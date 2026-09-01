#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AD_SYNC_LOCAL_SOURCE_TO_PRIVATE_GITHUB_REPORT.txt"
PRIVATE_REPO="StefanAlMare/Private-Work"
PRIVATE_URL="https://github.com/${PRIVATE_REPO}.git"
TARGET_BRANCH="oclp7-d97ad-github-build"
EXPECTED_HEAD="4143b7077a9a4e5aa41ec7a06c0888597eda9b06"
EXPECTED_SOURCE_BRANCH="alex-tahoe-25G82-custom"
ALLOWED_1="opencore_legacy_patcher/sys_patch/sys_patch.py"
ALLOWED_2="opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"

exec > >(tee "$REPORT") 2>&1
fail() {
  echo "OCLP7_D97AD_SYNC_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

TMP="$(/usr/bin/mktemp -d -t oclp7-d97ad-sync)"
trap '/bin/rm -rf "$TMP"' EXIT

echo "===== OCLP7 D97AD — SYNC EXACT LOCAL SOURCE TO PRIVATE GITHUB BUILD LANE ====="
echo "PRIVATE_REPO=$PRIVATE_REPO"
echo "TARGET_BRANCH=$TARGET_BRANCH"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for t in git python3 tar gzip shasum split awk sed sort comm cp mkdir rm; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done

PROJECT_ROOT=""
for C in \
  "/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82" \
  "/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82" \
  "$HOME/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
do
  if [[ -d "$C/.git" && -f "$C/$ALLOWED_1" && -f "$C/$ALLOWED_2" ]]; then
    PROJECT_ROOT="$C"
    break
  fi
done
[[ -n "$PROJECT_ROOT" ]] || fail "PROJECT_ROOT_NOT_FOUND"
echo "PROJECT_ROOT=$PROJECT_ROOT"

SOURCE_BRANCH="$(git -C "$PROJECT_ROOT" branch --show-current)"
SOURCE_HEAD="$(git -C "$PROJECT_ROOT" rev-parse HEAD)"
echo "SOURCE_BRANCH=$SOURCE_BRANCH"
echo "SOURCE_HEAD=$SOURCE_HEAD"
[[ "$SOURCE_BRANCH" == "$EXPECTED_SOURCE_BRANCH" ]] || fail "SOURCE_BRANCH_MISMATCH:$SOURCE_BRANCH"
[[ "$SOURCE_HEAD" == "$EXPECTED_HEAD" ]] || fail "SOURCE_HEAD_MISMATCH:$SOURCE_HEAD"

CHANGED_FILE_LIST="$TMP/git-diff-files.txt"
git -C "$PROJECT_ROOT" diff --name-only HEAD -- | /usr/bin/sort > "$CHANGED_FILE_LIST"
printf '%s\n%s\n' "$ALLOWED_1" "$ALLOWED_2" | /usr/bin/sort > "$TMP/allowed.txt"
echo "SOURCE_TRACKED_CHANGED_FILES=$(tr '\n' ',' < "$CHANGED_FILE_LIST" | sed 's/,$//')"
if ! /usr/bin/cmp -s "$CHANGED_FILE_LIST" "$TMP/allowed.txt"; then
  echo "EXPECTED_CHANGED_FILES=$(tr '\n' ',' < "$TMP/allowed.txt" | sed 's/,$//')"
  fail "TRACKED_CHANGED_FILE_SET_MISMATCH"
fi
echo "SOURCE_TRACKED_CHANGED_FILE_SET=PASS"

git -C "$PROJECT_ROOT" diff --check HEAD -- "$ALLOWED_1" "$ALLOWED_2"
echo "SOURCE_GIT_DIFF_CHECK=PASS"

PYTHON_BIN=""
for P in \
  "$PROJECT_ROOT/.venv/bin/python" \
  "$HOME/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82/.venv/bin/python" \
  "/usr/local/bin/python3" \
  "$(command -v python3)"
do
  if [[ -n "$P" && -x "$P" ]]; then
    PYTHON_BIN="$P"
    break
  fi
done
[[ -n "$PYTHON_BIN" ]] || fail "PYTHON_NOT_FOUND"
echo "PYTHON_BIN=$PYTHON_BIN"
"$PYTHON_BIN" --version 2>&1

"$PYTHON_BIN" - "$PROJECT_ROOT" <<'PY'
from __future__ import annotations
import ast
import hashlib
import sys
from pathlib import Path

root = Path(sys.argv[1])
helpers_path = root / 'opencore_legacy_patcher/sys_patch/sys_patch_helpers.py'
syspatch_path = root / 'opencore_legacy_patcher/sys_patch/sys_patch.py'
helpers_text = helpers_path.read_text()
syspatch_text = syspatch_path.read_text()
compile(helpers_text, str(helpers_path), 'exec')
compile(syspatch_text, str(syspatch_path), 'exec')
print('SOURCE_COMPILE_NOWRITE=PASS')

ht = ast.parse(helpers_text)
st = ast.parse(syspatch_text)
names = {
    'selector': 'patch_mtl_compiler_service_version_selector',
    'd97z': 'patch_mtl_compiler_service_tahoe_d97z_llvmversion_exit_classifier',
    'control': 'patch_mtl_compiler_tahoe_true_five_clean_control',
    'p6': 'patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports',
    'p7': 'patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports',
    'd97': 'patch_mtl_compiler_tahoe_d97_six_counter_terminal_register_snapshot',
    'd97ad': 'patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier',
}
expected = {'selector':1,'d97z':0,'control':1,'p6':1,'p7':1,'d97':0,'d97ad':1}
methods = {name: [] for name in names.values()}
for node in ast.walk(ht):
    if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)) and node.name in methods:
        methods[node.name].append(node)
for key, name in names.items():
    count = len(methods[name])
    print(f'SOURCE_HELPER_COUNT={key}|COUNT={count}')
    if count != expected[key]:
        raise SystemExit(f'POST_TRANSITION_HELPER_COUNT_MISMATCH:{key}:{count}')
print('POST_TRANSITION_HELPER_CARDINALITY=PASS')

d97ad = methods[names['d97ad']][0]
d97ad_src = ast.get_source_segment(helpers_text, d97ad) or ''
required = [
    '6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda',
    '524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755',
    '8b8d10feffff83f941','6a6e5fe9bb38f6ff90',
    '488d3599640200b91e000000','6a6f5fe9ac3bf6ff90909090',
    '488d359764020083fa10','6a705fe96d3bf6ff9090',
    '488d35cc63020031c0','6a715fe9643af6ff90',
    '4489f04881c488030000','6a725fe98d3df6ff9090',
    '488dbd20feffffe8c45c0100','6a725fe97a37f6ff90909090',
    'b8010000020f050f0b',
]
missing = [x for x in required if x not in d97ad_src]
print('D97AD_REQUIRED_RUNTIME_TOKENS_MISSING=' + repr(missing))
if missing:
    raise SystemExit('D97AD_RUNTIME_TOKEN_MISSING')
root_calls = d97ad_src.count('run_as_root_and_verify')
print(f'D97AD_RUN_AS_ROOT_AND_VERIFY_COUNT={root_calls}')
if root_calls != 3:
    raise SystemExit('D97AD_PRIVILEGED_CALL_COUNT_MISMATCH')

targets = set(names.values())
records = []
for node in ast.walk(st):
    if isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute) and node.func.attr in targets:
        records.append((node.lineno, node.func.attr, ast.unparse(node.func.value)))
records.sort()
actual_order = [name for _, name, _ in records]
expected_order = [names['selector'], names['control'], names['p6'], names['p7'], names['d97ad']]
print('SOURCE_ACTIVE_TARGET_CALL_ORDER=' + repr(actual_order))
if actual_order != expected_order:
    raise SystemExit('POST_TRANSITION_CALL_ORDER_MISMATCH')
if {r for _, _, r in records} != {'sys_patch_helpers.SysPatchHelpers(self.constants)'}:
    raise SystemExit('POST_TRANSITION_CALL_RECEIVER_MISMATCH')
print('POST_TRANSITION_CALL_ORDER_AND_RECEIVER=PASS')
print('SOURCE_SHA256=sys_patch.py|' + hashlib.sha256(syspatch_path.read_bytes()).hexdigest())
print('SOURCE_SHA256=sys_patch_helpers.py|' + hashlib.sha256(helpers_path.read_bytes()).hexdigest())
print('D97AD_LOCAL_SOURCE_STATE=STATIC_PROVEN')
PY

STAGE="$TMP/stage"
/bin/mkdir -p "$STAGE"
echo "===== CREATE EXACT TRACKED WORKING-TREE SNAPSHOT ====="
git -C "$PROJECT_ROOT" archive --format=tar HEAD | /usr/bin/tar -xf - -C "$STAGE"
/bin/cp -p "$PROJECT_ROOT/$ALLOWED_1" "$STAGE/$ALLOWED_1"
/bin/cp -p "$PROJECT_ROOT/$ALLOWED_2" "$STAGE/$ALLOWED_2"

META="$STAGE/.oclp7-snapshot"
/bin/mkdir -p "$META"
{
  echo "SNAPSHOT_FORMAT=git_archive_HEAD_plus_exact_two_worktree_overrides"
  echo "SOURCE_BRANCH=$SOURCE_BRANCH"
  echo "SOURCE_HEAD=$SOURCE_HEAD"
  echo "SOURCE_PRODUCT_VERSION=$(sw_vers -productVersion)"
  echo "SOURCE_BUILD_VERSION=$(sw_vers -buildVersion)"
  echo "SOURCE_ARCH=$(uname -m)"
  echo "EXPECTED_SELECTOR_ONLY_SERVICE_SHA=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
  echo "EXPECTED_D97AD_FINAL_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
  echo "SYSPATCH_SHA256=$(shasum -a 256 "$PROJECT_ROOT/$ALLOWED_1" | awk '{print $1}')"
  echo "HELPERS_SHA256=$(shasum -a 256 "$PROJECT_ROOT/$ALLOWED_2" | awk '{print $1}')"
} > "$META/SNAPSHOT_MANIFEST.env"
/bin/cp "$CHANGED_FILE_LIST" "$META/git-diff-files.txt"
git -C "$PROJECT_ROOT" diff --binary HEAD -- "$ALLOWED_1" "$ALLOWED_2" > "$META/git-diff.patch"
git -C "$PROJECT_ROOT" status --porcelain=v1 > "$META/git-status-porcelain.txt"

ARCHIVE="$TMP/source.tar.gz"
/usr/bin/tar -czf "$ARCHIVE" -C "$STAGE" .
ARCHIVE_SHA="$(shasum -a 256 "$ARCHIVE" | awk '{print $1}')"
ARCHIVE_SIZE="$(stat -f%z "$ARCHIVE")"
echo "SOURCE_ARCHIVE_SHA256=$ARCHIVE_SHA"
echo "SOURCE_ARCHIVE_SIZE=$ARCHIVE_SIZE"

PARTS="$TMP/parts"
/bin/mkdir -p "$PARTS"
/usr/bin/split -b 70m -d -a 3 "$ARCHIVE" "$PARTS/source.tar.gz.part-"
PART_COUNT="$(find "$PARTS" -type f -name 'source.tar.gz.part-*' | wc -l | tr -d ' ')"
echo "SOURCE_ARCHIVE_PART_COUNT=$PART_COUNT"
[[ "$PART_COUNT" -ge 1 ]] || fail "ARCHIVE_SPLIT_FAILED"

ORCH="$TMP/private-work"
echo "===== COPY SNAPSHOT TO PRIVATE GITHUB ====="
GIT_TERMINAL_PROMPT=1 git clone --depth 1 --single-branch --branch "$TARGET_BRANCH" "$PRIVATE_URL" "$ORCH"
SNAP="$ORCH/oclp7-d97ad/snapshot"
/bin/rm -rf "$SNAP"
/bin/mkdir -p "$SNAP"
/bin/cp "$PARTS"/source.tar.gz.part-* "$SNAP/"
printf '%s  %s\n' "$ARCHIVE_SHA" "source.tar.gz" > "$SNAP/source.tar.gz.sha256"
/bin/cp "$META/SNAPSHOT_MANIFEST.env" "$SNAP/SNAPSHOT_MANIFEST.env"
/bin/cp "$META/git-diff-files.txt" "$SNAP/git-diff-files.txt"
/bin/cp "$META/git-diff.patch" "$SNAP/git-diff.patch"
/bin/cp "$META/git-status-porcelain.txt" "$SNAP/git-status-porcelain.txt"

if [[ -z "$(git -C "$ORCH" config user.name || true)" ]]; then
  git -C "$ORCH" config user.name "Alex Dedu OCLP7 Sync"
fi
if [[ -z "$(git -C "$ORCH" config user.email || true)" ]]; then
  git -C "$ORCH" config user.email "92223268+StefanAlMare@users.noreply.github.com"
fi

git -C "$ORCH" add oclp7-d97ad/snapshot
git -C "$ORCH" commit -m "OCLP7 D97AD exact local source snapshot [oclp7-snapshot]"
GIT_TERMINAL_PROMPT=1 git -C "$ORCH" push origin "$TARGET_BRANCH"
PUSHED_COMMIT="$(git -C "$ORCH" rev-parse HEAD)"

echo "===== FINAL ====="
echo "OCLP7_D97AD_LOCAL_SOURCE_AUDIT=PASS"
echo "OCLP7_D97AD_SOURCE_SNAPSHOT_CREATED=PASS"
echo "OCLP7_D97AD_PRIVATE_GITHUB_PUSH=PASS"
echo "PUSHED_COMMIT=$PUSHED_COMMIT"
echo "ACTIONS_URL=https://github.com/${PRIVATE_REPO}/actions"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=GitHub_Actions_build_and_packaged_app_audit_started_by_push"
echo "REPORT=$REPORT"
