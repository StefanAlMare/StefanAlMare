#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEK_THREE_FILE_PRIVATE_GITHUB_SYNC_WRAPPER_REPORT.txt"
BASE_COMMIT="d755e45b28031a2fca859b7387b071c82e89da5c"
BASE_BLOB_EXPECTED="c04b7c31068c74016cbfd162abb33870449cd2b6"
BASE_NAME="OCLP7_D97AD_SYNC_LOCAL_SOURCE_TO_PRIVATE_GITHUB.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
EXPECTED_METAL_WORK_GIT_BLOB="2ea2a73c1642892d14168168b7961b3385cece81"
EXPECTED_METAL_BASE_GIT_BLOB="b44be4c2f773b75e3cee3ac301dc221229cfb7cb"
EXPECTED_METAL_WORK_SHA256="fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24"
TMP="$(/usr/bin/mktemp -d -t oclp7-d97aek)"
BASE="$TMP/$BASE_NAME"
FIXED="$TMP/OCLP7_D97AEK_THREE_FILE_SYNC_CORE.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1

fail() {
  echo "D97AEK_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEK — EXACT THREE-FILE PRIVATE GITHUB SYNC WRAPPER ====="
echo "CLASSIFICATION=D97AEJ_METAL_3802_CHANGE_IS_REQUIRED_TAHOE_COMPILER_SUBSTRATE_NOT_ACCIDENTAL"
echo "AUTHORIZED_TRACKED_FILES=metal_3802.py,sys_patch.py,sys_patch_helpers.py"
echo "METAL_3802_WORK_SHA256_EXPECTED=$EXPECTED_METAL_WORK_SHA256"
echo "SNAPSHOT_DESTINATION=oclp7-d97ad/snapshot-v2"
echo "GITHUB_WORKFLOW=oclp7-d97ad-build-v2.yml"
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
echo "D97AEK_BASE_BLOB_ACTUAL=$BASE_BLOB_ACTUAL"
echo "D97AEK_BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
[[ "$BASE_BLOB_ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$BASE_BLOB_ACTUAL"
echo "D97AEK_BASE_IDENTITY=PASS"

/usr/local/bin/python3 - "$BASE" "$FIXED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
s = src.read_text()

replacements = [
    (
        'REPORT="$HOME/Desktop/OCLP7_D97AD_SYNC_LOCAL_SOURCE_TO_PRIVATE_GITHUB_REPORT.txt"',
        'REPORT="$HOME/Desktop/OCLP7_D97AEK_THREE_FILE_PRIVATE_GITHUB_SYNC_CORE_REPORT.txt"',
    ),
    (
        'ALLOWED_2="opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"\n',
        'ALLOWED_2="opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"\nALLOWED_3="opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"\n',
    ),
    (
        'if [[ -d "$C/.git" && -f "$C/$ALLOWED_1" && -f "$C/$ALLOWED_2" ]]; then',
        'if [[ -d "$C/.git" && -f "$C/$ALLOWED_1" && -f "$C/$ALLOWED_2" && -f "$C/$ALLOWED_3" ]]; then',
    ),
    (
        "printf '%s\\n%s\\n' \"$ALLOWED_1\" \"$ALLOWED_2\" | /usr/bin/sort > \"$TMP/allowed.txt\"",
        "printf '%s\\n%s\\n%s\\n' \"$ALLOWED_1\" \"$ALLOWED_2\" \"$ALLOWED_3\" | /usr/bin/sort > \"$TMP/allowed.txt\"",
    ),
    (
        'git -C "$PROJECT_ROOT" diff --check HEAD -- "$ALLOWED_1" "$ALLOWED_2"',
        'git -C "$PROJECT_ROOT" diff --check HEAD -- "$ALLOWED_1" "$ALLOWED_2" "$ALLOWED_3"',
    ),
    (
        '"$PYTHON_BIN" --version 2>&1\n\n"$PYTHON_BIN" - "$PROJECT_ROOT" <<\'PY\'',
        '''"$PYTHON_BIN" --version 2>&1

METAL_PATH="$PROJECT_ROOT/$ALLOWED_3"
METAL_BASE_BLOB="$(git -C "$PROJECT_ROOT" rev-parse "HEAD:$ALLOWED_3")"
METAL_WORK_BLOB="$(git -C "$PROJECT_ROOT" hash-object "$METAL_PATH")"
METAL_WORK_SHA256="$(shasum -a 256 "$METAL_PATH" | awk '{print $1}')"
echo "METAL_3802_BASE_GIT_BLOB=$METAL_BASE_BLOB"
echo "METAL_3802_WORK_GIT_BLOB=$METAL_WORK_BLOB"
echo "METAL_3802_WORK_SHA256=$METAL_WORK_SHA256"
[[ "$METAL_BASE_BLOB" == "b44be4c2f773b75e3cee3ac301dc221229cfb7cb" ]] || fail "METAL_BASE_BLOB_MISMATCH:$METAL_BASE_BLOB"
[[ "$METAL_WORK_BLOB" == "2ea2a73c1642892d14168168b7961b3385cece81" ]] || fail "METAL_WORK_BLOB_MISMATCH:$METAL_WORK_BLOB"
[[ "$METAL_WORK_SHA256" == "fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24" ]] || fail "METAL_WORK_SHA_MISMATCH:$METAL_WORK_SHA256"
"$PYTHON_BIN" - "$METAL_PATH" <<'PYMETAL'
from pathlib import Path
import sys
p = Path(sys.argv[1])
s = p.read_text()
compile(s, str(p), 'exec')
required = [
    '/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices',
    'MTLCompilerService.xpc',
    '12.5-3802-23',
    'MTLCompiler.framework',
    'GPUCompiler.framework',
    '14.2 Beta 1',
]
missing = [x for x in required if x not in s]
print('METAL_3802_REQUIRED_TOKENS_MISSING=' + repr(missing))
if missing:
    raise SystemExit('METAL_3802_REQUIRED_TOKEN_MISSING')
print('METAL_3802_TAHOE_COMPILER_SUBSTRATE=PASS')
PYMETAL

"$PYTHON_BIN" - "$PROJECT_ROOT" <<'PY' ''',
    ),
    (
        '/bin/cp -p "$PROJECT_ROOT/$ALLOWED_2" "$STAGE/$ALLOWED_2"',
        '/bin/cp -p "$PROJECT_ROOT/$ALLOWED_2" "$STAGE/$ALLOWED_2"\n/bin/cp -p "$PROJECT_ROOT/$ALLOWED_3" "$STAGE/$ALLOWED_3"',
    ),
    (
        'SNAPSHOT_FORMAT=git_archive_HEAD_plus_exact_two_worktree_overrides',
        'SNAPSHOT_FORMAT=git_archive_HEAD_plus_exact_three_worktree_overrides',
    ),
    (
        'echo "HELPERS_SHA256=$(shasum -a 256 "$PROJECT_ROOT/$ALLOWED_2" | awk \'{print $1}\')"',
        'echo "HELPERS_SHA256=$(shasum -a 256 "$PROJECT_ROOT/$ALLOWED_2" | awk \'{print $1}\')"\n  echo "METAL_3802_SHA256=$(shasum -a 256 "$PROJECT_ROOT/$ALLOWED_3" | awk \'{print $1}\')"',
    ),
    (
        'git -C "$PROJECT_ROOT" diff --binary HEAD -- "$ALLOWED_1" "$ALLOWED_2" > "$META/git-diff.patch"',
        'git -C "$PROJECT_ROOT" diff --binary HEAD -- "$ALLOWED_1" "$ALLOWED_2" "$ALLOWED_3" > "$META/git-diff.patch"',
    ),
    (
        'SNAP="$ORCH/oclp7-d97ad/snapshot"',
        'SNAP="$ORCH/oclp7-d97ad/snapshot-v2"',
    ),
    (
        'OCLP7 D97AD exact local source snapshot [oclp7-snapshot]',
        'OCLP7 D97AD exact three-file local source snapshot [oclp7-snapshot-v2]',
    ),
]

for old, new in replacements:
    count = s.count(old)
    print(f'D97AEK_TRANSFORM_MATCH_COUNT={old[:72]!r}|COUNT={count}')
    if count != 1:
        raise SystemExit(f'D97AEK_TRANSFORM_CARDINALITY_FAIL:{old!r}:{count}')
    s = s.replace(old, new, 1)

dst.write_text(s)
dst.chmod(0o755)
print('D97AEK_EXACT_THREE_FILE_TRANSFORM=PASS')
PY

/bin/zsh -n "$FIXED"
echo "D97AEK_FIXED_CORE_ZSH_PARSE=PASS"

/usr/local/bin/python3 - "$FIXED" <<'PY'
from pathlib import Path
import sys
s = Path(sys.argv[1]).read_text()
required = [
    'ALLOWED_3="opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"',
    'METAL_3802_BASE_GIT_BLOB=',
    'METAL_3802_WORK_GIT_BLOB=',
    'METAL_3802_WORK_SHA256=',
    'SNAPSHOT_FORMAT=git_archive_HEAD_plus_exact_three_worktree_overrides',
    'SNAP="$ORCH/oclp7-d97ad/snapshot-v2"',
    '[oclp7-snapshot-v2]',
    'ROOT_PATCH=AUTO-NO',
    'REBOOT=AUTO-NO',
]
missing = [x for x in required if x not in s]
print('D97AEK_REQUIRED_ANCHORS_MISSING=' + repr(missing))
if missing:
    raise SystemExit('D97AEK_STATIC_ANCHOR_FAIL')
forbidden = []
for line in s.splitlines():
    q = line.strip().lower()
    if q.startswith(('/sbin/reboot', 'sudo /sbin/reboot', 'shutdown -r', 'sudo shutdown -r')):
        forbidden.append(line)
    if 'start_root_patch' in q or 'patch_root_volume(' in q:
        forbidden.append(line)
print('D97AEK_FORBIDDEN_AUTOMATION_LINES=' + repr(forbidden))
if forbidden:
    raise SystemExit('D97AEK_FORBIDDEN_AUTOMATION_FAIL')
print('D97AEK_STATIC_CONTRACT_AUDIT=PASS')
PY

echo "===== EXECUTE EXACT THREE-FILE SYNC CORE ====="
set +e
/bin/zsh "$FIXED"
RC=$?
set -e
echo "D97AEK_CORE_RC=$RC"
[[ "$RC" -eq 0 ]] || fail "CORE_FAILED_RC:$RC"

echo "===== FINAL ====="
echo "D97AEJ_METAL_3802_CLASSIFICATION=REQUIRED_TAHOE_COMPILER_SUBSTRATE"
echo "D97AEK_THREE_FILE_SNAPSHOT_SCOPE=AUTHORIZED"
echo "D97AEK_PRIVATE_GITHUB_SYNC=PASS"
echo "D97AEK_CORE_RC=0"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_monitor_private_GitHub_Actions_v2_build"
echo "REPORT=$REPORT"
