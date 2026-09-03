#!/bin/zsh -f
set -euo pipefail

TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e"
EXPECTED_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
EXPECTED_VESA_BOOT_SEC="1788466673"
FUNC_START_OFF="0x9D132"
FUNC_END_OFF="0x9D830"
LATE_START_OFF="0x9D6C5"
LATE_END_OFF="0x9D77F"
KNOWN_XREF_OFFSETS="0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D"
OUT="$HOME/Desktop/OCLP7_D97AK_A4F_FULL_IMAGE_DIAGNOSTIC_ORIGIN_AND_EXTERNAL_ENTRY_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AK.XXXXXX)"
OTOOL_OUT="$TMP/otool.txt"
NM_OUT="$TMP/nm.txt"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AK.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AK_AUDIT=FAIL_CLOSED|REASON=$1"
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

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AK — READ-ONLY A4F FULL-IMAGE DIAGNOSTIC ORIGIN / EXTERNAL ENTRY AUDIT ====="
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "FUNC_START_IMAGE_OFFSET=$FUNC_START_OFF"
echo "FUNC_END_IMAGE_OFFSET=$FUNC_END_OFF"
echo "LATE_REGION_IMAGE_OFFSETS=$LATE_START_OFF..$LATE_END_OFF"
echo "KNOWN_XREF_IMAGE_OFFSETS=$KNOWN_XREF_OFFSETS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail "TARGET_MISSING_NOT_REGULAR_OR_SYMLINK"
[[ -x /usr/bin/otool ]] || fail "OTOOL_MISSING"
[[ -x /usr/bin/nm ]] || fail "NM_MISSING"
PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\1/')"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"
[[ "$BOOT_SEC" == "$EXPECTED_VESA_BOOT_SEC" ]] || fail "BOOT_CHRONOLOGY_CHANGED"
echo "CURRENT_VESA_BOOT_IDENTITY=PASS"

ACTUAL_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$TARGET")"
echo "TARGET_BYTES=$ACTUAL_BYTES"
echo "TARGET_SHA256=$ACTUAL_SHA"
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail "TARGET_SHA_MISMATCH_NOT_EXACT_A4F"
echo "A4F_TARGET_SHA_IDENTITY=PASS"

/usr/bin/otool -tvV "$TARGET" > "$OTOOL_OUT" 2>&1 || fail "OTOOL_DISASSEMBLY_FAILED"
/usr/bin/nm -nm "$TARGET" > "$NM_OUT" 2>&1 || fail "NM_FAILED"
echo "OTOOL_OUTPUT_BYTES=$(/usr/bin/stat -f '%z' "$OTOOL_OUT")"
echo "NM_OUTPUT_BYTES=$(/usr/bin/stat -f '%z' "$NM_OUT")"

"$PYTHON" - "$TARGET" "$OTOOL_OUT" "$NM_OUT" "$EXPECTED_UUID" "$FUNC_START_OFF" "$FUNC_END_OFF" "$LATE_START_OFF" "$LATE_END_OFF" "$KNOWN_XREF_OFFSETS" <<'PY'
import bisect
import collections
import re
import struct
import sys
from pathlib import Path

binary_path = Path(sys.argv[1])
otool_path = Path(sys.argv[2])
nm_path = Path(sys.argv[3])
expected_uuid = sys.argv[4].upper()
func_start_off = int(sys.argv[5], 16)
func_end_off = int(sys.argv[6], 16)
late_start_off = int(sys.argv[7], 16)
late_end_off = int(sys.argv[8], 16)
known_xref_offsets = [int(x,16) for x in sys.argv[9].split(',')]

strings = [
    "only %u buffers are supported in the simulator but %u were used",
    "only %u sampelrs are supported in the simulator but %u were used",
    "only %u textures are supported in the simulator but %u were used",
    "only %u constant buffers binding are supported in the simulator but %u were used",
    "fragment shader has %u interpolated inputs but only %u are supported in the simulator",
]
labels = ["BUFFERS","SAMPLERS","TEXTURES","CONSTANT_BUFFERS","INTERPOLATED_INPUTS"]

data = binary_path.read_bytes()
if len(data) < 32:
    raise SystemExit("MACHO_TOO_SMALL")
magic = struct.unpack_from('<I', data, 0)[0]
if magic != 0xFEEDFACF:
    raise SystemExit(f"UNSUPPORTED_MACHO_MAGIC=0x{magic:08X}")

_, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags, reserved = struct.unpack_from('<IiiIIIII', data, 0)
pos = 32
segments = []
sections = []
lc_uuid = None
for _ in range(ncmds):
    if pos + 8 > len(data):
        raise SystemExit("LOAD_COMMAND_TRUNCATED")
    cmd, cmdsize = struct.unpack_from('<II', data, pos)
    if cmdsize < 8 or pos + cmdsize > len(data):
        raise SystemExit("LOAD_COMMAND_SIZE_INVALID")
    if cmd == 0x19 and cmdsize >= 72:
        segname = data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace')
        vmaddr, vmsize, fileoff, filesize = struct.unpack_from('<QQQQ', data, pos+24)
        maxprot, initprot, nsects, segflags = struct.unpack_from('<iiII', data, pos+56)
        segments.append((segname, vmaddr, vmsize, fileoff, filesize, initprot))
        so = pos + 72
        for i in range(nsects):
            q = so + i*80
            if q + 80 > pos + cmdsize:
                raise SystemExit("SECTION_TABLE_TRUNCATED")
            sectname = data[q:q+16].split(b'\0',1)[0].decode('ascii','replace')
            ssegname = data[q+16:q+32].split(b'\0',1)[0].decode('ascii','replace')
            addr, size = struct.unpack_from('<QQ', data, q+32)
            offset = struct.unpack_from('<I', data, q+48)[0]
            sflags = struct.unpack_from('<I', data, q+64)[0]
            sections.append((ssegname, sectname, addr, size, offset, sflags))
    elif cmd == 0x1B and cmdsize >= 24:
        u = data[pos+8:pos+24]
        lc_uuid = f"{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}".upper()
    pos += cmdsize

texts = [s for s in segments if s[0] == '__TEXT']
if len(texts) != 1:
    raise SystemExit(f"TEXT_SEGMENT_COUNT={len(texts)}")
_, image_base, text_vmsize, text_fileoff, text_filesize, text_prot = texts[0]
print(f"MACHO_CPU_TYPE={cputype}")
print(f"MACHO_CPU_SUBTYPE={cpusubtype}")
print(f"MACHO_LC_UUID={lc_uuid}")
print(f"MACHO_IMAGE_BASE=0x{image_base:X}")
if lc_uuid != expected_uuid:
    raise SystemExit("LC_UUID_MISMATCH")
print("A4F_TARGET_LC_UUID_IDENTITY=PASS")

func_start = image_base + func_start_off
func_end = image_base + func_end_off
late_start = image_base + late_start_off
late_end = image_base + late_end_off
known_xref_addrs = [image_base+x for x in known_xref_offsets]

# File-offset/VM helpers.
def fileoff_to_vm(off):
    for segname, vmaddr, vmsize, fileoff, filesize, prot in segments:
        if fileoff <= off < fileoff + filesize:
            return vmaddr + (off-fileoff), segname
    return None, None

def vm_to_fileoff(vm):
    for segname, vmaddr, vmsize, fileoff, filesize, prot in segments:
        if vmaddr <= vm < vmaddr + filesize:
            return fileoff + (vm-vmaddr), segname
    return None, None

def section_for_fileoff(off):
    for sg,sn,addr,size,fo,fl in sections:
        if fo <= off < fo + size:
            return f"{sg},{sn}"
    return "NONE"

def section_for_vm(vm):
    for sg,sn,addr,size,fo,fl in sections:
        if addr <= vm < addr + size:
            return f"{sg},{sn}"
    return "NONE"

# Parse all disassembled instructions.
rx = re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst = []
for line in otool_path.read_text(encoding='utf-8', errors='replace').splitlines():
    m = rx.match(line)
    if not m:
        continue
    try:
        a = int(m.group(1),16)
    except ValueError:
        continue
    body = m.group(2).strip()
    if not body:
        continue
    p = body.split(None,1)
    inst.append((a,p[0].lower(),p[1].strip() if len(p)>1 else '',body))
inst.sort()
if not inst:
    raise SystemExit("NO_DISASSEMBLY")
by_addr = {x[0]:x for x in inst}
addrs = [x[0] for x in inst]
next_addr = {addrs[i]:addrs[i+1] for i in range(len(addrs)-1)}
print(f"FULL_IMAGE_DISASSEMBLED_INSTRUCTION_COUNT={len(inst)}")

# Parse nm symbols and provide best-effort function ownership.
symbols = []
for ln in nm_path.read_text(encoding='utf-8', errors='replace').splitlines():
    m = re.match(r'^\s*([0-9A-Fa-f]{8,16})\s+(.+)$', ln)
    if not m:
        continue
    try:
        a = int(m.group(1),16)
    except ValueError:
        continue
    rest = m.group(2).strip()
    symbols.append((a,rest))
symbols.sort()
sym_addrs = [x[0] for x in symbols]

def owner(vm):
    i = bisect.bisect_right(sym_addrs, vm)-1
    if i < 0:
        return "NO_PRECEDING_SYMBOL"
    a,n = symbols[i]
    nxt = symbols[i+1][0] if i+1 < len(symbols) else None
    if nxt is not None and vm >= nxt:
        return "NO_SYMBOL_RANGE"
    return f"0x{a:X}:{n}"

# Locate exact NUL-terminated strings, including duplicates if any.
string_vms = {}
print("===== EXACT STRING LITERALS =====")
for lab,s in zip(labels,strings):
    needle = s.encode('utf-8') + b'\0'
    offs=[]
    start=0
    while True:
        p=data.find(needle,start)
        if p<0: break
        offs.append(p)
        start=p+1
    vms=[]
    for off in offs:
        vm,seg=fileoff_to_vm(off)
        vms.append(vm)
        print(f"STRING_LITERAL|LABEL={lab}|FILE_OFFSET=0x{off:X}|VM={('0x%X'%vm) if vm is not None else 'UNMAPPED'}|SEGMENT={seg}|SECTION={section_for_fileoff(off)}|TEXT={s}")
    string_vms[lab]=[v for v in vms if v is not None]
    print(f"STRING_LITERAL_COUNT|LABEL={lab}|COUNT={len(offs)}")

if any(len(string_vms[x]) != 1 for x in labels):
    print("EXACT_FIVE_LITERAL_UNIQUENESS=FAIL")
else:
    print("EXACT_FIVE_LITERAL_UNIQUENESS=PASS")

# RIP-relative target decoder. next instruction gives RIP after current instruction.
rip_re = re.compile(r'(-?0x[0-9A-Fa-f]+)\(%rip\)')
def rip_targets(addr, operands):
    nxt = next_addr.get(addr)
    if nxt is None:
        return []
    out=[]
    for m in rip_re.finditer(operands):
        q=m.group(1)
        d=-int(q[3:],16) if q.startswith('-0x') else int(q,16)
        out.append(nxt+d)
    return out

# One-level absolute pointer indirection to each string literal.
pointer_vms_by_label=collections.defaultdict(list)
print("===== ABSOLUTE POINTERS TO STRING LITERALS =====")
for lab in labels:
    for svm in string_vms[lab]:
        needle=struct.pack('<Q',svm)
        start=0
        while True:
            p=data.find(needle,start)
            if p<0: break
            pvm,pseg=fileoff_to_vm(p)
            pointer_vms_by_label[lab].append(pvm)
            print(f"STRING_POINTER|LABEL={lab}|FILE_OFFSET=0x{p:X}|VM={('0x%X'%pvm) if pvm is not None else 'UNMAPPED'}|SEGMENT={pseg}|SECTION={section_for_fileoff(p)}")
            start=p+1
    print(f"STRING_POINTER_COUNT|LABEL={lab}|COUNT={len(pointer_vms_by_label[lab])}")

# Exhaustive direct and one-level-indirect code xrefs to each literal.
print("===== FULL-IMAGE CODE XREFS TO DIAGNOSTIC STRINGS =====")
all_xrefs=collections.defaultdict(list)
indirect_xrefs=collections.defaultdict(list)
for addr,mn,op,body in inst:
    rtargets=rip_targets(addr,op)
    if not rtargets:
        continue
    for lab in labels:
        for svm in string_vms[lab]:
            if svm in rtargets:
                all_xrefs[lab].append(addr)
                print(f"DIRECT_STRING_XREF|LABEL={lab}|FROM_VM=0x{addr:X}|FROM_IMAGE_OFFSET=0x{addr-image_base:X}|OWNER={owner(addr)}|TEXT={body}")
        pset={x for x in pointer_vms_by_label[lab] if x is not None}
        for t in rtargets:
            if t in pset:
                indirect_xrefs[lab].append(addr)
                print(f"INDIRECT_STRING_POINTER_XREF|LABEL={lab}|FROM_VM=0x{addr:X}|FROM_IMAGE_OFFSET=0x{addr-image_base:X}|POINTER_VM=0x{t:X}|OWNER={owner(addr)}|TEXT={body}")

additional_direct=[]
known_pairs=dict(zip(labels,known_xref_addrs))
for lab in labels:
    unique=sorted(set(all_xrefs[lab]))
    indirect=sorted(set(indirect_xrefs[lab]))
    expected=known_pairs[lab]
    print(f"STRING_XREF_SUMMARY|LABEL={lab}|DIRECT_COUNT={len(unique)}|INDIRECT_POINTER_COUNT={len(indirect)}|KNOWN_XREF_VM=0x{expected:X}|KNOWN_PRESENT={'YES' if expected in unique else 'NO'}")
    for a in unique:
        if a != expected:
            additional_direct.append((lab,a))

print(f"ADDITIONAL_DIRECT_STRING_XREF_COUNT={len(additional_direct)}")
print(f"TOTAL_INDIRECT_STRING_POINTER_XREF_COUNT={sum(len(set(indirect_xrefs[x])) for x in labels)}")

# Direct branch/call targets from outside validator into validator interior.
hex_re = re.compile(r'0x([0-9A-Fa-f]+)')
def direct_target(op):
    m=hex_re.search(op)
    if m: return int(m.group(1),16)
    m=re.search(r'\b([0-9A-Fa-f]{6,16})\b',op)
    if m: return int(m.group(1),16)
    return None

external_entry=[]
external_late=[]
print("===== DIRECT EXTERNAL CONTROL-FLOW INTO VALIDATOR INTERIOR =====")
for addr,mn,op,body in inst:
    if func_start <= addr < func_end:
        continue
    if not (mn.startswith('j') or mn.startswith('call')):
        continue
    if op.lstrip().startswith('*'):
        continue
    t=direct_target(op)
    if t is None:
        continue
    if func_start < t < func_end:
        external_entry.append((addr,t,body))
        if late_start <= t <= late_end:
            external_late.append((addr,t,body))
        print(f"EXTERNAL_DIRECT_ENTRY|FROM_VM=0x{addr:X}|FROM_IMAGE_OFFSET=0x{addr-image_base:X}|FROM_OWNER={owner(addr)}|TO_VM=0x{t:X}|TO_IMAGE_OFFSET=0x{t-image_base:X}|TO_LATE_REGION={'YES' if late_start<=t<=late_end else 'NO'}|TEXT={body}")
print(f"EXTERNAL_DIRECT_INTERIOR_ENTRY_COUNT={len(external_entry)}")
print(f"EXTERNAL_DIRECT_LATE_REGION_ENTRY_COUNT={len(external_late)}")

# RIP-relative address-taking references from outside validator into validator text.
address_taken=[]
address_taken_late=[]
print("===== RIP-RELATIVE ADDRESS-TAKEN REFERENCES INTO VALIDATOR =====")
for addr,mn,op,body in inst:
    if func_start <= addr < func_end:
        continue
    for t in rip_targets(addr,op):
        if func_start <= t < func_end:
            address_taken.append((addr,t,body))
            if late_start <= t <= late_end:
                address_taken_late.append((addr,t,body))
            print(f"EXTERNAL_RIP_CODE_REFERENCE|FROM_VM=0x{addr:X}|FROM_IMAGE_OFFSET=0x{addr-image_base:X}|FROM_OWNER={owner(addr)}|TO_VM=0x{t:X}|TO_IMAGE_OFFSET=0x{t-image_base:X}|TO_LATE_REGION={'YES' if late_start<=t<=late_end else 'NO'}|TEXT={body}")
print(f"EXTERNAL_RIP_VALIDATOR_REFERENCE_COUNT={len(address_taken)}")
print(f"EXTERNAL_RIP_LATE_REGION_REFERENCE_COUNT={len(address_taken_late)}")

# Raw 64-bit absolute pointers to the five known late xref instruction addresses.
raw_late_ptrs=[]
print("===== RAW ABSOLUTE POINTERS TO KNOWN LATE XREF ADDRESSES =====")
for lab,target in zip(labels,known_xref_addrs):
    needle=struct.pack('<Q',target)
    start=0
    count=0
    while True:
        p=data.find(needle,start)
        if p<0: break
        pvm,pseg=fileoff_to_vm(p)
        count+=1
        raw_late_ptrs.append((lab,p,pvm,pseg))
        print(f"RAW_LATE_POINTER|LABEL={lab}|TARGET_VM=0x{target:X}|FILE_OFFSET=0x{p:X}|POINTER_VM={('0x%X'%pvm) if pvm is not None else 'UNMAPPED'}|SEGMENT={pseg}|SECTION={section_for_fileoff(p)}")
        start=p+1
    print(f"RAW_LATE_POINTER_COUNT|LABEL={lab}|COUNT={count}")
print(f"RAW_ABSOLUTE_LATE_POINTER_TOTAL={len(raw_late_ptrs)}")

print("===== KNOWN XREF OWNERS =====")
for lab,a in zip(labels,known_xref_addrs):
    row=by_addr.get(a)
    print(f"KNOWN_XREF_OWNER|LABEL={lab}|VM=0x{a:X}|IMAGE_OFFSET=0x{a-image_base:X}|OWNER={owner(a)}|TEXT={row[3] if row else 'MISSING'}")

known_present_all=all(known_pairs[lab] in set(all_xrefs[lab]) for lab in labels)
unique_literals_all=all(len(string_vms[x])==1 for x in labels)
indirect_count=sum(len(set(indirect_xrefs[x])) for x in labels)

print("===== CLASSIFICATION =====")
print(f"KNOWN_FIVE_DIRECT_XREFS_ALL_PRESENT={'PASS' if known_present_all else 'FAIL'}")
print(f"ADDITIONAL_DIRECT_STRING_XREF_COUNT={len(additional_direct)}")
print(f"INDIRECT_STRING_POINTER_XREF_COUNT={indirect_count}")
print(f"EXTERNAL_DIRECT_LATE_REGION_ENTRY_COUNT={len(external_late)}")
print(f"EXTERNAL_RIP_LATE_REGION_REFERENCE_COUNT={len(address_taken_late)}")
if not unique_literals_all or not known_present_all:
    print("D97AK_DIAGNOSTIC_ORIGIN=INCONCLUSIVE_LITERAL_OR_KNOWN_XREF_IDENTITY")
elif additional_direct:
    print("D97AK_DIAGNOSTIC_ORIGIN=ALTERNATE_DIRECT_CODE_XREF_STATIC_PROVEN")
elif indirect_count:
    print("D97AK_DIAGNOSTIC_ORIGIN=INDIRECT_POINTER_XREF_EVIDENCE_REQUIRES_MAPPING")
elif external_late or address_taken_late:
    print("D97AK_DIAGNOSTIC_ORIGIN=EXTERNAL_LATE_ENTRY_OR_ADDRESS_TAKEN_EVIDENCE")
else:
    print("D97AK_DIAGNOSTIC_ORIGIN=ONLY_KNOWN_UNREACHABLE_DIRECT_XREFS_ZERO_STATIC_EXTERNAL_LATE_ENTRY")
print("D97AK_A4F_FULL_IMAGE_DIAGNOSTIC_ORIGIN_AND_EXTERNAL_ENTRY_AUDIT=PASS")
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
echo "D97AK_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
