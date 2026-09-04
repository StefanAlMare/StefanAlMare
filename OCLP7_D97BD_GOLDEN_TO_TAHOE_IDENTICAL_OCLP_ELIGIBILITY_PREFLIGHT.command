#!/bin/zsh -f
set -euo pipefail

EXPECTED_OS_VERSION="15.8"
EXPECTED_OS_BUILD="24H22"
REPORT="$HOME/Desktop/OCLP7_D97BD_GOLDEN_TO_TAHOE_IDENTICAL_OCLP_ELIGIBILITY_PREFLIGHT.txt"
JSON_REPORT="$HOME/Desktop/OCLP7_D97BD_GOLDEN_TO_TAHOE_IDENTICAL_OCLP_ELIGIBILITY_PREFLIGHT.json"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97BD.XXXXXX)"
cleanup(){ local rc=$?; trap - EXIT; [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97BD.* && -d "$TMP" ]] && /bin/rm -rf -- "$TMP" || true; exit "$rc"; }
trap cleanup EXIT
fail(){ echo "D97BD_AUDIT=FAIL_CLOSED|REASON=$1"; echo "SYSTEM_FILE_MUTATION=NO"; echo "SOURCE_MUTATION=NO"; echo "GIT_FETCH_CHECKOUT_RESET=NO"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit 2; }

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "MISSING_PYTHON3"
for t in /usr/bin/shasum /usr/bin/plutil /usr/bin/git /usr/bin/find /usr/bin/stat; do [[ -x "$t" ]] || fail "MISSING_TOOL:$t"; done

exec > >(/usr/bin/tee "$REPORT") 2>&1

echo "===== OCLP7 D97BD — GOLDEN -> TAHOE IDENTICAL-OCLP ELIGIBILITY PREFLIGHT ====="
echo "PURPOSE=prove_original_OCLP_identity_and_isolate_Tahoe_eligibility_only_gate_before_any_source_mutation"
echo "SYSTEM_FILE_MUTATION=NO"
echo "SOURCE_MUTATION=NO"
echo "GIT_FETCH_CHECKOUT_RESET=NO"
echo "PROCESS_DEBUG_ATTACH=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

OSV="$(/usr/bin/sw_vers -productVersion)"
OSB="$(/usr/bin/sw_vers -buildVersion)"
echo "OS_VERSION=$OSV"
echo "OS_BUILD=$OSB"
[[ "$OSV" == "$EXPECTED_OS_VERSION" && "$OSB" == "$EXPECTED_OS_BUILD" ]] || fail "NOT_GOLDEN_B"

echo "===== LOCAL VOLUME INVENTORY ====="
/bin/ls -la /Volumes 2>/dev/null || true

"$PYTHON" - "$JSON_REPORT" <<'PY'
from __future__ import annotations
import ast, hashlib, json, os, plistlib, re, stat, subprocess, sys
from pathlib import Path

JOUT=Path(sys.argv[1])

def out(s=''): print(s,flush=True)
def sha256_path(p:Path):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
def run(cmd,cwd=None,timeout=60):
    try:
        p=subprocess.run(cmd,cwd=cwd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=timeout)
        return p.returncode,p.stdout.rstrip('\n')
    except Exception as e:
        return -999, f'TOOL_ERROR:{type(e).__name__}:{e}'
def git(repo,*args): return run(['/usr/bin/git','-C',str(repo),*args],timeout=90)

def bundle_identity(app:Path):
    info=app/'Contents/Info.plist'
    d={'path':str(app),'exists':app.is_dir(),'info_plist':str(info)}
    if not info.is_file(): return d
    try: pl=plistlib.loads(info.read_bytes())
    except Exception as e: d['plist_error']=repr(e); return d
    for k in ('CFBundleIdentifier','CFBundleShortVersionString','CFBundleVersion','CFBundleExecutable'):
        d[k]=pl.get(k)
    exe=app/'Contents/MacOS'/str(pl.get('CFBundleExecutable') or '')
    d['executable']=str(exe); d['executable_exists']=exe.is_file()
    if exe.is_file(): d['executable_sha256']=sha256_path(exe); d['executable_bytes']=exe.stat().st_size
    d['info_sha256']=sha256_path(info)
    # Content-addressed manifest over regular files + symlink targets. Ignore only Finder metadata.
    rows=[]; file_count=0; total=0
    for root,dirs,files in os.walk(app,followlinks=False):
        dirs.sort(); files.sort()
        rp=Path(root)
        for name in files:
            p=rp/name; rel=str(p.relative_to(app))
            if name=='.DS_Store': continue
            try:
                if p.is_symlink():
                    rows.append(('L',rel,os.readlink(p))); continue
                if not p.is_file(): continue
                s=p.stat(); h=sha256_path(p); rows.append(('F',rel,str(s.st_size),h));file_count+=1;total+=s.st_size
            except Exception as e: rows.append(('E',rel,repr(e)))
    mh=hashlib.sha256()
    for row in rows: mh.update(('\0'.join(row)+'\n').encode('utf-8','surrogateescape'))
    d['bundle_manifest_sha256']=mh.hexdigest(); d['regular_file_count']=file_count; d['regular_file_bytes']=total
    return d

# Discover relevant OCLP app candidates without traversing whole disks.
app_candidates=[]
fixed=[
 Path('/Applications/OpenCore-Patcher.app'),
 Path.home()/'Applications/OpenCore-Patcher.app',
 Path('/Volumes/AsusLaptop/Applications/OpenCore-Patcher.app'),
 Path('/Volumes/AsusLaptop - Data/Applications/OpenCore-Patcher.app'),
]
for p in fixed:
    if p.is_dir() and p not in app_candidates: app_candidates.append(p)
# Also inspect top-level Applications on mounted volumes for exact app basename.
try:
    for v in Path('/Volumes').iterdir():
        for p in (v/'Applications/OpenCore-Patcher.app', v/'Users/alex/Applications/OpenCore-Patcher.app'):
            if p.is_dir() and p not in app_candidates: app_candidates.append(p)
except Exception: pass

out('\n===== OCLP APP IDENTITIES =====')
apps=[bundle_identity(p) for p in app_candidates]
for a in apps:
    out('OCLP_APP|'+ '|'.join(f'{k}={a.get(k)}' for k in ('path','CFBundleIdentifier','CFBundleShortVersionString','CFBundleVersion','CFBundleExecutable','executable_sha256','bundle_manifest_sha256','regular_file_count','regular_file_bytes')))
if not apps: out('OCLP_APP=NONE_FOUND_IN_BOUNDED_LOCATIONS')

# Classify current Golden vs mounted-Tahoe copies only by path; do not claim usage provenance from presence alone.
golden_apps=[a for a in apps if a['path'].startswith('/Applications/') or a['path'].startswith(str(Path.home()/'Applications'))]
tahoe_apps=[a for a in apps if a['path'].startswith('/Volumes/')]
for ga in golden_apps:
    for ta in tahoe_apps:
        same_exe=bool(ga.get('executable_sha256')) and ga.get('executable_sha256')==ta.get('executable_sha256')
        same_manifest=bool(ga.get('bundle_manifest_sha256')) and ga.get('bundle_manifest_sha256')==ta.get('bundle_manifest_sha256')
        out(f'OCLP_APP_COMPARE|GOLDEN={ga["path"]}|TAHOE={ta["path"]}|EXECUTABLE_IDENTICAL={"YES" if same_exe else "NO"}|BUNDLE_MANIFEST_IDENTICAL={"YES" if same_manifest else "NO"}')

# Canonical source candidates from project authority, plus bounded discovery.
source_candidates=[
 Path('/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82'),
 Path('/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82'),
 Path.home()/'Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82',
]
source=None
for p in source_candidates:
    if (p/'.git').exists() and (p/'opencore_legacy_patcher').is_dir(): source=p;break
out('\n===== CANONICAL SOURCE IDENTITY =====')
out(f'SOURCE_PATH={source if source else "NOT_FOUND"}')
source_info={}
if source:
    for label,args in [
        ('HEAD',['rev-parse','HEAD']),('BRANCH',['branch','--show-current']),('STATUS',['status','--porcelain=v1']),
        ('REMOTES',['remote','-v']),('LOG20',['log','--oneline','--decorate','-20']),
    ]:
        rc,txt=git(source,*args); source_info[label.lower()]={'rc':rc,'text':txt};out(f'GIT_{label}_RC={rc}');out(f'GIT_{label}<<EOF\n{txt}\nEOF')
    # Existing local remote refs only; no fetch.
    rc,refs=git(source,'for-each-ref','--format=%(refname:short) %(objectname)','refs/remotes');source_info['remote_refs']={'rc':rc,'text':refs};out(f'GIT_REMOTE_REFS_RC={rc}');out('GIT_REMOTE_REFS<<EOF\n'+refs+'\nEOF')
else:
    out('D97BD_SOURCE_SCAN=SKIPPED_SOURCE_NOT_FOUND')

# Golden installed Haswell/OCLP relevant component identity manifest.
out('\n===== GOLDEN INSTALLED OCLP/HASWELL COMPONENT IDENTITIES =====')
component_paths=[
 Path('/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler'),
 Path('/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/3802/MTLCompiler'),
 Path('/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService'),
 Path('/Library/Extensions/AppleIntelFramebufferAzul.kext/Contents/MacOS/AppleIntelFramebufferAzul'),
 Path('/Library/Extensions/AppleIntelHD5000Graphics.kext/Contents/MacOS/AppleIntelHD5000Graphics'),
 Path('/System/Library/Extensions/AppleIntelHD5000GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntelHD5000GraphicsMTLDriver'),
]
components=[]
for p in component_paths:
    row={'path':str(p),'exists':p.is_file()}
    if p.is_file(): row.update(bytes=p.stat().st_size,sha256=sha256_path(p))
    components.append(row);out('GOLDEN_COMPONENT|'+ '|'.join(f'{k}={row.get(k)}' for k in ('path','exists','bytes','sha256')))

# Read-only source influence census.
scan={}
if source:
    pkg=source/'opencore_legacy_patcher'
    text_files=[]
    for p in pkg.rglob('*.py'):
        if any(x in p.parts for x in ('__pycache__','build','dist','.venv','venv')): continue
        text_files.append(p)
    # Also datasets/resources Python outside package if present.
    for extra in (source/'data_sets', source/'datasets'):
        if extra.is_dir(): text_files.extend(extra.rglob('*.py'))
    text_files=sorted(set(text_files))
    eligibility_terms=[
        'max_os','min_os','unsupported','support_status','patching_possible','can_patch','root_patch','root patch',
        'detected_os','kernel_major','darwin','os_data','tahoe','sequoia','native_os','allow_patching','patch_allowed',
        'sip_enabled','secure_boot','authenticated_root','filevault','kdk','metallib'
    ]
    payload_terms=['haswell','appleintelhd5000','appleintelframebufferazul','mtlcompiler','3802','32023','metal_3802','merge','overwrite','remove','patchset']
    candidates=[]; payload_hits=[]
    for p in text_files:
        try: lines=p.read_text(encoding='utf-8',errors='replace').splitlines()
        except: continue
        rel=str(p.relative_to(source))
        for i,line in enumerate(lines,1):
            lo=line.lower()
            eh=[t for t in eligibility_terms if t in lo]
            ph=[t for t in payload_terms if t in lo]
            if eh:
                score=sum(4 if t in ('max_os','min_os','patching_possible','can_patch','allow_patching','patch_allowed') else 1 for t in eh)
                # prioritize actual condition/return/assignment lines
                if re.search(r'\b(if|elif|return|=|raise|not)\b',lo): score+=3
                candidates.append({'score':score,'file':rel,'line':i,'text':line.strip(),'terms':eh})
            if ph:
                payload_hits.append({'file':rel,'line':i,'text':line.strip(),'terms':ph})
    candidates.sort(key=lambda x:(-x['score'],x['file'],x['line']))
    out('\n===== ELIGIBILITY / OS-SUPPORT CANDIDATES (RANKED) =====')
    for r in candidates[:220]: out(f'ELIGIBILITY_CANDIDATE|SCORE={r["score"]}|FILE={r["file"]}|LINE={r["line"]}|TERMS={",".join(r["terms"])}|TEXT={r["text"]}')
    out(f'ELIGIBILITY_CANDIDATE_TOTAL={len(candidates)}')
    out('\n===== HASWELL / PAYLOAD / DONOR INFLUENCE HITS =====')
    for r in payload_hits[:260]: out(f'PAYLOAD_INFLUENCE|FILE={r["file"]}|LINE={r["line"]}|TERMS={",".join(r["terms"])}|TEXT={r["text"]}')
    out(f'PAYLOAD_INFLUENCE_TOTAL={len(payload_hits)}')

    # Exact source files with strongest candidate counts and hashes.
    cnt={}
    for r in candidates:cnt[r['file']]=cnt.get(r['file'],0)+1
    for r in payload_hits:cnt[r['file']]=cnt.get(r['file'],0)+1
    top=sorted(cnt.items(),key=lambda x:(-x[1],x[0]))[:40]
    out('\n===== TOP INFLUENCE FILE IDENTITIES =====')
    top_rows=[]
    for rel,n in top:
        p=source/rel; row={'file':rel,'hits':n,'bytes':p.stat().st_size,'sha256':sha256_path(p)};top_rows.append(row)
        out(f'INFLUENCE_FILE|FILE={rel}|HITS={n}|BYTES={row["bytes"]}|SHA256={row["sha256"]}')

    # Explicitly inspect known project-relevant files when present.
    known_rel=[
      'opencore_legacy_patcher/sys_patch/sys_patch.py',
      'opencore_legacy_patcher/sys_patch/sys_patch_helpers.py',
      'opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py',
      'opencore_legacy_patcher/datasets/os_data.py',
      'opencore_legacy_patcher/data_sets/os_data.py',
    ]
    known=[]
    out('\n===== KNOWN RELEVANT SOURCE FILE IDENTITIES =====')
    for rel in known_rel:
        p=source/rel
        if p.is_file():
            row={'file':rel,'bytes':p.stat().st_size,'sha256':sha256_path(p)};known.append(row);out(f'KNOWN_SOURCE_FILE|FILE={rel}|BYTES={row["bytes"]}|SHA256={row["sha256"]}')

    # Search for D97/custom markers to ensure historical custom source is not silently treated as original.
    custom=[]
    for p in text_files:
        try: lines=p.read_text(encoding='utf-8',errors='replace').splitlines()
        except: continue
        rel=str(p.relative_to(source))
        for i,line in enumerate(lines,1):
            if re.search(r'D97[A-Z0-9]*|A4F456DF|0FC4C627|P6|P7',line): custom.append({'file':rel,'line':i,'text':line.strip()})
    out('\n===== HISTORICAL CUSTOM-MARKER CENSUS =====')
    for r in custom[:180]: out(f'CUSTOM_MARKER|FILE={r["file"]}|LINE={r["line"]}|TEXT={r["text"]}')
    out(f'CUSTOM_MARKER_TOTAL={len(custom)}')

    scan={'eligibility_candidates':candidates,'payload_hits':payload_hits,'top_influence_files':top_rows,'known_source_files':known,'custom_markers':custom}

# App equivalence summary is conservative.
app_equiv=[]
for ga in golden_apps:
    for ta in tahoe_apps:
        app_equiv.append({'golden':ga['path'],'tahoe':ta['path'],'executable_identical':ga.get('executable_sha256')==ta.get('executable_sha256') if ga.get('executable_sha256') and ta.get('executable_sha256') else None,'bundle_manifest_identical':ga.get('bundle_manifest_sha256')==ta.get('bundle_manifest_sha256') if ga.get('bundle_manifest_sha256') and ta.get('bundle_manifest_sha256') else None})

result={'os':'15.8','build':'24H22','apps':apps,'app_comparisons':app_equiv,'source_path':str(source) if source else None,'source_info':source_info,'golden_components':components,'source_scan':scan}
JOUT.write_text(json.dumps(result,indent=2,sort_keys=True),encoding='utf-8')
out('\n===== D97BD CLASSIFICATION =====')
out('D97BD_APP_IDENTITY_CENSUS=COMPLETE')
out('D97BD_GOLDEN_COMPONENT_MANIFEST=COMPLETE')
out('D97BD_SOURCE_ELIGIBILITY_INFLUENCE_CENSUS='+('COMPLETE' if source else 'NOT_RUN_SOURCE_NOT_FOUND'))
out('ELIGIBILITY_ONLY_DELTA=NOT_YET_CLAIMED_REQUIRES_ASSISTANT_AUDIT')
out(f'JSON_REPORT={JOUT}')
out('D97BD_AUDIT=COMPLETE')
out('SYSTEM_FILE_MUTATION=NO')
out('SOURCE_MUTATION=NO')
out('GIT_FETCH_CHECKOUT_RESET=NO')
out('PROCESS_DEBUG_ATTACH=NO')
out('ROOT_PATCH=AUTO-NO')
out('REBOOT=AUTO-NO')
out('STOP=RETURN_COMPLETE_REPORT_AND_JSON')
PY
