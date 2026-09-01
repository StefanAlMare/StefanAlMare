#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEI_READONLY_HISTORICAL_SOURCE_SEGMENT_AND_POST_TRANSITION_AUDIT_REPORT.txt"
exec > >(tee "$REPORT") 2>&1

fail() {
  echo "D97AEI_FAIL=$*"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AEI — READ-ONLY HISTORICAL SOURCE-SEGMENT + POST-TRANSITION AUDIT ====="
echo "PURPOSE=replace_D97AEH_packaged_code_object_fingerprint_gate_with_exact_historical_source_segment_SHA_reproduction_then_complete_D97AD_post_transition_source_audit"
echo "INPUT_D97AEH=trusted_live_D97Z_identity_and_post_transition_cardinality_PASS_then_packaged_vs_recompiled_code_object_fingerprint_mismatch_at_selector"
echo "CLASSIFICATION=D97AEH_CODE_OBJECT_FINGERPRINT_CHANNEL_INCONCLUSIVE_NOT_SOURCE_DIFFERENCE_PROOF"
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
python3 --version 2>&1

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
echo "LIVE_APP_SHA=$APP_SHA"
echo "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
echo "VISIBLE_MTL_SHA=$MTL_SHA"
[[ "$APP_SHA" == "0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f" ]] || fail "LIVE_APP_NOT_TRUSTED_D97Z:$APP_SHA"
[[ "$SERVICE_SHA" == "2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c" ]] || fail "VISIBLE_SERVICE_NOT_D97Z:$SERVICE_SHA"
[[ "$MTL_SHA" == "c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118" ]] || fail "VISIBLE_MTL_NOT_D97:$MTL_SHA"
echo "TRUSTED_LIVE_D97Z_PACKAGE_AND_RUNTIME_LAYER_IDENTITY=PASS"

python3 - "$PROJECT_ROOT" <<'PY'
from __future__ import annotations

import ast
import hashlib
import subprocess
import sys
import textwrap
from pathlib import Path

root = Path(sys.argv[1])
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
expected_counts = {
    "selector": 1, "d97z": 0, "control": 1, "p6": 1,
    "p7": 1, "d97": 0, "d97ad": 1,
}
expected_segment_sha = {
    "selector": "adb3981f5ac58820d4715436f56936ce2cae1bcf7c162107d215ff6150ee61a4",
    "control": "254104fa863b6d0b8e9c27a6db907b423c3153958d3e51fc4cbd912c7ebe6ac9",
    "p6": "ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a",
    "p7": "a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b",
}

method_nodes: dict[str, list[ast.FunctionDef | ast.AsyncFunctionDef]] = {v: [] for v in names.values()}
for node in ast.walk(helpers_tree):
    if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)) and node.name in method_nodes:
        method_nodes[node.name].append(node)
for key, name in names.items():
    count = len(method_nodes[name])
    print(f"SOURCE_HELPER_COUNT={key}|NAME={name}|COUNT={count}")
    if count != expected_counts[key]:
        raise SystemExit(f"D97AEI_HELPER_COUNT_MISMATCH:{key}:{count}")
print("POST_TRANSITION_HELPER_CARDINALITY=PASS")

lines = helpers_text.splitlines(keepends=True)

def sha(s: str) -> str:
    return hashlib.sha256(s.encode()).hexdigest()

def variants(node: ast.FunctionDef | ast.AsyncFunctionDef) -> dict[str, str]:
    raw = ast.get_source_segment(helpers_text, node)
    if raw is None:
        raise SystemExit(f"D97AEI_AST_SOURCE_SEGMENT_MISSING:{node.name}")
    start = node.lineno - 1
    end = node.end_lineno or node.lineno
    line_exact = "".join(lines[start:end])
    # Historical FASTLANEs used source-segment hashing. Enumerate only precise,
    # explainable source-range conventions; an exact SHA match is required.
    out = {
        "AST_GET_SOURCE_SEGMENT": raw,
        "AST_GET_SOURCE_SEGMENT_PLUS_NL": raw + "\n",
        "AST_GET_SOURCE_SEGMENT_RSTRIP_PLUS_NL": raw.rstrip() + "\n",
        "AST_GET_SOURCE_SEGMENT_DEDENT": textwrap.dedent(raw),
        "AST_GET_SOURCE_SEGMENT_DEDENT_PLUS_NL": textwrap.dedent(raw).rstrip() + "\n",
        "LINE_EXACT": line_exact,
        "LINE_EXACT_RSTRIP_PLUS_NL": line_exact.rstrip() + "\n",
        "LINE_EXACT_DEDENT": textwrap.dedent(line_exact),
        "LINE_EXACT_DEDENT_RSTRIP_PLUS_NL": textwrap.dedent(line_exact).rstrip() + "\n",
    }
    # Brute-force a narrowly bounded line-aligned envelope around the AST node,
    # covering historical inclusion of decorators/blank separators/next-def gap.
    for s in range(max(0, start - 4), start + 1):
        for e in range(end, min(len(lines), end + 7) + 1):
            candidate = "".join(lines[s:e])
            out[f"LINE_ENVELOPE_{s+1}_{e}"] = candidate
            out[f"LINE_ENVELOPE_{s+1}_{e}_RSTRIP_PLUS_NL"] = candidate.rstrip() + "\n"
    return out

for key in ("selector", "control", "p6", "p7"):
    node = method_nodes[names[key]][0]
    expected = expected_segment_sha[key]
    vv = variants(node)
    matches = []
    for mode, text in vv.items():
        digest = sha(text)
        if mode in {
            "AST_GET_SOURCE_SEGMENT", "AST_GET_SOURCE_SEGMENT_PLUS_NL",
            "AST_GET_SOURCE_SEGMENT_RSTRIP_PLUS_NL", "LINE_EXACT",
            "LINE_EXACT_RSTRIP_PLUS_NL"
        }:
            print(f"HISTORICAL_SEGMENT_SHA_VARIANT={key}|MODE={mode}|SHA256={digest}|LEN={len(text.encode())}")
        if digest == expected:
            matches.append((mode, len(text.encode())))
    print(f"HISTORICAL_SEGMENT_EXPECTED_SHA={key}|SHA256={expected}")
    print(f"HISTORICAL_SEGMENT_MATCHES={key}|MATCHES={matches}")
    if not matches:
        raise SystemExit(f"D97AEI_HISTORICAL_SOURCE_SEGMENT_SHA_NOT_REPRODUCED:{key}")
    print(f"RETAINED_HELPER_HISTORICAL_SOURCE_SEGMENT_IDENTITY={key}|PASS")
print("RETAINED_SELECTOR_CONTROL_P6_P7_HISTORICAL_SOURCE_SEGMENT_IDENTITY=PASS")

# Verify the new D97AD helper's exact runtime contract.
d97ad_node = method_nodes[names["d97ad"]][0]
d97ad_src = ast.get_source_segment(helpers_text, d97ad_node) or ""
required_tokens = [
    "6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda",
    "524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755",
    "8b8d10feffff83f941", "6a6e5fe9bb38f6ff90",
    "488d3599640200b91e000000", "6a6f5fe9ac3bf6ff90909090",
    "488d359764020083fa10", "6a705fe96d3bf6ff9090",
    "488d35cc63020031c0", "6a715fe9643af6ff90",
    "4489f04881c488030000", "6a725fe98d3df6ff9090",
    "488dbd20feffffe8c45c0100", "6a725fe97a37f6ff90909090",
    "b8010000020f050f0b",
]
missing = [x for x in required_tokens if x not in d97ad_src]
print(f"D97AD_REQUIRED_RUNTIME_TOKENS_MISSING={missing}")
if missing:
    raise SystemExit("D97AEI_D97AD_RUNTIME_TOKEN_MISSING")
root_calls = d97ad_src.count("run_as_root_and_verify")
print(f"D97AD_RUN_AS_ROOT_AND_VERIFY_COUNT={root_calls}")
if root_calls != 3:
    raise SystemExit(f"D97AEI_D97AD_PRIVILEGED_CALL_COUNT_MISMATCH:{root_calls}")
print("D97AD_HELPER_EXACT_RUNTIME_CONTRACT=PASS")

# Verify active call order and receiver.
target_set = set(names.values())
records = []
for node in ast.walk(syspatch_tree):
    if isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute) and node.func.attr in target_set:
        receiver = ast.unparse(node.func.value)
        records.append((node.lineno, node.func.attr, receiver))
records.sort()
for line, name, receiver in records:
    print(f"SOURCE_ACTIVE_TARGET_CALL=LINE={line}|NAME={name}|RECEIVER={receiver}")
active_names = [name for _, name, _ in records]
expected_order = [names["selector"], names["control"], names["p6"], names["p7"], names["d97ad"]]
print(f"SOURCE_ACTIVE_TARGET_CALL_ORDER={active_names}")
print(f"EXPECTED_POST_TRANSITION_CALL_ORDER={expected_order}")
if active_names != expected_order:
    raise SystemExit("D97AEI_POST_TRANSITION_CALL_ORDER_MISMATCH")
receivers = {receiver for _, _, receiver in records}
print(f"SOURCE_ACTIVE_CALL_RECEIVERS={sorted(receivers)}")
if receivers != {"sys_patch_helpers.SysPatchHelpers(self.constants)"}:
    raise SystemExit("D97AEI_CALL_RECEIVER_MISMATCH")
print("POST_TRANSITION_CALL_ORDER_AND_RECEIVER=PASS")

changed = subprocess.check_output(["git", "-C", str(root), "diff", "--name-only", "--"], text=True).splitlines()
changed = sorted(x for x in changed if x.strip())
allowed = sorted([
    "opencore_legacy_patcher/sys_patch/sys_patch.py",
    "opencore_legacy_patcher/sys_patch/sys_patch_helpers.py",
])
print(f"SOURCE_TRACKED_CHANGED_FILES={changed}")
print(f"SOURCE_ALLOWED_TRACKED_FILES={allowed}")
if changed != allowed:
    raise SystemExit("D97AEI_TRACKED_CHANGED_FILE_SET_MISMATCH")
check = subprocess.run(["git", "-C", str(root), "diff", "--check", "--", *allowed], text=True, capture_output=True)
print(f"SOURCE_GIT_DIFF_CHECK_RC={check.returncode}")
if check.stdout:
    print("SOURCE_GIT_DIFF_CHECK_STDOUT=" + check.stdout.replace("\n", "\\n"))
if check.stderr:
    print("SOURCE_GIT_DIFF_CHECK_STDERR=" + check.stderr.replace("\n", "\\n"))
if check.returncode != 0:
    raise SystemExit("D97AEI_GIT_DIFF_CHECK_FAIL")
print("SOURCE_GIT_DIFF_CHECK=PASS")

print("D97AEI_POST_TRANSITION_SOURCE_STATE=STATIC_PROVEN")
print("D97Z_SERVICE_HELPER_AND_CALL_ABSENT=PASS")
print("D97_MTL_DIAGNOSTIC_HELPER_AND_CALL_ABSENT=PASS")
print("D97AD_HELPER_AND_CALL_PRESENT_EXACTLY_ONCE=PASS")
print("D97AEI_BUILD_RESUME_AUTHORIZED=YES_BUILD_DEPLOY_ONLY_NO_SOURCE_REINTEGRATION")
PY

echo "===== FINAL ====="
echo "D97AEI_READONLY_HISTORICAL_SOURCE_SEGMENT_AND_POST_TRANSITION_AUDIT=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "BUILD=AUTO-NO"
echo "DEPLOY=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_audit_then_identity_pinned_build_deploy_only_resume"
echo "REPORT=$REPORT"
