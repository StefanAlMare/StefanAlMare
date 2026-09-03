#!/bin/zsh -f
set -euo pipefail

TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e"
EXPECTED_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
EXPECTED_VESA_BOOT_SEC="1788466673"
FUNC_START_OFF="0x9D132"
FUNC_END_OFF="0x9D830"
EXIT110_OFF="0x9D6BD"
EXIT110_BYTES="6a6e5fe9bb38f6ff90"
LATE_OFFSETS="0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D"
OUT="$HOME/Desktop/OCLP7_D97AI_A4F_VALID_SIMULATOR_METADATA_CFG_RECONCILIATION.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AI_CFG.XXXXXX)"
OTOOL_OUT="$TMP/otool.txt"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AI_CFG.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AI_CFG_AUDIT=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "SERVICE_LAUNCH=AUTO-NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AI — READ-ONLY A4F validSimulatorMetadata CFG RECONCILIATION ====="
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "FUNC_START_IMAGE_OFFSET=$FUNC_START_OFF"
echo "FUNC_END_IMAGE_OFFSET=$FUNC_END_OFF"
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

"$PYTHON" - "$TARGET" "$OTOOL_OUT" "$EXPECTED_UUID" "$FUNC_START_OFF" "$FUNC_END_OFF" "$EXIT110_OFF" "$EXIT110_BYTES" "$LATE_OFFSETS" <<'PY'
import collections
import hashlib
import re
import struct
import sys
from pathlib import Path

binary_path = Path(sys.argv[1])
otool_path = Path(sys.argv[2])
expected_uuid = sys.argv[3].upper()
func_start_off = int(sys.argv[4], 16)
func_end_off = int(sys.argv[5], 16)
exit110_off = int(sys.argv[6], 16)
exit110_expected = bytes.fromhex(sys.argv[7])
late_offsets = [int(x, 16) for x in sys.argv[8].split(',')]

data = binary_path.read_bytes()

if len(data) < 32:
    raise SystemExit("MACHO_TOO_SMALL")
magic = struct.unpack_from('<I', data, 0)[0]
if magic != 0xFEEDFACF:
    raise SystemExit(f"UNSUPPORTED_MACHO_MAGIC=0x{magic:08X}")

_, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags, reserved = struct.unpack_from('<IiiIIIII', data, 0)
pos = 32
segments = []
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
        segments.append((segname, vmaddr, vmsize, fileoff, filesize))
    elif cmd == 0x1B and cmdsize >= 24:
        u = data[pos+8:pos+24]
        lc_uuid = f"{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}".upper()
    pos += cmdsize

text_segments = [s for s in segments if s[0] == '__TEXT']
if len(text_segments) != 1:
    raise SystemExit(f"TEXT_SEGMENT_COUNT={len(text_segments)}")
text_name, image_base, text_vmsize, text_fileoff, text_filesize = text_segments[0]
print(f"MACHO_CPU_TYPE={cputype}")
print(f"MACHO_CPU_SUBTYPE={cpusubtype}")
print(f"MACHO_LC_UUID={lc_uuid}")
print(f"MACHO_IMAGE_BASE=0x{image_base:X}")
print(f"TEXT_VM_SIZE=0x{text_vmsize:X}")
print(f"TEXT_FILEOFF=0x{text_fileoff:X}")
print(f"TEXT_FILESIZE=0x{text_filesize:X}")
if lc_uuid != expected_uuid:
    raise SystemExit("LC_UUID_MISMATCH")
print("A4F_TARGET_LC_UUID_IDENTITY=PASS")

def fileoff_for_image_offset(off):
    addr = image_base + off
    for name, vmaddr, vmsize, fileoff, filesize in segments:
        if vmaddr <= addr < vmaddr + min(vmsize, filesize):
            return fileoff + (addr - vmaddr), name
    raise ValueError(f"NO_FILE_MAPPING_FOR_IMAGE_OFFSET_0x{off:X}")

exit_fileoff, exit_seg = fileoff_for_image_offset(exit110_off)
exit_actual = data[exit_fileoff:exit_fileoff+len(exit110_expected)]
print(f"EXIT110_SEGMENT={exit_seg}")
print(f"EXIT110_FILE_OFFSET=0x{exit_fileoff:X}")
print(f"EXIT110_BYTES_EXPECTED={exit110_expected.hex()}")
print(f"EXIT110_BYTES_ACTUAL={exit_actual.hex()}")
if exit_actual != exit110_expected:
    raise SystemExit("EXIT110_BYTES_MISMATCH")
print("D97AD_EXIT110_BYTES_ON_A4F=PASS")

func_start = image_base + func_start_off
func_end = image_base + func_end_off
exit_start = image_base + exit110_off
exit_end = exit_start + len(exit110_expected)
late_addrs = [image_base + x for x in late_offsets]

line_re = re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst = []
for line in otool_path.read_text(encoding='utf-8', errors='replace').splitlines():
    m = line_re.match(line)
    if not m:
        continue
    try:
        addr = int(m.group(1), 16)
    except ValueError:
        continue
    if not (func_start <= addr < func_end):
        continue
    body = m.group(2).strip()
    if not body:
        continue
    parts = body.split(None, 1)
    mnemonic = parts[0].lower()
    operands = parts[1].strip() if len(parts) > 1 else ''
    inst.append((addr, mnemonic, operands, body))

inst.sort()
print(f"FUNCTION_START_VM=0x{func_start:X}")
print(f"FUNCTION_END_VM=0x{func_end:X}")
print(f"FUNCTION_DISASSEMBLED_INSTRUCTION_COUNT={len(inst)}")
if not inst:
    raise SystemExit("NO_FUNCTION_DISASSEMBLY")
if inst[0][0] != func_start:
    print(f"FUNCTION_FIRST_DECODED_VM=0x{inst[0][0]:X}")
    raise SystemExit("FUNCTION_ENTRY_NOT_EXACTLY_DECODED")

by_addr = {x[0]: x for x in inst}
addrs = [x[0] for x in inst]
next_addr = {addrs[i]: addrs[i+1] for i in range(len(addrs)-1)}

print("===== TARGET INSTRUCTION CHECK =====")
for off, addr in zip(late_offsets, late_addrs):
    row = by_addr.get(addr)
    print(f"LATE_SITE_IMAGE_OFFSET=0x{off:X}|VM=0x{addr:X}|EXACT_INSTRUCTION={'YES' if row else 'NO'}|TEXT={row[3] if row else 'MISSING'}")
    if row is None:
        raise SystemExit(f"LATE_SITE_NOT_INSTRUCTION_0x{off:X}")

print("===== EXIT110 DISASSEMBLY REGION =====")
for addr, mnemonic, operands, body in inst:
    if exit_start - 0x20 <= addr < exit_end + 0x20:
        marker = "EXIT110_REGION" if exit_start <= addr < exit_end else "CONTEXT"
        print(f"{marker}|IMAGE_OFFSET=0x{addr-image_base:X}|VM=0x{addr:X}|{body}")

print("===== LATE SITE DISASSEMBLY CONTEXT =====")
for off, target in zip(late_offsets, late_addrs):
    print(f"--- LATE_SITE_0x{off:X} ---")
    for addr, mnemonic, operands, body in inst:
        if target - 0x18 <= addr <= target + 0x28:
            print(f"IMAGE_OFFSET=0x{addr-image_base:X}|VM=0x{addr:X}|{body}")

hex_re = re.compile(r'0x([0-9A-Fa-f]+)')
def branch_target(operands):
    m = hex_re.search(operands)
    if m:
        return int(m.group(1), 16)
    m = re.search(r'\b([0-9A-Fa-f]{6,16})\b', operands)
    if m:
        return int(m.group(1), 16)
    return None

graph = collections.defaultdict(set)
unresolved_reachable_candidates = []
branch_rows = []
for addr, mnemonic, operands, body in inst:
    nxt = next_addr.get(addr)
    is_ret = mnemonic.startswith('ret')
    is_uncond = mnemonic in ('jmp', 'jmpq')
    is_cond = mnemonic.startswith('j') and not is_uncond
    is_loop = mnemonic.startswith('loop')
    if is_ret:
        pass
    elif is_uncond:
        t = branch_target(operands)
        branch_rows.append((addr, mnemonic, operands, t))
        if t is not None and func_start <= t < func_end and t in by_addr:
            graph[addr].add(t)
        elif t is None:
            unresolved_reachable_candidates.append(addr)
    elif is_cond or is_loop:
        t = branch_target(operands)
        branch_rows.append((addr, mnemonic, operands, t))
        if t is not None and func_start <= t < func_end and t in by_addr:
            graph[addr].add(t)
        elif t is None:
            unresolved_reachable_candidates.append(addr)
        if nxt is not None:
            graph[addr].add(nxt)
    else:
        if nxt is not None:
            graph[addr].add(nxt)

entry = func_start

def bfs(block_terminal=False):
    q = collections.deque([entry])
    prev = {entry: None}
    while q:
        u = q.popleft()
        for v in graph.get(u, ()):
            if block_terminal and exit_start <= v < exit_end:
                continue
            if v not in prev:
                prev[v] = u
                q.append(v)
    return prev

reach_all = bfs(False)
reach_bypass = bfs(True)
reachable_unresolved = sorted(a for a in unresolved_reachable_candidates if a in reach_bypass)

print("===== CFG SUMMARY =====")
print(f"CFG_REACHABLE_INSTRUCTION_COUNT={len(reach_all)}")
print(f"CFG_REACHABLE_WITH_EXIT110_REGION_BLOCKED={len(reach_bypass)}")
print(f"CFG_REACHABLE_UNRESOLVED_BRANCH_COUNT_WITH_EXIT110_BLOCKED={len(reachable_unresolved)}")
for a in reachable_unresolved:
    row = by_addr[a]
    print(f"UNRESOLVED_REACHABLE_BRANCH|IMAGE_OFFSET=0x{a-image_base:X}|VM=0x{a:X}|{row[3]}")

pred = collections.defaultdict(set)
for u, vs in graph.items():
    for v in vs:
        pred[v].add(u)

bypass_any = False
print("===== LATE SITE PREDECESSORS AND BYPASS REACHABILITY =====")
for off, target in zip(late_offsets, late_addrs):
    preds = sorted(pred.get(target, ()))
    print(f"LATE_SITE=0x{off:X}|REACHABLE_NORMAL={'YES' if target in reach_all else 'NO'}|REACHABLE_WITH_EXIT110_BLOCKED={'YES' if target in reach_bypass else 'NO'}|PREDECESSOR_COUNT={len(preds)}")
    for p in preds:
        print(f"LATE_PREDECESSOR|SITE=0x{off:X}|FROM_IMAGE_OFFSET=0x{p-image_base:X}|FROM_VM=0x{p:X}|TEXT={by_addr[p][3]}")
    if target in reach_bypass:
        bypass_any = True
        path = []
        cur = target
        while cur is not None:
            path.append(cur)
            cur = reach_bypass.get(cur)
        path.reverse()
        print(f"BYPASS_PATH_SITE=0x{off:X}|NODE_COUNT={len(path)}|IMAGE_OFFSETS=" + ",".join(f"0x{x-image_base:X}" for x in path))

print("===== BRANCHES TARGETING LATE REGION =====")
late_region_start = min(late_addrs) - 0x40
late_region_end = max(late_addrs) + 0x80
for addr, mnemonic, operands, t in branch_rows:
    if t is not None and late_region_start <= t <= late_region_end:
        print(f"BRANCH_TO_LATE_REGION|FROM_IMAGE_OFFSET=0x{addr-image_base:X}|TO_IMAGE_OFFSET=0x{t-image_base:X}|{mnemonic} {operands}")

if bypass_any:
    print("D97AI_STATIC_LATE_BLOCK_BYPASS_EXIT110=PROVEN_REACHABLE")
elif reachable_unresolved:
    print("D97AI_STATIC_LATE_BLOCK_BYPASS_EXIT110=INCONCLUSIVE_UNRESOLVED_REACHABLE_BRANCH")
else:
    print("D97AI_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_DECODED_CFG")

print("D97AI_A4F_VALID_SIMULATOR_METADATA_CFG_AUDIT=PASS")
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
echo "D97AI_CFG_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
