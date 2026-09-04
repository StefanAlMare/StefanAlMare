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
METAL="/System/Library/Frameworks/Metal.framework/Versions/A/Metal"
LIBXPC="/usr/lib/system/libxpc.dylib"
CACHE="/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h"
REPORT="$HOME/Desktop/OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AZ.XXXXXX)"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AZ.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97AZ_AUDIT=FAIL_CLOSED|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "CACHE_MMAP=NO"; echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
for t in /usr/bin/otool /usr/bin/nm /usr/bin/shasum /usr/bin/file; do [[ -x "$t" ]] || fail "MISSING_TOOL:$t"; done
for p in "$MTL32023" "$MTL3802" "$SERVICE" "$CACHE"; do [[ -f "$p" ]] || fail "MISSING_INPUT:$p"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97AZ — GOLDEN METAL REQUEST-BUILDER VALUE BACKSLICE ====="
echo "PURPOSE=backslice_exact_value_sources_from_D97AY_primary_eight_key_request_builder_and_preserve_alternate_data_requestType_paths"
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
echo "D97AZ_GOLDEN_IDENTITY=PASS"

NM_METAL="$TMP/metal.nm"
NM_XPC="$TMP/libxpc.nm"
OTOOL_IV="$TMP/metal.iv"
set +e
/usr/bin/nm -nm "$METAL" > "$NM_METAL" 2>&1
NM_METAL_RC=$?
/usr/bin/nm -nm "$LIBXPC" > "$NM_XPC" 2>&1
NM_XPC_RC=$?
/usr/bin/otool -Iv "$METAL" > "$OTOOL_IV" 2>&1
OTOOL_IV_RC=$?
set -e
echo "NM_METAL_RC=$NM_METAL_RC"
echo "NM_LIBXPC_RC=$NM_XPC_RC"
echo "OTOOL_IV_METAL_RC=$OTOOL_IV_RC"
echo "===== XPC SYMBOL CAPABILITY ====="
/usr/bin/grep -E 'xpc_dictionary_set_(uint64|string|value)|xpc_dictionary_set_data' "$NM_METAL" "$NM_XPC" "$OTOOL_IV" 2>/dev/null | /usr/bin/head -80 || true

"$PYTHON" - "$CACHE" "$TMP" "$NM_METAL" "$NM_XPC" "$OTOOL_IV" "$JSON_REPORT" <<'PY'
from __future__ import annotations
import bisect, json, os, re, struct, subprocess, sys
from pathlib import Path

CACHE=Path(sys.argv[1]); TMP=Path(sys.argv[2]); NM_METAL=Path(sys.argv[3]); NM_XPC=Path(sys.argv[4]); OTOOL_IV=Path(sys.argv[5]); JOUT=Path(sys.argv[6])

METAL_START=0x7FF80D343000
METAL_END=0x7FF80D5C5C3D
PRIMARY=(0x7FF80D370600,0x7FF80D370B80)
ALT_DATA=(0x7FF80D41E700,0x7FF80D41EA00)
ALT_REQUESTTYPE=(0x7FF80D44B880,0x7FF80D44BB80)

KEYS={
 'llvmVersion':(0x7FF80D37081F,0x7FF80D53DBDB,'uint64'),
 'requestType':(0x7FF80D370832,0x7FF80D53DBBF,'uint64'),
 'sandboxTokens':(0x7FF80D370914,0x7FF80D53DBE7,'value'),
 'targetData':(0x7FF80D370939,0x7FF80D53DBF5,'value'),
 'data':(0x7FF80D37095E,0x7FF80D53ABA9,'value'),
 'pluginPath':(0x7FF80D37097F,0x7FF80D53DC00,'string'),
 'client_name':(0x7FF80D3709FD,0x7FF80D53DC22,'string'),
 'APISpecifiedTimeoutInSeconds':(0x7FF80D370A13,0x7FF80D53DC2E,'uint64'),
}
ALT={
 'data_alt':(0x7FF80D41E881,0x7FF80D53ABA9,'value',ALT_DATA),
 'requestType_alt':(0x7FF80D44B9E1,0x7FF80D53DBBF,'uint64',ALT_REQUESTTYPE),
}

LC_SEGMENT_64=0x19
MH_MAGIC_64=0xFEEDFACF
CPU_TYPE_X86_64=0x01000007
CPU_SUBTYPE_X86_64_ALL=3
MH_OBJECT=1
S_ATTR_PURE_INSTRUCTIONS=0x80000000
S_ATTR_SOME_INSTRUCTIONS=0x00000400

def out(s=''): print(s,flush=True)
def pread(fd,n,o): return os.pread(fd,n,o)
def u32(b,o): return struct.unpack_from('<I',b,o)[0]
def run(cmd,timeout=60):
    try:
        p=subprocess.run(cmd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=timeout)
        return p.returncode,p.stdout
    except Exception as e:
        return -999,'TOOL_ERROR:'+repr(e)

def cache_maps(fd):
    h=pread(fd,0x300,0)
    if len(h)<0x20: raise RuntimeError('CACHE_HEADER_SHORT')
    mo=u32(h,0x10); mc=u32(h,0x14)
    if mc==0 or mc>4096: raise RuntimeError(f'CACHE_MAP_COUNT:{mc}')
    raw=pread(fd,mc*32,mo)
    if len(raw)!=mc*32: raise RuntimeError('CACHE_MAP_TABLE_SHORT')
    a=[]
    for i in range(mc):
        vm,sz,fo,maxp,initp=struct.unpack_from('<QQQII',raw,i*32)
        a.append((vm,vm+sz,fo,fo+sz,maxp,initp))
    return a

def vm_to_file(maps,vm):
    for vs,ve,fs,fe,mp,ip in maps:
        if vs<=vm<ve:return fs+(vm-vs)
    return None

def make_macho(code:bytes,path:Path):
    cmdsize=72+80; dataoff=32+cmdsize
    hdr=struct.pack('<IiiIIIII',MH_MAGIC_64,CPU_TYPE_X86_64,CPU_SUBTYPE_X86_64_ALL,MH_OBJECT,1,cmdsize,0,0)
    segname=b'__TEXT'+b'\0'*10; sectname=b'__text'+b'\0'*10
    seg=struct.pack('<II16sQQQQiiII',LC_SEGMENT_64,cmdsize,segname,0,len(code),dataoff,len(code),7,5,1,0)
    sec=struct.pack('<16s16sQQIIIIIIII',sectname,segname,0,len(code),dataoff,0,0,0,S_ATTR_PURE_INSTRUCTIONS|S_ATTR_SOME_INSTRUCTIONS,0,0,0)
    path.write_bytes(hdr+seg+sec+code)

def parse_dis(txt,base):
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); a=[]
    for ln in txt.splitlines():
        m=rx.match(ln)
        if not m:continue
        try: fake=int(m.group(1),16)
        except:continue
        t=m.group(2).strip()
        if not t or t.endswith(':'):continue
        a.append({'fake':fake,'vm':base+fake,'text':t})
    a.sort(key=lambda x:x['fake'])
    return a

def rip_target(inst,i,base):
    t=inst[i]['text']; m=re.search(r'(-?0x[0-9A-Fa-f]+)\(%rip\)',t)
    if not m or i+1>=len(inst): return None
    nxt=inst[i+1]['fake']; cur=inst[i]['fake']
    if not (0<nxt-cur<=15): return None
    s=m.group(1); disp=-int(s[3:],16) if s.startswith('-0x') else int(s,16)
    return base+nxt+disp

def call_target(inst,i,base):
    t=inst[i]['text'].split('##',1)[0].strip()
    if not t.startswith('call'):return None
    m=re.search(r'callq?\s+0x([0-9A-Fa-f]+)',t)
    if m:
        raw=int(m.group(1),16)
        # Wrapped disassembly target is range-relative unless otool printed a fully external-sized address.
        if raw < 0x10000000:return base+raw
        return raw
    return None

REGFAM={
 'rax':{'rax','eax','ax','al'},'rbx':{'rbx','ebx','bx','bl'},'rcx':{'rcx','ecx','cx','cl'},'rdx':{'rdx','edx','dx','dl'},
 'rsi':{'rsi','esi','si','sil'},'rdi':{'rdi','edi','di','dil'},'rbp':{'rbp','ebp','bp','bpl'},'rsp':{'rsp','esp','sp','spl'},
 'r8':{'r8','r8d','r8w','r8b'},'r9':{'r9','r9d','r9w','r9b'},'r10':{'r10','r10d','r10w','r10b'},'r11':{'r11','r11d','r11w','r11b'},
 'r12':{'r12','r12d','r12w','r12b'},'r13':{'r13','r13d','r13w','r13b'},'r14':{'r14','r14d','r14w','r14b'},'r15':{'r15','r15d','r15w','r15b'} }
def canon(s):
    s=s.lower().lstrip('%')
    for k,v in REGFAM.items():
        if s in v:return k
    return s

def ops(t):
    q=t.split('##',1)[0].strip(); p=q.split(None,1)
    if not p:return '',[]
    if len(p)==1:return p[0],[]
    return p[0],[x.strip() for x in p[1].split(',')]
def destreg(t):
    op,oo=ops(t)
    if not oo or op.startswith(('cmp','test','call','j','ret','push','pop')):return None
    d=oo[-1]; m=re.fullmatch(r'%([A-Za-z0-9]+)',d)
    return canon(m.group(1)) if m else None

def trace_reg(inst,call_i,reg='rdx',maxsteps=80):
    cur=reg; tr=[]
    for j in range(call_i-1,max(-1,call_i-maxsteps-1),-1):
        t=inst[j]['text']; vm=inst[j]['vm']
        if t.startswith('call'):
            return tr,{'kind':'STOP_CALL','vm':vm,'text':t,'reg':cur}
        if destreg(t)!=cur:continue
        op,oo=ops(t); src=oo[0] if len(oo)>=2 else None
        tr.append({'vm':vm,'reg':cur,'text':t})
        if src is None:return tr,{'kind':'WRITE_OTHER','text':t}
        mr=re.fullmatch(r'%([A-Za-z0-9]+)',src)
        if mr:
            cur=canon(mr.group(1)); continue
        if src.startswith('$'):return tr,{'kind':'IMMEDIATE','source':src}
        if '(' in src:return tr,{'kind':'MEMORY','source':src}
        return tr,{'kind':'EXPR','source':src}
    return tr,{'kind':'NO_WRITER','reg':cur}

def trace_key_pair(inst,key_vm,key_target,expected_kind):
    indices=[i for i,x in enumerate(inst) if x['vm']==key_vm]
    if len(indices)!=1:return {'status':'XREF_INSTRUCTION_CARDINALITY','count':len(indices)}
    i=indices[0]; rt=rip_target(inst,i,inst[0]['vm']-inst[0]['fake'])
    row={'status':'XREF_FOUND','xref_vm':key_vm,'instruction':inst[i]['text'],'computed_target':rt,'expected_target':key_target,'expected_kind':expected_kind}
    # Find first call before RSI is overwritten. Preserve all nearby calls for audit.
    nearby=[]; chosen=None
    for j in range(i+1,min(len(inst),i+35)):
        d=destreg(inst[j]['text'])
        if d=='rsi':
            row['rsi_clobber_before_call']={'vm':inst[j]['vm'],'text':inst[j]['text']}; break
        if inst[j]['text'].startswith('call'):
            ct=call_target(inst,j,inst[0]['vm']-inst[0]['fake'])
            nearby.append({'index':j,'vm':inst[j]['vm'],'target':ct,'text':inst[j]['text']})
            chosen=j; break
    row['nearby_calls']=nearby
    if chosen is not None:
        tr,res=trace_reg(inst,chosen,'rdx',100)
        row['setter_call_vm']=inst[chosen]['vm']; row['setter_call_target']=call_target(inst,chosen,inst[0]['vm']-inst[0]['fake']); row['rdx_trace']=tr; row['rdx_result']=res
    return row

def nearest_nm_symbol(vm,text):
    sy=[]
    for ln in text.splitlines():
        m=re.match(r'^\s*([0-9A-Fa-f]{8,16})\s+(.+)$',ln)
        if not m:continue
        try:a=int(m.group(1),16)
        except:continue
        sy.append((a,m.group(2).strip()))
    sy.sort(); starts=[x[0] for x in sy]; i=bisect.bisect_right(starts,vm)-1
    return sy[i] if i>=0 else None

fd=os.open(CACHE,os.O_RDONLY)
try:
    maps=cache_maps(fd)
    out('===== CACHE MAPPING =====')
    for r in maps:out(f'CACHE_MAP|VM=0x{r[0]:X}..0x{r[1]:X}|FILE=0x{r[2]:X}..0x{r[3]:X}|MAXPROT={r[4]}|INITPROT={r[5]}')
    slices={}
    for name,(a,b) in {'primary':PRIMARY,'alt_data':ALT_DATA,'alt_requestType':ALT_REQUESTTYPE}.items():
        fo=vm_to_file(maps,a); fe=vm_to_file(maps,b-1)
        if fo is None or fe is None:raise RuntimeError(f'UNMAPPED_RANGE:{name}')
        fe+=1; code=pread(fd,fe-fo,fo)
        if len(code)!=fe-fo:raise RuntimeError(f'SHORT_RANGE_READ:{name}')
        obj=TMP/f'{name}.o'; make_macho(code,obj)
        rc,dis=run(['/usr/bin/otool','-tvV',str(obj)],30)
        out(f'RANGE|NAME={name}|VM=0x{a:X}..0x{b:X}|FILE=0x{fo:X}..0x{fe:X}|BYTES={len(code)}|OTOOL_RC={rc}')
        if rc!=0:raise RuntimeError(f'OTOOL_RANGE:{name}:{rc}:{dis[:200]}')
        inst=parse_dis(dis,a); out(f'RANGE_DISASM|NAME={name}|INSTRUCTIONS={len(inst)}')
        slices[name]={'start':a,'end':b,'fileoff_start':fo,'fileoff_end':fe,'instructions':inst}
finally:
    os.close(fd)

nm_metal=NM_METAL.read_text(errors='replace') if NM_METAL.exists() else ''
nm_xpc=NM_XPC.read_text(errors='replace') if NM_XPC.exists() else ''
ot_iv=OTOOL_IV.read_text(errors='replace') if OTOOL_IV.exists() else ''

out('\n===== PRIMARY EIGHT-KEY PAIR/BACKSLICE =====')
primary=slices['primary']['instructions']; result={}
for k,(x,t,kind) in KEYS.items():
    r=trace_key_pair(primary,x,t,kind); result[k]=r
    own=nearest_nm_symbol(x,nm_metal)
    out(f'KEY_BEGIN|KEY={k}|XREF=0x{x:X}|EXPECTED_TARGET=0x{t:X}|EXPECTED_KIND={kind}|NM_OWNER={own}')
    out('KEY_RESULT_JSON='+json.dumps(r,sort_keys=True))
    # Print bounded instruction corridor xref -> call + 8 surrounding each side.
    idx=next((i for i,z in enumerate(primary) if z['vm']==x),None)
    if idx is not None:
        hi=idx+1
        if r.get('setter_call_vm') is not None:
            ci=next((i for i,z in enumerate(primary) if z['vm']==r['setter_call_vm']),idx)
            hi=ci+5
        for z in primary[max(0,idx-6):min(len(primary),hi)]:out(f'KEY_CONTEXT|KEY={k}|VM=0x{z["vm"]:X}|{z["text"]}')
    out(f'KEY_END|KEY={k}')

out('\n===== ALTERNATE XREF PATHS =====')
altres={}
for name,(x,t,kind,rng) in ALT.items():
    inst=slices['alt_data' if name=='data_alt' else 'alt_requestType']['instructions']
    r=trace_key_pair(inst,x,t,kind); altres[name]=r
    out(f'ALT_BEGIN|NAME={name}|XREF=0x{x:X}|EXPECTED_TARGET=0x{t:X}|EXPECTED_KIND={kind}')
    out('ALT_RESULT_JSON='+json.dumps(r,sort_keys=True))
    idx=next((i for i,z in enumerate(inst) if z['vm']==x),None)
    if idx is not None:
        hi=idx+1
        if r.get('setter_call_vm') is not None:
            ci=next((i for i,z in enumerate(inst) if z['vm']==r['setter_call_vm']),idx)
            hi=ci+5
        for z in inst[max(0,idx-8):min(len(inst),hi)]:out(f'ALT_CONTEXT|NAME={name}|VM=0x{z["vm"]:X}|{z["text"]}')
    out(f'ALT_END|NAME={name}')

out('\n===== SETTER TARGET GROUPS =====')
groups={}
for k,r in result.items():
    t=r.get('setter_call_target'); groups.setdefault(str(t),[]).append(k)
for k,r in altres.items():
    t=r.get('setter_call_target'); groups.setdefault(str(t),[]).append(k)
for target,names in groups.items():out(f'SETTER_TARGET_GROUP|TARGET={target}|KEYS={",".join(names)}')

out('\n===== STATIC SYMBOL HINTS =====')
for source_name,text in [('NM_METAL',nm_metal),('NM_LIBXPC',nm_xpc),('OTOOL_IV_METAL',ot_iv)]:
    for ln in text.splitlines():
        if re.search(r'xpc_dictionary_set_(uint64|string|value)|xpc_dictionary_set_data',ln):out(f'{source_name}|{ln}')

# Conservative classifications from the backslice result only.
out('\n===== FIELD CLASSIFICATION =====')
classif={}
for k,r in result.items():
    res=r.get('rdx_result') or {}
    if r.get('computed_target')!=r.get('expected_target'):
        c='XREF_TARGET_MISMATCH'
    elif r.get('setter_call_vm') is None:
        c='UNKNOWN_NO_PAIRED_CALL'
    elif res.get('kind') in ('IMMEDIATE','MEMORY'):
        c='STATIC_VALUE_SOURCE_PROVEN'
    elif res.get('kind') in ('STOP_CALL','EXPR','WRITE_OTHER'):
        c='STRUCTURAL_SOURCE_MAPPED'
    else:
        c='UNKNOWN'
    classif[k]=c; out(f'FIELD_CLASSIFICATION|KEY={k}|CLASS={c}|RDX={json.dumps(res,sort_keys=True)}')

summary={'metal_start':METAL_START,'metal_end':METAL_END,'ranges':{n:{k:v for k,v in s.items() if k!='instructions'} for n,s in slices.items()},'primary':result,'alternate':altres,'setter_target_groups':groups,'field_classification':classif}
JOUT.write_text(json.dumps(summary,indent=2,sort_keys=True))
out(f'JSON_REPORT={JOUT}')
out('G1_GOLDEN_PRIMARY_REQUEST_BUILDER_VALUE_BACKSLICE=COMPLETE_FOR_STATIC_CHANNEL')
out('RUNTIME_VALUE_CLAIM=NO')
out('D97AZ_AUDIT=COMPLETE')
PY

echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=PERSISTENT_NO_TEMP_RANGE_ONLY"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "PERSISTENT_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
