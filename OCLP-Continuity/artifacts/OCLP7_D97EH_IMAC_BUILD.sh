#!/bin/bash
set -euo pipefail

# OCLP7 D97EH — iMac Intel local build only.
# No EFI / Root Patch / NVRAM / reboot / target mutation.

STAMP="$(date +%Y%m%d_%H%M%S)"
DESKTOP="${HOME}/Desktop"
WORK="${DESKTOP}/OCLP7_D97EH_BUILD_${STAMP}"
PROJECT="${WORK}/project"
SCAFFOLD="${WORK}/scaffold"
LILU_SRC="${WORK}/Lilu-src"
LILU_BUILD="${WORK}/Lilu-build"
PLUGIN_BUILD="${WORK}/plugin-build"
PACKAGE="${WORK}/package"
REPORT="${PACKAGE}/D97EH_BUILD_REPORT.txt"
LOG="${PACKAGE}/D97EH_XCODEBUILD.log"
ZIP="${DESKTOP}/OCLP7_D97EH_IMAC_BUILD_${STAMP}.zip"

PROJECT_REPO="https://github.com/StefanAlMare/StefanAlMare.git"
GEN_COMMIT="ce73ee2e09edb5d907adf64243251c513fff085a"
GEN_PATH="OCLP-Continuity/artifacts/OCLP7_D97EH_SOURCE_GENERATOR.py"
GEN_SHA="fed0d21e974a70a3dacad9e86261ecde28dc5f2fbb8f2e4c8c94bf08102a1144"

BASE_COMMIT="72dbc5f29aedf4f8190700de9f1c2c45f949b56f"
BASE_PATH="OCLP-Continuity/artifacts/OCLP7_D97DL_kern_start.cpp"
BASE_SHA="f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2"

INFO_HEAD="8c4904870b8512fe356fcb48e82fb32a9e980634"
INFO_PATH="OCLPMetalCompat/OCLPMetalCompat/Info.plist"

FEATURE_REPO="https://github.com/acidanthera/FeatureUnlock.git"
FEATURE_COMMIT="201bd45766207e6cc10cd40a8ac1f9c6216f9acb"
LILU_REPO="https://github.com/acidanthera/Lilu.git"
LILU_COMMIT="0515f40b7f2a096adc85e832a4c6104fbd07f936"
SDK_REPO="https://github.com/acidanthera/MacKernelSDK.git"
SDK_COMMIT="05094e5e88cec7caedbfb35e8449ed0db94bf95b"

mkdir -p "${WORK}" "${PACKAGE}"
: > "${REPORT}"
: > "${LOG}"
log(){ echo "$*" | tee -a "${REPORT}"; }
die(){ log "D97EH_BUILD_STATUS=FAIL"; log "FAIL_REASON=$*"; exit 1; }

log "===== D97EH BUILD ====="
log "HOST_REQUIRED=INTEL_IMAC"
log "PLUGIN_VERSION=0.0.9"
log "D97BV_PRESERVED=YES"
log "OBSERVER_SYMBOL=__ZN14IOAccelSurface11set_id_modeEjj"
log "OBSERVER_BOOTARG=-ocmcd97eh"
log "MODE_MUTATION=NO"
log "RETURN_COERCION=NO"
log "DEPLOYMENT_AUTHORIZED=NO"

[[ "$(/usr/bin/uname -m)" == "x86_64" ]] || die "host_not_x86_64"
XCODE="$(/usr/bin/xcode-select -p 2>/dev/null || true)"
[[ -n "${XCODE}" && "${XCODE}" != "/Library/Developer/CommandLineTools" ]] || die "full_Xcode_not_selected"
/usr/bin/xcodebuild -version | tee -a "${REPORT}"

PY=""
for P in /usr/local/bin/python3.13 /usr/bin/python3 "$(command -v python3 2>/dev/null || true)"; do
  [[ -n "${P}" && -x "${P}" ]] && { PY="${P}"; break; }
done
[[ -n "${PY}" ]] || die "python3_missing"
log "PYTHON=${PY}"

log "===== FETCH AUTHORITY ====="
/usr/bin/git clone --quiet "${PROJECT_REPO}" "${PROJECT}" || die "project_clone_failed"
/usr/bin/git -C "${PROJECT}" show "${GEN_COMMIT}:${GEN_PATH}" > "${WORK}/generator.py" || die "generator_fetch_failed"
/usr/bin/git -C "${PROJECT}" show "${BASE_COMMIT}:${BASE_PATH}" > "${WORK}/D97DL.cpp" || die "base_fetch_failed"
/usr/bin/git -C "${PROJECT}" show "${INFO_HEAD}:${INFO_PATH}" > "${WORK}/Info.plist" || die "Info_fetch_failed"

[[ "$(/usr/bin/shasum -a 256 "${WORK}/generator.py" | awk '{print $1}')" == "${GEN_SHA}" ]] || die "generator_sha_mismatch"
[[ "$(/usr/bin/shasum -a 256 "${WORK}/D97DL.cpp" | awk '{print $1}')" == "${BASE_SHA}" ]] || die "base_sha_mismatch"

"${PY}" "${WORK}/generator.py" "${WORK}/D97DL.cpp" "${WORK}/D97EH.cpp" | tee -a "${REPORT}"
SRC="${WORK}/D97EH.cpp"
SRC_SHA="$(/usr/bin/shasum -a 256 "${SRC}" | awk '{print $1}')"
log "D97EH_SOURCE_SHA256=${SRC_SHA}"
log "D97EH_SOURCE_BYTES=$(/usr/bin/stat -f '%z' "${SRC}")"

/usr/bin/grep -Fq '__ZN14IOAccelSurface11set_id_modeEjj' "${SRC}" || die "symbol_missing"
/usr/bin/grep -Fq 'FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode)' "${SRC}" || die "exact_passthrough_missing"
/usr/bin/grep -Fq 'return ret;' "${SRC}" || die "return_passthrough_missing"
/usr/bin/grep -Fq 'checkKernelArgument("-ocmcd97eh")' "${SRC}" || die "observer_gate_missing"
/usr/bin/grep -Fq 'call <= 32U' "${SRC}" || die "bounded_log_missing"
for BAD in 'patchedMode' '~0xff8073c0' '~0xFF8073C0' 'mode &=' 'return kIOReturnSuccess'; do
  ! /usr/bin/grep -Fq -- "${BAD}" "${SRC}" || die "functional_mutation_token_${BAD}"
done
log "STATIC_OBSERVER_ONLY_AUDIT=PASS"

log "===== SCAFFOLD ====="
/usr/bin/git clone --quiet "${FEATURE_REPO}" "${SCAFFOLD}" || die "Feature_clone_failed"
/usr/bin/git -C "${SCAFFOLD}" checkout --quiet "${FEATURE_COMMIT}" || die "Feature_pin_failed"
/usr/bin/git clone --quiet "${SDK_REPO}" "${SCAFFOLD}/MacKernelSDK" || die "SDK_clone_failed"
/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" checkout --quiet "${SDK_COMMIT}" || die "SDK_pin_failed"
cp "${SRC}" "${SCAFFOLD}/FeatureUnlock/kern_start.cpp"
cp "${WORK}/Info.plist" "${SCAFFOLD}/FeatureUnlock/Info.plist"

log "===== LILU ====="
/usr/bin/git clone --quiet "${LILU_REPO}" "${LILU_SRC}" || die "Lilu_clone_failed"
/usr/bin/git -C "${LILU_SRC}" checkout --quiet "${LILU_COMMIT}" || die "Lilu_pin_failed"
/usr/bin/git clone --quiet "${SDK_REPO}" "${LILU_SRC}/MacKernelSDK" || die "Lilu_SDK_clone_failed"
/usr/bin/git -C "${LILU_SRC}/MacKernelSDK" checkout --quiet "${SDK_COMMIT}" || die "Lilu_SDK_pin_failed"
set +e
(cd "${LILU_SRC}" && /usr/bin/xcodebuild -configuration Debug -arch x86_64 \
 SYMROOT="${LILU_BUILD}" OBJROOT="${WORK}/Lilu-obj" build) 2>&1 | tee -a "${LOG}"
RC=${PIPESTATUS[0]}; set -e
[[ ${RC} -eq 0 ]] || die "Lilu_build_failed"
LK="$(/usr/bin/find "${LILU_BUILD}" -type d -name Lilu.kext -print -quit)"
[[ -n "${LK}" ]] || die "Lilu_kext_missing"
rm -rf "${SCAFFOLD}/Lilu.kext"; cp -R "${LK}" "${SCAFFOLD}/Lilu.kext"

log "===== D97EH 0.0.9 ====="
set +e
(cd "${SCAFFOLD}" && /usr/bin/xcodebuild -project FeatureUnlock.xcodeproj -target FeatureUnlock \
 -configuration Debug -arch x86_64 SYMROOT="${PLUGIN_BUILD}" OBJROOT="${WORK}/obj" \
 PRODUCT_NAME=OCLPMetalCompat PRODUCT_BUNDLE_IDENTIFIER=com.oclpmetalcompat.OCLPMetalCompat \
 MODULE_NAME=com.oclpmetalcompat.OCLPMetalCompat MODULE_VERSION=0.0.9 \
 MARKETING_VERSION=0.0.9 CURRENT_PROJECT_VERSION=0.0.9 build) 2>&1 | tee -a "${LOG}"
RC=${PIPESTATUS[0]}; set -e
[[ ${RC} -eq 0 ]] || die "plugin_build_failed"

KEXT="$(/usr/bin/find "${PLUGIN_BUILD}" -type d -name OCLPMetalCompat.kext -print -quit)"
[[ -n "${KEXT}" ]] || die "plugin_kext_missing"
EXEC="${KEXT}/Contents/MacOS/OCLPMetalCompat"
[[ -f "${EXEC}" ]] || die "plugin_exec_missing"

VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "${KEXT}/Contents/Info.plist" 2>/dev/null || true)"
ARCH="$(/usr/bin/lipo -archs "${EXEC}" 2>/dev/null || true)"
UUID="$(/usr/bin/dwarfdump --uuid "${EXEC}" 2>/dev/null | awk 'NR==1{print $2}')"
EXSHA="$(/usr/bin/shasum -a 256 "${EXEC}" | awk '{print $1}')"
log "VERSION=${VER}"
log "ARCHS=${ARCH}"
log "UUID=${UUID}"
log "EXEC_SHA256=${EXSHA}"
[[ "${VER}" == "0.0.9" ]] || die "version_mismatch"
[[ "${ARCH}" == *x86_64* ]] || die "x86_64_missing"
/usr/bin/strings -a "${EXEC}" | /usr/bin/grep -Fq 'D97EH_SET_ID_MODE' || die "binary_marker_missing"
/usr/bin/strings -a "${EXEC}" | /usr/bin/grep -Fq -- '-ocmcd97eh' || die "binary_bootarg_missing"
/usr/bin/strings -a "${EXEC}" | /usr/bin/grep -Fq '__ZN14IOAccelSurface11set_id_modeEjj' || die "binary_symbol_missing"
log "BINARY_MARKER_AUDIT=PASS"

cp -R "${KEXT}" "${PACKAGE}/OCLPMetalCompat.kext"
cp "${SRC}" "${PACKAGE}/OCLP7_D97EH_kern_start.cpp"
cp "${WORK}/generator.py" "${PACKAGE}/OCLP7_D97EH_SOURCE_GENERATOR.py"
(cd "${PACKAGE}" && /usr/bin/find . -type f -print0 | /usr/bin/xargs -0 /usr/bin/shasum -a 256 > SHA256SUMS.txt)

rm -f "${ZIP}"
/usr/bin/ditto -c -k --keepParent "${PACKAGE}" "${ZIP}"
ZSHA="$(/usr/bin/shasum -a 256 "${ZIP}" | awk '{print $1}')"
ZBYTES="$(/usr/bin/stat -f '%z' "${ZIP}")"
log "D97EH_BUILD_STATUS=PASS"
log "FINAL_ZIP=${ZIP}"
log "FINAL_ZIP_BYTES=${ZBYTES}"
log "FINAL_ZIP_SHA256=${ZSHA}"
log "DEPLOYMENT_AUTHORIZED=NO"
log "ACCELERATED_BOOT_AUTHORIZED=NO"

echo
echo "D97EH_BUILD_STATUS=PASS"
echo "FINAL_ZIP=${ZIP}"
echo "FINAL_ZIP_BYTES=${ZBYTES}"
echo "FINAL_ZIP_SHA256=${ZSHA}"
