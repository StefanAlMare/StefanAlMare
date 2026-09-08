#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HM — resume from the already-created D97HI source state after the
# regex-based P1 audit false negative. Reconstructs exact D97GS in a temporary
# worktree and compares the P1 FunctionDef source range via Python AST.
# Only if P1 is byte-identical and all source/hash gates pass does it build the
# D97HI inner OpenCore-Patcher.app. NO wrapper, Root Patch, EFI/NVRAM, reboot.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
VENV_PY="$WORK/.venv/bin/python"
SYS_PATCH_REL="opencore_legacy_patcher/sys_patch/sys_patch.py"
SYS_PATCH="$WORK/$SYS_PATCH_REL"

EXPECTED_CURRENT_D97HI_DIFF_SHA="c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2"
EXPECTED_D97GS_DIFF_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_UNIVERSAL_SHA="33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7"
EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P3_POST_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"

STAMP="$(date +%Y%m%d_%H%M%S)"
TMP="$HOME/Library/Caches/OCLP7-D97HM-$STAMP"
TEMP_WT="$TMP/D97GS-reconstruction"
REPORT="$HOME/Desktop/OCLP7_D97HM_RESUME_BUILD_REPORT_${STAMP}.txt"
OUT_APP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.app"
OUT_ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.zip"
mkdir -p "$TMP"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HM_STATUS=FAIL"; echo "D97HM_REASON=$*"; echo "D97HM_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cleanup(){
  if [[ -d "$TEMP_WT" ]]; then
    /usr/local/bin/git -C "$WORK" worktree remove --force "$TEMP_WT" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

cat <<'HDR'
===== OCLP7 D97HM — RESUME D97HI AFTER P1 AUDIT FALSE NEGATIVE =====
TOOLING_CORRECTION=AST_FUNCTION_BOUNDARY_AUDIT
FUNCTIONAL_SOURCE_CHANGE=NO
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
WRAPPER_ASSEMBLY=NO
OUTPUT=INNER_APP_ONLY
P2B_REPLAY=NO
AIR00_REPLAY=NO
D34_REPLAY=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -d "$WORK/.git" ]] || fail WORKTREE_MISSING
[[ -x "$VENV_PY" ]] || fail VENV_MISSING
[[ -f "$SYS_PATCH" ]] || fail SYS_PATCH_MISSING
[[ "$(/usr/local/bin/git -C "$WORK" rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || fail GOLDEN_HEAD_DRIFT
[[ "$($VENV_PY -c 'import sys;print(f"{sys.version_info.major}.{sys.version_info.minor}")')" == 3.13 ]] || fail VENV_NOT_PY313
[[ "$($VENV_PY -c 'import platform;print(platform.machine())')" == x86_64 ]] || fail VENV_NOT_X86_64

printf '\n===== CURRENT POST-P3 SOURCE IDENTITY =====\n'
CURRENT_DIFF="$TMP/D97HI-current.patch"
/usr/local/bin/git -C "$WORK" diff > "$CURRENT_DIFF"
CURRENT_DIFF_SHA="$(sha256 "$CURRENT_DIFF")"
echo "D97HM_CURRENT_D97HI_SOURCE_DIFF_SHA256=$CURRENT_DIFF_SHA"
[[ "$CURRENT_DIFF_SHA" == "$EXPECTED_CURRENT_D97HI_DIFF_SHA" ]] || fail CURRENT_D97HI_DIFF_SHA_MISMATCH

EXPECTED_CHANGED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
  opencore_legacy_patcher/sys_patch/sys_patch.py | sort)"
ACTUAL_CHANGED="$(/usr/local/bin/git -C "$WORK" diff --name-only | sort)"
[[ "$ACTUAL_CHANGED" == "$EXPECTED_CHANGED" ]] || fail CHANGED_FILE_SET_MISMATCH
/usr/local/bin/git -C "$WORK" diff --check || fail CURRENT_DIFF_CHECK_FAIL

echo "D97HM_CURRENT_D97HI_SOURCE_IDENTITY=PASS"

printf '\n===== LOCATE EXACT D97GS SOURCE PATCH =====\n'
D97GS_PATCH=""
while IFS= read -r P; do
  [[ -f "$P" ]] || continue
  if [[ "$(sha256 "$P")" == "$EXPECTED_D97GS_DIFF_SHA" ]]; then
    D97GS_PATCH="$P"
    break
  fi
done < <(/usr/bin/find "$HOME/Desktop" -maxdepth 1 -type f -name 'OCLP7_D97GS_SOURCE_*.patch' -print | /usr/bin/sort -r)
[[ -n "$D97GS_PATCH" ]] || fail EXACT_D97GS_PATCH_NOT_FOUND
echo "D97HM_D97GS_PATCH=$D97GS_PATCH"
echo "D97HM_D97GS_PATCH_SHA256=$(sha256 "$D97GS_PATCH")"

printf '\n===== RECONSTRUCT EXACT D97GS IN TEMP WORKTREE =====\n'
/usr/local/bin/git -C "$WORK" worktree add --detach "$TEMP_WT" "$GOLDEN_COMMIT" >/dev/null
/usr/local/bin/git -C "$TEMP_WT" apply "$D97GS_PATCH"
TEMP_DIFF="$TMP/D97GS-reconstructed.patch"
/usr/local/bin/git -C "$TEMP_WT" diff > "$TEMP_DIFF"
TEMP_DIFF_SHA="$(sha256 "$TEMP_DIFF")"
echo "D97HM_RECONSTRUCTED_D97GS_DIFF_SHA256=$TEMP_DIFF_SHA"
[[ "$TEMP_DIFF_SHA" == "$EXPECTED_D97GS_DIFF_SHA" ]] || fail RECONSTRUCTED_D97GS_DIFF_SHA_MISMATCH

echo "D97HM_RECONSTRUCTED_D97GS=PASS"

printf '\n===== AST-BOUNDED P1 BYTE IDENTITY =====\n'
"$VENV_PY" - "$TEMP_WT/$SYS_PATCH_REL" "$SYS_PATCH" <<'PY'
from pathlib import Path
import ast, hashlib, sys

def extract(path: Path, name: str) -> bytes:
    data=path.read_bytes()
    text=data.decode('utf-8')
    tree=ast.parse(text)
    nodes=[n for n in ast.walk(tree) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)) and n.name==name]
    if len(nodes)!=1:
        raise SystemExit(f'{path}: {name} node count={len(nodes)}')
    n=nodes[0]
    lines=data.splitlines(keepends=True)
    # AST lineno/end_lineno include the entire function definition/body but exclude
    # blank separator lines before the next method — exactly what we need here.
    seg=b''.join(lines[n.lineno-1:n.end_lineno])
    return seg

pre=extract(Path(sys.argv[1]),'_d97gs_apply_p1_selector_bridge')
post=extract(Path(sys.argv[2]),'_d97gs_apply_p1_selector_bridge')
h1=hashlib.sha256(pre).hexdigest(); h2=hashlib.sha256(post).hexdigest()
print('D97HM_P1_AST_PRE_BYTES='+str(len(pre)))
print('D97HM_P1_AST_POST_BYTES='+str(len(post)))
print('D97HM_P1_AST_PRE_SHA256='+h1)
print('D97HM_P1_AST_POST_SHA256='+h2)
print('D97HM_P1_AST_BYTE_IDENTICAL='+('PASS' if pre==post else 'FAIL'))
if pre!=post:
    import difflib
    a=pre.decode().splitlines(); b=post.decode().splitlines()
    for line in difflib.unified_diff(a,b,fromfile='D97GS_P1',tofile='D97HI_P1',lineterm=''):
        print(line)
    raise SystemExit('P1 AST-bounded bytes drifted')
print('D97HM_P1_FUNCTION_PRESERVED_EXACT=PASS')
PY

printf '\n===== P3 SOURCE CONTRACT =====\n'
"$VENV_PY" - "$SYS_PATCH" <<'PY'
from pathlib import Path
import ast,sys
s=Path(sys.argv[1]).read_text()
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
    c=s.count(v)
    print(f'D97HM_{k.upper()}_COUNT={c}')
    if c!=1: raise SystemExit(f'{k} count={c}')

tree=ast.parse(s)
names=[n.name for n in ast.walk(tree) if isinstance(n,ast.FunctionDef)]
for name in ('_d97gs_apply_p1_selector_bridge','_d97hi_apply_p3_serialized_bitcode_bridge'):
    if names.count(name)!=1: raise SystemExit(f'{name} AST count={names.count(name)}')

i1=s.index('self._d97gs_apply_p1_selector_bridge()')
i3=s.index('self._d97hi_apply_p3_serialized_bitcode_bridge()')
iw=s.index('if self.constants.wxpython_variant is True',i3)
if not (i1<i3<iw): raise SystemExit('hook ordering fail')
print('D97HM_HOOK_ORDER_P1_THEN_P3_THEN_CONTINUATION=PASS')
print('D97HM_P3_SOURCE_CONTRACT=STATIC_STRUCTURAL_SEMANTIC_PROVEN')
PY

printf '\n===== ASSET / BUILD PRECONDITIONS =====\n'
[[ -f "$WORK/Universal-Binaries.dmg" ]] || fail UNIVERSAL_BINARIES_MISSING
[[ "$(sha256 "$WORK/Universal-Binaries.dmg")" == "$EXPECTED_UNIVERSAL_SHA" ]] || fail UNIVERSAL_BINARIES_SHA_MISMATCH
[[ -f "$WORK/payloads.dmg" ]] || fail PAYLOADS_DMG_MISSING
echo "D97HM_UNIVERSAL_BINARIES_SHA256=$(sha256 "$WORK/Universal-Binaries.dmg")"
echo "D97HM_PAYLOADS_DMG_SHA256=$(sha256 "$WORK/payloads.dmg")"
echo "D97HM_BUILD_PRECONDITIONS=PASS"

printf '\n===== BUILD D97HI INNER =====\n'
cd "$WORK"
/bin/rm -rf "$WORK/build" "$WORK/dist"
"$VENV_PY" Build-Project.command \
  --run-as-individual-steps \
  --prepare-application \
  --git-branch "D97HI-b9df76-Tahoe25G82-P1-P3-only-x86_64-portable" \
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

echo "D97HM_INNER_ARCH=$INNER_ARCH"
echo "D97HM_INNER_EXECUTABLE_SHA256=$INNER_SHA"

printf '\n===== PACKAGE PORTABLE INNER =====\n'
/bin/rm -rf "$OUT_APP" "$OUT_ZIP"
/usr/bin/ditto "$CUSTOM_APP" "$OUT_APP"
/usr/bin/codesign --verify --deep --strict "$OUT_APP" || fail PACKAGED_INNER_CODESIGN_FAIL
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT_APP" "$OUT_ZIP"
ZIP_SHA="$(sha256 "$OUT_ZIP")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$OUT_ZIP")"

printf '\n===== FINAL =====\n'
echo "D97HI_STATUS=BUILD_PASS_PORTABLE_INNER"
echo "D97HI_NEW_FUNCTIONAL_DELTA=P3_ONLY"
echo "D97HI_P1_BASE=PRESERVED_EXACT"
echo "D97HI_P2B_REPLAY=NO"
echo "D97HI_AIR00_REPLAY=NO"
echo "D97HI_D34_REPLAY=NO"
echo "D97HI_P1_POST_SHA256=$EXPECTED_P1_POST_SHA"
echo "D97HI_P3_POST_SHA256=$EXPECTED_P3_POST_SHA"
echo "D97HI_SOURCE_DIFF_SHA256=$CURRENT_DIFF_SHA"
echo "D97HI_INNER_EXECUTABLE_SHA256=$INNER_SHA"
echo "D97HI_PORTABLE_INNER_ZIP=$OUT_ZIP"
echo "D97HI_PORTABLE_INNER_ZIP_SHA256=$ZIP_SHA"
echo "D97HI_PORTABLE_INNER_ZIP_BYTES=$ZIP_BYTES"
echo "D97HM_STATUS=PASS_RESUME_INNER_BUILD"
echo "D97HM_ROOT_PATCH=NO"
echo "D97HM_REBOOT=NO"
echo "D97HM_NEXT=INDEPENDENT_INNER_AUDIT_BEFORE_WRAPPER_ASSEMBLY"
echo "D97HM_REPORT=$REPORT"
