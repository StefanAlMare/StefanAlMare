#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="f76b04832150a0a8fd1eb80867785bf147f94537"
BASE_BLOB="1ae81e5221d105603a9d9f8174a0506371564bee"
BASE_NAME="OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AY_V2.XXXXXX)"
BASE="$TMP/base.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AY_V2.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AY_V2_WRAPPER=FAIL|REASON=$1"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$BASE_BLOB" <<'PY'
import hashlib,sys
from pathlib import Path
p=Path(sys.argv[1]); expected=sys.argv[2]
b=p.read_bytes(); actual=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97AY_V2_BASE_EXPECTED_BLOB='+expected)
print('D97AY_V2_BASE_ACTUAL_BLOB='+actual)
print('D97AY_V2_BASE_BYTES='+str(len(b)))
print('D97AY_V2_BASE_SHA256='+hashlib.sha256(b).hexdigest())
if actual!=expected: raise SystemExit('BASE_BLOB_MISMATCH')
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
for token in ['CACHE_MMAP=NO','CACHE_EXTRACTION=NO','PROCESS_DEBUG_ATTACH=NO','ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO']:
    if token not in '\n'.join(lines): raise SystemExit('SAFETY_TOKEN_MISSING:'+token)
print('D97AY_V2_EMBEDDED_PYTHON_BLOCK_COUNT=1')
print('D97AY_V2_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97AY_V2_EXACT_EIGHT_KEY_TOKEN_GATE=PASS')
print('D97AY_V2_SAFETY_TOKEN_GATE=PASS')
PY

echo "D97AY_V2_IDENTITY_PARSE_AND_COMPILE=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$BASE"

echo "D97AY_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
