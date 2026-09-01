#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97WA_DIRECT_PINNED_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT_WRAPPER_REPORT.txt"
CORE_REPORT="$HOME/Desktop/OCLP7_D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT_REPORT.txt"
CORE_COMMIT="c849255bd90a59d8c01378708ff8780cdedbeded"
CORE_BLOB_EXPECTED="db02543255b73026b5474686e2014c330c594a45"
CORE_NAME="OCLP7_D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT.command"
CORE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/$CORE_COMMIT/$CORE_NAME"
TMP="$(/usr/bin/mktemp -t oclp-d97wa).command"
trap '/bin/rm -f "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97WA_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97WA — DIRECT PINNED ACCELERATED llvmVersion CRASH AUDIT WRAPPER ====="
echo "CORE_COMMIT=$CORE_COMMIT"
echo "CORE_BLOB_EXPECTED=$CORE_BLOB_EXPECTED"
echo "ACCELERATED_BOOT=2026-09-01_14:00"
echo "VESA_RECOVERY_BOOT=2026-09-01_14:03_EXCLUDED"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

for t in curl git python3 zsh; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
PYTHON_BIN="$(command -v python3)"
"$PYTHON_BIN" --version 2>&1
/usr/bin/curl -fL "$CORE_URL" -o "$TMP"
ACTUAL="$(/usr/bin/git hash-object "$TMP")"
echo "D97WA_CORE_BLOB_ACTUAL=$ACTUAL"
[[ "$ACTUAL" == "$CORE_BLOB_EXPECTED" ]] || fail "CORE_BLOB_MISMATCH:$ACTUAL"
echo "D97WA_CORE_IDENTITY=PASS"
/bin/zsh -n "$TMP"
echo "D97WA_CORE_ZSH_PARSE=PASS"

"$PYTHON_BIN" - "$TMP" <<'PYAUD'
from pathlib import Path
import re,sys
p=Path(sys.argv[1]); s=p.read_text()
blocks=re.findall(r"<<'PY'\n(.*?)\nPY\n",s,re.S)
print('D97WA_EMBEDDED_PYTHON_BLOCK_COUNT='+str(len(blocks)))
if len(blocks)!=1:raise SystemExit('EMBEDDED_PYTHON_BLOCK_CARDINALITY_FAIL')
compile(blocks[0],str(p)+'::<PY>','exec')
print('D97WA_EMBEDDED_PYTHON_COMPILE=PASS')
required=(
 'ACCELERATED_BOOT=2026-09-01_14:00',
 'VESA_RECOVERY_BOOT=2026-09-01_14:03_EXCLUDED',
 'EXPECTED_CRASH_IDENTITY=MTLCompilerService_SIGILL_EXC_BAD_INSTRUCTION_image_plus_0x25C3',
 'REGISTER_CONTRACT=RAX_full_uint64_llvmVersion_EAX_low32_exact_selector',
 'RUNTIME_LLVMVERSION_3802_PROVEN_ALL_OBSERVED_EXACT_CAPTURES',
 'RUNTIME_LLVMVERSION_32023_PROVEN_ALL_OBSERVED_EXACT_CAPTURES',
 'D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT=PASS',
 'ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO','SERVICE_LAUNCH=AUTO-NO'
)
missing=[x for x in required if x not in s]
print('D97WA_REQUIRED_ANCHORS_MISSING='+repr(missing))
if missing:raise SystemExit('STATIC_CONTRACT_ANCHOR_FAIL')
# Match executable mutation/reboot commands only at shell-command positions; do not match report labels such as REBOOT=AUTO-NO.
forbidden=[]
patterns=(
 r'(?m)^\s*(?:/usr/bin/)?sudo\b',
 r'(?m)^\s*(?:/usr/sbin/|/sbin/)?bless\b',
 r'(?m)^\s*(?:/usr/bin/)?kmutil\s+install\b',
 r'(?m)^\s*(?:/sbin/)?mount\s+-uw\b',
 r'(?m)^\s*(?:/sbin/)?shutdown\b',
 r'(?m)^\s*(?:/sbin/)?reboot\b',
 r'(?m)^\s*(?:/bin/)?launchctl\s+(?:kickstart|start|bootstrap)\b',
 r'(?m)^\s*(?:/usr/bin/)?open\s+.*OpenCore-Patcher'
)
for pat in patterns:
    if re.search(pat,s,re.I):forbidden.append(pat)
print('D97WA_FORBIDDEN_OPERATION_MATCHES='+repr(forbidden))
if forbidden:raise SystemExit('FORBIDDEN_OPERATION_STATIC_AUDIT_FAIL')
print('D97WA_STATIC_READONLY_CONTRACT_AUDIT=PASS')
PYAUD

echo "===== EXECUTE PINNED D97W CORE ====="
set +e
/bin/zsh "$TMP"
CORE_RC=$?
set -e
echo "D97WA_CORE_RC=$CORE_RC"
[[ "$CORE_RC" -eq 0 ]] || fail "CORE_FAILED_RC:$CORE_RC"
[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
/usr/bin/grep -Fq 'D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT=PASS' "$CORE_REPORT" || fail "CORE_FINAL_PASS_GATE_MISSING"
/usr/bin/grep -Fq 'ROOT_PATCH=AUTO-NO' "$CORE_REPORT" || fail "CORE_ROOT_PATCH_GATE_MISSING"
/usr/bin/grep -Fq 'REBOOT=AUTO-NO' "$CORE_REPORT" || fail "CORE_REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97WA_WRAPPER=PASS"
echo "D97WA_CORE_RC=0"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "NEXT=assistant_audit_exact_D97V_terminal_RAX_result"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
