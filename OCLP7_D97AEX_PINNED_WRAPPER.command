#!/bin/zsh -f

# OCLP7 D97AEX -- identity-pinned ASUS2-only runtime-text proof wrapper.
#
# This wrapper downloads one already-audited helper from one immutable public
# commit, verifies every published byte identity, runs the helper self-test,
# then watches only naturally occurring MTLCompilerService processes.  It never
# launches or stops the service and never changes source, system, Golden, Root
# Patch, or boot state.

emulate -LR zsh
set -euo pipefail
umask 077

if (( $# != 0 )); then
  print -r -- "D97AEX_WRAPPER_FATAL=WRAPPER_ARGUMENTS_NOT_ALLOWED"
  exit 2
fi

readonly WRAPPER_NAME="OCLP7_D97AEX_PINNED_WRAPPER"
readonly REPOSITORY="StefanAlMare/StefanAlMare"
readonly HELPER_COMMIT="18880de15acde73ca366c8c0e6e8e6aa4ea3a9f0"
readonly HELPER_TREE="f6806366a19f3f9da034611d04e39e4bb00e7486"
readonly HELPER_PATH="OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER"
readonly HELPER_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${HELPER_COMMIT}/${HELPER_PATH}"
readonly HELPER_BLOB_EXPECTED="528fd75bea3c9ed262daebf55142902a3795fcb8"
readonly HELPER_SHA256_EXPECTED="bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f"
readonly HELPER_BYTES_EXPECTED="94928"
readonly HELPER_PUBLIC_MODE_EXPECTED="100755"
readonly HELPER_RUNTIME_MODE_EXPECTED="500"
readonly SELFTEST_SHA256_EXPECTED="ba6c489151d595d9217ffdc2d8058798b454a8843d2a594d0477e1ff1cefca95"
readonly SELFTEST_BYTES_EXPECTED="345"
readonly SELFTEST_LINES_EXPECTED="6"

readonly PRODUCT_VERSION_EXPECTED="26.6.2"
readonly BUILD_VERSION_EXPECTED="25G82"
readonly SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
readonly TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
readonly SERVICE_SHA256_EXPECTED="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
readonly TARGET_SHA256_EXPECTED="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
readonly TARGET_BYTES_EXPECTED="1636864"
readonly LOG_PREDICATE='process == "MTLCompilerService" OR (process == "launchd" AND eventMessage CONTAINS[c] "MTLCompilerService")'

for tool in \
  /usr/bin/curl /usr/bin/git /usr/bin/shasum /usr/bin/stat /usr/bin/uname /usr/bin/id \
  /usr/bin/sw_vers /usr/bin/sudo /usr/bin/env /usr/bin/log \
  /usr/bin/mktemp /usr/bin/grep /usr/bin/sed /usr/bin/sort /usr/bin/tail \
  /usr/bin/wc /usr/bin/tr /usr/bin/tee /usr/bin/comm /usr/bin/file \
  /usr/bin/codesign /usr/sbin/sysctl /bin/chmod /bin/cat /bin/date \
  /bin/rm /bin/rmdir /bin/sleep; do
  if [[ ! -x "$tool" ]]; then
    print -r -- "D97AEX_WRAPPER_FATAL=REQUIRED_TOOL_MISSING:${tool}"
    exit 2
  fi
done

if [[ "$(/usr/bin/id -u)" == "0" ]]; then
  print -r -- "D97AEX_WRAPPER_FATAL=WHOLE_WRAPPER_MUST_NOT_RUN_AS_ROOT"
  print -r -- "D97AEX_WRAPPER_PRIVILEGE_CONTRACT=LOGIN_USER_WRAPPER_EXACT_HELPER_ONLY_SUDO"
  exit 2
fi

if [[ -z "${HOME:-}" || ! -d "$HOME/Desktop" || -L "$HOME/Desktop" ]]; then
  print -r -- "D97AEX_WRAPPER_FATAL=SAFE_DESKTOP_DIRECTORY_UNAVAILABLE"
  exit 2
fi

TMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AEX.XXXXXX)"
if [[ "$TMP_ROOT" != /private/tmp/OCLP7_D97AEX.* || ! -d "$TMP_ROOT" || -L "$TMP_ROOT" ]]; then
  print -r -- "D97AEX_WRAPPER_FATAL=PRIVATE_TEMP_DIRECTORY_INVALID"
  exit 2
fi
/bin/chmod 0700 "$TMP_ROOT"
if [[ "$(/usr/bin/stat -f '%Lp' "$TMP_ROOT")" != "700" || \
      "$(/usr/bin/stat -f '%l' "$TMP_ROOT")" != "2" || \
      "$(/usr/bin/stat -f '%u' "$TMP_ROOT")" != "$(/usr/bin/id -u)" ]]; then
  print -r -- "D97AEX_WRAPPER_FATAL=PRIVATE_TEMP_DIRECTORY_IDENTITY_INVALID"
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi

REPORT="$(/usr/bin/mktemp "$HOME/Desktop/OCLP7_D97AEX_PINNED_WRAPPER_REPORT.txt.XXXXXX")"
if [[ ! -f "$REPORT" || -L "$REPORT" || \
      "$(/usr/bin/stat -f '%l' "$REPORT")" != "1" || \
      "$(/usr/bin/stat -f '%u' "$REPORT")" != "$(/usr/bin/id -u)" ]]; then
  print -r -- "D97AEX_WRAPPER_FATAL=SAFE_REPORT_CREATION_FAILED"
  /bin/rm -f "$REPORT" 2>/dev/null || true
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi
/bin/chmod 0600 "$REPORT"
if [[ "$(/usr/bin/stat -f '%Lp' "$REPORT")" != "600" ]]; then
  print -r -- "D97AEX_WRAPPER_FATAL=SAFE_REPORT_MODE_FAILED"
  /bin/rm -f "$REPORT" 2>/dev/null || true
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
fi
REPORT_OWNER_EXPECTED="$(/usr/bin/id -u)"
REPORT_INITIAL_DEV_INODE="$(/usr/bin/stat -f 'DEV=%d|INODE=%i' "$REPORT")" || {
  print -r -- "D97AEX_WRAPPER_FATAL=SAFE_REPORT_INITIAL_IDENTITY_FAILED"
  /bin/rm -f "$REPORT" 2>/dev/null || true
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit 2
}

HELPER="$TMP_ROOT/$HELPER_PATH"
CURL_OUTPUT="$TMP_ROOT/curl-output.txt"
SELFTEST_OUTPUT="$TMP_ROOT/self-test.txt"
WATCH_OUTPUT="$TMP_ROOT/watcher.txt"
LOG_OUTPUT="$TMP_ROOT/log-visible.txt"
LOG_ERROR="$TMP_ROOT/log-visible-stderr.txt"
LOG_PIDS="$TMP_ROOT/log-visible-pids.txt"
LOG_SERVICE_PIDS="$TMP_ROOT/log-service-pids.txt"
LOG_SPAWN_PIDS="$TMP_ROOT/log-spawn-pids.txt"
LOG_LAUNCHD_PIDS="$TMP_ROOT/log-launchd-pids.txt"
HELPER_PIDS="$TMP_ROOT/helper-pids.txt"
PID_COMMON="$TMP_ROOT/pid-common.txt"
PID_HELPER_ONLY="$TMP_ROOT/pid-helper-only.txt"
PID_LOG_ONLY="$TMP_ROOT/pid-log-only.txt"

emit() {
  local line="$*"
  print -r -- "$line"
  print -r -- "$line" >> "$REPORT"
}

append_file() {
  local path="$1"
  if [[ -f "$path" && ! -L "$path" ]]; then
    /bin/cat "$path"
    /bin/cat "$path" >> "$REPORT"
  fi
}

cleanup() {
  local saved_rc=$?
  trap - EXIT
  /bin/rm -f "$HELPER" "$CURL_OUTPUT" "$SELFTEST_OUTPUT" \
    "$WATCH_OUTPUT" "$LOG_OUTPUT" "$LOG_ERROR" "$LOG_PIDS" \
    "$LOG_SERVICE_PIDS" "$LOG_SPAWN_PIDS" "$LOG_LAUNCHD_PIDS" \
    "$HELPER_PIDS" "$PID_COMMON" "$PID_HELPER_ONLY" "$PID_LOG_ONLY" \
    2>/dev/null || true
  /bin/rmdir "$TMP_ROOT" 2>/dev/null || true
  exit "$saved_rc"
}

trap cleanup EXIT
trap 'emit "D97AEX_WRAPPER_INTERRUPTED=INT"; exit 130' INT
trap 'emit "D97AEX_WRAPPER_INTERRUPTED=HUP"; exit 129' HUP
trap 'emit "D97AEX_WRAPPER_INTERRUPTED=TERM"; exit 143' TERM

stop_before_watch() {
  emit "D97AEX_WRAPPER_RESULT=PREWATCH_FAIL_CLOSED_STOP"
  emit "D97AEX_WRAPPER_EXIT_RC=2"
  emit "REPORT=$REPORT"
  exit 2
}

sha256_file() {
  local path="$1"
  local raw
  raw="$(/usr/bin/shasum -a 256 "$path")" || return 1
  print -r -- "${raw%% *}"
}

file_identity_gate() {
  local stage="$1"
  local label="$2"
  local path="$3"
  local expected_sha="$4"
  local expected_bytes="$5"
  local stat_before stat_after actual_sha actual_bytes

  GATE_IDENTITY="UNKNOWN"
  if [[ ! -f "$path" || -L "$path" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=NOT_REGULAR_OR_IS_SYMLINK|PATH=$path"
    return 1
  fi
  if [[ "$(/usr/bin/stat -f '%l' "$path")" != "1" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=LINK_COUNT_NOT_ONE|PATH=$path"
    return 1
  fi
  stat_before="$(/usr/bin/stat -f 'DEV=%d|INODE=%i|SIZE=%z|MTIME=%m|MODE=%Lp|NLINK=%l' "$path")" || {
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=STAT_BEFORE_FAILED|PATH=$path"
    return 1
  }
  actual_sha="$(sha256_file "$path")" || {
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=SHA256_FAILED|PATH=$path"
    return 1
  }
  stat_after="$(/usr/bin/stat -f 'DEV=%d|INODE=%i|SIZE=%z|MTIME=%m|MODE=%Lp|NLINK=%l' "$path")" || {
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=STAT_AFTER_FAILED|PATH=$path"
    return 1
  }
  actual_bytes="$(/usr/bin/stat -f '%z' "$path")"
  emit "${stage}_${label}_STAT_BEFORE=$stat_before"
  emit "${stage}_${label}_SHA256=$actual_sha"
  emit "${stage}_${label}_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=CHANGED_DURING_HASH"
    return 1
  fi
  if [[ "$actual_sha" != "$expected_sha" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=SHA256_MISMATCH"
    return 1
  fi
  if [[ -n "$expected_bytes" && "$actual_bytes" != "$expected_bytes" ]]; then
    emit "${stage}_${label}_IDENTITY=FAIL|REASON=BYTE_COUNT_MISMATCH"
    return 1
  fi
  GATE_IDENTITY="${stat_after}|SHA256=${actual_sha}"
  emit "${stage}_${label}_IDENTITY=PASS"
  return 0
}

helper_identity_gate() {
  local stage="$1"
  local actual_blob actual_sha actual_bytes actual_mode actual_links
  local stat_before stat_after
  if [[ ! -f "$HELPER" || -L "$HELPER" ]]; then
    emit "${stage}_HELPER_IDENTITY=FAIL|REASON=NOT_REGULAR_OR_IS_SYMLINK"
    return 1
  fi
  stat_before="$(/usr/bin/stat -f 'DEV=%d|INODE=%i|SIZE=%z|MTIME=%m|MODE=%Lp|NLINK=%l' "$HELPER")" || return 1
  actual_blob="$(/usr/bin/env -i PATH=/usr/bin:/bin LANG=C LC_ALL=C /usr/bin/git hash-object "$HELPER")" || return 1
  actual_sha="$(sha256_file "$HELPER")" || return 1
  stat_after="$(/usr/bin/stat -f 'DEV=%d|INODE=%i|SIZE=%z|MTIME=%m|MODE=%Lp|NLINK=%l' "$HELPER")" || return 1
  actual_links="$(/usr/bin/stat -f '%l' "$HELPER")"
  actual_mode="$(/usr/bin/stat -f '%Lp' "$HELPER")"
  actual_bytes="$(/usr/bin/stat -f '%z' "$HELPER")"
  emit "${stage}_HELPER_STAT_BEFORE=$stat_before"
  emit "${stage}_HELPER_BLOB=$actual_blob"
  emit "${stage}_HELPER_SHA256=$actual_sha"
  emit "${stage}_HELPER_BYTES=$actual_bytes"
  emit "${stage}_HELPER_RUNTIME_MODE=$actual_mode"
  emit "${stage}_HELPER_LINK_COUNT=$actual_links"
  emit "${stage}_HELPER_STAT_AFTER=$stat_after"
  if [[ "$stat_before" != "$stat_after" || \
        "$actual_links" != "1" || "$actual_mode" != "$HELPER_RUNTIME_MODE_EXPECTED" || \
        "$actual_bytes" != "$HELPER_BYTES_EXPECTED" || \
        "$actual_blob" != "$HELPER_BLOB_EXPECTED" || \
        "$actual_sha" != "$HELPER_SHA256_EXPECTED" ]]; then
    emit "${stage}_HELPER_IDENTITY=FAIL"
    return 1
  fi
  emit "${stage}_HELPER_IDENTITY=PASS"
  return 0
}

summary_field() {
  local summary="$1"
  local key="$2"
  local remainder="${summary#*${key}=}"
  [[ "$remainder" != "$summary" ]] || return 1
  print -r -- "${remainder%%|*}"
}

parse_watch_summary() {
  WATCH_SUMMARY_COUNT="$(/usr/bin/grep -Ec '^COHORT_SUMMARY=' "$WATCH_OUTPUT" || true)"
  [[ "$WATCH_SUMMARY_COUNT" == "1" ]] || return 1
  WATCH_SUMMARY="$(/usr/bin/grep -E '^COHORT_SUMMARY=' "$WATCH_OUTPUT")" || return 1
  print -r -- "$WATCH_SUMMARY" | /usr/bin/grep -Eq \
    '^COHORT_SUMMARY=POLLS=[0-9]+\|UNIQUE_EXACT_SERVICE_INSTANCES=[0-9]+\|COMPLETE_D5CE_INSTANCES=[0-9]+\|COMPLETE_BOUNDED31_MATCH=[0-9]+\|COMPLETE_BOUNDED31_MISMATCH=[0-9]+\|UUID_NEGATIVE_OFFSETS_SKIPPED=[0-9]+\|CAPTURE_EXIT_RACE_INCOMPLETE=[0-9]+\|PREFILTER_IDENTITY_RACE_INCOMPLETE=[0-9]+\|PENDING_OR_ENDED_INCOMPLETE=[0-9]+\|MINIMUM_REQUIRED=[0-9]+$' || return 1
  SUMMARY_POLLS="$(summary_field "$WATCH_SUMMARY" POLLS)" || return 1
  SUMMARY_UNIQUE="$(summary_field "$WATCH_SUMMARY" UNIQUE_EXACT_SERVICE_INSTANCES)" || return 1
  SUMMARY_COMPLETE="$(summary_field "$WATCH_SUMMARY" COMPLETE_D5CE_INSTANCES)" || return 1
  SUMMARY_MATCH="$(summary_field "$WATCH_SUMMARY" COMPLETE_BOUNDED31_MATCH)" || return 1
  SUMMARY_MISMATCH="$(summary_field "$WATCH_SUMMARY" COMPLETE_BOUNDED31_MISMATCH)" || return 1
  SUMMARY_UUID_NEGATIVE="$(summary_field "$WATCH_SUMMARY" UUID_NEGATIVE_OFFSETS_SKIPPED)" || return 1
  SUMMARY_EXIT_RACE="$(summary_field "$WATCH_SUMMARY" CAPTURE_EXIT_RACE_INCOMPLETE)" || return 1
  SUMMARY_PREFILTER_RACE="$(summary_field "$WATCH_SUMMARY" PREFILTER_IDENTITY_RACE_INCOMPLETE)" || return 1
  SUMMARY_PENDING="$(summary_field "$WATCH_SUMMARY" PENDING_OR_ENDED_INCOMPLETE)" || return 1
  SUMMARY_MINIMUM="$(summary_field "$WATCH_SUMMARY" MINIMUM_REQUIRED)" || return 1
  local value
  for value in "$SUMMARY_POLLS" "$SUMMARY_UNIQUE" "$SUMMARY_COMPLETE" \
    "$SUMMARY_MATCH" "$SUMMARY_MISMATCH" "$SUMMARY_UUID_NEGATIVE" \
    "$SUMMARY_EXIT_RACE" "$SUMMARY_PREFILTER_RACE" "$SUMMARY_PENDING" \
    "$SUMMARY_MINIMUM"; do
    [[ "$value" == <-> ]] || return 1
  done
  return 0
}

emit "===== OCLP7 D97AEX — PINNED READ-ONLY RUNTIME TEXT WRAPPER ====="
emit "WRAPPER=$WRAPPER_NAME"
emit "PURPOSE=identity_pinned_selftest_then_finite_natural_no_PID_runtime_text_watch"
emit "REPOSITORY=$REPOSITORY"
emit "HELPER_COMMIT=$HELPER_COMMIT"
emit "HELPER_TREE=$HELPER_TREE"
emit "HELPER_PATH=$HELPER_PATH"
emit "HELPER_URL=$HELPER_URL"
emit "HELPER_BLOB_EXPECTED=$HELPER_BLOB_EXPECTED"
emit "HELPER_SHA256_EXPECTED=$HELPER_SHA256_EXPECTED"
emit "HELPER_BYTES_EXPECTED=$HELPER_BYTES_EXPECTED"
emit "HELPER_PUBLIC_TREE_MODE_CI_PROVEN=$HELPER_PUBLIC_MODE_EXPECTED"
emit "HELPER_LOCAL_RUNTIME_MODE=$HELPER_RUNTIME_MODE_EXPECTED"
emit "WRAPPER_ARGUMENTS=NONE_REQUIRED"
emit "WATCH_ARGUMENTS=--duration_120_--interval-ms_25_--min-complete_3"
emit "WATCH_DEFAULTS=120_SECONDS_25_MILLISECONDS_MINIMUM_3_COMPLETE"
emit "SELECTION_SCOPE=ALL_EXACT_PATH_PIDS_VISIBLE_AT_EACH_HELPER_POLL"
emit "LOG_CENSUS_SCOPE=LOG_VISIBLE_ONLY"
emit "GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN"
emit "SOURCE_MUTATION=NO"
emit "SYSTEM_MUTATION=NO_PROJECT_TARGETS"
emit "SYSTEM_FILE_MUTATION=NO"
emit "PRIVATE_TEMP_ARTIFACTS=YES_EPHEMERAL_WRAPPER_OWNED_ONLY"
emit "USER_REPORT_WRITE=YES_UNIQUE_MODE_0600_DESKTOP_REPORT_ONLY"
emit "SUDO_TIMESTAMP_METADATA=STANDARD_AUTHENTICATION_CACHE_MAY_UPDATE"
emit "GOLDEN_MUTATION=NO"
emit "TARGET_CODE_BYTES_MUTATION=NO"
emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
emit "SERVICE_LAUNCH=AUTO-NO"
emit "SERVICE_STOP=AUTO-NO"
emit "DEBUGGER_OR_CONTROL_PORT_FALLBACK=NO"
emit "RUNTIME_INSTRUMENTATION=YES_APPLE_PRIVATE_TASK_READ_PORT"
emit "OBSERVATIONAL_PERTURBATION=POSSIBLE_PAGE_IN_AND_TIMING"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "REPORT=$REPORT"

PRODUCT_VERSION_ACTUAL="$(/usr/bin/sw_vers -productVersion)" || stop_before_watch
BUILD_VERSION_ACTUAL="$(/usr/bin/sw_vers -buildVersion)" || stop_before_watch
ARCHITECTURE_ACTUAL="$(/usr/bin/uname -m)" || stop_before_watch
emit "PRODUCT_VERSION_ACTUAL=$PRODUCT_VERSION_ACTUAL"
emit "BUILD_VERSION_ACTUAL=$BUILD_VERSION_ACTUAL"
emit "ARCHITECTURE_ACTUAL=$ARCHITECTURE_ACTUAL"
if [[ "$PRODUCT_VERSION_ACTUAL" != "$PRODUCT_VERSION_EXPECTED" || \
      "$BUILD_VERSION_ACTUAL" != "$BUILD_VERSION_EXPECTED" || \
      "$ARCHITECTURE_ACTUAL" != "x86_64" ]]; then
  emit "OS_BUILD_ARCH_IDENTITY=FAIL|EXPECTED=${PRODUCT_VERSION_EXPECTED}/${BUILD_VERSION_EXPECTED}/x86_64"
  stop_before_watch
fi
emit "OS_BUILD_ARCH_IDENTITY=PASS"

emit "DOWNLOAD_BEGIN=PINNED_PUBLIC_COMMIT_RAW_BINARY"
if /usr/bin/curl -q --fail --location --silent --show-error \
    --proto '=https' --proto-redir '=https' --tlsv1.2 \
    --retry 3 --connect-timeout 20 --max-time 180 \
    --output "$HELPER" "$HELPER_URL" > "$CURL_OUTPUT" 2>&1; then
  CURL_RC=0
else
  CURL_RC=$?
fi
append_file "$CURL_OUTPUT"
emit "DOWNLOAD_RC=$CURL_RC"
if (( CURL_RC != 0 )); then
  emit "DOWNLOAD_IDENTITY=FAIL_CLOSED"
  stop_before_watch
fi
if [[ ! -f "$HELPER" || -L "$HELPER" || \
      "$(/usr/bin/stat -f '%l' "$HELPER")" != "1" ]]; then
  emit "DOWNLOAD_IDENTITY=FAIL|REASON=UNSAFE_FILE_TYPE_OR_LINK_COUNT"
  stop_before_watch
fi
/bin/chmod 0500 "$HELPER"
if ! helper_identity_gate "PRE_SELFTEST"; then
  stop_before_watch
fi
HELPER_FILE_DESCRIPTION="$(/usr/bin/file -b "$HELPER")" || HELPER_FILE_DESCRIPTION="UNKNOWN"
emit "HELPER_FILE_DESCRIPTION=$HELPER_FILE_DESCRIPTION"
if [[ "$HELPER_FILE_DESCRIPTION" != *"Mach-O 64-bit executable x86_64"* ]]; then
  emit "HELPER_FILE_ARCHITECTURE=FAIL"
  stop_before_watch
fi
if /usr/bin/codesign --verify --strict --verbose=2 "$HELPER" > "$CURL_OUTPUT" 2>&1; then
  CODESIGN_VERIFY_RC=0
else
  CODESIGN_VERIFY_RC=$?
fi
append_file "$CURL_OUTPUT"
emit "HELPER_CODESIGN_VERIFY_RC=$CODESIGN_VERIFY_RC"
if (( CODESIGN_VERIFY_RC != 0 )); then
  emit "HELPER_CODESIGN_VERIFY=FAIL"
  stop_before_watch
fi
emit "HELPER_CODESIGN_VERIFY=PASS"

emit "SELF_TEST_BEGIN=UNPRIVILEGED_EXACT_HELPER"
if /usr/bin/env -i PATH=/usr/bin:/bin:/usr/sbin:/sbin LANG=C LC_ALL=C \
    TMPDIR=/private/tmp "$HELPER" --self-test > "$SELFTEST_OUTPUT" 2>&1; then
  SELFTEST_RC=0
else
  SELFTEST_RC=$?
fi
append_file "$SELFTEST_OUTPUT"
SELFTEST_SHA256_ACTUAL="$(sha256_file "$SELFTEST_OUTPUT")" || SELFTEST_SHA256_ACTUAL="UNKNOWN"
SELFTEST_BYTES_ACTUAL="$(/usr/bin/stat -f '%z' "$SELFTEST_OUTPUT")" || SELFTEST_BYTES_ACTUAL="UNKNOWN"
SELFTEST_LINES_ACTUAL="$(/usr/bin/wc -l < "$SELFTEST_OUTPUT" | /usr/bin/tr -d '[:space:]')"
emit "SELF_TEST_RC=$SELFTEST_RC"
emit "SELF_TEST_OUTPUT_SHA256=$SELFTEST_SHA256_ACTUAL"
emit "SELF_TEST_OUTPUT_BYTES=$SELFTEST_BYTES_ACTUAL"
emit "SELF_TEST_OUTPUT_LINES=$SELFTEST_LINES_ACTUAL"

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
for marker in "${SELFTEST_MARKERS[@]}"; do
  marker_count="$(/usr/bin/grep -Fxc "$marker" "$SELFTEST_OUTPUT" || true)"
  emit "SELF_TEST_MARKER_COUNT=${marker_count}|MARKER=${marker}"
  if [[ "$marker_count" != "1" ]]; then
    SELFTEST_MARKERS_OK=0
  fi
done
if (( SELFTEST_RC != 0 || SELFTEST_MARKERS_OK != 1 )) || \
   [[ "$SELFTEST_SHA256_ACTUAL" != "$SELFTEST_SHA256_EXPECTED" || \
      "$SELFTEST_BYTES_ACTUAL" != "$SELFTEST_BYTES_EXPECTED" || \
      "$SELFTEST_LINES_ACTUAL" != "$SELFTEST_LINES_EXPECTED" ]]; then
  emit "SELF_TEST_IDENTITY=FAIL_CLOSED"
  stop_before_watch
fi
emit "SELF_TEST_IDENTITY=PASS"

emit "SUDO_CREDENTIAL_VALIDATION_BEGIN=INTERACTIVE_NO_TARGET_COMMAND"
if /usr/bin/sudo -v; then
  SUDO_VALIDATE_RC=0
else
  SUDO_VALIDATE_RC=$?
fi
emit "SUDO_CREDENTIAL_VALIDATION_RC=$SUDO_VALIDATE_RC"
if (( SUDO_VALIDATE_RC != 0 )); then
  emit "SUDO_CREDENTIAL_VALIDATION=FAIL_CLOSED"
  stop_before_watch
fi
emit "SUDO_CREDENTIAL_VALIDATION=PASS"

PRE_GATES_OK=1
if ! helper_identity_gate "PRE_WATCH"; then
  PRE_GATES_OK=0
fi
if file_identity_gate "PRE_WATCH" "SERVICE" "$SERVICE" "$SERVICE_SHA256_EXPECTED" ""; then
  SERVICE_IDENTITY_PRE="$GATE_IDENTITY"
else
  SERVICE_IDENTITY_PRE="UNKNOWN"
  PRE_GATES_OK=0
fi
if file_identity_gate "PRE_WATCH" "TARGET" "$TARGET" "$TARGET_SHA256_EXPECTED" "$TARGET_BYTES_EXPECTED"; then
  TARGET_IDENTITY_PRE="$GATE_IDENTITY"
else
  TARGET_IDENTITY_PRE="UNKNOWN"
  PRE_GATES_OK=0
fi
if (( PRE_GATES_OK != 1 )); then
  emit "PRE_WATCH_IDENTITY_GATES=FAIL_CLOSED"
  stop_before_watch
fi
emit "PRE_WATCH_IDENTITY_GATES=PASS"

BOOT_SESSION_PRE="$(/usr/sbin/sysctl -n kern.bootsessionuuid)" || stop_before_watch
TIMEZONE_PRE="$(/bin/date '+%z|%Z')" || stop_before_watch
WATCH_START_EPOCH="$(/bin/date +%s)"
WATCH_START_LOCAL="$(/bin/date -r "$WATCH_START_EPOCH" '+%Y-%m-%d %H:%M:%S%z')"
LOG_START_EPOCH=$(( WATCH_START_EPOCH - 1 ))
LOG_START_LOCAL="$(/bin/date -r "$LOG_START_EPOCH" '+%Y-%m-%d %H:%M:%S%z')"
emit "BOOT_SESSION_PRE=$BOOT_SESSION_PRE"
emit "TIMEZONE_PRE=$TIMEZONE_PRE"
emit "WATCH_START_LOCAL_WITH_OFFSET=$WATCH_START_LOCAL"
emit "LOG_VISIBLE_QUERY_START_LOCAL_WITH_OFFSET=$LOG_START_LOCAL"
emit "WATCH_EXECUTION=sudo_-n_env_-i_exact_helper_explicit_120_25_3"

typeset -a WATCH_PIPESTATUS
set +e
/usr/bin/sudo -n -- /usr/bin/env -i \
    PATH=/usr/bin:/bin:/usr/sbin:/sbin LANG=C LC_ALL=C TMPDIR=/private/tmp \
    "$HELPER" --duration 120 --interval-ms 25 --min-complete 3 2>&1 | \
    /usr/bin/tee -a "$WATCH_OUTPUT" "$REPORT"
WATCH_PIPESTATUS=("${pipestatus[@]}")
set -e
WATCH_RC="${WATCH_PIPESTATUS[1]:-125}"
WATCH_TEE_RC="${WATCH_PIPESTATUS[2]:-125}"
WATCH_END_EPOCH="$(/bin/date +%s)"
WATCH_END_LOCAL="$(/bin/date -r "$WATCH_END_EPOCH" '+%Y-%m-%d %H:%M:%S%z')"
LOG_END_EPOCH=$(( WATCH_END_EPOCH + 1 ))
LOG_END_LOCAL="$(/bin/date -r "$LOG_END_EPOCH" '+%Y-%m-%d %H:%M:%S%z')"
BOOT_SESSION_POST="$(/usr/sbin/sysctl -n kern.bootsessionuuid 2>/dev/null || print UNKNOWN)"
TIMEZONE_POST="$(/bin/date '+%z|%Z' 2>/dev/null || print UNKNOWN)"
emit "WATCH_END_LOCAL_WITH_OFFSET=$WATCH_END_LOCAL"
emit "LOG_VISIBLE_QUERY_END_LOCAL_WITH_OFFSET=$LOG_END_LOCAL"
emit "BOOT_SESSION_POST=$BOOT_SESSION_POST"
emit "TIMEZONE_POST=$TIMEZONE_POST"
emit "D97AEX_HELPER_RC=$WATCH_RC"
emit "D97AEX_WATCH_TEE_RC=$WATCH_TEE_RC"

TEMPORAL_IDENTITY_OK=1
if [[ "$BOOT_SESSION_PRE" != "$BOOT_SESSION_POST" ]]; then
  emit "BOOT_SESSION_PRE_POST_IDENTITY=FAIL"
  TEMPORAL_IDENTITY_OK=0
else
  emit "BOOT_SESSION_PRE_POST_IDENTITY=PASS"
fi
if [[ "$TIMEZONE_PRE" != "$TIMEZONE_POST" ]]; then
  emit "TIMEZONE_PRE_POST_IDENTITY=CHANGED"
  TEMPORAL_IDENTITY_OK=0
else
  emit "TIMEZONE_PRE_POST_IDENTITY=PASS"
fi

WATCH_CONTRACT_OK=1
for default_marker in \
  "WATCH_DURATION_SECONDS=120" \
  "WATCH_INTERVAL_MILLISECONDS=25" \
  "MINIMUM_COMPLETE_INSTANCES=3" \
  "GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN" \
  "SERVICE_LAUNCH=AUTO-NO" \
  "ROOT_PATCH=AUTO-NO" \
  "REBOOT=AUTO-NO"; do
  default_count="$(/usr/bin/grep -Fxc "$default_marker" "$WATCH_OUTPUT" || true)"
  emit "WATCH_CONTRACT_MARKER_COUNT=${default_count}|MARKER=${default_marker}"
  if [[ "$default_count" != "1" ]]; then
    WATCH_CONTRACT_OK=0
  fi
done

WATCH_RESULT_COUNT="$(/usr/bin/grep -Ec '^D97AEX_RESULT=' "$WATCH_OUTPUT" || true)"
WATCH_STOP_FATAL_COUNT="$(/usr/bin/grep -Ec '^D97AEX_(STOP|FATAL)=' "$WATCH_OUTPUT" || true)"
MATCH_RESULT_COUNT="$(/usr/bin/grep -Fxc 'D97AEX_RESULT=OBSERVED_COHORT_BOUNDED_31_WINDOW_PROVENANCE_MATCH' "$WATCH_OUTPUT" || true)"
MISMATCH_RESULT_COUNT="$(/usr/bin/grep -Fxc 'D97AEX_RESULT=OBSERVED_COHORT_BOUNDED_31_WINDOW_PROVENANCE_MISMATCH' "$WATCH_OUTPUT" || true)"
INCOMPLETE_RESULT_COUNT="$(/usr/bin/grep -Fxc 'D97AEX_RESULT=COVERAGE_INCOMPLETE_STOP' "$WATCH_OUTPUT" || true)"
COVERAGE_COMPLETE_COUNT="$(/usr/bin/grep -Fxc 'COHORT_COVERAGE=ALL_DISCOVERED_EXACT_INSTANCES_COMPLETE' "$WATCH_OUTPUT" || true)"
COVERAGE_INCOMPLETE_COUNT="$(/usr/bin/grep -Fxc 'COHORT_COVERAGE=INCOMPLETE' "$WATCH_OUTPUT" || true)"
BYTES_YES_COUNT="$(/usr/bin/grep -Fxc 'COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=YES|SCOPE=OBSERVED_COHORT_31_WINDOWS_330_BYTES_EACH' "$WATCH_OUTPUT" || true)"
BYTES_NEGATIVE_COUNT="$(/usr/bin/grep -Fxc 'COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=NEGATIVE' "$WATCH_OUTPUT" || true)"
BYTES_UNKNOWN_COUNT="$(/usr/bin/grep -Fxc 'COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN' "$WATCH_OUTPUT" || true)"
PROVENANCE_MATCH_COUNT="$(/usr/bin/grep -Fxc 'COHORT_BOUNDED_31_WINDOW_PROVENANCE=MATCH' "$WATCH_OUTPUT" || true)"
PROVENANCE_MISMATCH_COUNT="$(/usr/bin/grep -Fxc 'COHORT_BOUNDED_31_WINDOW_PROVENANCE=MISMATCH' "$WATCH_OUTPUT" || true)"
emit "WATCH_RESULT_MARKER_COUNT=$WATCH_RESULT_COUNT"
emit "WATCH_STOP_FATAL_MARKER_COUNT=$WATCH_STOP_FATAL_COUNT"
emit "WATCH_RESULT_CLASS_COUNTS=MATCH:${MATCH_RESULT_COUNT}|MISMATCH:${MISMATCH_RESULT_COUNT}|INCOMPLETE:${INCOMPLETE_RESULT_COUNT}"

SUMMARY_PARSE_OK=0
SUMMARY_INVARIANTS_OK=0
if parse_watch_summary; then
  SUMMARY_PARSE_OK=1
  emit "WATCH_SUMMARY_PARSE=PASS"
  emit "WATCH_SUMMARY_FIELDS=POLLS:${SUMMARY_POLLS}|UNIQUE:${SUMMARY_UNIQUE}|COMPLETE:${SUMMARY_COMPLETE}|MATCH:${SUMMARY_MATCH}|MISMATCH:${SUMMARY_MISMATCH}|UUID_NEGATIVE:${SUMMARY_UUID_NEGATIVE}|EXIT_RACE:${SUMMARY_EXIT_RACE}|PREFILTER_RACE:${SUMMARY_PREFILTER_RACE}|PENDING:${SUMMARY_PENDING}|MINIMUM:${SUMMARY_MINIMUM}"
  if (( SUMMARY_POLLS > 0 && SUMMARY_MINIMUM == 3 && \
        SUMMARY_MATCH + SUMMARY_MISMATCH == SUMMARY_COMPLETE && \
        SUMMARY_UNIQUE == SUMMARY_COMPLETE + SUMMARY_UUID_NEGATIVE + \
                          SUMMARY_EXIT_RACE + SUMMARY_PENDING )); then
    SUMMARY_INVARIANTS_OK=1
    emit "WATCH_SUMMARY_COUNTER_INVARIANTS=PASS"
  else
    emit "WATCH_SUMMARY_COUNTER_INVARIANTS=FAIL"
  fi
else
  emit "WATCH_SUMMARY_PARSE=NOT_AVAILABLE_OR_INVALID"
  emit "WATCH_SUMMARY_COUNTER_INVARIANTS=NOT_AVAILABLE"
fi

WATCH_TERMINAL_OK=0
case "$WATCH_RC" in
  0)
    if (( SUMMARY_PARSE_OK == 1 && SUMMARY_INVARIANTS_OK == 1 )); then
      if [[ "$WATCH_RESULT_COUNT" == "1" && "$WATCH_STOP_FATAL_COUNT" == "0" && \
            "$MATCH_RESULT_COUNT" == "1" && \
            "$MISMATCH_RESULT_COUNT" == "0" && "$INCOMPLETE_RESULT_COUNT" == "0" && \
            "$COVERAGE_COMPLETE_COUNT" == "1" && "$COVERAGE_INCOMPLETE_COUNT" == "0" && \
            "$BYTES_YES_COUNT" == "1" && "$BYTES_NEGATIVE_COUNT" == "0" && \
            "$BYTES_UNKNOWN_COUNT" == "0" && "$PROVENANCE_MATCH_COUNT" == "1" && \
            "$PROVENANCE_MISMATCH_COUNT" == "0" ]] && \
         (( SUMMARY_POLLS > 0 && SUMMARY_MINIMUM == 3 && SUMMARY_COMPLETE >= 3 && \
            SUMMARY_UNIQUE == SUMMARY_COMPLETE && SUMMARY_MATCH == SUMMARY_COMPLETE && \
            SUMMARY_MISMATCH == 0 && SUMMARY_UUID_NEGATIVE == 0 && \
            SUMMARY_EXIT_RACE == 0 && SUMMARY_PREFILTER_RACE == 0 && SUMMARY_PENDING == 0 )); then
        WATCH_TERMINAL_OK=1
      fi
    fi
    ;;
  2)
    if [[ "$WATCH_RESULT_COUNT" == "0" && "$WATCH_STOP_FATAL_COUNT" == "1" && \
          "$WATCH_SUMMARY_COUNT" == "0" && "$MATCH_RESULT_COUNT" == "0" && \
          "$MISMATCH_RESULT_COUNT" == "0" && "$INCOMPLETE_RESULT_COUNT" == "0" && \
          "$COVERAGE_COMPLETE_COUNT" == "0" && "$COVERAGE_INCOMPLETE_COUNT" == "0" && \
          "$BYTES_YES_COUNT" == "0" && "$BYTES_NEGATIVE_COUNT" == "0" && \
          "$PROVENANCE_MATCH_COUNT" == "0" && "$PROVENANCE_MISMATCH_COUNT" == "0" ]] && \
       (( BYTES_UNKNOWN_COUNT <= 1 )); then
      WATCH_TERMINAL_OK=1
    fi
    ;;
  3)
    if (( SUMMARY_PARSE_OK == 1 && SUMMARY_INVARIANTS_OK == 1 )); then
      if [[ "$WATCH_RESULT_COUNT" == "1" && "$WATCH_STOP_FATAL_COUNT" == "0" && \
            "$MATCH_RESULT_COUNT" == "0" && \
            "$MISMATCH_RESULT_COUNT" == "0" && "$INCOMPLETE_RESULT_COUNT" == "1" && \
            "$COVERAGE_COMPLETE_COUNT" == "0" && "$COVERAGE_INCOMPLETE_COUNT" == "1" && \
            "$BYTES_YES_COUNT" == "0" && "$BYTES_NEGATIVE_COUNT" == "0" && \
            "$BYTES_UNKNOWN_COUNT" == "1" && "$PROVENANCE_MATCH_COUNT" == "0" && \
            "$PROVENANCE_MISMATCH_COUNT" == "0" ]] && \
         (( SUMMARY_POLLS > 0 && SUMMARY_MINIMUM == 3 && \
            (SUMMARY_COMPLETE < SUMMARY_MINIMUM || SUMMARY_UUID_NEGATIVE != 0 || \
             SUMMARY_EXIT_RACE != 0 || SUMMARY_PREFILTER_RACE != 0 || SUMMARY_PENDING != 0) )); then
        WATCH_TERMINAL_OK=1
      fi
    fi
    ;;
  4)
    if (( SUMMARY_PARSE_OK == 1 && SUMMARY_INVARIANTS_OK == 1 )); then
      if [[ "$WATCH_RESULT_COUNT" == "1" && "$WATCH_STOP_FATAL_COUNT" == "0" && \
            "$MATCH_RESULT_COUNT" == "0" && \
            "$MISMATCH_RESULT_COUNT" == "1" && "$INCOMPLETE_RESULT_COUNT" == "0" && \
            "$COVERAGE_COMPLETE_COUNT" == "1" && "$COVERAGE_INCOMPLETE_COUNT" == "0" && \
            "$BYTES_YES_COUNT" == "0" && "$BYTES_NEGATIVE_COUNT" == "1" && \
            "$BYTES_UNKNOWN_COUNT" == "0" && "$PROVENANCE_MATCH_COUNT" == "0" && \
            "$PROVENANCE_MISMATCH_COUNT" == "1" ]] && \
         (( SUMMARY_POLLS > 0 && SUMMARY_MINIMUM == 3 && SUMMARY_COMPLETE >= 3 && \
            SUMMARY_UNIQUE == SUMMARY_COMPLETE && SUMMARY_MATCH + SUMMARY_MISMATCH == SUMMARY_COMPLETE && \
            SUMMARY_MISMATCH > 0 && SUMMARY_UUID_NEGATIVE == 0 && \
            SUMMARY_EXIT_RACE == 0 && SUMMARY_PREFILTER_RACE == 0 && SUMMARY_PENDING == 0 )); then
        WATCH_TERMINAL_OK=1
      fi
    fi
    ;;
  *)
    WATCH_TERMINAL_OK=0
    ;;
esac
emit "WATCH_TERMINAL_CONTRACT=$([[ "$WATCH_TERMINAL_OK" == "1" ]] && print PASS || print FAIL)"
if [[ "$WATCH_TEE_RC" != "0" ]]; then
  emit "WATCH_TRANSCRIPT_TEE=FAIL|RC=$WATCH_TEE_RC"
  WATCH_CONTRACT_OK=0
else
  emit "WATCH_TRANSCRIPT_TEE=PASS"
fi

# These post-execution gates are deliberately unconditional for every helper
# outcome, including RC 2, 3, and 4.
POST_GATES_OK=1
if helper_identity_gate "POST_WATCH"; then
  :
else
  POST_GATES_OK=0
fi
if file_identity_gate "POST" "SERVICE" "$SERVICE" "$SERVICE_SHA256_EXPECTED" ""; then
  SERVICE_IDENTITY_POST="$GATE_IDENTITY"
else
  SERVICE_IDENTITY_POST="UNKNOWN"
  POST_GATES_OK=0
fi
if file_identity_gate "POST" "TARGET" "$TARGET" "$TARGET_SHA256_EXPECTED" "$TARGET_BYTES_EXPECTED"; then
  TARGET_IDENTITY_POST="$GATE_IDENTITY"
else
  TARGET_IDENTITY_POST="UNKNOWN"
  POST_GATES_OK=0
fi
if [[ "$SERVICE_IDENTITY_PRE" != "$SERVICE_IDENTITY_POST" ]]; then
  emit "SERVICE_PRE_POST_IDENTITY=FAIL"
  POST_GATES_OK=0
else
  emit "SERVICE_PRE_POST_IDENTITY=PASS"
fi
if [[ "$TARGET_IDENTITY_PRE" != "$TARGET_IDENTITY_POST" ]]; then
  emit "TARGET_PRE_POST_IDENTITY=FAIL"
  POST_GATES_OK=0
else
  emit "TARGET_PRE_POST_IDENTITY=PASS"
fi

/bin/sleep 2
emit "LOG_VISIBLE_QUERY_BEGIN=READ_ONLY_RETROSPECTIVE_UNIFIED_LOG"
if /usr/bin/log show --start "$LOG_START_LOCAL" --end "$LOG_END_LOCAL" \
    --style ndjson --color none --info --debug --no-pager \
    --predicate "$LOG_PREDICATE" > "$LOG_OUTPUT" 2> "$LOG_ERROR"; then
  LOG_RC=0
else
  LOG_RC=$?
fi
emit "LOG_VISIBLE_QUERY_RC=$LOG_RC"
emit "LOG_VISIBLE_FORMAT=NDJSON"
emit "LOG_VISIBLE_QUERY_SCOPE=RETROSPECTIVE_UNIFIED_LOG_GUARDED_WALLCLOCK_ENVELOPE"
emit "LOG_VISIBLE_TIME_BOUNDARY=FLOOR_START_MINUS_1_SECOND_TO_FLOOR_END_PLUS_1_SECOND"
emit "QUERY_SCOPE=GUARDED_WALLCLOCK_ENVELOPE_NOT_CAUSAL"
LOG_OUTPUT_SHA256="$(sha256_file "$LOG_OUTPUT" 2>/dev/null || print UNKNOWN)"
LOG_OUTPUT_BYTES="$(/usr/bin/stat -f '%z' "$LOG_OUTPUT" 2>/dev/null || print UNKNOWN)"
LOG_ERROR_SHA256="$(sha256_file "$LOG_ERROR" 2>/dev/null || print UNKNOWN)"
LOG_ERROR_BYTES="$(/usr/bin/stat -f '%z' "$LOG_ERROR" 2>/dev/null || print UNKNOWN)"
emit "LOG_VISIBLE_NDJSON_SHA256=$LOG_OUTPUT_SHA256"
emit "LOG_VISIBLE_NDJSON_BYTES=$LOG_OUTPUT_BYTES"
emit "LOG_VISIBLE_STDERR_SHA256=$LOG_ERROR_SHA256"
emit "LOG_VISIBLE_STDERR_BYTES=$LOG_ERROR_BYTES"
emit "===== BEGIN LOG_VISIBLE RAW CENSUS ====="
append_file "$LOG_OUTPUT"
emit "===== END LOG_VISIBLE RAW CENSUS ====="
emit "===== BEGIN LOG_VISIBLE STDERR ====="
append_file "$LOG_ERROR"
emit "===== END LOG_VISIBLE STDERR ====="

LOG_CENSUS_AVAILABLE=0
if (( LOG_RC == 0 && TEMPORAL_IDENTITY_OK == 1 )); then
  LOG_FINISHED_FIELD_COUNT="$(/usr/bin/grep -Ec '"finished"[[:space:]]*:' "$LOG_OUTPUT" || true)"
  LOG_FINISHED_COUNT="$(/usr/bin/grep -Ec '^[[:space:]]*\{[[:space:]]*"count"[[:space:]]*:[[:space:]]*[0-9]+[[:space:]]*,[[:space:]]*"finished"[[:space:]]*:[[:space:]]*1[[:space:]]*\}[[:space:]]*$' "$LOG_OUTPUT" || true)"
  LOG_FINISHED_DECLARED_COUNT="$(/usr/bin/sed -nE 's/^[[:space:]]*\{[[:space:]]*"count"[[:space:]]*:[[:space:]]*([0-9]+)[[:space:]]*,[[:space:]]*"finished"[[:space:]]*:[[:space:]]*1[[:space:]]*\}[[:space:]]*$/\1/p' "$LOG_OUTPUT" | /usr/bin/grep -E '^[0-9]+$' || true)"
  LOG_NONEMPTY_RECORD_COUNT="$(/usr/bin/grep -Evc '^[[:space:]]*$|^[[:space:]]*\{[[:space:]]*"count"[[:space:]]*:[[:space:]]*[0-9]+[[:space:]]*,[[:space:]]*"finished"[[:space:]]*:[[:space:]]*1[[:space:]]*\}[[:space:]]*$' "$LOG_OUTPUT" || true)"
  LOG_LAST_RECORD="$(/usr/bin/tail -n 1 "$LOG_OUTPUT" || true)"
  if [[ "$LOG_FINISHED_FIELD_COUNT" == "1" && "$LOG_FINISHED_COUNT" == "1" && \
        "$LOG_FINISHED_DECLARED_COUNT" == <-> && \
        "$LOG_FINISHED_DECLARED_COUNT" == "$LOG_NONEMPTY_RECORD_COUNT" ]] && \
     print -r -- "$LOG_LAST_RECORD" | /usr/bin/grep -Eq \
       '^[[:space:]]*\{[[:space:]]*"count"[[:space:]]*:[[:space:]]*[0-9]+[[:space:]]*,[[:space:]]*"finished"[[:space:]]*:[[:space:]]*1[[:space:]]*\}[[:space:]]*$'; then
    LOG_PARSER_COMPLETE=1
  else
    LOG_PARSER_COMPLETE=0
  fi
  emit "LOG_VISIBLE_FINISHED_FIELD_COUNT=$LOG_FINISHED_FIELD_COUNT"
  emit "LOG_VISIBLE_FINISHED_RECORD_COUNT=$LOG_FINISHED_COUNT"
  emit "LOG_VISIBLE_FINISHED_DECLARED_RECORD_COUNT=${LOG_FINISHED_DECLARED_COUNT:-UNKNOWN}"
  emit "LOG_VISIBLE_OBSERVED_RECORD_COUNT_BEFORE_TRAILER=$LOG_NONEMPTY_RECORD_COUNT"
  emit "LOG_VISIBLE_PARSER_COMPLETE=$([[ "$LOG_PARSER_COMPLETE" == "1" ]] && print YES || print NO)"
  if (( LOG_PARSER_COMPLETE == 1 )); then
    /usr/bin/sed -nE \
      -e '/"processImagePath"[[:space:]]*:[[:space:]]*"\/System\/Library\/Frameworks\/Metal\.framework\/Versions\/A\/XPCServices\/MTLCompilerService\.xpc\/Contents\/MacOS\/MTLCompilerService"/ s/.*"processID"[[:space:]]*:[[:space:]]*([0-9]+).*/\1/p' \
      -e '/"processImagePath"[[:space:]]*:[[:space:]]*"\/System\/Library\/Frameworks\/Metal\.framework\/Versions\/A\/XPCServices\/MTLCompilerService\.xpc\/Contents\/MacOS\/MTLCompilerService"/ s/.*"processIdentifier"[[:space:]]*:[[:space:]]*([0-9]+).*/\1/p' \
      "$LOG_OUTPUT" | /usr/bin/grep -E '^[0-9]+$' | \
      LC_ALL=C /usr/bin/sort -u > "$LOG_SERVICE_PIDS" || true
    /usr/bin/sed -nE \
      '/"processImagePath"[[:space:]]*:[[:space:]]*"\/sbin\/launchd"/ s/.*Successfully spawned MTLCompilerService\[([0-9]+)\].*/\1/p' \
      "$LOG_OUTPUT" | /usr/bin/grep -E '^[0-9]+$' | \
      LC_ALL=C /usr/bin/sort -u > "$LOG_SPAWN_PIDS" || true
    /usr/bin/sed -nE \
      '/"processImagePath"[[:space:]]*:[[:space:]]*"\/sbin\/launchd"/ s/.*com\.apple\.MTLCompilerService[^ ]*[[:space:]]+\[([0-9]+)\]:\].*/\1/p' \
      "$LOG_OUTPUT" | /usr/bin/grep -E '^[0-9]+$' | \
      LC_ALL=C /usr/bin/sort -u > "$LOG_LAUNCHD_PIDS" || true
    /bin/cat "$LOG_SERVICE_PIDS" "$LOG_SPAWN_PIDS" "$LOG_LAUNCHD_PIDS" | \
      /usr/bin/grep -E '^[0-9]+$' | LC_ALL=C /usr/bin/sort -u > "$LOG_PIDS" || true
    /usr/bin/sed -nE 's/.*PID=([0-9]+).*/\1/p' "$WATCH_OUTPUT" | \
      /usr/bin/grep -E '^[0-9]+$' | LC_ALL=C /usr/bin/sort -u > "$HELPER_PIDS" || true
    LC_ALL=C /usr/bin/comm -12 "$HELPER_PIDS" "$LOG_PIDS" > "$PID_COMMON"
    LC_ALL=C /usr/bin/comm -23 "$HELPER_PIDS" "$LOG_PIDS" > "$PID_HELPER_ONLY"
    LC_ALL=C /usr/bin/comm -13 "$HELPER_PIDS" "$LOG_PIDS" > "$PID_LOG_ONLY"
    LOG_RECORD_COUNT="$LOG_NONEMPTY_RECORD_COUNT"
    LOG_SERVICE_PID_COUNT="$(/usr/bin/wc -l < "$LOG_SERVICE_PIDS" | /usr/bin/tr -d '[:space:]')"
    LOG_SPAWN_PID_COUNT="$(/usr/bin/wc -l < "$LOG_SPAWN_PIDS" | /usr/bin/tr -d '[:space:]')"
    LOG_LAUNCHD_PID_COUNT="$(/usr/bin/wc -l < "$LOG_LAUNCHD_PIDS" | /usr/bin/tr -d '[:space:]')"
    LOG_PID_COUNT="$(/usr/bin/wc -l < "$LOG_PIDS" | /usr/bin/tr -d '[:space:]')"
    HELPER_PID_COUNT="$(/usr/bin/wc -l < "$HELPER_PIDS" | /usr/bin/tr -d '[:space:]')"
    PID_COMMON_COUNT="$(/usr/bin/wc -l < "$PID_COMMON" | /usr/bin/tr -d '[:space:]')"
    PID_HELPER_ONLY_COUNT="$(/usr/bin/wc -l < "$PID_HELPER_ONLY" | /usr/bin/tr -d '[:space:]')"
    PID_LOG_ONLY_COUNT="$(/usr/bin/wc -l < "$PID_LOG_ONLY" | /usr/bin/tr -d '[:space:]')"
    if [[ "$LOG_PID_COUNT" == "0" ]]; then
      LOG_PID_LIST="EMPTY"
    else
      LOG_PID_LIST="$(/usr/bin/tr '\n' ',' < "$LOG_PIDS" | /usr/bin/sed 's/,$//')"
    fi
    if [[ "$HELPER_PID_COUNT" == "0" ]]; then
      HELPER_PID_LIST="EMPTY"
    else
      HELPER_PID_LIST="$(/usr/bin/tr '\n' ',' < "$HELPER_PIDS" | /usr/bin/sed 's/,$//')"
    fi
    PID_COMMON_LIST="$(/usr/bin/tr '\n' ',' < "$PID_COMMON" | /usr/bin/sed 's/,$//' || true)"
    PID_HELPER_ONLY_LIST="$(/usr/bin/tr '\n' ',' < "$PID_HELPER_ONLY" | /usr/bin/sed 's/,$//' || true)"
    PID_LOG_ONLY_LIST="$(/usr/bin/tr '\n' ',' < "$PID_LOG_ONLY" | /usr/bin/sed 's/,$//' || true)"
    [[ -n "$PID_COMMON_LIST" ]] || PID_COMMON_LIST="EMPTY"
    [[ -n "$PID_HELPER_ONLY_LIST" ]] || PID_HELPER_ONLY_LIST="EMPTY"
    [[ -n "$PID_LOG_ONLY_LIST" ]] || PID_LOG_ONLY_LIST="EMPTY"
    LOG_CENSUS_AVAILABLE=1
    emit "LOG_VISIBLE_QUERY=AVAILABLE_PARSER_COMPLETE"
    emit "LOG_VISIBLE_RECORD_COUNT=$LOG_RECORD_COUNT"
    emit "LOG_VISIBLE_SERVICE_ORIGIN_PID_COUNT=$LOG_SERVICE_PID_COUNT"
    emit "LOG_VISIBLE_SPAWN_EVENT_PID_COUNT=$LOG_SPAWN_PID_COUNT"
    emit "LOG_VISIBLE_LAUNCHD_LIFECYCLE_PID_COUNT=$LOG_LAUNCHD_PID_COUNT"
    emit "LOG_VISIBLE_PID_COUNT=$LOG_PID_COUNT"
    emit "LOG_VISIBLE_PID_LIST=$LOG_PID_LIST"
    emit "HELPER_REPORTED_PID_COUNT=$HELPER_PID_COUNT"
    emit "HELPER_REPORTED_PID_LIST=$HELPER_PID_LIST"
    emit "PID_NUMBER_SET_COMMON_COUNT=$PID_COMMON_COUNT|PIDS=$PID_COMMON_LIST"
    emit "PID_NUMBER_SET_HELPER_ONLY_COUNT=$PID_HELPER_ONLY_COUNT|PIDS=$PID_HELPER_ONLY_LIST"
    emit "PID_NUMBER_SET_LOG_VISIBLE_ONLY_COUNT=$PID_LOG_ONLY_COUNT|PIDS=$PID_LOG_ONLY_LIST"
    emit "LOG_VISIBLE_PID_COMPARISON_SCOPE=PID_NUMBER_SET_ONLY_NO_IDENTITY_OR_REUSE_PROOF"
    emit "LOG_VISIBLE_COHORT_COVERAGE=LOG_VISIBLE_ONLY_NOT_GLOBAL"
  else
    emit "LOG_VISIBLE_QUERY=AVAILABLE_BUT_PARSER_INCOMPLETE"
    emit "LOG_VISIBLE_RECORD_COUNT=UNKNOWN"
    emit "LOG_VISIBLE_PID_COUNT=UNKNOWN"
    emit "LOG_VISIBLE_PID_LIST=UNKNOWN"
    emit "LOG_VISIBLE_COHORT_COVERAGE=UNKNOWN"
  fi
elif (( LOG_RC == 0 )); then
  emit "LOG_VISIBLE_FINISHED_FIELD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_FINISHED_RECORD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_FINISHED_DECLARED_RECORD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_OBSERVED_RECORD_COUNT_BEFORE_TRAILER=UNKNOWN"
  emit "LOG_VISIBLE_PARSER_COMPLETE=NO"
  emit "LOG_VISIBLE_QUERY=UNAVAILABLE_TEMPORAL_IDENTITY_CHANGED"
  emit "LOG_VISIBLE_RECORD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_PID_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_PID_LIST=UNKNOWN"
  emit "LOG_VISIBLE_COHORT_COVERAGE=UNKNOWN"
else
  emit "LOG_VISIBLE_FINISHED_FIELD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_FINISHED_RECORD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_FINISHED_DECLARED_RECORD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_OBSERVED_RECORD_COUNT_BEFORE_TRAILER=UNKNOWN"
  emit "LOG_VISIBLE_PARSER_COMPLETE=NO"
  emit "LOG_VISIBLE_QUERY=UNAVAILABLE"
  emit "LOG_VISIBLE_RECORD_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_PID_COUNT=UNKNOWN"
  emit "LOG_VISIBLE_PID_LIST=UNKNOWN"
  emit "LOG_VISIBLE_COHORT_COVERAGE=UNKNOWN"
fi
emit "LOG_VISIBLE_VS_HELPER_COHORT_EQUIVALENCE=NOT_CLAIMED"
emit "LOG_VISIBILITY_COMPLETENESS=NOT_ASSUMED"
emit "INTER_POLL_INSTANCE_VISIBILITY=NOT_GUARANTEED"
emit "GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN"

FINAL_RC="$WATCH_RC"
if (( WATCH_CONTRACT_OK != 1 || WATCH_TERMINAL_OK != 1 || \
      POST_GATES_OK != 1 || TEMPORAL_IDENTITY_OK != 1 )); then
  emit "D97AEX_WRAPPER_AUDIT=FAIL_CLOSED"
  FINAL_RC=2
elif (( LOG_CENSUS_AVAILABLE == 1 )); then
  emit "LOG_VISIBLE_CENSUS_STATUS=AVAILABLE_PARSER_COMPLETE"
  emit "D97AEX_WRAPPER_AUDIT=PASS_CORE_AND_LOG_VISIBLE_CENSUS"
else
  emit "LOG_VISIBLE_CENSUS_STATUS=UNKNOWN"
  emit "D97AEX_WRAPPER_AUDIT=PASS_CORE_LOG_VISIBLE_CENSUS_UNKNOWN"
fi

case "$FINAL_RC" in
  0)
    emit "D97AEX_WRAPPER_RESULT=OBSERVED_COHORT_BOUNDED_PROVENANCE_MATCH"
    ;;
  2)
    emit "D97AEX_WRAPPER_RESULT=FAIL_CLOSED_BLOCKER_STOP"
    ;;
  3)
    emit "D97AEX_WRAPPER_RESULT=COVERAGE_INCOMPLETE_STOP"
    ;;
  4)
    emit "D97AEX_WRAPPER_RESULT=OBSERVED_COHORT_BOUNDED_PROVENANCE_MISMATCH"
    ;;
  *)
    emit "D97AEX_WRAPPER_RESULT=UNEXPECTED_HELPER_RC_FAIL_CLOSED"
    FINAL_RC=2
    ;;
esac

emit "SOURCE_MUTATION=NO"
emit "SYSTEM_MUTATION=NO_PROJECT_TARGETS"
emit "SYSTEM_FILE_MUTATION=NO"
emit "GOLDEN_MUTATION=NO"
emit "TARGET_CODE_BYTES_MUTATION=NO"
emit "TARGET_PROCESS_CONTROL_MUTATION=NO"
emit "SERVICE_LAUNCH=AUTO-NO"
emit "SERVICE_STOP=AUTO-NO"
emit "ROOT_PATCH=AUTO-NO"
emit "REBOOT=AUTO-NO"
emit "D97AEX_WRAPPER_EXIT_RC_IF_FINAL_REPORT_IDENTITY_PASS=$FINAL_RC"
emit "REPORT=$REPORT"
final_report_fail() {
  local reason="$1"
  print -r -- "REPORT_FINAL_IDENTITY=FAIL|REASON=$reason"
  print -r -- "D97AEX_WRAPPER_EXIT_RC=2"
  exit 2
}
if [[ ! -f "$REPORT" || -L "$REPORT" ]]; then
  final_report_fail "NOT_REGULAR_OR_IS_SYMLINK"
fi
REPORT_FINAL_STAT_BEFORE="$(/usr/bin/stat -f 'DEV=%d|INODE=%i|SIZE=%z|MTIME=%m|MODE=%Lp|NLINK=%l|UID=%u' "$REPORT")" || \
  final_report_fail "STAT_BEFORE_FAILED"
REPORT_FINAL_DEV_INODE="$(/usr/bin/stat -f 'DEV=%d|INODE=%i' "$REPORT")" || \
  final_report_fail "DEV_INODE_FAILED"
REPORT_FINAL_MODE="$(/usr/bin/stat -f '%Lp' "$REPORT")" || final_report_fail "MODE_FAILED"
REPORT_FINAL_NLINK="$(/usr/bin/stat -f '%l' "$REPORT")" || final_report_fail "NLINK_FAILED"
REPORT_FINAL_OWNER="$(/usr/bin/stat -f '%u' "$REPORT")" || final_report_fail "OWNER_FAILED"
if [[ "$REPORT_FINAL_DEV_INODE" != "$REPORT_INITIAL_DEV_INODE" || \
      "$REPORT_FINAL_MODE" != "600" || "$REPORT_FINAL_NLINK" != "1" || \
      "$REPORT_FINAL_OWNER" != "$REPORT_OWNER_EXPECTED" ]]; then
  final_report_fail "DEV_INODE_MODE_NLINK_OR_OWNER_MISMATCH"
fi
REPORT_FINAL_SHA256="$(sha256_file "$REPORT")" || final_report_fail "SHA256_FAILED"
REPORT_FINAL_STAT_AFTER="$(/usr/bin/stat -f 'DEV=%d|INODE=%i|SIZE=%z|MTIME=%m|MODE=%Lp|NLINK=%l|UID=%u' "$REPORT")" || \
  final_report_fail "STAT_AFTER_FAILED"
if [[ "$REPORT_FINAL_STAT_BEFORE" != "$REPORT_FINAL_STAT_AFTER" ]]; then
  final_report_fail "CHANGED_DURING_FINAL_HASH"
fi
REPORT_FINAL_BYTES="$(/usr/bin/stat -f '%z' "$REPORT")" || final_report_fail "BYTE_COUNT_FAILED"
print -r -- "REPORT_FINAL_IDENTITY=PASS"
print -r -- "REPORT_FINAL_BYTES=$REPORT_FINAL_BYTES"
print -r -- "REPORT_FINAL_SHA256=$REPORT_FINAL_SHA256"
print -r -- "D97AEX_WRAPPER_EXIT_RC=$FINAL_RC"
exit "$FINAL_RC"
