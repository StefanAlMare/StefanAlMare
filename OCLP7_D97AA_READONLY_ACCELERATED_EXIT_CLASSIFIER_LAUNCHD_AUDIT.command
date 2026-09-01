#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AA_READONLY_ACCELERATED_EXIT_CLASSIFIER_LAUNCHD_AUDIT_REPORT.txt"
LOGFILE="/private/tmp/OCLP7_D97AA_ACCELERATED_EXIT_CLASSIFIER.log"
START="2026-09-01 17:11:30"
END="2026-09-01 17:14:00"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
EXPECTED_SERVICE_SHA="2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c"
EXPECTED_BLOCK="3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b90909090"
BLOCK_OFF=$((0x25C3))
BLOCK_LEN=40

exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AA_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

rm -f "$LOGFILE"

echo "===== OCLP7 D97AA — READ-ONLY ACCELERATED EXIT-CLASSIFIER LAUNCHD AUDIT ====="
echo "PURPOSE=classify_every_observed_D97Z_MTLCompilerService_request_in_the_accelerated_boot_by_launchd_visible_exit_123_124_125"
echo "ACCELERATED_BOOT=2026-09-01_17:12"
echo "VESA_RECOVERY_BOOT=2026-09-01_17:14_EXCLUDED"
echo "CONTENT_WINDOW_START=$START"
echo "CONTENT_WINDOW_END_EXCLUSIVE=$END"
echo "EXIT_123=llvmVersion_3802"
echo "EXIT_124=llvmVersion_32023"
echo "EXIT_125=llvmVersion_other"
echo "EXPECTED_SERVICE_SHA=$EXPECTED_SERVICE_SHA"
echo "EXPECTED_BLOCK_FILEOFF=0x25C3..0x25EB"
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
[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING:$SERVICE"
for t in log shasum xxd last; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
"$PYTHON_BIN" --version 2>&1

VISIBLE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
VISIBLE_BLOCK="$(/usr/bin/xxd -p -s "$BLOCK_OFF" -l "$BLOCK_LEN" "$SERVICE" | /usr/bin/tr -d '\n')"
echo "VISIBLE_SERVICE_SHA=$VISIBLE_SHA"
echo "VISIBLE_D97Z_BLOCK=$VISIBLE_BLOCK"
[[ "$VISIBLE_SHA" == "$EXPECTED_SERVICE_SHA" ]] || fail "VISIBLE_SERVICE_NOT_D97Z:$VISIBLE_SHA"
[[ "$VISIBLE_BLOCK" == "$EXPECTED_BLOCK" ]] || fail "VISIBLE_D97Z_BLOCK_MISMATCH:$VISIBLE_BLOCK"
echo "VISIBLE_D97Z_IDENTITY=PASS"

echo "===== BOOT CHRONOLOGY RECHECK ====="
/usr/bin/last reboot 2>/dev/null | /usr/bin/head -n 8 | /usr/bin/sed 's/^/LAST_REBOOT=/' || true
echo "BOOT_PAIR_CLASSIFICATION=ACCELERATED_17_12__VESA_17_14_EXCLUDED"
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

"$PYTHON_BIN" - "$LOGFILE" <<'PY'
from pathlib import Path
import re, sys

path=Path(sys.argv[1])
lines=path.read_text(errors='replace').splitlines()
mtl=[ln for ln in lines if re.search(r'MTLCompilerService',ln,re.I)]
spawn=[]; exits=[]; service_activity=[]

code_patterns=(
    re.compile(r'exited\s+due\s+to\s+exit\((\d+)\)',re.I),
    re.compile(r'exited\s+with\s+(?:exit\s+)?(?:code|status)\s*[=: ]\s*(\d+)',re.I),
    re.compile(r'exit(?:ed)?\s*\((\d+)\)',re.I),
    re.compile(r'\bexit[_ -]?code\b\s*[=: ]\s*(\d+)',re.I),
)

def get_code(line):
    for rx in code_patterns:
        m=rx.search(line)
        if m:
            try:return int(m.group(1))
            except:return None
    return None

def get_host(line):
    m=re.search(r'\[pid/(\d+)(?:/|\s)',line)
    return int(m.group(1)) if m else None

def get_service_pid(line):
    m=re.search(r'Successfully spawned MTLCompilerService\[(\d+)\]',line,re.I)
    if m:return int(m.group(1))
    m=re.search(r'com\.apple\.MTLCompilerService[^\n]*?\[(\d+)\]:\]',line,re.I)
    if m:return int(m.group(1))
    m=re.search(r'MTLCompilerService\[(\d+)\]',line,re.I)
    return int(m.group(1)) if m else None

for ln in mtl:
    low=ln.lower()
    if 'successfully spawned mtlcompilerservice' in low:
        spawn.append((get_host(ln),get_service_pid(ln),ln))
    if 'mtlcompilerservice[' in low or 'com.apple.mtlcompilerservice' in low:
        service_activity.append(ln)
    if 'exited' in low and ('mtlcompilerservice' in low):
        code=get_code(ln)
        signal=None
        for s in ('SIGILL','SIGSEGV','SIGABRT','SIGKILL','SIGBUS'):
            if s.lower() in low:signal=s;break
        teardown='during teardown' in low or 'after host exited' in low
        exits.append(dict(host=get_host(ln),pid=get_service_pid(ln),code=code,signal=signal,teardown=teardown,line=ln))

print(f'LOG_TOTAL_LINE_COUNT={len(lines)}')
print(f'LOG_MTLCOMPILERSERVICE_LINE_COUNT={len(mtl)}')
print(f'SPAWN_EVENT_COUNT={len(spawn)}')
print(f'EXIT_EVENT_COUNT={len(exits)}')
print(f'UNIQUE_SPAWN_SERVICE_PID_COUNT={len({x[1] for x in spawn if x[1] is not None})}')
print(f'UNIQUE_EXIT_SERVICE_PID_COUNT={len({x["pid"] for x in exits if x["pid"] is not None})}')
print(f'HOST_WINDOWSERVER_PIDS={sorted({x[0] for x in spawn if x[0] is not None})}')

for i,(host,pid,ln) in enumerate(spawn,1):
    print(f'SPAWN_{i}=HOST_PID={host if host is not None else "UNKNOWN"}|SERVICE_PID={pid if pid is not None else "UNKNOWN"}|LINE={ln}')
for i,x in enumerate(exits,1):
    print(f'EXIT_{i}=HOST_PID={x["host"] if x["host"] is not None else "UNKNOWN"}|SERVICE_PID={x["pid"] if x["pid"] is not None else "UNKNOWN"}|CODE={x["code"] if x["code"] is not None else "UNKNOWN"}|SIGNAL={x["signal"] or "NONE"}|TEARDOWN={"YES" if x["teardown"] else "NO"}|LINE={x["line"]}')

primary=[x for x in exits if not x['teardown']]
teardown=[x for x in exits if x['teardown']]
primary_codes=[x['code'] for x in primary if x['code'] is not None]
teardown_codes=[x['code'] for x in teardown if x['code'] is not None]
known_primary=[x for x in primary_codes if x in (123,124,125)]
known_teardown=[x for x in teardown_codes if x in (123,124,125)]
unknown_primary=[x for x in primary if x['code'] not in (123,124,125)]
signal_primary=[x for x in primary if x['signal']]

print('===== CLASSIFIER EXIT SUMMARY =====')
for code,label in ((123,'LLVMVERSION_3802'),(124,'LLVMVERSION_32023'),(125,'LLVMVERSION_OTHER')):
    print(f'PRIMARY_EXIT_HISTOGRAM=CODE={code}|CLASS={label}|COUNT={known_primary.count(code)}')
    print(f'TEARDOWN_EXIT_HISTOGRAM=CODE={code}|CLASS={label}|COUNT={known_teardown.count(code)}')
print(f'PRIMARY_CLASSIFIER_EXIT_COUNT={len(known_primary)}')
print(f'TEARDOWN_CLASSIFIER_EXIT_COUNT={len(known_teardown)}')
print(f'PRIMARY_UNKNOWN_OR_SIGNAL_EXIT_COUNT={len(unknown_primary)}')
print(f'PRIMARY_SIGNAL_EXIT_COUNT={len(signal_primary)}')
print(f'SPAWN_WITHOUT_RECORDED_EXIT_PID_COUNT={len({x[1] for x in spawn if x[1] is not None}-{x["pid"] for x in exits if x["pid"] is not None})}')

vals=set(known_primary)
if known_primary:
    if vals=={123}:
        result='RUNTIME_LLVMVERSION_3802_PROVEN_ALL_PRIMARY_OBSERVED_REQUESTS'
    elif vals=={124}:
        result='RUNTIME_LLVMVERSION_32023_PROVEN_ALL_PRIMARY_OBSERVED_REQUESTS'
    elif vals=={125}:
        result='RUNTIME_LLVMVERSION_OTHER_PROVEN_ALL_PRIMARY_OBSERVED_REQUESTS'
    else:
        result='RUNTIME_LLVMVERSION_REQUEST_VARIATION_PROVEN_PRIMARY_CODES_'+('_'.join(map(str,sorted(vals))))
    coverage='PRIMARY_LAUNCHD_EXIT_CLASSIFIER_CHANNEL_POSITIVE'
elif known_teardown:
    result='ONLY_TEARDOWN_CLASSIFIER_CODES_OBSERVED_CAUSAL_CLASSIFICATION_DEFERRED'
    coverage='TEARDOWN_ONLY_CHANNEL_POSITIVE'
elif signal_primary:
    result='NO_NORMAL_CLASSIFIER_EXIT_CODE_PRIMARY_SIGNAL_TERMINATION_OBSERVED'
    coverage='CLASSIFIER_NORMAL_EXIT_CHANNEL_NEGATIVE_SIGNAL_CHANNEL_POSITIVE'
elif exits:
    result='EXIT_EVENTS_PRESENT_BUT_NO_123_124_125_CODE_PARSED'
    coverage='CLASSIFIER_EXIT_PARSE_OR_EXECUTION_INCONCLUSIVE'
else:
    result='NO_MTLCOMPILERSERVICE_EXIT_EVENT_IN_ACCELERATED_WINDOW'
    coverage='LAUNCHD_EXIT_CHANNEL_NEGATIVE'

print('D97AA_RESULT='+result)
print('D97AA_CHANNEL_CLASSIFICATION='+coverage)
print('D97Z_VISIBLE_SERVICE_RUNTIME_EXECUTION=' + ('PROVEN_BY_CLASSIFIER_EXIT' if known_primary else 'NOT_PROVEN_BY_PRIMARY_CLASSIFIER_EXIT'))
print('EXACT_FATAL_REQUEST_CAUSALITY=' + ('UNIVERSAL_OBSERVED_REQUEST_CLASSIFICATION' if known_primary and len(vals)==1 and not unknown_primary else 'REQUIRES_ASSISTANT_AUDIT'))

print('===== RELEVANT LOG LINES =====')
for ln in mtl[:2000]:print('LOG='+ln)
if len(mtl)>2000:print(f'LOG_TRUNCATED_COUNT={len(mtl)-2000}')

print('===== FINAL =====')
print('ACCELERATED_BOOT_SELECTED=2026-09-01_17:12')
print('VESA_RECOVERY_BOOT_EXCLUDED=2026-09-01_17:14')
print('SYSTEM_MUTATION=NO')
print('SERVICE_LAUNCH=AUTO-NO')
print('ROOT_PATCH=AUTO-NO')
print('REBOOT=AUTO-NO')
print('D82_EXECUTION=NO')
print('PATCH8_AUTO_INTEGRATION=NO')
print('D97AA_READONLY_ACCELERATED_EXIT_CLASSIFIER_LAUNCHD_AUDIT=PASS')
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
