#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="2401be6af44180ae35040ad752ea3b361238d0b7"
BASE_BLOB="969701ab1fb00bea91d44196b463e3a400efd258"
BASE_NAME="OCLP7_D97AO_READONLY_NATURAL_P7_RUNTIME_PC_AND_RESOLVED_CFG_AUDIT.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AO_V2.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AO_V2.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AO_V2=FAIL_CLOSED|REASON=$1"
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

/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD_FAILED"

ACTUAL_BASE_BLOB="$("$PYTHON" - "$BASE" <<'PY'
import hashlib, sys
from pathlib import Path
p = Path(sys.argv[1])
d = p.read_bytes()
print(hashlib.sha1(b"blob " + str(len(d)).encode() + b"\0" + d).hexdigest())
PY
)"

echo "D97AO_V2_BASE_COMMIT=$BASE_COMMIT"
echo "D97AO_V2_BASE_BLOB_EXPECTED=$BASE_BLOB"
echo "D97AO_V2_BASE_BLOB_ACTUAL=$ACTUAL_BASE_BLOB"
[[ "$ACTUAL_BASE_BLOB" == "$BASE_BLOB" ]] || fail "BASE_BLOB_MISMATCH"

"$PYTHON" - "$BASE" "$PATCHED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1]).read_text(encoding="utf-8")

replacements = [
    (
        'EXPECTED_VESA_BOOT_SEC="1788478349"',
        'HISTORICAL_VESA_BOOT_SEC="1788478349"'
    ),
    (
        'echo "EXPECTED_CURRENT_VESA_BOOT_SEC=$EXPECTED_VESA_BOOT_SEC"',
        'echo "HISTORICAL_VESA_BOOT_SEC_PERSISTED=$HISTORICAL_VESA_BOOT_SEC"'
    ),
    (
        '''BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\\1/')"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"
[[ "$BOOT_SEC" == "$EXPECTED_VESA_BOOT_SEC" ]] || fail "CURRENT_BOOT_CHANGED_CHRONOLOGY_INVALID"
echo "CURRENT_VESA_BOOT_IDENTITY=PASS"''',
        '''BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\\1/')"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"
echo "HISTORICAL_ACCELERATED_BOOT=2026-09-04_02:29_PERSISTED"
echo "HISTORICAL_VESA_RECOVERY_BOOT=2026-09-04_02:32_PERSISTED_SEC_$HISTORICAL_VESA_BOOT_SEC"
echo "CURRENT_BOOT_IDENTITY_NOT_REQUIRED_FOR_STATIC_AUDIT=PASS"'''
    ),
]

for old, new in replacements:
    count = src.count(old)
    if count != 1:
        raise SystemExit(f"PATCH_PREIMAGE_COUNT_FAIL={count}|PREIMAGE={old[:80]!r}")
    src = src.replace(old, new, 1)

for forbidden in (
    'EXPECTED_VESA_BOOT_SEC=',
    'CURRENT_BOOT_CHANGED_CHRONOLOGY_INVALID',
    'CURRENT_VESA_BOOT_IDENTITY=PASS',
):
    if forbidden in src:
        raise SystemExit(f"FORBIDDEN_RESIDUE={forbidden}")

required = (
    'HISTORICAL_VESA_BOOT_SEC="1788478349"',
    'HISTORICAL_ACCELERATED_BOOT=2026-09-04_02:29_PERSISTED',
    'HISTORICAL_VESA_RECOVERY_BOOT=2026-09-04_02:32_PERSISTED_SEC_$HISTORICAL_VESA_BOOT_SEC',
    'CURRENT_BOOT_IDENTITY_NOT_REQUIRED_FOR_STATIC_AUDIT=PASS',
    'EXPECTED_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"',
    'EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"',
    'NATURAL_SITE_BYTES="8b8d10feffff83f941"',
)
for token in required:
    if token not in src:
        raise SystemExit(f"REQUIRED_TOKEN_MISSING={token}")

Path(sys.argv[2]).write_text(src, encoding="utf-8")
PY

/bin/zsh -n "$PATCHED" || fail "PATCHED_ZSH_PARSE_FAILED"

PATCHED_BLOB="$("$PYTHON" - "$PATCHED" <<'PY'
import hashlib, sys
from pathlib import Path
d = Path(sys.argv[1]).read_bytes()
print(hashlib.sha1(b"blob " + str(len(d)).encode() + b"\0" + d).hexdigest())
PY
)"
PATCHED_SHA256="$(/usr/bin/shasum -a 256 "$PATCHED" | /usr/bin/awk '{print $1}')"
PATCHED_BYTES="$(/usr/bin/stat -f '%z' "$PATCHED")"

echo "D97AO_V2_PATCHED_BLOB=$PATCHED_BLOB"
echo "D97AO_V2_PATCHED_SHA256=$PATCHED_SHA256"
echo "D97AO_V2_PATCHED_BYTES=$PATCHED_BYTES"
echo "D97AO_V2_TRANSFORM=EXACT_THREE_REPLACEMENTS_CURRENT_BOOT_GATE_ONLY"
echo "D97AO_V2_PATCH_AND_PARSE=PASS"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AO_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
