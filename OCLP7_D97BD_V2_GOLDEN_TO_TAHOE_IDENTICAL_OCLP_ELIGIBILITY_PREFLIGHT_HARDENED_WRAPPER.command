#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="f39dd21f73a66df4b1a3cdadf13c14e1688b5b58"
BASE_BLOB="a3dbc95d8688157692b30e738bbe98e51c2cef94"
BASE_NAME="OCLP7_D97BD_GOLDEN_TO_TAHOE_IDENTICAL_OCLP_ELIGIBILITY_PREFLIGHT.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BD_V2.XXXXXX)"
BASE="$TMP/base.command"
cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BD_V2.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BD_V2_WRAPPER=FAIL|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "SOURCE_MUTATION=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$BASE_BLOB" <<'PY'
import hashlib,sys
from pathlib import Path
p=Path(sys.argv[1]); expected=sys.argv[2]
b=p.read_bytes(); actual=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97BD_V2_BASE_EXPECTED_BLOB='+expected)
print('D97BD_V2_BASE_ACTUAL_BLOB='+actual)
print('D97BD_V2_BASE_BYTES='+str(len(b)))
print('D97BD_V2_BASE_SHA256='+hashlib.sha256(b).hexdigest())
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
compile(blocks[0],'<D97BD_CORE_PY>','exec')
text='\n'.join(lines)
required=[
 'EXPECTED_OS_VERSION="15.8"','EXPECTED_OS_BUILD="24H22"',
 'SOURCE_MUTATION=NO','GIT_FETCH_CHECKOUT_RESET=NO','PROCESS_DEBUG_ATTACH=NO','ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO',
 'OCLP APP IDENTITIES','CANONICAL SOURCE IDENTITY','GOLDEN INSTALLED OCLP/HASWELL COMPONENT IDENTITIES',
 'ELIGIBILITY / OS-SUPPORT CANDIDATES','HASWELL / PAYLOAD / DONOR INFLUENCE HITS','HISTORICAL CUSTOM-MARKER CENSUS',
 'ELIGIBILITY_ONLY_DELTA=NOT_YET_CLAIMED_REQUIRES_ASSISTANT_AUDIT'
]
for tok in required:
    if tok not in text:raise SystemExit('REQUIRED_TOKEN_MISSING:'+tok)
# Reject state-changing git/source/system operations. Report-file/temp writes are expected.
for bad in [
 "git(source,'fetch'", "git(source,'checkout'", "git(source,'reset'", "git(source,'clean'", "git(source,'switch'",
 "subprocess.run(['/usr/bin/sudo'", "subprocess.run(['sudo'", 'os.remove(source', 'shutil.rmtree(source',
 'mmap.mmap(', 'dyld_shared_cache_util -extract', 'dsc_extractor', 'lldb -p', 'process attach'
]:
    if bad in text:raise SystemExit('FORBIDDEN_STATE_CHANGE_TOKEN:'+bad)
print('D97BD_V2_EMBEDDED_PYTHON_BLOCK_COUNT=1')
print('D97BD_V2_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97BD_V2_READONLY_SOURCE_AND_SYSTEM_GATE=PASS')
print('D97BD_V2_REQUIRED_CENSUS_GATE=PASS')
PY

echo "D97BD_V2_IDENTITY_PARSE_COMPILE_AND_SAFETY=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "SOURCE_MUTATION=NO"
echo "GIT_FETCH_CHECKOUT_RESET=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$BASE"

echo "D97BD_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
