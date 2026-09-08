#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HD — ASUS2 post-D97GS VESA reboot active-snapshot audit.
# READ-ONLY. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P1_POSTIMAGE="81fe177d0000"
EXPECTED_P1_OFFSET=$((0x3494))
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_CORE_BYTES="20739"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HD_POST_VESA_REBOOT_${STAMP}"
REPORT="$OUT/D97HD_REPORT.txt"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
fail(){ echo "D97HD_STATUS=FAIL"; echo "D97HD_REASON=$*"; echo "D97HD_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HD — POST VESA REBOOT ACTIVE-SNAPSHOT AUDIT =====
ROOT_PATCH=NO
RESTORE=NO
SYSTEM_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== BOOT SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HD_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HD_VESA_GATE=PASS"

printf '\n===== ACTIVE SNAPSHOT EXACT P1 =====\n'
[[ -f "$SERVICE" ]] || fail ACTIVE_SERVICE_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
SERVICE_BYTES="$(bytes "$SERVICE")"
echo "D97HD_ACTIVE_SERVICE_SHA256=$SERVICE_SHA"
echo "D97HD_ACTIVE_SERVICE_BYTES=$SERVICE_BYTES"
[[ "$SERVICE_SHA" == "$EXPECTED_P1_SHA" ]] || fail ACTIVE_SERVICE_NOT_EXACT_P1

/usr/bin/python3 - "$SERVICE" "$EXPECTED_P1_OFFSET" "$EXPECTED_P1_POSTIMAGE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); off=int(sys.argv[2]); exp=bytes.fromhex(sys.argv[3]); b=p.read_bytes(); got=b[off:off+len(exp)]
print(f'D97HD_ACTIVE_P1_OFFSET=0x{off:x}')
print('D97HD_ACTIVE_P1_POSTIMAGE='+got.hex())
print('D97HD_ACTIVE_P1_POSTIMAGE_MATCH=' + ('PASS' if got==exp else 'FAIL'))
if got != exp: raise SystemExit(2)
PY

echo "D97HD_ACTIVE_P1=PASS"

printf '\n===== ACTIVE CORRECTED METALLIB LAYER =====\n'
[[ -d "$LOCAL_ROOT" && -f "$LOCAL_CORE" ]] || fail LOCAL_METALLIB_SOURCE_MISSING
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
LOCAL_CORE_SHA="$(sha256 "$LOCAL_CORE")"
LOCAL_CORE_BYTES="$(bytes "$LOCAL_CORE")"
echo "D97HD_LOCAL_METALLIB_COUNT=$LOCAL_COUNT"
echo "D97HD_LOCAL_CORE_SHA256=$LOCAL_CORE_SHA"
echo "D97HD_LOCAL_CORE_BYTES=$LOCAL_CORE_BYTES"
[[ "$LOCAL_COUNT" == "180" ]] || fail LOCAL_COUNT_NOT_180
[[ "$LOCAL_CORE_SHA" == "$EXPECTED_CORE_SHA" ]] || fail LOCAL_CORE_SHA_MISMATCH
[[ "$LOCAL_CORE_BYTES" == "$EXPECTED_CORE_BYTES" ]] || fail LOCAL_CORE_BYTES_MISMATCH

EXACT=0
MISSING=0
DIFFERENT=0
: > "$OUT/metallib_compare.tsv"
printf 'RELATIVE_PATH\tLOCAL_SHA256\tACTIVE_SHA256\tSTATUS\n' >> "$OUT/metallib_compare.tsv"
while IFS= read -r LF; do
  REL="${LF#$LOCAL_ROOT/}"
  AF="/$REL"
  LSH="$(sha256 "$LF")"
  if [[ ! -f "$AF" ]]; then
    MISSING=$((MISSING+1))
    printf '%s\t%s\t\tMISSING\n' "$REL" "$LSH" >> "$OUT/metallib_compare.tsv"
    continue
  fi
  ASH="$(sha256 "$AF")"
  if [[ "$LSH" == "$ASH" ]]; then
    EXACT=$((EXACT+1))
    printf '%s\t%s\t%s\tEXACT\n' "$REL" "$LSH" "$ASH" >> "$OUT/metallib_compare.tsv"
  else
    DIFFERENT=$((DIFFERENT+1))
    printf '%s\t%s\t%s\tDIFFERENT\n' "$REL" "$LSH" "$ASH" >> "$OUT/metallib_compare.tsv"
  fi
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)

echo "D97HD_ACTIVE_METALLIB_EXACT=$EXACT"
echo "D97HD_ACTIVE_METALLIB_MISSING=$MISSING"
echo "D97HD_ACTIVE_METALLIB_DIFFERENT=$DIFFERENT"
[[ "$EXACT" -eq 180 ]] || fail ACTIVE_METALLIB_EXACT_NOT_180
[[ "$MISSING" -eq 0 ]] || fail ACTIVE_METALLIB_MISSING_NONZERO
[[ "$DIFFERENT" -eq 0 ]] || fail ACTIVE_METALLIB_DIFFERENT_NONZERO

[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
CORE_SHA="$(sha256 "$ACTIVE_CORE")"
CORE_BYTES="$(bytes "$ACTIVE_CORE")"
CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$ACTIVE_CORE")"
echo "D97HD_ACTIVE_CORE_SHA256=$CORE_SHA"
echo "D97HD_ACTIVE_CORE_BYTES=$CORE_BYTES"
echo "D97HD_ACTIVE_CORE_MAGIC=$CORE_MAGIC"
[[ "$CORE_SHA" == "$EXPECTED_CORE_SHA" ]] || fail ACTIVE_CORE_SHA_MISMATCH
[[ "$CORE_BYTES" == "$EXPECTED_CORE_BYTES" ]] || fail ACTIVE_CORE_BYTES_MISMATCH
[[ "$CORE_MAGIC" == "4d544c42" ]] || fail ACTIVE_CORE_NOT_MTLB

echo "D97HD_ACTIVE_METALLIB_LAYER=PASS"

printf '\n===== HASWELL AUXKC / LOADED DRIVER =====\n'
[[ -d "$AZUL" ]] || fail AZUL_KEXT_MISSING
[[ -d "$HD5000" ]] || fail HD5000_KEXT_MISSING
AZUL_VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$AZUL/Contents/Info.plist" 2>/dev/null || true)"
HD5000_VER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$HD5000/Contents/Info.plist" 2>/dev/null || true)"
echo "D97HD_AZUL_VERSION=$AZUL_VER"
echo "D97HD_HD5000_VERSION=$HD5000_VER"

/usr/bin/kmutil showloaded 2>/dev/null > "$OUT/kmutil_showloaded.txt" || true
AZUL_LOADED="$(/usr/bin/grep -F 'AppleIntelFramebufferAzul' "$OUT/kmutil_showloaded.txt" || true)"
HD5000_LOADED="$(/usr/bin/grep -F 'AppleIntelHD5000Graphics' "$OUT/kmutil_showloaded.txt" || true)"
[[ -n "$AZUL_LOADED" ]] || fail AZUL_NOT_LOADED
[[ -n "$HD5000_LOADED" ]] || fail HD5000_NOT_LOADED
printf '%s\n' "$AZUL_LOADED"
printf '%s\n' "$HD5000_LOADED"
echo "D97HD_HASWELL_KEXTS_INSTALLED_AND_LOADED=PASS"

printf '\n===== OFFICIAL PRIVILEGED HELPER =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"
HELPER_TEAM="$(team "$OFFICIAL_HELPER")"
echo "D97HD_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HD_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HD_OFFICIAL_HELPER=PASS"

printf '\n===== FINAL =====\n'
echo "D97HD_STATUS=PASS_ACTIVE_SNAPSHOT_VESA"
echo "D97HD_ACTIVE_P1=STRUCTURAL_SEMANTIC_PASS"
echo "D97HD_ACTIVE_METALLIBS=180_OF_180_EXACT"
echo "D97HD_HASWELL_AUXKC=LOADED_PASS"
echo "D97HD_VESA_BOOT=PASS"
echo "D97HD_ACCELERATION=NOT_YET_AUTHORIZED"
echo "D97HD_REBOOT=NO"
echo "D97HD_REPORT=$REPORT"
