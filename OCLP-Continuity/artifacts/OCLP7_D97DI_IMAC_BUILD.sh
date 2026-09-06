#!/bin/bash
set -euo pipefail

# OCLP7 D97DI — iMac local build of latent functional D97BV plugin
#
# IMAC ONLY.
# NO sudo. NO EFI mutation. NO kext loading. NO Root Patch. NO reboot.
# Output ZIP must be returned to ChatGPT for audit before ASUS2 deployment.

STAMP="$(date +%Y%m%d_%H%M%S)"
DESKTOP="${HOME}/Desktop"
WORK="${DESKTOP}/OCLP7_D97DI_BUILD_${STAMP}"
SCAFFOLD="${WORK}/scaffold"
LILU_SRC="${WORK}/Lilu-src"
LILU_BUILD="${WORK}/Lilu-build"
PLUGIN_BUILD="${WORK}/plugin-build"
OBJROOT="${WORK}/obj"
PACKAGE="${WORK}/package"
REPORT="${PACKAGE}/D97DI_BUILD_REPORT.txt"
BUILDLOG="${PACKAGE}/D97DI_XCODEBUILD.log"
MANIFEST="${PACKAGE}/SHA256SUMS.txt"
FINAL_ZIP="${DESKTOP}/OCLP7_D97DI_IMAC_BUILD_${STAMP}.zip"

D97CT_SOURCE="${HOME}/Downloads/OCLP7_D97DI_kern_start.cpp"

PROJECT_REPO="https://github.com/StefanAlMare/StefanAlMare.git"
PROJECT_BRANCH="oclpmc-d97co-observe-only"
PROJECT_HEAD="8c4904870b8512fe356fcb48e82fb32a9e980634"
INFO_PATH="OCLPMetalCompat/OCLPMetalCompat/Info.plist"
INFO_BLOB="7d6b00ac1e8cbc26396a114c550ccac01c0bc008"

FEATUREUNLOCK_REPO="https://github.com/acidanthera/FeatureUnlock.git"
FEATUREUNLOCK_COMMIT="201bd45766207e6cc10cd40a8ac1f9c6216f9acb"

LILU_REPO="https://github.com/acidanthera/Lilu.git"
LILU_COMMIT="0515f40b7f2a096adc85e832a4c6104fbd07f936"
EXPECTED_LILU_VERSION="1.7.3"

MACKERNELSDK_REPO="https://github.com/acidanthera/MacKernelSDK.git"
MACKERNELSDK_COMMIT="05094e5e88cec7caedbfb35e8449ed0db94bf95b"

PLUGIN_VERSION="0.0.6"
PLUGIN_BUNDLE_ID="com.oclpmetalcompat.OCLPMetalCompat"

mkdir -p "${WORK}" "${PACKAGE}"
touch "${REPORT}" "${BUILDLOG}"

log() { echo "$*" | tee -a "${REPORT}"; }
die() { log "D97DI_BUILD_STATUS=FAIL"; log "FAIL_REASON=$*"; exit 1; }

log "===== OCLP7 D97DI — IMAC LOCAL BUILD ====="
log "SYSTEM_MUTATION=NO"
log "EFI_MUTATION=NO"
log "KEXT_LOAD=NO"
log "ROOT_PATCH=NO"
log "REBOOT=NO"
log "SUDO=NO"
log "D97BV_FUNCTIONAL_PAYLOAD=COMPILED_BUT_LATENT"
log "D97BV_FUNCTIONAL_RUNTIME_MUTATION=NO_BUILD_ONLY"
log "D97DI_FUNCTIONAL_BOOTARG=-ocmcd97bv"
log "D97DI_DOUBLE_GATED_FUNCTIONAL_DESIGN=YES"
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

log "===== D97DI SOURCE ====="
[[ -f "${D97CT_SOURCE}" ]] || die "D97DI_source_not_in_Downloads"
SOURCE_SHA="$(/usr/bin/shasum -a 256 "${D97CT_SOURCE}" | /usr/bin/awk '{print $1}')"
log "D97DI_SOURCE_PATH=${D97CT_SOURCE}"
log "D97DI_SOURCE_SHA256=${SOURCE_SHA}"
[[ "${SOURCE_SHA}" == "932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b" ]] || die "D97DI_source_sha_mismatch"

for forbidden in \
    'findAndReplace' \
    'findAndReplaceWithMask' \
    'vm_map_write_user' \
    'orgVmMapWriteUser' \
    'injectPayload' \
    'injectSegment' \
    'vmProtect'
do
    if /usr/bin/grep -q "${forbidden}" "${D97CT_SOURCE}"; then
        die "forbidden_source_token_${forbidden}"
    fi
done

/usr/bin/grep -q 'D97CTChannel' "${D97CT_SOURCE}" || die "persistent_channel_missing"
/usr/bin/grep -q 'D97DDRouteBuildGateMethod' "${D97CT_SOURCE}" || die "runtime_proven_route_marker_missing"
/usr/bin/grep -q 'D97DDObservedBuild' "${D97CT_SOURCE}" || die "runtime_proven_build_marker_missing"
/usr/bin/grep -q 'D97DDCallbackSeenCount' "${D97CT_SOURCE}" || die "runtime_proven_callback_marker_missing"
/usr/bin/grep -q 'D97DIFunctionalBootArg' "${D97CT_SOURCE}" || die "functional_bootarg_property_missing"
/usr/bin/grep -q 'D97DIFunctionalMode' "${D97CT_SOURCE}" || die "functional_mode_property_missing"
/usr/bin/grep -q 'D97DISiteMutation' "${D97CT_SOURCE}" || die "site_mutation_property_missing"
/usr/bin/grep -q 'D97DICaveMutation' "${D97CT_SOURCE}" || die "cave_mutation_property_missing"
/usr/bin/grep -q 'D97DISitePostimage' "${D97CT_SOURCE}" || die "site_postimage_property_missing"
/usr/bin/grep -q 'D97DICavePostimage' "${D97CT_SOURCE}" || die "cave_postimage_property_missing"
/usr/bin/grep -Fq 'checkKernelArgument("-ocmcd97bv")' "${D97CT_SOURCE}" || die "functional_bootarg_gate_missing"
/usr/bin/grep -q 'AppleValidatedAll = 0xF' "${D97CT_SOURCE}" || die "apple_validated_all_gate_missing"
/usr/bin/grep -q 'appleValidationSafe' "${D97CT_SOURCE}" || die "apple_validation_safety_gate_missing"
/usr/bin/grep -q 'SiteReplacement' "${D97CT_SOURCE}" || die "site_replacement_array_missing"
/usr/bin/grep -q 'CaveReplacement' "${D97CT_SOURCE}" || die "cave_replacement_array_missing"
/usr/bin/grep -q 'writeExact' "${D97CT_SOURCE}" || die "exact_write_helper_missing"
/usr/bin/grep -q 'const_cast<uint8_t' "${D97CT_SOURCE}" || die "page_buffer_mutation_cast_missing"
/usr/bin/grep -q 'functionalResolved' "${D97CT_SOURCE}" || die "functional_publisher_resolution_gate_missing"
if /usr/bin/grep -q '<libkern/version.h>' "${D97CT_SOURCE}"; then die "conflicting_libkern_version_header_present"; fi
/usr/bin/grep -Fq 'extern "C" char osversion[];' "${D97CT_SOURCE}" || die "kernel_global_osversion_c_linkage_missing"
/usr/bin/grep -q 'osversion' "${D97CT_SOURCE}" || die "kernel_global_osversion_missing"
if /usr/bin/grep -q 'sysctlbyname("kern.osversion"' "${D97CT_SOURCE}"; then die "old_early_sysctl_build_gate_present"; fi
/usr/bin/grep -q 'atomic_fetch_add_explicit(&d97ddCallbackSeenCount' "${D97CT_SOURCE}" || die "callback_counter_update_missing"
/usr/bin/grep -q 'atomic_store_explicit(&buildGate, buildOk ? 1U : 2U' "${D97CT_SOURCE}" || die "callback_build_gate_store_missing"
/usr/bin/grep -q 'D97CTSiteSeenCount' "${D97CT_SOURCE}" || die "site_property_missing"
/usr/bin/grep -q 'D97CTCaveSeenCount' "${D97CT_SOURCE}" || die "cave_property_missing"
/usr/bin/grep -q 'thread_call_allocate' "${D97CT_SOURCE}" || die "async_publisher_missing"
/usr/bin/grep -q '_Atomic(uint32_t)' "${D97CT_SOURCE}" || die "atomic_type_syntax_missing"
/usr/bin/grep -q 'ATOMIC_VAR_INIT(0)' "${D97CT_SOURCE}" || die "atomic_initializer_missing"
/usr/bin/grep -q 'atomic_fetch_add_explicit' "${D97CT_SOURCE}" || die "atomic_state_missing"
log "D97DI_SOURCE_STATIC_GATE=PASS"
log

log "===== AUTHORITATIVE INFO.PLST SOURCE ====="
/usr/bin/git clone --quiet --branch "${PROJECT_BRANCH}" "${PROJECT_REPO}" "${WORK}/project-source" || die "project_clone_failed"
/usr/bin/git -C "${WORK}/project-source" checkout --quiet "${PROJECT_HEAD}" || die "project_checkout_failed"
ACTUAL_HEAD="$(/usr/bin/git -C "${WORK}/project-source" rev-parse HEAD)"
[[ "${ACTUAL_HEAD}" == "${PROJECT_HEAD}" ]] || die "project_head_mismatch"
ACTUAL_INFO_BLOB="$(/usr/bin/git -C "${WORK}/project-source" hash-object "${INFO_PATH}")"
log "PROJECT_HEAD=${ACTUAL_HEAD}"
log "INFO_BLOB_EXPECTED=${INFO_BLOB}"
log "INFO_BLOB_ACTUAL=${ACTUAL_INFO_BLOB}"
[[ "${ACTUAL_INFO_BLOB}" == "${INFO_BLOB}" ]] || die "Info_plist_blob_mismatch"
log

log "===== FEATUREUNLOCK SCAFFOLD ====="
/usr/bin/git clone --quiet "${FEATUREUNLOCK_REPO}" "${SCAFFOLD}" || die "FeatureUnlock_clone_failed"
/usr/bin/git -C "${SCAFFOLD}" checkout --quiet "${FEATUREUNLOCK_COMMIT}" || die "FeatureUnlock_checkout_failed"
[[ "$(/usr/bin/git -C "${SCAFFOLD}" rev-parse HEAD)" == "${FEATUREUNLOCK_COMMIT}" ]] || die "FeatureUnlock_pin_mismatch"

cp "${D97CT_SOURCE}" "${SCAFFOLD}/FeatureUnlock/kern_start.cpp"
cp "${WORK}/project-source/${INFO_PATH}" "${SCAFFOLD}/FeatureUnlock/Info.plist"
log

log "===== MACKERNELSDK ====="
/usr/bin/git clone --quiet "${MACKERNELSDK_REPO}" "${SCAFFOLD}/MacKernelSDK" || die "MacKernelSDK_clone_failed"
/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" checkout --quiet "${MACKERNELSDK_COMMIT}" || die "MacKernelSDK_checkout_failed"
[[ "$(/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" rev-parse HEAD)" == "${MACKERNELSDK_COMMIT}" ]] || die "MacKernelSDK_pin_mismatch"
log

log "===== BUILD PINNED LILU 1.7.3 SDK ====="
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

log "===== BUILD D97DI ====="
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
[[ ${PLUGIN_RC} -eq 0 ]] || die "D97DI_plugin_build_failed"

KEXT="$(/usr/bin/find "${PLUGIN_BUILD}" -type d -name OCLPMetalCompat.kext -print -quit)"
[[ -n "${KEXT}" ]] || die "OCLPMetalCompat_kext_not_found"
BIN="${KEXT}/Contents/MacOS/OCLPMetalCompat"
[[ -f "${BIN}" ]] || die "OCLPMetalCompat_executable_not_found"
log "D97DI_COMPILE=PASS"
log

log "===== BINARY AUDIT ====="
BUNDLE_ID_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
BUNDLE_VER_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
LILU_REQ_ACTUAL="$(/usr/libexec/PlistBuddy -c 'Print :OSBundleLibraries:as.vit9696.Lilu' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
[[ "${BUNDLE_ID_ACTUAL}" == "${PLUGIN_BUNDLE_ID}" ]] || die "bundle_id_mismatch"
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

STRINGS_TMP="${WORK}/strings.txt"
/usr/bin/strings -a "${BIN}" > "${STRINGS_TMP}"

for required in \
    'D97CTChannel' \
    'D97CTRouteStatus' \
    'D97CTSiteSeenCount' \
    'D97CTSitePreimage' \
    'D97CTCaveSeenCount' \
    'D97CTCaveWindow18' \
    'D97CTCaveFull208' \
    'IORegistry-AtomicAsync-v1' \
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
    '-ocmcd97bv'
do
    /usr/bin/grep -q -- "${required}" "${STRINGS_TMP}" || die "compiled_required_marker_missing_${required}"
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

# Exact D97BV functional replacement payloads must be compiled in the latent build.
HEXBIN="${WORK}/binary.hex"
/usr/bin/hexdump -ve '1/1 "%.2x"' "${BIN}" > "${HEXBIN}"
/usr/bin/grep -q '3dda0e00007406e93bcee9ff90' "${HEXBIN}" || die "D97BV_site_replacement_bytes_missing"
/usr/bin/grep -q '3d187d0000b9177d00000f4cc1e9b4311600' "${HEXBIN}" || die "D97BV_cave_replacement_bytes_missing"

log "D97DI_BINARY_LATENT_FUNCTIONAL_PAYLOAD_AUDIT=PASS"
log "D97DI_BUILD_STATUS=PASS"
log "DEPLOY_TO_ASUS2_AUTHORIZED=NO"
log "SEND_ZIP_TO_CHATGPT_FOR_AUDIT=YES"
log

cp -R "${KEXT}" "${PACKAGE}/OCLPMetalCompat.kext"
cp "${D97CT_SOURCE}" "${PACKAGE}/kern_start.cpp.authoritative"
cp "${WORK}/project-source/${INFO_PATH}" "${PACKAGE}/Info.plist.authoritative"

# Manifest is generated after the report is complete.
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
echo "D97DI_BUILD_STATUS=PASS"
echo "DO_NOT_DEPLOY_YET=YES"
