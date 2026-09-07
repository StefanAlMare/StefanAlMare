#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GJ — read-only evidence capture for the two corrected-Root-Patch accelerated boots.
# Authoritative user boot boundaries:
#   accelerated #1: 2026-09-07 23:41 -> before 23:50
#   accelerated #2: 2026-09-07 23:50 -> before 23:52 recovery
# NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GJ_TWO_ACCEL_BOOT_LOG_CAPTURE_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97GJ_TWO_ACCEL_BOOT_LOG_CAPTURE_${STAMP}.zip"
mkdir -p "$OUT/diagnostics"

exec > >(tee "$OUT/D97GJ_CAPTURE.txt") 2>&1

echo "===== D97GJ TWO ACCELERATED BOOT LOG CAPTURE ====="
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
/usr/bin/last reboot | /usr/bin/head -n 12 | tee "$OUT/boot_history.txt"
/usr/sbin/sysctl -n kern.bootargs 2>/dev/null | tee "$OUT/current_kern_bootargs.txt" || true

PRED='process == "WindowServer" OR eventMessage CONTAINS[c] "GetGPUPassRenderPipelineState" OR eventMessage CONTAINS[c] "validateWithDevice" OR eventMessage CONTAINS[c] "CoreDisplay" OR eventMessage CONTAINS[c] "GPUWrangler" OR eventMessage CONTAINS[c] "IOAccel" OR eventMessage CONTAINS[c] "AppleIntelFramebuffer" OR eventMessage CONTAINS[c] "getPixelInformation" OR eventMessage CONTAINS[c] "IOFBGetDisplayModeInformation" OR eventMessage CONTAINS[c] "Surface mode contains bad bits" OR eventMessage CONTAINS[c] "display offline" OR eventMessage CONTAINS[c] "GPUPass" OR eventMessage CONTAINS[c] "MTLCompiler" OR eventMessage CONTAINS[c] "Metal"'

capture_window() {
  local TAG="$1" START="$2" END="$3"
  echo
  echo "===== $TAG $START -> $END ====="
  echo "$START -> $END" > "$OUT/${TAG}_window.txt"

  sudo /usr/bin/log show \
    --start "$START" --end "$END" \
    --style compact --info --debug \
    --predicate "$PRED" \
    > "$OUT/${TAG}_focused.log" 2>&1 || true

  sudo /usr/bin/log show \
    --start "$START" --end "$END" \
    --style compact --info --debug \
    --predicate 'process == "WindowServer"' \
    > "$OUT/${TAG}_WindowServer_full.log" 2>&1 || true

  sudo /usr/bin/log show \
    --start "$START" --end "$END" \
    --style compact --info --debug \
    --predicate 'process == "kernel" AND (eventMessage CONTAINS[c] "AppleIntel" OR eventMessage CONTAINS[c] "IOAccel" OR eventMessage CONTAINS[c] "framebuffer" OR eventMessage CONTAINS[c] "GPU" OR eventMessage CONTAINS[c] "Metal")' \
    > "$OUT/${TAG}_kernel_graphics.log" 2>&1 || true

  echo "${TAG}_FOCUSED_LINES=$(/usr/bin/wc -l < "$OUT/${TAG}_focused.log" | /usr/bin/tr -d ' ')"
  echo "${TAG}_WINDOWSERVER_LINES=$(/usr/bin/wc -l < "$OUT/${TAG}_WindowServer_full.log" | /usr/bin/tr -d ' ')"
  echo "${TAG}_KERNEL_GRAPHICS_LINES=$(/usr/bin/wc -l < "$OUT/${TAG}_kernel_graphics.log" | /usr/bin/tr -d ' ')"

  /usr/bin/grep -Eia \
    'GetGPUPassRenderPipelineState|validateWithDevice|Surface mode contains bad bits|getPixelInformation|IOFBGetDisplayModeInformation|display offline|SIGSEGV|SIGABRT|EXC_BAD_ACCESS|EXC_CRASH|MTLReportFailure|GPUPass' \
    "$OUT/${TAG}_focused.log" "$OUT/${TAG}_WindowServer_full.log" \
    > "$OUT/${TAG}_decisive_hits.txt" 2>/dev/null || true

  echo "${TAG}_DECISIVE_HIT_LINES=$(/usr/bin/wc -l < "$OUT/${TAG}_decisive_hits.txt" | /usr/bin/tr -d ' ')"
}

# User-authoritative accelerated boot boundaries.
capture_window "ACCEL1_2341" "2026-09-07 23:41:00" "2026-09-07 23:50:00"
capture_window "ACCEL2_2350" "2026-09-07 23:50:00" "2026-09-07 23:52:59"

echo
echo "===== RECENT DIAGNOSTIC REPORTS ====="
/usr/bin/python3 - "$OUT/diagnostics" <<'PY'
import os, pathlib, shutil, sys, datetime, hashlib
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
for root in roots:
    if not root.exists(): continue
    try: files=list(root.iterdir())
    except Exception: continue
    for p in files:
        try:
            if not p.is_file(): continue
            st=p.stat()
        except Exception:
            continue
        name=p.name.lower()
        if not any(k in name for k in keywords): continue
        # Use a broad temporal window; some reports are flushed during recovery.
        if not (start <= st.st_mtime <= end): continue
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
    for r in rows: f.write('\t'.join(map(str,r))+'\n')
print(f'D97GJ_DIAGNOSTIC_REPORT_COUNT={sum(1 for r in rows if not str(r[3]).startswith("COPY_ERROR"))}')
for r in rows: print('D97GJ_DIAGNOSTIC='+r[0])
PY

echo
echo "===== D97EW COHORT INVENTORY ====="
for R in \
  /Users/Shared/OCLP-D97EW-Capture/20260907T204303Z-312 \
  /Users/Shared/OCLP-D97EW-Capture/20260907T205125Z-322 \
  /Users/Shared/OCLP-D97EW-Capture/20260907T205412Z-322
 do
   if [[ -d "$R" ]]; then
     echo "RUN=$R" | tee -a "$OUT/d97ew_inventory.txt"
     /bin/cat "$R/collector.log" 2>/dev/null | tee -a "$OUT/d97ew_inventory.txt" || true
     /bin/cat "$R/summary.tsv" 2>/dev/null | tee -a "$OUT/d97ew_inventory.txt" || true
   fi
 done

echo
echo "===== PACKAGE ====="
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
ZIP_SHA="$(/usr/bin/shasum -a 256 "$ZIP" | /usr/bin/awk '{print $1}')"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97GJ_ZIP=$ZIP"
echo "D97GJ_ZIP_SHA256=$ZIP_SHA"
echo "D97GJ_ZIP_BYTES=$ZIP_BYTES"
echo "D97GJ_STATUS=CAPTURE_COMPLETE"
echo "D97GJ_REBOOT=NO"
