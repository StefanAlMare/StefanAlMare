#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HK — portable Intel build-host bootstrap + D97HI inner build.
# Designed for a clean Intel Mac that does NOT have the historical iMac worktree.
# Reconstructs exact D97DX source base -> exact D97GS P1 source state -> exact D97HI P3 source state,
# then builds ONLY the inner OpenCore-Patcher.app and packages it for later wrapper assembly.
# NO Root Patch. NO EFI/NVRAM/framebuffer/system-root mutation. NO reboot.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
GOLDEN_TREE="7c3411fde7d40604164c8877a5ab5594448083ac"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
VENV_PY="$WORK/.venv/bin/python"

D97DU_COMMIT="d8faeb3b108e57f35ee9576a8cbf1f7149c7bc9b"
D97DU_BLOB="ceed3890b5d35efbefc38ebf1a40f358884e58b9"
D97GS_COMMIT="8f86bfa76282b3b1c5b9aca311e95324406224d5"
D97GS_BLOB="b408d8d372ca6956db0caeb2a253df44acd7a5b9"
D97HI_COMMIT="4ca10b8e9a1b0db046d570bc2e1d2710ab16fa9a"
D97HI_BLOB="0bf2e5601f08613d916d1414a5e2561153517ed5"

EXPECTED_D97DX_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_D97GS_DIFF_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_UNIVERSAL_SHA="33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7"
EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P3_POST_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"

STAMP="$(date +%Y%m%d_%H%M%S)"
TMP="$HOME/Library/Caches/OCLP7-D97HK-$STAMP"
REPORT="$HOME/Desktop/OCLP7_D97HK_PORTABLE_BUILD_REPORT_${STAMP}.txt"
PORTABLE_APP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.app"
PORTABLE_ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.zip"

mkdir -p "$TMP"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HK_STATUS=FAIL"; echo "D97HK_REASON=$*"; echo "D97HK_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
blob(){ /usr/bin/git hash-object "$1"; }

cat <<'HDR'
===== OCLP7 D97HK — PORTABLE INTEL HOST BOOTSTRAP + D97HI INNER BUILD =====
BUILD_HOST=PORTABLE_INTEL_MAC
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
WRAPPER_ASSEMBLY=NO
OUTPUT=INNER_APP_ONLY
SOURCE_CHAIN=EXACT_D97DX_TO_D97GS_P1_TO_D97HI_P3
P2B_REPLAY=NO
AIR00_REPLAY=NO
D34_REPLAY=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -x /usr/local/bin/python3.13 ]] || fail PYTHON_313_X86_64_MISSING
[[ "$(/usr/local/bin/python3.13 -c 'import platform;print(platform.machine())')" == x86_64 ]] || fail PYTHON_313_NOT_X86_64

for c in git curl shasum codesign lipo ditto xcrun clang make; do
  command -v "$c" >/dev/null 2>&1 || fail "MISSING_TOOL_$c"
done
xcode-select -p >/dev/null 2>&1 || fail XCODE_SELECT_MISSING
SDKROOT="$(xcrun --sdk macosx --show-sdk-path 2>/dev/null || true)"
[[ -n "$SDKROOT" && -d "$SDKROOT" ]] || fail MACOS_SDK_MISSING
FREE_KB="$(df -Pk "$HOME" | awk 'NR==2{print $4}')"
[[ "$FREE_KB" =~ ^[0-9]+$ ]] || fail FREE_SPACE_PARSE_FAIL
(( FREE_KB > 40*1024*1024 )) || fail LESS_THAN_40_GIB_FREE

echo "D97HK_HOST_PRODUCT=$(/usr/bin/sw_vers -productVersion)"
echo "D97HK_HOST_BUILD=$(/usr/bin/sw_vers -buildVersion)"
echo "D97HK_HOST_CPU=$(/usr/sbin/sysctl -n machdep.cpu.brand_string 2>/dev/null || true)"
echo "D97HK_SDKROOT=$SDKROOT"
echo "D97HK_PYTHON=$(/usr/local/bin/python3.13 --version 2>&1)"
echo "D97HK_HOST_PREFLIGHT=PASS"

printf '\n===== FETCH EXACT HISTORICAL BUILD AUTHORITIES =====\n'
DU="$TMP/D97DU.sh"
GS="$TMP/D97GS.sh"
HI="$TMP/D97HI.sh"

/usr/bin/curl -fL "https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${D97DU_COMMIT}/OCLP-Continuity/artifacts/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.sh" -o "$DU"
/usr/bin/curl -fL "https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${D97GS_COMMIT}/OCLP-Continuity/artifacts/OCLP7_D97GS_IMAC_BUILD_P1_ONLY_FROM_D97DX.sh" -o "$GS"
/usr/bin/curl -fL "https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${D97HI_COMMIT}/OCLP-Continuity/artifacts/OCLP7_D97HI_IMAC_BUILD_P1_PLUS_P3_ONLY_FROM_D97GS.sh" -o "$HI"

[[ "$(blob "$DU")" == "$D97DU_BLOB" ]] || fail D97DU_AUTHORITY_BLOB_MISMATCH
[[ "$(blob "$GS")" == "$D97GS_BLOB" ]] || fail D97GS_AUTHORITY_BLOB_MISMATCH
[[ "$(blob "$HI")" == "$D97HI_BLOB" ]] || fail D97HI_AUTHORITY_BLOB_MISMATCH

echo "D97HK_D97DU_BLOB=$(blob "$DU")"
echo "D97HK_D97GS_BLOB=$(blob "$GS")"
echo "D97HK_D97HI_BLOB=$(blob "$HI")"
echo "D97HK_AUTHORITY_IDENTITY=PASS"

printf '\n===== TRANSFORM D97DU INTO PORTABLE SOURCE/ASSET PREP ONLY =====\n'
DU_PREP="$TMP/D97DU_PORTABLE_PREP.sh"
/usr/local/bin/python3.13 - "$DU" "$DU_PREP" <<'PY'
from pathlib import Path
import sys,re
src=Path(sys.argv[1]).read_text()

# Prefer the explicitly proven x86_64 Python 3.13 on this portable host.
needle='for p in \\\n'
if src.count(needle) != 1:
    raise SystemExit(f'python loop anchor count={src.count(needle)}')
src=src.replace(needle, needle+'    "/usr/local/bin/python3.13" \\\n',1)

# Build-host prep does not need target-local MetallibSupportPkg or an official target helper.
pat1=re.compile(r'say "Verify exact local 25G82 MetallibSupportPkg".*?(?=say "Locate exact official privileged-helper restore asset")',re.S)
if len(pat1.findall(src)) != 1:
    raise SystemExit('local metallib gate anchor mismatch')
src=pat1.sub('say "D97HK portable prep: target-local MetallibSupportPkg gate intentionally deferred"\necho "D97HK_LOCAL_METALLIB_GATE=DEFERRED_TO_TARGET_PREFLIGHT"\n\n',src,count=1)

pat2=re.compile(r'say "Locate exact official privileged-helper restore asset".*?(?=say "Create clean exact b9df76 worktree")',re.S)
if len(pat2.findall(src)) != 1:
    raise SystemExit('official helper gate anchor mismatch')
src=pat2.sub('say "D97HK portable prep: official target helper gate intentionally deferred"\necho "D97HK_OFFICIAL_HELPER_GATE=DEFERRED_TO_TARGET_PREFLIGHT"\n\n',src,count=1)

# Stop after exact source policy + venv + exact PatcherSupportPkg asset preparation.
stop='ok "PatcherSupportPkg asset gate PASS"\n'
if src.count(stop) != 1:
    raise SystemExit(f'asset stop anchor count={src.count(stop)}')
src=src.replace(stop,stop+'echo "D97HK_D97DU_PREP_COMPLETE=PASS"\necho "D97HK_D97DU_PREP_STOP=BEFORE_DEBUG_HELPER_AND_APP_BUILD"\nexit 0\n',1)

Path(sys.argv[2]).write_text(src)
PY
/bin/chmod +x "$DU_PREP"
/bin/bash -n "$DU_PREP" || fail D97DU_PORTABLE_PREP_SYNTAX_FAIL

# Historical worktree path is disposable build state. Preserve any pre-existing one rather than deleting it.
if [[ -e "$WORK" ]]; then
  OLD="$WORK.before-D97HK-$STAMP"
  /bin/mv "$WORK" "$OLD"
  echo "D97HK_PREEXISTING_WORKTREE_MOVED=$OLD"
fi

/bin/bash "$DU_PREP" || fail D97DU_PORTABLE_PREP_RUNTIME_FAIL

printf '\n===== VERIFY EXACT D97DX SOURCE BASE =====\n'
[[ -d "$WORK/.git" ]] || fail PREP_WORKTREE_MISSING
[[ -x "$VENV_PY" ]] || fail PREP_VENV_MISSING
cd "$WORK"
[[ "$(git rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || fail GOLDEN_COMMIT_MISMATCH
[[ "$(git rev-parse 'HEAD^{tree}')" == "$GOLDEN_TREE" ]] || fail GOLDEN_TREE_MISMATCH
D97DX_DIFF="$TMP/D97DX_SOURCE.patch"
git diff > "$D97DX_DIFF"
D97DX_DIFF_SHA="$(sha256 "$D97DX_DIFF")"
echo "D97HK_D97DX_SOURCE_DIFF_SHA256=$D97DX_DIFF_SHA"
[[ "$D97DX_DIFF_SHA" == "$EXPECTED_D97DX_DIFF_SHA" ]] || fail D97DX_SOURCE_DIFF_MISMATCH
[[ "$($VENV_PY -c 'import sys;print(f"{sys.version_info.major}.{sys.version_info.minor}")')" == "3.13" ]] || fail VENV_NOT_PYTHON_313
[[ "$($VENV_PY -c 'import platform;print(platform.machine())')" == x86_64 ]] || fail VENV_NOT_X86_64
[[ -f "$WORK/Universal-Binaries.dmg" ]] || fail UNIVERSAL_BINARIES_MISSING
[[ "$(sha256 "$WORK/Universal-Binaries.dmg")" == "$EXPECTED_UNIVERSAL_SHA" ]] || fail UNIVERSAL_BINARIES_SHA_MISMATCH
[[ -f "$WORK/payloads.dmg" ]] || fail PAYLOADS_DMG_MISSING
echo "D97HK_PAYLOADS_DMG_SHA256=$(sha256 "$WORK/payloads.dmg")"
echo "D97HK_D97DX_SOURCE_BASE=PASS"

printf '\n===== TRANSFORM D97GS INTO P1 SOURCE-PREP ONLY =====\n'
GS_PREP="$TMP/D97GS_SOURCE_PREP.sh"
/usr/local/bin/python3.13 - "$GS" "$GS_PREP" <<'PY'
from pathlib import Path
import sys
s=Path(sys.argv[1]).read_text()
marker='echo "===== BUILD INNER OCLP ====="'
if s.count(marker) != 1:
    raise SystemExit(f'D97GS inner-build marker count={s.count(marker)}')
pos=s.index(marker)
s=s[:pos]+'echo "D97HK_D97GS_SOURCE_PREP=PASS"\necho "D97HK_D97GS_STOP=BEFORE_INNER_BUILD"\nexit 0\n\n'+s[pos:]
Path(sys.argv[2]).write_text(s)
PY
/bin/chmod +x "$GS_PREP"
/bin/bash -n "$GS_PREP" || fail D97GS_SOURCE_PREP_SYNTAX_FAIL
/bin/bash "$GS_PREP" || fail D97GS_SOURCE_PREP_RUNTIME_FAIL

D97GS_DIFF="$TMP/D97GS_SOURCE.patch"
git diff > "$D97GS_DIFF"
D97GS_DIFF_SHA="$(sha256 "$D97GS_DIFF")"
echo "D97HK_D97GS_SOURCE_DIFF_SHA256=$D97GS_DIFF_SHA"
[[ "$D97GS_DIFF_SHA" == "$EXPECTED_D97GS_DIFF_SHA" ]] || fail D97GS_SOURCE_DIFF_MISMATCH

echo "D97HK_D97GS_EXACT_P1_SOURCE_BASE=PASS"

printf '\n===== TRANSFORM D97HI INTO PORTABLE INNER-BUILD ONLY =====\n'
HI_PORT="$TMP/D97HI_PORTABLE_INNER.sh"
/usr/local/bin/python3.13 - "$HI" "$HI_PORT" <<'PY'
from pathlib import Path
import sys
s=Path(sys.argv[1]).read_text()
needle='===== RESOLVE EXACT D97GS WRAPPER TEMPLATE ====='
if s.count(needle) != 1:
    raise SystemExit(f'D97HI wrapper marker count={s.count(needle)}')
idx=s.index(needle)
line_start=s.rfind('\nprintf',0,idx)
if line_start < 0:
    raise SystemExit('cannot locate wrapper printf start')
insert=r'''

printf '\n===== D97HK PORTABLE INNER PACKAGE =====\n'
PORTABLE_APP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.app"
PORTABLE_ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.zip"
/bin/rm -rf "$PORTABLE_APP" "$PORTABLE_ZIP"
/usr/bin/ditto "$CUSTOM_APP" "$PORTABLE_APP"
/usr/bin/codesign --verify --deep --strict "$PORTABLE_APP" || fail PORTABLE_INNER_CODESIGN_FAIL
PORTABLE_EXE="$PORTABLE_APP/Contents/MacOS/OpenCore-Patcher"
PORTABLE_ARCH="$(/usr/bin/lipo -archs "$PORTABLE_EXE")"
[[ "$PORTABLE_ARCH" == "x86_64" ]] || fail "PORTABLE_INNER_ARCH_$PORTABLE_ARCH"
PORTABLE_EXE_SHA="$(sha256 "$PORTABLE_EXE")"
[[ "$PORTABLE_EXE_SHA" == "$INNER_SHA" ]] || fail PORTABLE_INNER_SHA_DRIFT
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$PORTABLE_APP" "$PORTABLE_ZIP"
PORTABLE_ZIP_SHA="$(sha256 "$PORTABLE_ZIP")"
PORTABLE_ZIP_BYTES="$(/usr/bin/stat -f '%z' "$PORTABLE_ZIP")"
echo "D97HI_STATUS=BUILD_PASS_PORTABLE_INNER"
echo "D97HI_OUTER_WRAPPER=DEFERRED"
echo "D97HI_NEW_FUNCTIONAL_DELTA=P3_ONLY"
echo "D97HI_P1_BASE=PRESERVED_EXACT"
echo "D97HI_P2B_REPLAY=NO"
echo "D97HI_AIR00_REPLAY=NO"
echo "D97HI_D34_REPLAY=NO"
echo "D97HI_P3_POST_SHA256=0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"
echo "D97HI_SOURCE_DIFF_SHA256=$D97HI_DIFF_SHA"
echo "D97HI_INNER_EXECUTABLE_SHA256=$INNER_SHA"
echo "D97HI_PORTABLE_INNER_APP=$PORTABLE_APP"
echo "D97HI_PORTABLE_INNER_ZIP=$PORTABLE_ZIP"
echo "D97HI_PORTABLE_INNER_ZIP_SHA256=$PORTABLE_ZIP_SHA"
echo "D97HI_PORTABLE_INNER_ZIP_BYTES=$PORTABLE_ZIP_BYTES"
echo "D97HI_ROOT_PATCH=NO"
echo "D97HI_REBOOT=NO"
exit 0
'''
s=s[:line_start]+insert+s[line_start:]
Path(sys.argv[2]).write_text(s)
PY
/bin/chmod +x "$HI_PORT"
/bin/bash -n "$HI_PORT" || fail D97HI_PORTABLE_SYNTAX_FAIL
/bin/bash "$HI_PORT" || fail D97HI_PORTABLE_RUNTIME_FAIL

printf '\n===== FINAL PORTABLE HOST AUDIT =====\n'
[[ -d "$PORTABLE_APP" ]] || fail PORTABLE_APP_MISSING
[[ -f "$PORTABLE_ZIP" ]] || fail PORTABLE_ZIP_MISSING
PORTABLE_EXE="$PORTABLE_APP/Contents/MacOS/OpenCore-Patcher"
[[ -f "$PORTABLE_EXE" ]] || fail PORTABLE_EXE_MISSING
/usr/bin/codesign --verify --deep --strict "$PORTABLE_APP" || fail FINAL_INNER_CODESIGN_FAIL
[[ "$(/usr/bin/lipo -archs "$PORTABLE_EXE")" == x86_64 ]] || fail FINAL_INNER_ARCH_FAIL

FINAL_DIFF="$TMP/D97HI_FINAL_SOURCE.patch"
git diff > "$FINAL_DIFF"
FINAL_DIFF_SHA="$(sha256 "$FINAL_DIFF")"
PORTABLE_EXE_SHA="$(sha256 "$PORTABLE_EXE")"
PORTABLE_ZIP_SHA="$(sha256 "$PORTABLE_ZIP")"
PORTABLE_ZIP_BYTES="$(/usr/bin/stat -f '%z' "$PORTABLE_ZIP")"

echo "D97HK_D97HI_FINAL_SOURCE_DIFF_SHA256=$FINAL_DIFF_SHA"
echo "D97HK_D97HI_INNER_EXECUTABLE_SHA256=$PORTABLE_EXE_SHA"
echo "D97HK_D97HI_INNER_ZIP_SHA256=$PORTABLE_ZIP_SHA"
echo "D97HK_D97HI_INNER_ZIP_BYTES=$PORTABLE_ZIP_BYTES"
echo "D97HK_SOURCE_CHAIN=EXACT_D97DX_TO_EXACT_D97GS_TO_D97HI_P3_ONLY"
echo "D97HK_P1_POST_SHA=$EXPECTED_P1_POST_SHA"
echo "D97HK_P3_POST_SHA=$EXPECTED_P3_POST_SHA"
echo "D97HK_P2B_REPLAY=NO"
echo "D97HK_AIR00_REPLAY=NO"
echo "D97HK_D34_REPLAY=NO"
echo "D97HK_ROOT_PATCH=NO"
echo "D97HK_REBOOT=NO"
echo "D97HK_STATUS=PASS_PORTABLE_INNER_BUILD"
echo "D97HK_NEXT=INDEPENDENT_D97HL_INNER_AUDIT_BEFORE_TARGET_WRAPPER_ASSEMBLY"
echo "D97HK_REPORT=$REPORT"
echo "D97HK_PORTABLE_INNER_ZIP=$PORTABLE_ZIP"
