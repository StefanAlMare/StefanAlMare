#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HU — ASUS2 post-D97HO VESA reboot active-snapshot P1+P3 audit.
# Derived from D97HD, corrected using D97HQ evidence: under -igfxvesa Haswell kext loaded/unloaded state is informational, not a gate.
# READ-ONLY. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_BUILD="25G82"
EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P1_POSTIMAGE="81fe177d0000"
P1_OFFSET=$((0x3494))

EXPECTED_P3_COMPILER_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"
EXPECTED_P3_COMPILER_BYTES="1636896"
EXPECTED_COMPILER_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
EXPECTED_P2_ORIGINAL="418b81d0000000"
P2_OFFSET=$((0x9A8CD))
EXPECTED_P3_POST="81c900002000"
P3_OFFSET=$((0xA1573))

EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_CORE_BYTES="20739"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"
EXPECTED_D97HO_ZIP_SHA="a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3"
EXPECTED_D97HO_ZIP_BYTES="722975756"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"
AUXKC="/Library/KernelCollections/AuxiliaryKernelExtensions.kc"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HU_POST_VESA_ACTIVE_P1_P3_${STAMP}"
REPORT="$OUT/D97HU_REPORT.txt"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
plist(){ /usr/libexec/PlistBuddy -c "Print :$2" "$1/Contents/Info.plist" 2>/dev/null || true; }
fail(){ echo "D97HU_STATUS=FAIL"; echo "D97HU_REASON=$*"; echo "D97HU_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HU — POST VESA REBOOT ACTIVE P1+P3 AUDIT =====
READ_ONLY=YES
ROOT_PATCH=NO
RESTORE=NO
SYSTEM_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
P2B_REPLAY=NO
AIR00_REPLAY=NO
D34_REPLAY=NO
HASWELL_LOADED_STATE=INFORMATIONAL_UNDER_VESA
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "$EXPECTED_BUILD" ]] || fail NOT_25G82
/usr/bin/sw_vers

printf '\n===== BOOT SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HU_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HU_VESA_GATE=PASS"

printf '\n===== ACTIVE SNAPSHOT EXACT P1 =====\n'
[[ -f "$SERVICE" ]] || fail ACTIVE_SERVICE_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
SERVICE_BYTES="$(bytes "$SERVICE")"
echo "D97HU_ACTIVE_SERVICE_SHA256=$SERVICE_SHA"
echo "D97HU_ACTIVE_SERVICE_BYTES=$SERVICE_BYTES"
[[ "$SERVICE_SHA" == "$EXPECTED_P1_SHA" ]] || fail ACTIVE_SERVICE_NOT_EXACT_P1
/usr/bin/python3 - "$SERVICE" "$P1_OFFSET" "$EXPECTED_P1_POSTIMAGE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); off=int(sys.argv[2]); exp=bytes.fromhex(sys.argv[3]); b=p.read_bytes(); got=b[off:off+len(exp)]
print(f'D97HU_ACTIVE_P1_OFFSET=0x{off:x}')
print('D97HU_ACTIVE_P1_POSTIMAGE='+got.hex())
print('D97HU_ACTIVE_P1_POSTIMAGE_MATCH='+('PASS' if got==exp else 'FAIL'))
if got != exp: raise SystemExit(2)
PY
echo "D97HU_ACTIVE_P1=PASS"

printf '\n===== ACTIVE SNAPSHOT EXACT P3-ONLY MTLCompiler 32023 =====\n'
[[ -f "$COMPILER" ]] || fail ACTIVE_COMPILER_32023_MISSING
COMP_SHA="$(sha256 "$COMPILER")"
COMP_BYTES="$(bytes "$COMPILER")"
echo "D97HU_ACTIVE_COMPILER_SHA256=$COMP_SHA"
echo "D97HU_ACTIVE_COMPILER_BYTES=$COMP_BYTES"
[[ "$COMP_SHA" == "$EXPECTED_P3_COMPILER_SHA" ]] || fail ACTIVE_COMPILER_NOT_EXACT_P3_ONLY
[[ "$COMP_BYTES" == "$EXPECTED_P3_COMPILER_BYTES" ]] || fail ACTIVE_COMPILER_BYTES_MISMATCH
UUID_OUT="$(/usr/bin/dwarfdump --uuid "$COMPILER" 2>/dev/null || true)"
printf '%s\n' "$UUID_OUT"
printf '%s\n' "$UUID_OUT" | /usr/bin/grep -F "$EXPECTED_COMPILER_UUID" >/dev/null || fail ACTIVE_COMPILER_UUID_MISMATCH
/usr/bin/python3 - "$COMPILER" "$P2_OFFSET" "$EXPECTED_P2_ORIGINAL" "$P3_OFFSET" "$EXPECTED_P3_POST" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); b=p.read_bytes(); p2o=int(sys.argv[2]); p2=bytes.fromhex(sys.argv[3]); p3o=int(sys.argv[4]); p3=bytes.fromhex(sys.argv[5])
g2=b[p2o:p2o+len(p2)]; g3=b[p3o:p3o+len(p3)]
print(f'D97HU_ACTIVE_P2_OFFSET=0x{p2o:x}')
print('D97HU_ACTIVE_P2_CURRENT='+g2.hex())
print('D97HU_ACTIVE_P2_ORIGINAL_MATCH='+('PASS' if g2==p2 else 'FAIL'))
print(f'D97HU_ACTIVE_P3_OFFSET=0x{p3o:x}')
print('D97HU_ACTIVE_P3_CURRENT='+g3.hex())
print('D97HU_ACTIVE_P3_POSTIMAGE_MATCH='+('PASS' if g3==p3 else 'FAIL'))
if g2 != p2: raise SystemExit(20)
if g3 != p3: raise SystemExit(30)
PY
echo "D97HU_ACTIVE_P2_STATE=ORIGINAL_D0_NO_P2B"
echo "D97HU_ACTIVE_P3_STATE=EXACT_SERIALIZED_BITCODE_POSTIMAGE"
echo "D97HU_ACTIVE_COMPILER_P3_ONLY=PASS"

printf '\n===== ACTIVE CORRECTED METALLIB LAYER =====\n'
[[ -d "$LOCAL_ROOT" && -f "$LOCAL_CORE" ]] || fail LOCAL_METALLIB_SOURCE_MISSING
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
LOCAL_CORE_SHA="$(sha256 "$LOCAL_CORE")"
LOCAL_CORE_BYTES="$(bytes "$LOCAL_CORE")"
echo "D97HU_LOCAL_METALLIB_COUNT=$LOCAL_COUNT"
echo "D97HU_LOCAL_CORE_SHA256=$LOCAL_CORE_SHA"
echo "D97HU_LOCAL_CORE_BYTES=$LOCAL_CORE_BYTES"
[[ "$LOCAL_COUNT" == "180" ]] || fail LOCAL_COUNT_NOT_180
[[ "$LOCAL_CORE_SHA" == "$EXPECTED_CORE_SHA" ]] || fail LOCAL_CORE_SHA_MISMATCH
[[ "$LOCAL_CORE_BYTES" == "$EXPECTED_CORE_BYTES" ]] || fail LOCAL_CORE_BYTES_MISMATCH

EXACT=0; MISSING=0; DIFFERENT=0
: > "$OUT/metallib_compare.tsv"
printf 'RELATIVE_PATH\tLOCAL_SHA256\tACTIVE_SHA256\tSTATUS\n' >> "$OUT/metallib_compare.tsv"
while IFS= read -r LF; do
  REL="${LF#$LOCAL_ROOT/}"; AF="/$REL"; LSH="$(sha256 "$LF")"
  if [[ ! -f "$AF" ]]; then
    MISSING=$((MISSING+1)); printf '%s\t%s\t\tMISSING\n' "$REL" "$LSH" >> "$OUT/metallib_compare.tsv"; continue
  fi
  ASH="$(sha256 "$AF")"
  if [[ "$LSH" == "$ASH" ]]; then EXACT=$((EXACT+1)); S=EXACT; else DIFFERENT=$((DIFFERENT+1)); S=DIFFERENT; fi
  printf '%s\t%s\t%s\t%s\n' "$REL" "$LSH" "$ASH" "$S" >> "$OUT/metallib_compare.tsv"
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)
echo "D97HU_ACTIVE_METALLIB_EXACT=$EXACT"
echo "D97HU_ACTIVE_METALLIB_MISSING=$MISSING"
echo "D97HU_ACTIVE_METALLIB_DIFFERENT=$DIFFERENT"
[[ "$EXACT" -eq 180 ]] || fail ACTIVE_METALLIB_EXACT_NOT_180
[[ "$MISSING" -eq 0 ]] || fail ACTIVE_METALLIB_MISSING_NONZERO
[[ "$DIFFERENT" -eq 0 ]] || fail ACTIVE_METALLIB_DIFFERENT_NONZERO

[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
CORE_SHA="$(sha256 "$ACTIVE_CORE")"; CORE_BYTES="$(bytes "$ACTIVE_CORE")"; CORE_MAGIC="$(/usr/bin/xxd -p -l 4 "$ACTIVE_CORE")"
echo "D97HU_ACTIVE_CORE_SHA256=$CORE_SHA"
echo "D97HU_ACTIVE_CORE_BYTES=$CORE_BYTES"
echo "D97HU_ACTIVE_CORE_MAGIC=$CORE_MAGIC"
[[ "$CORE_SHA" == "$EXPECTED_CORE_SHA" ]] || fail ACTIVE_CORE_SHA_MISMATCH
[[ "$CORE_BYTES" == "$EXPECTED_CORE_BYTES" ]] || fail ACTIVE_CORE_BYTES_MISMATCH
[[ "$CORE_MAGIC" == "4d544c42" ]] || fail ACTIVE_CORE_NOT_MTLB
echo "D97HU_ACTIVE_METALLIB_LAYER=PASS"

printf '\n===== HASWELL BUNDLES / AUXKC =====\n'
[[ -d "$AZUL" ]] || fail AZUL_KEXT_MISSING
[[ -d "$HD5000" ]] || fail HD5000_KEXT_MISSING
AZUL_ID="$(plist "$AZUL" CFBundleIdentifier)"; HD5000_ID="$(plist "$HD5000" CFBundleIdentifier)"
echo "D97HU_AZUL_ID=$AZUL_ID"
echo "D97HU_HD5000_ID=$HD5000_ID"
[[ -n "$AZUL_ID" && -n "$HD5000_ID" ]] || fail HASWELL_BUNDLE_ID_READ_FAIL
[[ -f "$AUXKC" ]] || fail AUXKC_MISSING
/usr/bin/kmutil inspect --show-kext-uuids --show-fileset-entries -A "$AUXKC" > "$OUT/kmutil_inspect_auxkc.txt" 2>&1 || true
/usr/bin/grep -F "$AZUL_ID" "$OUT/kmutil_inspect_auxkc.txt" >/dev/null || fail AZUL_NOT_IN_AUXKC
/usr/bin/grep -F "$HD5000_ID" "$OUT/kmutil_inspect_auxkc.txt" >/dev/null || fail HD5000_NOT_IN_AUXKC
echo "D97HU_AZUL_IN_AUXKC=PASS"
echo "D97HU_HD5000_IN_AUXKC=PASS"
set +e
/usr/bin/kmutil check --collection aux --load-info > "$OUT/kmutil_check_aux_loadinfo.txt" 2>&1
CHECK_RC=$?
set -e
echo "D97HU_KMUTIL_CHECK_AUX_LOADINFO_RC=$CHECK_RC"
[[ "$CHECK_RC" -eq 0 ]] || fail AUXKC_CONSISTENCY_FAIL

/usr/bin/kmutil showloaded --collection aux --show all > "$OUT/kmutil_aux_all.txt" 2>&1 || true
/usr/bin/kmutil showloaded --collection aux --show loaded > "$OUT/kmutil_aux_loaded.txt" 2>&1 || true
/usr/bin/kmutil showloaded --collection aux --show unloaded > "$OUT/kmutil_aux_unloaded.txt" 2>&1 || true
for pair in "$AZUL_ID:AZUL" "$HD5000_ID:HD5000"; do
  ID="${pair%%:*}"; P="${pair##*:}"
  /usr/bin/grep -F "$ID" "$OUT/kmutil_aux_all.txt" >/dev/null 2>&1 && ALL=1 || ALL=0
  /usr/bin/grep -F "$ID" "$OUT/kmutil_aux_loaded.txt" >/dev/null 2>&1 && LOADED=1 || LOADED=0
  /usr/bin/grep -F "$ID" "$OUT/kmutil_aux_unloaded.txt" >/dev/null 2>&1 && UNLOADED=1 || UNLOADED=0
  echo "D97HU_${P}_IN_AUX_ALL=$ALL"
  echo "D97HU_${P}_IN_AUX_LOADED=$LOADED"
  echo "D97HU_${P}_IN_AUX_UNLOADED=$UNLOADED"
done

echo "D97HU_HASWELL_AUXKC=STRUCTURAL_PASS_LOAD_STATE_INFORMATIONAL"

printf '\n===== IOKIT VESA CONTEXT =====\n'
/usr/sbin/ioreg -lw0 > "$OUT/ioreg_full.txt" 2>/dev/null || true
for P in AppleIntelFramebufferAzul AppleIntelHD5000Graphics IntelAccelerator IntelFramebuffer display0 AppleBacklight; do
  C="$(/usr/bin/grep -c "$P" "$OUT/ioreg_full.txt" 2>/dev/null || true)"
  echo "D97HU_IOREG_${P}_COUNT=$C"
done
echo "D97HU_IOKIT_UNDER_VESA=INFORMATIONAL"

printf '\n===== OFFICIAL PRIVILEGED HELPER =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"; HELPER_TEAM="$(team "$OFFICIAL_HELPER")"
echo "D97HU_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HU_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HU_OFFICIAL_HELPER=PASS"

printf '\n===== D97HO ARTIFACT STILL EXACT =====\n'
D97HO_ZIP=""
for P in "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip" "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97HO.zip"; do
  [[ -f "$P" ]] || continue
  if [[ "$(sha256 "$P")" == "$EXPECTED_D97HO_ZIP_SHA" ]]; then D97HO_ZIP="$P"; break; fi
done
[[ -n "$D97HO_ZIP" ]] || fail EXACT_D97HO_ZIP_NOT_FOUND
[[ "$(bytes "$D97HO_ZIP")" == "$EXPECTED_D97HO_ZIP_BYTES" ]] || fail D97HO_ZIP_BYTES_MISMATCH
echo "D97HU_D97HO_ZIP=$D97HO_ZIP"
echo "D97HU_D97HO_ZIP_SHA256=$(sha256 "$D97HO_ZIP")"
echo "D97HU_D97HO_ZIP_BYTES=$(bytes "$D97HO_ZIP")"
echo "D97HU_D97HO_ARTIFACT=PASS_EXACT"

printf '\n===== FINAL =====\n'
echo "D97HU_STATUS=PASS_ACTIVE_P1_P3_VESA"
echo "D97HU_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS_ACTIVE_SNAPSHOT"
echo "D97HU_ACTIVE_P1=EXACT"
echo "D97HU_ACTIVE_P3=EXACT_P3_ONLY"
echo "D97HU_P2B_REPLAY=NO"
echo "D97HU_AIR00_REPLAY=NO"
echo "D97HU_D34_REPLAY=NO"
echo "D97HU_ACTIVE_METALLIBS=180_OF_180_EXACT"
echo "D97HU_HASWELL_AUXKC=VALID_PRESENT_LOAD_STATE_INFORMATIONAL_UNDER_VESA"
echo "D97HU_NEXT=REVALIDATE_D97EW_CAPTURE_BEFORE_ANY_ACCELERATED_BOOT"
echo "D97HU_ACCELERATION=NOT_YET_AUTHORIZED"
echo "D97HU_REBOOT=NO"
echo "D97HU_REPORT=$REPORT"
