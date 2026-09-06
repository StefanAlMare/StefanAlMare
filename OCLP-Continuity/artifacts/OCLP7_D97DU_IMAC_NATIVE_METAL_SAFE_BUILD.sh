#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DU — Intel iMac native-Metal-safe Tahoe 25G82 OCLP build
#
# Starts from exact OCLP b9df76 and creates a bounded Tahoe-only Root Patcher:
# - Tahoe native Metal / Metal4 stays canonical.
# - Legacy Metal.framework/Versions/A/Metal is NEVER installed.
# - MetalOld.dylib is NEVER installed.
# - only legacy MTLCompilerService.xpc is injected into Metal.framework.
# - private MTLCompiler/GPUCompiler lanes, CoreImage/RenderBox compatibility,
#   Haswell/GVA/OpenCL patchsets and exact 25G82 metallibs remain available.
#
# BUILD HOST ONLY. NO Root Patch. NO EFI mutation. NO reboot.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
GOLDEN_TREE="7c3411fde7d40604164c8877a5ab5594448083ac"

PATCHDICT_URL="https://github.com/pyquick/MetallibSupportPkg/releases/download/26.6.2-25G82/sys_patch_dict.py"
PATCHDICT_SHA256="c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e"
UNIVERSAL_SHA256="33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7"
OFFICIAL_HELPER_SHA256="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
DORTANIA_TEAM="S74BDJXQMD"

LOCAL_METALLIB="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
SYSTEM_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"

BASE="$HOME/Developer"
WORK="$BASE/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
D97BJ_WORK="$BASE/OpenCore-Legacy-Patcher-D97BJ-b9df76-Tahoe25G82"
OUT="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DU.app"
ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DU.zip"
REPORT="$HOME/Desktop/OCLP7_D97DU_IMAC_BUILD_REPORT.txt"
DIFF_OUT="$HOME/Desktop/OCLP7_D97DU_b9df76_NATIVE_METAL_SAFE.patch"

say() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
ok()  { printf '\033[1;32m[PASS]\033[0m %s\n' "$*"; }
die() { printf '\n\033[1;31mFATAL: %s\033[0m\n' "$*" >&2; exit 1; }
trap 'printf "\n\033[1;31mD97DU stopped at line %s\033[0m\n" "$LINENO" >&2' ERR

exec > >(tee "$REPORT") 2>&1

echo "===== OCLP7 D97DU — NATIVE METAL SAFE BUILD ====="
echo "BUILD_HOST=INTEL_MAC_ONLY"
echo "ROOT_PATCH=NO"
echo "EFI_MUTATION=NO"
echo "SYSTEM_PATCH_MUTATION=NO"
echo "REBOOT=NO"
echo "GOLDEN_COMMIT=$GOLDEN_COMMIT"
echo

[[ "$(uname -s)" == "Darwin" ]] || die "Must run on macOS."
[[ "$(uname -m)" == "x86_64" ]] || die "D97DU build authority is Intel/x86_64 only."

say "Close any running OCLP"
if pgrep -f 'OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' >/dev/null 2>&1; then
    die "OpenCore-Patcher is running. Quit it completely."
fi

say "Verify build tools and Python"
xcode-select -p >/dev/null 2>&1 || die "Xcode Command Line Tools missing."
for c in git clang curl shasum codesign lipo ditto; do
    command -v "$c" >/dev/null 2>&1 || die "Missing tool: $c"
done

PYTHON_BIN=""
for p in \
    "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3.13" \
    "/Library/Frameworks/Python.framework/Versions/3.11/bin/python3.11" \
    "/usr/local/bin/python3" \
    "/opt/homebrew/bin/python3"
do
    if [[ -x "$p" ]] && "$p" - <<'PY' >/dev/null 2>&1
import sys
raise SystemExit(0 if sys.version_info >= (3, 11) else 1)
PY
    then
        PYTHON_BIN="$p"
        break
    fi
done
[[ -n "$PYTHON_BIN" ]] || die "Python >= 3.11 not found. D97BJ previously used Python 3.13.13."
ok "Python=$($PYTHON_BIN --version 2>&1) [$PYTHON_BIN]"

say "Verify exact local 25G82 MetallibSupportPkg"
[[ -d "$LOCAL_METALLIB" ]] || die "Missing exact local MetallibSupportPkg: $LOCAL_METALLIB"
LOCAL_METALLIB_COUNT="$(find "$LOCAL_METALLIB" -type f -name '*.metallib' 2>/dev/null | wc -l | tr -d ' ')"
[[ "$LOCAL_METALLIB_COUNT" -ge 170 ]] || die "25G82 local metallib tree unexpectedly small: $LOCAL_METALLIB_COUNT"
echo "LOCAL_25G82_METALLIB_FILE_COUNT=$LOCAL_METALLIB_COUNT"

say "Locate exact official privileged-helper restore asset"
OFFICIAL_HELPER=""
for p in \
    "$SYSTEM_HELPER" \
    "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97BJ.app/Contents/Resources/official-privileged-helper" \
    "$HOME/Applications/OpenCore-Patcher-Tahoe-D97BJ.app/Contents/Resources/official-privileged-helper" \
    "/Applications/OpenCore-Patcher-Tahoe-D97BJ.app/Contents/Resources/official-privileged-helper"
do
    [[ -f "$p" ]] || continue
    s="$(shasum -a 256 "$p" | awk '{print $1}')"
    if [[ "$s" == "$OFFICIAL_HELPER_SHA256" ]]; then
        OFFICIAL_HELPER="$p"
        break
    fi
done
[[ -n "$OFFICIAL_HELPER" ]] || die "Exact official helper $OFFICIAL_HELPER_SHA256 not found."
codesign --verify --strict "$OFFICIAL_HELPER"
TEAM="$(codesign -dv --verbose=4 "$OFFICIAL_HELPER" 2>&1 | awk -F= '/^TeamIdentifier=/{print $2; exit}')"
[[ "$TEAM" == "$DORTANIA_TEAM" ]] || die "Official helper TeamIdentifier mismatch."
ok "Official helper exact: $OFFICIAL_HELPER"

say "Create clean exact b9df76 worktree"
mkdir -p "$BASE"
if [[ -e "$WORK" ]]; then
    mv "$WORK" "${WORK}.before-$(date +%Y%m%d-%H%M%S)"
fi

git clone https://github.com/dortania/OpenCore-Legacy-Patcher.git "$WORK"
cd "$WORK"
git checkout --detach "$GOLDEN_COMMIT"
[[ "$(git rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || die "HEAD mismatch."
[[ "$(git rev-parse 'HEAD^{tree}')" == "$GOLDEN_TREE" ]] || die "Golden tree mismatch."
[[ -z "$(git status --porcelain)" ]] || die "Fresh b9df76 checkout is dirty."
ok "Exact b9df76 source identity PASS"

say "Acquire exact Pyquick 25G82 patch dictionary"
PATCHDICT="$WORK/sys_patch_dict-25G82.py"
curl --fail --location --retry 3 --progress-bar "$PATCHDICT_URL" -o "$PATCHDICT"
printf '%s  %s\n' "$PATCHDICT_SHA256" "$PATCHDICT" | shasum -a 256 -c - \
    || die "25G82 sys_patch_dict checksum mismatch."
ok "sys_patch_dict 25G82 exact"

say "Apply D97DU native-Metal-safe Tahoe source policy"
ROOT_ENV="$WORK" PATCHDICT_ENV="$PATCHDICT" "$PYTHON_BIN" - <<'PY'
import ast
import os
import re
from pathlib import Path

root = Path(os.environ["ROOT_ENV"])
patchdict = Path(os.environ["PATCHDICT_ENV"])

detect = root / "opencore_legacy_patcher/sys_patch/patchsets/detect.py"
metal = root / "opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"
handler = root / "opencore_legacy_patcher/support/metallib_handler.py"
spec = root / "OpenCore-Patcher-GUI.spec"

# 1) Exact Tahoe host eligibility.
t = detect.read_text(encoding="utf-8")
old = "        _max_os = os_data.sequoia.value\n"
new = "        _max_os = os_data.tahoe.value\n"
if t.count(old) != 1:
    raise SystemExit("detect.py host-max anchor not unique")
detect.write_text(t.replace(old, new, 1), encoding="utf-8")

# Utility: preserve the exact upstream implementation for non-Tahoe and prepend
# a Tahoe-specific wrapper implementation.
def wrap_method(text: str, method: str, wrapper: str) -> str:
    pat = re.compile(
        rf"    def {re.escape(method)}\(self\) -> dict:\n.*?(?=\n    def [A-Za-z_][A-Za-z0-9_]*\(self\) -> dict:)",
        re.S,
    )
    matches = pat.findall(text)
    if len(matches) != 1:
        raise SystemExit(f"cannot uniquely isolate {method}: {len(matches)}")
    original = matches[0]
    renamed = original.replace(
        f"    def {method}(self) -> dict:",
        f"    def {method}_original(self) -> dict:",
        1,
    )
    return pat.sub(wrapper.rstrip() + "\n\n" + renamed, text, count=1)

m = metal.read_text(encoding="utf-8")

# 2) Tahoe Common: NEVER merge the whole Metal.framework.
# Install only the legacy MTLCompilerService.xpc plus private compiler frameworks.
common_wrapper = r'''    def _patches_metal_3802_common(self) -> dict:
        # D97DU Tahoe: preserve native Metal/Metal4; inject only legacy compiler service.
        if self._xnu_major != os_data.tahoe.value:
            return self._patches_metal_3802_common_original()
        if self._os_requires_patches() is False:
            return {}

        return {
            "Metal 3802 Common": {
                PatchType.OVERWRITE_SYSTEM_VOLUME: {
                    "/System/Library/Sandbox/Profiles": {
                        "com.apple.mtlcompilerservice.sb": "12.5-3802",
                    },
                    "/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices": {
                        "MTLCompilerService.xpc": "12.5-3802-23",
                    },
                },
                PatchType.MERGE_SYSTEM_VOLUME: {
                    "/System/Library/PrivateFrameworks": {
                        "MTLCompiler.framework": "12.7.6-3802",
                        "GPUCompiler.framework": "12.7.6-3802",
                    },
                },
            }
        }
'''
m = wrap_method(m, "_patches_metal_3802_common", common_wrapper)

# 3) Tahoe Extended: retain compatibility private frameworks/CoreImage, but NEVER
# install a legacy main Metal.framework or MetalOld.dylib.
extended_wrapper = r'''    def _patches_metal_3802_common_extended(self) -> dict:
        # D97DU Tahoe: native main Metal remains canonical.
        if self._xnu_major != os_data.tahoe.value:
            return self._patches_metal_3802_common_extended_original()
        if self._xnu_float < self.macOS_13_3:
            return {}

        return {
            "Metal 3802 Common Extended": {
                PatchType.MERGE_SYSTEM_VOLUME: {
                    "/System/Library/Frameworks": {
                        "CoreImage.framework": "14.0 Beta 3-24",
                    },
                    "/System/Library/PrivateFrameworks": {
                        "RenderBox.framework": "14.0-3802",
                        "MTLCompiler.framework": "14.2 Beta 1",
                        "GPUCompiler.framework": "14.2 Beta 1",
                    },
                },
            }
        }
'''
m = wrap_method(m, "_patches_metal_3802_common_extended", extended_wrapper)

# 4) Exact Tahoe 25G82 metallib destination/source map, preserving upstream
# metallib behavior off Tahoe.
data = ast.literal_eval(patchdict.read_text(encoding="utf-8"))
install = data.get("Install")
if not isinstance(install, dict) or not install:
    raise SystemExit("25G82 sys_patch_dict Install map missing")
entry_count = sum(len(v) for v in install.values())
if entry_count != 182:
    raise SystemExit(f"25G82 metallib map count != 182: {entry_count}")
values = {v for files in install.values() for v in files.values()}
unexpected = values - {"14.6.1", "26.6.2-25G82"}
if unexpected:
    raise SystemExit("unexpected 25G82 source variants: " + repr(sorted(unexpected)))

pat = re.compile(
    r"    def _patches_metal_3802_metallibs\(self\) -> dict:\n.*?(?=\n    def patches\(self\) -> dict:)",
    re.S,
)
found = pat.findall(m)
if len(found) != 1:
    raise SystemExit("cannot uniquely isolate metallib method")
original = found[0]
renamed = original.replace(
    "    def _patches_metal_3802_metallibs(self) -> dict:",
    "    def _patches_metal_3802_metallibs_original(self) -> dict:",
    1,
)
lines = [
    "    def _patches_metal_3802_metallibs(self) -> dict:",
    "        # D97DU Tahoe 25G82 exact metallib map; upstream unchanged off Tahoe.",
    "        if self._xnu_major != os_data.tahoe.value:",
    "            return self._patches_metal_3802_metallibs_original()",
    "",
    "        metallib_install = {",
]
for parent, files in install.items():
    lines.append(f"            {parent!r}: {{")
    for filename, value in files.items():
        expr = "DynamicPatchset.MetallibSupportPkg" if value == "26.6.2-25G82" else repr(value)
        lines.append(f"                {filename!r}: {expr},")
    lines.append("            },")
lines += [
    "        }",
    "",
    "        return {",
    '            "Metal 3802 .metallibs": {',
    "                PatchType.OVERWRITE_SYSTEM_VOLUME: metallib_install,",
    "                PatchType.REMOVE_SYSTEM_VOLUME: {",
    '                    "/System/Library/PrivateFrameworks/RenderBox.framework/Versions/A/Resources": [',
    '                        "archive.metallib",',
    "                    ],",
    "                },",
    "            }",
    "        }",
    "",
]
m = pat.sub("\n".join(lines) + "\n" + renamed, m, count=1)
metal.write_text(m, encoding="utf-8")

# 5) Prefer exact local 25G82 MetallibSupportPkg before API lookup.
h = handler.read_text(encoding="utf-8")
anchor = '''        self.metallib_installed_path = self._local_metallib_installed()
        if self.metallib_installed_path:
            logging.info(f"metallib already installed ({Path(self.metallib_installed_path).name}), skipping")
            self.metallib_already_installed = True
            self.success = True
            return
'''
exact = '''        # D97DU: prefer exact local host-build MetallibSupportPkg before API fallback.
        self.metallib_installed_path = self._local_metallib_installed(match=self.host_build)
        if self.metallib_installed_path:
            logging.info(f"Exact local metallib found ({Path(self.metallib_installed_path).name}), skipping API fallback")
            self.metallib_already_installed = True
            self.success = True
            return

''' + anchor
if h.count(anchor) != 1:
    raise SystemExit("metallib_handler anchor not unique")
handler.write_text(h.replace(anchor, exact, 1), encoding="utf-8")

# 6) Intel-only packaging correction proven during D97BJ.
s = spec.read_text(encoding="utf-8")
old = '          target_arch="universal2",'
new = '          target_arch="x86_64",'
if s.count(old) != 1:
    raise SystemExit("OpenCore-Patcher-GUI.spec target_arch anchor not unique")
spec.write_text(s.replace(old, new, 1), encoding="utf-8")

print("D97DU_SOURCE_POLICY_APPLIED=PASS")
print(f"D97DU_25G82_METALLIB_ENTRIES={entry_count}")
PY

git diff --check
CHANGED="$(git diff --name-only | sort)"
printf '%s\n' "$CHANGED"
EXPECTED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py | sort)"
[[ "$CHANGED" == "$EXPECTED" ]] || die "Unexpected source changed-file set."
git diff > "$DIFF_OUT"
ok "Source diff is bounded to 3 functional files + x86_64 packaging spec"

say "Create isolated build environment"
"$PYTHON_BIN" -m venv "$WORK/.venv"
VENV_PY="$WORK/.venv/bin/python"
VENV_PIP="$WORK/.venv/bin/pip"
"$VENV_PY" -m pip install --upgrade pip setuptools wheel
"$VENV_PIP" install -r requirements.txt

"$VENV_PY" -m py_compile \
    opencore_legacy_patcher/sys_patch/patchsets/detect.py \
    opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
    opencore_legacy_patcher/support/metallib_handler.py
ok "Python syntax PASS"

say "Runtime-synthesize Tahoe LegacyMetal3802 patch dictionary and enforce forbidden-surface gates"
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

ext = p["Metal 3802 Common Extended"]
em = ext[PatchType.MERGE_SYSTEM_VOLUME]
assert em["/System/Library/Frameworks"]["CoreImage.framework"] == "14.0 Beta 3-24"
assert "Metal.framework" not in em["/System/Library/Frameworks"]
assert em["/System/Library/PrivateFrameworks"]["RenderBox.framework"] == "14.0-3802"
assert em["/System/Library/PrivateFrameworks"]["MTLCompiler.framework"] == "14.2 Beta 1"
assert em["/System/Library/PrivateFrameworks"]["GPUCompiler.framework"] == "14.2 Beta 1"

met = p["Metal 3802 .metallibs"][PatchType.OVERWRITE_SYSTEM_VOLUME]
count = sum(len(v) for v in met.values())
assert count == 182, count

# Whole-framework main Metal donor must not exist anywhere.
for patch_name, patch in p.items():
    for patch_type, roots in patch.items():
        if not isinstance(roots, dict):
            continue
        fw = roots.get("/System/Library/Frameworks")
        if isinstance(fw, dict) and "Metal.framework" in fw:
            raise AssertionError(f"FORBIDDEN whole Metal.framework donor in {patch_name}/{patch_type}: {fw['Metal.framework']}")

flat = repr(p)
assert "MetalOld.dylib" not in flat
assert "13.2.1-24/Metal.framework" not in flat

print("D97DU_TAHOE_PATCHDICT_SYNTHESIS=PASS")
print("D97DU_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0")
print("D97DU_METALOLD_DYLIB_COUNT=0")
print("D97DU_MAIN_METAL_BINARY_INSTALL_COUNT=0")
print("D97DU_XPC_ONLY_LEGACY_METAL_INGRESS=PASS")
print("D97DU_PRIVATE_COMPILER_LANES=PASS")
print("D97DU_25G82_METALLIB_ENTRY_COUNT=182")
PY
ok "Native-Metal-safe synthesized patch dictionary PASS"

say "Acquire exact PatcherSupportPkg assets"
ASSETS_REUSED=0
if [[ -f "$D97BJ_WORK/payloads.dmg" && -f "$D97BJ_WORK/Universal-Binaries.dmg" ]]; then
    D97BJ_UNI_SHA="$(shasum -a 256 "$D97BJ_WORK/Universal-Binaries.dmg" | awk '{print $1}')"
    if [[ "$D97BJ_UNI_SHA" == "$UNIVERSAL_SHA256" ]]; then
        ditto "$D97BJ_WORK/payloads.dmg" "$WORK/payloads.dmg"
        ditto "$D97BJ_WORK/Universal-Binaries.dmg" "$WORK/Universal-Binaries.dmg"
        ASSETS_REUSED=1
        ok "Reused D97BJ exact Universal-Binaries + Golden-derived payloads.dmg"
    fi
fi

if [[ "$ASSETS_REUSED" -eq 0 ]]; then
    say "D97BJ assets unavailable; regenerate b9df76 assets"
    "$VENV_PY" Build-Project.command \
        --run-as-individual-steps \
        --prepare-assets \
        --reset-dmg-cache
fi

[[ -f "$WORK/payloads.dmg" ]] || die "payloads.dmg missing after asset stage."
[[ -f "$WORK/Universal-Binaries.dmg" ]] || die "Universal-Binaries.dmg missing after asset stage."
UNIVERSAL_ACTUAL_SHA="$(shasum -a 256 "$WORK/Universal-Binaries.dmg" | awk '{print $1}')"
[[ "$UNIVERSAL_ACTUAL_SHA" == "$UNIVERSAL_SHA256" ]] || die "Universal-Binaries SHA mismatch."
PAYLOADS_SHA="$(shasum -a 256 "$WORK/payloads.dmg" | awk '{print $1}')"
echo "UNIVERSAL_BINARIES_SHA256=$UNIVERSAL_ACTUAL_SHA"
echo "PAYLOADS_DMG_SHA256=$PAYLOADS_SHA"
ok "PatcherSupportPkg asset gate PASS"

say "Build DEBUG privileged helper"
pushd "$WORK/ci_tooling/privileged_helper_tool" >/dev/null
make debug
DEBUG_HELPER="$PWD/com.dortania.opencore-legacy-patcher.privileged-helper"
codesign --force --sign - "$DEBUG_HELPER"
codesign --verify --strict "$DEBUG_HELPER"
DEBUG_HELPER_SHA="$(shasum -a 256 "$DEBUG_HELPER" | awk '{print $1}')"
popd >/dev/null
echo "DEBUG_HELPER_SHA256=$DEBUG_HELPER_SHA"
ok "Debug helper build PASS"

say "Build D97DU x86_64 application"
cd "$WORK"
rm -rf build dist
"$VENV_PY" Build-Project.command \
    --run-as-individual-steps \
    --prepare-application \
    --git-branch "D97DU-b9df76-Tahoe25G82-native-Metal-safe-x86_64" \
    --git-commit-url "https://github.com/dortania/OpenCore-Legacy-Patcher/commit/${GOLDEN_COMMIT}"

CUSTOM_APP="$WORK/dist/OpenCore-Patcher.app"
[[ -d "$CUSTOM_APP" ]] || die "Built OpenCore-Patcher.app missing."
codesign --force --deep --sign - \
    --entitlements "$WORK/ci_tooling/entitlements/entitlements.plist" \
    "$CUSTOM_APP"
codesign --verify --deep --strict "$CUSTOM_APP"

CUSTOM_EXE="$CUSTOM_APP/Contents/MacOS/OpenCore-Patcher"
ARCHS="$(lipo -archs "$CUSTOM_EXE")"
[[ "$ARCHS" == "x86_64" ]] || die "D97DU app must be x86_64-only; got: $ARCHS"
CUSTOM_EXE_SHA="$(shasum -a 256 "$CUSTOM_EXE" | awk '{print $1}')"
ok "D97DU inner app x86_64 + ad-hoc codesign PASS"

say "Assemble bounded-helper D97DU wrapper"
rm -rf "$OUT" "$ZIP"
mkdir -p "$OUT/Contents/MacOS" "$OUT/Contents/Resources"
ditto "$CUSTOM_APP" "$OUT/Contents/Resources/OpenCore-Patcher.app"
ditto "$DEBUG_HELPER" "$OUT/Contents/Resources/debug-privileged-helper"
ditto "$OFFICIAL_HELPER" "$OUT/Contents/Resources/official-privileged-helper"
ditto "$DIFF_OUT" "$OUT/Contents/Resources/OCLP7_D97DU_SOURCE.patch"

cat > "$OUT/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DU" <<'LAUNCHER'
#!/bin/zsh
set -u

SELF_DIR="$(cd "$(dirname "$0")" && /bin/pwd -P)"
APP_ROOT="$(cd "$SELF_DIR/../.." && /bin/pwd -P)"
INNER="$APP_ROOT/Contents/Resources/OpenCore-Patcher.app"
DEBUG_HELPER="$APP_ROOT/Contents/Resources/debug-privileged-helper"
OFFICIAL_HELPER="$APP_ROOT/Contents/Resources/official-privileged-helper"
SYSTEM_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
restore_needed=0

fail() {
    local m="$1"
    echo "FATAL: $m" >&2
    /usr/bin/osascript - "$m" <<'OSA' >/dev/null 2>&1 || true
on run argv
    display alert "D97DU OpenCore Patcher" message (item 1 of argv) as critical
end run
OSA
    exit 1
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

cleanup() {
    if [[ "$restore_needed" -eq 1 ]]; then
        install_helper "$OFFICIAL_HELPER" >/dev/null 2>&1 || true
    fi
}
trap cleanup EXIT HUP INT TERM

[[ -d "$INNER" ]] || fail "Custom inner OCLP missing."
[[ -f "$DEBUG_HELPER" ]] || fail "Debug helper missing."
[[ -f "$OFFICIAL_HELPER" ]] || fail "Official helper restore asset missing."
/usr/bin/codesign --verify --deep --strict "$INNER" >/dev/null 2>&1 || fail "Custom inner app signature invalid."
/usr/bin/codesign --verify --strict "$DEBUG_HELPER" >/dev/null 2>&1 || fail "Debug helper signature invalid."
/usr/bin/codesign --verify --strict "$OFFICIAL_HELPER" >/dev/null 2>&1 || fail "Official helper signature invalid."

install_helper "$DEBUG_HELPER"
restore_needed=1
"$SYSTEM_HELPER" --version >/dev/null 2>&1 || fail "Installed debug helper did not execute."
/usr/bin/open -W -n "$INNER"
rc=$?
exit "$rc"
LAUNCHER
chmod 755 "$OUT/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DU"

cat > "$OUT/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleDevelopmentRegion</key><string>English</string>
<key>CFBundleExecutable</key><string>OpenCore-Patcher-Tahoe-D97DU</string>
<key>CFBundleIdentifier</key><string>ro.oclp.d97du.native-metal-safe</string>
<key>CFBundleName</key><string>OpenCore Patcher Tahoe D97DU</string>
<key>CFBundleDisplayName</key><string>OpenCore Patcher Tahoe D97DU</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>2.5.0-D97DU-x86_64</string>
<key>CFBundleVersion</key><string>2.5.0</string>
<key>LSMinimumSystemVersion</key><string>10.13.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
plutil -lint "$OUT/Contents/Info.plist"
xattr -dr com.apple.quarantine "$OUT" 2>/dev/null || true

say "Final wrapper identity audit"
INNER="$OUT/Contents/Resources/OpenCore-Patcher.app"
BUNDLED_DEBUG="$OUT/Contents/Resources/debug-privileged-helper"
BUNDLED_OFFICIAL="$OUT/Contents/Resources/official-privileged-helper"
codesign --verify --deep --strict "$INNER"
codesign --verify --strict "$BUNDLED_DEBUG"
codesign --verify --strict "$BUNDLED_OFFICIAL"

FINAL_EXE_SHA="$(shasum -a 256 "$INNER/Contents/MacOS/OpenCore-Patcher" | awk '{print $1}')"
FINAL_ARCH="$(lipo -archs "$INNER/Contents/MacOS/OpenCore-Patcher")"
FINAL_DEBUG_SHA="$(shasum -a 256 "$BUNDLED_DEBUG" | awk '{print $1}')"
FINAL_OFFICIAL_SHA="$(shasum -a 256 "$BUNDLED_OFFICIAL" | awk '{print $1}')"
[[ "$FINAL_EXE_SHA" == "$CUSTOM_EXE_SHA" ]] || die "Inner app changed during wrapper assembly."
[[ "$FINAL_ARCH" == "x86_64" ]] || die "Final inner app architecture changed."
[[ "$FINAL_DEBUG_SHA" == "$DEBUG_HELPER_SHA" ]] || die "Debug helper changed during wrapper assembly."
[[ "$FINAL_OFFICIAL_SHA" == "$OFFICIAL_HELPER_SHA256" ]] || die "Official helper changed during wrapper assembly."

SOURCE_METAL_SHA="$(shasum -a 256 "$WORK/opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py" | awk '{print $1}')"
SOURCE_DETECT_SHA="$(shasum -a 256 "$WORK/opencore_legacy_patcher/sys_patch/patchsets/detect.py" | awk '{print $1}')"
SOURCE_HANDLER_SHA="$(shasum -a 256 "$WORK/opencore_legacy_patcher/support/metallib_handler.py" | awk '{print $1}')"
SOURCE_SPEC_SHA="$(shasum -a 256 "$WORK/OpenCore-Patcher-GUI.spec" | awk '{print $1}')"
DIFF_SHA="$(shasum -a 256 "$DIFF_OUT" | awk '{print $1}')"

cat > "$OUT/Contents/Resources/D97DU_AUDIT.txt" <<EOF
D97DU_BUILD_SOURCE_COMMIT=$GOLDEN_COMMIT
D97DU_BUILD_SOURCE_TREE=$GOLDEN_TREE
D97DU_METAL3802_SOURCE_SHA256=$SOURCE_METAL_SHA
D97DU_DETECT_SOURCE_SHA256=$SOURCE_DETECT_SHA
D97DU_METALLIB_HANDLER_SOURCE_SHA256=$SOURCE_HANDLER_SHA
D97DU_SPEC_SOURCE_SHA256=$SOURCE_SPEC_SHA
D97DU_SOURCE_DIFF_SHA256=$DIFF_SHA
D97DU_PATCHDICT_25G82_SHA256=$PATCHDICT_SHA256
D97DU_25G82_METALLIB_ENTRY_COUNT=182
D97DU_UNIVERSAL_BINARIES_SHA256=$UNIVERSAL_ACTUAL_SHA
D97DU_PAYLOADS_DMG_SHA256=$PAYLOADS_SHA
D97DU_INNER_EXECUTABLE_SHA256=$FINAL_EXE_SHA
D97DU_INNER_ARCH=$FINAL_ARCH
D97DU_DEBUG_HELPER_SHA256=$FINAL_DEBUG_SHA
D97DU_OFFICIAL_HELPER_SHA256=$FINAL_OFFICIAL_SHA
D97DU_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0
D97DU_METALOLD_DYLIB_COUNT=0
D97DU_MAIN_METAL_BINARY_INSTALL_COUNT=0
D97DU_XPC_ONLY_LEGACY_METAL_INGRESS=PASS
D97DU_TAHOE_NATIVE_METAL4_PRESERVATION_POLICY=PASS
D97DU_TRUE_FIVE_REAPPLY=NO
ROOT_PATCH_RUN=NO
EFI_MUTATION=NO
REBOOT_RUN=NO
EOF

cd "$HOME/Desktop"
ditto -c -k --sequesterRsrc --keepParent \
    "OpenCore-Patcher-Tahoe-D97DU.app" \
    "OpenCore-Patcher-Tahoe-D97DU.zip"
ZIP_SHA="$(shasum -a 256 "$ZIP" | awk '{print $1}')"
ZIP_BYTES="$(stat -f '%z' "$ZIP")"

echo
echo "============================================================"
echo " D97DU FINAL BUILD RESULT"
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
echo "METAL3802_SOURCE_SHA256=$SOURCE_METAL_SHA"
echo "DETECT_SOURCE_SHA256=$SOURCE_DETECT_SHA"
echo "METALLIB_HANDLER_SOURCE_SHA256=$SOURCE_HANDLER_SHA"
echo "SPEC_SOURCE_SHA256=$SOURCE_SPEC_SHA"
echo "DEBUG_HELPER_SHA256=$FINAL_DEBUG_SHA"
echo "OFFICIAL_HELPER_SHA256=$FINAL_OFFICIAL_SHA"
echo "UNIVERSAL_BINARIES_SHA256=$UNIVERSAL_ACTUAL_SHA"
echo "PAYLOADS_DMG_SHA256=$PAYLOADS_SHA"
echo
echo "D97DU_EXACT_B9DF76_BASE=PASS"
echo "D97DU_TAHOE_HOST_GATE=PASS"
echo "D97DU_PATCHDICT_SYNTHESIS=PASS"
echo "D97DU_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0"
echo "D97DU_METALOLD_DYLIB_COUNT=0"
echo "D97DU_MAIN_METAL_BINARY_INSTALL_COUNT=0"
echo "D97DU_XPC_ONLY_LEGACY_METAL_INGRESS=PASS"
echo "D97DU_PRIVATE_COMPILER_LANES=PASS"
echo "D97DU_25G82_METALLIB_ENTRY_COUNT=182"
echo "D97DU_X86_64_PACKAGING=PASS"
echo "D97DU_BUILD_STATUS=PASS"
echo
echo "NO ROOT PATCH WAS RUN"
echo "NO EFI MUTATION WAS RUN"
echo "NO REBOOT WAS RUN"
echo "NEXT=RETURN ZIP + REPORT + SOURCE DIFF TO CHATGPT FOR INDEPENDENT AUDIT"
echo "============================================================"
