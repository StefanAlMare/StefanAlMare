#!/bin/bash
set -euo pipefail

# OCLP7 D97FE — D97EZ 0.0.12 VESA-first deploy helper.
# Scope: replace only the already-configured EFI OCLPMetalCompat.kext after exact
# old/new identity checks. No config.plist edit, NVRAM write, Root Patch or reboot.

EXPECTED_OLD_VERSION="0.0.11"
EXPECTED_OLD_EXEC_SHA256="2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de"
EXPECTED_OLD_UUID="4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4"

EXPECTED_NEW_VERSION="0.0.12"
EXPECTED_NEW_EXEC_SHA256="356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c"
EXPECTED_NEW_INFO_SHA256="2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899"
EXPECTED_NEW_UUID="3405DFAB-244A-38CA-90EA-79A1A24EEF72"
EXPECTED_NEW_ARCH="x86_64"

SCRIPT_DIR="$(cd "$(dirname "$0")" && /bin/pwd -P)"
INCOMING="${SCRIPT_DIR}/OCLPMetalCompat.kext"
EFI="/Volumes/EFI"
KEXT_DIR="${EFI}/EFI/OC/Kexts"
ACTIVE="${KEXT_DIR}/OCLPMetalCompat.kext"
CONFIG="${EFI}/EFI/OC/config.plist"
STAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP="${KEXT_DIR}/OCLPMetalCompat.kext.D97ES_BACKUP_${STAMP}"
TMP="${KEXT_DIR}/.OCLPMetalCompat.kext.D97EZ_${STAMP}.tmp"

log(){ printf '%s\n' "$*"; }
die(){ log "D97FE_DEPLOY_STATUS=FAIL"; log "D97FE_FAIL_REASON=$*"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

bundle_version(){
    /usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$1/Contents/Info.plist" 2>/dev/null || true
}
bundle_exec_sha(){ sha256 "$1/Contents/MacOS/OCLPMetalCompat"; }
bundle_info_sha(){ sha256 "$1/Contents/Info.plist"; }
bundle_uuid(){ /usr/bin/dwarfdump --uuid "$1/Contents/MacOS/OCLPMetalCompat" 2>/dev/null | /usr/bin/awk 'NR==1{print $2}'; }
bundle_arch(){ /usr/bin/lipo -archs "$1/Contents/MacOS/OCLPMetalCompat" 2>/dev/null || true; }

token_present(){
    local token="$1" args="$2"
    printf '%s\n' "$args" | /usr/bin/tr ' ' '\n' | /usr/bin/grep -Fxq -- "$token"
}

[[ "$(/usr/bin/id -u)" == "0" ]] || die "run_with_sudo_required"
[[ "$(/usr/bin/uname -m)" == "x86_64" ]] || die "target_not_x86_64"
[[ -d "${EFI}" && -d "${KEXT_DIR}" ]] || die "EFI_not_mounted_at_/Volumes/EFI"
[[ -f "${CONFIG}" ]] || die "config_plist_missing"
[[ -d "${ACTIVE}" ]] || die "active_OCLPMetalCompat_missing"
[[ -d "${INCOMING}" ]] || die "incoming_OCLPMetalCompat_missing_next_to_helper"
[[ ! -e "${BACKUP}" && ! -e "${TMP}" ]] || die "backup_or_tmp_collision"

BOOT_RAW_BEFORE="$(/usr/sbin/nvram boot-args 2>/dev/null || true)"
BOOT_ARGS_BEFORE="${BOOT_RAW_BEFORE#*$'\t'}"
CONFIG_SHA_BEFORE="$(sha256 "${CONFIG}")"

log "===== D97FE PRECHECK ====="
log "D97FE_BOOT_ARGS_BEFORE=${BOOT_ARGS_BEFORE}"
log "D97FE_CONFIG_SHA_BEFORE=${CONFIG_SHA_BEFORE}"

for req in -igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh '#-ocmcd97bvcave'; do
    token_present "$req" "${BOOT_ARGS_BEFORE}" || die "required_bootarg_missing_${req}"
done
for forbidden in '#-igfxvesa' -ocmcd97ez; do
    ! token_present "$forbidden" "${BOOT_ARGS_BEFORE}" || die "forbidden_bootarg_present_${forbidden}"
done
log "D97FE_VESA_BOOTARG_GATE=PASS"

OLD_VERSION="$(bundle_version "${ACTIVE}")"
OLD_EXEC_SHA="$(bundle_exec_sha "${ACTIVE}")"
OLD_UUID="$(bundle_uuid "${ACTIVE}")"
OLD_ARCH="$(bundle_arch "${ACTIVE}")"

log "D97FE_OLD_VERSION=${OLD_VERSION}"
log "D97FE_OLD_EXEC_SHA256=${OLD_EXEC_SHA}"
log "D97FE_OLD_UUID=${OLD_UUID}"
log "D97FE_OLD_ARCH=${OLD_ARCH}"

[[ "${OLD_VERSION}" == "${EXPECTED_OLD_VERSION}" ]] || die "old_version_mismatch"
[[ "${OLD_EXEC_SHA}" == "${EXPECTED_OLD_EXEC_SHA256}" ]] || die "old_exec_sha_mismatch"
[[ "${OLD_UUID}" == "${EXPECTED_OLD_UUID}" ]] || die "old_uuid_mismatch"
[[ "${OLD_ARCH}" == "x86_64" ]] || die "old_arch_mismatch"
log "D97FE_ACTIVE_D97ES_IDENTITY=PASS"

NEW_VERSION="$(bundle_version "${INCOMING}")"
NEW_EXEC_SHA="$(bundle_exec_sha "${INCOMING}")"
NEW_INFO_SHA="$(bundle_info_sha "${INCOMING}")"
NEW_UUID="$(bundle_uuid "${INCOMING}")"
NEW_ARCH="$(bundle_arch "${INCOMING}")"

log "D97FE_INCOMING_VERSION=${NEW_VERSION}"
log "D97FE_INCOMING_EXEC_SHA256=${NEW_EXEC_SHA}"
log "D97FE_INCOMING_INFO_SHA256=${NEW_INFO_SHA}"
log "D97FE_INCOMING_UUID=${NEW_UUID}"
log "D97FE_INCOMING_ARCH=${NEW_ARCH}"

[[ "${NEW_VERSION}" == "${EXPECTED_NEW_VERSION}" ]] || die "incoming_version_mismatch"
[[ "${NEW_EXEC_SHA}" == "${EXPECTED_NEW_EXEC_SHA256}" ]] || die "incoming_exec_sha_mismatch"
[[ "${NEW_INFO_SHA}" == "${EXPECTED_NEW_INFO_SHA256}" ]] || die "incoming_info_sha_mismatch"
[[ "${NEW_UUID}" == "${EXPECTED_NEW_UUID}" ]] || die "incoming_uuid_mismatch"
[[ "${NEW_ARCH}" == "${EXPECTED_NEW_ARCH}" ]] || die "incoming_arch_mismatch"
log "D97FE_INCOMING_D97EZ_IDENTITY=PASS"

# Copy to a temporary sibling first and verify copied bytes before touching active kext.
/usr/bin/ditto "${INCOMING}" "${TMP}"
TMP_VERSION="$(bundle_version "${TMP}")"
TMP_EXEC_SHA="$(bundle_exec_sha "${TMP}")"
TMP_INFO_SHA="$(bundle_info_sha "${TMP}")"
TMP_UUID="$(bundle_uuid "${TMP}")"
TMP_ARCH="$(bundle_arch "${TMP}")"
[[ "${TMP_VERSION}" == "${EXPECTED_NEW_VERSION}" ]] || { /bin/rm -rf "${TMP}"; die "tmp_version_mismatch"; }
[[ "${TMP_EXEC_SHA}" == "${EXPECTED_NEW_EXEC_SHA256}" ]] || { /bin/rm -rf "${TMP}"; die "tmp_exec_sha_mismatch"; }
[[ "${TMP_INFO_SHA}" == "${EXPECTED_NEW_INFO_SHA256}" ]] || { /bin/rm -rf "${TMP}"; die "tmp_info_sha_mismatch"; }
[[ "${TMP_UUID}" == "${EXPECTED_NEW_UUID}" ]] || { /bin/rm -rf "${TMP}"; die "tmp_uuid_mismatch"; }
[[ "${TMP_ARCH}" == "${EXPECTED_NEW_ARCH}" ]] || { /bin/rm -rf "${TMP}"; die "tmp_arch_mismatch"; }
log "D97FE_TEMP_COPY_IDENTITY=PASS"

# Atomic same-volume renames with fail-closed rollback if activation rename fails.
/bin/mv "${ACTIVE}" "${BACKUP}"
if ! /bin/mv "${TMP}" "${ACTIVE}"; then
    /bin/mv "${BACKUP}" "${ACTIVE}" || true
    /bin/sync
    die "activation_rename_failed_rollback_attempted"
fi
/bin/sync

FINAL_VERSION="$(bundle_version "${ACTIVE}")"
FINAL_EXEC_SHA="$(bundle_exec_sha "${ACTIVE}")"
FINAL_INFO_SHA="$(bundle_info_sha "${ACTIVE}")"
FINAL_UUID="$(bundle_uuid "${ACTIVE}")"
FINAL_ARCH="$(bundle_arch "${ACTIVE}")"

if [[ "${FINAL_VERSION}" != "${EXPECTED_NEW_VERSION}" || \
      "${FINAL_EXEC_SHA}" != "${EXPECTED_NEW_EXEC_SHA256}" || \
      "${FINAL_INFO_SHA}" != "${EXPECTED_NEW_INFO_SHA256}" || \
      "${FINAL_UUID}" != "${EXPECTED_NEW_UUID}" || \
      "${FINAL_ARCH}" != "${EXPECTED_NEW_ARCH}" ]]; then
    /bin/rm -rf "${ACTIVE}"
    /bin/mv "${BACKUP}" "${ACTIVE}" || true
    /bin/sync
    die "final_identity_mismatch_D97ES_restored_if_possible"
fi

CONFIG_SHA_AFTER="$(sha256 "${CONFIG}")"
BOOT_RAW_AFTER="$(/usr/sbin/nvram boot-args 2>/dev/null || true)"
BOOT_ARGS_AFTER="${BOOT_RAW_AFTER#*$'\t'}"

[[ "${CONFIG_SHA_AFTER}" == "${CONFIG_SHA_BEFORE}" ]] || die "config_plist_changed_unexpectedly"
[[ "${BOOT_ARGS_AFTER}" == "${BOOT_ARGS_BEFORE}" ]] || die "boot_args_changed_unexpectedly"

log "===== D97FE FINAL ====="
log "D97FE_DEPLOY_STATUS=PASS"
log "D97FE_BACKUP=${BACKUP}"
log "D97FE_ACTIVE_VERSION=${FINAL_VERSION}"
log "D97FE_ACTIVE_EXEC_SHA256=${FINAL_EXEC_SHA}"
log "D97FE_ACTIVE_INFO_SHA256=${FINAL_INFO_SHA}"
log "D97FE_ACTIVE_UUID=${FINAL_UUID}"
log "D97FE_ACTIVE_ARCH=${FINAL_ARCH}"
log "D97FE_CONFIG_SHA_AFTER=${CONFIG_SHA_AFTER}"
log "D97FE_CONFIG_UNCHANGED=PASS"
log "D97FE_BOOT_ARGS_AFTER=${BOOT_ARGS_AFTER}"
log "D97FE_BOOT_ARGS_UNCHANGED=PASS"
log "D97FE_KERNEL_ADD_BUNDLEPATH_CHANGED=NO"
log "D97FE_ROOT_PATCH=NO"
log "D97FE_NVRAM_WRITE=NO"
log "D97FE_REBOOT_PERFORMED=NO"
log "D97FE_VESA_REBOOT_AUTHORIZED=NO_PENDING_ASSISTANT_AUDIT"
