#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HP — ASUS2 read-only preflight before any D97HO Root Patch.
# Verifies exact D97HO artifact, active VESA/P1/metallib/helper/Haswell state,
# and proves active MTLCompiler 32023 is still the exact pre-P3 base.
# NO Root Patch/Restore. NO EFI/NVRAM/framebuffer/system mutation. NO reboot.

EXPECTED_D97HO_ZIP_SHA="a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3"
EXPECTED_D97HO_ZIP_BYTES="722975756"
EXPECTED_D97HI_INNER_EXE_SHA="1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133"
EXPECTED_LAUNCHER_SHA="344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_D97DX_PATCH_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_D97GS_PATCH_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_D97HI_SOURCE_DIFF_SHA="c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2"
EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P1_POSTIMAGE="81fe177d0000"
P1_OFFSET=$((0x3494))
EXPECTED_COMPILER_PRE_P3_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_P2_ORIGINAL="418b81d0000000"
P2_OFFSET=$((0x9A8CD))
EXPECTED_P3_PRE="81e100002000"
P3_OFFSET=$((0xA1573))
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_CORE_BYTES="20739"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
LOCAL_ROOT="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
LOCAL_CORE="$LOCAL_ROOT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
ACTIVE_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
OFFICIAL_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
AZUL="/Library/Extensions/AppleIntelFramebufferAzul.kext"
HD5000="/Library/Extensions/AppleIntelHD5000Graphics.kext"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HP_ASUS2_PREFLIGHT_${STAMP}"
TMP="$HOME/Library/Caches/OCLP7-D97HP-$STAMP"
EXTRACT="$TMP/extracted"
REPORT="$OUT/D97HP_REPORT.txt"
mkdir -p "$OUT" "$EXTRACT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }
team(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true; }
fail(){ echo "D97HP_STATUS=FAIL"; echo "D97HP_REASON=$*"; echo "D97HP_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HP — ASUS2 D97HO + ACTIVE P1/PRE-P3 READ-ONLY PREFLIGHT =====
READ_ONLY=YES
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

printf '\n===== CURRENT VESA SAFETY =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HP_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
echo "D97HP_VESA_GATE=PASS"

printf '\n===== EXACT D97HO ARTIFACT =====\n'
D97HO_ZIP=""
for P in "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip" "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97HO.zip"; do
  [[ -f "$P" ]] || continue
  if [[ "$(sha256 "$P")" == "$EXPECTED_D97HO_ZIP_SHA" ]]; then D97HO_ZIP="$P"; break; fi
done
[[ -n "$D97HO_ZIP" ]] || fail EXACT_D97HO_ZIP_NOT_FOUND
[[ "$(bytes "$D97HO_ZIP")" == "$EXPECTED_D97HO_ZIP_BYTES" ]] || fail D97HO_ZIP_BYTES_MISMATCH
echo "D97HP_D97HO_ZIP=$D97HO_ZIP"
echo "D97HP_D97HO_ZIP_SHA256=$(sha256 "$D97HO_ZIP")"
echo "D97HP_D97HO_ZIP_BYTES=$(bytes "$D97HO_ZIP")"

/usr/bin/ditto -x -k "$D97HO_ZIP" "$EXTRACT"
APP="$EXTRACT/OpenCore-Patcher-Tahoe-D97HO.app"
[[ -d "$APP" ]] || fail D97HO_APP_MISSING_AFTER_EXTRACT
/usr/bin/codesign --verify --deep --strict "$APP" || fail D97HO_OUTER_CODESIGN_FAIL
LAUNCHER="$APP/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DX"
DEBUG="$APP/Contents/Resources/debug-privileged-helper"
D97DX_PATCH="$APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
D97GS_PATCH="$APP/Contents/Resources/OCLP7_D97GS_SOURCE.patch"
INNER_EXE="$APP/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
PROV="$APP/Contents/Resources/OCLP7_D97HI_PROVENANCE.txt"
for P in "$LAUNCHER" "$DEBUG" "$D97DX_PATCH" "$D97GS_PATCH" "$INNER_EXE" "$PROV"; do [[ -f "$P" ]] || fail "D97HO_COMPONENT_MISSING_$P"; done
[[ "$(sha256 "$LAUNCHER")" == "$EXPECTED_LAUNCHER_SHA" ]] || fail D97HO_LAUNCHER_SHA_MISMATCH
[[ "$(sha256 "$DEBUG")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail D97HO_DEBUG_HELPER_SHA_MISMATCH
[[ "$(sha256 "$D97DX_PATCH")" == "$EXPECTED_D97DX_PATCH_SHA" ]] || fail D97HO_D97DX_PATCH_SHA_MISMATCH
[[ "$(sha256 "$D97GS_PATCH")" == "$EXPECTED_D97GS_PATCH_SHA" ]] || fail D97HO_D97GS_PATCH_SHA_MISMATCH
[[ "$(sha256 "$INNER_EXE")" == "$EXPECTED_D97HI_INNER_EXE_SHA" ]] || fail D97HO_INNER_EXE_SHA_MISMATCH
[[ "$(/usr/bin/lipo -archs "$INNER_EXE")" == x86_64 ]] || fail D97HO_INNER_ARCH_MISMATCH
/usr/bin/codesign --verify --deep --strict "$APP/Contents/Resources/OpenCore-Patcher.app" || fail D97HO_INNER_CODESIGN_FAIL

for T in \
  "D97HI_SOURCE_DIFF_SHA256=$EXPECTED_D97HI_SOURCE_DIFF_SHA" \
  "D97HI_INNER_EXECUTABLE_SHA256=$EXPECTED_D97HI_INNER_EXE_SHA" \
  "D97HI_P1_POST_SHA256=$EXPECTED_P1_SHA" \
  "D97HI_P3_POST_SHA256=0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90" \
  "D97HI_P2B_REPLAY=NO" "D97HI_AIR00_REPLAY=NO" "D97HI_D34_REPLAY=NO"
do
  /usr/bin/grep -Fx "$T" "$PROV" >/dev/null || fail "D97HO_PROVENANCE_TOKEN_MISSING_$T"
done

echo "D97HP_D97HO_ARTIFACT=PASS_EXACT"

printf '\n===== ACTIVE P1 SERVICE =====\n'
[[ -f "$SERVICE" ]] || fail ACTIVE_SERVICE_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
echo "D97HP_ACTIVE_SERVICE_SHA256=$SERVICE_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_P1_SHA" ]] || fail ACTIVE_SERVICE_NOT_EXACT_P1
/usr/bin/python3 - "$SERVICE" "$P1_OFFSET" "$EXPECTED_P1_POSTIMAGE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); off=int(sys.argv[2]); exp=bytes.fromhex(sys.argv[3]); b=p.read_bytes(); got=b[off:off+len(exp)]
print(f'D97HP_P1_OFFSET=0x{off:x}')
print('D97HP_P1_POSTIMAGE='+got.hex())
print('D97HP_P1_POSTIMAGE_MATCH='+('PASS' if got==exp else 'FAIL'))
if got!=exp: raise SystemExit(2)
PY
echo "D97HP_ACTIVE_P1=PASS"

printf '\n===== ACTIVE MTLCompiler 32023 PRE-P3 / NO-P2B =====\n'
[[ -f "$COMPILER" ]] || fail ACTIVE_COMPILER_MISSING
COMP_SHA="$(sha256 "$COMPILER")"
COMP_BYTES="$(bytes "$COMPILER")"
echo "D97HP_ACTIVE_COMPILER_SHA256=$COMP_SHA"
echo "D97HP_ACTIVE_COMPILER_BYTES=$COMP_BYTES"
[[ "$COMP_SHA" == "$EXPECTED_COMPILER_PRE_P3_SHA" ]] || fail ACTIVE_COMPILER_NOT_EXACT_PRE_P3_BASE
/usr/bin/dwarfdump --uuid "$COMPILER" 2>/dev/null || true
/usr/bin/python3 - "$COMPILER" "$P2_OFFSET" "$EXPECTED_P2_ORIGINAL" "$P3_OFFSET" "$EXPECTED_P3_PRE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); b=p.read_bytes(); p2o=int(sys.argv[2]); p2=bytes.fromhex(sys.argv[3]); p3o=int(sys.argv[4]); p3=bytes.fromhex(sys.argv[5])
g2=b[p2o:p2o+len(p2)]; g3=b[p3o:p3o+len(p3)]
print(f'D97HP_P2_OFFSET=0x{p2o:x}')
print('D97HP_P2_CURRENT='+g2.hex())
print('D97HP_P2_ORIGINAL_MATCH='+('PASS' if g2==p2 else 'FAIL'))
print(f'D97HP_P3_OFFSET=0x{p3o:x}')
print('D97HP_P3_CURRENT='+g3.hex())
print('D97HP_P3_PREIMAGE_MATCH='+('PASS' if g3==p3 else 'FAIL'))
if g2!=p2: raise SystemExit(20)
if g3!=p3: raise SystemExit(30)
PY
echo "D97HP_ACTIVE_P2_STATE=ORIGINAL_D0_NO_P2B"
echo "D97HP_ACTIVE_P3_STATE=NOT_APPLIED_EXACT_PREIMAGE"
echo "D97HP_ACTIVE_COMPILER_PRE_P3=PASS"

printf '\n===== ACTIVE CORRECTED METALLIB LAYER =====\n'
[[ -d "$LOCAL_ROOT" && -f "$LOCAL_CORE" ]] || fail LOCAL_METALLIB_SOURCE_MISSING
LOCAL_COUNT="$(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/wc -l | /usr/bin/tr -d ' ')"
[[ "$LOCAL_COUNT" == 180 ]] || fail LOCAL_METALLIB_COUNT_NOT_180
[[ "$(sha256 "$LOCAL_CORE")" == "$EXPECTED_CORE_SHA" ]] || fail LOCAL_CORE_SHA_MISMATCH
[[ "$(bytes "$LOCAL_CORE")" == "$EXPECTED_CORE_BYTES" ]] || fail LOCAL_CORE_BYTES_MISMATCH

EXACT=0; MISSING=0; DIFFERENT=0
: > "$OUT/metallib_compare.tsv"
printf 'RELATIVE_PATH\tLOCAL_SHA256\tACTIVE_SHA256\tSTATUS\n' >> "$OUT/metallib_compare.tsv"
while IFS= read -r LF; do
  REL="${LF#$LOCAL_ROOT/}"; AF="/$REL"; LSH="$(sha256 "$LF")"
  if [[ ! -f "$AF" ]]; then MISSING=$((MISSING+1)); printf '%s\t%s\t\tMISSING\n' "$REL" "$LSH" >> "$OUT/metallib_compare.tsv"; continue; fi
  ASH="$(sha256 "$AF")"
  if [[ "$LSH" == "$ASH" ]]; then EXACT=$((EXACT+1)); S=EXACT; else DIFFERENT=$((DIFFERENT+1)); S=DIFFERENT; fi
  printf '%s\t%s\t%s\t%s\n' "$REL" "$LSH" "$ASH" "$S" >> "$OUT/metallib_compare.tsv"
done < <(/usr/bin/find "$LOCAL_ROOT" -type f -name '*.metallib' | /usr/bin/sort)
echo "D97HP_ACTIVE_METALLIB_EXACT=$EXACT"
echo "D97HP_ACTIVE_METALLIB_MISSING=$MISSING"
echo "D97HP_ACTIVE_METALLIB_DIFFERENT=$DIFFERENT"
[[ "$EXACT" -eq 180 && "$MISSING" -eq 0 && "$DIFFERENT" -eq 0 ]] || fail ACTIVE_METALLIB_LAYER_NOT_EXACT_180
[[ -f "$ACTIVE_CORE" ]] || fail ACTIVE_CORE_MISSING
[[ "$(sha256 "$ACTIVE_CORE")" == "$EXPECTED_CORE_SHA" ]] || fail ACTIVE_CORE_SHA_MISMATCH
[[ "$(bytes "$ACTIVE_CORE")" == "$EXPECTED_CORE_BYTES" ]] || fail ACTIVE_CORE_BYTES_MISMATCH
[[ "$(/usr/bin/xxd -p -l 4 "$ACTIVE_CORE")" == 4d544c42 ]] || fail ACTIVE_CORE_NOT_MTLB
echo "D97HP_ACTIVE_METALLIB_LAYER=PASS"

printf '\n===== HASWELL KEXTS =====\n'
[[ -d "$AZUL" ]] || fail AZUL_KEXT_MISSING
[[ -d "$HD5000" ]] || fail HD5000_KEXT_MISSING
/usr/bin/kmutil showloaded 2>/dev/null > "$OUT/kmutil_showloaded.txt" || true
/usr/bin/grep -F 'AppleIntelFramebufferAzul' "$OUT/kmutil_showloaded.txt" >/dev/null || fail AZUL_NOT_LOADED
/usr/bin/grep -F 'AppleIntelHD5000Graphics' "$OUT/kmutil_showloaded.txt" >/dev/null || fail HD5000_NOT_LOADED
echo "D97HP_HASWELL_KEXTS_LOADED=PASS"

printf '\n===== OFFICIAL PRIVILEGED HELPER =====\n'
[[ -f "$OFFICIAL_HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HELPER_SHA="$(sha256 "$OFFICIAL_HELPER")"; HELPER_TEAM="$(team "$OFFICIAL_HELPER")"
echo "D97HP_OFFICIAL_HELPER_SHA256=$HELPER_SHA"
echo "D97HP_OFFICIAL_HELPER_TEAM=$HELPER_TEAM"
[[ "$HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail OFFICIAL_HELPER_SHA_MISMATCH
[[ "$HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail OFFICIAL_HELPER_TEAM_MISMATCH
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" || fail OFFICIAL_HELPER_CODESIGN_FAIL
echo "D97HP_OFFICIAL_HELPER=PASS"

printf '\n===== FINAL =====\n'
echo "D97HP_D97HO_ARTIFACT=STATIC_STRUCTURAL_SEMANTIC_PASS"
echo "D97HP_ACTIVE_P1=STRUCTURAL_SEMANTIC_PASS"
echo "D97HP_ACTIVE_COMPILER=EXACT_PRE_P3_NO_P2B_PASS"
echo "D97HP_ACTIVE_METALLIBS=180_OF_180_EXACT"
echo "D97HP_HASWELL_AUXKC=LOADED_PASS"
echo "D97HP_OFFICIAL_HELPER=PASS"
echo "D97HP_VESA_BOOT=PASS"
echo "D97HP_STATUS=PASS_READONLY_PREFLIGHT"
echo "D97HP_ROOT_PATCH=NOT_AUTHORIZED_BY_THIS_SCRIPT"
echo "D97HP_RESTORE_DECISION=PENDING_REVIEW"
echo "D97HP_REBOOT=NO"
echo "D97HP_REPORT=$REPORT"
