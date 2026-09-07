#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GS — build a D97DX-derived Root Patcher with exact P1 only.
# BUILD HOST: authorized Intel iMac only.
# NO Root Patch. NO EFI/NVRAM/framebuffer/system-root mutation. NO reboot.
# Reuses exact D97DX source state and exact audited D97DX outer wrapper skeleton.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
VENV_PY="$WORK/.venv/bin/python"
SYS_PATCH="$WORK/opencore_legacy_patcher/sys_patch/sys_patch.py"
EXPECTED_D97DX_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_D97DX_ZIP_SHA="2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_BASE_PATCH_SHA="$EXPECTED_D97DX_DIFF_SHA"
EXPECTED_P1_PRE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97GS.app"
ZIP_OUT="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97GS.zip"
REPORT="$HOME/Desktop/OCLP7_D97GS_IMAC_BUILD_REPORT_${STAMP}.txt"
DIFF_OUT="$HOME/Desktop/OCLP7_D97GS_SOURCE_${STAMP}.patch"
PRE_DIFF="/private/tmp/OCLP7_D97GS_PRE_DIFF_$$.patch"
TEMPLATE_TMP="/private/tmp/OCLP7_D97GS_TEMPLATE_$$"

cleanup() {
  /bin/rm -f "$PRE_DIFF" 2>/dev/null || true
  /bin/rm -rf "$TEMPLATE_TMP" 2>/dev/null || true
}
trap cleanup EXIT

exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97GS_STATUS=FAIL"; echo "D97GS_REASON=$*"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cat <<'HDR'
===== OCLP7 D97GS — P1-ONLY D97DX-DERIVED BUILD =====
BUILD_HOST=INTEL_IMAC_ONLY
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
P1_ONLY_NEW_FUNCTIONAL_DELTA=YES
P2B_NEW_REPLAY=NO
P3_NEW_REPLAY=NO
AIR00_NEW_REPLAY=NO
D34_NEW_REPLAY=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64_BUILD_HOST
[[ -d "$WORK/.git" ]] || fail D97DX_WORKTREE_MISSING
[[ -x "$VENV_PY" ]] || fail D97DX_VENV_MISSING
[[ -f "$SYS_PATCH" ]] || fail SYS_PATCH_SOURCE_MISSING

cd "$WORK"
[[ "$(git rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || fail GOLDEN_HEAD_DRIFT

echo
echo "===== VERIFY EXACT D97DX SOURCE BASE ====="
# D97DX did not modify sys_patch.py; it must still be pristine before D97GS insertion.
git diff --quiet -- opencore_legacy_patcher/sys_patch/sys_patch.py || fail SYS_PATCH_ALREADY_MODIFIED

git diff > "$PRE_DIFF"
PRE_DIFF_SHA="$(sha256 "$PRE_DIFF")"
echo "D97GS_PRE_DIFF_SHA256=$PRE_DIFF_SHA"
[[ "$PRE_DIFF_SHA" == "$EXPECTED_D97DX_DIFF_SHA" ]] || fail D97DX_SOURCE_BASE_DIFF_MISMATCH

git diff --check || fail D97DX_SOURCE_BASE_DIFF_CHECK_FAIL
EXPECTED_BASE_CHANGED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py | sort)"
ACTUAL_BASE_CHANGED="$(git diff --name-only | sort)"
printf '%s\n' "$ACTUAL_BASE_CHANGED"
[[ "$ACTUAL_BASE_CHANGED" == "$EXPECTED_BASE_CHANGED" ]] || fail D97DX_CHANGED_FILE_SET_DRIFT

echo "D97GS_D97DX_SOURCE_BASE=PASS"

# Preserve the pristine b9df76 sys_patch.py for independent diff review.
/bin/cp "$SYS_PATCH" "$HOME/Desktop/OCLP7_D97GS_sys_patch_PRE_${STAMP}.py"

echo
echo "===== INSERT EXACT GUARDED P1 HOOK ====="
"$VENV_PY" - "$SYS_PATCH" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1])
s=p.read_text()
marker='D97GS exact P1 selector bridge'
if marker in s:
    raise SystemExit('D97GS marker unexpectedly already present')

old_import='import logging\nimport plistlib\nimport subprocess\n'
new_import='import logging\nimport plistlib\nimport subprocess\nimport hashlib\n'
if s.count(old_import)!=1:
    raise SystemExit(f'import anchor count={s.count(old_import)}')
s=s.replace(old_import,new_import,1)

method='''\n\n    def _d97gs_apply_p1_selector_bridge(self) -> None:\n        \"\"\"D97GS exact P1 selector bridge for ASUS2 Tahoe 25G82 only.\n\n        Runs after all patchset file installation and before root-volume rebuild/snapshot.\n        Fails closed unless the final mounted-root MTLCompilerService is the exact\n        Golden original pre-P1 identity and the unique selector preimage is exact.\n        Writes only the two immediate bytes proven by D97GR, then requires exact\n        historical P1/D97M SHA identity.\n        \"\"\"\n        if self.constants.detected_os_build != \"25G82\":\n            return\n        if self.model != \"MacBookAir6,2\":\n            return\n\n        logging.info(\"- D97GS: applying exact P1 selector bridge\")\n        target = Path(self.mount_location) / Path(\n            \"System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/\"\n            \"MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService\"\n        )\n        expected_pre_sha = \"31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5\"\n        expected_post_sha = \"a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43\"\n        offset = 0x3494\n        pre = bytes.fromhex(\"81fe19790000\")\n        post = bytes.fromhex(\"81fe177d0000\")\n\n        if not target.is_file():\n            raise RuntimeError(f\"D97GS P1 target missing: {target}\")\n\n        before = target.read_bytes()\n        before_sha = hashlib.sha256(before).hexdigest()\n        if before_sha == expected_post_sha:\n            logging.info(\"  - D97GS P1 already exact; no write needed\")\n            return\n        if before_sha != expected_pre_sha:\n            raise RuntimeError(f\"D97GS P1 pre-SHA mismatch: {before_sha}\")\n        if before[offset:offset+len(pre)] != pre:\n            raise RuntimeError(\"D97GS P1 exact preimage mismatch at 0x3494\")\n\n        occurrences = []\n        start = 0\n        while True:\n            idx = before.find(pre, start)\n            if idx < 0:\n                break\n            occurrences.append(idx)\n            start = idx + 1\n        if occurrences != [offset]:\n            raise RuntimeError(f\"D97GS P1 preimage uniqueness mismatch: {occurrences}\")\n\n        # Only bytes +2/+3 differ between the proven preimage and postimage.\n        selector_tmp = Path(\"/private/tmp/OCLP-D97GS-P1-selector.bin\")\n        selector_tmp.write_bytes(post[2:4])\n        try:\n            subprocess_wrapper.run_as_root_and_verify(\n                [\"/bin/dd\", f\"if={selector_tmp}\", f\"of={target}\", \"bs=1\",\n                 f\"seek={offset+2}\", \"count=2\", \"conv=notrunc\"],\n                stdout=subprocess.PIPE, stderr=subprocess.STDOUT\n            )\n        finally:\n            try:\n                selector_tmp.unlink()\n            except FileNotFoundError:\n                pass\n\n        after = target.read_bytes()\n        after_sha = hashlib.sha256(after).hexdigest()\n        diffs = [i for i, (a, b) in enumerate(zip(before, after)) if a != b]\n        if len(before) != len(after):\n            raise RuntimeError(\"D97GS P1 target size changed\")\n        if diffs != [offset + 2, offset + 3]:\n            raise RuntimeError(f\"D97GS P1 unexpected byte delta: {diffs}\")\n        if after[offset:offset+len(post)] != post:\n            raise RuntimeError(\"D97GS P1 postimage mismatch\")\n        if after_sha != expected_post_sha:\n            raise RuntimeError(f\"D97GS P1 post-SHA mismatch: {after_sha}\")\n\n        logging.info(f\"  - D97GS P1 exact historical identity PASS: {after_sha}\")\n'''
anchor='\n\n    def _patch_root_vol(self):\n'
if s.count(anchor)!=1:
    raise SystemExit(f'method anchor count={s.count(anchor)}')
s=s.replace(anchor,method+anchor,1)

old_call='''        if self.patch_set_dictionary != {}:\n            self._execute_patchset(self.patch_set_dictionary)\n        else:\n            self._execute_patchset(HardwarePatchsetDetection(self.constants).patches)\n\n        if self.constants.wxpython_variant is True and self.constants.detected_os >= os_data.os_data.big_sur:\n'''
new_call='''        if self.patch_set_dictionary != {}:\n            self._execute_patchset(self.patch_set_dictionary)\n        else:\n            self._execute_patchset(HardwarePatchsetDetection(self.constants).patches)\n\n        # D97GS exact P1 selector bridge: bounded to exact ASUS2 model/build and fail-closed.\n        self._d97gs_apply_p1_selector_bridge()\n\n        if self.constants.wxpython_variant is True and self.constants.detected_os >= os_data.os_data.big_sur:\n'''
if s.count(old_call)!=1:
    raise SystemExit(f'call anchor count={s.count(old_call)}')
s=s.replace(old_call,new_call,1)
p.write_text(s)
print('D97GS_SOURCE_INSERT=PASS')
PY

"$VENV_PY" -m py_compile "$SYS_PATCH" || fail SYS_PATCH_PY_COMPILE_FAIL
git diff --check || fail D97GS_DIFF_CHECK_FAIL

EXPECTED_CHANGED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
  opencore_legacy_patcher/sys_patch/sys_patch.py | sort)"
ACTUAL_CHANGED="$(git diff --name-only | sort)"
printf '%s\n' "$ACTUAL_CHANGED"
[[ "$ACTUAL_CHANGED" == "$EXPECTED_CHANGED" ]] || fail D97GS_CHANGED_FILE_SET_MISMATCH

git diff > "$DIFF_OUT"
D97GS_DIFF_SHA="$(sha256 "$DIFF_OUT")"
echo "D97GS_SOURCE_DIFF=$DIFF_OUT"
echo "D97GS_SOURCE_DIFF_SHA256=$D97GS_DIFF_SHA"

# Machine-audit the newly added functional surface: exact constants, one hook call,
# and explicit absence of additional historical functional patch labels.
"$VENV_PY" - "$SYS_PATCH" <<'PY'
from pathlib import Path
import sys
s=Path(sys.argv[1]).read_text()
required={
 'method': 'def _d97gs_apply_p1_selector_bridge',
 'build': 'detected_os_build != "25G82"',
 'model': 'self.model != "MacBookAir6,2"',
 'pre_sha': '31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5',
 'post_sha': 'a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43',
 'pre': '81fe19790000',
 'post': '81fe177d0000',
 'offset': 'offset = 0x3494',
 'hook': 'self._d97gs_apply_p1_selector_bridge()',
}
for k,v in required.items():
    c=s.count(v)
    print(f'D97GS_SOURCE_{k.upper()}_COUNT={c}')
    if c != 1:
        raise SystemExit(f'{k} count={c}')
print('D97GS_SOURCE_P1_GUARD_CONTRACT=PASS')
PY

echo
echo "===== BUILD INNER OCLP ====="
/bin/rm -rf "$WORK/build" "$WORK/dist"
"$VENV_PY" Build-Project.command \
  --run-as-individual-steps \
  --prepare-application \
  --git-branch "D97GS-b9df76-Tahoe25G82-P1-only-x86_64" \
  --git-commit-url "https://github.com/dortania/OpenCore-Legacy-Patcher/commit/${GOLDEN_COMMIT}"

CUSTOM_APP="$WORK/dist/OpenCore-Patcher.app"
[[ -d "$CUSTOM_APP" ]] || fail INNER_APP_MISSING
/usr/bin/codesign --force --deep --sign - \
  --entitlements "$WORK/ci_tooling/entitlements/entitlements.plist" \
  "$CUSTOM_APP"
/usr/bin/codesign --verify --deep --strict "$CUSTOM_APP" || fail INNER_CODESIGN_FAIL
CUSTOM_EXE="$CUSTOM_APP/Contents/MacOS/OpenCore-Patcher"
[[ -f "$CUSTOM_EXE" ]] || fail INNER_EXECUTABLE_MISSING
INNER_ARCH="$(/usr/bin/lipo -archs "$CUSTOM_EXE")"
[[ "$INNER_ARCH" == x86_64 ]] || fail "INNER_ARCH_$INNER_ARCH"
INNER_SHA="$(sha256 "$CUSTOM_EXE")"
echo "D97GS_INNER_ARCH=$INNER_ARCH"
echo "D97GS_INNER_EXECUTABLE_SHA256=$INNER_SHA"


echo
echo "===== RESOLVE EXACT AUDITED D97DX WRAPPER TEMPLATE ====="
BASE_ZIP=""
for C in \
  "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.zip" \
  "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97DX.zip"
do
  if [[ -f "$C" ]] && [[ "$(sha256 "$C")" == "$EXPECTED_D97DX_ZIP_SHA" ]]; then
    BASE_ZIP="$C"
    break
  fi
done

/bin/rm -rf "$TEMPLATE_TMP"
/bin/mkdir -p "$TEMPLATE_TMP"
if [[ -n "$BASE_ZIP" ]]; then
  echo "D97GS_TEMPLATE_SOURCE_ZIP=$BASE_ZIP"
  echo "D97GS_TEMPLATE_ZIP_SHA256=$(sha256 "$BASE_ZIP")"
  /usr/bin/ditto -x -k "$BASE_ZIP" "$TEMPLATE_TMP"
  TEMPLATE_APP="$TEMPLATE_TMP/OpenCore-Patcher-Tahoe-D97DX.app"
else
  TEMPLATE_APP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.app"
  [[ -d "$TEMPLATE_APP" ]] || fail EXACT_D97DX_TEMPLATE_NOT_FOUND
  echo "D97GS_TEMPLATE_SOURCE_APP=$TEMPLATE_APP"
fi
[[ -d "$TEMPLATE_APP" ]] || fail D97DX_TEMPLATE_APP_MISSING

TEMPLATE_DEBUG="$TEMPLATE_APP/Contents/Resources/debug-privileged-helper"
TEMPLATE_PATCH="$TEMPLATE_APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
TEMPLATE_INNER="$TEMPLATE_APP/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
[[ -f "$TEMPLATE_DEBUG" ]] || fail TEMPLATE_DEBUG_HELPER_MISSING
[[ "$(sha256 "$TEMPLATE_DEBUG")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail TEMPLATE_DEBUG_HELPER_SHA_MISMATCH
[[ -f "$TEMPLATE_PATCH" ]] || fail TEMPLATE_BASE_PATCH_MISSING
[[ "$(sha256 "$TEMPLATE_PATCH")" == "$EXPECTED_BASE_PATCH_SHA" ]] || fail TEMPLATE_BASE_PATCH_SHA_MISMATCH
[[ -f "$TEMPLATE_INNER" ]] || fail TEMPLATE_INNER_MISSING

echo "D97GS_TEMPLATE_DEBUG_HELPER_SHA256=$(sha256 "$TEMPLATE_DEBUG")"
echo "D97GS_TEMPLATE_BASE_PATCH_SHA256=$(sha256 "$TEMPLATE_PATCH")"

TEMPLATE_LAUNCHER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$TEMPLATE_APP/Contents/Info.plist" 2>/dev/null || true)"
[[ -n "$TEMPLATE_LAUNCHER" ]] || fail TEMPLATE_CFEXECUTABLE_MISSING
TEMPLATE_LAUNCHER_PATH="$TEMPLATE_APP/Contents/MacOS/$TEMPLATE_LAUNCHER"
[[ -f "$TEMPLATE_LAUNCHER_PATH" ]] || fail TEMPLATE_LAUNCHER_MISSING
TEMPLATE_LAUNCHER_SHA="$(sha256 "$TEMPLATE_LAUNCHER_PATH")"
echo "D97GS_TEMPLATE_LAUNCHER=$TEMPLATE_LAUNCHER"
echo "D97GS_TEMPLATE_LAUNCHER_SHA256=$TEMPLATE_LAUNCHER_SHA"


echo
echo "===== ASSEMBLE D97GS OUTER APP ====="
/bin/rm -rf "$OUT" "$ZIP_OUT"
/usr/bin/ditto "$TEMPLATE_APP" "$OUT"
/bin/rm -rf "$OUT/Contents/Resources/OpenCore-Patcher.app"
/usr/bin/ditto "$CUSTOM_APP" "$OUT/Contents/Resources/OpenCore-Patcher.app"
/usr/bin/ditto "$DIFF_OUT" "$OUT/Contents/Resources/OCLP7_D97GS_SOURCE.patch"

# Keep the original D97DX source patch as base provenance and require its identity remains exact.
[[ "$(sha256 "$OUT/Contents/Resources/OCLP7_D97DX_SOURCE.patch")" == "$EXPECTED_BASE_PATCH_SHA" ]] || fail OUT_BASE_PATCH_DRIFT
[[ "$(sha256 "$OUT/Contents/Resources/debug-privileged-helper")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail OUT_DEBUG_HELPER_DRIFT
OUT_LAUNCHER="$OUT/Contents/MacOS/$TEMPLATE_LAUNCHER"
[[ "$(sha256 "$OUT_LAUNCHER")" == "$TEMPLATE_LAUNCHER_SHA" ]] || fail OUT_LAUNCHER_DRIFT

cat > "$OUT/Contents/Resources/OCLP7_D97GS_P1_CONTRACT.txt" <<EOF
D97GS_BUILD=25G82
D97GS_MODEL=MacBookAir6,2
D97GS_P1_PRE_SHA256=$EXPECTED_P1_PRE_SHA
D97GS_P1_POST_SHA256=$EXPECTED_P1_POST_SHA
D97GS_P1_OFFSET=0x3494
D97GS_P1_PREIMAGE=81fe19790000
D97GS_P1_POSTIMAGE=81fe177d0000
D97GS_WRITE_BYTES=0x3496:19->17,0x3497:79->7d
D97GS_P1_ONLY_NEW_FUNCTIONAL_DELTA=YES
D97GS_SOURCE_DIFF_SHA256=$D97GS_DIFF_SHA
EOF

/usr/bin/codesign --force --sign - "$OUT"
/usr/bin/codesign --verify --deep --strict "$OUT" || fail OUTER_CODESIGN_FAIL

NEW_INNER="$OUT/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
[[ "$(sha256 "$NEW_INNER")" == "$INNER_SHA" ]] || fail OUT_INNER_SHA_MISMATCH

/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP_OUT"
ZIP_SHA="$(sha256 "$ZIP_OUT")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP_OUT")"

echo
echo "===== FINAL ====="
echo "D97GS_STATUS=BUILD_PASS"
echo "D97GS_OUTER_APP=$OUT"
echo "D97GS_ZIP=$ZIP_OUT"
echo "D97GS_ZIP_SHA256=$ZIP_SHA"
echo "D97GS_ZIP_BYTES=$ZIP_BYTES"
echo "D97GS_SOURCE_DIFF_SHA256=$D97GS_DIFF_SHA"
echo "D97GS_INNER_EXECUTABLE_SHA256=$INNER_SHA"
echo "D97GS_DEBUG_HELPER_SHA256=$(sha256 "$OUT/Contents/Resources/debug-privileged-helper")"
echo "D97GS_LAUNCHER_SHA256=$(sha256 "$OUT_LAUNCHER")"
echo "D97GS_P1_PRE_SHA256=$EXPECTED_P1_PRE_SHA"
echo "D97GS_P1_POST_SHA256=$EXPECTED_P1_POST_SHA"
echo "D97GS_P1_ONLY_NEW_FUNCTIONAL_DELTA=PASS"
echo "D97GS_ROOT_PATCH=NO"
echo "D97GS_SYSTEM_ROOT_MUTATION=NO"
echo "D97GS_REBOOT=NO"
echo "D97GS_REPORT=$REPORT"
