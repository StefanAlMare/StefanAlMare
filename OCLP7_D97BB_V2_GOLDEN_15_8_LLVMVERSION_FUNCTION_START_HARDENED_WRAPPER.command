#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="c05563fdeae951c5731051c73ac7e43fd7f2ffdd"
BASE_BLOB="c02a2e7c196f3260858be55f6175ba275120ac35"
BASE_NAME="OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BB_V2.XXXXXX)"
BASE="$TMP/base.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BB_V2.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BB_V2_WRAPPER=FAIL|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$BASE_BLOB" <<'PY'
import hashlib,sys
from pathlib import Path
p=Path(sys.argv[1]); expected=sys.argv[2]
b=p.read_bytes(); actual=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97BB_V2_BASE_EXPECTED_BLOB='+expected)
print('D97BB_V2_BASE_ACTUAL_BLOB='+actual)
print('D97BB_V2_BASE_BYTES='+str(len(b)))
print('D97BB_V2_BASE_SHA256='+hashlib.sha256(b).hexdigest())
if actual!=expected: raise SystemExit('BASE_BLOB_MISMATCH')
PY

/bin/zsh -n "$BASE" || fail "BASE_ZSH_PARSE"

"$PYTHON" - "$BASE" <<'PY'
import sys
from pathlib import Path
lines=Path(sys.argv[1]).read_text(encoding='utf-8').splitlines()
blocks=[];i=0
while i<len(lines):
    if "<<'PY'" in lines[i]:
        start=i+1;j=start
        while j<len(lines) and lines[j] != 'PY':j+=1
        if j>=len(lines):raise SystemExit(f'UNTERMINATED_PY_HEREDOC_AT_{i+1}')
        blocks.append('\n'.join(lines[start:j])+'\n');i=j
    i+=1
if len(blocks)!=1:raise SystemExit(f'EXPECTED_1_PY_BLOCK_GOT_{len(blocks)}')
compile(blocks[0],'<D97BB_CORE_PY>','exec')
text='\n'.join(lines)
required=[
 'EXPECTED_OS_VERSION="15.8"','EXPECTED_OS_BUILD="24H22"',
 'EXPECTED_METAL_TEXT_SHA="f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865"',
 'LLVM_XREF="0x7FF80D37081F"','LLVM_KEY_VM="0x7FF80D53DBDB"','UINT64_SETTER_TARGET="0x7FF80D50FDCE"',
 'LC_FUNCTION_STARTS=0x26','D97BB_FUNCTION_BOUNDARY=LC_FUNCTION_STARTS_PROVEN',
 'G1_GOLDEN_LLVMVERSION_SOURCE_CLASS=','SYSTEM_FILE_MUTATION=NO','CACHE_MMAP=NO',
 'PROCESS_DEBUG_ATTACH=NO','ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO']
for tok in required:
    if tok not in text:raise SystemExit('REQUIRED_TOKEN_MISSING:'+tok)
for bad in ['mmap.mmap(','dyld_shared_cache_util -extract','dsc_extractor','lldb -p','process attach']:
    if bad in text:raise SystemExit('FORBIDDEN_TOKEN_PRESENT:'+bad)
print('D97BB_V2_EMBEDDED_PYTHON_BLOCK_COUNT=1')
print('D97BB_V2_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97BB_V2_FUNCTION_STARTS_AND_METAL_PIN_GATE=PASS')
print('D97BB_V2_SAFETY_GATE=PASS')
PY

echo "D97BB_V2_IDENTITY_PARSE_COMPILE_AND_SAFETY=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "PERSISTENT_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$BASE"

echo "D97BB_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
