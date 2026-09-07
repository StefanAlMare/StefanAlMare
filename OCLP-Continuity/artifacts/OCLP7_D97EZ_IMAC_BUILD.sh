#!/bin/bash
set -euo pipefail

# OCLP7 D97EZ 0.0.12 — authorized LOCAL Intel-iMac build helper.
# User explicitly authorized local compilation on 2026-09-07 while GitHub Actions
# execution/quota is unavailable. This helper NEVER deploys to ASUS2, never Root
# Patches, never changes EFI/NVRAM/boot args and never reboots.

STAMP="$(date +%Y%m%d_%H%M%S)"
DESKTOP="${HOME}/Desktop"
WORK="${DESKTOP}/OCLP7_D97EZ_BUILD_${STAMP}"
PROJECT="${WORK}/project"
SCAFFOLD="${WORK}/scaffold"
LILU_SRC="${WORK}/Lilu-src"
LILU_BUILD="${WORK}/Lilu-build"
PLUGIN_BUILD="${WORK}/plugin-build"
PACKAGE="${WORK}/package"
REPORT="${PACKAGE}/D97EZ_BUILD_REPORT.txt"
LOG="${PACKAGE}/D97EZ_XCODEBUILD.log"
ZIP="${DESKTOP}/OCLP7_D97EZ_IMAC_BUILD_${STAMP}.zip"
ZIP_SHA_FILE="${ZIP}.sha256"

PROJECT_REPO="https://github.com/StefanAlMare/StefanAlMare.git"

BASE_COMMIT="72dbc5f29aedf4f8190700de9f1c2c45f949b56f"
BASE_PATH="OCLP-Continuity/artifacts/OCLP7_D97DL_kern_start.cpp"
BASE_SHA256="f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2"

EH_GEN_COMMIT="ce73ee2e09edb5d907adf64243251c513fff085a"
EH_GEN_PATH="OCLP-Continuity/artifacts/OCLP7_D97EH_SOURCE_GENERATOR.py"
EH_GEN_SHA256="fed0d21e974a70a3dacad9e86261ecde28dc5f2fbb8f2e4c8c94bf08102a1144"
EH_SOURCE_SHA256="2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d"

EL_GEN_COMMIT="1fb87c18169a9bd1b74c2b3ff67badc77449c1d4"
EL_GEN_PATH="OCLP-Continuity/artifacts/OCLP7_D97EL_TELEMETRY_GENERATOR.py"
EL_GEN_BLOB="16fdcd6de0de7681a2abdf4c30716fb81a0d0f3e"
EL_SOURCE_SHA256="3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003"

ES_GEN_COMMIT="62fac73c0d834be92bcab208234112a4b046e385"
ES_GEN_PATH="OCLP-Continuity/artifacts/OCLP7_D97ES_IOREG_TUPLE_GENERATOR.py"
ES_GEN_BLOB="dc7e244c3734f5dd0cd6f24d6d8c43da76d41fad"
ES_SOURCE_SHA256="8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0"

EZ_GEN_COMMIT="cd76d912018bfa60284af3cb732ae8bca84db091"
EZ_GEN_PATH="OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py"
EZ_GEN_BLOB="3bf728b999e2163af77742686d7ce9aaac04e8fb"

INFO_COMMIT="8c4904870b8512fe356fcb48e82fb32a9e980634"
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
die(){ log "D97EZ_BUILD_STATUS=FAIL"; log "FAIL_REASON=$*"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

log "===== OCLP7 D97EZ LOCAL INTEL IMAC BUILD ====="
log "DATE_LOCAL=$(date '+%Y-%m-%dT%H:%M:%S%z')"
log "HOST_REQUIRED=INTEL_MAC_X86_64"
log "LOCAL_COMPILE_EXPLICITLY_AUTHORIZED=YES"
log "GITHUB_ACTIONS_BUILD=NO_QUOTA_BLOCKED"
log "PLUGIN_VERSION=0.0.12"
log "BASELINE=P1+P2b+P3+AIR00+D34"
log "D97BV_PRESERVED=YES"
log "D97ES_LINEAGE_REQUIRED=YES"
log "D97EZ_DEFAULT_MODE=LATENT"
log "D97EZ_FUNCTIONAL_BOOTARG=-ocmcd97ez"
log "D97EZ_EXACT_TRANSLATION=0x224_TO_0x24_ONLY"
log "GLOBAL_MASK=NO"
log "RETURN_COERCION=NO"
log "ID_REWRITE=NO"
log "ROOT_PATCH=AUTO-NO"
log "EFI_DEPLOY=AUTO-NO"
log "NVRAM_MUTATION=AUTO-NO"
log "REBOOT=AUTO-NO"

[[ "$(/usr/bin/uname -s)" == "Darwin" ]] || die "host_not_Darwin"
[[ "$(/usr/bin/uname -m)" == "x86_64" ]] || die "host_not_x86_64"
log "HOST_UNAME=$(/usr/bin/uname -a)"

XCODE_PATH="$(/usr/bin/xcode-select -p 2>/dev/null || true)"
[[ -n "${XCODE_PATH}" && "${XCODE_PATH}" != "/Library/Developer/CommandLineTools" ]] || die "full_Xcode_not_selected"
/usr/bin/xcodebuild -version | tee -a "${REPORT}"
/usr/bin/xcrun --find clang >/dev/null 2>&1 || die "clang_missing"
/usr/bin/git --version | tee -a "${REPORT}"

PY=""
for P in /usr/local/bin/python3 /opt/homebrew/bin/python3 /usr/bin/python3 "$(command -v python3 2>/dev/null || true)"; do
    [[ -n "${P}" && -x "${P}" ]] && { PY="${P}"; break; }
done
[[ -n "${PY}" ]] || die "python3_missing"
log "PYTHON=${PY}"
"${PY}" --version 2>&1 | tee -a "${REPORT}"

log "===== FETCH EXACT PROJECT AUTHORITY ====="
/usr/bin/git clone --quiet "${PROJECT_REPO}" "${PROJECT}" || die "project_clone_failed"

fetch_git_file(){
    local commit="$1" path="$2" out="$3"
    /usr/bin/git -C "${PROJECT}" cat-file -e "${commit}^{commit}" 2>/dev/null || die "missing_commit_${commit}"
    /usr/bin/git -C "${PROJECT}" show "${commit}:${path}" > "${out}" || die "fetch_failed_${path}"
}

fetch_git_file "${BASE_COMMIT}" "${BASE_PATH}" "${WORK}/D97DL.cpp"
fetch_git_file "${EH_GEN_COMMIT}" "${EH_GEN_PATH}" "${WORK}/D97EH_generator.py"
fetch_git_file "${EL_GEN_COMMIT}" "${EL_GEN_PATH}" "${WORK}/D97EL_generator.py"
fetch_git_file "${ES_GEN_COMMIT}" "${ES_GEN_PATH}" "${WORK}/D97ES_generator.py"
fetch_git_file "${EZ_GEN_COMMIT}" "${EZ_GEN_PATH}" "${WORK}/D97EZ_generator.py"
fetch_git_file "${INFO_COMMIT}" "${INFO_PATH}" "${WORK}/Info.plist"

[[ "$(sha256 "${WORK}/D97DL.cpp")" == "${BASE_SHA256}" ]] || die "D97DL_sha_mismatch"
[[ "$(sha256 "${WORK}/D97EH_generator.py")" == "${EH_GEN_SHA256}" ]] || die "D97EH_generator_sha_mismatch"
[[ "$(/usr/bin/git -C "${PROJECT}" rev-parse "${EL_GEN_COMMIT}:${EL_GEN_PATH}")" == "${EL_GEN_BLOB}" ]] || die "D97EL_generator_blob_mismatch"
[[ "$(/usr/bin/git -C "${PROJECT}" rev-parse "${ES_GEN_COMMIT}:${ES_GEN_PATH}")" == "${ES_GEN_BLOB}" ]] || die "D97ES_generator_blob_mismatch"
[[ "$(/usr/bin/git -C "${PROJECT}" rev-parse "${EZ_GEN_COMMIT}:${EZ_GEN_PATH}")" == "${EZ_GEN_BLOB}" ]] || die "D97EZ_generator_blob_mismatch"

log "D97DL_SHA256=$(sha256 "${WORK}/D97DL.cpp")"
log "D97EH_GENERATOR_SHA256=$(sha256 "${WORK}/D97EH_generator.py")"
log "D97EL_GENERATOR_BLOB=${EL_GEN_BLOB}"
log "D97ES_GENERATOR_BLOB=${ES_GEN_BLOB}"
log "D97EZ_GENERATOR_COMMIT=${EZ_GEN_COMMIT}"
log "D97EZ_GENERATOR_BLOB=${EZ_GEN_BLOB}"
log "D97EZ_GENERATOR_SHA256=$(sha256 "${WORK}/D97EZ_generator.py")"

log "===== RECONSTRUCT EXACT D97ES LINEAGE ====="
"${PY}" "${WORK}/D97EH_generator.py" "${WORK}/D97DL.cpp" "${WORK}/D97EH.cpp" | tee -a "${REPORT}"
[[ "$(sha256 "${WORK}/D97EH.cpp")" == "${EH_SOURCE_SHA256}" ]] || die "D97EH_source_sha_mismatch"

"${PY}" "${WORK}/D97EL_generator.py" "${WORK}/D97EH.cpp" "${WORK}/D97EL.cpp" | tee -a "${REPORT}"
[[ "$(sha256 "${WORK}/D97EL.cpp")" == "${EL_SOURCE_SHA256}" ]] || die "D97EL_source_sha_mismatch"

"${PY}" "${WORK}/D97ES_generator.py" "${WORK}/D97EL.cpp" "${WORK}/D97ES.cpp" | tee -a "${REPORT}"
[[ "$(sha256 "${WORK}/D97ES.cpp")" == "${ES_SOURCE_SHA256}" ]] || die "D97ES_source_sha_mismatch"
log "D97ES_LINEAGE_RECONSTRUCTION=PASS"

log "===== GENERATE D97EZ DETERMINISTICALLY ====="
"${PY}" "${WORK}/D97EZ_generator.py" "${WORK}/D97ES.cpp" "${WORK}/D97EZ.cpp" | tee -a "${REPORT}"
"${PY}" "${WORK}/D97EZ_generator.py" "${WORK}/D97ES.cpp" "${WORK}/D97EZ.repeat.cpp" > "${WORK}/D97EZ_repeat.log"
/usr/bin/cmp -s "${WORK}/D97EZ.cpp" "${WORK}/D97EZ.repeat.cpp" || die "D97EZ_generation_nondeterministic"
EZ_SOURCE_SHA256="$(sha256 "${WORK}/D97EZ.cpp")"
EZ_SOURCE_BYTES="$(/usr/bin/stat -f '%z' "${WORK}/D97EZ.cpp")"
log "D97EZ_SOURCE_SHA256=${EZ_SOURCE_SHA256}"
log "D97EZ_SOURCE_BYTES=${EZ_SOURCE_BYTES}"
log "D97EZ_DETERMINISTIC_GENERATION=PASS"

log "===== SOURCE SEMANTIC AUDIT ====="
"${PY}" - "${WORK}/D97EZ.cpp" <<'PY' | tee -a "${REPORT}"
from pathlib import Path
import sys
p = Path(sys.argv[1])
src = p.read_text()
start = src.index('static IOReturn patchedSetIdMode(')
end = src.index('\nstatic void processD97EHKext(', start)
fn = src[start:end]
assert fn.count('const uint32_t originalMode = mode;') == 1
assert fn.count('originalMode == 0x00000224U') == 1
assert fn.count('(functionalActive && exact224) ? 0x00000024U : originalMode') == 1
assert fn.count('FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, passedMode)') == 1
assert fn.count('return ret;') == 1
assert 'mode &=' not in fn
assert '~0x200' not in fn and '~0x00000200' not in fn
assert 'return kIOReturnSuccess' not in fn
assert 'id =' not in fn and 'id &=' not in fn and 'that =' not in fn
assert 'd97ezExact224SeenCount' in fn
assert 'd97ezOtherModeSeenCount' in fn
assert 'd97ezExact224AdaptedCount' in fn
assert 'd97ezAdaptSuccessCount' in fn and 'd97ezAdaptFailureCount' in fn
assert 'd97ezPassthroughSuccessCount' in fn and 'd97ezPassthroughFailureCount' in fn
for token in (
    'checkKernelArgument("-ocmcd97ez")',
    'D97EZFunctionalMode',
    'D97EZExact224SeenCount',
    'D97EZExact224AdaptedCount',
    'D97EZOtherModeSeenCount',
    'D97EZAdaptSuccessCount',
    'D97EZAdaptFailureCount',
    'D97EZPassthroughSuccessCount',
    'D97EZPassthroughFailureCount',
    'D97EZ01PassedMode',
    'atomic_store_explicit(&d97esMode[slot], originalMode',
    'atomic_store_explicit(&d97ezPassedMode[slot], passedMode',
    'lilu.onKextLoadForce(&kextIOAcceleratorFamily2);',
):
    assert token in src, token
assert src.count('0x00000224U') == 1
assert src.count('0x00000024U') == 1
print('D97EZ_EXACT_224_ONLY_SOURCE=PASS')
print('D97EZ_NON224_PASSTHROUGH_SOURCE=PASS')
print('D97EZ_APPLE_CALL_EXACTLY_ONCE_SOURCE=PASS')
print('D97EZ_RETURN_PASSTHROUGH_SOURCE=PASS')
print('D97EZ_LATENT_BOOTARG_SOURCE=PASS')
print('D97EZ_GLOBAL_COUNTER_CLASSIFICATION_SOURCE=PASS')
print('D97EZ_PER_SLOT_ORIGINAL_PASSED_TELEMETRY_SOURCE=PASS')
print('D97EZ_BROAD_MASK_SOURCE=ABSENT')
PY

RC=0
/usr/bin/git diff --no-index --binary "${WORK}/D97ES.cpp" "${WORK}/D97EZ.cpp" > "${PACKAGE}/D97ES_to_D97EZ.diff" || RC=$?
[[ "${RC}" -eq 1 ]] || die "D97ES_to_D97EZ_diff_expected_nonzero_RC1_got_${RC}"
[[ -s "${PACKAGE}/D97ES_to_D97EZ.diff" ]] || die "D97ES_to_D97EZ_diff_empty"
log "D97ES_TO_D97EZ_DIFF=PASS_NONEMPTY"

log "===== PREPARE PINNED BUILD SCAFFOLD ====="
/usr/bin/git clone --quiet "${FEATURE_REPO}" "${SCAFFOLD}" || die "FeatureUnlock_clone_failed"
/usr/bin/git -C "${SCAFFOLD}" checkout --quiet "${FEATURE_COMMIT}" || die "FeatureUnlock_pin_failed"
/usr/bin/git clone --quiet "${SDK_REPO}" "${SCAFFOLD}/MacKernelSDK" || die "FeatureUnlock_SDK_clone_failed"
/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" checkout --quiet "${SDK_COMMIT}" || die "FeatureUnlock_SDK_pin_failed"
/bin/cp "${WORK}/D97EZ.cpp" "${SCAFFOLD}/FeatureUnlock/kern_start.cpp"
/bin/cp "${WORK}/Info.plist" "${SCAFFOLD}/FeatureUnlock/Info.plist"
log "FEATURE_COMMIT=$(/usr/bin/git -C "${SCAFFOLD}" rev-parse HEAD)"
log "FEATURE_SDK_COMMIT=$(/usr/bin/git -C "${SCAFFOLD}/MacKernelSDK" rev-parse HEAD)"

log "===== BUILD PINNED LILU X86_64 ====="
/usr/bin/git clone --quiet "${LILU_REPO}" "${LILU_SRC}" || die "Lilu_clone_failed"
/usr/bin/git -C "${LILU_SRC}" checkout --quiet "${LILU_COMMIT}" || die "Lilu_pin_failed"
/usr/bin/git clone --quiet "${SDK_REPO}" "${LILU_SRC}/MacKernelSDK" || die "Lilu_SDK_clone_failed"
/usr/bin/git -C "${LILU_SRC}/MacKernelSDK" checkout --quiet "${SDK_COMMIT}" || die "Lilu_SDK_pin_failed"

set +e
(cd "${LILU_SRC}" && /usr/bin/xcodebuild -configuration Debug -arch x86_64 \
    SYMROOT="${LILU_BUILD}" OBJROOT="${WORK}/Lilu-obj" build) 2>&1 | /usr/bin/tee -a "${LOG}"
RC=${PIPESTATUS[0]}
set -e
[[ ${RC} -eq 0 ]] || die "Lilu_build_failed"
LILU_KEXT="$(/usr/bin/find "${LILU_BUILD}" -type d -name Lilu.kext -print -quit)"
[[ -n "${LILU_KEXT}" ]] || die "Lilu_kext_missing"
/bin/rm -rf "${SCAFFOLD}/Lilu.kext"
/bin/cp -R "${LILU_KEXT}" "${SCAFFOLD}/Lilu.kext"
log "LILU_BUILD=PASS"
log "LILU_COMMIT=$(/usr/bin/git -C "${LILU_SRC}" rev-parse HEAD)"

log "===== BUILD D97EZ OCLPMETALCOMPAT 0.0.12 X86_64 ====="
set +e
(cd "${SCAFFOLD}" && /usr/bin/xcodebuild -project FeatureUnlock.xcodeproj -target FeatureUnlock \
    -configuration Debug -arch x86_64 \
    SYMROOT="${PLUGIN_BUILD}" OBJROOT="${WORK}/plugin-obj" \
    PRODUCT_NAME=OCLPMetalCompat \
    PRODUCT_BUNDLE_IDENTIFIER=com.oclpmetalcompat.OCLPMetalCompat \
    MODULE_NAME=com.oclpmetalcompat.OCLPMetalCompat MODULE_VERSION=0.0.12 \
    MARKETING_VERSION=0.0.12 CURRENT_PROJECT_VERSION=0.0.12 build) 2>&1 | /usr/bin/tee -a "${LOG}"
RC=${PIPESTATUS[0]}
set -e
[[ ${RC} -eq 0 ]] || die "D97EZ_plugin_build_failed"

KEXT="$(/usr/bin/find "${PLUGIN_BUILD}" -type d -name OCLPMetalCompat.kext -print -quit)"
[[ -n "${KEXT}" ]] || die "D97EZ_kext_missing"
EXEC="${KEXT}/Contents/MacOS/OCLPMetalCompat"
INFO="${KEXT}/Contents/Info.plist"
[[ -f "${EXEC}" && -f "${INFO}" ]] || die "D97EZ_payload_missing"

VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "${INFO}" 2>/dev/null || true)"
ARCHS="$(/usr/bin/lipo -archs "${EXEC}" 2>/dev/null || true)"
UUID="$(/usr/bin/dwarfdump --uuid "${EXEC}" 2>/dev/null | /usr/bin/awk 'NR==1{print $2}')"
EXEC_SHA256="$(sha256 "${EXEC}")"
INFO_SHA256="$(sha256 "${INFO}")"
EXEC_BYTES="$(/usr/bin/stat -f '%z' "${EXEC}")"

[[ "${VER}" == "0.0.12" ]] || die "version_mismatch_${VER}"
[[ "${ARCHS}" == "x86_64" ]] || die "arch_mismatch_${ARCHS}"
[[ -n "${UUID}" ]] || die "uuid_missing"

log "D97EZ_PLUGIN_BUILD=PASS"
log "VERSION=${VER}"
log "ARCHS=${ARCHS}"
log "UUID=${UUID}"
log "EXEC_SHA256=${EXEC_SHA256}"
log "EXEC_BYTES=${EXEC_BYTES}"
log "INFO_PLIST_SHA256=${INFO_SHA256}"

log "===== BINARY MARKER / DISASSEMBLY AUDIT ====="
/usr/bin/strings -a "${EXEC}" > "${PACKAGE}/D97EZ_STRINGS.txt"
/usr/bin/nm -nm "${EXEC}" > "${PACKAGE}/D97EZ_NM.txt" 2>&1 || true
/usr/bin/otool -tvV "${EXEC}" > "${PACKAGE}/D97EZ_OTOOL_DISASSEMBLY.txt" 2>&1 || true
if /usr/bin/xcrun --find llvm-objdump >/dev/null 2>&1; then
    /usr/bin/xcrun llvm-objdump --macho --disassemble --demangle "${EXEC}" > "${PACKAGE}/D97EZ_LLVM_OBJDUMP.txt" 2>&1 || true
fi

for MARKER in \
    D97EZFunctionalMode D97EZExact224SeenCount D97EZExact224AdaptedCount \
    D97EZOtherModeSeenCount D97EZAdaptSuccessCount D97EZAdaptFailureCount \
    D97EZPassthroughSuccessCount D97EZPassthroughFailureCount D97EZ01PassedMode \
    D97ELRouteStatus D97ES01Mode D97ESCapturedCount -ocmcd97ez -ocmcd97eh
 do
    /usr/bin/grep -Fq -- "${MARKER}" "${PACKAGE}/D97EZ_STRINGS.txt" || die "binary_marker_missing_${MARKER}"
 done
log "D97EZ_BINARY_MARKERS=PASS"

# Preserve source/binary authority for independent post-build audit.
/bin/cp -R "${KEXT}" "${PACKAGE}/OCLPMetalCompat.kext"
/bin/cp "${WORK}/D97DL.cpp" "${PACKAGE}/OCLP7_D97DL_BASE.cpp"
/bin/cp "${WORK}/D97EH.cpp" "${PACKAGE}/OCLP7_D97EH_GENERATED.cpp"
/bin/cp "${WORK}/D97EL.cpp" "${PACKAGE}/OCLP7_D97EL_GENERATED.cpp"
/bin/cp "${WORK}/D97ES.cpp" "${PACKAGE}/OCLP7_D97ES_GENERATED.cpp"
/bin/cp "${WORK}/D97EZ.cpp" "${PACKAGE}/OCLP7_D97EZ_GENERATED.cpp"
/bin/cp "${WORK}/D97EH_generator.py" "${PACKAGE}/OCLP7_D97EH_SOURCE_GENERATOR.py"
/bin/cp "${WORK}/D97EL_generator.py" "${PACKAGE}/OCLP7_D97EL_TELEMETRY_GENERATOR.py"
/bin/cp "${WORK}/D97ES_generator.py" "${PACKAGE}/OCLP7_D97ES_IOREG_TUPLE_GENERATOR.py"
/bin/cp "${WORK}/D97EZ_generator.py" "${PACKAGE}/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py"

cat > "${PACKAGE}/D97EZ_IDENTITY.txt" <<EOF
D97EZ_VERSION=${VER}
D97EZ_ARCHS=${ARCHS}
D97EZ_UUID=${UUID}
D97EZ_EXEC_SHA256=${EXEC_SHA256}
D97EZ_EXEC_BYTES=${EXEC_BYTES}
D97EZ_INFO_PLIST_SHA256=${INFO_SHA256}
D97EZ_SOURCE_SHA256=${EZ_SOURCE_SHA256}
D97EZ_SOURCE_BYTES=${EZ_SOURCE_BYTES}
D97EZ_GENERATOR_BLOB=${EZ_GEN_BLOB}
D97EZ_DEFAULT_MODE=LATENT
D97EZ_FUNCTIONAL_BOOTARG=-ocmcd97ez
D97EZ_EXACT_TRANSLATION=0x224_TO_0x24_ONLY
D97EZ_ROOT_PATCH=AUTO-NO
D97EZ_DEPLOY=AUTO-NO
D97EZ_REBOOT=AUTO-NO
EOF

# Finalize the report BEFORE hashing package payloads. Do not mutate files in
# PACKAGE after SHA256SUMS.txt is generated, otherwise the manifest is stale.
log "PACKAGE_PAYLOAD_READY=PASS"
log "D97EZ_BUILD_STATUS=PASS"
log "DEPLOYMENT_AUTHORIZED=NO_PENDING_INDEPENDENT_AUDIT"
log "ROOT_PATCH_AUTHORIZED=NO"
log "REBOOT_AUTHORIZED=NO"

(
    cd "${PACKAGE}"
    /usr/bin/find . -type f ! -name 'SHA256SUMS.txt' -print0 | \
        /usr/bin/xargs -0 /usr/bin/shasum -a 256 > SHA256SUMS.txt
)
MANIFEST_SHA256="$(sha256 "${PACKAGE}/SHA256SUMS.txt")"

# Audit the newly written manifest immediately while the package is frozen.
(
    cd "${PACKAGE}"
    /usr/bin/shasum -a 256 -c SHA256SUMS.txt >/dev/null
) || die "package_manifest_self_check_failed"

/bin/rm -f "${ZIP}" "${ZIP_SHA_FILE}"
/usr/bin/ditto -c -k --keepParent "${PACKAGE}" "${ZIP}"
ZIP_SHA256="$(sha256 "${ZIP}")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "${ZIP}")"
printf '%s  %s\n' "${ZIP_SHA256}" "$(basename "${ZIP}")" > "${ZIP_SHA_FILE}"

/bin/sync

echo
echo "===== D97EZ FINAL ====="
echo "D97EZ_BUILD_STATUS=PASS"
echo "PACKAGE_MANIFEST_SHA256=${MANIFEST_SHA256}"
echo "FINAL_ZIP=${ZIP}"
echo "FINAL_ZIP_BYTES=${ZIP_BYTES}"
echo "FINAL_ZIP_SHA256=${ZIP_SHA256}"
echo "FINAL_ZIP_SHA_FILE=${ZIP_SHA_FILE}"
echo "D97EZ_EXEC_SHA256=${EXEC_SHA256}"
echo "D97EZ_UUID=${UUID}"
echo "D97EZ_SOURCE_SHA256=${EZ_SOURCE_SHA256}"
echo "DEPLOYMENT_AUTHORIZED=NO_PENDING_INDEPENDENT_AUDIT"
echo "ROOT_PATCH_AUTHORIZED=NO"
echo "REBOOT_AUTHORIZED=NO"
