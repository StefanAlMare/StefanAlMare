#!/bin/zsh -f
set -euo pipefail

TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"
EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
FUNC_START_OFF="0x9D132"
FUNC_END_OFF="0x9D830"
SWITCH_OFF="0x9D3AB"
SWITCH_TARGET_RELS="0x27B,0x281,0x36F,0x2B2,0x2CE,0x36F,0x2FF"
SPAN_START_OFF="0x9D6BD"
SPAN_END_OFF="0x9D72D"
SPAN_LEN_DEC="112"
D34_PROTECTED_START="0xEF8"
D34_PROTECTED_END="0xEFE"
EXIT_BASE="160"
OUT="$HOME/Desktop/OCLP7_D97AS_SIX_PREDICATE_BITMASK_TERMINAL_CLASSIFIER_FEASIBILITY_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AS.XXXXXX)"
ORIG_OTOOL="$TMP/orig.otool.txt"
PATCHED="$TMP/MTLCompiler.synthetic-d97as"
PATCHED_OTOOL="$TMP/patched.otool.txt"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AS.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT

fail(){
    echo "D97AS_AUDIT=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "SERVICE_LAUNCH=AUTO-NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "SNAPSHOT_MUTATION=NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"
[[ -x /usr/bin/otool ]] || fail "OTOOL_MISSING"
[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail "TARGET_MISSING_NOT_REGULAR_OR_SYMLINK"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AS — READ-ONLY SIX-PREDICATE BITMASK TERMINAL CLASSIFIER FEASIBILITY AUDIT ====="
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "FUNCTION_RANGE=$FUNC_START_OFF..$FUNC_END_OFF"
echo "KNOWN_SWITCH=$SWITCH_OFF"
echo "SPAN_START=$SPAN_START_OFF"
echo "SPAN_END_EXCLUSIVE=$SPAN_END_OFF"
echo "SPAN_LEN=$SPAN_LEN_DEC"
echo "EXIT_BASE=$EXIT_BASE"
echo "BIT0=BUFFERS_GE_65"
echo "BIT1=SAMPLERS_GE_17"
echo "BIT2=TEXTURES_GE_129"
echo "BIT3=CONSTANT_BUFFERS_GE_15"
echo "BIT4=INTERPOLATED_INPUTS_GE_32"
echo "BIT5=INTERPOLATED_COMPONENT_INPUTS_GE_125"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

ACTUAL_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$TARGET")"
echo "TARGET_BYTES=$ACTUAL_BYTES"
echo "TARGET_SHA256=$ACTUAL_SHA"
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail "TARGET_SHA_MISMATCH"

/usr/bin/otool -tvV "$TARGET" > "$ORIG_OTOOL" 2>&1 || fail "ORIGINAL_OTOOL_FAILED"

"$PYTHON" - "$TARGET" "$ORIG_OTOOL" "$PATCHED" "$EXPECTED_UUID" "$FUNC_START_OFF" "$FUNC_END_OFF" "$SWITCH_OFF" "$SWITCH_TARGET_RELS" "$SPAN_START_OFF" "$SPAN_END_OFF" "$D34_PROTECTED_START" "$D34_PROTECTED_END" "$EXIT_BASE" <<'PY'
from __future__ import annotations
import collections
import hashlib
import re
import struct
import sys
from pathlib import Path

binary_path=Path(sys.argv[1])
otool_path=Path(sys.argv[2])
patched_path=Path(sys.argv[3])
expected_uuid=sys.argv[4].upper()
func_start_off=int(sys.argv[5],16)
func_end_off=int(sys.argv[6],16)
switch_off=int(sys.argv[7],16)
switch_target_rels=[int(x,16) for x in sys.argv[8].split(',')]
span_start_off=int(sys.argv[9],16)
span_end_off=int(sys.argv[10],16)
d34_start=int(sys.argv[11],16)
d34_end=int(sys.argv[12],16)
exit_base=int(sys.argv[13])
span_len=span_end_off-span_start_off

# Six exact natural donor predicates from D97AR.
checks=[
    (-0x1f0,0x41,0x01,'BUFFERS_GE_65'),
    (-0x1f8,0x11,0x02,'SAMPLERS_GE_17'),
    (-0x1f4,0x81,0x04,'TEXTURES_GE_129'),
    (-0x200,0x0f,0x08,'CONSTANT_BUFFERS_GE_15'),
    (-0x1fc,0x20,0x10,'INTERPOLATED_INPUTS_GE_32'),
    (-0x1ec,0x7d,0x20,'INTERPOLATED_COMPONENT_INPUTS_GE_125'),
]

data=binary_path.read_bytes()
if len(data)<32 or struct.unpack_from('<I',data,0)[0] != 0xFEEDFACF:
    raise SystemExit('UNSUPPORTED_MACHO')
_,cputype,cpusubtype,filetype,ncmds,sizeofcmds,flags,reserved=struct.unpack_from('<IiiIIIII',data,0)
pos=32
segments=[]
lc_uuid=None
for _ in range(ncmds):
    if pos+8>len(data): raise SystemExit('LOAD_COMMAND_TRUNCATED')
    cmd,cmdsize=struct.unpack_from('<II',data,pos)
    if cmdsize<8 or pos+cmdsize>len(data): raise SystemExit('LOAD_COMMAND_INVALID')
    if cmd==0x19 and cmdsize>=72:
        segname=data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace')
        vmaddr,vmsize,fileoff,filesize=struct.unpack_from('<QQQQ',data,pos+24)
        segments.append((segname,vmaddr,vmsize,fileoff,filesize))
    elif cmd==0x1B and cmdsize>=24:
        u=data[pos+8:pos+24]
        lc_uuid=f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
    pos += cmdsize
texts=[s for s in segments if s[0]=='__TEXT']
if len(texts)!=1: raise SystemExit(f'TEXT_SEGMENT_COUNT={len(texts)}')
_,image_base,_,_,_=texts[0]
print(f'MACHO_IMAGE_BASE=0x{image_base:X}')
print(f'MACHO_LC_UUID={lc_uuid}')
if lc_uuid != expected_uuid: raise SystemExit('LC_UUID_MISMATCH')
print('D97AS_TARGET_IDENTITY=PASS')

def fileoff_for(off):
    addr=image_base+off
    for name,vmaddr,vmsize,fileoff,filesize in segments:
        mapped=min(vmsize,filesize)
        if vmaddr <= addr < vmaddr+mapped:
            return fileoff+(addr-vmaddr),name
    raise SystemExit(f'NO_FILE_MAPPING_FOR_0x{off:X}')

# Parse otool instructions.
rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
all_inst=[]
for line in otool_path.read_text(encoding='utf-8',errors='replace').splitlines():
    m=rx.match(line)
    if not m: continue
    try: addr=int(m.group(1),16)
    except ValueError: continue
    body=m.group(2).strip()
    if not body: continue
    p=body.split(None,1)
    all_inst.append((addr,p[0].lower(),p[1].strip() if len(p)>1 else '',body))
all_inst.sort()
all_by={x[0]:x for x in all_inst}
all_addrs=[x[0] for x in all_inst]
next_addr={all_addrs[i]:all_addrs[i+1] for i in range(len(all_addrs)-1)}
func_start=image_base+func_start_off
func_end=image_base+func_end_off
span_start=image_base+span_start_off
span_end=image_base+span_end_off
switch_addr=image_base+switch_off
func=[x for x in all_inst if func_start <= x[0] < func_end]
by={x[0]:x for x in func}
if not func or func[0][0]!=func_start: raise SystemExit('FUNCTION_ENTRY_DECODE_FAIL')
if span_start not in by: raise SystemExit('SPAN_START_NOT_INSTRUCTION')
if span_end not in by: raise SystemExit('SPAN_END_NOT_INSTRUCTION_BOUNDARY')
print(f'FUNCTION_INSTRUCTION_COUNT={len(func)}')
print(f'SPAN_START_TEXT={by[span_start][3]}')
print(f'SPAN_END_TEXT_UNTOUCHED={by[span_end][3]}')
print('D97AS_SPAN_INSTRUCTION_BOUNDARIES=PASS')

# Verify natural six predicate instruction identities exactly enough for semantics.
required={
    0x9D6BD: ('movl','-0x1f0(%rbp), %ecx'),
    0x9D6C3: ('cmpl','$0x41, %ecx'),
    0x9D6C6: ('jb','0x7ffb162c76e3'),
    0x9D6E3: ('movl','-0x1f8(%rbp), %ecx'),
    0x9D6E9: ('cmpl','$0x11, %ecx'),
    0x9D6EC: ('jb','0x7ffb162c7706'),
    0x9D706: ('cmpl','$0x81, -0x1f4(%rbp)'),
    0x9D710: ('jb','0x7ffb162c772f'),
    0x9D72F: ('movl','-0x200(%rbp), %ecx'),
    0x9D735: ('cmpl','$0xf, %ecx'),
    0x9D738: ('jb','0x7ffb162c7752'),
    0x9D752: ('movl','-0x1fc(%rbp), %edx'),
    0x9D758: ('cmpl','$0x20, %edx'),
    0x9D75B: ('jb','0x7ffb162c777f'),
    0x9D77F: ('movl','-0x1ec(%rbp), %ebx'),
    0x9D785: ('cmpl','$0x7d, %ebx'),
    0x9D788: ('jb','0x7ffb162c77a6'),
}
for off,(mn,opfrag) in required.items():
    row=by.get(image_base+off)
    if row is None or row[1]!=mn or opfrag not in row[2]:
        raise SystemExit(f'PREDICATE_IDENTITY_FAIL_0x{off:X}|GOT={row}')
    print(f'PREDICATE_IDENTITY|IMAGE_OFFSET=0x{off:X}|TEXT={row[3]}')
print('D97AS_SIX_NATURAL_PREDICATE_IDENTITIES=PASS')

# Check chosen span exactly covers complete instructions and no split.
span_rows=[x for x in func if span_start <= x[0] < span_end]
if not span_rows: raise SystemExit('SPAN_EMPTY')
last=span_rows[-1]
last_next=next_addr.get(last[0])
print(f'SPAN_INSTRUCTION_COUNT={len(span_rows)}')
print(f'SPAN_LAST_INSTRUCTION=0x{last[0]-image_base:X}|{last[3]}')
print(f'SPAN_LAST_NEXT=0x{last_next-image_base:X}' if last_next else 'SPAN_LAST_NEXT=MISSING')
if last_next != span_end: raise SystemExit('SPAN_END_SPLITS_INSTRUCTION')
print('D97AS_SPAN_NO_SPLIT=PASS')

# Original span preimage.
span_fileoff,span_seg=fileoff_for(span_start_off)
pre=data[span_fileoff:span_fileoff+span_len]
if len(pre)!=span_len: raise SystemExit('SPAN_PREIMAGE_SHORT')
print(f'SPAN_SEGMENT={span_seg}')
print(f'SPAN_FILE_OFFSET=0x{span_fileoff:X}')
print(f'SPAN_PREIMAGE_BYTES={len(pre)}')
print(f'SPAN_PREIMAGE_SHA256={hashlib.sha256(pre).hexdigest()}')
print(f'SPAN_PREIMAGE_HEX={pre.hex()}')

# D34 protected cave non-overlap (image/file offsets are disjoint by orders of magnitude here).
overlap=not (span_end_off <= d34_start or span_start_off > d34_end)
print(f'D34_PROTECTED_RANGE=0x{d34_start:X}..0x{d34_end:X}')
print(f'SPAN_OVERLAPS_D34={"YES" if overlap else "NO"}')
if overlap: raise SystemExit('SPAN_OVERLAPS_D34')
print('D97AS_D34_NONOVERLAP=PASS')

# Direct/control-flow entry audit. Resolve the one known switch.
hex_re=re.compile(r'0x([0-9A-Fa-f]+)')
def direct_target(op):
    m=hex_re.search(op)
    if m: return int(m.group(1),16)
    m=re.search(r'\b([0-9A-Fa-f]{6,16})\b',op)
    return int(m.group(1),16) if m else None

switch_targets=[func_start+r for r in switch_target_rels]
graph=collections.defaultdict(set)
unresolved=set()
outside_to_start=[]
outside_to_interior=[]
for addr,mn,op,body in func:
    nxt=next_addr.get(addr)
    if addr==switch_addr:
        targets=switch_targets
        graph[addr].update(targets)
    elif mn.startswith('ret') or mn in ('ud2','int3','hlt'):
        targets=[]
    elif mn in ('jmp','jmpq'):
        if op.lstrip().startswith('*'):
            unresolved.add(addr); targets=[]
        else:
            t=direct_target(op); targets=[t] if t is not None else []
            for t in targets:
                if func_start <= t < func_end and t in by: graph[addr].add(t)
    elif mn.startswith('j') or mn.startswith('loop'):
        t=direct_target(op); targets=[t] if t is not None else []
        if t is not None and func_start <= t < func_end and t in by: graph[addr].add(t)
        if nxt is not None and func_start <= nxt < func_end: graph[addr].add(nxt)
    else:
        targets=[]
        if nxt is not None and func_start <= nxt < func_end: graph[addr].add(nxt)
    if not (span_start <= addr < span_end):
        for t in graph.get(addr,()):
            if t==span_start:
                outside_to_start.append((addr,t,body))
            elif span_start < t < span_end:
                outside_to_interior.append((addr,t,body))

q=collections.deque([func_start]); prev={func_start:None}
while q:
    u=q.popleft()
    for v in graph.get(u,()):
        if v not in prev:
            prev[v]=u; q.append(v)
reachable_unresolved=sorted(a for a in unresolved if a in prev)
print(f'CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH={len(prev)}')
print(f'REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH={len(reachable_unresolved)}')
if reachable_unresolved:
    for a in reachable_unresolved: print(f'UNRESOLVED_REACHABLE|IMAGE_OFFSET=0x{a-image_base:X}|TEXT={by[a][3]}')
    raise SystemExit('REACHABLE_UNRESOLVED_INDIRECTS_REMAIN')
print(f'SPAN_START_REACHABLE_FROM_NORMAL_ENTRY={"YES" if span_start in prev else "NO"}')
if span_start not in prev: raise SystemExit('SPAN_START_NOT_REACHABLE')
print(f'OUTSIDE_TO_SPAN_START_EDGE_COUNT={len(outside_to_start)}')
for a,t,b in outside_to_start:
    print(f'OUTSIDE_TO_SPAN_START|FROM=0x{a-image_base:X}|TO=0x{t-image_base:X}|TEXT={b}')
print(f'OUTSIDE_TO_SPAN_INTERIOR_EDGE_COUNT={len(outside_to_interior)}')
for a,t,b in outside_to_interior:
    print(f'UNSAFE_OUTSIDE_TO_INTERIOR|FROM=0x{a-image_base:X}|TO=0x{t-image_base:X}|TEXT={b}')
if outside_to_interior: raise SystemExit('OUTSIDE_ENTRY_TO_CLASSIFIER_INTERIOR')
print('D97AS_SINGLE_ENTRY_SPAN_CONTROL_FLOW=PASS')

# Synthesize exact terminal classifier: mask in EDI, status=160+mask, SYS_exit, UD2.
code=bytearray(b'\x31\xff')  # xor edi,edi
for disp,thr,bit,name in checks:
    code += b'\x81\xbd' + struct.pack('<i',disp) + struct.pack('<I',thr) # cmp dword [rbp+disp], imm32
    code += b'\x72\x03'                                                    # jb +3, skip OR if below
    code += b'\x83\xcf' + bytes([bit])                                    # or edi,bit
code += b'\x81\xc7' + struct.pack('<I',exit_base)                         # add edi,160
code += b'\xb8' + struct.pack('<I',0x02000001)                             # mov eax,SYS_exit
code += b'\x0f\x05'                                                       # syscall
code += b'\x0f\x0b'                                                       # ud2 if syscall unexpectedly returns

print(f'CLASSIFIER_CODE_BYTES={len(code)}')
print(f'CLASSIFIER_SPAN_BYTES={span_len}')
print(f'CLASSIFIER_NOP_PADDING_BYTES={span_len-len(code)}')
if len(code)>span_len: raise SystemExit('CLASSIFIER_TOO_LARGE')
if span_len-len(code)<0: raise SystemExit('NEGATIVE_PADDING')

# Self-audit exact encoding structure.
p=2
if code[:2] != b'\x31\xff': raise SystemExit('ENCODE_XOR_FAIL')
for disp,thr,bit,name in checks:
    chunk=code[p:p+15]
    expected=b'\x81\xbd'+struct.pack('<i',disp)+struct.pack('<I',thr)+b'\x72\x03'+b'\x83\xcf'+bytes([bit])
    if chunk != expected: raise SystemExit('ENCODE_CHECK_FAIL_'+name)
    print(f'CLASSIFIER_CHECK|NAME={name}|RBP_DISP={disp}|THRESHOLD={thr}|BIT={bit}|ENCODING={chunk.hex()}')
    p += 15
expected_tail=b'\x81\xc7'+struct.pack('<I',exit_base)+b'\xb8'+struct.pack('<I',0x02000001)+b'\x0f\x05\x0f\x0b'
if code[p:] != expected_tail: raise SystemExit('ENCODE_TAIL_FAIL')
print(f'CLASSIFIER_TAIL_ENCODING={expected_tail.hex()}')
print(f'CLASSIFIER_CODE_SHA256={hashlib.sha256(code).hexdigest()}')
print(f'CLASSIFIER_CODE_HEX={code.hex()}')
print('CLASSIFIER_EXIT_RANGE=160..223')
print('CLASSIFIER_EXIT_160=ALL_SIX_BELOW_ERROR_THRESHOLDS')
print('CLASSIFIER_EXIT_223=ALL_SIX_AT_OR_ABOVE_ERROR_THRESHOLDS')
for mask in range(64):
    bits=[name for _,_,bit,name in checks if mask & bit]
    print(f'EXIT_MAP|STATUS={exit_base+mask}|MASK=0x{mask:02X}|TRUE={"NONE" if not bits else ",".join(bits)}')
print('D97AS_CLASSIFIER_ENCODING_SELF_AUDIT=PASS')

patch=bytes(code)+b'\x90'*(span_len-len(code))
if len(patch)!=span_len: raise SystemExit('PATCH_LENGTH_FAIL')
patched=bytearray(data)
patched[span_fileoff:span_fileoff+span_len]=patch
patched_path.write_bytes(patched)
print(f'CLASSIFIER_PATCH_BYTES={len(patch)}')
print(f'CLASSIFIER_PATCH_SHA256={hashlib.sha256(patch).hexdigest()}')
print(f'CLASSIFIER_PATCH_HEX={patch.hex()}')
print(f'SYNTHETIC_IMAGE_SHA256={hashlib.sha256(patched).hexdigest()}')
print('D97AS_TEMPORARY_SYNTHETIC_PATCH_WRITE=PASS')

# Explicit evidence contract.
print('CLASSIFIER_TERMINALITY=INTENTIONAL')
print('CLASSIFIER_CONTINUATION_CLAIM=NONE')
print('CLASSIFIER_STATE_PRESERVATION_AFTER_CAPTURE=NOT_REQUIRED_TERMINAL')
print('CLASSIFIER_SAME_COHORT_MODE=UNIVERSAL_NO_PID_FILTER')
print('CLASSIFIER_SEMANTIC_PAYLOAD=EXACT_SIX_DONOR_THRESHOLD_BOOLEANS_NOT_RAW_INTEGER_VALUES')
print('CLASSIFIER_RUNTIME_SUCCESS_IF_OBSERVED=REACHED_PLUS_EXACT_THRESHOLD_VECTOR_PER_EXIT_STATUS')
print('D97AS_STATIC_CLASSIFIER_FEASIBILITY=STATIC_PROVEN_PENDING_SYNTHETIC_DISASSEMBLY')
PY

/usr/bin/otool -tvV "$PATCHED" > "$PATCHED_OTOOL" 2>&1 || fail "SYNTHETIC_OTOOL_FAILED"

"$PYTHON" - "$PATCHED_OTOOL" "$SPAN_START_OFF" "$SPAN_END_OFF" <<'PY'
import re,sys
from pathlib import Path
p=Path(sys.argv[1])
start_off=int(sys.argv[2],16); end_off=int(sys.argv[3],16)
# Current image base is known for exact target.
image_base=0x7FFB1622A000
start=image_base+start_off; end=image_base+end_off
rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
rows=[]
for line in p.read_text(encoding='utf-8',errors='replace').splitlines():
    m=rx.match(line)
    if not m: continue
    try:a=int(m.group(1),16)
    except:continue
    if start <= a < end:
        rows.append((a,m.group(2).strip()))
print('===== SYNTHETIC CLASSIFIER DISASSEMBLY =====')
print('SYNTHETIC_SPAN_DISASSEMBLED_INSTRUCTION_COUNT='+str(len(rows)))
for a,b in rows:
    print(f'SYNTHETIC_INST|IMAGE_OFFSET=0x{a-image_base:X}|VM=0x{a:X}|{b}')
text='\n'.join(b for _,b in rows)
checks=[
    ('xor edi','%edi'),('cmp buffers','-0x1f0(%rbp)'),('cmp samplers','-0x1f8(%rbp)'),
    ('cmp textures','-0x1f4(%rbp)'),('cmp constants','-0x200(%rbp)'),
    ('cmp inputs','-0x1fc(%rbp)'),('cmp components','-0x1ec(%rbp)'),
    ('syscall','syscall'),('ud2','ud2')]
missing=[name for name,frag in checks if frag not in text]
print('SYNTHETIC_REQUIRED_DISASSEMBLY_FRAGMENT_MISSING_COUNT='+str(len(missing)))
for x in missing: print('SYNTHETIC_MISSING_FRAGMENT='+x)
if missing: raise SystemExit('SYNTHETIC_DISASSEMBLY_REQUIRED_FRAGMENT_MISSING')
print('D97AS_SYNTHETIC_CLASSIFIER_DISASSEMBLY=PASS')
print('D97AS_SIX_PREDICATE_BITMASK_TERMINAL_CLASSIFIER=STATIC_PROVEN_FEASIBLE')
PY

echo
echo "===== FINAL MUTATION LEDGER ====="
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "SNAPSHOT_MUTATION=NO"
echo "REBOOT=AUTO-NO"
echo "D97AS_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
