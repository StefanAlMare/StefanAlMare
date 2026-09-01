#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97ZA_DIRECT_PINNED_INPLACE_EXIT_CLASSIFIER_FASTLANE_WRAPPER_REPORT.txt"
CORE_REPORT="$HOME/Desktop/OCLP7_FASTLANE_D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER_REPORT.txt"
PAYLOAD_COMMIT="09543f3f5e7ad816d15650580ed17165eb698b0f"
PAYLOAD_DIR="OCLP7-D97ZA-payload"
CORE_SHA256_EXPECTED="419516697a9d69b888ec8fb03c10d6892c809c2e1a7653f190739f87350c3716"
PART1_BLOB="ad2bac11c3875ae725855031cae5c00de443935d"
PART2_BLOB="02325e749088750bef7ce02cfb9cfa09f8d32f29"
PART3_BLOB="74517f92d02917fd839f3034f73e51875377ac67"
PART4_BLOB="4177b268cad02d4c740fe8b1ac53c08e451ad9a6"
TMPDIR_D97ZA="$(/usr/bin/mktemp -d -t oclp-d97za)"
TMP_CORE="$TMPDIR_D97ZA/OCLP7_FASTLANE_D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER.command"
TMP_B64="$TMPDIR_D97ZA/core.b64"
trap '/bin/rm -rf "$TMPDIR_D97ZA"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97ZA_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97ZA — DIRECT PINNED IN-PLACE llvmVersion EXIT-CLASSIFIER FASTLANE WRAPPER ====="
echo "PAYLOAD_COMMIT=$PAYLOAD_COMMIT"
echo "CORE_SHA256_EXPECTED=$CORE_SHA256_EXPECTED"
echo "INPUT_D97Y=INPLACE_COMPLETE_INSTRUCTION_BLOCK_AND_CLASSIFIER_STATIC_PROVEN"
echo "D97V_REPLACED_NOT_STACKED=YES"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

for t in curl git python3 zsh shasum; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
PYTHON_BIN="$(command -v python3)"
"$PYTHON_BIN" --version 2>&1

names=(
  OCLP7_D97Z_CORE_PAYLOAD.part1.b64
  OCLP7_D97Z_CORE_PAYLOAD.part2.b64
  OCLP7_D97Z_CORE_PAYLOAD.part3.b64
  OCLP7_D97Z_CORE_PAYLOAD.part4.b64
)
blobs=("$PART1_BLOB" "$PART2_BLOB" "$PART3_BLOB" "$PART4_BLOB")
: > "$TMP_B64"
for i in {1..4}; do
  idx=$((i-1))
  name="${names[$i]}"
  expected="${blobs[$i]}"
  part="$TMPDIR_D97ZA/$name"
  url="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/$PAYLOAD_COMMIT/$PAYLOAD_DIR/$name"
  /usr/bin/curl -fL "$url" -o "$part"
  actual="$(/usr/bin/git hash-object "$part")"
  echo "D97ZA_PAYLOAD_PART_${i}_BLOB_ACTUAL=$actual"
  [[ "$actual" == "$expected" ]] || fail "PAYLOAD_PART_${i}_BLOB_MISMATCH:$actual"
  /bin/cat "$part" >> "$TMP_B64"
done
echo "D97ZA_PAYLOAD_PART_IDENTITIES=PASS"

echo "D97ZA_PAYLOAD_BASE64_LENGTH=$(wc -c < "$TMP_B64" | tr -d ' ')"
"$PYTHON_BIN" - "$TMP_B64" "$TMP_CORE" "$CORE_SHA256_EXPECTED" <<'PYUNPACK'
from pathlib import Path
import base64,gzip,hashlib,sys
src=Path(sys.argv[1]);dst=Path(sys.argv[2]);expected=sys.argv[3]
raw=base64.b64decode(src.read_text())
core=gzip.decompress(raw)
actual=hashlib.sha256(core).hexdigest()
print('D97ZA_CORE_SHA256_ACTUAL='+actual)
if actual!=expected:raise SystemExit('CORE_SHA256_MISMATCH')
dst.write_bytes(core);dst.chmod(0o755)
print('D97ZA_CORE_IDENTITY=PASS')
PYUNPACK

/bin/zsh -n "$TMP_CORE"
echo "D97ZA_CORE_ZSH_PARSE=PASS"

"$PYTHON_BIN" - "$TMP_CORE" <<'PYAUD'
from pathlib import Path
import re,sys
p=Path(sys.argv[1]);s=p.read_text()
blocks=re.findall(r"<<'([A-Z0-9_]+)'\n(.*?)\n\1\n",s,re.S)
print('D97ZA_EMBEDDED_PYTHON_BLOCKS='+repr([x[0] for x in blocks]))
expected=['PYPRE','PYOFF','PYFIX','PYCOMPILE','PYAUD','PYPKG']
if [x[0] for x in blocks]!=expected:raise SystemExit('EMBEDDED_PYTHON_BLOCK_SEQUENCE_FAIL')
for name,code in blocks:compile(code,str(p)+'::<'+name+'>','exec')
print('D97ZA_EMBEDDED_PYTHON_COMPILE=PASS')
required=(
 'EXPECTED_LIVE_D97V_APP_SHA="9b2b981afb2cc4a56e3b9b8a2e97c454a3bcce9522a37d0cd17629bd5ae76e45"',
 'EXPECTED_VISIBLE_D97V_SERVICE_SHA="bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19"',
 'EXPECTED_SELECTOR_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"',
 'EXPECTED_D97Z_SERVICE_SHA="2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c"',
 'BLOCK_END=$((0x25EB))',
 'EXIT_3802=123','EXIT_32023=124','EXIT_OTHER=125',
 'D97V_HELPER_REPLACED_BY_D97Z=PASS','D97V_CALL_REPLACED_BY_D97Z=PASS',
 'PACKAGED_D97Z_RUN_AS_ROOT_CALL_COUNT=',
 'FASTLANE_D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER=PASS',
 'ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO')
missing=[x for x in required if x not in s]
print('D97ZA_REQUIRED_ANCHORS_MISSING='+repr(missing))
if missing:raise SystemExit('STATIC_CONTRACT_ANCHOR_FAIL')
forbidden=[]
for ln in s.splitlines():
    q=ln.strip().lower()
    if q.startswith(('/sbin/reboot','sudo /sbin/reboot','shutdown -r','sudo shutdown -r')):forbidden.append(ln)
    if 'start_root_patch' in q or 'patch_root_volume(' in q:forbidden.append(ln)
print('D97ZA_FORBIDDEN_AUTOMATION_LINES='+repr(forbidden))
if forbidden:raise SystemExit('FORBIDDEN_AUTOMATION_STATIC_AUDIT_FAIL')
print('D97ZA_STATIC_FASTLANE_CONTRACT_AUDIT=PASS')
PYAUD

echo "===== EXECUTE PINNED D97Z CORE ====="
set +e
/bin/zsh "$TMP_CORE"
CORE_RC=$?
set -e
echo "D97ZA_CORE_RC=$CORE_RC"
[[ "$CORE_RC" -eq 0 ]] || fail "CORE_FAILED_RC:$CORE_RC"
[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
/usr/bin/grep -Fq 'FASTLANE_D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER=PASS' "$CORE_REPORT" || fail "CORE_FINAL_PASS_GATE_MISSING"
/usr/bin/grep -Fq 'D97V_REPLACED_NOT_STACKED=PASS' "$CORE_REPORT" || fail "CORE_REPLACEMENT_GATE_MISSING"
/usr/bin/grep -Fq 'ROOT_PATCH=AUTO-NO' "$CORE_REPORT" || fail "CORE_ROOT_PATCH_GATE_MISSING"
/usr/bin/grep -Fq 'REBOOT=AUTO-NO' "$CORE_REPORT" || fail "CORE_REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97ZA_WRAPPER=PASS"
echo "D97ZA_CORE_RC=0"
echo "D97V_REPLACED_NOT_STACKED=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_full_FASTLANE_audit_before_manual_Root_Patch"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
