#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.8"
EXPECTED_OS_BUILD="24H22"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_3802_SHA="85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40"
EXPECTED_SERVICE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
EXPECTED_METAL_TEXT_SHA="f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865"
METAL_START="0x7FF80D343000"
METAL_END="0x7FF80D5C5C3D"
FUNCTION_START="0x7FF80D370756"
FUNCTION_END="0x7FF80D370C28"
LLVM_LOAD="0x7FF80D37081B"
REQUESTTYPE_LOAD="0x7FF80D37082E"
TIMEOUT_LOAD="0x7FF80D370A0F"
SANDBOX_COND="0x7FF80D370905"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
REPORT="$HOME/Desktop/OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BC.XXXXXX)"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BC.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BC_AUDIT=FAIL_CLOSED|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "CACHE_MMAP=NO"; echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -x /usr/bin/otool ]] || fail "MISSING_OTOOL"
for p in "$MTL32023" "$MTL3802" "$SERVICE"; do [[ -f "$p" ]] || fail "MISSING_INPUT:$p"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97BC — GOLDEN 15.8 PRIMARY REQUEST-BUILDER OBJECT PROVENANCE ====="
echo "PURPOSE=map_RBX_R13_origins_in_LC_FUNCTION_STARTS_proven_request_builder_and_bind_known_field_offsets_to_root_objects"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "PERSISTENT_INSTRUMENTATION=NO"
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
echo "D97BC_GOLDEN_IDENTITY=PASS"

"$PYTHON" - "$TMP" "$JSON_REPORT" "$EXPECTED_METAL_TEXT_SHA" "$METAL_START" "$METAL_END" "$FUNCTION_START" "$FUNCTION_END" "$LLVM_LOAD" "$REQUESTTYPE_LOAD" "$TIMEOUT_LOAD" "$SANDBOX_COND" <<'PY'
from __future__ import annotations
import hashlib,json,os,re,struct,subprocess,sys
from pathlib import Path

TMP=Path(sys.argv[1]); JOUT=Path(sys.argv[2]); EXPECT_SHA=sys.argv[3]
MS=int(sys.argv[4],0); ME=int(sys.argv[5],0); FS=int(sys.argv[6],0); FE=int(sys.argv[7],0)
LLVM=int(sys.argv[8],0); REQ=int(sys.argv[9],0); TIMEOUT=int(sys.argv[10],0); SANDBOX=int(sys.argv[11],0)
SEARCH_DIRS=[Path('/System/Library/dyld'),Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),Path('/System/Cryptexes/OS/System/Library/dyld'),Path('/private/preboot/Cryptexes/OS/System/Library/dyld')]
MH_MAGIC_64=0xFEEDFACF; LC_SEGMENT_64=0x19; LC_FUNCTION_STARTS=0x26
MH_OBJECT=1; CPU_TYPE_X86_64=0x01000007; CPU_SUBTYPE_X86_64_ALL=3
S_ATTR_PURE_INSTRUCTIONS=0x80000000; S_ATTR_SOME_INSTRUCTIONS=0x400

def out(s=''):print(s,flush=True)
def u32(b,o):return struct.unpack_from('<I',b,o)[0]
def u64(b,o):return struct.unpack_from('<Q',b,o)[0]
def pread(fd,n,o):return os.pread(fd,n,o)
def run(cmd,timeout=60):
    p=subprocess.run(cmd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=timeout)
    return p.returncode,p.stdout

def cache_records():
    files=[];seen=set();recs=[]
    for d in SEARCH_DIRS:
        if not d.is_dir():continue
        for p in sorted(d.iterdir(),key=lambda x:x.name):
            if not p.name.startswith('dyld_shared_cache_'):continue
            try:
                st=p.stat(); ident=(st.st_dev,st.st_ino)
                if not p.is_file() or ident in seen:continue
                seen.add(ident);files.append((p,st.st_size))
            except:pass
    for p,size in files:
        fd=None
        try:
            fd=os.open(str(p),os.O_RDONLY);h=pread(fd,min(size,0x300),0)
            if len(h)<0x20:continue
            mo=u32(h,0x10);mc=u32(h,0x14);magic=h[:16].rstrip(b'\0').decode('ascii','replace')
            if not magic.startswith('dyld_') or not(0<mc<=4096) or mo+mc*32>size:continue
            raw=pread(fd,mc*32,mo)
            if len(raw)!=mc*32:continue
            maps=[]
            for i in range(mc):
                vm,sz,fo,maxp,initp=struct.unpack_from('<QQQII',raw,i*32);maps.append((vm,vm+sz,fo,fo+sz))
            recs.append({'path':p,'size':size,'maps':maps})
        finally:
            if fd is not None:os.close(fd)
    return recs
RECS=cache_records()
if not RECS:raise SystemExit('FAIL=NO_VALID_CACHE_RECORDS')
def vm_loc(vm):
    for r in RECS:
        for vs,ve,fs,fe in r['maps']:
            if vs<=vm<ve:return r,fs+(vm-vs)
    return None,None
def read_vm(vm,n):
    r,fo=vm_loc(vm);r2,fo2=vm_loc(vm+n-1)
    if r is None or r2 is None or r2['path']!=r['path'] or fo2-fo!=n-1:raise RuntimeError(f'UNMAPPED_OR_CROSS_RANGE:0x{vm:X}+0x{n:X}')
    fd=os.open(str(r['path']),os.O_RDONLY)
    try:b=pread(fd,n,fo)
    finally:os.close(fd)
    if len(b)!=n:raise RuntimeError('SHORT_READ')
    return b,r,fo

# Pin current Metal exactly.
metal,mrec,mfo=read_vm(MS,ME-MS);msha=hashlib.sha256(metal).hexdigest()
out(f'METAL_TEXT_EXPECTED_SHA256={EXPECT_SHA}')
out(f'METAL_TEXT_ACTUAL_SHA256={msha}')
out(f'METAL_TEXT_CACHE_FILE={mrec["path"]}')
if msha!=EXPECT_SHA:raise SystemExit('FAIL=METAL_TEXT_SHA256_MISMATCH')
out('D97BC_METAL_TEXT_IDENTITY=PASS')

# Independently revalidate LC_FUNCTION_STARTS contains exactly FS..FE around LLVM.
hdr,_,_=read_vm(MS,32)
if u32(hdr,0)!=MH_MAGIC_64:raise SystemExit('FAIL=METAL_MACHO_MAGIC')
ncmds=u32(hdr,16);sizeofcmds=u32(hdr,20);blob,_,_=read_vm(MS,32+sizeofcmds)
p=32;text=None;link=None;fst=None
for _ in range(ncmds):
    cmd,sz=struct.unpack_from('<II',blob,p)
    if sz<8 or p+sz>len(blob):raise SystemExit('FAIL=LOAD_COMMAND_BOUNDS')
    if cmd==LC_SEGMENT_64 and sz>=72:
        name=blob[p+8:p+24].split(b'\0',1)[0].decode('ascii','replace');vmaddr,vmsize,fileoff,filesize=struct.unpack_from('<QQQQ',blob,p+24)
        if name=='__TEXT':text=(vmaddr,vmsize,fileoff,filesize)
        elif name=='__LINKEDIT':link=(vmaddr,vmsize,fileoff,filesize)
    elif cmd==LC_FUNCTION_STARTS and sz>=16:fst=struct.unpack_from('<II',blob,p+8)
    p+=sz
if text is None or link is None or fst is None:raise SystemExit('FAIL=MACHO_BOUNDARY_METADATA_MISSING')
fs_vm=link[0]+(fst[0]-link[2]);fb,_,_=read_vm(fs_vm,fst[1])
def uleb(buf,i):
    v=0;s=0
    while i<len(buf):
        c=buf[i];i+=1;v|=(c&0x7f)<<s
        if not(c&0x80):return v,i
        s+=7
        if s>63:raise RuntimeError('ULEB_OVERFLOW')
    raise RuntimeError('ULEB_TRUNC')
starts=[];cur=text[0];i=0
while i<len(fb):
    d,i=uleb(fb,i)
    if d==0:break
    cur+=d;starts.append(cur)
prev=max(x for x in starts if x<=LLVM); nxt=min(x for x in starts if x>LLVM)
out(f'LC_FUNCTION_STARTS_REVALIDATED|START=0x{prev:X}|END=0x{nxt:X}|COUNT={len(starts)}')
if prev!=FS or nxt!=FE:raise SystemExit(f'FAIL=FUNCTION_BOUNDARY_CHANGED:0x{prev:X}..0x{nxt:X}')
out('D97BC_FUNCTION_BOUNDARY=REVALIDATED')

code,crec,cfo=read_vm(FS,FE-FS)
def make_macho(code,path):
    cmdsize=72+80;dataoff=32+cmdsize;segname=b'__TEXT'+b'\0'*10;sectname=b'__text'+b'\0'*10
    hdr=struct.pack('<IiiIIIII',MH_MAGIC_64,CPU_TYPE_X86_64,CPU_SUBTYPE_X86_64_ALL,MH_OBJECT,1,cmdsize,0,0)
    seg=struct.pack('<II16sQQQQiiII',LC_SEGMENT_64,cmdsize,segname,0,len(code),dataoff,len(code),7,5,1,0)
    sec=struct.pack('<16s16sQQIIIIIIII',sectname,segname,0,len(code),dataoff,0,0,0,S_ATTR_PURE_INSTRUCTIONS|S_ATTR_SOME_INSTRUCTIONS,0,0,0)
    path.write_bytes(hdr+seg+sec+code)
obj=TMP/'function.o';make_macho(code,obj);rc,ot=run(['/usr/bin/otool','-tvV',str(obj)])
if rc!=0:raise SystemExit('FAIL=OTOOL_FUNCTION')
rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$');inst=[]
for ln in ot.splitlines():
    m=rx.match(ln)
    if not m:continue
    try:o=int(m.group(1),16)
    except:continue
    t=m.group(2).strip()
    if t and not t.endswith(':'):inst.append({'off':o,'vm':FS+o,'text':t})
inst.sort(key=lambda x:x['off'])
out(f'FUNCTION_DISASM|START=0x{FS:X}|END=0x{FE:X}|INSTRUCTIONS={len(inst)}|OTOOL_RC={rc}')

# Register alias/canonicalization helpers.
FAMS={
 'rax':{'rax','eax','ax','al'},'rbx':{'rbx','ebx','bx','bl'},'rcx':{'rcx','ecx','cx','cl'},'rdx':{'rdx','edx','dx','dl'},
 'rsi':{'rsi','esi','si','sil'},'rdi':{'rdi','edi','di','dil'},'rbp':{'rbp','ebp','bp','bpl'},'rsp':{'rsp','esp','sp','spl'},
 'r8':{'r8','r8d','r8w','r8b'},'r9':{'r9','r9d','r9w','r9b'},'r10':{'r10','r10d','r10w','r10b'},'r11':{'r11','r11d','r11w','r11b'},
 'r12':{'r12','r12d','r12w','r12b'},'r13':{'r13','r13d','r13w','r13b'},'r14':{'r14','r14d','r14w','r14b'},'r15':{'r15','r15d','r15w','r15b'}}
def canon(x):
    x=x.lower().lstrip('%')
    for k,v in FAMS.items():
        if x in v:return k
    return x
def split(t):
    q=t.split('##',1)[0].strip();p=q.split(None,1)
    return (p[0],[]) if len(p)==1 else (p[0],[x.strip() for x in p[1].split(',')])
def dest(t):
    op,oo=split(t)
    if not oo or op.startswith(('cmp','test','call','j','ret','push')):return None
    m=re.fullmatch(r'%([A-Za-z0-9]+)',oo[-1]);return canon(m.group(1)) if m else None

def source_of_write(t):
    op,oo=split(t)
    if len(oo)<2:return {'kind':'OTHER','text':t}
    src=oo[0]
    m=re.fullmatch(r'%([A-Za-z0-9]+)',src)
    if m:return {'kind':'REGISTER','source':canon(m.group(1)),'raw':src}
    if src.startswith('$'):return {'kind':'IMMEDIATE','source':src}
    if '(' in src:return {'kind':'MEMORY','source':src}
    return {'kind':'EXPR','source':src}

def writes_before(reg,vm):
    return [x for x in inst if x['vm']<vm and dest(x['text'])==reg]

def last_writer(reg,vm):
    a=writes_before(reg,vm);return a[-1] if a else None

def trace_origin(reg,vm,maxdepth=8):
    # Trace only explicit register copies/memory/immediate. ABI argument classification is valid only if a source register has no prior writer after function entry.
    chain=[];cur=reg;at=vm
    abi={'rdi':'ABI_ARG1_RDI','rsi':'ABI_ARG2_RSI','rdx':'ABI_ARG3_RDX','rcx':'ABI_ARG4_RCX','r8':'ABI_ARG5_R8','r9':'ABI_ARG6_R9'}
    for _ in range(maxdepth):
        w=last_writer(cur,at)
        if w is None:
            return chain,{'kind':'ABI_OR_ENTRY_STATE','register':cur,'classification':abi.get(cur,'CALLEE_SAVED_OR_ENTRY_STATE')}
        s=source_of_write(w['text']);chain.append({'reg':cur,'vm':w['vm'],'text':w['text'],'source':s})
        if s['kind']=='REGISTER':
            cur=s['source'];at=w['vm'];continue
        return chain,s
    return chain,{'kind':'DEPTH_LIMIT','register':cur}

for label,vm in [('LLVM_LOAD',LLVM),('REQUESTTYPE_LOAD',REQ),('TIMEOUT_LOAD',TIMEOUT),('SANDBOX_COND',SANDBOX)]:
    out(f'KNOWN_FIELD_SITE|NAME={label}|VM=0x{vm:X}')

# Print entire entry-to-llvm region for raw auditing.
out('\n===== FUNCTION ENTRY THROUGH LLVMVERSION =====')
for x in inst:
    if x['vm']<=LLVM+0x20:out(f'FUNC|VM=0x{x["vm"]:X}|TEXT={x["text"]}')

rbx_writes=writes_before('rbx',LLVM);r13_writes=writes_before('r13',REQ)
out('\n===== RBX/R13 WRITE CENSUS BEFORE KNOWN USES =====')
for x in rbx_writes:out(f'REG_WRITE|REG=rbx|VM=0x{x["vm"]:X}|TEXT={x["text"]}')
for x in r13_writes:out(f'REG_WRITE|REG=r13|VM=0x{x["vm"]:X}|TEXT={x["text"]}')
rbx_chain,rbx_origin=trace_origin('rbx',LLVM)
r13_chain,r13_origin=trace_origin('r13',REQ)
out(f'RBX_ORIGIN_JSON={json.dumps({"chain":rbx_chain,"origin":rbx_origin},sort_keys=True)}')
out(f'R13_ORIGIN_JSON={json.dumps({"chain":r13_chain,"origin":r13_origin},sort_keys=True)}')

# Also map source register/object relations used by known fields.
layout={
 'llvmVersion':{'base':'rbx','offset':0x20,'width':'signed_dword_to_qword','site':LLVM},
 'requestType':{'base':'r13','offset':0x8,'width':'dword','site':REQ},
 'APISpecifiedTimeoutInSeconds':{'base':'r13','offset':0x18,'width':'qword','site':TIMEOUT},
 'sandboxTokens_condition':{'base':'r13','offset':0x70,'width':'byte','site':SANDBOX}}
for k,v in layout.items():out(f'PRODUCER_LAYOUT|FIELD={k}|BASE={v["base"]}|OFFSET=0x{v["offset"]:X}|WIDTH={v["width"]}|SITE=0x{v["site"]:X}')

# Conservative classification.
def cls(origin):
    if origin.get('kind')=='ABI_OR_ENTRY_STATE' and origin.get('classification','').startswith('ABI_ARG'):return 'STATIC_ABI_ORIGIN_PROVEN'
    if origin.get('kind') in ('MEMORY','IMMEDIATE'):return 'STATIC_STRUCTURAL_ORIGIN_PROVEN'
    return 'STRUCTURAL_ORIGIN_MAPPED'
rbx_cls=cls(rbx_origin);r13_cls=cls(r13_origin)
out(f'G1_GOLDEN_RBX_ORIGIN_CLASS={rbx_cls}')
out(f'G1_GOLDEN_R13_ORIGIN_CLASS={r13_cls}')

JOUT.write_text(json.dumps({'metal_text_sha256':msha,'function_start':FS,'function_end':FE,'function_instruction_count':len(inst),'rbx_writes':rbx_writes,'r13_writes':r13_writes,'rbx_chain':rbx_chain,'rbx_origin':rbx_origin,'r13_chain':r13_chain,'r13_origin':r13_origin,'rbx_class':rbx_cls,'r13_class':r13_cls,'layout':layout},indent=2,sort_keys=True))
out(f'JSON_REPORT={JOUT}')
out('D97BC_AUDIT=COMPLETE')
out('SYSTEM_FILE_MUTATION=NO')
out('CACHE_MMAP=NO')
out('CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY')
out('PROCESS_DEBUG_ATTACH=NO')
out('PERSISTENT_INSTRUMENTATION=NO')
out('ROOT_PATCH=AUTO-NO')
out('REBOOT=AUTO-NO')
out('STOP=RETURN_COMPLETE_REPORT_AND_JSON')
PY