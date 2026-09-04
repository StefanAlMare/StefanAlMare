#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="9f02c5c8200d2f37a785b0e87cd3ba8906a6da97"
BASE_BLOB="7a2cd15ca7aebdb3fe3d4a530b8aed79ecab9074"
BASE_NAME="OCLP7_D97AX_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AX_V2.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AX_V2.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AX_V2_WRAPPER=FAIL|REASON=$1"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$BASE_BLOB" "$PATCHED" <<'PY'
import hashlib,sys
from pathlib import Path
base=Path(sys.argv[1]); expected=sys.argv[2]; out=Path(sys.argv[3])
b=base.read_bytes()
blob=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97AX_V2_BASE_EXPECTED_BLOB='+expected)
print('D97AX_V2_BASE_ACTUAL_BLOB='+blob)
if blob!=expected: raise SystemExit('BASE_BLOB_MISMATCH')
old=b'/usr/bin/system_profiler'; new=b'/usr/sbin/system_profiler'
count=b.count(old)
print('D97AX_V2_SYSTEM_PROFILER_PATH_REPLACEMENT_COUNT='+str(count))
if count!=2: raise SystemExit('SYSTEM_PROFILER_PATH_PREIMAGE_COUNT_FAIL')
p=b.replace(old,new)
if p.count(old)!=0 or p.count(new)!=2: raise SystemExit('SYSTEM_PROFILER_PATH_POSTIMAGE_FAIL')
out.write_bytes(p)
print('D97AX_V2_PATCHED_BYTES='+str(len(p)))
print('D97AX_V2_PATCHED_SHA256='+hashlib.sha256(p).hexdigest())
print('D97AX_V2_TRANSFORM=EXACT_TWO_SYSTEM_PROFILER_PATH_REPLACEMENTS_ONLY')
PY

/bin/zsh -n "$PATCHED" || fail "PATCHED_ZSH_PARSE"

"$PYTHON" - "$PATCHED" <<'PY'
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
if len(blocks)!=3: raise SystemExit(f'EXPECTED_3_PY_BLOCKS_GOT_{len(blocks)}')
for n,b in enumerate(blocks,1): compile(b,f'<D97AX_V2_PY_{n}>','exec')
print('D97AX_V2_EMBEDDED_PYTHON_BLOCK_COUNT=3')
print('D97AX_V2_EMBEDDED_PYTHON_COMPILE=PASS')
PY

echo "D97AX_V2_IDENTITY_TRANSFORM_AND_PARSE=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "CACHE_EXTRACTION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AX_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
