#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GU — prepare Intel-iMac D97DX worktree for D97GS by removing only the
# exact tracked DEBUG helper build artifact left behind by D97DX.
# Deterministic, fail-closed. No global reset/checkout. No build. No Root Patch.

GOLDEN_COMMIT="b9df76ebdf3e768b37c1cc980e8444aa837c623e"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
DEBUG_HELPER_REL="ci_tooling/privileged_helper_tool/com.dortania.opencore-legacy-patcher.privileged-helper"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_HEAD_HELPER_SHA="772d2246825f9f1c471007b1b9bf151e20cac8522911e3cb4705524543be55be"
EXPECTED_D97DX_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"

STAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP="$HOME/Desktop/OCLP7_D97GU_DEBUG_HELPER_BACKUP_${STAMP}"
REPORT="$HOME/Desktop/OCLP7_D97GU_PREPARE_D97DX_BASE_${STAMP}.txt"
TMP_DIFF="/private/tmp/OCLP7_D97GU_D97DX_SOURCE_$$.patch"

cleanup(){ /bin/rm -f "$TMP_DIFF" 2>/dev/null || true; }
trap cleanup EXIT
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
fail(){ echo "D97GU_STATUS=FAIL"; echo "D97GU_REASON=$*"; exit 1; }

cat <<'HDR'
===== OCLP7 D97GU — DETERMINISTIC D97DX SOURCE-BASE PREPARATION =====
BUILD_HOST=INTEL_IMAC_ONLY
GLOBAL_GIT_RESET=NO
GLOBAL_GIT_CHECKOUT=NO
SOURCE_PATCH_MUTATION=NO
BUILD=NO
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
REBOOT=NO
ONLY_TRACKED_BUILD_ARTIFACT_RESTORED=DEBUG_HELPER
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -d "$WORK/.git" ]] || fail WORKTREE_MISSING
cd "$WORK"
[[ "$(git rev-parse HEAD)" == "$GOLDEN_COMMIT" ]] || fail HEAD_DRIFT

DEBUG_HELPER="$WORK/$DEBUG_HELPER_REL"
[[ -f "$DEBUG_HELPER" ]] || fail DEBUG_HELPER_MISSING

CURRENT_HELPER_SHA="$(sha256 "$DEBUG_HELPER")"
echo "D97GU_CURRENT_DEBUG_HELPER_SHA256=$CURRENT_HELPER_SHA"
[[ "$CURRENT_HELPER_SHA" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail DEBUG_HELPER_NOT_EXACT_D97DX_BUILD_ARTIFACT

# Verify the four audited D97DX source sections are exact before touching the build artifact.
SOURCE_FILES=(
  "OpenCore-Patcher-GUI.spec"
  "opencore_legacy_patcher/support/metallib_handler.py"
  "opencore_legacy_patcher/sys_patch/patchsets/detect.py"
  "opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py"
)

git diff -- "${SOURCE_FILES[@]}" > "$TMP_DIFF"
SOURCE_DIFF_SHA="$(sha256 "$TMP_DIFF")"
echo "D97GU_SOURCE_ONLY_DIFF_SHA256_BEFORE=$SOURCE_DIFF_SHA"
[[ "$SOURCE_DIFF_SHA" == "$EXPECTED_D97DX_DIFF_SHA" ]] || fail FOUR_SOURCE_DIFF_NOT_EXACT_D97DX

# Verify no tracked drift exists besides the four audited sources + exact DEBUG helper.
EXPECTED_TRACKED="$(printf '%s\n' "${SOURCE_FILES[@]}" "$DEBUG_HELPER_REL" | sort)"
ACTUAL_TRACKED="$(git diff --name-only | sort)"
echo "----- tracked changes before -----"
printf '%s\n' "$ACTUAL_TRACKED"
[[ "$ACTUAL_TRACKED" == "$EXPECTED_TRACKED" ]] || fail UNEXPECTED_TRACKED_DRIFT

# Preserve the exact DEBUG helper build artifact outside the worktree before restoring only this path.
/bin/cp "$DEBUG_HELPER" "$BACKUP"
[[ "$(sha256 "$BACKUP")" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail BACKUP_SHA_MISMATCH
echo "D97GU_DEBUG_HELPER_BACKUP=$BACKUP"
echo "D97GU_DEBUG_HELPER_BACKUP_SHA256=$(sha256 "$BACKUP")"

# Restore exactly one tracked path from HEAD. No other path is touched.
/usr/bin/git checkout HEAD -- "$DEBUG_HELPER_REL"

RESTORED_SHA="$(sha256 "$DEBUG_HELPER")"
echo "D97GU_RESTORED_HEAD_HELPER_SHA256=$RESTORED_SHA"
[[ "$RESTORED_SHA" == "$EXPECTED_HEAD_HELPER_SHA" ]] || fail RESTORED_HEAD_HELPER_SHA_MISMATCH

# Final closure: tracked changes are now exactly the four D97DX source files and their diff is exact.
ACTUAL_AFTER="$(git diff --name-only | sort)"
EXPECTED_AFTER="$(printf '%s\n' "${SOURCE_FILES[@]}" | sort)"
echo "----- tracked changes after -----"
printf '%s\n' "$ACTUAL_AFTER"
[[ "$ACTUAL_AFTER" == "$EXPECTED_AFTER" ]] || fail TRACKED_SET_AFTER_NOT_EXACT_D97DX_FOUR

git diff -- "${SOURCE_FILES[@]}" > "$TMP_DIFF"
FINAL_SOURCE_DIFF_SHA="$(sha256 "$TMP_DIFF")"
echo "D97GU_SOURCE_ONLY_DIFF_SHA256_AFTER=$FINAL_SOURCE_DIFF_SHA"
[[ "$FINAL_SOURCE_DIFF_SHA" == "$EXPECTED_D97DX_DIFF_SHA" ]] || fail FINAL_D97DX_SOURCE_DIFF_MISMATCH

git diff --quiet -- opencore_legacy_patcher/sys_patch/sys_patch.py || fail SYS_PATCH_NOT_PRISTINE

echo "D97GU_D97DX_SOURCE_BASE=EXACT_RESTORED"
echo "D97GU_ONLY_BUILD_ARTIFACT_CLEANED=PASS"
echo "D97GU_STATUS=PASS"
echo "D97GU_NEXT=RERUN_D97GS_UNCHANGED"
echo "D97GU_REPORT=$REPORT"
