#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEU_READONLY_DYLD_CACHE_32023_BYTE_IDENTITY_MAP_REPORT.txt"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_FS_32023_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
EXPECTED_32023_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
TARGET_IMAGE_PATH="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){
  echo "D97AEU_FAIL=$*"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "RUNTIME_INSTRUMENTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

print "===== OCLP7 D97AEU — READ-ONLY DYLD-CACHE 32023 BYTE IDENTITY MAP ====="
print "INPUT_D97AEQ=28_of_28_exit1_zero_exit110_114"
print "INPUT_D97AES=runtime_sender_32023_path_UUID_proven_all_28_PIDs"
print "INPUT_D97AET=dyld_cache_contains_32023_path_runtime_cache_execution_unknown"
print "PURPOSE=read_exact_cached_32023_text_bytes_and_compare_D97AD_classifier_sites_against_P7_preimages_and_visible_D97AD_postimages"
print "TARGET_IMAGE_PATH=$TARGET_IMAGE_PATH"
print "EXPECTED_32023_UUID=$EXPECTED_32023_UUID"
print "SOURCE_MUTATION=NO"
print "SYSTEM_MUTATION=NO"
print "GOLDEN_MUTATION=NO"
print "SERVICE_LAUNCH=AUTO-NO"
print "RUNTIME_INSTRUMENTATION=NO"
print "ROOT_PATCH=AUTO-NO"
print "REBOOT=AUTO-NO"
print "D82_EXECUTION=NO"
print "PATCH8_AUTO_INTEGRATION=NO"
print "REPORT=$REPORT"

PRODUCT="$(/usr/bin/sw_vers -productVersion 2>/dev/null || true)"
BUILD="$(/usr/bin/sw_vers -buildVersion 2>/dev/null || true)"
PY="$(command -v python3 2>/dev/null || true)"
print "PRODUCT_VERSION=$PRODUCT"
print "BUILD_VERSION=$BUILD"
print "PYTHON_EXEC=${PY:-MISSING}"
[[ "$PRODUCT" == "26.6.2" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "25G82" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PY" && -x "$PY" ]] || fail "PYTHON3_MISSING"
for tool in shasum otool stat; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  print "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done
"$PY" --version 2>&1

[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING"
[[ -f "$MTL32023" ]] || fail "MTL32023_MISSING"
SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
FS_SHA="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
FS_UUID="$(/usr/bin/otool -l "$MTL32023" | /usr/bin/awk '/LC_UUID/{f=1;next} f&&/uuid/{print $2;exit}')"
print "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
print "VISIBLE_FS_32023_SHA=$FS_SHA"
print "VISIBLE_FS_32023_LC_UUID=$FS_UUID"
[[ "$SERVICE_SHA" == "$EXPECTED_SERVICE_SHA" ]] || fail "SERVICE_SHA_MISMATCH:$SERVICE_SHA"
[[ "$FS_SHA" == "$EXPECTED_FS_32023_SHA" ]] || fail "FS_32023_SHA_MISMATCH:$FS_SHA"
[[ "${FS_UUID:u}" == "$EXPECTED_32023_UUID" ]] || fail "FS_32023_UUID_MISMATCH:$FS_UUID"
print "VISIBLE_IDENTITIES=PASS"

"$PY" - "$MTL32023" "$EXPECTED_32023_UUID" "$TARGET_IMAGE_PATH" <<'PY'
from pathlib import Path
import hashlib, mmap, os, struct, sys, uuid

fs_path=Path(sys.argv[1])
expected_uuid=sys.argv[2].upper()
target_path=sys.argv[3]
fs=fs_path.read_bytes()

def u32(b,o): return struct.unpack_from('<I',b,o)[0]
def u64(b,o): return struct.unpack_from('<Q',b,o)[0]
def hexuuid(raw): return str(uuid.UUID(bytes=bytes(raw))).upper()
def cstr(mm,off,limit=4096):
    if off < 0 or off >= len(mm): raise RuntimeError(f'CSTRING_OFFSET_OOB:0x{off:X}')
    end=mm.find(b'\0',off,min(len(mm),off+limit))
    if end < 0: raise RuntimeError(f'CSTRING_NO_NUL:0x{off:X}')
    return mm[off:end].decode('utf-8','replace')

def fs_bytes(off,n):
    if off < 0 or off+n > len(fs): raise RuntimeError(f'FS_RANGE_OOB:0x{off:X}+{n}')
    return fs[off:off+n]

print('===== CACHE FILE DISCOVERY =====')
dirs=[
    Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),
    Path('/System/Cryptexes/OS/System/Library/dyld'),
    Path('/System/Library/dyld'),
]
found=[]
seen=set()
for d in dirs:
    if not d.is_dir(): continue
    for p in sorted(d.glob('dyld_shared_cache_x86_64h*')):
        try:
            st=p.stat()
        except Exception:
            continue
        if not p.is_file(): continue
        key=(st.st_dev,st.st_ino)
        if key in seen: continue
        seen.add(key)
        found.append(p)
        print(f'CACHE_FILE={p}|SIZE={st.st_size}|DEV={st.st_dev}|INO={st.st_ino}')
if not found:
    raise SystemExit('NO_X86_64H_CACHE_FILES')
print(f'CACHE_UNIQUE_FILE_COUNT={len(found)}')

class CacheFile:
    def __init__(self,path):
        self.path=path
        self.f=path.open('rb')
        self.mm=mmap.mmap(self.f.fileno(),0,access=mmap.ACCESS_READ)
        self.size=len(self.mm)
        self.magic=bytes(self.mm[:16]).rstrip(b'\0').decode('ascii','replace')
        if not self.magic.startswith('dyld_v1'):
            raise RuntimeError(f'BAD_CACHE_MAGIC:{path}:{self.magic!r}')
        self.mapping_off=u32(self.mm,0x10)
        self.mapping_count=u32(self.mm,0x14)
        if self.mapping_count > 128 or self.mapping_off+32*self.mapping_count > self.size:
            raise RuntimeError(f'BAD_MAPPING_TABLE:{path}:off=0x{self.mapping_off:X}:count={self.mapping_count}')
        self.mappings=[]
        for i in range(self.mapping_count):
            o=self.mapping_off+i*32
            addr=u64(self.mm,o); size=u64(self.mm,o+8); fo=u64(self.mm,o+16)
            maxp=u32(self.mm,o+24); initp=u32(self.mm,o+28)
            self.mappings.append((addr,size,fo,maxp,initp))
        self.images_text_off=u64(self.mm,0x88) if self.size >= 0x98 else 0
        self.images_text_count=u64(self.mm,0x90) if self.size >= 0x98 else 0
        self.platform=u32(self.mm,0xD8) if self.size >= 0xE0 else 0
        self.format_bits=u32(self.mm,0xDC) if self.size >= 0xE0 else 0
        self.dylibs_expected_on_disk=(self.format_bits >> 8) & 1
        print(f'CACHE_HEADER={path}|MAGIC={self.magic}|MAPPING_OFF=0x{self.mapping_off:X}|MAPPING_COUNT={self.mapping_count}|IMAGES_TEXT_OFF=0x{self.images_text_off:X}|IMAGES_TEXT_COUNT={self.images_text_count}|PLATFORM={self.platform}|DYLIBS_EXPECTED_ON_DISK={self.dylibs_expected_on_disk}')
        for j,(a,s,fo,mp,ip) in enumerate(self.mappings):
            print(f'CACHE_MAPPING={path}|INDEX={j}|VM=0x{a:X}..0x{a+s:X}|FILE=0x{fo:X}..0x{fo+s:X}|MAXPROT=0x{mp:X}|INITPROT=0x{ip:X}')
    def close(self):
        self.mm.close(); self.f.close()

caches=[]
try:
    for p in found:
        try:
            caches.append(CacheFile(p))
        except Exception as e:
            print(f'CACHE_FILE_PARSE_SKIP={p}|ERROR={e!r}')
    if not caches:
        raise SystemExit('NO_PARSEABLE_CACHE_FILES')

    print('===== CACHED IMAGE LOOKUP =====')
    image_hits=[]
    for c in caches:
        cnt=c.images_text_count; off=c.images_text_off
        if cnt==0: continue
        if cnt > 200000 or off+cnt*32 > c.size:
            print(f'IMAGES_TEXT_TABLE_REJECTED={c.path}|OFF=0x{off:X}|COUNT={cnt}')
            continue
        for i in range(cnt):
            o=off+i*32
            raw_uuid=bytes(c.mm[o:o+16])
            load=u64(c.mm,o+16)
            text_size=u32(c.mm,o+24)
            path_off=u32(c.mm,o+28)
            try:
                path=cstr(c.mm,path_off)
            except Exception:
                continue
            if path == target_path:
                image_hits.append((c,i,hexuuid(raw_uuid),load,text_size,path_off))
                print(f'CACHED_IMAGE_HIT=INDEX={i}|TABLE_FILE={c.path}|UUID={hexuuid(raw_uuid)}|LOAD=0x{load:X}|TEXT_SIZE=0x{text_size:X}|PATH_OFF=0x{path_off:X}|PATH={path}')
    if len(image_hits) != 1:
        raise SystemExit(f'CACHED_IMAGE_HIT_CARDINALITY_FAIL:{len(image_hits)}')
    table_cache,index,cached_uuid,image_load,text_size,path_off=image_hits[0]
    if cached_uuid.upper() != expected_uuid:
        raise SystemExit(f'CACHED_IMAGE_UUID_MISMATCH:{cached_uuid}')
    print('CACHED_IMAGE_PATH_UUID_IDENTITY=PASS')

    def locate_vm(vm,n=1):
        hits=[]
        for c in caches:
            for mi,(addr,size,fo,maxp,initp) in enumerate(c.mappings):
                if addr <= vm and vm+n <= addr+size:
                    foff=fo+(vm-addr)
                    if foff+n <= c.size:
                        hits.append((c,mi,foff,addr,size,fo))
        if len(hits)!=1:
            raise RuntimeError(f'VM_MAPPING_CARDINALITY:{len(hits)}:VM=0x{vm:X}:N={n}')
        return hits[0]

    def cache_read_image(off,n):
        vm=image_load+off
        c,mi,foff,ma,ms,mfo=locate_vm(vm,n)
        return bytes(c.mm[foff:foff+n]),c,mi,foff,vm

    print('===== CACHED MACH-O HEADER / TEXT IDENTITY =====')
    mh,c0,mi0,fo0,vm0=cache_read_image(0,32)
    if u32(mh,0)!=0xFEEDFACF:
        raise SystemExit(f'CACHED_MACHO_MAGIC_FAIL:{mh[:4].hex()}')
    ncmds=u32(mh,16); sizeofcmds=u32(mh,20)
    cmds,cc,cm,cfo,cvm=cache_read_image(0,32+sizeofcmds)
    off=32; text=None; lc_uuid=None
    for _ in range(ncmds):
        if off+8>len(cmds): raise SystemExit('CACHED_LOAD_COMMAND_TRUNCATED')
        cmd=u32(cmds,off); cmdsize=u32(cmds,off+4)
        if cmdsize<8 or off+cmdsize>len(cmds): raise SystemExit('CACHED_LOAD_COMMAND_INVALID')
        if cmd==0x19:
            seg=cmds[off+8:off+24].split(b'\0',1)[0].decode('ascii','replace')
            vmaddr=u64(cmds,off+24); vmsize=u64(cmds,off+32); fileoff=u64(cmds,off+40); filesize=u64(cmds,off+48)
            if seg=='__TEXT': text=(vmaddr,vmsize,fileoff,filesize)
        elif cmd==0x1B and cmdsize>=24:
            lc_uuid=hexuuid(cmds[off+8:off+24])
        off+=cmdsize
    print(f'CACHED_MACHO=LOAD=0x{image_load:X}|NCMDS={ncmds}|SIZEOFCMDS=0x{sizeofcmds:X}|LC_UUID={lc_uuid}|TEXT={text}')
    if lc_uuid is not None and lc_uuid.upper()!=expected_uuid:
        raise SystemExit(f'CACHED_MACHO_LC_UUID_MISMATCH:{lc_uuid}')
    if text is None: raise SystemExit('CACHED_TEXT_SEGMENT_MISSING')
    if text[0] != image_load or text[2] != 0:
        raise SystemExit(f'CACHED_TEXT_BASE_CONTRACT_FAIL:{text}')
    print('CACHED_MACHO_TEXT_BASE_CONTRACT=PASS')

    print('===== EXACT D97AD SIX-SITE CACHE BYTE DISCRIMINATOR =====')
    sites=[
        ('CANDIDATE_110',0x9D6BD,'8b8d10feffff83f941','6a6e5fe9bb38f6ff90'),
        ('BUFFER_111',0x9D3CC,'488d3599640200b91e000000','6a6f5fe9ac3bf6ff90909090'),
        ('SAMPLER_112',0x9D40B,'488d359764020083fa10','6a705fe96d3bf6ff9090'),
        ('NESTED_113',0x9D514,'488d35cc63020031c0','6a715fe9643af6ff90'),
        ('EARLY_RETURN_114',0x9D1EB,'4489f04881c488030000','6a725fe98d3df6ff9090'),
        ('UNWIND_114',0x9D7FE,'488dbd20feffffe8c45c0100','6a725fe97a37f6ff90909090'),
    ]
    counts={'PRE':0,'POST':0,'OTHER':0}
    for name,off,pre_hex,post_hex in sites:
        pre=bytes.fromhex(pre_hex); post=bytes.fromhex(post_hex)
        if len(pre)!=len(post): raise SystemExit(f'SITE_LENGTH_CONTRACT_FAIL:{name}')
        actual,c,mi,foff,vm=cache_read_image(off,len(pre))
        fsactual=fs_bytes(off,len(pre))
        state='PRE' if actual==pre else ('POST' if actual==post else 'OTHER')
        counts[state]+=1
        fsstate='PRE' if fsactual==pre else ('POST' if fsactual==post else 'OTHER')
        print(f'CACHE_D97AD_SITE={name}|IMAGE_OFF=0x{off:X}|VM=0x{vm:X}|CACHE_FILE={c.path}|CACHE_FILE_OFF=0x{foff:X}|ACTUAL={actual.hex()}|PRE={pre_hex}|POST={post_hex}|CACHE_STATE={state}|FS_ACTUAL={fsactual.hex()}|FS_STATE={fsstate}')
    print(f'CACHE_D97AD_SITE_SUMMARY=PRE={counts["PRE"]}|POST={counts["POST"]}|OTHER={counts["OTHER"]}')
    if counts['PRE']==6:
        print('CACHE_D97AD_CLASSIFIER_STATE=ALL_SIX_P7_PREIMAGES')
    elif counts['POST']==6:
        print('CACHE_D97AD_CLASSIFIER_STATE=ALL_SIX_D97AD_POSTIMAGES')
    else:
        print('CACHE_D97AD_CLASSIFIER_STATE=MIXED_OR_OTHER')

    print('===== SHARED EXIT STUB CACHE DISCRIMINATOR =====')
    stub_off=0xF80; stub_post=bytes.fromhex('b8010000020f050f0b'); stub_pre=b'\0'*len(stub_post)
    actual,c,mi,foff,vm=cache_read_image(stub_off,len(stub_post))
    fsactual=fs_bytes(stub_off,len(stub_post))
    cache_state='PRE_ZERO' if actual==stub_pre else ('D97AD_STUB' if actual==stub_post else 'OTHER')
    fs_state='PRE_ZERO' if fsactual==stub_pre else ('D97AD_STUB' if fsactual==stub_post else 'OTHER')
    print(f'CACHE_SHARED_STUB=IMAGE_OFF=0x{stub_off:X}|VM=0x{vm:X}|CACHE_FILE={c.path}|CACHE_FILE_OFF=0x{foff:X}|ACTUAL={actual.hex()}|CACHE_STATE={cache_state}|FS_ACTUAL={fsactual.hex()}|FS_STATE={fs_state}')

    print('===== RETAINED FUNCTIONAL PATCH CACHE WINDOWS =====')
    retained=[
        ('D34_PROTECTED_CAVE',0xEF8,'4889f8488937c3'),
        ('AIR00',0x9A933,'49c7462800000000'),
        ('P7_PORT_01',0x9A93B,'8b83a8000000'),
        ('P7_PORT_02',0x9A946,'8b8bac000000'),
        ('P6_PORT_01',0x9F53A,'f680e400000001'),
        ('P6_PORT_02',0x9F5B0,'f680e400000001'),
        ('P6_PORT_03',0x9F63F,'f680e400000001'),
        ('P6_PORT_04',0x9F65E,'f680e400000002'),
        ('P6_PORT_05',0x9E95D,'f683e400000001'),
        ('P6_PORT_06',0x9E97C,'f683e400000002'),
        ('P6_PORT_07',0x9E9CF,'f683e400000004'),
        ('P6_PORT_08',0x9E985,'8b93e8000000'),
        ('P6_PORT_09',0x9E9AC,'8b93e8000000'),
        ('P6_PORT_10',0x9E8EF,'8bb3ec000000'),
        ('P6_PORT_11',0x9E757,'8bb31c010000'),
        ('P6_PORT_12',0x9E74E,'83be2001000000'),
    ]
    retained_match=0
    for name,off,post_hex in retained:
        post=bytes.fromhex(post_hex)
        actual,c,mi,foff,vm=cache_read_image(off,len(post))
        fsactual=fs_bytes(off,len(post))
        cache_match=(actual==post); fs_match=(fsactual==post)
        retained_match += int(cache_match)
        print(f'CACHE_RETAINED_SITE={name}|IMAGE_OFF=0x{off:X}|ACTUAL={actual.hex()}|EXPECTED_POST={post_hex}|CACHE_POST_MATCH={cache_match}|FS_ACTUAL={fsactual.hex()}|FS_POST_MATCH={fs_match}')
    print(f'CACHE_RETAINED_POSTIMAGE_MATCH_COUNT={retained_match}|TOTAL={len(retained)}')

    print('===== HISTORICAL SENDER-PC CACHE/FS BYTE COMPARISON =====')
    for off in (0x9FFEE,0xA5F81):
        actual,c,mi,foff,vm=cache_read_image(off,16)
        fsactual=fs_bytes(off,16)
        print(f'SENDER_PC_BYTE_COMPARE=IMAGE_OFF=0x{off:X}|CACHE={actual.hex()}|FS={fsactual.hex()}|EQUAL={actual==fsactual}|CACHE_FILE={c.path}|CACHE_FILE_OFF=0x{foff:X}')

    print('===== FILESYSTEM VS CACHE IDENTITY SUMMARY =====')
    candidate_cache,cc,mi,cfo,cvm=cache_read_image(0x9D6BD,9)
    candidate_fs=fs_bytes(0x9D6BD,9)
    print(f'CANDIDATE_CACHE_BYTES={candidate_cache.hex()}')
    print(f'CANDIDATE_FILESYSTEM_BYTES={candidate_fs.hex()}')
    print(f'CANDIDATE_CACHE_EQUALS_FILESYSTEM={candidate_cache==candidate_fs}')
    print(f'CACHED_IMAGE_UUID={cached_uuid}')
    print(f'CACHED_IMAGE_LOAD_ADDRESS=0x{image_load:X}')
    print(f'CACHED_IMAGE_TEXT_SIZE=0x{text_size:X}')
    print(f'CACHED_IMAGE_TABLE_FILE={table_cache.path}')
    print('CACHE_BYTE_IDENTITY_READ=PASS')

    if candidate_cache==bytes.fromhex('8b8d10feffff83f941') and candidate_fs==bytes.fromhex('6a6e5fe9bb38f6ff90'):
        print('D97AEU_DECISIVE_BYTE_DISCRIMINATOR=CACHE_PRE_D97AD__FILESYSTEM_D97AD')
    elif candidate_cache==candidate_fs:
        print('D97AEU_DECISIVE_BYTE_DISCRIMINATOR=CACHE_EQUALS_FILESYSTEM_AT_CANDIDATE')
    else:
        print('D97AEU_DECISIVE_BYTE_DISCRIMINATOR=CACHE_OTHER__FILESYSTEM_D97AD_OR_OTHER')

    print('RUNTIME_CACHE_EXECUTION_CLAIM=NOT_MADE_BY_THIS_STATIC_MAPPER')
finally:
    for c in caches:
        try: c.close()
        except Exception: pass
PY

print "===== FINAL ====="
print "D97AEU_READONLY_DYLD_CACHE_32023_BYTE_IDENTITY_MAP=PASS"
print "SOURCE_MUTATION=NO"
print "SYSTEM_MUTATION=NO"
print "GOLDEN_MUTATION=NO"
print "SERVICE_LAUNCH=AUTO-NO"
print "RUNTIME_INSTRUMENTATION=NO"
print "ROOT_PATCH=AUTO-NO"
print "REBOOT=AUTO-NO"
print "D82_EXECUTION=NO"
print "PATCH8_AUTO_INTEGRATION=NO"
print "NEXT=assistant_audit_cached_32023_byte_identity_before_any_runtime_change"
print "REPORT=$REPORT"
