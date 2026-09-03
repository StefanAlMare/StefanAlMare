#!/bin/zsh -f
set -euo pipefail

REPO="StefanAlMare/Private-Work"
RELEASE_ID="382366988"
RELEASE_TAG="oclp7-d97am-run-33812721798-attempt-1"
RELEASE_HEAD="6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d"
PART0_ID="543427689"
PART0_NAME="OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00"
PART0_BYTES="390000000"
PART0_SHA256="9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67"
PART1_ID="543427740"
PART1_NAME="OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01"
PART1_BYTES="361495650"
PART1_SHA256="80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08"
D97AM_ZIP_NAME="OCLP7-D97AM-OpenCore-Patcher.app.zip"
D97AM_ZIP_BYTES="751495650"
D97AM_ZIP_SHA256="d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca"
D97AM_EXE_BYTES="6596496"
D97AM_EXE_SHA256="fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3"
D97AH_EXE_BYTES="6596544"
D97AH_EXE_SHA256="207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf"
MIN_FREE_KB="4194304"

STAMP="$(/bin/date +%Y%m%d-%H%M%S)"
REPORT="$HOME/Desktop/OCLP7_D97AM_EXACT_APP_DEPLOY_OPEN_STOP_REPORT_$STAMP.txt"
TEMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AM_DEPLOY.XXXXXX)"
PART0="$TEMP_ROOT/$PART0_NAME"
PART1="$TEMP_ROOT/$PART1_NAME"
VERIFIED_ZIP="$TEMP_ROOT/$D97AM_ZIP_NAME"
EXTRACT_ROOT="$TEMP_ROOT/extracted"
LIVE_APP="/Applications/OpenCore-Patcher.app"
LIVE_EXE="$LIVE_APP/Contents/MacOS/OpenCore-Patcher"
BACKUP_APP="/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-$STAMP"
BACKUP_EXE="$BACKUP_APP/Contents/MacOS/OpenCore-Patcher"
NEW_APP="/Applications/OpenCore-Patcher.app.D97AM-deploying-$STAMP"
NEW_EXE="$NEW_APP/Contents/MacOS/OpenCore-Patcher"
FAILED_APP="/Applications/OpenCore-Patcher.app.D97AM-failed-$STAMP"
INSTALLED_APP_MUTATION_STATE="NO"

cleanup_temp() {
  if [[ "$TEMP_ROOT" == /private/tmp/OCLP7_D97AM_DEPLOY.* && -d "$TEMP_ROOT" && ! -L "$TEMP_ROOT" ]]; then
    /bin/rm -rf "$TEMP_ROOT" || true
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
    echo "D97AM_DEPLOY_EXIT_RECOVERY_BEGIN=STATE:$INSTALLED_APP_MUTATION_STATE|RC:$exit_rc"
    case "$INSTALLED_APP_MUTATION_STATE" in
      NO)
        echo "D97AM_DEPLOY_EXIT_RECOVERY=NOT_REQUIRED_NO_APPLICATION_MUTATION"
        ;;
      NEW_APP_COPYING|NEW_APP_READY)
        if [[ "$NEW_APP" == /Applications/OpenCore-Patcher.app.D97AM-deploying-* && ( -e "$NEW_APP" || -L "$NEW_APP" ) ]]; then
          /usr/bin/sudo -n /bin/rm -rf "$NEW_APP"
          echo "D97AM_DEPLOY_EXIT_RECOVERY_STAGING_REMOVE_RC=$?"
        fi
        echo "D97AM_DEPLOY_EXIT_RECOVERY=LIVE_D97AH_SHOULD_REMAIN_UNCHANGED"
        ;;
      LIVE_MOVED_TO_BACKUP|D97AM_DEPLOYED_PENDING_AUDIT|D97AM_DEPLOYED_PENDING_OPEN)
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
            echo "D97AM_DEPLOY_EXIT_RECOVERY_QUARANTINE_RC=$?"
          else
            echo "D97AM_DEPLOY_EXIT_RECOVERY_QUARANTINE=SKIPPED_FAILED_PATH_EXISTS"
          fi
        fi
        if [[ -d "$BACKUP_APP" && ! -L "$BACKUP_APP" && ! -e "$LIVE_APP" && ! -L "$LIVE_APP" ]]; then
          /usr/bin/sudo -n /bin/mv "$BACKUP_APP" "$LIVE_APP"
          local restore_rc=$?
          echo "D97AM_DEPLOY_EXIT_RECOVERY_RESTORE_MOVE_RC=$restore_rc"
          if (( restore_rc == 0 )) && [[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" ]]; then
            local restored_sha restored_bytes
            restored_sha="$(sha256_file "$LIVE_EXE" 2>/dev/null || true)"
            restored_bytes="$(/usr/bin/stat -f '%z' "$LIVE_EXE" 2>/dev/null || true)"
            echo "D97AM_DEPLOY_EXIT_RECOVERY_RESTORED_BYTES=$restored_bytes"
            echo "D97AM_DEPLOY_EXIT_RECOVERY_RESTORED_SHA256=$restored_sha"
            if [[ "$restored_sha" == "$D97AH_EXE_SHA256" && "$restored_bytes" == "$D97AH_EXE_BYTES" ]]; then
              INSTALLED_APP_MUTATION_STATE="D97AH_RESTORED_EXACT"
              echo "D97AM_DEPLOY_EXIT_RECOVERY=PASS_D97AH_RESTORED_EXACT"
            else
              echo "D97AM_DEPLOY_EXIT_RECOVERY=FAIL_RESTORED_IDENTITY"
            fi
          fi
        else
          echo "D97AM_DEPLOY_EXIT_RECOVERY=FAIL_BACKUP_OR_LIVE_PATH_STATE"
        fi
        if [[ "$NEW_APP" == /Applications/OpenCore-Patcher.app.D97AM-deploying-* && ( -e "$NEW_APP" || -L "$NEW_APP" ) ]]; then
          /usr/bin/sudo -n /bin/rm -rf "$NEW_APP"
          echo "D97AM_DEPLOY_EXIT_RECOVERY_STAGING_REMOVE_RC=$?"
        fi
        ;;
      D97AM_DEPLOYED_EXACT_OPENED)
        echo "D97AM_DEPLOY_EXIT_RECOVERY=NOT_REQUIRED_EXACT_D97AM_LIVE_BACKUP_RETAINED"
        ;;
      *)
        echo "D97AM_DEPLOY_EXIT_RECOVERY=UNKNOWN_STATE:$INSTALLED_APP_MUTATION_STATE"
        ;;
    esac
    echo "D97AM_DEPLOY_EXIT_RECOVERY_FINAL_STATE=$INSTALLED_APP_MUTATION_STATE"
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
  echo "D97AM_EXACT_APP_DEPLOY_OPEN_STOP=FAIL_CLOSED|REASON=$*"
  echo "INSTALLED_APP_MUTATION_STATE=$INSTALLED_APP_MUTATION_STATE"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_TARGET_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AM — EXACT ASUS2 PRIVATE-RELEASE APP DEPLOY / OPEN / STOP ====="
echo "PURPOSE=reacquire_exact_D97AM_verify_live_D97AH_backup_deploy_D97AM_open_STOP"
echo "PRIVATE_REPOSITORY=$REPO"
echo "EXPECTED_RELEASE_ID=$RELEASE_ID"
echo "EXPECTED_RELEASE_TAG=$RELEASE_TAG"
echo "EXPECTED_RELEASE_HEAD=$RELEASE_HEAD"
echo "D97AM_ZIP_SHA256_EXPECTED=$D97AM_ZIP_SHA256"
echo "D97AM_EXE_SHA256_EXPECTED=$D97AM_EXE_SHA256"
echo "D97AH_LIVE_EXE_SHA256_EXPECTED=$D97AH_EXE_SHA256"
echo "BACKUP_APP=$BACKUP_APP"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

GH="$(command -v gh 2>/dev/null || true)"
PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$GH" && -x "$GH" ]] || fail "GH_CLI_MISSING"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

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
  /bin/cat \
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

"$GH" auth status -h github.com >/dev/null 2>&1 || fail "GH_NOT_AUTHENTICATED_FOR_GITHUB_COM"
echo "GH_AUTH_GATE=PASS"

TEMP_IDENTITY="$(/usr/bin/stat -f '%u:%Lp:%l' "$TEMP_ROOT")"
echo "PRIVATE_TEMP_IDENTITY=$TEMP_IDENTITY"
[[ "$TEMP_IDENTITY" == "$(/usr/bin/id -u):700:2" ]] || fail "PRIVATE_TEMP_IDENTITY_INVALID:$TEMP_IDENTITY"

FREE_KB="$(/bin/df -Pk /Applications | /usr/bin/awk 'NR==2 {print $4}')"
echo "APPLICATION_VOLUME_FREE_KB=$FREE_KB"
[[ "$FREE_KB" == <-> ]] || fail "FREE_SPACE_PARSE_FAIL:$FREE_KB"
(( FREE_KB >= MIN_FREE_KB )) || fail "INSUFFICIENT_FREE_SPACE_KB:$FREE_KB"

echo "===== VERIFY PRIVATE RELEASE / TWO REQUIRED ASSETS ====="
"$PYTHON" - "$GH" "$REPO" "$RELEASE_TAG" "$RELEASE_ID" "$RELEASE_HEAD" "$PART0_ID" "$PART0_NAME" "$PART0_BYTES" "$PART0_SHA256" "$PART1_ID" "$PART1_NAME" "$PART1_BYTES" "$PART1_SHA256" <<'PY'
import json, subprocess, sys
(
    gh, repo, tag, release_id, head,
    p0_id, p0_name, p0_bytes, p0_sha,
    p1_id, p1_name, p1_bytes, p1_sha,
) = sys.argv[1:]
r = json.loads(subprocess.check_output([gh, 'api', f'repos/{repo}/releases/tags/{tag}'], text=True))
if str(r.get('id')) != release_id or r.get('tag_name') != tag or r.get('target_commitish') != head:
    raise SystemExit('D97AM_DEPLOY_RELEASE_BINDING_MISMATCH')
if r.get('draft') is not False or r.get('prerelease') is not False:
    raise SystemExit('D97AM_DEPLOY_RELEASE_STATE_MISMATCH')
by = {a.get('name'): a for a in (r.get('assets') or [])}
expected = [
    (p0_id, p0_name, int(p0_bytes), p0_sha),
    (p1_id, p1_name, int(p1_bytes), p1_sha),
]
for aid, name, size, sha in expected:
    a = by.get(name)
    if not a:
        raise SystemExit('D97AM_DEPLOY_RELEASE_ASSET_MISSING:'+name)
    if str(a.get('id')) != aid or int(a.get('size', -1)) != size or a.get('state') != 'uploaded':
        raise SystemExit('D97AM_DEPLOY_RELEASE_ASSET_METADATA:'+name)
    digest = a.get('digest')
    if digest and digest != 'sha256:'+sha:
        raise SystemExit('D97AM_DEPLOY_RELEASE_ASSET_DIGEST:'+name)
    print(f'D97AM_DEPLOY_RELEASE_ASSET_META|ID={aid}|NAME={name}|BYTES={size}|DIGEST={digest}')
print('D97AM_DEPLOY_RELEASE_AND_PART_METADATA=PASS')
PY

echo "===== DOWNLOAD / VERIFY D97AM PARTS ====="
"$GH" api -H "Accept: application/octet-stream" "repos/$REPO/releases/assets/$PART0_ID" > "$PART0" || fail "PART0_DOWNLOAD_FAIL"
"$GH" api -H "Accept: application/octet-stream" "repos/$REPO/releases/assets/$PART1_ID" > "$PART1" || fail "PART1_DOWNLOAD_FAIL"
for spec in \
  "$PART0|$PART0_BYTES|$PART0_SHA256|PART0" \
  "$PART1|$PART1_BYTES|$PART1_SHA256|PART1"; do
  p="${spec%%|*}"; rest="${spec#*|}"; expected_bytes="${rest%%|*}"; rest="${rest#*|}"; expected_sha="${rest%%|*}"; label="${rest##*|}"
  actual_bytes="$(/usr/bin/stat -f '%z' "$p")"
  actual_sha="$(sha256_file "$p")"
  echo "D97AM_${label}_BYTES=$actual_bytes"
  echo "D97AM_${label}_SHA256=$actual_sha"
  [[ "$actual_bytes" == "$expected_bytes" ]] || fail "${label}_BYTES_MISMATCH:$actual_bytes"
  [[ "$actual_sha" == "$expected_sha" ]] || fail "${label}_SHA_MISMATCH:$actual_sha"
done
echo "D97AM_DEPLOY_TWO_PART_LOCAL_IDENTITIES=PASS"

/bin/cat "$PART0" "$PART1" > "$VERIFIED_ZIP" || fail "ZIP_REASSEMBLY_WRITE_FAIL"
ZIP_BYTES_ACTUAL="$(/usr/bin/stat -f '%z' "$VERIFIED_ZIP")"
ZIP_SHA_ACTUAL="$(sha256_file "$VERIFIED_ZIP")"
echo "VERIFIED_ZIP_BYTES_ACTUAL=$ZIP_BYTES_ACTUAL"
echo "VERIFIED_ZIP_SHA256_ACTUAL=$ZIP_SHA_ACTUAL"
[[ "$ZIP_BYTES_ACTUAL" == "$D97AM_ZIP_BYTES" ]] || fail "VERIFIED_ZIP_BYTES_MISMATCH:$ZIP_BYTES_ACTUAL"
[[ "$ZIP_SHA_ACTUAL" == "$D97AM_ZIP_SHA256" ]] || fail "VERIFIED_ZIP_SHA_MISMATCH:$ZIP_SHA_ACTUAL"
echo "D97AM_DEPLOY_REASSEMBLED_ZIP_IDENTITY=PASS"

echo "===== EXTRACT / VERIFY D97AM STAGE ====="
/bin/mkdir -p "$EXTRACT_ROOT"
/usr/bin/ditto -x -k "$VERIFIED_ZIP" "$EXTRACT_ROOT" || fail "D97AM_ZIP_EXTRACTION_FAIL"
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
[[ "$STAGED_BYTES" == "$D97AM_EXE_BYTES" ]] || fail "STAGED_D97AM_BYTES_MISMATCH:$STAGED_BYTES"
[[ "$STAGED_SHA" == "$D97AM_EXE_SHA256" ]] || fail "STAGED_D97AM_SHA_MISMATCH:$STAGED_SHA"
[[ "$STAGED_ARCH" == "x86_64" ]] || fail "STAGED_D97AM_ARCH_MISMATCH:$STAGED_ARCH"
[[ "$STAGED_FILE" == *"Mach-O 64-bit executable x86_64"* ]] || fail "STAGED_D97AM_FILE_MISMATCH:$STAGED_FILE"
echo "D97AM_STAGED_APP_IDENTITY=PASS"

echo "===== VERIFY EXACT LIVE D97AH PREIMAGE ====="
[[ -d "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_D97AH_APP_MISSING_OR_SYMLINK"
[[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" && -x "$LIVE_EXE" ]] || fail "LIVE_D97AH_EXE_INVALID"
LIVE_PRE_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
LIVE_PRE_SHA="$(sha256_file "$LIVE_EXE")"
LIVE_PRE_ARCH="$(/usr/bin/lipo -archs "$LIVE_EXE")"
echo "LIVE_PRE_BYTES=$LIVE_PRE_BYTES"
echo "LIVE_PRE_SHA256=$LIVE_PRE_SHA"
echo "LIVE_PRE_ARCHS=$LIVE_PRE_ARCH"
[[ "$LIVE_PRE_BYTES" == "$D97AH_EXE_BYTES" ]] || fail "LIVE_D97AH_BYTES_MISMATCH:$LIVE_PRE_BYTES"
[[ "$LIVE_PRE_SHA" == "$D97AH_EXE_SHA256" ]] || fail "LIVE_D97AH_SHA_MISMATCH:$LIVE_PRE_SHA"
[[ "$LIVE_PRE_ARCH" == "x86_64" ]] || fail "LIVE_D97AH_ARCH_MISMATCH:$LIVE_PRE_ARCH"
[[ ! -e "$BACKUP_APP" && ! -L "$BACKUP_APP" ]] || fail "BACKUP_PATH_ALREADY_EXISTS:$BACKUP_APP"
[[ ! -e "$NEW_APP" && ! -L "$NEW_APP" ]] || fail "NEW_APP_PATH_ALREADY_EXISTS:$NEW_APP"
[[ ! -e "$FAILED_APP" && ! -L "$FAILED_APP" ]] || fail "FAILED_APP_PATH_ALREADY_EXISTS:$FAILED_APP"
echo "D97AH_LIVE_PREIMAGE=PASS"

echo "===== SUDO GATE / PREPARE EXACT D97AM BESIDE LIVE ====="
/usr/bin/sudo -v || fail "SUDO_AUTH_FAILED"
INSTALLED_APP_MUTATION_STATE="NEW_APP_COPYING"
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
[[ "$NEW_BYTES" == "$D97AM_EXE_BYTES" ]] || fail "NEW_D97AM_BYTES_MISMATCH:$NEW_BYTES"
[[ "$NEW_SHA" == "$D97AM_EXE_SHA256" ]] || fail "NEW_D97AM_SHA_MISMATCH:$NEW_SHA"
[[ "$NEW_ARCH" == "x86_64" ]] || fail "NEW_D97AM_ARCH_MISMATCH:$NEW_ARCH"
echo "D97AM_NEW_APP_READY_EXACT=PASS"

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
    echo "D97AM_DEPLOY_FORCE_KILL_EXACT_PIDS=$REMAINING_PIDS"
    for pid in ${(f)REMAINING_PIDS}; do
      /bin/kill -KILL "$pid" 2>/dev/null || true
    done
    /bin/sleep 0.5
  fi
fi
POST_DRAIN_PIDS="$(exact_live_pids)"
echo "POST_DRAIN_EXACT_PIDS=${POST_DRAIN_PIDS:-NONE}"
[[ -z "$POST_DRAIN_PIDS" ]] || fail "EXACT_LIVE_PROCESS_DRAIN_FAIL:$POST_DRAIN_PIDS"
echo "D97AH_EXACT_PATH_PROCESS_DRAIN=PASS"

echo "===== SWITCH D97AH -> D97AM ====="
/usr/bin/sudo /bin/mv "$LIVE_APP" "$BACKUP_APP" || fail "MOVE_D97AH_TO_BACKUP_FAIL"
INSTALLED_APP_MUTATION_STATE="LIVE_MOVED_TO_BACKUP"
[[ -d "$BACKUP_APP" && ! -L "$BACKUP_APP" ]] || fail "BACKUP_APP_INVALID_AFTER_MOVE"
[[ -f "$BACKUP_EXE" && ! -L "$BACKUP_EXE" ]] || fail "BACKUP_EXE_INVALID_AFTER_MOVE"
BACKUP_BYTES="$(/usr/bin/stat -f '%z' "$BACKUP_EXE")"
BACKUP_SHA="$(sha256_file "$BACKUP_EXE")"
echo "BACKUP_EXE_BYTES=$BACKUP_BYTES"
echo "BACKUP_EXE_SHA256=$BACKUP_SHA"
[[ "$BACKUP_BYTES" == "$D97AH_EXE_BYTES" ]] || fail "BACKUP_D97AH_BYTES_MISMATCH:$BACKUP_BYTES"
[[ "$BACKUP_SHA" == "$D97AH_EXE_SHA256" ]] || fail "BACKUP_D97AH_SHA_MISMATCH:$BACKUP_SHA"
[[ ! -e "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_PATH_NOT_EMPTY_AFTER_BACKUP_MOVE"

/usr/bin/sudo /bin/mv "$NEW_APP" "$LIVE_APP" || fail "MOVE_D97AM_TO_LIVE_FAIL"
INSTALLED_APP_MUTATION_STATE="D97AM_DEPLOYED_PENDING_AUDIT"
[[ -d "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_D97AM_APP_INVALID"
[[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" && -x "$LIVE_EXE" ]] || fail "LIVE_D97AM_EXE_INVALID"
LIVE_POST_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
LIVE_POST_SHA="$(sha256_file "$LIVE_EXE")"
LIVE_POST_ARCH="$(/usr/bin/lipo -archs "$LIVE_EXE")"
LIVE_POST_FILE="$(/usr/bin/file "$LIVE_EXE")"
echo "LIVE_POST_BYTES=$LIVE_POST_BYTES"
echo "LIVE_POST_SHA256=$LIVE_POST_SHA"
echo "LIVE_POST_ARCHS=$LIVE_POST_ARCH"
echo "LIVE_POST_FILE=$LIVE_POST_FILE"
[[ "$LIVE_POST_BYTES" == "$D97AM_EXE_BYTES" ]] || fail "LIVE_D97AM_BYTES_MISMATCH:$LIVE_POST_BYTES"
[[ "$LIVE_POST_SHA" == "$D97AM_EXE_SHA256" ]] || fail "LIVE_D97AM_SHA_MISMATCH:$LIVE_POST_SHA"
[[ "$LIVE_POST_ARCH" == "x86_64" ]] || fail "LIVE_D97AM_ARCH_MISMATCH:$LIVE_POST_ARCH"
[[ "$LIVE_POST_FILE" == *"Mach-O 64-bit executable x86_64"* ]] || fail "LIVE_D97AM_FILE_MISMATCH:$LIVE_POST_FILE"
echo "D97AM_LIVE_APP_IDENTITY=PASS"

INSTALLED_APP_MUTATION_STATE="D97AM_DEPLOYED_PENDING_OPEN"
echo "===== OPEN EXACT D97AM OCLP / PROVE FRESH PATH ====="
PRE_OPEN_PIDS="$(exact_live_pids)"
echo "PRE_OPEN_EXACT_PIDS=${PRE_OPEN_PIDS:-NONE}"
[[ -z "$PRE_OPEN_PIDS" ]] || fail "UNEXPECTED_EXACT_PROCESS_BEFORE_OPEN:$PRE_OPEN_PIDS"
/usr/bin/open "$LIVE_APP" || fail "OPEN_D97AM_APP_FAIL"
FRESH_PIDS=""
for _ in {1..40}; do
  FRESH_PIDS="$(exact_live_pids)"
  [[ -n "$FRESH_PIDS" ]] && break
  /bin/sleep 0.25
done
echo "FRESH_D97AM_EXACT_PIDS=${FRESH_PIDS:-NONE}"
[[ -n "$FRESH_PIDS" ]] || fail "FRESH_D97AM_EXACT_PROCESS_NOT_PROVEN"

FINAL_LIVE_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
FINAL_LIVE_SHA="$(sha256_file "$LIVE_EXE")"
echo "FINAL_LIVE_EXE_BYTES=$FINAL_LIVE_BYTES"
echo "FINAL_LIVE_EXE_SHA256=$FINAL_LIVE_SHA"
[[ "$FINAL_LIVE_BYTES" == "$D97AM_EXE_BYTES" ]] || fail "FINAL_LIVE_D97AM_BYTES_MISMATCH"
[[ "$FINAL_LIVE_SHA" == "$D97AM_EXE_SHA256" ]] || fail "FINAL_LIVE_D97AM_SHA_MISMATCH"

INSTALLED_APP_MUTATION_STATE="D97AM_DEPLOYED_EXACT_OPENED"
echo "D97AM_EXACT_APP_DEPLOY_OPEN_STOP=PASS"
echo "INSTALLED_APP_MUTATION_STATE=$INSTALLED_APP_MUTATION_STATE"
echo "D97AH_BACKUP_RETAINED=$BACKUP_APP"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=OCLP_OPEN_DO_NOT_CLICK_ROOT_PATCH_RETURN_COMPLETE_TERMINAL_OUTPUT"
echo "REPORT=$REPORT"
