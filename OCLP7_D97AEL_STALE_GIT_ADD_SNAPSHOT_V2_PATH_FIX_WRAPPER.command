#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEL_STALE_GIT_ADD_SNAPSHOT_V2_PATH_FIX_WRAPPER_REPORT.txt"
BASE_COMMIT="956f7880fbd64b71636e00aa49ed18d7bdaebcb8"
BASE_BLOB_EXPECTED="1ee8f7470d42de42dc562908e58361183eeffc0f"
BASE_NAME="OCLP7_D97AEK_THREE_FILE_PRIVATE_GITHUB_SYNC_WRAPPER.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d -t oclp7-d97ael)"
BASE="$TMP/$BASE_NAME"
FIXED="$TMP/OCLP7_D97AEL_FIXED_THREE_FILE_SYNC_WRAPPER.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1

fail() {
  echo "D97AEL_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEL — STALE git-add snapshot-v2 PATH FIX WRAPPER ====="
echo "CLASSIFICATION=D97AEK_PUSH_LANE_TOOLING_FAIL_STALE_GIT_ADD_PATH_ONLY"
echo "ROOT_CAUSE=SNAP_VARIABLE_TRANSFORMED_TO_snapshot-v2_BUT_git_add_RETAINED_snapshot"
echo "CORRECTION_SCOPE=add_exact_single_path_transform_for_git_add_only"
echo "D97AEK_TECHNICAL_AUDIT_RESULT=RETAINED_PASS"
echo "D97AEK_SOURCE_ARCHIVE_CREATION_RESULT=RETAINED_PASS"
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
echo "D97AEL_BASE_BLOB_ACTUAL=$BASE_BLOB_ACTUAL"
echo "D97AEL_BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
[[ "$BASE_BLOB_ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$BASE_BLOB_ACTUAL"
echo "D97AEL_BASE_IDENTITY=PASS"

/usr/local/bin/python3 - "$BASE" "$FIXED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
s = src.read_text()

anchor = "]\n\nfor old, new in replacements:\n"
count = s.count(anchor)
print(f"D97AEL_REPLACEMENT_LIST_TAIL_ANCHOR_COUNT={count}")
if count != 1:
    raise SystemExit(f"D97AEL_REPLACEMENT_LIST_TAIL_ANCHOR_FAIL:{count}")

extra = '''    (
        'git -C "$ORCH" add oclp7-d97ad/snapshot',
        'git -C "$ORCH" add oclp7-d97ad/snapshot-v2',
    ),
'''
s = s.replace(anchor, extra + anchor, 1)

dst.write_text(s)
dst.chmod(0o755)
print("D97AEL_EXACT_STALE_GIT_ADD_PATH_TRANSFORM_INSERTED=PASS")
PY

/bin/zsh -n "$FIXED"
echo "D97AEL_FIXED_WRAPPER_ZSH_PARSE=PASS"

/usr/local/bin/python3 - "$FIXED" <<'PY'
from pathlib import Path
import sys
s = Path(sys.argv[1]).read_text()
lines = s.splitlines()
old_line = "        'git -C \"$ORCH\" add oclp7-d97ad/snapshot',"
new_line = "        'git -C \"$ORCH\" add oclp7-d97ad/snapshot-v2',"
old_count = sum(line == old_line for line in lines)
new_count = sum(line == new_line for line in lines)
print(f"D97AEL_OLD_GIT_ADD_EXACT_LINE_COUNT={old_count}")
print(f"D97AEL_NEW_GIT_ADD_EXACT_LINE_COUNT={new_count}")
if old_count != 1 or new_count != 1:
    raise SystemExit("D97AEL_GIT_ADD_TRANSFORM_EXACT_LINE_CARDINALITY_FAIL")
required = [
    'SNAP="$ORCH/oclp7-d97ad/snapshot-v2"',
    '[oclp7-snapshot-v2]',
    'GITHUB_WORKFLOW=oclp7-d97ad-build-v2.yml',
    'ROOT_PATCH=AUTO-NO',
    'REBOOT=AUTO-NO',
]
missing = [x for x in required if x not in s]
print('D97AEL_REQUIRED_ANCHORS_MISSING=' + repr(missing))
if missing:
    raise SystemExit('D97AEL_STATIC_ANCHOR_FAIL')
forbidden = []
for line in s.splitlines():
    q = line.strip().lower()
    if q.startswith(('/sbin/reboot', 'sudo /sbin/reboot', 'shutdown -r', 'sudo shutdown -r')):
        forbidden.append(line)
    if 'start_root_patch' in q or 'patch_root_volume(' in q:
        forbidden.append(line)
print('D97AEL_FORBIDDEN_AUTOMATION_LINES=' + repr(forbidden))
if forbidden:
    raise SystemExit('D97AEL_FORBIDDEN_AUTOMATION_FAIL')
print('D97AEL_STATIC_CONTRACT_AUDIT=PASS')
PY

echo "===== EXECUTE PATH-HARDENED D97AEK WRAPPER ====="
set +e
/bin/zsh "$FIXED"
RC=$?
set -e
echo "D97AEL_INNER_D97AEK_RC=$RC"
[[ "$RC" -eq 0 ]] || fail "INNER_D97AEK_FAILED_RC:$RC"

echo "===== FINAL ====="
echo "D97AEK_STALE_GIT_ADD_PATH=CORRECTED_TO_snapshot-v2"
echo "D97AEL_PRIVATE_GITHUB_SYNC=PASS"
echo "D97AEL_INNER_D97AEK_RC=0"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_monitor_private_GitHub_Actions_v2_build"
echo "REPORT=$REPORT"
