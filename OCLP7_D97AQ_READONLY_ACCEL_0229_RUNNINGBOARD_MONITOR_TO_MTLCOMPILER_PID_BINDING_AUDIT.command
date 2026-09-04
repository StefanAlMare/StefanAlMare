#!/bin/zsh -f
set -euo pipefail

START="2026-09-04 02:29:00"
END="2026-09-04 02:31:59"
TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"
EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
EXPECTED_RECORD_COUNT="79"
OUT="$HOME/Desktop/OCLP7_D97AQ_ACCEL_0229_RUNNINGBOARD_MONITOR_TO_MTLCOMPILER_PID_BINDING_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AQ.XXXXXX)"
MTL_JSON="$TMP/mtl.json"
RBS_JSON="$TMP/rbs.json"
MTL_ERR="$TMP/mtl.err"
RBS_ERR="$TMP/rbs.err"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AQ.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AQ_AUDIT=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "SERVICE_LAUNCH=AUTO-NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "SNAPSHOT_MUTATION=NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"
[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail "TARGET_MISSING_NOT_REGULAR_OR_SYMLINK"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AQ — READ-ONLY 02:29 RUNNINGBOARD MONITOR -> MTLCOMPILER PID BINDING AUDIT ====="
echo "HISTORICAL_ACCEL_WINDOW_START=$START"
echo "HISTORICAL_ACCEL_WINDOW_END=$END"
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "EXPECTED_EXACT_32023_RECORD_COUNT=$EXPECTED_RECORD_COUNT"
echo "CURRENT_BOOT_IDENTITY_REQUIRED=NO"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "HISTORICAL_CHRONOLOGY=02:29_ACCELERATED_D97AM__02:32_VESA_RECOVERY_PERSISTED"

ACTUAL_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$TARGET")"
echo "TARGET_BYTES=$ACTUAL_BYTES"
echo "TARGET_SHA256=$ACTUAL_SHA"
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail "TARGET_SHA_MISMATCH_NOT_EXACT_D97AM_NATURAL_POSTIMAGE"
echo "D97AQ_TARGET_SHA_IDENTITY=PASS"

/usr/bin/log show \
    --start "$START" \
    --end "$END" \
    --timezone local \
    --style json \
    --info \
    --debug \
    --predicate 'process == "MTLCompilerService"' \
    > "$MTL_JSON" 2> "$MTL_ERR" || true

/usr/bin/log show \
    --start "$START" \
    --end "$END" \
    --timezone local \
    --style json \
    --info \
    --debug \
    --predicate 'process == "runningboardd"' \
    > "$RBS_JSON" 2> "$RBS_ERR" || true

echo "MTL_JSON_BYTES=$(/usr/bin/stat -f '%z' "$MTL_JSON" 2>/dev/null || echo 0)"
echo "RBS_JSON_BYTES=$(/usr/bin/stat -f '%z' "$RBS_JSON" 2>/dev/null || echo 0)"
echo "MTL_LOG_STDERR_BEGIN"
/bin/cat "$MTL_ERR" 2>/dev/null || true
echo "MTL_LOG_STDERR_END"
echo "RBS_LOG_STDERR_BEGIN"
/bin/cat "$RBS_ERR" 2>/dev/null || true
echo "RBS_LOG_STDERR_END"
echo

"$PYTHON" - "$MTL_JSON" "$RBS_JSON" "$EXPECTED_UUID" "$EXPECTED_RECORD_COUNT" <<'PY'
from __future__ import annotations

import collections
import json
import re
import sys
from pathlib import Path

mtl_path = Path(sys.argv[1])
rbs_path = Path(sys.argv[2])
expected_uuid = sys.argv[3].upper()
expected_record_count = int(sys.argv[4])

UUID_RE = re.compile(r'\b[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\b')
EXIT_MON_RE = re.compile(r'(?P<uuid>[0-9A-Fa-f-]{36})\s+monitor:\s+got an update with info exited,\s*(?P<detail>.*)', re.I)


def parse_json_stream(path: Path):
    raw = path.read_text(encoding='utf-8', errors='replace') if path.exists() else ''
    dec = json.JSONDecoder()
    out = []
    i = 0
    n = len(raw)
    while i < n:
        while i < n and (raw[i].isspace() or raw[i] == ','):
            i += 1
        if i >= n:
            break
        if raw[i] not in '[{':
            p1 = raw.find('{', i)
            p2 = raw.find('[', i)
            ps = [p for p in (p1,p2) if p >= 0]
            if not ps:
                break
            i = min(ps)
        try:
            obj, end = dec.raw_decode(raw, i)
        except json.JSONDecodeError:
            i += 1
            continue
        if isinstance(obj, list):
            out.extend(x for x in obj if isinstance(x, dict))
        elif isinstance(obj, dict):
            out.append(obj)
        i = end
    return out


def val(rec, *names):
    for n in names:
        if n in rec and rec[n] is not None:
            return rec[n]
    return None


def clean(v):
    if v is None:
        return 'MISSING'
    if isinstance(v, (dict,list)):
        try:
            return json.dumps(v, sort_keys=True, separators=(',',':'), ensure_ascii=False).replace('\n','\\n').replace('\r','\\r')
        except Exception:
            pass
    return str(v).replace('\n','\\n').replace('\r','\\r')


def pid_of(rec):
    p = val(rec,'processID','processIdentifier')
    try:
        return int(p)
    except Exception:
        return -1

mtl = parse_json_stream(mtl_path)
rbs = parse_json_stream(rbs_path)
print('MTL_JSON_RECORDS='+str(len(mtl)))
print('RBS_JSON_RECORDS='+str(len(rbs)))

# Exact natural-UUID MTL sender cohort -> PID set.
exact=[]
for r in mtl:
    path=clean(val(r,'senderImagePath'))
    uuid=clean(val(r,'senderImageUUID')).upper()
    if path.endswith('/MTLCompiler.framework/Versions/32023/MTLCompiler') and uuid==expected_uuid:
        exact.append(r)
exact_pids=sorted({pid_of(r) for r in exact if pid_of(r)>=0})
print('EXACT_NATURAL_32023_RECORD_COUNT='+str(len(exact)))
print('EXACT_NATURAL_32023_PID_COUNT='+str(len(exact_pids)))
print('EXACT_NATURAL_32023_PIDS='+','.join(str(x) for x in exact_pids))
if len(exact)==expected_record_count:
    print('D97AQ_EXPECTED_RECORD_COUNT_MATCH=PASS')
else:
    print(f'D97AQ_EXPECTED_RECORD_COUNT_MATCH=NO|EXPECTED={expected_record_count}|ACTUAL={len(exact)}')

# Index all RunningBoard records by any UUID text appearing in the event message.
groups=collections.defaultdict(list)
for r in rbs:
    msg=clean(val(r,'eventMessage','message'))
    for u in set(x.upper() for x in UUID_RE.findall(msg)):
        groups[u].append(r)

# Identify every monitor-exit record, then discard directly obvious non-MTL families only after printing.
exits=[]
for r in rbs:
    msg=clean(val(r,'eventMessage','message'))
    m=EXIT_MON_RE.search(msg)
    if m:
        exits.append((m.group('uuid').upper(), m.group('detail'), r))

print('RUNNINGBOARD_MONITOR_EXIT_RECORD_COUNT='+str(len(exits)))
for u,detail,r in exits:
    print(f'MONITOR_EXIT|UUID={u}|TS={clean(val(r,"timestamp"))}|DETAIL={detail}')

# Candidate exact-target PID patterns. Only text that itself mentions MTLCompilerService may bind a PID.
pid_patterns=[
    re.compile(r'MTLCompilerService\[(\d+)\]',re.I),
    re.compile(r'MTLCompilerService[^\n\r]{0,240}?:(\d+)\]',re.I),
    re.compile(r'MTLCompilerService[^\n\r]{0,240}?\bpid[ =:]+(\d+)\b',re.I),
    re.compile(r'MTLCompilerService[^\n\r]{0,240}?\bprocess\s*\(?\s*(\d+)\s*\)?',re.I),
]

print('===== MONITOR UUID DIRECT BINDING AUDIT =====')
bound=[]
unbound=[]
for u,detail,exit_rec in exits:
    grecs=groups.get(u,[])
    direct_service=[]
    direct_pids=set()
    print(f'MONITOR_GROUP_BEGIN|UUID={u}|EXIT_DETAIL={detail}|GROUP_RECORD_COUNT={len(grecs)}')
    for r in sorted(grecs,key=lambda x:clean(val(x,'timestamp'))):
        msg=clean(val(r,'eventMessage','message'))
        proc=clean(val(r,'process','processImagePath'))
        logger_pid=pid_of(r)
        print(f'MONITOR_GROUP_RECORD|UUID={u}|TS={clean(val(r,"timestamp"))}|LOGGER={proc}|LOGGER_PID={logger_pid}|MSG={msg}')
        if 'MTLCompilerService' in msg:
            direct_service.append(msg)
            for rx in pid_patterns:
                for m in rx.finditer(msg):
                    try:
                        direct_pids.add(int(m.group(1)))
                    except Exception:
                        pass
    exact_direct=sorted(p for p in direct_pids if p in exact_pids)
    noncohort_direct=sorted(p for p in direct_pids if p not in exact_pids)
    print(f'MONITOR_BINDING_SUMMARY|UUID={u}|DIRECT_MTLCOMPILERSERVICE_TEXT_COUNT={len(direct_service)}|DIRECT_PID_CANDIDATES='+(','.join(map(str,sorted(direct_pids))) if direct_pids else 'NONE')+'|EXACT_COHORT_DIRECT_PIDS='+(','.join(map(str,exact_direct)) if exact_direct else 'NONE')+'|NONCOHORT_DIRECT_PIDS='+(','.join(map(str,noncohort_direct)) if noncohort_direct else 'NONE'))
    if len(exact_direct)==1 and direct_service:
        p=exact_direct[0]
        bound.append((u,p,detail))
        print(f'MONITOR_BINDING_CLASSIFICATION|UUID={u}|STATUS=DIRECT_BOUND_TO_EXACT_NATURAL_MTLCOMPILERSERVICE_PID|PID={p}|DETAIL={detail}')
    else:
        unbound.append((u,detail,len(direct_service),exact_direct,sorted(direct_pids)))
        print(f'MONITOR_BINDING_CLASSIFICATION|UUID={u}|STATUS=UNBOUND_OR_AMBIGUOUS|DETAIL={detail}')
    print(f'MONITOR_GROUP_END|UUID={u}')

print('===== DIRECTLY BOUND EXIT SUMMARY =====')
print('DIRECT_BOUND_MONITOR_EXIT_COUNT='+str(len(bound)))
for u,p,detail in bound:
    print(f'DIRECT_BOUND_EXIT|UUID={u}|PID={p}|DETAIL={detail}')
print('UNBOUND_OR_AMBIGUOUS_MONITOR_EXIT_COUNT='+str(len(unbound)))
for u,detail,nsvc,exactp,allp in unbound:
    print(f'UNBOUND_EXIT|UUID={u}|DETAIL={detail}|DIRECT_MTLCOMPILERSERVICE_TEXT_COUNT={nsvc}|EXACT_COHORT_DIRECT_PIDS='+(','.join(map(str,exactp)) if exactp else 'NONE')+'|ALL_DIRECT_PID_CANDIDATES='+(','.join(map(str,allp)) if allp else 'NONE'))

# Produce only directly supported termination classification.
if bound:
    print('D97AQ_MTLCOMPILERSERVICE_TERMINATION_BINDING=DIRECT_BINDINGS_PRESENT')
    details=collections.Counter(d for _,_,d in bound)
    for d,c in sorted(details.items()):
        print(f'DIRECT_BOUND_EXIT_DETAIL_COUNT|COUNT={c}|DETAIL={d}')
else:
    print('D97AQ_MTLCOMPILERSERVICE_TERMINATION_BINDING=NO_DIRECT_MONITOR_TO_EXACT_PID_BINDING_RECOVERED')

# Additional direct service-name records independent of monitor UUID, for raw audit only.
print('===== RUNNINGBOARD DIRECT MTLCOMPILERSERVICE RECORDS =====')
svc_records=[]
for r in rbs:
    msg=clean(val(r,'eventMessage','message'))
    if 'MTLCompilerService' in msg:
        svc_records.append(r)
print('RBS_DIRECT_MTLCOMPILERSERVICE_RECORD_COUNT='+str(len(svc_records)))
for r in svc_records:
    print(f'RBS_MTLCOMPILER_RECORD|TS={clean(val(r,"timestamp"))}|LOGGER_PID={pid_of(r)}|MSG={clean(val(r,"eventMessage","message"))}')

print('===== EVIDENCE BOUNDARY =====')
print('D97AQ_MONITOR_UUID_TEMPORAL_PROXIMITY_NOT_USED_AS_IDENTITY=YES')
print('D97AQ_ONLY_SAME_UUID_DIRECT_SERVICE_AND_EXACT_PID_TEXT_CAN_PROVE_BINDING=YES')
print('D97AQ_AUDIT=COMPLETE')
PY

echo
echo "===== FINAL MUTATION LEDGER ====="
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "SNAPSHOT_MUTATION=NO"
echo "REBOOT=AUTO-NO"
echo "D97AQ_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
