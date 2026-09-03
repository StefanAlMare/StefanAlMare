#!/bin/zsh -f
set -euo pipefail

ROOT_DEFAULT="/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
ROOT_ALT="/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"
EXPECTED_BRANCH="alex-tahoe-25G82-custom"
EXPECTED_HEAD="4143b7077a9a4e5aa41ec7a06c0888597eda9b06"
HELPERS_REL="opencore_legacy_patcher/sys_patch/sys_patch_helpers.py"
SYSPATCH_REL="opencore_legacy_patcher/sys_patch/sys_patch.py"
METAL_REL="opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"
EXPECTED_HELPERS_SHA="6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c"
EXPECTED_SYSPATCH_SHA="93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69"
EXPECTED_METAL_SHA="fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24"
TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
A4F_SHA="a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e"
D97AD_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
P7_SHA="6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda"
OLD_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
A4F_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"
NEW_UUID="0FC4C627-2A5D-491B-8101-00CAAA7116B7"
EXPECTED_VESA_BOOT_SEC="1788466673"
OUT="$HOME/Desktop/OCLP7_D97AL_P7_NATURAL_FLOW_SOURCE_AND_SYNTHETIC_DESIGN_AUDIT.txt"

fail() {
    echo "D97AL_AUDIT=FAIL_CLOSED|REASON=$1"
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

echo "===== OCLP7 D97AL — READ-ONLY P7 NATURAL-FLOW SOURCE + SYNTHETIC DESIGN AUDIT ====="
echo "PURPOSE=prove_exact_current_source_transition_and_synthetic_A4F_to_D97AD_to_P7_to_new_UUID_without_mutation"
echo "EXPECTED_P7_SHA256=$P7_SHA"
echo "OLD_A4F_UUID=$A4F_UUID"
echo "NEW_P7_NATURAL_FLOW_UUID=$NEW_UUID"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

ROOT=""
for C in "$ROOT_DEFAULT" "$ROOT_ALT" "$HOME/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82"; do
    if [[ -d "$C/.git" && ! -L "$C" ]]; then
        ROOT="$C"
        break
    fi
done
[[ -n "$ROOT" ]] || fail "SOURCE_ROOT_NOT_FOUND"

echo "SOURCE_ROOT=$ROOT"
HELPERS="$ROOT/$HELPERS_REL"
SYSPATCH="$ROOT/$SYSPATCH_REL"
METAL="$ROOT/$METAL_REL"
for F in "$HELPERS" "$SYSPATCH" "$METAL" "$TARGET"; do
    [[ -f "$F" && ! -L "$F" ]] || fail "MISSING_OR_SYMLINK_${F:t}"
done

PYTHON=""
for C in "$ROOT/.venv/bin/python" /usr/local/bin/python3 /usr/bin/python3 "$(command -v python3 2>/dev/null || true)"; do
    if [[ -n "$C" && -x "$C" ]] && "$C" -c 'import ast,hashlib,pathlib,struct,sys,uuid; assert sys.version_info >= (3,10)' >/dev/null 2>&1; then
        PYTHON="$C"
        break
    fi
done
[[ -n "$PYTHON" ]] || fail "PYTHON3_NOT_FOUND"
echo "PYTHON=$PYTHON"

BRANCH="$(/usr/bin/git -C "$ROOT" branch --show-current)"
HEAD="$(/usr/bin/git -C "$ROOT" rev-parse HEAD)"
STATUS="$(/usr/bin/git -C "$ROOT" status --short --untracked-files=no)"
echo "SOURCE_BRANCH=$BRANCH"
echo "SOURCE_HEAD=$HEAD"
echo "===== SOURCE_TRACKED_STATUS ====="
printf '%s\n' "$STATUS"
[[ "$BRANCH" == "$EXPECTED_BRANCH" ]] || fail "SOURCE_BRANCH_MISMATCH"
[[ "$HEAD" == "$EXPECTED_HEAD" ]] || fail "SOURCE_HEAD_MISMATCH"

H_SHA="$(/usr/bin/shasum -a 256 "$HELPERS" | /usr/bin/awk '{print $1}')"
S_SHA="$(/usr/bin/shasum -a 256 "$SYSPATCH" | /usr/bin/awk '{print $1}')"
M_SHA="$(/usr/bin/shasum -a 256 "$METAL" | /usr/bin/awk '{print $1}')"
T_SHA="$(/usr/bin/shasum -a 256 "$TARGET" | /usr/bin/awk '{print $1}')"
echo "HELPERS_SHA256=$H_SHA"
echo "SYSPATCH_SHA256=$S_SHA"
echo "METAL_SHA256=$M_SHA"
echo "TARGET_SHA256=$T_SHA"
[[ "$H_SHA" == "$EXPECTED_HELPERS_SHA" ]] || fail "HELPERS_SHA_MISMATCH"
[[ "$S_SHA" == "$EXPECTED_SYSPATCH_SHA" ]] || fail "SYSPATCH_SHA_MISMATCH"
[[ "$M_SHA" == "$EXPECTED_METAL_SHA" ]] || fail "METAL_SHA_MISMATCH"
[[ "$T_SHA" == "$A4F_SHA" ]] || fail "TARGET_NOT_EXACT_A4F"

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_SEC="$(printf '%s\n' "$BOOT_RAW" | /usr/bin/sed -E 's/^.*sec = ([0-9]+),.*$/\1/')"
echo "CURRENT_KERN_BOOTTIME=$BOOT_RAW"
echo "CURRENT_KERN_BOOTTIME_SEC=$BOOT_SEC"
[[ "$BOOT_SEC" == "$EXPECTED_VESA_BOOT_SEC" ]] || fail "BOOT_CHRONOLOGY_CHANGED"
echo "CURRENT_VESA_BOOT_IDENTITY=PASS"

"$PYTHON" - "$HELPERS" "$SYSPATCH" "$TARGET" "$D97AD_SHA" "$P7_SHA" "$OLD_UUID" "$A4F_UUID" "$NEW_UUID" <<'PY'
from __future__ import annotations
import ast, hashlib, struct, sys, uuid
from pathlib import Path

helpers=Path(sys.argv[1]); syspatch=Path(sys.argv[2]); target=Path(sys.argv[3])
d97ad_sha=sys.argv[4]; p7_sha=sys.argv[5]
old_uuid=sys.argv[6].upper(); a4f_uuid=sys.argv[7].upper(); new_uuid=sys.argv[8].upper()

def sha(b): return hashlib.sha256(bytes(b)).hexdigest()
def uuid_bytes(s): return uuid.UUID(s).bytes

hs=helpers.read_text(encoding='utf-8')
ss=syspatch.read_text(encoding='utf-8')
ht=ast.parse(hs); st=ast.parse(ss)

def defs(tree): return [n for n in ast.walk(tree) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef))]
hdefs=defs(ht)
N={
 'selector':'patch_mtl_compiler_service_version_selector',
 'control':'patch_mtl_compiler_tahoe_true_five_clean_control',
 'p6':'patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports',
 'p7':'patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports',
 'd97ad':'patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier',
 'd97af':'patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp',
}
print('===== CURRENT SOURCE DEFINITIONS =====')
segments={}
for k,nm in N.items():
    hits=[n for n in hdefs if n.name==nm]
    print(f'HELPER_DEF|KEY={k}|NAME={nm}|COUNT={len(hits)}')
    if len(hits)!=1: raise SystemExit(f'HELPER_CARDINALITY_FAIL:{k}:{len(hits)}')
    seg=ast.get_source_segment(hs,hits[0]) or ''
    segments[k]=seg
    print(f'HELPER_SEGMENT_SHA256|KEY={k}|SHA={sha(seg.encode())}|START_LINE={hits[0].lineno}|END_LINE={getattr(hits[0],"end_lineno",0)}')

print('===== CURRENT ACTIVE CALLS =====')
calls=[]
for n in ast.walk(st):
    if isinstance(n,ast.Call) and isinstance(n.func,ast.Attribute):
        if n.func.attr in set(N.values()):
            calls.append((getattr(n,'lineno',0),n.func.attr,ast.get_source_segment(ss,n) or ast.unparse(n)))
calls.sort()
for line,name,text in calls:
    print(f'ACTIVE_CALL|LINE={line}|NAME={name}|TEXT={text}')
for k in N:
    c=sum(1 for _,nm,_ in calls if nm==N[k])
    print(f'ACTIVE_CALL_COUNT|KEY={k}|COUNT={c}')
    if c!=1: raise SystemExit(f'ACTIVE_CALL_CARDINALITY_FAIL:{k}:{c}')
order=[nm for _,nm,_ in calls]
if not (order.index(N['selector']) < order.index(N['control']) < order.index(N['p6']) < order.index(N['p7']) < order.index(N['d97ad']) < order.index(N['d97af'])):
    raise SystemExit('ACTIVE_CALL_ORDER_FAIL:'+repr(order))
print('CURRENT_ACTIVE_ORDER_SELECTOR_CONTROL_P6_P7_D97AD_D97AF=PASS')

print('===== D97AF METHOD-LOCAL RETARGET AUDIT =====')
d97af=segments['d97af']
checks={
 'D97AD_PRE_SHA':d97ad_sha,
 'P7_SHA_ALREADY_PRESENT':p7_sha,
 'OLD_UUID':old_uuid,
 'A4F_UUID':a4f_uuid,
 'NEW_UUID_ALREADY_PRESENT':new_uuid,
 '/usr/bin/chflags':'/usr/bin/chflags',
 '/bin/chflags':'/bin/chflags',
}
for lab,tok in checks.items():
    print(f'D97AF_TOKEN_COUNT|LABEL={lab}|COUNT={d97af.count(tok)}|TOKEN={tok}')
if d97af.count(d97ad_sha) < 1: raise SystemExit('D97AF_D97AD_PRE_SHA_MISSING')
if d97af.count(old_uuid) < 1: raise SystemExit('D97AF_OLD_UUID_MISSING')
if d97af.count(a4f_uuid) < 1: raise SystemExit('D97AF_A4F_UUID_MISSING')
if d97af.count(new_uuid) != 0: raise SystemExit('D97AF_NEW_UUID_ALREADY_PRESENT_UNEXPECTED')
if d97af.count('/usr/bin/chflags') != 2: raise SystemExit('D97AH_CHFLAGS_CORRECTION_NOT_EXACT_TWO')
print('D97AF_TRANSACTION_SUBSTRATE_CURRENT=PASS')

print('===== SYNTHETIC CURRENT A4F -> D97AD -> P7 =====')
data=bytearray(target.read_bytes())
print('SYNTH_INPUT_SHA='+sha(data))
# Mach-O LC_UUID parse.
if len(data)<32 or struct.unpack_from('<I',data,0)[0]!=0xFEEDFACF: raise SystemExit('MACHO64_LE_FAIL')
ncmds=struct.unpack_from('<I',data,16)[0]; off=32; lc_uuid_off=None; lc_uuid=None
for _ in range(ncmds):
    cmd,cmdsize=struct.unpack_from('<II',data,off)
    if cmdsize<8 or off+cmdsize>len(data): raise SystemExit('LOAD_COMMAND_INVALID')
    if cmd==0x1B and cmdsize>=24:
        lc_uuid_off=off+8
        lc_uuid=str(uuid.UUID(bytes=bytes(data[lc_uuid_off:lc_uuid_off+16]))).upper()
    off+=cmdsize
if lc_uuid_off is None: raise SystemExit('LC_UUID_MISSING')
print(f'CURRENT_LC_UUID={lc_uuid}')
print(f'LC_UUID_FILE_OFFSET=0x{lc_uuid_off:X}')
if lc_uuid!=a4f_uuid: raise SystemExit('CURRENT_LC_UUID_NOT_A4F')
if lc_uuid_off!=0xAB0: raise SystemExit(f'LC_UUID_OFFSET_CHANGED:0x{lc_uuid_off:X}')
# Undo UUID-only A4F stamp first.
data[lc_uuid_off:lc_uuid_off+16]=uuid_bytes(old_uuid)
print('AFTER_A4F_TO_D5CE_SHA='+sha(data))
if sha(data)!=d97ad_sha: raise SystemExit('A4F_TO_D97AD_SHA_FAIL:'+sha(data))
print('A4F_TO_EXACT_D97AD=PASS')

fstart=0x9D132
sites=[
 ('CANDIDATE',0x58B,'8b8d10feffff83f941','6a6e5fe9bb38f6ff90'),
 ('BUFFER_INDEX',0x29A,'488d3599640200b91e000000','6a6f5fe9ac3bf6ff90909090'),
 ('SAMPLER_INDEX',0x2D9,'488d359764020083fa10','6a705fe96d3bf6ff9090'),
 ('NESTED_ARG_BUFFER',0x3E2,'488d35cc63020031c0','6a715fe9643af6ff90'),
 ('OTHER_EARLY_RETURN',0xB9,'4489f04881c488030000','6a725fe98d3df6ff9090'),
 ('OTHER_EARLY_UNWIND',0x6CC,'488dbd20feffffe8c45c0100','6a725fe97a37f6ff90909090'),
]
for name,rel,pre_hex,post_hex in sites:
    fo=fstart+rel; pre=bytes.fromhex(pre_hex); post=bytes.fromhex(post_hex)
    actual=bytes(data[fo:fo+len(post)])
    print(f'D97AD_SITE_REVERSE|NAME={name}|FILEOFF=0x{fo:X}|ACTUAL_POST={actual.hex()}|EXPECTED_POST={post.hex()}|RESTORE_PRE={pre.hex()}')
    if actual!=post: raise SystemExit(f'D97AD_POSTIMAGE_MISMATCH:{name}:{actual.hex()}')
    if len(pre)!=len(post): raise SystemExit(f'D97AD_SITE_LENGTH_MISMATCH:{name}')
    data[fo:fo+len(pre)]=pre
cave_off=0xF80; cave_len=33; stub=bytes.fromhex('b8010000020f050f0b')+b'\0'*(cave_len-9)
actual_cave=bytes(data[cave_off:cave_off+cave_len])
print(f'D97AD_STUB_REVERSE|FILEOFF=0x{cave_off:X}|ACTUAL={actual_cave.hex()}|EXPECTED={stub.hex()}')
if actual_cave!=stub: raise SystemExit('D97AD_STUB_POSTIMAGE_MISMATCH')
data[cave_off:cave_off+cave_len]=b'\0'*cave_len
p7_actual=sha(data)
print('RECONSTRUCTED_P7_SHA256='+p7_actual)
if p7_actual!=p7_sha: raise SystemExit('P7_SHA_RECONSTRUCTION_FAIL:'+p7_actual)
print('EXACT_P7_RECONSTRUCTION=PASS')
print('P7_LC_UUID='+str(uuid.UUID(bytes=bytes(data[lc_uuid_off:lc_uuid_off+16]))).upper())

print('===== SYNTHETIC P7 + NEW PROVENANCE UUID =====')
data_new=bytearray(data)
data_new[lc_uuid_off:lc_uuid_off+16]=uuid_bytes(new_uuid)
new_sha=sha(data_new)
print('P7_NATURAL_FLOW_NEW_UUID='+new_uuid)
print('P7_NATURAL_FLOW_EXPECTED_POST_SHA256='+new_sha)
print('P7_NATURAL_FLOW_POST_BYTES='+str(len(data_new)))
print('P7_NATURAL_FLOW_LC_UUID='+str(uuid.UUID(bytes=bytes(data_new[lc_uuid_off:lc_uuid_off+16]))).upper())
diff=[i for i,(a,b) in enumerate(zip(data,data_new)) if a!=b]
print('P7_TO_NEW_UUID_DIFFERING_BYTE_COUNT='+str(len(diff)))
print('P7_TO_NEW_UUID_DIFF_MIN='+('0x%X'%min(diff) if diff else 'NONE'))
print('P7_TO_NEW_UUID_DIFF_MAX='+('0x%X'%max(diff) if diff else 'NONE'))
if not diff or min(diff)<lc_uuid_off or max(diff)>=lc_uuid_off+16: raise SystemExit('NEW_UUID_DIFF_OUTSIDE_LC_UUID')
print('P7_TO_NEW_UUID_UUID_ONLY_DIFF=PASS')

print('===== PROPOSED SOURCE TRANSITION — DESIGN ONLY =====')
print('TRANSITION_1=REMOVE_EXACT_ONE_ACTIVE_D97AD_CALL_FROM_sys_patch.py')
print('TRANSITION_2=RETARGET_D97AF_TRANSACTION_PREIMAGE_FROM_D97AD_SHA_TO_P7_SHA')
print('TRANSITION_3=RETARGET_PROVENANCE_UUID_A4F_TO_NEW_UUID')
print('TRANSITION_4=RETARGET_EXPECTED_POST_SHA_TO_SYNTHETIC_NEW_SHA')
print('TRANSITION_5=RENAME_ACTIVE_STAMP_PHASE_D97AF_TO_NEW_NATURAL_FLOW_PHASE_FOR_UNAMBIGUOUS_LOGGING_RECOMMENDED')
print('PRESERVE_SELECTOR_CONTROL_P6_P7=YES')
print('D97AD_HELPER_DEFINITION_MAY_REMAIN_DORMANT_FOR_ROLLBACK=YES')
print('D97AF_A4F_IDENTITY_MUST_NOT_BE_REUSED=YES')
print('SOURCE_TRANSITION_DESIGN_STATIC_READY=YES')
print('D97AL_COMPUTED_NEW_POST_SHA256='+new_sha)
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
echo "D97AL_AUDIT=COMPLETE"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$OUT"
