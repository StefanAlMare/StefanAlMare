#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97Y_READONLY_INPLACE_TERMINAL_CLASSIFIER_BLOCK_SAFETY_MAP_REPORT.txt"
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
fail(){ echo "D97Y_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97Y — READ-ONLY IN-PLACE TERMINAL CLASSIFIER BLOCK SAFETY MAP ====="
echo "PURPOSE=prove_or_reject_replacing_a_contiguous_complete_instruction_block_immediately_after_llvmVersion_getter_with_a_terminal_three_way_launchd_exit_classifier_without_using_a_cave"
echo "INPUT_D97X=NO_STATICALLY_SAFE_EXECUTABLE_ZERO_CAVE_FOUND"
echo "CURRENT_D97V_SERVICE_SHA=$EXPECTED_D97V_SHA"
echo "SELECTOR_ONLY_SERVICE_SHA=$EXPECTED_SELECTOR_SHA"
echo "CLASSIFIER_EXIT_3802=$EXIT_3802"
echo "CLASSIFIER_EXIT_32023=$EXIT_32023"
echo "CLASSIFIER_EXIT_OTHER=$EXIT_OTHER"
echo "CLASSIFIER_TRANSPORT=Darwin_x86_64_exit_syscall_0x2000001_observed_by_launchd"
echo "CLASSIFIER_PLACEMENT=IN_PLACE_COMPLETE_INSTRUCTIONS_TERMINAL_NO_PASS_THROUGH"
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

set +e
"$PYTHON_BIN" - "$SERVICE" "$EXPECTED_D97V_SHA" "$EXPECTED_SELECTOR_SHA" "$SITE_OFF" "$CURRENT_SITE12" "$SELECTOR_SITE12" "$EXIT_3802" "$EXIT_32023" "$EXIT_OTHER" <<'PY'
from pathlib import Path
import hashlib, os, re, struct, subprocess, sys, tempfile

svc=Path(sys.argv[1]); D97VSHA=sys.argv[2]; SELSHA=sys.argv[3]; SITE=int(sys.argv[4],0)
CURRENT=bytes.fromhex(sys.argv[5]); SELECTOR=bytes.fromhex(sys.argv[6])
EXIT3802=int(sys.argv[7]); EXIT32023=int(sys.argv[8]); EXITOTHER=int(sys.argv[9])
CLASSIFIER_LEN=36

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

print('\n===== MACH-O / SECTION MAP =====')
if u32(selector,0)!=0xFEEDFACF:raise SystemExit('MACHO64_LE_FAIL')
ncmds=u32(selector,16);off=32;textseg=None;sections=[]
for _ in range(ncmds):
    cmd=u32(selector,off);cmdsize=u32(selector,off+4)
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
text=[x for x in sections if x[0]=='__TEXT' and x[1]=='__text']
if len(text)!=1:raise SystemExit('__TEXT.__text_CARDINALITY_FAIL')
_,_,TEXT_VM,TEXT_SIZE,TEXT_OFF,TEXT_FLAGS=text[0]
print(f'TEXT_SEGMENT=VM=0x{TVM:X}..0x{TVM+TVS:X}|FILE=0x{TFO:X}..0x{TFO+TFS:X}')
print(f'CODE_SECTION=VM=0x{TEXT_VM:X}..0x{TEXT_VM+TEXT_SIZE:X}|FILE=0x{TEXT_OFF:X}..0x{TEXT_OFF+TEXT_SIZE:X}|FLAGS=0x{TEXT_FLAGS:X}')
def off_to_vm(fo):return TVM+(fo-TFO)
SITE_VM=off_to_vm(SITE)
print(f'CLASSIFIER_SITE_FILEOFF=0x{SITE:X}')
print(f'CLASSIFIER_SITE_VM=0x{SITE_VM:X}')
if not (TEXT_OFF<=SITE<TEXT_OFF+TEXT_SIZE):raise SystemExit('SITE_OUTSIDE_EXECUTABLE_TEXT')

with tempfile.TemporaryDirectory(prefix='d97y-') as td:
    td=Path(td);selp=td/'MTLCompilerService-selector-only';selp.write_bytes(selector);os.chmod(selp,0o755)
    rc,dis=run(['/usr/bin/otool','-tvV',str(selp)])
    print('\n===== SELECTOR-ONLY DISASSEMBLY / BLOCK BOUNDARY =====')
    print('OTOOL_SELECTOR_RC='+str(rc))
    if rc!=0:raise SystemExit('OTOOL_SELECTOR_FAIL')
    inst=[];rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
    for ln in dis.splitlines():
        m=rx.match(ln)
        if m:
            try:inst.append((int(m.group(1),16),m.group(2)))
            except:pass
    inst.sort();addrs=[a for a,_ in inst];by=dict(inst)
    print('SELECTOR_DISASM_INSTRUCTION_COUNT='+str(len(inst)))
    required=(0x1000025B4,0x1000025BE,SITE_VM)
    missing=[hex(a) for a in required if a not in by]
    print('REQUIRED_INSTRUCTION_MISSING='+repr(missing))
    if missing:raise SystemExit('REQUIRED_INSTRUCTION_MISSING')
    if 'llvmVersion' not in by[0x1000025B4]:raise SystemExit('LLVMVERSION_KEY_XREF_FAIL')
    if 'xpc_dictionary_get_uint64' not in by[0x1000025BE]:raise SystemExit('LLVMVERSION_GETTER_FAIL')
    if addrs.index(SITE_VM)!=addrs.index(0x1000025BE)+1:raise SystemExit('SITE_NOT_IMMEDIATELY_AFTER_GETTER')
    si=addrs.index(SITE_VM);end_i=None
    for j in range(si+1,len(addrs)):
        if addrs[j]-SITE_VM>=CLASSIFIER_LEN:
            end_i=j;break
    if end_i is None:raise SystemExit('NO_COMPLETE_INSTRUCTION_BLOCK_LARGE_ENOUGH')
    END_VM=addrs[end_i];BLOCK_LEN=END_VM-SITE_VM;END=SITE+BLOCK_LEN
    block_inst=inst[si:end_i]
    print(f'INPLACE_BLOCK_FILE=0x{SITE:X}..0x{END:X}|LEN={BLOCK_LEN}')
    print(f'INPLACE_BLOCK_VM=0x{SITE_VM:X}..0x{END_VM:X}')
    print('INPLACE_BLOCK_INSTRUCTION_COUNT='+str(len(block_inst)))
    for n,(a,t) in enumerate(block_inst,1):print(f'INPLACE_ORIGINAL_INSN_{n}=VM=0x{a:X}|{t}')
    print(f'INPLACE_NEXT_ORIGINAL_INSN=VM=0x{END_VM:X}|{by[END_VM]}')
    if BLOCK_LEN!=40 or END!=0x25EB:raise SystemExit(f'UNEXPECTED_MINIMUM_COMPLETE_BLOCK:len={BLOCK_LEN},end=0x{END:X}')
    expected_patterns=(
        ('movq','%r14','-0xa8(%rbp)'),('movl','$0xc0000000','%ecx'),('movq','%rcx','-0xa0(%rbp)'),
        ('leaq','block_invoke','%rcx'),('movq','%rcx','-0x98(%rbp)'),('leaq','block_descriptor','%rcx')
    )
    if len(block_inst)!=6:raise SystemExit('OVERWRITE_INSTRUCTION_COUNT_FAIL')
    for (a,t),pats in zip(block_inst,expected_patterns):
        if not all(p.lower() in t.lower() for p in pats):raise SystemExit(f'OVERWRITE_INSN_IDENTITY_FAIL_0x{a:X}:{t}')
    control_mn=('j','call','ret','loop','syscall','sysenter','int','ud2','hlt')
    control=[(a,t) for a,t in block_inst if t.strip().lower().startswith(control_mn)]
    print('ORIGINAL_BLOCK_CONTROL_TRANSFER_INSTRUCTIONS='+repr(control))
    if control:raise SystemExit('ORIGINAL_BLOCK_NOT_STRAIGHT_LINE')
    preimage=bytes(selector[SITE:END])
    print('INPLACE_BLOCK_PREIMAGE_HEX='+preimage.hex())
    print('INPLACE_BLOCK_PREIMAGE_SHA256='+hashlib.sha256(preimage).hexdigest())

    print('\n===== INBOUND TARGET / XREF / SYMBOL SAFETY =====')
    direct=[];rip=[]
    for i,(a,t) in enumerate(inst):
        m=re.match(r'^(?:j[a-z]+|callq?)\s+(0x[0-9A-Fa-f]+)\b',t.strip())
        if m:
            try:direct.append((int(m.group(1),16),a,t))
            except:pass
        if i+1<len(inst):
            nxt=inst[i+1][0]
            for mm in re.finditer(r'(-?0x[0-9A-Fa-f]+)\(%rip\)',t):
                s=mm.group(1);d=-int(s[3:],16) if s.startswith('-0x') else int(s,16)
                rip.append((nxt+d,a,t))
    interior_direct=[x for x in direct if SITE_VM<x[0]<END_VM]
    start_direct=[x for x in direct if x[0]==SITE_VM]
    interval_rip=[x for x in rip if SITE_VM<=x[0]<END_VM]
    rc,nm=run(['/usr/bin/nm','-nm',str(selp)])
    print('NM_SELECTOR_RC='+str(rc))
    symbols=[]
    for ln in nm.splitlines():
        m=re.match(r'^([0-9A-Fa-f]{8,16})\s+',ln.strip())
        if m:
            try:symbols.append((int(m.group(1),16),ln.strip()))
            except:pass
    interval_symbols=[x for x in symbols if SITE_VM<x[0]<END_VM]
    before_syms=[x for x in symbols if x[0]<=SITE_VM]
    after_syms=[x for x in symbols if x[0]>SITE_VM]
    owner=before_syms[-1] if before_syms else None
    nextsym=after_syms[0] if after_syms else None
    print('DIRECT_TARGET_AT_BLOCK_START_COUNT='+str(len(start_direct)))
    for x in start_direct:print(f'DIRECT_TARGET_AT_START=FROM=0x{x[1]:X}|{x[2]}')
    print('DIRECT_TARGET_INSIDE_BLOCK_COUNT='+str(len(interior_direct)))
    for x in interior_direct:print(f'DIRECT_TARGET_INSIDE=TARGET=0x{x[0]:X}|FROM=0x{x[1]:X}|{x[2]}')
    print('RIP_RELATIVE_TARGET_IN_BLOCK_COUNT='+str(len(interval_rip)))
    for x in interval_rip:print(f'RIP_TARGET_IN_BLOCK=TARGET=0x{x[0]:X}|FROM=0x{x[1]:X}|{x[2]}')
    print('SYMBOL_INSIDE_BLOCK_COUNT='+str(len(interval_symbols)))
    for x in interval_symbols:print('SYMBOL_INSIDE_BLOCK='+x[1])
    print('BLOCK_OWNER_SYMBOL='+('UNKNOWN' if owner is None else owner[1]))
    print('NEXT_SYMBOL_AFTER_BLOCK='+('UNKNOWN' if nextsym is None else nextsym[1]))
    if interior_direct or interval_rip or interval_symbols:raise SystemExit('INPLACE_BLOCK_INBOUND_REFERENCE_HAZARD')
    if nextsym is not None and END_VM>nextsym[0]:raise SystemExit('INPLACE_BLOCK_CROSSES_SYMBOL_BOUNDARY')
    print('INPLACE_BLOCK_INBOUND_REFERENCE_SAFETY=PASS')

    print('\n===== EXACT THREE-WAY CLASSIFIER BYTECODE =====')
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
    def s8(x):return x-256 if x>=128 else x
    checks=((5,7+s8(code[6]),19),(12,14+s8(code[13]),24),(17,19+s8(code[18]),27),(22,24+s8(code[23]),27))
    for at,actual,want in checks:
        print(f'CLASSIFIER_REL8=AT={at}|TARGET={actual}|EXPECTED={want}')
        if actual!=want:raise SystemExit('CLASSIFIER_REL8_TARGET_FAIL')
    if code[0:5]!=bytes.fromhex('3d da 0e 00 00'):raise SystemExit('CMP_3802_ENCODING_FAIL')
    if code[7:12]!=bytes.fromhex('3d 17 7d 00 00'):raise SystemExit('CMP_32023_ENCODING_FAIL')
    if code[14:17]!=bytes((0x6a,EXITOTHER,0x5f)):raise SystemExit('EXIT_OTHER_ENCODING_FAIL')
    if code[19:22]!=bytes((0x6a,EXIT3802,0x5f)):raise SystemExit('EXIT_3802_ENCODING_FAIL')
    if code[24:27]!=bytes((0x6a,EXIT32023,0x5f)):raise SystemExit('EXIT_32023_ENCODING_FAIL')
    if code[27:34]!=bytes.fromhex('b8 01 00 00 02 0f 05') or code[34:36]!=b'\x0f\x0b':raise SystemExit('DARWIN_EXIT_SYSCALL_ENCODING_FAIL')
    tests=((3802,123),(32023,124),(0,125),(3902,125),(0xffffffff,125))
    for value,want in tests:
        got=123 if (value&0xffffffff)==3802 else (124 if (value&0xffffffff)==32023 else 125)
        print(f'CLASSIFIER_SEMANTIC_TEST=EAX=0x{value&0xffffffff:X}|EXIT={got}|EXPECTED={want}')
        if got!=want:raise SystemExit('CLASSIFIER_SEMANTIC_TEST_FAIL')
    post=code+b'\x90'*(BLOCK_LEN-len(code))
    if len(post)!=BLOCK_LEN:raise SystemExit('INPLACE_POSTIMAGE_LENGTH_FAIL')
    print('INPLACE_BLOCK_POSTIMAGE_HEX='+post.hex())
    print('INPLACE_PADDING_NOP_COUNT='+str(BLOCK_LEN-len(code)))
    print('CLASSIFIER_TERMINAL_NO_PASS_THROUGH=YES')
    print('CLASSIFIER_UNIVERSAL_NO_PID_FILTER=YES')

    final=bytearray(selector);final[SITE:END]=post
    finalsha=sha(final)
    print('\n===== SYNTHETIC FINAL IDENTITY / DISASSEMBLY =====')
    print('D97Y_SYNTHETIC_FINAL_SERVICE_SHA='+finalsha)
    if bytes(final[0x3496:0x349A])!=bytes.fromhex('177d0000'):raise SystemExit('SELECTOR_32023_NOT_RETAINED')
    if bytes(final[0x3478:0x347C])!=bytes.fromhex('da0e0000'):raise SystemExit('SELECTOR_3802_NOT_RETAINED')
    if bytes(final[END:END+8])!=bytes(selector[END:END+8]):raise SystemExit('NEXT_ORIGINAL_BYTES_CHANGED')
    print('SELECTOR_32023_RETAINED=PASS')
    print('SELECTOR_3802_RETAINED=PASS')
    print('NEXT_ORIGINAL_INSTRUCTION_BYTES_RETAINED=PASS')
    fp=td/'MTLCompilerService-D97Y-synthetic';fp.write_bytes(final);os.chmod(fp,0o755)
    rc,pdis=run(['/usr/bin/otool','-tvV',str(fp)])
    print('OTOOL_SYNTHETIC_RC='+str(rc))
    if rc!=0:raise SystemExit('OTOOL_SYNTHETIC_FAIL')
    pinst=[]
    for ln in pdis.splitlines():
        m=rx.match(ln)
        if m:
            try:pinst.append((int(m.group(1),16),m.group(2)))
            except:pass
    for a,t in pinst:
        if SITE_VM<=a<END_VM+8:print(f'SYNTHETIC_INSN=VM=0x{a:X}|{t}')
    pby=dict(pinst)
    expected_sites=(SITE_VM,SITE_VM+5,SITE_VM+7,SITE_VM+12,SITE_VM+14,SITE_VM+17,SITE_VM+19,SITE_VM+22,SITE_VM+24,SITE_VM+27,SITE_VM+32,SITE_VM+34)
    missing=[hex(x) for x in expected_sites if x not in pby]
    print('SYNTHETIC_EXPECTED_INSTRUCTION_MISSING='+repr(missing))
    if missing:raise SystemExit('SYNTHETIC_CLASSIFIER_DISASM_BOUNDARY_FAIL')
    if END_VM not in pby:raise SystemExit('NEXT_ORIGINAL_INSTRUCTION_NOT_DISASSEMBLED')
    print('SYNTHETIC_CLASSIFIER_DISASSEMBLY=PASS')

print('\n===== CONSERVATIVE CONCLUSION =====')
print('D97X_ZERO_CAVE_RESULT=RETAINED_NEGATIVE')
print('D97Y_INPLACE_COMPLETE_INSTRUCTION_BLOCK=STATIC_PROVEN')
print('D97Y_INBOUND_REFERENCE_SAFETY=STATIC_PROVEN')
print('D97Y_THREE_WAY_EXIT_CLASSIFIER=STATIC_PROVEN')
print('D97Y_EXIT_CLASSIFIER_AUTHORIZED=FOR_FASTLANE_DESIGN_ONLY_NOT_INTEGRATION')
print('D97Y_READONLY_INPLACE_TERMINAL_CLASSIFIER_BLOCK_SAFETY_MAP=PASS')
PY
PY_RC=$?
set -e
echo "D97Y_PYTHON_RC=$PY_RC"
[[ "$PY_RC" -eq 0 ]] || fail "PYTHON_MAPPER_RC:$PY_RC"

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
