#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_3802_SHA="85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40"
EXPECTED_SERVICE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
UUID_32023="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
UUID_3802="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"
FIXED_START="2026-09-04 12:54:24"
FIXED_END="2026-09-04 12:57:24"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
METAL="/System/Library/Frameworks/Metal.framework/Versions/A/Metal"
REPORT="$HOME/Desktop/OCLP7_D97AX_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97AX_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AX.XXXXXX)"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AX.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){
  echo "D97AX_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SYSTEM_FILE_MUTATION=NO"
  echo "PROCESS_DEBUG_ATTACH=NO"
  echo "CACHE_EXTRACTION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
for t in /usr/bin/otool /usr/bin/nm /usr/bin/shasum /usr/bin/log /usr/bin/strings /usr/sbin/sysctl /usr/bin/system_profiler /usr/bin/codesign; do
  [[ -x "$t" ]] || fail "MISSING_TOOL:$t"
done
for p in "$MTL32023" "$MTL3802" "$SERVICE" "$METAL"; do [[ -e "$p" ]] || fail "MISSING_INPUT:$p"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97AX — GOLDEN ORIGINAL-OCLP INGRESS CONTRACT CENSUS ====="
echo "ARCHITECTURE=Sequoia_producer_to_ORIGINAL_OCLP_donor_to_Haswell_handoff_contract_book"
echo "FIXED_REFERENCE_WINDOW=$FIXED_START..$FIXED_END"
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
[[ "$OSV" == "$EXPECTED_OS_VERSION" && "$OSB" == "$EXPECTED_OS_BUILD" ]] || fail "NOT_EXPECTED_GOLDEN_OS"
[[ "$SHA32" == "$EXPECTED_32023_SHA" ]] || fail "GOLDEN_32023_SHA"
[[ "$SHA38" == "$EXPECTED_3802_SHA" ]] || fail "GOLDEN_3802_SHA"
[[ "$SHASVC" == "$EXPECTED_SERVICE_SHA" ]] || fail "GOLDEN_SERVICE_SHA"
echo "D97AX_GOLDEN_IDENTITY=PASS"

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_EPOCH="$("$PYTHON" - "$BOOT_RAW" <<'PY'
import re,sys
s=sys.argv[1]
m=re.search(r'(?<!u)\bsec\s*=\s*(\d+)',s)
if not m:
    raise SystemExit('BOOT_EPOCH_PARSE_FAIL:'+s)
print(m.group(1))
PY
)"
BOOT_START="$("$PYTHON" - "$BOOT_EPOCH" <<'PY'
import datetime,sys
print(datetime.datetime.fromtimestamp(int(sys.argv[1])).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
NOW_LOCAL="$(/bin/date '+%Y-%m-%d %H:%M:%S')"
echo "KERN_BOOTTIME_RAW=$BOOT_RAW"
echo "CURRENT_BOOT_EPOCH=$BOOT_EPOCH"
echo "CURRENT_BOOT_START=$BOOT_START"
echo "CURRENT_CAPTURE_END=$NOW_LOCAL"

O32="$TMP/32023.otool"; N32="$TMP/32023.nm"
O38="$TMP/3802.otool"; N38="$TMP/3802.nm"
OSVC="$TMP/service.otool"; NSVC="$TMP/service.nm"
OMETAL="$TMP/metal.otool"; NMETAL="$TMP/metal.nm"
FIXED_JSON="$TMP/fixed_mtl.json"; CURRENT_JSON="$TMP/current_mtl.json"
DRIVER_LOG="$TMP/driver.log"

/usr/bin/otool -tvV "$MTL32023" > "$O32" 2>&1 || fail "OTOOL_32023"
/usr/bin/nm -nm "$MTL32023" > "$N32" 2>&1 || fail "NM_32023"
/usr/bin/otool -tvV "$MTL3802" > "$O38" 2>&1 || fail "OTOOL_3802"
/usr/bin/nm -nm "$MTL3802" > "$N38" 2>&1 || fail "NM_3802"
/usr/bin/otool -tvV "$SERVICE" > "$OSVC" 2>&1 || fail "OTOOL_SERVICE"
/usr/bin/nm -nm "$SERVICE" > "$NSVC" 2>&1 || true
/usr/bin/otool -tvV "$METAL" > "$OMETAL" 2>&1 || true
/usr/bin/nm -nm "$METAL" > "$NMETAL" 2>&1 || true

/usr/bin/log show --start "$FIXED_START" --end "$FIXED_END" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$FIXED_JSON" 2>/dev/null || true
/usr/bin/log show --start "$BOOT_START" --end "$NOW_LOCAL" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$CURRENT_JSON" 2>/dev/null || true
/usr/bin/log show --start "$BOOT_START" --end "$NOW_LOCAL" --timezone local --style compact --info --debug --predicate '(process == "WindowServer") OR (eventMessage CONTAINS[c] "AppleIntelHD5000") OR (eventMessage CONTAINS[c] "Azul") OR (eventMessage CONTAINS[c] "IOGPU") OR (eventMessage CONTAINS[c] "GPUCompiler")' > "$DRIVER_LOG" 2>/dev/null || true

"$PYTHON" - "$SERVICE" "$OSVC" "$NSVC" "$METAL" "$OMETAL" "$NMETAL" "$MTL32023" "$O32" "$N32" "$MTL3802" "$O38" "$N38" "$FIXED_JSON" "$CURRENT_JSON" "$UUID_32023" "$UUID_3802" "$JSON_REPORT" <<'PY'
from __future__ import annotations
import bisect,collections,hashlib,json,re,struct,sys
from pathlib import Path

(svc,osvc,nsvc,metal,ometal,nmetal,p32,o32,n32,p38,o38,n38,fixedj,currentj)=map(Path,sys.argv[1:15])
u32=sys.argv[15].upper(); u38=sys.argv[16].upper(); jout=Path(sys.argv[17])

def out(s=''): print(s,flush=True)
def parse_dis(path):
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); a=[]
    for ln in path.read_text(errors='replace').splitlines():
        m=rx.match(ln)
        if not m: continue
        try:x=int(m.group(1),16)
        except: continue
        t=m.group(2).strip()
        if t and not t.endswith(':'): a.append((x,t))
    return sorted(a)
def parse_syms(path):
    a=[]
    if not path.exists(): return a
    for ln in path.read_text(errors='replace').splitlines():
        m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',ln)
        if not m: continue
        try:x=int(m.group(1),16)
        except: continue
        a.append((x,m.group(2).strip()))
    return sorted(a)
def macho(path):
    d=path.read_bytes()
    if len(d)<32 or struct.unpack_from('<I',d,0)[0]!=0xFEEDFACF: raise SystemExit('MACHO64_REQUIRED:'+str(path))
    n=struct.unpack_from('<I',d,16)[0]; p=32; text=None; uuid=None
    for _ in range(n):
        cmd,sz=struct.unpack_from('<II',d,p)
        if cmd==0x19 and sz>=72:
            nm=d[p+8:p+24].split(b'\0',1)[0].decode('ascii','replace'); vm,vs,fo,fs=struct.unpack_from('<QQQQ',d,p+24)
            if nm=='__TEXT': text=(vm,vs,fo,fs)
        elif cmd==0x1B and sz>=24:
            u=d[p+8:p+24]; uuid=f'{u[:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
        p+=sz
    if not text: raise SystemExit('TEXT_MISSING:'+str(path))
    return d,text,uuid
def owner(addr,syms):
    starts=[x[0] for x in syms]; i=bisect.bisect_right(starts,addr)-1
    return syms[i] if i>=0 else (None,'UNKNOWN')
def symbol_range(name,syms):
    for i,(a,n) in enumerate(syms):
        if n==name: return a,(syms[i+1][0] if i+1<len(syms) else 1<<64)
    return None,None

def splitops(t):
    q=t.split('##',1)[0].strip(); p=q.split(None,1)
    if not p:return '',[]
    return p[0],[x.strip() for x in p[1].split(',')] if len(p)>1 else []
def destreg(t):
    op,ops=splitops(t)
    if not ops or op.startswith(('cmp','test','call','j','ret','push')): return None
    m=re.fullmatch(r'%([A-Za-z0-9]+)',ops[-1]); return m.group(1).lower() if m else None

def literal_from_text(t):
    m=re.search(r'literal pool for:\s*"([^"]*)"',t)
    return m.group(1) if m else None

def trace_reg_before(dis,idx,reg,maxins=48):
    fam={
      'rsi':{'rsi','esi','si','sil'},'rdx':{'rdx','edx','dx','dl'},'rdi':{'rdi','edi','di','dil'},'rcx':{'rcx','ecx','cx','cl'},
      'rax':{'rax','eax','ax','al'},'rbx':{'rbx','ebx','bx','bl'},'r8':{'r8','r8d','r8w','r8b'},'r9':{'r9','r9d','r9w','r9b'},
      'r10':{'r10','r10d','r10w','r10b'},'r11':{'r11','r11d','r11w','r11b'},'r12':{'r12','r12d','r12w','r12b'},
      'r13':{'r13','r13d','r13w','r13b'},'r14':{'r14','r14d','r14w','r14b'},'r15':{'r15','r15d','r15w','r15b'} }
    def canon(x):
        x=x.lower().lstrip('%')
        for k,v in fam.items():
            if x in v:return k
        return x
    cur=canon(reg); tr=[]
    for j in range(idx-1,max(-1,idx-maxins-1),-1):
        a,t=dis[j]
        if t.lstrip().startswith('call'): return tr,('STOP_CALL',f'0x{a:X}',t,cur)
        if canon(destreg(t) or '')!=cur: continue
        lit=literal_from_text(t)
        tr.append((a,cur,t))
        if lit is not None:return tr,('LITERAL',lit)
        op,ops=splitops(t); src=ops[0] if len(ops)>=2 else None
        if src is None:return tr,('WRITE_OTHER',t)
        m=re.fullmatch(r'%([A-Za-z0-9]+)',src)
        if m:cur=canon(m.group(1));continue
        if src.startswith('$'):return tr,('IMMEDIATE',src)
        if '(' in src:return tr,('MEMORY',src)
        return tr,('EXPR',src)
    return tr,('UNKNOWN',cur)

def xpc_schema(label,dis,syms):
    rows=[]
    out(f'\n===== {label} XPC DICTIONARY CALL CENSUS =====')
    for i,(a,t) in enumerate(dis):
        m=re.search(r'_(xpc_dictionary_(?:get|set)_[A-Za-z0-9_]+)',t)
        if not m or not t.lstrip().startswith('call'):continue
        api=m.group(1); _,fn=owner(a,syms)
        ktr,kres=trace_reg_before(dis,i,'rsi')
        vtr,vres=trace_reg_before(dis,i,'rdx') if '_set_' in api else ([],('RETURN_REGISTER',api))
        key=kres[1] if kres and kres[0]=='LITERAL' else None
        row={'vm':a,'api':api,'function':fn,'key':key,'key_trace_result':kres,'value_trace_result':vres}
        rows.append(row)
        out(f'XPC_CALL|SIDE={label}|VM=0x{a:X}|FUNCTION={fn}|API={api}|KEY={key if key is not None else "UNKNOWN"}|KEY_SOURCE={kres}|VALUE_SOURCE={vres}')
        for aa,rr,tt in ktr:out(f'XPC_KEY_TRACE|SIDE={label}|CALL=0x{a:X}|VM=0x{aa:X}|REG={rr}|TEXT={tt}')
        if '_set_' in api:
            for aa,rr,tt in vtr:out(f'XPC_VALUE_TRACE|SIDE={label}|CALL=0x{a:X}|VM=0x{aa:X}|REG={rr}|TEXT={tt}')
    out(f'XPC_CALL_COUNT|SIDE={label}|COUNT={len(rows)}')
    known=collections.Counter((r['key'],r['api']) for r in rows if r['key'])
    for (k,a),n in sorted(known.items()):out(f'XPC_SCHEMA_KEY|SIDE={label}|KEY={k}|API={a}|COUNT={n}')
    return rows

def decode_json_stream(path):
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
def v(r,*ks):
    for k in ks:
        if k in r and r[k] is not None:return r[k]
    return None
def rpid(r):
    try:return int(v(r,'processID','processIdentifier'))
    except:return -1

def runtime_summary(name,path):
    rec=decode_json_stream(path); rows=[]
    for r in rec:
        uu=str(v(r,'senderImageUUID') or '').upper(); gen='32023' if uu==u32 else ('3802' if uu==u38 else 'OTHER')
        pc=v(r,'senderProgramCounter')
        try:pc=int(pc,0) if isinstance(pc,str) else int(pc)
        except:pc=-1
        rows.append({'timestamp':str(v(r,'timestamp') or ''),'pid':rpid(r),'gen':gen,'uuid':uu,'path':str(v(r,'senderImagePath') or ''),'pc':pc,'msg':str(v(r,'eventMessage','message') or '').replace('\n','\\n')})
    out(f'\n===== RUNTIME {name} =====')
    out(f'RUNTIME_RECORD_COUNT|WINDOW={name}|COUNT={len(rows)}')
    gc=collections.Counter(x['gen'] for x in rows); out('RUNTIME_GENERATION_COUNTS|WINDOW='+name+'|'+';'.join(f'{k}:{gc[k]}' for k in sorted(gc)))
    exact=[x for x in rows if x['gen'] in ('32023','3802')]
    bypc=collections.Counter((x['gen'],x['pc']) for x in exact)
    for (g,pc),n in sorted(bypc.items()):out(f'RUNTIME_PC|WINDOW={name}|GEN={g}|PC=0x{pc:X}|COUNT={n}')
    bypid=collections.defaultdict(list)
    for x in exact:bypid[x['pid']].append(x)
    for p in sorted(bypid):
        rr=sorted(bypid[p],key=lambda x:x['timestamp']); gs=sorted(set(x['gen'] for x in rr)); pcs=collections.Counter((x['gen'],x['pc']) for x in rr)
        out(f'RUNTIME_PID|WINDOW={name}|PID={p}|GENERATIONS={",".join(gs)}|COUNT={len(rr)}|PCS='+';'.join(f'{g}:0x{pc:X}:{n}' for (g,pc),n in sorted(pcs.items())))
    # message prototypes by generation/PC; preserve first exact text only, no semantic guess
    proto={}
    for x in exact: proto.setdefault((x['gen'],x['pc']),x['msg'])
    for (g,pc),msg in sorted(proto.items()):out(f'RUNTIME_MESSAGE_PROTOTYPE|WINDOW={name}|GEN={g}|PC=0x{pc:X}|TEXT={msg[:1200]}')
    return {'records':len(rows),'generation_counts':dict(gc),'pc_counts':{f'{g}:0x{pc:X}':n for (g,pc),n in bypc.items()},'pid_count':len(bypid)}

sd,st,su=macho(svc); md,mt,mu=macho(metal); d32,t32,u32file=macho(p32); d38,t38,u38file=macho(p38)
DS=parse_dis(osvc); SS=parse_syms(nsvc); DM=parse_dis(ometal); SM=parse_syms(nmetal); D32=parse_dis(o32); S32=parse_syms(n32); D38=parse_dis(o38); S38=parse_syms(n38)
out(f'SERVICE_UUID={su}|SERVICE_IMAGE_BASE=0x{st[0]:X}|SERVICE_BYTES={len(sd)}')
out(f'METAL_UUID={mu}|METAL_IMAGE_BASE=0x{mt[0]:X}|METAL_DISASM_INSTRUCTIONS={len(DM)}')
out(f'MTL32023_UUID={u32file}|MTL32023_IMAGE_BASE=0x{t32[0]:X}|MTL32023_DISASM_INSTRUCTIONS={len(D32)}')
out(f'MTL3802_UUID={u38file}|MTL3802_IMAGE_BASE=0x{t38[0]:X}|MTL3802_DISASM_INSTRUCTIONS={len(D38)}')

receiver=xpc_schema('MTLCOMPILERSERVICE',DS,SS)
sender=xpc_schema('METAL_VISIBLE_OR_SHARED_CACHE_AWARE',DM,SM) if DM else []

out('\n===== XPC SENDER/RECEIVER VOCABULARY INTERSECTION =====')
rget={r['key'] for r in receiver if r['key'] and '_get_' in r['api']}
sset={r['key'] for r in sender if r['key'] and '_set_' in r['api']}
for k in sorted(rget|sset):out(f'XPC_KEY_INTERSECTION|KEY={k}|METAL_SET={"YES" if k in sset else "NO"}|SERVICE_GET={"YES" if k in rget else "NO"}')
out(f'XPC_KNOWN_METAL_SET_KEY_COUNT={len(sset)}')
out(f'XPC_KNOWN_SERVICE_GET_KEY_COUNT={len(rget)}')
out(f'XPC_KNOWN_INTERSECTION_COUNT={len(sset&rget)}')

fixed=runtime_summary('D97AU_FIXED_BOOT3M',fixedj)
current=runtime_summary('CURRENT_GOLDEN_BOOT',currentj)

out('\n===== MTLCompiler 32023 DONOR FUNCTION + REQUEST MEMORY ACCESS CENSUS =====')
targets=['getReadParametersFromRequest','upgradeAIRModule','buildSpecializedFunctionRequest','backendCompileExecutableRequest','backendCompileModule','invokeLowerModule','runFrameworkPasses','validSimulatorMetadata','buildRequestWithOptions','getSerializedModule']
donor={}
for sub in targets:
    cs=[(a,n) for a,n in S32 if sub in n]
    out(f'DONOR_FUNCTION_CANDIDATES|SUB={sub}|COUNT={len(cs)}')
    donor[sub]=[]
    for a,n in cs:
        sa,se=symbol_range(n,S32); ins=[(x,t) for x,t in D32 if sa is not None and sa<=x<se]
        mem=collections.Counter()
        for x,t in ins:
            for m in re.finditer(r'(-?0x[0-9A-Fa-f]+)\(%([A-Za-z0-9]+)\)',t):
                mem[(m.group(2).lower(),m.group(1).lower())]+=1
        top=sorted(mem.items(),key=lambda kv:(-kv[1],kv[0]))[:120]
        donor[sub].append({'vm':a,'symbol':n,'instruction_count':len(ins),'memory_operands':[(f'%{r}',o,c) for (r,o),c in top]})
        out(f'DONOR_FUNCTION|SUB={sub}|VM=0x{a:X}|OFFSET=0x{a-t32[0]:X}|INSTRUCTIONS={len(ins)}|SYMBOL={n}')
        for (r,o),c in top:out(f'DONOR_MEMORY_ACCESS|FUNCTION={sub}|BASE=%{r}|DISP={o}|COUNT={c}')

# conservative direct call graph restricted to target functions
name_by_sub={}
for sub in targets:
    cs=[n for a,n in S32 if sub in n]
    if len(cs)==1:name_by_sub[sub]=cs[0]
edges=collections.defaultdict(set)
for a,t in D32:
    if not t.lstrip().startswith('call'):continue
    m=re.search(r'callq?\s+0x([0-9A-Fa-f]+)',t)
    if not m:continue
    tgt=int(m.group(1),16); _,src=owner(a,S32); _,dst=owner(tgt,S32)
    if src!='UNKNOWN' and dst!='UNKNOWN':edges[src].add(dst)
out('\n===== TARGETED DONOR DIRECT CALLGRAPH =====')
keyset=set(name_by_sub.values())
for src in sorted(edges):
    for dst in sorted(edges[src]):
        if src in keyset or dst in keyset:out(f'DONOR_DIRECT_CALL_EDGE|SRC={src}|DST={dst}')

result={'service_schema':receiver,'metal_schema':sender,'known_sender_keys':sorted(sset),'known_receiver_keys':sorted(rget),'known_intersection':sorted(sset&rget),'runtime_fixed':fixed,'runtime_current':current,'donor':donor,'identities':{'service_uuid':su,'metal_uuid':mu,'mtl32023_uuid':u32file,'mtl3802_uuid':u38file}}
jout.write_text(json.dumps(result,indent=2,default=str),encoding='utf-8')
out('\nD97AX_CORE_CONTRACT_CENSUS=COMPLETE')
PY

echo
echo "===== GOLDEN GRAPHICS / HASWELL DRIVER IDENTITY + LOAD STATE ====="
/usr/bin/system_profiler SPDisplaysDataType 2>&1 || true
if [[ -x /usr/bin/kmutil ]]; then
  /usr/bin/kmutil showloaded 2>&1 | /usr/bin/grep -Ei 'HD5000|Azul|Intel.*Graphics|IOGPU' || true
fi
for B in \
  "/System/Library/Extensions/AppleIntelHD5000Graphics.kext/Contents/MacOS/AppleIntelHD5000Graphics" \
  "/System/Library/Extensions/AppleIntelFramebufferAzul.kext/Contents/MacOS/AppleIntelFramebufferAzul"; do
  if [[ -f "$B" ]]; then
    echo "DRIVER_BINARY=$B"
    echo "DRIVER_SHA256=$(/usr/bin/shasum -a 256 "$B" | /usr/bin/awk '{print $1}')"
    /usr/bin/otool -L "$B" 2>&1 | /usr/bin/head -n 80 || true
  fi
done
/usr/bin/find /System/Library/Extensions/AppleIntelHD5000Graphics.kext -maxdepth 8 -type f \( -name '*MTLDriver*' -o -name '*Graphics*' \) -print 2>/dev/null | while IFS= read -r B; do
  [[ -f "$B" ]] || continue
  F="$(/usr/bin/file "$B" 2>/dev/null || true)"
  [[ "$F" == *Mach-O* ]] || continue
  echo "HASWELL_PLUGIN_BINARY=$B"
  echo "HASWELL_PLUGIN_SHA256=$(/usr/bin/shasum -a 256 "$B" | /usr/bin/awk '{print $1}')"
done

echo
echo "===== CURRENT-BOOT DRIVER/WINDOWSERVER OBSERVATION PROTOTYPES ====="
echo "DRIVER_LOG_LINE_COUNT=$(/usr/bin/wc -l < "$DRIVER_LOG" | /usr/bin/tr -d ' ')"
/usr/bin/grep -Ei 'MTLCompiler|GPUCompiler|AppleIntelHD5000|Azul|IOGPU|pipeline|Metal' "$DRIVER_LOG" 2>/dev/null | /usr/bin/head -n 400 || true

echo
echo "===== NON-PERSISTENT OBSERVATION CAPABILITY INVENTORY ====="
XCTRACE="$(/usr/bin/xcrun --find xctrace 2>/dev/null || true)"
echo "XCTRACE=${XCTRACE:-MISSING}"
if [[ -n "$XCTRACE" && -x "$XCTRACE" ]]; then
  "$XCTRACE" list templates 2>&1 | /usr/bin/head -n 250 || true
fi
DTRACE="$(command -v dtrace 2>/dev/null || true)"
echo "DTRACE=${DTRACE:-MISSING}"
if [[ -n "$DTRACE" && -x "$DTRACE" ]]; then
  "$DTRACE" -l 2>&1 | /usr/bin/grep -Ei 'xpc|metal|gpu' | /usr/bin/head -n 250 || true
fi
KTRACE="$(command -v ktrace 2>/dev/null || true)"
echo "KTRACE=${KTRACE:-MISSING}"
if [[ -n "$KTRACE" ]]; then "$KTRACE" --help 2>&1 | /usr/bin/head -n 120 || true; fi

echo
echo "===== CONTRACT-BOOK CLASSIFICATION ====="
echo "ORIGINAL_OCLP_DONOR_MUTATION=NO"
echo "G1_XPC_SCHEMA=STATIC_CENSUS_ATTEMPTED"
echo "G1_RUNTIME_LANES=RUNTIME_OBSERVED_FIXED_AND_CURRENT_BOOT"
echo "G1_RAW_RUNTIME_VALUES=ONLY_WHERE_DIRECTLY_EXPOSED_OTHERWISE_UNKNOWN"
echo "G2_DONOR_REQUEST_MEMORY_SCHEMA=STATIC_CENSUS_ATTEMPTED"
echo "G3_HASWELL_DRIVER_IDENTITY_LOAD_STATE=OBSERVED"
echo "G3_METAL_SYSTEM_TRACE_CAPABILITY=INVENTORIED_NOT_RECORDED"
echo "D97AX_AUDIT=COMPLETE"
echo "REPORT=$REPORT"
echo "JSON_REPORT=$JSON_REPORT"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
