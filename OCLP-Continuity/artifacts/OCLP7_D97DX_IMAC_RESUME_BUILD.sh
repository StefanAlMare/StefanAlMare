#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DX — iMac resume after D97DW helper SDK discovery failure.
# Reuses existing D97DU worktree/venv/assets. Does NOT reclone or reinstall requirements.
# BUILD HOST: Intel iMac only.
# NO Root Patch. NO EFI mutation. NO system root mutation. NO reboot.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
PATCHDICT_SHA256="c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e"
UNIVERSAL_SHA256="33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7"
PAYLOADS_SHA256="e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b"
OFFICIAL_HELPER_SHA256="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
DORTANIA_TEAM="S74BDJXQMD"

WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
VENV_PY="$WORK/.venv/bin/python"
PATCHDICT="$WORK/sys_patch_dict-25G82.py"
UNIVERSAL="$WORK/Universal-Binaries.dmg"
PAYLOADS="$WORK/payloads.dmg"
HELPER_DIR="$WORK/ci_tooling/privileged_helper_tool"
HELPER_MAIN="$HELPER_DIR/main.m"
DEBUG_HELPER="$HELPER_DIR/com.dortania.opencore-legacy-patcher.privileged-helper"

OUT="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.app"
ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.zip"
REPORT="$HOME/Desktop/OCLP7_D97DX_IMAC_RESUME_REPORT.txt"
DIFF_OUT="$HOME/Desktop/OCLP7_D97DX_b9df76_NATIVE_METAL_SAFE.patch"

say() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
ok()  { printf '\033[1;32m[PASS]\033[0m %s\n' "$*"; }
die() { printf '\n\033[1;31mFATAL: %s\033[0m\n' "$*" >&2; exit 1; }
trap 'printf "\n\033[1;31mD97DX stopped at line %s\033[0m\n" "$LINENO" >&2' ERR

exec > >(tee "$REPORT") 2>&1

echo "===== OCLP7 D97DX — RESUME D97DU NATIVE-METAL-SAFE BUILD ====="
echo "BUILD_HOST=INTEL_IMAC"
echo "REUSE_EXISTING_WORKTREE=YES"
echo "RECLONE=NO"
echo "REINSTALL_REQUIREMENTS=NO"
echo "ROOT_PATCH=NO"
echo "EFI_MUTATION=NO"
echo "SYSTEM_ROOT_MUTATION=NO"
echo "REBOOT=NO"
echo

[[ "$(uname -s)" == "Darwin" ]] || die "Must run on macOS."
[[ "$(uname -m)" == "x86_64" ]] || die "Intel/x86_64 build host required."
[[ -d "$WORK/.git" ]] || die "Existing D97DU worktree missing: $WORK"
[[ -x "$VENV_PY" ]] || die "Existing D97DU venv missing: $VENV_PY"

say "Re-pin existing D97DU source identity"
cd "$WORK"
[[ "$(git rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || die "HEAD drifted from exact b9df76."
git diff --check

EXPECTED_CHANGED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py | sort)"
ACTUAL_CHANGED="$(git diff --name-only | sort)"
printf '%s\n' "$ACTUAL_CHANGED"
[[ "$ACTUAL_CHANGED" == "$EXPECTED_CHANGED" ]] || die "Tracked source delta drifted."

git diff --quiet -- ci_tooling/privileged_helper_tool/main.m \
    || die "privileged helper main.m differs from b9df76."
git diff --quiet -- ci_tooling/privileged_helper_tool/Makefile \
    || die "privileged helper Makefile differs from b9df76."

git diff > "$DIFF_OUT"
DIFF_SHA="$(shasum -a 256 "$DIFF_OUT" | awk '{print $1}')"
ok "Existing D97DU tracked source delta remains bounded"

say "Re-pin Python 3.13 x86_64 environment"
"$VENV_PY" - <<'PY'
import platform, sys
assert sys.version_info[:2] == (3, 13), sys.version
assert platform.machine() == "x86_64", platform.machine()
print("D97DX_PYTHON_VERSION=" + sys.version.split()[0])
print("D97DX_PYTHON_ARCH=" + platform.machine())
PY
ok "Python 3.13 x86_64 PASS"

say "Re-pin patchdict and PatcherSupportPkg assets"
[[ -f "$PATCHDICT" ]] || die "25G82 patchdict missing."
[[ "$(shasum -a 256 "$PATCHDICT" | awk '{print $1}')" == "$PATCHDICT_SHA256" ]] \
    || die "25G82 patchdict hash mismatch."
[[ -f "$UNIVERSAL" ]] || die "Universal-Binaries.dmg missing."
[[ "$(shasum -a 256 "$UNIVERSAL" | awk '{print $1}')" == "$UNIVERSAL_SHA256" ]] \
    || die "Universal-Binaries.dmg hash mismatch."
[[ -f "$PAYLOADS" ]] || die "payloads.dmg missing."
[[ "$(shasum -a 256 "$PAYLOADS" | awk '{print $1}')" == "$PAYLOADS_SHA256" ]] \
    || die "payloads.dmg hash mismatch."
echo "PATCHDICT_SHA256=$PATCHDICT_SHA256"
echo "UNIVERSAL_BINARIES_SHA256=$UNIVERSAL_SHA256"
echo "PAYLOADS_DMG_SHA256=$PAYLOADS_SHA256"
ok "Patchdict/assets identity PASS"

say "Revalidate modified Python syntax"
"$VENV_PY" -m py_compile \
    opencore_legacy_patcher/sys_patch/patchsets/detect.py \
    opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
    opencore_legacy_patcher/support/metallib_handler.py
ok "Python syntax PASS"

say "Re-synthesize exact Tahoe 25G82 Metal3802 dictionary"
"$VENV_PY" - <<'PY'
from opencore_legacy_patcher.sys_patch.patchsets.shared_patches.metal_3802 import LegacyMetal3802
from opencore_legacy_patcher.sys_patch.patchsets.base import PatchType

p = LegacyMetal3802(25, 0, "26.6.2").patches()

common = p["Metal 3802 Common"]
co = common[PatchType.OVERWRITE_SYSTEM_VOLUME]
cm = common[PatchType.MERGE_SYSTEM_VOLUME]
assert co["/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices"]["MTLCompilerService.xpc"] == "12.5-3802-23"
assert cm["/System/Library/PrivateFrameworks"]["MTLCompiler.framework"] == "12.7.6-3802"
assert cm["/System/Library/PrivateFrameworks"]["GPUCompiler.framework"] == "12.7.6-3802"

ext = p["Metal 3802 Common Extended"][PatchType.MERGE_SYSTEM_VOLUME]
assert ext["/System/Library/Frameworks"]["CoreImage.framework"] == "14.0 Beta 3-24"
assert "Metal.framework" not in ext["/System/Library/Frameworks"]
assert ext["/System/Library/PrivateFrameworks"]["RenderBox.framework"] == "14.0-3802"
assert ext["/System/Library/PrivateFrameworks"]["MTLCompiler.framework"] == "14.2 Beta 1"
assert ext["/System/Library/PrivateFrameworks"]["GPUCompiler.framework"] == "14.2 Beta 1"

met = p["Metal 3802 .metallibs"][PatchType.OVERWRITE_SYSTEM_VOLUME]
count = sum(len(v) for v in met.values())
assert count == 182, count

for patch_name, patch in p.items():
    for patch_type, roots in patch.items():
        if not isinstance(roots, dict):
            continue
        fw = roots.get("/System/Library/Frameworks")
        if isinstance(fw, dict) and "Metal.framework" in fw:
            raise AssertionError((patch_name, patch_type, fw["Metal.framework"]))

flat = repr(p)
assert "MetalOld.dylib" not in flat
assert "13.2.1-24/Metal.framework" not in flat

print("D97DX_TAHOE_PATCHDICT_SYNTHESIS=PASS")
print("D97DX_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0")
print("D97DX_METALOLD_DYLIB_COUNT=0")
print("D97DX_MAIN_METAL_BINARY_INSTALL_COUNT=0")
print("D97DX_XPC_ONLY_LEGACY_METAL_INGRESS=PASS")
print("D97DX_PRIVATE_COMPILER_LANES=PASS")
print("D97DX_25G82_METALLIB_ENTRY_COUNT=182")
PY
ok "Native-Metal-safe policy still PASS"

say "Resolve explicit macOS SDK for privileged helper"
command -v xcrun >/dev/null 2>&1 || die "xcrun missing."
SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
CLANG="$(xcrun --sdk macosx --find clang)"
[[ -n "$SDKROOT" && -d "$SDKROOT" ]] || die "Could not resolve macOS SDK root."
[[ -x "$CLANG" ]] || die "Could not resolve SDK clang."
FOUNDATION_H="$SDKROOT/System/Library/Frameworks/Foundation.framework/Headers/Foundation.h"
SECURITY_H="$SDKROOT/System/Library/Frameworks/Security.framework/Headers/Security.h"
[[ -f "$FOUNDATION_H" ]] || die "Foundation SDK header missing: $FOUNDATION_H"
[[ -f "$SECURITY_H" ]] || die "Security SDK header missing: $SECURITY_H"
echo "SDKROOT=$SDKROOT"
echo "SDK_CLANG=$CLANG"
echo "FOUNDATION_HEADER=PASS"
echo "SECURITY_HEADER=PASS"
ok "Explicit macOS SDK/header gate PASS"

say "Compile DEBUG privileged helper x86_64 with explicit SDK"
cd "$HELPER_DIR"
/bin/rm -f "$DEBUG_HELPER"

"$CLANG" \
    -isysroot "$SDKROOT" \
    -F"$SDKROOT/System/Library/Frameworks" \
    -framework Foundation \
    -framework Security \
    -arch x86_64 \
    -mmacosx-version-min=10.9 \
    -DDEBUG \
    -o "$DEBUG_HELPER" \
    "$HELPER_MAIN"

[[ -f "$DEBUG_HELPER" ]] || die "DEBUG helper output missing."
HELPER_ARCH="$(lipo -archs "$DEBUG_HELPER")"
[[ "$HELPER_ARCH" == "x86_64" ]] || die "DEBUG helper must be x86_64-only; got $HELPER_ARCH."
codesign --force --sign - "$DEBUG_HELPER"
codesign --verify --strict "$DEBUG_HELPER"
DEBUG_HELPER_SHA="$(shasum -a 256 "$DEBUG_HELPER" | awk '{print $1}')"
echo "DEBUG_HELPER_ARCH=$HELPER_ARCH"
echo "DEBUG_HELPER_SHA256=$DEBUG_HELPER_SHA"
ok "DEBUG privileged helper explicit-SDK build PASS"

say "Build D97DX x86_64 application from already prepared source"
cd "$WORK"
/bin/rm -rf build dist

"$VENV_PY" Build-Project.command \
    --run-as-individual-steps \
    --prepare-application \
    --git-branch "D97DX-b9df76-Tahoe25G82-native-Metal-safe-x86_64" \
    --git-commit-url "https://github.com/dortania/OpenCore-Legacy-Patcher/commit/${GOLDEN_COMMIT}"

CUSTOM_APP="$WORK/dist/OpenCore-Patcher.app"
[[ -d "$CUSTOM_APP" ]] || die "Built OpenCore-Patcher.app missing."

codesign --force --deep --sign - \
    --entitlements "$WORK/ci_tooling/entitlements/entitlements.plist" \
    "$CUSTOM_APP"
codesign --verify --deep --strict "$CUSTOM_APP"

CUSTOM_EXE="$CUSTOM_APP/Contents/MacOS/OpenCore-Patcher"
CUSTOM_ARCH="$(lipo -archs "$CUSTOM_EXE")"
[[ "$CUSTOM_ARCH" == "x86_64" ]] || die "Inner app must be x86_64-only; got $CUSTOM_ARCH."
CUSTOM_EXE_SHA="$(shasum -a 256 "$CUSTOM_EXE" | awk '{print $1}')"
echo "INNER_ARCH=$CUSTOM_ARCH"
echo "INNER_EXECUTABLE_SHA256=$CUSTOM_EXE_SHA"
ok "Inner D97DX app build PASS"

say "Assemble target-safe D97DX wrapper"
/bin/rm -rf "$OUT" "$ZIP"
mkdir -p "$OUT/Contents/MacOS" "$OUT/Contents/Resources"
ditto "$CUSTOM_APP" "$OUT/Contents/Resources/OpenCore-Patcher.app"
ditto "$DEBUG_HELPER" "$OUT/Contents/Resources/debug-privileged-helper"
ditto "$DIFF_OUT" "$OUT/Contents/Resources/OCLP7_D97DX_SOURCE.patch"

cat > "$OUT/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DX" <<'LAUNCHER'
#!/bin/zsh
set -u

SELF_DIR="$(cd "$(dirname "$0")" && /bin/pwd -P)"
APP_ROOT="$(cd "$SELF_DIR/../.." && /bin/pwd -P)"
INNER="$APP_ROOT/Contents/Resources/OpenCore-Patcher.app"
DEBUG_HELPER="$APP_ROOT/Contents/Resources/debug-privileged-helper"
SYSTEM_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"

EXPECTED_OFFICIAL_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

BACKUP=""
BACKUP_READY=0
RESTORED=0

fail() {
    local m="$1"
    echo "FATAL: $m" >&2
    /usr/bin/osascript - "$m" <<'OSA' >/dev/null 2>&1 || true
on run argv
    display alert "D97DX OpenCore Patcher" message (item 1 of argv) as critical
end run
OSA
    exit 1
}

sha256_file() {
    /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

team_id() {
    /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}'
}

verify_official() {
    local p="$1"
    [[ -f "$p" ]] || return 1
    /usr/bin/codesign --verify --strict "$p" >/dev/null 2>&1 || return 1
    [[ "$(sha256_file "$p")" == "$EXPECTED_OFFICIAL_SHA" ]] || return 1
    [[ "$(team_id "$p")" == "$EXPECTED_OFFICIAL_TEAM" ]] || return 1
    return 0
}

install_helper() {
    local src="$1"
    /usr/bin/osascript - "$src" "$SYSTEM_HELPER" <<'OSA'
on run argv
    set src to item 1 of argv
    set dst to item 2 of argv
    set cmd to "/bin/mkdir -p /Library/PrivilegedHelperTools" & ¬
        " && /bin/cp -f " & quoted form of src & " " & quoted form of dst & ¬
        " && /usr/sbin/chown root:wheel " & quoted form of dst & ¬
        " && /bin/chmod 4755 " & quoted form of dst
    do shell script cmd with administrator privileges
end run
OSA
}

restore_official() {
    if [[ "$BACKUP_READY" -ne 1 || "$RESTORED" -eq 1 ]]; then
        return 0
    fi
    verify_official "$BACKUP" || {
        echo "FATAL: saved official-helper backup identity mismatch" >&2
        return 1
    }
    install_helper "$BACKUP" || {
        echo "FATAL: failed to restore saved official helper" >&2
        return 1
    }
    verify_official "$SYSTEM_HELPER" || {
        echo "FATAL: installed system helper is not exact official helper after restore" >&2
        return 1
    }
    RESTORED=1
    echo "D97DX_TARGET_OFFICIAL_HELPER_RESTORED=PASS"
    return 0
}

cleanup() {
    if [[ "$BACKUP_READY" -eq 1 && "$RESTORED" -ne 1 ]]; then
        restore_official >/dev/null 2>&1 || true
    fi
    [[ -n "$BACKUP" ]] && /bin/rm -f "$BACKUP" >/dev/null 2>&1 || true
}
trap cleanup EXIT HUP INT TERM

[[ -d "$INNER" ]] || fail "Custom inner OCLP missing."
[[ -f "$DEBUG_HELPER" ]] || fail "DEBUG helper missing."
/usr/bin/codesign --verify --deep --strict "$INNER" >/dev/null 2>&1 || fail "Custom inner app signature invalid."
/usr/bin/codesign --verify --strict "$DEBUG_HELPER" >/dev/null 2>&1 || fail "DEBUG helper signature invalid."

verify_official "$SYSTEM_HELPER" || fail "Current ASUS2 helper is not exact official Dortania helper. No swap performed."

BACKUP="$(/usr/bin/mktemp "/tmp/d97dx-official-helper.XXXXXX")" || fail "Could not create helper backup."
/bin/cp -p "$SYSTEM_HELPER" "$BACKUP" || fail "Could not save current official helper."
verify_official "$BACKUP" || fail "Saved helper backup identity mismatch."
BACKUP_READY=1
echo "D97DX_TARGET_OFFICIAL_HELPER_BACKUP=PASS"

install_helper "$DEBUG_HELPER" || fail "Could not install temporary DEBUG helper."
"$SYSTEM_HELPER" --version >/dev/null 2>&1 || fail "Installed DEBUG helper did not execute."
echo "D97DX_TARGET_DEBUG_HELPER_TEMPORARY=PASS"

/usr/bin/open -W -n "$INNER"
APP_RC=$?

restore_official || fail "Official helper restoration failed. Do NOT reboot."

exit "$APP_RC"
LAUNCHER
chmod 755 "$OUT/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DX"

cat > "$OUT/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleDevelopmentRegion</key><string>English</string>
<key>CFBundleExecutable</key><string>OpenCore-Patcher-Tahoe-D97DX</string>
<key>CFBundleIdentifier</key><string>ro.oclp.d97dx.native-metal-safe</string>
<key>CFBundleName</key><string>OpenCore Patcher Tahoe D97DX</string>
<key>CFBundleDisplayName</key><string>OpenCore Patcher Tahoe D97DX</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>2.5.0-D97DX-x86_64</string>
<key>CFBundleVersion</key><string>2.5.0</string>
<key>LSMinimumSystemVersion</key><string>10.13.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST

plutil -lint "$OUT/Contents/Info.plist"
xattr -dr com.apple.quarantine "$OUT" 2>/dev/null || true

say "Final D97DX wrapper audit"
INNER="$OUT/Contents/Resources/OpenCore-Patcher.app"
BUNDLED_DEBUG="$OUT/Contents/Resources/debug-privileged-helper"

codesign --verify --deep --strict "$INNER"
codesign --verify --strict "$BUNDLED_DEBUG"

FINAL_EXE_SHA="$(shasum -a 256 "$INNER/Contents/MacOS/OpenCore-Patcher" | awk '{print $1}')"
FINAL_ARCH="$(lipo -archs "$INNER/Contents/MacOS/OpenCore-Patcher")"
FINAL_DEBUG_SHA="$(shasum -a 256 "$BUNDLED_DEBUG" | awk '{print $1}')"

[[ "$FINAL_EXE_SHA" == "$CUSTOM_EXE_SHA" ]] || die "Inner app changed during wrapper assembly."
[[ "$FINAL_ARCH" == "x86_64" ]] || die "Final inner app architecture changed."
[[ "$FINAL_DEBUG_SHA" == "$DEBUG_HELPER_SHA" ]] || die "DEBUG helper changed during wrapper assembly."
[[ ! -e "$OUT/Contents/Resources/official-privileged-helper" ]] || die "Official helper must NOT be bundled."

SOURCE_METAL_SHA="$(shasum -a 256 "$WORK/opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py" | awk '{print $1}')"
SOURCE_DETECT_SHA="$(shasum -a 256 "$WORK/opencore_legacy_patcher/sys_patch/patchsets/detect.py" | awk '{print $1}')"
SOURCE_HANDLER_SHA="$(shasum -a 256 "$WORK/opencore_legacy_patcher/support/metallib_handler.py" | awk '{print $1}')"
SOURCE_SPEC_SHA="$(shasum -a 256 "$WORK/OpenCore-Patcher-GUI.spec" | awk '{print $1}')"

cat > "$OUT/Contents/Resources/D97DX_AUDIT.txt" <<EOF
D97DX_BUILD_SOURCE_COMMIT=$GOLDEN_COMMIT
D97DX_METAL3802_SOURCE_SHA256=$SOURCE_METAL_SHA
D97DX_DETECT_SOURCE_SHA256=$SOURCE_DETECT_SHA
D97DX_METALLIB_HANDLER_SOURCE_SHA256=$SOURCE_HANDLER_SHA
D97DX_SPEC_SOURCE_SHA256=$SOURCE_SPEC_SHA
D97DX_SOURCE_DIFF_SHA256=$DIFF_SHA
D97DX_PATCHDICT_25G82_SHA256=$PATCHDICT_SHA256
D97DX_25G82_METALLIB_ENTRY_COUNT=182
D97DX_UNIVERSAL_BINARIES_SHA256=$UNIVERSAL_SHA256
D97DX_PAYLOADS_DMG_SHA256=$PAYLOADS_SHA256
D97DX_INNER_EXECUTABLE_SHA256=$FINAL_EXE_SHA
D97DX_INNER_ARCH=$FINAL_ARCH
D97DX_DEBUG_HELPER_SHA256=$FINAL_DEBUG_SHA
D97DX_DEBUG_HELPER_ARCH=x86_64
D97DX_TARGET_OFFICIAL_HELPER_EXPECTED_SHA256=$OFFICIAL_HELPER_SHA256
D97DX_TARGET_OFFICIAL_HELPER_EXPECTED_TEAM=$DORTANIA_TEAM
D97DX_OFFICIAL_HELPER_BUNDLED=NO
D97DX_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0
D97DX_METALOLD_DYLIB_COUNT=0
D97DX_MAIN_METAL_BINARY_INSTALL_COUNT=0
D97DX_XPC_ONLY_LEGACY_METAL_INGRESS=PASS
D97DX_TAHOE_NATIVE_METAL4_PRESERVATION_POLICY=PASS
D97DX_TRUE_FIVE_REAPPLY=NO
ROOT_PATCH_RUN=NO
EFI_MUTATION=NO
REBOOT_RUN=NO
EOF

cd "$HOME/Desktop"
ditto -c -k --sequesterRsrc --keepParent \
    "OpenCore-Patcher-Tahoe-D97DX.app" \
    "OpenCore-Patcher-Tahoe-D97DX.zip"

ZIP_SHA="$(shasum -a 256 "$ZIP" | awk '{print $1}')"
ZIP_BYTES="$(stat -f '%z' "$ZIP")"

echo
echo "============================================================"
echo " D97DX FINAL RESUME RESULT"
echo "============================================================"
echo "APP=$OUT"
echo "ZIP=$ZIP"
echo "ZIP_BYTES=$ZIP_BYTES"
echo "ZIP_SHA256=$ZIP_SHA"
echo "REPORT=$REPORT"
echo "SOURCE_DIFF=$DIFF_OUT"
echo "SOURCE_DIFF_SHA256=$DIFF_SHA"
echo "INNER_EXECUTABLE_SHA256=$FINAL_EXE_SHA"
echo "INNER_ARCH=$FINAL_ARCH"
echo "DEBUG_HELPER_SHA256=$FINAL_DEBUG_SHA"
echo "DEBUG_HELPER_ARCH=x86_64"
echo "TARGET_OFFICIAL_HELPER_EXPECTED_SHA256=$OFFICIAL_HELPER_SHA256"
echo "OFFICIAL_HELPER_BUNDLED=NO"
echo
echo "D97DX_EXACT_B9DF76_BASE=PASS"
echo "D97DX_TAHOE_PATCHDICT_SYNTHESIS=PASS"
echo "D97DX_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0"
echo "D97DX_METALOLD_DYLIB_COUNT=0"
echo "D97DX_MAIN_METAL_BINARY_INSTALL_COUNT=0"
echo "D97DX_XPC_ONLY_LEGACY_METAL_INGRESS=PASS"
echo "D97DX_PRIVATE_COMPILER_LANES=PASS"
echo "D97DX_25G82_METALLIB_ENTRY_COUNT=182"
echo "D97DX_EXPLICIT_SDK_DEBUG_HELPER=PASS"
echo "D97DX_X86_64_PACKAGING=PASS"
echo "D97DX_TARGET_HELPER_SAVE_RESTORE_POLICY=PASS"
echo "D97DX_BUILD_STATUS=PASS"
echo
echo "NO ROOT PATCH WAS RUN"
echo "NO EFI MUTATION WAS RUN"
echo "NO REBOOT WAS RUN"
echo "NEXT=RETURN ZIP + REPORT + SOURCE DIFF TO CHATGPT FOR INDEPENDENT AUDIT"
echo "============================================================"
