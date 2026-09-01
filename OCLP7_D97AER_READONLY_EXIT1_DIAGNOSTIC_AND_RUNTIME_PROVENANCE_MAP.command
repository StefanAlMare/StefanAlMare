#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AER_READONLY_EXIT1_DIAGNOSTIC_AND_RUNTIME_PROVENANCE_MAP_REPORT.txt"
STATIC_REPORT="/private/tmp/OCLP7_D97AER_STATIC_MAP.txt"
PROV_LOG="/private/tmp/OCLP7_D97AER_PROVENANCE.log"
RUNTIME_LOG="/private/tmp/OCLP7_D97AER_RUNTIME.log"
START="2026-09-02 00:10:00"
END="2026-09-02 00:12:00"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
EXPECTED_32023_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
EXPECTED_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){
  echo "D97AER_FAIL=$*"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

/bin/rm -f "$STATIC_REPORT" "$PROV_LOG" "$RUNTIME_LOG"

echo "===== OCLP7 D97AER — READ-ONLY EXIT(1) DIAGNOSTIC + RUNTIME PROVENANCE MAP ====="
echo "INPUT_D97AEQ=28_of_28_MTLCompilerService_natural_exit1_zero_exit110_114"
echo "PURPOSE=map_the_universal_pre_exit_simulator_diagnostic_and_discriminate_visible_32023_D97AD_vs_3802_or_alternate_runtime_provenance"
echo "ACCELERATED_BOOT=2026-09-02_00:10"
echo "VESA_RECOVERY_BOOT=2026-09-02_00:12|EXCLUDED"
echo "CONTENT_WINDOW_START=$START"
echo "CONTENT_WINDOW_END_EXCLUSIVE=$END"
echo "EXPECTED_SELECTOR_ONLY_SERVICE_SHA=$EXPECTED_SERVICE_SHA"
echo "EXPECTED_D97AD_32023_SHA=$EXPECTED_32023_SHA"
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
for tool in shasum otool nm strings log last; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done
"$PY" --version 2>&1

[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING:$SERVICE"
[[ -f "$MTL32023" ]] || fail "MTL32023_MISSING:$MTL32023"
SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
MTL32023_SHA="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
echo "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
echo "VISIBLE_MTL32023_SHA=$MTL32023_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_SERVICE_SHA" ]] || fail "VISIBLE_SERVICE_SHA_MISMATCH:$SERVICE_SHA"
[[ "$MTL32023_SHA" == "$EXPECTED_32023_SHA" ]] || fail "VISIBLE_MTL32023_SHA_MISMATCH:$MTL32023_SHA"
echo "VISIBLE_D97AD_IDENTITIES=PASS"

if [[ -f "$MTL3802" ]]; then
  MTL3802_SHA="$(/usr/bin/shasum -a 256 "$MTL3802" | /usr/bin/awk '{print $1}')"
  echo "VISIBLE_MTL3802_PATH=$MTL3802"
  echo "VISIBLE_MTL3802_SHA=$MTL3802_SHA"
else
  MTL3802_SHA="MISSING"
  echo "VISIBLE_MTL3802_PATH=MISSING"
  echo "VISIBLE_MTL3802_SHA=MISSING"
fi

echo "===== STATIC STRING / XREF / SYMBOL MAP ====="
"$PY" - "$MTL32023" "$MTL3802" > "$STATIC_REPORT" <<'PY'
from pathlib import Path
import bisect, re, subprocess, sys

paths=[("32023", Path(sys.argv[1])), ("3802", Path(sys.argv[2]))]

def run(cmd, timeout=180):
    try:
        p=subprocess.run(cmd, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=timeout)
        return p.returncode, p.stdout
    except Exception as e:
        return -999, "TOOL_ERROR:"+repr(e)

def parse_symbols(text):
    out=[]
    for ln in text.splitlines():
        m=re.match(r'^([0-9A-Fa-f]{8,16})\s+\([^)]*\)\s+.*?\s(\S+)$',ln.strip())
        if not m:
            m=re.match(r'^([0-9A-Fa-f]{8,16})\s+.*?\s(\S+)$',ln.strip())
        if m:
            try: out.append((int(m.group(1),16),m.group(2)))
            except: pass
    return sorted(set(out))

def owner(symbols, addr):
    addrs=[x[0] for x in symbols]
    i=bisect.bisect_right(addrs,addr)-1
    return symbols[i] if i>=0 else (None,"UNKNOWN")

for label,path in paths:
    print(f"===== STATIC_BINARY={label} =====")
    if not path.is_file():
        print(f"STATIC_{label}_PRESENT=NO")
        continue
    print(f"STATIC_{label}_PRESENT=YES")
    rc_s,sout=run(['/usr/bin/strings','-a',str(path)])
    print(f"STRINGS_RC={rc_s}")
    simstrings=[]
    if rc_s==0:
        for s in sout.splitlines():
            low=s.lower()
            if ('simulator' in low and ('were used' in low or 'supported' in low or 'supportted' in low)):
                simstrings.append(s)
    unique=[]
    for s in simstrings:
        if s not in unique: unique.append(s)
    print(f"SIMULATOR_STRING_COUNT={len(unique)}")
    for i,s in enumerate(unique,1):
        print(f"SIMULATOR_STRING_{i}={s}")

    rc_nm,nmout=run(['/usr/bin/nm','-nm',str(path)])
    print(f"NM_RC={rc_nm}")
    symbols=parse_symbols(nmout) if rc_nm==0 else []
    validator=[x for x in symbols if 'validSimulatorMetadata' in x[1]]
    print(f"VALIDATOR_SYMBOL_HIT_COUNT={len(validator)}")
    for v in validator: print(f"VALIDATOR_SYMBOL=0x{v[0]:X}|{v[1]}")
    vstart=validator[0][0] if len(validator)==1 else None
    vend=None
    if label=='32023':
        expected_start=0x7FFB162C7132
        expected_end=0x7FFB162C7830
        print(f"VALIDATOR_EXPECTED_START=0x{expected_start:X}")
        print(f"VALIDATOR_EXPECTED_END=0x{expected_end:X}")
        if vstart is not None and vstart!=expected_start:
            print(f"VALIDATOR_START_IDENTITY_MISMATCH=0x{vstart:X}")
        vstart=expected_start
        vend=expected_end
    elif vstart is not None:
        higher=[a for a,n in symbols if a>vstart]
        vend=min(higher) if higher else None
    if vstart is not None:
        print(f"VALIDATOR_START=0x{vstart:X}")
        print(f"VALIDATOR_END={('0x%X'%vend) if vend else 'UNKNOWN'}")

    rc_ot,ot=run(['/usr/bin/otool','-tvV',str(path)],timeout=240)
    print(f"OTOOL_RC={rc_ot}")
    dlines=ot.splitlines() if rc_ot==0 else []
    hits=[]
    for idx,ln in enumerate(dlines):
        low=ln.lower()
        if 'simulator' in low and ('were used' in low or 'supported' in low or 'supportted' in low):
            m=re.match(r'^\s*([0-9A-Fa-f]+)\s+',ln)
            addr=int(m.group(1),16) if m else None
            hits.append((idx,addr,ln))
    print(f"DISASM_SIMULATOR_XREF_HIT_COUNT={len(hits)}")
    for j,(idx,addr,ln) in enumerate(hits,1):
        own_addr,own_name=owner(symbols,addr) if addr is not None else (None,"UNKNOWN")
        in_validator=(vstart is not None and vend is not None and addr is not None and vstart<=addr<vend)
        rel=(addr-vstart) if in_validator else None
        post_candidate=(rel is not None and rel>0x58B)
        print(f"XREF_{j}=VM={('0x%X'%addr) if addr is not None else 'UNKNOWN'}|OWNER={own_name}|OWNER_VM={('0x%X'%own_addr) if own_addr is not None else 'UNKNOWN'}|IN_VALIDATOR={in_validator}|VALIDATOR_REL={('0x%X'%rel) if rel is not None else 'NA'}|POST_REL_0x58B={post_candidate}|INSN={ln.strip()}")
        lo=max(0,idx-4); hi=min(len(dlines),idx+6)
        for k in range(lo,hi):
            print(f"XREF_{j}_CTX={dlines[k].strip()}")
    if label=="32023":
        post=[h for h in hits if h[1] is not None and vstart is not None and vend is not None and vstart<=h[1]<vend and (h[1]-vstart)>0x58B]
        pre=[h for h in hits if h[1] is not None and vstart is not None and vend is not None and vstart<=h[1]<vend and (h[1]-vstart)<=0x58B]
        print(f"XREFS_IN_VALIDATOR_AFTER_REL_0x58B={len(post)}")
        print(f"XREFS_IN_VALIDATOR_AT_OR_BEFORE_REL_0x58B={len(pre)}")
PY
/bin/cat "$STATIC_REPORT"

echo "===== HISTORICAL UNIFIED-LOG LOAD/PATH PROVENANCE ====="
PROV_PRED='eventMessage CONTAINS[c] "MTLCompiler.framework" OR eventMessage CONTAINS[c] "GPUCompiler.framework" OR eventMessage CONTAINS[c] "Versions/32023" OR eventMessage CONTAINS[c] "Versions/3802" OR eventMessage CONTAINS[c] "/MTLCompiler"'
set +e
/usr/bin/log show --start "$START" --end "$END" --style compact --info --debug --predicate "$PROV_PRED" > "$PROV_LOG" 2>&1
PROV_RC=$?
set -e
echo "PROVENANCE_LOG_SHOW_RC=$PROV_RC"
[[ "$PROV_RC" -eq 0 ]] || fail "PROVENANCE_LOG_SHOW_FAILED:$PROV_RC"
echo "PROVENANCE_LOG_LINE_COUNT=$(/usr/bin/wc -l < "$PROV_LOG" | /usr/bin/tr -d ' ')"
"$PY" - "$PROV_LOG" <<'PY'
from pathlib import Path
import re,sys
lines=Path(sys.argv[1]).read_text(errors='replace').splitlines()
p32023=[x for x in lines if re.search(r'(Versions/32023|Versions\\/32023|32023/MTLCompiler|32023\\/MTLCompiler)',x,re.I)]
p3802=[x for x in lines if re.search(r'(Versions/3802|Versions\\/3802|3802/MTLCompiler|3802\\/MTLCompiler)',x,re.I)]
mtl=[x for x in lines if re.search(r'MTLCompiler',x,re.I)]
print(f'PROVENANCE_EXPLICIT_32023_LINE_COUNT={len(p32023)}')
print(f'PROVENANCE_EXPLICIT_3802_LINE_COUNT={len(p3802)}')
print(f'PROVENANCE_MTLCOMPILER_LINE_COUNT={len(mtl)}')
for x in p32023[:200]: print('PROVENANCE_32023='+x)
for x in p3802[:200]: print('PROVENANCE_3802='+x)
if not p32023 and not p3802:
    print('HISTORICAL_RUNTIME_LOAD_PATH_PROVENANCE=UNKNOWN_NO_EXPLICIT_VERSION_PATH_LOG')
elif p32023 and not p3802:
    print('HISTORICAL_RUNTIME_LOAD_PATH_PROVENANCE=32023_PATH_LOG_PRESENT_3802_ABSENT')
elif p3802 and not p32023:
    print('HISTORICAL_RUNTIME_LOAD_PATH_PROVENANCE=3802_PATH_LOG_PRESENT_32023_ABSENT')
else:
    print('HISTORICAL_RUNTIME_LOAD_PATH_PROVENANCE=BOTH_VERSION_PATHS_PRESENT_REQUIRES_CONTEXT')
PY

echo "===== UNIVERSAL PRE-EXIT DIAGNOSTIC CORRELATION ====="
RUNTIME_PRED='process == "MTLCompilerService" OR (process == "launchd" AND eventMessage CONTAINS[c] "MTLCompilerService")'
set +e
/usr/bin/log show --start "$START" --end "$END" --style compact --info --debug --predicate "$RUNTIME_PRED" > "$RUNTIME_LOG" 2>&1
RUNTIME_RC=$?
set -e
echo "RUNTIME_LOG_SHOW_RC=$RUNTIME_RC"
[[ "$RUNTIME_RC" -eq 0 ]] || fail "RUNTIME_LOG_SHOW_FAILED:$RUNTIME_RC"
"$PY" - "$RUNTIME_LOG" <<'PY'
from pathlib import Path
import collections,re,sys
lines=Path(sys.argv[1]).read_text(errors='replace').splitlines()
spawn=set()
exit1={}
diag=collections.defaultdict(list)
for ln in lines:
    m=re.search(r'Successfully spawned MTLCompilerService\[(\d+)\]',ln,re.I)
    if m: spawn.add(int(m.group(1)))
    m=re.search(r'MTLCompilerService\[(\d+)[^\]]*\].*exited due to exit\(1\)',ln,re.I)
    if m: exit1[int(m.group(1))]=ln
    m=re.search(r'MTLCompilerService\[(\d+):[^\]]+\].*\(MTLCompiler\).*(simulator|were used)',ln,re.I)
    if m: diag[int(m.group(1))].append(ln)
diag_pids=set(diag)
print(f'RUNTIME_SPAWN_PID_COUNT={len(spawn)}')
print(f'RUNTIME_EXIT1_PID_COUNT={len(exit1)}')
print(f'PREEXIT_SIMULATOR_DIAGNOSTIC_PID_COUNT={len(diag_pids)}')
print(f'PREEXIT_SIMULATOR_DIAGNOSTIC_ALL_SPAWNED={diag_pids==spawn}')
print(f'PREEXIT_SIMULATOR_DIAGNOSTIC_ALL_EXIT1={diag_pids==set(exit1)}')
size9=set(); size24=set()
for pid,arr in diag.items():
    if any('STRING sz:9' in x for x in arr): size9.add(pid)
    if any('STRING sz:24' in x for x in arr): size24.add(pid)
print(f'DIAGNOSTIC_STRING_SIZE9_PID_COUNT={len(size9)}|PIDS={sorted(size9)}')
print(f'DIAGNOSTIC_STRING_SIZE24_PID_COUNT={len(size24)}|PIDS={sorted(size24)}')
for pid in sorted(diag):
    print(f'DIAGNOSTIC_PID={pid}|LINE_COUNT={len(diag[pid])}')
    for x in diag[pid]: print(f'DIAGNOSTIC_LINE={x}')
if spawn and diag_pids==spawn and set(exit1)==spawn:
    print('UNIVERSAL_PRE_EXIT_DIAGNOSTIC_CORRELATION=RUNTIME_PROVEN_ALL_SPAWNED_PIDS')
else:
    print('UNIVERSAL_PRE_EXIT_DIAGNOSTIC_CORRELATION=INCOMPLETE')
PY

echo "===== FINAL ====="
echo "D97AER_READONLY_EXIT1_DIAGNOSTIC_AND_RUNTIME_PROVENANCE_MAP=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "NEXT=assistant_audit_static_message_xrefs_and_runtime_provenance_before_any_new_FASTLANE"
echo "REPORT=$REPORT"
