#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="fb509db4b1e40c8e9c466fed45b53c8462ed408c"
BASE_BLOB="fec92ab86cad92cc69307284c6ad3cd26ed74c19"
BASE_NAME="OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"
EXPECTED_METAL_TEXT_SHA256="f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865"
CACHE="/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h"
METAL_START="0x7FF80D343000"
METAL_END="0x7FF80D5C5C3D"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AZ_V4.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AZ_V4.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AZ_V4_WRAPPER=FAIL|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -f "$CACHE" ]] || fail "MISSING_CACHE"
/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD"

"$PYTHON" - "$BASE" "$PATCHED" "$BASE_BLOB" <<'PY'
import hashlib,sys
from pathlib import Path
src=Path(sys.argv[1]); dst=Path(sys.argv[2]); expected=sys.argv[3]
b=src.read_bytes(); actual=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
print('D97AZ_V4_BASE_EXPECTED_BLOB='+expected)
print('D97AZ_V4_BASE_ACTUAL_BLOB='+actual)
print('D97AZ_V4_BASE_BYTES='+str(len(b)))
print('D97AZ_V4_BASE_SHA256='+hashlib.sha256(b).hexdigest())
if actual!=expected: raise SystemExit('BASE_BLOB_MISMATCH')
s=b.decode('utf-8')
repls=[
('EXPECTED_OS_VERSION="15.7.9"','EXPECTED_OS_VERSION="15.8"'),
('EXPECTED_OS_BUILD="24G830"','EXPECTED_OS_BUILD="24H22"'),
('PRIMARY=(0x7FF80D370600,0x7FF80D370B80)','PRIMARY=(0x7FF80D37081F,0x7FF80D370B80)'),
('ALT_DATA=(0x7FF80D41E700,0x7FF80D41EA00)','ALT_DATA=(0x7FF80D41E881,0x7FF80D41EA00)'),
('ALT_REQUESTTYPE=(0x7FF80D44B880,0x7FF80D44BB80)','ALT_REQUESTTYPE=(0x7FF80D44B9E1,0x7FF80D44BB80)'),
("""    if m:\n        raw=int(m.group(1),16)\n        # Wrapped disassembly target is range-relative unless otool printed a fully external-sized address.\n        if raw < 0x10000000:return base+raw\n        return raw\n""","""    if m:\n        raw=int(m.group(1),16)\n        if raw >= (1<<63): raw -= (1<<64)\n        return base+raw\n""")]
for old,new in repls:
    c=s.count(old)
    print('D97AZ_V4_TRANSFORM_MATCH_COUNT='+str(c)+'|OLD='+old.splitlines()[0])
    if c!=1: raise SystemExit('TRANSFORM_CARDINALITY_FAIL:'+old.splitlines()[0])
    s=s.replace(old,new,1)
dst.write_text(s,encoding='utf-8')
pb=dst.read_bytes()
print('D97AZ_V4_PATCHED_BYTES='+str(len(pb)))
print('D97AZ_V4_PATCHED_SHA256='+hashlib.sha256(pb).hexdigest())
print('D97AZ_V4_TRANSFORM=EXACT_OS15_8_BUILD24H22_PLUS_THREE_ALIGNED_RANGE_STARTS_PLUS_SIGNED_REL32_ONLY')
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
compile(blocks[0],'<D97AZ_V4_CORE_PY>','exec')
body='\n'.join(lines)
for exact in ['EXPECTED_OS_VERSION="15.8"','EXPECTED_OS_BUILD="24H22"','PRIMARY=(0x7FF80D37081F,0x7FF80D370B80)','ALT_DATA=(0x7FF80D41E881,0x7FF80D41EA00)','ALT_REQUESTTYPE=(0x7FF80D44B9E1,0x7FF80D44BB80)','if raw >= (1<<63): raw -= (1<<64)','return base+raw']:
    if exact not in body: raise SystemExit('PATCHED_INVARIANT_MISSING:'+exact)
required=['llvmVersion','requestType','sandboxTokens','targetData','data','pluginPath','client_name','APISpecifiedTimeoutInSeconds']
for k in required:
    if k not in body: raise SystemExit('REQUIRED_KEY_MISSING:'+k)
print('D97AZ_V4_EMBEDDED_PYTHON_BLOCK_COUNT=1')
print('D97AZ_V4_EMBEDDED_PYTHON_COMPILE=PASS')
print('D97AZ_V4_OS_RANGE_REL32_AND_EIGHT_KEY_GATE=PASS')
PY

"$PYTHON" - "$CACHE" "$METAL_START" "$METAL_END" "$EXPECTED_METAL_TEXT_SHA256" <<'PY'
import hashlib,os,struct,sys
p=sys.argv[1]; start=int(sys.argv[2],0); end=int(sys.argv[3],0); expected=sys.argv[4]
fd=os.open(p,os.O_RDONLY)
try:
    h=os.pread(fd,0x300,0)
    if len(h)<0x20: raise SystemExit('CACHE_HEADER_SHORT')
    mo=struct.unpack_from('<I',h,0x10)[0]; mc=struct.unpack_from('<I',h,0x14)[0]
    if not (0<mc<=4096): raise SystemExit('CACHE_MAP_COUNT')
    raw=os.pread(fd,mc*32,mo)
    maps=[]
    for i in range(mc):
        vm,sz,fo,maxp,initp=struct.unpack_from('<QQQII',raw,i*32)
        maps.append((vm,vm+sz,fo,fo+sz))
    def loc(vm):
        for vs,ve,fs,fe in maps:
            if vs<=vm<ve: return fs+(vm-vs)
        return None
    a=loc(start); b=loc(end-1)
    if a is None or b is None: raise SystemExit('METAL_RANGE_UNMAPPED')
    d=os.pread(fd,(b+1)-a,a)
finally:
    os.close(fd)
actual=hashlib.sha256(d).hexdigest()
print('D97AZ_V4_EXPECTED_METAL_TEXT_SHA256='+expected)
print('D97AZ_V4_ACTUAL_METAL_TEXT_SHA256='+actual)
print('D97AZ_V4_METAL_TEXT_BYTES='+str(len(d)))
if actual!=expected: raise SystemExit('METAL_TEXT_SHA256_MISMATCH')
print('D97AZ_V4_METAL_TEXT_IDENTITY=PASS')
PY

echo "D97AZ_V4_IDENTITY_TRANSFORM_PARSE_COMPILE_AND_METAL_PIN=PASS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "PERSISTENT_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AZ_V4_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
