#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="4c3c76b826b50d6b98ff400baac1b65c709508f7"
BASE_BLOB="b9fd1966c7d88a98284dd5775cacb59036b26e00"
BASE_NAME="OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_DYNAMIC_METAL_AND_BOOT3M.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BA_V2.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BA_V2.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BA_V2_WRAPPER=FAIL|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$PATCHED" "$BASE_BLOB" <<'PY'
import hashlib,sys
from pathlib import Path
src=Path(sys.argv[1]); dst=Path(sys.argv[2]); expected=sys.argv[3]
b=src.read_bytes(); actual=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97BA_V2_BASE_EXPECTED_BLOB='+expected)
print('D97BA_V2_BASE_ACTUAL_BLOB='+actual)
print('D97BA_V2_BASE_BYTES='+str(len(b)))
print('D97BA_V2_BASE_SHA256='+hashlib.sha256(b).hexdigest())
if actual!=expected: raise SystemExit('BASE_BLOB_MISMATCH')
s=b.decode('utf-8')
old="pid=v(r,'processIdentifier','pid')"
new="pid=v(r,'processID','processIdentifier','pid')"
count=s.count(old)
print('D97BA_V2_PID_TRANSFORM_MATCH_COUNT='+str(count))
if count!=1: raise SystemExit('PID_TRANSFORM_CARDINALITY')
s=s.replace(old,new,1)
dst.write_text(s,encoding='utf-8')
pb=dst.read_bytes()
print('D97BA_V2_PATCHED_BYTES='+str(len(pb)))
print('D97BA_V2_PATCHED_SHA256='+hashlib.sha256(pb).hexdigest())
print('D97BA_V2_TRANSFORM=EXACT_PROCESSID_PREFERENCE_ONLY')
PY

/bin/zsh -n "$PATCHED" || fail "PATCHED_ZSH_PARSE"

"$PYTHON" - "$PATCHED" <<'PY'
import sys
from pathlib import Path
lines=Path(sys.argv[1]).read_text(encoding='utf-8').splitlines()
blocks=[];i=0
while i<len(lines):
    if "<<'PY'" in lines[i]:
        start=i+1;j=start
        while j<len(lines) and lines[j]!='PY':j+=1
        if j>=len(lines):raise SystemExit(f'UNTERMINATED_PY_HEREDOC_AT_{i+1}')
        blocks.append('\n'.join(lines[start:j])+'\n');i=j
    i+=1
if len(blocks)!=4:raise SystemExit(f'EXPECTED_4_PY_BLOCKS_GOT_{len(blocks)}')
for n,b in enumerate(blocks,1):compile(b,f'<D97BA_PY_{n}>','exec')
text='\n'.join(lines)
for tok in ['EXPECTED_OS_VERSION="15.8"','EXPECTED_OS_BUILD="24H22"','raw=pread(fd,fo1-fo0,fo0)','METAL_TEXT_SHA256=','SEQUOIA_15_8_PRIMARY_EIGHT_KEY_OFFSETS_MATCH_15_7_9=','SEQUOIA_15_8_BOOT3M_DUAL_GENERATION_OBSERVED=','CACHE_MMAP=NO','CACHE_EXTRACTION=NO','PROCESS_DEBUG_ATTACH=NO','ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO']:
    if tok not in text:raise SystemExit('REQUIRED_TOKEN_MISSING:'+tok)
for bad in ['mmap.mmap(','dyld_shared_cache_util -extract','dsc_extractor']:
    if bad in text:raise SystemExit('FORBIDDEN_TOKEN_PRESENT:'+bad)
print('D97BA_V2_EMBEDDED_PYTHON_BLOCK_COUNT=4')
print('D97BA_V2_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97BA_V2_METAL_RANGE_ONLY_GATE=PASS')
print('D97BA_V2_SAFETY_GATE=PASS')
PY

echo "D97BA_V2_IDENTITY_TRANSFORM_PARSE_AND_COMPILE=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97BA_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
