#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AET_READONLY_EXECUTED_TEXT_PC_BACKTRACE_AND_SHARED_CACHE_PROVENANCE_REPORT.txt"
JSONLOG="/private/tmp/OCLP7_D97AET_MTL_JSON.log"
START="2026-09-02 00:10:00"
END="2026-09-02 00:12:00"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
EXPECTED_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_32023_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
EXPECTED_32023_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
EXPECTED_3802_UUID="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){
  echo "D97AET_FAIL=$*"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "RUNTIME_INSTRUMENTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

/bin/rm -f "$JSONLOG"

echo "===== OCLP7 D97AET — READ-ONLY EXECUTED-TEXT PC/BACKTRACE + SHARED-CACHE PROVENANCE ====="
echo "INPUT_D97AEQ=28_of_28_natural_exit1_zero_exit110_114"
echo "INPUT_D97AER=visible_32023_late_diagnostic_xrefs_all_after_REL_0x58B"
echo "INPUT_D97AES=runtime_diagnostic_sender_path_and_UUID_32023_proven_all_28_PIDs"
echo "PURPOSE=map_historical_senderProgramCounter_and_backtrace_imageOffsets_to_visible_32023_validator_and_test_dyld_shared_cache_presence_without_runtime_mutation"
echo "ACCELERATED_BOOT=2026-09-02_00:10"
echo "VESA_RECOVERY_BOOT=2026-09-02_00:12|EXCLUDED"
echo "CONTENT_WINDOW_START=$START"
echo "CONTENT_WINDOW_END_EXCLUSIVE=$END"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"

PRODUCT="$(/usr/bin/sw_vers -productVersion 2>/dev/null || true)"
BUILD="$(/usr/bin/sw_vers -buildVersion 2>/dev/null || true)"
PY="$(command -v python3 2>/dev/null || true)"
echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "PYTHON_EXEC=${PY:-MISSING}"
[[ "$PRODUCT" == "26.6.2" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "25G82" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PY" && -x "$PY" ]] || fail "PYTHON3_MISSING"
for tool in shasum otool log last stat; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done
"$PY" --version 2>&1

[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING"
[[ -f "$MTL32023" ]] || fail "MTL32023_MISSING"
SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
MTL32023_SHA="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
echo "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
echo "VISIBLE_MTL32023_SHA=$MTL32023_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_SERVICE_SHA" ]] || fail "SERVICE_SHA_MISMATCH:$SERVICE_SHA"
[[ "$MTL32023_SHA" == "$EXPECTED_32023_SHA" ]] || fail "MTL32023_SHA_MISMATCH:$MTL32023_SHA"

UUID32023="$(/usr/bin/otool -l "$MTL32023" | /usr/bin/awk '/LC_UUID/{f=1;next} f&&/uuid/{print $2;exit}')"
UUID3802="UNKNOWN"
if [[ -f "$MTL3802" ]]; then
  UUID3802="$(/usr/bin/otool -l "$MTL3802" | /usr/bin/awk '/LC_UUID/{f=1;next} f&&/uuid/{print $2;exit}')"
fi
echo "VISIBLE_MTL32023_LC_UUID=$UUID32023"
echo "VISIBLE_MTL3802_LC_UUID=$UUID3802"
[[ "${UUID32023:u}" == "$EXPECTED_32023_UUID" ]] || fail "MTL32023_UUID_MISMATCH:$UUID32023"
if [[ "$UUID3802" != "UNKNOWN" ]]; then
  [[ "${UUID3802:u}" == "$EXPECTED_3802_UUID" ]] || fail "MTL3802_UUID_MISMATCH:$UUID3802"
fi
echo "VISIBLE_IDENTITIES=PASS"

echo "===== D97AD SITE RECHECK ====="
"$PY" - "$MTL32023" <<'PY'
from pathlib import Path
import sys
b=Path(sys.argv[1]).read_bytes()
sites={
 'CANDIDATE_EXIT110':(0x9D6BD,'6a6e5fe9bb38f6ff90'),
 'LATE_BUFFERS_XREF':(0x9D6C8,None),
 'LATE_SAMPLERS_XREF':(0x9D6EE,None),
 'LATE_TEXTURES_XREF':(0x9D712,None),
 'LATE_CONSTBUF_XREF':(0x9D73A,None),
 'LATE_INTERP_XREF':(0x9D75D,None),
 'COMMON_FORMATTER_CALL':(0x9D775,None),
}
for name,(off,expected) in sites.items():
    actual=b[off:off+(len(bytes.fromhex(expected)) if expected else 16)].hex()
    print(f'D97AD_SITE={name}|IMAGE_OFFSET=0x{off:X}|ACTUAL={actual}')
    if expected and actual!=expected:
        raise SystemExit('CANDIDATE_POSTIMAGE_MISMATCH')
print('D97AD_CANDIDATE_EXIT110_VISIBLE=PASS')
PY

echo "===== HISTORICAL JSON EXTRACTION WITH BACKTRACE ====="
PRED='process == "MTLCompilerService"'
set +e
/usr/bin/log show --start "$START" --end "$END" --style json --info --debug --backtrace --predicate "$PRED" > "$JSONLOG" 2>&1
LOG_RC=$?
set -e
echo "JSON_LOG_SHOW_RC=$LOG_RC"
[[ "$LOG_RC" -eq 0 ]] || fail "JSON_LOG_SHOW_FAILED:$LOG_RC"
echo "JSON_LOG_BYTES=$(/usr/bin/stat -f %z "$JSONLOG")"

"$PY" - "$JSONLOG" "$EXPECTED_32023_UUID" <<'PY'
from pathlib import Path
import collections,json,re,sys
p=Path(sys.argv[1]); u32023=sys.argv[2].upper()
raw=p.read_text(errors='replace').strip()

def load_records(text):
    try:
        x=json.loads(text)
        if isinstance(x,list): return x
        if isinstance(x,dict): return [x]
    except Exception: pass
    out=[]
    for ln in text.splitlines():
        ln=ln.strip().rstrip(',')
        if not ln or ln in ('[',']'): continue
        try:
            x=json.loads(ln)
            if isinstance(x,dict): out.append(x)
        except Exception: pass
    return out

def asint(v):
    if isinstance(v,bool): return int(v)
    if isinstance(v,int): return v
    if isinstance(v,float): return int(v)
    if isinstance(v,str):
        s=v.strip()
        try: return int(s,0)
        except Exception:
            try: return int(s)
            except Exception: return None
    return None

def normuuid(v): return str(v or '').upper()
def frames_of(r):
    f=r.get('backtrace.frames')
    if isinstance(f,list): return f
    bt=r.get('backtrace')
    if isinstance(bt,dict) and isinstance(bt.get('frames'),list): return bt['frames']
    return []

def msgdiag(r):
    m=str(r.get('eventMessage') or '')
    return ('simulator' in m.lower() and 'were used' in m.lower())

records=load_records(raw)
diag=[r for r in records if msgdiag(r) and normuuid(r.get('senderImageUUID'))==u32023]
print(f'JSON_RECORD_COUNT={len(records)}')
print(f'DIAGNOSTIC_32023_RECORD_COUNT={len(diag)}')
print(f'DIAGNOSTIC_32023_UNIQUE_PID_COUNT={len({asint(r.get("processID")) for r in diag if asint(r.get("processID")) is not None})}')

VALIDATOR_START=0x9D132
VALIDATOR_END=0x9D830
CANDIDATE=0x9D6BD
KNOWN={
 0x9D6C8:'LATE_BUFFERS_XREF',0x9D6EE:'LATE_SAMPLERS_XREF',0x9D712:'LATE_TEXTURES_XREF',
 0x9D73A:'LATE_CONSTBUF_XREF',0x9D75D:'LATE_INTERP_XREF',0x9D775:'COMMON_FORMATTER_CALL'
}

def classify_offset(off):
    if off is None: return 'UNKNOWN'
    if off in KNOWN: return KNOWN[off]
    if VALIDATOR_START <= off < VALIDATOR_END:
        rel=off-VALIDATOR_START
        if off < CANDIDATE: return f'VALIDATOR_PRE_CANDIDATE_REL_0x{rel:X}'
        if off == CANDIDATE: return 'VALIDATOR_CANDIDATE_EXIT110_SITE'
        return f'VALIDATOR_POST_CANDIDATE_REL_0x{rel:X}'
    return 'OUTSIDE_VALIDATOR'

sender_hist=collections.Counter(); frame_hist=collections.Counter(); rel_hist=collections.Counter()
pids_post=set(); pids_validator=set(); pids_frames=set(); pids_sender=set()

for i,r in enumerate(diag,1):
    pid=asint(r.get('processID'))
    spc=asint(r.get('senderProgramCounter'))
    sender_hist[spc]+=1
    if pid is not None: pids_sender.add(pid)
    frs=frames_of(r)
    same=[]
    for f in frs:
        if not isinstance(f,dict): continue
        fu=normuuid(f.get('imageUUID') or f.get('uuid'))
        if fu!=u32023: continue
        off=asint(f.get('imageOffset'))
        same.append((off,f))
        if off is not None:
            frame_hist[off]+=1
            if pid is not None: pids_frames.add(pid)
            if VALIDATOR_START <= off < VALIDATOR_END:
                pids_validator.add(pid)
                rel=off-VALIDATOR_START
                rel_hist[rel]+=1
                if off>CANDIDATE: pids_post.add(pid)
    print(f'DIAG_PC_{i}=PID={pid}|SENDER_PC={"0x%X"%spc if spc is not None else "UNKNOWN"}|SENDER_CLASS={classify_offset(spc)}|SAME_IMAGE_FRAME_COUNT={len(same)}')
    for j,(off,f) in enumerate(same,1):
        symbol=f.get('symbol') or f.get('symbolName') or 'UNKNOWN'
        print(f'DIAG_FRAME_{i}_{j}=PID={pid}|IMAGE_OFFSET={"0x%X"%off if off is not None else "UNKNOWN"}|CLASS={classify_offset(off)}|SYMBOL={symbol}|RAW_KEYS={",".join(sorted(f.keys()))}')

print('===== PC / BACKTRACE SUMMARY =====')
for off,c in sorted(sender_hist.items(),key=lambda x:(x[0] is None,x[0] or 0)):
    print(f'SENDER_PC_HISTOGRAM=OFFSET={"0x%X"%off if off is not None else "UNKNOWN"}|COUNT={c}|CLASS={classify_offset(off)}')
for off,c in sorted(frame_hist.items()):
    print(f'FRAME_OFFSET_HISTOGRAM=OFFSET=0x{off:X}|COUNT={c}|CLASS={classify_offset(off)}')
for rel,c in sorted(rel_hist.items()):
    print(f'VALIDATOR_REL_HISTOGRAM=REL=0x{rel:X}|COUNT={c}|POST_CANDIDATE={rel>0x58B}')
print(f'PIDS_WITH_32023_BACKTRACE_FRAMES={len(pids_frames)}|PIDS={sorted(pids_frames)}')
print(f'PIDS_WITH_VALIDATOR_FRAME={len(pids_validator)}|PIDS={sorted(pids_validator)}')
print(f'PIDS_WITH_VALIDATOR_FRAME_AFTER_EXIT110_SITE={len(pids_post)}|PIDS={sorted(pids_post)}')
if pids_post:
    print('D97AET_RUNTIME_32023_CONTROL_FLOW_BEYOND_VISIBLE_EXIT110_SITE=PROVEN_BY_HISTORICAL_BACKTRACE_IMAGE_OFFSETS')
else:
    print('D97AET_RUNTIME_32023_CONTROL_FLOW_BEYOND_VISIBLE_EXIT110_SITE=NOT_PROVEN_BY_AVAILABLE_BACKTRACE_OFFSETS')
PY

echo "===== DYLD SHARED CACHE PRESENCE MAP ====="
CACHE_PATHS=()
for c in \
  /System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h \
  /System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64 \
  /System/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h \
  /System/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64 \
  /System/Library/dyld/dyld_shared_cache_x86_64h \
  /System/Library/dyld/dyld_shared_cache_x86_64; do
  if [[ -f "$c" ]]; then CACHE_PATHS+=("$c"); fi
done
print "DYLD_CACHE_FILE_COUNT=${#CACHE_PATHS[@]}"
for c in "${CACHE_PATHS[@]}"; do
  echo "DYLD_CACHE_FILE=$c|SIZE=$(/usr/bin/stat -f %z "$c")|MTIME=$(/usr/bin/stat -f %Sm -t '%Y-%m-%d_%H:%M:%S' "$c")"
done

if (( ${#CACHE_PATHS[@]} > 0 )); then
  "$PY" - "$EXPECTED_32023_UUID" "${CACHE_PATHS[@]}" <<'PY'
from pathlib import Path
import mmap,sys
uuid=sys.argv[1]
paths=[Path(x) for x in sys.argv[2:]]
needles={
 'PATH_32023':b'/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler',
 'PATH_3802':b'/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler',
 'UUID_32023_ASCII':uuid.encode(),
}
for p in paths:
    print('CACHE_SCAN='+str(p))
    try:
        with p.open('rb') as f:
            mm=mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ)
            try:
                for name,n in needles.items():
                    pos=mm.find(n)
                    print(f'CACHE_NEEDLE={name}|FOUND={pos>=0}|OFFSET={"0x%X"%pos if pos>=0 else "NA"}')
            finally: mm.close()
    except Exception as e:
        print('CACHE_SCAN_ERROR='+repr(e))
PY
else
  echo "DYLD_SHARED_CACHE_LOCAL_FILE_DISCOVERY=NONE_AT_STANDARD_CRYPTEX_OR_SYSTEM_PATHS"
fi

DSCU="$(command -v dyld_shared_cache_util 2>/dev/null || true)"
if [[ -z "$DSCU" ]] && command -v xcrun >/dev/null 2>&1; then
  DSCU="$(xcrun -f dyld_shared_cache_util 2>/dev/null || true)"
fi
echo "TOOL_dyld_shared_cache_util=${DSCU:-MISSING}"
if [[ -n "$DSCU" && ${#CACHE_PATHS[@]} -gt 0 ]]; then
  for c in "${CACHE_PATHS[@]}"; do
    TMP="/private/tmp/OCLP7_D97AET_dsc_list.$$.txt"
    set +e
    "$DSCU" -list "$c" > "$TMP" 2>&1
    RC=$?
    set -e
    echo "DSC_LIST=FILE=$c|RC=$RC|LINES=$(/usr/bin/wc -l < "$TMP" | /usr/bin/tr -d ' ')"
    if [[ "$RC" -eq 0 ]]; then
      H32023="$(/usr/bin/grep -F -c '/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler' "$TMP" || true)"
      H3802="$(/usr/bin/grep -F -c '/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler' "$TMP" || true)"
      echo "DSC_LIST_IMAGE_HITS=32023:$H32023|3802:$H3802"
      /usr/bin/grep -F 'MTLCompiler.framework/Versions/' "$TMP" | /usr/bin/head -n 20 | /usr/bin/sed 's/^/DSC_IMAGE=/' || true
    fi
    /bin/rm -f "$TMP"
  done
fi

echo "===== FINAL ====="
echo "D97AET_READONLY_EXECUTED_TEXT_PC_BACKTRACE_AND_SHARED_CACHE_PROVENANCE=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "NEXT=assistant_audit_PC_backtrace_and_shared_cache_provenance_before_any_runtime_change"
echo "REPORT=$REPORT"
