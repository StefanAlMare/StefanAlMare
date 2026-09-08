#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HI — build D97GS + exact measured P3 serialized-bitcode bridge only.
# BUILD HOST: authorized Intel iMac only.
# NO Root Patch. NO EFI/NVRAM/framebuffer/system-root mutation. NO reboot.
# Source base must be the exact previously audited D97GS source state.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
VENV_PY="$WORK/.venv/bin/python"
SYS_PATCH="$WORK/opencore_legacy_patcher/sys_patch/sys_patch.py"

EXPECTED_D97GS_SOURCE_DIFF_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_D97GS_ZIP_SHA="e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266"
EXPECTED_D97GS_ZIP_BYTES="722879148"
EXPECTED_D97DX_BASE_PATCH_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_LAUNCHER_SHA="344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c"
EXPECTED_P1_PRE_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P3_PRE_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_P3_POST_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI.app"
ZIP_OUT="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI.zip"
REPORT="$HOME/Desktop/OCLP7_D97HI_IMAC_BUILD_REPORT_${STAMP}.txt"
DIFF_OUT="$HOME/Desktop/OCLP7_D97HI_SOURCE_${STAMP}.patch"
PRE_DIFF="/private/tmp/OCLP7_D97HI_PRE_DIFF_$$.patch"
PRE_SYS="/private/tmp/OCLP7_D97HI_sys_patch_PRE_$$.py"
TEMPLATE_TMP="/private/tmp/OCLP7_D97HI_TEMPLATE_$$"

cleanup() {
  /bin/rm -f "$PRE_DIFF" "$PRE_SYS" 2>/dev/null || true
  /bin/rm -rf "$TEMPLATE_TMP" 2>/dev/null || true
}
trap cleanup EXIT

exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97HI_STATUS=FAIL"; echo "D97HI_REASON=$*"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cat <<'HDR'
===== OCLP7 D97HI — D97GS + P3-ONLY BUILD =====
BUILD_HOST=INTEL_IMAC_ONLY
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
BASE=D97GS_EXACT_P1_ONLY
NEW_FUNCTIONAL_DELTA=P3_ONLY_SERIALIZED_BITCODE
P2B_NEW_REPLAY=NO
AIR00_NEW_REPLAY=NO
D34_NEW_REPLAY=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64_BUILD_HOST
[[ -d "$WORK/.git" ]] || fail WORKTREE_MISSING
[[ -x "$VENV_PY" ]] || fail VENV_MISSING
[[ -f "$SYS_PATCH" ]] || fail SYS_PATCH_SOURCE_MISSING

cd "$WORK"
[[ "$(git rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || fail GOLDEN_HEAD_DRIFT

printf '\n===== VERIFY EXACT D97GS SOURCE BASE =====\n'
git diff > "$PRE_DIFF"
PRE_DIFF_SHA="$(sha256 "$PRE_DIFF")"
echo "D97HI_PRE_DIFF_SHA256=$PRE_DIFF_SHA"
[[ "$PRE_DIFF_SHA" == "$EXPECTED_D97GS_SOURCE_DIFF_SHA" ]] || fail D97GS_SOURCE_BASE_DIFF_MISMATCH

git diff --check || fail D97GS_SOURCE_BASE_DIFF_CHECK_FAIL
EXPECTED_CHANGED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
  opencore_legacy_patcher/sys_patch/sys_patch.py | sort)"
ACTUAL_CHANGED="$(git diff --name-only | sort)"
printf '%s\n' "$ACTUAL_CHANGED"
[[ "$ACTUAL_CHANGED" == "$EXPECTED_CHANGED" ]] || fail D97GS_CHANGED_FILE_SET_DRIFT

/bin/cp "$SYS_PATCH" "$PRE_SYS"

"$VENV_PY" - "$SYS_PATCH" <<'PY'
from pathlib import Path
import sys,hashlib,re
p=Path(sys.argv[1]); s=p.read_text()
required=[
    'def _d97gs_apply_p1_selector_bridge',
    'self._d97gs_apply_p1_selector_bridge()',
    '31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5',
    'a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43',
    '81fe19790000', '81fe177d0000', 'offset = 0x3494',
]
for token in required:
    if s.count(token) != 1:
        raise SystemExit(f'D97GS base token count mismatch: {token!r} -> {s.count(token)}')
if 'def _d97hi_apply_p3_serialized_bitcode_bridge' in s:
    raise SystemExit('D97HI P3 method already present')
if 'self._d97hi_apply_p3_serialized_bitcode_bridge()' in s:
    raise SystemExit('D97HI P3 hook already present')

# Hash exact D97GS P1 method before insertion so later audit can prove it stayed byte-identical.
m=re.search(r'\n    def _d97gs_apply_p1_selector_bridge\(self\).*?(?=\n    def _patch_root_vol\(self\):)',s,re.S)
if not m:
    raise SystemExit('cannot isolate D97GS P1 method')
print('D97HI_D97GS_P1_METHOD_PRE_SHA256='+hashlib.sha256(m.group(0).encode()).hexdigest())
PY

echo "D97HI_D97GS_SOURCE_BASE=PASS"

printf '\n===== INSERT EXACT GUARDED P3 SERIALIZED-BITCODE BRIDGE =====\n'
"$VENV_PY" - "$SYS_PATCH" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); s=p.read_text()

method='''\n\n    def _d97hi_apply_p3_serialized_bitcode_bridge(self) -> None:\n        \"\"\"D97HI exact P3 serialized-bitcode bridge for ASUS2 Tahoe 25G82 only.\n\n        Runs after patchset installation and after the exact D97GS P1 bridge.\n        Fails closed unless mounted-root MTLCompiler 32023 is the exact unmodified\n        Golden identity proven by D97HG. Changes exactly one byte at the historical\n        P3 site to force MTLCompilerOptionCompilerPluginRequiresSerializedBitcode,\n        avoiding the measured direct llvm::Module* cross-generation ABI frontier.\n        \"\"\"\n        if self.constants.detected_os_build != \"25G82\":\n            return\n        if self.model != \"MacBookAir6,2\":\n            return\n\n        logging.info(\"- D97HI: applying exact P3 serialized-bitcode bridge\")\n        target = Path(self.mount_location) / Path(\n            \"System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler\"\n        )\n        expected_pre_sha = \"ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269\"\n        expected_post_sha = \"0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90\"\n        offset = 0xA1573\n        pre = bytes.fromhex(\"81e100002000\")\n        post = bytes.fromhex(\"81c900002000\")\n\n        if not target.is_file():\n            raise RuntimeError(f\"D97HI P3 target missing: {target}\")\n\n        before = target.read_bytes()\n        before_sha = hashlib.sha256(before).hexdigest()\n        if before_sha == expected_post_sha:\n            logging.info(\"  - D97HI P3 already exact; no write needed\")\n            return\n        if before_sha != expected_pre_sha:\n            raise RuntimeError(f\"D97HI P3 pre-SHA mismatch: {before_sha}\")\n        if before[offset:offset+len(pre)] != pre:\n            raise RuntimeError(\"D97HI P3 exact preimage mismatch at 0xA1573\")\n\n        occurrences = []\n        start = 0\n        while True:\n            idx = before.find(pre, start)\n            if idx < 0:\n                break\n            occurrences.append(idx)\n            start = idx + 1\n        if occurrences != [offset]:\n            raise RuntimeError(f\"D97HI P3 preimage uniqueness mismatch: {occurrences}\")\n\n        # D97HG proves historical P3 changes exactly byte +1: e1 -> c9.\n        p3_tmp = Path(\"/private/tmp/OCLP-D97HI-P3-byte.bin\")\n        p3_tmp.write_bytes(post[1:2])\n        try:\n            subprocess_wrapper.run_as_root_and_verify(\n                [\"/bin/dd\", f\"if={p3_tmp}\", f\"of={target}\", \"bs=1\",\n                 f\"seek={offset+1}\", \"count=1\", \"conv=notrunc\"],\n                stdout=subprocess.PIPE, stderr=subprocess.STDOUT\n            )\n        finally:\n            try:\n                p3_tmp.unlink()\n            except FileNotFoundError:\n                pass\n\n        after = target.read_bytes()\n        after_sha = hashlib.sha256(after).hexdigest()\n        diffs = [i for i, (a, b) in enumerate(zip(before, after)) if a != b]\n        if len(before) != len(after):\n            raise RuntimeError(\"D97HI P3 target size changed\")\n        if diffs != [offset + 1]:\n            raise RuntimeError(f\"D97HI P3 unexpected byte delta: {diffs}\")\n        if after[offset:offset+len(post)] != post:\n            raise RuntimeError(\"D97HI P3 postimage mismatch\")\n        if after_sha != expected_post_sha:\n            raise RuntimeError(f\"D97HI P3 post-SHA mismatch: {after_sha}\")\n\n        logging.info(f\"  - D97HI P3 exact P3-only identity PASS: {after_sha}\")\n'''
anchor='\n\n    def _patch_root_vol(self):\n'
if s.count(anchor) != 1:
    raise SystemExit(f'P3 method anchor count={s.count(anchor)}')
s=s.replace(anchor,method+anchor,1)

old='''        # D97GS exact P1 selector bridge: bounded to exact ASUS2 model/build and fail-closed.\n        self._d97gs_apply_p1_selector_bridge()\n\n        if self.constants.wxpython_variant is True and self.constants.detected_os >= os_data.os_data.big_sur:\n'''
new='''        # D97GS exact P1 selector bridge: bounded to exact ASUS2 model/build and fail-closed.\n        self._d97gs_apply_p1_selector_bridge()\n\n        # D97HI exact measured P3 bridge: serialized-bitcode path only; no P2b/AIR00/D34 replay.\n        self._d97hi_apply_p3_serialized_bitcode_bridge()\n\n        if self.constants.wxpython_variant is True and self.constants.detected_os >= os_data.os_data.big_sur:\n'''
if s.count(old) != 1:
    raise SystemExit(f'P3 hook anchor count={s.count(old)}')
s=s.replace(old,new,1)
p.write_text(s)
print('D97HI_SOURCE_INSERT=PASS')
PY

"$VENV_PY" -m py_compile "$SYS_PATCH" || fail SYS_PATCH_PY_COMPILE_FAIL
git diff --check || fail D97HI_DIFF_CHECK_FAIL

ACTUAL_CHANGED="$(git diff --name-only | sort)"
[[ "$ACTUAL_CHANGED" == "$EXPECTED_CHANGED" ]] || fail D97HI_CHANGED_FILE_SET_MISMATCH

git diff > "$DIFF_OUT"
D97HI_DIFF_SHA="$(sha256 "$DIFF_OUT")"
echo "D97HI_SOURCE_DIFF=$DIFF_OUT"
echo "D97HI_SOURCE_DIFF_SHA256=$D97HI_DIFF_SHA"

printf '\n===== SOURCE CONTRACT AUDIT =====\n'
"$VENV_PY" - "$PRE_SYS" "$SYS_PATCH" <<'PY'
from pathlib import Path
import sys,hashlib,re
pre=Path(sys.argv[1]).read_text(); post=Path(sys.argv[2]).read_text()

def p1_method(s):
    m=re.search(r'\n    def _d97gs_apply_p1_selector_bridge\(self\).*?(?=\n    def (?:_d97hi_apply_p3_serialized_bitcode_bridge|_patch_root_vol)\(self\):)',s,re.S)
    if not m: raise SystemExit('cannot isolate P1 method')
    return m.group(0)
a=p1_method(pre); b=p1_method(post)
print('D97HI_P1_METHOD_PRE_SHA256='+hashlib.sha256(a.encode()).hexdigest())
print('D97HI_P1_METHOD_POST_SHA256='+hashlib.sha256(b.encode()).hexdigest())
print('D97HI_P1_METHOD_BYTE_IDENTICAL='+('PASS' if a==b else 'FAIL'))
if a!=b: raise SystemExit('P1 method drift')

required={
 'p3_method':'def _d97hi_apply_p3_serialized_bitcode_bridge',
 'p3_hook':'self._d97hi_apply_p3_serialized_bitcode_bridge()',
 'p3_pre_sha':'ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269',
 'p3_post_sha':'0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90',
 'p3_offset':'offset = 0xA1573',
 'p3_pre':'81e100002000',
 'p3_post':'81c900002000',
 'p1_method':'def _d97gs_apply_p1_selector_bridge',
 'p1_hook':'self._d97gs_apply_p1_selector_bridge()',
}
for k,v in required.items():
    c=post.count(v)
    print(f'D97HI_SOURCE_{k.upper()}_COUNT={c}')
    if c!=1: raise SystemExit(f'{k} count={c}')
# Hook ordering must be P1 then P3 then wxpython/snapshot continuation.
i1=post.index('self._d97gs_apply_p1_selector_bridge()')
i3=post.index('self._d97hi_apply_p3_serialized_bitcode_bridge()')
iw=post.index('if self.constants.wxpython_variant is True',i3)
print('D97HI_HOOK_ORDER_P1_THEN_P3_THEN_CONTINUATION='+('PASS' if i1<i3<iw else 'FAIL'))
if not (i1<i3<iw): raise SystemExit('hook ordering fail')
print('D97HI_SOURCE_CONTRACT=STATIC_STRUCTURAL_SEMANTIC_PROVEN')
PY

printf '\n===== BUILD INNER OCLP =====\n'
/bin/rm -rf "$WORK/build" "$WORK/dist"
"$VENV_PY" Build-Project.command \
  --run-as-individual-steps \
  --prepare-application \
  --git-branch "D97HI-b9df76-Tahoe25G82-P1-plus-P3-only-x86_64" \
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
echo "D97HI_INNER_ARCH=$INNER_ARCH"
echo "D97HI_INNER_EXECUTABLE_SHA256=$INNER_SHA"

printf '\n===== RESOLVE EXACT D97GS WRAPPER TEMPLATE =====\n'
BASE_ZIP=""
for C in \
  "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97GS.zip" \
  "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97GS.zip"
do
  if [[ -f "$C" ]] && [[ "$(sha256 "$C")" == "$EXPECTED_D97GS_ZIP_SHA" ]] && [[ "$(/usr/bin/stat -f '%z' "$C")" == "$EXPECTED_D97GS_ZIP_BYTES" ]]; then
    BASE_ZIP="$C"
    break
  fi
done
[[ -n "$BASE_ZIP" ]] || fail EXACT_D97GS_ZIP_NOT_FOUND

echo "D97HI_TEMPLATE_D97GS_ZIP=$BASE_ZIP"
echo "D97HI_TEMPLATE_D97GS_ZIP_SHA256=$(sha256 "$BASE_ZIP")"
echo "D97HI_TEMPLATE_D97GS_ZIP_BYTES=$(/usr/bin/stat -f '%z' "$BASE_ZIP")"

/bin/rm -rf "$TEMPLATE_TMP"
/bin/mkdir -p "$TEMPLATE_TMP"
/usr/bin/ditto -x -k "$BASE_ZIP" "$TEMPLATE_TMP"
TEMPLATE_APP="$TEMPLATE_TMP/OpenCore-Patcher-Tahoe-D97GS.app"
[[ -d "$TEMPLATE_APP" ]] || fail D97GS_TEMPLATE_APP_MISSING

TEMPLATE_DEBUG="$TEMPLATE_APP/Contents/Resources/debug-privileged-helper"
TEMPLATE_DX_PATCH="$TEMPLATE_APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
TEMPLATE_GS_PATCH="$TEMPLATE_APP/Contents/Resources/OCLP7_D97GS_SOURCE.patch"
TEMPLATE_INNER="$TEMPLATE_APP/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
[[ -f "$TEMPLATE_DEBUG" ]] || fail TEMPLATE_DEBUG_HELPER_MISSING
[[ "$(sha256 "$TEMPLATE_DEBUG")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail TEMPLATE_DEBUG_HELPER_SHA_MISMATCH
[[ -f "$TEMPLATE_DX_PATCH" ]] || fail TEMPLATE_D97DX_PATCH_MISSING
[[ "$(sha256 "$TEMPLATE_DX_PATCH")" == "$EXPECTED_D97DX_BASE_PATCH_SHA" ]] || fail TEMPLATE_D97DX_PATCH_SHA_MISMATCH
[[ -f "$TEMPLATE_GS_PATCH" ]] || fail TEMPLATE_D97GS_PATCH_MISSING
[[ "$(sha256 "$TEMPLATE_GS_PATCH")" == "$EXPECTED_D97GS_SOURCE_DIFF_SHA" ]] || fail TEMPLATE_D97GS_PATCH_SHA_MISMATCH
[[ -f "$TEMPLATE_INNER" ]] || fail TEMPLATE_INNER_MISSING

TEMPLATE_LAUNCHER="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$TEMPLATE_APP/Contents/Info.plist" 2>/dev/null || true)"
[[ -n "$TEMPLATE_LAUNCHER" ]] || fail TEMPLATE_CFEXECUTABLE_MISSING
TEMPLATE_LAUNCHER_PATH="$TEMPLATE_APP/Contents/MacOS/$TEMPLATE_LAUNCHER"
[[ -f "$TEMPLATE_LAUNCHER_PATH" ]] || fail TEMPLATE_LAUNCHER_MISSING
[[ "$(sha256 "$TEMPLATE_LAUNCHER_PATH")" == "$EXPECTED_LAUNCHER_SHA" ]] || fail TEMPLATE_LAUNCHER_SHA_MISMATCH

echo "D97HI_TEMPLATE_DEBUG_HELPER_SHA256=$(sha256 "$TEMPLATE_DEBUG")"
echo "D97HI_TEMPLATE_D97DX_PATCH_SHA256=$(sha256 "$TEMPLATE_DX_PATCH")"
echo "D97HI_TEMPLATE_D97GS_PATCH_SHA256=$(sha256 "$TEMPLATE_GS_PATCH")"
echo "D97HI_TEMPLATE_LAUNCHER=$TEMPLATE_LAUNCHER"
echo "D97HI_TEMPLATE_LAUNCHER_SHA256=$(sha256 "$TEMPLATE_LAUNCHER_PATH")"

printf '\n===== ASSEMBLE D97HI OUTER APP =====\n'
/bin/rm -rf "$OUT" "$ZIP_OUT"
/usr/bin/ditto "$TEMPLATE_APP" "$OUT"
/bin/rm -rf "$OUT/Contents/Resources/OpenCore-Patcher.app"
/usr/bin/ditto "$CUSTOM_APP" "$OUT/Contents/Resources/OpenCore-Patcher.app"
/usr/bin/ditto "$DIFF_OUT" "$OUT/Contents/Resources/OCLP7_D97HI_SOURCE.patch"

# Preserve exact D97DX and D97GS provenance plus exact launcher/debug-helper workflow.
[[ "$(sha256 "$OUT/Contents/Resources/OCLP7_D97DX_SOURCE.patch")" == "$EXPECTED_D97DX_BASE_PATCH_SHA" ]] || fail OUT_D97DX_PATCH_DRIFT
[[ "$(sha256 "$OUT/Contents/Resources/OCLP7_D97GS_SOURCE.patch")" == "$EXPECTED_D97GS_SOURCE_DIFF_SHA" ]] || fail OUT_D97GS_PATCH_DRIFT
[[ "$(sha256 "$OUT/Contents/Resources/debug-privileged-helper")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail OUT_DEBUG_HELPER_DRIFT
OUT_LAUNCHER="$OUT/Contents/MacOS/$TEMPLATE_LAUNCHER"
[[ "$(sha256 "$OUT_LAUNCHER")" == "$EXPECTED_LAUNCHER_SHA" ]] || fail OUT_LAUNCHER_DRIFT

cat > "$OUT/Contents/Resources/OCLP7_D97HI_MANIFEST.txt" <<EOF
D97HI_BASE=D97GS_EXACT
D97GS_ZIP_SHA256=$EXPECTED_D97GS_ZIP_SHA
D97GS_SOURCE_DIFF_SHA256=$EXPECTED_D97GS_SOURCE_DIFF_SHA
D97DX_BASE_SOURCE_PATCH_SHA256=$EXPECTED_D97DX_BASE_PATCH_SHA
D97HI_SOURCE_DIFF_SHA256=$D97HI_DIFF_SHA
D97HI_INNER_EXECUTABLE_SHA256=$INNER_SHA
D97HI_DEBUG_HELPER_SHA256=$EXPECTED_DEBUG_HELPER_SHA
D97HI_LAUNCHER_SHA256=$EXPECTED_LAUNCHER_SHA
D97HI_P1_PRE_SHA256=$EXPECTED_P1_PRE_SHA
D97HI_P1_POST_SHA256=$EXPECTED_P1_POST_SHA
D97HI_P1_BYTES=0x3496:19->17,0x3497:79->7d
D97HI_P3_PRE_SHA256=$EXPECTED_P3_PRE_SHA
D97HI_P3_POST_SHA256=$EXPECTED_P3_POST_SHA
D97HI_P3_OFFSET=0xA1573
D97HI_P3_PREIMAGE=81e100002000
D97HI_P3_POSTIMAGE=81c900002000
D97HI_P3_WRITE_BYTE=0xA1574:e1->c9
D97HI_P2B_REPLAY=NO
D97HI_AIR00_REPLAY=NO
D97HI_D34_REPLAY=NO
EOF

# Preserve the exact proven wrapper behavior; sign only the outer bundle ad-hoc as D97GS did.
# Developer ID is intentionally not used for this internal diagnostic artifact because
# changing wrapper/nested signing identity would add an unrelated variable to the measured test.
/usr/bin/codesign --force --sign - "$OUT"
/usr/bin/codesign --verify --deep --strict "$OUT" || fail OUTER_CODESIGN_FAIL

NEW_INNER="$OUT/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
[[ "$(sha256 "$NEW_INNER")" == "$INNER_SHA" ]] || fail OUT_INNER_SHA_MISMATCH
[[ "$(/usr/bin/lipo -archs "$NEW_INNER")" == x86_64 ]] || fail OUT_INNER_ARCH_MISMATCH

/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP_OUT"
ZIP_SHA="$(sha256 "$ZIP_OUT")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP_OUT")"

printf '\n===== FINAL =====\n'
echo "D97HI_STATUS=BUILD_PASS"
echo "D97HI_NEW_FUNCTIONAL_DELTA=P3_ONLY"
echo "D97HI_P1_BASE=PRESERVED_EXACT"
echo "D97HI_P2B_REPLAY=NO"
echo "D97HI_AIR00_REPLAY=NO"
echo "D97HI_D34_REPLAY=NO"
echo "D97HI_P3_PRE_SHA256=$EXPECTED_P3_PRE_SHA"
echo "D97HI_P3_POST_SHA256=$EXPECTED_P3_POST_SHA"
echo "D97HI_P3_WRITE_BYTE=0xA1574:e1->c9"
echo "D97HI_OUTER_APP=$OUT"
echo "D97HI_ZIP=$ZIP_OUT"
echo "D97HI_ZIP_SHA256=$ZIP_SHA"
echo "D97HI_ZIP_BYTES=$ZIP_BYTES"
echo "D97HI_SOURCE_DIFF_SHA256=$D97HI_DIFF_SHA"
echo "D97HI_INNER_EXECUTABLE_SHA256=$INNER_SHA"
echo "D97HI_DEBUG_HELPER_SHA256=$(sha256 "$OUT/Contents/Resources/debug-privileged-helper")"
echo "D97HI_LAUNCHER_SHA256=$(sha256 "$OUT_LAUNCHER")"
echo "D97HI_REPORT=$REPORT"
