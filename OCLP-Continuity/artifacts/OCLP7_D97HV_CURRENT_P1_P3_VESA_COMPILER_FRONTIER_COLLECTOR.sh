#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HV — current-boot P1+P3 VESA compiler-frontier collector.
# Purpose: exploit the already-observed WindowServer XPC interruption in the
# current VESA boot to determine whether exact P3 moved the post-P1 StringMap
# crash family before any accelerated boot.
# READ-ONLY with respect to Root Patch, EFI, NVRAM and framebuffer.
# Writes evidence only to Desktop.

EXPECTED_BUILD="25G82"
EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P3_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_${STAMP}.zip"
mkdir -p "$OUT/ips"
REPORT="$OUT/D97HV_REPORT.txt"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HV_STATUS=FAIL"; echo "D97HV_REASON=$*"; echo "D97HV_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cat <<'HDR'
===== OCLP7 D97HV — CURRENT P1+P3 VESA COMPILER FRONTIER COLLECTOR =====
SYSTEM_MUTATION=NO
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
ACCELERATION=NO
EVIDENCE_WRITE=DESKTOP_ONLY
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "$EXPECTED_BUILD" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== CURRENT P1+P3 VESA BINDING =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HV_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
[[ -f "$SERVICE" ]] || fail SERVICE_MISSING
[[ -f "$COMPILER" ]] || fail COMPILER_32023_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
COMPILER_SHA="$(sha256 "$COMPILER")"
echo "D97HV_ACTIVE_SERVICE_SHA256=$SERVICE_SHA"
echo "D97HV_ACTIVE_COMPILER_SHA256=$COMPILER_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_P1_SHA" ]] || fail ACTIVE_P1_IDENTITY_MISMATCH
[[ "$COMPILER_SHA" == "$EXPECTED_P3_SHA" ]] || fail ACTIVE_P3_IDENTITY_MISMATCH
echo "D97HV_ACTIVE_P1_P3_BINDING=PASS"

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime)"
BOOT_SEC="$(printf '%s\n' "$BOOT_RAW" | /usr/bin/sed -E 's/.*sec = ([0-9]+).*/\1/')"
[[ "$BOOT_SEC" =~ ^[0-9]+$ ]] || fail BOOTTIME_PARSE_FAIL
NOW_SEC="$(/bin/date +%s)"
/usr/bin/python3 - "$BOOT_SEC" "$NOW_SEC" <<'PY'
from datetime import datetime, timezone
import sys
b=int(sys.argv[1]); n=int(sys.argv[2])
print('D97HV_BOOT_UTC='+datetime.fromtimestamp(b,timezone.utc).isoformat())
print('D97HV_NOW_UTC='+datetime.fromtimestamp(n,timezone.utc).isoformat())
print('D97HV_BOOT_WINDOW_SECONDS='+str(n-b))
PY

printf '\n===== COPY CURRENT-BOOT MTLCompilerService / WindowServer IPS =====\n'
sudo /usr/bin/python3 - "$OUT/ips" "$OUT/ips_inventory.tsv" "$BOOT_SEC" "$NOW_SEC" <<'PY'
from pathlib import Path
from datetime import datetime, timezone
import sys, os, re, shutil, hashlib
out=Path(sys.argv[1]); inv=Path(sys.argv[2]); boot=int(sys.argv[3]); now=int(sys.argv[4])
start=datetime.fromtimestamp(boot-5, timezone.utc)
end=datetime.fromtimestamp(now+5, timezone.utc)
sudo_user=os.environ.get('SUDO_USER')
roots=[Path('/Library/Logs/DiagnosticReports'),Path('/Library/Logs/DiagnosticReports/Retired')]
if sudo_user:
    roots += [Path('/Users')/sudo_user/'Library/Logs/DiagnosticReports', Path('/Users')/sudo_user/'Library/Logs/DiagnosticReports/Retired']
pat=re.compile(r'"captureTime"\s*:\s*"([^"]+)"')
rows=[]; seen=set(); copied=0
for root in roots:
    if not root.exists(): continue
    try: files=list(root.iterdir())
    except Exception as e:
        rows.append((str(root),'ROOT_ERROR',str(e),'','','')); continue
    for p in files:
        try:
            if not p.is_file() or p.suffix != '.ips': continue
            if not (p.name.startswith('MTLCompilerService-') or p.name.startswith('WindowServer-')): continue
            txt=p.read_text(errors='replace')
            m=pat.search(txt)
            if not m: continue
            raw=m.group(1)
            dt=None
            for fmt in ('%Y-%m-%d %H:%M:%S.%f %z','%Y-%m-%d %H:%M:%S %z'):
                try: dt=datetime.strptime(raw,fmt); break
                except Exception: pass
            if dt is None or not (start <= dt.astimezone(timezone.utc) <= end): continue
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
print('D97HV_IPS_COPIED='+str(copied))
for r in rows: print('D97HV_IPS='+'\t'.join(r[:5]))
PY
/bin/cat "$OUT/ips_inventory.tsv" 2>/dev/null || true

printf '\n===== PARSE CURRENT-BOOT MTLCompilerService FRONTIER =====\n'
/usr/bin/python3 - "$OUT/ips" "$OUT/mtl_frontier.tsv" <<'PY'
from pathlib import Path
import sys, json, re
root=Path(sys.argv[1]); out=Path(sys.argv[2])
files=sorted(root.glob('MTLCompilerService-*.ips'))
rows=[]
old_null=0; stringmap=0; p3_backend=0; simmeta=0; parsed=0
print('D97HV_MTL_IPS_COUNT='+str(len(files)))
for p in files:
    txt=p.read_text(errors='replace')
    body=None
    try:
        parts=txt.split('\n',1)
        body=json.loads(parts[1] if len(parts)>1 else parts[0])
    except Exception as e:
        print(f'D97HV_MTL_PARSE_ERROR={p.name}::{e}')
    cap='NA'; incident='NA'; exc='NA'; term='NA'; rip='NA'; r15='NA'; frames=[]
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
            for fr in th.get('frames',[])[:28]:
                if not isinstance(fr,dict): continue
                sym=fr.get('symbol'); off=fr.get('imageOffset',0); idx=fr.get('imageIndex','?'); loc=fr.get('symbolLocation','')
                if not sym: sym=f'image{idx}+0x{off:x}'
                frames.append(f'{sym}+{loc}' if loc!='' else str(sym))
    has_ctx56=('MTLConnectionCtx::MTLConnectionCtx(int)+56' in txt or bool(re.search(r'MTLConnectionCtx::MTLConnectionCtx\(int\).*?"symbolLocation"\s*:\s*56',txt,re.S)))
    rip0=(rip == 0) or bool(re.search(r'"rip"\s*:\s*\{[^{}]*"value"\s*:\s*0\b',txt))
    r15_32023=(r15 == 32023) or bool(re.search(r'"r15"\s*:\s*\{[^{}]*"value"\s*:\s*32023\b',txt))
    old=bool(has_ctx56 and rip0 and r15_32023)
    sm=all(x in txt for x in ('llvm::StringMapImpl::LookupBucketFor','collectUsedGlobalVariables','getOrInsertNamedMetadata','addMsaaPositionInfoToModuleMetadata','MTLCompilerBuildRequestWithOptions'))
    backend=('MTLCompilerObject::backendCompileModule' in txt or 'backendCompileExecutableRequest' in txt)
    sim=('MTLSimCompiler::validSimulatorMetadata' in txt)
    old_null += int(old); stringmap += int(sm); p3_backend += int(backend); simmeta += int(sim)
    fs=' <- '.join(frames)
    rows.append((p.name,cap,incident,str(rip),str(r15),'YES' if old else 'NO','YES' if sm else 'NO','YES' if backend else 'NO','YES' if sim else 'NO',exc,term,fs))
    print('----- '+p.name+' -----')
    print('captureTime='+cap)
    print('incident='+incident)
    print('rip='+str(rip)+' r15='+str(r15))
    print('OLD_NULL_SIGNATURE='+('YES' if old else 'NO'))
    print('POST_P1_STRINGMAP_FAMILY='+('YES' if sm else 'NO'))
    print('BACKEND_COMPILE_PATH='+('YES' if backend else 'NO'))
    print('SIMULATOR_METADATA='+('YES' if sim else 'NO'))
    print('fault_frames='+fs)
with out.open('w') as f:
    f.write('FILE\tCAPTURE_TIME\tINCIDENT\tRIP\tR15\tOLD_NULL\tSTRINGMAP_FAMILY\tBACKEND_PATH\tSIM_METADATA\tEXCEPTION\tTERMINATION\tFAULT_FRAMES\n')
    for r in rows: f.write('\t'.join(r)+'\n')
print('D97HV_MTL_IPS_PARSED='+str(parsed))
print('D97HV_OLD_NULL_SIGNATURE_COUNT='+str(old_null))
print('D97HV_POST_P1_STRINGMAP_FAMILY_COUNT='+str(stringmap))
print('D97HV_BACKEND_COMPILE_PATH_COUNT='+str(p3_backend))
print('D97HV_SIMULATOR_METADATA_COUNT='+str(simmeta))
if not files:
    cls='INCONCLUSIVE_NO_MTL_IPS_CURRENT_BOOT'
elif stringmap == 0:
    cls='P3_MOVED_POST_P1_STRINGMAP_FRONTIER'
elif stringmap == len(files):
    cls='P3_DID_NOT_MOVE_POST_P1_STRINGMAP_FRONTIER'
else:
    cls='P3_MIXED_CURRENT_BOOT_FRONTIER'
print('D97HV_P3_RUNTIME_CLASSIFICATION='+cls)
PY
/bin/cat "$OUT/mtl_frontier.tsv" 2>/dev/null || true

printf '\n===== CURRENT-BOOT WINDOWSERVER XPC CLASSIFICATION =====\n'
/usr/bin/python3 - "$OUT/ips" <<'PY'
from pathlib import Path
import sys, json
root=Path(sys.argv[1]); files=sorted(root.glob('WindowServer-*.ips'))
xpc=0; pipeline=0
print('D97HV_WINDOWSERVER_IPS_COUNT='+str(len(files)))
for p in files:
    txt=p.read_text(errors='replace')
    if 'XPC_ERROR_CONNECTION_INTERRUPTED' in txt: xpc+=1
    if 'create_pipeline_state' in txt: pipeline+=1
    cap='NA'; incident='NA'
    try:
        parts=txt.split('\n',1); body=json.loads(parts[1] if len(parts)>1 else parts[0])
        cap=str(body.get('captureTime','NA')); incident=str(body.get('incident','NA'))
    except Exception: pass
    print(f'D97HV_WINDOWSERVER={p.name}::{cap}::{incident}::XPC_INTERRUPTED={"YES" if "XPC_ERROR_CONNECTION_INTERRUPTED" in txt else "NO"}::PIPELINE={"YES" if "create_pipeline_state" in txt else "NO"}')
print('D97HV_WINDOWSERVER_XPC_INTERRUPTED_COUNT='+str(xpc))
print('D97HV_WINDOWSERVER_PIPELINE_COUNT='+str(pipeline))
PY

printf '\n===== CURRENT-BOOT UNIFIED LOG =====\n'
BOOT_LOCAL="$(/bin/date -r "$BOOT_SEC" '+%Y-%m-%d %H:%M:%S')"
NOW_LOCAL="$(/bin/date '+%Y-%m-%d %H:%M:%S')"
echo "D97HV_LOG_START_LOCAL=$BOOT_LOCAL"
echo "D97HV_LOG_END_LOCAL=$NOW_LOCAL"
/usr/bin/log show --style compact --start "$BOOT_LOCAL" --end "$NOW_LOCAL" \
  --predicate 'process == "MTLCompilerService" OR process == "WindowServer" OR eventMessage CONTAINS[c] "MTLCompilerService" OR eventMessage CONTAINS[c] "XPC_ERROR_CONNECTION_INTERRUPTED"' \
  > "$OUT/current_boot_unified.log" 2>&1 || true
LINES="$(/usr/bin/wc -l < "$OUT/current_boot_unified.log" | /usr/bin/tr -d ' ')"
echo "D97HV_UNIFIED_LOG_LINES=$LINES"
/usr/bin/grep -Ei 'MTLCompilerService|XPC_ERROR_CONNECTION_INTERRUPTED|StringMap|addMsaaPositionInfo|backendCompile|validSimulatorMetadata|GPUPass|pipeline|crash|exited|abort|Compilation failed' "$OUT/current_boot_unified.log" \
  > "$OUT/current_boot_key_lines.txt" 2>/dev/null || true
/usr/bin/tail -n 220 "$OUT/current_boot_key_lines.txt" 2>/dev/null || true

printf '\n===== PACKAGE =====\n'
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
ZIP_SHA="$(sha256 "$ZIP")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97HV_ZIP=$ZIP"
echo "D97HV_ZIP_SHA256=$ZIP_SHA"
echo "D97HV_ZIP_BYTES=$ZIP_BYTES"
echo "D97HV_STATUS=CAPTURE_COMPLETE"
echo "D97HV_CLASSIFICATION=READONLY_CURRENT_BOOT_RUNTIME_EVIDENCE"
echo "D97HV_NEXT=REVIEW_P3_RUNTIME_FRONTIER_THEN_REVALIDATE_D97EW"
echo "D97HV_ACCELERATION=NOT_YET_AUTHORIZED"
echo "D97HV_REBOOT=NO"
echo "D97HV_REPORT=$REPORT"
