#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HF — exact post-P1 accelerated frontier collector for the
# 2026-09-08 03:35 EEST no-image boot, after VESA recovery.
# READ-ONLY with respect to system/root patch/EFI/NVRAM/framebuffer.
# Writes evidence only to Desktop.

START_LOCAL="2026-09-08 03:34:00 +0300"
END_LOCAL="2026-09-08 03:39:30 +0300"
D97EW_BASE="/Users/Shared/OCLP-D97EW-Capture"
EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HF_POST_P1_0335_FRONTIER_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97HF_POST_P1_0335_FRONTIER_${STAMP}.zip"
mkdir -p "$OUT/ips" "$OUT/d97ew_runs"
exec > >(tee "$OUT/D97HF_REPORT.txt") 2>&1

fail(){ echo "D97HF_STATUS=FAIL"; echo "D97HF_REASON=$*"; echo "D97HF_REPORT=$OUT/D97HF_REPORT.txt"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cat <<'HDR'
===== OCLP7 D97HF — EXACT 03:35 POST-P1 FRONTIER COLLECTOR =====
SYSTEM_MUTATION=NO
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
EVIDENCE_WRITE=DESKTOP_ONLY
TARGET_WINDOW=2026-09-08_03:34:00_TO_03:39:30_+0300
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== CURRENT RECOVERY VESA SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HF_CURRENT_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail CURRENT_BOOT_NOT_VESA
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_STILL_ACTIVE_IN_RECOVERY || true
echo "D97HF_RECOVERY_VESA_GATE=PASS"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
[[ -f "$SERVICE" ]] || fail CURRENT_SERVICE_MISSING
CURRENT_SHA="$(sha256 "$SERVICE")"
echo "D97HF_CURRENT_SERVICE_SHA256=$CURRENT_SHA"
[[ "$CURRENT_SHA" == "$EXPECTED_P1_SHA" ]] || fail CURRENT_SERVICE_NOT_EXACT_P1

echo
printf '===== D97EW RUN INVENTORY AROUND CURRENT TEST =====\n'
/usr/bin/python3 - "$D97EW_BASE" "$OUT/d97ew_inventory.tsv" "$OUT/d97ew_runs" <<'PY'
from pathlib import Path
from datetime import datetime, timezone
import sys, shutil
base=Path(sys.argv[1]); inv=Path(sys.argv[2]); copyroot=Path(sys.argv[3])
start=datetime(2026,9,8,0,33,0,tzinfo=timezone.utc)
end=datetime(2026,9,8,0,41,0,tzinfo=timezone.utc)
rows=[]
if base.exists():
    for d in sorted(base.iterdir()):
        if not d.is_dir() or not d.name.startswith('20'): continue
        try:
            stamp=d.name.split('-',1)[0]
            dt=datetime.strptime(stamp,'%Y%m%dT%H%M%SZ').replace(tzinfo=timezone.utc)
        except Exception:
            continue
        if not (start <= dt <= end): continue
        ba=(d/'boot_args.txt').read_text(errors='replace').strip() if (d/'boot_args.txt').is_file() else 'MISSING'
        tail=''
        if (d/'summary.tsv').is_file():
            lines=(d/'summary.tsv').read_text(errors='replace').splitlines()
            tail=' || '.join(lines[-3:])
        tup='YES' if (d/'TUPLE_CAPTURE_FIRST.txt').is_file() else 'NO'
        rows.append((d.name,dt.isoformat(),tup,ba,tail))
        dst=copyroot/d.name
        if dst.exists(): shutil.rmtree(dst)
        shutil.copytree(d,dst)
with inv.open('w') as f:
    f.write('RUN_ID\tUTC\tTUPLE_CAPTURE\tBOOT_ARGS\tSUMMARY_TAIL\n')
    for r in rows: f.write('\t'.join(r)+'\n')
print('D97HF_D97EW_RUNS_IN_WINDOW='+str(len(rows)))
for r in rows:
    print('D97HF_D97EW_RUN='+' :: '.join(r[:4]))
    print('D97HF_D97EW_SUMMARY_TAIL='+r[4])
PY
/bin/cat "$OUT/d97ew_inventory.tsv" 2>/dev/null || true

printf '\n===== COPY EXACT-WINDOW IPS BY captureTime =====\n'
sudo /usr/bin/python3 - "$OUT/ips" "$OUT/ips_inventory.tsv" <<'PY'
from pathlib import Path
from datetime import datetime
import sys, os, re, shutil, hashlib
out=Path(sys.argv[1]); inv=Path(sys.argv[2])
start=datetime.strptime('2026-09-08 03:34:00 +0300','%Y-%m-%d %H:%M:%S %z')
end=datetime.strptime('2026-09-08 03:39:30 +0300','%Y-%m-%d %H:%M:%S %z')
sudo_user=os.environ.get('SUDO_USER')
roots=[Path('/Library/Logs/DiagnosticReports'),Path('/Library/Logs/DiagnosticReports/Retired')]
if sudo_user:
    roots.append(Path('/Users')/sudo_user/'Library/Logs/DiagnosticReports')
rows=[]; seen=set(); copied=0
pat=re.compile(r'"captureTime"\s*:\s*"([^"]+)"')
for root in roots:
    if not root.exists(): continue
    try: files=list(root.iterdir())
    except Exception as e:
        rows.append((str(root),'ROOT_ERROR',str(e),'','','')); continue
    for p in files:
        try:
            if not p.is_file() or not p.name.endswith('.ips'): continue
            if not (p.name.startswith('MTLCompilerService-') or p.name.startswith('WindowServer-')): continue
            txt=p.read_text(errors='replace')
            m=pat.search(txt)
            if not m: continue
            raw=m.group(1)
            dt=None
            for fmt in ('%Y-%m-%d %H:%M:%S.%f %z','%Y-%m-%d %H:%M:%S %z'):
                try: dt=datetime.strptime(raw,fmt); break
                except Exception: pass
            if dt is None or not (start <= dt <= end): continue
            data=p.read_bytes(); h=hashlib.sha256(data).hexdigest(); key=(p.name,h)
            if key in seen: continue
            seen.add(key)
            dst=out/p.name
            if dst.exists(): dst=out/(p.stem+f'__dup{copied}'+p.suffix)
            shutil.copy2(p,dst); copied+=1
            rows.append((str(p),'COPIED',str(len(data)),h,raw,str(dst)))
        except Exception as e:
            rows.append((str(p),'COPY_ERROR',str(e),'','',''))
with inv.open('w') as f:
    f.write('SOURCE\tSTATUS\tBYTES_OR_ERROR\tSHA256\tCAPTURE_TIME\tCOPIED_TO\n')
    for r in rows: f.write('\t'.join(r)+'\n')
print('D97HF_IPS_COPIED='+str(copied))
for r in rows: print('D97HF_IPS='+'\t'.join(r[:5]))
PY
/bin/cat "$OUT/ips_inventory.tsv" || true

printf '\n===== PARSE CURRENT MTLCompilerService FRONTIER =====\n'
/usr/bin/python3 - "$OUT/ips" "$OUT/mtl_frontier.tsv" <<'PY'
from pathlib import Path
import sys, json, re
root=Path(sys.argv[1]); out=Path(sys.argv[2])
files=sorted(root.glob('MTLCompilerService-*.ips'))
rows=[]; old=0; parsed=0
print('D97HF_MTL_IPS_COUNT='+str(len(files)))
for p in files:
    txt=p.read_text(errors='replace')
    body=None
    # Apple .ips normally has one JSON metadata line then full JSON body.
    try:
        parts=txt.split('\n',1)
        body=json.loads(parts[1] if len(parts)>1 else parts[0])
    except Exception as e:
        print(f'D97HF_MTL_PARSE_ERROR={p.name}::{e}')
    cap='NA'; incident='NA'; rip='NA'; r15='NA'; exc='NA'; term='NA'; frames=[]
    if isinstance(body,dict):
        parsed+=1
        cap=str(body.get('captureTime','NA')); incident=str(body.get('incident','NA'))
        exc=str(body.get('exception',{}).get('type','NA'))
        term=str(body.get('termination',{}).get('namespace','NA'))+':'+str(body.get('termination',{}).get('code','NA'))
        fi=body.get('faultingThread',0); threads=body.get('threads',[])
        if isinstance(fi,int) and 0 <= fi < len(threads):
            th=threads[fi]
            ts=th.get('threadState',{}) if isinstance(th,dict) else {}
            try: rip=ts.get('rip',{}).get('value','NA')
            except Exception: pass
            try: r15=ts.get('r15',{}).get('value','NA')
            except Exception: pass
            for fr in th.get('frames',[])[:20]:
                if not isinstance(fr,dict): continue
                sym=fr.get('symbol')
                off=fr.get('imageOffset',0); idx=fr.get('imageIndex','?'); loc=fr.get('symbolLocation','')
                if not sym: sym=f'image{idx}+0x{off:x}'
                frames.append(f'{sym}+{loc}' if loc!='' else str(sym))
    has_ctx56=('MTLConnectionCtx::MTLConnectionCtx(int)+56' in txt or
               bool(re.search(r'MTLConnectionCtx::MTLConnectionCtx\(int\).*?"symbolLocation"\s*:\s*56',txt,re.S)))
    rip0=(rip == 0) or bool(re.search(r'"rip"\s*:\s*\{[^{}]*"value"\s*:\s*0\b',txt))
    r15_32023=(r15 == 32023) or bool(re.search(r'"r15"\s*:\s*\{[^{}]*"value"\s*:\s*32023\b',txt))
    oldsig=bool(has_ctx56 and rip0 and r15_32023)
    if oldsig: old+=1
    fs=' <- '.join(frames)
    rows.append((p.name,cap,incident,str(rip),str(r15),'YES' if has_ctx56 else 'NO','YES' if oldsig else 'NO',exc,term,fs))
    print('----- '+p.name+' -----')
    print('captureTime='+cap)
    print('incident='+incident)
    print('rip='+str(rip)+' r15='+str(r15)+' old_ctx56='+('YES' if has_ctx56 else 'NO')+' OLD_SIGNATURE='+('YES' if oldsig else 'NO'))
    print('fault_frames='+fs)
with out.open('w') as f:
    f.write('FILE\tCAPTURE_TIME\tINCIDENT\tRIP\tR15\tHAS_CTX56\tOLD_SIGNATURE\tEXCEPTION\tTERMINATION\tFAULT_FRAMES\n')
    for r in rows: f.write('\t'.join(r)+'\n')
print('D97HF_MTL_IPS_PARSED='+str(parsed))
print('D97HF_OLD_RIP0_CTX56_SIGNATURE_COUNT='+str(old))
if not files:
    print('D97HF_P1_RUNTIME_CLASSIFICATION=NO_MTL_IPS_IN_EXACT_WINDOW_REVIEW_UNIFIED_LOG')
elif old == 0:
    print('D97HF_P1_OLD_NULL_SIGNATURE=ABSENT_IN_EXACT_WINDOW')
    print('D97HF_P1_RUNTIME_CLASSIFICATION=SEMANTIC_PROGRESS_NEW_FRONTIER')
elif old == len(files):
    print('D97HF_P1_RUNTIME_CLASSIFICATION=OLD_NULL_SIGNATURE_PERSISTS_CURRENT_BOOT')
else:
    print('D97HF_P1_RUNTIME_CLASSIFICATION=MIXED_CURRENT_FRONTIER')
PY
/bin/cat "$OUT/mtl_frontier.tsv" 2>/dev/null || true

printf '\n===== EXACT-WINDOW UNIFIED LOG =====\n'
/usr/bin/log show --style compact \
  --start "2026-09-08 03:34:00" --end "2026-09-08 03:39:30" \
  --predicate 'process == "MTLCompilerService" OR process == "WindowServer" OR eventMessage CONTAINS[c] "MTLCompilerService" OR eventMessage CONTAINS[c] "XPC_ERROR_CONNECTION_INTERRUPTED"' \
  > "$OUT/exact_window_unified.log" 2>&1 || true
LINES="$(/usr/bin/wc -l < "$OUT/exact_window_unified.log" | /usr/bin/tr -d ' ')"
echo "D97HF_UNIFIED_LOG_LINES=$LINES"
/usr/bin/grep -Ei 'MTLCompilerService|XPC_ERROR_CONNECTION_INTERRUPTED|GPUPass|pipeline|crash|exited|invalid|abort|MTLReportFailure|validateWithDevice|Compilation failed' "$OUT/exact_window_unified.log" \
  > "$OUT/exact_window_key_lines.txt" 2>/dev/null || true
/usr/bin/tail -n 180 "$OUT/exact_window_key_lines.txt" 2>/dev/null || true

printf '\n===== WINDOWSERVER CURRENT CRASH INVENTORY =====\n'
for F in "$OUT"/ips/WindowServer-*.ips; do
  [[ -f "$F" ]] || continue
  echo "D97HF_WINDOWSERVER_IPS=$(basename "$F")::$(sha256 "$F")"
done

printf '\n===== PACKAGE =====\n'
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
ZIP_SHA="$(sha256 "$ZIP")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97HF_ZIP=$ZIP"
echo "D97HF_ZIP_SHA256=$ZIP_SHA"
echo "D97HF_ZIP_BYTES=$ZIP_BYTES"
echo "D97HF_STATUS=CAPTURE_COMPLETE"
echo "D97HF_NEXT=REVIEW_EXACT_CURRENT_MTL_FRONTIER"
echo "D97HF_REBOOT=NO"
echo "D97HF_REPORT=$OUT/D97HF_REPORT.txt"
