#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HA — restore exact official OCLP privileged helper only.
# NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_DEBUG_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_OFFICIAL_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"
ACTIVE="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
SOURCE="/Library/Application Support/Dortania/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper"
STAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP="$HOME/Desktop/OCLP7_D97HA_DEBUG_HELPER_BACKUP_${STAMP}"
REPORT="$HOME/Desktop/OCLP7_D97HA_HELPER_RESTORE_${STAMP}.txt"
STAGE="/private/tmp/OCLP7_D97HA_official_helper_$$"

cleanup(){ /usr/bin/sudo /bin/rm -f "$STAGE" >/dev/null 2>&1 || true; }
trap cleanup EXIT
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
fail(){ echo "D97HA_STATUS=FAIL"; echo "D97HA_REASON=$*"; echo "D97HA_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HA — RESTORE OFFICIAL HELPER ONLY =====
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
ONLY_MUTATION=PRIVILEGED_HELPER_RESTORE
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
[[ -f "$ACTIVE" ]] || fail ACTIVE_HELPER_MISSING
[[ -f "$SOURCE" ]] || fail OFFICIAL_SOURCE_MISSING

printf '\n===== ACTIVE DEBUG HELPER PRECHECK =====\n'
ACTIVE_SHA="$(sha256 "$ACTIVE")"
echo "D97HA_ACTIVE_PRE_SHA256=$ACTIVE_SHA"
[[ "$ACTIVE_SHA" == "$EXPECTED_DEBUG_SHA" ]] || fail ACTIVE_NOT_EXACT_DEBUG_HELPER
/usr/bin/codesign --verify --strict "$ACTIVE" || fail ACTIVE_DEBUG_CODESIGN_FAIL

echo "D97HA_ACTIVE_DEBUG_PRECHECK=PASS"

printf '\n===== OFFICIAL SOURCE PRECHECK =====\n'
SOURCE_SHA="$(sha256 "$SOURCE")"
SOURCE_TEAM="$(team "$SOURCE")"
echo "D97HA_SOURCE_SHA256=$SOURCE_SHA"
echo "D97HA_SOURCE_TEAM=$SOURCE_TEAM"
[[ "$SOURCE_SHA" == "$EXPECTED_OFFICIAL_SHA" ]] || fail SOURCE_SHA_MISMATCH
[[ "$SOURCE_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail SOURCE_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$SOURCE" || fail SOURCE_CODESIGN_FAIL

echo "D97HA_OFFICIAL_SOURCE=PASS"

printf '\n===== BACKUP CURRENT DEBUG HELPER =====\n'
/bin/cp "$ACTIVE" "$BACKUP"
[[ "$(sha256 "$BACKUP")" == "$EXPECTED_DEBUG_SHA" ]] || fail DEBUG_BACKUP_SHA_MISMATCH
echo "D97HA_DEBUG_BACKUP=$BACKUP"
echo "D97HA_DEBUG_BACKUP_SHA256=$(sha256 "$BACKUP")"

printf '\n===== STAGE EXACT OFFICIAL HELPER =====\n'
/usr/bin/sudo /bin/cp -f "$SOURCE" "$STAGE"
/usr/bin/sudo /usr/sbin/chown root:wheel "$STAGE"
/usr/bin/sudo /bin/chmod 4755 "$STAGE"
STAGE_SHA="$(sha256 "$STAGE")"
STAGE_TEAM="$(team "$STAGE")"
echo "D97HA_STAGE_SHA256=$STAGE_SHA"
echo "D97HA_STAGE_TEAM=$STAGE_TEAM"
[[ "$STAGE_SHA" == "$EXPECTED_OFFICIAL_SHA" ]] || fail STAGE_SHA_MISMATCH
[[ "$STAGE_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail STAGE_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$STAGE" || fail STAGE_CODESIGN_FAIL

echo "D97HA_STAGE=PASS"

printf '\n===== ATOMIC HELPER REPLACEMENT =====\n'
/usr/bin/sudo /bin/mv -f "$STAGE" "$ACTIVE"
/usr/bin/sudo /usr/sbin/chown root:wheel "$ACTIVE"
/usr/bin/sudo /bin/chmod 4755 "$ACTIVE"

FINAL_SHA="$(sha256 "$ACTIVE")"
FINAL_TEAM="$(team "$ACTIVE")"
echo "D97HA_ACTIVE_POST_SHA256=$FINAL_SHA"
echo "D97HA_ACTIVE_POST_TEAM=$FINAL_TEAM"
[[ "$FINAL_SHA" == "$EXPECTED_OFFICIAL_SHA" ]] || fail FINAL_SHA_MISMATCH
[[ "$FINAL_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail FINAL_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$ACTIVE" || fail FINAL_CODESIGN_FAIL

STAT_LINE="$(/usr/bin/stat -f '%Su:%Sg %Sp %z' "$ACTIVE")"
echo "D97HA_ACTIVE_POST_STAT=$STAT_LINE"

echo "D97HA_OFFICIAL_HELPER_RESTORED=PASS"
echo "D97HA_STATUS=PASS"
echo "D97HA_NEXT=RERUN_D97GY"
echo "D97HA_REBOOT=NO"
echo "D97HA_REPORT=$REPORT"
