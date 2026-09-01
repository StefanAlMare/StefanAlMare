#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AES_READONLY_JSON_SENDER_IMAGE_AND_FORMAT_PROVENANCE_REPORT.txt"
JSONLOG="/private/tmp/OCLP7_D97AES_MTL_JSON.log"
START="2026-09-02 00:10:00"
END="2026-09-02 00:12:00"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
EXPECTED_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_32023_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
EXPECTED_3802_SHA="85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){
  echo "D97AES_FAIL=$*"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "RUNTIME_INSTRUMENTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

/bin/rm -f "$JSONLOG"

echo "===== OCLP7 D97AES — READ-ONLY JSON SENDER-IMAGE / FORMAT PROVENANCE ====="
echo "INPUT_D97AEQ=28_of_28_natural_exit1_zero_exit110_114"
echo "INPUT_D97AER=visible_32023_late_diagnostic_xrefs_all_after_D97AD_REL_0x58B"
echo "PURPOSE=use_historical_unified_log_JSON_sender_image_and_format_metadata_to_identify_the_actual_MTLCompiler_generation_and_error_family"
echo "ACCELERATED_BOOT=2026-09-02_00:10"
echo "VESA_RECOVERY_BOOT=2026-09-02_00:12|EXCLUDED"
echo "CONTENT_WINDOW_START=$START"
echo "CONTENT_WINDOW_END_EXCLUSIVE=$END"
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

PRODUCT="$(/usr/bin/sw_vers -productVersion 2>/dev/null || true)"
BUILD="$(/usr/bin/sw_vers -buildVersion 2>/dev/null || true)"
PY="$(command -v python3 2>/dev/null || true)"
echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "PYTHON_EXEC=${PY:-MISSING}"
[[ "$PRODUCT" == "26.6.2" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "25G82" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PY" && -x "$PY" ]] || fail "PYTHON3_MISSING"
for tool in shasum otool log last awk sed grep head; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done
"$PY" --version 2>&1

[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING"
[[ -f "$MTL32023" ]] || fail "MTL32023_MISSING"
[[ -f "$MTL3802" ]] || fail "MTL3802_MISSING"
SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
SHA32023="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
SHA3802="$(/usr/bin/shasum -a 256 "$MTL3802" | /usr/bin/awk '{print $1}')"
echo "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
echo "VISIBLE_MTL32023_SHA=$SHA32023"
echo "VISIBLE_MTL3802_SHA=$SHA3802"
[[ "$SERVICE_SHA" == "$EXPECTED_SERVICE_SHA" ]] || fail "SERVICE_SHA_MISMATCH:$SERVICE_SHA"
[[ "$SHA32023" == "$EXPECTED_32023_SHA" ]] || fail "MTL32023_SHA_MISMATCH:$SHA32023"
[[ "$SHA3802" == "$EXPECTED_3802_SHA" ]] || fail "MTL3802_SHA_MISMATCH:$SHA3802"

echo "===== MACH-O UUIDS ====="
UUID_SERVICE="$(/usr/bin/otool -l "$SERVICE" | /usr/bin/awk '/cmd LC_UUID/{f=1;next} f&&/uuid /{print $2;exit}')"
UUID32023="$(/usr/bin/otool -l "$MTL32023" | /usr/bin/awk '/cmd LC_UUID/{f=1;next} f&&/uuid /{print $2;exit}')"
UUID3802="$(/usr/bin/otool -l "$MTL3802" | /usr/bin/awk '/cmd LC_UUID/{f=1;next} f&&/uuid /{print $2;exit}')"
echo "SERVICE_LC_UUID=${UUID_SERVICE:-UNKNOWN}"
echo "MTL32023_LC_UUID=${UUID32023:-UNKNOWN}"
echo "MTL3802_LC_UUID=${UUID3802:-UNKNOWN}"
[[ -n "$UUID_SERVICE" && -n "$UUID32023" && -n "$UUID3802" ]] || fail "UUID_EXTRACTION_FAILED"
echo "VISIBLE_IDENTITIES_AND_UUIDS=PASS"

echo "===== BOOT CHRONOLOGY ====="
/usr/bin/last reboot 2>/dev/null | /usr/bin/head -n 8 | /usr/bin/sed 's/^/LAST_REBOOT=/' || true
echo "BOOT_PAIR_CLASSIFICATION=ACCELERATED_00_10__VESA_00_12_EXCLUDED"

echo "===== HISTORICAL JSON LOG EXTRACTION ====="
PRED='process == "MTLCompilerService" OR (process == "launchd" AND eventMessage CONTAINS[c] "MTLCompilerService")'
set +e
/usr/bin/log show --start "$START" --end "$END" --style json --info --debug --predicate "$PRED" > "$JSONLOG" 2>&1
LOG_RC=$?
set -e
echo "JSON_LOG_SHOW_RC=$LOG_RC"
[[ "$LOG_RC" -eq 0 ]] || fail "JSON_LOG_SHOW_FAILED:$LOG_RC"
[[ -s "$JSONLOG" ]] || fail "JSON_LOG_EMPTY"
echo "JSON_LOG_FILE=$JSONLOG"
echo "JSON_LOG_BYTES=$(/usr/bin/stat -f %z "$JSONLOG" 2>/dev/null || /usr/bin/wc -c < "$JSONLOG")"

"$PY" - "$JSONLOG" "$UUID_SERVICE" "$UUID32023" "$UUID3802" <<'PY'
from pathlib import Path
import collections, json, re, sys

p=Path(sys.argv[1])
u_service=sys.argv[2].replace('-','').lower()
u_32023=sys.argv[3].replace('-','').lower()
u_3802=sys.argv[4].replace('-','').lower()
text=p.read_text(errors='replace')

def load_records(s):
    s=s.strip()
    if not s:
        return []
    try:
        obj=json.loads(s)
        if isinstance(obj,list): return [x for x in obj if isinstance(x,dict)]
        if isinstance(obj,dict):
            for k in ('records','entries','events'):
                if isinstance(obj.get(k),list): return [x for x in obj[k] if isinstance(x,dict)]
            return [obj]
    except Exception:
        pass
    rec=[]
    for ln in s.splitlines():
        t=ln.strip().rstrip(',')
        if t in ('[',']',''):
            continue
        try:
            x=json.loads(t)
            if isinstance(x,dict): rec.append(x)
        except Exception:
            pass
    return rec

records=load_records(text)
print(f'JSON_RECORD_COUNT={len(records)}')
if not records:
    print('D97AES_JSON_PARSE=FAIL_NO_RECORDS')
    raise SystemExit(2)
print('D97AES_JSON_PARSE=PASS')

def flat(d,prefix=''):
    out={}
    if isinstance(d,dict):
        for k,v in d.items():
            key=f'{prefix}.{k}' if prefix else str(k)
            if isinstance(v,dict): out.update(flat(v,key))
            else: out[key]=v
    return out

def first_by_suffix(fd,suffixes):
    for suf in suffixes:
        for k,v in fd.items():
            if k.lower().endswith(suf.lower()) and v not in (None,''):
                return v
    return None

def vals_by_suffix(fd,suffixes):
    arr=[]
    for k,v in fd.items():
        kl=k.lower()
        if any(kl.endswith(s.lower()) for s in suffixes) and v not in (None,''):
            arr.append((k,v))
    return arr

def norm_uuid(v):
    if v is None:return None
    s=re.sub(r'[^0-9a-fA-F]','',str(v)).lower()
    return s if len(s)>=32 else None

def msg_of(r):
    fd=flat(r)
    v=first_by_suffix(fd,('eventMessage','composedMessage','message'))
    return str(v) if v is not None else ''

def proc_of(r):
    fd=flat(r)
    v=first_by_suffix(fd,('process','processName'))
    return str(v) if v is not None else ''

def pid_of(r,msg=''):
    fd=flat(r)
    for suf in ('processID','processIdentifier','pid'):
        v=first_by_suffix(fd,(suf,))
        if v is not None:
            try:return int(v)
            except:pass
    m=re.search(r'MTLCompilerService\[(\d+)',msg)
    if m:return int(m.group(1))
    return None

def classify_path(v):
    if v is None:return 'NONE'
    s=str(v)
    if '/Versions/32023/MTLCompiler' in s or '\\Versions\\32023\\MTLCompiler' in s:return '32023'
    if '/Versions/3802/MTLCompiler' in s or '\\Versions\\3802\\MTLCompiler' in s:return '3802'
    if 'MTLCompilerService' in s:return 'SERVICE'
    if 'MTLCompiler' in s:return 'OTHER_MTLCOMPILER'
    return 'OTHER'

def classify_uuid(v):
    u=norm_uuid(v)
    if not u:return 'NONE'
    if u==u_32023:return '32023'
    if u==u_3802:return '3802'
    if u==u_service:return 'SERVICE'
    return 'OTHER'

def branch_from_format(s):
    low=(s or '').lower()
    if 'pointers to an argument buffer inside another argument buffer' in low:return 'NESTED_ARG_BUFFER'
    if 'buffers are supported in the simulator' in low and 'constant buffers' not in low:return 'BUFFERS'
    if 'sampelrs are supported in the simulator' in low or 'samplers are supported in the simulator' in low:return 'SAMPLERS'
    if 'textures are supported in the simulator' in low:return 'TEXTURES'
    if 'constant buffers binding are supported in the simulator' in low:return 'CONST_BUFFERS'
    if 'fragment shader has' in low and 'interpolated inputs' in low:return 'INTERPOLATED_INPUTS'
    return 'UNKNOWN'

# Diagnostic records are service-side MTLCompiler messages from the simulator-limit family.
diag=[]
for r in records:
    m=msg_of(r)
    if 'simulator' in m.lower() and ('were used' in m.lower() or 'support' in m.lower()):
        diag.append(r)
print(f'JSON_SIMULATOR_DIAGNOSTIC_RECORD_COUNT={len(diag)}')
if diag:
    print('JSON_DIAGNOSTIC_FIRST_KEYS='+','.join(sorted(flat(diag[0]).keys())))

path_hist=collections.Counter(); uuid_hist=collections.Counter(); branch_hist=collections.Counter(); pidset=set()
records_with_sender_path=0; records_with_sender_uuid=0; records_with_format=0
sender_32023_pids=set(); sender_3802_pids=set(); sender_unknown_pids=set()
branch_by_pid=collections.defaultdict(set)

for i,r in enumerate(diag,1):
    fd=flat(r); m=msg_of(r); pid=pid_of(r,m)
    if pid is not None: pidset.add(pid)
    sender_paths=vals_by_suffix(fd,('senderImagePath','sender_image_path'))
    sender_uuids=vals_by_suffix(fd,('senderImageUUID','sender_image_uuid'))
    process_paths=vals_by_suffix(fd,('processImagePath','process_image_path'))
    process_uuids=vals_by_suffix(fd,('processImageUUID','process_image_uuid'))
    formats=vals_by_suffix(fd,('formatString','format_string'))
    sources=vals_by_suffix(fd,('source','subsystem','category'))

    sp=sender_paths[0][1] if sender_paths else None
    su=sender_uuids[0][1] if sender_uuids else None
    pp=process_paths[0][1] if process_paths else None
    pu=process_uuids[0][1] if process_uuids else None
    fmt=formats[0][1] if formats else None
    if sp is not None: records_with_sender_path+=1
    if su is not None: records_with_sender_uuid+=1
    if fmt is not None: records_with_format+=1
    pc=classify_path(sp); uc=classify_uuid(su); br=branch_from_format(str(fmt) if fmt is not None else m)
    path_hist[pc]+=1; uuid_hist[uc]+=1; branch_hist[br]+=1
    if pid is not None:
        if pc=='32023' or uc=='32023': sender_32023_pids.add(pid)
        elif pc=='3802' or uc=='3802': sender_3802_pids.add(pid)
        else: sender_unknown_pids.add(pid)
        branch_by_pid[pid].add(br)
    print(f'DIAG_JSON_{i}=PID={pid if pid is not None else "UNKNOWN"}|SENDER_PATH={sp if sp is not None else "NONE"}|SENDER_PATH_CLASS={pc}|SENDER_UUID={su if su is not None else "NONE"}|SENDER_UUID_CLASS={uc}|PROCESS_PATH={pp if pp is not None else "NONE"}|PROCESS_UUID={pu if pu is not None else "NONE"}|FORMAT={fmt if fmt is not None else "NONE"}|BRANCH={br}|MESSAGE={m}')
    if i<=3:
        for k,v in sources:
            print(f'DIAG_JSON_{i}_META={k}={v}')

print('===== JSON SENDER PROVENANCE SUMMARY =====')
print(f'DIAGNOSTIC_UNIQUE_PID_COUNT={len(pidset)}')
print(f'DIAGNOSTIC_RECORDS_WITH_SENDER_PATH={records_with_sender_path}')
print(f'DIAGNOSTIC_RECORDS_WITH_SENDER_UUID={records_with_sender_uuid}')
print(f'DIAGNOSTIC_RECORDS_WITH_FORMAT_STRING={records_with_format}')
for k in sorted(path_hist):print(f'SENDER_PATH_CLASS_HISTOGRAM={k}|COUNT={path_hist[k]}')
for k in sorted(uuid_hist):print(f'SENDER_UUID_CLASS_HISTOGRAM={k}|COUNT={uuid_hist[k]}')
for k in sorted(branch_hist):print(f'FORMAT_BRANCH_HISTOGRAM={k}|COUNT={branch_hist[k]}')
print(f'SENDER_32023_PID_COUNT={len(sender_32023_pids)}|PIDS={sorted(sender_32023_pids)}')
print(f'SENDER_3802_PID_COUNT={len(sender_3802_pids)}|PIDS={sorted(sender_3802_pids)}')
print(f'SENDER_UNKNOWN_PID_COUNT={len(sender_unknown_pids)}|PIDS={sorted(sender_unknown_pids)}')
for pid in sorted(branch_by_pid):print(f'FORMAT_BRANCH_BY_PID=PID={pid}|BRANCHES={sorted(branch_by_pid[pid])}')

if pidset and sender_32023_pids==pidset and not sender_3802_pids:
    sender_result='RUNTIME_DIAGNOSTIC_SENDER_32023_PROVEN_FOR_ALL_DIAGNOSTIC_PIDS'
elif pidset and sender_3802_pids==pidset and not sender_32023_pids:
    sender_result='RUNTIME_DIAGNOSTIC_SENDER_3802_PROVEN_FOR_ALL_DIAGNOSTIC_PIDS'
elif sender_32023_pids or sender_3802_pids:
    sender_result='RUNTIME_DIAGNOSTIC_SENDER_MIXED_OR_PARTIAL_PROVENANCE_REQUIRES_AUDIT'
else:
    sender_result='RUNTIME_DIAGNOSTIC_SENDER_IMAGE_PROVENANCE_UNKNOWN_JSON_METADATA_ABSENT_OR_UNMATCHED'
print('D97AES_SENDER_RESULT='+sender_result)

known_branch_pids={pid for pid,bs in branch_by_pid.items() if bs and bs!={'UNKNOWN'}}
if pidset and known_branch_pids==pidset:
    print('D97AES_FORMAT_BRANCH_COVERAGE=ALL_DIAGNOSTIC_PIDS_HAVE_KNOWN_BRANCH_FAMILY')
elif known_branch_pids:
    print('D97AES_FORMAT_BRANCH_COVERAGE=PARTIAL_KNOWN_BRANCH_FAMILY')
else:
    print('D97AES_FORMAT_BRANCH_COVERAGE=UNKNOWN_NO_USABLE_FORMAT_STRING')

# Corroborate D97AEQ exit(1) with the actual launchd message shape.
spawn=set(); exit1=set(); exit_other=[]
for r in records:
    m=msg_of(r)
    sm=re.search(r'Successfully spawned MTLCompilerService\[(\d+)\]',m,re.I)
    if sm: spawn.add(int(sm.group(1)))
    if 'MTLCompilerService' in m and 'exited due to' in m:
        pm=re.search(r'MTLCompilerService(?:\.[^\[]+)?\s*\[(\d+)\]:\]\s+exited due to exit\((\d+)\)',m,re.I)
        if pm:
            pid=int(pm.group(1)); code=int(pm.group(2))
            if code==1: exit1.add(pid)
            else: exit_other.append((pid,code,m))
print('===== REPAIRED EXIT1 CORROBORATION =====')
print(f'JSON_SPAWN_PID_COUNT={len(spawn)}|PIDS={sorted(spawn)}')
print(f'JSON_EXIT1_PID_COUNT={len(exit1)}|PIDS={sorted(exit1)}')
print(f'JSON_OTHER_NORMAL_EXIT_COUNT={len(exit_other)}')
print(f'JSON_EXIT1_EQUALS_SPAWN_SET={exit1==spawn}')
print(f'JSON_DIAGNOSTIC_PID_SET_EQUALS_SPAWN_SET={pidset==spawn}')
if exit1==spawn and len(spawn)==28:
    print('D97AES_EXIT1_CORROBORATION=PASS_28_OF_28')
else:
    print('D97AES_EXIT1_CORROBORATION=INCOMPLETE_D97AEQ_REMAINS_AUTHORITATIVE')

print('===== FINAL PYTHON =====')
print('D97AES_JSON_SENDER_IMAGE_AND_FORMAT_PROVENANCE_PYTHON=PASS')
PY

echo "===== FINAL ====="
echo "D97AES_READONLY_JSON_SENDER_IMAGE_AND_FORMAT_PROVENANCE=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "NEXT=assistant_audit_JSON_sender_image_and_format_provenance_before_any_runtime_change"
echo "REPORT=$REPORT"
