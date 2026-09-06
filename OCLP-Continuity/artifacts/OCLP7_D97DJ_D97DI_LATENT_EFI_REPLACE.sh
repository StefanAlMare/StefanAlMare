#!/bin/bash
set -euo pipefail

# OCLP7 D97DJ — ASUS2 controlled LATENT D97DD 0.0.4 -> D97DI 0.0.6 replacement
#
# Mutates ONLY EFI/OC/Kexts/OCLPMetalCompat.kext.
# config.plist is verified but NOT modified.
# Functional D97BV is NOT armed: -ocmcd97bv must be absent.
# NO sudo. NO Root Patch. NO system/dyld-cache mutation. NO reboot.

CONFIG="/Volumes/EFI/EFI/OC/config.plist"
EXPECTED_CONFIG_SHA="b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48"
OLD_EXEC_SHA="3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25"
NEW_EXEC_SHA="0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4"
EXPECTED_BUNDLE_ID="com.oclpmetalcompat.OCLPMetalCompat"
EXPECTED_OLD_VERSION="0.0.4"
EXPECTED_NEW_VERSION="0.0.6"
EXPECTED_LILU_VERSION="1.7.3"
PACKAGE="${HOME}/Downloads/OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip"
EXPECTED_PACKAGE_SHA="6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f"
EXPECTED_SOURCE_SHA="932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b"
GUID="7C436110-AB2A-4BBB-A880-FE41995C9F82"
STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT="${HOME}/Desktop/OCLP7_D97DJ_D97DI_LATENT_EFI_REPLACE_${STAMP}.txt"
TMPDIR="$(/usr/bin/mktemp -d "/tmp/d97dj.${STAMP}.XXXXXX")"
cleanup(){ /bin/rm -rf "${TMPDIR}" 2>/dev/null || true; }
trap cleanup EXIT
exec > >(tee "${REPORT}") 2>&1

echo "===== OCLP7 D97DJ — D97DI LATENT CONTROLLED EFI REPLACE ====="
echo "TARGET=ASUS2"
echo "SYSTEM_MUTATION=NO"
echo "DYLD_CACHE_MUTATION=NO"
echo "ROOT_PATCH=NO"
echo "REBOOT=NO"
echo "SUDO=NO"
echo "CONFIG_MUTATION=NO"
echo "EFI_KEXT_REPLACEMENT=YES"
echo "D97DI_DEPLOY_MODE=LATENT"
echo "D97BV_FUNCTIONAL_MUTATION=NO"
echo "D97BV_FUNCTIONAL_BOOTARG_REQUIRED_ABSENT=-ocmcd97bv"
echo
/usr/bin/sw_vers
/usr/bin/uname -a
[[ -f "${CONFIG}" ]] || { echo "D97DJ_STATUS=STOP_CONFIG_NOT_FOUND"; exit 2; }
CONFIG_SHA="$(/usr/bin/shasum -a 256 "${CONFIG}"|/usr/bin/awk '{print $1}')"
echo "CONFIG_SHA_EXPECTED=${EXPECTED_CONFIG_SHA}"
echo "CONFIG_SHA_ACTUAL=${CONFIG_SHA}"
[[ "${CONFIG_SHA}" == "${EXPECTED_CONFIG_SHA}" ]] || { echo "D97DJ_STATUS=STOP_CONFIG_IDENTITY_MISMATCH"; exit 3; }
/usr/bin/plutil -lint "${CONFIG}"
OC_DIR="$(/usr/bin/dirname "${CONFIG}")"; KEXTS_DIR="${OC_DIR}/Kexts"; CURRENT_KEXT="${KEXTS_DIR}/OCLPMetalCompat.kext"; CURRENT_EXEC="${CURRENT_KEXT}/Contents/MacOS/OCLPMetalCompat"
MATCH_COUNT=0; ENTRY_INDEX=""
for i in $(/usr/bin/seq 0 99); do BP="$(/usr/libexec/PlistBuddy -c "Print :Kernel:Add:${i}:BundlePath" "${CONFIG}" 2>/dev/null || true)"; if [[ "${BP}" == "OCLPMetalCompat.kext" ]]; then MATCH_COUNT=$((MATCH_COUNT+1)); ENTRY_INDEX="${i}"; fi; done
echo "OCLPMETALCOMPAT_ENTRY_COUNT=${MATCH_COUNT}"; echo "OCLPMETALCOMPAT_ENTRY_INDEX=${ENTRY_INDEX}"
[[ "${MATCH_COUNT}" -eq 1 ]] || { echo "D97DJ_STATUS=STOP_OCLPMETALCOMPAT_ENTRY_COUNT"; exit 4; }
[[ "${ENTRY_INDEX}" == "5" ]] || { echo "D97DJ_STATUS=STOP_OCLPMETALCOMPAT_ENTRY_INDEX_CHANGED"; exit 5; }
BOOT_ARGS="$(/usr/libexec/PlistBuddy -c "Print :NVRAM:Add:${GUID}:boot-args" "${CONFIG}" 2>/dev/null || true)"
echo "BOOT_ARGS=${BOOT_ARGS}"
echo " ${BOOT_ARGS} "|/usr/bin/grep -q ' -igfxvesa ' || { echo "D97DJ_STATUS=STOP_IGFXVESA_MISSING"; exit 6; }
echo " ${BOOT_ARGS} "|/usr/bin/grep -q ' -ocmcdiag ' || { echo "D97DJ_STATUS=STOP_OCMCDIAG_MISSING"; exit 7; }
if echo " ${BOOT_ARGS} "|/usr/bin/grep -q ' -ocmcd97bv '; then echo "D97DJ_STATUS=STOP_FUNCTIONAL_BOOTARG_PRESENT"; exit 8; fi
echo "FUNCTIONAL_BOOTARG_ABSENT=PASS"
LILU_BP="$(/usr/libexec/PlistBuddy -c 'Print :Kernel:Add:0:BundlePath' "${CONFIG}" 2>/dev/null || true)"; LILU_VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "${KEXTS_DIR}/Lilu.kext/Contents/Info.plist" 2>/dev/null || true)"
echo "KERNEL_ADD_0=${LILU_BP}"; echo "EFI_LILU_VERSION=${LILU_VER}"
[[ "${LILU_BP}" == "Lilu.kext" && "${LILU_VER}" == "${EXPECTED_LILU_VERSION}" ]] || { echo "D97DJ_STATUS=STOP_LILU_IDENTITY"; exit 9; }
CURRENT_EXEC_SHA="$(/usr/bin/shasum -a 256 "${CURRENT_EXEC}"|/usr/bin/awk '{print $1}')"; CURRENT_VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "${CURRENT_KEXT}/Contents/Info.plist" 2>/dev/null || true)"; CURRENT_ID="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "${CURRENT_KEXT}/Contents/Info.plist" 2>/dev/null || true)"
echo "CURRENT_EXEC_SHA_ACTUAL=${CURRENT_EXEC_SHA}"; echo "CURRENT_VERSION=${CURRENT_VER}"; echo "CURRENT_BUNDLE_ID=${CURRENT_ID}"
[[ "${CURRENT_EXEC_SHA}" == "${OLD_EXEC_SHA}" && "${CURRENT_VER}" == "${EXPECTED_OLD_VERSION}" && "${CURRENT_ID}" == "${EXPECTED_BUNDLE_ID}" ]] || { echo "D97DJ_STATUS=STOP_CURRENT_D97DD_IDENTITY_MISMATCH"; exit 10; }
[[ -f "${PACKAGE}" ]] || { echo "D97DJ_STATUS=STOP_PACKAGE_NOT_IN_DOWNLOADS"; exit 11; }
PACKAGE_SHA="$(/usr/bin/shasum -a 256 "${PACKAGE}"|/usr/bin/awk '{print $1}')"; echo "PACKAGE_SHA_ACTUAL=${PACKAGE_SHA}"
[[ "${PACKAGE_SHA}" == "${EXPECTED_PACKAGE_SHA}" ]] || { echo "D97DJ_STATUS=STOP_PACKAGE_SHA_MISMATCH"; exit 12; }
/usr/bin/unzip -q "${PACKAGE}" -d "${TMPDIR}/pkg"
NEW_KEXT="${TMPDIR}/pkg/OCLPMetalCompat.kext"; NEW_EXEC="${NEW_KEXT}/Contents/MacOS/OCLPMetalCompat"; NEW_SOURCE="${TMPDIR}/pkg/kern_start.cpp.authoritative"
NEW_SOURCE_SHA="$(/usr/bin/shasum -a 256 "${NEW_SOURCE}"|/usr/bin/awk '{print $1}')"; NEW_EXEC_SHA_ACTUAL="$(/usr/bin/shasum -a 256 "${NEW_EXEC}"|/usr/bin/awk '{print $1}')"; NEW_ID="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "${NEW_KEXT}/Contents/Info.plist" 2>/dev/null || true)"; NEW_VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "${NEW_KEXT}/Contents/Info.plist" 2>/dev/null || true)"; NEW_LILU="$(/usr/libexec/PlistBuddy -c 'Print :OSBundleLibraries:as.vit9696.Lilu' "${NEW_KEXT}/Contents/Info.plist" 2>/dev/null || true)"
echo "NEW_SOURCE_SHA_ACTUAL=${NEW_SOURCE_SHA}"; echo "NEW_EXEC_SHA_ACTUAL=${NEW_EXEC_SHA_ACTUAL}"; echo "NEW_VERSION=${NEW_VER}"
[[ "${NEW_SOURCE_SHA}" == "${EXPECTED_SOURCE_SHA}" && "${NEW_EXEC_SHA_ACTUAL}" == "${NEW_EXEC_SHA}" && "${NEW_ID}" == "${EXPECTED_BUNDLE_ID}" && "${NEW_VER}" == "${EXPECTED_NEW_VERSION}" && "${NEW_LILU}" == "${EXPECTED_LILU_VERSION}" ]] || { echo "D97DJ_STATUS=STOP_NEW_D97DI_IDENTITY"; exit 13; }
/usr/bin/codesign --verify --deep --strict "${NEW_KEXT}" 2>&1 || { echo "D97DJ_STATUS=STOP_NEW_CODESIGN_VERIFY_FAIL"; exit 14; }
STRINGS_TMP="${TMPDIR}/strings.txt"; /usr/bin/strings -a "${NEW_EXEC}" > "${STRINGS_TMP}"; /usr/bin/grep -q -- '-ocmcd97bv' "${STRINGS_TMP}" || { echo "D97DJ_STATUS=STOP_FUNCTIONAL_MARKER_MISSING"; exit 15; }; /usr/bin/grep -q -- 'D97DIFunctionalMode' "${STRINGS_TMP}" || { echo "D97DJ_STATUS=STOP_MODE_MARKER_MISSING"; exit 16; }
echo "AUDITED_D97DI_LATENT_GATE=PASS"
STAGED="${KEXTS_DIR}/.OCLPMetalCompat.D97DI.${STAMP}.new"; BACKUP="${KEXTS_DIR}/OCLPMetalCompat.kext.D97DD-${STAMP}.bak"; /bin/rm -rf "${STAGED}" 2>/dev/null || true; cp -R "${NEW_KEXT}" "${STAGED}"; STAGED_SHA="$(/usr/bin/shasum -a 256 "${STAGED}/Contents/MacOS/OCLPMetalCompat"|/usr/bin/awk '{print $1}')"; echo "STAGED_EXEC_SHA=${STAGED_SHA}"; [[ "${STAGED_SHA}" == "${NEW_EXEC_SHA}" ]] || { /bin/rm -rf "${STAGED}"; echo "D97DJ_STATUS=STOP_STAGED_SHA_MISMATCH"; exit 17; }
mv "${CURRENT_KEXT}" "${BACKUP}"; echo "BACKUP_KEXT=${BACKUP}"; echo "BACKUP_EXEC_SHA=$(/usr/bin/shasum -a 256 "${BACKUP}/Contents/MacOS/OCLPMetalCompat"|/usr/bin/awk '{print $1}')"; if ! mv "${STAGED}" "${CURRENT_KEXT}"; then [[ ! -e "${CURRENT_KEXT}" && -d "${BACKUP}" ]] && mv "${BACKUP}" "${CURRENT_KEXT}" || true; echo "D97DJ_STATUS=STOP_REPLACE_FAILED"; exit 18; fi
FINAL_EXEC_SHA="$(/usr/bin/shasum -a 256 "${CURRENT_EXEC}"|/usr/bin/awk '{print $1}')"; FINAL_VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "${CURRENT_KEXT}/Contents/Info.plist" 2>/dev/null || true)"; FINAL_ID="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "${CURRENT_KEXT}/Contents/Info.plist" 2>/dev/null || true)"; FINAL_CONFIG_SHA="$(/usr/bin/shasum -a 256 "${CONFIG}"|/usr/bin/awk '{print $1}')"; FINAL_BOOT_ARGS="$(/usr/libexec/PlistBuddy -c "Print :NVRAM:Add:${GUID}:boot-args" "${CONFIG}" 2>/dev/null || true)"
echo "FINAL_EXEC_SHA=${FINAL_EXEC_SHA}"; echo "FINAL_VERSION=${FINAL_VER}"; echo "FINAL_BUNDLE_ID=${FINAL_ID}"; echo "FINAL_CONFIG_SHA=${FINAL_CONFIG_SHA}"; echo "FINAL_BOOT_ARGS=${FINAL_BOOT_ARGS}"
[[ "${FINAL_EXEC_SHA}" == "${NEW_EXEC_SHA}" && "${FINAL_VER}" == "${EXPECTED_NEW_VERSION}" && "${FINAL_ID}" == "${EXPECTED_BUNDLE_ID}" && "${FINAL_CONFIG_SHA}" == "${EXPECTED_CONFIG_SHA}" ]] || { echo "D97DJ_STATUS=STOP_POST_REPLACE_AUDIT_FAIL"; exit 19; }
if echo " ${FINAL_BOOT_ARGS} "|/usr/bin/grep -q ' -ocmcd97bv '; then echo "D97DJ_STATUS=STOP_FUNCTIONAL_BOOTARG_APPEARED"; exit 20; fi
/usr/bin/plutil -lint "${CONFIG}"; /usr/bin/codesign --verify --deep --strict "${CURRENT_KEXT}" 2>&1
echo "POST_REPLACE_LATENT_GATE=PASS"
echo "D97DJ_STATUS=PASS"
echo "D97DI_DEPLOY_MODE=LATENT"
echo "CONFIG_MUTATION=NO"
echo "FUNCTIONAL_BOOTARG_PRESENT=NO"
echo "D97BV_FUNCTIONAL_MUTATION=NO"
echo "ROOT_PATCH=NO"
echo "REBOOT_PERFORMED=NO"
echo "NEXT=RETURN_REPORT_TO_CHATGPT_BEFORE_REBOOT"
echo "REPORT=${REPORT}"
