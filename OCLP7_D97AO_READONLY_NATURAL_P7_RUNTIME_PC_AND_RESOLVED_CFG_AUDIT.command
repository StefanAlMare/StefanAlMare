#!/bin/zsh -f
set -euo pipefail

TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"
EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
EXPECTED_VESA_BOOT_SEC="1788478349"
FUNC_START_OFF="0x9D132"
FUNC_END_OFF="0x9D830"
SWITCH_OFF="0x9D3AB"
SWITCH_REL="0x279"
SWITCH_TARGET_RELS="0x27B,0x281,0x36F,0x2B2,0x2CE,0x36F,0x2FF"
NATURAL_SITE_OFF="0x9D6BD"
NATURAL_SITE_BYTES="8b8d10feffff83f941"
LATE_OFFSETS="0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D"
RUNTIME_PC_OFFSETS="0x9FFEE,0xA0521,0xA5F81"
RUNTIME_PC_COUNTS="7,7,65"
OUT="$HOME/Desktop/OCLP7_D97AO_NATURAL_P7_RUNTIME_PC_AND_RESOLVED_CFG_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AO.XXXXXX)"
OTOOL_OUT="$TMP/otool.txt"
NM_OUT="$TMP/nm.txt"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AO.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AO_AUDIT=FAIL_CLOSED|REASON=$1"
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
[[ -x /usr/bin/nm ]] || fail "NM_MISSING"
[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail "TARGET_MISSING_NOT_REGULAR_OR_SYMLINK"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AO — READ-ONLY NATURAL P7 RUNTIME-PC + RESOLVED CFG AUDIT ====="
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "EXPECTED_CURRENT_VESA_BOOT_SEC=$EXPECTED_VESA_BOOT_SEC"
echo "FUNC_START_IMAGE_OFFSET=$FUNC_START_OFF"
echo "FUNC_END_IMAGE_OFFSET=$FUNC_END_OFF"
echo "KNOWN_SWITCH_IMAGE_OFFSET=$SWITCH_OFF"
echo "KNOWN_SWITCH_REL=$SWITCH_REL"
echo "D97AB_PROVEN_SWITCH_TARGET_RELS=$SWITCH_TARGET_RELS"
echo "NATURAL_D97AD_REMOVED_SITE_OFFSET=$NATURAL_SITE_OFF"
echo "NATURAL_D97AD_REMOVED_SITE_BYTES=$NATURAL_SITE_BYTES"
echo "LATE_DIAGNOSTIC_XREF_OFFSETS=$LATE_OFFSETS"
echo "D97AN_RUNTIME_PC_OFFSETS=$RUNTIME_PC_OFFSETS"
echo "D97AN_RUNTIME_PC_COUNTS=$RUNTIME_PC_COUNTS"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\1/')"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"
[[ "$BOOT_SEC" == "$EXPECTED_VESA_BOOT_SEC" ]] || fail "CURRENT_BOOT_CHANGED_CHRONOLOGY_INVALID"
echo "CURRENT_VESA_BOOT_IDENTITY=PASS"

ACTUAL_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$TARGET")"
echo "TARGET_BYTES=$ACTUAL_BYTES"
echo "TARGET_SHA256=$ACTUAL_SHA"
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail "TARGET_SHA_MISMATCH_NOT_EXACT_NATURAL_POSTIMAGE"
echo "D97AO_TARGET_SHA_IDENTITY=PASS"

/usr/bin/otool -tvV "$TARGET" > "$OTOOL_OUT" 2>&1 || fail "OTOOL_DISASSEMBLY_FAILED"
/usr/bin/nm -nm "$TARGET" > "$NM_OUT" 2>&1 || fail "NM_FAILED"
echo "OTOOL_OUTPUT_BYTES=$(/usr/bin/stat -f '%z' "$OTOOL_OUT")"
echo "NM_OUTPUT_BYTES=$(/usr/bin/stat -f '%z' "$NM_OUT")"

"$PYTHON" - "$TARGET" "$OTOOL_OUT" "$NM_OUT" "$EXPECTED_UUID" "$FUNC_START_OFF" "$FUNC_END_OFF" "$SWITCH_OFF" "$SWITCH_REL" "$SWITCH_TARGET_RELS" "$NATURAL_SITE_OFF" "$NATURAL_SITE_BYTES" "$LATE_OFFSETS" "$RUNTIME_PC_OFFSETS" "$RUNTIME_PC_COUNTS" <<'PY'
from __future__ import annotations

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
switch_off = int(sys.argv[7], 16)
switch_rel = int(sys.argv[8], 16)
switch_target_rels = [int(x, 16) for x in sys.argv[9].split(',')]
natural_off = int(sys.argv[10], 16)
natural_expected = bytes.fromhex(sys.argv[11])
late_offsets = [int(x, 16) for x in sys.argv[12].split(',')]
runtime_offsets = [int(x, 16) for x in sys.argv[13].split(',')]
runtime_counts = [int(x) for x in sys.argv[14].split(',')]

if len(runtime_offsets) != len(runtime_counts):
    raise SystemExit('RUNTIME_PC_COUNT_VECTOR_MISMATCH')

data = binary_path.read_bytes()
if len(data) < 32:
    raise SystemExit('MACHO_TOO_SMALL')
magic = struct.unpack_from('<I', data, 0)[0]
if magic != 0xFEEDFACF:
    raise SystemExit(f'UNSUPPORTED_MACHO_MAGIC=0x{magic:08X}')

_, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags, reserved = struct.unpack_from('<IiiIIIII', data, 0)
pos = 32
segments = []
lc_uuid = None
for _ in range(ncmds):
    if pos + 8 > len(data):
        raise SystemExit('LOAD_COMMAND_TRUNCATED')
    cmd, cmdsize = struct.unpack_from('<II', data, pos)
    if cmdsize < 8 or pos + cmdsize > len(data):
        raise SystemExit('LOAD_COMMAND_SIZE_INVALID')
    if cmd == 0x19 and cmdsize >= 72:
        segname = data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace')
        vmaddr, vmsize, fileoff, filesize = struct.unpack_from('<QQQQ', data, pos+24)
        segments.append((segname, vmaddr, vmsize, fileoff, filesize))
    elif cmd == 0x1B and cmdsize >= 24:
        u = data[pos+8:pos+24]
        lc_uuid = f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
    pos += cmdsize

texts = [s for s in segments if s[0] == '__TEXT']
if len(texts) != 1:
    raise SystemExit(f'TEXT_SEGMENT_COUNT={len(texts)}')
_, image_base, text_vmsize, text_fileoff, text_filesize = texts[0]
print(f'MACHO_CPU_TYPE={cputype}')
print(f'MACHO_CPU_SUBTYPE={cpusubtype}')
print(f'MACHO_LC_UUID={lc_uuid}')
print(f'MACHO_IMAGE_BASE=0x{image_base:X}')
if lc_uuid != expected_uuid:
    raise SystemExit('LC_UUID_MISMATCH')
print('D97AO_TARGET_LC_UUID_IDENTITY=PASS')

# Validate exact natural bytes where D97AD formerly installed artificial exit110.
def fileoff_for_image_offset(off):
    addr = image_base + off
    for name, vmaddr, vmsize, fileoff, filesize in segments:
        mapped = min(vmsize, filesize)
        if vmaddr <= addr < vmaddr + mapped:
            return fileoff + (addr - vmaddr), name
    raise ValueError(f'NO_FILE_MAPPING_FOR_IMAGE_OFFSET_0x{off:X}')

natural_fileoff, natural_seg = fileoff_for_image_offset(natural_off)
natural_actual = data[natural_fileoff:natural_fileoff+len(natural_expected)]
print('===== NATURAL D97AD-REMOVED SITE IDENTITY =====')
print(f'NATURAL_SITE_SEGMENT={natural_seg}')
print(f'NATURAL_SITE_FILE_OFFSET=0x{natural_fileoff:X}')
print(f'NATURAL_SITE_BYTES_EXPECTED={natural_expected.hex()}')
print(f'NATURAL_SITE_BYTES_ACTUAL={natural_actual.hex()}')
if natural_actual != natural_expected:
    raise SystemExit('NATURAL_SITE_BYTES_MISMATCH')
print('D97AO_EXACT_NATURAL_SITE_BYTES=PASS')

# Parse full disassembly.
rx = re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
all_inst = []
for line in otool_path.read_text(encoding='utf-8', errors='replace').splitlines():
    m = rx.match(line)
    if not m:
        continue
    try:
        addr = int(m.group(1), 16)
    except ValueError:
        continue
    body = m.group(2).strip()
    if not body:
        continue
    p = body.split(None, 1)
    all_inst.append((addr, p[0].lower(), p[1].strip() if len(p)>1 else '', body))
all_inst.sort()
all_by_addr = {x[0]: x for x in all_inst}
all_addrs = [x[0] for x in all_inst]
print(f'FULL_IMAGE_DISASSEMBLED_INSTRUCTION_COUNT={len(all_inst)}')

# Parse nm best-effort symbols and map nearest owner <= address.
symbols = []
for line in nm_path.read_text(encoding='utf-8', errors='replace').splitlines():
    m = re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$', line)
    if not m:
        continue
    try:
        a = int(m.group(1), 16)
    except ValueError:
        continue
    symbols.append((a, m.group(2).strip()))
symbols.sort()

def owner_for(addr):
    lo, hi = 0, len(symbols)
    while lo < hi:
        mid = (lo + hi) // 2
        if symbols[mid][0] <= addr:
            lo = mid + 1
        else:
            hi = mid
    if lo == 0:
        return None
    return symbols[lo-1]

print('===== D97AN RUNTIME SENDER-PC STATIC MAPPING =====')
runtime_exact_count = 0
for off, observed_count in zip(runtime_offsets, runtime_counts):
    addr = image_base + off
    row = all_by_addr.get(addr)
    if row:
        runtime_exact_count += 1
    owner = owner_for(addr)
    print(f'RUNTIME_PC|IMAGE_OFFSET=0x{off:X}|VM=0x{addr:X}|D97AN_RECORD_COUNT={observed_count}|EXACT_INSTRUCTION={"YES" if row else "NO"}|TEXT={row[3] if row else "MISSING"}|OWNER_VM={"0x%X"%owner[0] if owner else "MISSING"}|OWNER={owner[1] if owner else "MISSING"}')
    idx = None
    if row:
        # first exact matching instruction index
        for i, item in enumerate(all_inst):
            if item[0] == addr:
                idx = i
                break
    else:
        for i, item in enumerate(all_inst):
            if item[0] > addr:
                idx = max(0, i-1)
                break
        if idx is None and all_inst:
            idx = len(all_inst)-1
    if idx is not None:
        print(f'RUNTIME_PC_CONTEXT_BEGIN|IMAGE_OFFSET=0x{off:X}')
        for item in all_inst[max(0,idx-7):min(len(all_inst),idx+8)]:
            print(f'PC_CONTEXT|TARGET=0x{off:X}|IMAGE_OFFSET=0x{item[0]-image_base:X}|VM=0x{item[0]:X}|{item[3]}')
        print(f'RUNTIME_PC_CONTEXT_END|IMAGE_OFFSET=0x{off:X}')
print(f'RUNTIME_PC_EXACT_INSTRUCTION_COUNT={runtime_exact_count}')
print(f'D97AO_RUNTIME_PC_STATIC_MAPPING={"PASS" if runtime_exact_count == len(runtime_offsets) else "INCONCLUSIVE_NONBOUNDARY_PC"}')

# Print all otool-annotated code references to simulator/"were used" string literals.
print('===== FULL-IMAGE OTOOL SIMULATOR / WERE-USED ANNOTATED XREFS =====')
relevant_lines = []
for line in otool_path.read_text(encoding='utf-8', errors='replace').splitlines():
    low = line.lower()
    if 'simulator' in low or 'were used' in low:
        relevant_lines.append(line.rstrip())
print(f'ANNOTATED_SIMULATOR_OR_WERE_USED_LINE_COUNT={len(relevant_lines)}')
for line in relevant_lines:
    print('ANNOTATED_XREF|' + line)

# Extract printable binary strings with simulator / were used fragments for inventory only.
print('===== PRINTABLE BINARY STRING INVENTORY =====')
strings = []
start = None
buf = bytearray()
for i,b in enumerate(data):
    printable = 32 <= b <= 126
    if printable:
        if start is None:
            start = i
            buf = bytearray()
        buf.append(b)
    else:
        if start is not None and len(buf) >= 4:
            s = buf.decode('ascii','replace')
            low = s.lower()
            if 'simulator' in low or 'were used' in low:
                strings.append((start,s))
        start = None
        buf = bytearray()
if start is not None and len(buf) >= 4:
    s = buf.decode('ascii','replace')
    low = s.lower()
    if 'simulator' in low or 'were used' in low:
        strings.append((start,s))
print(f'PRINTABLE_SIMULATOR_OR_WERE_USED_STRING_COUNT={len(strings)}')
for off,s in strings:
    print(f'PRINTABLE_STRING|FILE_OFFSET=0x{off:X}|TEXT={s}')

# Intraprocedural natural-P7 CFG with the known D97AB switch resolved.
func_start = image_base + func_start_off
func_end = image_base + func_end_off
switch_addr = image_base + switch_off
expected_switch_addr = func_start + switch_rel
if switch_addr != expected_switch_addr:
    raise SystemExit('SWITCH_OFFSET_RELATION_FAIL')
switch_targets = [func_start + x for x in switch_target_rels]
late_addrs = [image_base + x for x in late_offsets]

inst = [x for x in all_inst if func_start <= x[0] < func_end]
if not inst or inst[0][0] != func_start:
    raise SystemExit('FUNCTION_ENTRY_NOT_EXACTLY_DECODED')
by_addr = {x[0]: x for x in inst}
addrs = [x[0] for x in inst]
next_addr = {addrs[i]: addrs[i+1] for i in range(len(addrs)-1)}
print('===== NATURAL P7 VALIDATOR IDENTITY =====')
print(f'FUNCTION_START_VM=0x{func_start:X}')
print(f'FUNCTION_END_VM=0x{func_end:X}')
print(f'FUNCTION_DISASSEMBLED_INSTRUCTION_COUNT={len(inst)}')

srow = by_addr.get(switch_addr)
print(f'SWITCH_IMAGE_OFFSET=0x{switch_off:X}')
print(f'SWITCH_VM=0x{switch_addr:X}')
print(f'SWITCH_TEXT={srow[3] if srow else "MISSING"}')
if srow is None or srow[1] not in ('jmp','jmpq') or srow[2].replace('\t','').replace(' ','') != '*%rax':
    raise SystemExit('KNOWN_SWITCH_INSTRUCTION_IDENTITY_FAIL')
print('D97AO_D97AB_KNOWN_SWITCH_IDENTITY=PASS')
for i,(rel,target) in enumerate(zip(switch_target_rels,switch_targets)):
    row = by_addr.get(target)
    print(f'SWITCH_TARGET|INDEX={i}|REL=0x{rel:X}|IMAGE_OFFSET=0x{target-image_base:X}|VM=0x{target:X}|EXACT_INSTRUCTION={"YES" if row else "NO"}|TEXT={row[3] if row else "MISSING"}')
    if row is None:
        raise SystemExit(f'KNOWN_SWITCH_TARGET_NOT_CURRENT_INSTRUCTION_INDEX_{i}')
print('D97AO_D97AB_SEVEN_ENTRY_SWITCH_RESOLUTION=PASS')

print('===== NATURAL P7 LATE SITE IDENTITY =====')
for off,target in zip(late_offsets,late_addrs):
    row = by_addr.get(target)
    print(f'LATE_SITE_IDENTITY|IMAGE_OFFSET=0x{off:X}|VM=0x{target:X}|EXACT_INSTRUCTION={"YES" if row else "NO"}|TEXT={row[3] if row else "MISSING"}')
    if row is None:
        raise SystemExit(f'LATE_SITE_NOT_INSTRUCTION_0x{off:X}')

hex_re = re.compile(r'0x([0-9A-Fa-f]+)')
def direct_target(operands):
    m = hex_re.search(operands)
    if m:
        return int(m.group(1), 16)
    m = re.search(r'\b([0-9A-Fa-f]{6,16})\b', operands)
    if m:
        return int(m.group(1), 16)
    return None

graph = collections.defaultdict(set)
unresolved_indirect = set()
for addr,mn,op,body in inst:
    nxt = next_addr.get(addr)
    if addr == switch_addr:
        graph[addr].update(set(switch_targets))
        continue
    if mn.startswith('ret') or mn in ('ud2','int3','hlt'):
        continue
    if mn in ('jmp','jmpq'):
        if op.lstrip().startswith('*'):
            unresolved_indirect.add(addr)
            continue
        t = direct_target(op)
        if t is not None and func_start <= t < func_end and t in by_addr:
            graph[addr].add(t)
        continue
    if mn.startswith('j') or mn.startswith('loop'):
        t = direct_target(op)
        if t is not None and func_start <= t < func_end and t in by_addr:
            graph[addr].add(t)
        if nxt is not None:
            graph[addr].add(nxt)
        continue
    if nxt is not None:
        graph[addr].add(nxt)

q = collections.deque([func_start])
prev = {func_start: None}
while q:
    u = q.popleft()
    for v in graph.get(u, ()):
        if v not in prev:
            prev[v] = u
            q.append(v)

reachable_unresolved = sorted(a for a in unresolved_indirect if a in prev)
print('===== NATURAL P7 RESOLVED CFG SUMMARY =====')
print(f'CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH={len(prev)}')
print(f'REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH={len(reachable_unresolved)}')
for a in reachable_unresolved:
    print(f'REMAINING_UNRESOLVED_INDIRECT|IMAGE_OFFSET=0x{a-image_base:X}|VM=0x{a:X}|TEXT={by_addr[a][3]}')

pred = collections.defaultdict(set)
for u,vs in graph.items():
    for v in vs:
        pred[v].add(u)

reachable_late = []
print('===== NATURAL P7 LATE SITE STATIC REACHABILITY =====')
for off,target in zip(late_offsets,late_addrs):
    yes = target in prev
    print(f'LATE_SITE=0x{off:X}|STATIC_REACHABLE_FROM_NORMAL_ENTRY={"YES" if yes else "NO"}|PREDECESSOR_COUNT={len(pred.get(target,()))}')
    for p in sorted(pred.get(target,())):
        print(f'LATE_PREDECESSOR|SITE=0x{off:X}|FROM_IMAGE_OFFSET=0x{p-image_base:X}|VM=0x{p:X}|TEXT={by_addr[p][3]}')
    if yes:
        reachable_late.append((off,target))
        path=[]
        cur=target
        while cur is not None:
            path.append(cur)
            cur=prev.get(cur)
        path.reverse()
        print(f'STATIC_PATH_SITE=0x{off:X}|NODE_COUNT={len(path)}|IMAGE_OFFSETS='+','.join(f'0x{x-image_base:X}' for x in path))

print('===== CLASSIFICATION =====')
if reachable_unresolved:
    print('D97AO_NATURAL_P7_LATE_CFG=INCONCLUSIVE_REMAINING_REACHABLE_INDIRECT')
elif len(reachable_late) == len(late_offsets):
    print('D97AO_NATURAL_P7_LATE_CFG=STATIC_PROVEN_ALL_FIVE_REACHABLE_FROM_NORMAL_ENTRY')
elif reachable_late:
    print(f'D97AO_NATURAL_P7_LATE_CFG=STATIC_PARTIAL_REACHABILITY_{len(reachable_late)}_OF_{len(late_offsets)}')
else:
    print('D97AO_NATURAL_P7_LATE_CFG=STATIC_NEGATIVE_ZERO_OF_FIVE_REACHABLE_FROM_NORMAL_ENTRY')
print('D97AO_RUNTIME_PC_AND_NATURAL_RESOLVED_CFG_AUDIT=PASS')
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
echo "D97AO_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"