#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HT — restore the exact official privileged helper after D97HO custom Root Patch,
# then rerun the exact D97HS pre-reboot P1+P3 audit.
# Only system mutation is the already-proven official-helper restoration performed by D97HA.
# NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

D97HA_COMMIT="5c5ffddc7db7c2d6113115c90b9ef0e74449e977"
D97HA_BLOB="5eec076996619bab2b2d8a17f57b086b6d0ac011"
D97HS_COMMIT="dcfc861b9bd23a8ac00d7d07c43f4166ea402f18"
D97HS_BLOB="dd71dbd1149a6c96b3e754ff500f029f536bdef5"

STAMP="$(date +%Y%m%d_%H%M%S)"
TMP="/private/tmp/OCLP7_D97HT_$$"
REPORT="$HOME/Desktop/OCLP7_D97HT_HELPER_RESTORE_AND_D97HS_${STAMP}.txt"
mkdir -p "$TMP"
trap '/bin/rm -rf "$TMP" >/dev/null 2>&1 || true' EXIT
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HT_STATUS=FAIL"; echo "D97HT_REASON=$*"; echo "D97HT_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HT — RESTORE OFFICIAL HELPER + RERUN D97HS =====
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
ONLY_SYSTEM_MUTATION=OFFICIAL_PRIVILEGED_HELPER_RESTORE
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82

D97HA="$TMP/OCLP7_D97HA_ASUS2_RESTORE_OFFICIAL_HELPER_ONLY.sh"
D97HS="$TMP/OCLP7_D97HS_ASUS2_POST_D97HO_PRE_REBOOT_P1_P3_AUDIT.sh"

HA_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${D97HA_COMMIT}/OCLP-Continuity/artifacts/OCLP7_D97HA_ASUS2_RESTORE_OFFICIAL_HELPER_ONLY.sh"
HS_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${D97HS_COMMIT}/OCLP-Continuity/artifacts/OCLP7_D97HS_ASUS2_POST_D97HO_PRE_REBOOT_P1_P3_AUDIT.sh"

printf '\n===== FETCH EXACT PROVEN HELPERS =====\n'
/usr/bin/curl -fL "$HA_URL" -o "$D97HA" || fail D97HA_DOWNLOAD_FAIL
/usr/bin/curl -fL "$HS_URL" -o "$D97HS" || fail D97HS_DOWNLOAD_FAIL

HA_BLOB="$(/usr/bin/git hash-object "$D97HA")"
HS_BLOB="$(/usr/bin/git hash-object "$D97HS")"
echo "D97HT_D97HA_BLOB=$HA_BLOB"
echo "D97HT_D97HS_BLOB=$HS_BLOB"
[[ "$HA_BLOB" == "$D97HA_BLOB" ]] || fail D97HA_BLOB_MISMATCH
[[ "$HS_BLOB" == "$D97HS_BLOB" ]] || fail D97HS_BLOB_MISMATCH
/bin/chmod +x "$D97HA" "$D97HS"
echo "D97HT_HELPER_IDENTITIES=PASS"

printf '\n===== RESTORE OFFICIAL HELPER ONLY =====\n'
"$D97HA"
echo "D97HT_D97HA_EXECUTION=PASS"

printf '\n===== RERUN EXACT D97HS =====\n'
"$D97HS"
echo "D97HT_D97HS_EXECUTION=PASS"

printf '\n===== FINAL =====\n'
echo "D97HT_STATUS=PASS_HELPER_RESTORED_D97HS_COMPLETED"
echo "D97HT_NEXT=REVIEW_D97HS_BEFORE_ANY_REBOOT"
echo "D97HT_REBOOT=NO"
echo "D97HT_REPORT=$REPORT"
