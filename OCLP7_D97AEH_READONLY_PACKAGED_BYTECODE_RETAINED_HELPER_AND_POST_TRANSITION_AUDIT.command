#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEH_READONLY_PACKAGED_BYTECODE_RETAINED_HELPER_AND_POST_TRANSITION_AUDIT_REPORT.txt"
exec > >(tee "$REPORT") 2>&1

fail() {
  echo "D97AEH_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEH — READ-ONLY PACKAGED-BYTECODE RETAINED-HELPER + POST-TRANSITION AUDIT ====="
echo "PURPOSE=replace_D97AEG_historical_source_range_hash_reproduction_gate_with_direct_normalized_Python_bytecode_identity_against_the_trusted_live_D97Z_packaged_app_then_complete_the_exact_D97AD_post_transition_source_audit"
echo "INPUT_D97AEG=post_transition_helper_cardinality_PASS_then_historical_selector_segment_SHA_not_reproduced_by_new_range_extractor"
echo "CLASSIFICATION=D97AEG_TOOLING_FALSE_NEGATIVE_SOURCE_RANGE_HASH_ALGORITHM_MISMATCH_NOT_SOURCE_DIFFERENCE_PROOF"
echo "TRANSITION_ORIGIN=NOT_CLAIMED_BY_THIS_AUDIT"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "BUILD=AUTO-NO"
echo "DEPLOY=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"

for t in git python3 shasum; do
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
  if [[ -f "$C/opencore_legacy_patcher/sys_patch/sys_patch_helpers.py" && -f "$C/opencore_legacy_patcher/sys_patch/sys_patch.py" ]]; then
    PROJECT_ROOT="$C"
    break
  fi
done
[[ -n "$PROJECT_ROOT" ]] || fail "PROJECT_ROOT_NOT_FOUND"
echo "PROJECT_ROOT=$PROJECT_ROOT"
echo "PROJECT_BRANCH=$(git -C "$PROJECT_ROOT" branch --show-current)"
echo "PROJECT_HEAD=$(git -C "$PROJECT_ROOT" rev-parse HEAD)"

SELECTED_PY=""
for P in \
  "$PROJECT_ROOT/.venv/bin/python" \
  "$HOME/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82/.venv/bin/python" \
  "/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82/.venv/bin/python"
do
  if [[ -x "$P" ]] && "$P" -c 'import PyInstaller' >/dev/null 2>&1; then
    SELECTED_PY="$P"
    break
  fi
done
[[ -n "$SELECTED_PY" ]] || fail "PYINSTALLER_CAPABLE_PROJECT_PYTHON_NOT_FOUND"
echo "SELECTED_PY=$SELECTED_PY"
"$SELECTED_PY" --version 2>&1

APP_EXE="/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
MTL=""
for C in \
  "/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler" \
  "/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/A/MTLCompiler"
do
  [[ -f "$C" ]] && { MTL="$C"; break; }
done
[[ -f "$APP_EXE" ]] || fail "LIVE_APP_EXE_MISSING"
[[ -f "$SERVICE" ]] || fail "VISIBLE_SERVICE_MISSING"
[[ -n "$MTL" ]] || fail "VISIBLE_MTL_32023_MISSING"

APP_SHA="$(shasum -a 256 "$APP_EXE" | awk '{print $1}')"
SERVICE_SHA="$(shasum -a 256 "$SERVICE" | awk '{print $1}')"
MTL_SHA="$(shasum -a 256 "$MTL" | awk '{print $1}')"
echo "LIVE_APP_EXE=$APP_EXE"
echo "LIVE_APP_SHA=$APP_SHA"
echo "VISIBLE_SERVICE=$SERVICE"
echo "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
echo "VISIBLE_MTL=$MTL"
echo "VISIBLE_MTL_SHA=$MTL_SHA"
[[ "$APP_SHA" == "0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f" ]] || fail "LIVE_APP_NOT_TRUSTED_D97Z:$APP_SHA"
[[ "$SERVICE_SHA" == "2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c" ]] || fail "VISIBLE_SERVICE_NOT_D97Z:$SERVICE_SHA"
[[ "$MTL_SHA" == "c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118" ]] || fail "VISIBLE_MTL_NOT_D97:$MTL_SHA"
echo "TRUSTED_LIVE_D97Z_PACKAGE_AND_RUNTIME_LAYER_IDENTITY=PASS"

"$SELECTED_PY" - "$PROJECT_ROOT" "$APP_EXE" <<'PY'
from __future__ import annotations

import ast
import hashlib
import json
import marshal
import os
import pickle
import subprocess
import sys
import tempfile
import types
from pathlib import Path

root = Path(sys.argv[1])
app_exe = Path(sys.argv[2])
helpers_path = root / "opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"
syspatch_path = root / "opencore_legacy_patcher/sys_patch/sys_patch.py"
helpers_text = helpers_path.read_text()
syspatch_text = syspatch_path.read_text()

compile(helpers_text, str(helpers_path), "exec")
compile(syspatch_text, str(syspatch_path), "exec")
print("SOURCE_COMPILE_NOWRITE_HELPERS=PASS")
print("SOURCE_COMPILE_NOWRITE_SYSPATCH=PASS")

helpers_tree = ast.parse(helpers_text)
syspatch_tree = ast.parse(syspatch_text)

names = {
    "selector": "patch_mtl_compiler_service_version_selector",
    "d97z": "patch_mtl_compiler_service_tahoe_d97z_llvmversion_exit_classifier",
    "control": "patch_mtl_compiler_tahoe_true_five_clean_control",
    "p6": "patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports",
    "p7": "patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports",
    "d97": "patch_mtl_compiler_tahoe_d97_six_counter_terminal_register_snapshot",
    "d97ad": "patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier",
}
expected_source_counts = {
    "selector": 1,
    "d97z": 0,
    "control": 1,
    "p6": 1,
    "p7": 1,
    "d97": 0,
    "d97ad": 1,
}
method_nodes: dict[str, list[ast.FunctionDef | ast.AsyncFunctionDef]] = {v: [] for v in names.values()}
for node in ast.walk(helpers_tree):
    if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)) and node.name in method_nodes:
        method_nodes[node.name].append(node)
for key, name in names.items():
    count = len(method_nodes[name])
    print(f"SOURCE_HELPER_COUNT={key}|NAME={name}|COUNT={count}")
    if count != expected_source_counts[key]:
        raise SystemExit(f"D97AEH_SOURCE_HELPER_COUNT_MISMATCH:{key}:{count}")
print("POST_TRANSITION_HELPER_CARDINALITY=PASS")

# Load the trusted D97Z packaged module directly from the PyInstaller archive.
from PyInstaller.archive.readers import CArchiveReader, ZlibArchiveReader

car = CArchiveReader(str(app_exe))
car_names = list(car.toc.keys()) if isinstance(car.toc, dict) else list(car.toc)
pyz_names = [str(name) for name in car_names if str(name).lower().endswith(".pyz")]
print(f"PACKAGED_CARCHIVE_PYZ_NAMES={pyz_names}")
if len(pyz_names) != 1:
    raise SystemExit(f"D97AEH_PACKAGED_PYZ_CARDINALITY_FAIL:{len(pyz_names)}")
pyz_name = pyz_names[0]
pyz = None
open_errors = []
if hasattr(car, "open_embedded_archive"):
    try:
        pyz = car.open_embedded_archive(pyz_name)
        print("PACKAGED_PYZ_OPEN_MODE=CArchiveReader.open_embedded_archive")
    except Exception as exc:
        open_errors.append(f"open_embedded_archive:{type(exc).__name__}:{exc}")
if pyz is None:
    try:
        raw = car.extract(pyz_name)
        if not isinstance(raw, (bytes, bytearray)):
            raise TypeError(f"unexpected CArchive extract type {type(raw)!r}")
        with tempfile.NamedTemporaryFile(prefix="oclp-d97aeh-pyz-", suffix=".pyz", delete=False) as fh:
            fh.write(raw)
            tmp_pyz = fh.name
        try:
            pyz = ZlibArchiveReader(tmp_pyz)
            print("PACKAGED_PYZ_OPEN_MODE=CArchive_extract_then_ZlibArchiveReader")
        finally:
            try:
                os.unlink(tmp_pyz)
            except FileNotFoundError:
                pass
    except Exception as exc:
        open_errors.append(f"extract_fallback:{type(exc).__name__}:{exc}")
if pyz is None:
    print(f"PACKAGED_PYZ_OPEN_ERRORS={open_errors}")
    raise SystemExit("D97AEH_PACKAGED_PYZ_OPEN_FAIL")

pyz_toc = pyz.toc
pyz_names_all = list(pyz_toc.keys()) if isinstance(pyz_toc, dict) else list(pyz_toc)
module_target = "opencore_legacy_patcher.sys_patch.sys_patch_helpers"
module_candidates = [str(name) for name in pyz_names_all if str(name) == module_target]
if not module_candidates:
    module_candidates = [str(name) for name in pyz_names_all if str(name).endswith("sys_patch.sys_patch_helpers")]
print(f"PACKAGED_HELPERS_MODULE_CANDIDATES={module_candidates}")
if len(module_candidates) != 1:
    raise SystemExit(f"D97AEH_PACKAGED_HELPERS_MODULE_CARDINALITY_FAIL:{len(module_candidates)}")
module_key = module_candidates[0]
packaged_module = pyz.extract(module_key)
if isinstance(packaged_module, (bytes, bytearray)):
    packaged_module = marshal.loads(packaged_module)
if isinstance(packaged_module, (tuple, list)):
    code_candidates = [item for item in packaged_module if isinstance(item, types.CodeType)]
    if len(code_candidates) == 1:
        packaged_module = code_candidates[0]
if not isinstance(packaged_module, types.CodeType):
    raise SystemExit(f"D97AEH_PACKAGED_MODULE_NOT_CODE:{type(packaged_module)!r}")
print(f"PACKAGED_HELPERS_MODULE_KEY={module_key}")
print("PACKAGED_HELPERS_MODULE_CODE_OBJECT=PASS")


def find_code(root_code: types.CodeType, target_name: str) -> list[types.CodeType]:
    found: list[types.CodeType] = []
    def walk(co: types.CodeType) -> None:
        for value in co.co_consts:
            if isinstance(value, types.CodeType):
                if value.co_name == target_name:
                    found.append(value)
                walk(value)
    walk(root_code)
    return found


def norm_const(value):
    if isinstance(value, types.CodeType):
        return ["CODE", norm_code(value)]
    if isinstance(value, tuple):
        return ["TUPLE", [norm_const(x) for x in value]]
    if isinstance(value, list):
        return ["LIST", [norm_const(x) for x in value]]
    if isinstance(value, frozenset):
        items = [norm_const(x) for x in value]
        return ["FROZENSET", sorted(items, key=lambda x: json.dumps(x, sort_keys=True, default=repr))]
    if isinstance(value, bytes):
        return ["BYTES", value.hex()]
    if isinstance(value, bytearray):
        return ["BYTEARRAY", bytes(value).hex()]
    if value is Ellipsis:
        return ["ELLIPSIS"]
    if value is None:
        return ["NONE"]
    if isinstance(value, (str, int, float, complex, bool)):
        return [type(value).__name__, repr(value)]
    return [type(value).__name__, repr(value)]


def norm_code(co: types.CodeType):
    return {
        "name": co.co_name,
        "qualname_tail": co.co_qualname.split(".")[-1],
        "argcount": co.co_argcount,
        "posonlyargcount": getattr(co, "co_posonlyargcount", 0),
        "kwonlyargcount": co.co_kwonlyargcount,
        "nlocals": co.co_nlocals,
        "stacksize": co.co_stacksize,
        "flags": co.co_flags,
        "code": co.co_code.hex(),
        "exceptiontable": getattr(co, "co_exceptiontable", b"").hex(),
        "consts": [norm_const(x) for x in co.co_consts],
        "names": list(co.co_names),
        "varnames": list(co.co_varnames),
        "freevars": list(co.co_freevars),
        "cellvars": list(co.co_cellvars),
    }


def fingerprint(co: types.CodeType) -> str:
    payload = json.dumps(norm_code(co), sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode()
    return hashlib.sha256(payload).hexdigest()

retained = ["selector", "control", "p6", "p7"]
source_modules: dict[int, types.CodeType] = {
    opt: compile(helpers_text, str(helpers_path), "exec", optimize=opt)
    for opt in (0, 1, 2)
}
matched_opt_levels: dict[str, list[int]] = {}
for key in retained:
    name = names[key]
    packaged_methods = find_code(packaged_module, name)
    print(f"PACKAGED_RETAINED_HELPER_CODE_COUNT={key}|NAME={name}|COUNT={len(packaged_methods)}")
    if len(packaged_methods) != 1:
        raise SystemExit(f"D97AEH_PACKAGED_RETAINED_HELPER_CODE_COUNT_FAIL:{key}:{len(packaged_methods)}")
    pkg_hash = fingerprint(packaged_methods[0])
    print(f"PACKAGED_RETAINED_HELPER_NORMALIZED_BYTECODE_SHA={key}|SHA256={pkg_hash}")
    matches: list[int] = []
    for opt, source_module in source_modules.items():
        source_methods = find_code(source_module, name)
        print(f"SOURCE_RETAINED_HELPER_CODE_COUNT={key}|OPTIMIZE={opt}|COUNT={len(source_methods)}")
        if len(source_methods) != 1:
            raise SystemExit(f"D97AEH_SOURCE_RETAINED_HELPER_CODE_COUNT_FAIL:{key}:OPT{opt}:{len(source_methods)}")
        source_hash = fingerprint(source_methods[0])
        print(f"SOURCE_RETAINED_HELPER_NORMALIZED_BYTECODE_SHA={key}|OPTIMIZE={opt}|SHA256={source_hash}")
        if source_hash == pkg_hash:
            matches.append(opt)
    matched_opt_levels[key] = matches
    print(f"RETAINED_HELPER_PACKAGED_BYTECODE_MATCH_LEVELS={key}|OPTIMIZE_LEVELS={matches}")
    if not matches:
        raise SystemExit(f"D97AEH_RETAINED_HELPER_PACKAGED_BYTECODE_MISMATCH:{key}")
    print(f"RETAINED_HELPER_PACKAGED_BYTECODE_IDENTITY={key}|PASS")
print(f"RETAINED_HELPER_MATCH_LEVEL_MAP={matched_opt_levels}")
print("RETAINED_SELECTOR_CONTROL_P6_P7_PACKAGED_BYTECODE_IDENTITY=PASS")

# Prove the trusted package has the old diagnostics and not the new D97AD helper.
expected_packaged_counts = {"d97z": 1, "d97": 1, "d97ad": 0}
for key, expected in expected_packaged_counts.items():
    count = len(find_code(packaged_module, names[key]))
    print(f"PACKAGED_DIAGNOSTIC_HELPER_CODE_COUNT={key}|COUNT={count}|EXPECTED={expected}")
    if count != expected:
        raise SystemExit(f"D97AEH_PACKAGED_DIAGNOSTIC_HELPER_COUNT_FAIL:{key}:{count}")
print("TRUSTED_PACKAGE_PRE_TRANSITION_DIAGNOSTIC_STATE=PASS")

# Audit the new D97AD helper itself from source.
d97ad_node = method_nodes[names["d97ad"]][0]
d97ad_src = ast.get_source_segment(helpers_text, d97ad_node) or ""
print(f"D97AD_HELPER_LINE_RANGE={d97ad_node.lineno}..{d97ad_node.end_lineno}")
print(f"D97AD_HELPER_SOURCE_SHA256={hashlib.sha256(d97ad_src.encode()).hexdigest()}")
required_d97ad_tokens = [
    "6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda",
    "524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755",
    "8b8d10feffff83f941",
    "6a6e5fe9bb38f6ff90",
    "488d3599640200b91e000000",
    "6a6f5fe9ac3bf6ff90909090",
    "488d359764020083fa10",
    "6a705fe96d3bf6ff9090",
    "488d35cc63020031c0",
    "6a715fe9643af6ff90",
    "4489f04881c488030000",
    "6a725fe98d3df6ff9090",
    "488dbd20feffffe8c45c0100",
    "6a725fe97a37f6ff90909090",
    "b8010000020f050f0b",
]
missing = [token for token in required_d97ad_tokens if d97ad_src.count(token) != 1]
print(f"D97AD_REQUIRED_EXACT_ONCE_RUNTIME_TOKENS_FAILED={missing}")
if missing:
    raise SystemExit("D97AEH_D97AD_RUNTIME_TOKEN_CARDINALITY_FAIL")
root_calls = sum(
    1 for node in ast.walk(d97ad_node)
    if isinstance(node, ast.Call)
    and isinstance(node.func, ast.Attribute)
    and node.func.attr == "run_as_root_and_verify"
)
print(f"D97AD_RUN_AS_ROOT_AND_VERIFY_COUNT={root_calls}")
if root_calls != 3:
    raise SystemExit(f"D97AEH_D97AD_PRIVILEGED_CALL_COUNT_MISMATCH:{root_calls}")
print("D97AD_HELPER_EXACT_RUNTIME_CONTRACT=PASS")

# Exact active call order and receiver in sys_patch.py.
target_set = set(names.values())
call_records: list[tuple[int, str, str]] = []
for node in ast.walk(syspatch_tree):
    if not isinstance(node, ast.Call) or not isinstance(node.func, ast.Attribute):
        continue
    name = node.func.attr
    if name not in target_set:
        continue
    receiver = ast.unparse(node.func.value) if hasattr(ast, "unparse") else "UNKNOWN"
    call_records.append((node.lineno, name, receiver))
call_records.sort()
for line, name, receiver in call_records:
    print(f"SOURCE_ACTIVE_TARGET_CALL=LINE={line}|NAME={name}|RECEIVER={receiver}")
active_names = [name for _, name, _ in call_records]
expected_order = [names["selector"], names["control"], names["p6"], names["p7"], names["d97ad"]]
print(f"SOURCE_ACTIVE_TARGET_CALL_ORDER={active_names}")
print(f"EXPECTED_POST_TRANSITION_CALL_ORDER={expected_order}")
if active_names != expected_order:
    raise SystemExit("D97AEH_POST_TRANSITION_CALL_ORDER_MISMATCH")
receivers = {receiver for _, _, receiver in call_records}
print(f"SOURCE_ACTIVE_CALL_RECEIVERS={sorted(receivers)}")
if receivers != {"sys_patch_helpers.SysPatchHelpers(self.constants)"}:
    raise SystemExit("D97AEH_CALL_RECEIVER_MISMATCH")
print("POST_TRANSITION_CALL_ORDER_AND_RECEIVER=PASS")

changed = subprocess.check_output(
    ["git", "-C", str(root), "diff", "--name-only", "--"], text=True
).splitlines()
changed = sorted(x for x in changed if x.strip())
allowed = sorted([
    "opencore_legacy_patcher/sys_patch/sys_patch.py",
    "opencore_legacy_patcher/sys_patch/sys_patch_helpers.py",
])
print(f"SOURCE_TRACKED_CHANGED_FILES={changed}")
print(f"SOURCE_ALLOWED_TRACKED_FILES={allowed}")
if changed != allowed:
    raise SystemExit("D97AEH_TRACKED_CHANGED_FILE_SET_MISMATCH")
check = subprocess.run(
    ["git", "-C", str(root), "diff", "--check", "--", *allowed],
    text=True, capture_output=True
)
print(f"SOURCE_GIT_DIFF_CHECK_RC={check.returncode}")
if check.stdout:
    print("SOURCE_GIT_DIFF_CHECK_STDOUT=" + check.stdout.replace("\n", "\\n"))
if check.stderr:
    print("SOURCE_GIT_DIFF_CHECK_STDERR=" + check.stderr.replace("\n", "\\n"))
if check.returncode != 0:
    raise SystemExit("D97AEH_GIT_DIFF_CHECK_FAIL")
print("SOURCE_GIT_DIFF_CHECK=PASS")
stat = subprocess.check_output(
    ["git", "-C", str(root), "diff", "--stat", "--", *allowed], text=True
).strip()
print("SOURCE_DIFF_STAT=" + stat.replace("\n", " | "))

print("D97AEH_POST_TRANSITION_SOURCE_STATE=STATIC_PROVEN")
print("D97Z_SERVICE_HELPER_AND_CALL_ABSENT=PASS")
print("D97_MTL_DIAGNOSTIC_HELPER_AND_CALL_ABSENT=PASS")
print("D97AD_HELPER_AND_CALL_PRESENT_EXACTLY_ONCE=PASS")
print("D97AEH_BUILD_RESUME_AUTHORIZED=YES_BUILD_DEPLOY_ONLY_NO_SOURCE_REINTEGRATION")
PY

echo "===== FINAL ====="
echo "D97AEH_READONLY_PACKAGED_BYTECODE_RETAINED_HELPER_AND_POST_TRANSITION_AUDIT=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "BUILD=AUTO-NO"
echo "DEPLOY=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_audit_then_construct_identity_pinned_build_deploy_only_resume"
echo "REPORT=$REPORT"
