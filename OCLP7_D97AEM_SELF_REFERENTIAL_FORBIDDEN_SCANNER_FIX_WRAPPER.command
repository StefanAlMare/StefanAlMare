#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEM_SELF_REFERENTIAL_FORBIDDEN_SCANNER_FIX_WRAPPER_REPORT.txt"
BASE_COMMIT="b43fac0041f0331637a699c5d13121748e58d73a"
BASE_BLOB_EXPECTED="aa2bccdd24b582986fd9fd110a13ca4b7d0981ce"
BASE_NAME="OCLP7_D97AEL_STALE_GIT_ADD_SNAPSHOT_V2_PATH_FIX_WRAPPER.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d -t oclp7-d97aem)"
BASE="$TMP/$BASE_NAME"
FIXED="$TMP/OCLP7_D97AEM_FIXED_D97AEL_WRAPPER.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1

fail() {
  echo "D97AEM_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEM — SELF-REFERENTIAL FORBIDDEN-SCANNER FIX WRAPPER ====="
echo "CLASSIFICATION=D97AEL_STATIC_AUDIT_FALSE_POSITIVE_ON_NESTED_D97AEK_CHECKER_LINE"
echo "ROOT_CAUSE=D97AEL_SCANNED_THE_EXACT_FORBIDDEN_TOKEN_CHECKER_INSIDE_D97AEK_AS_IF_IT_WERE_AN_OPERATION"
echo "CORRECTION_SCOPE=exclude_only_the_exact_known_checker_source_line_from_D97AEL_forbidden_results"
echo "D97AEL_STALE_GIT_ADD_SNAPSHOT_V2_FIX=RETAINED_UNCHANGED"
echo "D97AEK_TECHNICAL_AUDIT_RESULT=RETAINED_PASS"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for t in curl git python3 zsh shasum; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done

/usr/bin/curl -fL "$BASE_URL" -o "$BASE"
BASE_BLOB_ACTUAL="$(/usr/bin/git hash-object "$BASE")"
echo "D97AEM_BASE_BLOB_ACTUAL=$BASE_BLOB_ACTUAL"
echo "D97AEM_BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
[[ "$BASE_BLOB_ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$BASE_BLOB_ACTUAL"
echo "D97AEM_BASE_IDENTITY=PASS"

/usr/local/bin/python3 - "$BASE" "$FIXED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
original = src.read_text()
old = """    if 'start_root_patch' in q or 'patch_root_volume(' in q:
        forbidden.append(line)
"""
new = """    if 'start_root_patch' in q or 'patch_root_volume(' in q:
        if q == "if 'start_root_patch' in q or 'patch_root_volume(' in q:":
            continue
        forbidden.append(line)
"""
count = original.count(old)
print(f"D97AEM_SELF_SCANNER_BLOCK_MATCH_COUNT={count}")
if count != 1:
    raise SystemExit(f"D97AEM_SELF_SCANNER_BLOCK_CARDINALITY_FAIL:{count}")
fixed = original.replace(old, new, 1)
if fixed.replace(new, old, 1) != original:
    raise SystemExit("D97AEM_ONLY_SCANNER_EXCLUSION_DELTA_FAIL")
if fixed.count(new) != 1 or fixed.count(old) != 0:
    raise SystemExit("D97AEM_SCANNER_POSTIMAGE_CARDINALITY_FAIL")
dst.write_text(fixed)
dst.chmod(0o755)
print("D97AEM_EXACT_SELF_REFERENTIAL_CHECKER_EXCLUSION=PASS")
print("D97AEM_ONLY_D97AEL_FORBIDDEN_SCANNER_BLOCK_CHANGED=PASS")
PY

/bin/zsh -n "$FIXED"
echo "D97AEM_FIXED_D97AEL_ZSH_PARSE=PASS"

/usr/local/bin/python3 - "$FIXED" <<'PY'
from pathlib import Path
import sys
s = Path(sys.argv[1]).read_text()
required = [
    'SNAP="$ORCH/oclp7-d97ad/snapshot-v2"',
    "'git -C \"$ORCH\" add oclp7-d97ad/snapshot-v2'",
    '[oclp7-snapshot-v2]',
    'GITHUB_WORKFLOW=oclp7-d97ad-build-v2.yml',
    'D97AEL_STATIC_CONTRACT_AUDIT=PASS',
    'ROOT_PATCH=AUTO-NO',
    'REBOOT=AUTO-NO',
]
missing = [x for x in required if x not in s]
print('D97AEM_REQUIRED_ANCHORS_MISSING=' + repr(missing))
if missing:
    raise SystemExit('D97AEM_STATIC_ANCHOR_FAIL')
checker = '        if q == "if \'start_root_patch\' in q or \'patch_root_volume(\' in q:":'
checker_count = sum(line == checker for line in s.splitlines())
print(f'D97AEM_EXACT_CHECKER_EXCLUSION_LINE_COUNT={checker_count}')
if checker_count != 1:
    raise SystemExit('D97AEM_CHECKER_EXCLUSION_LINE_CARDINALITY_FAIL')
print('D97AEM_STATIC_CONTRACT_AUDIT=PASS')
PY

echo "===== EXECUTE SELF-SCANNER-HARDENED D97AEL WRAPPER ====="
set +e
/bin/zsh "$FIXED"
RC=$?
set -e
echo "D97AEM_INNER_D97AEL_RC=$RC"
[[ "$RC" -eq 0 ]] || fail "INNER_D97AEL_FAILED_RC:$RC"

echo "===== FINAL ====="
echo "D97AEL_SELF_REFERENTIAL_FORBIDDEN_SCANNER=CORRECTED"
echo "D97AEL_STALE_GIT_ADD_SNAPSHOT_V2_PATH_FIX=RETAINED"
echo "D97AEM_PRIVATE_GITHUB_SYNC=PASS"
echo "D97AEM_INNER_D97AEL_RC=0"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_monitor_private_GitHub_Actions_v2_build"
echo "REPORT=$REPORT"
