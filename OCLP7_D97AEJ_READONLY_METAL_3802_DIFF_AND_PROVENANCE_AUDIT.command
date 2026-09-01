#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEJ_READONLY_METAL_3802_DIFF_AND_PROVENANCE_AUDIT_REPORT.txt"
exec > >(tee "$REPORT") 2>&1

fail() {
  echo "D97AEJ_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEJ — READ-ONLY metal_3802.py DIFF / PROVENANCE AUDIT ====="
echo "PURPOSE=classify_the_unexpected_third_tracked_change_before_deciding_private_GitHub_snapshot_scope"
echo "INPUT_SYNC=tracked_changed_files_are_metal_3802.py_plus_sys_patch.py_plus_sys_patch_helpers.py"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "BUILD=AUTO-NO"
echo "DEPLOY=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for t in git python3 shasum diff stat; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
python3 --version 2>&1

PROJECT_ROOT=""
for C in \
  "/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82" \
  "/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82" \
  "$HOME/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
do
  if [[ -f "$C/opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py" ]]; then
    PROJECT_ROOT="$C"
    break
  fi
done
[[ -n "$PROJECT_ROOT" ]] || fail "PROJECT_ROOT_NOT_FOUND"

echo "PROJECT_ROOT=$PROJECT_ROOT"
BRANCH="$(git -C "$PROJECT_ROOT" branch --show-current)"
HEAD_SHA="$(git -C "$PROJECT_ROOT" rev-parse HEAD)"
echo "PROJECT_BRANCH=$BRANCH"
echo "PROJECT_HEAD=$HEAD_SHA"
[[ "$BRANCH" == "alex-tahoe-25G82-custom" ]] || fail "UNEXPECTED_BRANCH:$BRANCH"
[[ "$HEAD_SHA" == "4143b7077a9a4e5aa41ec7a06c0888597eda9b06" ]] || fail "UNEXPECTED_HEAD:$HEAD_SHA"

METAL_PATH="opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"
SYSPATCH_PATH="opencore_legacy_patcher/sys_patch/sys_patch.py"
HELPERS_PATH="opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"
METAL_FILE="$PROJECT_ROOT/$METAL_PATH"
[[ -f "$METAL_FILE" ]] || fail "METAL_3802_FILE_MISSING"

CHANGED="$(git -C "$PROJECT_ROOT" diff --name-only -- | /usr/bin/sort)"
echo "SOURCE_TRACKED_CHANGED_FILES=$(echo "$CHANGED" | /usr/bin/tr '\n' ',' | /usr/bin/sed 's/,$//')"
EXPECTED="$(printf '%s\n' "$METAL_PATH" "$SYSPATCH_PATH" "$HELPERS_PATH" | /usr/bin/sort)"
if [[ "$CHANGED" != "$EXPECTED" ]]; then
  echo "EXPECTED_TRACKED_CHANGED_FILES=$(echo "$EXPECTED" | /usr/bin/tr '\n' ',' | /usr/bin/sed 's/,$//')"
  fail "TRACKED_CHANGED_FILE_SET_CHANGED_SINCE_SYNC_FAILURE"
fi
echo "EXPECTED_THREE_FILE_STATE=PASS"

TMP="$(/usr/bin/mktemp -d -t oclp7-d97aej)"
BASE="$TMP/metal_3802.base.py"
WORK="$TMP/metal_3802.work.py"
trap '/bin/rm -rf "$TMP"' EXIT

git -C "$PROJECT_ROOT" show "HEAD:$METAL_PATH" > "$BASE"
/bin/cp "$METAL_FILE" "$WORK"

BASE_GIT_BLOB="$(git -C "$PROJECT_ROOT" rev-parse "HEAD:$METAL_PATH")"
WORK_GIT_BLOB="$(git hash-object "$WORK")"
BASE_SHA256="$(shasum -a 256 "$BASE" | awk '{print $1}')"
WORK_SHA256="$(shasum -a 256 "$WORK" | awk '{print $1}')"
echo "METAL_3802_BASE_GIT_BLOB=$BASE_GIT_BLOB"
echo "METAL_3802_WORK_GIT_BLOB=$WORK_GIT_BLOB"
echo "METAL_3802_BASE_SHA256=$BASE_SHA256"
echo "METAL_3802_WORK_SHA256=$WORK_SHA256"
[[ "$BASE_GIT_BLOB" != "$WORK_GIT_BLOB" ]] || fail "METAL_3802_REPORTED_CHANGED_BUT_BLOBS_EQUAL"

BASE_BYTES="$(wc -c < "$BASE" | tr -d ' ')"
WORK_BYTES="$(wc -c < "$WORK" | tr -d ' ')"
BASE_LINES="$(wc -l < "$BASE" | tr -d ' ')"
WORK_LINES="$(wc -l < "$WORK" | tr -d ' ')"
echo "METAL_3802_BASE_SIZE_BYTES=$BASE_BYTES"
echo "METAL_3802_WORK_SIZE_BYTES=$WORK_BYTES"
echo "METAL_3802_BASE_LINE_COUNT=$BASE_LINES"
echo "METAL_3802_WORK_LINE_COUNT=$WORK_LINES"

/usr/bin/stat -f 'METAL_3802_WORK_STAT=mtime_epoch:%m|mtime:%Sm|ctime_epoch:%c|ctime:%Sc|size:%z|mode:%Sp' -t '%Y-%m-%d %H:%M:%S %Z' "$METAL_FILE"

set +e
DIFF_CHECK_OUTPUT="$(git -C "$PROJECT_ROOT" diff --check -- "$METAL_PATH" 2>&1)"
DIFF_CHECK_RC=$?
set -e
echo "METAL_3802_GIT_DIFF_CHECK_RC=$DIFF_CHECK_RC"
if [[ -n "$DIFF_CHECK_OUTPUT" ]]; then
  echo "METAL_3802_GIT_DIFF_CHECK_OUTPUT_BEGIN"
  echo "$DIFF_CHECK_OUTPUT"
  echo "METAL_3802_GIT_DIFF_CHECK_OUTPUT_END"
fi

NUMSTAT="$(git -C "$PROJECT_ROOT" diff --numstat -- "$METAL_PATH")"
SHORTSTAT="$(git -C "$PROJECT_ROOT" diff --shortstat -- "$METAL_PATH")"
echo "METAL_3802_DIFF_NUMSTAT=$NUMSTAT"
echo "METAL_3802_DIFF_SHORTSTAT=$SHORTSTAT"

python3 - "$BASE" "$WORK" <<'PY'
from __future__ import annotations

import ast
import collections
import hashlib
import json
import sys
from pathlib import Path

base_path = Path(sys.argv[1])
work_path = Path(sys.argv[2])
base_text = base_path.read_text()
work_text = work_path.read_text()

compile(base_text, str(base_path), "exec")
compile(work_text, str(work_path), "exec")
print("METAL_3802_BASE_COMPILE=PASS")
print("METAL_3802_WORK_COMPILE=PASS")

base_tree = ast.parse(base_text)
work_tree = ast.parse(work_text)

def digest_node(node: ast.AST) -> str:
    payload = ast.dump(node, annotate_fields=True, include_attributes=False)
    return hashlib.sha256(payload.encode()).hexdigest()

base_module_digest = digest_node(base_tree)
work_module_digest = digest_node(work_tree)
print(f"METAL_3802_BASE_AST_SHA256={base_module_digest}")
print(f"METAL_3802_WORK_AST_SHA256={work_module_digest}")
semantic_equal = base_module_digest == work_module_digest
print(f"METAL_3802_AST_SEMANTIC_IDENTITY={'PASS' if semantic_equal else 'DIFFERENT'}")


def node_key(node: ast.AST, index: int) -> str:
    if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
        return f"{type(node).__name__}:{node.name}"
    if isinstance(node, (ast.Import, ast.ImportFrom)):
        return f"{type(node).__name__}:{ast.dump(node, include_attributes=False)}"
    if isinstance(node, (ast.Assign, ast.AnnAssign)):
        if isinstance(node, ast.Assign):
            targets = node.targets
        else:
            targets = [node.target]
        names = []
        for target in targets:
            if isinstance(target, ast.Name):
                names.append(target.id)
            elif isinstance(target, ast.Attribute):
                names.append(ast.unparse(target))
            else:
                names.append(ast.dump(target, include_attributes=False))
        return f"{type(node).__name__}:{','.join(names)}"
    return f"{type(node).__name__}:index{index}"


def map_top(tree: ast.Module):
    out: dict[str, list[str]] = collections.defaultdict(list)
    for i, node in enumerate(tree.body):
        out[node_key(node, i)].append(digest_node(node))
    return out

base_top = map_top(base_tree)
work_top = map_top(work_tree)
keys = sorted(set(base_top) | set(work_top))
changed = []
for key in keys:
    if base_top.get(key) != work_top.get(key):
        changed.append(key)
        print(
            "METAL_3802_CHANGED_TOP_LEVEL_NODE="
            + key
            + "|BASE=" + repr(base_top.get(key, []))
            + "|WORK=" + repr(work_top.get(key, []))
        )
print(f"METAL_3802_CHANGED_TOP_LEVEL_NODE_COUNT={len(changed)}")


def constants(tree: ast.AST):
    c = collections.Counter()
    for node in ast.walk(tree):
        if isinstance(node, ast.Constant):
            value = node.value
            key = (type(value).__name__, repr(value))
            c[key] += 1
    return c

bc = constants(base_tree)
wc = constants(work_tree)
removed = bc - wc
added = wc - bc
print(f"METAL_3802_REMOVED_CONSTANT_DISTINCT_COUNT={len(removed)}")
for (typ, value), count in sorted(removed.items(), key=lambda x: (x[0][0], x[0][1])):
    print(f"METAL_3802_REMOVED_CONSTANT=TYPE={typ}|VALUE={value}|COUNT={count}")
print(f"METAL_3802_ADDED_CONSTANT_DISTINCT_COUNT={len(added)}")
for (typ, value), count in sorted(added.items(), key=lambda x: (x[0][0], x[0][1])):
    print(f"METAL_3802_ADDED_CONSTANT=TYPE={typ}|VALUE={value}|COUNT={count}")

for token in (
    "MTLCompilerService", "MTLCompiler.framework", "GPUCompiler.framework",
    "MetallibSupportPkg", "31001", "32023", "3802", "26.6.2", "25G82",
    "D97", "D97AD", "Tahoe"
):
    print(
        f"METAL_3802_TOKEN_COUNT={token}|BASE={base_text.count(token)}|WORK={work_text.count(token)}"
    )

if semantic_equal:
    classification = "NON_SEMANTIC_TEXT_ONLY"
else:
    classification = "SEMANTIC_CHANGE_REQUIRES_ASSISTANT_AUDIT"
print(f"METAL_3802_DIFF_CLASSIFICATION={classification}")
PY

echo "===== METAL_3802 EXACT GIT DIFF BEGIN ====="
git -C "$PROJECT_ROOT" --no-pager diff --no-ext-diff --unified=120 -- "$METAL_PATH"
echo "===== METAL_3802 EXACT GIT DIFF END ====="

echo "===== FINAL ====="
echo "D97AEJ_READONLY_METAL_3802_DIFF_AND_PROVENANCE_AUDIT=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "BUILD=AUTO-NO"
echo "DEPLOY=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_classify_metal_3802_change_and_decide_snapshot_scope"
echo "REPORT=$REPORT"
