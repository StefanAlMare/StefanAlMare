#!/bin/zsh -f
set -euo pipefail

START="2026-09-03 23:15:30"
END="2026-09-03 23:17:52"
EXPECTED_CURRENT_VESA_BOOT_SEC="1788466673"
EXPECTED_STAMP_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
OLD_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
OUT="$HOME/Desktop/OCLP7_D97AH_ACCEL_PROVENANCE_EXIT_JSON_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_JSON_AUDIT.XXXXXX)"
MTL_JSON="$TMP/mtl.json"
MTL_ERR="$TMP/mtl.err"
LAUNCHD_JSON="$TMP/launchd.json"
LAUNCHD_ERR="$TMP/launchd.err"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_JSON_AUDIT.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_ACCEL_JSON_AUDIT=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AH — ACCELERATED JSON PROVENANCE + EXIT AUDIT ====="
echo "ACCEL_WINDOW_START=$START"
echo "ACCEL_WINDOW_END=$END"
echo "EXPECTED_CURRENT_VESA_BOOT_SEC=$EXPECTED_CURRENT_VESA_BOOT_SEC"
echo "EXPECTED_STAMP_UUID=$EXPECTED_STAMP_UUID"
echo "OLD_UUID=$OLD_UUID"
echo

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\1/')"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"
[[ "$BOOT_SEC" == "$EXPECTED_CURRENT_VESA_BOOT_SEC" ]] || fail "CURRENT_BOOT_CHANGED_CHRONOLOGY_INVALID"
echo "CURRENT_VESA_BOOT_IDENTITY=PASS"
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

MTL_BYTES="$(/usr/bin/stat -f '%z' "$MTL_JSON" 2>/dev/null || echo 0)"
LAUNCHD_BYTES="$(/usr/bin/stat -f '%z' "$LAUNCHD_JSON" 2>/dev/null || echo 0)"
echo "MTL_JSON_BYTES=$MTL_BYTES"
echo "LAUNCHD_JSON_BYTES=$LAUNCHD_BYTES"
[[ "$MTL_BYTES" -gt 0 ]] || fail "MTL_JSON_EMPTY"
[[ "$LAUNCHD_BYTES" -gt 0 ]] || fail "LAUNCHD_JSON_EMPTY"

echo "MTL_LOG_STDERR_BEGIN"
/bin/cat "$MTL_ERR" 2>/dev/null || true
echo "MTL_LOG_STDERR_END"
echo "LAUNCHD_LOG_STDERR_BEGIN"
/bin/cat "$LAUNCHD_ERR" 2>/dev/null || true
echo "LAUNCHD_LOG_STDERR_END"
echo

"$PYTHON" - "$MTL_JSON" "$LAUNCHD_JSON" "$EXPECTED_STAMP_UUID" "$OLD_UUID" <<'PY'
import collections
import json
import re
import sys
from pathlib import Path

mtl_path = Path(sys.argv[1])
launchd_path = Path(sys.argv[2])
expected_uuid = sys.argv[3].upper()
old_uuid = sys.argv[4].upper()

def parse_json_stream(path):
    raw = path.read_text(encoding="utf-8", errors="replace")
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

def norm_uuid(v):
    if v is None:
        return "MISSING"
    return str(v).upper()

def clean(v):
    if v is None:
        return "MISSING"
    return str(v).replace("\n", "\\n").replace("\r", "\\r")

mtl = parse_json_stream(mtl_path)
launchd = parse_json_stream(launchd_path)
print(f"MTL_JSON_RECORDS={len(mtl)}")
print(f"LAUNCHD_JSON_RECORDS={len(launchd)}")
if not mtl:
    raise SystemExit("NO_MTL_JSON_RECORDS")
if not launchd:
    raise SystemExit("NO_LAUNCHD_JSON_RECORDS")

pids = sorted({int(val(r, "processID", "processIdentifier")) for r in mtl if str(val(r, "processID", "processIdentifier") or "").isdigit()})
print("MTL_PROCESS_PID_COUNT=" + str(len(pids)))
print("MTL_PROCESS_PIDS=" + ",".join(map(str, pids)))

all_sender = collections.Counter()
diag_sender = collections.Counter()
per_pid_diag = collections.defaultdict(collections.Counter)
per_pid_all = collections.defaultdict(collections.Counter)
diag_records = []

for r in mtl:
    pidv = val(r, "processID", "processIdentifier")
    try:
        pid = int(pidv)
    except Exception:
        pid = -1
    msg = clean(val(r, "eventMessage", "message"))
    sip = clean(val(r, "senderImagePath"))
    siu = norm_uuid(val(r, "senderImageUUID"))
    pip = clean(val(r, "processImagePath"))
    piu = norm_uuid(val(r, "processImageUUID"))
    key = (sip, siu)
    all_sender[key] += 1
    if pid >= 0:
        per_pid_all[pid][key] += 1
    low = msg.lower()
    is_diag = ("simulator" in low and "were used" in low) or ("mtlcompiler" in sip.lower())
    if is_diag:
        diag_sender[key] += 1
        if pid >= 0:
            per_pid_diag[pid][key] += 1
        diag_records.append((clean(val(r, "timestamp")), pid, sip, siu, pip, piu, msg))

print("===== MTL SENDER DISTRIBUTION ALL =====")
for (path, uuid), count in sorted(all_sender.items(), key=lambda x: (-x[1], x[0][0], x[0][1])):
    print(f"ALL_SENDER_COUNT={count}|PATH={path}|UUID={uuid}")

print("===== MTL DIAGNOSTIC SENDER DISTRIBUTION =====")
print(f"DIAGNOSTIC_RECORD_COUNT={len(diag_records)}")
for (path, uuid), count in sorted(diag_sender.items(), key=lambda x: (-x[1], x[0][0], x[0][1])):
    print(f"DIAG_SENDER_COUNT={count}|PATH={path}|UUID={uuid}")

print("===== PER-PID DIAGNOSTIC SENDER =====")
for pid in pids:
    pairs = per_pid_diag.get(pid, {})
    if not pairs:
        print(f"PID_DIAG_SENDER={pid}|NONE")
        continue
    for (path, uuid), count in sorted(pairs.items(), key=lambda x: (-x[1], x[0][0], x[0][1])):
        print(f"PID_DIAG_SENDER={pid}|COUNT={count}|PATH={path}|UUID={uuid}")

print("===== RAW DIAGNOSTIC RECORDS =====")
for ts, pid, sip, siu, pip, piu, msg in diag_records:
    print(f"DIAG_RECORD|TS={ts}|PID={pid}|SENDER_PATH={sip}|SENDER_UUID={siu}|PROCESS_PATH={pip}|PROCESS_UUID={piu}|MSG={msg}")

all_uuid_values = [norm_uuid(val(r, "senderImageUUID")) for r in mtl]
diag_uuid_values = [x[3] for x in diag_records]
print("EXPECTED_STAMP_UUID_ALL_RECORD_MATCHES=" + str(sum(u == expected_uuid for u in all_uuid_values)))
print("OLD_UUID_ALL_RECORD_MATCHES=" + str(sum(u == old_uuid for u in all_uuid_values)))
print("EXPECTED_STAMP_UUID_DIAG_MATCHES=" + str(sum(u == expected_uuid for u in diag_uuid_values)))
print("OLD_UUID_DIAG_MATCHES=" + str(sum(u == old_uuid for u in diag_uuid_values)))

launch_records = []
spawn_pids = set()
for r in launchd:
    msg = clean(val(r, "eventMessage", "message"))
    ts = clean(val(r, "timestamp"))
    if "MTLCompilerService" in msg:
        launch_records.append((ts, msg))
        for pat in (r"MTLCompilerService\[(\d+)\]", r"MTLCompilerService[^\[]*\[(\d+)\]"):
            for m in re.finditer(pat, msg):
                spawn_pids.add(int(m.group(1)))

if pids:
    spawn_pids.update(pids)

print("===== LAUNCHD MTL RAW RECORDS =====")
print(f"LAUNCHD_MTL_RECORD_COUNT={len(launch_records)}")
for ts, msg in launch_records:
    print(f"LAUNCHD_MTL|TS={ts}|MSG={msg}")

keywords = re.compile(r"exit|exited|signal|sig[a-z0-9]+|terminat|status|code|crash|inactive|spawn", re.I)
term_by_pid = collections.defaultdict(list)
for r in launchd:
    msg = clean(val(r, "eventMessage", "message"))
    if not keywords.search(msg):
        continue
    ts = clean(val(r, "timestamp"))
    for pid in sorted(spawn_pids):
        if re.search(rf"(?<!\d){pid}(?!\d)", msg):
            term_by_pid[pid].append((ts, msg))

print("===== PER-PID LAUNCHD TERMINATION/LIFECYCLE EVIDENCE =====")
for pid in sorted(spawn_pids):
    recs = term_by_pid.get(pid, [])
    print(f"PID_LIFECYCLE={pid}|RECORDS={len(recs)}")
    for ts, msg in recs:
        print(f"PID_LIFECYCLE_RECORD|PID={pid}|TS={ts}|MSG={msg}")

outcome_counts = collections.Counter()
for ts, msg in launch_records:
    for code in (110,111,112,113,114):
        if re.search(rf"(?<!\d){code}(?!\d)", msg) and re.search(r"exit|code|status", msg, re.I):
            outcome_counts[code] += 1
print("D97AD_110_114_LAUNCHD_EVIDENCE=" + ";".join(f"{c}:{outcome_counts[c]}" for c in (110,111,112,113,114)))

normal_exit_one = 0
for ts, msg in launch_records:
    if re.search(r"(?:exit(?:ed)?(?: with)?(?: code)?|code|status)[^0-9]{0,20}1(?!\d)", msg, re.I):
        normal_exit_one += 1
print(f"LAUNCHD_EXIT1_TEXT_EVIDENCE_COUNT={normal_exit_one}")

print("===== STRUCTURED FIELD NAMES OBSERVED IN DIAGNOSTIC RECORDS =====")
keys = sorted({k for r in mtl for k in r.keys() if "image" in k.lower() or "uuid" in k.lower() or "process" in k.lower() or "sender" in k.lower()})
print("MTL_RELEVANT_JSON_KEYS=" + ",".join(keys))
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
echo "D97AH_ACCEL_JSON_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
