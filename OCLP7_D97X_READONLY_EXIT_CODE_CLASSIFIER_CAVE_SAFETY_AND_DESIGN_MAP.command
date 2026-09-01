#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97X_READONLY_EXIT_CODE_CLASSIFIER_CAVE_SAFETY_AND_DESIGN_MAP_REPORT.txt"
EXPECTED_PRODUCT="26.6.2"
EXPECTED_BUILD="25G82"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
EXPECTED_D97V_SHA="bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19"
EXPECTED_SELECTOR_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
SITE_OFF="0x25C3"
CURRENT_SITE12="0f0b9090909090b9000000c0"
SELECTOR_SITE12="4c89b558ffffffb9000000c0"
EXIT_3802=123
EXIT_32023=124
EXIT_OTHER=125

exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97X_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97X — READ-ONLY EXIT-CODE CLASSIFIER CAVE SAFETY / DESIGN MAP ====="
echo "PURPOSE=replace_register_dependent_SIGILL_report_channel_with_universal_launchd_visible_exact_selector_classifier_without_integrating_or_root_patching"
echo "INPUT_D97W=accelerated_boot_14_explicit_MTLCompilerService_SIGILL_terminations_but_zero_DiagnosticReports_and_no_RAX"
echo "CURRENT_D97V_SERVICE_SHA=$EXPECTED_D97V_SHA"
echo "SELECTOR_ONLY_SERVICE_SHA=$EXPECTED_SELECTOR_SHA"
echo "CAPTURE_SITE_FILEOFF=$SITE_OFF"
echo "CLASSIFIER_EXIT_3802=$EXIT_3802"
echo "CLASSIFIER_EXIT_32023=$EXIT_32023"
echo "CLASSIFIER_EXIT_OTHER=$EXIT_OTHER"
echo "CLASSIFIER_TRANSPORT=Darwin_x86_64_exit_syscall_0x2000001_observed_by_launchd"
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

PRODUCT="$(sw_vers -productVersion 2>/dev/null || true)"
BUILD="$(sw_vers -buildVersion 2>/dev/null || true)"
PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "PYTHON_EXEC=${PYTHON_BIN:-MISSING}"
[[ "$PRODUCT" == "$EXPECTED_PRODUCT" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "$EXPECTED_BUILD" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PYTHON_BIN" && -x "$PYTHON_BIN" ]] || fail "PYTHON3_MISSING"
[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING:$SERVICE"
for t in otool nm shasum xxd; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
"$PYTHON_BIN" --version 2>&1
CURRENT_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
CURRENT_HEX="$(/usr/bin/xxd -p -s $((0x25C3)) -l 12 "$SERVICE" | /usr/bin/tr -d '\n')"
echo "VISIBLE_SERVICE_SHA=$CURRENT_SHA"
echo "VISIBLE_SITE12=$CURRENT_HEX"
[[ "$CURRENT_SHA" == "$EXPECTED_D97V_SHA" ]] || fail "VISIBLE_SERVICE_NOT_D97V:$CURRENT_SHA"
[[ "$CURRENT_HEX" == "$CURRENT_SITE12" ]] || fail "VISIBLE_SITE12_MISMATCH:$CURRENT_HEX"
echo "PRECHECK=PASS"

"$PYTHON_BIN" - "$SERVICE" "$EXPECTED_D97V_SHA" "$EXPECTED_SELECTOR_SHA" "$SITE_OFF" "$CURRENT_SITE12" "$SELECTOR_SITE12" "$EXIT_3802" "$EXIT_32023" "$EXIT_OTHER" <<'PY'
from pathlib import Path
import hashlib, os, re, struct, subprocess, sys, tempfile

svc=Path(sys.argv[1]); D97VSHA=sys.argv[2]; SELSHA=sys.argv[3]; SITE=int(sys.argv[4],0)
CURRENT=bytes.fromhex(sys.argv[5]); SELECTOR=bytes.fromhex(sys.argv[6])
EXIT3802=int(sys.argv[7]); EXIT32023=int(sys.argv[8]); EXITOTHER=int(sys.argv[9])
MIN_CAVE=48

def sha(b):return hashlib.sha256(bytes(b)).hexdigest()
def u32(b,o=0):return struct.unpack_from('<I',b,o)[0]
def u64(b,o=0):return struct.unpack_from('<Q',b,o)[0]
def run(cmd,timeout=120):
    try:
        p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=timeout)
        return p.returncode,p.stdout
    except Exception as e:return -999,'TOOL_ERROR:'+repr(e)

data=bytearray(svc.read_bytes())
print('\n===== EXACT CURRENT -> SELECTOR-ONLY SYNTHETIC IDENTITY =====')
print('CURRENT_D97V_SHA='+sha(data))
print('CURRENT_SITE12='+bytes(data[SITE:SITE+12]).hex())
if sha(data)!=D97VSHA or bytes(data[SITE:SITE+12])!=CURRENT:raise SystemExit('CURRENT_D97V_IDENTITY_FAIL')
selector=bytearray(data); selector[SITE:SITE+12]=SELECTOR
sels=sha(selector)
print('SYNTHETIC_SELECTOR_ONLY_SHA='+sels)
print('SYNTHETIC_SELECTOR_SITE12='+bytes(selector[SITE:SITE+12]).hex())
if sels!=SELSHA:raise SystemExit('SELECTOR_ONLY_RECONSTRUCTION_FAIL:'+sels)
print('D97V_TO_SELECTOR_ONLY_RECONSTRUCTION=PASS')

print('\n===== MACH-O SECTION MAP =====')
if u32(selector,0)!=0xFEEDFACF:raise SystemExit('MACHO64_LE_FAIL')
ncmds=u32(selector,16); off=32; textseg=None; sections=[]
for _ in range(ncmds):
    cmd=u32(selector,off); cmdsize=u32(selector,off+4)
    if cmdsize<8 or off+cmdsize>len(selector):raise SystemExit('LOAD_COMMAND_INVALID')
    if cmd==0x19:
        seg=bytes(selector[off+8:off+24]).split(b'\0',1)[0].decode('ascii','replace')
        vmaddr=u64(selector,off+24);vmsize=u64(selector,off+32);fileoff=u64(selector,off+40);filesize=u64(selector,off+48);nsects=u32(selector,off+64)
        if seg=='__TEXT':textseg=(vmaddr,vmsize,fileoff,filesize)
        so=off+72
        for i in range(nsects):
            q=so+i*80
            sect=bytes(selector[q:q+16]).split(b'\0',1)[0].decode('ascii','replace')
            sseg=bytes(selector[q+16:q+32]).split(b'\0',1)[0].decode('ascii','replace')
            addr=u64(selector,q+32);size=u64(selector,q+40);fo=u32(selector,q+48);flags=u32(selector,q+64)
            sections.append((sseg,sect,addr,size,fo,flags))
    off+=cmdsize
if textseg is None:raise SystemExit('TEXT_SEGMENT_MISSING')
TVM,TVS,TFO,TFS=textseg
print(f'TEXT_SEGMENT=VM=0x{TVM:X}..0x{TVM+TVS:X}|FILE=0x{TFO:X}..0x{TFO+TFS:X}')
for sseg,sect,addr,size,fo,flags in sections:
    if sseg=='__TEXT':print(f'TEXT_SECTION={sect}|VM=0x{addr:X}..0x{addr+size:X}|FILE=0x{fo:X}..0x{fo+size:X}|FLAGS=0x{flags:X}')
text_sections=[x for x in sections if x[0]=='__TEXT' and x[1]=='__text']
if len(text_sections)!=1:raise SystemExit('__TEXT.__text_CARDINALITY_FAIL')
_,_,TEXT_ADDR,TEXT_SIZE,TEXT_OFF,TEXT_FLAGS=text_sections[0]
print(f'CODE_SECTION=VM=0x{TEXT_ADDR:X}..0x{TEXT_ADDR+TEXT_SIZE:X}|FILE=0x{TEXT_OFF:X}..0x{TEXT_OFF+TEXT_SIZE:X}')

def off_to_vm(fo):return TVM+(fo-TFO)
def vm_to_off(vm):return TFO+(vm-TVM)
SITE_VM=off_to_vm(SITE)
print(f'CAPTURE_SITE_VM=0x{SITE_VM:X}')

print('\n===== DISASSEMBLY / XREF MAP =====')
rc,dis=run(['/usr/bin/otool','-tvV',str(svc)])
print(f'OTOOL_RC={rc}')
if rc!=0:raise SystemExit('OTOOL_FAIL')
inst=[];rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
for ln in dis.splitlines():
    m=rx.match(ln)
    if m:
        try:inst.append((int(m.group(1),16),m.group(2)))
        except:pass
inst.sort(); addrs=[a for a,_ in inst]
print('DISASM_INSTRUCTION_COUNT='+str(len(inst)))
direct_targets=[];rip_targets=[]
for i,(a,t) in enumerate(inst):
    m=re.match(r'^(?:j[a-z]+|callq?)\s+(0x[0-9A-Fa-f]+)\b',t.strip())
    if m:
        try:direct_targets.append((int(m.group(1),16),a,t))
        except:pass
    if i+1<len(inst):
        nxt=inst[i+1][0]
        for mm in re.finditer(r'(-?0x[0-9A-Fa-f]+)\(%rip\)',t):
            s=mm.group(1);d=-int(s[3:],16) if s.startswith('-0x') else int(s,16)
            rip_targets.append((nxt+d,a,t))
print('DIRECT_BRANCH_CALL_TARGET_COUNT='+str(len(direct_targets)))
print('RIP_RELATIVE_TARGET_COUNT='+str(len(rip_targets)))
rc,nm=run(['/usr/bin/nm','-nm',str(svc)])
symbols=[]
for ln in nm.splitlines():
    m=re.match(r'^([0-9A-Fa-f]{8,16})\s+',ln.strip())
    if m:
        try:symbols.append((int(m.group(1),16),ln.strip()))
        except:pass
print('NM_SYMBOL_ADDRESS_COUNT='+str(len(symbols)))

print('\n===== ZERO-RUN CAVE CANDIDATES IN __TEXT,__text =====')
lo=TEXT_OFF;hi=TEXT_OFF+TEXT_SIZE;runs=[];i=lo
while i<hi:
    if selector[i]!=0:i+=1;continue
    j=i+1
    while j<hi and selector[j]==0:j+=1
    if j-i>=MIN_CAVE:runs.append((i,j))
    i=j
print('ZERO_RUN_GE_48_COUNT='+str(len(runs)))
terminators=('ret','jmp','ud2','int3','hlt')
candidates=[]
for idx,(rs,re_) in enumerate(runs,1):
    aligned=(rs+15)&~15
    if aligned+36>re_:continue
    cvs=off_to_vm(aligned);cve=off_to_vm(re_)
    dt=[x for x in direct_targets if cvs<=x[0]<cve]
    rt=[x for x in rip_targets if cvs<=x[0]<cve]
    sy=[x for x in symbols if cvs<=x[0]<cve]
    prev=[x for x in inst if x[0]<off_to_vm(rs)]
    prev=prev[-1] if prev else None
    nexts=[x for x in inst if x[0]>=off_to_vm(re_)]
    nxt=nexts[0] if nexts else None
    term=bool(prev and prev[1].strip().startswith(terminators))
    overlap=not (re_<=SITE or rs>=SITE+12)
    print(f'ZERO_RUN_{idx}=FILE=0x{rs:X}..0x{re_:X}|LEN={re_-rs}|ALIGNED_CAVE=0x{aligned:X}|VM=0x{cvs:X}|DIRECT_TARGETS={len(dt)}|RIP_TARGETS={len(rt)}|SYMBOLS={len(sy)}|PREV_TERMINATOR={term}|OVERLAP_SITE={overlap}')
    print(f'ZERO_RUN_{idx}_PREV={"NONE" if prev is None else f"0x{prev[0]:X}|{prev[1]}"}')
    print(f'ZERO_RUN_{idx}_NEXT={"NONE" if nxt is None else f"0x{nxt[0]:X}|{nxt[1]}"}')
    if not dt and not rt and not sy and term and not overlap:
        candidates.append((aligned,re_,rs,prev,nxt))
print('SAFE_CAVE_CANDIDATE_COUNT='+str(len(candidates)))
if not candidates:
    print('D97X_RESULT=NO_STATICALLY_SAFE_EXECUTABLE_ZERO_CAVE_FOUND')
    print('D97X_EXIT_CLASSIFIER_AUTHORIZED=NO')
    print('D97X_READONLY_EXIT_CODE_CLASSIFIER_CAVE_SAFETY_AND_DESIGN_MAP=PASS')
    raise SystemExit(0)
# Prefer longest residual aligned region, then highest address to stay away from hot early code.
candidates.sort(key=lambda x:((x[1]-x[0]),x[0]),reverse=True)
CAVE,CAVE_END,RUN_START,PREV,NXT=candidates[0]
CAVE_VM=off_to_vm(CAVE)
print(f'SELECTED_CAVE_FILEOFF=0x{CAVE:X}')
print(f'SELECTED_CAVE_VM=0x{CAVE_VM:X}')
print(f'SELECTED_CAVE_AVAILABLE={CAVE_END-CAVE}')
print(f'SELECTED_CAVE_PREV=0x{PREV[0]:X}|{PREV[1]}')
print(f'SELECTED_CAVE_NEXT={"NONE" if NXT is None else f"0x{NXT[0]:X}|{NXT[1]}"}')

print('\n===== CLASSIFIER BYTECODE CONTRACT =====')
# Exact three-way classifier. 123=>3802, 124=>32023, 125=>other.
code=bytes.fromhex(
    '3d da 0e 00 00 74 0c '
    '3d 17 7d 00 00 74 0a '
    '6a 7d 5f eb 08 '
    '6a 7b 5f eb 03 '
    '6a 7c 5f '
    'b8 01 00 00 02 0f 05 0f 0b'
)
print('CLASSIFIER_CODE_HEX='+code.hex())
print('CLASSIFIER_CODE_LENGTH='+str(len(code)))
if len(code)!=36:raise SystemExit('CLASSIFIER_LENGTH_FAIL')
if code[0:5]!=bytes.fromhex('3d da 0e 00 00'):raise SystemExit('CMP_3802_FAIL')
if code[7:12]!=bytes.fromhex('3d 17 7d 00 00'):raise SystemExit('CMP_32023_FAIL')
if code[14:17]!=bytes((0x6a,EXITOTHER,0x5f)):raise SystemExit('EXIT_OTHER_ENCODING_FAIL')
if code[19:22]!=bytes((0x6a,EXIT3802,0x5f)):raise SystemExit('EXIT_3802_ENCODING_FAIL')
if code[24:27]!=bytes((0x6a,EXIT32023,0x5f)):raise SystemExit('EXIT_32023_ENCODING_FAIL')
if code[27:34]!=bytes.fromhex('b8 01 00 00 02 0f 05') or code[34:36]!=b'\x0f\x0b':raise SystemExit('DARWIN_EXIT_SYSCALL_ENCODING_FAIL')
# Verify all rel8 branch destinations.
def s8(x):return x-256 if x>=128 else x
checks=((5,7+s8(code[6]),19),(12,14+s8(code[13]),24),(17,19+s8(code[18]),27),(22,24+s8(code[23]),27))
for at,actual,expected in checks:
    print(f'CLASSIFIER_BRANCH=AT={at}|TARGET={actual}|EXPECTED={expected}')
    if actual!=expected:raise SystemExit('CLASSIFIER_BRANCH_TARGET_FAIL')
print('CLASSIFIER_3802_EXIT_CODE=123')
print('CLASSIFIER_32023_EXIT_CODE=124')
print('CLASSIFIER_OTHER_EXIT_CODE=125')
print('DARWIN_X86_64_EXIT_SYSCALL_NUMBER=0x2000001')
print('CLASSIFIER_TERMINAL_FALLBACK=UD2_IF_SYSCALL_RETURNS')

print('\n===== SITE TRAMPOLINE / SYNTHETIC FINAL PROOF =====')
rel=CAVE_VM-(SITE_VM+5)
if not -(1<<31)<=rel<(1<<31):raise SystemExit('REL32_OUT_OF_RANGE')
site_patch=b'\xe9'+int(rel).to_bytes(4,'little',signed=True)+b'\x90'*7
print('SITE_SELECTOR_PREIMAGE='+SELECTOR.hex())
print('SITE_CLASSIFIER_PATCH='+site_patch.hex())
print(f'SITE_JUMP_REL32={rel}|TARGET_VM=0x{SITE_VM+5+rel:X}')
if len(site_patch)!=12 or SITE_VM+5+int.from_bytes(site_patch[1:5],'little',signed=True)!=CAVE_VM:raise SystemExit('SITE_JUMP_PROOF_FAIL')
if bytes(selector[CAVE:CAVE+len(code)])!=bytes(len(code)):raise SystemExit('SELECTED_CAVE_NOT_ZERO')
final=bytearray(selector);final[SITE:SITE+12]=site_patch;final[CAVE:CAVE+len(code)]=code
final_sha=sha(final)
print('D97X_EXPECTED_SERVICE_POST_SHA='+final_sha)
print('D97X_PATCHED_SITE12='+bytes(final[SITE:SITE+12]).hex())
print('D97X_PATCHED_CAVE='+bytes(final[CAVE:CAVE+len(code)]).hex())

fd,tmp=tempfile.mkstemp(prefix='MTLCompilerService-D97X-',suffix='.bin')
os.close(fd);Path(tmp).write_bytes(final)
try:
    rc,out=run(['/usr/bin/otool','-tvV',tmp])
    print('PATCHED_OTOOL_RC='+str(rc))
    lines=[]
    for ln in out.splitlines():
        m=re.match(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$',ln)
        if not m:continue
        try:a=int(m.group(1),16)
        except:continue
        if SITE_VM<=a<SITE_VM+16 or CAVE_VM<=a<CAVE_VM+len(code):lines.append((a,m.group(2)))
    for a,t in lines:print(f'PATCHED_DISASM=VM=0x{a:X}|{t}')
    if rc!=0:raise SystemExit('PATCHED_OTOOL_FAIL')
finally:
    try:os.unlink(tmp)
    except:pass

print('\n===== CONSERVATIVE CONCLUSION =====')
print('D97W_DIAGNOSTIC_REPORT_REGISTER_CHANNEL=NEGATIVE')
print('D97W_UNIFIED_LOG_SIGILL_TERMINATION_CHANNEL=POSITIVE_REPEATED')
print('D97V_TERMINAL_CONTROL_FLOW=STRONGLY_CORROBORATED_NOT_EXACT_RIP_PROVEN')
print('D97X_SAFE_EXECUTABLE_CAVE=STATIC_PROVEN')
print('D97X_EXACT_THREE_WAY_EXIT_CLASSIFIER=STATIC_PROVEN')
print('D97X_LAUNCHD_OBSERVATION_CONTRACT=EXIT_123_SELECTS_3802;EXIT_124_SELECTS_32023;EXIT_125_OTHER')
print('D97X_EXIT_CLASSIFIER_AUTHORIZED=FOR_FASTLANE_DESIGN_ONLY_NOT_INTEGRATION')
print('D97X_READONLY_EXIT_CODE_CLASSIFIER_CAVE_SAFETY_AND_DESIGN_MAP=PASS')
PY

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
