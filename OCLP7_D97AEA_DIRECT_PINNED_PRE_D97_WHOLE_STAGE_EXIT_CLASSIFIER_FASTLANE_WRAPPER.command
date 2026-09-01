#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEA_DIRECT_PINNED_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_FASTLANE_WRAPPER_REPORT.txt"
CORE_REPORT="$HOME/Desktop/OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_REPORT.txt"
PAYLOAD_COMMIT="473d4bab1571e2a8907d3ae500fb88e5fd9639c0"
PAYLOAD_DIR="OCLP7-D97AEA-payload"
PART_PREFIX="OCLP7_D97AE_CORE_PAYLOAD.part"
CORE_SHA256_EXPECTED="d8166ed5697cf281a60b19dba4c902470c4900de740006431d7cff5580fa5bb6"
PART_BLOBS=(
    "bcfcc00786676f3d946e9782f4fe94f3980b392d"
    "a389b2eedcd1960475de0ddd3024b0afaec6f930"
    "c34f26b9a111aef8926ee49cfaa0f6fa4edd8423"
    "c74b2b02171f1c38669f6b45f8f0bf14aa7a9d17"
)

TMPDIR_D97AEA="$(/usr/bin/mktemp -d -t oclp-d97aea)"
CORE="$TMPDIR_D97AEA/OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER.command"
trap '/bin/rm -rf "$TMPDIR_D97AEA"' EXIT

exec > >(tee "$REPORT") 2>&1

fail() {
    echo "D97AEA_FAIL=$*"
    echo "REPORT=$REPORT"
    exit 2
}

echo "===== OCLP7 D97AEA — DIRECT PINNED PRE-D97 WHOLE-STAGE EXIT-CLASSIFIER FASTLANE WRAPPER ====="
echo "PAYLOAD_COMMIT=$PAYLOAD_COMMIT"
echo "CORE_SHA256_EXPECTED=$CORE_SHA256_EXPECTED"
echo "INPUT_D97AD=exact_final_service_and_MTL_transition_STATIC_PROVEN"
echo "D97Z_SERVICE_DIAGNOSTIC_REMOVED=YES"
echo "D97_MTL_DIAGNOSTIC_REPLACED_NOT_STACKED=YES"
echo "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

for TOOL in curl git python3 zsh shasum; do
    P="$(command -v "$TOOL" 2>/dev/null || true)"
    echo "TOOL_${TOOL}=${P:-MISSING}"
    [[ -n "$P" ]] || fail "MISSING_TOOL:$TOOL"
done
PY="$(command -v python3)"
"$PY" --version 2>&1

PART_FILES=()
for INDEX in 1 2 3 4; do
    FILE="$TMPDIR_D97AEA/${PART_PREFIX}${INDEX}.b64"
    URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/$PAYLOAD_COMMIT/$PAYLOAD_DIR/${PART_PREFIX}${INDEX}.b64"
    /usr/bin/curl -fL "$URL" -o "$FILE"
    ACTUAL_BLOB="$(/usr/bin/git hash-object "$FILE")"
    EXPECTED_BLOB="${PART_BLOBS[$INDEX]}"
    echo "D97AEA_PAYLOAD_PART_${INDEX}_BLOB_ACTUAL=$ACTUAL_BLOB"
    echo "D97AEA_PAYLOAD_PART_${INDEX}_BLOB_EXPECTED=$EXPECTED_BLOB"
    [[ "$ACTUAL_BLOB" == "$EXPECTED_BLOB" ]] || fail "PAYLOAD_PART_${INDEX}_BLOB_MISMATCH"
    PART_FILES+=("$FILE")
done
echo "D97AEA_PAYLOAD_PART_IDENTITIES=PASS"

/bin/cat "${PART_FILES[@]}" > "$TMPDIR_D97AEA/core.b64"
"$PY" - "$TMPDIR_D97AEA/core.b64" "$CORE" <<'PYDECODE'
from pathlib import Path
import base64
import gzip
import sys

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
payload = base64.b64decode(src.read_bytes(), validate=True)
data = gzip.decompress(payload)
dst.write_bytes(data)
dst.chmod(0o755)
print("D97AEA_PAYLOAD_BASE64_LENGTH=" + str(src.stat().st_size))
print("D97AEA_DECOMPRESSED_CORE_SIZE=" + str(len(data)))
PYDECODE

CORE_SHA256_ACTUAL="$(/usr/bin/shasum -a 256 "$CORE" | /usr/bin/awk '{print $1}')"
echo "D97AEA_CORE_SHA256_ACTUAL=$CORE_SHA256_ACTUAL"
[[ "$CORE_SHA256_ACTUAL" == "$CORE_SHA256_EXPECTED" ]] || fail "CORE_SHA256_MISMATCH"
echo "D97AEA_CORE_IDENTITY=PASS"

/bin/zsh -n "$CORE"
echo "D97AEA_CORE_ZSH_PARSE=PASS"

"$PY" - "$CORE" <<'PYAUD'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
source = path.read_text()
blocks = re.findall(r"<<'([A-Z0-9_]+)'\n(.*?)\n\1\n", source, re.S)
print("D97AEA_EMBEDDED_PYTHON_BLOCKS=" + repr([name for name, _ in blocks]))
if [name for name, _ in blocks] != ["PYINTEGRATE", "PYPACKAGE"]:
    raise SystemExit("D97AEA_PYTHON_BLOCK_IDENTITY_FAIL")
for name, code in blocks:
    compile(code, str(path) + "::<" + name + ">", "exec")
print("D97AEA_EMBEDDED_PYTHON_COMPILE=PASS")

required = (
    "D97Z_SERVICE_HELPER_AND_CALL_REMOVED=PASS",
    "D97_MTL_HELPER_AND_CALL_REPLACED_BY_D97AD=PASS",
    "D97AE_SYNTHETIC_FINAL_MTL_SHA=",
    "524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755",
    "SOURCE_ORDER_SELECTOR_CONTROL_P6_P7_D97AD=PASS",
    "PACKAGED_D97Z_SERVICE_DIAGNOSTIC_ABSENT=PASS",
    "PACKAGED_D97_REMOVED_NOT_STACKED=PASS",
    "PACKAGED_D97AD_PRESENT_ONCE=PASS",
    "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114_or_runtime_run_invalid",
    "ROOT_PATCH=AUTO-NO",
    "REBOOT=AUTO-NO",
)
missing = [token for token in required if token not in source]
print("D97AEA_REQUIRED_ANCHORS_MISSING=" + repr(missing))
if missing:
    raise SystemExit("D97AEA_STATIC_CONTRACT_FAIL")

forbidden_patterns = (
    r"^\s*(?:sudo\s+)?reboot\b",
    r"^\s*(?:sudo\s+)?shutdown\b",
    r"start_root_patch",
    r"patch_sys_volume",
    r"automatic_root_patch",
)
hits = []
for lineno, line in enumerate(source.splitlines(), 1):
    for pattern in forbidden_patterns:
        if re.search(pattern, line, re.I):
            hits.append((lineno, line))
print("D97AEA_FORBIDDEN_AUTOMATION_LINES=" + repr(hits))
if hits:
    raise SystemExit("D97AEA_FORBIDDEN_AUTOMATION_DETECTED")
print("D97AEA_STATIC_FASTLANE_CONTRACT_AUDIT=PASS")
PYAUD

echo "===== EXECUTE PINNED D97AE CORE ====="
set +e
/bin/zsh "$CORE"
RC=$?
set -e
echo "D97AEA_CORE_RC=$RC"
[[ "$RC" -eq 0 ]] || fail "CORE_FAILED_RC:$RC"
[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
/usr/bin/grep -Fq 'FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER=PASS' "$CORE_REPORT" || fail "CORE_FINAL_PASS_GATE_MISSING"
/usr/bin/grep -Fq 'D97Z_SERVICE_DIAGNOSTIC_REMOVED=PASS' "$CORE_REPORT" || fail "CORE_SERVICE_REMOVAL_GATE_MISSING"
/usr/bin/grep -Fq 'D97_DOWNSTREAM_DIAGNOSTIC_REPLACED_NOT_STACKED=PASS' "$CORE_REPORT" || fail "CORE_D97_REPLACEMENT_GATE_MISSING"
/usr/bin/grep -Fq 'ROOT_PATCH=AUTO-NO' "$CORE_REPORT" || fail "CORE_ROOT_PATCH_GATE_MISSING"
/usr/bin/grep -Fq 'REBOOT=AUTO-NO' "$CORE_REPORT" || fail "CORE_REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97AEA_WRAPPER=PASS"
echo "D97AEA_CORE_RC=0"
echo "D97Z_SERVICE_DIAGNOSTIC_REMOVED=PASS"
echo "D97_MTL_DIAGNOSTIC_REPLACED_NOT_STACKED=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_full_FASTLANE_audit_before_manual_Root_Patch"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
