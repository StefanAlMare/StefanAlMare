#!/bin/bash
set -euo pipefail

EXPECTED_SOURCE_COMMIT="524467d3f41166f58e75a39d003ae79eedf71d7e"
EXPECTED_SOURCE_BLOB="08aca87f551cf9dbd2d12974d58f81e7de2495c9"
SOURCE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${EXPECTED_SOURCE_COMMIT}/OCLP-Continuity/artifacts/OCLP7_D97FN_DSC_EXTRACTOR_WRAPPER.cc"
STAMP="$(date '+%Y%m%d_%H%M%S')"
WORK="${HOME}/Desktop/OCLP7_D97FN_DSC_EXTRACTOR_IMAC_${STAMP}"
SRC="${WORK}/OCLP7_D97FN_DSC_EXTRACTOR_WRAPPER.cc"
BIN="${WORK}/d97fn-dsc-extractor"
REPORT="${WORK}/D97FN_BUILD_REPORT.txt"
ZIP="${WORK}.zip"

fail(){ echo "D97FN_BUILD_STATUS=FAIL"; echo "D97FN_FAIL_REASON=$*"; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || fail "NOT_DARWIN"
[[ "$(uname -m)" == "x86_64" ]] || fail "NOT_X86_64"

CLANG="$(/usr/bin/xcrun --find clang++ 2>/dev/null || true)"
SDKROOT="$(/usr/bin/xcrun --sdk macosx --show-sdk-path 2>/dev/null || true)"
LIPO="$(/usr/bin/xcrun --find lipo 2>/dev/null || true)"
DWARFDUMP="$(/usr/bin/xcrun --find dwarfdump 2>/dev/null || true)"
OTOOL="$(/usr/bin/xcrun --find otool 2>/dev/null || true)"

[[ -n "$CLANG" && -x "$CLANG" ]] || fail "CLANGXX_NOT_FOUND"
[[ -n "$SDKROOT" && -d "$SDKROOT" ]] || fail "MACOS_SDK_NOT_FOUND"
[[ -f "$SDKROOT/usr/include/dlfcn.h" ]] || fail "DLFCN_HEADER_NOT_FOUND_IN_SDK_$SDKROOT"
[[ -n "$LIPO" && -x "$LIPO" ]] || fail "LIPO_NOT_FOUND"
[[ -n "$DWARFDUMP" && -x "$DWARFDUMP" ]] || fail "DWARFDUMP_NOT_FOUND"
[[ -n "$OTOOL" && -x "$OTOOL" ]] || fail "OTOOL_NOT_FOUND"
[[ -x /usr/bin/codesign ]] || fail "CODESIGN_NOT_FOUND"
[[ -x /usr/bin/shasum ]] || fail "SHASUM_NOT_FOUND"
[[ -x /usr/bin/stat ]] || fail "STAT_NOT_FOUND"
[[ -x /usr/bin/file ]] || fail "FILE_NOT_FOUND"
[[ -x /usr/bin/ditto ]] || fail "DITTO_NOT_FOUND"
[[ -x /usr/bin/curl ]] || fail "CURL_NOT_FOUND"
[[ -x /usr/bin/git ]] || fail "GIT_NOT_FOUND"
[[ -x /bin/ls ]] || fail "LS_NOT_FOUND"

mkdir -p "$WORK"

{
  echo "===== D97FN BUILD HOST ====="
  sw_vers
  uname -a
  echo "CLANG=$CLANG"
  "$CLANG" --version
  echo "SDKROOT=$SDKROOT"
  echo "DLFCN_HEADER=$SDKROOT/usr/include/dlfcn.h"
  /bin/ls -l "$SDKROOT/usr/include/dlfcn.h"
  echo "LIPO=$LIPO"
  echo "DWARFDUMP=$DWARFDUMP"
  echo "OTOOL=$OTOOL"
  echo "SOURCE_COMMIT=$EXPECTED_SOURCE_COMMIT"
  echo "EXPECTED_SOURCE_BLOB=$EXPECTED_SOURCE_BLOB"
} | /usr/bin/tee "$REPORT"

/usr/bin/curl -fL --retry 3 --retry-delay 2 "$SOURCE_URL" -o "$SRC"
ACTUAL_BLOB="$(/usr/bin/git hash-object "$SRC")"
echo "ACTUAL_SOURCE_BLOB=$ACTUAL_BLOB" | /usr/bin/tee -a "$REPORT"
[[ "$ACTUAL_BLOB" == "$EXPECTED_SOURCE_BLOB" ]] || fail "SOURCE_BLOB_MISMATCH"

echo "===== COMPILE =====" | /usr/bin/tee -a "$REPORT"
"$CLANG" \
  -std=c++17 \
  -fblocks \
  -O2 \
  -Wall \
  -Wextra \
  -arch x86_64 \
  -isysroot "$SDKROOT" \
  "$SRC" \
  -o "$BIN" \
  2>&1 | /usr/bin/tee -a "$REPORT"

/usr/bin/codesign --force --sign - "$BIN" 2>&1 | /usr/bin/tee -a "$REPORT"

ARCHS="$("$LIPO" -archs "$BIN")"
[[ "$ARCHS" == "x86_64" ]] || fail "ARCH_MISMATCH_$ARCHS"

BIN_SHA="$(/usr/bin/shasum -a 256 "$BIN" | /usr/bin/awk '{print $1}')"
BIN_UUID="$("$DWARFDUMP" --uuid "$BIN" | /usr/bin/awk 'NR==1{print $2}')"
BIN_BYTES="$(/usr/bin/stat -f '%z' "$BIN")"

{
  echo
  echo "===== BINARY IDENTITY ====="
  /usr/bin/file "$BIN"
  echo "D97FN_ARCHS=$ARCHS"
  echo "D97FN_BINARY_SHA256=$BIN_SHA"
  echo "D97FN_BINARY_UUID=$BIN_UUID"
  echo "D97FN_BINARY_BYTES=$BIN_BYTES"
  echo
  echo "===== DEPENDENCIES ====="
  "$OTOOL" -L "$BIN"
  echo
  echo "D97FN_SOURCE_COMMIT=$EXPECTED_SOURCE_COMMIT"
  echo "D97FN_SOURCE_BLOB=$ACTUAL_BLOB"
  echo "D97FN_SDKROOT=$SDKROOT"
  echo "D97FN_BUILD_STATUS=PASS"
  echo "D97FN_ASUS2_COMPILE=NO"
  echo "D97FN_SYSTEM_MUTATION=NO"
  echo "D97FN_REBOOT=NO"
} | /usr/bin/tee -a "$REPORT"

/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$WORK" "$ZIP"
ZIP_SHA="$(/usr/bin/shasum -a 256 "$ZIP" | /usr/bin/awk '{print $1}')"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"

{
  echo "D97FN_ZIP=$ZIP"
  echo "D97FN_ZIP_SHA256=$ZIP_SHA"
  echo "D97FN_ZIP_BYTES=$ZIP_BYTES"
} | /usr/bin/tee -a "$REPORT"

printf '%s  %s\n' "$ZIP_SHA" "$(basename "$ZIP")" > "${ZIP}.sha256"

echo
echo "D97FN_BUILD_COMPLETE=YES"
echo "UPLOAD_ZIP=$ZIP"
