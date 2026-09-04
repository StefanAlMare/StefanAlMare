#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.8"
EXPECTED_OS_BUILD="24H22"
EXPECTED_32023_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_3802_SHA="85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40"
EXPECTED_SERVICE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
UUID_32023="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
UUID_3802="D5CE0007-FAD0-3468-A62E-A21995BCA9F5"
MTL32023="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
MTL3802="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler"
SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
REPORT="$HOME/Desktop/OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BA.XXXXXX)"

cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BA.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BA_AUDIT=FAIL_CLOSED|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "CACHE_MMAP=NO"; echo "CACHE_EXTRACTION=NO"; echo "PROCESS_DEBUG_ATTACH=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
for t in /usr/bin/shasum /usr/bin/log /usr/sbin/sysctl /usr/sbin/system_profiler /usr/bin/kmutil; do [[ -x "$t" ]] || fail "MISSING_TOOL:$t"; done
for p in "$MTL32023" "$MTL3802" "$SERVICE"; do [[ -f "$p" ]] || fail "MISSING_INPUT:$p"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97BA — GOLDEN SEQUOIA 15.8 PRODUCER REBASE ====="
echo "PURPOSE=rebase_G1_G3_after_Sequoia_15.7.9_to_15.8_update_while_proving_original_OCLP_donor_identity_unchanged"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "PERSISTENT_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

OSV="$(/usr/bin/sw_vers -productVersion)"
OSB="$(/usr/bin/sw_vers -buildVersion)"
SHA32="$(/usr/bin/shasum -a 256 "$MTL32023" | /usr/bin/awk '{print $1}')"
SHA38="$(/usr/bin/shasum -a 256 "$MTL3802" | /usr/bin/awk '{print $1}')"
SHASVC="$(/usr/bin/shasum -a 256 "$SERVICE" | /usr/bin/awk '{print $1}')"
echo "OS_VERSION=$OSV"
echo "OS_BUILD=$OSB"
echo "GOLDEN_32023_SHA256=$SHA32"
echo "GOLDEN_3802_SHA256=$SHA38"
echo "GOLDEN_SERVICE_SHA256=$SHASVC"
[[ "$OSV" == "$EXPECTED_OS_VERSION" && "$OSB" == "$EXPECTED_OS_BUILD" ]] || fail "GOLDEN_15_8_OS_IDENTITY"
[[ "$SHA32" == "$EXPECTED_32023_SHA" ]] || fail "GOLDEN_32023_IDENTITY_CHANGED"
[[ "$SHA38" == "$EXPECTED_3802_SHA" ]] || fail "GOLDEN_3802_IDENTITY_CHANGED"
[[ "$SHASVC" == "$EXPECTED_SERVICE_SHA" ]] || fail "GOLDEN_SERVICE_IDENTITY_CHANGED"
echo "D97BA_ORIGINAL_OCLP_DONOR_IDENTITY=PASS_UNCHANGED_FROM_15_7_9"

BOOT_RAW="$(/usr/sbin/sysctl -n kern.boottime 2>/dev/null || true)"
BOOT_EPOCH="$("$PYTHON" - "$BOOT_RAW" <<'PY'
import re,sys
m=re.search(r'(?<!u)\bsec\s*=\s*(\d+)',sys.argv[1])
if not m: raise SystemExit('BOOT_EPOCH_PARSE_FAIL:'+sys.argv[1])
print(m.group(1))
PY
)"
BOOT_START="$("$PYTHON" - "$BOOT_EPOCH" <<'PY'
import datetime,sys
print(datetime.datetime.fromtimestamp(int(sys.argv[1])).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
BOOT_END="$("$PYTHON" - "$BOOT_EPOCH" <<'PY'
import datetime,sys
print(datetime.datetime.fromtimestamp(int(sys.argv[1])+180).strftime('%Y-%m-%d %H:%M:%S'))
PY
)"
echo "KERN_BOOTTIME_RAW=$BOOT_RAW"
echo "BOOT3M_START=$BOOT_START"
echo "BOOT3M_END=$BOOT_END"

MTL_JSON="$TMP/mtl_boot3m.json"
WS_LOG="$TMP/ws_boot3m.log"
/usr/bin/log show --start "$BOOT_START" --end "$BOOT_END" --timezone local --style json --info --debug --predicate 'process == "MTLCompilerService"' > "$MTL_JSON" 2>/dev/null || true
/usr/bin/log show --start "$BOOT_START" --end "$BOOT_END" --timezone local --style compact --info --debug --predicate '(process == "WindowServer") OR (eventMessage CONTAINS[c] "AppleIntelHD5000") OR (eventMessage CONTAINS[c] "Azul") OR (eventMessage CONTAINS[c] "Metal compositor activated") OR (eventMessage CONTAINS[c] "IOGPU")' > "$WS_LOG" 2>/dev/null || true

/usr/sbin/system_profiler SPDisplaysDataType 2>/dev/null | /usr/bin/sed -n '1,160p' || true
/usr/bin/kmutil showloaded 2>/dev/null | /usr/bin/grep -Ei 'AppleIntelFramebufferAzul|AppleIntelHD5000Graphics' || true

echo "===== BOOT3M POSITIVE-CORRIDOR LOG HIGHLIGHTS ====="
/usr/bin/grep -Ei 'Metal compositor activated|AppleIntelHD5000|Azul|IOGPU|MTLCompilerService|shader|compile' "$WS_LOG" | /usr/bin/head -240 || true

"$PYTHON" - "$MTL_JSON" "$JSON_REPORT" "$UUID_32023" "$UUID_3802" <<'PY'
from __future__ import annotations
import bisect,collections,datetime,hashlib,json,os,re,struct,sys
from pathlib import Path

MTLJ=Path(sys.argv[1]); JOUT=Path(sys.argv[2]); UUID32=sys.argv[3].upper(); UUID38=sys.argv[4].upper()
KEYS=[b'requestType',b'sandboxTokens',b'llvmVersion',b'pluginPath',b'targetData',b'data',b'client_name',b'APISpecifiedTimeoutInSeconds']
KEY_NAMES=[k.decode() for k in KEYS]
METAL_SUFFIX='/System/Library/Frameworks/Metal.framework/Versions/A/Metal'
SEARCH_DIRS=[Path('/System/Library/dyld'),Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),Path('/System/Cryptexes/OS/System/Library/dyld'),Path('/private/preboot/Cryptexes/OS/System/Library/dyld')]
OLD_PRIMARY={'llvmVersion':0x2D81F,'requestType':0x2D832,'sandboxTokens':0x2D914,'targetData':0x2D939,'data':0x2D95E,'pluginPath':0x2D97F,'client_name':0x2D9FD,'APISpecifiedTimeoutInSeconds':0x2DA13}
OLD_ALT={'requestType':[0x1089E1],'data':[0xDB881]}

def out(s=''):print(s,flush=True)
def u32(b,o):return struct.unpack_from('<I',b,o)[0]
def u64(b,o):return struct.unpack_from('<Q',b,o)[0]
def pread(fd,n,o):return os.pread(fd,n,o)
def read_cstr(fd,size,off,limit=16384):
    if off<0 or off>=size:return None
    b=pread(fd,min(limit,size-off),off); z=b.find(b'\0')
    return None if z<0 else b[:z].decode('utf-8','replace')

# Locate valid cache files + image catalogs dynamically.
files=[];seen=set()
for d in SEARCH_DIRS:
    if not d.is_dir():continue
    for p in sorted(d.iterdir(),key=lambda x:x.name):
        if not p.name.startswith('dyld_shared_cache_'):continue
        try:
            st=p.stat(); ident=(st.st_dev,st.st_ino)
            if not p.is_file() or ident in seen:continue
            seen.add(ident);files.append((p,st.st_size))
        except:pass
files.sort(key=lambda x:str(x[0]))
recs=[]
for p,size in files:
    fd=None
    try:
        fd=os.open(str(p),os.O_RDONLY);h=pread(fd,min(size,0x300),0)
        if len(h)<0x98:continue
        magic=h[:16].rstrip(b'\0').decode('ascii','replace');mo=u32(h,0x10);mc=u32(h,0x14);ito=u64(h,0x88);itc=u64(h,0x90)
        if not magic.startswith('dyld_') or not (0<mc<=4096) or mo+mc*32>size:continue
        raw=pread(fd,mc*32,mo)
        if len(raw)!=mc*32:continue
        maps=[]
        for i in range(mc):
            vm,sz,fo,maxp,initp=struct.unpack_from('<QQQII',raw,i*32);maps.append((vm,vm+sz,fo,fo+sz,maxp,initp))
        recs.append({'path':p,'size':size,'maps':maps,'ito':ito,'itc':itc})
    finally:
        if fd is not None:os.close(fd)
if not recs:raise SystemExit('NO_VALID_CACHE_HEADERS')

images=[]
for rec in recs:
    p,size,cnt,off=rec['path'],rec['size'],rec['itc'],rec['ito']
    if cnt==0 or cnt>200000 or off+cnt*32>size:continue
    fd=os.open(str(p),os.O_RDONLY)
    try:
        raw=pread(fd,cnt*32,off)
        if len(raw)!=cnt*32:continue
        for i in range(cnt):
            q=i*32;load=u64(raw,q+16);ts=u32(raw,q+24);po=u32(raw,q+28)
            if not ts:continue
            path=read_cstr(fd,size,po)
            if path:images.append((load,load+ts,path))
    finally:os.close(fd)
images=sorted(set(images))
metal=[x for x in images if x[2].endswith(METAL_SUFFIX)]
out('\n===== SEQUOIA 15.8 METAL SHARED-CACHE PRODUCER =====')
out(f'METAL_IMAGE_RECORD_COUNT={len(metal)}')
for s,e,p in metal:out(f'METAL_IMAGE|TEXT_START=0x{s:X}|TEXT_END=0x{e:X}|SIZE=0x{e-s:X}|PATH={p}')
if len(metal)!=1:raise SystemExit('METAL_IMAGE_CARDINALITY:'+str(len(metal)))
MS,ME,MP=metal[0]

def vm_loc(vm):
    for rec in recs:
        for vs,ve,fs,fe,mp,ip in rec['maps']:
            if vs<=vm<ve:return rec,fs+(vm-vs)
    return None,None
rec,fo0=vm_loc(MS);rec2,foe=vm_loc(ME-1)
if rec is None or rec2 is None or rec['path']!=rec2['path']:raise SystemExit('METAL_TEXT_NOT_SINGLE_CACHE_MAPPING')
fo1=foe+1;fd=os.open(str(rec['path']),os.O_RDONLY)
try:raw=pread(fd,fo1-fo0,fo0)
finally:os.close(fd)
if len(raw)!=ME-MS:raise SystemExit('METAL_TEXT_SHORT_READ')
text_sha=hashlib.sha256(raw).hexdigest()
out(f'METAL_TEXT_CACHE_FILE={rec["path"]}')
out(f'METAL_TEXT_SHA256={text_sha}')

# Exact key strings within Metal image, then exact RIP-relative LEA xrefs to those VMs.
hits={k.decode():[] for k in KEYS}
for key in KEYS:
    st=0
    while True:
        q=raw.find(key,st)
        if q<0:break
        hits[key.decode()].append(MS+q);st=q+1
for k in KEY_NAMES:
    vals=hits[k]
    out(f'METAL_KEY_STRING_HITS|KEY={k}|COUNT={len(vals)}'+('' if not vals else '|FIRST=0x%X|LAST=0x%X'%(vals[0],vals[-1])))

xref={k:[] for k in KEY_NAMES};targets={k:set(v) for k,v in hits.items()}
for i in range(0,max(0,len(raw)-7)):
    rex=raw[i]
    if not (0x48<=rex<=0x4F) or raw[i+1]!=0x8D:continue
    modrm=raw[i+2]
    if (modrm&0xC7)!=0x05:continue
    disp=struct.unpack_from('<i',raw,i+3)[0];vm=MS+i;target=vm+7+disp
    for k,ts in targets.items():
        if target in ts:
            reg=((modrm>>3)&7)|(((rex>>2)&1)<<3);regs=['rax','rcx','rdx','rbx','rsp','rbp','rsi','rdi','r8','r9','r10','r11','r12','r13','r14','r15']
            xref[k].append({'vm':vm,'offset':vm-MS,'target':target,'dst':regs[reg]})
for k in KEY_NAMES:
    for r in xref[k]:out(f'METAL_KEY_XREF|KEY={k}|VM=0x{r["vm"]:X}|OFFSET=0x{r["offset"]:X}|TARGET=0x{r["target"]:X}|DST={r["dst"]}')
    out(f'METAL_KEY_XREF_SUMMARY|KEY={k}|COUNT={len(xref[k])}')

# Compare only xref offsets, not absolute addresses, with 15.7.9 snapshot.
primary_now={}
for k,old in OLD_PRIMARY.items():
    offs=sorted(r['offset'] for r in xref[k])
    primary_now[k]=old if old in offs else (offs[0] if len(offs)==1 else None)
    out(f'OLD15_7_9_PRIMARY_OFFSET_COMPARE|KEY={k}|OLD=0x{old:X}|NOW_OFFSETS={",".join("0x%X"%x for x in offs)}|OLD_OFFSET_PRESENT={"YES" if old in offs else "NO"}')
all_primary_same=all(OLD_PRIMARY[k] in [r['offset'] for r in xref[k]] for k in OLD_PRIMARY)
out(f'SEQUOIA_15_8_PRIMARY_EIGHT_KEY_OFFSETS_MATCH_15_7_9={"YES" if all_primary_same else "NO"}')
for k,olds in OLD_ALT.items():
    offs=sorted(r['offset'] for r in xref[k]);out(f'OLD15_7_9_ALT_OFFSET_COMPARE|KEY={k}|OLD={",".join("0x%X"%x for x in olds)}|NOW={",".join("0x%X"%x for x in offs)}')

# Boot3m runtime lane census from exact sender UUIDs.
def records(path):
    t=path.read_text(errors='replace').strip()
    if not t:return []
    try:
        x=json.loads(t);return x if isinstance(x,list) else [x]
    except:pass
    a=[]
    for ln in t.splitlines():
        try:a.append(json.loads(ln))
        except:pass
    return a

def v(r,*names):
    for n in names:
        if n in r:return r[n]
    return None
recj=records(MTLJ);rows=[]
for r in recj:
    uu=str(v(r,'senderImageUUID') or '').upper();gen='32023' if uu==UUID32 else ('3802' if uu==UUID38 else 'OTHER')
    pc=v(r,'senderProgramCounter')
    try:pc=int(pc,0) if isinstance(pc,str) else int(pc)
    except:pc=-1
    pid=v(r,'processIdentifier','pid')
    rows.append({'timestamp':str(v(r,'timestamp') or ''),'pid':pid,'gen':gen,'uuid':uu,'path':str(v(r,'senderImagePath') or ''),'pc':pc,'msg':str(v(r,'eventMessage','message') or '').replace('\n','\\n')})
cnt=collections.Counter(r['gen'] for r in rows);pcs=collections.Counter((r['gen'],r['pc']) for r in rows if r['pc']>=0);pids=collections.defaultdict(set)
for r in rows:pids[r['gen']].add(r['pid'])
out('\n===== SEQUOIA 15.8 BOOT3M RUNTIME LANE =====')
out(f'BOOT3M_MTL_RECORDS={len(rows)}')
out(f'BOOT3M_32023={cnt["32023"]}')
out(f'BOOT3M_3802={cnt["3802"]}')
out(f'BOOT3M_OTHER={cnt["OTHER"]}')
out(f'BOOT3M_32023_PID_COUNT={len(pids["32023"])}')
out(f'BOOT3M_3802_PID_COUNT={len(pids["3802"])}')
for (g,pc),n in sorted(pcs.items()):
    if g in ('32023','3802'):out(f'BOOT3M_PC|GEN={g}|PC=0x{pc:X}|COUNT={n}')
dual=cnt['32023']>0 and cnt['3802']>0
out(f'SEQUOIA_15_8_BOOT3M_DUAL_GENERATION_OBSERVED={"YES" if dual else "NO"}')

result={'os':'15.8','build':'24H22','metal':{'start':MS,'end':ME,'cache_file':str(rec['path']),'text_sha256':text_sha,'key_hits':hits,'xrefs':xref,'primary_offsets_match_15_7_9':all_primary_same},'runtime_boot3m':{'records':len(rows),'counts':dict(cnt),'pc_counts':{f'{g}:0x{pc:X}':n for (g,pc),n in pcs.items()},'pids':{g:sorted(x for x in s if x is not None) for g,s in pids.items()},'dual_generation':dual}}
JOUT.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
out(f'JSON_REPORT={JOUT}')
out('\n===== D97BA CLASSIFICATION =====')
out('ORIGINAL_OCLP_DONOR_15_8_VS_15_7_9=BYTE_IDENTITY_PROVEN_FOR_32023_3802_SERVICE')
out('G1_SEQUOIA_15_8_METAL_PRODUCER_REBASE=STATIC_CENSUS_COMPLETE')
out('G1_SEQUOIA_15_8_BOOT3M_GENERATION_LANE=RUNTIME_OBSERVED')
out('G3_SEQUOIA_15_8_SUCCESS_CORRIDOR=CHECK_HIGHLIGHTS_FOR_METAL_COMPOSITOR_ACTIVATED')
out('D97BA_AUDIT=COMPLETE')
PY

echo "===== FINAL SUCCESS-CORRIDOR GATE ====="
if /usr/bin/grep -qi 'Metal compositor activated' "$WS_LOG"; then
  echo "SEQUOIA_15_8_METAL_COMPOSITOR_ACTIVATED=RUNTIME_OBSERVED"
else
  echo "SEQUOIA_15_8_METAL_COMPOSITOR_ACTIVATED=NOT_OBSERVED_IN_BOOT3M_LOG_CHANNEL"
fi

echo "REPORT=$REPORT"
echo "JSON_REPORT=$JSON_REPORT"
echo "SYSTEM_FILE_MUTATION=NO"
echo "CACHE_MMAP=NO"
echo "CACHE_EXTRACTION=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_REPORT_AND_JSON"
