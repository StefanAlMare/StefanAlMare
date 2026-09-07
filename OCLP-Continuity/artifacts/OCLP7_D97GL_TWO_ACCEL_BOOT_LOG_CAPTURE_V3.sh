#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GL — corrected read-only evidence capture for the two corrected-Root-Patch accelerated boots.
# Supersedes D97GK for ACCEL1 boundary.
# User-authoritative boot boundaries:
#   accelerated #1: reboot 2026-09-07 23:39 local, ends before 23:50 reboot
#   accelerated #2: reboot 2026-09-07 23:50 local, ends before 23:52 recovery reboot
# NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GL_TWO_ACCEL_BOOT_LOG_CAPTURE_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97GL_TWO_ACCEL_BOOT_LOG_CAPTURE_${STAMP}.zip"
mkdir -p "$OUT/diagnostics" "$OUT/d97ew"

exec > >(tee "$OUT/D97GL_CAPTURE.txt") 2>&1

echo "===== D97GL TWO ACCELERATED BOOT LOG CAPTURE V3 ====="
echo "ROOT_PATCH=NO"
echo "RESTORE=NO"
echo "EFI_MUTATION=NO"
echo "NVRAM_MUTATION=NO"
echo "FRAMEBUFFER_MUTATION=NO"
echo "REBOOT=NO"

echo
echo "===== CURRENT SYSTEM / BOOT HISTORY ====="
/usr/bin/sw_vers
/usr/bin/uname -a
/usr/bin/last reboot > "$OUT/boot_history_full.txt" 2>&1 || true
/usr/bin/head -n 12 "$OUT/boot_history_full.txt" || true

BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "CURRENT_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" > "$OUT/current_kern_bootargs.txt"

PRED='process == "WindowServer" OR eventMessage CONTAINS[c] "GetGPUPassRenderPipelineState" OR eventMessage CONTAINS[c] "validateWithDevice" OR eventMessage CONTAINS[c] "CoreDisplay" OR eventMessage CONTAINS[c] "GPUWrangler" OR eventMessage CONTAINS[c] "IOAccel" OR eventMessage CONTAINS[c] "AppleIntelFramebuffer" OR eventMessage CONTAINS[c] "getPixelInformation" OR eventMessage CONTAINS[c] "IOFBGetDisplayModeInformation" OR eventMessage CONTAINS[c] "Surface mode contains bad bits" OR eventMessage CONTAINS[c] "display offline" OR eventMessage CONTAINS[c] "GPUPass" OR eventMessage CONTAINS[c] "MTLCompiler" OR eventMessage CONTAINS[c] "MTLReportFailure" OR eventMessage CONTAINS[c] "Metal"'

capture_window() {
  local TAG="$1" START="$2" END="$3"
  local FOC="$OUT/${TAG}_focused.log"
  local WS="$OUT/${TAG}_WindowServer_full.log"
  local KG="$OUT/${TAG}_kernel_graphics.log"
  local DEC="$OUT/${TAG}_decisive_hits.txt"

  echo
  echo "===== $TAG $START -> $END ====="
  printf '%s -> %s\n' "$START" "$END" > "$OUT/${TAG}_window.txt"

  set +e
  sudo /usr/bin/log show \
    --start "$START" --end "$END" \
    --style compact --info --debug \
    --predicate "$PRED" \
    > "$FOC" 2>&1
  local RC_FOC=$?

  sudo /usr/bin/log show \
    --start "$START" --end "$END" \
    --style compact --info --debug \
    --predicate 'process == "WindowServer"' \
    > "$WS" 2>&1
  local RC_WS=$?

  sudo /usr/bin/log show \
    --start "$START" --end "$END" \
    --style compact --info --debug \
    --predicate 'process == "kernel" AND (eventMessage CONTAINS[c] "AppleIntel" OR eventMessage CONTAINS[c] "IOAccel" OR eventMessage CONTAINS[c] "framebuffer" OR eventMessage CONTAINS[c] "GPU" OR eventMessage CONTAINS[c] "Metal")' \
    > "$KG" 2>&1
  local RC_KG=$?
  set -e

  echo "${TAG}_LOG_SHOW_FOCUSED_RC=$RC_FOC"
  echo "${TAG}_LOG_SHOW_WINDOWSERVER_RC=$RC_WS"
  echo "${TAG}_LOG_SHOW_KERNEL_RC=$RC_KG"

  echo "${TAG}_FOCUSED_LINES=$(/usr/bin/wc -l < "$FOC" | /usr/bin/tr -d ' ')"
  echo "${TAG}_WINDOWSERVER_LINES=$(/usr/bin/wc -l < "$WS" | /usr/bin/tr -d ' ')"
  echo "${TAG}_KERNEL_GRAPHICS_LINES=$(/usr/bin/wc -l < "$KG" | /usr/bin/tr -d ' ')"

  /usr/bin/grep -Eia \
    'GetGPUPassRenderPipelineState|validateWithDevice|Surface mode contains bad bits|getPixelInformation|IOFBGetDisplayModeInformation|display offline|SIGSEGV|SIGABRT|EXC_BAD_ACCESS|EXC_CRASH|MTLReportFailure|GPUPass|WindowServer.*(crash|terminated|exited)' \
    "$FOC" "$WS" \
    > "$DEC" 2>/dev/null || true

  echo "${TAG}_DECISIVE_HIT_LINES=$(/usr/bin/wc -l < "$DEC" | /usr/bin/tr -d ' ')"
  echo "----- ${TAG} DECISIVE HITS (first 120) -----"
  /usr/bin/head -n 120 "$DEC" || true
}

# Exact user-authoritative accelerated boot windows.
capture_window "ACCEL1_2339" "2026-09-07 23:39:00" "2026-09-07 23:49:59"
capture_window "ACCEL2_2350" "2026-09-07 23:50:00" "2026-09-07 23:51:59"

echo
echo "===== RECENT DIAGNOSTIC REPORTS ====="
/usr/bin/python3 - "$OUT/diagnostics" <<'PY'
import pathlib, shutil, sys, datetime, hashlib
out=pathlib.Path(sys.argv[1]); out.mkdir(parents=True,exist_ok=True)
roots=[
    pathlib.Path('/Library/Logs/DiagnosticReports'),
    pathlib.Path.home()/'Library/Logs/DiagnosticReports',
    pathlib.Path('/Library/Logs/DiagnosticReports/Retired'),
]
start=datetime.datetime(2026,9,7,23,35).timestamp()
end=datetime.datetime(2026,9,8,0,10).timestamp()
keywords=('windowserver','panic','coredisplay','metal','gpu','watchdog','kernel')
rows=[]
seen=set()
for root in roots:
    if not root.exists():
        continue
    try:
        files=list(root.iterdir())
    except Exception:
        continue
    for p in files:
        try:
            if not p.is_file():
                continue
            st=p.stat()
        except Exception:
            continue
        name=p.name.lower()
        if not any(k in name for k in keywords):
            continue
        if not (start <= st.st_mtime <= end):
            continue
        key=(str(p),st.st_size,st.st_mtime)
        if key in seen:
            continue
        seen.add(key)
        prefix='system' if str(root).startswith('/Library/') else 'user'
        dst=out/f'{prefix}__{p.name}'
        try:
            shutil.copy2(p,dst)
            h=hashlib.sha256(dst.read_bytes()).hexdigest()
            rows.append((str(p),st.st_size,datetime.datetime.fromtimestamp(st.st_mtime).isoformat(),h,str(dst)))
        except Exception as e:
            rows.append((str(p),st.st_size,datetime.datetime.fromtimestamp(st.st_mtime).isoformat(),f'COPY_ERROR:{e}',''))
with (out.parent/'diagnostic_inventory.tsv').open('w') as f:
    f.write('SOURCE\tBYTES\tMTIME_LOCAL\tSHA256_OR_ERROR\tCOPIED_TO\n')
    for r in rows:
        f.write('\t'.join(map(str,r))+'\n')
ok=sum(1 for r in rows if not str(r[3]).startswith('COPY_ERROR'))
print(f'D97GL_DIAGNOSTIC_REPORT_COUNT={ok}')
for r in rows:
    print('D97GL_DIAGNOSTIC='+r[0])
PY

echo
echo "===== D97EW COHORT COPY / INVENTORY ====="
copy_run() {
  local SRC="$1" TAG="$2"
  if [[ ! -d "$SRC" ]]; then
    echo "${TAG}_D97EW_PRESENT=NO"
    return 0
  fi
  echo "${TAG}_D97EW_PRESENT=YES"
  echo "${TAG}_D97EW_RUN=$SRC"
  mkdir -p "$OUT/d97ew/$TAG"
  for F in collector.log summary.tsv boot_args.txt kmutil_showloaded.txt oclpmetalcompat_loaded.txt TUPLE_CAPTURE_FIRST.txt TUPLE_CAPTURE_BOOT_ARGS.txt TUPLE_CAPTURE_KMUTIL.txt; do
    [[ -f "$SRC/$F" ]] && /bin/cp "$SRC/$F" "$OUT/d97ew/$TAG/$F"
  done
  for F in "$SRC"/TUPLE_CAPTURE_POST_*.txt; do
    [[ -f "$F" ]] && /bin/cp "$F" "$OUT/d97ew/$TAG/$(basename "$F")"
  done
  echo "----- $TAG collector -----"
  /bin/cat "$SRC/collector.log" 2>/dev/null || true
  echo "----- $TAG summary -----"
  /bin/cat "$SRC/summary.tsv" 2>/dev/null || true
}

copy_run "/Users/Shared/OCLP-D97EW-Capture/20260907T204303Z-312" "ACCEL1_RUN_204303Z_312"
copy_run "/Users/Shared/OCLP-D97EW-Capture/20260907T205125Z-322" "ACCEL2_RUN_205125Z_322"
copy_run "/Users/Shared/OCLP-D97EW-Capture/20260907T205412Z-322" "RECOVERY_RUN_205412Z_322"

echo
echo "===== PACKAGE ====="
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
ZIP_SHA="$(/usr/bin/shasum -a 256 "$ZIP" | /usr/bin/awk '{print $1}')"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97GL_ZIP=$ZIP"
echo "D97GL_ZIP_SHA256=$ZIP_SHA"
echo "D97GL_ZIP_BYTES=$ZIP_BYTES"
echo "D97GL_STATUS=CAPTURE_COMPLETE"
echo "D97GL_REBOOT=NO"
