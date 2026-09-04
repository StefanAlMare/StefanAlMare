#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="fb509db4b1e40c8e9c466fed45b53c8462ed408c"
BASE_BLOB="fec92ab86cad92cc69307284c6ad3cd26ed74c19"
BASE_NAME="OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AZ_V3.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AZ_V3.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AZ_V3_WRAPPER=FAIL|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$PATCHED" "$BASE_BLOB" <<'PY'
import hashlib,sys
from pathlib import Path
src=Path(sys.argv[1]); dst=Path(sys.argv[2]); expected=sys.argv[3]
b=src.read_bytes(); actual=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97AZ_V3_BASE_EXPECTED_BLOB='+expected)
print('D97AZ_V3_BASE_ACTUAL_BLOB='+actual)
print('D97AZ_V3_BASE_BYTES='+str(len(b)))
print('D97AZ_V3_BASE_SHA256='+hashlib.sha256(b).hexdigest())
if actual!=expected: raise SystemExit('BASE_BLOB_MISMATCH')
s=b.decode('utf-8')
repls=[
("PRIMARY=(0x7FF80D370600,0x7FF80D370B80)","PRIMARY=(0x7FF80D37081F,0x7FF80D370B80)"),
("ALT_DATA=(0x7FF80D41E700,0x7FF80D41EA00)","ALT_DATA=(0x7FF80D41E881,0x7FF80D41EA00)"),
("ALT_REQUESTTYPE=(0x7FF80D44B880,0x7FF80D44BB80)","ALT_REQUESTTYPE=(0x7FF80D44B9E1,0x7FF80D44BB80)"),
("""    if m:\n        raw=int(m.group(1),16)\n        # Wrapped disassembly target is range-relative unless otool printed a fully external-sized address.\n        if raw < 0x10000000:return base+raw\n        return raw\n""","""    if m:\n        raw=int(m.group(1),16)\n        if raw >= (1<<63): raw -= (1<<64)\n        return base+raw\n""")]
for old,new in repls:
    c=s.count(old)
    print('D97AZ_V3_TRANSFORM_MATCH_COUNT='+str(c)+'|OLD='+old.splitlines()[0])
    if c!=1: raise SystemExit('TRANSFORM_CARDINALITY_FAIL:'+old.splitlines()[0])
    s=s.replace(old,new,1)
dst.write_text(s,encoding='utf-8')
pb=dst.read_bytes()
print('D97AZ_V3_PATCHED_BYTES='+str(len(pb)))
print('D97AZ_V3_PATCHED_SHA256='+hashlib.sha256(pb).hexdigest())
print('D97AZ_V3_TRANSFORM=EXACT_THREE_XREF_ALIGNED_RANGE_STARTS_PLUS_SIGNED_REL32_TRANSLATION_ONLY')
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
if len(blocks)!=1: raise SystemExit(f'EXPECTED_1_PY_BLOCK_GOT_{len(blocks)}')
compile(blocks[0],'<D97AZ_V3_CORE_PY>','exec')
body=blocks[0]
for exact in ['PRIMARY=(0x7FF80D37081F,0x7FF80D370B80)','ALT_DATA=(0x7FF80D41E881,0x7FF80D41EA00)','ALT_REQUESTTYPE=(0x7FF80D44B9E1,0x7FF80D44BB80)','if raw >= (1<<63): raw -= (1<<64)','return base+raw']:
    if exact not in body: raise SystemExit('PATCHED_INVARIANT_MISSING:'+exact)
required=['llvmVersion','requestType','sandboxTokens','targetData','data','pluginPath','client_name','APISpecifiedTimeoutInSeconds']
for k in required:
    if k not in body: raise SystemExit('REQUIRED_KEY_MISSING:'+k)
print('D97AZ_V3_EMBEDDED_PYTHON_BLOCK_COUNT=1')
print('D97AZ_V3_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97AZ_V3_ALIGNED_RANGE_AND_REL32_GATE=PASS')
print('D97AZ_V3_EIGHT_KEY_GATE=PASS')
PY

echo "D97AZ_V3_IDENTITY_TRANSFORM_PARSE_AND_COMPILE=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "PERSISTENT_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AZ_V3_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
