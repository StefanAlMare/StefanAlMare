#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_3802_SHA="85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40"
EXPECTED_SERVICE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
REPORT="$HOME/Desktop/OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AY.XXXXXX)"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AY.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AY_AUDIT=FAIL_CLOSED|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "CACHE_MMAP=NO"; echo "CACHE_EXTRACTION=NO"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
for t in /usr/bin/otool /usr/bin/nm /usr/bin/shasum /usr/bin/file; do [[ -x "$t" ]] || fail "MISSING_TOOL:$t"; done
for p in "$MTL32023" "$MTL3802" "$SERVICE"; do [[ -f "$p" ]] || fail "MISSING_INPUT:$p"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97AY — GOLDEN SHARED-CACHE EIGHT-KEY OWNER/XREF + 3802 PC MAP ====="
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

OSV="$(/usr/bin/sw_vers -productVersion)"
OSB="$(/usr/bin/sw_vers -buildVersion)"
SHA32="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
SHA38="$(/usr/bin/shasum -a 256 "$MTL3802" | /usr/bin/awk '{print $1}')"
SHASVC="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
echo "OS_VERSION=$OSV"
echo "OS_BUILD=$OSB"
echo "GOLDEN_32023_SHA256=$SHA32"
echo "GOLDEN_3802_SHA256=$SHA38"
echo "GOLDEN_SERVICE_SHA256=$SHASVC"
[[ "$OSV" == "$EXPECTED_OS_VERSION" && "$OSB" == "$EXPECTED_OS_BUILD" ]] || fail "GOLDEN_OS_IDENTITY"
[[ "$SHA32" == "$EXPECTED_32023_SHA" ]] || fail "GOLDEN_32023_IDENTITY"
[[ "$SHA38" == "$EXPECTED_3802_SHA" ]] || fail "GOLDEN_3802_IDENTITY"
[[ "$SHASVC" == "$EXPECTED_SERVICE_SHA" ]] || fail "GOLDEN_SERVICE_IDENTITY"
echo "D97AY_GOLDEN_IDENTITY=PASS"

O38="$TMP/3802.otool"; N38="$TMP/3802.nm"
/usr/bin/otool -tvV "$MTL3802" > "$O38" 2>&1 || fail "OTOOL_3802"
/usr/bin/nm -nm "$MTL3802" > "$N38" 2>&1 || fail "NM_3802"

"$PYTHON" - "$O38" "$N38" "$MTL3802" "$JSON_REPORT" <<'PY'
from __future__ import annotations
import bisect,hashlib,json,os,re,struct,sys
from pathlib import Path

O38,N38,P38,JOUT=map(Path,sys.argv[1:5])
KEYS=[b'requestType',b'sandboxTokens',b'llvmVersion',b'pluginPath',b'targetData',b'data',b'client_name',b'APISpecifiedTimeoutInSeconds']
KEY_NAMES=[k.decode() for k in KEYS]
METAL_SUFFIX='/System/Library/Frameworks/Metal.framework/Versions/A/Metal'
SEARCH_DIRS=[Path('/System/Library/dyld'),Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),Path('/System/Cryptexes/OS/System/Library/dyld'),Path('/private/preboot/Cryptexes/OS/System/Library/dyld')]
CHUNK=16*1024*1024

def out(s=''): print(s,flush=True)
def u32(b,o): return struct.unpack_from('<I',b,o)[0]
def u64(b,o): return struct.unpack_from('<Q',b,o)[0]
def pread(fd,n,off): return os.pread(fd,n,off)
def read_cstr(fd,size,off,limit=16384):
    if off<0 or off>=size:return None
    b=pread(fd,min(limit,size-off),off); z=b.find(b'\0')
    if z<0:return None
    return b[:z].decode('utf-8','replace')

def parse_dis(path):
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); a=[]
    for ln in path.read_text(errors='replace').splitlines():
        m=rx.match(ln)
        if not m:continue
        try:x=int(m.group(1),16)
        except:continue
        t=m.group(2).strip()
        if t and not t.endswith(':'):a.append((x,t))
    return sorted(a)
def parse_syms(path):
    a=[]
    for ln in path.read_text(errors='replace').splitlines():
        m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',ln)
        if not m:continue
        try:x=int(m.group(1),16)
        except:continue
        a.append((x,m.group(2).strip()))
    return sorted(a)
def macho_base(path):
    d=path.read_bytes();
    if len(d)<32 or u32(d,0)!=0xFEEDFACF:raise SystemExit('MACHO64_REQUIRED:'+str(path))
    n=u32(d,16); q=32; text=None
    for _ in range(n):
        cmd,sz=struct.unpack_from('<II',d,q)
        if cmd==0x19 and sz>=72:
            nm=d[q+8:q+24].split(b'\0',1)[0].decode('ascii','replace'); vm,vs,fo,fs=struct.unpack_from('<QQQQ',d,q+24)
            if nm=='__TEXT':text=(vm,vs,fo,fs)
        q+=sz
    if not text:raise SystemExit('TEXT_MISSING')
    return text[0]
def owner_symbol(addr,syms):
    starts=[x[0] for x in syms]; i=bisect.bisect_right(starts,addr)-1
    return syms[i] if i>=0 else (None,'UNKNOWN')

# 3802 PC map first: exact observed runtime offsets from D97AX/D97AU.
D38=parse_dis(O38); S38=parse_syms(N38); B38=macho_base(P38)
pc3802={}
out('\n===== GOLDEN 3802 OBSERVED PC STATIC MAP =====')
for off in (0x1DFA3,0x238E3):
    vm=B38+off; sa,sn=owner_symbol(vm,S38); nearest=min(D38,key=lambda x:abs(x[0]-vm)) if D38 else (0,'NONE')
    pc3802[f'0x{off:X}']={'vm':vm,'symbol':sn,'instruction':nearest[1]}
    out(f'PC3802_MAP|OFFSET=0x{off:X}|VM=0x{vm:X}|SYMBOL={sn}|INSTRUCTION={nearest[1]}')
    idx=D38.index(nearest)
    for a,t in D38[max(0,idx-12):min(len(D38),idx+13)]: out(f'PC3802_CONTEXT|TARGET=0x{off:X}|OFFSET=0x{a-B38:X}|TEXT={t}')

# Cache inventory/header/image catalogs.
files=[]; seen=set()
for d in SEARCH_DIRS:
    out(f'CACHE_DIR|PATH={d}|EXISTS={d.exists()}|IS_DIR={d.is_dir()}')
    if not d.is_dir():continue
    for p in sorted(d.iterdir(),key=lambda x:x.name):
        if not p.name.startswith('dyld_shared_cache_'):continue
        try:
            st=p.stat(); ident=(st.st_dev,st.st_ino)
            if not p.is_file() or ident in seen:continue
            seen.add(ident); files.append((p,st.st_size))
        except Exception as e: out(f'CACHE_STAT_ERROR|PATH={p}|ERR={e!r}')
files.sort(key=lambda x:str(x[0]))
out(f'UNIQUE_CACHE_FILE_COUNT={len(files)}')
if not files:raise SystemExit('NO_CACHE_FILES')

recs=[]
for p,size in files:
    fd=None
    try:
        fd=os.open(str(p),os.O_RDONLY); h=pread(fd,min(size,0x300),0)
        if len(h)<0x98:continue
        magic=h[:16].rstrip(b'\0').decode('ascii','replace'); mo=u32(h,0x10); mc=u32(h,0x14); ito=u64(h,0x88); itc=u64(h,0x90)
        if not magic.startswith('dyld_') or mc==0 or mc>4096 or mo+mc*32>size:continue
        mr=pread(fd,mc*32,mo); maps=[]
        if len(mr)!=mc*32:continue
        for i in range(mc):
            addr,sz,fo,maxp,initp=struct.unpack_from('<QQQII',mr,i*32); maps.append((fo,fo+sz,addr,addr+sz,maxp,initp))
        rec={'path':p,'size':size,'maps':maps,'imagesTextOffset':ito,'imagesTextCount':itc,'magic':magic}
        recs.append(rec)
        out(f'CACHE_VALID|PATH={p}|SIZE={size}|MAGIC={magic}|MAPS={len(maps)}|IMAGES_TEXT_OFF=0x{ito:X}|IMAGES_TEXT_COUNT={itc}')
    except Exception as e:out(f'CACHE_HEADER_ERROR|PATH={p}|ERR={type(e).__name__}:{e}')
    finally:
        if fd is not None:os.close(fd)
if not recs:raise SystemExit('NO_VALID_CACHE_HEADERS')

images=[]
for rec in recs:
    p,size=rec['path'],rec['size']; cnt,off=rec['imagesTextCount'],rec['imagesTextOffset']
    if cnt==0 or cnt>200000 or off+cnt*32>size:continue
    fd=os.open(str(p),os.O_RDONLY)
    try:
        raw=pread(fd,cnt*32,off)
        if len(raw)!=cnt*32:continue
        for i in range(cnt):
            o=i*32; load=u64(raw,o+16); ts=u32(raw,o+24); po=u32(raw,o+28)
            if not ts:continue
            path=read_cstr(fd,size,po) or f'<BAD_PATH_0x{po:X}>'
            images.append((load,load+ts,path,str(p),i))
    finally:os.close(fd)
uniq={}
for x in images:uniq[(x[0],x[1],x[2])]=x
images=sorted(uniq.values()); starts=[x[0] for x in images]
out(f'IMAGE_TEXT_UNIQUE_COUNT={len(images)}')

def owner_vm(vm):
    i=bisect.bisect_right(starts,vm)-1
    for j in range(i,max(-1,i-12),-1):
        if j<0:break
        x=images[j]
        if x[0]<=vm<x[1]:return x
    return None

def fileoff_to_vm(rec,off):
    for fs,fe,va,ve,mp,ip in rec['maps']:
        if fs<=off<fe:return va+(off-fs)
    return None

def vm_to_location(vm):
    for rec in recs:
        for fs,fe,va,ve,mp,ip in rec['maps']:
            if va<=vm<ve:return rec,fs+(vm-va)
    return None,None

# One-pass multi-key scan across all cache files.
hits={k.decode():[] for k in KEYS}
out('\n===== EIGHT-KEY CHUNKED CACHE SCAN =====')
maxk=max(len(k) for k in KEYS); overlap=maxk-1
for rec in recs:
    p,size=rec['path'],rec['size']; fd=os.open(str(p),os.O_RDONLY); pos=0; carry=b''
    local={k.decode():0 for k in KEYS}
    try:
        while pos<size:
            want=min(CHUNK,size-pos); b=pread(fd,want,pos)
            if not b and want:raise IOError(f'EMPTY_PREAD_0x{pos:X}')
            buf=carry+b; base=pos-len(carry)
            for key in KEYS:
                st=0
                while True:
                    q=buf.find(key,st)
                    if q<0:break
                    off=base+q
                    if 0<=off<size and (not hits[key.decode()] or hits[key.decode()][-1].get('cache_file')!=str(p) or hits[key.decode()][-1].get('fileoff')!=off):
                        vm=fileoff_to_vm(rec,off); own=owner_vm(vm) if vm is not None else None
                        row={'cache_file':str(p),'fileoff':off,'vm':vm,'owner':own[2] if own else None,'owner_start':own[0] if own else None,'owner_end':own[1] if own else None}
                        hits[key.decode()].append(row); local[key.decode()]+=1
                        out(f'KEY_HIT|KEY={key.decode()}|CACHE={p}|FILEOFF=0x{off:X}|VM={"0x%X"%vm if vm is not None else "UNMAPPED"}|OWNER={row["owner"] or "UNKNOWN"}')
                    st=q+1
            carry=buf[-overlap:] if overlap else b''; pos+=len(b)
            if len(b)<want:break
    finally:os.close(fd)
    out('CACHE_SCAN_DONE|PATH='+str(p)+'|'+';'.join(f'{k}:{v}' for k,v in local.items()))

for k in KEY_NAMES:
    owners=sorted(set(x['owner'] for x in hits[k] if x['owner']))
    out(f'KEY_SUMMARY|KEY={k}|HITS={len(hits[k])}|OWNERS={" || ".join(owners)}')

# Identify Metal image catalog records and exact key VMs owned by Metal.
metal_images=sorted(set((x[0],x[1],x[2]) for x in images if x[2].endswith(METAL_SUFFIX)))
out('\n===== GOLDEN METAL SHARED-CACHE IMAGE =====')
out(f'METAL_IMAGE_RECORD_COUNT={len(metal_images)}')
for a,b,p in metal_images:out(f'METAL_IMAGE|TEXT_START=0x{a:X}|TEXT_END=0x{b:X}|PATH={p}')
metal_key_vms={k:sorted(set(x['vm'] for x in hits[k] if x['vm'] is not None and x['owner'] and x['owner'].endswith(METAL_SUFFIX))) for k in KEY_NAMES}
for k,vs in metal_key_vms.items():out(f'METAL_KEY_VMS|KEY={k}|COUNT={len(vs)}|VMS={",".join("0x%X"%x for x in vs)}')

# Raw RIP-relative LEA xrefs inside Metal text. Exact for 7-byte REX.W LEA disp32.
raw_xrefs={k:[] for k in KEY_NAMES}
out('\n===== GOLDEN METAL RAW RIP-RELATIVE KEY XREF SCAN =====')
for start,end,path in metal_images:
    rec,fo0=vm_to_location(start); rec2,fo1=vm_to_location(end-1)
    if rec is None or rec2 is None or rec['path']!=rec2['path']:
        out(f'METAL_TEXT_SCAN_SKIP|START=0x{start:X}|END=0x{end:X}|REASON=CROSS_OR_UNMAPPED');continue
    fd=os.open(str(rec['path']),os.O_RDONLY)
    try:
        size=end-start; pos=0; carry=b''; ov=16
        while pos<size:
            n=min(4*1024*1024,size-pos); b=pread(fd,n,fo0+pos)
            if not b:break
            data=carry+b; basefo=fo0+pos-len(carry); basevm=start+pos-len(carry)
            begin=max(0,len(carry)-8)
            for q in range(begin,max(begin,len(data)-6)):
                rex=data[q]
                if rex not in range(0x48,0x50) or data[q+1]!=0x8D:continue
                modrm=data[q+2]
                if (modrm&0xC7)!=0x05:continue
                disp=struct.unpack_from('<i',data,q+3)[0]; ivm=basevm+q; target=ivm+7+disp
                reg=((modrm>>3)&7)|(((rex>>2)&1)<<3); regs=['rax','rcx','rdx','rbx','rsp','rbp','rsi','rdi','r8','r9','r10','r11','r12','r13','r14','r15']
                for k,vs in metal_key_vms.items():
                    if target in vs:
                        row={'vm':ivm,'fileoff':basefo+q,'target_vm':target,'dst':regs[reg],'image_start':start,'image_end':end,'cache_file':str(rec['path'])}
                        if row not in raw_xrefs[k]:raw_xrefs[k].append(row); out(f'METAL_KEY_XREF|KEY={k}|VM=0x{ivm:X}|FILEOFF=0x{basefo+q:X}|TARGET=0x{target:X}|DST={regs[reg]}|CACHE={rec["path"]}')
            carry=data[-ov:]; pos+=len(b)
    finally:os.close(fd)
for k in KEY_NAMES:out(f'METAL_KEY_XREF_SUMMARY|KEY={k}|COUNT={len(raw_xrefs[k])}')

# Save structured report.
JOUT.write_text(json.dumps({'pc3802':pc3802,'cache_files':[str(x[0]) for x in files],'metal_images':[{'start':a,'end':b,'path':p} for a,b,p in metal_images],'key_hits':hits,'metal_key_vms':metal_key_vms,'metal_raw_xrefs':raw_xrefs},indent=2),encoding='utf-8')
out('\n===== D97AY CLASSIFICATION =====')
out('G1_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_MAP=STATIC_CENSUS_COMPLETE')
out('G1_GOLDEN_METAL_KEY_RIP_XREF_MAP=STATIC_CENSUS_COMPLETE')
out('G1_GOLDEN_XPC_WRITER_VALUE_SOURCES=NOT_YET_CLAIMED')
out('GOLDEN_3802_OBSERVED_PC_STATIC_MAP=COMPLETE')
out('CACHE_MMAP=NO')
out('CACHE_EXTRACTION=NO')
out('D97AY_AUDIT=COMPLETE')
PY

echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "JSON_REPORT=$JSON_REPORT"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
