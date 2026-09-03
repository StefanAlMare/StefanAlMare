#!/bin/zsh -f
set -euo pipefail

ROOT1="/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
ROOT2="/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
EXPECTED_BRANCH="alex-tahoe-25G82-custom"
EXPECTED_HEAD="4143b7077a9a4e5aa41ec7a06c0888597eda9b06"
EXPECTED_HELPERS_PRE_SHA="6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c"
EXPECTED_SYSPATCH_PRE_SHA="93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69"
EXPECTED_METAL_SHA="fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24"
EXPECTED_D97AD_SEG_SHA="bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12"
EXPECTED_D97AF_SEG_SHA="fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a"
EXPECTED_VESA_BOOT_SEC="1788466673"
D97AD_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
P7_SHA="6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda"
OLD_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
A4F_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
NEW_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
A4F_POST_SHA="a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e"
NEW_POST_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"
OLD_STAMP_METHOD="patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp"
NEW_STAMP_METHOD="patch_mtl_compiler_tahoe_d97am_p7_natural_flow_lc_uuid_stamp"
D97AD_METHOD="patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier"
OUT="$HOME/Desktop/OCLP7_D97AM_LOCAL_P7_NATURAL_FLOW_SOURCE_INTEGRATION_REPORT.txt"
BACKUP="$HOME/Desktop/OCLP7_D97AM_SOURCE_BACKUP_$(/bin/date +%Y%m%d-%H%M%S)_$$"

fail_outer() {
    echo "D97AM_LOCAL_SOURCE_INTEGRATION=FAIL_CLOSED|REASON=$1"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AM — LOCAL P7 NATURAL-FLOW SOURCE INTEGRATION ====="
echo "PURPOSE=remove_entire_active_D97AD_terminal_classifier_and_retarget_exact_privileged_UUID_stamp_to_P7_natural_flow"
echo "P7_PRE_SHA256=$P7_SHA"
echo "NEW_P7_NATURAL_FLOW_UUID=$NEW_UUID"
echo "EXPECTED_P7_NATURAL_FLOW_POST_SHA256=$NEW_POST_SHA"
echo "SOURCE_MUTATION=PLANNED_EXACT_TWO_FILES_AFTER_ALL_GATES"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

ROOT=""
for C in "$ROOT1" "$ROOT2"; do
    if [[ -d "$C/.git" && ! -L "$C" ]]; then
        ROOT="$C"
        break
    fi
done
[[ -n "$ROOT" ]] || fail_outer "SOURCE_ROOT_NOT_FOUND"

HELPERS="$ROOT/opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"
SYSPATCH="$ROOT/opencore_legacy_patcher/sys_patch/sys_patch.py"
METAL="$ROOT/opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"

echo "SOURCE_ROOT=$ROOT"
for F in "$HELPERS" "$SYSPATCH" "$METAL"; do
    [[ -f "$F" && ! -L "$F" ]] || fail_outer "SOURCE_FILE_INVALID_${F:t}"
    [[ "$(/usr/bin/stat -f '%l' "$F")" == "1" ]] || fail_outer "SOURCE_LINK_COUNT_INVALID_${F:t}"
done

PYTHON=""
for C in "$ROOT/.venv/bin/python" /usr/local/bin/python3 "$(command -v python3 2>/dev/null || true)"; do
    if [[ -n "$C" && -x "$C" ]] && "$C" -c 'import ast,hashlib,pathlib,subprocess,sys; assert sys.version_info >= (3,10)' >/dev/null 2>&1; then
        PYTHON="$C"
        break
    fi
done
[[ -n "$PYTHON" ]] || fail_outer "PYTHON3_NOT_FOUND"
echo "PYTHON=$PYTHON"

BRANCH="$(/usr/bin/git -C "$ROOT" branch --show-current)"
HEAD="$(/usr/bin/git -C "$ROOT" rev-parse HEAD)"
STATUS="$(/usr/bin/git -C "$ROOT" status --short --untracked-files=no)"
HELPERS_SHA="$(/usr/bin/shasum -a 256 "$HELPERS" | /usr/bin/awk '{print $1}')"
SYSPATCH_SHA="$(/usr/bin/shasum -a 256 "$SYSPATCH" | /usr/bin/awk '{print $1}')"
METAL_SHA="$(/usr/bin/shasum -a 256 "$METAL" | /usr/bin/awk '{print $1}')"
BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\1/')"

echo "SOURCE_BRANCH=$BRANCH"
echo "SOURCE_HEAD=$HEAD"
echo "SOURCE_TRACKED_STATUS_BEGIN"
printf '%s\n' "$STATUS"
echo "SOURCE_TRACKED_STATUS_END"
echo "HELPERS_PRE_SHA256=$HELPERS_SHA"
echo "SYSPATCH_PRE_SHA256=$SYSPATCH_SHA"
echo "METAL_PRE_SHA256=$METAL_SHA"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"

[[ "$BRANCH" == "$EXPECTED_BRANCH" ]] || fail_outer "BRANCH_MISMATCH"
[[ "$HEAD" == "$EXPECTED_HEAD" ]] || fail_outer "HEAD_MISMATCH"
EXPECTED_STATUS=$' M opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py\n M opencore_legacy_patcher/sys_patch/sys_patch.py\n M opencore_legacy_patcher/sys_patch/sys_patch_helpers.py'
[[ "$STATUS" == "$EXPECTED_STATUS" ]] || fail_outer "TRACKED_STATUS_MISMATCH"
[[ "$HELPERS_SHA" == "$EXPECTED_HELPERS_PRE_SHA" ]] || fail_outer "HELPERS_PRE_SHA_MISMATCH"
[[ "$SYSPATCH_SHA" == "$EXPECTED_SYSPATCH_PRE_SHA" ]] || fail_outer "SYSPATCH_PRE_SHA_MISMATCH"
[[ "$METAL_SHA" == "$EXPECTED_METAL_SHA" ]] || fail_outer "METAL_PRE_SHA_MISMATCH"
[[ "$BOOT_SEC" == "$EXPECTED_VESA_BOOT_SEC" ]] || fail_outer "BOOT_CHRONOLOGY_CHANGED"
echo "PREIMAGE_AND_BOOT_GATES=PASS"

/bin/mkdir -m 0700 "$BACKUP" || fail_outer "BACKUP_CREATE_FAILED"
/bin/cp -p "$HELPERS" "$BACKUP/sys_patch_helpers.py.D97AH-pre-D97AM" || fail_outer "BACKUP_HELPERS_FAILED"
/bin/cp -p "$SYSPATCH" "$BACKUP/sys_patch.py.D97AH-pre-D97AM" || fail_outer "BACKUP_SYSPATCH_FAILED"
/bin/cp -p "$METAL" "$BACKUP/metal_3802.py.unchanged" || fail_outer "BACKUP_METAL_FAILED"
echo "BACKUP=$BACKUP"

set +e
"$PYTHON" - \
    "$ROOT" "$HELPERS" "$SYSPATCH" "$METAL" "$BACKUP" \
    "$EXPECTED_HELPERS_PRE_SHA" "$EXPECTED_SYSPATCH_PRE_SHA" "$EXPECTED_METAL_SHA" \
    "$EXPECTED_D97AD_SEG_SHA" "$EXPECTED_D97AF_SEG_SHA" \
    "$D97AD_SHA" "$P7_SHA" "$OLD_UUID" "$A4F_UUID" "$NEW_UUID" "$A4F_POST_SHA" "$NEW_POST_SHA" \
    "$OLD_STAMP_METHOD" "$NEW_STAMP_METHOD" "$D97AD_METHOD" <<'PY'
from __future__ import annotations

import ast
import difflib
import hashlib
import os
import stat
import subprocess
import sys
import tempfile
from pathlib import Path

(
    root_s, helpers_s, syspatch_s, metal_s, backup_s,
    helpers_pre_sha, syspatch_pre_sha, metal_expected_sha,
    d97ad_seg_sha, d97af_seg_sha,
    d97ad_sha, p7_sha, old_uuid, a4f_uuid, new_uuid, a4f_post_sha, new_post_sha,
    old_stamp_method, new_stamp_method, d97ad_method,
) = sys.argv[1:]

root = Path(root_s)
helpers = Path(helpers_s)
syspatch = Path(syspatch_s)
metal = Path(metal_s)
backup = Path(backup_s)

selector = 'patch_mtl_compiler_service_version_selector'
control = 'patch_mtl_compiler_tahoe_true_five_clean_control'
p6 = 'patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports'
p7 = 'patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports'


def sha_bytes(b: bytes) -> str:
    return hashlib.sha256(b).hexdigest()


def sha_text(s: str) -> str:
    return hashlib.sha256(s.encode()).hexdigest()


def defs_by_name(tree: ast.AST, name: str):
    return [n for n in ast.walk(tree) if isinstance(n, (ast.FunctionDef, ast.AsyncFunctionDef)) and n.name == name]


def source_segment(src: str, node: ast.AST) -> str:
    seg = ast.get_source_segment(src, node)
    if seg is None:
        raise RuntimeError(f'NO_SOURCE_SEGMENT:{getattr(node,"name","UNKNOWN")}')
    return seg


def relevant_calls(tree: ast.AST, names: set[str]):
    out = []
    for n in ast.walk(tree):
        if isinstance(n, ast.Call) and isinstance(n.func, ast.Attribute) and n.func.attr in names:
            recv = ast.unparse(n.func.value)
            out.append((getattr(n, 'lineno', 0), n.func.attr, recv, n))
    return sorted(out, key=lambda x: x[0])


def atomic_replace(path: Path, payload: bytes, mode: int):
    fd, tmpname = tempfile.mkstemp(prefix=f'.{path.name}.D97AM.', dir=str(path.parent))
    try:
        with os.fdopen(fd, 'wb') as f:
            f.write(payload)
            f.flush()
            os.fsync(f.fileno())
        os.chmod(tmpname, stat.S_IMODE(mode))
        os.replace(tmpname, path)
    finally:
        try:
            os.unlink(tmpname)
        except FileNotFoundError:
            pass

helpers_pre = helpers.read_bytes()
syspatch_pre = syspatch.read_bytes()
metal_pre = metal.read_bytes()
if sha_bytes(helpers_pre) != helpers_pre_sha:
    raise SystemExit('PY_PRE_HELPERS_SHA_MISMATCH')
if sha_bytes(syspatch_pre) != syspatch_pre_sha:
    raise SystemExit('PY_PRE_SYSPATCH_SHA_MISMATCH')
if sha_bytes(metal_pre) != metal_expected_sha:
    raise SystemExit('PY_PRE_METAL_SHA_MISMATCH')

hs = helpers_pre.decode('utf-8')
ps = syspatch_pre.decode('utf-8')
ht = ast.parse(hs)
pt = ast.parse(ps)

old_stamp_defs = defs_by_name(ht, old_stamp_method)
new_stamp_defs = defs_by_name(ht, new_stamp_method)
d97ad_defs = defs_by_name(ht, d97ad_method)
if len(old_stamp_defs) != 1 or len(new_stamp_defs) != 0 or len(d97ad_defs) != 1:
    raise SystemExit(f'PRE_HELPER_CARDINALITY_FAIL:old={len(old_stamp_defs)}:new={len(new_stamp_defs)}:d97ad={len(d97ad_defs)}')

old_stamp_node = old_stamp_defs[0]
d97ad_node = d97ad_defs[0]
old_seg = source_segment(hs, old_stamp_node)
d97ad_seg = source_segment(hs, d97ad_node)
print('PRE_D97AF_SEG_SHA256=' + sha_text(old_seg))
print('PRE_D97AD_SEG_SHA256=' + sha_text(d97ad_seg))
if sha_text(old_seg) != d97af_seg_sha:
    raise SystemExit('PRE_D97AF_SEG_SHA_MISMATCH')
if sha_text(d97ad_seg) != d97ad_seg_sha:
    raise SystemExit('PRE_D97AD_SEG_SHA_MISMATCH')

checks = [
    ('D97AD_PRE_SHA', d97ad_sha, 1),
    ('P7_SHA', p7_sha, 0),
    ('OLD_UUID', old_uuid, 1),
    ('A4F_UUID', a4f_uuid, 1),
    ('NEW_UUID', new_uuid, 0),
    ('A4F_POST_SHA', a4f_post_sha, 1),
    ('NEW_POST_SHA', new_post_sha, 0),
]
for label, token, expected in checks:
    got = old_seg.count(token)
    print(f'PRE_METHOD_TOKEN_COUNT|{label}|{got}')
    if got != expected:
        raise SystemExit(f'PRE_METHOD_TOKEN_CARDINALITY_FAIL:{label}:{got}!={expected}')

consts = [n.value for n in ast.walk(old_stamp_node) if isinstance(n, ast.Constant) and isinstance(n.value, str)]
usr_chflags = sum(1 for x in consts if x == '/usr/bin/chflags')
bin_chflags = sum(1 for x in consts if x == '/bin/chflags')
print(f'PRE_METHOD_USR_BIN_CHFLAGS_CONST_COUNT={usr_chflags}')
print(f'PRE_METHOD_BIN_CHFLAGS_CONST_COUNT={bin_chflags}')
if usr_chflags != 2 or bin_chflags != 0:
    raise SystemExit('D97AH_CHFLAGS_SEMANTICS_NOT_EXACT')

pre_names = {selector, control, p6, p7, d97ad_method, old_stamp_method, new_stamp_method}
pre_calls = relevant_calls(pt, pre_names)
print('PRE_ACTIVE_CALLS=' + repr([(a,b,c) for a,b,c,_ in pre_calls]))
pre_order = [x[1] for x in pre_calls]
expected_pre_order = [selector, control, p6, p7, d97ad_method, old_stamp_method]
if pre_order != expected_pre_order:
    raise SystemExit('PRE_ACTIVE_ORDER_MISMATCH:' + repr(pre_order))
if {x[2] for x in pre_calls} != {'sys_patch_helpers.SysPatchHelpers(self.constants)'}:
    raise SystemExit('PRE_CALL_RECEIVER_MISMATCH')

# Candidate helper: exact method-local retarget plus phase-name/log-label rename.
new_seg = old_seg
needle = f'def {old_stamp_method}('
replacement = f'def {new_stamp_method}('
if new_seg.count(needle) != 1:
    raise SystemExit('METHOD_DEF_TEXT_CARDINALITY_FAIL')
new_seg = new_seg.replace(needle, replacement, 1)
for old, new, label in [
    (d97ad_sha, p7_sha, 'PRE_SHA'),
    (a4f_uuid, new_uuid, 'UUID'),
    (a4f_post_sha, new_post_sha, 'POST_SHA'),
]:
    if new_seg.count(old) != 1 or new_seg.count(new) != 0:
        raise SystemExit(f'METHOD_RETARGET_PRECONDITION_FAIL:{label}')
    new_seg = new_seg.replace(old, new, 1)

label_count = new_seg.count('D97AF')
print(f'D97AF_UPPERCASE_PHASE_LABEL_REPLACEMENT_COUNT={label_count}')
if label_count < 1:
    raise SystemExit('NO_D97AF_PHASE_LABELS_FOUND')
new_seg = new_seg.replace('D97AF', 'D97AM')

if hs.count(old_seg) != 1:
    raise SystemExit('OLD_METHOD_SEGMENT_WHOLE_FILE_CARDINALITY_FAIL')
hs_candidate = hs.replace(old_seg, new_seg, 1)

# Candidate sys_patch: remove one complete D97AD call statement, rename one stamp call.
pt2 = ast.parse(ps)
d97ad_exprs = []
old_stamp_calls = []
for n in ast.walk(pt2):
    if isinstance(n, ast.Expr) and isinstance(n.value, ast.Call) and isinstance(n.value.func, ast.Attribute):
        if n.value.func.attr == d97ad_method:
            d97ad_exprs.append(n)
    if isinstance(n, ast.Call) and isinstance(n.func, ast.Attribute) and n.func.attr == old_stamp_method:
        old_stamp_calls.append(n)
if len(d97ad_exprs) != 1 or len(old_stamp_calls) != 1:
    raise SystemExit(f'SYSPATCH_TARGET_CARDINALITY_FAIL:d97ad={len(d97ad_exprs)}:stamp={len(old_stamp_calls)}')

lines = ps.splitlines(keepends=True)
expr = d97ad_exprs[0]
if expr.col_offset <= 0:
    raise SystemExit('D97AD_CALL_NOT_NESTED_EXPECTED')
start = expr.lineno - 1
end = (expr.end_lineno or expr.lineno)
removed = ''.join(lines[start:end])
print('REMOVED_D97AD_CALL_TEXT=' + removed.strip())
if d97ad_method not in removed:
    raise SystemExit('D97AD_REMOVED_TEXT_IDENTITY_FAIL')
del lines[start:end]
ps_candidate = ''.join(lines)
if ps_candidate.count(old_stamp_method) != 1:
    raise SystemExit('OLD_STAMP_CALL_TEXT_CARDINALITY_AFTER_REMOVE_FAIL')
ps_candidate = ps_candidate.replace(old_stamp_method, new_stamp_method, 1)

# Candidate semantic/AST/compile gates before any mutation.
ht_new = ast.parse(hs_candidate)
pt_new = ast.parse(ps_candidate)
compile(hs_candidate, str(helpers), 'exec')
compile(ps_candidate, str(syspatch), 'exec')

if len(defs_by_name(ht_new, old_stamp_method)) != 0:
    raise SystemExit('POST_OLD_STAMP_HELPER_STILL_PRESENT')
new_defs = defs_by_name(ht_new, new_stamp_method)
if len(new_defs) != 1:
    raise SystemExit('POST_NEW_STAMP_HELPER_CARDINALITY_FAIL')
if len(defs_by_name(ht_new, d97ad_method)) != 1:
    raise SystemExit('POST_D97AD_HELPER_NOT_RETAINED_DORMANT')
new_method_seg = source_segment(hs_candidate, new_defs[0])
print('CANDIDATE_D97AM_METHOD_SHA256=' + sha_text(new_method_seg))

post_checks = [
    ('D97AD_PRE_SHA', d97ad_sha, 0),
    ('P7_SHA', p7_sha, 1),
    ('OLD_UUID', old_uuid, 1),
    ('A4F_UUID', a4f_uuid, 0),
    ('NEW_UUID', new_uuid, 1),
    ('A4F_POST_SHA', a4f_post_sha, 0),
    ('NEW_POST_SHA', new_post_sha, 1),
]
for label, token, expected in post_checks:
    got = new_method_seg.count(token)
    print(f'CANDIDATE_METHOD_TOKEN_COUNT|{label}|{got}')
    if got != expected:
        raise SystemExit(f'CANDIDATE_METHOD_TOKEN_CARDINALITY_FAIL:{label}:{got}!={expected}')

new_consts = [n.value for n in ast.walk(new_defs[0]) if isinstance(n, ast.Constant) and isinstance(n.value, str)]
if sum(1 for x in new_consts if x == '/usr/bin/chflags') != 2 or sum(1 for x in new_consts if x == '/bin/chflags') != 0:
    raise SystemExit('CANDIDATE_D97AH_CHFLAGS_REGRESSION')
if 'D97AF' in new_method_seg:
    raise SystemExit('CANDIDATE_OLD_PHASE_LABEL_REMAINS')
if 'D97AM' not in new_method_seg:
    raise SystemExit('CANDIDATE_NEW_PHASE_LABEL_MISSING')

post_names = {selector, control, p6, p7, d97ad_method, old_stamp_method, new_stamp_method}
post_calls = relevant_calls(pt_new, post_names)
print('CANDIDATE_ACTIVE_CALLS=' + repr([(a,b,c) for a,b,c,_ in post_calls]))
post_order = [x[1] for x in post_calls]
expected_post_order = [selector, control, p6, p7, new_stamp_method]
if post_order != expected_post_order:
    raise SystemExit('CANDIDATE_ACTIVE_ORDER_MISMATCH:' + repr(post_order))
if {x[2] for x in post_calls} != {'sys_patch_helpers.SysPatchHelpers(self.constants)'}:
    raise SystemExit('CANDIDATE_CALL_RECEIVER_MISMATCH')

helpers_candidate = hs_candidate.encode('utf-8')
syspatch_candidate = ps_candidate.encode('utf-8')
helpers_post_sha = sha_bytes(helpers_candidate)
syspatch_post_sha = sha_bytes(syspatch_candidate)
print('CANDIDATE_HELPERS_SHA256=' + helpers_post_sha)
print('CANDIDATE_SYSPATCH_SHA256=' + syspatch_post_sha)
print('CANDIDATE_METAL_SHA256=' + sha_bytes(metal_pre))
print('CANDIDATE_AST_COMPILE=PASS')

print('===== CANDIDATE DIFF =====')
for line in difflib.unified_diff(hs.splitlines(), hs_candidate.splitlines(), fromfile='sys_patch_helpers.py.D97AH', tofile='sys_patch_helpers.py.D97AM', lineterm=''):
    print(line)
for line in difflib.unified_diff(ps.splitlines(), ps_candidate.splitlines(), fromfile='sys_patch.py.D97AH', tofile='sys_patch.py.D97AM', lineterm=''):
    print(line)

# Recheck CAS immediately before first write.
if sha_bytes(helpers.read_bytes()) != helpers_pre_sha or sha_bytes(syspatch.read_bytes()) != syspatch_pre_sha or sha_bytes(metal.read_bytes()) != metal_expected_sha:
    raise SystemExit('CAS_PREWRITE_SOURCE_CHANGED')

helpers_mode = helpers.stat().st_mode
syspatch_mode = syspatch.stat().st_mode
committed = False
try:
    atomic_replace(helpers, helpers_candidate, helpers_mode)
    if sha_bytes(helpers.read_bytes()) != helpers_post_sha:
        raise RuntimeError('HELPERS_POSTWRITE_VERIFY_FAIL')
    atomic_replace(syspatch, syspatch_candidate, syspatch_mode)
    if sha_bytes(syspatch.read_bytes()) != syspatch_post_sha:
        raise RuntimeError('SYSPATCH_POSTWRITE_VERIFY_FAIL')
    if sha_bytes(metal.read_bytes()) != metal_expected_sha:
        raise RuntimeError('METAL_CHANGED_DURING_TRANSACTION')

    # Final parse/compile and active-order audit from disk.
    hsf = helpers.read_text()
    psf = syspatch.read_text()
    htf = ast.parse(hsf)
    ptf = ast.parse(psf)
    compile(hsf, str(helpers), 'exec')
    compile(psf, str(syspatch), 'exec')
    if len(defs_by_name(htf, new_stamp_method)) != 1 or len(defs_by_name(htf, old_stamp_method)) != 0 or len(defs_by_name(htf, d97ad_method)) != 1:
        raise RuntimeError('FINAL_HELPER_CARDINALITY_FAIL')
    final_calls = relevant_calls(ptf, post_names)
    final_order = [x[1] for x in final_calls]
    if final_order != expected_post_order:
        raise RuntimeError('FINAL_ACTIVE_ORDER_FAIL:' + repr(final_order))
    committed = True
except BaseException as e:
    print('D97AM_TRANSACTION_EXCEPTION=' + repr(e))
    # Roll back both source files from exact in-memory preimages.
    try:
        atomic_replace(helpers, helpers_pre, helpers_mode)
        atomic_replace(syspatch, syspatch_pre, syspatch_mode)
    except BaseException as rb:
        print('D97AM_ROLLBACK_EXCEPTION=' + repr(rb))
        raise SystemExit('ROLLBACK_WRITE_FAILED')
    rb_ok = (
        sha_bytes(helpers.read_bytes()) == helpers_pre_sha and
        sha_bytes(syspatch.read_bytes()) == syspatch_pre_sha and
        sha_bytes(metal.read_bytes()) == metal_expected_sha
    )
    print('D97AM_ROLLBACK=' + ('PASS' if rb_ok else 'FAIL'))
    if not rb_ok:
        raise SystemExit('ROLLBACK_VERIFY_FAILED')
    raise SystemExit('D97AM_TRANSACTION_ROLLED_BACK')

if not committed:
    raise SystemExit('D97AM_NOT_COMMITTED')

print('===== FINAL SOURCE STATE =====')
print('FINAL_HELPERS_SHA256=' + sha_bytes(helpers.read_bytes()))
print('FINAL_SYSPATCH_SHA256=' + sha_bytes(syspatch.read_bytes()))
print('FINAL_METAL_SHA256=' + sha_bytes(metal.read_bytes()))
print('FINAL_D97AM_METHOD_SHA256=' + sha_text(source_segment(helpers.read_text(), defs_by_name(ast.parse(helpers.read_text()), new_stamp_method)[0])))
print('FINAL_ACTIVE_ORDER=' + ','.join(expected_post_order))
print('D97AD_ACTIVE_CALL_COUNT=0')
print('D97AD_HELPER_DEFINITION_DORMANT_COUNT=1')
print('OLD_D97AF_HELPER_DEFINITION_COUNT=0')
print('D97AM_HELPER_DEFINITION_COUNT=1')
print('P7_NATURAL_FLOW_PRE_SHA256=' + p7_sha)
print('P7_NATURAL_FLOW_UUID=' + new_uuid)
print('P7_NATURAL_FLOW_EXPECTED_POST_SHA256=' + new_post_sha)
print('D97AG_XATTR_FATAL_BOUNDARY_PRESERVED_BY_METHOD_LOCAL_RETARGET=YES')
print('D97AH_USR_BIN_CHFLAGS_CONST_COUNT=2')
print('METAL_BYTE_IDENTITY_PRESERVED=PASS')
print('D97AM_SOURCE_TRANSACTION=PASS')
PY
PY_RC=$?
set -e

if [[ "$PY_RC" -ne 0 ]]; then
    echo "D97AM_INNER_RC=$PY_RC"
    echo "SOURCE_MUTATION=NO_NET_IF_ROLLBACK_PASS_SEE_ABOVE"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    echo "BACKUP=$BACKUP"
    echo "REPORT=$OUT"
    exit "$PY_RC"
fi

FINAL_HELPERS_SHA="$(/usr/bin/shasum -a 256 "$HELPERS" | /usr/bin/awk '{print $1}')"
FINAL_SYSPATCH_SHA="$(/usr/bin/shasum -a 256 "$SYSPATCH" | /usr/bin/awk '{print $1}')"
FINAL_METAL_SHA="$(/usr/bin/shasum -a 256 "$METAL" | /usr/bin/awk '{print $1}')"
FINAL_STATUS="$(/usr/bin/git -C "$ROOT" status --short --untracked-files=no)"

echo "===== OUTER FINAL AUDIT ====="
echo "FINAL_HELPERS_SHA256=$FINAL_HELPERS_SHA"
echo "FINAL_SYSPATCH_SHA256=$FINAL_SYSPATCH_SHA"
echo "FINAL_METAL_SHA256=$FINAL_METAL_SHA"
echo "FINAL_TRACKED_STATUS_BEGIN"
printf '%s\n' "$FINAL_STATUS"
echo "FINAL_TRACKED_STATUS_END"
[[ "$FINAL_METAL_SHA" == "$EXPECTED_METAL_SHA" ]] || fail_outer "OUTER_FINAL_METAL_MISMATCH"
[[ "$FINAL_STATUS" == "$EXPECTED_STATUS" ]] || fail_outer "OUTER_FINAL_TRACKED_STATUS_MISMATCH"

echo "SOURCE_MUTATION=YES_EXACT_TWO_FILES"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "LOCAL_MAJOR_BUILD=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "BACKUP=$BACKUP"
echo "D97AM_LOCAL_P7_NATURAL_FLOW_SOURCE_INTEGRATION=PASS"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
