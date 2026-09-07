#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GW — ASUS2 read-only preflight before D97GS P1-only Root Patch.
# NO Root Patch. NO system/root/EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_GS_ZIP_SHA="e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266"
EXPECTED_GS_ZIP_BYTES="722879148"
EXPECTED_GS_SOURCE_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_GS_INNER_SHA="5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_LAUNCHER_SHA="344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c"
EXPECTED_SERVICE_PRE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
EXPECTED_CORE_METALLIB_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_CORE_METALLIB_BYTES="20739"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GW_ASUS2_PREFLIGHT_${STAMP}"
REPORT="$OUT/D97GW_REPORT.txt"
EXTRACT="$OUT/extracted"
mkdir -p "$OUT" "$EXTRACT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
fail(){ echo "D97GW_STATUS=FAIL"; echo "D97GW_REASON=$*"; echo "D97GW_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97GW — ASUS2 PREFLIGHT FOR D97GS P1-ONLY ROOT PATCH =====
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
/usr/bin/sw_vers

BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97GW_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97GW_VESA_GATE=PASS"

[[ -f "$SERVICE" ]] || fail SERVICE_MISSING
S_SHA="$(sha256 "$SERVICE")"
echo "D97GW_CURRENT_SERVICE_SHA256=$S_SHA"
[[ "$S_SHA" == "$EXPECTED_SERVICE_PRE_SHA" ]] || fail SERVICE_NOT_EXACT_PRE_P1

[[ -d "$LOCAL_ROOT" ]] || fail LOCAL_METALLIB_ROOT_MISSING
[[ -f "$LOCAL_CORE" ]] || fail LOCAL_CORE_METALLIB_MISSING
CORE_SHA="$(sha256 "$LOCAL_CORE")"
CORE_BYTES="$(bytes "$LOCAL_CORE")"
echo "D97GW_LOCAL_CORE_METALLIB_SHA256=$CORE_SHA"
echo "D97GW_LOCAL_CORE_METALLIB_BYTES=$CORE_BYTES"
[[ "$CORE_SHA" == "$EXPECTED_CORE_METALLIB_SHA" ]] || fail LOCAL_CORE_METALLIB_SHA_MISMATCH
[[ "$CORE_BYTES" == "$EXPECTED_CORE_METALLIB_BYTES" ]] || fail LOCAL_CORE_METALLIB_BYTES_MISMATCH
MAGIC="$(/usr/bin/xxd -p -l 4 "$LOCAL_CORE")"
echo "D97GW_LOCAL_CORE_METALLIB_MAGIC=$MAGIC"
[[ "$MAGIC" == "4d544c42" ]] || fail LOCAL_CORE_METALLIB_NOT_MTLB

# Confirm the corrected local tree still has exactly 180 regular .metallib files and no obvious ASCII metadata stubs.
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
echo "D97GW_LOCAL_METALLIB_COUNT=$LOCAL_COUNT"
[[ "$LOCAL_COUNT" == "180" ]] || fail LOCAL_METALLIB_COUNT_NOT_180
BAD_MAGIC=0
while IFS= read -r F; do
    M="$(/usr/bin/xxd -p -l 4 "$F" 2>/dev/null || true)"
    if [[ "$M" != "4d544c42" ]]; then
        # One known QuartzCore target may be a valid Mach-O container; accept Mach-O magic only.
        case "$M" in
            cffaedfe|feedfacf|cafebabe|cafebabf) ;;
            *) echo "D97GW_BAD_METALLIB_MAGIC=$F::$M"; BAD_MAGIC=$((BAD_MAGIC+1));;
        esac
    fi
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)
echo "D97GW_LOCAL_BAD_MAGIC_COUNT=$BAD_MAGIC"
[[ "$BAD_MAGIC" -eq 0 ]] || fail LOCAL_METALLIB_BAD_MAGIC

echo "D97GW_LOCAL_METALLIB_SOURCE=PASS"

GS_ZIP=""
for C in \
  "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97GS.zip" \
  "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97GS.zip"
do
  if [[ -f "$C" ]]; then
    H="$(sha256 "$C")"
    echo "D97GW_CANDIDATE_ZIP=$C"
    echo "D97GW_CANDIDATE_ZIP_SHA256=$H"
    if [[ "$H" == "$EXPECTED_GS_ZIP_SHA" ]]; then
      GS_ZIP="$C"
      break
    fi
  fi
done
[[ -n "$GS_ZIP" ]] || fail EXACT_D97GS_ZIP_NOT_FOUND
[[ "$(bytes "$GS_ZIP")" == "$EXPECTED_GS_ZIP_BYTES" ]] || fail GS_ZIP_BYTES_MISMATCH

echo "D97GW_D97GS_ZIP=$GS_ZIP"
echo "D97GW_D97GS_ZIP_SHA256=$(sha256 "$GS_ZIP")"
echo "D97GW_D97GS_ZIP_BYTES=$(bytes "$GS_ZIP")"

/usr/bin/ditto -x -k "$GS_ZIP" "$EXTRACT"
APP="$EXTRACT/OpenCore-Patcher-Tahoe-D97GS.app"
[[ -d "$APP" ]] || fail EXTRACTED_APP_MISSING

DEBUG="$APP/Contents/Resources/debug-privileged-helper"
SOURCE="$APP/Contents/Resources/OCLP7_D97GS_SOURCE.patch"
INNER="$APP/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
CONTRACT="$APP/Contents/Resources/OCLP7_D97GS_P1_CONTRACT.txt"
[[ -f "$DEBUG" && -f "$SOURCE" && -f "$INNER" && -f "$CONTRACT" ]] || fail APP_RESOURCE_MISSING

[[ "$(sha256 "$DEBUG")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail DEBUG_HELPER_SHA_MISMATCH
[[ "$(sha256 "$SOURCE")" == "$EXPECTED_GS_SOURCE_SHA" ]] || fail SOURCE_PATCH_SHA_MISMATCH
[[ "$(sha256 "$INNER")" == "$EXPECTED_GS_INNER_SHA" ]] || fail INNER_SHA_MISMATCH
[[ "$(/usr/bin/lipo -archs "$INNER")" == "x86_64" ]] || fail INNER_ARCH_MISMATCH

LAUNCHER_COUNT="$(/usr/bin/find "$APP/Contents/MacOS" -maxdepth 1 -type f | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
[[ "$LAUNCHER_COUNT" == "1" ]] || fail LAUNCHER_COUNT_NOT_ONE
LAUNCHER="$(/usr/bin/find "$APP/Contents/MacOS" -maxdepth 1 -type f -print | /usr/bin/head -n 1)"
[[ "$(sha256 "$LAUNCHER")" == "$EXPECTED_LAUNCHER_SHA" ]] || fail LAUNCHER_SHA_MISMATCH

/usr/bin/codesign --verify --deep --strict "$APP" || fail OUTER_CODESIGN_FAIL
/usr/bin/codesign --verify --deep --strict "$APP/Contents/Resources/OpenCore-Patcher.app" || fail INNER_CODESIGN_FAIL
/usr/bin/codesign --verify --strict "$DEBUG" || fail DEBUG_HELPER_CODESIGN_FAIL

echo "D97GW_TRANSFERRED_ARTIFACT=PASS"

echo "D97GW_EXTRACTED_APP=$APP"
echo "D97GW_LAUNCHER_SHA256=$(sha256 "$LAUNCHER")"
echo "D97GW_INNER_SHA256=$(sha256 "$INNER")"
echo "D97GW_DEBUG_HELPER_SHA256=$(sha256 "$DEBUG")"
echo "D97GW_SOURCE_PATCH_SHA256=$(sha256 "$SOURCE")"
echo "D97GW_STATUS=PASS_READONLY_PREFLIGHT"
echo "D97GW_ROOT_PATCH=NO"
echo "D97GW_REBOOT=NO"
echo "D97GW_REPORT=$REPORT"
