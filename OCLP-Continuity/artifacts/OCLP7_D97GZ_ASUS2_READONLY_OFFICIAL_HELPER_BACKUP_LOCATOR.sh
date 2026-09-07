#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GZ — read-only locator for exact official OCLP privileged-helper backup.
# NO helper replacement. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_DEBUG_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_OFFICIAL_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"
EXPECTED_D97GS_ZIP_SHA="e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266"
EXPECTED_LAUNCHER_SHA="344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c"

ACTIVE="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GZ_HELPER_BACKUP_LOCATOR_${STAMP}"
REPORT="$OUT/D97GZ_REPORT.txt"
EXTRACT="$OUT/extracted"
STRINGS_OUT="$OUT/launcher_strings.txt"
RELEVANT_OUT="$OUT/launcher_relevant_strings.txt"
CANDIDATES="$OUT/candidates.tsv"
mkdir -p "$OUT" "$EXTRACT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
fail(){ echo "D97GZ_STATUS=FAIL"; echo "D97GZ_REASON=$*"; echo "D97GZ_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97GZ — READ-ONLY OFFICIAL HELPER BACKUP LOCATOR =====
HELPER_REPLACEMENT=NO
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

printf '\n===== ACTIVE HELPER =====\n'
[[ -f "$ACTIVE" ]] || fail ACTIVE_HELPER_MISSING
ACTIVE_SHA="$(sha256 "$ACTIVE")"
echo "D97GZ_ACTIVE_HELPER_SHA256=$ACTIVE_SHA"
[[ "$ACTIVE_SHA" == "$EXPECTED_DEBUG_SHA" ]] || fail ACTIVE_HELPER_NOT_EXACT_DEBUG_IDENTITY
/usr/bin/codesign --verify --strict "$ACTIVE" || fail ACTIVE_DEBUG_CODESIGN_VERIFY_FAIL
ACTIVE_TEAM="$(/usr/bin/codesign -dv --verbose=4 "$ACTIVE" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true)"
echo "D97GZ_ACTIVE_HELPER_TEAM=${ACTIVE_TEAM:-NOT_SET}"
echo "D97GZ_ACTIVE_DEBUG_HELPER=PROVEN"

printf '\n===== EXACT D97GS ZIP / D97DX-DERIVED LAUNCHER =====\n'
GS_ZIP=""
for C in "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97GS.zip" "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97GS.zip"; do
  if [[ -f "$C" ]]; then
    H="$(sha256 "$C")"
    echo "D97GZ_ZIP_CANDIDATE=$C::$H"
    if [[ "$H" == "$EXPECTED_D97GS_ZIP_SHA" ]]; then GS_ZIP="$C"; break; fi
  fi
done
[[ -n "$GS_ZIP" ]] || fail EXACT_D97GS_ZIP_NOT_FOUND
/usr/bin/ditto -x -k "$GS_ZIP" "$EXTRACT"
APP="$EXTRACT/OpenCore-Patcher-Tahoe-D97GS.app"
[[ -d "$APP" ]] || fail EXTRACTED_D97GS_APP_MISSING
LAUNCHER_NAME="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$APP/Contents/Info.plist" 2>/dev/null || true)"
[[ -n "$LAUNCHER_NAME" ]] || fail LAUNCHER_NAME_MISSING
LAUNCHER="$APP/Contents/MacOS/$LAUNCHER_NAME"
[[ -f "$LAUNCHER" ]] || fail LAUNCHER_MISSING
LAUNCHER_SHA="$(sha256 "$LAUNCHER")"
echo "D97GZ_LAUNCHER=$LAUNCHER"
echo "D97GZ_LAUNCHER_SHA256=$LAUNCHER_SHA"
[[ "$LAUNCHER_SHA" == "$EXPECTED_LAUNCHER_SHA" ]] || fail LAUNCHER_SHA_MISMATCH
/usr/bin/file "$LAUNCHER" | tee "$OUT/launcher_file.txt"

# Capture text/strings from exact launcher. This is read-only reverse inspection.
if /usr/bin/grep -Iq . "$LAUNCHER" 2>/dev/null; then
  /bin/cat "$LAUNCHER" > "$STRINGS_OUT"
  echo "D97GZ_LAUNCHER_TEXT_MODE=YES"
else
  /usr/bin/strings -a "$LAUNCHER" > "$STRINGS_OUT"
  echo "D97GZ_LAUNCHER_TEXT_MODE=NO"
fi
/usr/bin/grep -Ei 'PrivilegedHelperTools|privileged-helper|helper|backup|restore|private/tmp|/tmp|mktemp|cp |mv |ditto|trap|EXIT' "$STRINGS_OUT" > "$RELEVANT_OUT" || true
echo "----- relevant exact-launcher strings -----"
/bin/cat "$RELEVANT_OUT" || true

printf '\n===== EXACT-SHA BACKUP CANDIDATE SEARCH =====\n'
printf 'PATH\tSHA256\tTEAM\tSTATUS\n' > "$CANDIDATES"
FOUND=0
CHECKED=0

check_file() {
  F="$1"
  [[ -f "$F" ]] || return 0
  CHECKED=$((CHECKED+1))
  H="$(sha256 "$F" 2>/dev/null || true)"
  [[ -n "$H" ]] || return 0
  if [[ "$H" == "$EXPECTED_OFFICIAL_SHA" ]]; then
    TEAM="$(/usr/bin/codesign -dv --verbose=4 "$F" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}' || true)"
    STATUS="OFFICIAL_SHA_MATCH"
    if [[ "$TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]]; then STATUS="OFFICIAL_SHA_AND_TEAM_PASS"; fi
    printf '%s\t%s\t%s\t%s\n' "$F" "$H" "${TEAM:-NOT_SET}" "$STATUS" | tee -a "$CANDIDATES"
    FOUND=$((FOUND+1))
  fi
}

# First inspect exact absolute paths surfaced by launcher strings.
/usr/bin/python3 - "$RELEVANT_OUT" "$OUT/launcher_absolute_paths.txt" <<'PY'
from pathlib import Path
import re,sys
s=Path(sys.argv[1]).read_text(errors='replace') if Path(sys.argv[1]).exists() else ''
# Conservative extraction of slash-starting path-like tokens; variables may remain unresolved and are retained for evidence.
paths=[]
for m in re.finditer(r'(?<![A-Za-z0-9_])(/[^\s"\'\`;<>()]+)', s):
    p=m.group(1).rstrip(',:')
    if p not in paths: paths.append(p)
Path(sys.argv[2]).write_text('\n'.join(paths)+('\n' if paths else ''))
for p in paths: print('D97GZ_LAUNCHER_PATH_TOKEN='+p)
PY
while IFS= read -r P; do
  case "$P" in
    *'$'*|*'{'*|*'}'*) ;;
    *) check_file "$P" ;;
  esac
done < "$OUT/launcher_absolute_paths.txt"

# Then search likely persistence locations, but only helper/backup/OCLP/Dortania-named files.
ROOTS=("/private/tmp" "$HOME/Desktop" "$HOME/Downloads" "$HOME/Library/Application Support" "/Users/Shared" "/Library/Application Support")
for R in "${ROOTS[@]}"; do
  [[ -d "$R" ]] || continue
  while IFS= read -r F; do check_file "$F"; done < <(
    /usr/bin/find "$R" -maxdepth 6 -type f \
      \( -iname '*helper*' -o -iname '*backup*' -o -iname '*oclp*' -o -iname '*dortania*' \) \
      -size -8M -print 2>/dev/null | /usr/bin/sort -u
  )
done

# /private/tmp is normally small; additionally inspect every regular file <=8 MiB there to catch randomized backup names.
if [[ -d /private/tmp ]]; then
  while IFS= read -r F; do check_file "$F"; done < <(/usr/bin/find /private/tmp -maxdepth 4 -type f -size -8M -print 2>/dev/null | /usr/bin/sort -u)
fi

echo "D97GZ_CANDIDATE_FILES_CHECKED=$CHECKED"
echo "D97GZ_OFFICIAL_SHA_MATCH_COUNT=$FOUND"

if [[ "$FOUND" -gt 0 ]]; then
  GOOD="$(/usr/bin/awk -F '\t' '$4=="OFFICIAL_SHA_AND_TEAM_PASS"{c++}END{print c+0}' "$CANDIDATES")"
  echo "D97GZ_OFFICIAL_SHA_AND_TEAM_PASS_COUNT=$GOOD"
  if [[ "$GOOD" -gt 0 ]]; then
    echo "D97GZ_OFFICIAL_BACKUP_LOCATED=PASS"
    echo "D97GZ_NEXT=DESIGN_SINGLE_HELPER_RESTORE_FROM_EXACT_BACKUP"
  else
    echo "D97GZ_OFFICIAL_BACKUP_LOCATED=SHA_ONLY_TEAM_NOT_PROVEN"
    echo "D97GZ_NEXT=STOP_AND_REVIEW_CANDIDATE"
  fi
else
  echo "D97GZ_OFFICIAL_BACKUP_LOCATED=NO"
  echo "D97GZ_NEXT=USE_LAUNCHER_EVIDENCE_TO_RESOLVE_BACKUP_OR_OFFICIAL_SOURCE"
fi

echo "D97GZ_STATUS=PASS_READONLY_LOCATOR"
echo "D97GZ_HELPER_REPLACEMENT=NO"
echo "D97GZ_REBOOT=NO"
echo "D97GZ_REPORT=$REPORT"
