#!/bin/zsh -f

# OCLP7 D97AEZ -- identity-pinned VESA-side one-shot evidence retrieval.
#
# This login-user wrapper performs no deployment, launchd manipulation, OCLP
# action, Root Patch, service control, target mutation, reboot, or cleanup of
# the installed observer.  With sudo it reads and hashes only the observer's
# root-owned installation/state plus the already installed live service and
# target.  It copies those text records into one unique mode-0600 Desktop
# report.  A claimed boot is never called accelerated by this program:
# user-authorized boot chronology is required for that binding.

emulate -LR zsh
set -euo pipefail
umask 077

readonly NAME="OCLP7_D97AEZ_RETRIEVE_PINNED_WRAPPER"
readonly LABEL="com.stefanalmare.oclp7.d97aez.boot-bound-one-shot"
readonly INSTALL_DIR="/Library/Application Support/OCLP7-D97AEZ"
readonly STATE_DIR="/var/db/OCLP7-D97AEZ"
readonly STATE_DIR_CANONICAL="/private/var/db/OCLP7-D97AEZ"
readonly RUNNER="$INSTALL_DIR/OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT_RUNNER.command"
readonly HELPER="$INSTALL_DIR/OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER"
readonly PLIST="/Library/LaunchDaemons/${LABEL}.plist"
readonly DEPLOY_RECORD="$STATE_DIR/DEPLOY_RECORD"
readonly CLAIM="$STATE_DIR/CLAIM"
readonly CLAIM_RECORD="$CLAIM/RECORD"
readonly OBSERVER_REPORT="$STATE_DIR/OCLP7_D97AEZ_BOOT_BOUND_REPORT.partial"
readonly DONE="$STATE_DIR/DONE"
readonly HELPER_OUTPUT="$STATE_DIR/D97AEX_HELPER_OUTPUT.partial"
readonly WATCHDOG_MARKER="$STATE_DIR/WATCHDOG_TIMEOUT"
readonly LAUNCHD_STDOUT="$STATE_DIR/LAUNCHD_STDOUT.log"
readonly LAUNCHD_STDERR="$STATE_DIR/LAUNCHD_STDERR.log"

readonly PRODUCT_VERSION_EXPECTED="26.6.2"
readonly BUILD_VERSION_EXPECTED="25G82"
readonly ARCHITECTURE_EXPECTED="x86_64"

# Final GitHub-audited immutable payload identity.
readonly PAYLOAD_COMMIT="b5f99c883ff7006f8c5800464c8e032631d5e8d2"
readonly PAYLOAD_TREE_EXPECTED="585b9113d5ffdb509b41bda1a80bbc12cb13917e"
readonly RUNNER_BLOB_EXPECTED="1e962579811d897ec82546e1ecbd0f6b03354aac"
readonly RUNNER_SHA256_EXPECTED="0dbc8e0c3e2880d105a4c139e0c278616ff339e06a40bd0f9a46827963feedf4"
readonly RUNNER_BYTES_EXPECTED="36677"
readonly PLIST_BLOB_EXPECTED="8ef97872d0a29c28a91c9d1818bf0c5c7492c080"
readonly PLIST_SHA256_EXPECTED="90c0801805319126520cc946d9f2bb4a69e95fd7a0be4a85914a1c3305ec03c5"
readonly PLIST_BYTES_EXPECTED="1027"

readonly HELPER_SHA256_EXPECTED="f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9"
readonly HELPER_BLOB_EXPECTED="9f22460e8c1e51a2ae091eb7377e958f6a148e35"
readonly HELPER_BYTES_EXPECTED="94928"
readonly SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
readonly SERVICE_SHA256_EXPECTED="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
readonly SERVICE_BYTES_EXPECTED="85520"
readonly TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
readonly TARGET_SHA256_EXPECTED="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
readonly TARGET_BYTES_EXPECTED="1636896"

readonly MAX_DEPLOY_RECORD_BYTES="8192"
readonly MAX_CLAIM_RECORD_BYTES="4096"
readonly MAX_OBSERVER_REPORT_BYTES="16777216"
readonly MAX_DONE_BYTES="8192"
readonly MAX_HELPER_OUTPUT_BYTES="8388608"
readonly MAX_WATCHDOG_MARKER_BYTES="4096"
readonly MAX_LAUNCHD_LOG_BYTES="4194304"

if (( $# != 0 )); then
  print -r -- "D97AEZ_RETRIEVE_FATAL=WRAPPER_ARGUMENTS_NOT_ALLOWED"
  exit 2
fi

for tool in /bin/cat /bin/chmod /bin/rm /bin/rmdir /bin/test \
  /usr/bin/awk /usr/bin/env /usr/bin/grep /usr/bin/id /usr/bin/last \
  /usr/bin/mktemp /usr/bin/printf /usr/bin/shasum /usr/bin/stat /usr/bin/sudo \
  /usr/bin/sw_vers /usr/bin/uname /usr/bin/wc /usr/sbin/sysctl; do
  if [[ ! -x "$tool" ]]; then
    print -r -- "D97AEZ_RETRIEVE_FATAL=REQUIRED_TOOL_MISSING:$tool"
    exit 2
  fi
done

if [[ "$(/usr/bin/id -u)" == "0" ]]; then
  print -r -- "D97AEZ_RETRIEVE_FATAL=WHOLE_WRAPPER_MUST_NOT_RUN_AS_ROOT"
  print -r -- "D97AEZ_RETRIEVE_PRIVILEGE_CONTRACT=LOGIN_USER_WRAPPER_SUDO_READ_ONLY_ROOT_OBJECTS"
  exit 2
fi

case "$RUNNER_SHA256_EXPECTED:$RUNNER_BYTES_EXPECTED:$PLIST_SHA256_EXPECTED:$PLIST_BYTES_EXPECTED" in
  *__D97AEZ_*|*[^0-9a-f:]* )
    print -r -- "D97AEZ_RETRIEVE_FATAL=UNRESOLVED_OR_INVALID_BUILD_IDENTITY_PINS"
    exit 2
    ;;
esac
[[ "$RUNNER_SHA256_EXPECTED" =~ '^[0-9a-f]{64}$' && \
   "$PLIST_SHA256_EXPECTED" =~ '^[0-9a-f]{64}$' && \
   "$PAYLOAD_COMMIT" =~ '^[0-9a-f]{40}$' && \
   "$PAYLOAD_TREE_EXPECTED" =~ '^[0-9a-f]{40}$' && \
   "$RUNNER_BLOB_EXPECTED" =~ '^[0-9a-f]{40}$' && \
   "$PLIST_BLOB_EXPECTED" =~ '^[0-9a-f]{40}$' && \
   "$HELPER_BLOB_EXPECTED" =~ '^[0-9a-f]{40}$' && \
   "$RUNNER_BYTES_EXPECTED" =~ '^[1-9][0-9]*$' && \
   "$PLIST_BYTES_EXPECTED" =~ '^[1-9][0-9]*$' ]] || {
  print -r -- "D97AEZ_RETRIEVE_FATAL=INVALID_BUILD_IDENTITY_PIN_FORMAT"
  exit 2
}

if [[ -z "${HOME:-}" || ! -d "$HOME/Desktop" || -L "$HOME/Desktop" ]]; then
  print -r -- "D97AEZ_RETRIEVE_FATAL=SAFE_DESKTOP_DIRECTORY_UNAVAILABLE"
  exit 2
fi

readonly LOGIN_UID="$(/usr/bin/id -u)"
readonly LOGIN_GID="$(/usr/bin/id -g)"
TMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AEZ_RETRIEVE.XXXXXX)" || {
  print -r -- "D97AEZ_RETRIEVE_FATAL=PRIVATE_TEMP_DIRECTORY_CREATE_FAILED"
  exit 2
}
if [[ "$TMP_ROOT" != /private/tmp/OCLP7_D97AEZ_RETRIEVE.* || ! -d "$TMP_ROOT" || -L "$TMP_ROOT" ]]; then
  print -r -- "D97AEZ_RETRIEVE_FATAL=PRIVATE_TEMP_DIRECTORY_INVALID"
  exit 2
fi
/bin/chmod 0700 "$TMP_ROOT"
[[ "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$TMP_ROOT")" == "$LOGIN_UID:$LOGIN_GID:700:2" ]] || {
  print -r -- "D97AEZ_RETRIEVE_FATAL=PRIVATE_TEMP_DIRECTORY_IDENTITY_INVALID"
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
}

REPORT="$(/usr/bin/mktemp "$HOME/Desktop/OCLP7_D97AEZ_RETRIEVE_PINNED_WRAPPER_REPORT.txt.XXXXXX")" || {
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  print -r -- "D97AEZ_RETRIEVE_FATAL=SAFE_REPORT_CREATE_FAILED"
  exit 2
}
/bin/chmod 0600 "$REPORT"
if [[ ! -f "$REPORT" || -L "$REPORT" || \
      "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$REPORT")" != "$LOGIN_UID:$LOGIN_GID:600:1" ]]; then
  print -r -- "D97AEZ_RETRIEVE_FATAL=SAFE_REPORT_IDENTITY_INVALID"
  /bin/rm -f "$REPORT" 2>/dev/null || true
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi
readonly REPORT_DEV_INODE="$(/usr/bin/stat -f 'DEV=%d|INO=%i' "$REPORT")"
exec 3>> "$REPORT"
readonly REPORT_FD_DEV_INODE="$(/usr/bin/stat -f 'DEV=%d|INO=%i' /dev/fd/3)"
if [[ "$REPORT_FD_DEV_INODE" != "$REPORT_DEV_INODE" || \
      "$(/usr/bin/stat -f '%u:%g:%Lp:%l' /dev/fd/3)" != "$LOGIN_UID:$LOGIN_GID:600:1" ]]; then
  print -r -- "D97AEZ_RETRIEVE_FATAL=DESKTOP_REPORT_PATH_FD_BINDING_FAILED"
  print -r -- "D97AEZ_RETRIEVE_FATAL=DESKTOP_REPORT_PATH_FD_BINDING_FAILED" >&3
  exec 3>&-
  /bin/rm -f "$REPORT" 2>/dev/null || true
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi

typeset -a TEMP_FILES
TEMP_FILES=()

emit() {
  print -r -- "$*"
  print -r -- "$*" >&3
}

cleanup() {
  local saved_rc=$? path
  trap - EXIT
  exec 3>&- 2>/dev/null || true
  for path in "${TEMP_FILES[@]}"; do
    if [[ "$path" == "$TMP_ROOT"/* ]]; then
      /bin/rm -f "$path" 2>/dev/null || true
    fi
  done
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit "$saved_rc"
}

trap cleanup EXIT
trap 'emit "D97AEZ_RETRIEVE_INTERRUPTED=HUP"; exit 129' HUP
trap 'emit "D97AEZ_RETRIEVE_INTERRUPTED=INT"; exit 130' INT
trap 'emit "D97AEZ_RETRIEVE_INTERRUPTED=TERM"; exit 143' TERM

fatal() {
  local reason="$1" rc="${2:-2}"
  emit "D97AEZ_RETRIEVE_RESULT=FAIL_CLOSED"
  emit "D97AEZ_RETRIEVE_FATAL=$reason"
  emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
  emit "BOOT_LANE_BINDING=USER_AUTHORIZED_CHRONOLOGY_REQUIRED"
  emit "REPORT=$REPORT"
  exit "$rc"
}

unknown_stop() {
  local reason="$1"
  emit "D97AEZ_RETRIEVE_RESULT=UNKNOWN"
  emit "D97AEZ_RETRIEVE_UNKNOWN_REASON=$reason"
  emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
  emit "BOOT_LANE_BINDING=USER_AUTHORIZED_CHRONOLOGY_REQUIRED"
  emit "TARGETED_BOOT_CALLED_ACCELERATED=AUTO-NO"
  emit "OBSERVER_REMOVAL=AUTO-NO"
  emit "REPORT=$REPORT"
  exit 3
}

sha256_local() {
  local raw
  raw="$(/usr/bin/shasum -a 256 "$1")" || return 1
  print -r -- "${raw%% *}"
}

blob_local() {
  local blob_file="$1" blob_bytes blob_line
  blob_bytes="$(/usr/bin/stat -f '%z' "$blob_file")" || return 1
  [[ "$blob_bytes" =~ '^[0-9]+$' ]] || return 1
  blob_line="$({
    /usr/bin/printf 'blob %s\000' "$blob_bytes"
    /bin/cat "$blob_file"
  } | /usr/bin/shasum -a 1)" || return 1
  print -r -- "${blob_line%% *}"
}

root_stat() {
  /usr/bin/sudo -n /usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l|FLAGS=%f' "$1"
}

root_regular_not_symlink() {
  /usr/bin/sudo -n /bin/test -f "$1" && \
    /usr/bin/sudo -n /bin/test ! -L "$1"
}

mode_allowed() {
  local actual="$1" allowed="$2" item
  for item in "${(@s:,:)allowed}"; do
    [[ "$actual" == "$item" ]] && return 0
  done
  return 1
}

immutable_allowed() {
  local flags="$1" policy="$2"
  case "$policy" in
    REQUIRED) (( (flags & 2) == 2 )) ;;
    FORBIDDEN) (( (flags & 2) == 0 )) ;;
    ANY) return 0 ;;
    *) return 1 ;;
  esac
}

# Globals returned by snapshot_root_file.
typeset SNAPSHOT_PATH=""
typeset SNAPSHOT_SHA256=""
typeset SNAPSHOT_BYTES=""
typeset SNAPSHOT_MODE=""
typeset SNAPSHOT_FLAGS=""

snapshot_root_file() {
  local label="$1" path="$2" allowed_modes="$3" max_bytes="$4"
  local immutable_policy="$5" expected_sha="${6:-}" expected_bytes="${7:-}"
  local stat_before stat_after stat_after_copy raw actual_sha actual_bytes
  local actual_uid actual_gid actual_mode actual_links actual_flags snapshot snapshot_sha snapshot_bytes

  SNAPSHOT_PATH=""
  SNAPSHOT_SHA256=""
  SNAPSHOT_BYTES=""
  SNAPSHOT_MODE=""
  SNAPSHOT_FLAGS=""
  root_regular_not_symlink "$path" || {
    emit "${label}_IDENTITY=FAIL|REASON=NOT_REGULAR_OR_IS_SYMLINK|PATH=$path"
    return 1
  }
  stat_before="$(root_stat "$path")" || {
    emit "${label}_IDENTITY=FAIL|REASON=STAT_BEFORE_FAILED|PATH=$path"
    return 1
  }
  actual_uid="$(/usr/bin/sudo -n /usr/bin/stat -f '%u' "$path")" || return 1
  actual_gid="$(/usr/bin/sudo -n /usr/bin/stat -f '%g' "$path")" || return 1
  actual_mode="$(/usr/bin/sudo -n /usr/bin/stat -f '%Lp' "$path")" || return 1
  actual_links="$(/usr/bin/sudo -n /usr/bin/stat -f '%l' "$path")" || return 1
  actual_flags="$(/usr/bin/sudo -n /usr/bin/stat -f '%f' "$path")" || return 1
  actual_bytes="$(/usr/bin/sudo -n /usr/bin/stat -f '%z' "$path")" || return 1
  emit "${label}_STAT_BEFORE=$stat_before"
  if [[ ! "$actual_bytes" =~ '^[0-9]+$' || ! "$max_bytes" =~ '^[1-9][0-9]*$' ]] || \
     (( actual_bytes > max_bytes )); then
    emit "${label}_IDENTITY=FAIL|REASON=BYTE_LIMIT_INVALID_OR_EXCEEDED|ACTUAL=$actual_bytes|MAX=$max_bytes"
    return 1
  fi
  raw="$(/usr/bin/sudo -n /usr/bin/shasum -a 256 "$path")" || {
    emit "${label}_IDENTITY=FAIL|REASON=SHA256_FAILED|PATH=$path"
    return 1
  }
  actual_sha="${raw%% *}"
  stat_after="$(root_stat "$path")" || return 1
  emit "${label}_SHA256=$actual_sha"
  emit "${label}_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" ]]; then
    emit "${label}_IDENTITY=FAIL|REASON=CHANGED_DURING_HASH"
    return 1
  fi
  if [[ "$actual_uid:$actual_gid:$actual_links" != "0:0:1" ]]; then
    emit "${label}_IDENTITY=FAIL|REASON=OWNER_GROUP_OR_LINK_COUNT_INVALID"
    return 1
  fi
  mode_allowed "$actual_mode" "$allowed_modes" || {
    emit "${label}_IDENTITY=FAIL|REASON=MODE_INVALID|ACTUAL=$actual_mode|ALLOWED=$allowed_modes"
    return 1
  }
  immutable_allowed "$actual_flags" "$immutable_policy" || {
    emit "${label}_IDENTITY=FAIL|REASON=IMMUTABLE_FLAG_POLICY_FAILED|FLAGS=$actual_flags|POLICY=$immutable_policy"
    return 1
  }
  if [[ -n "$expected_sha" && "$actual_sha" != "$expected_sha" ]]; then
    emit "${label}_IDENTITY=FAIL|REASON=SHA256_MISMATCH|EXPECTED=$expected_sha|ACTUAL=$actual_sha"
    return 1
  fi
  if [[ -n "$expected_bytes" && "$actual_bytes" != "$expected_bytes" ]]; then
    emit "${label}_IDENTITY=FAIL|REASON=BYTE_COUNT_MISMATCH|EXPECTED=$expected_bytes|ACTUAL=$actual_bytes"
    return 1
  fi

  snapshot="$(/usr/bin/mktemp "$TMP_ROOT/${label}.XXXXXX")" || return 1
  TEMP_FILES+=("$snapshot")
  /bin/chmod 0600 "$snapshot"
  /usr/bin/sudo -n /bin/cat "$path" > "$snapshot" || {
    emit "${label}_IDENTITY=FAIL|REASON=SNAPSHOT_READ_FAILED"
    return 1
  }
  stat_after_copy="$(root_stat "$path")" || return 1
  snapshot_sha="$(sha256_local "$snapshot")" || return 1
  snapshot_bytes="$(/usr/bin/stat -f '%z' "$snapshot")" || return 1
  emit "${label}_STAT_AFTER_COPY=$stat_after_copy"
  emit "${label}_SNAPSHOT_SHA256=$snapshot_sha"
  emit "${label}_SNAPSHOT_BYTES=$snapshot_bytes"
  if [[ "$stat_before" != "$stat_after_copy" || "$snapshot_sha" != "$actual_sha" || \
        "$snapshot_bytes" != "$actual_bytes" || \
        "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$snapshot")" != "$LOGIN_UID:$LOGIN_GID:600:1" ]]; then
    emit "${label}_IDENTITY=FAIL|REASON=LIVE_TO_SNAPSHOT_BINDING_FAILED"
    return 1
  fi
  SNAPSHOT_PATH="$snapshot"
  SNAPSHOT_SHA256="$actual_sha"
  SNAPSHOT_BYTES="$actual_bytes"
  SNAPSHOT_MODE="$actual_mode"
  SNAPSHOT_FLAGS="$actual_flags"
  emit "${label}_IDENTITY=PASS"
  return 0
}

root_directory_gate() {
  local label="$1" path="$2" expected_mode="$3" immutable_policy="$4"
  local stat_before stat_after uid gid mode links flags
  if ! /usr/bin/sudo -n /bin/test -d "$path" || /usr/bin/sudo -n /bin/test -L "$path"; then
    emit "${label}_IDENTITY=FAIL|REASON=NOT_DIRECTORY_OR_IS_SYMLINK|PATH=$path"
    return 1
  fi
  stat_before="$(root_stat "$path")" || return 1
  uid="$(/usr/bin/sudo -n /usr/bin/stat -f '%u' "$path")" || return 1
  gid="$(/usr/bin/sudo -n /usr/bin/stat -f '%g' "$path")" || return 1
  mode="$(/usr/bin/sudo -n /usr/bin/stat -f '%Lp' "$path")" || return 1
  links="$(/usr/bin/sudo -n /usr/bin/stat -f '%l' "$path")" || return 1
  flags="$(/usr/bin/sudo -n /usr/bin/stat -f '%f' "$path")" || return 1
  stat_after="$(root_stat "$path")" || return 1
  emit "${label}_STAT_BEFORE=$stat_before"
  emit "${label}_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" || "$uid:$gid:$mode" != "0:0:$expected_mode" || \
        ! "$links" =~ '^[0-9]+$' ]] || (( links < 2 )); then
    emit "${label}_IDENTITY=FAIL|REASON=METADATA_INVALID"
    return 1
  fi
  immutable_allowed "$flags" "$immutable_policy" || {
    emit "${label}_IDENTITY=FAIL|REASON=IMMUTABLE_FLAG_POLICY_FAILED|FLAGS=$flags|POLICY=$immutable_policy"
    return 1
  }
  emit "${label}_IDENTITY=PASS"
  return 0
}

append_snapshot() {
  local label="$1" path="$2" line
  emit "===== BEGIN ${label} CONTENT ====="
  while IFS= read -r line || [[ -n "$line" ]]; do
    emit "${label}|$line"
  done < "$path"
  emit "===== END ${label} CONTENT ====="
}

typeset -a LINES
load_lines() {
  local path="$1" content
  content="$(/bin/cat "$path")" || return 1
  LINES=("${(@f)content}")
}

typeset ACTIVATION_BOOT_UUID=""
validate_deploy_record_schema() {
  local path="$1" physical_lines
  load_lines "$path" || return 1
  physical_lines="$(/usr/bin/wc -l < "$path")" || return 1
  (( physical_lines == 35 && ${#LINES} == 35 )) || return 1
  ACTIVATION_BOOT_UUID="${LINES[3]#ACTIVATION_BOOT_UUID=}"
  [[ "$ACTIVATION_BOOT_UUID" =~ '^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$' ]] || return 1
  [[ "$LINES[1]" == "D97AEZ_DEPLOY_RECORD_SCHEMA=1" ]] || return 1
  [[ "$LINES[2]" == "D97AEZ_DEPLOY_RECORD_STATE=ACTIVATED_IN_VESA" ]] || return 1
  [[ "$LINES[3]" == "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID" ]] || return 1
  [[ "$LINES[4]" == "PRODUCT_VERSION_EXPECTED=$PRODUCT_VERSION_EXPECTED" ]] || return 1
  [[ "$LINES[5]" == "BUILD_VERSION_EXPECTED=$BUILD_VERSION_EXPECTED" ]] || return 1
  [[ "$LINES[6]" == "ARCHITECTURE_EXPECTED=$ARCHITECTURE_EXPECTED" ]] || return 1
  [[ "$LINES[7]" == "RUNNER_PATH=$RUNNER" ]] || return 1
  [[ "$LINES[8]" == "RUNNER_SHA256=$RUNNER_SHA256_EXPECTED" ]] || return 1
  [[ "$LINES[9]" == "RUNNER_BYTES=$RUNNER_BYTES_EXPECTED" ]] || return 1
  [[ "$LINES[10]" == "RUNNER_MODE=500" ]] || return 1
  [[ "$LINES[11]" == "HELPER_PATH=$HELPER" ]] || return 1
  [[ "$LINES[12]" == "HELPER_SHA256=$HELPER_SHA256_EXPECTED" ]] || return 1
  [[ "$LINES[13]" == "HELPER_BYTES=$HELPER_BYTES_EXPECTED" ]] || return 1
  [[ "$LINES[14]" == "HELPER_MODE=500" ]] || return 1
  [[ "$LINES[15]" == "PLIST_PATH=$PLIST" ]] || return 1
  [[ "$LINES[16]" == "PLIST_SHA256=$PLIST_SHA256_EXPECTED" ]] || return 1
  [[ "$LINES[17]" == "PLIST_BYTES=$PLIST_BYTES_EXPECTED" ]] || return 1
  [[ "$LINES[18]" == "PLIST_MODE=644" ]] || return 1
  [[ "$LINES[19]" == "SERVICE_PATH=$SERVICE" ]] || return 1
  [[ "$LINES[20]" == "SERVICE_SHA256=$SERVICE_SHA256_EXPECTED" ]] || return 1
  [[ "$LINES[21]" == "SERVICE_BYTES=$SERVICE_BYTES_EXPECTED" ]] || return 1
  [[ "$LINES[22]" == "SERVICE_MODE=755" ]] || return 1
  [[ "$LINES[23]" == "TARGET_PATH=$TARGET" ]] || return 1
  [[ "$LINES[24]" == "TARGET_SHA256=$TARGET_SHA256_EXPECTED" ]] || return 1
  [[ "$LINES[25]" == "TARGET_BYTES=$TARGET_BYTES_EXPECTED" ]] || return 1
  [[ "$LINES[26]" == "TARGET_MODE=755" ]] || return 1
  [[ "$LINES[27]" == "WATCH_DURATION_SECONDS=120" ]] || return 1
  [[ "$LINES[28]" == "WATCH_INTERVAL_MILLISECONDS=25" ]] || return 1
  [[ "$LINES[29]" == "WATCH_MINIMUM_COMPLETE=3" ]] || return 1
  [[ "$LINES[30]" == "SERVICE_LAUNCH=AUTO-NO" ]] || return 1
  [[ "$LINES[31]" == "SERVICE_STOP=AUTO-NO" ]] || return 1
  [[ "$LINES[32]" == "TARGET_PROCESS_CONTROL_MUTATION=NO" ]] || return 1
  [[ "$LINES[33]" == "ROOT_PATCH=AUTO-NO" ]] || return 1
  [[ "$LINES[34]" == "REBOOT=AUTO-NO" ]] || return 1
  [[ "$LINES[35]" == "D97AEZ_DEPLOY_RECORD_END=END" ]] || return 1
  return 0
}

typeset CLAIMED_BOOT_UUID=""
validate_claim_schema() {
  local path="$1" physical_lines claim_epoch
  load_lines "$path" || return 1
  physical_lines="$(/usr/bin/wc -l < "$path")" || return 1
  (( physical_lines == 5 && ${#LINES} == 5 )) || return 1
  CLAIMED_BOOT_UUID="${LINES[3]#CLAIMED_BOOT_UUID=}"
  claim_epoch="${LINES[4]#CLAIM_EPOCH=}"
  [[ "$LINES[1]" == "D97AEZ_CLAIM_SCHEMA=1" ]] || return 1
  [[ "$LINES[2]" == "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID" ]] || return 1
  [[ "$LINES[3]" == "CLAIMED_BOOT_UUID=$CLAIMED_BOOT_UUID" && \
     "$CLAIMED_BOOT_UUID" =~ '^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$' ]] || return 1
  [[ "$ACTIVATION_BOOT_UUID" != "$CLAIMED_BOOT_UUID" ]] || return 1
  [[ "$LINES[4]" == "CLAIM_EPOCH=$claim_epoch" && "$claim_epoch" =~ '^[0-9]+$' ]] || return 1
  [[ "$LINES[5]" == "D97AEZ_CLAIM_END=END" ]] || return 1
  return 0
}

typeset DONE_REPORT_SHA256=""
typeset DONE_REPORT_BYTES=""
typeset DONE_HELPER_RC=""
typeset DONE_HELPER_MAPPING=""
typeset DONE_WATCHDOG_FIRED=""
typeset DONE_RUNNER_RESULT=""
typeset DONE_RUNNER_REASON=""
typeset DONE_RUNNER_RC=""
validate_done_schema() {
  local path="$1" physical_lines
  load_lines "$path" || return 1
  physical_lines="$(/usr/bin/wc -l < "$path")" || return 1
  (( physical_lines == 14 && ${#LINES} == 14 )) || return 1
  DONE_REPORT_SHA256="${LINES[5]#REPORT_SHA256=}"
  DONE_REPORT_BYTES="${LINES[6]#REPORT_BYTES=}"
  DONE_HELPER_RC="${LINES[7]#HELPER_RC=}"
  DONE_HELPER_MAPPING="${LINES[8]#HELPER_MAPPING=}"
  DONE_WATCHDOG_FIRED="${LINES[9]#WATCHDOG_FIRED=}"
  DONE_RUNNER_RESULT="${LINES[11]#RUNNER_RESULT=}"
  DONE_RUNNER_REASON="${LINES[12]#RUNNER_REASON=}"
  DONE_RUNNER_RC="${LINES[13]#RUNNER_RC=}"
  [[ "$LINES[1]" == "D97AEZ_DONE_SCHEMA=1" ]] || return 1
  [[ "$LINES[2]" == "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID" ]] || return 1
  [[ "$LINES[3]" == "CLAIMED_BOOT_UUID=$CLAIMED_BOOT_UUID" ]] || return 1
  [[ "$LINES[4]" == "REPORT_PATH=$OBSERVER_REPORT" ]] || return 1
  [[ "$LINES[5]" == "REPORT_SHA256=$DONE_REPORT_SHA256" && \
     "$DONE_REPORT_SHA256" =~ '^[0-9a-f]{64}$' ]] || return 1
  [[ "$LINES[6]" == "REPORT_BYTES=$DONE_REPORT_BYTES" && \
     "$DONE_REPORT_BYTES" =~ '^[1-9][0-9]*$' ]] || return 1
  [[ "$LINES[7]" == "HELPER_RC=$DONE_HELPER_RC" && \
     "$DONE_HELPER_RC" =~ '^([0-9]+|INTERRUPTED|NOT_RUN)$' ]] || return 1
  [[ "$LINES[8]" == "HELPER_MAPPING=$DONE_HELPER_MAPPING" && \
     "$DONE_HELPER_MAPPING" =~ '^(NONE|INVALID|INTERRUPTED|WATCHDOG_TIMEOUT|RC0_MATCH|RC2_FAIL_CLOSED|RC3_COVERAGE_INCOMPLETE|RC4_MISMATCH)$' ]] || return 1
  [[ "$LINES[9]" == "WATCHDOG_FIRED=$DONE_WATCHDOG_FIRED" && \
     "$DONE_WATCHDOG_FIRED" =~ '^(0|1)$' ]] || return 1
  [[ "$LINES[10]" == "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE" ]] || return 1
  [[ "$LINES[11]" == "RUNNER_RESULT=$DONE_RUNNER_RESULT" && \
     "$DONE_RUNNER_RESULT" =~ '^(OBSERVED_COHORT_BOUNDED_PROVENANCE_MATCH|HELPER_FAIL_CLOSED|COVERAGE_INCOMPLETE_STOP|OBSERVED_COHORT_BOUNDED_PROVENANCE_MISMATCH|WATCHDOG_TIMEOUT_UNKNOWN|FAIL_CLOSED|PREFLIGHT_FAIL_CLOSED|INTERRUPTED_UNKNOWN|UNEXPECTED_HELPER_RC_FAIL_CLOSED)$' ]] || return 1
  [[ "$LINES[12]" == "RUNNER_REASON=$DONE_RUNNER_REASON" && \
     "$DONE_RUNNER_REASON" =~ '^([A-Z0-9_]+|(SIGNAL|SIGNAL_AFTER_WATCHDOG):(HUP|INT|TERM)|WATCHDOG_PLUS:[A-Z0-9_]+)$' ]] || return 1
  [[ "$LINES[13]" == "RUNNER_RC=$DONE_RUNNER_RC" && "$DONE_RUNNER_RC" =~ '^[0-9]+$' ]] || return 1
  [[ "$LINES[14]" == "D97AEZ_DONE_END=END" ]] || return 1
  case "$DONE_RUNNER_RESULT" in
    OBSERVED_COHORT_BOUNDED_PROVENANCE_MATCH)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_RC" == \
         "0:RC0_MATCH:0:0" && "$DONE_RUNNER_REASON" == "NONE" ]] || return 1
      ;;
    HELPER_FAIL_CLOSED)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_RC" == \
         "2:RC2_FAIL_CLOSED:0:2" && "$DONE_RUNNER_REASON" == "NONE" ]] || return 1
      ;;
    COVERAGE_INCOMPLETE_STOP)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_RC" == \
         "3:RC3_COVERAGE_INCOMPLETE:0:3" && "$DONE_RUNNER_REASON" == "NONE" ]] || return 1
      ;;
    OBSERVED_COHORT_BOUNDED_PROVENANCE_MISMATCH)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_RC" == \
         "4:RC4_MISMATCH:0:4" && "$DONE_RUNNER_REASON" == "NONE" ]] || return 1
      ;;
    PREFLIGHT_FAIL_CLOSED)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_RC" == \
         "NOT_RUN:NONE:0:2" && "$DONE_RUNNER_REASON" != "NONE" ]] || return 1
      [[ "$DONE_RUNNER_REASON" =~ '^(PRODUCT_VERSION_QUERY_FAILED|BUILD_VERSION_QUERY_FAILED|ARCHITECTURE_QUERY_FAILED|OS_BUILD_ARCH_IDENTITY_FAILED|PRE_HELPER_IDENTITY_GATES_FAILED|WATCHDOG_MARKER_PREEXISTING|HELPER_OUTPUT_PREEXISTING)$' ]] || return 1
      ;;
    INTERRUPTED_UNKNOWN)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED" == \
         "INTERRUPTED:INTERRUPTED:0" ]] || return 1
      case "$DONE_RUNNER_REASON:$DONE_RUNNER_RC" in
        SIGNAL:HUP:129|SIGNAL:INT:130|SIGNAL:TERM:143) ;;
        *) return 1 ;;
      esac
      ;;
    WATCHDOG_TIMEOUT_UNKNOWN)
      [[ "$DONE_HELPER_RC:$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_RC" == \
         "124:WATCHDOG_TIMEOUT:1:2" ]] || return 1
      [[ "$DONE_RUNNER_REASON" =~ '^(WATCHDOG_EXPIRED|WATCHDOG_MARKER_INVALID|WATCHDOG_MARKER_MODE_FAILED|WATCHDOG_MARKER_IMMUTABLE_FAILED|SIGNAL_AFTER_WATCHDOG:(HUP|INT|TERM)|WATCHDOG_PLUS:(WATCHDOG_MARKER_WITHOUT_TIMEOUT_SIGNAL|HELPER_OUTPUT_NOT_REGULAR|HELPER_OUTPUT_STAT_BEFORE_FAILED|HELPER_OUTPUT_SHA256_FAILED|HELPER_OUTPUT_STAT_AFTER_FAILED|HELPER_OUTPUT_BYTES_FAILED|HELPER_OUTPUT_IDENTITY_OR_BOUND_FAILED|HELPER_OUTPUT_APPEND_FAILED|HELPER_OUTPUT_MODE_FAILED|HELPER_OUTPUT_IMMUTABLE_FAILED|HELPER_OUTPUT_SYNC_FAILED|HELPER_OUTPUT_GREP_FAILED|TERMINAL_CONTRACT_OR_POST_IDENTITY_FAILED))$' ]] || return 1
      ;;
    FAIL_CLOSED)
      [[ "$DONE_RUNNER_RC" == "2" && "$DONE_HELPER_RC" =~ '^[0-9]+$' && \
         "$DONE_WATCHDOG_FIRED" == "0" && \
         "$DONE_HELPER_MAPPING" =~ '^(INVALID|RC0_MATCH|RC2_FAIL_CLOSED|RC3_COVERAGE_INCOMPLETE|RC4_MISMATCH)$' && \
         "$DONE_RUNNER_REASON" != "NONE" ]] || return 1
      [[ "$DONE_RUNNER_REASON" =~ '^(WATCHDOG_MARKER_WITHOUT_TIMEOUT_SIGNAL|HELPER_OUTPUT_NOT_REGULAR|HELPER_OUTPUT_STAT_BEFORE_FAILED|HELPER_OUTPUT_SHA256_FAILED|HELPER_OUTPUT_STAT_AFTER_FAILED|HELPER_OUTPUT_BYTES_FAILED|HELPER_OUTPUT_IDENTITY_OR_BOUND_FAILED|HELPER_OUTPUT_APPEND_FAILED|HELPER_OUTPUT_MODE_FAILED|HELPER_OUTPUT_IMMUTABLE_FAILED|HELPER_OUTPUT_SYNC_FAILED|HELPER_OUTPUT_GREP_FAILED|TERMINAL_CONTRACT_OR_POST_IDENTITY_FAILED)$' ]] || return 1
      ;;
    UNEXPECTED_HELPER_RC_FAIL_CLOSED)
      [[ "$DONE_RUNNER_RC" == "2" && "$DONE_HELPER_RC" =~ '^[0-9]+$' && \
         "$DONE_HELPER_MAPPING:$DONE_WATCHDOG_FIRED:$DONE_RUNNER_REASON" == "INVALID:0:UNEXPECTED_HELPER_RC" ]] || return 1
      ;;
  esac
  return 0
}

report_uuid_and_terminal_binding() {
  local path="$1"
  local binding key expected
  local -a bindings
  bindings=(
    "ACTIVATION_BOOT_UUID|$ACTIVATION_BOOT_UUID"
    "CLAIMED_BOOT_UUID|$CLAIMED_BOOT_UUID"
    "CLAIMED_BOOT_UUID_FINAL|$CLAIMED_BOOT_UUID"
    "D97AEZ_HELPER_RC|$DONE_HELPER_RC"
    "D97AEZ_HELPER_MAPPING|$DONE_HELPER_MAPPING"
    "D97AEZ_RUNNER_RESULT|$DONE_RUNNER_RESULT"
    "D97AEZ_RUNNER_REASON|$DONE_RUNNER_REASON"
    "D97AEZ_RERUN_ALLOWED|NO"
  )
  for binding in "${bindings[@]}"; do
    key="${binding%%|*}"
    expected="${binding#*|}"
    [[ "$(/usr/bin/grep -Ec "^${key}=" "$path" || true)" == "1" ]] || return 1
    [[ "$(/usr/bin/grep -Fxc "${key}=${expected}" "$path" || true)" == "1" ]] || return 1
  done
  [[ "$(/usr/bin/grep -Ec '^D97AEZ_(WATCHDOG_FIRED|RUNNER_RC)=' "$path" || true)" == "0" ]] || return 1
  return 0
}

report_key_value_once() {
  local path="$1" key="$2" expected="$3"
  [[ "$(/usr/bin/grep -Ec "^${key}=" "$path" || true)" == "1" ]] || return 1
  [[ "$(/usr/bin/grep -Fxc "${key}=${expected}" "$path" || true)" == "1" ]]
}

bind_embedded_helper_output() {
  local report_path="$1" helper_path="$2" expected_sha="$3" expected_bytes="$4"
  local extracted extracted_sha extracted_bytes helper_sha helper_bytes
  report_key_value_once "$report_path" HELPER_OUTPUT_SHA256 "$expected_sha" || return 1
  report_key_value_once "$report_path" HELPER_OUTPUT_BYTES "$expected_bytes" || return 1
  [[ "$(/usr/bin/grep -Fxc '===== BEGIN EXACT D97AEX HELPER OUTPUT =====' "$report_path" || true)" == "1" ]] || return 1
  [[ "$(/usr/bin/grep -Fxc '===== END EXACT D97AEX HELPER OUTPUT =====' "$report_path" || true)" == "1" ]] || return 1
  extracted="$(/usr/bin/mktemp "$TMP_ROOT/EMBEDDED_HELPER_OUTPUT.XXXXXX")" || return 1
  TEMP_FILES+=("$extracted")
  /bin/chmod 0600 "$extracted"
  /usr/bin/awk '
    $0 == "===== BEGIN EXACT D97AEX HELPER OUTPUT =====" {
      if (begun != 0 || ended != 0) exit 2
      begun = 1
      next
    }
    $0 == "===== END EXACT D97AEX HELPER OUTPUT =====" {
      if (begun != 1 || ended != 0) exit 2
      ended = 1
      next
    }
    begun == 1 && ended == 0 { print }
    END { if (begun != 1 || ended != 1) exit 2 }
  ' "$report_path" > "$extracted" || return 1
  extracted_sha="$(sha256_local "$extracted")" || return 1
  extracted_bytes="$(/usr/bin/stat -f '%z' "$extracted")" || return 1
  helper_sha="$(sha256_local "$helper_path")" || return 1
  helper_bytes="$(/usr/bin/stat -f '%z' "$helper_path")" || return 1
  [[ "$extracted_sha:$extracted_bytes" == "$expected_sha:$expected_bytes" && \
     "$helper_sha:$helper_bytes" == "$expected_sha:$expected_bytes" ]]
}

validate_watchdog_marker_schema() {
  local path="$1" content physical_lines
  local -a marker_lines
  content="$(/bin/cat "$path")" || return 1
  marker_lines=("${(@f)content}")
  physical_lines="$(/usr/bin/wc -l < "$path")" || return 1
  (( physical_lines == 2 && ${#marker_lines} == 2 )) || return 1
  [[ "$marker_lines[1]" == "D97AEZ_WATCHDOG_TIMEOUT=150" && \
     "$marker_lines[2]" == "CLAIMED_BOOT_UUID=$CLAIMED_BOOT_UUID" ]]
}

emit "===== OCLP7 D97AEZ — PINNED VESA EVIDENCE RETRIEVAL ====="
emit "WRAPPER=$NAME"
emit "PURPOSE=retrieve_one_boot_bound_observer_record_without_reclassification_or_cleanup"
emit "PAYLOAD_COMMIT=$PAYLOAD_COMMIT"
emit "PAYLOAD_TREE_EXPECTED=$PAYLOAD_TREE_EXPECTED"
emit "RUNNER_BLOB_EXPECTED=$RUNNER_BLOB_EXPECTED"
emit "RUNNER_SHA256_EXPECTED=$RUNNER_SHA256_EXPECTED"
emit "RUNNER_BYTES_EXPECTED=$RUNNER_BYTES_EXPECTED"
emit "PLIST_BLOB_EXPECTED=$PLIST_BLOB_EXPECTED"
emit "PLIST_SHA256_EXPECTED=$PLIST_SHA256_EXPECTED"
emit "PLIST_BYTES_EXPECTED=$PLIST_BYTES_EXPECTED"
emit "HELPER_BLOB_EXPECTED=$HELPER_BLOB_EXPECTED"
emit "HELPER_SHA256_EXPECTED=$HELPER_SHA256_EXPECTED"
emit "HELPER_BYTES_EXPECTED=$HELPER_BYTES_EXPECTED"
emit "WRAPPER_ARGUMENTS=NONE_REQUIRED"
emit "PRIVILEGE=LOGIN_USER_WITH_SUDO_READ_ONLY_ROOT_OBJECTS"
emit "SUDO_TIMESTAMP_METADATA=STANDARD_AUTHENTICATION_CACHE_MAY_UPDATE"
emit "SOURCE_MUTATION=NO"
emit "SYSTEM_MUTATION=NO_PROJECT_TARGETS"
emit "OBSERVER_STATE_MUTATION=NO"
emit "OBSERVER_REMOVAL=AUTO-NO"
emit "LAUNCHD_CONTROL=AUTO-NO"
emit "OCLP_APP_CONTROL=AUTO-NO"
emit "SERVICE_LAUNCH=AUTO-NO"
emit "SERVICE_STOP=AUTO-NO"
emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
emit "GOLDEN_MUTATION=NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
emit "BOOT_LANE_BINDING=USER_AUTHORIZED_CHRONOLOGY_REQUIRED"
emit "TARGETED_BOOT_CALLED_ACCELERATED=AUTO-NO"
emit "REPORT=$REPORT"

PRODUCT_VERSION_ACTUAL="$(/usr/bin/sw_vers -productVersion)" || fatal "PRODUCT_VERSION_QUERY_FAILED"
BUILD_VERSION_ACTUAL="$(/usr/bin/sw_vers -buildVersion)" || fatal "BUILD_VERSION_QUERY_FAILED"
ARCHITECTURE_ACTUAL="$(/usr/bin/uname -m)" || fatal "ARCHITECTURE_QUERY_FAILED"
CPU_BRAND_STRING="$(/usr/sbin/sysctl -n machdep.cpu.brand_string)" || fatal "CPU_BRAND_QUERY_FAILED"
X86_64_HARDWARE_CAPABLE="$(/usr/sbin/sysctl -n hw.optional.x86_64)" || fatal "X86_64_HARDWARE_CAPABILITY_QUERY_FAILED"
RETRIEVAL_BOOT_UUID="$(/usr/sbin/sysctl -n kern.bootsessionuuid)" || fatal "RETRIEVAL_BOOT_UUID_QUERY_FAILED"
emit "PRODUCT_VERSION_ACTUAL=$PRODUCT_VERSION_ACTUAL"
emit "BUILD_VERSION_ACTUAL=$BUILD_VERSION_ACTUAL"
emit "ARCHITECTURE_ACTUAL=$ARCHITECTURE_ACTUAL"
emit "CPU_BRAND_STRING=$CPU_BRAND_STRING"
emit "X86_64_HARDWARE_CAPABLE=$X86_64_HARDWARE_CAPABLE"
emit "RETRIEVAL_BOOT_UUID=$RETRIEVAL_BOOT_UUID"
if [[ "$PRODUCT_VERSION_ACTUAL" != "$PRODUCT_VERSION_EXPECTED" || \
      "$BUILD_VERSION_ACTUAL" != "$BUILD_VERSION_EXPECTED" || \
      "$ARCHITECTURE_ACTUAL" != "$ARCHITECTURE_EXPECTED" || \
      "$CPU_BRAND_STRING" != *Intel* || "$X86_64_HARDWARE_CAPABLE" != "1" || \
      ! "$RETRIEVAL_BOOT_UUID" =~ '^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$' ]]; then
  fatal "OS_BUILD_ARCH_OR_BOOT_UUID_IDENTITY_FAILED"
fi
emit "OS_BUILD_ARCH_IDENTITY=PASS"

emit "SUDO_CREDENTIAL_VALIDATION_BEGIN=INTERACTIVE_NO_TARGET_COMMAND"
if /usr/bin/sudo -v; then
  emit "SUDO_CREDENTIAL_VALIDATION=PASS"
else
  fatal "SUDO_CREDENTIAL_VALIDATION_FAILED"
fi

root_directory_gate INSTALL_DIRECTORY "$INSTALL_DIR" 700 ANY || fatal "INSTALL_DIRECTORY_IDENTITY_FAILED"
root_directory_gate STATE_DIRECTORY "$STATE_DIR" 700 ANY || fatal "STATE_DIRECTORY_IDENTITY_FAILED"
STATE_ALIAS_DEV_INODE="$(/usr/bin/sudo -n /usr/bin/stat -f '%d:%i' "$STATE_DIR")" || \
  fatal "STATE_ALIAS_STAT_FAILED"
STATE_CANONICAL_DEV_INODE="$(/usr/bin/sudo -n /usr/bin/stat -f '%d:%i' "$STATE_DIR_CANONICAL")" || \
  fatal "STATE_CANONICAL_STAT_FAILED"
emit "STATE_ALIAS_DEV_INODE=$STATE_ALIAS_DEV_INODE"
emit "STATE_CANONICAL_DEV_INODE=$STATE_CANONICAL_DEV_INODE"
[[ "$STATE_ALIAS_DEV_INODE" == "$STATE_CANONICAL_DEV_INODE" ]] || \
  fatal "STATE_ALIAS_CANONICAL_IDENTITY_MISMATCH"
emit "STATE_ALIAS_CANONICAL_IDENTITY=PASS"

snapshot_root_file RUNNER "$RUNNER" 500 "$RUNNER_BYTES_EXPECTED" ANY \
  "$RUNNER_SHA256_EXPECTED" "$RUNNER_BYTES_EXPECTED" || fatal "RUNNER_IDENTITY_FAILED"
RUNNER_BLOB_ACTUAL="$(blob_local "$SNAPSHOT_PATH")" || fatal "RUNNER_BLOB_QUERY_FAILED"
emit "RUNNER_BLOB=$RUNNER_BLOB_ACTUAL"
[[ "$RUNNER_BLOB_ACTUAL" == "$RUNNER_BLOB_EXPECTED" ]] || fatal "RUNNER_BLOB_IDENTITY_FAILED"
emit "RUNNER_BLOB_IDENTITY=PASS"
snapshot_root_file HELPER "$HELPER" 500 "$HELPER_BYTES_EXPECTED" ANY \
  "$HELPER_SHA256_EXPECTED" "$HELPER_BYTES_EXPECTED" || fatal "HELPER_IDENTITY_FAILED"
HELPER_BLOB_ACTUAL="$(blob_local "$SNAPSHOT_PATH")" || fatal "HELPER_BLOB_QUERY_FAILED"
emit "HELPER_BLOB=$HELPER_BLOB_ACTUAL"
[[ "$HELPER_BLOB_ACTUAL" == "$HELPER_BLOB_EXPECTED" ]] || fatal "HELPER_BLOB_IDENTITY_FAILED"
emit "HELPER_BLOB_IDENTITY=PASS"
snapshot_root_file PLIST "$PLIST" 644 "$PLIST_BYTES_EXPECTED" ANY \
  "$PLIST_SHA256_EXPECTED" "$PLIST_BYTES_EXPECTED" || fatal "PLIST_IDENTITY_FAILED"
PLIST_BLOB_ACTUAL="$(blob_local "$SNAPSHOT_PATH")" || fatal "PLIST_BLOB_QUERY_FAILED"
emit "PLIST_BLOB=$PLIST_BLOB_ACTUAL"
[[ "$PLIST_BLOB_ACTUAL" == "$PLIST_BLOB_EXPECTED" ]] || fatal "PLIST_BLOB_IDENTITY_FAILED"
emit "PLIST_BLOB_IDENTITY=PASS"
snapshot_root_file LIVE_SERVICE "$SERVICE" 755 "$SERVICE_BYTES_EXPECTED" ANY \
  "$SERVICE_SHA256_EXPECTED" "$SERVICE_BYTES_EXPECTED" || fatal "LIVE_SERVICE_IDENTITY_FAILED"
snapshot_root_file LIVE_TARGET "$TARGET" 755 "$TARGET_BYTES_EXPECTED" ANY \
  "$TARGET_SHA256_EXPECTED" "$TARGET_BYTES_EXPECTED" || fatal "LIVE_TARGET_IDENTITY_FAILED"

snapshot_root_file DEPLOY_RECORD "$DEPLOY_RECORD" 400 "$MAX_DEPLOY_RECORD_BYTES" REQUIRED || \
  fatal "DEPLOY_RECORD_IDENTITY_FAILED"
DEPLOY_SNAPSHOT="$SNAPSHOT_PATH"
validate_deploy_record_schema "$DEPLOY_SNAPSHOT" || fatal "DEPLOY_RECORD_SCHEMA_OR_PIN_BINDING_FAILED"
emit "DEPLOY_RECORD_SCHEMA_AND_PIN_BINDING=PASS"
emit "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"
append_snapshot DEPLOY_RECORD "$DEPLOY_SNAPSHOT"

snapshot_root_file LAUNCHD_STDOUT "$LAUNCHD_STDOUT" 400,440,444,600,640,644 \
  "$MAX_LAUNCHD_LOG_BYTES" ANY || fatal "LAUNCHD_STDOUT_IDENTITY_FAILED"
STDOUT_SNAPSHOT="$SNAPSHOT_PATH"
append_snapshot LAUNCHD_STDOUT "$STDOUT_SNAPSHOT"
snapshot_root_file LAUNCHD_STDERR "$LAUNCHD_STDERR" 400,440,444,600,640,644 \
  "$MAX_LAUNCHD_LOG_BYTES" ANY || fatal "LAUNCHD_STDERR_IDENTITY_FAILED"
STDERR_SNAPSHOT="$SNAPSHOT_PATH"
append_snapshot LAUNCHD_STDERR "$STDERR_SNAPSHOT"

CHRONOLOGY_SNAPSHOT="$(/usr/bin/mktemp "$TMP_ROOT/LAST_REBOOT_VISIBLE.XXXXXX")" || \
  fatal "CHRONOLOGY_SNAPSHOT_CREATE_FAILED"
TEMP_FILES+=("$CHRONOLOGY_SNAPSHOT")
/bin/chmod 0600 "$CHRONOLOGY_SNAPSHOT"
if /usr/bin/last reboot | /usr/bin/awk 'NR <= 40' > "$CHRONOLOGY_SNAPSHOT"; then
  [[ "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$CHRONOLOGY_SNAPSHOT")" == \
     "$LOGIN_UID:$LOGIN_GID:600:1" ]] || fatal "CHRONOLOGY_SNAPSHOT_IDENTITY_FAILED"
  emit "LAST_REBOOT_VISIBLE_CHRONOLOGY=AVAILABLE"
  append_snapshot LAST_REBOOT_VISIBLE "$CHRONOLOGY_SNAPSHOT"
else
  emit "LAST_REBOOT_VISIBLE_CHRONOLOGY=UNAVAILABLE_COMMAND_FAILED"
fi
emit "CHRONOLOGY_INTERPRETATION=AUTO-NO_USER_AUTHORIZATION_REQUIRED"

if ! /usr/bin/sudo -n /bin/test -e "$CLAIM" && ! /usr/bin/sudo -n /bin/test -L "$CLAIM"; then
  emit "CLAIM=ABSENT"
  typeset raw_label raw_path raw_modes raw_max
  for raw_spec in \
    "DONE|$DONE|400,600|$MAX_DONE_BYTES" \
    "OBSERVER_REPORT_RAW|$OBSERVER_REPORT|400,600|$MAX_OBSERVER_REPORT_BYTES" \
    "HELPER_OUTPUT_RAW|$HELPER_OUTPUT|400,600|$MAX_HELPER_OUTPUT_BYTES" \
    "WATCHDOG_MARKER_RAW|$WATCHDOG_MARKER|400,600|$MAX_WATCHDOG_MARKER_BYTES"; do
    raw_label="${raw_spec%%|*}"
    raw_remainder="${raw_spec#*|}"
    raw_path="${raw_remainder%%|*}"
    raw_remainder="${raw_remainder#*|}"
    raw_modes="${raw_remainder%%|*}"
    raw_max="${raw_remainder##*|}"
    if /usr/bin/sudo -n /bin/test -e "$raw_path" || /usr/bin/sudo -n /bin/test -L "$raw_path"; then
      if snapshot_root_file "$raw_label" "$raw_path" "$raw_modes" "$raw_max" ANY; then
        RAW_SNAPSHOT="$SNAPSHOT_PATH"
        append_snapshot "$raw_label" "$RAW_SNAPSHOT"
      else
        emit "${raw_label}_RAW_COPY=UNSAFE_OR_UNSTABLE_SOURCE_PRESERVED_IN_PLACE"
      fi
    else
      emit "${raw_label}=ABSENT"
    fi
  done
  unknown_stop "CLAIM_ABSENT_PRECLAIM_OR_INCOMPLETE_STATE"
fi

if ! /usr/bin/sudo -n /bin/test -e "$DONE" && ! /usr/bin/sudo -n /bin/test -L "$DONE"; then
  emit "DONE=ABSENT"
  if /usr/bin/sudo -n /bin/test -d "$CLAIM" && ! /usr/bin/sudo -n /bin/test -L "$CLAIM"; then
    CLAIM_DIRECTORY_RAW_STAT_BEFORE="$(root_stat "$CLAIM")" || CLAIM_DIRECTORY_RAW_STAT_BEFORE="STAT_FAILED"
    CLAIM_DIRECTORY_RAW_STAT_AFTER="$(root_stat "$CLAIM")" || CLAIM_DIRECTORY_RAW_STAT_AFTER="STAT_FAILED"
    emit "CLAIM_DIRECTORY_RAW_STAT_BEFORE=$CLAIM_DIRECTORY_RAW_STAT_BEFORE"
    emit "CLAIM_DIRECTORY_RAW_STAT_AFTER=$CLAIM_DIRECTORY_RAW_STAT_AFTER"
  else
    emit "CLAIM_DIRECTORY_RAW=NOT_SAFE_DIRECTORY_SOURCE_PRESERVED_IN_PLACE"
  fi
  if /usr/bin/sudo -n /bin/test -e "$CLAIM_RECORD" || /usr/bin/sudo -n /bin/test -L "$CLAIM_RECORD"; then
    if snapshot_root_file CLAIM_RECORD_RAW "$CLAIM_RECORD" 400,600 "$MAX_CLAIM_RECORD_BYTES" ANY; then
      CLAIM_RECORD_RAW_SNAPSHOT="$SNAPSHOT_PATH"
      append_snapshot CLAIM_RECORD_RAW "$CLAIM_RECORD_RAW_SNAPSHOT"
    else
      emit "CLAIM_RECORD_RAW_COPY=UNSAFE_OR_UNSTABLE_SOURCE_PRESERVED_IN_PLACE"
    fi
  else
    emit "CLAIM_RECORD_RAW=ABSENT"
  fi
  typeset incomplete_label incomplete_path incomplete_max
  for incomplete_spec in \
    "OBSERVER_REPORT_UNSEALED|$OBSERVER_REPORT|$MAX_OBSERVER_REPORT_BYTES" \
    "HELPER_OUTPUT_UNSEALED|$HELPER_OUTPUT|$MAX_HELPER_OUTPUT_BYTES" \
    "WATCHDOG_MARKER_UNSEALED|$WATCHDOG_MARKER|$MAX_WATCHDOG_MARKER_BYTES"; do
    incomplete_label="${incomplete_spec%%|*}"
    incomplete_remainder="${incomplete_spec#*|}"
    incomplete_path="${incomplete_remainder%%|*}"
    incomplete_max="${incomplete_remainder##*|}"
    if /usr/bin/sudo -n /bin/test -e "$incomplete_path" || /usr/bin/sudo -n /bin/test -L "$incomplete_path"; then
      if snapshot_root_file "$incomplete_label" "$incomplete_path" 400,600 "$incomplete_max" ANY; then
        INCOMPLETE_SNAPSHOT="$SNAPSHOT_PATH"
        append_snapshot "$incomplete_label" "$INCOMPLETE_SNAPSHOT"
      else
        emit "${incomplete_label}_RAW_COPY=UNSAFE_OR_UNSTABLE_SOURCE_PRESERVED_IN_PLACE"
      fi
    else
      emit "${incomplete_label}=ABSENT"
    fi
  done
  unknown_stop "CLAIM_PRESENT_DONE_ABSENT_INTERRUPTED_FREEZE_OR_INCOMPLETE"
fi

root_directory_gate CLAIM_DIRECTORY "$CLAIM" 500 REQUIRED || fatal "CLAIM_DIRECTORY_IDENTITY_FAILED"
snapshot_root_file CLAIM_RECORD "$CLAIM_RECORD" 400 "$MAX_CLAIM_RECORD_BYTES" REQUIRED || \
  fatal "CLAIM_RECORD_IDENTITY_FAILED"
CLAIM_SNAPSHOT="$SNAPSHOT_PATH"
validate_claim_schema "$CLAIM_SNAPSHOT" || fatal "CLAIM_SCHEMA_OR_UUID_BINDING_FAILED"
emit "CLAIM_SCHEMA_AND_UUID_BINDING=PASS"
emit "CLAIMED_BOOT_UUID=$CLAIMED_BOOT_UUID"
append_snapshot CLAIM_RECORD "$CLAIM_SNAPSHOT"

if [[ "$RETRIEVAL_BOOT_UUID" == "$CLAIMED_BOOT_UUID" ]]; then
  emit "RETRIEVAL_BOOT_DISTINCT_FROM_CLAIMED_BOOT=NO"
else
  emit "RETRIEVAL_BOOT_DISTINCT_FROM_CLAIMED_BOOT=YES"
fi
emit "CLAIMED_BOOT_LANE=UNCLASSIFIED"
emit "CLAIMED_BOOT_LANE_BINDING=USER_AUTHORIZED_CHRONOLOGY_REQUIRED"
emit "EVIDENCE_TARGET_BOOT_UUID=$CLAIMED_BOOT_UUID"
emit "RETRIEVAL_BOOT_UUID_EXCLUDED_FROM_TEST_TARGET=$RETRIEVAL_BOOT_UUID"
emit "AUTHORIZED_CHRONOLOGY_CONTRACT=CLAIMED_UUID_IMMEDIATELY_PRECEDING_ACCELERATED_BOOT_CURRENT_VESA_RECOVERY_EXCLUDED"

snapshot_root_file DONE "$DONE" 400 "$MAX_DONE_BYTES" REQUIRED || fatal "DONE_IDENTITY_FAILED"
DONE_SNAPSHOT="$SNAPSHOT_PATH"
validate_done_schema "$DONE_SNAPSHOT" || fatal "DONE_EXACT_14_LINE_SCHEMA_OR_UUID_BINDING_FAILED"
emit "DONE_EXACT_14_LINE_SCHEMA_AND_UUID_BINDING=PASS"
append_snapshot DONE "$DONE_SNAPSHOT"
DONE_ARTIFACT_REASON="$DONE_RUNNER_REASON"
if [[ "$DONE_ARTIFACT_REASON" == WATCHDOG_PLUS:* ]]; then
  DONE_ARTIFACT_REASON="${DONE_ARTIFACT_REASON#WATCHDOG_PLUS:}"
fi
emit "DONE_ARTIFACT_REASON=$DONE_ARTIFACT_REASON"

snapshot_root_file OBSERVER_REPORT "$OBSERVER_REPORT" 400 "$MAX_OBSERVER_REPORT_BYTES" REQUIRED \
  "$DONE_REPORT_SHA256" "$DONE_REPORT_BYTES" || fatal "SEALED_OBSERVER_REPORT_IDENTITY_OR_DONE_BINDING_FAILED"
SEALED_REPORT_SNAPSHOT="$SNAPSHOT_PATH"
report_uuid_and_terminal_binding "$SEALED_REPORT_SNAPSHOT" || fatal "OBSERVER_REPORT_UUID_OR_TERMINAL_BINDING_FAILED"
emit "OBSERVER_REPORT_DONE_SHA_BYTES_UUID_TERMINAL_BINDING=PASS"

HELPER_OUTPUT_PRESENT=0
if /usr/bin/sudo -n /bin/test -e "$HELPER_OUTPUT" || /usr/bin/sudo -n /bin/test -L "$HELPER_OUTPUT"; then
  HELPER_OUTPUT_PRESENT=1
  if [[ "$DONE_ARTIFACT_REASON" == "HELPER_OUTPUT_NOT_REGULAR" ]]; then
    if root_regular_not_symlink "$HELPER_OUTPUT"; then
      fatal "HELPER_OUTPUT_NOT_REGULAR_REASON_CONTRADICTED"
    fi
    emit "HELPER_OUTPUT_NOT_REGULAR_NEGATIVE_PREDICATE=PASS"
    emit "HELPER_OUTPUT_RAW_COPY=UNSAFE_IDENTITY_SOURCE_PRESERVED_IN_PLACE"
  elif [[ "$DONE_ARTIFACT_REASON" == "HELPER_OUTPUT_PREEXISTING" ]]; then
    if snapshot_root_file HELPER_OUTPUT_PREEXISTING "$HELPER_OUTPUT" 400,600 \
      "$MAX_HELPER_OUTPUT_BYTES" ANY; then
      HELPER_OUTPUT_SNAPSHOT="$SNAPSHOT_PATH"
      append_snapshot HELPER_OUTPUT_PREEXISTING "$HELPER_OUTPUT_SNAPSHOT"
    else
      emit "HELPER_OUTPUT_PREEXISTING_RAW_COPY=UNSAFE_OR_UNSTABLE_SOURCE_PRESERVED_IN_PLACE"
    fi
  else
    snapshot_root_file HELPER_OUTPUT "$HELPER_OUTPUT" 400,600 \
      "$MAX_HELPER_OUTPUT_BYTES" ANY || fatal "HELPER_OUTPUT_IDENTITY_FAILED"
  HELPER_OUTPUT_SNAPSHOT="$SNAPSHOT_PATH"
  HELPER_OUTPUT_SHA256_ACTUAL="$SNAPSHOT_SHA256"
  HELPER_OUTPUT_BYTES_ACTUAL="$SNAPSHOT_BYTES"
  HELPER_OUTPUT_MODE_ACTUAL="$SNAPSHOT_MODE"
  HELPER_OUTPUT_FLAGS_ACTUAL="$SNAPSHOT_FLAGS"
  HELPER_SHA_MARKER_COUNT="$(/usr/bin/grep -Ec '^HELPER_OUTPUT_SHA256=' "$SEALED_REPORT_SNAPSHOT" || true)"
  HELPER_BYTES_MARKER_COUNT="$(/usr/bin/grep -Ec '^HELPER_OUTPUT_BYTES=' "$SEALED_REPORT_SNAPSHOT" || true)"
  HELPER_BEGIN_COUNT="$(/usr/bin/grep -Fxc '===== BEGIN EXACT D97AEX HELPER OUTPUT =====' "$SEALED_REPORT_SNAPSHOT" || true)"
  HELPER_END_COUNT="$(/usr/bin/grep -Fxc '===== END EXACT D97AEX HELPER OUTPUT =====' "$SEALED_REPORT_SNAPSHOT" || true)"
  if [[ "$HELPER_SHA_MARKER_COUNT:$HELPER_BYTES_MARKER_COUNT" == "1:1" ]]; then
    report_key_value_once "$SEALED_REPORT_SNAPSHOT" HELPER_OUTPUT_SHA256 "$HELPER_OUTPUT_SHA256_ACTUAL" || \
      fatal "HELPER_OUTPUT_REPORT_SHA_BINDING_FAILED"
    report_key_value_once "$SEALED_REPORT_SNAPSHOT" HELPER_OUTPUT_BYTES "$HELPER_OUTPUT_BYTES_ACTUAL" || \
      fatal "HELPER_OUTPUT_REPORT_BYTES_BINDING_FAILED"
  elif [[ "$HELPER_SHA_MARKER_COUNT:$HELPER_BYTES_MARKER_COUNT" != "0:0" ]]; then
    fatal "HELPER_OUTPUT_REPORT_SHA_BYTES_MARKER_CARDINALITY_FAILED"
  fi
  if [[ "$HELPER_BEGIN_COUNT:$HELPER_END_COUNT" == "1:1" ]]; then
    bind_embedded_helper_output "$SEALED_REPORT_SNAPSHOT" "$HELPER_OUTPUT_SNAPSHOT" \
      "$HELPER_OUTPUT_SHA256_ACTUAL" "$HELPER_OUTPUT_BYTES_ACTUAL" || \
      fatal "HELPER_OUTPUT_EXACT_EMBEDDED_REPORT_BINDING_FAILED"
    emit "HELPER_OUTPUT_EXACT_EMBEDDED_REPORT_BINDING=PASS"
  elif [[ "$HELPER_BEGIN_COUNT:$HELPER_END_COUNT" != "0:0" && \
          "$DONE_ARTIFACT_REASON" != "HELPER_OUTPUT_APPEND_FAILED" ]]; then
    fatal "HELPER_OUTPUT_EMBEDDED_BOUNDARY_CARDINALITY_FAILED"
  fi
  case "$DONE_RUNNER_RESULT:$DONE_ARTIFACT_REASON" in
    OBSERVED_COHORT_BOUNDED_PROVENANCE_MATCH:NONE|HELPER_FAIL_CLOSED:NONE|\
    COVERAGE_INCOMPLETE_STOP:NONE|OBSERVED_COHORT_BOUNDED_PROVENANCE_MISMATCH:NONE|\
    UNEXPECTED_HELPER_RC_FAIL_CLOSED:UNEXPECTED_HELPER_RC|\
    WATCHDOG_TIMEOUT_UNKNOWN:WATCHDOG_EXPIRED|\
    WATCHDOG_TIMEOUT_UNKNOWN:HELPER_OUTPUT_GREP_FAILED|\
    WATCHDOG_TIMEOUT_UNKNOWN:TERMINAL_CONTRACT_OR_POST_IDENTITY_FAILED|\
    FAIL_CLOSED:HELPER_OUTPUT_GREP_FAILED|\
    FAIL_CLOSED:TERMINAL_CONTRACT_OR_POST_IDENTITY_FAILED)
      [[ "$HELPER_OUTPUT_MODE_ACTUAL" == "400" ]] || fatal "HELPER_OUTPUT_TERMINAL_MODE_NOT_400"
      (( (HELPER_OUTPUT_FLAGS_ACTUAL & 2) == 2 )) || fatal "HELPER_OUTPUT_TERMINAL_IMMUTABLE_FLAG_MISSING"
      [[ "$HELPER_SHA_MARKER_COUNT:$HELPER_BYTES_MARKER_COUNT:$HELPER_BEGIN_COUNT:$HELPER_END_COUNT" == \
         "1:1:1:1" ]] || fatal "HELPER_OUTPUT_TERMINAL_REPORT_BINDING_INCOMPLETE"
      ;;
  esac
  case "$DONE_ARTIFACT_REASON" in
    HELPER_OUTPUT_MODE_FAILED)
      [[ "$HELPER_OUTPUT_MODE_ACTUAL" != "400" ]] || fatal "HELPER_OUTPUT_MODE_FAILED_REASON_CONTRADICTED"
      ;;
    HELPER_OUTPUT_IMMUTABLE_FAILED)
      [[ "$HELPER_OUTPUT_MODE_ACTUAL" == "400" ]] || fatal "HELPER_OUTPUT_IMMUTABLE_FAILED_MODE_NOT_400"
      (( (HELPER_OUTPUT_FLAGS_ACTUAL & 2) == 0 )) || fatal "HELPER_OUTPUT_IMMUTABLE_FAILED_REASON_CONTRADICTED"
      ;;
    HELPER_OUTPUT_SYNC_FAILED)
      [[ "$HELPER_OUTPUT_MODE_ACTUAL" == "400" ]] || fatal "HELPER_OUTPUT_SYNC_FAILED_MODE_NOT_400"
      (( (HELPER_OUTPUT_FLAGS_ACTUAL & 2) == 2 )) || fatal "HELPER_OUTPUT_SYNC_FAILED_IMMUTABLE_FLAG_MISSING"
      ;;
  esac
  append_snapshot HELPER_OUTPUT "$HELPER_OUTPUT_SNAPSHOT"
  fi
else
  emit "HELPER_OUTPUT=ABSENT"
fi

if [[ "$DONE_HELPER_RC" =~ '^[0-9]+$' && "$HELPER_OUTPUT_PRESENT" != "1" ]]; then
  fatal "NUMERIC_HELPER_RC_WITHOUT_HELPER_OUTPUT"
fi
if [[ "$DONE_HELPER_RC" == "NOT_RUN" && "$DONE_ARTIFACT_REASON" == "HELPER_OUTPUT_PREEXISTING" && \
      "$HELPER_OUTPUT_PRESENT" != "1" ]]; then
  fatal "HELPER_OUTPUT_PREEXISTING_REASON_WITHOUT_ARTIFACT"
fi

WATCHDOG_MARKER_PRESENT=0
if /usr/bin/sudo -n /bin/test -e "$WATCHDOG_MARKER" || /usr/bin/sudo -n /bin/test -L "$WATCHDOG_MARKER"; then
  WATCHDOG_MARKER_PRESENT=1
  if [[ "$DONE_RUNNER_REASON" == "WATCHDOG_MARKER_INVALID" ]]; then
    if root_regular_not_symlink "$WATCHDOG_MARKER" && \
       [[ "$(/usr/bin/sudo -n /usr/bin/stat -f '%u:%g:%l' "$WATCHDOG_MARKER")" == "0:0:1" ]]; then
      fatal "WATCHDOG_MARKER_INVALID_REASON_CONTRADICTED_BY_RUNNER_IDENTITY_PREDICATE"
    fi
    emit "WATCHDOG_MARKER_INVALID_NEGATIVE_PREDICATE=PASS"
    emit "WATCHDOG_MARKER_RAW_COPY=UNSAFE_IDENTITY_SOURCE_PRESERVED_IN_PLACE"
  elif [[ "$DONE_RUNNER_REASON" == "WATCHDOG_MARKER_PREEXISTING" ]]; then
    if snapshot_root_file WATCHDOG_MARKER_PREEXISTING "$WATCHDOG_MARKER" 400,600 \
      "$MAX_WATCHDOG_MARKER_BYTES" ANY; then
      WATCHDOG_SNAPSHOT="$SNAPSHOT_PATH"
      append_snapshot WATCHDOG_MARKER_PREEXISTING "$WATCHDOG_SNAPSHOT"
    else
      emit "WATCHDOG_MARKER_PREEXISTING_RAW_COPY=UNSAFE_OR_UNSTABLE_SOURCE_PRESERVED_IN_PLACE"
    fi
  else
    snapshot_root_file WATCHDOG_MARKER "$WATCHDOG_MARKER" 400,600 \
      "$MAX_WATCHDOG_MARKER_BYTES" ANY || fatal "WATCHDOG_MARKER_IDENTITY_FAILED"
    WATCHDOG_SNAPSHOT="$SNAPSHOT_PATH"
    WATCHDOG_MODE_ACTUAL="$SNAPSHOT_MODE"
    WATCHDOG_FLAGS_ACTUAL="$SNAPSHOT_FLAGS"
    validate_watchdog_marker_schema "$WATCHDOG_SNAPSHOT" || fatal "WATCHDOG_MARKER_SCHEMA_OR_CLAIM_UUID_BINDING_FAILED"
    emit "WATCHDOG_MARKER_SCHEMA_AND_CLAIM_UUID_BINDING=PASS"
    case "$DONE_RUNNER_REASON" in
      WATCHDOG_EXPIRED)
        [[ "$WATCHDOG_MODE_ACTUAL" == "400" ]] || fatal "WATCHDOG_MARKER_TERMINAL_MODE_NOT_400"
        (( (WATCHDOG_FLAGS_ACTUAL & 2) == 2 )) || fatal "WATCHDOG_MARKER_TERMINAL_IMMUTABLE_FLAG_MISSING"
        ;;
      WATCHDOG_MARKER_MODE_FAILED)
        [[ "$WATCHDOG_MODE_ACTUAL" != "400" ]] || fatal "WATCHDOG_MARKER_MODE_FAILED_REASON_CONTRADICTED"
        ;;
      WATCHDOG_MARKER_IMMUTABLE_FAILED)
        [[ "$WATCHDOG_MODE_ACTUAL" == "400" ]] || fatal "WATCHDOG_MARKER_IMMUTABLE_FAILED_MODE_NOT_400"
        (( (WATCHDOG_FLAGS_ACTUAL & 2) == 0 )) || fatal "WATCHDOG_MARKER_IMMUTABLE_FAILED_REASON_CONTRADICTED"
        ;;
      WATCHDOG_MARKER_WITHOUT_TIMEOUT_SIGNAL)
        [[ "$WATCHDOG_MODE_ACTUAL" == "600" ]] || fatal "WATCHDOG_MARKER_WITHOUT_SIGNAL_MODE_NOT_600"
        (( (WATCHDOG_FLAGS_ACTUAL & 2) == 0 )) || fatal "WATCHDOG_MARKER_WITHOUT_SIGNAL_UNEXPECTED_IMMUTABILITY"
        ;;
      WATCHDOG_PLUS:*)
        [[ "$WATCHDOG_MODE_ACTUAL" == "400" ]] || fatal "WATCHDOG_PLUS_MARKER_MODE_NOT_400"
        (( (WATCHDOG_FLAGS_ACTUAL & 2) == 2 )) || fatal "WATCHDOG_PLUS_MARKER_IMMUTABLE_FLAG_MISSING"
        ;;
      SIGNAL_AFTER_WATCHDOG:*)
        if [[ "$WATCHDOG_MODE_ACTUAL" == "400" ]]; then
          (( (WATCHDOG_FLAGS_ACTUAL & 2) == 2 )) || fatal "SIGNAL_AFTER_WATCHDOG_MODE400_WITHOUT_IMMUTABILITY"
        elif [[ "$WATCHDOG_MODE_ACTUAL" == "600" ]]; then
          (( (WATCHDOG_FLAGS_ACTUAL & 2) == 0 )) || fatal "SIGNAL_AFTER_WATCHDOG_MODE600_WITH_IMMUTABILITY"
        else
          fatal "SIGNAL_AFTER_WATCHDOG_MARKER_MODE_INVALID"
        fi
        ;;
      *) fatal "WATCHDOG_MARKER_PRESENT_WITHOUT_ALLOWED_DONE_STATE" ;;
    esac
    append_snapshot WATCHDOG_MARKER "$WATCHDOG_SNAPSHOT"
  fi
else
  emit "WATCHDOG_MARKER=ABSENT"
fi

if [[ "$DONE_WATCHDOG_FIRED" == "1" && "$WATCHDOG_MARKER_PRESENT" != "1" ]]; then
  fatal "WATCHDOG_FIRED_WITHOUT_MARKER"
fi
if [[ "$DONE_WATCHDOG_FIRED" == "0" && \
      "$DONE_RUNNER_REASON" =~ '^(WATCHDOG_MARKER_PREEXISTING|WATCHDOG_MARKER_WITHOUT_TIMEOUT_SIGNAL)$' && \
      "$WATCHDOG_MARKER_PRESENT" != "1" ]]; then
  fatal "WATCHDOG_MARKER_REASON_WITHOUT_MARKER"
fi
append_snapshot OBSERVER_REPORT "$SEALED_REPORT_SNAPSHOT"

if [[ "$(/usr/bin/stat -f 'DEV=%d|INO=%i' "$REPORT")" != "$REPORT_DEV_INODE" || \
      "$(/usr/bin/stat -f 'DEV=%d|INO=%i' /dev/fd/3)" != "$REPORT_FD_DEV_INODE" || \
      "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$REPORT")" != "$LOGIN_UID:$LOGIN_GID:600:1" || \
      "$(/usr/bin/stat -f '%u:%g:%Lp:%l' /dev/fd/3)" != "$LOGIN_UID:$LOGIN_GID:600:1" ]]; then
  fatal "FINAL_DESKTOP_REPORT_PATH_FD_IDENTITY_FAILED"
fi
emit "DESKTOP_REPORT_PATH_FD_IDENTITY=PASS"

if [[ "$RETRIEVAL_BOOT_UUID" == "$CLAIMED_BOOT_UUID" ]]; then
  emit "SEALED_RECORD_RETRIEVED=PASS"
  unknown_stop "SEALED_RECORD_RETRIEVED_FROM_SAME_CLAIMED_BOOT_CHRONOLOGY_NOT_BOUND"
fi

emit "OBSERVER_HELPER_RC=$DONE_HELPER_RC"
emit "OBSERVER_HELPER_MAPPING=$DONE_HELPER_MAPPING"
emit "OBSERVER_WATCHDOG_FIRED=$DONE_WATCHDOG_FIRED"
emit "OBSERVER_RUNNER_RESULT=$DONE_RUNNER_RESULT"
emit "OBSERVER_RUNNER_RC=$DONE_RUNNER_RC"
emit "SEALED_RECORD_RETRIEVED=PASS"
emit "D97AEZ_RETRIEVE_RESULT=SEALED_OBSERVER_RECORD_RETRIEVED"
emit "CLAIMED_BOOT_LANE=UNCLASSIFIED"
emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
emit "BOOT_LANE_BINDING=USER_AUTHORIZED_CHRONOLOGY_REQUIRED"
emit "TARGETED_BOOT_CALLED_ACCELERATED=AUTO-NO"
emit "OBSERVER_REMOVAL=AUTO-NO"
emit "NEXT_ACTION=AUTHORITATIVE_REVIEW_BEFORE_ANY_OBSERVER_REMOVAL_OR_NEW_PATCH"
emit "REPORT=$REPORT"
exit 0
