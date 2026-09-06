#!/bin/bash
set -euo pipefail

# OCLP7 D97DL — cave-first hardened authoritative self-fetching iMac local build
#
# IMAC ONLY.
# Fetches the exact GitHub-persisted D97DL source by pinned commit/blob/SHA.
# NO sudo. NO EFI mutation. NO kext loading. NO Root Patch. NO reboot.
# Output ZIP must be returned to ChatGPT for independent audit.
# ASUS2 deployment / -ocmcd97bv / functional execution remain unauthorized.

STAMP="$(date +%Y%m%d_%H%M%S)"
DESKTOP="${HOME}/Desktop"
WORK="${DESKTOP}/OCLP7_D97DL_BUILD_${STAMP}"
PROJECT_SRC="${WORK}/project-source"
SCAFFOLD="${WORK}/scaffold"
LILU_SRC="${WORK}/Lilu-src"
LILU_BUILD="${WORK}/Lilu-build"
PLUGIN_BUILD="${WORK}/plugin-build"
OBJROOT="${WORK}/obj"
PACKAGE="${WORK}/package"
REPORT="${PACKAGE}/D97DL_BUILD_REPORT.txt"
BUILDLOG="${PACKAGE}/D97DL_XCODEBUILD.log"
MANIFEST="${PACKAGE}/SHA256SUMS.txt"
FINAL_ZIP="${DESKTOP}/OCLP7_D97DL_IMAC_BUILD_${STAMP}.zip"

PROJECT_REPO="https://github.com/StefanAlMare/StefanAlMare.git"
D97DL_AUTHORITY_COMMIT="72dbc5f29aedf4f8190700de9f1c2c45f949b56f"
D97DL_SOURCE_PATH="OCLP-Continuity/artifacts/OCLP7_D97DL_kern_start.cpp"
D97DL_AUDIT_PATH="OCLP-Continuity/artifacts/OCLP7_D97DL_STATIC_ORDERING_AUDIT.md"
EXPECTED_D97DL_SOURCE_SHA="f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2"
EXPECTED_D97DL_SOURCE_BLOB="af52267e8e5fbbc975715b1c3a7a3fceab994c1b"

INFO_HEAD="8c4904870b8512fe356fcb48e82fb32a9e980634"
INFO_PATH="OCLPMetalCompat/OCLPMetalCompat/Info.plist"
INFO_BLOB="7d6b00ac1e8cbc26396a114c550ccac01c0bc008"

FEATUREUNLOCK_REPO="https://github.com/acidanthera/FeatureUnlock.git"
FEATUREUNLOCK_COMMIT="201bd45766207e6cc10cd40a8ac1f9c6216f9acb"

LILU_REPO="https://github.com/acidanthera/Lilu.git"
LILU_COMMIT="0515f40b7f2a096adc85e832a4c6104fbd07f936"
EXPECTED_LILU_VERSION="1.7.3"

MACKERNELSDK_REPO="https://github.com/acidanthera/MacKernelSDK.git"
MACKERNELSDK_COMMIT="05094e5e88cec7caedbfb35e8449ed0db94bf95b"

PLUGIN_VERSION="0.0.7"
PLUGIN_BUNDLE_ID="com.oclpmetalcompat.OCLPMetalCompat"

mkdir -p "${WORK}" "${PACKAGE}"
touch "${REPORT}" "${BUILDLOG}"

log() { echo "$*" | tee -a "${REPORT}"; }
die() { log "D97DL_BUILD_STATUS=FAIL"; log "FAIL_REASON=$*"; exit 1; }

log "===== OCLP7 D97DL — AUTHORITATIVE IMAC LOCAL BUILD ====="
log "SYSTEM_MUTATION=NO"
log "EFI_MUTATION=NO"
log "KEXT_LOAD=NO"
log "ROOT_PATCH=NO"
log "REBOOT=NO"
log "SUDO=NO"
log "D97BV_FUNCTIONAL_PAYLOAD=COMPILED_BUT_LATENT_CAVE_FIRST_HARDENED"
log "D97BV_FUNCTIONAL_RUNTIME_MUTATION=NO_BUILD_ONLY"
log "D97DI_FUNCTIONAL_BOOTARG=-ocmcd97bv"
log "D97DL_DEPLOY_AUTHORIZED=NO"
log

log "===== HOST ====="
/usr/bin/sw_vers | tee -a "${REPORT}"
/usr/bin/uname -a | tee -a "${REPORT}"
/usr/sbin/sysctl -n machdep.cpu.brand_string 2>/dev/null | sed 's/^/CPU=/' | tee -a "${REPORT}" || true
log

log "===== TOOLCHAIN ====="
XCODE_PATH="$(/usr/bin/xcode-select -p 2>/dev/null || true)"
[[ -n "${XCODE_PATH}" ]] || die "xcode_select_empty"
[[ "${XCODE_PATH}" != "/Library/Developer/CommandLineTools" ]] || die "full_Xcode_not_selected"
log "XCODE_SELECT=${XCODE_PATH}"
/usr/bin/xcodebuild -version | tee -a "${REPORT}"
/usr/bin/clang --version | /usr/bin/head -n 1 | tee -a "${REPORT}"
log

log "===== FETCH AUTHORITATIVE PROJECT STATE ====="
/usr/bin/git clone --quiet "${PROJECT_REPO}" "${PROJECT_SRC}" || die "project_clone_failed"
/usr/bin/git -C "${PROJECT_SRC}" checkout --quiet "${D97DL_AUTHORITY_COMMIT}" || die "authority_checkout_failed"
ACTUAL_AUTHORITY_COMMIT="$(/usr/bin/git -C "${PROJECT_SRC}" rev-parse HEAD)"
log "D97DL_AUTHORITY_COMMIT_EXPECTED=${D97DL_AUTHORITY_COMMIT}"
log "D97DL_AUTHORITY_COMMIT_ACTUAL=${ACTUAL_AUTHORITY_COMMIT}"
[[ "${ACTUAL_AUTHORITY_COMMIT}" == "${D97DL_AUTHORITY_COMMIT}" ]] || die "authority_commit_mismatch"

D97DL_SOURCE="${PROJECT_SRC}/${D97DL_SOURCE_PATH}"
D97DL_AUDIT="${PROJECT_SRC}/${D97DL_AUDIT_PATH}"
[[ -f "${D97DL_SOURCE}" ]] || die "authoritative_D97DL_source_missing"
[[ -f "${D97DL_AUDIT}" ]] || die "authoritative_D97DL_audit_missing"

SOURCE_SHA="$(/usr/bin/shasum -a 256 "${D97DL_SOURCE}" | /usr/bin/awk '{print $1}')"
SOURCE_BLOB="$(/usr/bin/git -C "${PROJECT_SRC}" hash-object "${D97DL_SOURCE_PATH}")"
log "D97DL_SOURCE_SHA_EXPECTED=${EXPECTED_D97DL_SOURCE_SHA}"
log "D97DL_SOURCE_SHA_ACTUAL=${SOURCE_SHA}"
log "D97DL_SOURCE_BLOB_EXPECTED=${EXPECTED_D97DL_SOURCE_BLOB}"
log "D97DL_SOURCE_BLOB_ACTUAL=${SOURCE_BLOB}"
[[ "${SOURCE_SHA}" == "${EXPECTED_D97DL_SOURCE_SHA}" ]] || die "D97DL_source_sha_mismatch"
[[ "${SOURCE_BLOB}" == "${EXPECTED_D97DL_SOURCE_BLOB}" ]] || die "D97DL_source_blob_mismatch"

ACTUAL_INFO_BLOB="$(/usr/bin/git -C "${PROJECT_SRC}" rev-parse "${INFO_HEAD}:${INFO_PATH}")"
log "INFO_BLOB_EXPECTED=${INFO_BLOB}"
log "INFO_BLOB_ACTUAL=${ACTUAL_INFO_BLOB}"
[[ "${ACTUAL_INFO_BLOB}" == "${INFO_BLOB}" ]] || die "Info_plist_blob_mismatch"
/usr/bin/git -C "${PROJECT_SRC}" show "${INFO_HEAD}:${INFO_PATH}" > "${WORK}/Info.plist.authoritative"
log

log "===== SOURCE IDENTITY / SAFETY GATE ====="
for forbidden in \
    'findAndReplace' \
    'findAndReplaceWithMask' \
    'vm_map_write_user' \
    'orgVmMapWriteUser' \
    'injectPayload' \
    'injectSegment' \
    'vmProtect'
do
    if /usr/bin/grep -q "${forbidden}" "${D97DL_SOURCE}"; then
        die "forbidden_source_token_${forbidden}"
    fi
done

for required in \
    'D97CTChannel' \
    'D97DDRouteBuildGateMethod' \
    'D97DDObservedBuild' \
    'D97DDCallbackSeenCount' \
    'D97DIFunctionalBootArg' \
    'D97DIFunctionalMode' \
    'D97DIFunctionalRequested' \
    'D97DISiteSafety' \
    'D97DISiteMutation' \
    'D97DISitePostimage' \
    'D97DISiteWriteCount' \
    'D97DICaveSafety' \
    'D97DICaveMutation' \
    'D97DICavePostimage' \
    'D97DICaveTailZeroAfter' \
    'D97DICaveWriteCount' \
    'D97DLSiteCavePrereq' \
    'WAITING_CAVE' \
    '-ocmcd97bv' \
    '25G82' \
    '/dyld_shared_cache_x86_64h'
do
    /usr/bin/grep -Fq -- "${required}" "${D97DL_SOURCE}" || die "required_source_marker_missing_${required}"
done

/usr/bin/grep -Fq 'checkKernelArgument("-ocmcd97bv")' "${D97DL_SOURCE}" || die "functional_bootarg_gate_missing"
/usr/bin/grep -q 'AppleValidatedAll = 0xF' "${D97DL_SOURCE}" || die "apple_validated_all_gate_missing"
/usr/bin/grep -q 'appleValidationSafe' "${D97DL_SOURCE}" || die "apple_validation_safety_gate_missing"
/usr/bin/grep -q 'SiteReplacement' "${D97DL_SOURCE}" || die "site_replacement_missing"
/usr/bin/grep -q 'CaveReplacement' "${D97DL_SOURCE}" || die "cave_replacement_missing"
/usr/bin/grep -q 'writeExact' "${D97DL_SOURCE}" || die "exact_write_helper_missing"
/usr/bin/grep -q 'const_cast<uint8_t' "${D97DL_SOURCE}" || die "bounded_page_buffer_mutation_cast_missing"
/usr/bin/grep -q 'functionalResolved' "${D97DL_SOURCE}" || die "functional_publisher_resolution_gate_missing"
if /usr/bin/grep -q 'sysctlbyname("kern.osversion"' "${D97DL_SOURCE}"; then die "old_sysctl_build_gate_present"; fi
/usr/bin/grep -Fq 'memory_order_acquire' "${D97DL_SOURCE}" || die "cave_to_site_acquire_missing"
/usr/bin/grep -Fq 'memory_order_release' "${D97DL_SOURCE}" || die "cave_release_missing"
/usr/bin/grep -Fq 'atomic_load_explicit(&d97diCaveMutationState, memory_order_acquire)' "${D97DL_SOURCE}" || die "site_cave_prereq_acquire_load_missing"
/usr/bin/grep -Fq 'D97DLSiteCavePrereq' "${D97DL_SOURCE}" || die "site_cave_prereq_property_missing"
/usr/bin/grep -Fq 'WAITING_CAVE' "${D97DL_SOURCE}" || die "waiting_cave_state_missing"

PREREQ_LINE="$(/usr/bin/grep -n 'const uint32_t caveMutationReady' "${D97DL_SOURCE}" | /usr/bin/head -n1 | /usr/bin/cut -d: -f1)"
SITE_WRITE_LINE="$(/usr/bin/grep -n 'mutablePage + SiteInPage' "${D97DL_SOURCE}" | /usr/bin/head -n1 | /usr/bin/cut -d: -f1)"
[[ -n "${PREREQ_LINE}" && -n "${SITE_WRITE_LINE}" ]] || die "site_order_line_detection_failed"
[[ "${PREREQ_LINE}" -lt "${SITE_WRITE_LINE}" ]] || die "site_write_precedes_cave_prereq_gate"

CAVE_RELEASE_LINE="$(/usr/bin/grep -n -A4 '&d97diCaveMutationState,' "${D97DL_SOURCE}" | /usr/bin/grep 'memory_order_release' | /usr/bin/tail -n1 | /usr/bin/cut -d- -f1)"
[[ -n "${CAVE_RELEASE_LINE}" ]] || die "cave_final_release_store_missing"
log "D97DL_SOURCE_IDENTITY_AND_STATIC_MARKERS=PASS"
log

log "===== FEATUREUNLOCK SCAFFOLD ====="
/usr/bin/git clone --quiet "${FEATUREUNLOCK_REPO}" "${SCAFFOLD}" || die "FeatureUnlock_clone_failed"
/usr/bin/git -C "${SCAFFOLD}" checkout --quiet "${FEATUREUNLOCK_COMMIT}" || die "FeatureUnlock_checkout_failed"
[[ "$(/usr/bin/git -C "${SCAFFOLD}" rev-parse HEAD)" == "${FEATUREUNLOCK_COMMIT}" ]] || die "FeatureUnlock_pin_mismatch"
cp "${D97DL_SOURCE}" "${SCAFFOLD}/FeatureUnlock/kern_start.cpp"
cp "${WORK}/Info.plist.authoritative" "${SCAFFOLD}/FeatureUnlock/Info.plist"
log

log "===== MACKERNELSDK ====="
/usr/bin/git clone --quiet "${MACKERNELSDK_REPO}" "${SCAFFOLD}/MacKernelSDK" || die "MacKernelSDK_clone_failed"
/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" checkout --quiet "${MACKERNELSDK_COMMIT}" || die "MacKernelSDK_checkout_failed"
[[ "$(/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" rev-parse HEAD)" == "${MACKERNELSDK_COMMIT}" ]] || die "MacKernelSDK_pin_mismatch"
log

log "===== BUILD PINNED LILU 1.7.3 ====="
/usr/bin/git clone --quiet "${LILU_REPO}" "${LILU_SRC}" || die "Lilu_clone_failed"
/usr/bin/git -C "${LILU_SRC}" checkout --quiet "${LILU_COMMIT}" || die "Lilu_checkout_failed"
/usr/bin/git clone --quiet "${MACKERNELSDK_REPO}" "${LILU_SRC}/MacKernelSDK" || die "Lilu_MacKernelSDK_clone_failed"
/usr/bin/git -C "${LILU_SRC}/MacKernelSDK" checkout --quiet "${MACKERNELSDK_COMMIT}" || die "Lilu_MacKernelSDK_pin_mismatch"

set +e
(
  cd "${LILU_SRC}"
  /usr/bin/xcodebuild \
    -configuration Debug \
    -arch x86_64 \
    SYMROOT="${LILU_BUILD}" \
    OBJROOT="${WORK}/Lilu-obj" \
    build
) 2>&1 | tee -a "${BUILDLOG}"
LILU_RC=${PIPESTATUS[0]}
set -e
log "LILU_XCODEBUILD_RC=${LILU_RC}"
[[ ${LILU_RC} -eq 0 ]] || die "Lilu_build_failed"

BUILT_LILU="$(/usr/bin/find "${LILU_BUILD}" -type d -name Lilu.kext -print -quit)"
[[ -n "${BUILT_LILU}" ]] || die "built_Lilu_kext_not_found"
LILU_VERSION_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "${BUILT_LILU}/Contents/Info.plist" 2>/dev/null || true)"
log "LILU_VERSION_ACTUAL=${LILU_VERSION_ACTUAL}"
[[ "${LILU_VERSION_ACTUAL}" == "${EXPECTED_LILU_VERSION}" ]] || die "built_Lilu_version_mismatch"
rm -rf "${SCAFFOLD}/Lilu.kext"
cp -R "${BUILT_LILU}" "${SCAFFOLD}/Lilu.kext"
log

log "===== BUILD D97DL 0.0.7 ====="
set +e
(
  cd "${SCAFFOLD}"
  /usr/bin/xcodebuild \
    -project FeatureUnlock.xcodeproj \
    -target FeatureUnlock \
    -configuration Debug \
    -arch x86_64 \
    SYMROOT="${PLUGIN_BUILD}" \
    OBJROOT="${OBJROOT}" \
    PRODUCT_NAME=OCLPMetalCompat \
    PRODUCT_BUNDLE_IDENTIFIER="${PLUGIN_BUNDLE_ID}" \
    MODULE_NAME="${PLUGIN_BUNDLE_ID}" \
    MODULE_VERSION="${PLUGIN_VERSION}" \
    MARKETING_VERSION="${PLUGIN_VERSION}" \
    CURRENT_PROJECT_VERSION="${PLUGIN_VERSION}" \
    build
) 2>&1 | tee -a "${BUILDLOG}"
PLUGIN_RC=${PIPESTATUS[0]}
set -e
log "PLUGIN_XCODEBUILD_RC=${PLUGIN_RC}"
[[ ${PLUGIN_RC} -eq 0 ]] || die "D97DL_plugin_build_failed"

KEXT="$(/usr/bin/find "${PLUGIN_BUILD}" -type d -name OCLPMetalCompat.kext -print -quit)"
[[ -n "${KEXT}" ]] || die "OCLPMetalCompat_kext_not_found"
BIN="${KEXT}/Contents/MacOS/OCLPMetalCompat"
[[ -f "${BIN}" ]] || die "OCLPMetalCompat_executable_not_found"
log "D97DL_COMPILE=PASS"
log

log "===== COMPILED IDENTITY ====="
BUNDLE_ID_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
BUNDLE_VER_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
LILU_REQ_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :OSBundleLibraries:as.vit9696.Lilu' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
[[ "${BUNDLE_ID_ACTUAL}" == "${PLUGIN_BUNDLE_ID}" ]] || die "bundle_id_mismatch"
[[ "${BUNDLE_VER_ACTUAL}" == "${PLUGIN_VERSION}" ]] || die "bundle_version_mismatch"
[[ "${LILU_REQ_ACTUAL}" == "${EXPECTED_LILU_VERSION}" ]] || die "Lilu_dependency_mismatch"

EXEC_SHA="$(/usr/bin/shasum -a 256 "${BIN}" | /usr/bin/awk '{print $1}')"
INFO_SHA="$(/usr/bin/shasum -a 256 "${KEXT}/Contents/Info.plist" | /usr/bin/awk '{print $1}')"
log "BUNDLE_ID=${BUNDLE_ID_ACTUAL}"
log "BUNDLE_VERSION=${BUNDLE_VER_ACTUAL}"
log "EXEC_SHA256=${EXEC_SHA}"
log "BUILT_INFO_SHA256=${INFO_SHA}"
/usr/bin/file "${BIN}" | tee -a "${REPORT}"
/usr/bin/otool -hv "${BIN}" | tee -a "${REPORT}"
/usr/bin/codesign -dvv "${KEXT}" 2>&1 | tee -a "${REPORT}" || true
log

log "===== COMPILED BINARY AUDIT ====="
STRINGS_TMP="${WORK}/strings.txt"
/usr/bin/strings -a "${BIN}" > "${STRINGS_TMP}"

for required in \
    'D97CTChannel' \
    'D97CTRouteStatus' \
    'D97DDRouteBuildGateMethod' \
    'D97DDObservedBuild' \
    'D97DDCallbackSeenCount' \
    'D97DIFunctionalBootArg' \
    'D97DIFunctionalMode' \
    'D97DIFunctionalRequested' \
    'D97DISiteSafety' \
    'D97DISiteMutation' \
    'D97DISitePostimage' \
    'D97DISiteWriteCount' \
    'D97DICaveSafety' \
    'D97DICaveMutation' \
    'D97DICavePostimage' \
    'D97DICaveTailZeroAfter' \
    'D97DICaveWriteCount' \
    'D97DLSiteCavePrereq' \
    'WAITING_CAVE' \
    '-ocmcd97bv' \
    '25G82' \
    '/dyld_shared_cache_x86_64h'
do
    /usr/bin/grep -Fq -- "${required}" "${STRINGS_TMP}" || die "compiled_required_marker_missing_${required}"
done

for forbidden in \
    'vm_map_write_user' \
    'orgVmMapWriteUser' \
    'findAndReplace' \
    'findAndReplaceWithMask' \
    'injectPayload' \
    'injectSegment' \
    'vmProtect'
do
    if /usr/bin/grep -q "${forbidden}" "${STRINGS_TMP}"; then
        die "forbidden_binary_symbol_${forbidden}"
    fi
done

BIN_HEX="${WORK}/binary.hex"
/usr/bin/hexdump -ve '1/1 "%.2x"' "${BIN}" > "${BIN_HEX}"
/usr/bin/grep -q '3dda0e00007406e93bcee9ff90' "${BIN_HEX}" || die "D97BV_site_replacement_bytes_missing"
/usr/bin/grep -q '3d187d0000b9177d00000f4cc1e9b4311600' "${BIN_HEX}" || die "D97BV_cave_replacement_bytes_missing"

log "D97DL_BINARY_FUNCTIONAL_PROTOTYPE_AUDIT=PASS"
log "D97DL_BUILD_STATUS=PASS"
log "DEPLOY_TO_ASUS2_AUTHORIZED=NO"
log "FUNCTIONAL_ARM_OR_EXECUTION_AUTHORIZED=NO"
log "SEND_ZIP_TO_CHATGPT_FOR_AUDIT=YES"
log

cp -R "${KEXT}" "${PACKAGE}/OCLPMetalCompat.kext"
cp "${D97DL_SOURCE}" "${PACKAGE}/kern_start.cpp.authoritative"
cp "${D97DL_AUDIT}" "${PACKAGE}/D97DL_STATIC_ORDERING_AUDIT.md"
cp "${WORK}/Info.plist.authoritative" "${PACKAGE}/Info.plist.authoritative"

(
  cd "${PACKAGE}"
  /usr/bin/find . -type f ! -name SHA256SUMS.txt -print0 | \
    /usr/bin/sort -z | \
    /usr/bin/xargs -0 /usr/bin/shasum -a 256
) > "${MANIFEST}"

(
  cd "${PACKAGE}"
  /usr/bin/zip -qry "${FINAL_ZIP}" .
)

echo
echo "===== FINAL ====="
echo "ZIP=${FINAL_ZIP}"
echo "ZIP_SHA256=$(/usr/bin/shasum -a 256 "${FINAL_ZIP}" | /usr/bin/awk '{print $1}')"
echo "D97DL_BUILD_STATUS=PASS"
echo "DO_NOT_DEPLOY_YET=YES"
