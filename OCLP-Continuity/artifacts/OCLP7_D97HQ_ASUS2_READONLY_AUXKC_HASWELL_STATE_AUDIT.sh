#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HQ — ASUS2 read-only Haswell AuxKC/load-state audit after D97HP AZUL_NOT_LOADED.
# Distinguishes installed-on-disk, present-in-AuxKC, loaded, unloaded/not-matched, and IOKit evidence.
# Also verifies the official OCLP privileged helper.
# NO load/unload. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_BUILD="25G82"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"
HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HQ_AUXKC_HASWELL_AUDIT_${STAMP}"
REPORT="$OUT/D97HQ_REPORT.txt"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HQ_STATUS=FAIL"; echo "D97HQ_REASON=$*"; echo "D97HQ_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
plist(){ /usr/libexec/PlistBuddy -c "Print :$2" "$1/Contents/Info.plist" 2>/dev/null || true; }

cat <<'HDR'
===== OCLP7 D97HQ — HASWELL AUXKC / LOAD-STATE AUDIT =====
READ_ONLY=YES
KEXT_LOAD=NO
KEXT_UNLOAD=NO
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
[[ "$(/usr/bin/sw_vers -buildVersion)" == "$EXPECTED_BUILD" ]] || fail NOT_25G82
/usr/bin/sw_vers

BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HQ_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HQ_VESA_GATE=PASS"

printf '\n===== INSTALLED KEXT IDENTITIES =====\n'
[[ -d "$AZUL" ]] || fail AZUL_KEXT_MISSING_ON_DISK
[[ -d "$HD5000" ]] || fail HD5000_KEXT_MISSING_ON_DISK
AZUL_ID="$(plist "$AZUL" CFBundleIdentifier)"
HD5000_ID="$(plist "$HD5000" CFBundleIdentifier)"
AZUL_VER="$(plist "$AZUL" CFBundleVersion)"
HD5000_VER="$(plist "$HD5000" CFBundleVersion)"
AZUL_SHORT="$(plist "$AZUL" CFBundleShortVersionString)"
HD5000_SHORT="$(plist "$HD5000" CFBundleShortVersionString)"
echo "D97HQ_AZUL_ID=$AZUL_ID"
echo "D97HQ_AZUL_VERSION=$AZUL_VER"
echo "D97HQ_AZUL_SHORT_VERSION=$AZUL_SHORT"
echo "D97HQ_HD5000_ID=$HD5000_ID"
echo "D97HQ_HD5000_VERSION=$HD5000_VER"
echo "D97HQ_HD5000_SHORT_VERSION=$HD5000_SHORT"
[[ -n "$AZUL_ID" && -n "$HD5000_ID" ]] || fail BUNDLE_ID_READ_FAIL
/usr/bin/codesign --verify --deep --strict "$AZUL" > "$OUT/azul_codesign.txt" 2>&1 || true
/usr/bin/codesign --verify --deep --strict "$HD5000" > "$OUT/hd5000_codesign.txt" 2>&1 || true
echo "D97HQ_KEXTS_PRESENT_ON_DISK=PASS"

printf '\n===== KMUTIL AUX COLLECTION LOAD STATES =====\n'
/usr/bin/kmutil showloaded --collection aux --show all > "$OUT/kmutil_aux_all.txt" 2>&1 || true
/usr/bin/kmutil showloaded --collection aux --show loaded > "$OUT/kmutil_aux_loaded.txt" 2>&1 || true
/usr/bin/kmutil showloaded --collection aux --show unloaded > "$OUT/kmutil_aux_unloaded.txt" 2>&1 || true
/usr/bin/kmutil showloaded --show all > "$OUT/kmutil_all_allcollections.txt" 2>&1 || true

check_state(){
  local id="$1" prefix="$2"
  local in_aux_all=0 in_aux_loaded=0 in_aux_unloaded=0 in_all=0
  /usr/bin/grep -F "$id" "$OUT/kmutil_aux_all.txt" >/dev/null 2>&1 && in_aux_all=1 || true
  /usr/bin/grep -F "$id" "$OUT/kmutil_aux_loaded.txt" >/dev/null 2>&1 && in_aux_loaded=1 || true
  /usr/bin/grep -F "$id" "$OUT/kmutil_aux_unloaded.txt" >/dev/null 2>&1 && in_aux_unloaded=1 || true
  /usr/bin/grep -F "$id" "$OUT/kmutil_all_allcollections.txt" >/dev/null 2>&1 && in_all=1 || true
  echo "D97HQ_${prefix}_IN_AUX_ALL=$in_aux_all"
  echo "D97HQ_${prefix}_IN_AUX_LOADED=$in_aux_loaded"
  echo "D97HQ_${prefix}_IN_AUX_UNLOADED=$in_aux_unloaded"
  echo "D97HQ_${prefix}_IN_ALL_COLLECTIONS=$in_all"
}
check_state "$AZUL_ID" AZUL
check_state "$HD5000_ID" HD5000

echo "--- AUX ALL matches ---"
/usr/bin/grep -F -e "$AZUL_ID" -e "$HD5000_ID" "$OUT/kmutil_aux_all.txt" || true
echo "--- AUX LOADED matches ---"
/usr/bin/grep -F -e "$AZUL_ID" -e "$HD5000_ID" "$OUT/kmutil_aux_loaded.txt" || true
echo "--- AUX UNLOADED matches ---"
/usr/bin/grep -F -e "$AZUL_ID" -e "$HD5000_ID" "$OUT/kmutil_aux_unloaded.txt" || true

printf '\n===== KMUTIL CONSISTENCY / DIAGNOSTICS =====\n'
set +e
/usr/bin/kmutil check --collection aux --load-info > "$OUT/kmutil_check_aux_loadinfo.txt" 2>&1
CHECK_RC=$?
/usr/bin/kmutil dumpstate > "$OUT/kmutil_dumpstate.txt" 2>&1
DUMP_RC=$?
set -e
echo "D97HQ_KMUTIL_CHECK_AUX_LOADINFO_RC=$CHECK_RC"
echo "D97HQ_KMUTIL_DUMPSTATE_RC=$DUMP_RC"
/usr/bin/head -n 80 "$OUT/kmutil_check_aux_loadinfo.txt" || true

printf '\n===== AUXKC ON-DISK PRESENCE =====\n'
AUX_CANDIDATES=(
  "/Library/KernelCollections/AuxiliaryKernelExtensions.kc"
  "/System/Library/KernelCollections/AuxiliaryKernelExtensions.kc"
)
AUX_FOUND=0
for KC in "${AUX_CANDIDATES[@]}"; do
  if [[ -f "$KC" ]]; then
    AUX_FOUND=1
    echo "D97HQ_AUXKC_PATH=$KC"
    echo "D97HQ_AUXKC_BYTES=$(/usr/bin/stat -f '%z' "$KC")"
    /usr/bin/kmutil inspect --show-kext-uuids --show-fileset-entries -A "$KC" > "$OUT/kmutil_inspect_$(basename "$KC").txt" 2>&1 || true
    if /usr/bin/grep -F "$AZUL_ID" "$OUT/kmutil_inspect_$(basename "$KC").txt" >/dev/null 2>&1; then echo "D97HQ_AZUL_IN_AUXKC_INSPECT=1"; else echo "D97HQ_AZUL_IN_AUXKC_INSPECT=0"; fi
    if /usr/bin/grep -F "$HD5000_ID" "$OUT/kmutil_inspect_$(basename "$KC").txt" >/dev/null 2>&1; then echo "D97HQ_HD5000_IN_AUXKC_INSPECT=1"; else echo "D97HQ_HD5000_IN_AUXKC_INSPECT=0"; fi
  fi
done
if [[ "$AUX_FOUND" -eq 0 ]]; then
  echo "D97HQ_AUXKC_PATH=NOT_FOUND_AT_STANDARD_INTEL_PATHS"
fi

printf '\n===== IOKIT CROSS-CHECK =====\n'
/usr/sbin/ioreg -lw0 > "$OUT/ioreg_full.txt" 2>/dev/null || true
for P in AppleIntelFramebufferAzul AppleIntelHD5000Graphics IntelAccelerator IntelFramebuffer AppleIntelFramebuffer display0 AppleBacklight; do
  C="$(/usr/bin/grep -c "$P" "$OUT/ioreg_full.txt" 2>/dev/null || true)"
  echo "D97HQ_IOREG_${P}_COUNT=$C"
done
/usr/bin/grep -Ei 'AppleIntelFramebufferAzul|AppleIntelHD5000Graphics|IntelAccelerator|IntelFramebuffer|display0|AppleBacklight' "$OUT/ioreg_full.txt" > "$OUT/ioreg_haswell_extract.txt" 2>/dev/null || true
/usr/bin/head -n 120 "$OUT/ioreg_haswell_extract.txt" || true

printf '\n===== OFFICIAL PRIVILEGED HELPER =====\n'
[[ -f "$HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$HELPER")"
HELPER_TEAM="$(team "$HELPER")"
echo "D97HQ_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HQ_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HQ_OFFICIAL_HELPER=PASS"

printf '\n===== CLASSIFICATION =====\n'
AZ_AUX_ALL=$(/usr/bin/grep -F "$AZUL_ID" "$OUT/kmutil_aux_all.txt" >/dev/null 2>&1; echo $?)
AZ_AUX_LOADED=$(/usr/bin/grep -F "$AZUL_ID" "$OUT/kmutil_aux_loaded.txt" >/dev/null 2>&1; echo $?)
HD_AUX_ALL=$(/usr/bin/grep -F "$HD5000_ID" "$OUT/kmutil_aux_all.txt" >/dev/null 2>&1; echo $?)
HD_AUX_LOADED=$(/usr/bin/grep -F "$HD5000_ID" "$OUT/kmutil_aux_loaded.txt" >/dev/null 2>&1; echo $?)

if [[ "$AZ_AUX_LOADED" -eq 0 && "$HD_AUX_LOADED" -eq 0 ]]; then
  CLASS="BOTH_LOADED_IN_AUX"
elif [[ "$AZ_AUX_ALL" -eq 0 && "$HD_AUX_ALL" -eq 0 ]]; then
  CLASS="PRESENT_IN_AUX_BUT_NOT_BOTH_LOADED"
else
  CLASS="AUX_COLLECTION_PRESENCE_INCOMPLETE_OR_NOT_REPORTED"
fi

echo "D97HQ_HASWELL_CLASSIFICATION=$CLASS"
echo "D97HQ_D97HP_AZUL_NOT_LOADED=NEEDS_CONTEXT_FROM_THIS_AUDIT"
echo "D97HQ_ROOT_PATCH_DECISION=PENDING_REVIEW"
echo "D97HQ_RESTORE_DECISION=PENDING_REVIEW"
echo "D97HQ_STATUS=PASS_READONLY_DIAGNOSTIC_COLLECTION"
echo "D97HQ_REBOOT=NO"
echo "D97HQ_REPORT=$REPORT"

/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$HOME/Desktop/OCLP7_D97HQ_AUXKC_HASWELL_AUDIT_${STAMP}.zip"
ZIP="$HOME/Desktop/OCLP7_D97HQ_AUXKC_HASWELL_AUDIT_${STAMP}.zip"
echo "D97HQ_ZIP=$ZIP"
echo "D97HQ_ZIP_SHA256=$(sha256 "$ZIP")"
echo "D97HQ_ZIP_BYTES=$(/usr/bin/stat -f '%z' "$ZIP")"
