#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HR — ASUS2 post-D97GS-Revert reboot clean/native audit.
# READ ONLY. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_NATIVE_SERVICE_SHA="4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256"
EXPECTED_NATIVE_CORE_SHA="daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1"
EXPECTED_NATIVE_CORE_BYTES="24128"
EXPECTED_D97HO_ZIP_SHA="a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3"
EXPECTED_D97HO_ZIP_BYTES="722975756"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"
AUXKC="/Library/KernelCollections/AuxiliaryKernelExtensions.kc"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HR_CLEAN_NATIVE_AUDIT_${STAMP}"
REPORT="$OUT/D97HR_REPORT.txt"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
fail(){ echo "D97HR_STATUS=FAIL"; echo "D97HR_REASON=$*"; echo "D97HR_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HR — POST-REVERT CLEAN/NATIVE VESA AUDIT =====
READ_ONLY=YES
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
echo "D97HR_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HR_VESA_GATE=PASS"

printf '\n===== NATIVE METAL COMPILER SERVICE =====\n'
[[ -f "$SERVICE" ]] || fail NATIVE_SERVICE_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
echo "D97HR_NATIVE_SERVICE_SHA256=$SERVICE_SHA"
echo "D97HR_NATIVE_SERVICE_BYTES=$(bytes "$SERVICE")"
[[ "$SERVICE_SHA" == "$EXPECTED_NATIVE_SERVICE_SHA" ]] || fail SERVICE_NOT_EXACT_NATIVE
/usr/bin/dwarfdump --uuid "$SERVICE" 2>/dev/null || true
echo "D97HR_NATIVE_SERVICE=PASS"

printf '\n===== NATIVE COREDISPLAY METALLIB =====\n'
[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
CORE_SHA="$(sha256 "$ACTIVE_CORE")"
CORE_BYTES="$(bytes "$ACTIVE_CORE")"
CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$ACTIVE_CORE")"
echo "D97HR_NATIVE_CORE_SHA256=$CORE_SHA"
echo "D97HR_NATIVE_CORE_BYTES=$CORE_BYTES"
echo "D97HR_NATIVE_CORE_MAGIC=$CORE_MAGIC"
[[ "$CORE_SHA" == "$EXPECTED_NATIVE_CORE_SHA" ]] || fail CORE_NOT_EXACT_NATIVE
[[ "$CORE_BYTES" == "$EXPECTED_NATIVE_CORE_BYTES" ]] || fail CORE_NATIVE_BYTES_MISMATCH
[[ "$CORE_MAGIC" == "4d544c42" ]] || fail CORE_NOT_MTLB
echo "D97HR_NATIVE_CORE=PASS"

printf '\n===== HASWELL PATCH BUNDLES REMOVED =====\n'
if [[ -d "$AZUL" ]]; then echo "D97HR_AZUL_PATH=PRESENT"; else echo "D97HR_AZUL_PATH=ABSENT"; fi
if [[ -d "$HD5000" ]]; then echo "D97HR_HD5000_PATH=PRESENT"; else echo "D97HR_HD5000_PATH=ABSENT"; fi
[[ ! -d "$AZUL" ]] || fail AZUL_BUNDLE_STILL_PRESENT_AFTER_REVERT
[[ ! -d "$HD5000" ]] || fail HD5000_BUNDLE_STILL_PRESENT_AFTER_REVERT

/usr/bin/kmutil showloaded --collection aux --show all 2>/dev/null > "$OUT/kmutil_aux_all.txt" || true
AZUL_AUX_COUNT="$(/usr/bin/grep -Fc 'com.apple.driver.AppleIntelFramebufferAzul' "$OUT/kmutil_aux_all.txt" || true)"
HD5000_AUX_COUNT="$(/usr/bin/grep -Fc 'com.apple.driver.AppleIntelHD5000Graphics' "$OUT/kmutil_aux_all.txt" || true)"
echo "D97HR_AZUL_AUX_LIST_COUNT=$AZUL_AUX_COUNT"
echo "D97HR_HD5000_AUX_LIST_COUNT=$HD5000_AUX_COUNT"

CHECK_RC=0
/usr/bin/kmutil check --collection aux --load-info > "$OUT/kmutil_check_aux.txt" 2>&1 || CHECK_RC=$?
echo "D97HR_KMUTIL_CHECK_AUX_LOADINFO_RC=$CHECK_RC"
[[ "$CHECK_RC" -eq 0 ]] || fail AUXKC_CHECK_FAILED

echo "D97HR_HASWELL_PATCH_BUNDLES_REMOVED=PASS"

printf '\n===== IOKIT VESA CLEAN STATE =====\n'
/usr/sbin/ioreg -l -w0 > "$OUT/ioreg.txt" 2>/dev/null || true
for TERM in AppleIntelFramebufferAzul AppleIntelHD5000Graphics IntelAccelerator IntelFramebuffer; do
  COUNT="$(/usr/bin/grep -Fc "$TERM" "$OUT/ioreg.txt" || true)"
  echo "D97HR_IOREG_${TERM}_COUNT=$COUNT"
done

printf '\n===== OFFICIAL PRIVILEGED HELPER =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"
HELPER_TEAM="$(team "$OFFICIAL_HELPER")"
echo "D97HR_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HR_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HR_OFFICIAL_HELPER=PASS"

printf '\n===== D97HO ARTIFACT STILL EXACT =====\n'
D97HO_ZIP=""
for P in "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip" "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97HO.zip"; do
  [[ -f "$P" ]] || continue
  if [[ "$(sha256 "$P")" == "$EXPECTED_D97HO_ZIP_SHA" ]]; then D97HO_ZIP="$P"; break; fi
done
[[ -n "$D97HO_ZIP" ]] || fail EXACT_D97HO_ZIP_NOT_FOUND
[[ "$(bytes "$D97HO_ZIP")" == "$EXPECTED_D97HO_ZIP_BYTES" ]] || fail D97HO_ZIP_BYTES_MISMATCH
echo "D97HR_D97HO_ZIP=$D97HO_ZIP"
echo "D97HR_D97HO_ZIP_SHA256=$(sha256 "$D97HO_ZIP")"
echo "D97HR_D97HO_ZIP_BYTES=$(bytes "$D97HO_ZIP")"
echo "D97HR_D97HO_ARTIFACT=PASS_EXACT"

printf '\n===== OPTIONAL LEGACY COMPILER RESIDUAL INVENTORY =====\n'
LEGACY_COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
if [[ -f "$LEGACY_COMPILER" ]]; then
  echo "D97HR_LEGACY_32023_PRESENT=YES"
  echo "D97HR_LEGACY_32023_SHA256=$(sha256 "$LEGACY_COMPILER")"
else
  echo "D97HR_LEGACY_32023_PRESENT=NO"
fi

printf '\n===== FINAL =====\n'
echo "D97HR_STATUS=PASS_CLEAN_NATIVE_VESA"
echo "D97HR_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS"
echo "D97HR_ROOT_PATCH_STATE=CLEAN_NATIVE_AFTER_REVERT"
echo "D97HR_D97HO_ROOT_PATCH=READY_AFTER_REVIEW"
echo "D97HR_REBOOT=NO"
echo "D97HR_REPORT=$REPORT"
