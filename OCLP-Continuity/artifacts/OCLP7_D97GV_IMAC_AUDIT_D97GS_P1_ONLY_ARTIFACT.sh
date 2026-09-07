#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GV — independent read-only audit of the D97GS P1-only build artifact.
# BUILD/AUDIT HOST: Intel iMac.
# NO source mutation. NO build. NO Root Patch. NO system/EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_GS_ZIP_SHA="e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266"
EXPECTED_GS_ZIP_BYTES="722879148"
EXPECTED_GS_SOURCE_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_GS_INNER_SHA="5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e"
EXPECTED_DX_ZIP_SHA="2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a"
EXPECTED_DX_SOURCE_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_LAUNCHER_SHA="344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c"
EXPECTED_P1_PRE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"

GS_ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97GS.zip"
DX_ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.zip"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GV_D97GS_ARTIFACT_AUDIT_${STAMP}"
REPORT="$OUT/D97GV_REPORT.txt"
ZIP_OUT="$HOME/Desktop/OCLP7_D97GV_D97GS_ARTIFACT_AUDIT_${STAMP}.zip"
TMP="$OUT/extracted"
mkdir -p "$OUT" "$TMP/gs" "$TMP/dx"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
fail(){ echo "D97GV_STATUS=FAIL"; echo "D97GV_REASON=$*"; echo "D97GV_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97GV — INDEPENDENT D97GS P1-ONLY ARTIFACT AUDIT =====
AUDIT_HOST=INTEL_IMAC_ONLY
SOURCE_MUTATION=NO
BUILD=NO
ROOT_PATCH=NO
SYSTEM_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -f "$GS_ZIP" ]] || fail D97GS_ZIP_MISSING
[[ -f "$DX_ZIP" ]] || fail D97DX_ZIP_MISSING

printf '\n===== OUTER ZIP IDENTITIES =====\n'
GS_ZIP_SHA="$(sha256 "$GS_ZIP")"
GS_ZIP_BYTES="$(bytes "$GS_ZIP")"
DX_ZIP_SHA="$(sha256 "$DX_ZIP")"
echo "D97GV_GS_ZIP_SHA256=$GS_ZIP_SHA"
echo "D97GV_GS_ZIP_BYTES=$GS_ZIP_BYTES"
echo "D97GV_DX_ZIP_SHA256=$DX_ZIP_SHA"
[[ "$GS_ZIP_SHA" == "$EXPECTED_GS_ZIP_SHA" ]] || fail GS_ZIP_SHA_MISMATCH
[[ "$GS_ZIP_BYTES" == "$EXPECTED_GS_ZIP_BYTES" ]] || fail GS_ZIP_BYTES_MISMATCH
[[ "$DX_ZIP_SHA" == "$EXPECTED_DX_ZIP_SHA" ]] || fail DX_ZIP_SHA_MISMATCH

echo "D97GV_OUTER_ZIP_IDENTITIES=PASS"

printf '\n===== EXTRACT EXACT ZIPs =====\n'
/usr/bin/ditto -x -k "$GS_ZIP" "$TMP/gs"
/usr/bin/ditto -x -k "$DX_ZIP" "$TMP/dx"
GS_APP="$TMP/gs/OpenCore-Patcher-Tahoe-D97GS.app"
DX_APP="$TMP/dx/OpenCore-Patcher-Tahoe-D97DX.app"
[[ -d "$GS_APP" ]] || fail GS_APP_MISSING_AFTER_EXTRACT
[[ -d "$DX_APP" ]] || fail DX_APP_MISSING_AFTER_EXTRACT

echo "D97GV_EXTRACT=PASS"

printf '\n===== WRAPPER PROVENANCE =====\n'
GS_DEBUG="$GS_APP/Contents/Resources/debug-privileged-helper"
DX_DEBUG="$DX_APP/Contents/Resources/debug-privileged-helper"
GS_BASE_PATCH="$GS_APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
DX_BASE_PATCH="$DX_APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
GS_NEW_PATCH="$GS_APP/Contents/Resources/OCLP7_D97GS_SOURCE.patch"
GS_CONTRACT="$GS_APP/Contents/Resources/OCLP7_D97GS_P1_CONTRACT.txt"
GS_INNER="$GS_APP/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"

[[ -f "$GS_DEBUG" && -f "$DX_DEBUG" ]] || fail DEBUG_HELPER_MISSING
[[ -f "$GS_BASE_PATCH" && -f "$DX_BASE_PATCH" ]] || fail BASE_PATCH_MISSING
[[ -f "$GS_NEW_PATCH" ]] || fail GS_NEW_PATCH_MISSING
[[ -f "$GS_CONTRACT" ]] || fail GS_CONTRACT_MISSING
[[ -f "$GS_INNER" ]] || fail GS_INNER_MISSING

GS_DEBUG_SHA="$(sha256 "$GS_DEBUG")"
DX_DEBUG_SHA="$(sha256 "$DX_DEBUG")"
GS_BASE_SHA="$(sha256 "$GS_BASE_PATCH")"
DX_BASE_SHA="$(sha256 "$DX_BASE_PATCH")"
GS_NEW_SHA="$(sha256 "$GS_NEW_PATCH")"
GS_INNER_SHA="$(sha256 "$GS_INNER")"

echo "D97GV_GS_DEBUG_HELPER_SHA256=$GS_DEBUG_SHA"
echo "D97GV_DX_DEBUG_HELPER_SHA256=$DX_DEBUG_SHA"
echo "D97GV_GS_BASE_PATCH_SHA256=$GS_BASE_SHA"
echo "D97GV_DX_BASE_PATCH_SHA256=$DX_BASE_SHA"
echo "D97GV_GS_NEW_PATCH_SHA256=$GS_NEW_SHA"
echo "D97GV_GS_INNER_SHA256=$GS_INNER_SHA"
[[ "$GS_DEBUG_SHA" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail GS_DEBUG_HELPER_SHA_MISMATCH
[[ "$DX_DEBUG_SHA" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail DX_DEBUG_HELPER_SHA_MISMATCH
[[ "$GS_BASE_SHA" == "$EXPECTED_DX_SOURCE_SHA" ]] || fail GS_BASE_PATCH_SHA_MISMATCH
[[ "$DX_BASE_SHA" == "$EXPECTED_DX_SOURCE_SHA" ]] || fail DX_BASE_PATCH_SHA_MISMATCH
[[ "$GS_NEW_SHA" == "$EXPECTED_GS_SOURCE_SHA" ]] || fail GS_NEW_PATCH_SHA_MISMATCH
[[ "$GS_INNER_SHA" == "$EXPECTED_GS_INNER_SHA" ]] || fail GS_INNER_SHA_MISMATCH

# Launcher must remain byte-identical to D97DX. Resolve exactly one regular file in each Contents/MacOS.
mapfile -t GS_LAUNCHERS < <(/usr/bin/find "$GS_APP/Contents/MacOS" -maxdepth 1 -type f -print)
mapfile -t DX_LAUNCHERS < <(/usr/bin/find "$DX_APP/Contents/MacOS" -maxdepth 1 -type f -print)
[[ "${#GS_LAUNCHERS[@]}" -eq 1 ]] || fail GS_LAUNCHER_COUNT_NOT_ONE
[[ "${#DX_LAUNCHERS[@]}" -eq 1 ]] || fail DX_LAUNCHER_COUNT_NOT_ONE
GS_LAUNCHER_SHA="$(sha256 "${GS_LAUNCHERS[0]}")"
DX_LAUNCHER_SHA="$(sha256 "${DX_LAUNCHERS[0]}")"
echo "D97GV_GS_LAUNCHER=$(basename "${GS_LAUNCHERS[0]}")"
echo "D97GV_GS_LAUNCHER_SHA256=$GS_LAUNCHER_SHA"
echo "D97GV_DX_LAUNCHER_SHA256=$DX_LAUNCHER_SHA"
[[ "$GS_LAUNCHER_SHA" == "$EXPECTED_LAUNCHER_SHA" ]] || fail GS_LAUNCHER_SHA_MISMATCH
[[ "$DX_LAUNCHER_SHA" == "$EXPECTED_LAUNCHER_SHA" ]] || fail DX_LAUNCHER_SHA_MISMATCH

echo "D97GV_WRAPPER_PROVENANCE=PASS"

printf '\n===== ARCH / CODESIGN =====\n'
GS_INNER_ARCH="$(/usr/bin/lipo -archs "$GS_INNER")"
echo "D97GV_GS_INNER_ARCH=$GS_INNER_ARCH"
[[ "$GS_INNER_ARCH" == x86_64 ]] || fail GS_INNER_NOT_X86_64
/usr/bin/codesign --verify --deep --strict "$GS_APP" || fail GS_OUTER_CODESIGN_FAIL
/usr/bin/codesign --verify --deep --strict "$GS_APP/Contents/Resources/OpenCore-Patcher.app" || fail GS_INNER_APP_CODESIGN_FAIL
/usr/bin/codesign --verify --strict "$GS_DEBUG" || fail GS_DEBUG_HELPER_CODESIGN_FAIL

echo "D97GV_CODESIGN=PASS"

printf '\n===== SOURCE PATCH SECTION AUDIT =====\n'
/usr/bin/python3 - "$DX_BASE_PATCH" "$GS_NEW_PATCH" "$OUT/section_audit.tsv" <<'PY'
from pathlib import Path
import hashlib,re,sys
base=Path(sys.argv[1]).read_text(errors='replace')
gs=Path(sys.argv[2]).read_text(errors='replace')
out=Path(sys.argv[3])

def sections(txt):
    starts=[m.start() for m in re.finditer(r'(?m)^diff --git a/', txt)]
    d={}
    for i,s in enumerate(starts):
        e=starts[i+1] if i+1<len(starts) else len(txt)
        sec=txt[s:e]
        m=re.match(r'diff --git a/(.*?) b/(.*?)\n', sec)
        if not m:
            raise SystemExit('SECTION_HEADER_PARSE_FAIL')
        d[m.group(2)] = sec
    return d

B=sections(base); G=sections(gs)
expected_base={
 'OpenCore-Patcher-GUI.spec',
 'opencore_legacy_patcher/support/metallib_handler.py',
 'opencore_legacy_patcher/sys_patch/patchsets/detect.py',
 'opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py',
}
new_file='opencore_legacy_patcher/sys_patch/sys_patch.py'
expected_gs=expected_base|{new_file}
print('D97GV_BASE_SECTION_COUNT='+str(len(B)))
print('D97GV_GS_SECTION_COUNT='+str(len(G)))
if set(B)!=expected_base:
    raise SystemExit('BASE_SECTION_SET_MISMATCH:'+repr(sorted(B)))
if set(G)!=expected_gs:
    raise SystemExit('GS_SECTION_SET_MISMATCH:'+repr(sorted(G)))

rows=[]
for fn in sorted(expected_base):
    same=B[fn]==G[fn]
    bh=hashlib.sha256(B[fn].encode()).hexdigest()
    gh=hashlib.sha256(G[fn].encode()).hexdigest()
    rows.append((fn,bh,gh,'YES' if same else 'NO'))
    print(f'D97GV_BASE_SECTION_EXACT::{fn}=' + ('PASS' if same else 'FAIL'))
    if not same:
        raise SystemExit('BASE_SECTION_DRIFT:'+fn)

sec=G[new_file]
# Only additive source changes are acceptable in sys_patch.py (ignoring file-header --- lines).
removed=[ln for ln in sec.splitlines() if ln.startswith('-') and not ln.startswith('---')]
added=[ln[1:] for ln in sec.splitlines() if ln.startswith('+') and not ln.startswith('+++')]
print('D97GV_SYS_PATCH_REMOVED_LINE_COUNT='+str(len(removed)))
print('D97GV_SYS_PATCH_ADDED_LINE_COUNT='+str(len(added)))
if removed:
    raise SystemExit('SYS_PATCH_HAS_REMOVALS')
a='\n'.join(added)
required=[
 'import hashlib',
 'def _d97gs_apply_p1_selector_bridge(self) -> None:',
 'self.constants.detected_os_build != "25G82"',
 'self.model != "MacBookAir6,2"',
 '31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5',
 'a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43',
 'offset = 0x3494',
 'bytes.fromhex("81fe19790000")',
 'bytes.fromhex("81fe177d0000")',
 'occurrences != [offset]',
 'post[2:4]',
 'seek={offset+2}',
 'count=2',
 'diffs != [offset + 2, offset + 3]',
 'self._d97gs_apply_p1_selector_bridge()',
]
for token in required:
    c=a.count(token)
    print('D97GV_SYS_PATCH_TOKEN_COUNT::'+token+'='+str(c))
    if c!=1:
        raise SystemExit('SYS_PATCH_TOKEN_COUNT_FAIL:'+token+':'+str(c))
for forbidden in ['P2b','P2B','AIR00','D34','true-five','true five']:
    if forbidden in a:
        raise SystemExit('FORBIDDEN_REPLAY_LABEL_IN_SYS_PATCH:'+forbidden)

with out.open('w') as f:
    f.write('FILE\tBASE_SECTION_SHA256\tGS_SECTION_SHA256\tEXACT_MATCH\n')
    for r in rows:
        f.write('\t'.join(r)+'\n')
    f.write(new_file+'\t\t'+hashlib.sha256(sec.encode()).hexdigest()+'\tNEW_P1_ONLY_SECTION\n')
print('D97GV_SOURCE_SECTIONS=PASS')
print('D97GV_SYS_PATCH_P1_ONLY_STATIC_CONTRACT=PASS')
PY
/bin/cat "$OUT/section_audit.tsv"

printf '\n===== P1 CONTRACT FILE =====\n'
/bin/cat "$GS_CONTRACT" | tee "$OUT/P1_contract_copy.txt"
/usr/bin/grep -Fx "D97GS_BUILD=25G82" "$GS_CONTRACT" >/dev/null || fail CONTRACT_BUILD_MISMATCH
/usr/bin/grep -Fx "D97GS_MODEL=MacBookAir6,2" "$GS_CONTRACT" >/dev/null || fail CONTRACT_MODEL_MISMATCH
/usr/bin/grep -Fx "D97GS_P1_PRE_SHA256=$EXPECTED_P1_PRE_SHA" "$GS_CONTRACT" >/dev/null || fail CONTRACT_PRE_SHA_MISMATCH
/usr/bin/grep -Fx "D97GS_P1_POST_SHA256=$EXPECTED_P1_POST_SHA" "$GS_CONTRACT" >/dev/null || fail CONTRACT_POST_SHA_MISMATCH
/usr/bin/grep -Fx "D97GS_P1_OFFSET=0x3494" "$GS_CONTRACT" >/dev/null || fail CONTRACT_OFFSET_MISMATCH
echo "D97GV_P1_CONTRACT_FILE=PASS"

printf '\n===== FORBIDDEN WRAPPER / SOURCE REGRESSION SCAN =====\n'
# Base D97DX patch was already audited. New functional source is restricted to sys_patch.py above.
# Still scan the combined D97GS source patch for legacy main-Metal shadow literals.
if /usr/bin/grep -E 'MetalOld\.dylib|13\.2\.1-24/Metal\.framework' "$GS_NEW_PATCH" > "$OUT/forbidden_source_hits.txt"; then
    /bin/cat "$OUT/forbidden_source_hits.txt"
    fail FORBIDDEN_LEGACY_MAIN_METAL_LITERAL_FOUND
fi

echo "D97GV_FORBIDDEN_LEGACY_MAIN_METAL_SCAN=PASS"

printf '\n===== PACKAGE AUDIT RESULT =====\n'
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP_OUT"
echo "D97GV_AUDIT_ZIP=$ZIP_OUT"
echo "D97GV_AUDIT_ZIP_SHA256=$(sha256 "$ZIP_OUT")"
echo "D97GV_AUDIT_ZIP_BYTES=$(bytes "$ZIP_OUT")"
echo "D97GV_D97GS_ARTIFACT_IDENTITY=PASS"
echo "D97GV_D97DX_BASE_SECTIONS_EXACT=PASS"
echo "D97GV_P1_ONLY_SOURCE_DELTA=STATIC_STRUCTURAL_SEMANTIC_PROVEN"
echo "D97GV_STATUS=PASS_READONLY_AUDIT"
echo "D97GV_ROOT_PATCH=NO"
echo "D97GV_REBOOT=NO"
echo "D97GV_REPORT=$REPORT"
