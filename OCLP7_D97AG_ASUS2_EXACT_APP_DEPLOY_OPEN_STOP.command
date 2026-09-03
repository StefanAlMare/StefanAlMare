#!/bin/zsh -f
set -euo pipefail

VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip"
D97AG_ZIP_BYTES="751494420"
D97AG_ZIP_SHA256="d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846"
D97AG_EXE_BYTES="6596544"
D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"
D97AF_EXE_BYTES="6595600"
D97AF_EXE_SHA256="ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470"
MIN_FREE_KB="4194304"

STAMP="$(/bin/date +%Y%m%d-%H%M%S)"
REPORT="$HOME/Desktop/OCLP7_D97AG_EXACT_APP_DEPLOY_OPEN_STOP_REPORT_$STAMP.txt"
TEMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AG_DEPLOY.XXXXXX)"
EXTRACT_ROOT="$TEMP_ROOT/extracted"
LIVE_APP="/Applications/OpenCore-Patcher.app"
LIVE_EXE="$LIVE_APP/Contents/MacOS/OpenCore-Patcher"
BACKUP_APP="/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-$STAMP"
BACKUP_EXE="$BACKUP_APP/Contents/MacOS/OpenCore-Patcher"
NEW_APP="/Applications/OpenCore-Patcher.app.D97AG-deploying-$STAMP"
NEW_EXE="$NEW_APP/Contents/MacOS/OpenCore-Patcher"
FAILED_APP="/Applications/OpenCore-Patcher.app.D97AG-failed-$STAMP"
INSTALLED_APP_MUTATION_STATE="NO"

cleanup_temp() {
  if [[ "$TEMP_ROOT" == /private/tmp/OCLP7_D97AG_DEPLOY.* && -d "$TEMP_ROOT" && ! -L "$TEMP_ROOT" ]]; then
    /bin/rm -rf "$TEMP_ROOT"
  fi
}

sha256_file() {
  /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

exact_live_pids() {
  /bin/ps -axo pid=,command= | /usr/bin/awk -v target="$LIVE_EXE" '$2 == target {print $1}'
}

finish() {
  local exit_rc=$?
  trap - EXIT HUP INT TERM
  set +e
  if (( exit_rc != 0 )); then
    echo "D97AG_DEPLOY_EXIT_RECOVERY_BEGIN=STATE:$INSTALLED_APP_MUTATION_STATE|RC:$exit_rc"
    case "$INSTALLED_APP_MUTATION_STATE" in
      NO)
        echo "D97AG_DEPLOY_EXIT_RECOVERY=NOT_REQUIRED_NO_APPLICATION_MUTATION"
        ;;
      NEW_APP_READY)
        if [[ "$NEW_APP" == /Applications/OpenCore-Patcher.app.D97AG-deploying-* && ( -e "$NEW_APP" || -L "$NEW_APP" ) ]]; then
          /usr/bin/sudo -n /bin/rm -rf "$NEW_APP"
          echo "D97AG_DEPLOY_EXIT_RECOVERY_STAGING_REMOVE_RC=$?"
        fi
        echo "D97AG_DEPLOY_EXIT_RECOVERY=LIVE_D97AF_SHOULD_REMAIN_UNCHANGED"
        ;;
      LIVE_MOVED_TO_BACKUP|D97AG_DEPLOYED_PENDING_AUDIT|D97AG_DEPLOYED_PENDING_OPEN)
        local live_pids
        live_pids="$(exact_live_pids 2>/dev/null || true)"
        if [[ -n "$live_pids" ]]; then
          for pid in ${(f)live_pids}; do
            /bin/kill -TERM "$pid" 2>/dev/null || true
          done
          /bin/sleep 1
        fi
        if [[ -e "$LIVE_APP" || -L "$LIVE_APP" ]]; then
          if [[ ! -e "$FAILED_APP" && ! -L "$FAILED_APP" ]]; then
            /usr/bin/sudo -n /bin/mv "$LIVE_APP" "$FAILED_APP"
            echo "D97AG_DEPLOY_EXIT_RECOVERY_QUARANTINE_RC=$?"
          else
            echo "D97AG_DEPLOY_EXIT_RECOVERY_QUARANTINE=SKIPPED_FAILED_PATH_EXISTS"
          fi
        fi
        if [[ -d "$BACKUP_APP" && ! -L "$BACKUP_APP" && ! -e "$LIVE_APP" && ! -L "$LIVE_APP" ]]; then
          /usr/bin/sudo -n /bin/mv "$BACKUP_APP" "$LIVE_APP"
          local restore_rc=$?
          echo "D97AG_DEPLOY_EXIT_RECOVERY_RESTORE_MOVE_RC=$restore_rc"
          if (( restore_rc == 0 )) && [[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" ]]; then
            local restored_sha restored_bytes
            restored_sha="$(sha256_file "$LIVE_EXE" 2>/dev/null || true)"
            restored_bytes="$(/usr/bin/stat -f '%z' "$LIVE_EXE" 2>/dev/null || true)"
            echo "D97AG_DEPLOY_EXIT_RECOVERY_RESTORED_BYTES=$restored_bytes"
            echo "D97AG_DEPLOY_EXIT_RECOVERY_RESTORED_SHA256=$restored_sha"
            if [[ "$restored_sha" == "$D97AF_EXE_SHA256" && "$restored_bytes" == "$D97AF_EXE_BYTES" ]]; then
              INSTALLED_APP_MUTATION_STATE="D97AF_RESTORED_EXACT"
              echo "D97AG_DEPLOY_EXIT_RECOVERY=PASS_D97AF_RESTORED_EXACT"
            else
              echo "D97AG_DEPLOY_EXIT_RECOVERY=FAIL_RESTORED_IDENTITY"
            fi
          fi
        else
          echo "D97AG_DEPLOY_EXIT_RECOVERY=FAIL_BACKUP_OR_LIVE_PATH_STATE"
        fi
        if [[ "$NEW_APP" == /Applications/OpenCore-Patcher.app.D97AG-deploying-* && ( -e "$NEW_APP" || -L "$NEW_APP" ) ]]; then
          /usr/bin/sudo -n /bin/rm -rf "$NEW_APP"
          echo "D97AG_DEPLOY_EXIT_RECOVERY_STAGING_REMOVE_RC=$?"
        fi
        ;;
      D97AG_DEPLOYED_EXACT_OPENED)
        echo "D97AG_DEPLOY_EXIT_RECOVERY=NOT_REQUIRED_EXACT_D97AG_LIVE_BACKUP_RETAINED"
        ;;
      *)
        echo "D97AG_DEPLOY_EXIT_RECOVERY=UNKNOWN_STATE:$INSTALLED_APP_MUTATION_STATE"
        ;;
    esac
    echo "D97AG_DEPLOY_EXIT_RECOVERY_FINAL_STATE=$INSTALLED_APP_MUTATION_STATE"
  fi
  cleanup_temp
  exit "$exit_rc"
}

trap finish EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

exec > >(/usr/bin/tee "$REPORT") 2>&1

fail() {
  echo "D97AG_EXACT_APP_DEPLOY_OPEN_STOP=FAIL_CLOSED|REASON=$*"
  echo "INSTALLED_APP_MUTATION_STATE=$INSTALLED_APP_MUTATION_STATE"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_TARGET_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AG — EXACT ASUS2 APP DEPLOY / OPEN / STOP ====="
echo "PURPOSE=verify_local_D97AG_zip_backup_exact_D97AF_deploy_exact_D97AG_open_STOP"
echo "VERIFIED_ZIP=$VERIFIED_ZIP"
echo "D97AG_ZIP_SHA256_EXPECTED=$D97AG_ZIP_SHA256"
echo "D97AG_EXE_SHA256_EXPECTED=$D97AG_EXE_SHA256"
echo "D97AF_LIVE_EXE_SHA256_EXPECTED=$D97AF_EXE_SHA256"
echo "BACKUP_APP=$BACKUP_APP"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for tool_path in \
  /usr/bin/awk \
  /usr/bin/ditto \
  /usr/bin/file \
  /usr/bin/find \
  /usr/bin/id \
  /usr/bin/lipo \
  /usr/bin/mktemp \
  /usr/bin/open \
  /usr/bin/plutil \
  /usr/bin/shasum \
  /usr/bin/stat \
  /usr/bin/tee \
  /bin/date \
  /bin/df \
  /bin/kill \
  /bin/mkdir \
  /bin/mv \
  /bin/ps \
  /bin/rm \
  /bin/sleep \
  /usr/bin/sudo; do
  [[ -x "$tool_path" ]] || fail "MISSING_ABSOLUTE_TOOL:$tool_path"
done

TEMP_IDENTITY="$(/usr/bin/stat -f '%u:%Lp:%l' "$TEMP_ROOT")"
echo "PRIVATE_TEMP_IDENTITY=$TEMP_IDENTITY"
[[ "$TEMP_IDENTITY" == "$(/usr/bin/id -u):700:2" ]] || fail "PRIVATE_TEMP_IDENTITY_INVALID:$TEMP_IDENTITY"

FREE_KB="$(/bin/df -Pk /Applications | /usr/bin/awk 'NR==2 {print $4}')"
echo "APPLICATION_VOLUME_FREE_KB=$FREE_KB"
[[ "$FREE_KB" == <-> ]] || fail "FREE_SPACE_PARSE_FAIL:$FREE_KB"
(( FREE_KB >= MIN_FREE_KB )) || fail "INSUFFICIENT_FREE_SPACE_KB:$FREE_KB"

[[ -f "$VERIFIED_ZIP" && ! -L "$VERIFIED_ZIP" ]] || fail "VERIFIED_ZIP_MISSING_OR_SYMLINK"
ZIP_BYTES_ACTUAL="$(/usr/bin/stat -f '%z' "$VERIFIED_ZIP")"
ZIP_SHA_ACTUAL="$(sha256_file "$VERIFIED_ZIP")"
echo "VERIFIED_ZIP_BYTES_ACTUAL=$ZIP_BYTES_ACTUAL"
echo "VERIFIED_ZIP_SHA256_ACTUAL=$ZIP_SHA_ACTUAL"
[[ "$ZIP_BYTES_ACTUAL" == "$D97AG_ZIP_BYTES" ]] || fail "VERIFIED_ZIP_BYTES_MISMATCH:$ZIP_BYTES_ACTUAL"
[[ "$ZIP_SHA_ACTUAL" == "$D97AG_ZIP_SHA256" ]] || fail "VERIFIED_ZIP_SHA_MISMATCH:$ZIP_SHA_ACTUAL"

echo "===== EXTRACT / VERIFY D97AG STAGE ====="
/bin/mkdir -p "$EXTRACT_ROOT"
/usr/bin/ditto -x -k "$VERIFIED_ZIP" "$EXTRACT_ROOT" || fail "D97AG_ZIP_EXTRACTION_FAIL"
STAGED_APPS=("${(@f)$(/usr/bin/find "$EXTRACT_ROOT" -type d -name 'OpenCore-Patcher.app' -prune -print)}")
(( ${#STAGED_APPS[@]} == 1 )) || fail "STAGED_APP_CARDINALITY:${#STAGED_APPS[@]}"
STAGED_APP="$STAGED_APPS[1]"
STAGED_EXE="$STAGED_APP/Contents/MacOS/OpenCore-Patcher"
[[ -d "$STAGED_APP" && ! -L "$STAGED_APP" ]] || fail "STAGED_APP_INVALID"
[[ -f "$STAGED_EXE" && ! -L "$STAGED_EXE" && -x "$STAGED_EXE" ]] || fail "STAGED_EXE_INVALID"
[[ -f "$STAGED_APP/Contents/Info.plist" && ! -L "$STAGED_APP/Contents/Info.plist" ]] || fail "STAGED_INFO_PLIST_INVALID_PATH"
/usr/bin/plutil -lint "$STAGED_APP/Contents/Info.plist" >/dev/null || fail "STAGED_INFO_PLIST_LINT_FAIL"
STAGED_BYTES="$(/usr/bin/stat -f '%z' "$STAGED_EXE")"
STAGED_SHA="$(sha256_file "$STAGED_EXE")"
STAGED_ARCH="$(/usr/bin/lipo -archs "$STAGED_EXE")"
STAGED_FILE="$(/usr/bin/file "$STAGED_EXE")"
echo "STAGED_APP=$STAGED_APP"
echo "STAGED_EXE_BYTES=$STAGED_BYTES"
echo "STAGED_EXE_SHA256=$STAGED_SHA"
echo "STAGED_EXE_ARCHS=$STAGED_ARCH"
echo "STAGED_EXE_FILE=$STAGED_FILE"
[[ "$STAGED_BYTES" == "$D97AG_EXE_BYTES" ]] || fail "STAGED_D97AG_BYTES_MISMATCH:$STAGED_BYTES"
[[ "$STAGED_SHA" == "$D97AG_EXE_SHA256" ]] || fail "STAGED_D97AG_SHA_MISMATCH:$STAGED_SHA"
[[ "$STAGED_ARCH" == "x86_64" ]] || fail "STAGED_D97AG_ARCH_MISMATCH:$STAGED_ARCH"
[[ "$STAGED_FILE" == *"Mach-O 64-bit executable x86_64"* ]] || fail "STAGED_D97AG_FILE_MISMATCH:$STAGED_FILE"
echo "D97AG_STAGED_APP_IDENTITY=PASS"

echo "===== VERIFY EXACT LIVE D97AF PREIMAGE ====="
[[ -d "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_D97AF_APP_MISSING_OR_SYMLINK"
[[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" && -x "$LIVE_EXE" ]] || fail "LIVE_D97AF_EXE_INVALID"
LIVE_PRE_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
LIVE_PRE_SHA="$(sha256_file "$LIVE_EXE")"
LIVE_PRE_ARCH="$(/usr/bin/lipo -archs "$LIVE_EXE")"
echo "LIVE_PRE_BYTES=$LIVE_PRE_BYTES"
echo "LIVE_PRE_SHA256=$LIVE_PRE_SHA"
echo "LIVE_PRE_ARCHS=$LIVE_PRE_ARCH"
[[ "$LIVE_PRE_BYTES" == "$D97AF_EXE_BYTES" ]] || fail "LIVE_D97AF_BYTES_MISMATCH:$LIVE_PRE_BYTES"
[[ "$LIVE_PRE_SHA" == "$D97AF_EXE_SHA256" ]] || fail "LIVE_D97AF_SHA_MISMATCH:$LIVE_PRE_SHA"
[[ "$LIVE_PRE_ARCH" == "x86_64" ]] || fail "LIVE_D97AF_ARCH_MISMATCH:$LIVE_PRE_ARCH"
[[ ! -e "$BACKUP_APP" && ! -L "$BACKUP_APP" ]] || fail "BACKUP_PATH_ALREADY_EXISTS:$BACKUP_APP"
[[ ! -e "$NEW_APP" && ! -L "$NEW_APP" ]] || fail "NEW_APP_PATH_ALREADY_EXISTS:$NEW_APP"
[[ ! -e "$FAILED_APP" && ! -L "$FAILED_APP" ]] || fail "FAILED_APP_PATH_ALREADY_EXISTS:$FAILED_APP"
echo "D97AF_LIVE_PREIMAGE=PASS"

echo "===== SUDO GATE / PREPARE EXACT D97AG BESIDE LIVE ====="
/usr/bin/sudo -v || fail "SUDO_AUTH_FAILED"
/usr/bin/sudo /usr/bin/ditto "$STAGED_APP" "$NEW_APP" || fail "NEW_APP_COPY_FAIL"
INSTALLED_APP_MUTATION_STATE="NEW_APP_READY"
[[ -d "$NEW_APP" && ! -L "$NEW_APP" ]] || fail "NEW_APP_INVALID"
[[ -f "$NEW_EXE" && ! -L "$NEW_EXE" && -x "$NEW_EXE" ]] || fail "NEW_EXE_INVALID"
NEW_BYTES="$(/usr/bin/stat -f '%z' "$NEW_EXE")"
NEW_SHA="$(sha256_file "$NEW_EXE")"
NEW_ARCH="$(/usr/bin/lipo -archs "$NEW_EXE")"
echo "NEW_EXE_BYTES=$NEW_BYTES"
echo "NEW_EXE_SHA256=$NEW_SHA"
echo "NEW_EXE_ARCHS=$NEW_ARCH"
[[ "$NEW_BYTES" == "$D97AG_EXE_BYTES" ]] || fail "NEW_D97AG_BYTES_MISMATCH:$NEW_BYTES"
[[ "$NEW_SHA" == "$D97AG_EXE_SHA256" ]] || fail "NEW_D97AG_SHA_MISMATCH:$NEW_SHA"
[[ "$NEW_ARCH" == "x86_64" ]] || fail "NEW_D97AG_ARCH_MISMATCH:$NEW_ARCH"
echo "D97AG_NEW_APP_READY_EXACT=PASS"

echo "===== DRAIN ONLY EXACT LIVE OCLP PATH ====="
PRE_DRAIN_PIDS="$(exact_live_pids)"
echo "PRE_DRAIN_EXACT_PIDS=${PRE_DRAIN_PIDS:-NONE}"
if [[ -n "$PRE_DRAIN_PIDS" ]]; then
  for pid in ${(f)PRE_DRAIN_PIDS}; do
    /bin/kill -TERM "$pid" 2>/dev/null || true
  done
  for _ in {1..20}; do
    [[ -z "$(exact_live_pids)" ]] && break
    /bin/sleep 0.25
  done
  REMAINING_PIDS="$(exact_live_pids)"
  if [[ -n "$REMAINING_PIDS" ]]; then
    echo "D97AG_DEPLOY_FORCE_KILL_EXACT_PIDS=$REMAINING_PIDS"
    for pid in ${(f)REMAINING_PIDS}; do
      /bin/kill -KILL "$pid" 2>/dev/null || true
    done
    /bin/sleep 0.5
  fi
fi
POST_DRAIN_PIDS="$(exact_live_pids)"
echo "POST_DRAIN_EXACT_PIDS=${POST_DRAIN_PIDS:-NONE}"
[[ -z "$POST_DRAIN_PIDS" ]] || fail "EXACT_LIVE_PROCESS_DRAIN_FAIL:$POST_DRAIN_PIDS"
echo "D97AF_EXACT_PATH_PROCESS_DRAIN=PASS"

echo "===== SWITCH D97AF -> D97AG ====="
/usr/bin/sudo /bin/mv "$LIVE_APP" "$BACKUP_APP" || fail "MOVE_D97AF_TO_BACKUP_FAIL"
INSTALLED_APP_MUTATION_STATE="LIVE_MOVED_TO_BACKUP"
[[ -d "$BACKUP_APP" && ! -L "$BACKUP_APP" ]] || fail "BACKUP_APP_INVALID_AFTER_MOVE"
[[ -f "$BACKUP_EXE" && ! -L "$BACKUP_EXE" ]] || fail "BACKUP_EXE_INVALID_AFTER_MOVE"
BACKUP_BYTES="$(/usr/bin/stat -f '%z' "$BACKUP_EXE")"
BACKUP_SHA="$(sha256_file "$BACKUP_EXE")"
echo "BACKUP_EXE_BYTES=$BACKUP_BYTES"
echo "BACKUP_EXE_SHA256=$BACKUP_SHA"
[[ "$BACKUP_BYTES" == "$D97AF_EXE_BYTES" ]] || fail "BACKUP_D97AF_BYTES_MISMATCH:$BACKUP_BYTES"
[[ "$BACKUP_SHA" == "$D97AF_EXE_SHA256" ]] || fail "BACKUP_D97AF_SHA_MISMATCH:$BACKUP_SHA"
[[ ! -e "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_PATH_NOT_EMPTY_AFTER_BACKUP_MOVE"

/usr/bin/sudo /bin/mv "$NEW_APP" "$LIVE_APP" || fail "MOVE_D97AG_TO_LIVE_FAIL"
INSTALLED_APP_MUTATION_STATE="D97AG_DEPLOYED_PENDING_AUDIT"
[[ -d "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_D97AG_APP_INVALID"
[[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" && -x "$LIVE_EXE" ]] || fail "LIVE_D97AG_EXE_INVALID"
LIVE_POST_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
LIVE_POST_SHA="$(sha256_file "$LIVE_EXE")"
LIVE_POST_ARCH="$(/usr/bin/lipo -archs "$LIVE_EXE")"
LIVE_POST_FILE="$(/usr/bin/file "$LIVE_EXE")"
echo "LIVE_POST_BYTES=$LIVE_POST_BYTES"
echo "LIVE_POST_SHA256=$LIVE_POST_SHA"
echo "LIVE_POST_ARCHS=$LIVE_POST_ARCH"
echo "LIVE_POST_FILE=$LIVE_POST_FILE"
[[ "$LIVE_POST_BYTES" == "$D97AG_EXE_BYTES" ]] || fail "LIVE_D97AG_BYTES_MISMATCH:$LIVE_POST_BYTES"
[[ "$LIVE_POST_SHA" == "$D97AG_EXE_SHA256" ]] || fail "LIVE_D97AG_SHA_MISMATCH:$LIVE_POST_SHA"
[[ "$LIVE_POST_ARCH" == "x86_64" ]] || fail "LIVE_D97AG_ARCH_MISMATCH:$LIVE_POST_ARCH"
[[ "$LIVE_POST_FILE" == *"Mach-O 64-bit executable x86_64"* ]] || fail "LIVE_D97AG_FILE_MISMATCH:$LIVE_POST_FILE"
echo "D97AG_LIVE_APP_IDENTITY=PASS"

INSTALLED_APP_MUTATION_STATE="D97AG_DEPLOYED_PENDING_OPEN"
echo "===== OPEN EXACT D97AG OCLP / PROVE FRESH PATH ====="
PRE_OPEN_PIDS="$(exact_live_pids)"
echo "PRE_OPEN_EXACT_PIDS=${PRE_OPEN_PIDS:-NONE}"
[[ -z "$PRE_OPEN_PIDS" ]] || fail "UNEXPECTED_EXACT_PROCESS_BEFORE_OPEN:$PRE_OPEN_PIDS"
/usr/bin/open "$LIVE_APP" || fail "OPEN_D97AG_APP_FAIL"
FRESH_PIDS=""
for _ in {1..40}; do
  FRESH_PIDS="$(exact_live_pids)"
  [[ -n "$FRESH_PIDS" ]] && break
  /bin/sleep 0.25
done
echo "FRESH_D97AG_EXACT_PIDS=${FRESH_PIDS:-NONE}"
[[ -n "$FRESH_PIDS" ]] || fail "FRESH_D97AG_EXACT_PROCESS_NOT_PROVEN"

FINAL_LIVE_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
FINAL_LIVE_SHA="$(sha256_file "$LIVE_EXE")"
echo "FINAL_LIVE_EXE_BYTES=$FINAL_LIVE_BYTES"
echo "FINAL_LIVE_EXE_SHA256=$FINAL_LIVE_SHA"
[[ "$FINAL_LIVE_BYTES" == "$D97AG_EXE_BYTES" ]] || fail "FINAL_LIVE_D97AG_BYTES_MISMATCH"
[[ "$FINAL_LIVE_SHA" == "$D97AG_EXE_SHA256" ]] || fail "FINAL_LIVE_D97AG_SHA_MISMATCH"

INSTALLED_APP_MUTATION_STATE="D97AG_DEPLOYED_EXACT_OPENED"
echo "D97AG_EXACT_APP_DEPLOY_OPEN_STOP=PASS"
echo "INSTALLED_APP_MUTATION_STATE=$INSTALLED_APP_MUTATION_STATE"
echo "D97AF_BACKUP_RETAINED=$BACKUP_APP"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=OCLP_OPEN_DO_NOT_CLICK_ROOT_PATCH_RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$REPORT"
