#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT_REPORT.txt"
ACCEL_START="2026-09-01 13:59:30"
VESA_START="2026-09-01 14:03:00"
EXPECTED_SITE_OFF="0x25C3"
EXPECTED_SERVICE_POST_SHA="bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19"
EXPECTED_SITE_HEX="0f0b9090909090"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"

exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97W_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97W — READ-ONLY ACCELERATED llvmVersion CRASH-REGISTER AUDIT ====="
echo "PURPOSE=extract_exact_D97V_terminal_SIGILL_identity_and_RAX_llvmVersion_from_the_2026-09-01_14:00_accelerated_boot_only"
echo "ACCELERATED_BOOT=2026-09-01_14:00"
echo "VESA_RECOVERY_BOOT=2026-09-01_14:03_EXCLUDED"
echo "CONTENT_WINDOW_START=$ACCEL_START"
echo "CONTENT_WINDOW_END_EXCLUSIVE=$VESA_START"
echo "EXPECTED_CRASH_IDENTITY=MTLCompilerService_SIGILL_EXC_BAD_INSTRUCTION_image_plus_0x25C3"
echo "REGISTER_CONTRACT=RAX_full_uint64_llvmVersion_EAX_low32_exact_selector"
echo "SELECTOR_3802_DEC=3802|HEX=0xEDA"
echo "SELECTOR_32023_DEC=32023|HEX=0x7D17"
echo "EXPECTED_SERVICE_POST_SHA=$EXPECTED_SERVICE_POST_SHA"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"

PRODUCT="$(sw_vers -productVersion 2>/dev/null || true)"
BUILD="$(sw_vers -buildVersion 2>/dev/null || true)"
PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
CURRENT_BOOT_UUID="$(/usr/sbin/sysctl -n kern.bootsessionuuid 2>/dev/null || true)"
echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "PYTHON_EXEC=${PYTHON_BIN:-MISSING}"
echo "CURRENT_VESA_BOOT_SESSION_UUID=${CURRENT_BOOT_UUID:-UNKNOWN}"
[[ "$PRODUCT" == "26.6.2" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "25G82" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PYTHON_BIN" && -x "$PYTHON_BIN" ]] || fail "PYTHON3_MISSING"
"$PYTHON_BIN" --version 2>&1

echo "===== BOOT CHRONOLOGY RECHECK ====="
/usr/bin/last reboot 2>/dev/null | /usr/bin/head -n 8 | /usr/bin/sed 's/^/LAST_REBOOT=/' || true

if [[ -f "$SERVICE" ]]; then
  CURRENT_SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
  CURRENT_SITE_HEX="$(/usr/bin/xxd -p -s $((0x25C3)) -l 7 "$SERVICE" 2>/dev/null | /usr/bin/tr -d '\n' || true)"
  echo "CURRENT_VISIBLE_SERVICE_SHA=$CURRENT_SERVICE_SHA"
  echo "CURRENT_VISIBLE_SITE_0x25C3=$CURRENT_SITE_HEX"
  if [[ "$CURRENT_SERVICE_SHA" == "$EXPECTED_SERVICE_POST_SHA" && "$CURRENT_SITE_HEX" == "$EXPECTED_SITE_HEX" ]]; then
    echo "CURRENT_VISIBLE_D97V_PATCH_IDENTITY=PASS"
  else
    echo "CURRENT_VISIBLE_D97V_PATCH_IDENTITY=NOT_EXACT_CURRENT_VIEW"
  fi
else
  echo "CURRENT_VISIBLE_SERVICE=MISSING"
fi

echo "PRECHECK=PASS"

set +e
"$PYTHON_BIN" - "$ACCEL_START" "$VESA_START" "$CURRENT_BOOT_UUID" "$EXPECTED_SITE_OFF" <<'PY'
from pathlib import Path
from datetime import datetime, timezone, timedelta
import json, os, re, subprocess, sys

START_S, END_S, CURRENT_UUID, SITE_S = sys.argv[1:5]
LOCAL_TZ = timezone(timedelta(hours=3))
START = datetime.strptime(START_S, '%Y-%m-%d %H:%M:%S').replace(tzinfo=LOCAL_TZ)
END = datetime.strptime(END_S, '%Y-%m-%d %H:%M:%S').replace(tzinfo=LOCAL_TZ)
SITE = int(SITE_S, 0)
ROOTS = [Path('/Library/Logs/DiagnosticReports'), Path.home()/'Library/Logs/DiagnosticReports']

def p_int(v):
    if v is None: return None
    if isinstance(v, bool): return int(v)
    if isinstance(v, int): return v
    if isinstance(v, float): return int(v)
    if isinstance(v, dict):
        for k in ('value','address','pc','rip'):
            if k in v:
                x=p_int(v[k])
                if x is not None:return x
        return None
    if isinstance(v, str):
        s=v.strip().replace('_','')
        m=re.search(r'0x[0-9a-fA-F]+',s)
        if m:
            try:return int(m.group(0),16)
            except:return None
        m=re.fullmatch(r'-?\d+',s)
        if m:
            try:return int(s,10)
            except:return None
    return None

def parse_dt(v):
    if not isinstance(v,str): return None
    s=v.strip()
    if not s:return None
    s=re.sub(r'([+-]\d{2})(\d{2})$',r'\1:\2',s)
    if s.endswith('Z'):s=s[:-1]+'+00:00'
    for cand in (s,s.replace(' ','T',1)):
        try:
            d=datetime.fromisoformat(cand)
            if d.tzinfo is None:d=d.replace(tzinfo=LOCAL_TZ)
            return d.astimezone(LOCAL_TZ)
        except:pass
    fmts=('%Y-%m-%d %H:%M:%S.%f %z','%Y-%m-%d %H:%M:%S %z','%Y-%m-%d %H:%M:%S.%f','%Y-%m-%d %H:%M:%S')
    for f in fmts:
        try:
            d=datetime.strptime(s,f)
            if d.tzinfo is None:d=d.replace(tzinfo=LOCAL_TZ)
            return d.astimezone(LOCAL_TZ)
        except:pass
    return None

def recursive_values(obj, wanted):
    wl={x.lower() for x in wanted}; out=[]
    def rec(x):
        if isinstance(x,dict):
            for k,v in x.items():
                if str(k).lower() in wl:out.append(v)
                rec(v)
        elif isinstance(x,list):
            for y in x:rec(y)
    rec(obj); return out

def first_dt(objs, path):
    keys=('captureTime','timestamp','dateTime','time','Date/Time')
    for o in objs:
        for v in recursive_values(o,keys):
            d=parse_dt(v)
            if d:return d,'CONTENT'
    m=re.search(r'MTLCompilerService-(\d{4}-\d{2}-\d{2})-(\d{6})',path.name)
    if m:
        try:return datetime.strptime(m.group(1)+m.group(2),'%Y-%m-%d%H%M%S').replace(tzinfo=LOCAL_TZ),'FILENAME'
        except:pass
    return None,'UNKNOWN'

def parse_json_objects(text):
    dec=json.JSONDecoder(); pos=0; out=[]; n=len(text)
    while pos<n:
        while pos<n and text[pos].isspace():pos+=1
        if pos>=n:break
        try:o,end=dec.raw_decode(text,pos)
        except Exception:break
        out.append(o);pos=end
    if not out:
        for line in text.splitlines()[:4]:
            try:out.append(json.loads(line))
            except:pass
    return out

def reg_from(x,name):
    target=name.lower()
    if isinstance(x,dict):
        for k,v in x.items():
            if str(k).lower()==target:
                q=p_int(v)
                if q is not None:return q
        for v in x.values():
            q=reg_from(v,name)
            if q is not None:return q
    elif isinstance(x,list):
        for v in x:
            q=reg_from(v,name)
            if q is not None:return q
    return None

def pick_payload(objs):
    for o in reversed(objs):
        if isinstance(o,dict) and any(k in o for k in ('threads','usedImages','procName','faultingThread')):return o
    return objs[-1] if objs else {}

def fault_thread(payload):
    threads=payload.get('threads') if isinstance(payload,dict) else None
    if not isinstance(threads,list):return None
    fi=p_int(payload.get('faultingThread'))
    if fi is not None and 0<=fi<len(threads):return threads[fi]
    for t in threads:
        if isinstance(t,dict) and t.get('triggered') is True:return t
    return threads[0] if threads else None

def image_name(im):
    if not isinstance(im,dict):return ''
    return str(im.get('name') or Path(str(im.get('path') or '')).name)

def summarize_ips(path,text,objs):
    payload=pick_payload(objs); merged=objs
    dt,dtsrc=first_dt(objs,path)
    uuids=[]
    for o in objs:
        for v in recursive_values(o,('bootSessionUUID','boot_session_uuid')):
            if isinstance(v,str):uuids.append(v.upper())
    boot_uuid=uuids[0] if uuids else None
    proc=None;pid=None;incident=None
    for o in objs:
        if not isinstance(o,dict):continue
        proc=proc or o.get('procName') or o.get('app_name') or o.get('name')
        pid=pid if pid is not None else p_int(o.get('pid'))
        incident=incident or o.get('incident') or o.get('incident_id')
    ft=fault_thread(payload)
    state=(ft.get('threadState') if isinstance(ft,dict) else None) or (ft.get('thread_state') if isinstance(ft,dict) else None) or ft or payload
    rax=reg_from(state,'rax'); rip=reg_from(state,'rip')
    if rax is None:rax=reg_from(payload,'rax')
    if rip is None:rip=reg_from(payload,'rip')
    images=payload.get('usedImages',[]) if isinstance(payload,dict) else []
    service_base=None
    for im in images if isinstance(images,list) else []:
        if 'MTLCompilerService' in image_name(im) or 'MTLCompilerService' in str(im.get('path','')):
            service_base=p_int(im.get('base'));break
    rip_off=(rip-service_base) if rip is not None and service_base is not None else None
    frame_off=None;frame_image=None
    if isinstance(ft,dict):
        frames=ft.get('frames',[])
        if isinstance(frames,list):
            for fr in frames:
                if not isinstance(fr,dict):continue
                off=p_int(fr.get('imageOffset')); idx=p_int(fr.get('imageIndex'))
                name=''
                if idx is not None and isinstance(images,list) and 0<=idx<len(images):name=image_name(images[idx])
                if frame_off is None:
                    frame_off=off;frame_image=name
                if 'MTLCompilerService' in name:
                    frame_off=off;frame_image=name;break
    compact=json.dumps(objs,ensure_ascii=False,separators=(',',':'))
    sigill=bool(re.search(r'SIGILL|EXC_BAD_INSTRUCTION|signal[^0-9]{0,8}4\b|"signal"\s*:\s*4\b',compact,re.I))
    exc=[]
    for o in objs:
        for v in recursive_values(o,('exception','termination','exceptionType','signal')):
            if isinstance(v,(str,int,float)):exc.append(str(v))
            elif isinstance(v,dict):exc.append(json.dumps(v,separators=(',',':'))[:500])
    exact_offset=(rip_off==SITE or frame_off==SITE)
    in_window=(dt is not None and START<=dt<END)
    vesa_excluded=(CURRENT_UUID and boot_uuid and boot_uuid.upper()==CURRENT_UUID.upper())
    low=(rax & 0xffffffff) if rax is not None else None
    return dict(path=str(path),dt=dt,dtsrc=dtsrc,boot_uuid=boot_uuid,proc=proc,pid=pid,incident=incident,
                rax=rax,low=low,rip=rip,service_base=service_base,rip_off=rip_off,frame_off=frame_off,
                frame_image=frame_image,sigill=sigill,exc=' | '.join(exc[:8]),exact_offset=exact_offset,
                in_window=in_window,vesa_excluded=vesa_excluded,kind='IPS')

def summarize_crash(path,text):
    dt=None;src='UNKNOWN'
    m=re.search(r'^Date/Time:\s*(.+)$',text,re.M)
    if m:dt=parse_dt(m.group(1));src='CONTENT'
    if dt is None:
        dt,src=first_dt([],path)
    pid=None;m=re.search(r'^Process:\s*MTLCompilerService\s*\[(\d+)\]',text,re.M)
    if m:pid=int(m.group(1))
    mr=re.search(r'\brax:\s*(0x[0-9a-fA-F]+)',text,re.I);rax=int(mr.group(1),16) if mr else None
    mi=re.search(r'\brip:\s*(0x[0-9a-fA-F]+)',text,re.I);rip=int(mi.group(1),16) if mi else None
    base=None
    for ln in text.splitlines():
        if 'MTLCompilerService' in ln and re.search(r'0x[0-9a-fA-F]+\s+-\s+0x[0-9a-fA-F]+',ln):
            m=re.search(r'(0x[0-9a-fA-F]+)\s+-',ln)
            if m:base=int(m.group(1),16);break
    rip_off=(rip-base) if rip is not None and base is not None else None
    frame_off=None
    for ln in text.splitlines():
        if 'MTLCompilerService' in ln:
            m=re.search(r'\+\s*(0x[0-9a-fA-F]+|\d+)\s*$',ln)
            if m:
                frame_off=int(m.group(1),0);break
    sigill=bool(re.search(r'SIGILL|EXC_BAD_INSTRUCTION',text,re.I))
    low=(rax&0xffffffff) if rax is not None else None
    return dict(path=str(path),dt=dt,dtsrc=src,boot_uuid=None,proc='MTLCompilerService',pid=pid,incident=None,
                rax=rax,low=low,rip=rip,service_base=base,rip_off=rip_off,frame_off=frame_off,
                frame_image='MTLCompilerService',sigill=sigill,exc='',exact_offset=(rip_off==SITE or frame_off==SITE),
                in_window=(dt is not None and START<=dt<END),vesa_excluded=False,kind='CRASH')

paths=[]
for root in ROOTS:
    print(f'SCAN_ROOT={root}|EXISTS={root.exists()}')
    if root.exists():
        try:
            for p in root.rglob('*'):
                if p.is_file() and p.name.lower().startswith('mtlcompilerservice') and p.suffix.lower() in ('.ips','.crash'):
                    paths.append(p)
        except Exception as e:print(f'SCAN_ERROR={root}|{e!r}')
# inode/path dedupe
uniq=[];seen=set()
for p in sorted(paths,key=str):
    try:key=(p.stat().st_dev,p.stat().st_ino)
    except:key=('PATH',str(p))
    if key not in seen:seen.add(key);uniq.append(p)
print(f'ALL_MTLCOMPILERSERVICE_REPORT_COUNT={len(uniq)}')
records=[];parse_fail=[]
for p in uniq:
    try:text=p.read_text(errors='replace')
    except Exception as e:parse_fail.append((str(p),repr(e)));continue
    try:
        if p.suffix.lower()=='.ips':
            objs=parse_json_objects(text)
            if not objs:raise ValueError('no JSON objects')
            r=summarize_ips(p,text,objs)
        else:r=summarize_crash(p,text)
        records.append(r)
    except Exception as e:parse_fail.append((str(p),repr(e)))
print(f'PARSED_REPORT_COUNT={len(records)}')
print(f'PARSE_FAIL_COUNT={len(parse_fail)}')
for p,e in parse_fail:print(f'PARSE_FAIL=PATH={p}|ERROR={e}')
window=[r for r in records if r['in_window'] and not r['vesa_excluded']]
print(f'CONTENT_WINDOW_REPORT_COUNT={len(window)}')
for i,r in enumerate(sorted(window,key=lambda x:(x['dt'] or START,x['path'])),1):
    print(f'--- WINDOW_REPORT_{i} ---')
    print(f'PATH={r["path"]}')
    print(f'KIND={r["kind"]}|CAPTURE_TIME={r["dt"].isoformat() if r["dt"] else "UNKNOWN"}|TIME_SOURCE={r["dtsrc"]}')
    print(f'BOOT_SESSION_UUID={r["boot_uuid"] or "UNKNOWN"}|PID={r["pid"] if r["pid"] is not None else "UNKNOWN"}|INCIDENT={r["incident"] or "UNKNOWN"}')
    print(f'SIGILL_OR_EXC_BAD_INSTRUCTION={"YES" if r["sigill"] else "NO"}')
    print(f'RIP={"UNKNOWN" if r["rip"] is None else hex(r["rip"])}|SERVICE_BASE={"UNKNOWN" if r["service_base"] is None else hex(r["service_base"])}|RIP_OFFSET={"UNKNOWN" if r["rip_off"] is None else hex(r["rip_off"])}')
    print(f'FRAME_IMAGE={r["frame_image"] or "UNKNOWN"}|FRAME_OFFSET={"UNKNOWN" if r["frame_off"] is None else hex(r["frame_off"])}')
    print(f'RAX_FULL64={"UNKNOWN" if r["rax"] is None else f"0x{r["rax"] & ((1<<64)-1):016X}"}|RAX_LOW32={"UNKNOWN" if r["low"] is None else f"0x{r["low"]:08X}"}|LOW32_DEC={r["low"] if r["low"] is not None else "UNKNOWN"}')
    print(f'EXACT_D97V_TERMINAL_IDENTITY={"YES" if r["exact_offset"] and r["sigill"] else "NO"}')
    if r['exc']:print('EXCEPTION_SUMMARY='+r['exc'][:1500])

# Dedupe exact captures conservatively by incident/time/pid/low/offset.
exact_raw=[r for r in window if r['exact_offset'] and r['sigill']]
exact=[];keys=set()
for r in exact_raw:
    k=(r['incident'] or '',r['dt'].isoformat() if r['dt'] else '',r['pid'],r['low'],r['rip_off'],r['frame_off'])
    if k not in keys:keys.add(k);exact.append(r)
with_rax=[r for r in exact if r['rax'] is not None]
print('\n===== D97V TERMINAL CAPTURE SUMMARY =====')
print(f'D97V_EXACT_TERMINAL_REPORT_COUNT_RAW={len(exact_raw)}')
print(f'D97V_EXACT_TERMINAL_CAPTURE_COUNT_UNIQUE={len(exact)}')
print(f'D97V_EXACT_TERMINAL_WITH_RAX_COUNT={len(with_rax)}')
vals={}
for r in with_rax:vals[r['low']]=vals.get(r['low'],0)+1
for v,n in sorted(vals.items()):
    label='SELECTS_MTLCompiler_3802' if v==3802 else ('SELECTS_MTLCompiler_32023' if v==32023 else ('ZERO_OR_KEY_ABSENT' if v==0 else 'OTHER_SELECTOR'))
    print(f'RAX_LOW32_HISTOGRAM=DEC={v}|HEX=0x{v:X}|COUNT={n}|CLASS={label}')
if with_rax:
    first=min(with_rax,key=lambda r:r['dt'] or END)
    print(f'EARLIEST_EXACT_CAPTURE_TIME={first["dt"].isoformat() if first["dt"] else "UNKNOWN"}')
    print(f'EARLIEST_EXACT_CAPTURE_PID={first["pid"] if first["pid"] is not None else "UNKNOWN"}')
    print(f'EARLIEST_EXACT_CAPTURE_RAX_FULL64=0x{first["rax"] & ((1<<64)-1):016X}')
    print(f'EARLIEST_EXACT_CAPTURE_RAX_LOW32_DEC={first["low"]}')
    print(f'EARLIEST_EXACT_CAPTURE_RAX_LOW32_HEX=0x{first["low"]:X}')

if len(vals)==1:
    only=next(iter(vals))
    if only==3802:
        result='RUNTIME_LLVMVERSION_3802_PROVEN_ALL_OBSERVED_EXACT_CAPTURES'
    elif only==32023:
        result='RUNTIME_LLVMVERSION_32023_PROVEN_ALL_OBSERVED_EXACT_CAPTURES'
    elif only==0:
        result='RUNTIME_LLVMVERSION_ZERO_PROVEN_ALL_OBSERVED_EXACT_CAPTURES'
    else:
        result=f'RUNTIME_LLVMVERSION_OTHER_{only}_PROVEN_ALL_OBSERVED_EXACT_CAPTURES'
    print('D97W_RESULT='+result)
    print('D97V_VISIBLE_SERVICE_EXECUTION_PROVEN=YES')
    print('HISTORICAL_ACCELERATED_RUNTIME_LLVMVERSION=STATICALLY_UNKNOWN_RUNTIME_NOW_DIRECTLY_OBSERVED')
elif len(vals)>1:
    print('D97W_RESULT=MULTIPLE_RUNTIME_LLVMVERSION_VALUES_PROVEN_REQUEST_VARIATION_REQUIRES_CAUSAL_CORRELATION')
    print('D97V_VISIBLE_SERVICE_EXECUTION_PROVEN=YES')
else:
    print('D97W_RESULT=NO_EXACT_D97V_TERMINAL_RAX_CAPTURE_FOUND_IN_DIAGNOSTIC_REPORT_CHANNEL')
    print('D97V_VISIBLE_SERVICE_EXECUTION_PROVEN=UNKNOWN_FROM_REPORT_CHANNEL')

print('\n===== UNIFIED LOG FALLBACK / CORROBORATION =====')
pred='process == "MTLCompilerService" OR eventMessage CONTAINS[c] "MTLCompilerService" OR eventMessage CONTAINS[c] "SIGILL" OR eventMessage CONTAINS[c] "EXC_BAD_INSTRUCTION"'
try:
    p=subprocess.run(['/usr/bin/log','show','--start',START_S,'--end',END_S,'--style','compact','--predicate',pred],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=180)
    lines=p.stdout.splitlines()
    hits=[ln for ln in lines if re.search(r'MTLCompilerService|SIGILL|EXC_BAD_INSTRUCTION|signal 4|corpse|crash|exited',ln,re.I)]
    print(f'LOG_SHOW_RC={p.returncode}|TOTAL_LINES={len(lines)}|INTERESTING_LINES={len(hits)}')
    for ln in hits[:1200]:print('LOG='+ln)
    if len(hits)>1200:print(f'LOG_TRUNCATED={len(hits)-1200}')
except Exception as e:
    print('LOG_SHOW_ERROR='+repr(e))

print('\n===== FINAL =====')
print('ACCELERATED_BOOT_SELECTED=2026-09-01_14:00')
print('VESA_RECOVERY_BOOT_EXCLUDED=2026-09-01_14:03')
print('SYSTEM_MUTATION=NO')
print('SERVICE_LAUNCH=AUTO-NO')
print('ROOT_PATCH=AUTO-NO')
print('REBOOT=AUTO-NO')
print('D82_EXECUTION=NO')
print('PATCH8_AUTO_INTEGRATION=NO')
print('D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT=PASS')
PY
PY_RC=$?
set -e
echo "D97W_PYTHON_RC=$PY_RC"
[[ "$PY_RC" -eq 0 ]] || fail "PYTHON_AUDIT_RC:$PY_RC"

echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"
