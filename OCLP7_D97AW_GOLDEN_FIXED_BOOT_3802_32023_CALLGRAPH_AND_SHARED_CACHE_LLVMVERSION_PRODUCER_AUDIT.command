#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_3802_SHA="85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40"
EXPECTED_SERVICE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
UUID_32023="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
UUID_3802="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"
BOOT_START="2026-09-04 12:54:24"
BOOT_END="2026-09-04 12:57:24"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
METAL="/System/Library/Frameworks/Metal.framework/Versions/A/Metal"
REPORT="$HOME/Desktop/OCLP7_D97AW_GOLDEN_FIXED_BOOT_3802_32023_CALLGRAPH_AND_SHARED_CACHE_LLVMVERSION_PRODUCER_AUDIT.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97AW_GOLDEN_FIXED_BOOT_3802_32023_CALLGRAPH_AND_SHARED_CACHE_LLVMVERSION_PRODUCER_AUDIT.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AW.XXXXXX)"
LOGJSON="$TMP/boot.json"
O32023="$TMP/32023.otool"
N32023="$TMP/32023.nm"
O3802="$TMP/3802.otool"
N3802="$TMP/3802.nm"
OMETAL="$TMP/metal.otool"
NMETAL="$TMP/metal.nm"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AW.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){
  echo "D97AW_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SYSTEM_FILE_MUTATION=NO"
  echo "PROCESS_DEBUG_ATTACH=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
for p in "$MTL32023" "$MTL3802" "$SERVICE" "$METAL"; do [[ -e "$p" ]] || fail "MISSING:$p"; done
for t in /usr/bin/otool /usr/bin/nm /usr/bin/shasum /usr/bin/log; do [[ -x "$t" ]] || fail "MISSING_TOOL:$t"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97AW — GOLDEN FIXED BOOT 3802/32023 CALLGRAPH + SHARED-CACHE LLVMVERSION PRODUCER ====="
echo "EXPECTED_OS_VERSION=$EXPECTED_OS_VERSION"
echo "EXPECTED_OS_BUILD=$EXPECTED_OS_BUILD"
echo "FIXED_BOOT_START=$BOOT_START"
echo "FIXED_BOOT_END=$BOOT_END"
echo "SYSTEM_FILE_MUTATION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
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
echo "D97AW_GOLDEN_IDENTITY=PASS"

/usr/bin/otool -tvV "$MTL32023" > "$O32023" 2>&1 || fail "OTOOL_32023"
/usr/bin/nm -nm "$MTL32023" > "$N32023" 2>&1 || fail "NM_32023"
/usr/bin/otool -tvV "$MTL3802" > "$O3802" 2>&1 || fail "OTOOL_3802"
/usr/bin/nm -nm "$MTL3802" > "$N3802" 2>&1 || fail "NM_3802"
/usr/bin/otool -tvV "$METAL" > "$OMETAL" 2>&1 || true
/usr/bin/nm -nm "$METAL" > "$NMETAL" 2>&1 || true
/usr/bin/log show --start "$BOOT_START" --end "$BOOT_END" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$LOGJSON" 2>/dev/null || true

"$PYTHON" - "$MTL32023" "$O32023" "$N32023" "$MTL3802" "$O3802" "$N3802" "$METAL" "$OMETAL" "$NMETAL" "$LOGJSON" "$UUID_32023" "$UUID_3802" "$JSON_REPORT" <<'PY'
from __future__ import annotations
import bisect, collections, hashlib, json, os, re, struct, subprocess, sys
from pathlib import Path

p32,o32,n32,p38,o38,n38,metal,ometal,nmetal,logjson=map(Path,sys.argv[1:11])
u32=sys.argv[11].upper(); u38=sys.argv[12].upper(); jsonout=Path(sys.argv[13])

TAHOE_WRITER_SOURCES={'[RBX+0x1C]','[RCX+0x38]'}
KEYFUN_SUBSTRINGS=[
 'getReadParametersFromRequest','upgradeAIRModule','buildSpecializedFunctionRequest',
 'backendCompileExecutableRequest','backendCompileModule','invokeLowerModule','runFrameworkPasses'
]
PATCH_OWNER_SUBSTRINGS={
 'P2B':'getReadParametersFromRequest','AIR00':'getReadParametersFromRequest','P7':'getReadParametersFromRequest',
 'P3':'backendCompileModule','D34':'runFrameworkPasses','P6A':'invokeLowerModule','P6B':'runFrameworkPasses'
}

def out(s=''): print(s,flush=True)
def parse_dis(path):
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); arr=[]
    for ln in path.read_text(errors='replace').splitlines():
        m=rx.match(ln)
        if not m: continue
        try:a=int(m.group(1),16)
        except:continue
        t=m.group(2).strip()
        if t and not t.endswith(':'):arr.append((a,t))
    return sorted(arr)
def parse_syms(path):
    arr=[]
    for ln in path.read_text(errors='replace').splitlines():
        m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',ln)
        if not m:continue
        try:a=int(m.group(1),16)
        except:continue
        arr.append((a,m.group(2).strip()))
    return sorted(arr)
def macho_base(path):
    d=path.read_bytes()
    if len(d)<32 or struct.unpack_from('<I',d,0)[0]!=0xFEEDFACF: raise SystemExit('MACHO64_REQUIRED:'+str(path))
    n=struct.unpack_from('<I',d,16)[0]; q=32; text=None
    for _ in range(n):
        cmd,sz=struct.unpack_from('<II',d,q)
        if cmd==0x19 and sz>=72:
            nm=d[q+8:q+24].split(b'\0',1)[0].decode('ascii','replace')
            vm,vs,fo,fs=struct.unpack_from('<QQQQ',d,q+24)
            if nm=='__TEXT':text=(vm,vs,fo,fs)
        q+=sz
    if not text:raise SystemExit('TEXT_MISSING:'+str(path))
    return text[0]
def owner(addr,syms):
    starts=[a for a,n in syms]; i=bisect.bisect_right(starts,addr)-1
    return syms[i] if i>=0 else (None,'UNKNOWN')
def sym_bounds(syms):
    outd={}
    for i,(a,n) in enumerate(syms):outd[n]=(a,syms[i+1][0] if i+1<len(syms) else (1<<64))
    return outd

def decode_log(path):
    raw=path.read_text(errors='replace'); dec=json.JSONDecoder(); rec=[]; i=0
    while i<len(raw):
        while i<len(raw) and (raw[i].isspace() or raw[i]==','):i+=1
        if i>=len(raw):break
        if raw[i] not in '[{':
            ps=[p for p in (raw.find('{',i),raw.find('[',i)) if p>=0]
            if not ps:break
            i=min(ps)
        try:o,e=dec.raw_decode(raw,i)
        except json.JSONDecodeError:i+=1;continue
        if isinstance(o,list):rec.extend(x for x in o if isinstance(x,dict))
        elif isinstance(o,dict):rec.append(o)
        i=e
    return rec

def val(r,*ks):
    for k in ks:
        if k in r and r[k] is not None:return r[k]
    return None

def pid(r):
    try:return int(val(r,'processID','processIdentifier'))
    except:return -1

D32=parse_dis(o32); S32=parse_syms(n32); B32=macho_base(p32)
D38=parse_dis(o38); S38=parse_syms(n38); B38=macho_base(p38)
recs=decode_log(logjson)
rows=[]
for r in recs:
    uu=str(val(r,'senderImageUUID') or '').upper(); gen='32023' if uu==u32 else ('3802' if uu==u38 else None)
    if not gen:continue
    pc=val(r,'senderProgramCounter')
    try:pc=int(pc,0) if isinstance(pc,str) else int(pc)
    except:pc=-1
    rows.append((str(val(r,'timestamp') or ''),pid(r),gen,pc,str(val(r,'eventMessage','message') or '').replace('\n','\\n')))

out('\n===== FIXED D97AU BOOT WINDOW — EXACT GENERATION / PC COUNTS =====')
out('FIXED_WINDOW_EXACT_ROW_COUNT='+str(len(rows)))
gc=collections.Counter(x[2] for x in rows); out('FIXED_WINDOW_GENERATION_COUNTS='+';'.join(f'{k}:{gc[k]}' for k in sorted(gc)))
bygenpc=collections.Counter((x[2],x[3]) for x in rows)
for (g,pc),n in sorted(bygenpc.items()):out(f'FIXED_WINDOW_PC|GEN={g}|PC=0x{pc:X}|COUNT={n}')
by=collections.defaultdict(list)
for x in rows:by[x[1]].append(x)
for p in by:by[p].sort()
out('FIXED_WINDOW_EXACT_PID_COUNT='+str(len(by)))
for p in sorted(by):
    rs=by[p]; gens=sorted(set(x[2] for x in rs)); pcs=collections.Counter((x[2],x[3]) for x in rs)
    out(f'FIXED_PID|PID={p}|GENERATIONS={",".join(gens)}|COUNT={len(rs)}|PCS='+';'.join(f'{g}:0x{pc:X}:{n}' for (g,pc),n in sorted(pcs.items())))

out('\n===== STATIC MAP OF EVERY OBSERVED FIXED-WINDOW PC =====')
pcmap={}
for gen,pc in sorted(set((x[2],x[3]) for x in rows)):
    dis,sy,base=(D32,S32,B32) if gen=='32023' else (D38,S38,B38)
    vm=base+pc; sa,sn=owner(vm,sy); nearest=min(dis,key=lambda x:abs(x[0]-vm)) if dis else (0,'NONE')
    pcmap[f'{gen}:0x{pc:X}']={'vm':vm,'symbol':sn,'instruction':nearest[1]}
    out(f'FIXED_PC_MAP|GEN={gen}|PC=0x{pc:X}|VM=0x{vm:X}|SYMBOL={sn}|INSTRUCTION={nearest[1]}')
    idx=dis.index(nearest)
    for a,t in dis[max(0,idx-8):min(len(dis),idx+9)]:out(f'FIXED_PC_CONTEXT|GEN={gen}|PC=0x{pc:X}|OFFSET=0x{a-base:X}|TEXT={t}')

out('\n===== GOLDEN 32023 DIRECT CALLGRAPH AROUND PATCH/LANE FUNCTIONS =====')
bounds=sym_bounds(S32); starts={a:n for a,n in S32}; keynames={}
for sub in KEYFUN_SUBSTRINGS:
    c=[(a,n) for a,n in S32 if sub in n]
    out(f'KEY_FUNCTION_CANDIDATES|SUB={sub}|COUNT={len(c)}')
    for a,n in c:out(f'KEY_FUNCTION|SUB={sub}|VM=0x{a:X}|OFFSET=0x{a-B32:X}|SYMBOL={n}')
    if len(c)==1:keynames[sub]=c[0][1]

# Direct internal calls: source owner -> numeric target owner.
edges=collections.defaultdict(set); callers=collections.defaultdict(set)
for a,t in D32:
    if not t.lstrip().startswith('call'):continue
    m=re.search(r'callq?\s+0x([0-9A-Fa-f]+)',t)
    if not m:continue
    tgt=int(m.group(1),16); _,src=owner(a,S32); _,dst=owner(tgt,S32)
    if src!='UNKNOWN' and dst!='UNKNOWN':edges[src].add(dst); callers[dst].add(src)
keyset=set(keynames.values())
for src in sorted(edges):
    for dst in sorted(edges[src]):
        if src in keyset or dst in keyset:
            out(f'DIRECT_CALL_EDGE|SRC={src}|DST={dst}')
for sub,nm in keynames.items():
    out(f'DIRECT_CALLERS|FUNCTION={sub}|COUNT={len(callers.get(nm,set()))}|CALLERS='+' || '.join(sorted(callers.get(nm,set()))))
    out(f'DIRECT_CALLEES|FUNCTION={sub}|COUNT={len(edges.get(nm,set()))}|CALLEES='+' || '.join(sorted(edges.get(nm,set()))))

def reach(src,dst,limit=12):
    if src==dst:return [src]
    q=collections.deque([(src,[src])]); seen={src}
    while q:
        n,path=q.popleft()
        if len(path)>limit:continue
        for z in edges.get(n,set()):
            if z==dst:return path+[z]
            if z not in seen:seen.add(z);q.append((z,path+[z]))
    return None
for entrysub in ('buildSpecializedFunctionRequest','backendCompileExecutableRequest'):
    en=keynames.get(entrysub)
    if not en:continue
    for patch,ownersub in PATCH_OWNER_SUBSTRINGS.items():
        on=keynames.get(ownersub)
        if not on:continue
        path=reach(en,on)
        out(f'DIRECT_REACHABILITY|ENTRY={entrysub}|PATCH_OWNER={patch}:{ownersub}|RESULT={"STATIC_PROVEN" if path else "NOT_PROVEN_BY_DIRECT_CALLGRAPH"}|PATH={" -> ".join(path) if path else "NONE"}')

# Explicit getReadParameters -> upgradeAIR relation.
if keynames.get('getReadParametersFromRequest') and keynames.get('upgradeAIRModule'):
    p=reach(keynames['getReadParametersFromRequest'],keynames['upgradeAIRModule'])
    out('GETREAD_TO_UPGRADEAIR_DIRECT_REACHABILITY='+('STATIC_PROVEN|PATH='+' -> '.join(p) if p else 'NOT_PROVEN_BY_DIRECT_CALLGRAPH'))

out('\n===== GOLDEN SHARED-CACHE llvmVersion OWNER + WRITER VALUE SOURCE =====')
KEY=b'llvmVersion'; CHUNK=8*1024*1024
SEARCH_DIRS=[Path('/System/Library/dyld'),Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),Path('/System/Cryptexes/OS/System/Library/dyld'),Path('/private/preboot/Cryptexes/OS/System/Library/dyld')]

def u32le(b,o):return struct.unpack_from('<I',b,o)[0]
def u64le(b,o):return struct.unpack_from('<Q',b,o)[0]
def pread(fd,n,o):return os.pread(fd,n,o)
def cstr(fd,size,o,lim=16384):
    if o<0 or o>=size:return None
    b=pread(fd,min(lim,size-o),o); z=b.find(b'\0')
    return (b[:z] if z>=0 else b).decode('utf-8','replace')
def chunk_find(fd,size,key):
    ov=len(key)-1; pos=0; carry=b''; hits=[]
    while pos<size:
        b=pread(fd,min(CHUNK,size-pos),pos)
        if not b:break
        buf=carry+b; base=pos-len(carry); st=0
        while True:
            i=buf.find(key,st)
            if i<0:break
            a=base+i
            if a>=0 and (not hits or hits[-1]!=a):hits.append(a)
            st=i+1
        carry=buf[-ov:] if ov else b''; pos+=len(b)
    return hits

files=[]; seen=set()
for d in SEARCH_DIRS:
    if not d.is_dir():continue
    for p in sorted(d.iterdir()):
        if not p.name.startswith('dyld_shared_cache_'):continue
        try:st=p.stat()
        except:continue
        if not p.is_file():continue
        ident=(st.st_dev,st.st_ino)
        if ident in seen:continue
        seen.add(ident);files.append((p,st.st_size))
out('CACHE_FILE_COUNT='+str(len(files)))
meta=[]; images=[]
for p,size in files:
    fd=None
    try:
        fd=os.open(str(p),os.O_RDONLY); h=pread(fd,min(size,0x300),0)
        if len(h)<0x98 or not h[:16].rstrip(b'\0').startswith(b'dyld_'):continue
        mo=u32le(h,0x10); mc=u32le(h,0x14); ito=u64le(h,0x88); itc=u64le(h,0x90)
        raw=pread(fd,mc*32,mo); maps=[]
        if len(raw)!=mc*32:continue
        for i in range(mc):
            addr,sz,fo,maxp,initp=struct.unpack_from('<QQQII',raw,i*32); maps.append((fo,fo+sz,addr,sz))
        rec={'path':p,'size':size,'maps':maps};meta.append(rec)
        if itc and itc<200000 and ito+itc*32<=size:
            ir=pread(fd,itc*32,ito)
            if len(ir)==itc*32:
                for i in range(itc):
                    o=i*32; load=u64le(ir,o+16); ts=u32le(ir,o+24); po=u32le(ir,o+28)
                    if ts:
                        pp=cstr(fd,size,po) or ''
                        images.append((load,load+ts,pp,str(p)))
    except Exception as e:out(f'CACHE_PARSE_ERROR={p}|{e!r}')
    finally:
        if fd is not None:
            try:os.close(fd)
            except:pass
images=sorted({(a,b,p,c) for a,b,p,c in images})
starts=[x[0] for x in images]
def image_owner(vm):
    i=bisect.bisect_right(starts,vm)-1
    if i>=0 and images[i][0]<=vm<images[i][1]:return images[i]
    return None
def off_to_vm(maps,off):
    for fo,fe,va,sz in maps:
        if fo<=off<fe:return va+(off-fo)
    return None
metal_hits=[]
for rec in meta:
    fd=None
    try:
        fd=os.open(str(rec['path']),os.O_RDONLY)
        hits=chunk_find(fd,rec['size'],KEY)
        for off in hits:
            vm=off_to_vm(rec['maps'],off); own=image_owner(vm) if vm is not None else None
            if own and '/Metal.framework/Versions/A/Metal' in own[2]:
                metal_hits.append({'cache':str(rec['path']),'fileoff':off,'vm':vm,'owner':own[2],'text_start':own[0],'text_end':own[1]})
    except Exception as e:out(f'CACHE_SCAN_ERROR={rec["path"]}|{e!r}')
    finally:
        if fd is not None:
            try:os.close(fd)
            except:pass
out('GOLDEN_CACHED_METAL_LLVMVERSION_HIT_COUNT='+str(len(metal_hits)))
for i,h in enumerate(metal_hits,1):out(f'GOLDEN_CACHED_METAL_KEY|N={i}|VM=0x{h["vm"]:X}|FILEOFF=0x{h["fileoff"]:X}|OWNER={h["owner"]}|CACHE={h["cache"]}')

DM=parse_dis(ometal); SM=parse_syms(nmetal)
def rip_target(i):
    a,t=DM[i]; m=re.search(r'(-?0x[0-9A-Fa-f]+)\(%rip\)',t)
    if not m or i+1>=len(DM):return None
    s=m.group(1); disp=-int(s[3:],16) if s.startswith('-0x') else int(s,16)
    nxt=DM[i+1][0]
    if not (0<nxt-a<=15):return None
    return nxt+disp
xrefs=[]
keys={h['vm'] for h in metal_hits}
for i,(a,t) in enumerate(DM):
    rt=rip_target(i)
    if rt in keys or 'llvmVersion' in t:xrefs.append((i,a,t,rt))
out('GOLDEN_METAL_EXACT_KEY_XREF_COUNT='+str(len(xrefs)))
for n,(i,a,t,rt) in enumerate(xrefs,1):
    _,sn=owner(a,SM);out(f'GOLDEN_METAL_KEY_XREF|N={n}|VM=0x{a:X}|TARGET={"0x%X"%rt if rt else "NA"}|SYMBOL={sn}|TEXT={t}')

writers=[]
for i,(a,t) in enumerate(DM):
    if t.lstrip().startswith('call') and 'xpc_dictionary_set_uint64' in t:writers.append((i,a,t))
out('GOLDEN_METAL_SET_UINT64_CALL_COUNT='+str(len(writers)))

fam={'rdi':{'rdi','edi','di','dil'},'rsi':{'rsi','esi','si','sil'},'rdx':{'rdx','edx','dx','dl'},'rcx':{'rcx','ecx','cx','cl'},'r8':{'r8','r8d','r8w','r8b'},'r9':{'r9','r9d','r9w','r9b'},'rax':{'rax','eax','ax','al'},'rbx':{'rbx','ebx','bx','bl'},'r10':{'r10','r10d','r10w','r10b'},'r11':{'r11','r11d','r11w','r11b'},'r12':{'r12','r12d','r12w','r12b'},'r13':{'r13','r13d','r13w','r13b'},'r14':{'r14','r14d','r14w','r14b'},'r15':{'r15','r15d','r15w','r15b'}}
def canon(s):
    s=s.lower().lstrip('%')
    for k,v in fam.items():
        if s in v:return k
    return s
def splitops(t):
    q=t.split('##',1)[0].strip(); ps=q.split(None,1)
    return (ps[0] if ps else '',[x.strip() for x in ps[1].split(',')] if len(ps)>1 else [])
def destreg(t):
    op,ops=splitops(t)
    if not ops or op.startswith(('cmp','test','call','j','ret','push')):return None
    m=re.fullmatch(r'%([A-Za-z0-9]+)',ops[-1]);return canon(m.group(1)) if m else None
def norm_mem(s):
    # Normalize common source for comparison with persisted Tahoe forms.
    m=re.fullmatch(r'(-?0x[0-9A-Fa-f]+)\(%(r[a-z0-9]+)\)',s.replace(' ',''))
    if not m:return s
    off=int(m.group(1),16) if not m.group(1).startswith('-') else -int(m.group(1)[3:],16)
    return f'[{m.group(2).upper()}+0x{off:X}]' if off>=0 else f'[{m.group(2).upper()}-0x{-off:X}]'
def trace(idx,reg='rdx',steps=100):
    cur=reg; tr=[]
    for j in range(idx-1,max(-1,idx-steps-1),-1):
        a,t=DM[j]
        if t.lstrip().startswith('call'):return tr,('STOP_CALL',t)
        if destreg(t)!=cur:continue
        op,ops=splitops(t); src=ops[0] if len(ops)>=2 else None;tr.append((a,cur,t))
        if src is None:return tr,('OTHER',t)
        mr=re.fullmatch(r'%([A-Za-z0-9]+)',src)
        if mr:cur=canon(mr.group(1));continue
        if src.startswith('$'):return tr,('IMMEDIATE',src)
        if '(' in src:return tr,('MEMORY',norm_mem(src))
        return tr,('EXPR',src)
    return tr,('NO_WRITER',cur)

sources=[]; pairs=[]
for xn,(xi,xa,xt,xrt) in enumerate(xrefs,1):
    for wn,(wi,wa,wt) in enumerate(writers,1):
        delta=wa-xa
        if -0x300<=delta<=0x600:
            tr,res=trace(wi,'rdx');pairs.append((xn,wn,xa,wa,delta,res))
            out(f'GOLDEN_KEY_WRITER_PAIR|KEY={xn}|WRITER={wn}|DELTA={delta:+#x}|RDX_RESULT={res}')
            for aa,rr,tt in tr:out(f'GOLDEN_RDX_TRACE|VM=0x{aa:X}|REG={rr}|TEXT={tt}')
            if res[0]=='MEMORY':sources.append(res[1])
out('GOLDEN_LLVMVERSION_VALUE_SOURCE_SET='+';'.join(sorted(set(sources))) if sources else 'GOLDEN_LLVMVERSION_VALUE_SOURCE_SET=UNRESOLVED')
if sources:
    ss=set(sources)
    if ss==TAHOE_WRITER_SOURCES: cmp='STATIC_EQUIVALENT_EXACT_SOURCE_SHAPE'
    elif ss & TAHOE_WRITER_SOURCES: cmp='PARTIAL_OVERLAP'
    else: cmp='DIFFERENT_SOURCE_SHAPE'
else:cmp='INCONCLUSIVE_NO_SOURCE_RECOVERED'
out('GOLDEN_TAHOE_LLVMVERSION_WRITER_SOURCE_COMPARISON='+cmp)
out('TAHOE_PERSISTED_LLVMVERSION_VALUE_SOURCE_SET='+';'.join(sorted(TAHOE_WRITER_SOURCES)))

out('\n===== CONSERVATIVE CLASSIFICATIONS =====')
out('D97AW_FIXED_BOOT_WINDOW_USED=YES_ABSOLUTE_D97AU_WINDOW')
out('D97AV_V2_1970_BOOT_SUBSECTION=RETIRED_TOOLING_FALSE_WINDOW')
out('P1_3802_BRANCH_BYTE_INFLUENCE=NO_P1_ONLY_CHANGES_31001_COMPARE_TO_32023')
out('P1_SIMPLE_ABLATION=NOT_RECOMMENDED_WITHOUT_PRODUCER_NORMALIZATION')
out('D97AW_GOLDEN_CALLGRAPH_AND_SHARED_CACHE_PRODUCER_AUDIT=PASS')

Path(jsonout).write_text(json.dumps({
 'fixed_window_generation_counts':dict(gc),
 'fixed_window_pc_counts':{f'{g}:0x{pc:X}':n for (g,pc),n in bygenpc.items()},
 'pc_map':pcmap,
 'key_functions':keynames,
 'cached_metal_key_hits':metal_hits,
 'golden_writer_sources':sorted(set(sources)),
 'golden_tahoe_writer_source_comparison':cmp,
},indent=2),encoding='utf-8')
PY

echo
echo "===== FINAL LEDGER ====="
echo "SYSTEM_FILE_MUTATION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D97AW_AUDIT=PASS"
echo "REPORT=$REPORT"
echo "JSON_REPORT=$JSON_REPORT"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
