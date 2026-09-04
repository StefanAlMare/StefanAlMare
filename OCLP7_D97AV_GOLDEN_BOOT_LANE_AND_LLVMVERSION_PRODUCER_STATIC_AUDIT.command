#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
METAL="/System/Library/Frameworks/Metal.framework/Versions/A/Metal"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_32023_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
EXPECTED_3802_UUID="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"
PC_OFFSETS="0x9A9FC,0x9FFEE,0xA0521,0xA5F81"
OUT="$HOME/Desktop/OCLP7_D97AV_GOLDEN_BOOT_LANE_AND_LLVMVERSION_PRODUCER_STATIC_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AV.XXXXXX)"
MTL_OTOOL="$TMP/mtl32023.otool"
MTL_NM="$TMP/mtl32023.nm"
METAL_OTOOL="$TMP/metal.otool"
METAL_NM="$TMP/metal.nm"
BOOT_JSON="$TMP/boot.json"

cleanup(){
  local rc=$?
  trap - EXIT
  [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AV.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true
  exit "$rc"
}
trap cleanup EXIT

fail(){
  echo "D97AV_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SYSTEM_FILE_MUTATION=NO"
  echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
  echo "PROCESS_DEBUG_ATTACH=NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -x /usr/bin/otool ]] || fail "MISSING_OTOOL"
[[ -x /usr/bin/nm ]] || fail "MISSING_NM"
[[ -f "$MTL32023" && -f "$MTL3802" && -f "$METAL" ]] || fail "EXPECTED_GOLDEN_BINARIES_MISSING"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AV — GOLDEN BOOT LANE + LLVMVERSION PRODUCER STATIC AUDIT ====="
echo "EXPECTED_OS_VERSION=$EXPECTED_OS_VERSION"
echo "EXPECTED_OS_BUILD=$EXPECTED_OS_BUILD"
echo "PC_OFFSETS=$PC_OFFSETS"
echo "SYSTEM_FILE_MUTATION=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "REBOOT=AUTO-NO"

OS_VERSION="$(/usr/bin/sw_vers -productVersion)"
OS_BUILD="$(/usr/bin/sw_vers -buildVersion)"
SHA32023="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
SHA3802="$(/usr/bin/shasum -a 256 "$MTL3802" | /usr/bin/awk '{print $1}')"
METAL_SHA="$(/usr/bin/shasum -a 256 "$METAL" | /usr/bin/awk '{print $1}')"
echo "OS_VERSION=$OS_VERSION"
echo "OS_BUILD=$OS_BUILD"
echo "GOLDEN_32023_SHA256=$SHA32023"
echo "GOLDEN_3802_SHA256=$SHA3802"
echo "GOLDEN_METAL_SHA256=$METAL_SHA"
[[ "$OS_VERSION" == "$EXPECTED_OS_VERSION" && "$OS_BUILD" == "$EXPECTED_OS_BUILD" ]] || fail "NOT_EXPECTED_GOLDEN_OS"
[[ "$SHA32023" == "$EXPECTED_32023_SHA" ]] || fail "GOLDEN_32023_SHA_MISMATCH"
echo "D97AV_GOLDEN_IDENTITY=PASS"

/usr/bin/otool -tvV "$MTL32023" > "$MTL_OTOOL" 2>&1 || fail "MTL32023_OTOOL_FAILED"
/usr/bin/nm -nm "$MTL32023" > "$MTL_NM" 2>&1 || fail "MTL32023_NM_FAILED"
/usr/bin/otool -tvV "$METAL" > "$METAL_OTOOL" 2>&1 || fail "METAL_OTOOL_FAILED"
/usr/bin/nm -nm "$METAL" > "$METAL_NM" 2>&1 || true

echo "MTL32023_OTOOL_BYTES=$(/usr/bin/stat -f '%z' "$MTL_OTOOL")"
echo "METAL_OTOOL_BYTES=$(/usr/bin/stat -f '%z' "$METAL_OTOOL")"

echo
"$PYTHON" - "$MTL32023" "$MTL_OTOOL" "$MTL_NM" "$PC_OFFSETS" <<'PY'
import re,struct,sys
from pathlib import Path

binp=Path(sys.argv[1]); ot=Path(sys.argv[2]); nmp=Path(sys.argv[3]); offs=[int(x,16) for x in sys.argv[4].split(',')]
data=binp.read_bytes()
if len(data)<32 or struct.unpack_from('<I',data,0)[0]!=0xFEEDFACF: raise SystemExit('FAIL=UNSUPPORTED_MACHO')
ncmds=struct.unpack_from('<I',data,16)[0]; pos=32; base=None; uuid=None
for _ in range(ncmds):
    cmd,cmdsize=struct.unpack_from('<II',data,pos)
    if cmd==0x19 and cmdsize>=72:
        name=data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace'); vmaddr=struct.unpack_from('<Q',data,pos+24)[0]
        if name=='__TEXT': base=vmaddr
    elif cmd==0x1B and cmdsize>=24:
        u=data[pos+8:pos+24]; uuid=f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
    pos+=cmdsize
print(f'MTL32023_IMAGE_BASE=0x{base:X}')
print(f'MTL32023_LC_UUID={uuid}')
rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst=[]
for line in ot.read_text(errors='replace').splitlines():
    m=rx.match(line)
    if not m: continue
    try:a=int(m.group(1),16)
    except:continue
    body=m.group(2).strip()
    if body: inst.append((a,body))
inst.sort(); addrs=[a for a,_ in inst]
syms=[]
for line in nmp.read_text(errors='replace').splitlines():
    m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',line)
    if not m:continue
    try:a=int(m.group(1),16)
    except:continue
    syms.append((a,m.group(2).strip()))
syms.sort()

def containing(vm):
    prev=[s for s in syms if s[0]<=vm]
    if not prev:return (None,None,'UNKNOWN')
    s=prev[-1]; nxt=[a for a,n in syms if a>s[0]]; end=min(nxt) if nxt else (inst[-1][0]+16)
    return s[0],end,s[1]

def idx_for(vm):
    for i,(a,b) in enumerate(inst):
        if a==vm:return i
    return min(range(len(inst)), key=lambda i:abs(inst[i][0]-vm))

print('===== GOLDEN 32023 RUNTIME-PC STATIC MAP =====')
for off in offs:
    vm=base+off; fs,fe,name=containing(vm); i=idx_for(vm); body=inst[i][1]
    print(f'GOLDEN_PC_STATIC_MAP|OFFSET=0x{off:X}|VM=0x{vm:X}|FUNCTION_START={"0x%X"%fs if fs else "UNKNOWN"}|FUNCTION_END={"0x%X"%fe if fe else "UNKNOWN"}|SYMBOL={name}|INSTRUCTION={body}')
    lo=max(0,i-16); hi=min(len(inst),i+17)
    for a,b in inst[lo:hi]: print(f'PC_CONTEXT|TARGET=0x{off:X}|OFFSET=0x{a-base:X}|VM=0x{a:X}|TEXT={b}')
    if fs is not None:
        fi=[x for x in inst if fs<=x[0]<fe]
        oslogs=[x for x in fi if '__os_log_impl' in x[1]]
        print(f'FUNCTION_OS_LOG_CALL_COUNT|TARGET=0x{off:X}|COUNT={len(oslogs)}')
        for a,b in oslogs:
            print(f'FUNCTION_OS_LOG_CALL|TARGET=0x{off:X}|OFFSET=0x{a-base:X}|TEXT={b}')
print('D97AV_32023_PC_STATIC_MAPPING=COMPLETE')
PY

echo
echo "===== GOLDEN METAL LLVMVERSION PRODUCER STATIC CONTEXT ====="
/usr/bin/strings -a -t x "$METAL" | /usr/bin/grep -i 'llvmVersion' || true
"$PYTHON" - "$METAL_OTOOL" "$METAL_NM" <<'PY'
import re,sys
from pathlib import Path
ot=Path(sys.argv[1]); nm=Path(sys.argv[2])
rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); inst=[]
for line in ot.read_text(errors='replace').splitlines():
    m=rx.match(line)
    if not m:continue
    try:a=int(m.group(1),16)
    except:continue
    b=m.group(2).strip()
    if b:inst.append((a,b))
inst.sort(); syms=[]
if nm.exists():
  for line in nm.read_text(errors='replace').splitlines():
    m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',line)
    if m:
      try:syms.append((int(m.group(1),16),m.group(2).strip()))
      except:pass
syms.sort()
def sym(vm):
    p=[s for s in syms if s[0]<=vm]
    return p[-1][1] if p else 'UNKNOWN'
idxs=[i for i,(a,b) in enumerate(inst) if 'llvmVersion' in b]
print('METAL_LLVMVERSION_ANNOTATED_XREF_COUNT='+str(len(idxs)))
for i in idxs:
    a,b=inst[i]; print(f'METAL_LLVMVERSION_XREF|VM=0x{a:X}|SYMBOL={sym(a)}|TEXT={b}')
    for aa,bb in inst[max(0,i-45):min(len(inst),i+46)]:
        mark=[]
        low=bb.lower()
        if 'xpc_dictionary_set_uint64' in low: mark.append('XPC_SET_U64')
        if '0xeda' in low: mark.append('IMM_3802')
        if '0x7d17' in low: mark.append('IMM_32023')
        if '0x7919' in low: mark.append('IMM_31001')
        print(f'METAL_PRODUCER_CONTEXT|XREF_VM=0x{a:X}|VM=0x{aa:X}|MARK={",".join(mark) if mark else "-"}|TEXT={bb}')
for token,label in [('xpc_dictionary_set_uint64','XPC_SET_UINT64'),('0xeda','IMM_3802'),('0x7d17','IMM_32023'),('0x7919','IMM_31001')]:
    hits=[(a,b) for a,b in inst if token.lower() in b.lower()]
    print(f'METAL_GLOBAL_{label}_COUNT={len(hits)}')
    for a,b in hits[:30]: print(f'METAL_GLOBAL_{label}|VM=0x{a:X}|SYMBOL={sym(a)}|TEXT={b}')
print('D97AV_METAL_LLVMVERSION_PRODUCER_STATIC_AUDIT=COMPLETE')
PY

echo
echo "===== GOLDEN BOOT-ALIGNED PER-PID LANE SEQUENCES ====="
BOOT_SEC="$(/usr/sbin/sysctl -n kern.boottime | /usr/bin/sed -E 's/.*sec = ([0-9]+).*/\1/')"
read BOOT_START BOOT_END <<<"$($PYTHON - "$BOOT_SEC" <<'PY'
import datetime,sys
s=int(sys.argv[1]); dt=datetime.datetime.fromtimestamp(s); print(dt.strftime('%Y-%m-%d %H:%M:%S'),(dt+datetime.timedelta(minutes=3)).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
echo "BOOT_START=$BOOT_START"
echo "BOOT_END=$BOOT_END"
/usr/bin/log show --start "$BOOT_START" --end "$BOOT_END" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$BOOT_JSON" 2>/dev/null || true
"$PYTHON" - "$BOOT_JSON" "$EXPECTED_32023_UUID" "$EXPECTED_3802_UUID" <<'PY'
import collections,json,sys
from pathlib import Path
raw=Path(sys.argv[1]).read_text(errors='replace'); dec=json.JSONDecoder(); rec=[]; i=0
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
u32=sys.argv[2].upper(); u38=sys.argv[3].upper()
def v(r,*ks):
    for k in ks:
        if k in r and r[k] is not None:return r[k]
    return None
def pid(r):
    try:return int(v(r,'processID','processIdentifier'))
    except:return -1
rows=[]
for r in rec:
    u=str(v(r,'senderImageUUID') or '').upper(); gen='32023' if u==u32 else ('3802' if u==u38 else None)
    if not gen:continue
    pc=v(r,'senderProgramCounter')
    try: pc=int(pc,0) if isinstance(pc,str) else int(pc)
    except: pc=-1
    rows.append((str(v(r,'timestamp') or ''),pid(r),gen,pc,str(v(r,'eventMessage','message') or '').replace('\n','\\n')))
by=collections.defaultdict(list)
for row in rows:by[row[1]].append(row)
for p in by:by[p].sort()
print('GOLDEN_BOOT3M_EXACT_ROW_COUNT='+str(len(rows)))
print('GOLDEN_BOOT3M_EXACT_PID_COUNT='+str(len(by)))
for p in sorted(by):
    rs=by[p]; gens=sorted(set(x[2] for x in rs)); pcs=collections.Counter(x[3] for x in rs)
    seq='>'.join('0x%X'%x[3] for x in rs)
    print(f'BOOT_PID_LANE|PID={p}|GENERATIONS={",".join(gens)}|COUNT={len(rs)}|FIRST={rs[0][0]}|LAST={rs[-1][0]}|PC_COUNTS='+';'.join(f'0x{k:X}:{n}' for k,n in sorted(pcs.items()))+f'|SEQUENCE={seq}')
    seen=set()
    for ts,pidv,g,pc,msg in rs:
        key=(pc,msg)
        if key in seen:continue
        seen.add(key)
        print(f'BOOT_PID_REPRESENTATIVE|PID={p}|GEN={g}|PC=0x{pc:X}|TS={ts}|MSG={msg}')
print('TAHOE_REFERENCE|32023=79|3802=0|PC_0x9FFEE=7|PC_0xA0521=7|PC_0xA5F81=65|PID_COUNT=65')
print('D97AV_GOLDEN_BOOT_PID_LANE_AUDIT=COMPLETE')
PY

echo
echo "===== EVIDENCE BOUNDARY ====="
echo "D97AV_RAW_SIX_COUNTER_VALUES=UNKNOWN_ATTACH_DENIED_D97AU"
echo "D97AV_BOOT_GENERATION_DIFFERENCE=OBSERVED_BOOT_ALIGNED_NOT_YET_CAUSAL"
echo "D97AV_BACKEND_LANE_DIFFERENCE=OBSERVED_BOOT_ALIGNED_NOT_YET_CAUSAL"
echo "D97AV_AUDIT=COMPLETE"
echo "SYSTEM_FILE_MUTATION=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
