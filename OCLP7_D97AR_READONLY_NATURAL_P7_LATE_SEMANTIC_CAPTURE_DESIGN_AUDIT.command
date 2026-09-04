#!/bin/zsh -f
set -euo pipefail

TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"
EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
IMAGE_BASE="0x7FFB1622A000"
FUNC_START="0x9D132"
FUNC_END="0x9D830"
LATE_START="0x9D680"
LATE_END="0x9D830"
FORMER_D97AD_SITE="0x9D6BD"
FORMER_D97AD_NATURAL_BYTES="8b8d10feffff83f941"
LATE_XREFS="0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D"
OUT="$HOME/Desktop/OCLP7_D97AR_NATURAL_P7_LATE_SEMANTIC_CAPTURE_DESIGN_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AR.XXXXXX)"
OTOOL_OUT="$TMP/otool.txt"
NM_OUT="$TMP/nm.txt"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AR.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT

fail(){
  echo "D97AR_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SOURCE_MUTATION=NO"
  echo "INSTALLED_APP_MUTATION=NO"
  echo "SYSTEM_TARGET_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail PYTHON3_MISSING
[[ -x /usr/bin/otool ]] || fail OTOOL_MISSING
[[ -x /usr/bin/nm ]] || fail NM_MISSING
[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail TARGET_INVALID

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AR — READ-ONLY NATURAL P7 LATE SEMANTIC CAPTURE DESIGN AUDIT ====="
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "FUNCTION_RANGE=$FUNC_START..$FUNC_END"
echo "LATE_REGION=$LATE_START..$LATE_END"
echo "FORMER_D97AD_SITE=$FORMER_D97AD_SITE"
echo "LATE_XREFS=$LATE_XREFS"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

ACTUAL_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$TARGET")"
echo "TARGET_BYTES=$ACTUAL_BYTES"
echo "TARGET_SHA256=$ACTUAL_SHA"
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail TARGET_SHA_MISMATCH

/usr/bin/otool -tvV "$TARGET" > "$OTOOL_OUT" 2>&1 || fail OTOOL_FAILED
/usr/bin/nm -nm "$TARGET" > "$NM_OUT" 2>&1 || fail NM_FAILED

"$PYTHON" - "$TARGET" "$OTOOL_OUT" "$NM_OUT" "$EXPECTED_UUID" "$IMAGE_BASE" "$FUNC_START" "$FUNC_END" "$LATE_START" "$LATE_END" "$FORMER_D97AD_SITE" "$FORMER_D97AD_NATURAL_BYTES" "$LATE_XREFS" <<'PY'
from __future__ import annotations
import collections,re,struct,sys
from pathlib import Path

binary=Path(sys.argv[1]); otool=Path(sys.argv[2]); nm=Path(sys.argv[3])
expected_uuid=sys.argv[4].upper(); image_base=int(sys.argv[5],16)
func_start_off=int(sys.argv[6],16); func_end_off=int(sys.argv[7],16)
late_start_off=int(sys.argv[8],16); late_end_off=int(sys.argv[9],16)
former_off=int(sys.argv[10],16); former_bytes=bytes.fromhex(sys.argv[11]); late_xrefs=[int(x,16) for x in sys.argv[12].split(',')]

data=binary.read_bytes()
if struct.unpack_from('<I',data,0)[0]!=0xFEEDFACF: raise SystemExit('MACHO_MAGIC_FAIL')
pos=32; ncmds=struct.unpack_from('<IiiIIIII',data,0)[4]; segs=[]; uuid=None
for _ in range(ncmds):
    cmd,sz=struct.unpack_from('<II',data,pos)
    if cmd==0x19 and sz>=72:
        name=data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace'); vm,vms,fileoff,filesize=struct.unpack_from('<QQQQ',data,pos+24); segs.append((name,vm,vms,fileoff,filesize))
    elif cmd==0x1B and sz>=24:
        u=data[pos+8:pos+24]; uuid=f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
    pos+=sz
print(f'MACHO_LC_UUID={uuid}')
if uuid!=expected_uuid: raise SystemExit('UUID_MISMATCH')
print('D97AR_TARGET_IDENTITY=PASS')

# file mapping check for former D97AD site
addr=image_base+former_off
fo=None
for name,vm,vms,fileoff,filesize in segs:
    if vm<=addr<vm+min(vms,filesize): fo=fileoff+(addr-vm); break
if fo is None: raise SystemExit('FORMER_SITE_MAPPING_FAIL')
actual=data[fo:fo+len(former_bytes)]
print(f'FORMER_D97AD_SITE_BYTES_ACTUAL={actual.hex()}')
if actual!=former_bytes: raise SystemExit('FORMER_SITE_BYTES_MISMATCH')
print('D97AR_FORMER_D97AD_SITE_NATURAL_BYTES=PASS')

rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst=[]
for line in otool.read_text(encoding='utf-8',errors='replace').splitlines():
    m=rx.match(line)
    if not m: continue
    try:a=int(m.group(1),16)
    except:continue
    body=m.group(2).strip()
    if not body: continue
    p=body.split(None,1); inst.append((a,p[0].lower(),p[1].strip() if len(p)>1 else '',body))
inst.sort(); by={x[0]:x for x in inst}; addrs=[x[0] for x in inst]; nxt={addrs[i]:addrs[i+1] for i in range(len(addrs)-1)}
func_start=image_base+func_start_off; func_end=image_base+func_end_off; late_start=image_base+late_start_off; late_end=image_base+late_end_off
f=[x for x in inst if func_start<=x[0]<func_end]; late=[x for x in inst if late_start<=x[0]<late_end]
print(f'FUNCTION_INSTRUCTION_COUNT={len(f)}')
print(f'LATE_REGION_INSTRUCTION_COUNT={len(late)}')

print('===== EXACT LATE REGION DISASSEMBLY =====')
for a,mn,op,body in late: print(f'LATE_INST|IMAGE_OFFSET=0x{a-image_base:X}|VM=0x{a:X}|{body}')

# Collect stack locals and registers touched in late region.
stack=collections.Counter(); regs=collections.Counter(); calls=[]
stack_re=re.compile(r'(-?0x[0-9a-fA-F]+)\(%rbp\)')
reg_re=re.compile(r'%([a-z][a-z0-9]+)')
for a,mn,op,body in late:
    for s in stack_re.findall(body): stack[s.lower()]+=1
    for r in reg_re.findall(body): regs[r.lower()]+=1
    if mn in ('call','callq'): calls.append((a,body))
print('===== LATE STACK/REGISTER INVENTORY =====')
print('LATE_RBP_LOCAL_COUNT='+str(len(stack)))
for k,v in sorted(stack.items(),key=lambda kv:int(kv[0],16) if not kv[0].startswith('-') else -int(kv[0][1:],16)): print(f'RBP_LOCAL|OFFSET={k}|REF_COUNT={v}')
print('LATE_REGISTER_COUNT='+str(len(regs)))
for k,v in sorted(regs.items()): print(f'REGISTER|NAME=%{k}|REF_COUNT={v}')
print('LATE_CALL_COUNT='+str(len(calls)))
for a,b in calls: print(f'LATE_CALL|IMAGE_OFFSET=0x{a-image_base:X}|TEXT={b}')

# Predicate map: for each late xref, locate immediately preceding conditional branch / compare window and following continuation.
cond_mn={'ja','jae','jb','jbe','je','jne','jg','jge','jl','jle','jz','jnz','jc','jnc','jo','jno','js','jns','jp','jnp'}
print('===== FIVE LATE PREDICATE WINDOWS =====')
for off in late_xrefs:
    target=image_base+off
    if target not in by: raise SystemExit(f'LATE_XREF_NOT_INSTRUCTION_0x{off:X}')
    idx=addrs.index(target)
    window=inst[max(0,idx-8):min(len(inst),idx+12)]
    prev_branch=None; prev_cmp=None
    for row in reversed(inst[max(0,idx-12):idx]):
        if prev_branch is None and row[1] in cond_mn: prev_branch=row
        if prev_cmp is None and (row[1].startswith('cmp') or row[1].startswith('test')): prev_cmp=row
        if prev_branch and prev_cmp: break
    print(f'PREDICATE_BEGIN|XREF=0x{off:X}')
    if prev_cmp: print(f'PREDICATE_COMPARE|IMAGE_OFFSET=0x{prev_cmp[0]-image_base:X}|TEXT={prev_cmp[3]}')
    else: print('PREDICATE_COMPARE=MISSING')
    if prev_branch: print(f'PREDICATE_BRANCH|IMAGE_OFFSET=0x{prev_branch[0]-image_base:X}|TEXT={prev_branch[3]}|FALLTHROUGH=0x{nxt.get(prev_branch[0],0)-image_base:X}')
    else: print('PREDICATE_BRANCH=MISSING')
    print(f'PREDICATE_XREF|IMAGE_OFFSET=0x{off:X}|TEXT={by[target][3]}')
    for a,mn,op,body in window: print(f'PREDICATE_CONTEXT|XREF=0x{off:X}|IMAGE_OFFSET=0x{a-image_base:X}|{body}')
    print(f'PREDICATE_END|XREF=0x{off:X}')

# Return/unwind sites in natural validator.
print('===== NATURAL RETURN / TERMINAL SITES =====')
returns=[]
for a,mn,op,body in f:
    if mn.startswith('ret') or mn in ('ud2','int3','hlt'):
        returns.append((a,mn,body))
        print(f'FUNCTION_TERMINAL|IMAGE_OFFSET=0x{a-image_base:X}|MNEMONIC={mn}|TEXT={body}')
print('FUNCTION_TERMINAL_COUNT='+str(len(returns)))

# Candidate capture boundaries are compare and conditional branch sites only; no mutation claim.
print('===== SEMANTIC CAPTURE DESIGN MATRIX =====')
for off in late_xrefs:
    target=image_base+off; idx=addrs.index(target)
    prevs=inst[max(0,idx-12):idx]
    cmp_row=next((r for r in reversed(prevs) if r[1].startswith('cmp') or r[1].startswith('test')),None)
    br_row=next((r for r in reversed(prevs) if r[1] in cond_mn),None)
    locals_here=[]
    for r in ([cmp_row,br_row] if cmp_row or br_row else []):
        if r:
            locals_here += stack_re.findall(r[3])
    print(f'CAPTURE_DESIGN|XREF=0x{off:X}|COMPARE={"0x%X"%(cmp_row[0]-image_base) if cmp_row else "MISSING"}|BRANCH={"0x%X"%(br_row[0]-image_base) if br_row else "MISSING"}|RBP_LOCALS={",".join(dict.fromkeys(locals_here)) if locals_here else "NONE"}|NEEDED=RAW_OPERANDS_PLUS_RFLAGS_BEFORE_BRANCH|EVIDENCE_IF_CAPTURED=SEMANTIC_OR_STRUCTURAL_SEMANTIC_PLUS_CONTROL_FLOW')

print('CAPTURE_CHANNEL_UNIFIED_LOG_RAW_NUMERIC_RELIABLE=NO_PROOF_CURRENTLY')
print('CAPTURE_CHANNEL_LAUNCHD_EXIT_CODE_CAPACITY=INSUFFICIENT_FOR_SIX_RAW_VALUES')
print('CAPTURE_CHANNEL_CRASH_REGISTER_REPORTING=HISTORICALLY_UNRELIABLE_FOR_CURRENT_COHORT')
print('D97AR_SAFE_RAW_NUMERIC_OUTPUT_CHANNEL=UNPROVEN_REQUIRES_SEPARATE_DESIGN')
print('D97AR_SEMANTIC_CAPTURE_STATIC_DESIGN_AUDIT=PASS')
PY

echo "===== FINAL MUTATION LEDGER ====="
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D97AR_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
