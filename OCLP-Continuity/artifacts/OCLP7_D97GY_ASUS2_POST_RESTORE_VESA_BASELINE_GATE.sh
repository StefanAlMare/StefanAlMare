#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GY — ASUS2 post-Restore/reboot VESA baseline gate before D97GS.
# READ-ONLY. NO Root Patch. NO Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_NATIVE_SERVICE_SHA="4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256"
EXPECTED_NATIVE_SERVICE_UUID="022C1750-8735-389A-A8BA-A8A67F54235D"
EXPECTED_NATIVE_CORE_SHA="daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1"
EXPECTED_NATIVE_CORE_BYTES="24128"
EXPECTED_LOCAL_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_LOCAL_CORE_BYTES="20739"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GY_POST_RESTORE_VESA_${STAMP}"
REPORT="$OUT/D97GY_REPORT.txt"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
fail(){ echo "D97GY_STATUS=FAIL"; echo "D97GY_REASON=$*"; echo "D97GY_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97GY — POST RESTORE / VESA BASELINE GATE =====
ROOT_PATCH=NO
RESTORE=NO
SYSTEM_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== BOOT SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97GY_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97GY_VESA_GATE=PASS"

printf '\n===== NATIVE TAHOE MTLCOMPILERSERVICE RESTORED =====\n'
[[ -f "$SERVICE" ]] || fail NATIVE_SERVICE_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
echo "D97GY_NATIVE_SERVICE_SHA256=$SERVICE_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_NATIVE_SERVICE_SHA" ]] || fail NATIVE_SERVICE_SHA_MISMATCH
/usr/bin/file "$SERVICE" | tee "$OUT/native_service_file.txt"
UUID_LINE="$(/usr/bin/dwarfdump --uuid "$SERVICE" 2>/dev/null | /usr/bin/grep -F "$EXPECTED_NATIVE_SERVICE_UUID" || true)"
echo "D97GY_NATIVE_SERVICE_UUID_MATCH=$([[ -n "$UUID_LINE" ]] && echo PASS || echo FAIL)"
[[ -n "$UUID_LINE" ]] || fail NATIVE_SERVICE_UUID_MISMATCH
ARCHS="$(/usr/bin/lipo -archs "$SERVICE" 2>/dev/null || true)"
echo "D97GY_NATIVE_SERVICE_ARCHS=$ARCHS"
printf '%s\n' "$ARCHS" | /usr/bin/grep -qw x86_64 || fail NATIVE_SERVICE_X86_64_MISSING
printf '%s\n' "$ARCHS" | /usr/bin/grep -qw arm64e || fail NATIVE_SERVICE_ARM64E_MISSING
echo "D97GY_NATIVE_SERVICE=PASS"

printf '\n===== NATIVE COREDISPLAY METALLIB RESTORED =====\n'
[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
ACTIVE_CORE_SHA="$(sha256 "$ACTIVE_CORE")"
ACTIVE_CORE_BYTES="$(bytes "$ACTIVE_CORE")"
ACTIVE_CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$ACTIVE_CORE")"
echo "D97GY_ACTIVE_CORE_SHA256=$ACTIVE_CORE_SHA"
echo "D97GY_ACTIVE_CORE_BYTES=$ACTIVE_CORE_BYTES"
echo "D97GY_ACTIVE_CORE_MAGIC=$ACTIVE_CORE_MAGIC"
[[ "$ACTIVE_CORE_SHA" == "$EXPECTED_NATIVE_CORE_SHA" ]] || fail ACTIVE_CORE_SHA_NOT_NATIVE
[[ "$ACTIVE_CORE_BYTES" == "$EXPECTED_NATIVE_CORE_BYTES" ]] || fail ACTIVE_CORE_BYTES_NOT_NATIVE
[[ "$ACTIVE_CORE_MAGIC" == "4d544c42" ]] || fail ACTIVE_CORE_NOT_MTLB
echo "D97GY_NATIVE_CORE=PASS"

printf '\n===== HASWELL AUXKC DATA KEXTS REMOVED =====\n'
if [[ -e "$AZUL" ]]; then echo "D97GY_RESIDUAL_KEXT=$AZUL"; fail AZUL_KEXT_STILL_PRESENT; fi
if [[ -e "$HD5000" ]]; then echo "D97GY_RESIDUAL_KEXT=$HD5000"; fail HD5000_KEXT_STILL_PRESENT; fi
LOADED="$(/usr/bin/kmutil showloaded 2>/dev/null | /usr/bin/grep -E 'AppleIntelFramebufferAzul|AppleIntelHD5000Graphics' || true)"
if [[ -n "$LOADED" ]]; then
  printf '%s\n' "$LOADED"
  fail HASWELL_KEXT_STILL_LOADED
fi
echo "D97GY_HASWELL_AUXKC_REMOVED=PASS"

printf '\n===== CORRECTED LOCAL METALLIB SOURCE SURVIVED =====\n'
[[ -d "$LOCAL_ROOT" && -f "$LOCAL_CORE" ]] || fail LOCAL_METALLIB_SOURCE_MISSING
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
LOCAL_CORE_SHA="$(sha256 "$LOCAL_CORE")"
LOCAL_CORE_BYTES="$(bytes "$LOCAL_CORE")"
LOCAL_CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$LOCAL_CORE")"
echo "D97GY_LOCAL_METALLIB_COUNT=$LOCAL_COUNT"
echo "D97GY_LOCAL_CORE_SHA256=$LOCAL_CORE_SHA"
echo "D97GY_LOCAL_CORE_BYTES=$LOCAL_CORE_BYTES"
echo "D97GY_LOCAL_CORE_MAGIC=$LOCAL_CORE_MAGIC"
[[ "$LOCAL_COUNT" == "180" ]] || fail LOCAL_METALLIB_COUNT_NOT_180
[[ "$LOCAL_CORE_SHA" == "$EXPECTED_LOCAL_CORE_SHA" ]] || fail LOCAL_CORE_SHA_MISMATCH
[[ "$LOCAL_CORE_BYTES" == "$EXPECTED_LOCAL_CORE_BYTES" ]] || fail LOCAL_CORE_BYTES_MISMATCH
[[ "$LOCAL_CORE_MAGIC" == "4d544c42" ]] || fail LOCAL_CORE_NOT_MTLB
BAD_MAGIC=0
while IFS= read -r F; do
  M="$(/usr/bin/xxd -p -l 4 "$F" 2>/dev/null || true)"
  if [[ "$M" != "4d544c42" ]]; then
    case "$M" in
      cffaedfe|feedfacf|cafebabe|cafebabf) ;;
      *) echo "D97GY_BAD_LOCAL_METALLIB_MAGIC=$F::$M"; BAD_MAGIC=$((BAD_MAGIC+1));;
    esac
  fi
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)
echo "D97GY_LOCAL_BAD_MAGIC_COUNT=$BAD_MAGIC"
[[ "$BAD_MAGIC" -eq 0 ]] || fail LOCAL_METALLIB_BAD_MAGIC
echo "D97GY_LOCAL_METALLIB_SOURCE=PASS"

printf '\n===== OFFICIAL HELPER =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"
HELPER_TEAM="$(/usr/bin/codesign -dv --verbose=4 "$OFFICIAL_HELPER" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}')"
echo "D97GY_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97GY_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97GY_OFFICIAL_HELPER=PASS"

printf '\n===== FINAL =====\n'
echo "D97GY_NATIVE_BASELINE=PASS"
echo "D97GY_RESTORE_REBOOT=STRUCTURAL_SEMANTIC_PASS"
echo "D97GY_D97GS_ROOTPATCH_BASE=READY"
echo "D97GY_STATUS=PASS_READONLY_POST_RESTORE_GATE"
echo "D97GY_REBOOT=NO"
echo "D97GY_REPORT=$REPORT"
