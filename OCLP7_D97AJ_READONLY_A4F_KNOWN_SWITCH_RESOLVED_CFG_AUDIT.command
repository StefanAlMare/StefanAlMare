#!/bin/zsh -f
set -euo pipefail

TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e"
EXPECTED_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
EXPECTED_VESA_BOOT_SEC="1788466673"
FUNC_START_OFF="0x9D132"
FUNC_END_OFF="0x9D830"
SWITCH_OFF="0x9D3AB"
SWITCH_REL="0x279"
SWITCH_TARGET_RELS="0x27B,0x281,0x36F,0x2B2,0x2CE,0x36F,0x2FF"
EXIT110_OFF="0x9D6BD"
EXIT110_BYTES="6a6e5fe9bb38f6ff90"
LATE_OFFSETS="0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D"
OUT="$HOME/Desktop/OCLP7_D97AJ_A4F_KNOWN_SWITCH_RESOLVED_CFG_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AJ_CFG.XXXXXX)"
OTOOL_OUT="$TMP/otool.txt"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AJ_CFG.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AJ_CFG_AUDIT=FAIL_CLOSED|REASON=$1"
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

echo "===== OCLP7 D97AJ — READ-ONLY A4F KNOWN-SWITCH RESOLVED CFG AUDIT ====="
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "FUNC_START_IMAGE_OFFSET=$FUNC_START_OFF"
echo "FUNC_END_IMAGE_OFFSET=$FUNC_END_OFF"
echo "KNOWN_SWITCH_IMAGE_OFFSET=$SWITCH_OFF"
echo "KNOWN_SWITCH_REL=$SWITCH_REL"
echo "D97AB_PROVEN_SWITCH_TARGET_RELS=$SWITCH_TARGET_RELS"
echo "EXIT110_IMAGE_OFFSET=$EXIT110_OFF"
echo "LATE_DIAGNOSTIC_XREF_OFFSETS=$LATE_OFFSETS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail "TARGET_MISSING_NOT_REGULAR_OR_SYMLINK"
[[ -x /usr/bin/otool ]] || fail "OTOOL_MISSING"
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
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail "TARGET_SHA_MISMATCH_NOT_EXACT_A4F_POSTIMAGE"
echo "A4F_TARGET_SHA_IDENTITY=PASS"

/usr/bin/otool -tvV "$TARGET" > "$OTOOL_OUT" 2>&1 || fail "OTOOL_DISASSEMBLY_FAILED"
OTOOL_BYTES="$(/usr/bin/stat -f '%z' "$OTOOL_OUT" 2>/dev/null || echo 0)"
echo "OTOOL_OUTPUT_BYTES=$OTOOL_BYTES"
[[ "$OTOOL_BYTES" -gt 0 ]] || fail "OTOOL_OUTPUT_EMPTY"

"$PYTHON" - "$TARGET" "$OTOOL_OUT" "$EXPECTED_UUID" "$FUNC_START_OFF" "$FUNC_END_OFF" "$SWITCH_OFF" "$SWITCH_REL" "$SWITCH_TARGET_RELS" "$EXIT110_OFF" "$EXIT110_BYTES" "$LATE_OFFSETS" <<'PY'
import collections
import re
import struct
import sys
from pathlib import Path

binary_path = Path(sys.argv[1])
otool_path = Path(sys.argv[2])
expected_uuid = sys.argv[3].upper()
func_start_off = int(sys.argv[4], 16)
func_end_off = int(sys.argv[5], 16)
switch_off = int(sys.argv[6], 16)
switch_rel = int(sys.argv[7], 16)
switch_target_rels = [int(x, 16) for x in sys.argv[8].split(',')]
exit110_off = int(sys.argv[9], 16)
exit110_expected = bytes.fromhex(sys.argv[10])
late_offsets = [int(x, 16) for x in sys.argv[11].split(',')]

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
print('A4F_TARGET_LC_UUID_IDENTITY=PASS')

func_start = image_base + func_start_off
func_end = image_base + func_end_off
switch_addr = image_base + switch_off
expected_switch_addr = func_start + switch_rel
if switch_addr != expected_switch_addr:
    raise SystemExit(f'SWITCH_OFFSET_RELATION_FAIL:0x{switch_addr:X}:0x{expected_switch_addr:X}')

switch_targets = [func_start + x for x in switch_target_rels]
late_addrs = [image_base + x for x in late_offsets]
exit_start = image_base + exit110_off
exit_end = exit_start + len(exit110_expected)

def fileoff_for_image_offset(off):
    addr = image_base + off
    for name, vmaddr, vmsize, fileoff, filesize in segments:
        if vmaddr <= addr < vmaddr + min(vmsize, filesize):
            return fileoff + (addr - vmaddr), name
    raise ValueError(f'NO_FILE_MAPPING_FOR_IMAGE_OFFSET_0x{off:X}')

exit_fileoff, exit_seg = fileoff_for_image_offset(exit110_off)
exit_actual = data[exit_fileoff:exit_fileoff+len(exit110_expected)]
print(f'EXIT110_SEGMENT={exit_seg}')
print(f'EXIT110_FILE_OFFSET=0x{exit_fileoff:X}')
print(f'EXIT110_BYTES_EXPECTED={exit110_expected.hex()}')
print(f'EXIT110_BYTES_ACTUAL={exit_actual.hex()}')
if exit_actual != exit110_expected:
    raise SystemExit('EXIT110_BYTES_MISMATCH')
print('D97AD_EXIT110_BYTES_ON_A4F=PASS')

rx = re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst = []
for line in otool_path.read_text(encoding='utf-8', errors='replace').splitlines():
    m = rx.match(line)
    if not m:
        continue
    try:
        addr = int(m.group(1), 16)
    except ValueError:
        continue
    if func_start <= addr < func_end:
        body = m.group(2).strip()
        if body:
            p = body.split(None, 1)
            inst.append((addr, p[0].lower(), p[1].strip() if len(p)>1 else '', body))
inst.sort()
if not inst or inst[0][0] != func_start:
    raise SystemExit('FUNCTION_ENTRY_NOT_EXACTLY_DECODED')
by_addr = {x[0]: x for x in inst}
addrs = [x[0] for x in inst]
next_addr = {addrs[i]: addrs[i+1] for i in range(len(addrs)-1)}
print(f'FUNCTION_START_VM=0x{func_start:X}')
print(f'FUNCTION_END_VM=0x{func_end:X}')
print(f'FUNCTION_DISASSEMBLED_INSTRUCTION_COUNT={len(inst)}')

srow = by_addr.get(switch_addr)
print('===== CURRENT A4F KNOWN SWITCH IDENTITY =====')
print(f'SWITCH_IMAGE_OFFSET=0x{switch_off:X}')
print(f'SWITCH_REL=0x{switch_rel:X}')
print(f'SWITCH_VM=0x{switch_addr:X}')
print(f'SWITCH_TEXT={srow[3] if srow else "MISSING"}')
if srow is None or not (srow[0] == switch_addr and srow[1] in ('jmp','jmpq') and srow[2].replace('\t',' ').replace(' ','') == '*%rax'):
    raise SystemExit('KNOWN_SWITCH_INSTRUCTION_IDENTITY_FAIL')
print('D97AB_KNOWN_SWITCH_INSTRUCTION_ON_A4F=PASS')

print('D97AB_PROVEN_SWITCH_TARGET_COUNT_RAW='+str(len(switch_targets)))
print('D97AB_PROVEN_SWITCH_TARGET_COUNT_UNIQUE='+str(len(set(switch_targets))))
for i,(rel,target) in enumerate(zip(switch_target_rels,switch_targets)):
    row = by_addr.get(target)
    print(f'SWITCH_TARGET|INDEX={i}|REL=0x{rel:X}|IMAGE_OFFSET=0x{target-image_base:X}|VM=0x{target:X}|EXACT_INSTRUCTION={"YES" if row else "NO"}|TEXT={row[3] if row else "MISSING"}')
    if row is None:
        raise SystemExit(f'KNOWN_SWITCH_TARGET_NOT_CURRENT_INSTRUCTION_INDEX_{i}')
print('D97AB_SEVEN_ENTRY_SWITCH_RESOLUTION_APPLIES_TO_CURRENT_A4F=PASS')

print('===== CURRENT A4F SWITCH CONTEXT =====')
for addr,mn,op,body in inst:
    if switch_addr - 0x28 <= addr <= switch_addr + 0x30:
        print(f'IMAGE_OFFSET=0x{addr-image_base:X}|VM=0x{addr:X}|{body}')

print('===== CURRENT A4F LATE SITE IDENTITY =====')
for off,target in zip(late_offsets,late_addrs):
    row = by_addr.get(target)
    print(f'LATE_SITE|IMAGE_OFFSET=0x{off:X}|VM=0x{target:X}|EXACT_INSTRUCTION={"YES" if row else "NO"}|TEXT={row[3] if row else "MISSING"}')
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

def bfs(block_exit110):
    q = collections.deque([func_start])
    prev = {func_start: None}
    while q:
        u = q.popleft()
        if block_exit110 and exit_start <= u < exit_end:
            continue
        for v in graph.get(u, ()):
            if block_exit110 and exit_start <= v < exit_end:
                continue
            if v not in prev:
                prev[v] = u
                q.append(v)
    return prev

reach = bfs(False)
bypass = bfs(True)
reachable_unresolved = sorted(a for a in unresolved_indirect if a in bypass)
print('===== RESOLVED CFG SUMMARY =====')
print(f'CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH={len(reach)}')
print(f'CFG_REACHABLE_WITH_EXIT110_BLOCKED_AND_SWITCH={len(bypass)}')
print(f'REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH={len(reachable_unresolved)}')
for a in reachable_unresolved:
    print(f'REMAINING_UNRESOLVED_INDIRECT|IMAGE_OFFSET=0x{a-image_base:X}|VM=0x{a:X}|TEXT={by_addr[a][3]}')

pred = collections.defaultdict(set)
for u,vs in graph.items():
    for v in vs:
        pred[v].add(u)

print('===== LATE SITE RESOLVED REACHABILITY =====')
bypass_sites = []
for off,target in zip(late_offsets,late_addrs):
    normal = target in reach
    byp = target in bypass
    print(f'LATE_SITE=0x{off:X}|REACHABLE_NORMAL={"YES" if normal else "NO"}|REACHABLE_WITH_EXIT110_BLOCKED={"YES" if byp else "NO"}|PREDECESSOR_COUNT={len(pred.get(target,()))}')
    for p in sorted(pred.get(target,())):
        print(f'LATE_PREDECESSOR|SITE=0x{off:X}|FROM_IMAGE_OFFSET=0x{p-image_base:X}|FROM_VM=0x{p:X}|TEXT={by_addr[p][3]}')
    if byp:
        bypass_sites.append((off,target))
        path=[]
        cur=target
        while cur is not None:
            path.append(cur)
            cur=bypass.get(cur)
        path.reverse()
        print(f'BYPASS_PATH_SITE=0x{off:X}|NODE_COUNT={len(path)}|IMAGE_OFFSETS='+','.join(f'0x{x-image_base:X}' for x in path))

print('===== CLASSIFICATION =====')
if reachable_unresolved:
    print('D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=INCONCLUSIVE_REMAINING_REACHABLE_INDIRECT')
elif bypass_sites:
    print('D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=PROVEN_REACHABLE')
else:
    print('D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_FULLY_RESOLVED_REACHABLE_CFG')
print('D97AJ_A4F_KNOWN_SWITCH_RESOLVED_CFG_AUDIT=PASS')
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
echo "D97AJ_CFG_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
