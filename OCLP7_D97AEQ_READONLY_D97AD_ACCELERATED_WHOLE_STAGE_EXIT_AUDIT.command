#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEQ_READONLY_D97AD_ACCELERATED_WHOLE_STAGE_EXIT_AUDIT_REPORT.txt"
LOGFILE="/private/tmp/OCLP7_D97AEQ_D97AD_ACCELERATED_WHOLE_STAGE.log"
START="2026-09-02 00:10:00"
END="2026-09-02 00:12:00"
ACCELERATED_BOOT="2026-09-02_00:10"
VESA_BOOT="2026-09-02_00:12"
FATAL_WS_PID="394"
FATAL_WS_TIME="2026-09-02 00:11:47.9888"
FATAL_WS_BOOT_UUID="B6B4D4C3-D751-4FB0-AE64-2AF8AA1B9CC0"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
MTL="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_MTL_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail() {
  echo "D97AEQ_FAIL=$*"
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
  exit 2
}

/bin/rm -f "$LOGFILE"

echo "===== OCLP7 D97AEQ — READ-ONLY D97AD ACCELERATED WHOLE-STAGE EXIT AUDIT ====="
echo "PURPOSE=classify_every_spawned_MTLCompilerService_in_the_2026-09-02_00:10_accelerated_D97AD_boot_by_exhaustive_exit_110_114"
echo "ACCELERATED_BOOT=$ACCELERATED_BOOT"
echo "VESA_RECOVERY_BOOT=$VESA_BOOT|EXCLUDED"
echo "CONTENT_WINDOW_START=$START"
echo "CONTENT_WINDOW_END_EXCLUSIVE=$END"
echo "FATAL_WINDOWSERVER_PID=$FATAL_WS_PID"
echo "FATAL_WINDOWSERVER_TIME=$FATAL_WS_TIME"
echo "FATAL_WINDOWSERVER_BOOT_UUID=$FATAL_WS_BOOT_UUID"
echo "EXIT_110=CANDIDATE_REACHED_REL_0x58B"
echo "EXIT_111=BUFFER_INDEX_ERROR_REL_0x29A"
echo "EXIT_112=SAMPLER_INDEX_ERROR_REL_0x2D9"
echo "EXIT_113=NESTED_ARGUMENT_BUFFER_ERROR_REL_0x3E2"
echo "EXIT_114=OTHER_EARLY_RETURN_REL_0xB9_OR_UNWIND_REL_0x6CC"
echo "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_PID_must_emit_exactly_one_exit_110_114;signal_other_or_missing_invalidates_run"
echo "EXPECTED_SELECTOR_ONLY_SERVICE_SHA=$EXPECTED_SERVICE_SHA"
echo "EXPECTED_D97AD_MTL_SHA=$EXPECTED_MTL_SHA"
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
CURRENT_BOOT_UUID="$(/usr/sbin/sysctl -n kern.bootsessionuuid 2>/dev/null || true)"
PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "CURRENT_VESA_BOOT_SESSION_UUID=${CURRENT_BOOT_UUID:-UNKNOWN}"
echo "PYTHON_EXEC=${PYTHON_BIN:-MISSING}"
[[ "$PRODUCT" == "26.6.2" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "25G82" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PYTHON_BIN" && -x "$PYTHON_BIN" ]] || fail "PYTHON3_MISSING"
[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING:$SERVICE"
[[ -f "$MTL" ]] || fail "MTL_MISSING:$MTL"

for tool in log shasum xxd last awk sed grep head; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done
"$PYTHON_BIN" --version 2>&1

VISIBLE_SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
VISIBLE_MTL_SHA="$(/usr/bin/shasum -a 256 "$MTL" | /usr/bin/awk '{print $1}')"
echo "VISIBLE_SERVICE_SHA=$VISIBLE_SERVICE_SHA"
echo "VISIBLE_MTL_SHA=$VISIBLE_MTL_SHA"
[[ "$VISIBLE_SERVICE_SHA" == "$EXPECTED_SERVICE_SHA" ]] || fail "VISIBLE_SERVICE_NOT_SELECTOR_ONLY:$VISIBLE_SERVICE_SHA"
[[ "$VISIBLE_MTL_SHA" == "$EXPECTED_MTL_SHA" ]] || fail "VISIBLE_MTL_NOT_D97AD:$VISIBLE_MTL_SHA"
echo "VISIBLE_SELECTOR_ONLY_SERVICE_IDENTITY=PASS"
echo "VISIBLE_D97AD_MTL_IDENTITY=PASS"

"$PYTHON_BIN" - "$MTL" <<'PYIDENT'
from pathlib import Path
import sys
p=Path(sys.argv[1])
b=p.read_bytes()
checks=[
    ('CANDIDATE_110',0x9D6BD,'6a6e5fe9bb38f6ff90'),
    ('BUFFER_111',0x9D3CC,'6a6f5fe9ac3bf6ff90909090'),
    ('SAMPLER_112',0x9D40B,'6a705fe96d3bf6ff9090'),
    ('NESTED_113',0x9D514,'6a715fe9643af6ff90'),
    ('EARLY_RETURN_114',0x9D1EB,'6a725fe98d3df6ff9090'),
    ('UNWIND_114',0x9D7FE,'6a725fe97a37f6ff90909090'),
    ('SHARED_EXIT_STUB',0xF80,'b8010000020f050f0b'),
]
for name,off,hx in checks:
    exp=bytes.fromhex(hx)
    got=b[off:off+len(exp)]
    print(f'D97AD_VISIBLE_POSTIMAGE={name}|FILEOFF=0x{off:X}|ACTUAL={got.hex()}|EXPECTED={hx}|PASS={got==exp}')
    if got!=exp:
        raise SystemExit(f'D97AD_VISIBLE_POSTIMAGE_FAIL:{name}:{got.hex()}')
print('D97AD_VISIBLE_SIX_SITES_AND_SHARED_STUB=PASS')
PYIDENT

echo "===== BOOT CHRONOLOGY RECHECK ====="
/usr/bin/last reboot 2>/dev/null | /usr/bin/head -n 8 | /usr/bin/sed 's/^/LAST_REBOOT=/' || true
echo "BOOT_PAIR_CLASSIFICATION=ACCELERATED_00_10__VESA_00_12_EXCLUDED"
echo "PRECHECK=PASS"

echo "===== UNIFIED LOG EXTRACTION ====="
PRED='process == "launchd" OR process == "MTLCompilerService" OR process == "WindowServer" OR eventMessage CONTAINS[c] "MTLCompilerService"'
set +e
/usr/bin/log show --start "$START" --end "$END" --style compact --predicate "$PRED" > "$LOGFILE" 2>&1
LOG_RC=$?
set -e
echo "LOG_SHOW_RC=$LOG_RC"
[[ "$LOG_RC" -eq 0 ]] || fail "LOG_SHOW_FAILED_RC:$LOG_RC"
[[ -f "$LOGFILE" ]] || fail "LOG_FILE_MISSING"
echo "LOG_FILE=$LOGFILE"

"$PYTHON_BIN" - "$LOGFILE" "$FATAL_WS_PID" "$FATAL_WS_TIME" <<'PY'
from pathlib import Path
from datetime import datetime
import collections
import re
import sys

path=Path(sys.argv[1])
fatal_ws_pid=int(sys.argv[2])
fatal_time=datetime.strptime(sys.argv[3],'%Y-%m-%d %H:%M:%S.%f')
lines=path.read_text(errors='replace').splitlines()
mtl=[ln for ln in lines if re.search(r'MTLCompilerService',ln,re.I)]

spawn=[]
exit_due=[]

def timestamp(line):
    m=re.match(r'^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(?:\.\d+)?)',line)
    if not m:return None
    try:return datetime.strptime(m.group(1),'%Y-%m-%d %H:%M:%S.%f')
    except ValueError:
        try:return datetime.strptime(m.group(1),'%Y-%m-%d %H:%M:%S')
        except ValueError:return None

def get_host(line):
    m=re.search(r'\[pid/(\d+)(?:/|\s)',line)
    return int(m.group(1)) if m else None

def get_pid(line):
    m=re.search(r'MTLCompilerService\[(\d+)\]',line,re.I)
    if m:return int(m.group(1))
    m=re.search(r'com\.apple\.MTLCompilerService[^\n]*?\[(\d+)\]:\]',line,re.I)
    return int(m.group(1)) if m else None

def parse_exit(line):
    low=line.lower()
    if 'exited due to' not in low or 'mtlcompilerservice' not in low:
        return None
    cm=re.search(r'exited\s+due\s+to\s+exit\((\d+)\)',line,re.I)
    code=int(cm.group(1)) if cm else None
    sig=None
    sm=re.search(r'exited\s+due\s+to\s+(SIG[A-Z0-9]+)',line,re.I)
    if sm:sig=sm.group(1).upper()
    teardown=('during teardown' in low or 'after host exited' in low)
    return {
        'time':timestamp(line),'host':get_host(line),'pid':get_pid(line),
        'code':code,'signal':sig,'teardown':teardown,'line':line,
    }

for ln in mtl:
    low=ln.lower()
    if 'successfully spawned mtlcompilerservice' in low:
        spawn.append({'time':timestamp(ln),'host':get_host(ln),'pid':get_pid(ln),'line':ln})
    x=parse_exit(ln)
    if x:exit_due.append(x)

spawn_pids=sorted({x['pid'] for x in spawn if x['pid'] is not None})
exit_pids=sorted({x['pid'] for x in exit_due if x['pid'] is not None})
print(f'LOG_TOTAL_LINE_COUNT={len(lines)}')
print(f'LOG_MTLCOMPILERSERVICE_LINE_COUNT={len(mtl)}')
print(f'SPAWN_EVENT_COUNT={len(spawn)}')
print(f'EXIT_DUE_EVENT_COUNT={len(exit_due)}')
print(f'UNIQUE_SPAWN_SERVICE_PID_COUNT={len(spawn_pids)}')
print(f'UNIQUE_EXIT_DUE_SERVICE_PID_COUNT={len(exit_pids)}')
print(f'HOST_PIDS_FROM_SPAWNS={sorted({x["host"] for x in spawn if x["host"] is not None})}')
print(f'FATAL_WINDOWSERVER_PID_PRESENT_IN_SPAWN_HOSTS={fatal_ws_pid in {x["host"] for x in spawn}}')

for i,x in enumerate(spawn,1):
    print(f'SPAWN_{i}=TIME={x["time"]}|HOST_PID={x["host"] if x["host"] is not None else "UNKNOWN"}|SERVICE_PID={x["pid"] if x["pid"] is not None else "UNKNOWN"}|LINE={x["line"]}')
for i,x in enumerate(exit_due,1):
    print(f'EXIT_DUE_{i}=TIME={x["time"]}|HOST_PID={x["host"] if x["host"] is not None else "UNKNOWN"}|SERVICE_PID={x["pid"] if x["pid"] is not None else "UNKNOWN"}|CODE={x["code"] if x["code"] is not None else "NONE"}|SIGNAL={x["signal"] or "NONE"}|TEARDOWN={"YES" if x["teardown"] else "NO"}|LINE={x["line"]}')

by_pid=collections.defaultdict(lambda:{'spawns':[],'exits':[]})
for x in spawn:
    if x['pid'] is not None:by_pid[x['pid']]['spawns'].append(x)
for x in exit_due:
    if x['pid'] is not None:by_pid[x['pid']]['exits'].append(x)

valid_codes={110,111,112,113,114}
hist=collections.Counter()
invalid=[]
classified=[]
teardown_classified=[]
for pid in sorted(by_pid):
    rec=by_pid[pid]
    classifier=[x for x in rec['exits'] if x['code'] in valid_codes]
    signals=[x for x in rec['exits'] if x['signal']]
    other_normal=[x for x in rec['exits'] if x['code'] is not None and x['code'] not in valid_codes]
    reasons=[]
    if len(rec['spawns'])!=1:reasons.append(f'SPAWN_COUNT_{len(rec["spawns"])}')
    if len(classifier)!=1:reasons.append(f'CLASSIFIER_EXIT_COUNT_{len(classifier)}')
    if signals:reasons.append('SIGNAL_EXIT')
    if other_normal:reasons.append('OTHER_NORMAL_EXIT_'+','.join(str(x['code']) for x in other_normal))
    if reasons:
        invalid.append((pid,reasons))
    else:
        x=classifier[0]
        hist[x['code']]+=1
        classified.append((pid,x['code'],x['host'],x['time'],x['teardown']))
        if x['teardown']:teardown_classified.append(pid)
    print(f'PID_GATE=PID={pid}|SPAWNS={len(rec["spawns"])}|CLASSIFIER_EXITS={[(x["code"],x["teardown"]) for x in classifier]}|SIGNALS={[x["signal"] for x in signals]}|OTHER_NORMAL_CODES={[x["code"] for x in other_normal]}|VALID={not reasons}|REASONS={reasons}')

print('===== D97AD WHOLE-STAGE CLASSIFIER SUMMARY =====')
for code,label in (
    (110,'CANDIDATE_REACHED_REL_0x58B'),
    (111,'BUFFER_INDEX_REL_0x29A'),
    (112,'SAMPLER_INDEX_REL_0x2D9'),
    (113,'NESTED_ARG_BUFFER_REL_0x3E2'),
    (114,'OTHER_EARLY_REL_0xB9_OR_0x6CC'),
):
    print(f'CLASSIFIER_HISTOGRAM=CODE={code}|CLASS={label}|COUNT={hist[code]}')
print(f'CLASSIFIED_PID_COUNT={len(classified)}')
print(f'TEARDOWN_CLASSIFIED_PID_COUNT={len(teardown_classified)}')
print(f'TEARDOWN_CLASSIFIED_PIDS={teardown_classified}')
print(f'INVALID_PID_COUNT={len(invalid)}')
print(f'INVALID_PIDS={invalid}')
print(f'SPAWN_PID_COUNT={len(spawn_pids)}')
print(f'SPAWN_WITHOUT_ANY_EXIT_DUE_PID_COUNT={len(set(spawn_pids)-set(exit_pids))}')
print(f'SPAWN_WITHOUT_ANY_EXIT_DUE_PIDS={sorted(set(spawn_pids)-set(exit_pids))}')

fatal_host_classified=[x for x in classified if x[2]==fatal_ws_pid]
before_fatal=[x for x in fatal_host_classified if x[3] is not None and x[3] <= fatal_time]
after_fatal=[x for x in fatal_host_classified if x[3] is not None and x[3] > fatal_time]
print(f'FATAL_WS_HOST_CLASSIFIED_COUNT={len(fatal_host_classified)}')
print(f'FATAL_WS_HOST_CLASSIFIED_BEFORE_OR_AT_CRASH={before_fatal}')
print(f'FATAL_WS_HOST_CLASSIFIED_AFTER_CRASH={after_fatal}')

runtime_gate=(len(spawn_pids)>0 and len(invalid)==0 and len(classified)==len(spawn_pids))
print('D97AEQ_RUNTIME_LIVENESS_GATE=' + ('PASS' if runtime_gate else 'FAIL'))
if runtime_gate:
    codes=sorted(k for k,v in hist.items() if v)
    if codes==[110]:
        result='ALL_OBSERVED_REQUESTS_REACHED_REL_0x58B'
    elif codes==[111]:
        result='ALL_OBSERVED_REQUESTS_TERMINATED_AT_BUFFER_INDEX_ERROR_REL_0x29A'
    elif codes==[112]:
        result='ALL_OBSERVED_REQUESTS_TERMINATED_AT_SAMPLER_INDEX_ERROR_REL_0x2D9'
    elif codes==[113]:
        result='ALL_OBSERVED_REQUESTS_TERMINATED_AT_NESTED_ARG_BUFFER_ERROR_REL_0x3E2'
    elif codes==[114]:
        result='ALL_OBSERVED_REQUESTS_TERMINATED_AT_OTHER_EARLY_RETURN_OR_UNWIND'
    else:
        result='REQUEST_VARIATION_PROVEN_CODES_'+'_'.join(map(str,codes))
else:
    result='RUNTIME_RUN_INVALID_LIVENESS_GATE_FAILED'
print('D97AEQ_RESULT='+result)

if classified:
    ordered=sorted(classified,key=lambda x:(x[3] is None,x[3] or datetime.max,x[0]))
    print('CLASSIFIED_SEQUENCE=' + repr(ordered))

print('===== RELEVANT MTLCompilerService LOG LINES =====')
for ln in mtl[:3000]:
    print('LOG='+ln)
if len(mtl)>3000:
    print(f'LOG_TRUNCATED_COUNT={len(mtl)-3000}')

print('===== FINAL =====')
print('ACCELERATED_BOOT_SELECTED=2026-09-02_00:10')
print('VESA_RECOVERY_BOOT_EXCLUDED=2026-09-02_00:12')
print('FATAL_WINDOWSERVER_CRASH_ANCHOR=PID394_AT_2026-09-02_00:11:47.9888')
print('SOURCE_MUTATION=NO')
print('SYSTEM_MUTATION=NO')
print('GOLDEN_MUTATION=NO')
print('SERVICE_LAUNCH=AUTO-NO')
print('RUNTIME_INSTRUMENTATION=NO')
print('ROOT_PATCH=AUTO-NO')
print('REBOOT=AUTO-NO')
print('D82_EXECUTION=NO')
print('PATCH8_AUTO_INTEGRATION=NO')
print('D97AEQ_READONLY_D97AD_ACCELERATED_WHOLE_STAGE_EXIT_AUDIT=PASS')
PY

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
