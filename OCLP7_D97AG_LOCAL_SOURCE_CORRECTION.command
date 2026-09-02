#!/bin/zsh -f

set -euo pipefail

readonly DEFAULT_ROOT="/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
readonly EXPECTED_BRANCH="alex-tahoe-25G82-custom"
readonly EXPECTED_HEAD="4143b7077a9a4e5aa41ec7a06c0888597eda9b06"
readonly HELPERS_REL="opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"
readonly SYSPATCH_REL="opencore_legacy_patcher/sys_patch/sys_patch.py"
readonly METAL_REL="opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"

readonly PATCH_SHA256="2c4e93e57b2d13762ef90020496f87c2a95c7e39553ff60f948bfacd2b6b659b"
readonly PATCH_BLOB="532f8729658b3bc287fa83963043a4d2a8aa816a"
readonly PATCH_BYTES="3137"
readonly HELPERS_PRE_SHA256="a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e"
readonly HELPERS_POST_SHA256="ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2"
readonly SYSPATCH_PRE_SHA256="ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9"
readonly SYSPATCH_POST_SHA256="93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69"
readonly METAL_SHA256="fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24"
readonly D97AD_METHOD_SHA256="bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12"
readonly D97AF_METHOD_POST_SHA256="1abd24399b9c39b215d7c06ecaf18fdfe24faeb19a743ac2ea957a20c99dc8d5"
readonly XATTR_METHOD_POST_SHA256="d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019"

if (( $# > 2 )); then
    print -u2 -r -- "USAGE: $0 [SOURCE_ROOT] [D97AG_SOURCE_CORRECTION.patch]"
    exit 2
fi

readonly ROOT="${1:-$DEFAULT_ROOT}"
readonly SELF_DIR="${0:A:h}"
readonly PATCH="${2:-$SELF_DIR/D97AG_SOURCE_CORRECTION.patch}"
readonly HELPERS="$ROOT/$HELPERS_REL"
readonly SYSPATCH="$ROOT/$SYSPATCH_REL"
readonly METAL="$ROOT/$METAL_REL"

REPORT=""
BACKUP=""
BACKUP_HELPERS=""
BACKUP_SYSPATCH=""
BACKUP_METAL=""
MUTATION_STARTED=0
COMMITTED=0

emit() {
    print -r -- "$*"
    if [[ -n "$REPORT" && -f "$REPORT" && ! -L "$REPORT" ]]; then
        print -r -- "$*" >> "$REPORT"
    fi
}

sha256_file() {
    /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

byte_count() {
    /usr/bin/wc -c < "$1" | /usr/bin/tr -d '[:space:]'
}

restore_preimage() {
    local rollback_failed=0

    if [[ -n "$BACKUP_HELPERS" && -f "$BACKUP_HELPERS" && ! -L "$BACKUP_HELPERS" ]]; then
        /bin/cp -pf "$BACKUP_HELPERS" "$HELPERS" || rollback_failed=1
    else
        rollback_failed=1
    fi
    if [[ -n "$BACKUP_SYSPATCH" && -f "$BACKUP_SYSPATCH" && ! -L "$BACKUP_SYSPATCH" ]]; then
        /bin/cp -pf "$BACKUP_SYSPATCH" "$SYSPATCH" || rollback_failed=1
    else
        rollback_failed=1
    fi
    if [[ -n "$BACKUP_METAL" && -f "$BACKUP_METAL" && ! -L "$BACKUP_METAL" ]]; then
        /bin/cp -pf "$BACKUP_METAL" "$METAL" || rollback_failed=1
    else
        rollback_failed=1
    fi

    if (( rollback_failed == 0 )) && \
       [[ "$(sha256_file "$HELPERS")" == "$HELPERS_PRE_SHA256" ]] && \
       [[ "$(sha256_file "$SYSPATCH")" == "$SYSPATCH_PRE_SHA256" ]] && \
       [[ "$(sha256_file "$METAL")" == "$METAL_SHA256" ]]; then
        emit "D97AG_TRANSACTION_ROLLBACK=PASS"
        return 0
    fi

    emit "D97AG_TRANSACTION_ROLLBACK=FAIL"
    return 1
}

on_exit() {
    local original_rc=$?
    trap - EXIT HUP INT TERM

    if (( MUTATION_STARTED == 1 && COMMITTED == 0 )); then
        if ! restore_preimage; then
            original_rc=3
        fi
    fi

    exit "$original_rc"
}

trap on_exit EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

fail() {
    emit "D97AG_LOCAL_SOURCE_CORRECTION=FAIL_CLOSED|REASON=$1"
    emit "SOURCE_MUTATION_STATE=$([[ $MUTATION_STARTED == 1 ]] && print STARTED_ROLLBACK_REQUIRED || print NOT_STARTED)"
    emit "INSTALLED_APP_MUTATION=NO"
    emit "SYSTEM_TARGET_MUTATION=NO"
    emit "ROOT_PATCH=AUTO-NO|REBOOT=AUTO-NO|USER_ACTION_NOW=STOP"
    [[ -n "$BACKUP" ]] && emit "SOURCE_BACKUP=$BACKUP"
    [[ -n "$REPORT" ]] && emit "REPORT=$REPORT"
    exit 2
}

for tool in /usr/bin/git /usr/bin/shasum /usr/bin/awk /usr/bin/wc /usr/bin/tr \
            /usr/bin/mktemp /usr/bin/stat /usr/bin/id \
            /bin/cp /bin/chmod /bin/mkdir /bin/date; do
    [[ -x "$tool" ]] || fail "MISSING_TOOL_${tool:t}"
done

[[ -d "$HOME/Desktop" && ! -L "$HOME/Desktop" ]] || fail "DESKTOP_IDENTITY_INVALID"
umask 077
REPORT="$HOME/Desktop/OCLP7_D97AG_LOCAL_SOURCE_CORRECTION_REPORT_$(/bin/date +%Y%m%d-%H%M%S)_$$.txt"
setopt NO_CLOBBER
: > "$REPORT" || {
    unsetopt NO_CLOBBER
    fail "REPORT_CREATE_FAILED"
}
unsetopt NO_CLOBBER
/bin/chmod 0600 "$REPORT"

emit "===== OCLP7 D97AG — LOCAL D97AF SOURCE CORRECTION ====="
emit "PURPOSE=replace_packaged_incompatible_Python_xattr_API_and_make_shared_Metal_failure_fatal"
emit "SOURCE_ROOT=$ROOT"
emit "PATCH=$PATCH"
emit "SOURCE_MUTATION=PLANNED_EXACT_TWO_FILES_AFTER_ALL_GATES"
emit "INSTALLED_APP_MUTATION=NO"
emit "SYSTEM_TARGET_MUTATION=NO"
emit "GOLDEN_MUTATION=NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "REPORT=$REPORT"

[[ -d "$ROOT" && ! -L "$ROOT" ]] || fail "SOURCE_ROOT_IDENTITY_INVALID"
[[ -d "$ROOT/.git" && ! -L "$ROOT/.git" ]] || fail "SOURCE_GIT_DIRECTORY_INVALID"
[[ -f "$PATCH" && ! -L "$PATCH" ]] || fail "PATCH_IDENTITY_INVALID"

for source_file in "$HELPERS" "$SYSPATCH" "$METAL"; do
    [[ -f "$source_file" && ! -L "$source_file" ]] || fail "SOURCE_FILE_IDENTITY_INVALID_${source_file:t}"
    [[ "$(/usr/bin/stat -f '%l' "$source_file")" == "1" ]] || fail "SOURCE_FILE_LINK_COUNT_INVALID_${source_file:t}"
    [[ "$(/usr/bin/stat -f '%u' "$source_file")" == "$(/usr/bin/id -u)" ]] || fail "SOURCE_FILE_OWNER_INVALID_${source_file:t}"
done

actual_patch_sha="$(sha256_file "$PATCH")"
actual_patch_blob="$(/usr/bin/git hash-object "$PATCH")"
actual_patch_bytes="$(byte_count "$PATCH")"
emit "D97AG_PATCH_SHA256=$actual_patch_sha"
emit "D97AG_PATCH_BLOB=$actual_patch_blob"
emit "D97AG_PATCH_BYTES=$actual_patch_bytes"
[[ "$actual_patch_sha" == "$PATCH_SHA256" ]] || fail "PATCH_SHA256_MISMATCH"
[[ "$actual_patch_blob" == "$PATCH_BLOB" ]] || fail "PATCH_BLOB_MISMATCH"
[[ "$actual_patch_bytes" == "$PATCH_BYTES" ]] || fail "PATCH_BYTE_COUNT_MISMATCH"

actual_branch="$(/usr/bin/git -C "$ROOT" branch --show-current)"
actual_head="$(/usr/bin/git -C "$ROOT" rev-parse HEAD)"
emit "SOURCE_BRANCH=$actual_branch"
emit "SOURCE_HEAD=$actual_head"
[[ "$actual_branch" == "$EXPECTED_BRANCH" ]] || fail "SOURCE_BRANCH_MISMATCH"
[[ "$actual_head" == "$EXPECTED_HEAD" ]] || fail "SOURCE_HEAD_MISMATCH"

expected_status=$' M opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py\n M opencore_legacy_patcher/sys_patch/sys_patch.py\n M opencore_legacy_patcher/sys_patch/sys_patch_helpers.py'
actual_status="$(/usr/bin/git -C "$ROOT" status --short --untracked-files=no)"
[[ "$actual_status" == "$expected_status" ]] || fail "SOURCE_TRACKED_STATUS_MISMATCH"
emit "SOURCE_TRACKED_STATUS=EXACT_D97AF_THREE_FILES"

helpers_pre="$(sha256_file "$HELPERS")"
syspatch_pre="$(sha256_file "$SYSPATCH")"
metal_pre="$(sha256_file "$METAL")"
emit "HELPERS_PRE_SHA256=$helpers_pre"
emit "SYSPATCH_PRE_SHA256=$syspatch_pre"
emit "METAL_PRE_SHA256=$metal_pre"
[[ "$helpers_pre" == "$HELPERS_PRE_SHA256" ]] || fail "HELPERS_PREIMAGE_MISMATCH"
[[ "$syspatch_pre" == "$SYSPATCH_PRE_SHA256" ]] || fail "SYSPATCH_PREIMAGE_MISMATCH"
[[ "$metal_pre" == "$METAL_SHA256" ]] || fail "METAL_PREIMAGE_MISMATCH"

expected_numstat=$'39\t2\topencore_legacy_patcher/sys_patch/sys_patch_helpers.py\n2\t0\topencore_legacy_patcher/sys_patch/sys_patch.py'
actual_numstat="$(/usr/bin/git apply --numstat "$PATCH")"
[[ "$actual_numstat" == "$expected_numstat" ]] || fail "PATCH_PATH_OR_CARDINALITY_MISMATCH"
/usr/bin/git -C "$ROOT" apply --check --whitespace=nowarn -- "$PATCH" || fail "PATCH_CHECK_FAILED"
emit "D97AG_PATCH_SCOPE_AND_CHECK=PASS"

BACKUP="$(/usr/bin/mktemp -d "$HOME/Desktop/OCLP7_D97AG_SOURCE_BACKUP_$(/bin/date +%Y%m%d-%H%M%S).XXXXXX")" || fail "BACKUP_CREATE_FAILED"
[[ -d "$BACKUP" && ! -L "$BACKUP" ]] || fail "BACKUP_IDENTITY_INVALID"
/bin/chmod 0700 "$BACKUP"
BACKUP_HELPERS="$BACKUP/sys_patch_helpers.py.D97AF-pre-D97AG"
BACKUP_SYSPATCH="$BACKUP/sys_patch.py.D97AF-pre-D97AG"
BACKUP_METAL="$BACKUP/metal_3802.py.D97AF-unchanged"
/bin/cp -p "$HELPERS" "$BACKUP_HELPERS" || fail "BACKUP_HELPERS_COPY_FAILED"
/bin/cp -p "$SYSPATCH" "$BACKUP_SYSPATCH" || fail "BACKUP_SYSPATCH_COPY_FAILED"
/bin/cp -p "$METAL" "$BACKUP_METAL" || fail "BACKUP_METAL_COPY_FAILED"
/bin/cp -p "$PATCH" "$BACKUP/D97AG_SOURCE_CORRECTION.patch" || fail "BACKUP_PATCH_COPY_FAILED"
[[ "$(sha256_file "$BACKUP_HELPERS")" == "$HELPERS_PRE_SHA256" ]] || fail "BACKUP_HELPERS_VERIFY_FAILED"
[[ "$(sha256_file "$BACKUP_SYSPATCH")" == "$SYSPATCH_PRE_SHA256" ]] || fail "BACKUP_SYSPATCH_VERIFY_FAILED"
[[ "$(sha256_file "$BACKUP_METAL")" == "$METAL_SHA256" ]] || fail "BACKUP_METAL_VERIFY_FAILED"
emit "D97AG_RECOVERABLE_BACKUP=PASS|PATH=$BACKUP"

PYTHON_BIN=""
for candidate in "$ROOT/.venv/bin/python" /usr/local/bin/python3 /usr/bin/python3 "$(command -v python3 2>/dev/null || true)"; do
    if [[ -n "$candidate" && -x "$candidate" ]] && \
       "$candidate" -c 'import ast, hashlib, pathlib, sys; assert sys.version_info >= (3, 10)' >/dev/null 2>&1; then
        PYTHON_BIN="$candidate"
        break
    fi
done
[[ -n "$PYTHON_BIN" ]] || fail "PYTHON_NOT_FOUND"
emit "PYTHON_BIN=$PYTHON_BIN"
emit "PYTHON_VERSION=$($PYTHON_BIN --version 2>&1)"

MUTATION_STARTED=1
/usr/bin/git -C "$ROOT" apply --whitespace=nowarn -- "$PATCH" || fail "PATCH_APPLY_FAILED"

helpers_post="$(sha256_file "$HELPERS")"
syspatch_post="$(sha256_file "$SYSPATCH")"
metal_post="$(sha256_file "$METAL")"
emit "HELPERS_POST_SHA256=$helpers_post"
emit "SYSPATCH_POST_SHA256=$syspatch_post"
emit "METAL_POST_SHA256=$metal_post"
[[ "$helpers_post" == "$HELPERS_POST_SHA256" ]] || fail "HELPERS_POSTIMAGE_MISMATCH"
[[ "$syspatch_post" == "$SYSPATCH_POST_SHA256" ]] || fail "SYSPATCH_POSTIMAGE_MISMATCH"
[[ "$metal_post" == "$METAL_SHA256" ]] || fail "METAL_CHANGED"

set +e
"$PYTHON_BIN" - \
    "$HELPERS" "$SYSPATCH" \
    "$D97AD_METHOD_SHA256" "$D97AF_METHOD_POST_SHA256" "$XATTR_METHOD_POST_SHA256" <<'PY'
import ast
import hashlib
import sys
from pathlib import Path

helpers_path = Path(sys.argv[1])
syspatch_path = Path(sys.argv[2])
expected_d97ad_sha = sys.argv[3]
expected_d97af_sha = sys.argv[4]
expected_xattrs_sha = sys.argv[5]

helpers_text = helpers_path.read_text(encoding="utf-8")
syspatch_text = syspatch_path.read_text(encoding="utf-8")
compile(helpers_text, str(helpers_path), "exec")
compile(syspatch_text, str(syspatch_path), "exec")
helpers_tree = ast.parse(helpers_text)
syspatch_tree = ast.parse(syspatch_text)

helpers_class = next(
    node for node in helpers_tree.body
    if isinstance(node, ast.ClassDef) and node.name == "SysPatchHelpers"
)

def exact_method(name):
    hits = [
        node for node in helpers_class.body
        if isinstance(node, ast.FunctionDef) and node.name == name
    ]
    if len(hits) != 1:
        raise RuntimeError(f"METHOD_CARDINALITY_{name}:{len(hits)}")
    return hits[0]

def segment_sha(text, node):
    segment = ast.get_source_segment(text, node)
    if segment is None:
        raise RuntimeError("AST_SOURCE_SEGMENT_MISSING")
    return hashlib.sha256(segment.encode("utf-8")).hexdigest()

d97ad = exact_method("patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier")
d97af = exact_method("patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp")
if segment_sha(helpers_text, d97ad) != expected_d97ad_sha:
    raise RuntimeError("D97AD_METHOD_CHANGED")
if segment_sha(helpers_text, d97af) != expected_d97af_sha:
    raise RuntimeError("D97AF_METHOD_POSTIMAGE_MISMATCH")

xattr_methods = [
    node for node in d97af.body
    if isinstance(node, ast.FunctionDef) and node.name == "_xattrs"
]
if len(xattr_methods) != 1:
    raise RuntimeError(f"XATTR_METHOD_CARDINALITY:{len(xattr_methods)}")
xattrs = xattr_methods[0]
if segment_sha(helpers_text, xattrs) != expected_xattrs_sha:
    raise RuntimeError("XATTR_METHOD_POSTIMAGE_MISMATCH")

forbidden_xattr_apis = {
    node.attr for node in ast.walk(d97af)
    if isinstance(node, ast.Attribute)
    and node.attr in {"listxattr", "getxattr", "setxattr", "removexattr"}
}
if forbidden_xattr_apis:
    raise RuntimeError("PYTHON_XATTR_API_REMAINS:" + repr(sorted(forbidden_xattr_apis)))

xattr_tool_literals = [
    node.value for node in ast.walk(xattrs)
    if isinstance(node, ast.Constant) and node.value == "/usr/bin/xattr"
]
if len(xattr_tool_literals) != 2:
    raise RuntimeError(f"NATIVE_XATTR_TOOL_CARDINALITY:{len(xattr_tool_literals)}")

execute = next(
    node for node in syspatch_tree.body
    if isinstance(node, ast.ClassDef) and node.name == "PatchSysVolume"
)
execute = next(
    node for node in execute.body
    if isinstance(node, ast.FunctionDef) and node.name == "_execute_patchset"
)
ordered_names = [
    "patch_gpu_compiler_libraries",
    "patch_mtl_compiler_service_version_selector",
    "patch_mtl_compiler_tahoe_request_layout",
    "patch_mtl_compiler_tahoe_force_serialized_bitcode",
    "patch_mtl_compiler_tahoe_air_request_default_2_6",
    "patch_mtl_compiler_tahoe_true_five_clean_control",
    "patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports",
    "patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports",
    "patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier",
    "patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp",
]
calls = sorted(
    (node.lineno, node.func.attr)
    for node in ast.walk(execute)
    if isinstance(node, ast.Call)
    and isinstance(node.func, ast.Attribute)
    and node.func.attr in set(ordered_names)
)
if [name for _, name in calls] != ordered_names:
    raise RuntimeError("ACTIVE_CALL_ORDER_OR_CARDINALITY_MISMATCH:" + repr(calls))

metal_try = next(
    node for node in ast.walk(execute)
    if isinstance(node, ast.Try)
    and any(
        isinstance(child, ast.Attribute)
        and child.attr == "patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp"
        for child in ast.walk(node)
    )
)
if len(metal_try.handlers) != 1:
    raise RuntimeError("METAL_FATAL_HANDLER_CARDINALITY_MISMATCH")
handler = metal_try.handlers[0]
if len(handler.body) != 4:
    raise RuntimeError("METAL_FATAL_HANDLER_BODY_MISMATCH")
unmount = handler.body[-2]
reraised = handler.body[-1]
if not (
    isinstance(unmount, ast.Expr)
    and isinstance(unmount.value, ast.Call)
    and isinstance(unmount.value.func, ast.Attribute)
    and isinstance(unmount.value.func.value, ast.Name)
    and unmount.value.func.value.id == "self"
    and unmount.value.func.attr == "_unmount_root_vol"
    and not unmount.value.args
    and not unmount.value.keywords
):
    raise RuntimeError("METAL_FATAL_UNMOUNT_GUARD_MISSING")
if not isinstance(reraised, ast.Raise) or reraised.exc is not None or reraised.cause is not None:
    raise RuntimeError("METAL_FATAL_BARE_RERAISE_MISSING")

print("D97AG_PYTHON_COMPILE_AST=PASS")
print("D97AG_D97AD_METHOD_UNCHANGED=PASS")
print("D97AG_NO_PYTHON_XATTR_API=PASS")
print("D97AG_NATIVE_XATTR_READER=PASS")
print("D97AG_ACTIVE_CALL_ORDER=PASS")
print("D97AG_SHARED_METAL_FATAL_UNMOUNT_RERAISE=PASS")
PY
ast_rc=$?
set -e
(( ast_rc == 0 )) || fail "POST_PYTHON_COMPILE_AST_VALIDATION_FAILED"

post_status="$(/usr/bin/git -C "$ROOT" status --short --untracked-files=no)"
[[ "$post_status" == "$expected_status" ]] || fail "POST_SOURCE_TRACKED_STATUS_MISMATCH"
[[ "$(/usr/bin/git -C "$ROOT" branch --show-current)" == "$EXPECTED_BRANCH" ]] || fail "POST_BRANCH_CHANGED"
[[ "$(/usr/bin/git -C "$ROOT" rev-parse HEAD)" == "$EXPECTED_HEAD" ]] || fail "POST_HEAD_CHANGED"
/usr/bin/git -C "$ROOT" apply --reverse --check --whitespace=nowarn -- "$PATCH" || fail "POST_REVERSE_PATCH_CHECK_FAILED"

COMMITTED=1
emit "D97AG_EXACT_TWO_SOURCE_FILE_CORRECTION=PASS"
emit "D97AG_PACKAGED_XATTR_API_CORRECTION_SOURCE_STATE=READY"
emit "D97AG_SHARED_METAL_FAILURE_POLICY=UNMOUNT_AND_FATAL_RERAISE"
emit "SOURCE_BACKUP=$BACKUP"
emit "SOURCE_MUTATION=YES_EXACT_TWO_FILES"
emit "INSTALLED_APP_MUTATION=NO"
emit "SYSTEM_TARGET_MUTATION=NO"
emit "GOLDEN_MUTATION=NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "USER_ACTION_NOW=STOP_RETURN_COMPLETE_OUTPUT"
emit "REPORT=$REPORT"
emit "D97AG_LOCAL_SOURCE_CORRECTION=PASS"
