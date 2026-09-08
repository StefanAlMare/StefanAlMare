#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HW — read-only static map of the new P1+P3 accelerated
# simulator/bitcode compiler frontier.
# No Root Patch, no restore, no EFI/NVRAM/framebuffer mutation, no reboot.

EXPECTED_BUILD="25G82"
EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P3_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"
EXPECTED_P2_BYTES="418b81d0000000"
EXPECTED_P3_BYTES="81c900002000"
P2_OFF=$((0x9A8CD))
P3_OFF=$((0xA1573))

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HW_P3_SIMULATOR_BITCODE_STATIC_MAP_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97HW_P3_SIMULATOR_BITCODE_STATIC_MAP_${STAMP}.zip"
mkdir -p "$OUT"
REPORT="$OUT/D97HW_REPORT.txt"
exec > >(tee "$REPORT") 2>&1

fail(){
  echo "D97HW_STATUS=FAIL"
  echo "D97HW_REASON=$*"
  echo "D97HW_REPORT=$REPORT"
  exit 1
}
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
hex_at(){
  local file="$1" off="$2" count="$3"
  /bin/dd if="$file" bs=1 skip="$off" count="$count" 2>/dev/null | /usr/bin/xxd -p | /usr/bin/tr -d '\n'
}

cat <<'HDR'
===== OCLP7 D97HW — P3 SIMULATOR/BITCODE STATIC MAP =====
READ_ONLY=YES
ROOT_PATCH=NO
RESTORE=NO
SYSTEM_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
ACCELERATION_CHANGE=NO
REBOOT=NO
P2B_REPLAY=NO
AIR00_REPLAY=NO
D34_REPLAY=NO
EVIDENCE_WRITE=DESKTOP_ONLY
HDR

[[ "$(uname -s)" == "Darwin" ]] || fail NOT_DARWIN
[[ "$(uname -m)" == "x86_64" ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "$EXPECTED_BUILD" ]] || fail NOT_25G82
[[ -f "$SERVICE" ]] || fail SERVICE_MISSING
[[ -f "$COMPILER" ]] || fail COMPILER_32023_MISSING
/usr/bin/sw_vers

printf '\n===== RUNTIME IDENTITY BINDING =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HW_BOOTARGS=$BOOTARGS"
SERVICE_SHA="$(sha256 "$SERVICE")"
COMPILER_SHA="$(sha256 "$COMPILER")"
echo "D97HW_ACTIVE_SERVICE_SHA256=$SERVICE_SHA"
echo "D97HW_ACTIVE_COMPILER_SHA256=$COMPILER_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_P1_SHA" ]] || fail ACTIVE_P1_IDENTITY_MISMATCH
[[ "$COMPILER_SHA" == "$EXPECTED_P3_SHA" ]] || fail ACTIVE_P3_IDENTITY_MISMATCH
P2_BYTES="$(hex_at "$COMPILER" "$P2_OFF" 7)"
P3_BYTES="$(hex_at "$COMPILER" "$P3_OFF" 6)"
echo "D97HW_P2_OFFSET=0x9a8cd"
echo "D97HW_P2_CURRENT=$P2_BYTES"
echo "D97HW_P3_OFFSET=0xa1573"
echo "D97HW_P3_CURRENT=$P3_BYTES"
[[ "$P2_BYTES" == "$EXPECTED_P2_BYTES" ]] || fail P2_NOT_ORIGINAL_D0
[[ "$P3_BYTES" == "$EXPECTED_P3_BYTES" ]] || fail P3_POSTIMAGE_MISMATCH
echo "D97HW_ACTIVE_P1_P3_BINDING=PASS"
echo "D97HW_P2_STATE=ORIGINAL_D0_NO_P2B"
echo "D97HW_P3_STATE=EXACT_SERIALIZED_BITCODE_POSTIMAGE"

printf '\n===== MACH-O / STRING / RIP-RELATIVE XREF MAP =====\n'
/usr/bin/python3 - "$COMPILER" "$OUT" "$P2_OFF" "$P3_OFF" <<'PY'
from pathlib import Path
import sys, struct, re

path=Path(sys.argv[1]); out=Path(sys.argv[2]); p2off=int(sys.argv[3]); p3off=int(sys.argv[4])
data=path.read_bytes()

if len(data) < 32:
    raise SystemExit('D97HW_PY_FAIL=SHORT_MACHO')
magic=struct.unpack_from('<I',data,0)[0]
if magic != 0xfeedfacf:
    raise SystemExit(f'D97HW_PY_FAIL=UNEXPECTED_MAGIC_0x{magic:x}')
header=struct.unpack_from('<IiiIIIII',data,0)
ncmds=header[4]
cmd_off=32
segments=[]; sections=[]
for _ in range(ncmds):
    if cmd_off+8 > len(data): break
    cmd,cmdsize=struct.unpack_from('<II',data,cmd_off)
    if cmdsize < 8 or cmd_off+cmdsize > len(data): break
    if cmd == 0x19 and cmdsize >= 72: # LC_SEGMENT_64
        vals=struct.unpack_from('<II16sQQQQiiII',data,cmd_off)
        _,_,segraw,vmaddr,vmsize,fileoff,filesize,maxprot,initprot,nsects,flags=vals
        segname=segraw.split(b'\0',1)[0].decode('ascii','replace')
        segments.append((segname,vmaddr,vmsize,fileoff,filesize))
        so=cmd_off+72
        for i in range(nsects):
            if so+80 > cmd_off+cmdsize: break
            sv=struct.unpack_from('<16s16sQQIIIIIIII',data,so)
            sect=sv[0].split(b'\0',1)[0].decode('ascii','replace')
            sseg=sv[1].split(b'\0',1)[0].decode('ascii','replace')
            addr,size,offset=sv[2],sv[3],sv[4]
            sections.append((sseg,sect,addr,size,offset))
            so += 80
    cmd_off += cmdsize

with (out/'macho_segments.tsv').open('w') as f:
    f.write('SEGMENT\tVMADDR\tVMSIZE\tFILEOFF\tFILESIZE\n')
    for r in segments:
        f.write(f'{r[0]}\t0x{r[1]:x}\t0x{r[2]:x}\t0x{r[3]:x}\t0x{r[4]:x}\n')
with (out/'macho_sections.tsv').open('w') as f:
    f.write('SEGMENT\tSECTION\tADDR\tSIZE\tOFFSET\n')
    for r in sections:
        f.write(f'{r[0]}\t{r[1]}\t0x{r[2]:x}\t0x{r[3]:x}\t0x{r[4]:x}\n')

def off_to_va(off):
    for seg,vm,vmsz,fo,fsz in segments:
        if fo <= off < fo+fsz:
            return vm + (off-fo)
    return None

def off_section(off):
    for seg,sect,addr,size,fo in sections:
        if fo <= off < fo+size:
            return seg,sect,addr+(off-fo)
    return ('?','?',off_to_va(off))

p2va=off_to_va(p2off); p3va=off_to_va(p3off)
print('D97HW_P2_VA='+('UNKNOWN' if p2va is None else f'0x{p2va:x}'))
print('D97HW_P3_VA='+('UNKNOWN' if p3va is None else f'0x{p3va:x}'))

# Extract printable ASCII runs and retain only relevant compiler diagnostics/symbol-like strings.
tokens=('simulator','bitcode','validsimulatormetadata','mtlsimcompiler')
strings=[]
for m in re.finditer(rb'[\x20-\x7e]{4,}',data):
    raw=m.group(0)
    low=raw.lower()
    if not any(t.encode() in low for t in tokens):
        continue
    off=m.start(); seg,sect,va=off_section(off)
    text=raw.decode('ascii','replace')
    strings.append((off,va,seg,sect,text,len(raw)))

with (out/'matched_strings.tsv').open('w') as f:
    f.write('FILE_OFFSET\tVA\tSEGMENT\tSECTION\tBYTES\tSTRING\n')
    for off,va,seg,sect,text,n in strings:
        safe=text.replace('\t','\\t').replace('\n','\\n')
        f.write(f'0x{off:x}\t'+('UNKNOWN' if va is None else f'0x{va:x}')+f'\t{seg}\t{sect}\t{n}\t{safe}\n')

print(f'D97HW_RELEVANT_STRING_COUNT={len(strings)}')
for off,va,seg,sect,text,n in strings:
    print('D97HW_STRING='+f'fileoff=0x{off:x} va='+('UNKNOWN' if va is None else f'0x{va:x}')+f' {seg},{sect} :: {text}')

# Map common x86_64 RIP-relative LEA/MOV references to the matched ASCII ranges.
# This is deliberately bounded to common RIP-relative forms; absence is not proof of no xref.
intervals=[]
for off,va,seg,sect,text,n in strings:
    if va is not None:
        intervals.append((va,va+n,text,off))

xrefs=[]
def check(ins_off,disp_off,ins_len,kind):
    if disp_off+4 > len(data): return
    iva=off_to_va(ins_off)
    if iva is None: return
    disp=struct.unpack_from('<i',data,disp_off)[0]
    target=iva+ins_len+disp
    for lo,hi,text,stroff in intervals:
        if lo <= target < hi:
            xrefs.append((ins_off,iva,target,kind,stroff,text))

for i in range(0,len(data)-7):
    # REX + LEA/MOV r64, [RIP+disp32]
    if 0x40 <= data[i] <= 0x4f and data[i+1] in (0x8d,0x8b):
        modrm=data[i+2]
        if (modrm & 0xc7) == 0x05:
            check(i,i+3,7,'REX_'+('LEA' if data[i+1]==0x8d else 'MOV'))
    # LEA/MOV r32, [RIP+disp32]
    if data[i] in (0x8d,0x8b):
        modrm=data[i+1]
        if (modrm & 0xc7) == 0x05:
            check(i,i+2,6,'LEA32' if data[i]==0x8d else 'MOV32')

# dedupe
seen=set(); uniq=[]
for r in xrefs:
    key=(r[0],r[2],r[4])
    if key in seen: continue
    seen.add(key); uniq.append(r)

with (out/'rip_relative_string_xrefs.tsv').open('w') as f:
    f.write('INSTR_FILE_OFFSET\tINSTR_VA\tTARGET_VA\tFORM\tSTRING_FILE_OFFSET\tSTRING\n')
    for ins,iva,tgt,kind,stroff,text in uniq:
        safe=text.replace('\t','\\t').replace('\n','\\n')
        f.write(f'0x{ins:x}\t0x{iva:x}\t0x{tgt:x}\t{kind}\t0x{stroff:x}\t{safe}\n')
print(f'D97HW_RIPREL_RELEVANT_XREF_COUNT={len(uniq)}')
for ins,iva,tgt,kind,stroff,text in uniq:
    print(f'D97HW_XREF=ins_fileoff=0x{ins:x} ins_va=0x{iva:x} target_va=0x{tgt:x} {kind} :: {text}')
PY

printf '\n===== MACH-O DEPENDENCIES / LOAD COMMANDS =====\n'
/usr/bin/otool -L "$COMPILER" > "$OUT/otool_L.txt" 2>&1 || true
/usr/bin/otool -l "$COMPILER" > "$OUT/otool_load_commands.txt" 2>&1 || true
/bin/cat "$OUT/otool_L.txt" || true

printf '\n===== SYMBOL INVENTORY =====\n'
/usr/bin/nm -n -m "$COMPILER" > "$OUT/nm_all.txt" 2>&1 || true
/usr/bin/grep -Ei 'MTLSimCompiler|validSimulatorMetadata|simulator|bitcode|backendCompileModule|backendCompileExecutableRequest|MTLCompilerBuildRequestWithOptions' "$OUT/nm_all.txt" \
  > "$OUT/nm_relevant.txt" 2>/dev/null || true
/bin/cat "$OUT/nm_relevant.txt" 2>/dev/null || true
NM_REL="$(/usr/bin/wc -l < "$OUT/nm_relevant.txt" | /usr/bin/tr -d ' ')"
echo "D97HW_NM_RELEVANT_LINES=$NM_REL"

printf '\n===== FULL DISASSEMBLY =====\n'
/usr/bin/otool -tvV "$COMPILER" > "$OUT/otool_disassembly.txt" 2>&1 || fail OTOOL_DISASSEMBLY_FAILED
DIS_LINES="$(/usr/bin/wc -l < "$OUT/otool_disassembly.txt" | /usr/bin/tr -d ' ')"
echo "D97HW_DISASSEMBLY_LINES=$DIS_LINES"
/usr/bin/grep -n -Ei 'MTLSimCompiler|validSimulatorMetadata|simulator|bitcode|backendCompileModule|backendCompileExecutableRequest|MTLCompilerBuildRequestWithOptions' "$OUT/otool_disassembly.txt" \
  > "$OUT/disassembly_keyword_hits.txt" 2>/dev/null || true
/bin/cat "$OUT/disassembly_keyword_hits.txt" 2>/dev/null || true

printf '\n===== DISASSEMBLY CONTEXT AROUND STRING XREFS / P2 / P3 =====\n'
/usr/bin/python3 - "$OUT/otool_disassembly.txt" "$OUT/rip_relative_string_xrefs.tsv" "$OUT/macho_segments.tsv" "$P2_OFF" "$P3_OFF" "$OUT/disassembly_contexts.txt" <<'PY'
from pathlib import Path
import sys,re

dis=Path(sys.argv[1]); xref=Path(sys.argv[2]); segfile=Path(sys.argv[3]); p2off=int(sys.argv[4]); p3off=int(sys.argv[5]); out=Path(sys.argv[6])
lines=dis.read_text(errors='replace').splitlines()
addr=[]
for i,l in enumerate(lines):
    m=re.match(r'^([0-9a-fA-F]{8,16})\s',l)
    if m:
        try: addr.append((int(m.group(1),16),i))
        except: pass

def off_to_va(off):
    rows=segfile.read_text(errors='replace').splitlines()[1:]
    for r in rows:
        p=r.split('\t')
        if len(p)<5: continue
        vm=int(p[1],16); fo=int(p[3],16); fs=int(p[4],16)
        if fo <= off < fo+fs: return vm+(off-fo)
    return None

def nearest_idx(va):
    if va is None or not addr: return None
    best=min(addr,key=lambda x:abs(x[0]-va))
    return best[1]

targets=[]
for name,off in [('P2',p2off),('P3',p3off)]:
    va=off_to_va(off); idx=nearest_idx(va)
    targets.append((name,va,idx,'offset map'))
if xref.exists():
    for r in xref.read_text(errors='replace').splitlines()[1:]:
        p=r.split('\t')
        if len(p)<6: continue
        try: va=int(p[1],16)
        except: continue
        idx=nearest_idx(va)
        targets.append(('STRING_XREF',va,idx,p[5][:180]))
# keyword hits are useful even when otool itself resolves cstring comments.
for i,l in enumerate(lines):
    if re.search(r'MTLSimCompiler|validSimulatorMetadata|simulator|bitcode',l,re.I):
        m=re.match(r'^([0-9a-fA-F]{8,16})\s',l)
        va=int(m.group(1),16) if m else None
        targets.append(('KEYWORD_HIT',va,i,l[:180]))
# dedupe by line index/name class
seen=set(); clean=[]
for t in targets:
    key=(t[0],t[2])
    if t[2] is None or key in seen: continue
    seen.add(key); clean.append(t)
with out.open('w') as f:
    for name,va,idx,desc in clean:
        f.write('\n===== '+name+' '+('VA=UNKNOWN' if va is None else f'VA=0x{va:x}')+' :: '+desc+' =====\n')
        lo=max(0,idx-28); hi=min(len(lines),idx+29)
        for j in range(lo,hi): f.write(lines[j]+'\n')
print('D97HW_DISASSEMBLY_CONTEXT_COUNT='+str(len(clean)))
PY
/bin/cat "$OUT/disassembly_contexts.txt" 2>/dev/null || true

printf '\n===== RELATIONSHIP SUMMARY =====\n'
/usr/bin/python3 - "$OUT/rip_relative_string_xrefs.tsv" "$P2_OFF" "$P3_OFF" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); p2=int(sys.argv[2]); p3=int(sys.argv[3])
rows=[]
if p.exists():
    for r in p.read_text(errors='replace').splitlines()[1:]:
        q=r.split('\t')
        if len(q)<6: continue
        try: off=int(q[0],16)
        except: continue
        rows.append((off,q[5]))
print('D97HW_P2_FILE_OFFSET=0x%x'%p2)
print('D97HW_P3_FILE_OFFSET=0x%x'%p3)
if not rows:
    print('D97HW_XREF_DISTANCE_CLASSIFICATION=INCONCLUSIVE_NO_COMMON_RIPREL_STRING_XREFS')
else:
    near=sorted(rows,key=lambda r:min(abs(r[0]-p2),abs(r[0]-p3)))
    for off,text in near[:12]:
        print('D97HW_XREF_DISTANCE=off=0x%x delta_p2=%+d delta_p3=%+d :: %s'%(off,off-p2,off-p3,text[:180]))
    print('D97HW_XREF_DISTANCE_CLASSIFICATION=STATIC_DISTANCE_MAP_COMPLETE')
PY

printf '\n===== PACKAGE =====\n'
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
ZIP_SHA="$(sha256 "$ZIP")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97HW_ZIP=$ZIP"
echo "D97HW_ZIP_SHA256=$ZIP_SHA"
echo "D97HW_ZIP_BYTES=$ZIP_BYTES"
echo "D97HW_STATUS=PASS_READONLY_STATIC_COLLECTION"
echo "D97HW_CLASSIFICATION=STATIC_MAP_READY_FOR_CAUSAL_REVIEW"
echo "D97HW_P2B_AUTHORIZED=NO_PENDING_REVIEW"
echo "D97HW_ROOT_PATCH=NO"
echo "D97HW_REBOOT=NO"
echo "D97HW_REPORT=$REPORT"
