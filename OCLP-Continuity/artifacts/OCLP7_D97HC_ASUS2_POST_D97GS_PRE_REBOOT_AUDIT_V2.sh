#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HC — corrected ASUS2 post-D97GS Root Patch, pre-reboot audit after CLEAN Restore baseline.
# D97HB tooling correction: macOS mount utility is /sbin/mount, not /usr/bin/mount.
# Current active snapshot must remain native Tahoe; underlying System volume must contain exact D97GS P1 + corrected metallibs.
# READ-ONLY except temporary read-only mount. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_ACTIVE_NATIVE_SERVICE_SHA="4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256"
EXPECTED_ACTIVE_NATIVE_CORE_SHA="daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1"
EXPECTED_ACTIVE_NATIVE_CORE_BYTES="24128"
EXPECTED_PATCHED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P1_POSTIMAGE="81fe177d0000"
EXPECTED_P1_OFFSET=$((0x3494))
EXPECTED_PATCHED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_PATCHED_CORE_BYTES="20739"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

ACTIVE_SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HC_POST_D97GS_PRE_REBOOT_${STAMP}"
REPORT="$OUT/D97HC_REPORT.txt"
MNT="/private/tmp/OCLP7_D97HC_MNT_$$"
mkdir -p "$OUT" "$MNT"
MOUNTED=0

cleanup() {
  if [[ "$MOUNTED" -eq 1 ]]; then
    /usr/bin/sudo /sbin/umount "$MNT" >/dev/null 2>&1 || /usr/bin/sudo /usr/sbin/diskutil unmount force "$MNT" >/dev/null 2>&1 || true
  fi
  /bin/rmdir "$MNT" >/dev/null 2>&1 || true
}
trap cleanup EXIT

exec > >(tee "$REPORT") 2>&1
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
fail(){ echo "D97HC_STATUS=FAIL"; echo "D97HC_REASON=$*"; echo "D97HC_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HC — POST D97GS / PRE REBOOT AUDIT V2 AFTER CLEAN RESTORE =====
ROOT_PATCH=NO
RESTORE=NO
SYSTEM_WRITE=NO
MOUNT_MODE=READ_ONLY
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
D97HB_TOOLING_FIX=/usr/bin/mount->/sbin/mount
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82

printf '\n===== BOOT SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HC_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HC_VESA_GATE=PASS"

printf '\n===== CURRENT ACTIVE SNAPSHOT MUST REMAIN NATIVE TAHOE =====\n'
[[ -f "$ACTIVE_SERVICE" ]] || fail ACTIVE_SERVICE_MISSING
ACTIVE_SERVICE_SHA="$(sha256 "$ACTIVE_SERVICE")"
echo "D97HC_ACTIVE_SERVICE_SHA256=$ACTIVE_SERVICE_SHA"
[[ "$ACTIVE_SERVICE_SHA" == "$EXPECTED_ACTIVE_NATIVE_SERVICE_SHA" ]] || fail ACTIVE_SERVICE_NOT_NATIVE_EXPECTED

[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
ACTIVE_CORE_SHA="$(sha256 "$ACTIVE_CORE")"
ACTIVE_CORE_BYTES="$(bytes "$ACTIVE_CORE")"
echo "D97HC_ACTIVE_CORE_SHA256=$ACTIVE_CORE_SHA"
echo "D97HC_ACTIVE_CORE_BYTES=$ACTIVE_CORE_BYTES"
[[ "$ACTIVE_CORE_SHA" == "$EXPECTED_ACTIVE_NATIVE_CORE_SHA" ]] || fail ACTIVE_CORE_NOT_NATIVE_EXPECTED
[[ "$ACTIVE_CORE_BYTES" == "$EXPECTED_ACTIVE_NATIVE_CORE_BYTES" ]] || fail ACTIVE_CORE_BYTES_NOT_NATIVE_EXPECTED

echo "D97HC_ACTIVE_SNAPSHOT_NATIVE=PASS"

printf '\n===== OFFICIAL PRIVILEGED HELPER MUST BE RESTORED =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"
HELPER_TEAM="$(team "$OFFICIAL_HELPER")"
echo "D97HC_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HC_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HC_OFFICIAL_HELPER_RESTORED=PASS"

printf '\n===== LOCAL CORRECTED METALLIB SOURCE =====\n'
[[ -d "$LOCAL_ROOT" && -f "$LOCAL_CORE" ]] || fail LOCAL_METALLIB_SOURCE_MISSING
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
LOCAL_CORE_SHA="$(sha256 "$LOCAL_CORE")"
LOCAL_CORE_BYTES="$(bytes "$LOCAL_CORE")"
echo "D97HC_LOCAL_METALLIB_COUNT=$LOCAL_COUNT"
echo "D97HC_LOCAL_CORE_SHA256=$LOCAL_CORE_SHA"
echo "D97HC_LOCAL_CORE_BYTES=$LOCAL_CORE_BYTES"
[[ "$LOCAL_COUNT" == "180" ]] || fail LOCAL_COUNT_NOT_180
[[ "$LOCAL_CORE_SHA" == "$EXPECTED_PATCHED_CORE_SHA" ]] || fail LOCAL_CORE_SHA_MISMATCH
[[ "$LOCAL_CORE_BYTES" == "$EXPECTED_PATCHED_CORE_BYTES" ]] || fail LOCAL_CORE_BYTES_MISMATCH
echo "D97HC_LOCAL_SOURCE=PASS"

printf '\n===== RESOLVE UNDERLYING SYSTEM VOLUME =====\n'
ROOT_ID="$(/usr/sbin/diskutil info / | /usr/bin/awk -F: '/Device Identifier/{gsub(/[[:space:]]/,"",$2); print $2; exit}')"
[[ -n "$ROOT_ID" ]] || fail ROOT_DEVICE_ID_UNKNOWN
BASE_ID="$(printf '%s\n' "$ROOT_ID" | /usr/bin/sed -E 's/s[0-9]+$//')"
[[ -n "$BASE_ID" && "$BASE_ID" != "$ROOT_ID" ]] || fail BASE_SYSTEM_DEVICE_NORMALIZATION_FAILED
echo "D97HC_ACTIVE_ROOT_DEVICE=$ROOT_ID"
echo "D97HC_BASE_SYSTEM_DEVICE=$BASE_ID"
/usr/sbin/diskutil info "/dev/$BASE_ID" > "$OUT/base_system_diskutil_info.txt" 2>&1 || fail BASE_SYSTEM_DISKUTIL_INFO_FAIL

/usr/bin/sudo /sbin/mount_apfs -o rdonly,nobrowse "/dev/$BASE_ID" "$MNT" || fail READONLY_MOUNT_FAIL
MOUNTED=1
echo "D97HC_READONLY_MOUNT=$MNT"
/sbin/mount | /usr/bin/grep -F " on $MNT " | tee "$OUT/mount_line.txt" || fail MOUNT_LINE_NOT_FOUND
MOUNT_LINE="$(/bin/cat "$OUT/mount_line.txt")"
echo "D97HC_MOUNT_LINE=$MOUNT_LINE"
printf '%s\n' "$MOUNT_LINE" | /usr/bin/grep -Eq 'read-only|rdonly' || echo "D97HC_MOUNT_READONLY_TOKEN=NOT_EXPLICIT_IN_MOUNT_OUTPUT"
echo "D97HC_BASE_SYSTEM_READONLY_MOUNT=PASS"

PATCHED_SERVICE="$MNT/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
PATCHED_CORE="$MNT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"

printf '\n===== PATCHED MTLCOMPILERSERVICE EXACT P1 =====\n'
[[ -f "$PATCHED_SERVICE" ]] || fail PATCHED_SERVICE_MISSING
PATCHED_SHA="$(sha256 "$PATCHED_SERVICE")"
PATCHED_BYTES="$(bytes "$PATCHED_SERVICE")"
echo "D97HC_PATCHED_SERVICE_SHA256=$PATCHED_SHA"
echo "D97HC_PATCHED_SERVICE_BYTES=$PATCHED_BYTES"
[[ "$PATCHED_SHA" == "$EXPECTED_PATCHED_P1_SHA" ]] || fail PATCHED_SERVICE_NOT_EXACT_P1

/usr/bin/python3 - "$PATCHED_SERVICE" "$EXPECTED_P1_OFFSET" "$EXPECTED_P1_POSTIMAGE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); off=int(sys.argv[2]); exp=bytes.fromhex(sys.argv[3]); b=p.read_bytes(); got=b[off:off+len(exp)]
print(f'D97HC_PATCHED_P1_OFFSET=0x{off:x}')
print('D97HC_PATCHED_P1_POSTIMAGE='+got.hex())
print('D97HC_PATCHED_P1_POSTIMAGE_MATCH=' + ('PASS' if got==exp else 'FAIL'))
if got != exp: raise SystemExit(2)
PY

echo "D97HC_PATCHED_SERVICE_P1=PASS"

printf '\n===== PATCHED METALLIB 180/180 BYTE IDENTITY =====\n'
EXACT=0
MISSING=0
DIFFERENT=0
: > "$OUT/metallib_compare.tsv"
printf 'RELATIVE_PATH\tLOCAL_SHA256\tPATCHED_SHA256\tSTATUS\n' >> "$OUT/metallib_compare.tsv"
while IFS= read -r LF; do
  REL="${LF#$LOCAL_ROOT/}"
  PF="$MNT/$REL"
  LSH="$(sha256 "$LF")"
  if [[ ! -f "$PF" ]]; then
    MISSING=$((MISSING+1))
    printf '%s\t%s\t\tMISSING\n' "$REL" "$LSH" >> "$OUT/metallib_compare.tsv"
    continue
  fi
  PSH="$(sha256 "$PF")"
  if [[ "$LSH" == "$PSH" ]]; then
    EXACT=$((EXACT+1))
    printf '%s\t%s\t%s\tEXACT\n' "$REL" "$LSH" "$PSH" >> "$OUT/metallib_compare.tsv"
  else
    DIFFERENT=$((DIFFERENT+1))
    printf '%s\t%s\t%s\tDIFFERENT\n' "$REL" "$LSH" "$PSH" >> "$OUT/metallib_compare.tsv"
  fi
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)

echo "D97HC_PATCHED_METALLIB_EXACT=$EXACT"
echo "D97HC_PATCHED_METALLIB_MISSING=$MISSING"
echo "D97HC_PATCHED_METALLIB_DIFFERENT=$DIFFERENT"
[[ "$EXACT" -eq 180 ]] || fail PATCHED_METALLIB_EXACT_NOT_180
[[ "$MISSING" -eq 0 ]] || fail PATCHED_METALLIB_MISSING_NONZERO
[[ "$DIFFERENT" -eq 0 ]] || fail PATCHED_METALLIB_DIFFERENT_NONZERO

[[ -f "$PATCHED_CORE" ]] || fail PATCHED_CORE_METALLIB_MISSING
PATCHED_CORE_SHA="$(sha256 "$PATCHED_CORE")"
PATCHED_CORE_BYTES="$(bytes "$PATCHED_CORE")"
PATCHED_CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$PATCHED_CORE")"
echo "D97HC_PATCHED_CORE_SHA256=$PATCHED_CORE_SHA"
echo "D97HC_PATCHED_CORE_BYTES=$PATCHED_CORE_BYTES"
echo "D97HC_PATCHED_CORE_MAGIC=$PATCHED_CORE_MAGIC"
[[ "$PATCHED_CORE_SHA" == "$EXPECTED_PATCHED_CORE_SHA" ]] || fail PATCHED_CORE_SHA_MISMATCH
[[ "$PATCHED_CORE_BYTES" == "$EXPECTED_PATCHED_CORE_BYTES" ]] || fail PATCHED_CORE_BYTES_MISMATCH
[[ "$PATCHED_CORE_MAGIC" == "4d544c42" ]] || fail PATCHED_CORE_NOT_MTLB

echo "D97HC_PATCHED_METALLIB_LAYER=PASS"

printf '\n===== FINAL =====\n'
echo "D97HC_STATUS=PASS_PRE_REBOOT_AUDIT"
echo "D97HC_ACTIVE_SNAPSHOT=NATIVE_TAHOE_UNCHANGED"
echo "D97HC_PATCHED_P1=STRUCTURAL_SEMANTIC_PASS_PRE_REBOOT"
echo "D97HC_PATCHED_METALLIBS=180_OF_180_EXACT"
echo "D97HC_OFFICIAL_HELPER=RESTORED_PASS"
echo "D97HC_NEXT=VESA_REBOOT_ONLY_AFTER_REVIEW"
echo "D97HC_REBOOT=NO"
echo "D97HC_REPORT=$REPORT"
