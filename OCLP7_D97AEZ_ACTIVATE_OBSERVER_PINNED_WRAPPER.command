#!/bin/zsh -f

# OCLP7 D97AEZ -- pinned VESA-side activation of the passive boot observer.
#
# This login-user wrapper downloads three exact files from one immutable public
# commit, proves their Git identities and local byte identities, proves the
# unchanged D97AEX helper self-test and the live D97AD service/target identities,
# then installs and bootstraps only the passive D97AEZ observer.  The immediate
# same-boot launch must stop before CLAIM and records that no-op in persistent
# launchd output.  Nothing here opens OCLP, performs Root Patch, reboots, or
# launches/stops/controls MTLCompilerService.

emulate -LR zsh
set -euo pipefail
umask 077

if (( $# != 0 )); then
  print -r -- "D97AEZ_ACTIVATION_FATAL=WRAPPER_ARGUMENTS_NOT_ALLOWED"
  exit 2
fi

readonly WRAPPER_NAME="OCLP7_D97AEZ_ACTIVATE_OBSERVER_PINNED_WRAPPER"
readonly REPOSITORY="StefanAlMare/StefanAlMare"
readonly REPOSITORY_URL="https://github.com/${REPOSITORY}.git"

# RELEASE PIN BLOCK -- all placeholders must be replaced from the immutable
# payload commit containing runner/plist/helper.  That payload commit must
# precede the later commit publishing this wrapper, avoiding a self-referential
# commit/tree pin. PIN_SET_STATUS becomes FINAL only after the final CI and
# downloaded-artifact audits pass. The executable fails closed while any pin
# remains a placeholder.
readonly PIN_SET_STATUS="FINAL"
readonly PIN_COMMIT="b30a02fed23cdd75de880c90947f5c985571b53a"
readonly PIN_TREE_EXPECTED="51b4df3c6935dbf818b5269c99a7752d71da2eba"

readonly RUNNER_REPOSITORY_PATH="OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT_RUNNER.command"
readonly RUNNER_PUBLIC_MODE_EXPECTED="100755"
readonly RUNNER_BLOB_EXPECTED="74ab4b67f2d2bfe2e7635b1d4025e488d59c2ad2"
readonly RUNNER_SHA256_EXPECTED="9c2dc2060ea557dfea9ca1901b055f1242ba4e34f5ec29297e6b847997a320a4"
readonly RUNNER_BYTES_EXPECTED="36701"
readonly RUNNER_RUNTIME_MODE_EXPECTED="500"

readonly PLIST_REPOSITORY_PATH="OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT.plist"
readonly PLIST_PUBLIC_MODE_EXPECTED="100644"
readonly PLIST_BLOB_EXPECTED="8ef97872d0a29c28a91c9d1818bf0c5c7492c080"
readonly PLIST_SHA256_EXPECTED="90c0801805319126520cc946d9f2bb4a69e95fd7a0be4a85914a1c3305ec03c5"
readonly PLIST_BYTES_EXPECTED="1027"
readonly PLIST_RUNTIME_MODE_EXPECTED="644"

readonly HELPER_REPOSITORY_PATH="OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER"
readonly HELPER_PUBLIC_MODE_EXPECTED="100755"
readonly HELPER_BLOB_EXPECTED="9f22460e8c1e51a2ae091eb7377e958f6a148e35"
readonly HELPER_SHA256_EXPECTED="f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9"
readonly HELPER_BYTES_EXPECTED="94928"
readonly HELPER_RUNTIME_MODE_EXPECTED="500"
readonly SELFTEST_SHA256_EXPECTED="ba6c489151d595d9217ffdc2d8058798b454a8843d2a594d0477e1ff1cefca95"
readonly SELFTEST_BYTES_EXPECTED="345"
readonly SELFTEST_LINES_EXPECTED="6"

readonly PRODUCT_VERSION_EXPECTED="26.6.2"
readonly BUILD_VERSION_EXPECTED="25G82"
readonly ARCHITECTURE_EXPECTED="x86_64"
readonly LABEL="com.stefanalmare.oclp7.d97aez.boot-bound-one-shot"
readonly INSTALL_DIR="/Library/Application Support/OCLP7-D97AEZ"
readonly STATE_DIR="/var/db/OCLP7-D97AEZ"
readonly STATE_DIR_CANONICAL="/private/var/db/OCLP7-D97AEZ"
readonly RUNNER="$INSTALL_DIR/$RUNNER_REPOSITORY_PATH"
readonly HELPER="$INSTALL_DIR/$HELPER_REPOSITORY_PATH"
readonly PLIST="/Library/LaunchDaemons/${LABEL}.plist"
readonly DEPLOY_RECORD="$STATE_DIR/DEPLOY_RECORD"
readonly LAUNCHD_STDOUT="$STATE_DIR/LAUNCHD_STDOUT.log"
readonly LAUNCHD_STDERR="$STATE_DIR/LAUNCHD_STDERR.log"
readonly CLAIM="$STATE_DIR/CLAIM"
readonly DONE="$STATE_DIR/DONE"
readonly BOOT_REPORT="$STATE_DIR/OCLP7_D97AEZ_BOOT_BOUND_REPORT.partial"
readonly HELPER_OUTPUT="$STATE_DIR/D97AEX_HELPER_OUTPUT.partial"
readonly WATCHDOG_MARKER="$STATE_DIR/WATCHDOG_TIMEOUT"

readonly SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
readonly SERVICE_SHA256_EXPECTED="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
readonly SERVICE_BYTES_EXPECTED="85520"
readonly SERVICE_MODE_EXPECTED="755"
readonly TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
readonly TARGET_SHA256_EXPECTED="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
readonly TARGET_BYTES_EXPECTED="1636896"
readonly TARGET_MODE_EXPECTED="755"

for required_tool in \
  /bin/cat /bin/chmod /bin/date /bin/launchctl /bin/ln /bin/ls /bin/mkdir \
  /bin/rm /bin/rmdir /bin/sleep /bin/sync /bin/test /bin/zsh \
  /usr/bin/chflags /usr/bin/codesign /usr/bin/env /usr/bin/file \
  /usr/bin/git /usr/bin/grep /usr/bin/id /usr/bin/install /usr/bin/mktemp \
  /usr/bin/plutil /usr/bin/shasum /usr/bin/stat /usr/bin/sudo \
  /usr/bin/sw_vers /usr/bin/tr /usr/bin/uname /usr/bin/wc \
  /usr/sbin/chown /usr/sbin/sysctl; do
  if [[ ! -x "$required_tool" ]]; then
    print -r -- "D97AEZ_ACTIVATION_FATAL=REQUIRED_TOOL_MISSING:${required_tool}"
    exit 2
  fi
done

if [[ "$(/usr/bin/id -u)" == "0" ]]; then
  print -r -- "D97AEZ_ACTIVATION_FATAL=WHOLE_WRAPPER_MUST_NOT_RUN_AS_ROOT"
  print -r -- "D97AEZ_PRIVILEGE_CONTRACT=LOGIN_USER_WRAPPER_WITH_BOUNDED_SUDO_INSTALL_ONLY"
  exit 2
fi

if [[ -z "${HOME:-}" || ! -d "$HOME/Desktop" || -L "$HOME/Desktop" ]]; then
  print -r -- "D97AEZ_ACTIVATION_FATAL=SAFE_DESKTOP_DIRECTORY_UNAVAILABLE"
  exit 2
fi

TMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AEZ_ACTIVATE.XXXXXX)"
if [[ "$TMP_ROOT" != /private/tmp/OCLP7_D97AEZ_ACTIVATE.* || \
      ! -d "$TMP_ROOT" || -L "$TMP_ROOT" ]]; then
  print -r -- "D97AEZ_ACTIVATION_FATAL=PRIVATE_TEMP_DIRECTORY_INVALID"
  exit 2
fi
/bin/chmod 0700 "$TMP_ROOT"
if [[ "$(/usr/bin/stat -f '%u:%Lp' "$TMP_ROOT")" != "$(/usr/bin/id -u):700" ]]; then
  print -r -- "D97AEZ_ACTIVATION_FATAL=PRIVATE_TEMP_DIRECTORY_IDENTITY_INVALID"
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi

REPORT="$(/usr/bin/mktemp "$HOME/Desktop/OCLP7_D97AEZ_ACTIVATE_OBSERVER_PINNED_WRAPPER_REPORT.txt.XXXXXX")"
if [[ ! -f "$REPORT" || -L "$REPORT" || \
      "$(/usr/bin/stat -f '%u:%l' "$REPORT")" != "$(/usr/bin/id -u):1" ]]; then
  print -r -- "D97AEZ_ACTIVATION_FATAL=SAFE_DESKTOP_REPORT_CREATE_FAILED"
  /bin/rm -rf "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi
/bin/chmod 0600 "$REPORT"
if [[ "$(/usr/bin/stat -f '%Lp' "$REPORT")" != "600" ]]; then
  print -r -- "D97AEZ_ACTIVATION_FATAL=SAFE_DESKTOP_REPORT_MODE_FAILED"
  /bin/rm -f "$REPORT" 2>/dev/null || true
  /bin/rm -rf "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi

FETCH_REPOSITORY="$TMP_ROOT/repository.git"
FETCH_OUTPUT="$TMP_ROOT/git-fetch.txt"
STAGED_RUNNER="$TMP_ROOT/$RUNNER_REPOSITORY_PATH"
STAGED_PLIST="$TMP_ROOT/$PLIST_REPOSITORY_PATH"
STAGED_HELPER="$TMP_ROOT/$HELPER_REPOSITORY_PATH"
STAGED_DEPLOY_RECORD="$TMP_ROOT/DEPLOY_RECORD"
SELFTEST_OUTPUT="$TMP_ROOT/helper-self-test.txt"
LAUNCH_PRINT_OUTPUT="$TMP_ROOT/launchctl-print.txt"
LAUNCH_DISABLED_OUTPUT="$TMP_ROOT/launchctl-print-disabled.txt"
LAUNCHD_STDOUT_COPY="$TMP_ROOT/launchd-stdout.txt"
typeset -gi OBSERVER_SYSTEM_CONTROL_BEGUN=0

cleanup() {
  local saved_rc=$?
  trap - EXIT
  exec 3>&- 2>/dev/null || true
  if [[ -n "${TMP_ROOT:-}" && "$TMP_ROOT" == /private/tmp/OCLP7_D97AEZ_ACTIVATE.* && \
        -d "$TMP_ROOT" && ! -L "$TMP_ROOT" ]]; then
    /bin/rm -rf "$TMP_ROOT" 2>/dev/null || true
  fi
  exit "$saved_rc"
}

trap cleanup EXIT
trap 'print -r -- "D97AEZ_ACTIVATION_INTERRUPTED=HUP"; exit 129' HUP
trap 'print -r -- "D97AEZ_ACTIVATION_INTERRUPTED=INT"; exit 130' INT
trap 'print -r -- "D97AEZ_ACTIVATION_INTERRUPTED=TERM"; exit 143' TERM

exec 3>> "$REPORT"

report_io_stop() {
  trap '' HUP INT TERM PIPE
  print -u2 -r -- "D97AEZ_ACTIVATION_FATAL=DESKTOP_REPORT_WRITE_FAILED"
  if (( OBSERVER_SYSTEM_CONTROL_BEGUN == 1 )); then
    /usr/bin/sudo /bin/launchctl bootout "system/$LABEL" >/dev/null 2>&1 || true
    /usr/bin/sudo /bin/launchctl disable "system/$LABEL" >/dev/null 2>&1 || true
  fi
  exec 3>&- 2>/dev/null || true
  exit 2
}

emit() {
  print -r -- "$*" || true
  print -r -- "$*" >&3 || report_io_stop
}

emit_file() {
  local source_file="$1" source_line
  [[ -f "$source_file" && ! -L "$source_file" ]] || return 1
  while IFS= read -r source_line || [[ -n "$source_line" ]]; do
    emit "$source_line"
  done < "$source_file"
}

fail() {
  local failure_reason="$*"
  if (( OBSERVER_SYSTEM_CONTROL_BEGUN == 1 )); then
    emit "OBSERVER_FAIL_CLOSED_DEACTIVATION_BEGIN=YES"
    if /usr/bin/sudo /bin/launchctl bootout "system/$LABEL" >/dev/null 2>&1; then
      emit "OBSERVER_FAIL_CLOSED_BOOTOUT=PASS"
    else
      emit "OBSERVER_FAIL_CLOSED_BOOTOUT=NOT_LOADED_OR_FAILED"
    fi
    if /usr/bin/sudo /bin/launchctl disable "system/$LABEL" >/dev/null 2>&1; then
      emit "OBSERVER_FAIL_CLOSED_DISABLE=PASS"
    else
      emit "OBSERVER_FAIL_CLOSED_DISABLE=FAIL"
    fi
    OBSERVER_SYSTEM_CONTROL_BEGUN=0
  fi
  emit "D97AEZ_ACTIVATION_RESULT=FAIL_CLOSED"
  emit "D97AEZ_ACTIVATION_FAILURE=$failure_reason"
  emit "OCLP_APP_CONTROL=AUTO-NO"
  emit "ROOT_PATCH=AUTO-NO"
  emit "REBOOT=AUTO-NO"
  emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
  emit "SERVICE_LAUNCH=AUTO-NO"
  emit "SERVICE_STOP=AUTO-NO"
  emit "REPORT=$REPORT"
  exit 2
}

activation_interrupt() {
  local signal_name="$1" signal_rc="$2"
  trap - HUP INT TERM
  emit "D97AEZ_ACTIVATION_INTERRUPTED=$signal_name"
  fail "INTERRUPTED_${signal_name}_RC_${signal_rc}"
}

trap 'activation_interrupt HUP 129' HUP
trap 'activation_interrupt INT 130' INT
trap 'activation_interrupt TERM 143' TERM

sha256_file() {
  local identity_file="$1"
  local sha_line
  sha_line="$(/usr/bin/shasum -a 256 "$identity_file")" || return 1
  print -r -- "${sha_line%% *}"
}

clean_git() {
  /usr/bin/env -i PATH=/usr/bin:/bin:/usr/sbin:/sbin LANG=C LC_ALL=C \
    GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null \
    GIT_DEFAULT_HASH=sha1 GIT_TERMINAL_PROMPT=0 /usr/bin/git "$@"
}

pin_format_gate() {
  [[ "$PIN_SET_STATUS" == "FINAL" ]] || return 1
  print -r -- "$PIN_COMMIT" | /usr/bin/grep -Eq '^[0-9a-f]{40}$' || return 1
  print -r -- "$PIN_TREE_EXPECTED" | /usr/bin/grep -Eq '^[0-9a-f]{40}$' || return 1
  print -r -- "$RUNNER_BLOB_EXPECTED" | /usr/bin/grep -Eq '^[0-9a-f]{40}$' || return 1
  print -r -- "$RUNNER_SHA256_EXPECTED" | /usr/bin/grep -Eq '^[0-9a-f]{64}$' || return 1
  print -r -- "$RUNNER_BYTES_EXPECTED" | /usr/bin/grep -Eq '^[1-9][0-9]*$' || return 1
  print -r -- "$PLIST_BLOB_EXPECTED" | /usr/bin/grep -Eq '^[0-9a-f]{40}$' || return 1
  print -r -- "$PLIST_SHA256_EXPECTED" | /usr/bin/grep -Eq '^[0-9a-f]{64}$' || return 1
  print -r -- "$PLIST_BYTES_EXPECTED" | /usr/bin/grep -Eq '^[1-9][0-9]*$' || return 1
  return 0
}

tree_entry_gate() {
  local entry_label="$1" repository_file="$2" expected_mode="$3" expected_blob="$4"
  local actual_entry expected_entry
  actual_entry="$(clean_git --git-dir="$FETCH_REPOSITORY" ls-tree "$PIN_COMMIT" -- "$repository_file")" || return 1
  expected_entry="${expected_mode} blob ${expected_blob}"$'\t'"${repository_file}"
  emit "${entry_label}_PINNED_TREE_ENTRY=$actual_entry"
  [[ "$actual_entry" == "$expected_entry" ]] || return 1
  return 0
}

staged_identity_gate() {
  local stage_label="$1" staged_file="$2" expected_blob="$3"
  local expected_sha="$4" expected_bytes="$5" expected_mode="$6"
  local stat_before stat_after actual_blob actual_sha actual_bytes actual_mode
  [[ -f "$staged_file" && ! -L "$staged_file" ]] || return 1
  [[ "$(/usr/bin/stat -f '%l' "$staged_file")" == "1" ]] || return 1
  stat_before="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$staged_file")" || return 1
  actual_blob="$(clean_git hash-object --no-filters "$staged_file")" || return 1
  actual_sha="$(sha256_file "$staged_file")" || return 1
  stat_after="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$staged_file")" || return 1
  actual_bytes="$(/usr/bin/stat -f '%z' "$staged_file")" || return 1
  actual_mode="$(/usr/bin/stat -f '%Lp' "$staged_file")" || return 1
  emit "${stage_label}_STAT_BEFORE=$stat_before"
  emit "${stage_label}_BLOB=$actual_blob"
  emit "${stage_label}_SHA256=$actual_sha"
  emit "${stage_label}_BYTES=$actual_bytes"
  emit "${stage_label}_MODE=$actual_mode"
  emit "${stage_label}_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" || "$actual_blob" != "$expected_blob" || \
        "$actual_sha" != "$expected_sha" || "$actual_bytes" != "$expected_bytes" || \
        "$actual_mode" != "$expected_mode" ]]; then
    emit "${stage_label}_IDENTITY=FAIL"
    return 1
  fi
  emit "${stage_label}_IDENTITY=PASS"
  return 0
}

live_identity_gate() {
  local live_label="$1" live_file="$2" expected_sha="$3"
  local expected_bytes="$4" expected_mode="$5"
  local stat_before stat_after actual_sha actual_bytes actual_mode
  [[ -f "$live_file" && ! -L "$live_file" ]] || return 1
  stat_before="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$live_file")" || return 1
  actual_sha="$(sha256_file "$live_file")" || return 1
  stat_after="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$live_file")" || return 1
  actual_bytes="$(/usr/bin/stat -f '%z' "$live_file")" || return 1
  actual_mode="$(/usr/bin/stat -f '%Lp' "$live_file")" || return 1
  emit "LIVE_${live_label}_STAT_BEFORE=$stat_before"
  emit "LIVE_${live_label}_SHA256=$actual_sha"
  emit "LIVE_${live_label}_BYTES=$actual_bytes"
  emit "LIVE_${live_label}_MODE=$actual_mode"
  emit "LIVE_${live_label}_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" || \
        "$(/usr/bin/stat -f '%u:%g:%l' "$live_file")" != "0:0:1" || \
        "$actual_sha" != "$expected_sha" || "$actual_bytes" != "$expected_bytes" || \
        "$actual_mode" != "$expected_mode" ]]; then
    emit "LIVE_${live_label}_IDENTITY=FAIL"
    return 1
  fi
  emit "LIVE_${live_label}_IDENTITY=PASS"
  return 0
}

safe_root_parent_gate() {
  local parent_dir="$1"
  local parent_uid parent_mode parent_listing parent_first_line parent_permissions
  [[ -d "$parent_dir" && ! -L "$parent_dir" ]] || return 1
  parent_uid="$(/usr/bin/stat -f '%u' "$parent_dir")" || return 1
  parent_mode="$(/usr/bin/stat -f '%Lp' "$parent_dir")" || return 1
  [[ "$parent_mode" =~ '^[0-7]{3,4}$' ]] || return 1
  (( (8#$parent_mode & 8#022) == 0 )) || return 1
  parent_listing="$(/bin/ls -lde "$parent_dir")" || return 1
  parent_first_line="${parent_listing%%$'\n'*}"
  parent_permissions="${parent_first_line%%[[:space:]]*}"
  emit "SAFE_PARENT_IDENTITY=$parent_dir|UID=$parent_uid|MODE=$parent_mode|PERMISSIONS=$parent_permissions"
  [[ "$parent_uid" == "0" && "$parent_permissions" != *+* ]]
}

root_directory_gate() {
  local directory_label="$1" directory_name="$2"
  local directory_identity
  /usr/bin/sudo /bin/test -d "$directory_name" || return 1
  if /usr/bin/sudo /bin/test -L "$directory_name"; then
    return 1
  fi
  directory_identity="$(/usr/bin/sudo /usr/bin/stat -f 'DEV=%d|INO=%i|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$directory_name")" || return 1
  emit "ROOT_${directory_label}_IDENTITY=$directory_identity"
  [[ "$(/usr/bin/sudo /usr/bin/stat -f '%u:%g:%Lp' "$directory_name")" == "0:0:700" ]] || return 1
  return 0
}

root_file_identity_gate() {
  local root_label="$1" root_file="$2" expected_blob="$3"
  local expected_sha="$4" expected_bytes="$5" expected_mode="$6"
  local stat_before stat_after actual_blob actual_sha actual_bytes actual_mode
  /usr/bin/sudo /bin/test -f "$root_file" || return 1
  if /usr/bin/sudo /bin/test -L "$root_file"; then
    return 1
  fi
  stat_before="$(/usr/bin/sudo /usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$root_file")" || return 1
  actual_blob="$(/usr/bin/sudo /usr/bin/env -i PATH=/usr/bin:/bin:/usr/sbin:/sbin \
    LANG=C LC_ALL=C GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null \
    GIT_DEFAULT_HASH=sha1 /usr/bin/git hash-object --no-filters "$root_file")" || return 1
  actual_sha="$(/usr/bin/sudo /usr/bin/shasum -a 256 "$root_file")" || return 1
  actual_sha="${actual_sha%% *}"
  stat_after="$(/usr/bin/sudo /usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$root_file")" || return 1
  actual_bytes="$(/usr/bin/sudo /usr/bin/stat -f '%z' "$root_file")" || return 1
  actual_mode="$(/usr/bin/sudo /usr/bin/stat -f '%Lp' "$root_file")" || return 1
  emit "ROOT_${root_label}_STAT_BEFORE=$stat_before"
  emit "ROOT_${root_label}_BLOB=$actual_blob"
  emit "ROOT_${root_label}_SHA256=$actual_sha"
  emit "ROOT_${root_label}_BYTES=$actual_bytes"
  emit "ROOT_${root_label}_MODE=$actual_mode"
  emit "ROOT_${root_label}_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" || \
        "$(/usr/bin/sudo /usr/bin/stat -f '%u:%g:%l' "$root_file")" != "0:0:1" || \
        "$actual_blob" != "$expected_blob" || "$actual_sha" != "$expected_sha" || \
        "$actual_bytes" != "$expected_bytes" || "$actual_mode" != "$expected_mode" ]]; then
    emit "ROOT_${root_label}_IDENTITY=FAIL"
    return 1
  fi
  emit "ROOT_${root_label}_IDENTITY=PASS"
  return 0
}

root_log_gate() {
  local log_label="$1" log_file="$2"
  local log_identity
  /usr/bin/sudo /bin/test -f "$log_file" || return 1
  if /usr/bin/sudo /bin/test -L "$log_file"; then
    return 1
  fi
  log_identity="$(/usr/bin/sudo /usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$log_file")" || return 1
  emit "${log_label}_IDENTITY=$log_identity"
  [[ "$(/usr/bin/sudo /usr/bin/stat -f '%u:%g:%Lp:%l' "$log_file")" == "0:0:600:1" ]]
}

emit "===== OCLP7 D97AEZ -- PINNED PASSIVE OBSERVER ACTIVATION ====="
emit "WRAPPER=$WRAPPER_NAME"
emit "PURPOSE=pinned_VESA_side_install_bootstrap_and_same_boot_noop_proof"
emit "REPOSITORY=$REPOSITORY"
emit "PIN_SET_STATUS=$PIN_SET_STATUS"
emit "PIN_COMMIT=$PIN_COMMIT"
emit "PIN_TREE_EXPECTED=$PIN_TREE_EXPECTED"
emit "ARCHITECTURE_CONTRACT=INTEL_X86_64_ONLY"
emit "ACTIVATION_LANE_DECLARED=VESA_BY_USER_OPERATION"
emit "ACTIVATION_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
emit "OBSERVER_LAUNCHD_CONTROL=ENABLE_AND_BOOTSTRAP_ONLY"
emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
emit "SERVICE_LAUNCH=AUTO-NO"
emit "SERVICE_STOP=AUTO-NO"
emit "OCLP_APP_CONTROL=AUTO-NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "GOLDEN_MUTATION=NO"
emit "REPORT=$REPORT"

pin_format_gate || fail "RELEASE_PIN_BLOCK_NOT_FINALIZED"
emit "RELEASE_PIN_FORMATS=PASS"

PRODUCT_VERSION_ACTUAL="$(/usr/bin/sw_vers -productVersion)" || fail "PRODUCT_VERSION_QUERY_FAILED"
BUILD_VERSION_ACTUAL="$(/usr/bin/sw_vers -buildVersion)" || fail "BUILD_VERSION_QUERY_FAILED"
ARCHITECTURE_ACTUAL="$(/usr/bin/uname -m)" || fail "ARCHITECTURE_QUERY_FAILED"
emit "PRODUCT_VERSION_ACTUAL=$PRODUCT_VERSION_ACTUAL"
emit "BUILD_VERSION_ACTUAL=$BUILD_VERSION_ACTUAL"
emit "ARCHITECTURE_ACTUAL=$ARCHITECTURE_ACTUAL"
if [[ "$PRODUCT_VERSION_ACTUAL" != "$PRODUCT_VERSION_EXPECTED" || \
      "$BUILD_VERSION_ACTUAL" != "$BUILD_VERSION_EXPECTED" || \
      "$ARCHITECTURE_ACTUAL" != "$ARCHITECTURE_EXPECTED" ]]; then
  fail "OS_BUILD_ARCH_IDENTITY_MISMATCH"
fi
emit "OS_BUILD_ARCH_IDENTITY=PASS"

safe_root_parent_gate "/Library/Application Support" || fail "INSTALL_PARENT_IDENTITY_FAILED"
safe_root_parent_gate "/Library/LaunchDaemons" || fail "LAUNCHDAEMONS_PARENT_IDENTITY_FAILED"
safe_root_parent_gate "/private/var/db" || fail "STATE_PARENT_IDENTITY_FAILED"

emit "PINNED_GIT_FETCH_BEGIN=YES"
if clean_git init --bare "$FETCH_REPOSITORY" > "$FETCH_OUTPUT" 2>&1 && \
   clean_git --git-dir="$FETCH_REPOSITORY" fetch --no-tags --depth=1 \
     "$REPOSITORY_URL" "$PIN_COMMIT" >> "$FETCH_OUTPUT" 2>&1; then
  FETCH_RC=0
else
  FETCH_RC=$?
fi
emit_file "$FETCH_OUTPUT" || fail "PINNED_GIT_FETCH_OUTPUT_READ_FAILED"
emit "PINNED_GIT_FETCH_RC=$FETCH_RC"
(( FETCH_RC == 0 )) || fail "PINNED_GIT_FETCH_FAILED"

FETCHED_COMMIT="$(clean_git --git-dir="$FETCH_REPOSITORY" rev-parse FETCH_HEAD)" || fail "FETCH_HEAD_QUERY_FAILED"
FETCHED_TREE="$(clean_git --git-dir="$FETCH_REPOSITORY" rev-parse "${PIN_COMMIT}^{tree}")" || fail "FETCHED_TREE_QUERY_FAILED"
emit "FETCHED_COMMIT=$FETCHED_COMMIT"
emit "FETCHED_TREE=$FETCHED_TREE"
[[ "$FETCHED_COMMIT" == "$PIN_COMMIT" && "$FETCHED_TREE" == "$PIN_TREE_EXPECTED" ]] || \
  fail "PINNED_COMMIT_OR_TREE_IDENTITY_MISMATCH"
emit "PINNED_COMMIT_AND_TREE_IDENTITY=PASS"

tree_entry_gate RUNNER "$RUNNER_REPOSITORY_PATH" "$RUNNER_PUBLIC_MODE_EXPECTED" "$RUNNER_BLOB_EXPECTED" || \
  fail "RUNNER_PINNED_TREE_ENTRY_MISMATCH"
tree_entry_gate PLIST "$PLIST_REPOSITORY_PATH" "$PLIST_PUBLIC_MODE_EXPECTED" "$PLIST_BLOB_EXPECTED" || \
  fail "PLIST_PINNED_TREE_ENTRY_MISMATCH"
tree_entry_gate HELPER "$HELPER_REPOSITORY_PATH" "$HELPER_PUBLIC_MODE_EXPECTED" "$HELPER_BLOB_EXPECTED" || \
  fail "HELPER_PINNED_TREE_ENTRY_MISMATCH"
emit "PINNED_TREE_ENTRIES_AND_PUBLIC_MODES=PASS"

clean_git --git-dir="$FETCH_REPOSITORY" show "${PIN_COMMIT}:${RUNNER_REPOSITORY_PATH}" > "$STAGED_RUNNER" || \
  fail "RUNNER_PINNED_EXTRACT_FAILED"
clean_git --git-dir="$FETCH_REPOSITORY" show "${PIN_COMMIT}:${PLIST_REPOSITORY_PATH}" > "$STAGED_PLIST" || \
  fail "PLIST_PINNED_EXTRACT_FAILED"
clean_git --git-dir="$FETCH_REPOSITORY" show "${PIN_COMMIT}:${HELPER_REPOSITORY_PATH}" > "$STAGED_HELPER" || \
  fail "HELPER_PINNED_EXTRACT_FAILED"
/bin/chmod 0500 "$STAGED_RUNNER" "$STAGED_HELPER"
/bin/chmod 0644 "$STAGED_PLIST"

staged_identity_gate STAGED_RUNNER "$STAGED_RUNNER" "$RUNNER_BLOB_EXPECTED" \
  "$RUNNER_SHA256_EXPECTED" "$RUNNER_BYTES_EXPECTED" "$RUNNER_RUNTIME_MODE_EXPECTED" || \
  fail "STAGED_RUNNER_IDENTITY_FAILED"
staged_identity_gate STAGED_PLIST "$STAGED_PLIST" "$PLIST_BLOB_EXPECTED" \
  "$PLIST_SHA256_EXPECTED" "$PLIST_BYTES_EXPECTED" "$PLIST_RUNTIME_MODE_EXPECTED" || \
  fail "STAGED_PLIST_IDENTITY_FAILED"
staged_identity_gate STAGED_HELPER "$STAGED_HELPER" "$HELPER_BLOB_EXPECTED" \
  "$HELPER_SHA256_EXPECTED" "$HELPER_BYTES_EXPECTED" "$HELPER_RUNTIME_MODE_EXPECTED" || \
  fail "STAGED_HELPER_IDENTITY_FAILED"

/bin/zsh -n "$STAGED_RUNNER" || fail "PINNED_RUNNER_ZSH_SYNTAX_FAILED"
/usr/bin/plutil -lint "$STAGED_PLIST" || fail "PINNED_PLIST_LINT_FAILED"
emit "PINNED_RUNNER_AND_PLIST_LOCAL_VALIDATION=PASS"

HELPER_FILE_DESCRIPTION="$(/usr/bin/file -b "$STAGED_HELPER")" || fail "HELPER_FILE_DESCRIPTION_FAILED"
emit "HELPER_FILE_DESCRIPTION=$HELPER_FILE_DESCRIPTION"
[[ "$HELPER_FILE_DESCRIPTION" == *"Mach-O 64-bit executable x86_64"* ]] || \
  fail "HELPER_ARCHITECTURE_IDENTITY_FAILED"
/usr/bin/codesign --verify --strict --verbose=2 "$STAGED_HELPER" || \
  fail "HELPER_CODESIGN_VERIFY_FAILED"
emit "HELPER_CODESIGN_VERIFY=PASS"

emit "HELPER_SELF_TEST_BEGIN=UNCHANGED_PINNED_HELPER"
if /usr/bin/env -i PATH=/usr/bin:/bin:/usr/sbin:/sbin LANG=C LC_ALL=C \
    TMPDIR=/private/tmp "$STAGED_HELPER" --self-test > "$SELFTEST_OUTPUT" 2>&1; then
  SELFTEST_RC=0
else
  SELFTEST_RC=$?
fi
emit_file "$SELFTEST_OUTPUT" || fail "SELFTEST_OUTPUT_READ_FAILED"
SELFTEST_SHA256_ACTUAL="$(sha256_file "$SELFTEST_OUTPUT")" || fail "SELFTEST_SHA256_FAILED"
SELFTEST_BYTES_ACTUAL="$(/usr/bin/stat -f '%z' "$SELFTEST_OUTPUT")" || fail "SELFTEST_BYTES_FAILED"
SELFTEST_LINES_ACTUAL="$(/usr/bin/wc -l < "$SELFTEST_OUTPUT" | /usr/bin/tr -d '[:space:]')"
emit "SELFTEST_RC=$SELFTEST_RC"
emit "SELFTEST_SHA256=$SELFTEST_SHA256_ACTUAL"
emit "SELFTEST_BYTES=$SELFTEST_BYTES_ACTUAL"
emit "SELFTEST_LINES=$SELFTEST_LINES_ACTUAL"

typeset -a SELFTEST_MARKERS
SELFTEST_MARKERS=(
  "D97AEX_SELF_TEST_MANIFEST=PASS|ENTRIES=31|BYTES=330"
  "D97AEX_SELF_TEST_CLASSIFIER=PASS|PRE_POST_OTHER_INVARIANT"
  "D97AEX_SELF_TEST_AGGREGATION=PASS|PATCH_MISMATCH_CASES=23|INVARIANT_MISMATCH_CASES=8"
  "D97AEX_SELF_TEST_MACHO=PASS|HEADER_BYTES=3832|UUID_D5CE=YES|TOPOLOGY=EXACT"
  "D97AEX_SELF_TEST_SEGMENT_TRANSLATION=PASS|WINDOWS=31"
  "D97AEX_SELF_TEST=PASS"
)
SELFTEST_MARKERS_OK=1
for selftest_marker in "${SELFTEST_MARKERS[@]}"; do
  marker_count="$(/usr/bin/grep -Fxc "$selftest_marker" "$SELFTEST_OUTPUT" || true)"
  emit "SELFTEST_MARKER_COUNT=${marker_count}|MARKER=${selftest_marker}"
  [[ "$marker_count" == "1" ]] || SELFTEST_MARKERS_OK=0
done
if (( SELFTEST_RC != 0 || SELFTEST_MARKERS_OK != 1 )) || \
   [[ "$SELFTEST_SHA256_ACTUAL" != "$SELFTEST_SHA256_EXPECTED" || \
      "$SELFTEST_BYTES_ACTUAL" != "$SELFTEST_BYTES_EXPECTED" || \
      "$SELFTEST_LINES_ACTUAL" != "$SELFTEST_LINES_EXPECTED" ]]; then
  fail "UNCHANGED_HELPER_SELFTEST_IDENTITY_FAILED"
fi
emit "UNCHANGED_HELPER_SELFTEST_IDENTITY=PASS"

live_identity_gate SERVICE "$SERVICE" "$SERVICE_SHA256_EXPECTED" \
  "$SERVICE_BYTES_EXPECTED" "$SERVICE_MODE_EXPECTED" || fail "LIVE_D97AD_SERVICE_IDENTITY_FAILED"
live_identity_gate TARGET "$TARGET" "$TARGET_SHA256_EXPECTED" \
  "$TARGET_BYTES_EXPECTED" "$TARGET_MODE_EXPECTED" || fail "LIVE_D97AD_TARGET_IDENTITY_FAILED"
emit "LIVE_D97AD_SERVICE_AND_TARGET_IDENTITIES=PASS"

ACTIVATION_BOOT_UUID="$(/usr/sbin/sysctl -n kern.bootsessionuuid)" || fail "ACTIVATION_BOOT_UUID_QUERY_FAILED"
print -r -- "$ACTIVATION_BOOT_UUID" | /usr/bin/grep -Eq \
  '^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$' || \
  fail "ACTIVATION_BOOT_UUID_FORMAT_INVALID"
emit "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"

{
  print -r -- "D97AEZ_DEPLOY_RECORD_SCHEMA=1"
  print -r -- "D97AEZ_DEPLOY_RECORD_STATE=ACTIVATED_IN_VESA"
  print -r -- "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"
  print -r -- "PRODUCT_VERSION_EXPECTED=$PRODUCT_VERSION_EXPECTED"
  print -r -- "BUILD_VERSION_EXPECTED=$BUILD_VERSION_EXPECTED"
  print -r -- "ARCHITECTURE_EXPECTED=$ARCHITECTURE_EXPECTED"
  print -r -- "RUNNER_PATH=$RUNNER"
  print -r -- "RUNNER_SHA256=$RUNNER_SHA256_EXPECTED"
  print -r -- "RUNNER_BYTES=$RUNNER_BYTES_EXPECTED"
  print -r -- "RUNNER_MODE=$RUNNER_RUNTIME_MODE_EXPECTED"
  print -r -- "HELPER_PATH=$HELPER"
  print -r -- "HELPER_SHA256=$HELPER_SHA256_EXPECTED"
  print -r -- "HELPER_BYTES=$HELPER_BYTES_EXPECTED"
  print -r -- "HELPER_MODE=$HELPER_RUNTIME_MODE_EXPECTED"
  print -r -- "PLIST_PATH=$PLIST"
  print -r -- "PLIST_SHA256=$PLIST_SHA256_EXPECTED"
  print -r -- "PLIST_BYTES=$PLIST_BYTES_EXPECTED"
  print -r -- "PLIST_MODE=$PLIST_RUNTIME_MODE_EXPECTED"
  print -r -- "SERVICE_PATH=$SERVICE"
  print -r -- "SERVICE_SHA256=$SERVICE_SHA256_EXPECTED"
  print -r -- "SERVICE_BYTES=$SERVICE_BYTES_EXPECTED"
  print -r -- "SERVICE_MODE=$SERVICE_MODE_EXPECTED"
  print -r -- "TARGET_PATH=$TARGET"
  print -r -- "TARGET_SHA256=$TARGET_SHA256_EXPECTED"
  print -r -- "TARGET_BYTES=$TARGET_BYTES_EXPECTED"
  print -r -- "TARGET_MODE=$TARGET_MODE_EXPECTED"
  print -r -- "WATCH_DURATION_SECONDS=120"
  print -r -- "WATCH_INTERVAL_MILLISECONDS=25"
  print -r -- "WATCH_MINIMUM_COMPLETE=3"
  print -r -- "SERVICE_LAUNCH=AUTO-NO"
  print -r -- "SERVICE_STOP=AUTO-NO"
  print -r -- "TARGET_PROCESS_CONTROL_MUTATION=NO"
  print -r -- "ROOT_PATCH=AUTO-NO"
  print -r -- "REBOOT=AUTO-NO"
  print -r -- "D97AEZ_DEPLOY_RECORD_END=END"
} > "$STAGED_DEPLOY_RECORD" || fail "DEPLOY_RECORD_STAGE_WRITE_FAILED"
/bin/chmod 0400 "$STAGED_DEPLOY_RECORD"

DEPLOY_RECORD_LINES="$(/usr/bin/wc -l < "$STAGED_DEPLOY_RECORD" | /usr/bin/tr -d '[:space:]')"
DEPLOY_RECORD_BYTES="$(/usr/bin/stat -f '%z' "$STAGED_DEPLOY_RECORD")" || fail "DEPLOY_RECORD_BYTES_QUERY_FAILED"
DEPLOY_RECORD_SHA256="$(sha256_file "$STAGED_DEPLOY_RECORD")" || fail "DEPLOY_RECORD_SHA256_FAILED"
emit "DEPLOY_RECORD_LINES=$DEPLOY_RECORD_LINES"
emit "DEPLOY_RECORD_BYTES=$DEPLOY_RECORD_BYTES"
emit "DEPLOY_RECORD_SHA256=$DEPLOY_RECORD_SHA256"
[[ "$DEPLOY_RECORD_LINES" == "35" ]] || fail "DEPLOY_RECORD_PHYSICAL_LINE_COUNT_NOT_35"
(( DEPLOY_RECORD_BYTES > 0 && DEPLOY_RECORD_BYTES <= 8192 )) || fail "DEPLOY_RECORD_SIZE_OUT_OF_RANGE"
[[ "$(/usr/bin/grep -Fxc 'D97AEZ_DEPLOY_RECORD_SCHEMA=1' "$STAGED_DEPLOY_RECORD")" == "1" && \
   "$(/usr/bin/grep -Fxc 'D97AEZ_DEPLOY_RECORD_END=END' "$STAGED_DEPLOY_RECORD")" == "1" ]] || \
  fail "DEPLOY_RECORD_BOUNDARY_MARKERS_INVALID"
emit "DEPLOY_RECORD_EXACT_35_LINE_SCHEMA=PASS"

emit "SUDO_CREDENTIAL_VALIDATION_BEGIN=INTERACTIVE_NO_TARGET_COMMAND"
/usr/bin/sudo -v || fail "SUDO_CREDENTIAL_VALIDATION_FAILED"
emit "SUDO_CREDENTIAL_VALIDATION=PASS"

if /usr/bin/sudo /bin/launchctl print "system/$LABEL" >/dev/null 2>&1; then
  fail "OBSERVER_LABEL_ALREADY_LOADED"
fi
for absent_target in "$INSTALL_DIR" "$STATE_DIR_CANONICAL" "$PLIST"; do
  if [[ -e "$absent_target" || -L "$absent_target" ]]; then
    fail "PREEXISTING_OBSERVER_TARGET:${absent_target}"
  fi
done

emit "ROOT_OBSERVER_INSTALL_BEGIN=EXCLUSIVE_NEW_PATHS_ONLY"
/usr/bin/sudo /bin/mkdir "$INSTALL_DIR" || fail "INSTALL_DIRECTORY_EXCLUSIVE_CREATE_FAILED"
/usr/bin/sudo /usr/sbin/chown root:wheel "$INSTALL_DIR" || fail "INSTALL_DIRECTORY_OWNER_FAILED"
/usr/bin/sudo /bin/chmod 0700 "$INSTALL_DIR" || fail "INSTALL_DIRECTORY_MODE_FAILED"
/usr/bin/sudo /bin/mkdir "$STATE_DIR_CANONICAL" || fail "STATE_DIRECTORY_EXCLUSIVE_CREATE_FAILED"
/usr/bin/sudo /usr/sbin/chown root:wheel "$STATE_DIR_CANONICAL" || fail "STATE_DIRECTORY_OWNER_FAILED"
/usr/bin/sudo /bin/chmod 0700 "$STATE_DIR_CANONICAL" || fail "STATE_DIRECTORY_MODE_FAILED"
root_directory_gate INSTALL_DIRECTORY "$INSTALL_DIR" || fail "INSTALLED_DIRECTORY_IDENTITY_FAILED"
root_directory_gate STATE_DIRECTORY "$STATE_DIR" || fail "STATE_DIRECTORY_IDENTITY_FAILED"

STATE_ALIAS_IDENTITY="$(/usr/bin/sudo /usr/bin/stat -f '%d:%i' "$STATE_DIR")" || fail "STATE_ALIAS_STAT_FAILED"
STATE_CANONICAL_IDENTITY="$(/usr/bin/sudo /usr/bin/stat -f '%d:%i' "$STATE_DIR_CANONICAL")" || fail "STATE_CANONICAL_STAT_FAILED"
emit "STATE_ALIAS_DEV_INODE=$STATE_ALIAS_IDENTITY"
emit "STATE_CANONICAL_DEV_INODE=$STATE_CANONICAL_IDENTITY"
[[ "$STATE_ALIAS_IDENTITY" == "$STATE_CANONICAL_IDENTITY" ]] || fail "STATE_ALIAS_CANONICAL_IDENTITY_MISMATCH"

/usr/bin/sudo /usr/bin/install -o root -g wheel -m 0500 "$STAGED_RUNNER" "$RUNNER" || \
  fail "RUNNER_INSTALL_FAILED"
/usr/bin/sudo /usr/bin/install -o root -g wheel -m 0500 "$STAGED_HELPER" "$HELPER" || \
  fail "HELPER_INSTALL_FAILED"
/usr/bin/sudo /usr/bin/install -o root -g wheel -m 0400 "$STAGED_DEPLOY_RECORD" "$DEPLOY_RECORD" || \
  fail "DEPLOY_RECORD_INSTALL_FAILED"
/usr/bin/sudo /usr/bin/install -o root -g wheel -m 0600 /dev/null "$LAUNCHD_STDOUT" || \
  fail "LAUNCHD_STDOUT_CREATE_FAILED"
/usr/bin/sudo /usr/bin/install -o root -g wheel -m 0600 /dev/null "$LAUNCHD_STDERR" || \
  fail "LAUNCHD_STDERR_CREATE_FAILED"

PLIST_INSTALLING="${PLIST}.D97AEZ-installing-${ACTIVATION_BOOT_UUID}"
[[ ! -e "$PLIST_INSTALLING" && ! -L "$PLIST_INSTALLING" ]] || fail "PLIST_INSTALLING_PATH_PREEXISTS"
/usr/bin/sudo /usr/bin/install -o root -g wheel -m 0644 "$STAGED_PLIST" "$PLIST_INSTALLING" || \
  fail "PLIST_TEMP_INSTALL_FAILED"
/usr/bin/sudo /bin/ln "$PLIST_INSTALLING" "$PLIST" || fail "PLIST_EXCLUSIVE_PUBLISH_FAILED"
/usr/bin/sudo /bin/rm -f "$PLIST_INSTALLING" || fail "PLIST_TEMP_LINK_REMOVE_FAILED"

root_file_identity_gate RUNNER "$RUNNER" "$RUNNER_BLOB_EXPECTED" "$RUNNER_SHA256_EXPECTED" \
  "$RUNNER_BYTES_EXPECTED" "$RUNNER_RUNTIME_MODE_EXPECTED" || fail "INSTALLED_RUNNER_IDENTITY_FAILED"
root_file_identity_gate HELPER "$HELPER" "$HELPER_BLOB_EXPECTED" "$HELPER_SHA256_EXPECTED" \
  "$HELPER_BYTES_EXPECTED" "$HELPER_RUNTIME_MODE_EXPECTED" || fail "INSTALLED_HELPER_IDENTITY_FAILED"
root_file_identity_gate PLIST "$PLIST" "$PLIST_BLOB_EXPECTED" "$PLIST_SHA256_EXPECTED" \
  "$PLIST_BYTES_EXPECTED" "$PLIST_RUNTIME_MODE_EXPECTED" || fail "INSTALLED_PLIST_IDENTITY_FAILED"
root_log_gate LAUNCHD_STDOUT_PRE "$LAUNCHD_STDOUT" || fail "LAUNCHD_STDOUT_PRE_IDENTITY_FAILED"
root_log_gate LAUNCHD_STDERR_PRE "$LAUNCHD_STDERR" || fail "LAUNCHD_STDERR_PRE_IDENTITY_FAILED"
[[ "$(/usr/bin/sudo /usr/bin/stat -f '%z' "$LAUNCHD_STDOUT")" == "0" && \
   "$(/usr/bin/sudo /usr/bin/stat -f '%z' "$LAUNCHD_STDERR")" == "0" ]] || \
  fail "LAUNCHD_LOGS_NOT_EMPTY_BEFORE_BOOTSTRAP"

DEPLOY_RECORD_INSTALLED_SHA="$(/usr/bin/sudo /usr/bin/shasum -a 256 "$DEPLOY_RECORD")" || \
  fail "INSTALLED_DEPLOY_RECORD_SHA_FAILED"
DEPLOY_RECORD_INSTALLED_SHA="${DEPLOY_RECORD_INSTALLED_SHA%% *}"
[[ "$DEPLOY_RECORD_INSTALLED_SHA" == "$DEPLOY_RECORD_SHA256" && \
   "$(/usr/bin/sudo /usr/bin/stat -f '%u:%g:%Lp:%l:%z' "$DEPLOY_RECORD")" == \
     "0:0:400:1:${DEPLOY_RECORD_BYTES}" ]] || fail "INSTALLED_DEPLOY_RECORD_IDENTITY_FAILED"
/usr/bin/sudo /usr/bin/chflags uchg "$DEPLOY_RECORD" || fail "DEPLOY_RECORD_IMMUTABLE_FLAG_FAILED"
DEPLOY_RECORD_FLAGS="$(/usr/bin/sudo /usr/bin/stat -f '%f' "$DEPLOY_RECORD")" || fail "DEPLOY_RECORD_FLAGS_QUERY_FAILED"
(( (DEPLOY_RECORD_FLAGS & 2) == 2 )) || fail "DEPLOY_RECORD_IMMUTABLE_FLAG_NOT_PRESENT"
emit "INSTALLED_DEPLOY_RECORD_SHA256=$DEPLOY_RECORD_INSTALLED_SHA"
emit "INSTALLED_DEPLOY_RECORD_FLAGS=$DEPLOY_RECORD_FLAGS"
emit "INSTALLED_DEPLOY_RECORD_IDENTITY_AND_IMMUTABILITY=PASS"
/bin/sync

emit "OBSERVER_LAUNCHD_ENABLE_BEGIN=SYSTEM_DOMAIN"
OBSERVER_SYSTEM_CONTROL_BEGUN=1
/usr/bin/sudo /bin/launchctl enable "system/$LABEL" || fail "OBSERVER_LAUNCHD_ENABLE_FAILED"
/usr/bin/sudo /bin/launchctl print-disabled system > "$LAUNCH_DISABLED_OUTPUT" 2>&1 || \
  fail "OBSERVER_PRINT_DISABLED_FAILED"
DISABLED_LINE="$(/usr/bin/grep -F "$LABEL" "$LAUNCH_DISABLED_OUTPUT" || true)"
emit "OBSERVER_DISABLED_DATABASE_LINE=${DISABLED_LINE:-ABSENT}"
print -r -- "$DISABLED_LINE" | /usr/bin/grep -Eq '=>[[:space:]]*false' || \
  fail "OBSERVER_EXPLICIT_ENABLE_AUDIT_FAILED"
emit "OBSERVER_LAUNCHD_EXPLICIT_ENABLE=PASS"

emit "OBSERVER_LAUNCHD_BOOTSTRAP_BEGIN=SYSTEM_DOMAIN"
/usr/bin/sudo /bin/launchctl bootstrap system "$PLIST" || fail "OBSERVER_LAUNCHD_BOOTSTRAP_FAILED"
emit "OBSERVER_LAUNCHD_BOOTSTRAP_RC=0"

SAME_BOOT_MARKER="D97AEZ_STARTUP_RESULT=SAME_ACTIVATION_BOOT_SKIP|DEPLOY_RECORD=PASS"
SAME_BOOT_MARKER_SEEN=0
for wait_index in {1..30}; do
  if /usr/bin/sudo /usr/bin/grep -Fqx "$SAME_BOOT_MARKER" "$LAUNCHD_STDOUT" 2>/dev/null; then
    SAME_BOOT_MARKER_SEEN=1
    break
  fi
  /bin/sleep 1
done
(( SAME_BOOT_MARKER_SEEN == 1 )) || fail "SAME_BOOT_NOOP_MARKER_TIMEOUT"

CURRENT_BOOT_UUID_AFTER="$(/usr/sbin/sysctl -n kern.bootsessionuuid)" || fail "POST_BOOTSTRAP_BOOT_UUID_QUERY_FAILED"
emit "CURRENT_BOOT_UUID_AFTER_BOOTSTRAP=$CURRENT_BOOT_UUID_AFTER"
[[ "$CURRENT_BOOT_UUID_AFTER" == "$ACTIVATION_BOOT_UUID" ]] || fail "BOOT_CHANGED_DURING_ACTIVATION"

SAME_BOOT_MARKER_COUNT="$(/usr/bin/sudo /usr/bin/grep -Fxc "$SAME_BOOT_MARKER" "$LAUNCHD_STDOUT" || true)"
STARTUP_HEADER_COUNT="$(/usr/bin/sudo /usr/bin/grep -Fxc '===== OCLP7 D97AEZ LAUNCHD STARTUP =====' "$LAUNCHD_STDOUT" || true)"
emit "SAME_BOOT_MARKER_COUNT=$SAME_BOOT_MARKER_COUNT"
emit "STARTUP_HEADER_COUNT=$STARTUP_HEADER_COUNT"
[[ "$SAME_BOOT_MARKER_COUNT" == "1" && "$STARTUP_HEADER_COUNT" == "1" ]] || \
  fail "SAME_BOOT_NOOP_CARDINALITY_FAILED"

for forbidden_same_boot_artifact in "$CLAIM" "$DONE" "$BOOT_REPORT" \
  "$HELPER_OUTPUT" "$WATCHDOG_MARKER"; do
  if /usr/bin/sudo /bin/test -e "$forbidden_same_boot_artifact" || \
     /usr/bin/sudo /bin/test -L "$forbidden_same_boot_artifact"; then
    fail "SAME_BOOT_OBSERVER_WORK_ARTIFACT_PRESENT:${forbidden_same_boot_artifact}"
  fi
done

root_log_gate LAUNCHD_STDOUT_POST "$LAUNCHD_STDOUT" || fail "LAUNCHD_STDOUT_POST_IDENTITY_FAILED"
root_log_gate LAUNCHD_STDERR_POST "$LAUNCHD_STDERR" || fail "LAUNCHD_STDERR_POST_IDENTITY_FAILED"
LAUNCHD_STDERR_BYTES="$(/usr/bin/sudo /usr/bin/stat -f '%z' "$LAUNCHD_STDERR")" || fail "LAUNCHD_STDERR_BYTES_QUERY_FAILED"
emit "LAUNCHD_STDERR_BYTES=$LAUNCHD_STDERR_BYTES"
[[ "$LAUNCHD_STDERR_BYTES" == "0" ]] || fail "LAUNCHD_STDERR_NOT_EMPTY"

emit "===== PERSISTENT SAME-BOOT LAUNCHD STDOUT ====="
/usr/bin/sudo /bin/cat "$LAUNCHD_STDOUT" > "$LAUNCHD_STDOUT_COPY" || \
  fail "LAUNCHD_STDOUT_READ_FAILED"
/bin/chmod 0600 "$LAUNCHD_STDOUT_COPY" || fail "LAUNCHD_STDOUT_COPY_MODE_FAILED"
emit_file "$LAUNCHD_STDOUT_COPY" || fail "LAUNCHD_STDOUT_COPY_EMIT_FAILED"
emit "===== END PERSISTENT SAME-BOOT LAUNCHD STDOUT ====="

/usr/bin/sudo /bin/launchctl print "system/$LABEL" > "$LAUNCH_PRINT_OUTPUT" 2>&1 || \
  fail "OBSERVER_LAUNCHD_PRINT_FAILED"
for launch_audit_anchor in \
  "system/$LABEL" \
  "path = $PLIST" \
  "program = /bin/zsh" \
  "$RUNNER" \
  "stdout path = $LAUNCHD_STDOUT" \
  "stderr path = $LAUNCHD_STDERR"; do
  /usr/bin/grep -Fq "$launch_audit_anchor" "$LAUNCH_PRINT_OUTPUT" || \
    fail "OBSERVER_LAUNCHD_PRINT_ANCHOR_MISSING:${launch_audit_anchor}"
done
/usr/bin/grep -Fq 'state = not running' "$LAUNCH_PRINT_OUTPUT" || \
  fail "OBSERVER_JOB_NOT_FULLY_EXITED"
/usr/bin/grep -Fq 'last exit code = 0' "$LAUNCH_PRINT_OUTPUT" || \
  fail "OBSERVER_JOB_LAST_EXIT_STATUS_NOT_ZERO"
if /usr/bin/grep -Eq '^[[:space:]]*pid = [0-9]+' "$LAUNCH_PRINT_OUTPUT"; then
  fail "OBSERVER_JOB_PID_REMAINS_AFTER_SAME_BOOT_NOOP"
fi
emit "OBSERVER_SAME_BOOT_PROCESS_EXIT=PASS|STATE=NOT_RUNNING|LAST_EXIT_CODE=0|PID=ABSENT"
emit "OBSERVER_LAUNCHD_PRINT_IDENTITY=PASS"
emit "===== LAUNCHD JOB AUDIT ====="
emit_file "$LAUNCH_PRINT_OUTPUT" || fail "LAUNCHD_JOB_AUDIT_EMIT_FAILED"
emit "===== END LAUNCHD JOB AUDIT ====="

root_file_identity_gate RUNNER_POST_BOOTSTRAP "$RUNNER" "$RUNNER_BLOB_EXPECTED" \
  "$RUNNER_SHA256_EXPECTED" "$RUNNER_BYTES_EXPECTED" "$RUNNER_RUNTIME_MODE_EXPECTED" || \
  fail "POST_BOOTSTRAP_RUNNER_IDENTITY_FAILED"
root_file_identity_gate HELPER_POST_BOOTSTRAP "$HELPER" "$HELPER_BLOB_EXPECTED" \
  "$HELPER_SHA256_EXPECTED" "$HELPER_BYTES_EXPECTED" "$HELPER_RUNTIME_MODE_EXPECTED" || \
  fail "POST_BOOTSTRAP_HELPER_IDENTITY_FAILED"
root_file_identity_gate PLIST_POST_BOOTSTRAP "$PLIST" "$PLIST_BLOB_EXPECTED" \
  "$PLIST_SHA256_EXPECTED" "$PLIST_BYTES_EXPECTED" "$PLIST_RUNTIME_MODE_EXPECTED" || \
  fail "POST_BOOTSTRAP_PLIST_IDENTITY_FAILED"
DEPLOY_RECORD_POST_STAT_BEFORE="$(/usr/bin/sudo /usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l|FLAGS=%f' "$DEPLOY_RECORD")" || \
  fail "POST_BOOTSTRAP_DEPLOY_RECORD_STAT_BEFORE_FAILED"
DEPLOY_RECORD_POST_SHA="$(/usr/bin/sudo /usr/bin/shasum -a 256 "$DEPLOY_RECORD")" || \
  fail "POST_BOOTSTRAP_DEPLOY_RECORD_SHA_FAILED"
DEPLOY_RECORD_POST_SHA="${DEPLOY_RECORD_POST_SHA%% *}"
DEPLOY_RECORD_POST_STAT_AFTER="$(/usr/bin/sudo /usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l|FLAGS=%f' "$DEPLOY_RECORD")" || \
  fail "POST_BOOTSTRAP_DEPLOY_RECORD_STAT_AFTER_FAILED"
DEPLOY_RECORD_POST_FLAGS="$(/usr/bin/sudo /usr/bin/stat -f '%f' "$DEPLOY_RECORD")" || \
  fail "POST_BOOTSTRAP_DEPLOY_RECORD_FLAGS_FAILED"
emit "POST_BOOTSTRAP_DEPLOY_RECORD_STAT_BEFORE=$DEPLOY_RECORD_POST_STAT_BEFORE"
emit "POST_BOOTSTRAP_DEPLOY_RECORD_SHA256=$DEPLOY_RECORD_POST_SHA"
emit "POST_BOOTSTRAP_DEPLOY_RECORD_STAT_AFTER=$DEPLOY_RECORD_POST_STAT_AFTER"
if [[ "$DEPLOY_RECORD_POST_STAT_BEFORE" != "$DEPLOY_RECORD_POST_STAT_AFTER" || \
      "$DEPLOY_RECORD_POST_SHA" != "$DEPLOY_RECORD_SHA256" || \
      "$(/usr/bin/sudo /usr/bin/stat -f '%u:%g:%Lp:%l:%z' "$DEPLOY_RECORD")" != \
        "0:0:400:1:${DEPLOY_RECORD_BYTES}" ]] || \
   (( (DEPLOY_RECORD_POST_FLAGS & 2) != 2 )); then
  fail "POST_BOOTSTRAP_DEPLOY_RECORD_IDENTITY_OR_IMMUTABILITY_FAILED"
fi
emit "POST_BOOTSTRAP_DEPLOY_RECORD_IDENTITY_AND_IMMUTABILITY=PASS"
live_identity_gate SERVICE_POST_BOOTSTRAP "$SERVICE" "$SERVICE_SHA256_EXPECTED" \
  "$SERVICE_BYTES_EXPECTED" "$SERVICE_MODE_EXPECTED" || fail "POST_BOOTSTRAP_SERVICE_IDENTITY_FAILED"
live_identity_gate TARGET_POST_BOOTSTRAP "$TARGET" "$TARGET_SHA256_EXPECTED" \
  "$TARGET_BYTES_EXPECTED" "$TARGET_MODE_EXPECTED" || fail "POST_BOOTSTRAP_TARGET_IDENTITY_FAILED"

emit "D97AEZ_SAME_BOOT_NOOP=PASS"
emit "D97AEZ_OBSERVER_INSTALL_IDENTITIES=PASS"
emit "D97AEZ_OBSERVER_LAUNCHD_ENABLE_BOOTSTRAP_AUDIT=PASS"
emit "D97AEZ_ACTIVATION_RESULT=PASS"
emit "OCLP_APP_CONTROL=AUTO-NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
emit "SERVICE_LAUNCH=AUTO-NO"
emit "SERVICE_STOP=AUTO-NO"
emit "NEXT=assistant_audit_complete_activation_report_before_any_accelerated_boot"
emit "USER_ACTION_NOW=STOP"
emit "REPORT=$REPORT"
