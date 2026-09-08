#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HN — independent read-only audit of the built D97HI portable inner artifact.
# NO build. NO source mutation. NO wrapper assembly. NO Root Patch. NO EFI/NVRAM. NO reboot.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
VENV_PY="$WORK/.venv/bin/python"
SYS_REL="opencore_legacy_patcher/sys_patch/sys_patch.py"
SYS="$WORK/$SYS_REL"
APP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.app"
ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.zip"

EXPECTED_D97GS_DIFF_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"
EXPECTED_D97HI_DIFF_SHA="c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2"
EXPECTED_INNER_SHA="1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133"
EXPECTED_ZIP_SHA="b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94"
EXPECTED_ZIP_BYTES="722927108"
EXPECTED_P1_SERVICE_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_P3_COMPILER_POST_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"

STAMP="$(date +%Y%m%d_%H%M%S)"
TMP="$HOME/Library/Caches/OCLP7-D97HN-$STAMP"
TEMP_WT="$TMP/D97GS-reference"
EXTRACT="$TMP/extracted"
REPORT="$HOME/Desktop/OCLP7_D97HN_INDEPENDENT_AUDIT_${STAMP}.txt"
AUDIT_ZIP="$HOME/Desktop/OCLP7_D97HN_INDEPENDENT_AUDIT_${STAMP}.zip"
mkdir -p "$TMP" "$EXTRACT"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HN_STATUS=FAIL"; echo "D97HN_REASON=$*"; echo "D97HN_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cleanup(){
  if [[ -d "$TEMP_WT" ]]; then
    /usr/local/bin/git -C "$WORK" worktree remove --force "$TEMP_WT" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

cat <<'HDR'
===== OCLP7 D97HN — INDEPENDENT D97HI INNER ARTIFACT AUDIT =====
READ_ONLY_AUDIT=YES
BUILD=NO
SOURCE_MUTATION=NO
WRAPPER_ASSEMBLY=NO
ROOT_PATCH=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -d "$WORK/.git" ]] || fail WORKTREE_MISSING
[[ -x "$VENV_PY" ]] || fail VENV_MISSING
[[ -f "$SYS" ]] || fail SYS_PATCH_MISSING
[[ -d "$APP" ]] || fail PORTABLE_INNER_APP_MISSING
[[ -f "$ZIP" ]] || fail PORTABLE_INNER_ZIP_MISSING
[[ "$(/usr/local/bin/git -C "$WORK" rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || fail GOLDEN_HEAD_DRIFT

echo "D97HN_HOST=$(/usr/bin/sw_vers -productVersion)/$('/usr/bin/sw_vers' -buildVersion 2>/dev/null || /usr/bin/sw_vers -buildVersion)"

printf '\n===== SOURCE IDENTITY =====\n'
CUR_DIFF="$TMP/D97HI-current.patch"
/usr/local/bin/git -C "$WORK" diff > "$CUR_DIFF"
CUR_SHA="$(sha256 "$CUR_DIFF")"
echo "D97HN_D97HI_SOURCE_DIFF_SHA256=$CUR_SHA"
[[ "$CUR_SHA" == "$EXPECTED_D97HI_DIFF_SHA" ]] || fail D97HI_SOURCE_DIFF_SHA_MISMATCH
/usr/local/bin/git -C "$WORK" diff --check || fail D97HI_DIFF_CHECK_FAIL
EXPECTED_CHANGED="$(printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
  opencore_legacy_patcher/sys_patch/sys_patch.py | sort)"
ACTUAL_CHANGED="$(/usr/local/bin/git -C "$WORK" diff --name-only | sort)"
[[ "$ACTUAL_CHANGED" == "$EXPECTED_CHANGED" ]] || fail CHANGED_FILE_SET_MISMATCH
echo "D97HN_SOURCE_FILE_SET=PASS"

printf '\n===== RECONSTRUCT D97GS REFERENCE =====\n'
D97GS_PATCH=""
while IFS= read -r P; do
  [[ -f "$P" ]] || continue
  if [[ "$(sha256 "$P")" == "$EXPECTED_D97GS_DIFF_SHA" ]]; then
    D97GS_PATCH="$P"; break
  fi
done < <(/usr/bin/find "$HOME/Desktop" -maxdepth 1 -type f -name 'OCLP7_D97GS_SOURCE_*.patch' -print | /usr/bin/sort -r)
[[ -n "$D97GS_PATCH" ]] || fail EXACT_D97GS_PATCH_NOT_FOUND
/usr/local/bin/git -C "$WORK" worktree add --detach "$TEMP_WT" "$GOLDEN_COMMIT" >/dev/null
/usr/local/bin/git -C "$TEMP_WT" apply "$D97GS_PATCH"
REF_DIFF="$TMP/D97GS-reference.patch"
/usr/local/bin/git -C "$TEMP_WT" diff > "$REF_DIFF"
REF_SHA="$(sha256 "$REF_DIFF")"
echo "D97HN_D97GS_REFERENCE_DIFF_SHA256=$REF_SHA"
[[ "$REF_SHA" == "$EXPECTED_D97GS_DIFF_SHA" ]] || fail D97GS_REFERENCE_DIFF_SHA_MISMATCH

echo "D97HN_D97GS_REFERENCE=PASS"

printf '\n===== P1 AST BYTE IDENTITY + P3 CONTRACT =====\n'
"$VENV_PY" - "$TEMP_WT/$SYS_REL" "$SYS" <<'PY'
from pathlib import Path
import ast, hashlib, sys

def extract(path,name):
    data=Path(path).read_bytes(); text=data.decode('utf-8'); tree=ast.parse(text)
    nodes=[n for n in ast.walk(tree) if isinstance(n,ast.FunctionDef) and n.name==name]
    if len(nodes)!=1: raise SystemExit(f'{name} count={len(nodes)} in {path}')
    n=nodes[0]; lines=data.splitlines(keepends=True)
    return b''.join(lines[n.lineno-1:n.end_lineno])

ref_p1=extract(sys.argv[1],'_d97gs_apply_p1_selector_bridge')
cur_p1=extract(sys.argv[2],'_d97gs_apply_p1_selector_bridge')
print('D97HN_P1_REF_SHA256='+hashlib.sha256(ref_p1).hexdigest())
print('D97HN_P1_CUR_SHA256='+hashlib.sha256(cur_p1).hexdigest())
print('D97HN_P1_BYTE_IDENTICAL='+('PASS' if ref_p1==cur_p1 else 'FAIL'))
if ref_p1!=cur_p1: raise SystemExit('P1 bytes differ')

s=Path(sys.argv[2]).read_text(); tree=ast.parse(s)
names=[n.name for n in ast.walk(tree) if isinstance(n,ast.FunctionDef)]
required_funcs=['_d97gs_apply_p1_selector_bridge','_d97hi_apply_p3_serialized_bitcode_bridge']
for n in required_funcs:
    print(f'D97HN_FUNCTION_COUNT={names.count(n)}::{n}')
    if names.count(n)!=1: raise SystemExit(f'{n} count={names.count(n)}')

required={
 'p1_pre_sha':'31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5',
 'p1_post_sha':'a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43',
 'p1_pre':'81fe19790000','p1_post':'81fe177d0000','p1_offset':'offset = 0x3494',
 'p3_pre_sha':'ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269',
 'p3_post_sha':'0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90',
 'p3_pre':'81e100002000','p3_post':'81c900002000','p3_offset':'offset = 0xA1573',
 'p1_hook':'self._d97gs_apply_p1_selector_bridge()',
 'p3_hook':'self._d97hi_apply_p3_serialized_bitcode_bridge()',
}
for k,v in required.items():
    c=s.count(v); print(f'D97HN_TOKEN_COUNT={c}::{k}')
    if c!=1: raise SystemExit(f'{k} count={c}')
i1=s.index(required['p1_hook']); i3=s.index(required['p3_hook']); iw=s.index('if self.constants.wxpython_variant is True',i3)
if not (i1<i3<iw): raise SystemExit('hook order fail')
print('D97HN_HOOK_ORDER=PASS_P1_THEN_P3_THEN_CONTINUATION')
print('D97HN_SOURCE_CONTRACT=STATIC_STRUCTURAL_SEMANTIC_PROVEN')
PY

echo "D97HN_P1_POST_SHA256=$EXPECTED_P1_SERVICE_POST_SHA"
echo "D97HN_P3_POST_SHA256=$EXPECTED_P3_COMPILER_POST_SHA"
echo "D97HN_P2B_REPLAY=NO"
echo "D97HN_AIR00_REPLAY=NO"
echo "D97HN_D34_REPLAY=NO"

printf '\n===== INNER APP IDENTITY =====\n'
/usr/bin/codesign --verify --deep --strict "$APP" || fail APP_CODESIGN_FAIL
EXE="$APP/Contents/MacOS/OpenCore-Patcher"
[[ -f "$EXE" ]] || fail APP_EXECUTABLE_MISSING
ARCH="$(/usr/bin/lipo -archs "$EXE")"
EXE_SHA="$(sha256 "$EXE")"
echo "D97HN_INNER_ARCH=$ARCH"
echo "D97HN_INNER_EXECUTABLE_SHA256=$EXE_SHA"
[[ "$ARCH" == x86_64 ]] || fail APP_ARCH_NOT_X86_64
[[ "$EXE_SHA" == "$EXPECTED_INNER_SHA" ]] || fail APP_EXECUTABLE_SHA_MISMATCH
/usr/bin/codesign -d --entitlements :- "$APP" > "$TMP/inner_entitlements.plist" 2>/dev/null || true
/usr/bin/otool -L "$EXE" > "$TMP/inner_otool_L.txt" 2>&1 || true
/usr/bin/file "$EXE" > "$TMP/inner_file.txt" 2>&1 || true
echo "D97HN_INNER_APP=PASS"

printf '\n===== ZIP IDENTITY =====\n'
ZIP_SHA="$(sha256 "$ZIP")"
ZIP_BYTES="$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97HN_ZIP_SHA256=$ZIP_SHA"
echo "D97HN_ZIP_BYTES=$ZIP_BYTES"
[[ "$ZIP_SHA" == "$EXPECTED_ZIP_SHA" ]] || fail ZIP_SHA_MISMATCH
[[ "$ZIP_BYTES" == "$EXPECTED_ZIP_BYTES" ]] || fail ZIP_BYTES_MISMATCH
/usr/bin/ditto -x -k "$ZIP" "$EXTRACT"
EX_APP="$EXTRACT/OpenCore-Patcher-Tahoe-D97HI-INNER.app"
[[ -d "$EX_APP" ]] || fail EXTRACTED_APP_MISSING
/usr/bin/codesign --verify --deep --strict "$EX_APP" || fail EXTRACTED_CODESIGN_FAIL
EX_EXE="$EX_APP/Contents/MacOS/OpenCore-Patcher"
EX_SHA="$(sha256 "$EX_EXE")"
EX_ARCH="$(/usr/bin/lipo -archs "$EX_EXE")"
echo "D97HN_EXTRACTED_INNER_SHA256=$EX_SHA"
echo "D97HN_EXTRACTED_INNER_ARCH=$EX_ARCH"
[[ "$EX_SHA" == "$EXPECTED_INNER_SHA" ]] || fail EXTRACTED_EXE_SHA_MISMATCH
[[ "$EX_ARCH" == x86_64 ]] || fail EXTRACTED_ARCH_MISMATCH

printf '\n===== APP VS ZIP FILE MANIFEST =====\n'
"$VENV_PY" - "$APP" "$EX_APP" "$TMP/app_manifest.tsv" "$TMP/zip_manifest.tsv" <<'PY'
from pathlib import Path
import hashlib, os, sys

def inventory(root,out):
    root=Path(root); rows=[]
    for p in sorted(root.rglob('*'), key=lambda x:str(x.relative_to(root))):
        rel=str(p.relative_to(root))
        if p.is_symlink():
            rows.append((rel,'L',os.readlink(p)))
        elif p.is_file():
            h=hashlib.sha256(p.read_bytes()).hexdigest()
            rows.append((rel,'F',str(p.stat().st_size),h))
        elif p.is_dir():
            rows.append((rel,'D'))
    Path(out).write_text('\n'.join('\t'.join(r) for r in rows)+'\n')
    return rows

a=inventory(sys.argv[1],sys.argv[3]); b=inventory(sys.argv[2],sys.argv[4])
print('D97HN_APP_MANIFEST_ROWS='+str(len(a)))
print('D97HN_ZIP_MANIFEST_ROWS='+str(len(b)))
print('D97HN_APP_ZIP_CONTENT_MANIFEST_IDENTICAL='+('PASS' if a==b else 'FAIL'))
if a!=b:
    sa=set(a); sb=set(b)
    print('D97HN_ONLY_APP_COUNT='+str(len(sa-sb)))
    print('D97HN_ONLY_ZIP_COUNT='+str(len(sb-sa)))
    raise SystemExit('app/zip manifest mismatch')
PY

echo "D97HN_ZIP_CONTENT=PASS_EXACT_APP_MANIFEST"

printf '\n===== PACKAGE AUDIT EVIDENCE =====\n'
EVID="$TMP/D97HN_EVIDENCE"
/bin/mkdir -p "$EVID"
/bin/cp "$REPORT" "$EVID/" 2>/dev/null || true
/bin/cp "$CUR_DIFF" "$EVID/D97HI_SOURCE.patch"
/bin/cp "$REF_DIFF" "$EVID/D97GS_REFERENCE.patch"
/bin/cp "$TMP/app_manifest.tsv" "$EVID/"
/bin/cp "$TMP/zip_manifest.tsv" "$EVID/"
/bin/cp "$TMP/inner_file.txt" "$EVID/" 2>/dev/null || true
/bin/cp "$TMP/inner_otool_L.txt" "$EVID/" 2>/dev/null || true
/bin/cp "$TMP/inner_entitlements.plist" "$EVID/" 2>/dev/null || true
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$EVID" "$AUDIT_ZIP"
AUDIT_SHA="$(sha256 "$AUDIT_ZIP")"
AUDIT_BYTES="$(/usr/bin/stat -f '%z' "$AUDIT_ZIP")"

echo "D97HN_AUDIT_ZIP=$AUDIT_ZIP"
echo "D97HN_AUDIT_ZIP_SHA256=$AUDIT_SHA"
echo "D97HN_AUDIT_ZIP_BYTES=$AUDIT_BYTES"

echo "D97HN_STATUS=PASS_INDEPENDENT_INNER_AUDIT"
echo "D97HN_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN"
echo "D97HN_TRANSFER_TO_ASUS2=NOT_YET"
echo "D97HN_NEXT=WRAPPER_ASSEMBLY_PLAN_AFTER_REVIEW"
echo "D97HN_REBOOT=NO"
echo "D97HN_REPORT=$REPORT"
