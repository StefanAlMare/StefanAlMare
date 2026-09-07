#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GT — read-only audit of Intel-iMac D97DX source-base drift.
# Diagnoses why current git diff no longer matches the exact audited D97DX diff.
# NO source mutation. NO git reset/checkout/apply. NO build. NO Root Patch. NO reboot.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
EXPECTED_D97DX_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_D97DX_ZIP_SHA="2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a"
STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GT_D97DX_SOURCE_DRIFT_AUDIT_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97GT_D97DX_SOURCE_DRIFT_AUDIT_${STAMP}.zip"
REPORT="$OUT/D97GT_REPORT.txt"
CURRENT_DIFF="$OUT/current_git_diff.patch"
EXPECTED_PATCH="$OUT/expected_D97DX_SOURCE.patch"
mkdir -p "$OUT/per_file"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
fail(){ echo "D97GT_STATUS=FAIL"; echo "D97GT_REASON=$*"; exit 1; }

cat <<'HDR'
===== OCLP7 D97GT — READ-ONLY D97DX SOURCE DRIFT AUDIT =====
SOURCE_MUTATION=NO
GIT_RESET=NO
GIT_CHECKOUT=NO
GIT_APPLY=NO
BUILD=NO
ROOT_PATCH=NO
SYSTEM_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -d "$WORK/.git" ]] || fail WORKTREE_MISSING
cd "$WORK"

echo
echo "===== REPOSITORY IDENTITY ====="
HEAD_SHA="$(git rev-parse HEAD)"
echo "D97GT_HEAD=$HEAD_SHA"
[[ "$HEAD_SHA" == "$GOLDEN_COMMIT" ]] || fail HEAD_DRIFT

git status --porcelain=v1 > "$OUT/git_status_porcelain.txt"
echo "----- git status --porcelain -----"
/bin/cat "$OUT/git_status_porcelain.txt"

git diff --name-only | sort > "$OUT/current_changed_files.txt"
echo "----- tracked changed files -----"
/bin/cat "$OUT/current_changed_files.txt"

EXPECTED_FILES="$OUT/expected_changed_files.txt"
printf '%s\n' \
  OpenCore-Patcher-GUI.spec \
  opencore_legacy_patcher/support/metallib_handler.py \
  opencore_legacy_patcher/sys_patch/patchsets/detect.py \
  opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py \
  | sort > "$EXPECTED_FILES"

if /usr/bin/cmp -s "$EXPECTED_FILES" "$OUT/current_changed_files.txt"; then
  echo "D97GT_CHANGED_FILE_SET=EXACT_D97DX_FOUR"
else
  echo "D97GT_CHANGED_FILE_SET=DRIFT"
  echo "----- changed-file-set delta -----"
  /usr/bin/diff -u "$EXPECTED_FILES" "$OUT/current_changed_files.txt" || true
fi

echo
echo "===== CURRENT DIFF IDENTITY ====="
git diff > "$CURRENT_DIFF"
CURRENT_SHA="$(sha256 "$CURRENT_DIFF")"
echo "D97GT_CURRENT_DIFF_SHA256=$CURRENT_SHA"
echo "D97GT_EXPECTED_D97DX_DIFF_SHA256=$EXPECTED_D97DX_DIFF_SHA"
if [[ "$CURRENT_SHA" == "$EXPECTED_D97DX_DIFF_SHA" ]]; then
  echo "D97GT_CURRENT_DIFF_MATCHES_EXPECTED=PASS"
else
  echo "D97GT_CURRENT_DIFF_MATCHES_EXPECTED=NO"
fi

echo
echo "===== LOCATE EXACT D97DX EXPECTED PATCH ====="
FOUND_EXPECTED=0
# Prefer an already-extracted exact D97DX app resource if present.
for P in \
  "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.app/Contents/Resources/OCLP7_D97DX_SOURCE.patch" \
  "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97DX.app/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
do
  if [[ -f "$P" ]]; then
    H="$(sha256 "$P")"
    echo "D97GT_CANDIDATE_PATCH=$P"
    echo "D97GT_CANDIDATE_PATCH_SHA256=$H"
    if [[ "$H" == "$EXPECTED_D97DX_DIFF_SHA" ]]; then
      /bin/cp "$P" "$EXPECTED_PATCH"
      FOUND_EXPECTED=1
      echo "D97GT_EXPECTED_PATCH_SOURCE=$P"
      break
    fi
  fi
done

# If not found, extract only from exact audited D97DX ZIP into a temp directory.
TMP="/private/tmp/OCLP7_D97GT_D97DX_$$"
trap '/bin/rm -rf "$TMP" 2>/dev/null || true' EXIT
if [[ "$FOUND_EXPECTED" -eq 0 ]]; then
  for Z in "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.zip" "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97DX.zip"; do
    if [[ -f "$Z" ]]; then
      ZH="$(sha256 "$Z")"
      echo "D97GT_CANDIDATE_ZIP=$Z"
      echo "D97GT_CANDIDATE_ZIP_SHA256=$ZH"
      if [[ "$ZH" == "$EXPECTED_D97DX_ZIP_SHA" ]]; then
        /bin/rm -rf "$TMP"; /bin/mkdir -p "$TMP"
        /usr/bin/ditto -x -k "$Z" "$TMP"
        P="$TMP/OpenCore-Patcher-Tahoe-D97DX.app/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
        [[ -f "$P" ]] || fail EXACT_D97DX_ZIP_MISSING_EMBEDDED_PATCH
        PH="$(sha256 "$P")"
        echo "D97GT_EXTRACTED_PATCH_SHA256=$PH"
        [[ "$PH" == "$EXPECTED_D97DX_DIFF_SHA" ]] || fail EXTRACTED_EXPECTED_PATCH_SHA_MISMATCH
        /bin/cp "$P" "$EXPECTED_PATCH"
        FOUND_EXPECTED=1
        echo "D97GT_EXPECTED_PATCH_SOURCE=$Z::embedded"
        break
      fi
    fi
  done
fi

if [[ "$FOUND_EXPECTED" -eq 1 ]]; then
  echo "D97GT_EXPECTED_PATCH_FOUND=YES"
  echo "D97GT_EXPECTED_PATCH_SHA256=$(sha256 "$EXPECTED_PATCH")"
else
  echo "D97GT_EXPECTED_PATCH_FOUND=NO"
fi

echo
echo "===== PER-FILE CURRENT DIFF / CONTENT IDENTITY ====="
while IFS= read -r F; do
  [[ -n "$F" ]] || continue
  SAFE="$(printf '%s' "$F" | /usr/bin/tr '/ ' '__')"
  git diff -- "$F" > "$OUT/per_file/${SAFE}.current.patch"
  echo "FILE=$F"
  if [[ -f "$F" ]]; then
    echo "  CURRENT_FILE_SHA256=$(sha256 "$F")"
  else
    echo "  CURRENT_FILE_SHA256=MISSING"
  fi
  git show "HEAD:$F" > "$OUT/per_file/${SAFE}.head" 2>/dev/null || true
  if [[ -f "$OUT/per_file/${SAFE}.head" ]]; then
    echo "  HEAD_FILE_SHA256=$(sha256 "$OUT/per_file/${SAFE}.head")"
  fi
  echo "  CURRENT_PER_FILE_DIFF_SHA256=$(sha256 "$OUT/per_file/${SAFE}.current.patch")"
  git diff --numstat -- "$F" | /usr/bin/awk '{print "  NUMSTAT_ADD="$1" DEL="$2}' || true
done < "$OUT/current_changed_files.txt"

if [[ "$FOUND_EXPECTED" -eq 1 ]]; then
  echo
echo "===== EXPECTED-vs-CURRENT PATCH DELTA ====="
  set +e
  /usr/bin/diff -u "$EXPECTED_PATCH" "$CURRENT_DIFF" > "$OUT/expected_vs_current_diff.txt"
  DRC=$?
  set -e
  echo "D97GT_EXPECTED_VS_CURRENT_DIFF_RC=$DRC"
  echo "D97GT_EXPECTED_VS_CURRENT_DELTA_LINES=$(/usr/bin/wc -l < "$OUT/expected_vs_current_diff.txt" | /usr/bin/tr -d ' ')"
  echo "----- first 240 delta lines -----"
  /usr/bin/head -n 240 "$OUT/expected_vs_current_diff.txt" || true

  /usr/bin/python3 - "$EXPECTED_PATCH" "$CURRENT_DIFF" "$OUT/section_compare.tsv" <<'PY'
from pathlib import Path
import re,sys,hashlib
exp=Path(sys.argv[1]).read_text(errors='replace')
cur=Path(sys.argv[2]).read_text(errors='replace')
out=Path(sys.argv[3])

def sections(txt):
    # split by git diff file header, preserving each section verbatim
    starts=[m.start() for m in re.finditer(r'(?m)^diff --git a/',txt)]
    d={}
    for i,s in enumerate(starts):
        e=starts[i+1] if i+1<len(starts) else len(txt)
        sec=txt[s:e]
        m=re.match(r'diff --git a/(.*?) b/(.*?)\n',sec)
        if m:
            d[m.group(2)]=sec
    return d
E=sections(exp); C=sections(cur)
files=sorted(set(E)|set(C))
with out.open('w') as f:
    f.write('FILE\tEXPECTED_PRESENT\tCURRENT_PRESENT\tEXPECTED_SECTION_SHA256\tCURRENT_SECTION_SHA256\tMATCH\n')
    for fn in files:
        es=E.get(fn); cs=C.get(fn)
        eh=hashlib.sha256(es.encode()).hexdigest() if es is not None else ''
        ch=hashlib.sha256(cs.encode()).hexdigest() if cs is not None else ''
        match='YES' if es is not None and cs is not None and es==cs else 'NO'
        f.write(f'{fn}\t{es is not None}\t{cs is not None}\t{eh}\t{ch}\t{match}\n')
print('D97GT_SECTION_COMPARE_FILES='+str(len(files)))
for line in out.read_text().splitlines()[1:]:
    print('D97GT_SECTION='+line)
PY
  echo "----- section compare -----"
  /bin/cat "$OUT/section_compare.tsv"
fi

echo
echo "===== PACKAGE ====="
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
echo "D97GT_ZIP=$ZIP"
echo "D97GT_ZIP_SHA256=$(sha256 "$ZIP")"
echo "D97GT_ZIP_BYTES=$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97GT_STATUS=PASS_READONLY_AUDIT"
echo "D97GT_BUILD=NO"
echo "D97GT_SOURCE_MUTATION=NO"
echo "D97GT_REBOOT=NO"
