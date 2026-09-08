#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HS — ASUS2 post-D97HO Root Patch, PRE-REBOOT audit.
# Derived from proven D97HC read-only underlying-System-volume method.
# Active booted snapshot must remain native Tahoe until reboot.
# Underlying System volume must contain exact D97HO P1 + P3-only state.
# READ-ONLY except temporary read-only APFS mount. NO Root Patch/Restore. NO reboot.

EXPECTED_BUILD="25G82"
EXPECTED_ACTIVE_NATIVE_SERVICE_SHA="4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256"
EXPECTED_ACTIVE_NATIVE_CORE_SHA="daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1"
EXPECTED_ACTIVE_NATIVE_CORE_BYTES="24128"

EXPECTED_PATCHED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P1_POSTIMAGE="81fe177d0000"
P1_OFFSET=$((0x3494))

EXPECTED_P3_COMPILER_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"
EXPECTED_P3_COMPILER_BYTES="1636896"
EXPECTED_P2_ORIGINAL="418b81d0000000"
P2_OFFSET=$((0x9A8CD))
EXPECTED_P3_POST="81c900002000"
P3_OFFSET=$((0xA1573))
EXPECTED_COMPILER_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"

EXPECTED_PATCHED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_PATCHED_CORE_BYTES="20739"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"
EXPECTED_D97HO_ZIP_SHA="a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3"
EXPECTED_D97HO_ZIP_BYTES="722975756"

ACTIVE_SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
ACTIVE_COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"
AUXKC="/Library/KernelCollections/AuxiliaryKernelExtensions.kc"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HS_POST_D97HO_PRE_REBOOT_${STAMP}"
REPORT="$OUT/D97HS_REPORT.txt"
MNT="/private/tmp/OCLP7_D97HS_MNT_$$"
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
fail(){ echo "D97HS_STATUS=FAIL"; echo "D97HS_REASON=$*"; echo "D97HS_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HS — POST D97HO / PRE REBOOT P1+P3 AUDIT =====
READ_ONLY=YES
ROOT_PATCH=NO
RESTORE=NO
SYSTEM_WRITE=NO
MOUNT_MODE=READ_ONLY
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
P2B_REPLAY=NO
AIR00_REPLAY=NO
D34_REPLAY=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "$EXPECTED_BUILD" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== BOOT SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HS_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HS_VESA_GATE=PASS"

printf '\n===== ACTIVE SNAPSHOT MUST STILL BE NATIVE =====\n'
[[ -f "$ACTIVE_SERVICE" ]] || fail ACTIVE_SERVICE_MISSING
ACTIVE_SERVICE_SHA="$(sha256 "$ACTIVE_SERVICE")"
echo "D97HS_ACTIVE_SERVICE_SHA256=$ACTIVE_SERVICE_SHA"
[[ "$ACTIVE_SERVICE_SHA" == "$EXPECTED_ACTIVE_NATIVE_SERVICE_SHA" ]] || fail ACTIVE_SERVICE_NOT_NATIVE

[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
ACTIVE_CORE_SHA="$(sha256 "$ACTIVE_CORE")"
ACTIVE_CORE_BYTES="$(bytes "$ACTIVE_CORE")"
echo "D97HS_ACTIVE_CORE_SHA256=$ACTIVE_CORE_SHA"
echo "D97HS_ACTIVE_CORE_BYTES=$ACTIVE_CORE_BYTES"
[[ "$ACTIVE_CORE_SHA" == "$EXPECTED_ACTIVE_NATIVE_CORE_SHA" ]] || fail ACTIVE_CORE_NOT_NATIVE
[[ "$ACTIVE_CORE_BYTES" == "$EXPECTED_ACTIVE_NATIVE_CORE_BYTES" ]] || fail ACTIVE_CORE_BYTES_NOT_NATIVE

if [[ -f "$ACTIVE_COMPILER" ]]; then
  echo "D97HS_ACTIVE_LEGACY_32023_PRESENT=YES"
  echo "D97HS_ACTIVE_LEGACY_32023_SHA256=$(sha256 "$ACTIVE_COMPILER")"
  fail ACTIVE_SNAPSHOT_ALREADY_EXPOSES_LEGACY_32023
else
  echo "D97HS_ACTIVE_LEGACY_32023_PRESENT=NO"
fi

echo "D97HS_ACTIVE_SNAPSHOT_NATIVE_UNCHANGED=PASS"

printf '\n===== OFFICIAL PRIVILEGED HELPER =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"
HELPER_TEAM="$(team "$OFFICIAL_HELPER")"
echo "D97HS_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HS_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HS_OFFICIAL_HELPER=PASS"

printf '\n===== LOCAL CORRECTED METALLIB SOURCE =====\n'
[[ -d "$LOCAL_ROOT" && -f "$LOCAL_CORE" ]] || fail LOCAL_METALLIB_SOURCE_MISSING
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
LOCAL_CORE_SHA="$(sha256 "$LOCAL_CORE")"
LOCAL_CORE_BYTES="$(bytes "$LOCAL_CORE")"
echo "D97HS_LOCAL_METALLIB_COUNT=$LOCAL_COUNT"
echo "D97HS_LOCAL_CORE_SHA256=$LOCAL_CORE_SHA"
echo "D97HS_LOCAL_CORE_BYTES=$LOCAL_CORE_BYTES"
[[ "$LOCAL_COUNT" == "180" ]] || fail LOCAL_COUNT_NOT_180
[[ "$LOCAL_CORE_SHA" == "$EXPECTED_PATCHED_CORE_SHA" ]] || fail LOCAL_CORE_SHA_MISMATCH
[[ "$LOCAL_CORE_BYTES" == "$EXPECTED_PATCHED_CORE_BYTES" ]] || fail LOCAL_CORE_BYTES_MISMATCH
echo "D97HS_LOCAL_METALLIB_SOURCE=PASS"

printf '\n===== D97HO ARTIFACT STILL EXACT =====\n'
D97HO_ZIP=""
for P in "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip" "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97HO.zip"; do
  [[ -f "$P" ]] || continue
  if [[ "$(sha256 "$P")" == "$EXPECTED_D97HO_ZIP_SHA" ]]; then D97HO_ZIP="$P"; break; fi
done
[[ -n "$D97HO_ZIP" ]] || fail EXACT_D97HO_ZIP_NOT_FOUND
[[ "$(bytes "$D97HO_ZIP")" == "$EXPECTED_D97HO_ZIP_BYTES" ]] || fail D97HO_ZIP_BYTES_MISMATCH
echo "D97HS_D97HO_ZIP=$D97HO_ZIP"
echo "D97HS_D97HO_ZIP_SHA256=$(sha256 "$D97HO_ZIP")"
echo "D97HS_D97HO_ZIP_BYTES=$(bytes "$D97HO_ZIP")"
echo "D97HS_D97HO_ARTIFACT=PASS_EXACT"

printf '\n===== RESOLVE UNDERLYING SYSTEM VOLUME =====\n'
ROOT_ID="$(/usr/sbin/diskutil info / | /usr/bin/awk -F: '/Device Identifier/{gsub(/[[:space:]]/,"",$2); print $2; exit}')"
[[ -n "$ROOT_ID" ]] || fail ROOT_DEVICE_ID_UNKNOWN
BASE_ID="$(printf '%s\n' "$ROOT_ID" | /usr/bin/sed -E 's/s[0-9]+$//')"
[[ -n "$BASE_ID" && "$BASE_ID" != "$ROOT_ID" ]] || fail BASE_SYSTEM_DEVICE_NORMALIZATION_FAILED
echo "D97HS_ACTIVE_ROOT_DEVICE=$ROOT_ID"
echo "D97HS_BASE_SYSTEM_DEVICE=$BASE_ID"
/usr/sbin/diskutil info "/dev/$BASE_ID" > "$OUT/base_system_diskutil_info.txt" 2>&1 || fail BASE_SYSTEM_DISKUTIL_INFO_FAIL
/usr/bin/sudo /sbin/mount_apfs -o rdonly,nobrowse "/dev/$BASE_ID" "$MNT" || fail READONLY_MOUNT_FAIL
MOUNTED=1
echo "D97HS_READONLY_MOUNT=$MNT"
/sbin/mount | /usr/bin/grep -F " on $MNT " | tee "$OUT/mount_line.txt" || fail MOUNT_LINE_NOT_FOUND
echo "D97HS_BASE_SYSTEM_READONLY_MOUNT=PASS"

PATCHED_SERVICE="$MNT/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
PATCHED_COMPILER="$MNT/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
PATCHED_CORE="$MNT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"

printf '\n===== UNDERLYING SYSTEM EXACT P1 =====\n'
[[ -f "$PATCHED_SERVICE" ]] || fail PATCHED_SERVICE_MISSING
PATCHED_SERVICE_SHA="$(sha256 "$PATCHED_SERVICE")"
echo "D97HS_PATCHED_SERVICE_SHA256=$PATCHED_SERVICE_SHA"
echo "D97HS_PATCHED_SERVICE_BYTES=$(bytes "$PATCHED_SERVICE")"
[[ "$PATCHED_SERVICE_SHA" == "$EXPECTED_PATCHED_P1_SHA" ]] || fail PATCHED_SERVICE_NOT_EXACT_P1
/usr/bin/python3 - "$PATCHED_SERVICE" "$P1_OFFSET" "$EXPECTED_P1_POSTIMAGE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); off=int(sys.argv[2]); exp=bytes.fromhex(sys.argv[3]); b=p.read_bytes(); got=b[off:off+len(exp)]
print(f'D97HS_P1_OFFSET=0x{off:x}')
print('D97HS_P1_POSTIMAGE='+got.hex())
print('D97HS_P1_POSTIMAGE_MATCH='+('PASS' if got==exp else 'FAIL'))
if got != exp: raise SystemExit(2)
PY
echo "D97HS_PATCHED_P1=PASS"

printf '\n===== UNDERLYING SYSTEM EXACT P3-ONLY MTLCompiler 32023 =====\n'
[[ -f "$PATCHED_COMPILER" ]] || fail PATCHED_COMPILER_32023_MISSING
COMP_SHA="$(sha256 "$PATCHED_COMPILER")"
COMP_BYTES="$(bytes "$PATCHED_COMPILER")"
echo "D97HS_PATCHED_COMPILER_SHA256=$COMP_SHA"
echo "D97HS_PATCHED_COMPILER_BYTES=$COMP_BYTES"
[[ "$COMP_SHA" == "$EXPECTED_P3_COMPILER_SHA" ]] || fail PATCHED_COMPILER_NOT_EXACT_P3_ONLY
[[ "$COMP_BYTES" == "$EXPECTED_P3_COMPILER_BYTES" ]] || fail PATCHED_COMPILER_BYTES_MISMATCH
UUID_OUT="$(/usr/bin/dwarfdump --uuid "$PATCHED_COMPILER" 2>/dev/null || true)"
printf '%s\n' "$UUID_OUT"
printf '%s\n' "$UUID_OUT" | /usr/bin/grep -F "$EXPECTED_COMPILER_UUID" >/dev/null || fail PATCHED_COMPILER_UUID_MISMATCH

/usr/bin/python3 - "$PATCHED_COMPILER" "$P2_OFFSET" "$EXPECTED_P2_ORIGINAL" "$P3_OFFSET" "$EXPECTED_P3_POST" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); b=p.read_bytes(); p2o=int(sys.argv[2]); p2=bytes.fromhex(sys.argv[3]); p3o=int(sys.argv[4]); p3=bytes.fromhex(sys.argv[5])
g2=b[p2o:p2o+len(p2)]; g3=b[p3o:p3o+len(p3)]
print(f'D97HS_P2_OFFSET=0x{p2o:x}')
print('D97HS_P2_CURRENT='+g2.hex())
print('D97HS_P2_ORIGINAL_MATCH='+('PASS' if g2==p2 else 'FAIL'))
print(f'D97HS_P3_OFFSET=0x{p3o:x}')
print('D97HS_P3_CURRENT='+g3.hex())
print('D97HS_P3_POSTIMAGE_MATCH='+('PASS' if g3==p3 else 'FAIL'))
if g2 != p2: raise SystemExit(20)
if g3 != p3: raise SystemExit(30)
PY

echo "D97HS_P2_STATE=ORIGINAL_D0_NO_P2B"
echo "D97HS_P3_STATE=EXACT_SERIALIZED_BITCODE_POSTIMAGE"
echo "D97HS_PATCHED_COMPILER_P3_ONLY=PASS"

printf '\n===== UNDERLYING SYSTEM METALLIB 180/180 BYTE IDENTITY =====\n'
EXACT=0; MISSING=0; DIFFERENT=0
: > "$OUT/metallib_compare.tsv"
printf 'RELATIVE_PATH\tLOCAL_SHA256\tPATCHED_SHA256\tSTATUS\n' >> "$OUT/metallib_compare.tsv"
while IFS= read -r LF; do
  REL="${LF#$LOCAL_ROOT/}"; PF="$MNT/$REL"; LSH="$(sha256 "$LF")"
  if [[ ! -f "$PF" ]]; then
    MISSING=$((MISSING+1)); printf '%s\t%s\t\tMISSING\n' "$REL" "$LSH" >> "$OUT/metallib_compare.tsv"; continue
  fi
  PSH="$(sha256 "$PF")"
  if [[ "$LSH" == "$PSH" ]]; then EXACT=$((EXACT+1)); S=EXACT; else DIFFERENT=$((DIFFERENT+1)); S=DIFFERENT; fi
  printf '%s\t%s\t%s\t%s\n' "$REL" "$LSH" "$PSH" "$S" >> "$OUT/metallib_compare.tsv"
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)
echo "D97HS_PATCHED_METALLIB_EXACT=$EXACT"
echo "D97HS_PATCHED_METALLIB_MISSING=$MISSING"
echo "D97HS_PATCHED_METALLIB_DIFFERENT=$DIFFERENT"
[[ "$EXACT" -eq 180 ]] || fail PATCHED_METALLIB_EXACT_NOT_180
[[ "$MISSING" -eq 0 ]] || fail PATCHED_METALLIB_MISSING_NONZERO
[[ "$DIFFERENT" -eq 0 ]] || fail PATCHED_METALLIB_DIFFERENT_NONZERO

[[ -f "$PATCHED_CORE" ]] || fail PATCHED_CORE_MISSING
PATCHED_CORE_SHA="$(sha256 "$PATCHED_CORE")"
PATCHED_CORE_BYTES="$(bytes "$PATCHED_CORE")"
PATCHED_CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$PATCHED_CORE")"
echo "D97HS_PATCHED_CORE_SHA256=$PATCHED_CORE_SHA"
echo "D97HS_PATCHED_CORE_BYTES=$PATCHED_CORE_BYTES"
echo "D97HS_PATCHED_CORE_MAGIC=$PATCHED_CORE_MAGIC"
[[ "$PATCHED_CORE_SHA" == "$EXPECTED_PATCHED_CORE_SHA" ]] || fail PATCHED_CORE_SHA_MISMATCH
[[ "$PATCHED_CORE_BYTES" == "$EXPECTED_PATCHED_CORE_BYTES" ]] || fail PATCHED_CORE_BYTES_MISMATCH
[[ "$PATCHED_CORE_MAGIC" == "4d544c42" ]] || fail PATCHED_CORE_NOT_MTLB
echo "D97HS_PATCHED_METALLIB_LAYER=PASS"

printf '\n===== HASWELL BUNDLES / NEW AUXKC ON DISK =====\n'
[[ -d "$AZUL" ]] || fail AZUL_KEXT_NOT_REINSTALLED
[[ -d "$HD5000" ]] || fail HD5000_KEXT_NOT_REINSTALLED
echo "D97HS_AZUL_PATH=PRESENT"
echo "D97HS_HD5000_PATH=PRESENT"
AZUL_ID="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$AZUL/Contents/Info.plist" 2>/dev/null || true)"
HD5000_ID="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$HD5000/Contents/Info.plist" 2>/dev/null || true)"
echo "D97HS_AZUL_ID=$AZUL_ID"
echo "D97HS_HD5000_ID=$HD5000_ID"
[[ -n "$AZUL_ID" && -n "$HD5000_ID" ]] || fail HASWELL_BUNDLE_ID_READ_FAIL

if [[ -f "$AUXKC" ]]; then
  echo "D97HS_AUXKC_PATH=$AUXKC"
  echo "D97HS_AUXKC_BYTES=$(bytes "$AUXKC")"
  /usr/bin/kmutil inspect --show-kext-uuids --show-fileset-entries -A "$AUXKC" > "$OUT/kmutil_auxkc_inspect.txt" 2>&1 || true
  /usr/bin/grep -F "$AZUL_ID" "$OUT/kmutil_auxkc_inspect.txt" >/dev/null || fail AZUL_NOT_IN_NEW_AUXKC_INSPECT
  /usr/bin/grep -F "$HD5000_ID" "$OUT/kmutil_auxkc_inspect.txt" >/dev/null || fail HD5000_NOT_IN_NEW_AUXKC_INSPECT
  echo "D97HS_AZUL_IN_NEW_AUXKC=PASS"
  echo "D97HS_HD5000_IN_NEW_AUXKC=PASS"
else
  fail AUXKC_MISSING_AFTER_ROOT_PATCH
fi

# Informational only: the running kernel is still the pre-patch native VESA boot,
# so loaded/unloaded state is not a pre-reboot correctness gate.
CHECK_RC=0
/usr/bin/kmutil check --collection aux --load-info > "$OUT/kmutil_check_aux_loadinfo.txt" 2>&1 || CHECK_RC=$?
echo "D97HS_KMUTIL_CHECK_AUX_LOADINFO_RC_INFORMATIONAL=$CHECK_RC"
echo "D97HS_HASWELL_PRE_REBOOT_GATE=ON_DISK_AND_AUXKC_PRESENT"

printf '\n===== FINAL =====\n'
echo "D97HS_STATUS=PASS_PRE_REBOOT_P1_P3_AUDIT"
echo "D97HS_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN"
echo "D97HS_ACTIVE_SNAPSHOT=NATIVE_TAHOE_UNCHANGED"
echo "D97HS_PATCHED_P1=EXACT"
echo "D97HS_PATCHED_P3=EXACT_P3_ONLY"
echo "D97HS_P2B_REPLAY=NO"
echo "D97HS_AIR00_REPLAY=NO"
echo "D97HS_D34_REPLAY=NO"
echo "D97HS_PATCHED_METALLIBS=180_OF_180_EXACT"
echo "D97HS_HASWELL_AUXKC=ON_DISK_PRESENT_PASS"
echo "D97HS_NEXT=VESA_REBOOT_ONLY_AFTER_REVIEW"
echo "D97HS_REBOOT=NO"
echo "D97HS_REPORT=$REPORT"
