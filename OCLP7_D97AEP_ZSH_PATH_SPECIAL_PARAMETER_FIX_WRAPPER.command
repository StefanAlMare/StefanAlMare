#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEP_ZSH_PATH_SPECIAL_PARAMETER_FIX_WRAPPER_REPORT.txt"
BASE_COMMIT="b05a4b6a9760302c03b5770e24315308771815ec"
BASE_BLOB_EXPECTED="eeead68e397d3cf915f2b884d8ff1f7dfcec0e04"
BASE_NAME="OCLP7_D97AEO_HARDENED_GITHUB_ARTIFACT_DOWNLOAD_AUDIT_DEPLOY.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d -t oclp7-d97aep)"
BASE="$TMP/$BASE_NAME"
FIXED="$TMP/OCLP7_D97AEO_HARDENED_GITHUB_ARTIFACT_DOWNLOAD_AUDIT_DEPLOY.path-fixed.command"

cleanup() {
  /bin/rm -rf "$TMP"
}
trap cleanup EXIT

exec > >(/usr/bin/tee "$REPORT") 2>&1

fail() {
  echo "D97AEP_FAIL=$*"
  echo "LOCAL_SOURCE_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEP — zsh SPECIAL path/PATH PARAMETER FIX WRAPPER ====="
echo "CLASSIFICATION=D97AEO_TOOL_DISCOVERY_FALSE_FAILURE_CAUSED_BY_ZSH_path_SPECIAL_PARAMETER"
echo "ROOT_CAUSE=assignment_to_lowercase_path_rebound_the_tied_PATH_parameter_after_first_tool"
echo "CORRECTION_SCOPE=rename_only_the_three_D97AEO_tool_loop_references_from_path_to_tool_path"
echo "D97AEO_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AEO_ARTIFACT_IDENTITY_CHANGE=NO"
echo "D97AEO_DEPLOY_OR_ROLLBACK_LOGIC_CHANGE=NO"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "TOOL_curl=$([[ -x /usr/bin/curl ]] && echo /usr/bin/curl || echo MISSING)"
echo "TOOL_git=$([[ -x /usr/bin/git ]] && echo /usr/bin/git || echo MISSING)"
echo "TOOL_zsh=$([[ -x /bin/zsh ]] && echo /bin/zsh || echo MISSING)"

[[ -x /usr/bin/curl ]] || fail "MISSING_ABSOLUTE_TOOL:/usr/bin/curl"
[[ -x /usr/bin/git ]] || fail "MISSING_ABSOLUTE_TOOL:/usr/bin/git"
[[ -x /bin/zsh ]] || fail "MISSING_ABSOLUTE_TOOL:/bin/zsh"

PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON_BIN" ]] || fail "MISSING_TOOL:python3"
echo "TOOL_python3=$PYTHON_BIN"
"$PYTHON_BIN" --version

/usr/bin/curl -fL "$BASE_URL" -o "$BASE"
BASE_BLOB_ACTUAL="$(/usr/bin/git hash-object "$BASE")"
echo "D97AEP_BASE_BLOB_ACTUAL=$BASE_BLOB_ACTUAL"
echo "D97AEP_BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
[[ "$BASE_BLOB_ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$BASE_BLOB_ACTUAL"
echo "D97AEP_BASE_IDENTITY=PASS"

"$PYTHON_BIN" - "$BASE" "$FIXED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
text = src.read_text()

old = '''for tool in gh git python3 shasum awk find ditto lipo file plutil pgrep ps open sudo df grep; do
  path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${path:-MISSING}"
  [[ -n "$path" ]] || fail "MISSING_TOOL:$tool"
done'''
new = '''for tool in gh git python3 shasum awk find ditto lipo file plutil pgrep ps open sudo df grep; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done'''

count = text.count(old)
print(f"D97AEP_EXACT_BROKEN_TOOL_LOOP_COUNT={count}")
if count != 1:
    raise SystemExit(f"BROKEN_TOOL_LOOP_CARDINALITY_FAIL:{count}")

fixed = text.replace(old, new, 1)

old_lines = text.splitlines()
new_lines = fixed.splitlines()
if len(old_lines) != len(new_lines):
    raise SystemExit("LINE_COUNT_CHANGED")
changes = [(i + 1, a, b) for i, (a, b) in enumerate(zip(old_lines, new_lines)) if a != b]
print(f"D97AEP_CHANGED_LINE_COUNT={len(changes)}")
for line_no, before, after in changes:
    print(f"D97AEP_CHANGED_LINE={line_no}|BEFORE={before}|AFTER={after}")
expected = [
    ('  path="$(command -v "$tool" 2>/dev/null || true)"', '  tool_path="$(command -v "$tool" 2>/dev/null || true)"'),
    ('  echo "TOOL_${tool}=${path:-MISSING}"', '  echo "TOOL_${tool}=${tool_path:-MISSING}"'),
    ('  [[ -n "$path" ]] || fail "MISSING_TOOL:$tool"', '  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"'),
]
if [(a, b) for _, a, b in changes] != expected:
    raise SystemExit("UNEXPECTED_TRANSFORM_DELTA")

if fixed.count('  path="$(command -v "$tool" 2>/dev/null || true)"') != 0:
    raise SystemExit("BROKEN_path_ASSIGNMENT_RETAINED")
if fixed.count('  tool_path="$(command -v "$tool" 2>/dev/null || true)"') != 1:
    raise SystemExit("FIXED_tool_path_ASSIGNMENT_CARDINALITY_FAIL")
if fixed.count('${tool_path:-MISSING}') != 1 or fixed.count('[[ -n "$tool_path" ]]') != 1:
    raise SystemExit("FIXED_tool_path_REFERENCE_CARDINALITY_FAIL")

# The transformation is exact and line-for-line; all build/artifact/deploy identities remain byte-identical.
dst.write_text(fixed)
print("D97AEP_ONLY_ZSH_PATH_BINDING_RENAMED=PASS")
PY

/bin/chmod +x "$FIXED"
/bin/zsh -n "$FIXED"
echo "D97AEP_FIXED_D97AEO_ZSH_PARSE=PASS"

OLD_ASSIGN_COUNT="$(/usr/bin/grep -F -c '  path="$(command -v "$tool" 2>/dev/null || true)"' "$FIXED" || true)"
NEW_ASSIGN_COUNT="$(/usr/bin/grep -F -c '  tool_path="$(command -v "$tool" 2>/dev/null || true)"' "$FIXED" || true)"
echo "D97AEP_OLD_path_ASSIGNMENT_COUNT=$OLD_ASSIGN_COUNT"
echo "D97AEP_NEW_tool_path_ASSIGNMENT_COUNT=$NEW_ASSIGN_COUNT"
[[ "$OLD_ASSIGN_COUNT" == "0" && "$NEW_ASSIGN_COUNT" == "1" ]] || fail "POST_TRANSFORM_CARDINALITY_FAIL"

echo "===== EXECUTE PATH-SAFE D97AEO CORE ====="
set +e
/bin/zsh "$FIXED"
INNER_RC=$?
set -e
echo "D97AEP_INNER_D97AEO_RC=$INNER_RC"
(( INNER_RC == 0 )) || fail "INNER_D97AEO_FAILED_RC:$INNER_RC"

echo "===== FINAL ====="
echo "D97AEO_ZSH_path_SPECIAL_PARAMETER_COLLISION=CORRECTED"
echo "D97AEO_ARTIFACT_AND_DEPLOY_CONTRACT=RETAINED_UNCHANGED"
echo "D97AEP_INNER_D97AEO_RC=0"
echo "D97AEP_PATH_SAFE_DOWNLOAD_AUDIT_DEPLOY=PASS"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_audit_live_D97AD_before_manual_Root_Patch"
echo "REPORT=$REPORT"
