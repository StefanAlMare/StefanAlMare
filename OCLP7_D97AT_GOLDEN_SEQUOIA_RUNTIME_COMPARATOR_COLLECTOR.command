#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
KNOWN_GOLDEN_ROOTPATCHED_MTL_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
TAHOE_EXPECTED_THRESHOLDS="65,17,129,15,32,125"
TAHOE_EXPECTED_DISPS="-496,-504,-500,-512,-508,-492"
LIVE_MODE="${GOLDEN_CAPTURE_LIVE:-NO}"
LIVE_ROUNDS="${GOLDEN_CAPTURE_ROUNDS:-4}"
LIVE_TIMEOUT="${GOLDEN_CAPTURE_TIMEOUT:-20}"
OUT="$HOME/Desktop/OCLP7_D97AT_GOLDEN_SEQUOIA_RUNTIME_COMPARATOR_REPORT.txt"
JSON_OUT="$HOME/Desktop/OCLP7_D97AT_GOLDEN_SEQUOIA_RUNTIME_COMPARATOR_DATA.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AT.XXXXXX)"
OTOOL_OUT="$TMP/mtl.otool.txt"
NM_OUT="$TMP/mtl.nm.txt"
META_ENV="$TMP/golden-meta.env"
META_JSON="$TMP/golden-meta.json"
MTL_LOG="$TMP/mtl-log.json"
LAUNCHD_LOG="$TMP/launchd-log.json"
WS_LOG="$TMP/windowserver-log.json"
LLDB_PY="$TMP/golden_lldb.py"

cleanup(){
  local rc=$?
  trap - EXIT
  [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AT.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true
  exit "$rc"
}
trap cleanup EXIT

fail(){
  echo "D97AT_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SYSTEM_FILE_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -x /usr/bin/otool ]] || fail "MISSING_OTOOL"
[[ -x /usr/bin/nm ]] || fail "MISSING_NM"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AT — GOLDEN SEQUOIA RUNTIME COMPARATOR COLLECTOR ====="
echo "EXPECTED_OS_VERSION=$EXPECTED_OS_VERSION"
echo "EXPECTED_OS_BUILD=$EXPECTED_OS_BUILD"
echo "KNOWN_GOLDEN_ROOTPATCHED_MTL_SHA=$KNOWN_GOLDEN_ROOTPATCHED_MTL_SHA"
echo "LIVE_CAPTURE_REQUESTED=$LIVE_MODE"
echo "LIVE_CAPTURE_ROUNDS=$LIVE_ROUNDS"
echo "LIVE_CAPTURE_TIMEOUT_SECONDS=$LIVE_TIMEOUT"
echo "SYSTEM_FILE_MUTATION=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

OS_VERSION="$(/usr/bin/sw_vers -productVersion)"
OS_BUILD="$(/usr/bin/sw_vers -buildVersion)"
PRODUCT_NAME="$(/usr/bin/sw_vers -productName)"
echo "PRODUCT_NAME=$PRODUCT_NAME"
echo "OS_VERSION=$OS_VERSION"
echo "OS_BUILD=$OS_BUILD"
[[ "$OS_VERSION" == "$EXPECTED_OS_VERSION" ]] && echo "GOLDEN_EXPECTED_OS_VERSION=PASS" || echo "GOLDEN_EXPECTED_OS_VERSION=MISMATCH"
[[ "$OS_BUILD" == "$EXPECTED_OS_BUILD" ]] && echo "GOLDEN_EXPECTED_OS_BUILD=PASS" || echo "GOLDEN_EXPECTED_OS_BUILD=MISMATCH"
echo "KERN_BOOTTIME=$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
echo "UNAME=$(/usr/bin/uname -a)"
echo

echo "===== SECURITY / ROOT-PATCH CONTEXT (READ-ONLY) ====="
/usr/bin/csrutil status 2>&1 || true
/usr/bin/csrutil authenticated-root status 2>&1 || true
/usr/sbin/nvram -p 2>/dev/null | /usr/bin/grep -E 'csr-active-config|boot-args' || true
echo

echo "===== GPU / DRIVER CONTEXT ====="
/usr/sbin/system_profiler SPDisplaysDataType 2>&1 || true
/usr/sbin/ioreg -l -w0 -r -c AppleIntelFramebufferAzul 2>&1 || true
/usr/bin/kmutil showloaded 2>&1 | /usr/bin/grep -Ei 'AppleIntel|MTL|Metal|Graphics' || true
echo

echo "===== DISCOVER GOLDEN MTLCOMPILER IMAGES ====="
"$PYTHON" - "$KNOWN_GOLDEN_ROOTPATCHED_MTL_SHA" "$META_ENV" "$META_JSON" <<'PY'
import hashlib, json, os, struct, sys
from pathlib import Path

known=sys.argv[1].lower(); envp=Path(sys.argv[2]); jsonp=Path(sys.argv[3])
root=Path('/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions')
rows=[]

def uuid_of(data):
    if len(data)<32 or struct.unpack_from('<I',data,0)[0]!=0xFEEDFACF: return None
    ncmds=struct.unpack_from('<I',data,16)[0]; pos=32
    for _ in range(ncmds):
        if pos+8>len(data): break
        cmd,sz=struct.unpack_from('<II',data,pos)
        if sz<8 or pos+sz>len(data): break
        if cmd==0x1B and sz>=24:
            u=data[pos+8:pos+24]
            return f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
        pos+=sz
    return None

if root.exists():
    for p in sorted(root.glob('*/MTLCompiler')):
        try:
            rp=p.resolve(strict=True)
            if not rp.is_file(): continue
            d=rp.read_bytes(); sha=hashlib.sha256(d).hexdigest(); u=uuid_of(d)
            rows.append({'link':str(p),'path':str(rp),'bytes':len(d),'sha256':sha,'uuid':u,'version_dir':p.parent.name})
        except Exception as e:
            print(f'MTL_DISCOVERY_ERROR|PATH={p}|ERROR={type(e).__name__}:{e}')

seen=[]; uniq=[]
for r in rows:
    k=(r['path'],r['sha256'])
    if k not in seen: seen.append(k); uniq.append(r)
rows=uniq
for r in rows:
    print('MTL_IMAGE|VERSION_DIR={version_dir}|PATH={path}|BYTES={bytes}|SHA256={sha256}|UUID={uuid}'.format(**r))

sel=None
for r in rows:
    if r['sha256'].lower()==known: sel=r; break
if sel is None:
    for r in rows:
        if r['version_dir']=='32023': sel=r; break
if sel is None and rows: sel=rows[0]
if sel is None:
    raise SystemExit('NO_MTLCOMPILER_IMAGE_FOUND')

print(f'SELECTED_MTL_PATH={sel["path"]}')
print(f'SELECTED_MTL_SHA256={sel["sha256"]}')
print(f'SELECTED_MTL_UUID={sel["uuid"]}')
print('KNOWN_GOLDEN_ROOTPATCHED_MTL_SHA_MATCH='+('PASS' if sel['sha256'].lower()==known else 'NO'))
envp.write_text('SELECTED_MTL_PATH='+json.dumps(sel['path'])+'\nSELECTED_MTL_SHA256='+json.dumps(sel['sha256'])+'\nSELECTED_MTL_UUID='+json.dumps(sel['uuid'] or '')+'\n',encoding='utf-8')
jsonp.write_text(json.dumps({'images':rows,'selected':sel},indent=2),encoding='utf-8')
PY

source "$META_ENV"
[[ -f "$SELECTED_MTL_PATH" ]] || fail "SELECTED_MTL_MISSING"
/usr/bin/otool -tvV "$SELECTED_MTL_PATH" > "$OTOOL_OUT" 2>&1 || fail "OTOOL_FAILED"
/usr/bin/nm -nm "$SELECTED_MTL_PATH" > "$NM_OUT" 2>&1 || fail "NM_FAILED"
echo

echo "===== STATIC SAME-BOUNDARY MAP ====="
"$PYTHON" - "$SELECTED_MTL_PATH" "$OTOOL_OUT" "$NM_OUT" "$TAHOE_EXPECTED_THRESHOLDS" "$TAHOE_EXPECTED_DISPS" "$META_ENV" "$META_JSON" <<'PY'
import hashlib,json,re,struct,sys
from pathlib import Path

binp=Path(sys.argv[1]); otool=Path(sys.argv[2]); nmp=Path(sys.argv[3]); exp_thr=[int(x) for x in sys.argv[4].split(',')]; exp_disp=[int(x) for x in sys.argv[5].split(',')]; envp=Path(sys.argv[6]); jsonp=Path(sys.argv[7])
labels=['BUFFERS','SAMPLERS','TEXTURES','CONSTANT_BUFFERS','INTERPOLATED_INPUTS','INTERPOLATED_COMPONENT_INPUTS']
imm_hex=['41','11','81','f','20','7d']

# symbols
symbols=[]
for line in nmp.read_text(errors='replace').splitlines():
    m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',line)
    if m:
        try: symbols.append((int(m.group(1),16),m.group(2).strip()))
        except: pass
symbols.sort()
hits=[x for x in symbols if 'validSimulatorMetadata' in x[1]]
print('VALID_SIMULATOR_METADATA_SYMBOL_COUNT='+str(len(hits)))
if len(hits)!=1:
    print('GOLDEN_SIX_COUNTER_STATIC_MAP=INCONCLUSIVE_SYMBOL_COUNT')
    raise SystemExit(0)
start,name=hits[0]; end=min([a for a,n in symbols if a>start], default=start+0x1000)
print(f'GOLDEN_VALID_SIMULATOR_METADATA_START_VM=0x{start:X}')
print(f'GOLDEN_VALID_SIMULATOR_METADATA_END_VM=0x{end:X}')
print('GOLDEN_VALID_SIMULATOR_METADATA_SYMBOL='+name)

rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst=[]
for line in otool.read_text(errors='replace').splitlines():
    m=rx.match(line)
    if not m: continue
    try:a=int(m.group(1),16)
    except:continue
    if not (start<=a<end): continue
    body=m.group(2).strip(); parts=body.split(None,1); mn=parts[0].lower() if parts else ''; op=parts[1] if len(parts)>1 else ''
    inst.append((a,mn,op,body))
inst.sort(); print('GOLDEN_VALID_SIMULATOR_METADATA_INSTRUCTION_COUNT='+str(len(inst)))

def disp_from(s):
    m=re.search(r'(-?0x[0-9a-fA-F]+)\(%rbp\)',s)
    if not m:return None
    t=m.group(1); return -int(t[3:],16) if t.startswith('-0x') else int(t,16)

rows=[]
for idx,(label,imm) in enumerate(zip(labels,imm_hex)):
    candidates=[]
    pat=re.compile(r'\$0x0*'+re.escape(imm)+r'(?:,|\b)',re.I)
    for i,row in enumerate(inst):
        a,mn,op,body=row
        if mn!='cmpl' or not pat.search(op): continue
        disp=disp_from(op); reg=None; load_addr=None
        if disp is None:
            # second operand register; find nearest load into same register
            parts=[x.strip() for x in op.split(',')]
            reg=parts[-1] if parts else None
            for j in range(i-1,max(-1,i-8),-1):
                pa,pmn,pop,pbody=inst[j]
                if pmn=='movl' and reg and pop.strip().endswith(', '+reg):
                    d=disp_from(pop)
                    if d is not None: disp=d; load_addr=pa; break
        else:
            load_addr=a
        branch=None
        if i+1<len(inst) and inst[i+1][1].startswith('j'):
            branch=inst[i+1]
        candidates.append((a,disp,load_addr,branch,body))
    # prefer expected displacement match
    chosen=None
    for c in candidates:
        if c[1]==exp_disp[idx]: chosen=c; break
    if chosen is None and len(candidates)==1: chosen=candidates[0]
    if chosen is None:
        print(f'GOLDEN_COUNTER|NAME={label}|STATUS=INCONCLUSIVE|CANDIDATE_COUNT={len(candidates)}')
        rows.append({'name':label,'status':'INCONCLUSIVE','threshold':exp_thr[idx],'expected_disp':exp_disp[idx]})
        continue
    a,disp,load_addr,branch,body=chosen
    baddr=branch[0] if branch else None; btext=branch[3] if branch else None
    print(f'GOLDEN_COUNTER|NAME={label}|STATUS=MAPPED|RBP_DISP={disp}|THRESHOLD={exp_thr[idx]}|COMPARE_VM=0x{a:X}|LOAD_VM={"0x%X"%load_addr if load_addr else "UNKNOWN"}|BRANCH_VM={"0x%X"%baddr if baddr else "UNKNOWN"}|BRANCH={btext or "UNKNOWN"}')
    rows.append({'name':label,'status':'MAPPED','rbp_disp':disp,'threshold':exp_thr[idx],'compare_vm':a,'load_vm':load_addr,'branch_vm':baddr,'branch_text':btext})

exact=all(r.get('status')=='MAPPED' and r.get('rbp_disp')==exp_disp[i] for i,r in enumerate(rows)) and len(rows)==6
print('GOLDEN_TAHOE_STATIC_SIX_COUNTER_CONTRACT='+('EXACT_MATCH' if exact else 'NOT_EXACT_OR_INCONCLUSIVE'))

# choose first compare as capture point only if exact map complete
capture_vm=rows[0].get('compare_vm') if exact else None
print('GOLDEN_LATE_CAPTURE_VM='+('0x%X'%capture_vm if capture_vm else 'UNKNOWN'))

# function byte hash from Mach-O __TEXT mapping
data=binp.read_bytes(); fn_sha=None; fn_bytes=None
if len(data)>=32 and struct.unpack_from('<I',data,0)[0]==0xFEEDFACF:
    ncmds=struct.unpack_from('<I',data,16)[0]; pos=32; segs=[]
    for _ in range(ncmds):
        cmd,sz=struct.unpack_from('<II',data,pos)
        if cmd==0x19 and sz>=72:
            segname=data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace')
            vmaddr,vmsize,fileoff,filesize=struct.unpack_from('<QQQQ',data,pos+24)
            segs.append((segname,vmaddr,vmsize,fileoff,filesize))
        pos+=sz
    for segname,vmaddr,vmsize,fileoff,filesize in segs:
        if vmaddr<=start<end<=vmaddr+filesize:
            fo=fileoff+(start-vmaddr); ln=end-start; b=data[fo:fo+ln]; fn_bytes=len(b); fn_sha=hashlib.sha256(b).hexdigest(); break
print('GOLDEN_VALID_SIMULATOR_METADATA_BYTES='+str(fn_bytes if fn_bytes is not None else 'UNKNOWN'))
print('GOLDEN_VALID_SIMULATOR_METADATA_SHA256='+str(fn_sha if fn_sha is not None else 'UNKNOWN'))

meta=json.loads(jsonp.read_text())
meta['validSimulatorMetadata']={'start_vm':start,'end_vm':end,'symbol':name,'instruction_count':len(inst),'function_bytes':fn_bytes,'function_sha256':fn_sha,'six_counters':rows,'static_contract_exact_match':exact,'capture_vm':capture_vm}
jsonp.write_text(json.dumps(meta,indent=2),encoding='utf-8')
with envp.open('a',encoding='utf-8') as f:
    f.write('GOLDEN_STATIC_EXACT_MATCH='+json.dumps('YES' if exact else 'NO')+'\n')
    f.write('GOLDEN_LATE_CAPTURE_VM='+json.dumps(('0x%X'%capture_vm) if capture_vm else '')+'\n')
    f.write('GOLDEN_COUNTER_DISPS='+json.dumps(','.join(str(r.get('rbp_disp','')) for r in rows))+'\n')
PY

source "$META_ENV"
echo

echo "===== PASSIVE RECENT RUNTIME LOGS ====="
/usr/bin/log show --last 20m --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$MTL_LOG" 2>/dev/null || true
/usr/bin/log show --last 20m --timezone local --style json --info --debug --predicate 'process == "launchd" AND eventMessage CONTAINS[c] "MTLCompilerService"' > "$LAUNCHD_LOG" 2>/dev/null || true
/usr/bin/log show --last 20m --timezone local --style json --info --debug --predicate 'process == "WindowServer" AND (eventMessage CONTAINS[c] "compiler" OR eventMessage CONTAINS[c] "pipeline" OR eventMessage CONTAINS[c] "Metal")' > "$WS_LOG" 2>/dev/null || true
"$PYTHON" - "$MTL_LOG" "$LAUNCHD_LOG" "$WS_LOG" "$SELECTED_MTL_UUID" <<'PY'
import collections,json,re,sys
from pathlib import Path

def parse(path):
    raw=Path(path).read_text(errors='replace') if Path(path).exists() else ''; dec=json.JSONDecoder(); out=[]; i=0
    while i<len(raw):
        while i<len(raw) and (raw[i].isspace() or raw[i]==','): i+=1
        if i>=len(raw): break
        if raw[i] not in '[{':
            ps=[p for p in (raw.find('{',i),raw.find('[',i)) if p>=0]
            if not ps: break
            i=min(ps)
        try: obj,e=dec.raw_decode(raw,i)
        except json.JSONDecodeError: i+=1; continue
        if isinstance(obj,list): out.extend(x for x in obj if isinstance(x,dict))
        elif isinstance(obj,dict): out.append(obj)
        i=e
    return out

def v(r,*ks):
    for k in ks:
        if k in r and r[k] is not None:return r[k]
    return None

def pid(r):
    try:return int(v(r,'processID','processIdentifier'))
    except:return -1

mtl=parse(sys.argv[1]); lau=parse(sys.argv[2]); ws=parse(sys.argv[3]); expected_uuid=sys.argv[4].upper()
print('GOLDEN_MTL_LOG_RECORD_COUNT='+str(len(mtl)))
print('GOLDEN_LAUNCHD_MTL_RECORD_COUNT='+str(len(lau)))
print('GOLDEN_WINDOWSERVER_RELEVANT_RECORD_COUNT='+str(len(ws)))
senders=collections.Counter(); pids=set(); late=[]
for r in mtl:
    pids.add(pid(r)); path=str(v(r,'senderImagePath') or ''); uuid=str(v(r,'senderImageUUID') or '').upper(); pc=v(r,'senderProgramCounter'); senders[(path,uuid,str(pc))]+=1
    msg=str(v(r,'eventMessage','message') or '')
    if re.search(r'buffers|sampelrs|samplers|textures|constant buffers|interpolated|simulator',msg,re.I):
        late.append((str(v(r,'timestamp') or ''),pid(r),path,uuid,str(pc),msg.replace('\n','\\n')))
print('GOLDEN_MTL_LOG_PID_COUNT='+str(len([x for x in pids if x>=0])))
for (path,uuid,pc),n in senders.most_common(30):
    print(f'GOLDEN_SENDER|COUNT={n}|PATH={path}|UUID={uuid}|PC={pc}')
print('GOLDEN_LATE_RELATED_MESSAGE_COUNT='+str(len(late)))
for row in late[:100]:
    print('GOLDEN_LATE_LOG|TS=%s|PID=%s|PATH=%s|UUID=%s|PC=%s|MSG=%s'%row)
print('GOLDEN_SELECTED_UUID_SENDER_RECORDS='+str(sum(n for (p,u,pc),n in senders.items() if u==expected_uuid)))
PY

echo
echo "===== RECENT MTLCOMPILERSERVICE DIAGNOSTIC REPORTS ====="
/usr/bin/find /Library/Logs/DiagnosticReports "$HOME/Library/Logs/DiagnosticReports" -maxdepth 1 -type f -name 'MTLCompilerService*' -mmin -120 -print 2>/dev/null | /usr/bin/sort || true

echo
echo "===== OPTIONAL LIVE SIX-COUNTER CAPTURE ====="
if [[ "$LIVE_MODE" != "YES" ]]; then
  echo "GOLDEN_LIVE_COUNTER_CAPTURE=SKIPPED|REASON=GOLDEN_CAPTURE_LIVE_NOT_YES"
else
  [[ "$GOLDEN_STATIC_EXACT_MATCH" == "YES" && -n "$GOLDEN_LATE_CAPTURE_VM" ]] || fail "LIVE_CAPTURE_REQUIRES_EXACT_STATIC_SIX_COUNTER_MAP"
  [[ -x /usr/bin/lldb ]] || { echo "GOLDEN_LIVE_COUNTER_CAPTURE=UNAVAILABLE|REASON=LLDB_MISSING"; LIVE_MODE="NO"; }
fi

if [[ "$LIVE_MODE" == "YES" ]]; then
  /usr/bin/sudo -v || fail "SUDO_GATE_FAILED_FOR_OPTIONAL_LIVE_DEBUG_ATTACH"
  cat > "$LLDB_PY" <<'PY'
import lldb, sys, time

DISPS=[-496,-504,-500,-512,-508,-492]
NAMES=['BUFFERS','SAMPLERS','TEXTURES','CONSTANT_BUFFERS','INTERPOLATED_INPUTS','INTERPOLATED_COMPONENT_INPUTS']

def setbp(debugger, command, result, internal_dict):
    target=debugger.GetSelectedTarget(); process=target.GetProcess()
    try: file_addr=int(command.strip(),0)
    except Exception:
        result.PutCString('GOLDEN_LLDB_SETBP=FAIL_BAD_ADDRESS'); return
    mods=[]
    for i in range(target.GetNumModules()):
        m=target.GetModuleAtIndex(i); p=m.GetFileSpec().fullpath or ''
        if '/MTLCompiler.framework/' in p and p.endswith('/MTLCompiler'): mods.append(m)
    if len(mods)!=1:
        result.PutCString('GOLDEN_LLDB_SETBP=FAIL_MODULE_COUNT_%d'%len(mods)); return
    addr=mods[0].ResolveFileAddress(file_addr)
    if not addr.IsValid():
        result.PutCString('GOLDEN_LLDB_SETBP=FAIL_RESOLVE_FILE_ADDRESS'); return
    bp=target.BreakpointCreateBySBAddress(addr)
    result.PutCString('GOLDEN_LLDB_SETBP=PASS|FILE_ADDR=0x%X|LOAD_ADDR=0x%X|BP_ID=%d'%(file_addr,addr.GetLoadAddress(target),bp.GetID()))

def dump(debugger, command, result, internal_dict):
    target=debugger.GetSelectedTarget(); p=target.GetProcess(); th=p.GetSelectedThread()
    if not th.IsValid() or th.GetNumFrames()==0:
        result.PutCString('GOLDEN_CAPTURE=NO_SELECTED_FRAME'); return
    f=th.GetFrameAtIndex(0); rbp=f.FindRegister('rbp').GetValueAsUnsigned(); err=lldb.SBError(); vals=[]
    for d in DISPS:
        b=p.ReadMemory(rbp+d,4,err)
        if err.Fail() or len(b)!=4: vals.append(None)
        else: vals.append(int.from_bytes(b,'little',signed=False))
    bits=[vals[0] is not None and vals[0]>=65,vals[1] is not None and vals[1]>=17,vals[2] is not None and vals[2]>=129,vals[3] is not None and vals[3]>=15,vals[4] is not None and vals[4]>=32,vals[5] is not None and vals[5]>=125]
    mask=sum((1<<i) for i,b in enumerate(bits) if b)
    stack=[]
    for i in range(min(10,th.GetNumFrames())):
        fr=th.GetFrameAtIndex(i); stack.append(fr.GetFunctionName() or ('0x%X'%fr.GetPC()))
    kv='|'.join('%s=%s'%(n,'READ_FAIL' if v is None else v) for n,v in zip(NAMES,vals))
    result.PutCString('GOLDEN_CAPTURE|PID=%d|TID=%d|RBP=0x%X|%s|MASK=0x%02X|STATUS_EQUIV=%d|STACK=%s'%(p.GetProcessID(),th.GetThreadID(),rbp,kv,mask,160+mask,' <- '.join(stack)))

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f golden_lldb.setbp golden_setbp')
    debugger.HandleCommand('command script add -f golden_lldb.dump golden_dump')
PY

  LIVE_HITS=0
  for ROUND in $(/usr/bin/seq 1 "$LIVE_ROUNDS"); do
    CMD="$TMP/lldb-$ROUND.cmd"; LOUT="$TMP/lldb-$ROUND.out"
    cat > "$CMD" <<EOF
command script import $LLDB_PY
process attach --name MTLCompilerService --waitfor
golden_setbp $GOLDEN_LATE_CAPTURE_VM
continue
golden_dump
bt 10
detach
quit
EOF
    echo "GOLDEN_LIVE_ROUND_BEGIN=$ROUND"
    "$PYTHON" - "$CMD" "$LOUT" "$LIVE_TIMEOUT" <<'PY'
import subprocess,sys
cmd,out,timeout=sys.argv[1],sys.argv[2],int(sys.argv[3])
try:
    p=subprocess.run(['/usr/bin/sudo','-n','/usr/bin/lldb','-b','-s',cmd],stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=timeout)
    open(out,'w',encoding='utf-8').write(p.stdout)
    print('LLDB_ROUND_RC='+str(p.returncode))
except subprocess.TimeoutExpired as e:
    text=(e.stdout or '') if isinstance(e.stdout,str) else ((e.stdout or b'').decode('utf-8','replace'))
    open(out,'w',encoding='utf-8').write(text)
    print('LLDB_ROUND_TIMEOUT=YES')
PY
    /bin/cat "$LOUT" || true
    HITS="$(/usr/bin/grep -c '^GOLDEN_CAPTURE|PID=' "$LOUT" 2>/dev/null || true)"
    LIVE_HITS=$((LIVE_HITS + HITS))
    echo "GOLDEN_LIVE_ROUND_HITS=$HITS"
    echo "GOLDEN_LIVE_ROUND_END=$ROUND"
  done
  echo "GOLDEN_LIVE_CAPTURE_TOTAL_HITS=$LIVE_HITS"
  if (( LIVE_HITS > 0 )); then
    echo "GOLDEN_LIVE_COUNTER_CAPTURE=PROVEN_RAW_SIX_VALUES_OBSERVED"
  else
    echo "GOLDEN_LIVE_COUNTER_CAPTURE=NO_HIT_OR_ATTACH_BLOCKED_OR_NO_MATCHING_REQUEST"
  fi
fi

echo
echo "===== BUILD STRUCTURED JSON ====="
"$PYTHON" - "$META_JSON" "$JSON_OUT" "$OUT" "$OS_VERSION" "$OS_BUILD" "$LIVE_MODE" <<'PY'
import json,sys
from pathlib import Path
meta=json.loads(Path(sys.argv[1]).read_text())
meta['os_version']=sys.argv[4]; meta['os_build']=sys.argv[5]; meta['live_mode_requested']=sys.argv[6]
meta['report_path']=sys.argv[3]
Path(sys.argv[2]).write_text(json.dumps(meta,indent=2),encoding='utf-8')
print('GOLDEN_STRUCTURED_JSON='+sys.argv[2])
PY

echo
echo "===== FINAL LEDGER ====="
echo "SYSTEM_FILE_MUTATION=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "PROCESS_DEBUG_ATTACH=$([[ "$LIVE_MODE" == "YES" ]] && echo ATTEMPTED_TEMPORARY || echo NO)"
echo "D97AT_GOLDEN_COMPARATOR_COLLECTOR=COMPLETE"
echo "REPORT=$OUT"
echo "JSON_REPORT=$JSON_OUT"
echo "STOP=RETURN_COMPLETE_OUTPUT_AND_JSON_IF_AVAILABLE"
