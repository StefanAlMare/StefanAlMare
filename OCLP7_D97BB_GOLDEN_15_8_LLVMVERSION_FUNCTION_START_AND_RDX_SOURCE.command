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
LLVM_XREF="0x7FF80D37081F"
LLVM_KEY_VM="0x7FF80D53DBDB"
UINT64_SETTER_TARGET="0x7FF80D50FDCE"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
REPORT="$HOME/Desktop/OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BB.XXXXXX)"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BB.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BB_AUDIT=FAIL_CLOSED|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "CACHE_MMAP=NO"; echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -x /usr/bin/otool ]] || fail "MISSING_OTOOL"
for p in "$MTL32023" "$MTL3802" "$SERVICE"; do [[ -f "$p" ]] || fail "MISSING_INPUT:$p"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97BB — GOLDEN 15.8 LLVMVERSION FUNCTION START + RDX SOURCE ====="
echo "PURPOSE=recover_proven_function_boundary_before_primary_llvmVersion_xref_and_backslice_uint64_value_argument"
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
echo "D97BB_GOLDEN_IDENTITY=PASS"

"$PYTHON" - "$TMP" "$JSON_REPORT" "$EXPECTED_METAL_TEXT_SHA" "$METAL_START" "$METAL_END" "$LLVM_XREF" "$LLVM_KEY_VM" "$UINT64_SETTER_TARGET" <<'PY'
from __future__ import annotations
import hashlib, json, os, re, struct, subprocess, sys
from pathlib import Path

TMP=Path(sys.argv[1]); JOUT=Path(sys.argv[2]); EXPECT_SHA=sys.argv[3]
MS=int(sys.argv[4],0); ME=int(sys.argv[5],0); TARGET=int(sys.argv[6],0); KEY_VM=int(sys.argv[7],0); EXPECT_SETTER=int(sys.argv[8],0)
SEARCH_DIRS=[Path('/System/Library/dyld'),Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),Path('/System/Cryptexes/OS/System/Library/dyld'),Path('/private/preboot/Cryptexes/OS/System/Library/dyld')]
LC_SEGMENT_64=0x19; LC_FUNCTION_STARTS=0x26; MH_MAGIC_64=0xFEEDFACF
MH_OBJECT=1; CPU_TYPE_X86_64=0x01000007; CPU_SUBTYPE_X86_64_ALL=3
S_ATTR_PURE_INSTRUCTIONS=0x80000000; S_ATTR_SOME_INSTRUCTIONS=0x400

def out(s=''): print(s,flush=True)
def u32(b,o): return struct.unpack_from('<I',b,o)[0]
def u64(b,o): return struct.unpack_from('<Q',b,o)[0]
def pread(fd,n,o): return os.pread(fd,n,o)
def run(cmd,timeout=60):
    p=subprocess.run(cmd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=timeout)
    return p.returncode,p.stdout

def cache_records():
    files=[]; seen=set()
    for d in SEARCH_DIRS:
        if not d.is_dir(): continue
        for p in sorted(d.iterdir(),key=lambda x:x.name):
            if not p.name.startswith('dyld_shared_cache_'): continue
            try:
                st=p.stat(); ident=(st.st_dev,st.st_ino)
                if not p.is_file() or ident in seen: continue
                seen.add(ident); files.append((p,st.st_size))
            except Exception: pass
    recs=[]
    for p,size in files:
        fd=None
        try:
            fd=os.open(str(p),os.O_RDONLY); h=pread(fd,min(size,0x300),0)
            if len(h)<0x20: continue
            magic=h[:16].rstrip(b'\0').decode('ascii','replace'); mo=u32(h,0x10); mc=u32(h,0x14)
            if not magic.startswith('dyld_') or not (0<mc<=4096) or mo+mc*32>size: continue
            raw=pread(fd,mc*32,mo)
            if len(raw)!=mc*32: continue
            maps=[]
            for i in range(mc):
                vm,sz,fo,maxp,initp=struct.unpack_from('<QQQII',raw,i*32)
                maps.append((vm,vm+sz,fo,fo+sz))
            recs.append({'path':p,'size':size,'maps':maps})
        finally:
            if fd is not None: os.close(fd)
    return recs

RECS=cache_records()
if not RECS: raise SystemExit('FAIL=NO_VALID_CACHE_RECORDS')

def vm_loc(vm):
    for r in RECS:
        for vs,ve,fs,fe in r['maps']:
            if vs<=vm<ve: return r,fs+(vm-vs)
    return None,None

def read_vm(vm,n):
    r,fo=vm_loc(vm)
    if r is None: raise RuntimeError(f'UNMAPPED_VM:0x{vm:X}')
    # Current bounded ranges must remain in one mapping/file.
    r2,fo2=vm_loc(vm+n-1)
    if r2 is None or r2['path']!=r['path'] or fo2-fo!=n-1: raise RuntimeError(f'CROSS_MAPPING_RANGE:0x{vm:X}+0x{n:X}')
    fd=os.open(str(r['path']),os.O_RDONLY)
    try: b=pread(fd,n,fo)
    finally: os.close(fd)
    if len(b)!=n: raise RuntimeError('SHORT_VM_READ')
    return b,r,fo

# Pin current Metal text bytes exactly to D97BA GOLDEN_B.
metal,metal_rec,metal_fo=read_vm(MS,ME-MS)
metal_sha=hashlib.sha256(metal).hexdigest()
out(f'METAL_TEXT_CACHE_FILE={metal_rec["path"]}')
out(f'METAL_TEXT_FILEOFF=0x{metal_fo:X}')
out(f'METAL_TEXT_BYTES={len(metal)}')
out(f'METAL_TEXT_EXPECTED_SHA256={EXPECT_SHA}')
out(f'METAL_TEXT_ACTUAL_SHA256={metal_sha}')
if metal_sha!=EXPECT_SHA: raise SystemExit('FAIL=METAL_TEXT_SHA256_MISMATCH')
out('D97BB_METAL_TEXT_IDENTITY=PASS')

# Parse the cached Metal Mach-O load commands from the actual image header.
hdr,_,_=read_vm(MS,32)
if u32(hdr,0)!=MH_MAGIC_64: raise SystemExit(f'FAIL=METAL_MACHO_MAGIC:0x{u32(hdr,0):X}')
ncmds=u32(hdr,16); sizeofcmds=u32(hdr,20)
if not (0<ncmds<10000 and 0<sizeofcmds<0x200000): raise SystemExit('FAIL=METAL_LOAD_COMMAND_BOUNDS')
blob,_,_=read_vm(MS,32+sizeofcmds)
p=32; text_seg=None; linkedit=None; fstarts=None
for _ in range(ncmds):
    if p+8>len(blob): raise SystemExit('FAIL=LOAD_COMMAND_TRUNCATED')
    cmd,sz=struct.unpack_from('<II',blob,p)
    if sz<8 or p+sz>len(blob): raise SystemExit('FAIL=LOAD_COMMAND_SIZE')
    if cmd==LC_SEGMENT_64 and sz>=72:
        name=blob[p+8:p+24].split(b'\0',1)[0].decode('ascii','replace')
        vmaddr,vmsize,fileoff,filesize=struct.unpack_from('<QQQQ',blob,p+24)
        if name=='__TEXT': text_seg=(vmaddr,vmsize,fileoff,filesize)
        elif name=='__LINKEDIT': linkedit=(vmaddr,vmsize,fileoff,filesize)
    elif cmd==LC_FUNCTION_STARTS and sz>=16:
        dataoff,datasize=struct.unpack_from('<II',blob,p+8); fstarts=(dataoff,datasize)
    p+=sz
if text_seg is None: raise SystemExit('FAIL=METAL_TEXT_SEGMENT_MISSING')
if linkedit is None: raise SystemExit('FAIL=METAL_LINKEDIT_SEGMENT_MISSING')
if fstarts is None: raise SystemExit('FAIL=LC_FUNCTION_STARTS_MISSING')
out(f'MACHO_TEXT_SEGMENT|VM=0x{text_seg[0]:X}|SIZE=0x{text_seg[1]:X}|FILEOFF=0x{text_seg[2]:X}|FILESIZE=0x{text_seg[3]:X}')
out(f'MACHO_LINKEDIT_SEGMENT|VM=0x{linkedit[0]:X}|SIZE=0x{linkedit[1]:X}|FILEOFF=0x{linkedit[2]:X}|FILESIZE=0x{linkedit[3]:X}')
out(f'LC_FUNCTION_STARTS|DATAOFF=0x{fstarts[0]:X}|DATASIZE=0x{fstarts[1]:X}')
if text_seg[0]!=MS: raise SystemExit(f'FAIL=TEXT_VM_MISMATCH:0x{text_seg[0]:X}')
if fstarts[0] < linkedit[2]: raise SystemExit('FAIL=FUNCTION_STARTS_BEFORE_LINKEDIT')
fs_vm=linkedit[0] + (fstarts[0]-linkedit[2])
fs_bytes,fs_rec,fs_fo=read_vm(fs_vm,fstarts[1])
out(f'LC_FUNCTION_STARTS_VM=0x{fs_vm:X}|CACHE={fs_rec["path"]}|FILEOFF=0x{fs_fo:X}')

# ULEB128 cumulative deltas from __TEXT vmaddr.
def read_uleb(buf,idx):
    val=0; shift=0; start=idx
    while idx<len(buf):
        c=buf[idx]; idx+=1; val |= (c&0x7f)<<shift
        if (c&0x80)==0: return val,idx
        shift+=7
        if shift>63: raise RuntimeError('ULEB_OVERFLOW')
    raise RuntimeError('ULEB_TRUNCATED')
starts=[]; cur=text_seg[0]; i=0
while i<len(fs_bytes):
    d,i=read_uleb(fs_bytes,i)
    if d==0: break
    cur+=d
    if cur<text_seg[0] or cur>=text_seg[0]+text_seg[1]: raise SystemExit(f'FAIL=FUNCTION_START_OUT_OF_TEXT:0x{cur:X}')
    starts.append(cur)
if not starts: raise SystemExit('FAIL=FUNCTION_STARTS_EMPTY')
prev=[x for x in starts if x<=TARGET]
if not prev: raise SystemExit('FAIL=NO_FUNCTION_START_BEFORE_TARGET')
FSTART=prev[-1]
nexts=[x for x in starts if x>TARGET]
FEND=nexts[0] if nexts else min(text_seg[0]+text_seg[1],TARGET+0x400)
if not (FSTART<=TARGET<FEND): raise SystemExit('FAIL=FUNCTION_RANGE_DOES_NOT_CONTAIN_TARGET')
out(f'FUNCTION_STARTS_COUNT={len(starts)}')
out(f'PRIMARY_CONTAINING_FUNCTION_START=0x{FSTART:X}')
out(f'PRIMARY_CONTAINING_FUNCTION_END=0x{FEND:X}')
out(f'LLVM_XREF_OFFSET_IN_FUNCTION=0x{TARGET-FSTART:X}')
out('D97BB_FUNCTION_BOUNDARY=LC_FUNCTION_STARTS_PROVEN')

# Disassemble from the exact LC_FUNCTION_STARTS boundary.
READ_END=min(FEND,max(TARGET+0x80,TARGET+1))
code,code_rec,code_fo=read_vm(FSTART,READ_END-FSTART)

def make_macho(code,path):
    cmdsize=72+80; dataoff=32+cmdsize
    segname=b'__TEXT'+b'\0'*10; sectname=b'__text'+b'\0'*10
    hdr=struct.pack('<IiiIIIII',MH_MAGIC_64,CPU_TYPE_X86_64,CPU_SUBTYPE_X86_64_ALL,MH_OBJECT,1,cmdsize,0,0)
    seg=struct.pack('<II16sQQQQiiII',LC_SEGMENT_64,cmdsize,segname,0,len(code),dataoff,len(code),7,5,1,0)
    sec=struct.pack('<16s16sQQIIIIIIII',sectname,segname,0,len(code),dataoff,0,0,0,S_ATTR_PURE_INSTRUCTIONS|S_ATTR_SOME_INSTRUCTIONS,0,0,0)
    path.write_bytes(hdr+seg+sec+code)
obj=TMP/'function.o'; make_macho(code,obj)
rc,ot=run(['/usr/bin/otool','-tvV',str(obj)])
out(f'FUNCTION_RANGE|VM=0x{FSTART:X}..0x{READ_END:X}|CACHE={code_rec["path"]}|FILEOFF=0x{code_fo:X}|BYTES={len(code)}|OTOOL_RC={rc}')
if rc!=0: raise SystemExit('FAIL=OTOOL_FUNCTION')
rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); inst=[]
for ln in ot.splitlines():
    m=rx.match(ln)
    if not m: continue
    try: off=int(m.group(1),16)
    except: continue
    t=m.group(2).strip()
    if t and not t.endswith(':'): inst.append({'off':off,'vm':FSTART+off,'text':t})
inst.sort(key=lambda x:x['off'])
byvm={x['vm']:i for i,x in enumerate(inst)}
if TARGET not in byvm: raise SystemExit('FAIL=LLVM_XREF_NOT_IN_DISASSEMBLY')
ti=byvm[TARGET]
if not inst[ti]['text'].startswith('leaq') or '%rsi' not in inst[ti]['text']: raise SystemExit('FAIL=LLVM_XREF_INSTRUCTION_MISMATCH')
# Verify RIP target of key LEA using next instruction boundary.
if ti+1>=len(inst): raise SystemExit('FAIL=LLVM_XREF_NO_NEXT_INSTRUCTION')
m=re.search(r'(-?0x[0-9A-Fa-f]+)\(%rip\)',inst[ti]['text'])
if not m: raise SystemExit('FAIL=LLVM_XREF_NO_RIP_DISP')
s=m.group(1); disp=-int(s[3:],16) if s.startswith('-0x') else int(s,16)
calc_key=inst[ti+1]['vm']+disp
out(f'LLVM_KEY_RIP_TARGET=0x{calc_key:X}|EXPECTED=0x{KEY_VM:X}')
if calc_key!=KEY_VM: raise SystemExit('FAIL=LLVM_KEY_TARGET_MISMATCH')

# Setter call is the first call after the key before RSI is clobbered.
call_i=None
for j in range(ti+1,min(len(inst),ti+12)):
    if re.search(r'\b%rsi\b',inst[j]['text']) and inst[j]['text'].split(None,1)[0] not in ('callq','call'):
        # Ignore the known key LEA itself; after it, a write to RSI ends pairing.
        if j>ti+1 and inst[j]['text'].split(None,1)[0].startswith(('mov','lea')) and inst[j]['text'].rstrip().endswith('%rsi'): break
    if inst[j]['text'].startswith(('callq','call ')):
        call_i=j; break
if call_i is None: raise SystemExit('FAIL=LLVM_SETTER_CALL_NOT_FOUND')
call_vm=inst[call_i]['vm']; call_off=call_vm-FSTART
# Decode E8 rel32 directly from raw bytes for unambiguous target.
if call_off+5>len(code) or code[call_off]!=0xE8: raise SystemExit(f'FAIL=LLVM_SETTER_NOT_E8:0x{code[call_off]:02X}')
rel=struct.unpack_from('<i',code,call_off+1)[0]; call_target=call_vm+5+rel
out(f'LLVM_SETTER_CALL_VM=0x{call_vm:X}|TARGET=0x{call_target:X}|EXPECTED=0x{EXPECT_SETTER:X}')
if call_target!=EXPECT_SETTER: raise SystemExit('FAIL=LLVM_SETTER_TARGET_MISMATCH')

# Register-family backslice from setter RDX to the first root source, within exact function boundary.
FAM={
 'rax':{'rax','eax','ax','al'},'rbx':{'rbx','ebx','bx','bl'},'rcx':{'rcx','ecx','cx','cl'},'rdx':{'rdx','edx','dx','dl'},
 'rsi':{'rsi','esi','si','sil'},'rdi':{'rdi','edi','di','dil'},'rbp':{'rbp','ebp','bp','bpl'},'rsp':{'rsp','esp','sp','spl'},
 'r8':{'r8','r8d','r8w','r8b'},'r9':{'r9','r9d','r9w','r9b'},'r10':{'r10','r10d','r10w','r10b'},'r11':{'r11','r11d','r11w','r11b'},
 'r12':{'r12','r12d','r12w','r12b'},'r13':{'r13','r13d','r13w','r13b'},'r14':{'r14','r14d','r14w','r14b'},'r15':{'r15','r15d','r15w','r15b'} }
def canon(x):
    x=x.lower().lstrip('%')
    for k,v in FAM.items():
        if x in v:return k
    return x
def ops(t):
    q=t.split('##',1)[0].strip(); p=q.split(None,1)
    if not p:return '',[]
    return p[0],[x.strip() for x in p[1].split(',')] if len(p)>1 else []
def destreg(t):
    op,oo=ops(t)
    if not oo or op.startswith(('cmp','test','call','j','ret','push','pop')):return None
    m=re.fullmatch(r'%([A-Za-z0-9]+)',oo[-1]); return canon(m.group(1)) if m else None
cur='rdx'; trace=[]; source={'kind':'NO_WRITER_WITHIN_FUNCTION','reg':cur}
for j in range(call_i-1,-1,-1):
    t=inst[j]['text']; vm=inst[j]['vm']; op,oo=ops(t)
    if op.startswith('call'):
        # Caller-saved tracked registers cannot be safely traced across an unknown call.
        if cur in {'rax','rcx','rdx','rsi','rdi','r8','r9','r10','r11'}:
            source={'kind':'STOP_CALL','reg':cur,'vm':vm,'text':t}; break
        continue
    if destreg(t)!=cur: continue
    src=oo[0] if len(oo)>=2 else None
    trace.append({'vm':vm,'reg':cur,'text':t})
    if src is None:
        source={'kind':'WRITE_OTHER','text':t}; break
    mreg=re.fullmatch(r'%([A-Za-z0-9]+)',src)
    if mreg:
        cur=canon(mreg.group(1)); continue
    if src.startswith('$'):
        source={'kind':'IMMEDIATE','source':src,'vm':vm,'text':t}; break
    if '(' in src:
        source={'kind':'MEMORY','source':src,'vm':vm,'text':t}; break
    source={'kind':'EXPR','source':src,'vm':vm,'text':t}; break

out('\n===== FUNCTION CONTEXT AROUND LLVMVERSION =====')
lo=max(0,ti-24); hi=min(len(inst),call_i+10)
for x in inst[lo:hi]: out(f'FUNCTION_CONTEXT|VM=0x{x["vm"]:X}|TEXT={x["text"]}')
out('\n===== LLVMVERSION RDX BACKSLICE =====')
for x in trace: out(f'LLVM_RDX_TRACE|VM=0x{x["vm"]:X}|REG={x["reg"]}|TEXT={x["text"]}')
out('LLVM_RDX_SOURCE_JSON='+json.dumps(source,sort_keys=True))
if source['kind'] in {'MEMORY','IMMEDIATE'}:
    classification='STATIC_VALUE_SOURCE_PROVEN'
elif source['kind']=='STOP_CALL':
    classification='STRUCTURAL_SOURCE_MAPPED'
else:
    classification='UNKNOWN'
out(f'G1_GOLDEN_LLVMVERSION_SOURCE_CLASS={classification}')
if source['kind']=='MEMORY': out(f'G1_GOLDEN_LLVMVERSION_MEMORY_SOURCE={source["source"]}')
if source['kind']=='IMMEDIATE': out(f'G1_GOLDEN_LLVMVERSION_IMMEDIATE_SOURCE={source["source"]}')

result={
 'metal_text_sha256':metal_sha,'function_start':FSTART,'function_end':FEND,'llvm_xref':TARGET,'llvm_key_vm':calc_key,
 'setter_call_vm':call_vm,'setter_target':call_target,'rdx_trace':trace,'rdx_source':source,'classification':classification,
 'function_starts_count':len(starts),'function_context':inst[lo:hi]
}
JOUT.write_text(json.dumps(result,indent=2,sort_keys=True),encoding='utf-8')
out(f'JSON_REPORT={JOUT}')
out('D97BB_AUDIT=COMPLETE')
out('SYSTEM_FILE_MUTATION=NO')
out('CACHE_MMAP=NO')
out('CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY')
out('PROCESS_DEBUG_ATTACH=NO')
out('PERSISTENT_INSTRUMENTATION=NO')
out('ROOT_PATCH=AUTO-NO')
out('REBOOT=AUTO-NO')
out('STOP=RETURN_COMPLETE_REPORT_AND_JSON')
PY
