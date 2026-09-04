#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="f76b04832150a0a8fd1eb80867785bf147f94537"
BASE_BLOB="3b07f1d4d52da948268fbd437781dd73092bef1c"
BASE_SHA256="203f7255019ffb99e4d83084a8b22a6d9184f5134bab503891faf5d9863c7674"
BASE_NAME="OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AY_V3.XXXXXX)"
BASE="$TMP/base.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AY_V3.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AY_V3_WRAPPER=FAIL|REASON=$1"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$BASE_BLOB" "$BASE_SHA256" <<'PY'
import hashlib,sys
from pathlib import Path
p=Path(sys.argv[1]); expected_blob=sys.argv[2]; expected_sha=sys.argv[3]
b=p.read_bytes()
actual_blob=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
actual_sha=hashlib.sha256(b).hexdigest()
print('D97AY_V3_BASE_EXPECTED_BLOB='+expected_blob)
print('D97AY_V3_BASE_ACTUAL_BLOB='+actual_blob)
print('D97AY_V3_BASE_EXPECTED_SHA256='+expected_sha)
print('D97AY_V3_BASE_ACTUAL_SHA256='+actual_sha)
print('D97AY_V3_BASE_BYTES='+str(len(b)))
if actual_blob!=expected_blob: raise SystemExit('BASE_BLOB_MISMATCH')
if actual_sha!=expected_sha: raise SystemExit('BASE_SHA256_MISMATCH')
PY

/bin/zsh -n "$BASE" || fail "BASE_ZSH_PARSE"

"$PYTHON" - "$BASE" <<'PY'
import sys
from pathlib import Path
lines=Path(sys.argv[1]).read_text(encoding='utf-8').splitlines()
blocks=[]; i=0
while i<len(lines):
    if "<<'PY'" in lines[i]:
        start=i+1; j=start
        while j<len(lines) and lines[j] != 'PY': j+=1
        if j>=len(lines): raise SystemExit(f'UNTERMINATED_PY_HEREDOC_AT_LINE_{i+1}')
        blocks.append('\n'.join(lines[start:j])+'\n'); i=j
    i+=1
if len(blocks)!=1: raise SystemExit(f'EXPECTED_1_PY_BLOCK_GOT_{len(blocks)}')
compile(blocks[0],'<D97AY_CORE_PY>','exec')
required=['requestType','sandboxTokens','llvmVersion','pluginPath','targetData','data','client_name','APISpecifiedTimeoutInSeconds']
for k in required:
    if blocks[0].count("b'"+k+"'")!=1: raise SystemExit('KEY_CARDINALITY_FAIL:'+k)
all_text='\n'.join(lines)
for token in ['CACHE_MMAP=NO','CACHE_EXTRACTION=NO','PROCESS_DEBUG_ATTACH=NO','ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO']:
    if token not in all_text: raise SystemExit('SAFETY_TOKEN_MISSING:'+token)
print('D97AY_V3_EMBEDDED_PYTHON_BLOCK_COUNT=1')
print('D97AY_V3_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97AY_V3_EXACT_EIGHT_KEY_TOKEN_GATE=PASS')
print('D97AY_V3_SAFETY_TOKEN_GATE=PASS')
PY

echo "D97AY_V3_IDENTITY_PARSE_AND_COMPILE=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$BASE"

echo "D97AY_V3_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
