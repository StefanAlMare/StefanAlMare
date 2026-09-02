#!/bin/zsh -f

# OCLP7 D97AEZ -- root, boot-bound, passive, one-shot D97AEX runner.
#
# The VESA-side installer creates the immutable DEPLOY_RECORD consumed here. The
# runner claims exactly the first later boot before doing any other production
# work. CLAIM is intentionally never removed: an interrupted or failed run
# must never be retried by a later boot.

emulate -LR zsh
set -euo pipefail
umask 077

readonly NAME="OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT"
readonly LABEL="com.stefanalmare.oclp7.d97aez.boot-bound-one-shot"
readonly INSTALL_DIR="/Library/Application Support/OCLP7-D97AEZ"
readonly STATE_DIR="/var/db/OCLP7-D97AEZ"
readonly RUNNER="$INSTALL_DIR/OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT_RUNNER.command"
readonly HELPER="$INSTALL_DIR/OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER"
readonly PLIST="/Library/LaunchDaemons/${LABEL}.plist"
readonly DEPLOY_RECORD="$STATE_DIR/DEPLOY_RECORD"
readonly CLAIM="$STATE_DIR/CLAIM"
readonly REPORT="$STATE_DIR/OCLP7_D97AEZ_BOOT_BOUND_REPORT.partial"
readonly REPORT_MAX_BYTES="16777216"
readonly DONE="$STATE_DIR/DONE"
readonly HELPER_OUTPUT="$STATE_DIR/D97AEX_HELPER_OUTPUT.partial"
readonly HELPER_OUTPUT_MAX_BYTES="8388608"
readonly WATCHDOG_MARKER="$STATE_DIR/WATCHDOG_TIMEOUT"
readonly WATCHDOG_SECONDS="150"

readonly PRODUCT_VERSION_EXPECTED="26.6.2"
readonly BUILD_VERSION_EXPECTED="25G82"
readonly ARCHITECTURE_EXPECTED="x86_64"
readonly HELPER_SHA256_EXPECTED="f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9"
readonly HELPER_BYTES_EXPECTED="94928"
readonly HELPER_MODE_EXPECTED="500"
readonly SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
readonly SERVICE_SHA256_EXPECTED="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
readonly SERVICE_BYTES_EXPECTED="85520"
readonly SERVICE_MODE_EXPECTED="755"
readonly TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
readonly TARGET_SHA256_EXPECTED="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
readonly TARGET_BYTES_EXPECTED="1636896"
readonly TARGET_MODE_EXPECTED="755"

readonly MATCH_MARKER="D97AEX_RESULT=OBSERVED_COHORT_BOUNDED_31_WINDOW_PROVENANCE_MATCH"
readonly INCOMPLETE_MARKER="D97AEX_RESULT=COVERAGE_INCOMPLETE_STOP"
readonly MISMATCH_MARKER="D97AEX_RESULT=OBSERVED_COHORT_BOUNDED_31_WINDOW_PROVENANCE_MISMATCH"

# Safety contract: this executable only hashes installed files, reads process
# memory through the unchanged D97AEX helper, and writes its own bounded state.
# It contains no network operation and performs no OCLP, Root Patch, reboot,
# launchd manipulation, or target-service launch/stop/control operation.

startup_emit() {
  print -r -- "$*"
}

startup_stop() {
  local reason="$1" rc="${2:-2}"
  startup_emit "D97AEZ_STARTUP_RESULT=STOP|REASON=$reason|RC=$rc"
  exit "$rc"
}

(( $# == 0 )) || startup_stop "ARGUMENTS_NOT_ALLOWED"
for early_tool in /bin/cat /bin/mkdir /usr/bin/id /usr/bin/stat /usr/bin/wc \
  /usr/sbin/sysctl; do
  [[ -x "$early_tool" ]] || startup_stop "EARLY_TOOL_MISSING:$early_tool"
done
[[ "$(/usr/bin/id -u)" == "0" ]] || startup_stop "ROOT_REQUIRED"

safe_directory() {
  local path="$1"
  [[ -d "$path" && ! -L "$path" ]] || return 1
  [[ "$(/usr/bin/stat -f '%u:%g:%Lp' "$path")" == "0:0:700" ]] || return 1
}

safe_deploy_record_file() {
  local stat_before stat_after flags
  [[ -f "$DEPLOY_RECORD" && ! -L "$DEPLOY_RECORD" ]] || return 1
  stat_before="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l|FLAGS=%f' "$DEPLOY_RECORD")" || return 1
  [[ "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$DEPLOY_RECORD")" == "0:0:400:1" ]] || return 1
  flags="$(/usr/bin/stat -f '%f' "$DEPLOY_RECORD")" || return 1
  (( (flags & 2) == 2 )) || return 1
  (( $(/usr/bin/stat -f '%z' "$DEPLOY_RECORD") > 0 && $(/usr/bin/stat -f '%z' "$DEPLOY_RECORD") <= 8192 )) || return 1
  stat_after="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l|FLAGS=%f' "$DEPLOY_RECORD")" || return 1
  [[ "$stat_before" == "$stat_after" ]]
}

safe_directory "$STATE_DIR" || startup_stop "STATE_DIRECTORY_IDENTITY_FAILED"

# Existing CLAIM or DONE is an unconditional no-rerun stop, including damaged
# or symlinked state.  Nothing is removed, repaired, or overwritten here.
if [[ -e "$CLAIM" || -L "$CLAIM" || -e "$DONE" || -L "$DONE" ]]; then
  exit 0
fi

startup_emit "===== OCLP7 D97AEZ LAUNCHD STARTUP ====="
startup_emit "RUNNER=$NAME"
startup_emit "ARCHITECTURE_CONTRACT=INTEL_X86_64_ONLY"

safe_deploy_record_file || startup_stop "DEPLOY_RECORD_IDENTITY_FAILED"

typeset -a DEPLOY_LINES
DEPLOY_CONTENT="$(/bin/cat "$DEPLOY_RECORD")" || \
  startup_stop "DEPLOY_RECORD_READ_FAILED"
DEPLOY_LINES=("${(@f)DEPLOY_CONTENT}")
(( ${#DEPLOY_LINES} >= 3 )) || startup_stop "DEPLOY_RECORD_TOO_SHORT_FOR_BOOT_BINDING"
[[ "$DEPLOY_LINES[1]" == "D97AEZ_DEPLOY_RECORD_SCHEMA=1" ]] || \
  startup_stop "DEPLOY_RECORD_BOOT_BINDING_SCHEMA_INVALID"
[[ "$DEPLOY_LINES[2]" == "D97AEZ_DEPLOY_RECORD_STATE=ACTIVATED_IN_VESA" ]] || \
  startup_stop "DEPLOY_RECORD_BOOT_BINDING_STATE_INVALID"
readonly ACTIVATION_BOOT_UUID="${DEPLOY_LINES[3]#ACTIVATION_BOOT_UUID=}"
[[ "$DEPLOY_LINES[3]" == "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID" && \
   "$ACTIVATION_BOOT_UUID" =~ '^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$' ]] || \
  startup_stop "DEPLOY_RECORD_BOOT_UUID_INVALID"

typeset RUNNER_SHA256_EXPECTED=""
typeset RUNNER_BYTES_EXPECTED=""
typeset PLIST_SHA256_EXPECTED=""
typeset PLIST_BYTES_EXPECTED=""

validate_deploy_record() {
  local physical_line_count
  physical_line_count="$(/usr/bin/wc -l < "$DEPLOY_RECORD")" || return 1
  (( physical_line_count == 35 )) || return 1
  (( ${#DEPLOY_LINES} == 35 )) || return 1
  [[ "$DEPLOY_LINES[1]" == "D97AEZ_DEPLOY_RECORD_SCHEMA=1" ]] || return 1
  [[ "$DEPLOY_LINES[2]" == "D97AEZ_DEPLOY_RECORD_STATE=ACTIVATED_IN_VESA" ]] || return 1
  [[ "$DEPLOY_LINES[3]" == "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID" ]] || return 1
  [[ "$DEPLOY_LINES[4]" == "PRODUCT_VERSION_EXPECTED=$PRODUCT_VERSION_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[5]" == "BUILD_VERSION_EXPECTED=$BUILD_VERSION_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[6]" == "ARCHITECTURE_EXPECTED=$ARCHITECTURE_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[7]" == "RUNNER_PATH=$RUNNER" ]] || return 1
  RUNNER_SHA256_EXPECTED="${DEPLOY_LINES[8]#RUNNER_SHA256=}"
  RUNNER_BYTES_EXPECTED="${DEPLOY_LINES[9]#RUNNER_BYTES=}"
  [[ "$DEPLOY_LINES[8]" == "RUNNER_SHA256=$RUNNER_SHA256_EXPECTED" && \
     "$RUNNER_SHA256_EXPECTED" =~ '^[0-9a-f]{64}$' ]] || return 1
  [[ "$DEPLOY_LINES[9]" == "RUNNER_BYTES=$RUNNER_BYTES_EXPECTED" && \
     "$RUNNER_BYTES_EXPECTED" =~ '^[1-9][0-9]*$' ]] || return 1
  [[ "$DEPLOY_LINES[10]" == "RUNNER_MODE=500" ]] || return 1
  [[ "$DEPLOY_LINES[11]" == "HELPER_PATH=$HELPER" ]] || return 1
  [[ "$DEPLOY_LINES[12]" == "HELPER_SHA256=$HELPER_SHA256_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[13]" == "HELPER_BYTES=$HELPER_BYTES_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[14]" == "HELPER_MODE=$HELPER_MODE_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[15]" == "PLIST_PATH=$PLIST" ]] || return 1
  PLIST_SHA256_EXPECTED="${DEPLOY_LINES[16]#PLIST_SHA256=}"
  PLIST_BYTES_EXPECTED="${DEPLOY_LINES[17]#PLIST_BYTES=}"
  [[ "$DEPLOY_LINES[16]" == "PLIST_SHA256=$PLIST_SHA256_EXPECTED" && \
     "$PLIST_SHA256_EXPECTED" =~ '^[0-9a-f]{64}$' ]] || return 1
  [[ "$DEPLOY_LINES[17]" == "PLIST_BYTES=$PLIST_BYTES_EXPECTED" && \
     "$PLIST_BYTES_EXPECTED" =~ '^[1-9][0-9]*$' ]] || return 1
  [[ "$DEPLOY_LINES[18]" == "PLIST_MODE=644" ]] || return 1
  [[ "$DEPLOY_LINES[19]" == "SERVICE_PATH=$SERVICE" ]] || return 1
  [[ "$DEPLOY_LINES[20]" == "SERVICE_SHA256=$SERVICE_SHA256_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[21]" == "SERVICE_BYTES=$SERVICE_BYTES_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[22]" == "SERVICE_MODE=$SERVICE_MODE_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[23]" == "TARGET_PATH=$TARGET" ]] || return 1
  [[ "$DEPLOY_LINES[24]" == "TARGET_SHA256=$TARGET_SHA256_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[25]" == "TARGET_BYTES=$TARGET_BYTES_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[26]" == "TARGET_MODE=$TARGET_MODE_EXPECTED" ]] || return 1
  [[ "$DEPLOY_LINES[27]" == "WATCH_DURATION_SECONDS=120" ]] || return 1
  [[ "$DEPLOY_LINES[28]" == "WATCH_INTERVAL_MILLISECONDS=25" ]] || return 1
  [[ "$DEPLOY_LINES[29]" == "WATCH_MINIMUM_COMPLETE=3" ]] || return 1
  [[ "$DEPLOY_LINES[30]" == "SERVICE_LAUNCH=AUTO-NO" ]] || return 1
  [[ "$DEPLOY_LINES[31]" == "SERVICE_STOP=AUTO-NO" ]] || return 1
  [[ "$DEPLOY_LINES[32]" == "TARGET_PROCESS_CONTROL_MUTATION=NO" ]] || return 1
  [[ "$DEPLOY_LINES[33]" == "ROOT_PATCH=AUTO-NO" ]] || return 1
  [[ "$DEPLOY_LINES[34]" == "REBOOT=AUTO-NO" ]] || return 1
  [[ "$DEPLOY_LINES[35]" == "D97AEZ_DEPLOY_RECORD_END=END" ]] || return 1
  return 0
}

CURRENT_BOOT_UUID="$(/usr/sbin/sysctl -n kern.bootsessionuuid)" || \
  startup_stop "CURRENT_BOOT_UUID_QUERY_FAILED"
readonly CURRENT_BOOT_UUID
[[ "$CURRENT_BOOT_UUID" =~ '^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$' ]] || \
  startup_stop "CURRENT_BOOT_UUID_INVALID"
startup_emit "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"
startup_emit "CURRENT_BOOT_UUID=$CURRENT_BOOT_UUID"

# RunAtLoad in the VESA activation boot is deliberately a no-op. DEPLOY_RECORD remains in
# place so the same loaded job can claim the first boot with a different UUID.
if [[ "$CURRENT_BOOT_UUID" == "$ACTIVATION_BOOT_UUID" ]]; then
  if validate_deploy_record; then
    startup_emit "D97AEZ_STARTUP_RESULT=SAME_ACTIVATION_BOOT_SKIP|DEPLOY_RECORD=PASS"
    exit 0
  fi
  startup_stop "SAME_ACTIVATION_BOOT_RECORD_VALIDATION_FAILED"
fi

# mkdir is the atomic one-shot claim. From this point onward every outcome,
# including interruption or a failed identity gate, permanently consumes the activation.
claim_phase_interrupt_stop() {
  local signal_name="$1" signal_rc="$2"
  trap '' HUP INT TERM
  if [[ -d "$CLAIM" && ! -L "$CLAIM" ]]; then
    startup_emit "D97AEZ_EARLY_CLAIM_INTERRUPTED=$signal_name|CLAIM_DIRECTORY_PRESENT=YES|RERUN_ALLOWED=NO"
  else
    startup_emit "D97AEZ_EARLY_CLAIM_INTERRUPTED=$signal_name|CLAIM_DIRECTORY_PRESENT=NO"
  fi
  exit "$signal_rc"
}
trap 'claim_phase_interrupt_stop HUP 129' HUP
trap 'claim_phase_interrupt_stop INT 130' INT
trap 'claim_phase_interrupt_stop TERM 143' TERM

if ! /bin/mkdir "$CLAIM"; then
  if [[ -d "$CLAIM" && ! -L "$CLAIM" ]]; then
    startup_emit "D97AEZ_STARTUP_RESULT=NO_RERUN_CLAIM_RACE"
    exit 0
  fi
  startup_stop "CLAIM_DIRECTORY_CREATE_FAILED"
fi

# NOCLOBBER makes the partial report exclusive.  A pre-existing artifact is a
# fail-closed consumed run; it is never truncated or replaced.
setopt NOCLOBBER
[[ ! -e "$REPORT" && ! -L "$REPORT" ]] || \
  startup_stop "CLAIMED_REPORT_PREEXISTING_ARTIFACT"
if ! exec 3> "$REPORT"; then
  startup_stop "CLAIMED_REPORT_EXCLUSIVE_CREATE_FAILED"
fi

emit() {
  print -r -- "$*" >&3
}

claimed_stop() {
  local reason="$1" rc="${2:-2}"
  trap '' HUP INT TERM USR1
  emit "D97AEZ_CLAIMED_STOP=$reason"
  emit "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"
  emit "CLAIMED_BOOT_UUID=$CURRENT_BOOT_UUID"
  emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
  emit "D97AEZ_RERUN_ALLOWED=NO"
  exec 3>&-
  /bin/sync 2>/dev/null || true
  /bin/chmod 0400 "$REPORT" 2>/dev/null || true
  /usr/bin/chflags uchg "$REPORT" 2>/dev/null || true
  startup_emit "D97AEZ_STARTUP_RESULT=CLAIMED_STOP|REASON=$reason|RC=$rc"
  exit "$rc"
}

early_interrupt_stop() {
  local signal_name="$1" signal_rc="$2"
  claimed_stop "INTERRUPTED_BEFORE_HELPER:$signal_name" "$signal_rc"
}

trap 'early_interrupt_stop HUP 129' HUP
trap 'early_interrupt_stop INT 130' INT
trap 'early_interrupt_stop TERM 143' TERM

for tool in /bin/cat /bin/chmod /bin/date /bin/kill /bin/mkdir /bin/mv \
  /bin/sleep /bin/sync /bin/zsh /usr/bin/env /usr/bin/grep /usr/bin/id \
  /usr/bin/chflags /usr/bin/mktemp /usr/bin/shasum /usr/bin/stat \
  /usr/bin/sw_vers /usr/bin/tail /usr/bin/uname /usr/bin/wc \
  /usr/sbin/sysctl; do
  [[ -x "$tool" ]] || claimed_stop "REQUIRED_TOOL_MISSING:$tool"
done
safe_directory "$INSTALL_DIR" || claimed_stop "INSTALL_DIRECTORY_IDENTITY_FAILED"
validate_deploy_record || claimed_stop "DEPLOY_RECORD_FULL_VALIDATION_FAILED"
CLAIM_EPOCH="$(/bin/date +%s)" || claimed_stop "CLAIM_EPOCH_QUERY_FAILED"
[[ "$CLAIM_EPOCH" =~ '^[0-9]+$' ]] || claimed_stop "CLAIM_EPOCH_INVALID"

{
  print -r -- "D97AEZ_CLAIM_SCHEMA=1"
  print -r -- "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"
  print -r -- "CLAIMED_BOOT_UUID=$CURRENT_BOOT_UUID"
  print -r -- "CLAIM_EPOCH=$CLAIM_EPOCH"
  print -r -- "D97AEZ_CLAIM_END=END"
} > "$CLAIM/RECORD" || claimed_stop "CLAIM_RECORD_WRITE_FAILED"
/bin/chmod 0400 "$CLAIM/RECORD" || claimed_stop "CLAIM_RECORD_MODE_FAILED"
/usr/bin/chflags uchg "$CLAIM/RECORD" || claimed_stop "CLAIM_RECORD_IMMUTABLE_FAILED"
/bin/chmod 0500 "$CLAIM" || claimed_stop "CLAIM_DIRECTORY_MODE_FAILED"
/usr/bin/chflags uchg "$CLAIM" || claimed_stop "CLAIM_DIRECTORY_IMMUTABLE_FAILED"
/bin/sync || claimed_stop "CLAIM_DURABILITY_SYNC_FAILED"

REPORT_OPEN=1
HELPER_PID=0
WATCHDOG_PID=0
WATCHDOG_FIRED=0

emit "===== OCLP7 D97AEZ BOOT-BOUND ONE-SHOT ====="
emit "RUNNER=$NAME"
emit "LABEL=$LABEL"
emit "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID"
emit "CLAIMED_BOOT_UUID=$CURRENT_BOOT_UUID"
emit "CLAIM_SCOPE=FIRST_BOOT_UUID_DIFFERENT_FROM_DEPLOY"
emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
emit "BOOT_LANE_BINDING=UUID_AND_USER_AUTHORIZED_CHRONOLOGY_REQUIRED"
emit "RERUN_AFTER_CLAIM_OR_DONE=AUTO-NO"
emit "WATCH_ARGUMENTS=--duration_120_--interval-ms_25_--min-complete_3"
emit "WATCHDOG_SECONDS=$WATCHDOG_SECONDS"
emit "WATCHDOG_CONTROL_SCOPE=OWN_HELPER_CHILD_ONLY"
emit "HELPER_OUTPUT_MAX_BYTES=$HELPER_OUTPUT_MAX_BYTES"
emit "REPORT_MAX_BYTES=$REPORT_MAX_BYTES"
emit "NETWORK=AUTO-NO"
emit "PYTHON=AUTO-NO"
emit "OCLP_APP_CONTROL=AUTO-NO"
emit "SYSTEM_FILE_MUTATION=OWN_INSTALL_AND_STATE_ONLY"
emit "GOLDEN_MUTATION=NO"
emit "TARGET_CODE_BYTES_MUTATION=NO"
emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
emit "SERVICE_LAUNCH=AUTO-NO"
emit "SERVICE_STOP=AUTO-NO"
emit "LAUNCHCTL=AUTO-NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"

sha256_file() {
  local raw
  raw="$(/usr/bin/shasum -a 256 "$1")" || return 1
  print -r -- "${raw%% *}"
}

identity_gate() {
  local stage="$1" label="$2" path="$3" expected_sha="$4"
  local expected_bytes="$5" expected_mode="$6"
  local stat_before stat_after actual_sha actual_bytes actual_mode owner_group_links
  if [[ ! -f "$path" || -L "$path" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=NOT_REGULAR_OR_SYMLINK" || return 1
    return 1
  fi
  stat_before="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$path")" || return 1
  actual_sha="$(sha256_file "$path")" || return 1
  stat_after="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$path")" || return 1
  actual_bytes="$(/usr/bin/stat -f '%z' "$path")" || return 1
  actual_mode="$(/usr/bin/stat -f '%Lp' "$path")" || return 1
  owner_group_links="$(/usr/bin/stat -f '%u:%g:%l' "$path")" || return 1
  emit "${stage}_${label}_STAT_BEFORE=$stat_before" || return 1
  emit "${stage}_${label}_SHA256=$actual_sha" || return 1
  emit "${stage}_${label}_STAT_AFTER=$stat_after" || return 1
  if [[ "$stat_before" != "$stat_after" || \
        "$owner_group_links" != "0:0:1" || \
        "$actual_sha" != "$expected_sha" || "$actual_bytes" != "$expected_bytes" || \
        "$actual_mode" != "$expected_mode" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL" || return 1
    return 1
  fi
  emit "${stage}_${label}_IDENTITY=PASS" || return 1
  return 0
}

seal_done() {
  local runner_result="$1" final_rc="$2" helper_rc="$3" helper_mapping="$4"
  local runner_reason="${5:-NONE}"
  local report_sha report_bytes report_stat_before report_stat_after
  local done_tmp done_lines done_stat

  set -e
  trap '' HUP INT TERM USR1
  if (( WATCHDOG_PID > 0 )); then
    /bin/kill -TERM "$WATCHDOG_PID" 2>/dev/null || true
    wait "$WATCHDOG_PID" 2>/dev/null || true
    WATCHDOG_PID=0
  fi
  emit "CLAIMED_BOOT_UUID_FINAL=$CURRENT_BOOT_UUID"
  emit "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE"
  emit "D97AEZ_HELPER_RC=$helper_rc"
  emit "D97AEZ_HELPER_MAPPING=$helper_mapping"
  emit "D97AEZ_RUNNER_RESULT=$runner_result"
  emit "D97AEZ_RUNNER_REASON=$runner_reason"
  emit "D97AEZ_RERUN_ALLOWED=NO"
  emit "REPORT_DURABILITY_SYNC=SYSTEM_WIDE_SYNC_REQUIRED"
  exec 3>&-
  REPORT_OPEN=0
  /bin/sync || exit 2

  [[ -f "$REPORT" && ! -L "$REPORT" ]] || exit 2
  report_stat_before="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$REPORT")" || exit 2
  report_sha="$(sha256_file "$REPORT")" || exit 2
  report_stat_after="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$REPORT")" || exit 2
  [[ "$report_stat_before" == "$report_stat_after" ]] || exit 2
  [[ "$(/usr/bin/stat -f '%u:%g:%l' "$REPORT")" == "0:0:1" ]] || exit 2
  report_bytes="$(/usr/bin/stat -f '%z' "$REPORT")" || exit 2
  (( report_bytes <= REPORT_MAX_BYTES )) || exit 2
  /bin/chmod 0400 "$REPORT" || exit 2
  /usr/bin/chflags uchg "$REPORT" || exit 2
  /bin/sync || exit 2

  # DONE is published only after a complete temporary record has been closed,
  # checked and synced. A power loss before the atomic rename leaves no DONE.
  done_tmp="$(/usr/bin/mktemp "$STATE_DIR/.DONE.XXXXXX")" || exit 2
  [[ -f "$done_tmp" && ! -L "$done_tmp" && \
     "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$done_tmp")" == "0:0:600:1" ]] || exit 2
  exec 4>| "$done_tmp" || exit 2
  print -r -- "D97AEZ_DONE_SCHEMA=1" >&4
  print -r -- "ACTIVATION_BOOT_UUID=$ACTIVATION_BOOT_UUID" >&4
  print -r -- "CLAIMED_BOOT_UUID=$CURRENT_BOOT_UUID" >&4
  print -r -- "REPORT_PATH=$REPORT" >&4
  print -r -- "REPORT_SHA256=$report_sha" >&4
  print -r -- "REPORT_BYTES=$report_bytes" >&4
  print -r -- "HELPER_RC=$helper_rc" >&4
  print -r -- "HELPER_MAPPING=$helper_mapping" >&4
  print -r -- "WATCHDOG_FIRED=$WATCHDOG_FIRED" >&4
  print -r -- "BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE" >&4
  print -r -- "RUNNER_RESULT=$runner_result" >&4
  print -r -- "RUNNER_REASON=$runner_reason" >&4
  print -r -- "RUNNER_RC=$final_rc" >&4
  print -r -- "D97AEZ_DONE_END=END" >&4
  exec 4>&-
  /bin/sync || exit 2
  done_lines="$(/usr/bin/wc -l < "$done_tmp")" || exit 2
  (( done_lines == 14 )) || exit 2
  [[ "$(/usr/bin/tail -n 1 "$done_tmp")" == "D97AEZ_DONE_END=END" ]] || exit 2
  /bin/chmod 0400 "$done_tmp" || exit 2
  done_stat="$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$done_tmp")" || exit 2
  [[ "$done_stat" == "0:0:400:1" ]] || exit 2
  [[ ! -e "$DONE" && ! -L "$DONE" ]] || exit 2
  /bin/mv "$done_tmp" "$DONE" || exit 2
  /bin/sync || exit 2
  [[ -f "$DONE" && ! -L "$DONE" && \
     "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$DONE")" == "0:0:400:1" ]] || exit 2
  /usr/bin/chflags uchg "$DONE" || exit 2
  /bin/sync || exit 2
  exit "$final_rc"
}

stop_owned_children() {
  if (( WATCHDOG_PID > 0 )); then
    /bin/kill -TERM "$WATCHDOG_PID" 2>/dev/null || true
    wait "$WATCHDOG_PID" 2>/dev/null || true
    WATCHDOG_PID=0
  fi
  if (( HELPER_PID > 0 )); then
    /bin/kill -TERM "$HELPER_PID" 2>/dev/null || true
    /bin/sleep 1 || true
    /bin/kill -KILL "$HELPER_PID" 2>/dev/null || true
    wait "$HELPER_PID" 2>/dev/null || true
    HELPER_PID=0
  fi
}

interrupt_stop() {
  local signal_name="$1" signal_rc="$2"
  trap '' HUP INT TERM USR1
  stop_owned_children
  set -e
  emit "D97AEZ_INTERRUPTED=$signal_name"
  if (( WATCHDOG_FIRED == 1 )); then
    seal_done "WATCHDOG_TIMEOUT_UNKNOWN" 2 "$HELPER_RC" "WATCHDOG_TIMEOUT" \
      "SIGNAL_AFTER_WATCHDOG:$signal_name"
  fi
  seal_done "INTERRUPTED_UNKNOWN" "$signal_rc" "INTERRUPTED" "INTERRUPTED" "SIGNAL:$signal_name"
}

watchdog_timeout() {
  trap '' USR1
  WATCHDOG_FIRED=1
  HELPER_RC=124
  if (( HELPER_PID > 0 )); then
    /bin/kill -TERM "$HELPER_PID" 2>/dev/null || true
    /bin/sleep 1 || true
    /bin/kill -KILL "$HELPER_PID" 2>/dev/null || true
    wait "$HELPER_PID" 2>/dev/null || true
    HELPER_PID=0
  fi
}

post_helper_fail() {
  local reason="$1" helper_mapping="${2:-INVALID}"
  if (( WATCHDOG_FIRED == 1 )); then
    seal_done "WATCHDOG_TIMEOUT_UNKNOWN" 2 "$HELPER_RC" "WATCHDOG_TIMEOUT" \
      "WATCHDOG_PLUS:$reason"
  fi
  seal_done "FAIL_CLOSED" 2 "$HELPER_RC" "$helper_mapping" "$reason"
}

trap 'interrupt_stop HUP 129' HUP
trap 'interrupt_stop INT 130' INT
trap 'interrupt_stop TERM 143' TERM
trap 'watchdog_timeout' USR1

PRODUCT_VERSION_ACTUAL="$(/usr/bin/sw_vers -productVersion)" || seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "PRODUCT_VERSION_QUERY_FAILED"
BUILD_VERSION_ACTUAL="$(/usr/bin/sw_vers -buildVersion)" || seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "BUILD_VERSION_QUERY_FAILED"
ARCHITECTURE_ACTUAL="$(/usr/bin/uname -m)" || seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "ARCHITECTURE_QUERY_FAILED"
emit "PRODUCT_VERSION_ACTUAL=$PRODUCT_VERSION_ACTUAL"
emit "BUILD_VERSION_ACTUAL=$BUILD_VERSION_ACTUAL"
emit "ARCHITECTURE_ACTUAL=$ARCHITECTURE_ACTUAL"
if [[ "$PRODUCT_VERSION_ACTUAL" != "$PRODUCT_VERSION_EXPECTED" || \
      "$BUILD_VERSION_ACTUAL" != "$BUILD_VERSION_EXPECTED" || \
      "$ARCHITECTURE_ACTUAL" != "$ARCHITECTURE_EXPECTED" ]]; then
  emit "OS_BUILD_ARCH_IDENTITY=FAIL"
  seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "OS_BUILD_ARCH_IDENTITY_FAILED"
fi
emit "OS_BUILD_ARCH_IDENTITY=PASS"

PRE_OK=1
identity_gate PRE RUNNER "$RUNNER" "$RUNNER_SHA256_EXPECTED" "$RUNNER_BYTES_EXPECTED" 500 || PRE_OK=0
identity_gate PRE HELPER "$HELPER" "$HELPER_SHA256_EXPECTED" "$HELPER_BYTES_EXPECTED" "$HELPER_MODE_EXPECTED" || PRE_OK=0
identity_gate PRE PLIST "$PLIST" "$PLIST_SHA256_EXPECTED" "$PLIST_BYTES_EXPECTED" 644 || PRE_OK=0
identity_gate PRE SERVICE "$SERVICE" "$SERVICE_SHA256_EXPECTED" "$SERVICE_BYTES_EXPECTED" "$SERVICE_MODE_EXPECTED" || PRE_OK=0
identity_gate PRE TARGET "$TARGET" "$TARGET_SHA256_EXPECTED" "$TARGET_BYTES_EXPECTED" "$TARGET_MODE_EXPECTED" || PRE_OK=0
if (( PRE_OK != 1 )); then
  seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "PRE_HELPER_IDENTITY_GATES_FAILED"
fi
emit "PRE_HELPER_IDENTITY_GATES=PASS"

[[ ! -e "$WATCHDOG_MARKER" && ! -L "$WATCHDOG_MARKER" ]] || \
  seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "WATCHDOG_MARKER_PREEXISTING"
[[ ! -e "$HELPER_OUTPUT" && ! -L "$HELPER_OUTPUT" ]] || \
  seal_done "PREFLIGHT_FAIL_CLOSED" 2 "NOT_RUN" "NONE" "HELPER_OUTPUT_PREEXISTING"

PARENT_PID=$$
HELPER_RC=125
HELPER_WAIT_RC=125
set +e
(
  ulimit -f 16384 || exit 125
  exec /usr/bin/env -i PATH=/usr/bin:/bin:/usr/sbin:/sbin LANG=C LC_ALL=C TMPDIR=/private/tmp \
    "$HELPER" --duration 120 --interval-ms 25 --min-complete 3
) > "$HELPER_OUTPUT" 2>&1 3>&- &
HELPER_PID=$!
(
  /bin/sleep "$WATCHDOG_SECONDS"
  {
    print -r -- "D97AEZ_WATCHDOG_TIMEOUT=$WATCHDOG_SECONDS"
    print -r -- "CLAIMED_BOOT_UUID=$CURRENT_BOOT_UUID"
  } > "$WATCHDOG_MARKER"
  /bin/kill -USR1 "$PARENT_PID"
  /bin/sync
) 3>&- &
WATCHDOG_PID=$!
wait "$HELPER_PID"
HELPER_WAIT_RC=$?
if (( WATCHDOG_FIRED == 0 )); then
  HELPER_RC="$HELPER_WAIT_RC"
  HELPER_PID=0
  /bin/kill -TERM "$WATCHDOG_PID" 2>/dev/null || true
  wait "$WATCHDOG_PID" 2>/dev/null || true
  WATCHDOG_PID=0
else
  wait "$WATCHDOG_PID" 2>/dev/null || true
  WATCHDOG_PID=0
fi
set -e

if (( WATCHDOG_FIRED == 1 )); then
  [[ -f "$WATCHDOG_MARKER" && ! -L "$WATCHDOG_MARKER" && \
     "$(/usr/bin/stat -f '%u:%g:%l' "$WATCHDOG_MARKER")" == "0:0:1" ]] || \
    seal_done "WATCHDOG_TIMEOUT_UNKNOWN" 2 "$HELPER_RC" "WATCHDOG_TIMEOUT" "WATCHDOG_MARKER_INVALID"
  /bin/chmod 0400 "$WATCHDOG_MARKER" || \
    seal_done "WATCHDOG_TIMEOUT_UNKNOWN" 2 "$HELPER_RC" "WATCHDOG_TIMEOUT" "WATCHDOG_MARKER_MODE_FAILED"
  /usr/bin/chflags uchg "$WATCHDOG_MARKER" || \
    seal_done "WATCHDOG_TIMEOUT_UNKNOWN" 2 "$HELPER_RC" "WATCHDOG_TIMEOUT" "WATCHDOG_MARKER_IMMUTABLE_FAILED"
  emit "D97AEZ_WATCHDOG_RESULT=TIMEOUT|SECONDS=$WATCHDOG_SECONDS"
else
  if [[ -e "$WATCHDOG_MARKER" || -L "$WATCHDOG_MARKER" ]]; then
    post_helper_fail "WATCHDOG_MARKER_WITHOUT_TIMEOUT_SIGNAL"
  fi
  emit "D97AEZ_WATCHDOG_RESULT=DISARMED_AFTER_HELPER_EXIT"
fi

[[ -f "$HELPER_OUTPUT" && ! -L "$HELPER_OUTPUT" ]] || \
  post_helper_fail "HELPER_OUTPUT_NOT_REGULAR"
HELPER_OUTPUT_STAT_BEFORE="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$HELPER_OUTPUT")" || \
  post_helper_fail "HELPER_OUTPUT_STAT_BEFORE_FAILED"
HELPER_OUTPUT_SHA256="$(sha256_file "$HELPER_OUTPUT")" || \
  post_helper_fail "HELPER_OUTPUT_SHA256_FAILED"
HELPER_OUTPUT_STAT_AFTER="$(/usr/bin/stat -f 'DEV=%d|INO=%i|SIZE=%z|MTIME=%m|UID=%u|GID=%g|MODE=%Lp|NLINK=%l' "$HELPER_OUTPUT")" || \
  post_helper_fail "HELPER_OUTPUT_STAT_AFTER_FAILED"
HELPER_OUTPUT_BYTES="$(/usr/bin/stat -f '%z' "$HELPER_OUTPUT")" || \
  post_helper_fail "HELPER_OUTPUT_BYTES_FAILED"
if [[ "$HELPER_OUTPUT_STAT_BEFORE" != "$HELPER_OUTPUT_STAT_AFTER" || \
      "$(/usr/bin/stat -f '%u:%g:%Lp:%l' "$HELPER_OUTPUT")" != "0:0:600:1" ]] || \
   (( HELPER_OUTPUT_BYTES > HELPER_OUTPUT_MAX_BYTES )); then
  post_helper_fail "HELPER_OUTPUT_IDENTITY_OR_BOUND_FAILED"
fi
emit "HELPER_OUTPUT_STAT=$HELPER_OUTPUT_STAT_AFTER"
emit "HELPER_OUTPUT_SHA256=$HELPER_OUTPUT_SHA256"
emit "HELPER_OUTPUT_BYTES=$HELPER_OUTPUT_BYTES"
emit "===== BEGIN EXACT D97AEX HELPER OUTPUT ====="
/bin/cat "$HELPER_OUTPUT" >&3 || \
  post_helper_fail "HELPER_OUTPUT_APPEND_FAILED"
emit "===== END EXACT D97AEX HELPER OUTPUT ====="
/bin/chmod 0400 "$HELPER_OUTPUT" || \
  post_helper_fail "HELPER_OUTPUT_MODE_FAILED"
/usr/bin/chflags uchg "$HELPER_OUTPUT" || \
  post_helper_fail "HELPER_OUTPUT_IMMUTABLE_FAILED"
/bin/sync || post_helper_fail "HELPER_OUTPUT_SYNC_FAILED"

safe_grep_count() {
  local mode="$1" pattern="$2" output rc
  if [[ "$mode" == "ERE" ]]; then
    if output="$(/usr/bin/grep -Ec -- "$pattern" "$HELPER_OUTPUT")"; then
      rc=0
    else
      rc=$?
    fi
  else
    if output="$(/usr/bin/grep -Fxc -- "$pattern" "$HELPER_OUTPUT")"; then
      rc=0
    else
      rc=$?
    fi
  fi
  (( rc == 0 || rc == 1 )) || return 2
  [[ "$output" =~ '^[0-9]+$' ]] || return 2
  print -r -- "$output"
}

summary_field() {
  local summary="$1"
  local key="$2"
  local remainder="${summary#*${key}=}"
  [[ "$remainder" != "$summary" ]] || return 1
  print -r -- "${remainder%%|*}"
}

parse_helper_summary() {
  HELPER_SUMMARY_COUNT="$(safe_grep_count ERE '^COHORT_SUMMARY=')" || return 1
  [[ "$HELPER_SUMMARY_COUNT" == "1" ]] || return 1
  HELPER_SUMMARY="$(/usr/bin/grep -E '^COHORT_SUMMARY=' "$HELPER_OUTPUT")" || return 1
  print -r -- "$HELPER_SUMMARY" | /usr/bin/grep -Eq \
    '^COHORT_SUMMARY=POLLS=[0-9]+\|UNIQUE_EXACT_SERVICE_INSTANCES=[0-9]+\|COMPLETE_D5CE_INSTANCES=[0-9]+\|COMPLETE_BOUNDED31_MATCH=[0-9]+\|COMPLETE_BOUNDED31_MISMATCH=[0-9]+\|UUID_NEGATIVE_OFFSETS_SKIPPED=[0-9]+\|CAPTURE_EXIT_RACE_INCOMPLETE=[0-9]+\|PREFILTER_IDENTITY_RACE_INCOMPLETE=[0-9]+\|PENDING_OR_ENDED_INCOMPLETE=[0-9]+\|MINIMUM_REQUIRED=[0-9]+$' || return 1
  SUMMARY_POLLS="$(summary_field "$HELPER_SUMMARY" POLLS)" || return 1
  SUMMARY_UNIQUE="$(summary_field "$HELPER_SUMMARY" UNIQUE_EXACT_SERVICE_INSTANCES)" || return 1
  SUMMARY_COMPLETE="$(summary_field "$HELPER_SUMMARY" COMPLETE_D5CE_INSTANCES)" || return 1
  SUMMARY_MATCH="$(summary_field "$HELPER_SUMMARY" COMPLETE_BOUNDED31_MATCH)" || return 1
  SUMMARY_MISMATCH="$(summary_field "$HELPER_SUMMARY" COMPLETE_BOUNDED31_MISMATCH)" || return 1
  SUMMARY_UUID_NEGATIVE="$(summary_field "$HELPER_SUMMARY" UUID_NEGATIVE_OFFSETS_SKIPPED)" || return 1
  SUMMARY_EXIT_RACE="$(summary_field "$HELPER_SUMMARY" CAPTURE_EXIT_RACE_INCOMPLETE)" || return 1
  SUMMARY_PREFILTER_RACE="$(summary_field "$HELPER_SUMMARY" PREFILTER_IDENTITY_RACE_INCOMPLETE)" || return 1
  SUMMARY_PENDING="$(summary_field "$HELPER_SUMMARY" PENDING_OR_ENDED_INCOMPLETE)" || return 1
  SUMMARY_MINIMUM="$(summary_field "$HELPER_SUMMARY" MINIMUM_REQUIRED)" || return 1
  local value
  for value in "$SUMMARY_POLLS" "$SUMMARY_UNIQUE" "$SUMMARY_COMPLETE" \
    "$SUMMARY_MATCH" "$SUMMARY_MISMATCH" "$SUMMARY_UUID_NEGATIVE" \
    "$SUMMARY_EXIT_RACE" "$SUMMARY_PREFILTER_RACE" "$SUMMARY_PENDING" \
    "$SUMMARY_MINIMUM"; do
    [[ "$value" =~ '^[0-9]+$' ]] || return 1
  done
  return 0
}

RESULT_COUNT="$(safe_grep_count ERE '^D97AEX_RESULT=')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
STOP_FATAL_COUNT="$(safe_grep_count ERE '^D97AEX_(STOP|FATAL)=')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
MATCH_COUNT="$(safe_grep_count FIXED "$MATCH_MARKER")" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
INCOMPLETE_COUNT="$(safe_grep_count FIXED "$INCOMPLETE_MARKER")" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
MISMATCH_COUNT="$(safe_grep_count FIXED "$MISMATCH_MARKER")" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
COVERAGE_COMPLETE_COUNT="$(safe_grep_count FIXED 'COHORT_COVERAGE=ALL_DISCOVERED_EXACT_INSTANCES_COMPLETE')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
COVERAGE_INCOMPLETE_COUNT="$(safe_grep_count FIXED 'COHORT_COVERAGE=INCOMPLETE')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
BYTES_YES_COUNT="$(safe_grep_count FIXED 'COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=YES|SCOPE=OBSERVED_COHORT_31_WINDOWS_330_BYTES_EACH')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
BYTES_NEGATIVE_COUNT="$(safe_grep_count FIXED 'COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=NEGATIVE')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
BYTES_UNKNOWN_COUNT="$(safe_grep_count FIXED 'COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
PROVENANCE_MATCH_COUNT="$(safe_grep_count FIXED 'COHORT_BOUNDED_31_WINDOW_PROVENANCE=MATCH')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
PROVENANCE_MISMATCH_COUNT="$(safe_grep_count FIXED 'COHORT_BOUNDED_31_WINDOW_PROVENANCE=MISMATCH')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
HELPER_SUMMARY_COUNT="$(safe_grep_count ERE '^COHORT_SUMMARY=')" || \
  post_helper_fail "HELPER_OUTPUT_GREP_FAILED"

CONTRACT_OK=1
for contract_marker in \
  'WATCH_DURATION_SECONDS=120' \
  'WATCH_INTERVAL_MILLISECONDS=25' \
  'MINIMUM_COMPLETE_INSTANCES=3' \
  'GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN' \
  'SERVICE_LAUNCH=AUTO-NO' \
  'ROOT_PATCH=AUTO-NO' \
  'REBOOT=AUTO-NO'; do
  CONTRACT_MARKER_COUNT="$(safe_grep_count FIXED "$contract_marker")" || \
    post_helper_fail "HELPER_OUTPUT_GREP_FAILED"
  emit "HELPER_CONTRACT_MARKER_COUNT=$CONTRACT_MARKER_COUNT|MARKER=$contract_marker"
  [[ "$CONTRACT_MARKER_COUNT" == "1" ]] || CONTRACT_OK=0
done

SUMMARY_PARSE_OK=0
SUMMARY_INVARIANTS_OK=0
if parse_helper_summary; then
  SUMMARY_PARSE_OK=1
  emit "HELPER_SUMMARY_PARSE=PASS"
  emit "HELPER_SUMMARY_FIELDS=POLLS:${SUMMARY_POLLS}|UNIQUE:${SUMMARY_UNIQUE}|COMPLETE:${SUMMARY_COMPLETE}|MATCH:${SUMMARY_MATCH}|MISMATCH:${SUMMARY_MISMATCH}|UUID_NEGATIVE:${SUMMARY_UUID_NEGATIVE}|EXIT_RACE:${SUMMARY_EXIT_RACE}|PREFILTER_RACE:${SUMMARY_PREFILTER_RACE}|PENDING:${SUMMARY_PENDING}|MINIMUM:${SUMMARY_MINIMUM}"
  if (( SUMMARY_POLLS > 0 && SUMMARY_MINIMUM == 3 && \
        SUMMARY_MATCH + SUMMARY_MISMATCH == SUMMARY_COMPLETE && \
        SUMMARY_UNIQUE == SUMMARY_COMPLETE + SUMMARY_UUID_NEGATIVE + \
                          SUMMARY_EXIT_RACE + SUMMARY_PENDING )); then
    SUMMARY_INVARIANTS_OK=1
    emit "HELPER_SUMMARY_COUNTER_INVARIANTS=PASS"
  else
    emit "HELPER_SUMMARY_COUNTER_INVARIANTS=FAIL"
  fi
else
  emit "HELPER_SUMMARY_PARSE=NOT_AVAILABLE_OR_INVALID"
  emit "HELPER_SUMMARY_COUNTER_INVARIANTS=NOT_AVAILABLE"
fi

HELPER_MAPPING="INVALID"
TERMINAL_OK=0
if (( WATCHDOG_FIRED == 1 )); then
  HELPER_MAPPING="WATCHDOG_TIMEOUT"
else
  case "$HELPER_RC" in
    0)
      if (( SUMMARY_PARSE_OK == 1 && SUMMARY_INVARIANTS_OK == 1 )) && \
         [[ "$RESULT_COUNT:$STOP_FATAL_COUNT:$MATCH_COUNT:$INCOMPLETE_COUNT:$MISMATCH_COUNT" == "1:0:1:0:0" && \
            "$COVERAGE_COMPLETE_COUNT:$COVERAGE_INCOMPLETE_COUNT:$BYTES_YES_COUNT:$BYTES_NEGATIVE_COUNT:$BYTES_UNKNOWN_COUNT" == "1:0:1:0:0" && \
            "$PROVENANCE_MATCH_COUNT:$PROVENANCE_MISMATCH_COUNT" == "1:0" ]] && \
         (( SUMMARY_COMPLETE >= 3 && SUMMARY_UNIQUE == SUMMARY_COMPLETE && \
            SUMMARY_MATCH == SUMMARY_COMPLETE && SUMMARY_MISMATCH == 0 && \
            SUMMARY_UUID_NEGATIVE == 0 && SUMMARY_EXIT_RACE == 0 && \
            SUMMARY_PREFILTER_RACE == 0 && SUMMARY_PENDING == 0 )); then
        HELPER_MAPPING="RC0_MATCH"
        TERMINAL_OK=1
      fi
      ;;
    2)
      if [[ "$RESULT_COUNT:$STOP_FATAL_COUNT:$HELPER_SUMMARY_COUNT" == "0:1:0" && \
            "$MATCH_COUNT:$INCOMPLETE_COUNT:$MISMATCH_COUNT" == "0:0:0" && \
            "$COVERAGE_COMPLETE_COUNT:$COVERAGE_INCOMPLETE_COUNT" == "0:0" && \
            "$BYTES_YES_COUNT:$BYTES_NEGATIVE_COUNT" == "0:0" && \
            "$PROVENANCE_MATCH_COUNT:$PROVENANCE_MISMATCH_COUNT" == "0:0" ]] && \
         (( BYTES_UNKNOWN_COUNT <= 1 )); then
        HELPER_MAPPING="RC2_FAIL_CLOSED"
        TERMINAL_OK=1
      fi
      ;;
    3)
      if (( SUMMARY_PARSE_OK == 1 && SUMMARY_INVARIANTS_OK == 1 )) && \
         [[ "$RESULT_COUNT:$STOP_FATAL_COUNT:$MATCH_COUNT:$INCOMPLETE_COUNT:$MISMATCH_COUNT" == "1:0:0:1:0" && \
            "$COVERAGE_COMPLETE_COUNT:$COVERAGE_INCOMPLETE_COUNT:$BYTES_YES_COUNT:$BYTES_NEGATIVE_COUNT:$BYTES_UNKNOWN_COUNT" == "0:1:0:0:1" && \
            "$PROVENANCE_MATCH_COUNT:$PROVENANCE_MISMATCH_COUNT" == "0:0" ]] && \
         (( SUMMARY_COMPLETE < 3 || SUMMARY_UUID_NEGATIVE != 0 || \
            SUMMARY_EXIT_RACE != 0 || SUMMARY_PREFILTER_RACE != 0 || \
            SUMMARY_PENDING != 0 )); then
        HELPER_MAPPING="RC3_COVERAGE_INCOMPLETE"
        TERMINAL_OK=1
      fi
      ;;
    4)
      if (( SUMMARY_PARSE_OK == 1 && SUMMARY_INVARIANTS_OK == 1 )) && \
         [[ "$RESULT_COUNT:$STOP_FATAL_COUNT:$MATCH_COUNT:$INCOMPLETE_COUNT:$MISMATCH_COUNT" == "1:0:0:0:1" && \
            "$COVERAGE_COMPLETE_COUNT:$COVERAGE_INCOMPLETE_COUNT:$BYTES_YES_COUNT:$BYTES_NEGATIVE_COUNT:$BYTES_UNKNOWN_COUNT" == "1:0:0:1:0" && \
            "$PROVENANCE_MATCH_COUNT:$PROVENANCE_MISMATCH_COUNT" == "0:1" ]] && \
         (( SUMMARY_COMPLETE >= 3 && SUMMARY_UNIQUE == SUMMARY_COMPLETE && \
            SUMMARY_MATCH + SUMMARY_MISMATCH == SUMMARY_COMPLETE && \
            SUMMARY_MISMATCH > 0 && SUMMARY_UUID_NEGATIVE == 0 && \
            SUMMARY_EXIT_RACE == 0 && SUMMARY_PREFILTER_RACE == 0 && \
            SUMMARY_PENDING == 0 )); then
        HELPER_MAPPING="RC4_MISMATCH"
        TERMINAL_OK=1
      fi
      ;;
  esac
fi
emit "HELPER_TERMINAL_COUNTS=RESULT:${RESULT_COUNT}|STOP_OR_FATAL:${STOP_FATAL_COUNT}|MATCH:${MATCH_COUNT}|INCOMPLETE:${INCOMPLETE_COUNT}|MISMATCH:${MISMATCH_COUNT}"
emit "HELPER_TERMINAL_CONTRACT=$([[ "$TERMINAL_OK" == "1" && "$CONTRACT_OK" == "1" ]] && print PASS || print FAIL)"

TEMPORAL_OK=1
if CURRENT_BOOT_UUID_POST="$(/usr/sbin/sysctl -n kern.bootsessionuuid)"; then
  emit "CURRENT_BOOT_UUID_POST=$CURRENT_BOOT_UUID_POST"
else
  CURRENT_BOOT_UUID_POST="UNKNOWN"
  emit "CURRENT_BOOT_UUID_POST=UNKNOWN"
  TEMPORAL_OK=0
fi
if [[ "$CURRENT_BOOT_UUID_POST" == "$CURRENT_BOOT_UUID" ]]; then
  emit "BOOT_UUID_PRE_POST_IDENTITY=PASS"
else
  emit "BOOT_UUID_PRE_POST_IDENTITY=FAIL"
  TEMPORAL_OK=0
fi

POST_OK=1
identity_gate POST RUNNER "$RUNNER" "$RUNNER_SHA256_EXPECTED" "$RUNNER_BYTES_EXPECTED" 500 || POST_OK=0
identity_gate POST HELPER "$HELPER" "$HELPER_SHA256_EXPECTED" "$HELPER_BYTES_EXPECTED" "$HELPER_MODE_EXPECTED" || POST_OK=0
identity_gate POST PLIST "$PLIST" "$PLIST_SHA256_EXPECTED" "$PLIST_BYTES_EXPECTED" 644 || POST_OK=0
identity_gate POST SERVICE "$SERVICE" "$SERVICE_SHA256_EXPECTED" "$SERVICE_BYTES_EXPECTED" "$SERVICE_MODE_EXPECTED" || POST_OK=0
identity_gate POST TARGET "$TARGET" "$TARGET_SHA256_EXPECTED" "$TARGET_BYTES_EXPECTED" "$TARGET_MODE_EXPECTED" || POST_OK=0

if (( WATCHDOG_FIRED == 1 )); then
  seal_done "WATCHDOG_TIMEOUT_UNKNOWN" 2 "$HELPER_RC" "$HELPER_MAPPING" "WATCHDOG_EXPIRED"
fi
if (( TERMINAL_OK != 1 || CONTRACT_OK != 1 || POST_OK != 1 || TEMPORAL_OK != 1 )); then
  post_helper_fail "TERMINAL_CONTRACT_OR_POST_IDENTITY_FAILED" "$HELPER_MAPPING"
fi
case "$HELPER_RC" in
  0) seal_done "OBSERVED_COHORT_BOUNDED_PROVENANCE_MATCH" 0 "$HELPER_RC" "$HELPER_MAPPING" ;;
  2) seal_done "HELPER_FAIL_CLOSED" 2 "$HELPER_RC" "$HELPER_MAPPING" ;;
  3) seal_done "COVERAGE_INCOMPLETE_STOP" 3 "$HELPER_RC" "$HELPER_MAPPING" ;;
  4) seal_done "OBSERVED_COHORT_BOUNDED_PROVENANCE_MISMATCH" 4 "$HELPER_RC" "$HELPER_MAPPING" ;;
  *) seal_done "UNEXPECTED_HELPER_RC_FAIL_CLOSED" 2 "$HELPER_RC" "$HELPER_MAPPING" "UNEXPECTED_HELPER_RC" ;;
esac
