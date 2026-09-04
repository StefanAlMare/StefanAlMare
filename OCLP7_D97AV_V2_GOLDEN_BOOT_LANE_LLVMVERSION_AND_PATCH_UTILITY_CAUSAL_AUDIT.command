#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.7.9"
EXPECTED_OS_BUILD="24G830"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
METAL="/System/Library/Frameworks/Metal.framework/Versions/A/Metal"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_32023_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
EXPECTED_3802_UUID="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"
OUT="$HOME/Desktop/OCLP7_D97AV_V2_GOLDEN_BOOT_LANE_LLVMVERSION_AND_PATCH_UTILITY_CAUSAL_AUDIT.txt"
JSON_OUT="$HOME/Desktop/OCLP7_D97AV_V2_GOLDEN_BOOT_LANE_LLVMVERSION_AND_PATCH_UTILITY_CAUSAL_AUDIT.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AV_V2.XXXXXX)"
MTL_OTOOL="$TMP/mtl.otool"
MTL_NM="$TMP/mtl.nm"
SVC_OTOOL="$TMP/service.otool"
SVC_NM="$TMP/service.nm"
METAL_OTOOL="$TMP/metal.otool"
METAL_NM="$TMP/metal.nm"
BOOT_JSON="$TMP/boot.json"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AV_V2.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){
  echo "D97AV_V2_AUDIT=FAIL_CLOSED|REASON=$1"
  echo "SYSTEM_FILE_MUTATION=NO"
  echo "PROCESS_DEBUG_ATTACH=NO"
  echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
[[ -x /usr/bin/otool && -x /usr/bin/nm ]] || fail "MISSING_OTOOL_OR_NM"
[[ -f "$MTL32023" && -f "$MTL3802" && -f "$SERVICE" ]] || fail "EXPECTED_GOLDEN_BINARIES_MISSING"

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AV V2 — GOLDEN BOOT LANE + LLVMVERSION + SEVEN-PATCH UTILITY CAUSAL AUDIT ====="
echo "EXPECTED_OS_VERSION=$EXPECTED_OS_VERSION"
echo "EXPECTED_OS_BUILD=$EXPECTED_OS_BUILD"
echo "SYSTEM_FILE_MUTATION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "PATCH_SET=P1,P2B,P3,AIR00,D34,P6,P7"
echo "D97AM_UUID_STAMP_FUNCTIONAL_PATCH=NO_PROVENANCE_ONLY"

a_OS="$(/usr/bin/sw_vers -productVersion)"
a_BUILD="$(/usr/bin/sw_vers -buildVersion)"
a_SHA="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
echo "OS_VERSION=$a_OS"
echo "OS_BUILD=$a_BUILD"
echo "GOLDEN_32023_SHA256=$a_SHA"
[[ "$a_OS" == "$EXPECTED_OS_VERSION" && "$a_BUILD" == "$EXPECTED_OS_BUILD" ]] || fail "NOT_EXPECTED_GOLDEN_OS"
[[ "$a_SHA" == "$EXPECTED_32023_SHA" ]] || fail "GOLDEN_32023_SHA_MISMATCH"
echo "D97AV_V2_GOLDEN_IDENTITY=PASS"

/usr/bin/otool -tvV "$MTL32023" > "$MTL_OTOOL" 2>&1 || fail "MTL_OTOOL_FAILED"
/usr/bin/nm -nm "$MTL32023" > "$MTL_NM" 2>&1 || fail "MTL_NM_FAILED"
/usr/bin/otool -tvV "$SERVICE" > "$SVC_OTOOL" 2>&1 || fail "SERVICE_OTOOL_FAILED"
/usr/bin/nm -nm "$SERVICE" > "$SVC_NM" 2>&1 || true
if [[ -f "$METAL" ]]; then
  /usr/bin/otool -tvV "$METAL" > "$METAL_OTOOL" 2>&1 || true
  /usr/bin/nm -nm "$METAL" > "$METAL_NM" 2>&1 || true
else
  : > "$METAL_OTOOL"; : > "$METAL_NM"
fi

echo
echo "===== EXACT GOLDEN 32023 LANE-PC MAP + SEVEN-PATCH STATIC INFLUENCE MAP ====="
"$PYTHON" - "$MTL32023" "$MTL_OTOOL" "$MTL_NM" "$SERVICE" "$SVC_OTOOL" "$SVC_NM" "$JSON_OUT" <<'PY'
from __future__ import annotations
import hashlib,json,re,struct,sys
from pathlib import Path

mtlp,mtlot,mtlnm,svcp,svcot,svcnm,jsonout=map(Path,sys.argv[1:8])

def macho(path):
    d=path.read_bytes()
    if len(d)<32 or struct.unpack_from('<I',d,0)[0]!=0xFEEDFACF: raise SystemExit('MACHO64_REQUIRED:'+str(path))
    n=struct.unpack_from('<I',d,16)[0]; p=32; text=None; uuid=None
    for _ in range(n):
        cmd,sz=struct.unpack_from('<II',d,p)
        if cmd==0x19 and sz>=72:
            nm=d[p+8:p+24].split(b'\0',1)[0].decode('ascii','replace')
            vm,vs,fo,fs=struct.unpack_from('<QQQQ',d,p+24)
            if nm=='__TEXT': text=(vm,vs,fo,fs)
        elif cmd==0x1B and sz>=24:
            u=d[p+8:p+24]; uuid=f'{u[0:4].hex()}-{u[4:6].hex()}-{u[6:8].hex()}-{u[8:10].hex()}-{u[10:16].hex()}'.upper()
        p+=sz
    if not text: raise SystemExit('TEXT_MISSING:'+str(path))
    return d,text,uuid

def dis(path):
    rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); out=[]
    for ln in path.read_text(errors='replace').splitlines():
        m=rx.match(ln)
        if not m: continue
        try:a=int(m.group(1),16)
        except:continue
        b=m.group(2).strip()
        if b:out.append((a,b))
    return sorted(out)

def syms(path):
    out=[]
    if not path.exists(): return out
    for ln in path.read_text(errors='replace').splitlines():
        m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',ln)
        if not m:continue
        try:a=int(m.group(1),16)
        except:continue
        out.append((a,m.group(2).strip()))
    return sorted(out)

def owner(vm,ss,inst):
    p=[x for x in ss if x[0]<=vm]
    if not p:return ('UNKNOWN',None,None)
    s=p[-1]; nxt=[a for a,n in ss if a>s[0]]; e=min(nxt) if nxt else (inst[-1][0]+16 if inst else None)
    return (s[1],s[0],e)

md,(mbase,mvs,mfo,mfs),muuid=macho(mtlp); mi=dis(mtlot); ms=syms(mtlnm)
sd,(sbase,svs,sfo,sfs),suuid=macho(svcp); si=dis(svcot); ss=syms(svcnm)
print(f'GOLDEN_32023_IMAGE_BASE=0x{mbase:X}')
print(f'GOLDEN_32023_UUID={muuid}')
print(f'GOLDEN_SERVICE_IMAGE_BASE=0x{sbase:X}')
print(f'GOLDEN_SERVICE_SHA256={hashlib.sha256(sd).hexdigest()}')
print(f'GOLDEN_SERVICE_UUID={suuid}')

lane_offsets=[0x9A9FC,0x9FFEE,0xA0521,0xA5F81]
lane_map={}
for off in lane_offsets:
    vm=mbase+off; own,fs,fe=owner(vm,ms,mi); nearest=min(mi,key=lambda x:abs(x[0]-vm)) if mi else (0,'NONE')
    lane_map[f'0x{off:X}']={'symbol':own,'instruction':nearest[1]}
    print(f'LANE_PC_MAP|OFFSET=0x{off:X}|VM=0x{vm:X}|SYMBOL={own}|INSTRUCTION={nearest[1]}')
    idx=mi.index(nearest)
    for a,b in mi[max(0,idx-12):min(len(mi),idx+13)]: print(f'LANE_PC_CONTEXT|TARGET=0x{off:X}|OFFSET=0x{a-mbase:X}|TEXT={b}')

# Conceptual seven patches. P1 is in MTLCompilerService; all others are in selected 32023 MTLCompiler.
# For MTL sites, postimages are exact active design bytes from the audited project lineage.
patch_groups={
 'P2B':[(0x9A8CD,'418b8110010000','request_layout_+0xD0_to_+0x110')],
 'AIR00':[(0x9A933,'49c7462800000000','AIR_fallback_state')],
 'P3':[(0xA1573,'81c900002000','serialized_bitcode_path')],
 'D34':[(0xEF8,'4889f8488937c3','semantic_equivalent_reset_cave'),(0x9F6FA,'e8f917f6ff','semantic_equivalent_reset_callsite')],
 'P6':[
  (0x9F53A,'f680e400000001','C4_to_E4'),(0x9F5B0,'f680e400000001','C4_to_E4'),(0x9F63F,'f680e400000001','C4_to_E4'),(0x9F65E,'f680e400000002','C4_to_E4'),
  (0x9E95D,'f683e400000001','C4_to_E4'),(0x9E97C,'f683e400000002','C4_to_E4'),(0x9E9CF,'f683e400000004','C4_to_E4'),(0x9E985,'8b93e8000000','C8_to_E8'),
  (0x9E9AC,'8b93e8000000','C8_to_E8'),(0x9E8EF,'8bb3ec000000','CC_to_EC'),(0x9E757,'8bb31c010000','DC_to_11C'),(0x9E74E,'83be2001000000','E0_to_120')],
 'P7':[(0x9A93B,'8b83a8000000','raw_88_to_A8'),(0x9A946,'8b8bac000000','raw_8C_to_AC')],
}

matrix={}
for pn,sites in patch_groups.items():
    owners=set(); rows=[]
    for off,posthex,role in sites:
        post=bytes.fromhex(posthex); pre=md[off:off+len(post)]; vm=mbase+off; own,fs,fe=owner(vm,ms,mi); owners.add(own)
        row={'off':off,'golden_pre':pre.hex(),'tahoe_post':post.hex(),'same':pre==post,'role':role,'symbol':own}; rows.append(row)
        print(f'PATCH_SITE|PATCH={pn}|OFFSET=0x{off:X}|ROLE={role}|GOLDEN_PREIMAGE={pre.hex()}|TAHOE_PATCHED_POSTIMAGE={post.hex()}|GOLDEN_EQUALS_PATCHED={"YES" if pre==post else "NO"}|SYMBOL={own}')
    matrix[pn]={'sites':rows,'symbols':sorted(owners)}
    print(f'PATCH_SYMBOL_SET|PATCH={pn}|SYMBOLS={" || ".join(sorted(owners))}')

# P1 exact semantic transform: custom Tahoe bridge replaces selector constant 31001 (0x7919) with 32023 (0x7D17).
# Inspect Golden service rather than assuming Golden has/does not have this bridge.
patterns=[(31001,'19790000'),(32023,'177d0000'),(3802,'da0e0000')]
p1info={}
for val,hx in patterns:
    pat=bytes.fromhex(hx); offs=[]; p=0
    while True:
        p=sd.find(pat,p)
        if p<0:break
        offs.append(p); p+=1
    p1info[str(val)]=offs
    print(f'GOLDEN_SERVICE_IMM32|VALUE={val}|COUNT={len(offs)}|FILE_OFFSETS={",".join("0x%X"%x for x in offs)}')
    for off in offs[:20]:
        vm=sbase+(off-sfo); own,fs,fe=owner(vm,ss,si); nearest=min(si,key=lambda x:abs(x[0]-vm)) if si else (0,'NONE')
        print(f'GOLDEN_SERVICE_IMM32_CONTEXT|VALUE={val}|FILE_OFFSET=0x{off:X}|VM=0x{vm:X}|SYMBOL={own}|INSTRUCTION={nearest[1]}')
        idx=si.index(nearest)
        for a,b in si[max(0,idx-8):min(len(si),idx+9)]: print(f'SERVICE_SELECTOR_CONTEXT|VALUE={val}|FILE_OFFSET=0x{off:X}|VM=0x{a:X}|TEXT={b}')
print('P1_CONCEPTUAL_TRANSFORM=SERVICE_SELECTOR_IMM32_31001_TO_32023')
print('P1_TAHOE_KNOWN_PATCHED_SELECTOR_FILEOFF=0x3496')
print('P1_TAHOE_PATCHED_POSTIMAGE_AT_0x3496=177d0000')
print('P1_DIRECT_GENERATION_SELECTION_INFLUENCE=YES')

# Conservative influence/utility matrix. These are hypotheses/status labels, not causal verdicts.
historical={
 'P1':('selector_bridge_31001_to_32023','historically_enables_31001_requests_to_select_32023','NEW_GOLDEN_BOOT_DIVERGENCE_REQUIRES_REEVALUATION','HIGH_PRIORITY_SUSPECT_REEVALUATE'),
 'P2B':('request_layout_+0xD0_to_+0x110','accepted_structural_request_layout_bridge','NO_GUI_SUFFICIENCY_PROOF_ALONE','KEEP_PROVISIONAL_REEVALUATE_LANE_INFLUENCE'),
 'P3':('serialized_bitcode_path','accepted_serialized_bitcode_bridge','NO_GUI_SUFFICIENCY_PROOF_ALONE','KEEP_PROVISIONAL_REEVALUATE_LANE_INFLUENCE'),
 'AIR00':('AIR_2.6_Metal_3.1_fallback','D22_SEMANTIC_PROVEN_AIR2.6_METAL3.1','NO_GUI_SUFFICIENCY_PROOF_ALONE','KEEP_PROVISIONAL_STRONG_SEMANTIC_EVIDENCE'),
 'D34':('semantic_equivalent_reset','semantic_equivalent_reset_accepted','NO_GUI_SUFFICIENCY_PROOF_ALONE','KEEP_PROVISIONAL_STRONG_SEMANTIC_EVIDENCE'),
 'P6':('12_request_dialect_callsite_ports','real_fixed_header_dialect_mismatch_corrected','RUNTIME_SUFFICIENCY_NEGATIVE','SUSPECT_ABLATION_CANDIDATE_AFTER_LANE_MAP'),
 'P7':('2_raw_optional_payload_read_ports','real_raw88_8C_vs_A8_AC_mismatch_corrected','RUNTIME_SUFFICIENCY_NEGATIVE','SUSPECT_ABLATION_CANDIDATE_AFTER_LANE_MAP'),
}
for pn,(purpose,benefit,cost,just) in historical.items():
    direct_gen='YES' if pn=='P1' else 'NO_POST_SELECTION_32023_BINARY'
    sy='SERVICE_SELECTOR' if pn=='P1' else ' || '.join(matrix[pn]['symbols'])
    print(f'PATCH_UTILITY|PATCH={pn}|PURPOSE={purpose}|DIRECT_GENERATION_SELECTION={direct_gen}|STATIC_LOCATION={sy}|KNOWN_RUNTIME_OR_SEMANTIC_BENEFIT={benefit}|KNOWN_RUNTIME_COST_OR_LIMIT={cost}|CURRENT_JUSTIFICATION={just}')

Path(jsonout).write_text(json.dumps({'lane_map':lane_map,'patch_matrix':matrix,'golden_service_selector_immediates':p1info,'historical_utility':historical},indent=2),encoding='utf-8')
print('D97AV_V2_SEVEN_PATCH_STATIC_UTILITY_MAP=COMPLETE')
PY

echo
echo "===== GOLDEN BOOT-ALIGNED PER-PID GENERATION/LANE SEQUENCES ====="
BOOT_SEC="$(/usr/sbin/sysctl -n kern.boottime | /usr/bin/sed -E 's/.*sec = ([0-9]+).*/\1/')"
BOOT_START="$("$PYTHON" - "$BOOT_SEC" <<'PY'
import datetime,sys
print(datetime.datetime.fromtimestamp(int(sys.argv[1])).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
BOOT_END="$("$PYTHON" - "$BOOT_SEC" <<'PY'
import datetime,sys
print((datetime.datetime.fromtimestamp(int(sys.argv[1]))+datetime.timedelta(minutes=3)).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
echo "GOLDEN_BOOT3M_START=$BOOT_START"
echo "GOLDEN_BOOT3M_END=$BOOT_END"
/usr/bin/log show --start "$BOOT_START" --end "$BOOT_END" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$BOOT_JSON" 2>/dev/null || true
"$PYTHON" - "$BOOT_JSON" "$EXPECTED_32023_UUID" "$EXPECTED_3802_UUID" <<'PY'
import collections,json,sys
from pathlib import Path
raw=Path(sys.argv[1]).read_text(errors='replace'); dec=json.JSONDecoder(); rec=[]; i=0
while i<len(raw):
    while i<len(raw) and (raw[i].isspace() or raw[i]==','):i+=1
    if i>=len(raw):break
    if raw[i] not in '[{':
        ps=[p for p in (raw.find('{',i),raw.find('[',i)) if p>=0]
        if not ps:break
        i=min(ps)
    try:o,e=dec.raw_decode(raw,i)
    except json.JSONDecodeError:i+=1;continue
    if isinstance(o,list):rec.extend(x for x in o if isinstance(x,dict))
    elif isinstance(o,dict):rec.append(o)
    i=e
u32,u38=sys.argv[2].upper(),sys.argv[3].upper()
def v(r,*ks):
    for k in ks:
        if k in r and r[k] is not None:return r[k]
    return None
def pid(r):
    try:return int(v(r,'processID','processIdentifier'))
    except:return -1
rows=[]
for r in rec:
    u=str(v(r,'senderImageUUID') or '').upper(); gen='32023' if u==u32 else ('3802' if u==u38 else None)
    if not gen:continue
    pc=v(r,'senderProgramCounter')
    try: pc=int(pc,0) if isinstance(pc,str) else int(pc)
    except:pc=-1
    rows.append((str(v(r,'timestamp') or ''),pid(r),gen,pc,str(v(r,'eventMessage','message') or '').replace('\n','\\n')))
by=collections.defaultdict(list)
for x in rows:by[x[1]].append(x)
for p in by:by[p].sort()
print('GOLDEN_BOOT3M_EXACT_GENERATION_ROW_COUNT='+str(len(rows)))
print('GOLDEN_BOOT3M_EXACT_GENERATION_PID_COUNT='+str(len(by)))
for p in sorted(by):
    rs=by[p]; gens=sorted(set(x[2] for x in rs)); pcs=collections.Counter(x[3] for x in rs)
    print(f'BOOT_PID_LANE|PID={p}|GENERATIONS={",".join(gens)}|COUNT={len(rs)}|PC_COUNTS='+';'.join(f'0x{k:X}:{n}' for k,n in sorted(pcs.items())))
    # compact sequence with run-length encoding
    seq=[]
    for x in rs:
        token=f'{x[2]}:0x{x[3]:X}'
        if seq and seq[-1][0]==token:seq[-1][1]+=1
        else:seq.append([token,1])
    print(f'BOOT_PID_LANE_RLE|PID={p}|SEQUENCE='+' > '.join(f'{t}x{n}' for t,n in seq))
print('TAHOE_D97AN_REFERENCE|32023=79|3802=0|PIDS=65|PC_0x9FFEE=7|PC_0xA0521=7|PC_0xA5F81=65')
print('D97AV_V2_BOOT_LANE_SEQUENCE_AUDIT=COMPLETE')
PY

echo
echo "===== GOLDEN METAL LLVMVERSION PRODUCER STATIC CONTEXT ====="
if [[ -s "$METAL_OTOOL" ]]; then
  /usr/bin/strings -a -t x "$METAL" | /usr/bin/grep -i 'llvmVersion' || true
  "$PYTHON" - "$METAL_OTOOL" "$METAL_NM" <<'PY'
import re,sys
from pathlib import Path
ot=Path(sys.argv[1]); nm=Path(sys.argv[2]); rx=re.compile(r'^\s*([0-9A-Fa-f]+)\s+(.+?)\s*$'); ins=[]
for ln in ot.read_text(errors='replace').splitlines():
    m=rx.match(ln)
    if not m:continue
    try:a=int(m.group(1),16)
    except:continue
    b=m.group(2).strip()
    if b:ins.append((a,b))
sy=[]
for ln in nm.read_text(errors='replace').splitlines() if nm.exists() else []:
    m=re.match(r'^\s*([0-9A-Fa-f]{6,16})\s+(.+)$',ln)
    if m:
        try:sy.append((int(m.group(1),16),m.group(2).strip()))
        except:pass
sy.sort()
def owner(a):
    p=[x for x in sy if x[0]<=a];return p[-1][1] if p else 'UNKNOWN'
idx=[i for i,(a,b) in enumerate(ins) if 'llvmVersion' in b]
print('VISIBLE_METAL_LLVMVERSION_ANNOTATED_XREF_COUNT='+str(len(idx)))
for i in idx:
    a,b=ins[i];print(f'VISIBLE_METAL_LLVMVERSION_XREF|VM=0x{a:X}|SYMBOL={owner(a)}|TEXT={b}')
    for aa,bb in ins[max(0,i-50):min(len(ins),i+51)]:
        mark=[]; low=bb.lower()
        if 'xpc_dictionary_set_uint64' in low:mark.append('XPC_SET_U64')
        if '0xeda' in low:mark.append('IMM_3802')
        if '0x7d17' in low:mark.append('IMM_32023')
        if '0x7919' in low:mark.append('IMM_31001')
        if mark: print(f'VISIBLE_METAL_PRODUCER_MARK|XREF_VM=0x{a:X}|VM=0x{aa:X}|MARK={",".join(mark)}|SYMBOL={owner(aa)}|TEXT={bb}')
print('D97AV_V2_VISIBLE_METAL_LLVMVERSION_STATIC_SCAN=COMPLETE')
PY
else
  echo "VISIBLE_METAL_STATIC_SCAN=UNAVAILABLE_OR_EMPTY"
fi

echo
echo "===== CAUSAL DISCIPLINE / NEXT-TEST DESIGN ====="
echo "BOOT_ALIGNED_GOLDEN_TAHOE_GENERATION_DIVERGENCE=RETAINED_RUNTIME_PROVEN_OBSERVED_NOT_CAUSAL"
echo "BOOT_ALIGNED_GOLDEN_TAHOE_32023_LANE_DIVERGENCE=RETAINED_RUNTIME_PROVEN_OBSERVED_NOT_CAUSAL"
echo "P1_ONLY_PATCH_WITH_DIRECT_PRE_DLOPEN_GENERATION_SELECTION_INFLUENCE=YES"
echo "P2B_P3_AIR00_D34_P6_P7_DIRECT_3802_VS_32023_SELECTION_INFLUENCE=NO_ALREADY_INSIDE_32023"
echo "P6_P7_INTERNAL_32023_LANE_INFLUENCE=POSSIBLE_REQUIRES_STATIC_SYMBOL_RESULT_AND_TARGETED_ABLATION"
echo "SEVEN_SEPARATE_REBOOTS_AUTHORIZED=NO"
echo "TARGETED_ABLATION_DESIGN=ONLY_AFTER_THIS_STATIC_MAP_IS_AUDITED"
echo "D97AS_LATE_CLASSIFIER_STATUS=RESERVE_NOT_CURRENT_FRONTIER"

echo
echo "===== FINAL LEDGER ====="
echo "SYSTEM_FILE_MUTATION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "EXPERIMENTAL_ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D97AV_V2_AUDIT=COMPLETE"
echo "REPORT=$OUT"
echo "JSON_REPORT=$JSON_OUT"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
