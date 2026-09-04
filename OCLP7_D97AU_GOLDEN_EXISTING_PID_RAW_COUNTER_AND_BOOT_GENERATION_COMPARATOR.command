#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
GOLDEN_32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
GOLDEN_3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_32023_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
EXPECTED_3802_UUID="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"
CAPTURE_FILE_ADDR="0x7FFB162C76C3"
CAPTURE_HIT_LIMIT="${GOLDEN_CAPTURE_HITS:-8}"
CAPTURE_TIMEOUT="${GOLDEN_CAPTURE_TIMEOUT:-35}"
MAX_PID_ATTEMPTS="${GOLDEN_CAPTURE_PID_ATTEMPTS:-5}"
OUT="$HOME/Desktop/OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_REPORT.txt"
JSON_OUT="$HOME/Desktop/OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_DATA.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AU.XXXXXX)"
BOOT_JSON="$TMP/boot.json"
RECENT_JSON="$TMP/recent.json"
LLDB_PY="$TMP/golden_live.py"

cleanup(){
  local rc=$?
  trap - EXIT
  [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AU.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true
  exit "$rc"
}
trap cleanup EXIT

fail(){
  echo "D97AU_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SYSTEM_FILE_MUTATION=NO"
  echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -x /usr/bin/lldb ]] || fail "MISSING_LLDB"
[[ -f "$GOLDEN_32023" ]] || fail "MISSING_GOLDEN_32023"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AU — GOLDEN EXISTING-PID RAW SIX-COUNTER + BOOT GENERATION COMPARATOR ====="
echo "EXPECTED_OS_VERSION=$EXPECTED_OS_VERSION"
echo "EXPECTED_OS_BUILD=$EXPECTED_OS_BUILD"
echo "EXPECTED_32023_SHA256=$EXPECTED_32023_SHA"
echo "EXPECTED_32023_UUID=$EXPECTED_32023_UUID"
echo "EXPECTED_3802_UUID=$EXPECTED_3802_UUID"
echo "CAPTURE_FILE_ADDRESS=$CAPTURE_FILE_ADDR"
echo "CAPTURE_HIT_LIMIT=$CAPTURE_HIT_LIMIT"
echo "CAPTURE_TIMEOUT_SECONDS=$CAPTURE_TIMEOUT"
echo "SYSTEM_FILE_MUTATION=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "PROCESS_DEBUG_ATTACH=TEMPORARY_EXISTING_PID_ONLY"
echo

OS_VERSION="$(/usr/bin/sw_vers -productVersion)"
OS_BUILD="$(/usr/bin/sw_vers -buildVersion)"
echo "OS_VERSION=$OS_VERSION"
echo "OS_BUILD=$OS_BUILD"
[[ "$OS_VERSION" == "$EXPECTED_OS_VERSION" ]] || fail "NOT_EXPECTED_GOLDEN_SEQUOIA_VERSION"
[[ "$OS_BUILD" == "$EXPECTED_OS_BUILD" ]] || fail "NOT_EXPECTED_GOLDEN_SEQUOIA_BUILD"
echo "D97AU_GOLDEN_OS_IDENTITY=PASS"

ACTUAL_32023_SHA="$(/usr/bin/shasum -a 256 "$GOLDEN_32023" | /usr/bin/awk '{print $1}')"
echo "GOLDEN_32023_SHA256=$ACTUAL_32023_SHA"
[[ "$ACTUAL_32023_SHA" == "$EXPECTED_32023_SHA" ]] || fail "GOLDEN_32023_SHA_MISMATCH"
echo "D97AU_GOLDEN_32023_IDENTITY=PASS"

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
echo "KERN_BOOTTIME=$BOOT_RAW"
BOOT_START="$("$PYTHON" - "$BOOT_RAW" <<'PY'
import datetime,re,sys
sec=int(re.search(r'sec\s*=\s*(\d+)',sys.argv[1]).group(1)); print(datetime.datetime.fromtimestamp(sec).astimezone().strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
BOOT_END="$("$PYTHON" - "$BOOT_RAW" <<'PY'
import datetime,re,sys
sec=int(re.search(r'sec\s*=\s*(\d+)',sys.argv[1]).group(1)); print((datetime.datetime.fromtimestamp(sec).astimezone()+datetime.timedelta(seconds=180)).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
echo "GOLDEN_BOOT_ALIGNED_WINDOW_START=$BOOT_START"
echo "GOLDEN_BOOT_ALIGNED_WINDOW_END=$BOOT_END"

/usr/bin/log show --start "$BOOT_START" --end "$BOOT_END" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$BOOT_JSON" 2>/dev/null || true
/usr/bin/log show --last 10m --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$RECENT_JSON" 2>/dev/null || true

"$PYTHON" - "$BOOT_JSON" "$RECENT_JSON" "$EXPECTED_32023_UUID" "$EXPECTED_3802_UUID" <<'PY'
import collections,json,sys
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

def summarize(label,recs,u32,u38):
    byuuid=collections.Counter(); pcs=collections.Counter(); perpid=collections.defaultdict(lambda:collections.Counter())
    for r in recs:
        u=str(v(r,'senderImageUUID') or '').upper(); pc=v(r,'senderProgramCounter'); n=pid(r)
        if u in (u32,u38):
            key='32023' if u==u32 else '3802'; byuuid[key]+=1; perpid[n][key]+=1
            if u==u32:
                try: x=int(pc,0) if isinstance(pc,str) else int(pc)
                except: x=-1
                pcs[x]+=1
    print(f'{label}_TOTAL_MTL_RECORDS={len(recs)}')
    print(f'{label}_32023_SENDER_RECORDS={byuuid["32023"]}')
    print(f'{label}_3802_SENDER_RECORDS={byuuid["3802"]}')
    print(f'{label}_GENERATION_ACTIVE_SET='+','.join(k for k in ('3802','32023') if byuuid[k]>0))
    print(f'{label}_EXACT_GENERATION_PID_COUNT={len([p for p,c in perpid.items() if p>=0])}')
    both=[p for p,c in perpid.items() if p>=0 and c['32023'] and c['3802']]
    only32=[p for p,c in perpid.items() if p>=0 and c['32023'] and not c['3802']]
    only38=[p for p,c in perpid.items() if p>=0 and c['3802'] and not c['32023']]
    print(f'{label}_PIDS_BOTH_GENERATIONS='+(','.join(map(str,sorted(both))) if both else 'NONE'))
    print(f'{label}_PIDS_32023_ONLY='+(','.join(map(str,sorted(only32))) if only32 else 'NONE'))
    print(f'{label}_PIDS_3802_ONLY='+(','.join(map(str,sorted(only38))) if only38 else 'NONE'))
    for off in (0x9FFEE,0xA0521,0xA5F81): print(f'{label}_32023_PC_0x{off:X}_COUNT={pcs[off]}')
    for pc,n in pcs.most_common(20):
        if pc>=0: print(f'{label}_32023_PC|OFFSET=0x{pc:X}|COUNT={n}')

u32=sys.argv[3].upper(); u38=sys.argv[4].upper()
summarize('GOLDEN_BOOT3M',parse(sys.argv[1]),u32,u38)
summarize('GOLDEN_RECENT10M',parse(sys.argv[2]),u32,u38)
print('TAHOE_D97AN_REFERENCE_32023_SENDER_RECORDS=79')
print('TAHOE_D97AN_REFERENCE_3802_SENDER_RECORDS=0')
print('TAHOE_D97AN_REFERENCE_32023_PID_COUNT=65')
print('TAHOE_D97AN_REFERENCE_PC_0x9FFEE_COUNT=7')
print('TAHOE_D97AN_REFERENCE_PC_0xA0521_COUNT=7')
print('TAHOE_D97AN_REFERENCE_PC_0xA5F81_COUNT=65')
PY

echo
echo "===== LIVE MTLCOMPILERSERVICE PID INVENTORY ====="
LIVE_PIDS=""
for POLL in {1..10}; do
  LIVE_PIDS="$(/usr/bin/pgrep -x MTLCompilerService 2>/dev/null | /usr/bin/tr '\n' ' ' | /usr/bin/sed 's/[[:space:]]*$//' || true)"
  [[ -n "$LIVE_PIDS" ]] && break
  /bin/sleep 1
done
echo "LIVE_MTLCOMPILERSERVICE_PIDS=${LIVE_PIDS:-NONE}"
if [[ -n "$LIVE_PIDS" ]]; then
  PID_CSV="${LIVE_PIDS// /,}"
  /bin/ps -o pid=,ppid=,etime=,state=,command= -p "$PID_CSV" 2>/dev/null || true
fi

cat > "$LLDB_PY" <<'PY'
import lldb,sys

EXPECTED_UUID='D5CE0008-587C-3861-971A-4BAEFB7B9C5B'
DISPS=[-496,-504,-500,-512,-508,-492]
NAMES=['BUFFERS','SAMPLERS','TEXTURES','CONSTANT_BUFFERS','INTERPOLATED_INPUTS','INTERPOLATED_COMPONENT_INPUTS']
THRESH=[65,17,129,15,32,125]
STATE={'count':0,'limit':8}

def _module_uuid(m):
    try:return (m.GetUUIDString() or '').upper()
    except:return ''

def capture_callback(frame,bp_loc,internal_dict):
    try:
        th=frame.GetThread(); p=th.GetProcess(); rbp=frame.FindRegister('rbp').GetValueAsUnsigned(); err=lldb.SBError(); vals=[]
        for d in DISPS:
            b=p.ReadMemory(rbp+d,4,err)
            if err.Fail() or len(b)!=4: vals.append(None)
            else: vals.append(int.from_bytes(b,'little',signed=False))
        mask=0
        for i,(v,t) in enumerate(zip(vals,THRESH)):
            if v is not None and v>=t: mask|=(1<<i)
        stack=[]
        for i in range(min(12,th.GetNumFrames())):
            fr=th.GetFrameAtIndex(i); stack.append(fr.GetFunctionName() or ('0x%X'%fr.GetPC()))
        kv='|'.join('%s=%s'%(n,'READ_FAIL' if v is None else v) for n,v in zip(NAMES,vals))
        STATE['count']+=1
        print('GOLDEN_RAW_CAPTURE|HIT=%d|PID=%d|TID=%d|PC=0x%X|RBP=0x%X|%s|MASK=0x%02X|STATUS_EQUIV=%d|STACK=%s'%(STATE['count'],p.GetProcessID(),th.GetThreadID(),frame.GetPC(),rbp,kv,mask,160+mask,' <- '.join(stack)),flush=True)
        return STATE['count']>=STATE['limit']
    except Exception as e:
        print('GOLDEN_RAW_CAPTURE_ERROR|%s:%s'%(type(e).__name__,e),flush=True)
        return True

def install(debugger,command,result,internal_dict):
    parts=command.split()
    if len(parts)<2:
        result.PutCString('GOLDEN_LLDB_INSTALL=FAIL_ARGS'); return
    file_addr=int(parts[0],0); STATE['limit']=int(parts[1]); target=debugger.GetSelectedTarget()
    mods=[]
    for i in range(target.GetNumModules()):
        m=target.GetModuleAtIndex(i); p=(m.GetFileSpec().fullpath or '')
        if _module_uuid(m)==EXPECTED_UUID and '/MTLCompiler.framework/Versions/32023/MTLCompiler' in p: mods.append(m)
    if len(mods)!=1:
        result.PutCString('GOLDEN_LLDB_INSTALL=FAIL_EXACT_32023_MODULE_COUNT_%d'%len(mods)); return
    m=mods[0]; addr=m.ResolveFileAddress(file_addr)
    if not addr.IsValid():
        result.PutCString('GOLDEN_LLDB_INSTALL=FAIL_RESOLVE_FILE_ADDRESS'); return
    bp=target.BreakpointCreateBySBAddress(addr); bp.SetScriptCallbackFunction('golden_live.capture_callback')
    load=addr.GetLoadAddress(target); filea=addr.GetFileAddress()
    result.PutCString('GOLDEN_LLDB_INSTALL=PASS|MODULE_UUID=%s|FILE_ADDR=0x%X|RESOLVED_FILE_ADDR=0x%X|LOAD_ADDR=0x%X|BP_ID=%d|HIT_LIMIT=%d'%(_module_uuid(m),file_addr,filea,load,bp.GetID(),STATE['limit']))

def __lldb_init_module(debugger,internal_dict):
    debugger.HandleCommand('command script add -f golden_live.install golden_install')
PY

echo
echo "===== EXISTING-PID LLDB RAW COUNTER CAPTURE ====="
/usr/bin/sudo -v || fail "SUDO_GATE_FAILED_FOR_DEBUG_ATTACH"
TOTAL_HITS=0
ATTEMPTS=0
if [[ -n "$LIVE_PIDS" ]]; then
  for PID in ${=LIVE_PIDS}; do
    ATTEMPTS=$((ATTEMPTS+1))
    (( ATTEMPTS <= MAX_PID_ATTEMPTS )) || break
    /bin/kill -0 "$PID" 2>/dev/null || continue
    CMD="$TMP/lldb-$PID.cmd"; LOUT="$TMP/lldb-$PID.out"
    cat > "$CMD" <<EOF
command script import $LLDB_PY
golden_install $CAPTURE_FILE_ADDR $CAPTURE_HIT_LIMIT
continue
detach
quit
EOF
    echo "GOLDEN_EXISTING_PID_CAPTURE_BEGIN=$PID"
    "$PYTHON" - "$PID" "$CMD" "$LOUT" "$CAPTURE_TIMEOUT" <<'PY'
import subprocess,sys
pid,cmd,out,timeout=sys.argv[1],sys.argv[2],sys.argv[3],int(sys.argv[4])
try:
    p=subprocess.run(['/usr/bin/sudo','-n','/usr/bin/lldb','-b','-p',pid,'-s',cmd],stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=timeout)
    open(out,'w',encoding='utf-8').write(p.stdout)
    print('LLDB_EXISTING_PID_RC='+str(p.returncode))
except subprocess.TimeoutExpired as e:
    text=(e.stdout or '') if isinstance(e.stdout,str) else ((e.stdout or b'').decode('utf-8','replace'))
    open(out,'w',encoding='utf-8').write(text)
    print('LLDB_EXISTING_PID_TIMEOUT=YES')
PY
    /bin/cat "$LOUT" 2>/dev/null || true
    /usr/bin/sudo -n /bin/kill -CONT "$PID" 2>/dev/null || true
    HITS="$(/usr/bin/grep -c '^GOLDEN_RAW_CAPTURE|' "$LOUT" 2>/dev/null || true)"
    TOTAL_HITS=$((TOTAL_HITS+HITS))
    echo "GOLDEN_EXISTING_PID_CAPTURE_HITS=$HITS"
    echo "GOLDEN_EXISTING_PID_CAPTURE_END=$PID"
    (( TOTAL_HITS > 0 )) && break
  done
fi

echo "GOLDEN_EXISTING_PID_CAPTURE_TOTAL_HITS=$TOTAL_HITS"
if (( TOTAL_HITS > 0 )); then
  echo "D97AU_GOLDEN_RAW_SIX_COUNTER_CAPTURE=PROVEN_VALUES_OBSERVED"
else
  echo "D97AU_GOLDEN_RAW_SIX_COUNTER_CAPTURE=NO_HITS_OR_ATTACH_DENIED_OR_IDLE_EXISTING_PID"
fi

echo
echo "===== BUILD STRUCTURED RESULT ====="
"$PYTHON" - "$OUT" "$JSON_OUT" <<'PY'
import json,sys
from pathlib import Path
lines=Path(sys.argv[1]).read_text(errors='replace').splitlines(); caps=[]; kv={}
for line in lines:
    if '=' in line and '|' not in line:
        k,v=line.split('=',1); kv[k]=v
    if line.startswith('GOLDEN_RAW_CAPTURE|'):
        row={}
        for item in line.split('|')[1:]:
            if '=' in item:
                k,v=item.split('=',1); row[k]=v
        caps.append(row)
Path(sys.argv[2]).write_text(json.dumps({'summary':kv,'raw_captures':caps},indent=2),encoding='utf-8')
print('D97AU_JSON_REPORT='+sys.argv[2])
print('D97AU_RAW_CAPTURE_JSON_COUNT='+str(len(caps)))
PY

echo
echo "===== FINAL LEDGER ====="
echo "SYSTEM_FILE_MUTATION=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "PROCESS_DEBUG_ATTACH=TEMPORARY_EXISTING_PID_ATTEMPTED"
echo "D97AU_AUDIT=COMPLETE"
echo "REPORT=$OUT"
echo "JSON_REPORT=$JSON_OUT"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
