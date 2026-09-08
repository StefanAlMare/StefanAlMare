#!/usr/bin/env python3
"""D97HW: static comparison on disposable GitHub-runner copies only.

Never loads/executes donor code. Never accesses the runner's installed compiler
frameworks. Never changes ASUS2 or Golden. A static match is NOT a Golden
runtime-path or request-payload proof. RIP-relative xrefs below are candidates
at disassembler instruction boundaries, not a complete CFG analysis.
"""
import bisect
import hashlib
import json
import os
from pathlib import Path
import re
import struct
import subprocess
import sys
import uuid

GOLDEN = "ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
P3 = "0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"
SERVICE_BASE = "31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
SERVICE_P1 = "a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def pick(root, name, expected, size):
    candidates = sorted(p for p in root.rglob(name) if p.is_file() and p.stat().st_size == size)
    matches = []
    for path in candidates:
        data = path.read_bytes()
        if sha(data) == expected:
            matches.append(path)
    require(matches, "EXACT_DONOR_NOT_FOUND: " + name + " SHA=" + expected)
    return matches[0].read_bytes(), [str(p.relative_to(root)) for p in matches]


def variant(data, expected_before, offset, pre, post, expected_after, changed_offsets):
    require(sha(data) == expected_before, "PRE_SHA_MISMATCH")
    require(len(pre) == len(post), "PATCH_LENGTH")
    require(data[offset:offset + len(pre)] == pre, "PREIMAGE_MISMATCH")
    require(data.count(pre) == 1, "NON_UNIQUE_PREIMAGE")
    result = data[:offset] + post + data[offset + len(pre):]
    changes = [i for i, (a, b) in enumerate(zip(data, result)) if a != b]
    require(len(data) == len(result) and changes == changed_offsets, "UNEXPECTED_DIFF")
    require(sha(result) == expected_after, "POST_SHA_MISMATCH")
    return result, changes


def macho(data):
    require(len(data) >= 32, "SHORT_MACHO")
    magic, cpu, subtype, ftype, ncmds, cmdbytes, flags, reserved = struct.unpack_from("<IiiIIIII", data)
    require(magic == 0xfeedfacf and cpu == 0x1000007, "NOT_THIN_X86_64")
    require(32 + cmdbytes <= len(data), "LOAD_COMMAND_BOUNDS")
    pos = 32
    sections, segments, symbols, starts = [], [], [], []
    symtab = None
    function_data = None
    identity = None
    for _ in range(ncmds):
        require(pos + 8 <= 32 + cmdbytes, "SHORT_COMMAND")
        cmd, size = struct.unpack_from("<II", data, pos)
        require(size >= 8 and pos + size <= 32 + cmdbytes, "COMMAND_SIZE")
        if cmd == 0x19:
            require(size >= 72, "SHORT_SEGMENT")
            vals = struct.unpack_from("<II16sQQQQiiII", data, pos)
            _, _, name, va, vs, fo, fs, maxp, initp, ns, fl = vals
            require(72 + 80 * ns <= size and fo + fs <= len(data), "SEGMENT_BOUNDS")
            segments.append(dict(name=name.split(b"\0")[0].decode(), va=va, size=vs, offset=fo, filesize=fs))
            for index in range(ns):
                v = struct.unpack_from("<16s16sQQIIIIIIII", data, pos + 72 + 80 * index)
                sect, seg, addr, length, off, align, reloc, nreloc, sf, r1, r2, r3 = v
                zerofill = (sf & 0xff) in (1, 12, 18)
                if not zerofill:
                    require(off + length <= len(data), "SECTION_BOUNDS")
                sections.append(dict(section=sect.split(b"\0")[0].decode(), segment=seg.split(b"\0")[0].decode(), va=addr, size=length, offset=off, zerofill=zerofill))
        elif cmd == 0x1b:
            require(size >= 24, "SHORT_UUID")
            identity = str(uuid.UUID(bytes=data[pos + 8:pos + 24])).upper()
        elif cmd == 2:
            require(size >= 24, "SHORT_SYMTAB")
            symtab = struct.unpack_from("<IIII", data, pos + 8)
        elif cmd == 0x26:
            require(size >= 16, "SHORT_FUNCTION_STARTS")
            function_data = struct.unpack_from("<II", data, pos + 8)
        pos += size
    require(pos == 32 + cmdbytes, "LOAD_COMMAND_END")
    if symtab:
        so, count, stro, strsize = symtab
        require(so + count * 16 <= len(data) and stro + strsize <= len(data), "SYMTAB_BOUNDS")
        for i in range(count):
            ni, nt, ns, nd, value = struct.unpack_from("<IBBHQ", data, so + 16 * i)
            if ni >= strsize or nt & 0xe0 or nt & 0x0e != 0x0e or not value:
                continue
            end = data.find(b"\0", stro + ni, stro + strsize)
            if end >= 0:
                symbols.append((value, data[stro + ni:end].decode("utf-8", "replace")))
    if function_data:
        off, size = function_data
        require(off + size <= len(data), "FUNCTION_STARTS_BOUNDS")
        text = next(s for s in segments if s["name"] == "__TEXT")
        addr, value, shift = text["va"], 0, 0
        for byte in data[off:off + size]:
            value |= (byte & 127) << shift
            if byte & 128:
                shift += 7
                require(shift < 64, "ULEB_OVERFLOW")
            else:
                if value == 0:
                    break
                addr += value
                starts.append(addr)
                value, shift = 0, 0
    return dict(uuid=identity, sections=sections, segments=segments, symbols=sorted(symbols), functions=starts)


def tool(name, *args):
    path = subprocess.run(["/usr/bin/xcrun", "--find", name], check=True, text=True, capture_output=True).stdout.strip()
    proc = subprocess.run([path, *args], text=True, capture_output=True)
    require(proc.returncode == 0, name + ": " + proc.stderr)
    return proc.stdout


def describe(data, image, metadata, out):
    strings = []
    for sec in metadata["sections"]:
        if sec["zerofill"] or sec["section"] not in ("__cstring", "__oslogstring", "__const"):
            continue
        block = data[sec["offset"]:sec["offset"] + sec["size"]]
        for match in re.finditer(rb"[\x20-\x7e]{4,}", block):
            text = match.group().decode("ascii")
            if re.search("simulator|bitcode", text, re.I):
                strings.append(dict(file_offset=sec["offset"] + match.start(), va=sec["va"] + match.start(), section=sec["section"], text=text))
    (out / (image.name + "_strings.json")).write_text(json.dumps(strings, indent=2) + "\n")
    dis = tool("otool", "-arch", "x86_64", "-tvV", str(image))
    (out / (image.name + "_disassembly.txt")).write_text(dis)
    (out / (image.name + "_nm.txt")).write_text(tool("nm", "-n", "-m", str(image)))
    (out / (image.name + "_loads.txt")).write_text(tool("otool", "-l", str(image)))
    rows = []
    for line in dis.splitlines():
        match = re.match(r"^([0-9a-fA-F]{8,16})\s+(.+)$", line)
        if match:
            rows.append((int(match[1], 16), match[2], line))
    require(rows, "NO_DISASSEMBLY")
    symbols = metadata["symbols"]
    symbol_addrs = [x[0] for x in symbols]
    functions = metadata["functions"]
    xrefs = []
    contexts = []
    for i, (addr, ins, line) in enumerate(rows[:-1]):
        nextaddr = rows[i + 1][0]
        if not 0 < nextaddr - addr <= 15:
            continue
        match = re.search(r"(?P<disp>-?(?:0x[0-9a-fA-F]+|[0-9]+))?\(%rip\)", ins)
        targets = []
        if match:
            raw = match["disp"] or "0"
            disp = int(raw, 16 if "0x" in raw else 10)
            target = nextaddr + disp
            targets = [s for s in strings if s["va"] <= target < s["va"] + len(s["text"])]
        for target in targets:
            fi = bisect.bisect_right(functions, addr) - 1
            si = bisect.bisect_right(symbol_addrs, addr) - 1
            xrefs.append(dict(instruction_va=addr, instruction=ins, string=target, function_start=functions[fi] if fi >= 0 else None, nearest_symbol=symbols[si] if si >= 0 else None))
            contexts.append((i, target["text"]))
        if addr in (0x9A8CD, 0xA1573) or re.search("validSimulatorMetadata", ins, re.I):
            contexts.append((i, "P2/P3 or named-call candidate"))
    (out / (image.name + "_xref_candidates.json")).write_text(json.dumps(xrefs, indent=2) + "\n")
    with (out / (image.name + "_contexts.txt")).open("w") as f:
        for idx, title in contexts:
            f.write("\n=== " + title + " ===\n")
            f.write("\n".join(r[2] for r in rows[max(0, idx - 50):idx + 71]) + "\n")
    return dict(string_count=len(strings), xref_candidate_count=len(xrefs), relevant_symbols=[s for s in symbols if re.search("MTLSimCompiler|validSimulatorMetadata|backendCompileModule|backendCompileExecutableRequest", s[1])], strings=strings, xrefs=xrefs)


def main():
    require(len(sys.argv) == 4, "USAGE: script MOUNT OUTPUT WORKSPACE")
    root, out, work = (Path(p).resolve() for p in sys.argv[1:])
    require(root.is_dir() and not root.is_symlink(), "MOUNT_REQUIRED")
    require(str(root).startswith(os.environ.get("RUNNER_TEMP", "/__not_a_runner__") + "/"), "GITHUB_RUNNER_TEMP_REQUIRED")
    out.mkdir(parents=True, exist_ok=True)
    work.mkdir(parents=True, exist_ok=True)
    base, basepaths = pick(root, "MTLCompiler", GOLDEN, 1636896)
    service, servicepaths = pick(root, "MTLCompilerService", SERVICE_BASE, 85520)
    p3, changes = variant(base, GOLDEN, 0xA1573, bytes.fromhex("81e100002000"), bytes.fromhex("81c900002000"), P3, [0xA1574])
    p1, svcchanges = variant(service, SERVICE_BASE, 0x3494, bytes.fromhex("81fe19790000"), bytes.fromhex("81fe177d0000"), SERVICE_P1, [0x3496, 0x3497])
    require(p3[0x9A8CD:0x9A8CD + 7].hex() == "418b81d0000000", "P2_NOT_ORIGINAL")
    metadata = macho(base)
    require(metadata["uuid"] == "D5CE0008-587C-3861-971A-4BAEFB7B9C5B", "COMPILER_UUID")
    require(macho(p3) == metadata, "MACHO_METADATA_DRIFT")
    summary = dict(status="STATIC_COLLECTION_NOT_RUNTIME_PROOF", golden_sha256=sha(base), p3_sha256=sha(p3), p1_sha256=sha(p1), compiler_changed_offsets=changes, service_changed_offsets=svcchanges, compiler_donor_paths=basepaths, service_donor_paths=servicepaths, uuid=metadata["uuid"], p2="ORIGINAL_D0", target_mutation=False, golden_runtime_equivalence="UNKNOWN", p2b_authorized=False, github_head=os.environ.get("GITHUB_SHA"), run_id=os.environ.get("GITHUB_RUN_ID"))
    (out / "macho_metadata.json").write_text(json.dumps(metadata, indent=2) + "\n")
    for label, data in (("Golden_MTLCompiler32023", base), ("P3_MTLCompiler32023", p3)):
        path = work / label
        path.write_bytes(data)
        summary[label] = describe(data, path, metadata, out)
    (out / "D97HW_STATIC_SUMMARY.json").write_text(json.dumps(summary, indent=2) + "\n")
    manifest = {str(p.relative_to(out)): dict(bytes=p.stat().st_size, sha256=sha(p.read_bytes())) for p in sorted(out.rglob("*")) if p.is_file()}
    (out / "SHA256_MANIFEST.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print("D97HW_DONOR_IDENTITY=PASS")
    print("D97HW_P1_RECONSTRUCTION=EXACT_PERSISTED_ACTIVE_SHA")
    print("D97HW_P3_RECONSTRUCTION=EXACT_PERSISTED_ACTIVE_SHA")
    print("D97HW_GOLDEN_RUNTIME_EQUIVALENCE=UNKNOWN")
    print("D97HW_P2B_AUTHORIZED=NO")
    for item in summary["P3_MTLCompiler32023"]["strings"]:
        print("STRING", hex(item["file_offset"]), item["section"], item["text"])
    for item in summary["P3_MTLCompiler32023"]["xrefs"]:
        print("XREF_CANDIDATE", hex(item["instruction_va"]), item["nearest_symbol"], item["string"]["text"])
    print("D97HW_STATUS=PASS_STATIC_COLLECTION_PENDING_CAUSAL_REVIEW")


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print("D97HW_STATUS=FAIL_CLOSED", type(error).__name__, str(error), file=sys.stderr)
        sys.exit(1)
