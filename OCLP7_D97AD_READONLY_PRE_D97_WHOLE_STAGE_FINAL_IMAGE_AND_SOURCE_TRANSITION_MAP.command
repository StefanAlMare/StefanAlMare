#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AD_READONLY_PRE_D97_WHOLE_STAGE_FINAL_IMAGE_AND_SOURCE_TRANSITION_MAP_REPORT.txt"
PRODUCT_EXPECTED="26.6.2"
BUILD_EXPECTED="25G82"
EXPECTED_BRANCH="alex-tahoe-25G82-custom"
EXPECTED_HEAD="4143b7077a9a4e5aa41ec7a06c0888597eda9b06"
LIVE_APP="/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
LIVE_APP_SHA_EXPECTED="0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
SERVICE_D97Z_SHA="2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c"
SERVICE_SELECTOR_ONLY_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
SERVICE_BLOCK_OFF=$((0x25C3))
SERVICE_D97Z_BLOCK="3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b90909090"
SERVICE_SELECTOR_BLOCK="4c89b558ffffffb9000000c048898d60ffffff488d0df10d000048898d68ffffff488d0d951b0000"
MTL="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
D97_SHA="c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118"
P7_SHA="6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda"
D97_SITE=$((0x9D6BD))
D97_SITE_PATCH="e9be38f6ff90"
D97_SITE_PRE="8b8d10feffff"
D97_CAVE=$((0xF80))
D97_CAVE_LEN=33
D97_CAVE_PATCH="488b8500feffff488b9d08feffff488b8d10feffff49bb443937434e5452210f0b"
EXIT_CANDIDATE=110
EXIT_BUFFER_INDEX=111
EXIT_SAMPLER_INDEX=112
EXIT_NESTED_ARG_BUFFER=113
EXIT_OTHER_EARLY=114

exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AD_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AD — READ-ONLY PRE-D97 WHOLE-STAGE FINAL-IMAGE + SOURCE-TRANSITION MAP ====="
echo "PURPOSE=derive_exact_identity_pinned_D97AD_MTLCompiler_postimage_and_prove_simultaneous_D97Z_service_removal_plus_D97_replacement_source_transition_before_FASTLANE"
echo "INPUT_D97AC=finite_path_partition_STATIC_PROVEN;all_six_windows_SAFE;shared_exit_stub_cave_SAFE;runtime_liveness_gate_required"
echo "SERVICE_TRANSITION=D97Z_terminal_service_classifier_removed_to_restore_selector_only_service"
echo "MTL_TRANSITION=D97_six_counter_snapshot_replaced_not_stacked_by_pre_D97_whole_stage_exit_classifier"
echo "OUTCOMES=110_candidate_REL_0x58B;111_buffer_index_REL_0x29A;112_sampler_index_REL_0x2D9;113_nested_arg_buffer_REL_0x3E2;114_other_early_REL_0xB9_or_0x6CC"
echo "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114_or_runtime_result_invalid"
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
PY="$(command -v python3 2>/dev/null || true)"
ROOT=""
for CAND in \
  "/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82" \
  "$HOME/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"; do
  if [[ -d "$CAND/.git" ]]; then ROOT="$CAND"; break; fi
done

echo "PRODUCT_VERSION=$PRODUCT"
echo "BUILD_VERSION=$BUILD"
echo "PYTHON_EXEC=${PY:-MISSING}"
echo "PROJECT_ROOT=${ROOT:-MISSING}"
[[ "$PRODUCT" == "$PRODUCT_EXPECTED" ]] || fail "UNEXPECTED_PRODUCT:$PRODUCT"
[[ "$BUILD" == "$BUILD_EXPECTED" ]] || fail "UNEXPECTED_BUILD:$BUILD"
[[ -n "$PY" && -x "$PY" ]] || fail "PYTHON3_MISSING"
[[ -n "$ROOT" ]] || fail "PROJECT_ROOT_NOT_FOUND"
[[ -f "$LIVE_APP" ]] || fail "LIVE_APP_MISSING:$LIVE_APP"
[[ -f "$SERVICE" ]] || fail "SERVICE_MISSING:$SERVICE"
[[ -f "$MTL" ]] || fail "MTL_MISSING:$MTL"
for t in otool nm shasum git xxd; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
"$PY" --version 2>&1

LIVE_APP_SHA="$(/usr/bin/shasum -a 256 "$LIVE_APP" | /usr/bin/awk '{print $1}')"
SERVICE_SHA="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
MTL_SHA="$(/usr/bin/shasum -a 256 "$MTL" | /usr/bin/awk '{print $1}')"
SERVICE_BLOCK="$(/usr/bin/xxd -p -s "$SERVICE_BLOCK_OFF" -l 40 "$SERVICE" | /usr/bin/tr -d '\n')"
echo "LIVE_APP_SHA=$LIVE_APP_SHA"
echo "VISIBLE_SERVICE_SHA=$SERVICE_SHA"
echo "VISIBLE_SERVICE_D97Z_BLOCK=$SERVICE_BLOCK"
echo "VISIBLE_MTL_SHA=$MTL_SHA"
[[ "$LIVE_APP_SHA" == "$LIVE_APP_SHA_EXPECTED" ]] || fail "LIVE_APP_NOT_D97Z:$LIVE_APP_SHA"
[[ "$SERVICE_SHA" == "$SERVICE_D97Z_SHA" ]] || fail "VISIBLE_SERVICE_NOT_D97Z:$SERVICE_SHA"
[[ "$SERVICE_BLOCK" == "$SERVICE_D97Z_BLOCK" ]] || fail "VISIBLE_SERVICE_D97Z_BLOCK_MISMATCH:$SERVICE_BLOCK"
[[ "$MTL_SHA" == "$D97_SHA" ]] || fail "VISIBLE_MTL_NOT_D97:$MTL_SHA"

cd "$ROOT"
BRANCH="$(/usr/bin/git branch --show-current)"
HEAD="$(/usr/bin/git rev-parse HEAD)"
echo "PROJECT_BRANCH=$BRANCH"
echo "PROJECT_HEAD=$HEAD"
[[ "$BRANCH" == "$EXPECTED_BRANCH" ]] || fail "PROJECT_BRANCH_MISMATCH:$BRANCH"
[[ "$HEAD" == "$EXPECTED_HEAD" ]] || fail "PROJECT_HEAD_MISMATCH:$HEAD"
echo "PRECHECK=PASS"

"$PY" - "$SERVICE" "$MTL" "$ROOT" "$SERVICE_D97Z_SHA" "$SERVICE_SELECTOR_ONLY_SHA" "$SERVICE_BLOCK_OFF" "$SERVICE_D97Z_BLOCK" "$SERVICE_SELECTOR_BLOCK" "$D97_SHA" "$P7_SHA" "$D97_SITE" "$D97_SITE_PATCH" "$D97_SITE_PRE" "$D97_CAVE" "$D97_CAVE_LEN" "$D97_CAVE_PATCH" "$EXIT_CANDIDATE" "$EXIT_BUFFER_INDEX" "$EXIT_SAMPLER_INDEX" "$EXIT_NESTED_ARG_BUFFER" "$EXIT_OTHER_EARLY" <<'PY'
from pathlib import Path
import ast, hashlib, os, re, struct, subprocess, sys, tempfile

(service_s,mtl_s,root_s,service_d97z_sha,service_selector_sha,service_block_off_s,
 service_d97z_hex,service_selector_hex,d97_sha,p7_sha,d97_site_s,d97_site_patch_hex,
 d97_site_pre_hex,d97_cave_s,d97_cave_len_s,d97_cave_patch_hex,
 ec_s,e1_s,e2_s,e3_s,eo_s)=sys.argv[1:]
service=Path(service_s); mtl=Path(mtl_s); root=Path(root_s)
service_block_off=int(service_block_off_s,0)
d97_site=int(d97_site_s,0); d97_cave=int(d97_cave_s,0); d97_cave_len=int(d97_cave_len_s,0)
codes=[int(ec_s),int(e1_s),int(e2_s),int(e3_s),int(eo_s)]
service_d97z=bytes.fromhex(service_d97z_hex); service_selector=bytes.fromhex(service_selector_hex)
d97_site_patch=bytes.fromhex(d97_site_patch_hex); d97_site_pre=bytes.fromhex(d97_site_pre_hex)
d97_cave_patch=bytes.fromhex(d97_cave_patch_hex)

def sha(b): return hashlib.sha256(bytes(b)).hexdigest()
def run(cmd,timeout=180):
    try:
        p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=timeout)
        return p.returncode,p.stdout
    except Exception as e:
        return -999,'TOOL_ERROR:'+repr(e)
def u32(b,o=0): return struct.unpack_from('<I',b,o)[0]
def u64(b,o=0): return struct.unpack_from('<Q',b,o)[0]

print('\n===== EXACT D97Z SERVICE -> SELECTOR-ONLY SYNTHETIC TRANSITION =====')
sdata=bytearray(service.read_bytes())
print('CURRENT_D97Z_SERVICE_SHA='+sha(sdata))
print('CURRENT_D97Z_SERVICE_BLOCK='+bytes(sdata[service_block_off:service_block_off+40]).hex())
if sha(sdata)!=service_d97z_sha: raise SystemExit('SERVICE_D97Z_SHA_FAIL')
if bytes(sdata[service_block_off:service_block_off+40])!=service_d97z: raise SystemExit('SERVICE_D97Z_BLOCK_FAIL')
sdata[service_block_off:service_block_off+40]=service_selector
print('SYNTHETIC_SELECTOR_ONLY_SERVICE_SHA='+sha(sdata))
print('SYNTHETIC_SELECTOR_ONLY_SERVICE_BLOCK='+bytes(sdata[service_block_off:service_block_off+40]).hex())
if sha(sdata)!=service_selector_sha: raise SystemExit('SERVICE_SELECTOR_ONLY_RECONSTRUCTION_FAIL:'+sha(sdata))
print('D97Z_SERVICE_REMOVAL_TO_SELECTOR_ONLY=PASS')

print('\n===== EXACT D97 MTL -> P7 RECONSTRUCTION =====')
data=bytearray(mtl.read_bytes())
print('CURRENT_D97_MTL_SHA='+sha(data))
print('CURRENT_D97_SITE='+bytes(data[d97_site:d97_site+len(d97_site_patch)]).hex())
print('CURRENT_D97_CAVE='+bytes(data[d97_cave:d97_cave+d97_cave_len]).hex())
if sha(data)!=d97_sha: raise SystemExit('D97_SHA_FAIL')
if bytes(data[d97_site:d97_site+len(d97_site_patch)])!=d97_site_patch: raise SystemExit('D97_SITE_IDENTITY_FAIL')
if bytes(data[d97_cave:d97_cave+d97_cave_len])!=d97_cave_patch: raise SystemExit('D97_CAVE_IDENTITY_FAIL')
data[d97_site:d97_site+len(d97_site_pre)]=d97_site_pre
data[d97_cave:d97_cave+d97_cave_len]=b'\0'*d97_cave_len
print('RECONSTRUCTED_P7_SHA='+sha(data))
print('RECONSTRUCTED_P7_SITE='+bytes(data[d97_site:d97_site+len(d97_site_pre)]).hex())
print('RECONSTRUCTED_P7_CAVE='+bytes(data[d97_cave:d97_cave+d97_cave_len]).hex())
if sha(data)!=p7_sha: raise SystemExit('P7_RECONSTRUCTION_SHA_FAIL:'+sha(data))
print('D97_TO_P7_RECONSTRUCTION=PASS')

print('\n===== MACH-O / VALIDATOR IDENTITY =====')
if u32(data,0)!=0xFEEDFACF: raise SystemExit('MACHO64_LE_FAIL')
ncmds=u32(data,16); off=32; text=None
for _ in range(ncmds):
    cmd=u32(data,off); cmdsize=u32(data,off+4)
    if cmdsize<8 or off+cmdsize>len(data): raise SystemExit('LOAD_COMMAND_INVALID')
    if cmd==0x19:
        seg=bytes(data[off+8:off+24]).split(b'\0',1)[0].decode('ascii','replace')
        vm=u64(data,off+24); vs=u64(data,off+32); fo=u64(data,off+40); fs=u64(data,off+48)
        if seg=='__TEXT': text=(vm,vs,fo,fs)
    off+=cmdsize
if text is None: raise SystemExit('TEXT_SEGMENT_MISSING')
tvm,tvs,tfo,tfs=text
rc,nm=run(['/usr/bin/nm','-nm',str(mtl)])
print('NM_RC='+str(rc))
if rc!=0: raise SystemExit('NM_FAIL')
hits=[]
for ln in nm.splitlines():
    if 'validSimulatorMetadata' not in ln: continue
    m=re.match(r'^\s*([0-9A-Fa-f]{8,16})\s+',ln)
    if m: hits.append((int(m.group(1),16),ln.strip()))
print('VALIDATOR_SYMBOL_HIT_COUNT='+str(len(hits)))
for _,ln in hits: print('VALIDATOR_SYMBOL_HIT='+ln)
if len(hits)!=1: raise SystemExit('VALIDATOR_SYMBOL_CARDINALITY_FAIL')
fstart=hits[0][0]
fstart_off=tfo+(fstart-tvm)
print(f'TEXT_SEGMENT=VM=0x{tvm:X}..0x{tvm+tvs:X}|FILE=0x{tfo:X}..0x{tfo+tfs:X}')
print(f'VALIDATOR_START_VM=0x{fstart:X}|FILEOFF=0x{fstart_off:X}')
if fstart!=0x7FFB162C7132 or fstart_off!=0x9D132: raise SystemExit('VALIDATOR_START_IDENTITY_FAIL')

sites=[
    ('CANDIDATE_REACHED',0x58B,codes[0],bytes.fromhex('8b8d10feffff83f941'),bytes.fromhex('6a6e5fe9bb38f6ff90')),
    ('BUFFER_INDEX',0x29A,codes[1],bytes.fromhex('488d3599640200b91e000000'),bytes.fromhex('6a6f5fe9ac3bf6ff90909090')),
    ('SAMPLER_INDEX',0x2D9,codes[2],bytes.fromhex('488d359764020083fa10'),bytes.fromhex('6a705fe96d3bf6ff9090')),
    ('NESTED_ARG_BUFFER',0x3E2,codes[3],bytes.fromhex('488d35cc63020031c0'),bytes.fromhex('6a715fe9643af6ff90')),
    ('OTHER_EARLY_RETURN',0xB9,codes[4],bytes.fromhex('4489f04881c488030000'),bytes.fromhex('6a725fe98d3df6ff9090')),
    ('OTHER_EARLY_UNWIND',0x6CC,codes[4],bytes.fromhex('488dbd20feffffe8c45c0100'),bytes.fromhex('6a725fe97a37f6ff90909090')),
]

print('\n===== D97AD EXACT SIX-SITE + SHARED-STUB SYNTHETIC PROOF =====')
ranges=[]
for name,rel,code,pre,post in sites:
    fo=fstart_off+rel
    actual=bytes(data[fo:fo+len(pre)])
    print(f'SITE={name}|REL=0x{rel:X}|FILEOFF=0x{fo:X}|EXIT={code}|PREIMAGE={actual.hex()}|EXPECTED={pre.hex()}|POSTIMAGE={post.hex()}')
    if actual!=pre: raise SystemExit(f'{name}_PREIMAGE_FAIL:{actual.hex()}')
    if len(pre)!=len(post): raise SystemExit(f'{name}_LENGTH_FAIL')
    ranges.append((fo,fo+len(post),name))

stub=bytes.fromhex('b8010000020f050f0b')
stub_full=stub+b'\0'*(d97_cave_len-len(stub))
print(f'SHARED_STUB_FILEOFF=0x{d97_cave:X}..0x{d97_cave+d97_cave_len:X}')
print('SHARED_STUB_PREIMAGE='+bytes(data[d97_cave:d97_cave+d97_cave_len]).hex())
print('SHARED_STUB_POSTIMAGE='+stub_full.hex())
if bytes(data[d97_cave:d97_cave+d97_cave_len])!=b'\0'*d97_cave_len: raise SystemExit('SHARED_STUB_PREIMAGE_NOT_ZERO')
ranges.append((d97_cave,d97_cave+d97_cave_len,'SHARED_EXIT_STUB'))

protected=[(0xEF8,0xEFF,'D34_PROTECTED_CAVE')]
p6_sites=[0x9F53A,0x9F5B0,0x9F63F,0x9F65E,0x9E95D,0x9E97C,0x9E9CF,0x9E985,0x9E9AC,0x9E8EF,0x9E757,0x9E74E]
p7_sites=[0x9A93B,0x9A946]
for x in p6_sites: protected.append((x,x+7,'P6'))
for x in p7_sites: protected.append((x,x+6,'P7'))
for i,(a,b,n) in enumerate(ranges):
    for c,d,m in ranges[i+1:]:
        if max(a,c)<min(b,d): raise SystemExit(f'D97AD_INTERNAL_OVERLAP:{n}:{m}')
    for c,d,m in protected:
        if max(a,c)<min(b,d): raise SystemExit(f'D97AD_RETAINED_PATCH_OVERLAP:{n}:{m}:0x{c:X}')
print('D97AD_NO_OVERLAP_D34_P6_P7_OR_INTERNAL=PASS')

for name,rel,code,pre,post in sites:
    fo=fstart_off+rel
    data[fo:fo+len(post)]=post
data[d97_cave:d97_cave+d97_cave_len]=stub_full
final_sha=sha(data)
print('D97AD_SYNTHETIC_FINAL_MTL_SHA='+final_sha)
for name,rel,code,pre,post in sites:
    fo=fstart_off+rel
    if bytes(data[fo:fo+len(post)])!=post: raise SystemExit(name+'_POST_WRITE_VERIFY_FAIL')
if bytes(data[d97_cave:d97_cave+len(stub)])!=stub: raise SystemExit('STUB_POST_WRITE_VERIFY_FAIL')
print('D97AD_ALL_POSTIMAGES_COMMITTED_IN_SYNTHETIC_COPY=PASS')

fd,tmpname=tempfile.mkstemp(prefix='OCLP7_D97AD_SYNTHETIC_',suffix='.MTLCompiler',dir='/private/tmp')
os.close(fd); tmp=Path(tmpname); tmp.write_bytes(data); tmp.chmod(0o755)
try:
    rc,dis=run(['/usr/bin/otool','-tvV',str(tmp)])
    print('OTOOL_SYNTHETIC_RC='+str(rc))
    if rc!=0: raise SystemExit('OTOOL_SYNTHETIC_FAIL')
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$')
    parsed=[]
    for ln in dis.splitlines():
        m=rx.match(ln)
        if m:
            try: parsed.append((int(m.group(1),16),m.group(2)))
            except: pass
    by={a:t for a,t in parsed}
    for name,rel,code,pre,post in sites:
        vm=fstart+rel
        print(f'SYNTHETIC_SITE_HEAD={name}|VM=0x{vm:X}|INSN={by.get(vm,"MISSING")}')
        if vm not in by: raise SystemExit(name+'_SYNTHETIC_HEAD_MISSING')
        if not by[vm].strip().startswith('pushq'):
            raise SystemExit(name+'_SYNTHETIC_HEAD_NOT_PUSH:'+by[vm])
    print('D97AD_SYNTHETIC_SITE_DISASSEMBLY=PASS')
finally:
    try: tmp.unlink()
    except Exception: pass

print('\n===== CURRENT OCLP SOURCE TRANSITION MAP =====')
helpers=root/'opencore_legacy_patcher/sys_patch/sys_patch_helpers.py'
patcher=root/'opencore_legacy_patcher/sys_patch/sys_patch.py'
if not helpers.is_file() or not patcher.is_file(): raise SystemExit('SOURCE_FILES_MISSING')
hs=helpers.read_text(); ps=patcher.read_text(); ht=ast.parse(hs); pt=ast.parse(ps)
names={
 'selector':'patch_mtl_compiler_service_version_selector',
 'service_d97z':'patch_mtl_compiler_service_tahoe_d97z_llvmversion_exit_classifier',
 'control':'patch_mtl_compiler_tahoe_true_five_clean_control',
 'p6':'patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports',
 'p7':'patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports',
 'd97':'patch_mtl_compiler_tahoe_d97_six_counter_terminal_register_snapshot',
 'd97ad':'patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier',
}
def defs(tree):
    return [n for n in ast.walk(tree) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef))]
hdefs=defs(ht)
for key,name in names.items():
    count=sum(1 for n in hdefs if n.name==name)
    print(f'SOURCE_HELPER_COUNT={key}|NAME={name}|COUNT={count}')
expected={'selector':1,'service_d97z':1,'control':1,'p6':1,'p7':1,'d97':1,'d97ad':0}
for k,v in expected.items():
    got=sum(1 for n in hdefs if n.name==names[k])
    if got!=v: raise SystemExit(f'SOURCE_HELPER_CARDINALITY_FAIL:{k}:{got}!={v}')

def seg_for(name):
    hits=[n for n in hdefs if n.name==name]
    if len(hits)!=1: return None
    return ast.get_source_segment(hs,hits[0]) or ''
for key in ('selector','service_d97z','control','p6','p7','d97'):
    seg=seg_for(names[key])
    print(f'SOURCE_HELPER_SEG_SHA={key}|SHA256={hashlib.sha256(seg.encode()).hexdigest()}')

calls=[]
for n in ast.walk(pt):
    if isinstance(n,ast.Call) and isinstance(n.func,ast.Attribute):
        calls.append((getattr(n,'lineno',0),n.func.attr,ast.unparse(n.func.value)))
filtered=[x for x in sorted(calls) if x[1] in set(names.values())]
print('SOURCE_ACTIVE_TARGET_CALLS='+repr(filtered))
expected_order=[names[k] for k in ('selector','service_d97z','control','p6','p7','d97')]
actual=[x[1] for x in filtered]
if actual!=expected_order: raise SystemExit('SOURCE_ACTIVE_CALL_ORDER_FAIL:'+repr(actual))
receivers={x[2] for x in filtered}
print('SOURCE_ACTIVE_CALL_RECEIVERS='+repr(sorted(receivers)))
if receivers!={'sys_patch_helpers.SysPatchHelpers(self.constants)'}: raise SystemExit('SOURCE_CALL_RECEIVER_FAIL')
print('CURRENT_SOURCE_ORDER_SELECTOR_D97Z_CONTROL_P6_P7_D97=PASS')
print('PLANNED_SOURCE_TRANSITION_1=REMOVE_D97Z_SERVICE_HELPER_AND_CALL_TO_RESTORE_SELECTOR_ONLY_SERVICE')
print('PLANNED_SOURCE_TRANSITION_2=REPLACE_D97_MTL_HELPER_AND_CALL_WITH_D97AD_NOT_STACKED')
print('PLANNED_TARGET_ORDER=selector,control,p6,p7,d97ad')
print('PLANNED_SERVICE_POST_ROOTPATCH_SHA='+service_selector_sha)
print('PLANNED_MTL_POST_ROOTPATCH_SHA='+final_sha)
print('D97AD_SOURCE_TRANSITION_PREIMAGE=STATIC_PROVEN')

print('\n===== CONSERVATIVE CONCLUSION =====')
print('D97AC_FINITE_PATH_OUTCOME_PARTITION=RETAINED_STATIC_PROVEN')
print('D97AC_CLOSED_NONTERMINAL_SCC_COUNT=RETAINED_ZERO')
print('D97AC_REACHABLE_OUTSIDE_OR_UNRESOLVED_EDGE_COUNT=RETAINED_ZERO')
print('D97AC_BLOCKS_WITHOUT_FINITE_OUTCOME_PATH=RETAINED_ZERO')
print('D97AD_SERVICE_D97Z_REMOVAL_TO_SELECTOR_ONLY=STATIC_PROVEN')
print('D97AD_MTL_D97_REPLACEMENT_BY_WHOLE_STAGE_CLASSIFIER=STATIC_PROVEN')
print('D97AD_EXACT_FINAL_MTL_SHA='+final_sha)
print('D97AD_FASTLANE_DESIGN_AUTHORIZED=YES_WITH_RUNTIME_LIVENESS_GATE')
print('D97AD_AUTO_INTEGRATION=NO')
print('D97AD_ROOT_PATCH_AUTHORIZED=NO_PENDING_FASTLANE_BUILD_AND_ASSISTANT_AUDIT')
print('D97AD_READONLY_PRE_D97_WHOLE_STAGE_FINAL_IMAGE_AND_SOURCE_TRANSITION_MAP=PASS')
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
