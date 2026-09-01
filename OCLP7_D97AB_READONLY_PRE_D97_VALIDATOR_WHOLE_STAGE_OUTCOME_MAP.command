#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP_REPORT.txt"
PRODUCT_EXPECTED="26.6.2"
BUILD_EXPECTED="25G82"
MTL="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
D97_SHA="c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118"
P7_SHA="6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda"
D97_SITE=$((0x9D6BD))
D97_SITE_PATCH="e9be38f6ff90"
D97_SITE_PRE="8b8d10feffff"
D97_CAVE=$((0xF80))
D97_CAVE_LEN=33
FUNC_START_EXPECTED="0x7FFB162C7132"
FUNC_END_EXPECTED="0x7FFB162C7830"
CANDIDATE_REL=$((0x58B))
XREF1_REL=$((0x29A))
XREF2_REL=$((0x2D9))
XREF3_REL=$((0x3E2))
EXIT_CANDIDATE=110
EXIT_BUFFER_INDEX=111
EXIT_SAMPLER_INDEX=112
EXIT_NESTED_ARG_BUFFER=113
EXIT_OTHER_EARLY=114

exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AB_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AB — READ-ONLY PRE-D97 VALIDATOR WHOLE-STAGE OUTCOME MAP ====="
echo "PURPOSE=map_every_reachable_outcome_from_validSimulatorMetadata_entry_to_D97_REL+0x58B_after_D97AA_proved_runtime_llvmVersion_32023"
echo "INPUT_D97AA=12_of_12_observed_primary_MTLCompilerService_requests_exit124_equal_llvmVersion_32023"
echo "CURRENT_D97_MTL_SHA=$D97_SHA"
echo "RECONSTRUCTED_P7_SHA=$P7_SHA"
echo "FUNCTION=MTLSimCompiler::validSimulatorMetadata(llvm::Module*)"
echo "FUNCTION_START_EXPECTED=$FUNC_START_EXPECTED"
echo "FUNCTION_END_EXPECTED=$FUNC_END_EXPECTED"
echo "D97_CANDIDATE_REL=0x58B"
echo "KNOWN_EARLY_ERROR_XREFS=REL+0x29A_buffer_index;REL+0x2D9_sampler_index;REL+0x3E2_nested_argument_buffer_pointer"
echo "PLANNED_EXIT_CODES=110_candidate_reached;111_buffer_index;112_sampler_index;113_nested_arg_buffer;114_other_early"
echo "DESIGN_TRANSPORT=push_imm8_pop_rdi_jmp_rel32_to_shared_Darwin_exit_stub"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"

PRODUCT="$(sw_vers -productVersion 2>/dev/null || true)"
BUILD="$(sw_vers -buildVersion 2>/dev/null || true)"
PY="$(command -v python3 2>/dev/null || true)"
echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "PYTHON_EXEC=${PY:-MISSING}"
[[ "$PRODUCT" == "$PRODUCT_EXPECTED" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "$BUILD_EXPECTED" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PY" && -x "$PY" ]] || fail "PYTHON3_MISSING"
[[ -f "$MTL" ]] || fail "MTL_MISSING:$MTL"
for t in otool nm shasum; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
"$PY" --version 2>&1
VISIBLE_SHA="$(/usr/bin/shasum -a 256 "$MTL" | /usr/bin/awk '{print $1}')"
echo "VISIBLE_MTL_SHA=$VISIBLE_SHA"
[[ "$VISIBLE_SHA" == "$D97_SHA" ]] || fail "VISIBLE_MTL_NOT_D97:$VISIBLE_SHA"
echo "PRECHECK=PASS"

"$PY" - "$MTL" "$D97_SHA" "$P7_SHA" "$D97_SITE" "$D97_SITE_PATCH" "$D97_SITE_PRE" "$D97_CAVE" "$D97_CAVE_LEN" "$FUNC_START_EXPECTED" "$FUNC_END_EXPECTED" "$CANDIDATE_REL" "$XREF1_REL" "$XREF2_REL" "$XREF3_REL" "$EXIT_CANDIDATE" "$EXIT_BUFFER_INDEX" "$EXIT_SAMPLER_INDEX" "$EXIT_NESTED_ARG_BUFFER" "$EXIT_OTHER_EARLY" <<'PY'
from pathlib import Path
import collections, hashlib, os, re, struct, subprocess, sys, tempfile

(src,d97sha,p7sha,site_s,site_patch_hex,site_pre_hex,cave_s,cave_len_s,
 fstart_s,fend_s,cand_rel_s,x1_s,x2_s,x3_s,ec_s,e1_s,e2_s,e3_s,eo_s)=sys.argv[1:]
src=Path(src); site=int(site_s,0); cave=int(cave_s,0); cave_len=int(cave_len_s,0)
fstart_expected=int(fstart_s,0); fend_expected=int(fend_s,0)
cand_rel=int(cand_rel_s,0); xrels=[int(x1_s,0),int(x2_s,0),int(x3_s,0)]
codes=[int(ec_s),int(e1_s),int(e2_s),int(e3_s),int(eo_s)]
site_patch=bytes.fromhex(site_patch_hex); site_pre=bytes.fromhex(site_pre_hex)

def sha(b): return hashlib.sha256(bytes(b)).hexdigest()
def run(cmd,timeout=180):
    try:
        p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=timeout)
        return p.returncode,p.stdout
    except Exception as e:
        return -999,'TOOL_ERROR:'+repr(e)
def u32(b,o=0): return struct.unpack_from('<I',b,o)[0]
def u64(b,o=0): return struct.unpack_from('<Q',b,o)[0]

data=bytearray(src.read_bytes())
print('\n===== EXACT D97 -> P7 RECONSTRUCTION =====')
print('CURRENT_D97_SHA='+sha(data))
print('CURRENT_D97_SITE='+bytes(data[site:site+len(site_patch)]).hex())
print('CURRENT_D97_CAVE='+bytes(data[cave:cave+cave_len]).hex())
if sha(data)!=d97sha: raise SystemExit('D97_SHA_FAIL')
if bytes(data[site:site+len(site_patch)])!=site_patch: raise SystemExit('D97_SITE_PATCH_IDENTITY_FAIL')
data[site:site+len(site_pre)]=site_pre
data[cave:cave+cave_len]=b'\0'*cave_len
print('RECONSTRUCTED_P7_SHA='+sha(data))
print('RECONSTRUCTED_P7_SITE='+bytes(data[site:site+len(site_pre)]).hex())
print('RECONSTRUCTED_P7_CAVE='+bytes(data[cave:cave+cave_len]).hex())
if sha(data)!=p7sha: raise SystemExit('P7_RECONSTRUCTION_SHA_FAIL:'+sha(data))
print('D97_TO_P7_RECONSTRUCTION=PASS')

fd,tmpname=tempfile.mkstemp(prefix='OCLP7_D97AB_P7_',suffix='.MTLCompiler',dir='/private/tmp')
os.close(fd); tmp=Path(tmpname); tmp.write_bytes(data); tmp.chmod(0o755)
try:
    rc,nm=run(['/usr/bin/nm','-nm',str(tmp)])
    print('\n===== FUNCTION / MACH-O IDENTITY =====')
    print('NM_RC='+str(rc))
    if rc!=0: raise SystemExit('NM_FAIL')
    syms=[]
    for ln in nm.splitlines():
        m=re.match(r'^([0-9A-Fa-f]{8,16})\s+.*?\s(.*)$',ln.strip())
        if m:
            try: syms.append((int(m.group(1),16),ln.strip(),m.group(2)))
            except: pass
    hits=[x for x in syms if 'validSimulatorMetadata' in x[1]]
    print('VALIDATOR_SYMBOL_HIT_COUNT='+str(len(hits)))
    for x in hits: print('VALIDATOR_SYMBOL_HIT='+x[1])
    if len(hits)!=1: raise SystemExit('VALIDATOR_SYMBOL_CARDINALITY_FAIL')
    fstart=hits[0][0]
    later=sorted(a for a,_,_ in syms if a>fstart)
    fend=later[0] if later else fend_expected
    print(f'VALIDATOR_START=0x{fstart:X}')
    print(f'VALIDATOR_END=0x{fend:X}')
    if fstart!=fstart_expected or fend!=fend_expected:
        raise SystemExit(f'VALIDATOR_RANGE_MISMATCH:0x{fstart:X}..0x{fend:X}')

    # Mach-O __TEXT mapping for VM/file conversion and cave membership.
    if u32(data,0)!=0xFEEDFACF: raise SystemExit('MACHO64_LE_FAIL')
    ncmds=u32(data,16); off=32; text=None; sections=[]
    for _ in range(ncmds):
        cmd=u32(data,off); cmdsize=u32(data,off+4)
        if cmdsize<8 or off+cmdsize>len(data): raise SystemExit('LOAD_COMMAND_INVALID')
        if cmd==0x19:
            seg=bytes(data[off+8:off+24]).split(b'\0',1)[0].decode('ascii','replace')
            vm=u64(data,off+24); vs=u64(data,off+32); fo=u64(data,off+40); fs=u64(data,off+48); ns=u32(data,off+64)
            if seg=='__TEXT': text=(vm,vs,fo,fs)
            so=off+72
            for i in range(ns):
                q=so+i*80
                sn=bytes(data[q:q+16]).split(b'\0',1)[0].decode('ascii','replace')
                sg=bytes(data[q+16:q+32]).split(b'\0',1)[0].decode('ascii','replace')
                a=u64(data,q+32); z=u64(data,q+40); f=u32(data,q+48); fl=u32(data,q+64)
                sections.append((sg,sn,a,z,f,fl))
        off+=cmdsize
    if text is None: raise SystemExit('TEXT_SEGMENT_MISSING')
    tvm,tvs,tfo,tfs=text
    def off_to_vm(x): return tvm+(x-tfo)
    print(f'TEXT_SEGMENT=VM=0x{tvm:X}..0x{tvm+tvs:X}|FILE=0x{tfo:X}..0x{tfo+tfs:X}')
    containing=[s for s in sections if s[4]<=cave<s[4]+s[3]]
    print('D97_CAVE_SECTION_COUNT='+str(len(containing)))
    for s in containing: print(f'D97_CAVE_SECTION={s[0]},{s[1]}|VM=0x{s[2]:X}|FILE=0x{s[4]:X}|SIZE=0x{s[3]:X}|FLAGS=0x{s[5]:X}')

    rc,dis=run(['/usr/bin/otool','-tvV',str(tmp)])
    print('OTOOL_RC='+str(rc))
    if rc!=0: raise SystemExit('OTOOL_FAIL')
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
    inst=[]
    for ln in dis.splitlines():
        m=rx.match(ln)
        if m:
            try:
                a=int(m.group(1),16)
                if fstart<=a<fend: inst.append((a,m.group(2)))
            except: pass
    inst.sort(); addrs=[a for a,_ in inst]; by=dict(inst)
    print('VALIDATOR_INSTRUCTION_COUNT='+str(len(inst)))
    if not inst or inst[0][0]!=fstart: raise SystemExit('DISASM_FUNCTION_START_FAIL')

    candidate=fstart+cand_rel
    xaddrs=[fstart+r for r in xrels]
    required=[candidate]+xaddrs
    print(f'CANDIDATE_VM=0x{candidate:X}|INSN={by.get(candidate,"MISSING")}')
    labels=['BUFFER_INDEX','SAMPLER_INDEX','NESTED_ARG_BUFFER']
    for lab,a in zip(labels,xaddrs): print(f'EARLY_XREF_{lab}=VM=0x{a:X}|INSN={by.get(a,"MISSING")}')
    miss=[hex(a) for a in required if a not in by]
    print('REQUIRED_ANCHOR_MISSING='+repr(miss))
    if miss: raise SystemExit('ANCHOR_MISSING')

    # Direct branch/call and RIP-relative target inventory.
    direct=[]; rip=[]
    cond_prefixes=('ja','jae','jb','jbe','jc','je','jg','jge','jl','jle','jna','jnae','jnb','jnbe','jnc','jne','jng','jnge','jnl','jnle','jno','jnp','jns','jnz','jo','jp','jpe','jpo','js','jz')
    for i,(a,t) in enumerate(inst):
        s=t.strip()
        m=re.match(r'^(j[a-z]+|callq?)\s+(0x[0-9A-Fa-f]+)\b',s)
        if m:
            try: direct.append((int(m.group(2),16),a,s,m.group(1)))
            except: pass
        nxt=inst[i+1][0] if i+1<len(inst) else fend
        for mm in re.finditer(r'(-?0x[0-9A-Fa-f]+)\(%rip\)',s):
            q=mm.group(1); d=-int(q[3:],16) if q.startswith('-0x') else int(q,16)
            rip.append((nxt+d,a,s))
    print('DIRECT_BRANCH_CALL_TARGET_COUNT='+str(len(direct)))
    print('RIP_RELATIVE_TARGET_COUNT='+str(len(rip)))

    # Resolve the one switch proven by D97J.
    ijmp=fstart+0x279
    expected_switch=[fstart+x for x in (0x27B,0x281,0x36F,0x2B2,0x2CE,0x36F,0x2FF)]
    print(f'INDIRECT_JUMP_VM=0x{ijmp:X}|INSN={by.get(ijmp,"MISSING")}')
    if by.get(ijmp,'').strip() not in ('jmpq\t*%rax','jmpq *%rax','jmp\t*%rax','jmp *%rax'):
        raise SystemExit('INDIRECT_JUMP_IDENTITY_FAIL:'+by.get(ijmp,'MISSING'))
    print('INDIRECT_SWITCH_TARGETS='+','.join(f'0x{x:X}' for x in expected_switch))
    if any(x not in by for x in set(expected_switch)): raise SystemExit('INDIRECT_SWITCH_TARGET_NOT_INSN')

    # Basic block leaders.
    addr_index={a:i for i,a in enumerate(addrs)}
    leaders={fstart,candidate,*expected_switch}
    branch_re=re.compile(r'^(j[a-z]+)\s+(0x[0-9A-Fa-f]+)\b')
    for i,(a,t) in enumerate(inst):
        s=t.strip(); m=branch_re.match(s)
        if m:
            target=int(m.group(2),16)
            if fstart<=target<fend: leaders.add(target)
            if i+1<len(inst): leaders.add(inst[i+1][0])
        elif re.match(r'^jmpq?\s+\*',s):
            if i+1<len(inst): leaders.add(inst[i+1][0])
        elif s.startswith(('ret','ud2','int3','hlt')):
            if i+1<len(inst): leaders.add(inst[i+1][0])
    leaders=sorted(x for x in leaders if x in by)
    blocks=[]; block_for={}
    for i,l in enumerate(leaders):
        r=leaders[i+1] if i+1<len(leaders) else fend
        ins=[(a,by[a]) for a in addrs if l<=a<r]
        if not ins: continue
        bi=len(blocks); blocks.append((l,r,ins))
        for a,_ in ins: block_for[a]=bi
    print('BASIC_BLOCK_COUNT='+str(len(blocks)))

    def is_cond(mn):
        return mn.startswith('j') and mn not in ('jmp','jmpq')
    edges={i:set() for i in range(len(blocks))}; outside=[]
    for i,(l,r,ins) in enumerate(blocks):
        a,t=ins[-1]; s=t.strip(); mn=s.split()[0] if s.split() else ''
        nextb=i+1 if i+1<len(blocks) else None
        m=branch_re.match(s)
        if a==ijmp:
            for x in set(expected_switch): edges[i].add(block_for[x])
        elif m:
            target=int(m.group(2),16)
            if fstart<=target<fend and target in block_for: edges[i].add(block_for[target])
            else: outside.append((i,target,s))
            if is_cond(m.group(1)) and nextb is not None: edges[i].add(nextb)
        elif mn in ('jmp','jmpq'):
            # unresolved indirect other than the proven switch
            outside.append((i,None,s))
        elif s.startswith(('ret','ud2','int3','hlt')):
            pass
        elif nextb is not None:
            edges[i].add(nextb)

    entry=block_for[fstart]; cand_b=block_for[candidate]; marker_bs=[block_for[a] for a in xaddrs]
    print(f'ENTRY_BLOCK=B{entry}|REL=0x{blocks[entry][0]-fstart:X}')
    print(f'CANDIDATE_BLOCK=B{cand_b}|REL=0x{blocks[cand_b][0]-fstart:X}')
    for lab,b in zip(labels,marker_bs): print(f'EARLY_XREF_BLOCK_{lab}=B{b}|REL=0x{blocks[b][0]-fstart:X}')

    def reach(stop):
        seen=set(); q=collections.deque([entry])
        while q:
            b=q.popleft()
            if b in seen: continue
            seen.add(b)
            if b in stop: continue
            for n in edges[b]:
                if n not in seen: q.append(n)
        return seen
    reachable=reach(set())
    print('REACHABLE_BLOCK_COUNT='+str(len(reachable)))
    print('CANDIDATE_REACHABLE=' + ('YES' if cand_b in reachable else 'NO'))
    for lab,b in zip(labels,marker_bs): print(f'EARLY_XREF_REACHABLE_{lab}=' + ('YES' if b in reachable else 'NO'))
    if cand_b not in reachable: raise SystemExit('CANDIDATE_NOT_REACHABLE_STATIC_CFG')

    # Partition all entry paths by treating candidate and the three known early outcomes as terminals.
    stop={cand_b,*marker_bs}
    partition_reach=reach(stop)
    residual_terms=[]
    for b in sorted(partition_reach):
        if b in stop: continue
        outs=[n for n in edges[b] if n in partition_reach and n not in stop]
        to_stop=[n for n in edges[b] if n in stop]
        if not outs and not to_stop:
            residual_terms.append(b)
    # Cycle detection in residual graph after stopping at known markers.
    residual_nodes=set(partition_reach)-stop
    color={b:0 for b in residual_nodes}; cycles=[]
    def dfs(b,stack):
        color[b]=1; stack.append(b)
        for n in edges[b]:
            if n not in residual_nodes: continue
            if color[n]==0: dfs(n,stack)
            elif color[n]==1:
                try: cycles.append(stack[stack.index(n):]+[n])
                except ValueError: cycles.append([b,n])
        stack.pop(); color[b]=2
    for b in sorted(residual_nodes):
        if color[b]==0: dfs(b,[])
    # Deduplicate cycle signatures.
    cyc_unique=[]; seen_c=set()
    for c in cycles:
        sig=tuple(sorted(set(c)))
        if sig not in seen_c: seen_c.add(sig); cyc_unique.append(c)

    print('\n===== WHOLE-STAGE OUTCOME PARTITION =====')
    print('KNOWN_TERMINAL_MARKER_COUNT=4')
    print('KNOWN_TERMINAL_MARKERS=CANDIDATE_REL_0x58B,BUFFER_INDEX_REL_0x29A,SAMPLER_INDEX_REL_0x2D9,NESTED_ARG_BUFFER_REL_0x3E2')
    print('RESIDUAL_OTHER_EARLY_TERMINAL_BLOCK_COUNT='+str(len(residual_terms)))
    for j,b in enumerate(residual_terms,1):
        l,r,ins=blocks[b]
        print(f'RESIDUAL_TERMINAL_{j}=B{b}|REL=0x{l-fstart:X}..0x{r-fstart:X}|LAST={ins[-1][1]}')
        for a,t in ins[-8:]: print(f'RESIDUAL_TERMINAL_{j}_INSN=REL+0x{a-fstart:X}|{t}')
    print('RESIDUAL_CYCLE_COUNT='+str(len(cyc_unique)))
    for j,c in enumerate(cyc_unique,1): print('RESIDUAL_CYCLE_'+str(j)+'='+','.join('B'+str(x) for x in c))
    exhaustive=(len(cyc_unique)==0)
    print('ENTRY_PATH_PARTITION_EXHAUSTIVE_STATIC=' + ('PASS' if exhaustive else 'FAIL'))

    # Patch-window safety for an 8-byte terminal marker trampoline.
    target_inventory=[x[0] for x in direct if fstart<=x[0]<fend]
    rip_inventory=[x[0] for x in rip]
    sym_inventory=[a for a,_,_ in syms]
    def window(start,minlen=8):
        if start not in addr_index: return None,'START_NOT_INSN'
        i=addr_index[start]; total=0; chosen=[]
        while i<len(inst) and inst[i][0]<fend and total<minlen:
            a,t=inst[i]
            nxt=inst[i+1][0] if i+1<len(inst) else fend
            chosen.append((a,t,nxt-a)); total+=nxt-a; i+=1
        if total<minlen: return None,'INSUFFICIENT_BYTES'
        end=start+total
        interior_targets=[x for x in target_inventory if start<x<end]
        interior_rip=[x for x in rip_inventory if start<=x<end]
        interior_syms=[x for x in sym_inventory if start<x<end]
        control=[(a,t) for a,t,_ in chosen if t.strip().startswith(('j','ret','ud2','int3','hlt'))]
        if interior_targets or interior_rip or interior_syms or control:
            return (end,chosen,interior_targets,interior_rip,interior_syms,control),'UNSAFE'
        return (end,chosen,[],[],[],[]),'SAFE'

    # Shared cave audit and common exit stub.
    cave_vm=off_to_vm(cave); cave_end=cave+16; cave_vm_end=off_to_vm(cave_end)
    cave_direct=[x for x in target_inventory if cave_vm<=x<cave_vm_end]
    cave_rip=[x for x in rip_inventory if cave_vm<=x<cave_vm_end]
    cave_syms=[x for x in sym_inventory if cave_vm<=x<cave_vm_end]
    cave_zero=(bytes(data[cave:cave+16])==b'\0'*16)
    print('\n===== SHARED EXIT-STUB CAVE AUDIT =====')
    print(f'SHARED_CAVE_FILE=0x{cave:X}..0x{cave_end:X}|VM=0x{cave_vm:X}..0x{cave_vm_end:X}')
    print('SHARED_CAVE_ZERO16='+('PASS' if cave_zero else 'FAIL'))
    print('SHARED_CAVE_DIRECT_TARGET_COUNT='+str(len(cave_direct)))
    print('SHARED_CAVE_RIP_TARGET_COUNT='+str(len(cave_rip)))
    print('SHARED_CAVE_SYMBOL_COUNT='+str(len(cave_syms)))
    exit_stub=bytes.fromhex('b8010000020f050f0b')
    print('SHARED_EXIT_STUB_HEX='+exit_stub.hex())
    print('SHARED_EXIT_STUB_CONTRACT=EDI_preloaded_exit_code;EAX_Darwin_exit_syscall_0x2000001;syscall;UD2_fallback')
    cave_safe=cave_zero and not cave_direct and not cave_rip and not cave_syms
    print('SHARED_EXIT_STUB_CAVE_SAFETY='+('PASS' if cave_safe else 'FAIL'))

    sites=[('CANDIDATE_REACHED',candidate,codes[0])]
    sites += [(labels[i],xaddrs[i],codes[i+1]) for i in range(3)]
    for j,b in enumerate(residual_terms,1): sites.append((f'OTHER_EARLY_{j}',blocks[b][0],codes[4]))
    print('\n===== TERMINAL OUTCOME PATCH-WINDOW DESIGN MAP =====')
    all_safe=cave_safe and exhaustive
    for name,start,code in sites:
        w,status=window(start,8)
        print(f'OUTCOME_SITE={name}|VM=0x{start:X}|REL=0x{start-fstart:X}|EXIT={code}|WINDOW_STATUS={status}')
        if w is None:
            all_safe=False; continue
        end,chosen,it,ir,isy,ctrl=w
        print(f'OUTCOME_WINDOW={name}|VM=0x{start:X}..0x{end:X}|LEN={end-start}|INTERIOR_TARGETS={len(it)}|RIP_TARGETS={len(ir)}|SYMBOLS={len(isy)}|CONTROL={len(ctrl)}')
        for a,t,z in chosen: print(f'OUTCOME_WINDOW_INSN={name}|REL+0x{a-fstart:X}|LEN={z}|{t}')
        rel=cave_vm-(start+8)
        patch=bytes((0x6A,code,0x5F,0xE9))+struct.pack('<i',rel)
        post=patch+b'\x90'*((end-start)-len(patch))
        print(f'OUTCOME_PATCH={name}|REL32={rel}|PATCH={patch.hex()}|POSTIMAGE={post.hex()}')
        if status!='SAFE': all_safe=False

    print('\n===== CONSERVATIVE CONCLUSION =====')
    print('D97AA_RUNTIME_LLVMVERSION_32023=RETAINED_PROVEN_ALL_12_OBSERVED_REQUESTS')
    print('H4_RUNTIME_SELECTS_3802=REJECTED_FOR_OBSERVED_ACCELERATED_REQUEST_SET')
    print('D97H_ZERO_DOWNSTREAM_D97_SIGILL=NOT_EXPLAINED_BY_3802_SELECTION')
    print('NEXT_CAUSAL_INTERVAL=validSimulatorMetadata_entry_to_REL+0x58B')
    print('D97AB_WHOLE_STAGE_OUTCOME_PARTITION=' + ('STATIC_MAPPED_EXHAUSTIVE' if exhaustive else 'INCOMPLETE'))
    print('D97AB_TERMINAL_CLASSIFIER_DESIGN_SAFETY=' + ('STATIC_PROVEN_FOR_FASTLANE_DESIGN_ONLY' if all_safe else 'NOT_AUTHORIZED'))
    print('D97AB_AUTO_INTEGRATION=NO')
    print('D97AB_ROOT_PATCH_AUTHORIZED=NO_PENDING_ASSISTANT_AUDIT')
    print('D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP=PASS')
finally:
    try: tmp.unlink()
    except Exception: pass
PY

echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"
