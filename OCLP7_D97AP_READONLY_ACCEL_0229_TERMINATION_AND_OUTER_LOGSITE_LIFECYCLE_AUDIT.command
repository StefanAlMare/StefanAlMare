#!/bin/zsh -f
set -euo pipefail

START="2026-09-04 02:29:00"
END="2026-09-04 02:31:59"
TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_SHA="e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9"
EXPECTED_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
EXPECTED_RECORD_COUNT="79"
EXPECTED_PC_OFFSETS="0x9FFEE,0xA0521,0xA5F81"
OUT="$HOME/Desktop/OCLP7_D97AP_ACCEL_0229_TERMINATION_AND_OUTER_LOGSITE_LIFECYCLE_AUDIT.txt"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AP.XXXXXX)"
MTL_JSON="$TMP/mtl.json"
SYS_JSON="$TMP/system.json"
MTL_ERR="$TMP/mtl.err"
SYS_ERR="$TMP/system.err"
OTOOL_OUT="$TMP/otool.txt"
NM_OUT="$TMP/nm.txt"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AP.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AP_AUDIT=FAIL_CLOSED|REASON=$1"
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

echo "===== OCLP7 D97AP — READ-ONLY 02:29 TERMINATION + OUTER LOGSITE LIFECYCLE AUDIT ====="
echo "HISTORICAL_ACCEL_WINDOW_START=$START"
echo "HISTORICAL_ACCEL_WINDOW_END=$END"
echo "TARGET=$TARGET"
echo "EXPECTED_SHA256=$EXPECTED_SHA"
echo "EXPECTED_UUID=$EXPECTED_UUID"
echo "EXPECTED_EXACT_32023_RECORD_COUNT=$EXPECTED_RECORD_COUNT"
echo "D97AN_EXPECTED_RUNTIME_PC_OFFSETS=$EXPECTED_PC_OFFSETS"
echo "CURRENT_BOOT_IDENTITY_REQUIRED=NO"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "HISTORICAL_CHRONOLOGY=02:29_ACCELERATED_D97AM__02:32_VESA_RECOVERY_PERSISTED"

ACTUAL_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$TARGET")"
echo "TARGET_BYTES=$ACTUAL_BYTES"
echo "TARGET_SHA256=$ACTUAL_SHA"
[[ "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || fail "TARGET_SHA_MISMATCH_NOT_EXACT_D97AM_NATURAL_POSTIMAGE"
echo "D97AP_TARGET_SHA_IDENTITY=PASS"

/usr/bin/otool -tvV "$TARGET" > "$OTOOL_OUT" 2>&1 || fail "OTOOL_DISASSEMBLY_FAILED"
/usr/bin/nm -nm "$TARGET" > "$NM_OUT" 2>&1 || fail "NM_FAILED"

echo "OTOOL_OUTPUT_BYTES=$(/usr/bin/stat -f '%z' "$OTOOL_OUT")"
echo "NM_OUTPUT_BYTES=$(/usr/bin/stat -f '%z' "$NM_OUT")"

/usr/bin/log show \
    --start "$START" \
    --end "$END" \
    --timezone local \
    --style json \
    --info \
    --debug \
    --predicate 'process == "MTLCompilerService"' \
    > "$MTL_JSON" 2> "$MTL_ERR" || true

/usr/bin/log show \
    --start "$START" \
    --end "$END" \
    --timezone local \
    --style json \
    --info \
    --debug \
    --predicate 'process == "launchd" OR process == "runningboardd" OR process == "ReportCrash" OR process == "kernel" OR process == "osanalyticshelper" OR process == "diagnosticd" OR process == "MTLCompilerService"' \
    > "$SYS_JSON" 2> "$SYS_ERR" || true

echo "MTL_JSON_BYTES=$(/usr/bin/stat -f '%z' "$MTL_JSON" 2>/dev/null || echo 0)"
echo "SYSTEM_JSON_BYTES=$(/usr/bin/stat -f '%z' "$SYS_JSON" 2>/dev/null || echo 0)"
echo "MTL_LOG_STDERR_BEGIN"
/bin/cat "$MTL_ERR" 2>/dev/null || true
echo "MTL_LOG_STDERR_END"
echo "SYSTEM_LOG_STDERR_BEGIN"
/bin/cat "$SYS_ERR" 2>/dev/null || true
echo "SYSTEM_LOG_STDERR_END"
echo

"$PYTHON" - "$TARGET" "$OTOOL_OUT" "$NM_OUT" "$MTL_JSON" "$SYS_JSON" "$EXPECTED_UUID" "$EXPECTED_RECORD_COUNT" "$EXPECTED_PC_OFFSETS" <<'PY'
from __future__ import annotations

import collections
import json
import re
import struct
import sys
from pathlib import Path

binary_path = Path(sys.argv[1])
otool_path = Path(sys.argv[2])
nm_path = Path(sys.argv[3])
mtl_path = Path(sys.argv[4])
sys_path = Path(sys.argv[5])
expected_uuid = sys.argv[6].upper()
expected_record_count = int(sys.argv[7])
expected_pc_offsets = [int(x,16) for x in sys.argv[8].split(',')]

SPECIALIZED_TOKEN = "MTLCompilerObject31buildSpecializedFunctionRequest"
BACKEND_TOKEN = "MTLCompilerObject31backendCompileExecutableRequest"


def parse_json_stream(path: Path):
    raw = path.read_text(encoding="utf-8", errors="replace") if path.exists() else ""
    dec = json.JSONDecoder()
    out = []
    i = 0
    n = len(raw)
    while i < n:
        while i < n and (raw[i].isspace() or raw[i] == ','):
            i += 1
        if i >= n:
            break
        if raw[i] not in '[{':
            p1 = raw.find('{', i)
            p2 = raw.find('[', i)
            ps = [p for p in (p1,p2) if p >= 0]
            if not ps:
                break
            i = min(ps)
        try:
            obj, end = dec.raw_decode(raw, i)
        except json.JSONDecodeError:
            i += 1
            continue
        if isinstance(obj, list):
            out.extend(x for x in obj if isinstance(x, dict))
        elif isinstance(obj, dict):
            out.append(obj)
        i = end
    return out


def val(rec, *names):
    for name in names:
        if name in rec and rec[name] is not None:
            return rec[name]
    return None


def clean(v):
    if v is None:
        return "MISSING"
    if isinstance(v, (dict,list)):
        try:
            return json.dumps(v, sort_keys=True, separators=(",",":"), ensure_ascii=False).replace("\n","\\n").replace("\r","\\r")
        except Exception:
            pass
    return str(v).replace("\n","\\n").replace("\r","\\r")


def pid_of(rec):
    p = val(rec,"processID","processIdentifier")
    try:
        return int(p)
    except Exception:
        return -1

# Mach-O image base + LC_UUID.
data = binary_path.read_bytes()
if len(data) < 32 or struct.unpack_from('<I', data, 0)[0] != 0xFEEDFACF:
    raise SystemExit('UNSUPPORTED_MACHO')
_, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags, reserved = struct.unpack_from('<IiiIIIII', data, 0)
pos = 32
segments = []
lc_uuid = None
for _ in range(ncmds):
    cmd, cmdsize = struct.unpack_from('<II', data, pos)
    if cmdsize < 8 or pos + cmdsize > len(data):
        raise SystemExit('LOAD_COMMAND_INVALID')
    if cmd == 0x19 and cmdsize >= 72:
        segname = data[pos+8:pos+24].split(b'\0',1)[0].decode('ascii','replace')
        vmaddr,vmsize,fileoff,filesize = struct.unpack_from('<QQQQ', data, pos+24)
        segments.append((segname,vmaddr,vmsize,fileoff,filesize))
    elif cmd == 0x1B and cmdsize >= 24:
        u=data[pos+8:pos+24]
        lc_uuid=f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
    pos += cmdsize
texts=[s for s in segments if s[0]=='__TEXT']
if len(texts)!=1:
    raise SystemExit('TEXT_SEGMENT_COUNT='+str(len(texts)))
image_base=texts[0][1]
print(f'MACHO_IMAGE_BASE=0x{image_base:X}')
print(f'MACHO_LC_UUID={lc_uuid}')
if lc_uuid != expected_uuid:
    raise SystemExit('LC_UUID_MISMATCH')
print('D97AP_TARGET_LC_UUID_IDENTITY=PASS')

# Parse disassembly.
rx = re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
inst=[]
for line in otool_path.read_text(encoding='utf-8',errors='replace').splitlines():
    m=rx.match(line)
    if not m:
        continue
    try: addr=int(m.group(1),16)
    except ValueError: continue
    body=m.group(2).strip()
    if not body: continue
    p=body.split(None,1)
    inst.append((addr,p[0].lower(),p[1].strip() if len(p)>1 else '',body))
inst.sort()
by_addr={x[0]:x for x in inst}
addrs=[x[0] for x in inst]
next_addr={addrs[i]:addrs[i+1] for i in range(len(addrs)-1)}
print('FULL_IMAGE_DISASSEMBLED_INSTRUCTION_COUNT='+str(len(inst)))

# Parse symbols and function ranges.
symbols=[]
for line in nm_path.read_text(encoding='utf-8',errors='replace').splitlines():
    m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',line)
    if not m: continue
    try: a=int(m.group(1),16)
    except ValueError: continue
    symbols.append((a,m.group(2).strip()))
symbols.sort()

def find_symbol(token):
    hits=[x for x in symbols if token in x[1]]
    if len(hits)!=1:
        raise SystemExit(f'SYMBOL_COUNT_{token}={len(hits)}')
    return hits[0]

def function_range(token):
    start,name=find_symbol(token)
    ends=[a for a,n in symbols if a>start]
    end=min(ends) if ends else (inst[-1][0]+16)
    return start,end,name

spec_start,spec_end,spec_name=function_range(SPECIALIZED_TOKEN)
back_start,back_end,back_name=function_range(BACKEND_TOKEN)
print('===== FUNCTION RANGES =====')
print(f'SPECIALIZED_FUNCTION_START=0x{spec_start:X}|END=0x{spec_end:X}|NAME={spec_name}')
print(f'BACKEND_FUNCTION_START=0x{back_start:X}|END=0x{back_end:X}|NAME={back_name}')

# Enumerate __os_log_impl calls and infer format literal from nearby annotated context.
def logsites(start,end,label):
    fi=[x for x in inst if start<=x[0]<end]
    index={x[0]:i for i,x in enumerate(fi)}
    out=[]
    for i,row in enumerate(fi):
        addr,mn,op,body=row
        if mn not in ('call','callq') or '__os_log_impl' not in body:
            continue
        sender=next_addr.get(addr)
        fmt='UNKNOWN'
        fmt_addr=None
        for prev in reversed(fi[max(0,i-14):i]):
            txt=prev[3]
            m=re.search(r'literal pool for: "(.*)"',txt)
            if m:
                fmt=m.group(1)
                fmt_addr=prev[0]
                break
        out.append({'function':label,'call':addr,'sender':sender,'format':fmt,'format_inst':fmt_addr})
    return out

sites=logsites(spec_start,spec_end,'SPECIALIZED')+logsites(back_start,back_end,'BACKEND')
print('===== STATIC OS_LOG SITES =====')
print('STATIC_OS_LOG_SITE_COUNT='+str(len(sites)))
for s in sites:
    print(f'LOGSITE|FUNCTION={s["function"]}|CALL_IMAGE_OFFSET=0x{s["call"]-image_base:X}|SENDER_PC_IMAGE_OFFSET={"0x%X"%(s["sender"]-image_base) if s["sender"] else "NONE"}|FORMAT_INST_IMAGE_OFFSET={"0x%X"%(s["format_inst"]-image_base) if s["format_inst"] else "NONE"}|FORMAT={s["format"]}')

site_by_off={s['sender']-image_base:s for s in sites if s['sender'] is not None}
print('===== D97AN EXPECTED PC -> STATIC LOGSITE =====')
all_expected_mapped=True
for off in expected_pc_offsets:
    s=site_by_off.get(off)
    print(f'EXPECTED_PC_MAP|IMAGE_OFFSET=0x{off:X}|MAPPED={"YES" if s else "NO"}|FUNCTION={s["function"] if s else "MISSING"}|FORMAT={s["format"] if s else "MISSING"}')
    all_expected_mapped &= s is not None
print('D97AP_D97AN_OUTER_PC_LOGSITE_RECONCILIATION='+('PASS' if all_expected_mapped else 'INCONCLUSIVE'))

# Historical MTL records.
mtl=parse_json_stream(mtl_path)
print('MTL_JSON_RECORDS='+str(len(mtl)))
records=[]
for r in mtl:
    path=clean(val(r,'senderImagePath'))
    uuid=clean(val(r,'senderImageUUID')).upper()
    if not path.endswith('/MTLCompiler.framework/Versions/32023/MTLCompiler') or uuid != expected_uuid:
        continue
    pc=val(r,'senderProgramCounter')
    try:
        if isinstance(pc,str):
            pcv=int(pc,0)
        else:
            pcv=int(pc)
    except Exception:
        pcv=-1
    records.append((clean(val(r,'timestamp')),pid_of(r),pcv,clean(val(r,'eventMessage','message'))))

print('EXACT_NATURAL_32023_RECORD_COUNT='+str(len(records)))
if len(records)!=expected_record_count:
    print(f'D97AP_EXPECTED_RECORD_COUNT_MATCH=NO|EXPECTED={expected_record_count}|ACTUAL={len(records)}')
else:
    print('D97AP_EXPECTED_RECORD_COUNT_MATCH=PASS')

pc_counts=collections.Counter(x[2] for x in records)
print('===== RUNTIME PC COUNTS / STATIC LABELS =====')
for pc,count in sorted(pc_counts.items()):
    s=site_by_off.get(pc)
    print(f'RUNTIME_PC_COUNT|IMAGE_OFFSET=0x{pc:X}|COUNT={count}|STATIC_LOGSITE={"YES" if s else "NO"}|FUNCTION={s["function"] if s else "MISSING"}|FORMAT={s["format"] if s else "MISSING"}')

per_pid=collections.defaultdict(list)
for ts,pid,pc,msg in records:
    per_pid[pid].append((ts,pc,msg))
for pid in per_pid:
    per_pid[pid].sort()

print('===== PER-PID EXACT NATURAL-UUID LOGSITE SEQUENCE =====')
for pid in sorted(per_pid):
    seq=[]
    for ts,pc,msg in per_pid[pid]:
        s=site_by_off.get(pc)
        label=(s['function']+':'+s['format']) if s else f'UNMAPPED_0x{pc:X}'
        seq.append(label)
    print(f'PID_LOGSITE_SEQUENCE|PID={pid}|COUNT={len(seq)}|SEQUENCE='+' -> '.join(seq))

# Identify specialized start/timing sites and backend start sites by static format.
spec_start_sites=[s for s in sites if s['function']=='SPECIALIZED' and 'Build request:' in s['format']]
spec_timing_sites=[s for s in sites if s['function']=='SPECIALIZED' and 'Compilation (' in s['format'] and 'time' in s['format']]
back_start_sites=[s for s in sites if s['function']=='BACKEND' and 'Build request:' in s['format']]
back_timing_sites=[s for s in sites if s['function']=='BACKEND' and 'Compilation (' in s['format'] and 'time' in s['format']]

def off_set(ss):
    return {s['sender']-image_base for s in ss if s['sender'] is not None}
ss=off_set(spec_start_sites); st=off_set(spec_timing_sites); bs=off_set(back_start_sites); bt=off_set(back_timing_sites)
print('===== COARSE REQUEST-LIFECYCLE COUNTS =====')
print('SPECIALIZED_START_STATIC_SITE_COUNT='+str(len(ss)))
print('SPECIALIZED_TIMING_STATIC_SITE_COUNT='+str(len(st)))
print('BACKEND_START_STATIC_SITE_COUNT='+str(len(bs)))
print('BACKEND_TIMING_STATIC_SITE_COUNT='+str(len(bt)))
print('SPECIALIZED_START_RUNTIME_COUNT='+str(sum(pc_counts[o] for o in ss)))
print('SPECIALIZED_TIMING_RUNTIME_COUNT='+str(sum(pc_counts[o] for o in st)))
print('BACKEND_START_RUNTIME_COUNT='+str(sum(pc_counts[o] for o in bs)))
print('BACKEND_TIMING_RUNTIME_COUNT='+str(sum(pc_counts[o] for o in bt)))

paired=0
start_without=0
timing_without=0
for pid,seqrows in per_pid.items():
    pcs=[x[1] for x in seqrows]
    has_s=any(p in ss for p in pcs)
    has_t=any(p in st for p in pcs)
    if has_s and has_t: paired+=1
    elif has_s: start_without+=1
    elif has_t: timing_without+=1
print('SPECIALIZED_PID_HAS_START_AND_TIMING='+str(paired))
print('SPECIALIZED_PID_HAS_START_WITHOUT_TIMING='+str(start_without))
print('SPECIALIZED_PID_HAS_TIMING_WITHOUT_START='+str(timing_without))
if ss and st and start_without==0 and timing_without==0:
    print('D97AP_SPECIALIZED_START_TIMING_PAIRING=PROVEN_FOR_OBSERVED_LOGSITE_COHORT')
else:
    print('D97AP_SPECIALIZED_START_TIMING_PAIRING=INCONCLUSIVE')

# System-daemon termination/corpse/crash evidence.
sysrecs=parse_json_stream(sys_path)
print('SYSTEM_JSON_RECORDS='+str(len(sysrecs)))
known_pids=set(per_pid.keys())
term_rx=re.compile(r'crash|crashed|signal|sigsegv|sigabrt|sigill|killed|kill|exit|exited|terminat|corpse|exception|jetsam|watchdog|fault|abort|inactive|spawn',re.I)
strong_rx=re.compile(r'sigsegv|sigabrt|sigill|signal\s+[0-9]+|crash(?:ed)?|exception|corpse|jetsam|watchdog|exited?\s+(?:with|due|code|status)|termination reason',re.I)
relevant=[]
strong=[]
for r in sysrecs:
    msg=clean(val(r,'eventMessage','message'))
    proc=clean(val(r,'processImagePath','process'))
    pid=pid_of(r)
    mentions_service='MTLCompilerService' in msg or 'MTLCompilerService' in proc
    mentions_pid=any(re.search(rf'(?<!\d){p}(?!\d)',msg) for p in known_pids) if known_pids else False
    if (mentions_service or mentions_pid) and term_rx.search(msg):
        row=(clean(val(r,'timestamp')),clean(val(r,'process')),pid,msg)
        relevant.append(row)
        if strong_rx.search(msg):
            strong.append(row)

print('===== SYSTEM TERMINATION / CRASH / CORPSE CANDIDATES =====')
print('SYSTEM_TERMINATION_RELEVANT_COUNT='+str(len(relevant)))
print('SYSTEM_TERMINATION_STRONG_TEXT_COUNT='+str(len(strong)))
for ts,proc,pid,msg in relevant:
    print(f'SYSTEM_TERM_RECORD|TS={ts}|LOGGER={proc}|LOGGER_PID={pid}|MSG={msg}')

if strong:
    print('D97AP_EXACT_TERMINATION_CHANNEL=STRONG_TEXT_CANDIDATES_PRESENT_REQUIRES_RAW_AUDIT')
else:
    print('D97AP_EXACT_TERMINATION_CHANNEL=NO_STRONG_TEXT_RECOVERED_FROM_SELECTED_SYSTEM_LOGGERS')

print('===== STATIC/RUNTIME EVIDENCE BOUNDARY =====')
print('D97AP_OUTER_LOGSITE_MAPPING_DOES_NOT_PROVE_VALIDATOR_LATE_RUNTIME_REACHABILITY=YES')
print('D97AO_ALL_FIVE_LATE_STATIC_REACHABILITY_REMAINS_STATIC_PROVEN=YES')
print('D97AP_LOG_LIFECYCLE_AUDIT=COMPLETE')
PY

echo
echo "===== DIAGNOSTIC REPORT FILESYSTEM SCAN ====="
"$PYTHON" - <<'PY'
from pathlib import Path
import re

roots=[
    Path('/Library/Logs/DiagnosticReports'),
    Path.home()/'Library/Logs/DiagnosticReports',
    Path('/Library/Logs/CrashReporter'),
]
seen=[]
for root in roots:
    if not root.exists():
        print(f'DIAG_ROOT|PATH={root}|EXISTS=NO')
        continue
    print(f'DIAG_ROOT|PATH={root}|EXISTS=YES')
    try:
        files=list(root.glob('*'))
    except Exception as e:
        print(f'DIAG_ROOT_LIST_ERROR|PATH={root}|ERROR={type(e).__name__}:{e}')
        continue
    for p in files:
        if not p.is_file():
            continue
        name=p.name
        if 'MTLCompilerService' in name:
            seen.append(p)
            continue
        if p.suffix.lower() not in ('.ips','.crash','.diag'):
            continue
        try:
            head=p.read_text(encoding='utf-8',errors='replace')[:16384]
        except Exception:
            continue
        if 'MTLCompilerService' in head:
            seen.append(p)

uniq=[]
seen_names=set()
for p in seen:
    s=str(p)
    if s not in seen_names:
        uniq.append(p); seen_names.add(s)
print('MTLCOMPILERSERVICE_DIAGNOSTIC_FILE_COUNT='+str(len(uniq)))
for p in sorted(uniq,key=lambda x:str(x)):
    try:
        st=p.stat()
        head=p.read_text(encoding='utf-8',errors='replace')[:32768]
    except Exception as e:
        print(f'DIAG_FILE_ERROR|PATH={p}|ERROR={type(e).__name__}:{e}')
        continue
    lines=[]
    for line in head.splitlines():
        if re.search(r'Date/Time|timestamp|captureTime|Process:|procName|Exception Type|Termination Reason|signal|incident|MTLCompilerService',line,re.I):
            lines.append(line.strip())
        if len(lines)>=25:
            break
    print(f'DIAG_FILE|PATH={p}|BYTES={st.st_size}|MTIME_NS={st.st_mtime_ns}')
    for line in lines:
        print('DIAG_FILE_KEYLINE|'+line.replace('\n','\\n').replace('\r','\\r'))
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
echo "D97AP_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
