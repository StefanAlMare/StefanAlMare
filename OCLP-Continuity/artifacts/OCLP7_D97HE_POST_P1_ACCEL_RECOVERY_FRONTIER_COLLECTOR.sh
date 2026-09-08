#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HE — post-P1 accelerated-boot frontier collector after VESA recovery.
# READ-ONLY with respect to system/EFI/NVRAM/root patch. Writes evidence only to user's Desktop.

BASE="/Users/Shared/OCLP-D97EW-Capture"
STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HE_POST_P1_ACCEL_FRONTIER_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97HE_POST_P1_ACCEL_FRONTIER_${STAMP}.zip"
mkdir -p "$OUT/d97ew" "$OUT/ips"
exec > >(tee "$OUT/D97HE_REPORT.txt") 2>&1

fail(){ echo "D97HE_STATUS=FAIL"; echo "D97HE_REASON=$*"; echo "D97HE_REPORT=$OUT/D97HE_REPORT.txt"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cat <<'HDR'
===== OCLP7 D97HE — POST P1 ACCELERATED FRONTIER COLLECTOR =====
SYSTEM_MUTATION=NO
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
EVIDENCE_WRITE=DESKTOP_ONLY
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== CURRENT RECOVERY BOOT SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HE_CURRENT_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail CURRENT_BOOT_NOT_VESA
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_STILL_ACTIVE_IN_RECOVERY || true
echo "D97HE_RECOVERY_VESA_GATE=PASS"

printf '\n===== LOCATE AUTHORITATIVE D97EW ACCELERATED RUN =====\n'
[[ -d "$BASE" ]] || fail D97EW_BASE_MISSING
ACCEL_RUN="$(/usr/bin/python3 - "$BASE" <<'PY'
from pathlib import Path
import sys
base=Path(sys.argv[1])
cands=[]
for d in base.iterdir():
    if not d.is_dir() or not d.name.startswith('20'):
        continue
    p=d/'boot_args.txt'
    if not p.is_file():
        continue
    s=p.read_text(errors='replace').replace('\t',' ')
    toks=s.split()
    # nvram output begins with boot-args; exact tokens after that are what matter.
    active_d97ez='-ocmcd97ez' in toks
    active_vesa='-igfxvesa' in toks
    inert_vesa='#-igfxvesa' in toks
    if active_d97ez and not active_vesa and inert_vesa:
        cands.append(d)
if not cands:
    raise SystemExit(2)
for d in sorted(cands, key=lambda p:p.name):
    print(d)
PY
)" || fail NO_D97EW_ACCEL_RUN_FOUND
[[ -n "$ACCEL_RUN" && -d "$ACCEL_RUN" ]] || fail ACCEL_RUN_INVALID
ACCEL_NAME="$(basename "$ACCEL_RUN")"
echo "D97HE_ACCEL_RUN=$ACCEL_RUN"
echo "D97HE_ACCEL_RUN_ID=$ACCEL_NAME"
/bin/cp -R "$ACCEL_RUN" "$OUT/d97ew/" || fail COPY_D97EW_RUN_FAIL

echo "----- accelerated boot args -----"
/bin/cat "$ACCEL_RUN/boot_args.txt" 2>/dev/null || true
echo "----- accelerated summary tail -----"
/usr/bin/tail -n 20 "$ACCEL_RUN/summary.tsv" 2>/dev/null || true
echo "----- accelerated collector log -----"
/bin/cat "$ACCEL_RUN/collector.log" 2>/dev/null || true

if [[ -f "$ACCEL_RUN/TUPLE_CAPTURE_FIRST.txt" ]]; then
  echo "D97HE_D97EW_TUPLE_CAPTURE=PASS"
  /usr/bin/grep -E '"D97ESCapturedCount"|"D97ELSetIdModeCallCount"|"D97ELRouteStatus"|"D97EZ|"D97EL' "$ACCEL_RUN/TUPLE_CAPTURE_FIRST.txt" > "$OUT/d97ew/TUPLE_KEY_FIELDS.txt" 2>/dev/null || true
  /bin/cat "$OUT/d97ew/TUPLE_KEY_FIELDS.txt" || true
else
  echo "D97HE_D97EW_TUPLE_CAPTURE=NO_FIRST_CAPTURE_FILE"
fi

printf '\n===== DERIVE ACCELERATED TIME WINDOW =====\n'
/usr/bin/python3 - "$ACCEL_NAME" "$OUT/time_window.env" <<'PY'
import sys,re
from datetime import datetime,timezone,timedelta
name=sys.argv[1]
m=re.match(r'^(\d{8}T\d{6}Z)',name)
if not m:
    raise SystemExit('cannot parse accelerated D97EW run UTC')
dt=datetime.strptime(m.group(1),'%Y%m%dT%H%M%SZ').replace(tzinfo=timezone.utc)
start=dt-timedelta(seconds=60)
end=dt+timedelta(minutes=10)
# Use local timezone of this host for log show display/query.
ls=start.astimezone(); le=end.astimezone()
with open(sys.argv[2],'w') as f:
    f.write('ACCEL_EPOCH='+str(int(dt.timestamp()))+'\n')
    f.write('START_EPOCH='+str(int(start.timestamp()))+'\n')
    f.write('END_EPOCH='+str(int(end.timestamp()))+'\n')
    f.write('START_LOCAL='+ls.strftime('%Y-%m-%d %H:%M:%S')+'\n')
    f.write('END_LOCAL='+le.strftime('%Y-%m-%d %H:%M:%S')+'\n')
print('D97HE_ACCEL_RUN_START_UTC='+dt.strftime('%Y-%m-%dT%H:%M:%SZ'))
print('D97HE_LOG_WINDOW_LOCAL='+ls.strftime('%Y-%m-%d %H:%M:%S')+' -> '+le.strftime('%Y-%m-%d %H:%M:%S'))
PY
source "$OUT/time_window.env"

printf '\n===== COPY MTLCompilerService + WindowServer IPS IN WINDOW =====\n'
sudo /usr/bin/python3 - "$OUT/ips" "$OUT/ips_inventory.tsv" "$START_EPOCH" "$END_EPOCH" <<'PY'
import pathlib,sys,os,shutil,hashlib
out=pathlib.Path(sys.argv[1]); inv=pathlib.Path(sys.argv[2]); start=float(sys.argv[3]); end=float(sys.argv[4])
sudo_user=os.environ.get('SUDO_USER')
roots=[pathlib.Path('/Library/Logs/DiagnosticReports'),pathlib.Path('/Library/Logs/DiagnosticReports/Retired')]
if sudo_user: roots += [pathlib.Path('/Users')/sudo_user/'Library/Logs/DiagnosticReports']
rows=[]; copied=0; seen=set()
for root in roots:
    if not root.exists(): continue
    try: files=list(root.iterdir())
    except Exception as e:
        rows.append((str(root),'ROOT_ERROR',str(e),'','','')); continue
    for p in files:
        try:
            if not p.is_file() or not p.name.endswith('.ips'): continue
            if not (p.name.startswith('MTLCompilerService-') or p.name.startswith('WindowServer-')): continue
            st=p.stat()
            # Report creation/mtime can lag the process crash slightly; bounded 1 minute grace.
            if not (start-60 <= st.st_mtime <= end+60): continue
            data=p.read_bytes(); h=hashlib.sha256(data).hexdigest(); key=(p.name,h)
            if key in seen: continue
            seen.add(key)
            dst=out/p.name
            if dst.exists(): dst=out/(p.stem+f'__dup{copied}'+p.suffix)
            shutil.copy2(p,dst); copied+=1
            rows.append((str(p),'COPIED',str(len(data)),h,str(st.st_mtime),str(dst)))
        except Exception as e:
            rows.append((str(p),'COPY_ERROR',str(e),'','',''))
with inv.open('w') as f:
    f.write('SOURCE\tSTATUS\tBYTES_OR_ERROR\tSHA256\tMTIME_EPOCH\tCOPIED_TO\n')
    for r in rows: f.write('\t'.join(r)+'\n')
print(f'D97HE_IPS_COPIED={copied}')
for r in rows: print('D97HE_IPS='+ '\t'.join(r[:4]))
PY
/bin/cat "$OUT/ips_inventory.tsv" || true

printf '\n===== PARSE MTLCOMPILERSERVICE CRASH FRONTIER =====\n'
/usr/bin/python3 - "$OUT/ips" "$OUT/mtl_frontier.tsv" <<'PY'
from pathlib import Path
import sys,json,re
root=Path(sys.argv[1]); out=Path(sys.argv[2])
files=sorted(root.glob('MTLCompilerService-*.ips'))
rows=[]; old=0; parsed=0
print('D97HE_MTL_IPS_COUNT='+str(len(files)))
for p in files:
    txt=p.read_text(errors='replace')
    body=None
    try:
        parts=txt.split('\n',1)
        body=json.loads(parts[1] if len(parts)>1 else parts[0])
    except Exception as e:
        print(f'D97HE_MTL_PARSE_ERROR={p.name}::{e}')
    rip='NA'; r15='NA'; frames=[]; cap='NA'; incident='NA'; exc='NA'; term='NA'
    if isinstance(body,dict):
        parsed+=1
        cap=str(body.get('captureTime','NA')); incident=str(body.get('incident','NA'))
        exc=str(body.get('exception',{}).get('type','NA'))
        term=str(body.get('termination',{}).get('namespace','NA'))+':'+str(body.get('termination',{}).get('code','NA'))
        fi=body.get('faultingThread',0)
        threads=body.get('threads',[])
        if isinstance(fi,int) and 0 <= fi < len(threads):
            th=threads[fi]
            ts=th.get('threadState',{}) if isinstance(th,dict) else {}
            try: rip=ts.get('rip',{}).get('value','NA')
            except Exception: pass
            try: r15=ts.get('r15',{}).get('value','NA')
            except Exception: pass
            for fr in th.get('frames',[])[:16]:
                if not isinstance(fr,dict): continue
                sym=fr.get('symbol',f"image{fr.get('imageIndex','?')}+0x{fr.get('imageOffset',0):x}")
                loc=fr.get('symbolLocation','')
                frames.append(f'{sym}+{loc}' if loc!='' else str(sym))
    # Fallback / cross-check textual signature.
    has_ctx56 = ('MTLConnectionCtx::MTLConnectionCtx(int)+56' in txt or
                 ('MTLConnectionCtx::MTLConnectionCtx(int)' in txt and '"symbolLocation" : 56' in txt) or
                 ('MTLConnectionCtx::MTLConnectionCtx(int)' in txt and '"symbolLocation":56' in txt))
    rip0 = (rip == 0) or bool(re.search(r'"rip"\s*:\s*\{[^{}]*"value"\s*:\s*0\b',txt))
    r15_32023 = (r15 == 32023) or bool(re.search(r'"r15"\s*:\s*\{[^{}]*"value"\s*:\s*32023\b',txt))
    oldsig=bool(has_ctx56 and rip0 and r15_32023)
    if oldsig: old+=1
    frame_str=' <- '.join(frames)
    rows.append((p.name,cap,incident,str(rip),str(r15),'YES' if has_ctx56 else 'NO','YES' if oldsig else 'NO',exc,term,frame_str))
    print('----- '+p.name+' -----')
    print('captureTime='+cap)
    print('incident='+incident)
    print('rip='+str(rip)+' r15='+str(r15)+' old_ctx56='+('YES' if has_ctx56 else 'NO')+' OLD_SIGNATURE='+('YES' if oldsig else 'NO'))
    print('fault_frames='+frame_str)
with out.open('w') as f:
    f.write('FILE\tCAPTURE_TIME\tINCIDENT\tRIP\tR15\tHAS_CTX56\tOLD_SIGNATURE\tEXCEPTION\tTERMINATION\tFAULT_FRAMES\n')
    for r in rows: f.write('\t'.join(r)+'\n')
print('D97HE_MTL_IPS_PARSED='+str(parsed))
print('D97HE_OLD_RIP0_CTX56_SIGNATURE_COUNT='+str(old))
if not files:
    print('D97HE_P1_RUNTIME_CLASSIFICATION=NO_MTL_IPS_FOUND_IN_WINDOW')
elif old == 0:
    print('D97HE_P1_OLD_NULL_SIGNATURE=ABSENT_IN_COLLECTED_IPS')
    print('D97HE_P1_RUNTIME_CLASSIFICATION=PROGRESS_CANDIDATE_NEW_FRONTIER_REVIEW_REQUIRED')
elif old == len(files):
    print('D97HE_P1_RUNTIME_CLASSIFICATION=OLD_NULL_SIGNATURE_PERSISTS_ALL_REPORTS')
else:
    print('D97HE_P1_RUNTIME_CLASSIFICATION=MIXED_OLD_AND_NEW_FRONTIERS')
PY
/bin/cat "$OUT/mtl_frontier.tsv" 2>/dev/null || true

printf '\n===== UNIFIED LOG FOR ACCELERATED WINDOW =====\n'
/usr/bin/log show --style compact --start "$START_LOCAL" --end "$END_LOCAL" \
  --predicate 'process == "MTLCompilerService" OR process == "WindowServer" OR eventMessage CONTAINS[c] "XPC_ERROR_CONNECTION_INTERRUPTED" OR eventMessage CONTAINS[c] "MTLCompilerService"' \
  > "$OUT/accelerated_window_unified.log" 2>&1 || true
LINES="$(/usr/bin/wc -l < "$OUT/accelerated_window_unified.log" | /usr/bin/tr -d ' ')"
echo "D97HE_UNIFIED_LOG_LINES=$LINES"
/usr/bin/grep -Ei 'MTLCompilerService|XPC_ERROR_CONNECTION_INTERRUPTED|GPUPass|pipeline|crash|exited|invalid|abort|MTLReportFailure|validateWithDevice' "$OUT/accelerated_window_unified.log" \
  > "$OUT/accelerated_window_key_lines.txt" 2>/dev/null || true
/usr/bin/tail -n 120 "$OUT/accelerated_window_key_lines.txt" 2>/dev/null || true

printf '\n===== CURRENT ACTIVE P1 IDENTITY (RECOVERY VESA) =====\n'
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
if [[ -f "$SERVICE" ]]; then
  echo "D97HE_CURRENT_SERVICE_SHA256=$(sha256 "$SERVICE")"
fi

printf '\n===== PACKAGE =====\n'
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
ZIP_SHA="$(sha256 "$ZIP")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97HE_ZIP=$ZIP"
echo "D97HE_ZIP_SHA256=$ZIP_SHA"
echo "D97HE_ZIP_BYTES=$ZIP_BYTES"
echo "D97HE_STATUS=CAPTURE_COMPLETE"
echo "D97HE_NEXT=REVIEW_MTL_FRONTIER_BEFORE_ANY_NEW_PATCH"
echo "D97HE_REBOOT=NO"
echo "D97HE_REPORT=$OUT/D97HE_REPORT.txt"
