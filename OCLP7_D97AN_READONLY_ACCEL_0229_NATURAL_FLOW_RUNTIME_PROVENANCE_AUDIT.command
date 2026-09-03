#!/bin/zsh -f
set -euo pipefail

START="2026-09-04 02:29:00"
END="2026-09-04 02:31:59"
EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
OLD_D5CE_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
OLD_A4F_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
OUT="$HOME/Desktop/OCLP7_D97AN_ACCEL_0229_NATURAL_FLOW_RUNTIME_PROVENANCE_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AN_RUNTIME_AUDIT.XXXXXX)"
MTL_JSON="$TMP/mtl.json"
MTL_ERR="$TMP/mtl.err"
LAUNCHD_JSON="$TMP/launchd.json"
LAUNCHD_ERR="$TMP/launchd.err"
WS_JSON="$TMP/windowserver.json"
WS_ERR="$TMP/windowserver.err"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AN_RUNTIME_AUDIT.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AN_RUNTIME_AUDIT=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "SNAPSHOT_MUTATION=NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AN — READ-ONLY D97AM 02:29 ACCELERATED NATURAL-FLOW RUNTIME PROVENANCE AUDIT ====="
echo "ACCEL_WINDOW_START=$START"
echo "ACCEL_WINDOW_END=$END"
echo "EXPECTED_NATURAL_FLOW_UUID=$EXPECTED_UUID"
echo "OLD_D5CE_UUID=$OLD_D5CE_UUID"
echo "OLD_A4F_UUID=$OLD_A4F_UUID"
echo "CHRONOLOGY_CONTRACT=02:29_ACCELERATED_D97AM__02:32_VESA_RECOVERY"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

echo "===== CURRENT / HISTORICAL BOOT CHRONOLOGY ====="
BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "LAST_REBOOT_HEAD_BEGIN"
/usr/bin/last reboot 2>/dev/null | /usr/bin/head -n 8 || true
echo "LAST_REBOOT_HEAD_END"
echo

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
    --predicate 'process == "launchd"' \
    > "$LAUNCHD_JSON" 2> "$LAUNCHD_ERR" || true

/usr/bin/log show \
    --start "$START" \
    --end "$END" \
    --timezone local \
    --style json \
    --info \
    --debug \
    --predicate 'process == "WindowServer"' \
    > "$WS_JSON" 2> "$WS_ERR" || true

for pair in "MTL:$MTL_JSON:$MTL_ERR" "LAUNCHD:$LAUNCHD_JSON:$LAUNCHD_ERR" "WINDOWSERVER:$WS_JSON:$WS_ERR"; do
    label="${pair%%:*}"
    rest="${pair#*:}"
    json_path="${rest%%:*}"
    err_path="${rest#*:}"
    bytes="$(/usr/bin/stat -f '%z' "$json_path" 2>/dev/null || echo 0)"
    echo "${label}_JSON_BYTES=$bytes"
    echo "${label}_LOG_STDERR_BEGIN"
    /bin/cat "$err_path" 2>/dev/null || true
    echo "${label}_LOG_STDERR_END"
done

echo

"$PYTHON" - "$MTL_JSON" "$LAUNCHD_JSON" "$WS_JSON" "$EXPECTED_UUID" "$OLD_D5CE_UUID" "$OLD_A4F_UUID" <<'PY'
from __future__ import annotations

import collections
import json
import re
import sys
from pathlib import Path

mtl_path = Path(sys.argv[1])
launchd_path = Path(sys.argv[2])
ws_path = Path(sys.argv[3])
expected_uuid = sys.argv[4].upper()
old_d5ce = sys.argv[5].upper()
old_a4f = sys.argv[6].upper()
expected_sender_path = "/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"


def parse_json_stream(path: Path):
    raw = path.read_text(encoding="utf-8", errors="replace") if path.exists() else ""
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
            candidates = [p for p in (p1, p2) if p >= 0]
            if not candidates:
                break
            i = min(candidates)
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
    for name in names:
        if name in rec and rec[name] is not None:
            return rec[name]
    return None


def clean(v):
    if v is None:
        return "MISSING"
    if isinstance(v, (dict, list)):
        try:
            return json.dumps(v, sort_keys=True, separators=(",", ":"), ensure_ascii=False).replace("\n", "\\n").replace("\r", "\\r")
        except Exception:
            pass
    return str(v).replace("\n", "\\n").replace("\r", "\\r")


def norm_uuid(v):
    return "MISSING" if v is None else str(v).upper()


def pid_of(rec):
    p = val(rec, "processID", "processIdentifier")
    try:
        return int(p)
    except Exception:
        return -1


def late_kind(msg: str):
    low = msg.lower()
    if "constant buffers binding are supported in the simulator" in low:
        return "CONSTANT_BUFFERS"
    if "buffers are supported in the simulator" in low:
        return "BUFFERS"
    if "sampelrs are supported in the simulator" in low or "samplers are supported in the simulator" in low:
        return "SAMPLERS"
    if "textures are supported in the simulator" in low:
        return "TEXTURES"
    if "fragment shader has" in low and "interpolated inputs" in low and "supported in the simulator" in low:
        return "INTERPOLATED_INPUTS"
    return None


mtl = parse_json_stream(mtl_path)
launchd = parse_json_stream(launchd_path)
ws = parse_json_stream(ws_path)
print("MTL_JSON_RECORDS=" + str(len(mtl)))
print("LAUNCHD_JSON_RECORDS=" + str(len(launchd)))
print("WINDOWSERVER_JSON_RECORDS=" + str(len(ws)))

pids = sorted({pid_of(r) for r in mtl if pid_of(r) >= 0})
print("MTL_PROCESS_PID_COUNT=" + str(len(pids)))
print("MTL_PROCESS_PIDS=" + (",".join(map(str, pids)) if pids else "NONE"))

all_sender = collections.Counter()
mtl_sender_records = []
late_records = []
late_kind_counts = collections.Counter()
per_pid_late = collections.defaultdict(collections.Counter)
per_pid_mtl_sender = collections.Counter()

for r in mtl:
    pid = pid_of(r)
    ts = clean(val(r, "timestamp"))
    msg = clean(val(r, "eventMessage", "message"))
    sip = clean(val(r, "senderImagePath"))
    siu = norm_uuid(val(r, "senderImageUUID"))
    pip = clean(val(r, "processImagePath"))
    piu = norm_uuid(val(r, "processImageUUID"))
    spc = clean(val(r, "senderProgramCounter"))
    bt = clean(val(r, "backtrace"))
    all_sender[(sip, siu)] += 1
    is_mtl_sender = sip == expected_sender_path or sip.endswith("/MTLCompiler.framework/Versions/32023/MTLCompiler")
    if is_mtl_sender:
        mtl_sender_records.append((ts, pid, sip, siu, pip, piu, spc, bt, msg))
        if pid >= 0:
            per_pid_mtl_sender[pid] += 1
    kind = late_kind(msg)
    if kind:
        late_records.append((kind, ts, pid, sip, siu, pip, piu, spc, bt, msg))
        late_kind_counts[kind] += 1
        if pid >= 0:
            per_pid_late[pid][kind] += 1

print("===== MTL SENDER DISTRIBUTION ALL =====")
for (path, uuid), count in sorted(all_sender.items(), key=lambda x: (-x[1], x[0][0], x[0][1])):
    print(f"ALL_SENDER_COUNT={count}|PATH={path}|UUID={uuid}")

print("===== EXACT 32023 MTLCompiler SENDER RECORDS =====")
print("MTLCOMPILER_32023_SENDER_RECORD_COUNT=" + str(len(mtl_sender_records)))
for row in mtl_sender_records:
    ts, pid, sip, siu, pip, piu, spc, bt, msg = row
    print(f"MTLCOMPILER_SENDER_RECORD|TS={ts}|PID={pid}|SENDER_PATH={sip}|SENDER_UUID={siu}|PROCESS_PATH={pip}|PROCESS_UUID={piu}|SPC={spc}|BACKTRACE={bt}|MSG={msg}")

sender_uuids = [x[3] for x in mtl_sender_records]
print("EXPECTED_UUID_MTLCOMPILER_SENDER_MATCHES=" + str(sum(u == expected_uuid for u in sender_uuids)))
print("OLD_D5CE_UUID_MTLCOMPILER_SENDER_MATCHES=" + str(sum(u == old_d5ce for u in sender_uuids)))
print("OLD_A4F_UUID_MTLCOMPILER_SENDER_MATCHES=" + str(sum(u == old_a4f for u in sender_uuids)))

if mtl_sender_records and all(u == expected_uuid for u in sender_uuids):
    print("D97AN_RUNTIME_32023_SENDER_PROVENANCE=PROVEN_EXPECTED_NATURAL_FLOW_UUID")
elif not mtl_sender_records:
    print("D97AN_RUNTIME_32023_SENDER_PROVENANCE=INCONCLUSIVE_NO_32023_SENDER_RECORDS")
else:
    print("D97AN_RUNTIME_32023_SENDER_PROVENANCE=INCONCLUSIVE_MIXED_OR_UNEXPECTED_UUID")

print("===== FIVE LATE SIMULATOR-DIAGNOSTIC FAMILY =====")
print("LATE_DIAGNOSTIC_RECORD_COUNT=" + str(len(late_records)))
for kind in ("BUFFERS", "SAMPLERS", "TEXTURES", "CONSTANT_BUFFERS", "INTERPOLATED_INPUTS"):
    print(f"LATE_DIAGNOSTIC_KIND_COUNT|KIND={kind}|COUNT={late_kind_counts[kind]}")
for row in late_records:
    kind, ts, pid, sip, siu, pip, piu, spc, bt, msg = row
    print(f"LATE_DIAG_RECORD|KIND={kind}|TS={ts}|PID={pid}|SENDER_PATH={sip}|SENDER_UUID={siu}|PROCESS_PATH={pip}|PROCESS_UUID={piu}|SPC={spc}|BACKTRACE={bt}|MSG={msg}")

late_uuids = [x[4] for x in late_records]
late_expected_path = [x for x in late_records if x[3] == expected_sender_path or x[3].endswith("/MTLCompiler.framework/Versions/32023/MTLCompiler")]
print("EXPECTED_UUID_LATE_DIAG_MATCHES=" + str(sum(u == expected_uuid for u in late_uuids)))
print("OLD_D5CE_UUID_LATE_DIAG_MATCHES=" + str(sum(u == old_d5ce for u in late_uuids)))
print("OLD_A4F_UUID_LATE_DIAG_MATCHES=" + str(sum(u == old_a4f for u in late_uuids)))
print("EXPECTED_32023_PATH_LATE_DIAG_MATCHES=" + str(len(late_expected_path)))

if late_records and len(late_expected_path) == len(late_records) and all(u == expected_uuid for u in late_uuids):
    print("D97AN_NATURAL_FLOW_LATE_DIAGNOSTIC_REACHABILITY=PROVEN_RUNTIME_EXPECTED_UUID")
elif not late_records:
    print("D97AN_NATURAL_FLOW_LATE_DIAGNOSTIC_REACHABILITY=NO_MATCH_OBSERVED_NOT_HARD_NEGATIVE")
else:
    print("D97AN_NATURAL_FLOW_LATE_DIAGNOSTIC_REACHABILITY=INCONCLUSIVE_MIXED_OR_UNEXPECTED_PROVENANCE")

print("===== PER-PID NATURAL-FLOW SUMMARY =====")
for pid in pids:
    kinds = per_pid_late.get(pid, {})
    kind_text = ",".join(f"{k}:{kinds[k]}" for k in sorted(kinds)) if kinds else "NONE"
    print(f"PID_RUNTIME_SUMMARY|PID={pid}|MTLCOMPILER_SENDER_RECORDS={per_pid_mtl_sender.get(pid,0)}|LATE_KINDS={kind_text}")

print("===== LAUNCHD MTLCompilerService LIFECYCLE =====")
launch_records = []
spawn_pids = set(pids)
for r in launchd:
    msg = clean(val(r, "eventMessage", "message"))
    ts = clean(val(r, "timestamp"))
    if "MTLCompilerService" in msg:
        launch_records.append((ts, msg))
        for pat in (
            r"MTLCompilerService\[(\d+)\]",
            r"MTLCompilerService[^\[]*\[(\d+)\]",
            r"MTLCompilerService[^0-9]{0,80}(\d{2,7})(?!\d)",
        ):
            for m in re.finditer(pat, msg):
                try:
                    spawn_pids.add(int(m.group(1)))
                except Exception:
                    pass

print("LAUNCHD_MTL_RECORD_COUNT=" + str(len(launch_records)))
for ts, msg in launch_records:
    print(f"LAUNCHD_MTL|TS={ts}|MSG={msg}")

keywords = re.compile(r"exit|exited|signal|sig[a-z0-9]+|terminat|status|code|crash|inactive|spawn|launch", re.I)
for pid in sorted(spawn_pids):
    recs = []
    for ts, msg in launch_records:
        if keywords.search(msg) and re.search(rf"(?<!\d){pid}(?!\d)", msg):
            recs.append((ts, msg))
    print(f"PID_LIFECYCLE={pid}|RECORDS={len(recs)}")
    for ts, msg in recs:
        print(f"PID_LIFECYCLE_RECORD|PID={pid}|TS={ts}|MSG={msg}")

exit_counts = collections.Counter()
for ts, msg in launch_records:
    for code in (1, 110, 111, 112, 113, 114):
        patterns = [
            rf"exit\s*\(?\s*{code}\s*\)?",
            rf"exited[^0-9]{{0,30}}{code}(?!\d)",
            rf"(?:status|code)[^0-9]{{0,30}}{code}(?!\d)",
        ]
        if any(re.search(p, msg, re.I) for p in patterns):
            exit_counts[code] += 1
print("LAUNCHD_EXIT_TEXT_COUNTS=" + ";".join(f"{c}:{exit_counts[c]}" for c in (1,110,111,112,113,114)))
print("D97AN_ARTIFICIAL_110_114_TEXT_EVIDENCE_TOTAL=" + str(sum(exit_counts[c] for c in (110,111,112,113,114))))

print("===== WINDOWSERVER ACCELERATED-WINDOW CORRELATION =====")
ws_xpc = 0
ws_compile = 0
ws_relevant = []
for r in ws:
    msg = clean(val(r, "eventMessage", "message"))
    ts = clean(val(r, "timestamp"))
    low = msg.lower()
    if "xpc_error_connection_interrupted" in low:
        ws_xpc += 1
    if "compilation failed" in low:
        ws_compile += 1
    if any(x in low for x in ("xpc_error_connection_interrupted", "compilation failed", "mtlcompiler", "metal", "pipeline")):
        ws_relevant.append((ts, pid_of(r), msg))
print("WINDOWSERVER_XPC_INTERRUPTED_TEXT_COUNT=" + str(ws_xpc))
print("WINDOWSERVER_COMPILATION_FAILED_TEXT_COUNT=" + str(ws_compile))
print("WINDOWSERVER_RELEVANT_RECORD_COUNT=" + str(len(ws_relevant)))
for ts, pid, msg in ws_relevant:
    print(f"WINDOWSERVER_RELEVANT|TS={ts}|PID={pid}|MSG={msg}")

print("===== RELEVANT JSON FIELD INVENTORY =====")
keys = sorted({k for r in mtl for k in r.keys() if any(t in k.lower() for t in ("image", "uuid", "process", "sender", "backtrace", "programcounter"))})
print("MTL_RELEVANT_JSON_KEYS=" + ",".join(keys))

print("===== FINAL DATA CLASSIFICATION =====")
print("D97AM_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI")
print("D97AN_RUNTIME_AUDIT=COMPLETE")
PY

echo
echo "===== FINAL MUTATION LEDGER ====="
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "SNAPSHOT_MUTATION=NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
