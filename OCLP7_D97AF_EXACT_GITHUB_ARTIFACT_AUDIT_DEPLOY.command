#!/bin/zsh -f
set -euo pipefail

REPO="StefanAlMare/Private-Work"
RUN_ID="33686570072"
JOB_ID="100435354962"
WORKFLOW_ID="348814365"
RUN_HEAD_SHA="76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e"
RUN_WORKFLOW_PATH=".github/workflows/oclp7-d97af-build.yml"
ARTIFACT_ID="9868515225"
ARTIFACT_NAME="OCLP7-D97AF-OpenCore-Patcher-v1"
ARTIFACT_BYTES_EXPECTED="751567689"
ARTIFACT_DIGEST_EXPECTED="sha256:70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b"
OUTER_SHA256_EXPECTED="70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b"
INNER_APP_ZIP_BYTES_EXPECTED="751492703"
INNER_APP_ZIP_SHA256_EXPECTED="728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907"
SHA256SUMS_SHA256_EXPECTED="99ad0f4d1e4b58910274c19da4a89b74dd935d222da0d0c7407a1d4121379ff2"
D97AF_EXE_BYTES_EXPECTED="6595600"
D97AF_EXE_SHA256_EXPECTED="ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470"
D97AD_LIVE_EXE_BYTES_EXPECTED="6587056"
D97AD_LIVE_EXE_SHA256_EXPECTED="5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0"
MIN_FREE_KB="8388608"

export REPO RUN_ID JOB_ID WORKFLOW_ID RUN_HEAD_SHA RUN_WORKFLOW_PATH
export ARTIFACT_ID ARTIFACT_NAME ARTIFACT_BYTES_EXPECTED ARTIFACT_DIGEST_EXPECTED
export INNER_APP_ZIP_SHA256_EXPECTED D97AF_EXE_BYTES_EXPECTED D97AF_EXE_SHA256_EXPECTED

STAMP="$(/bin/date +%Y%m%d-%H%M%S)"
REPORT="$HOME/Desktop/OCLP7_D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY_REPORT_$STAMP.txt"
TEMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AF_DEPLOY.XXXXXX)"
OUTER_ZIP="$TEMP_ROOT/$ARTIFACT_NAME.zip"
PAYLOAD_DIR="$TEMP_ROOT/payload"
APP_EXTRACT_DIR="$TEMP_ROOT/app-extracted"
LIVE_APP="/Applications/OpenCore-Patcher.app"
LIVE_EXE="$LIVE_APP/Contents/MacOS/OpenCore-Patcher"
BACKUP_APP="/Applications/OpenCore-Patcher.app.D97AD-before-D97AF-$STAMP"
NEW_APP="/Applications/OpenCore-Patcher.app.D97AF-deploying-$STAMP"
FAILED_APP="/Applications/OpenCore-Patcher.app.D97AF-failed-$STAMP"
INSTALLED_APP_MUTATION_STATE="NO"

cleanup() {
  if [[ "$TEMP_ROOT" == /private/tmp/OCLP7_D97AF_DEPLOY.* && -d "$TEMP_ROOT" && ! -L "$TEMP_ROOT" ]]; then
    /bin/rm -rf "$TEMP_ROOT"
  fi
}
trap cleanup EXIT

exec > >(/usr/bin/tee "$REPORT") 2>&1

fail() {
  echo "D97AF_DEPLOY=FAIL_CLOSED|REASON=$*"
  echo "INSTALLED_APP_MUTATION_STATE=$INSTALLED_APP_MUTATION_STATE"
  echo "SYSTEM_TARGET_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

sha256_file() {
  /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

finish() {
  exit_rc=$?
  trap - EXIT HUP INT TERM
  set +e
  if (( exit_rc != 0 )); then
    echo "D97AF_EXIT_RECOVERY_BEGIN=STATE:$INSTALLED_APP_MUTATION_STATE|RC:$exit_rc"
    case "$INSTALLED_APP_MUTATION_STATE" in
      NO)
        echo "D97AF_EXIT_RECOVERY=NOT_REQUIRED_NO_APPLICATION_MUTATION"
        ;;
      PREPARING_NEW_APP|NEW_APP_READY)
        if [[ "$NEW_APP" == /Applications/OpenCore-Patcher.app.D97AF-deploying-* && \
              ( -e "$NEW_APP" || -L "$NEW_APP" ) ]]; then
          /usr/bin/sudo -n /bin/rm -rf "$NEW_APP"
          echo "D97AF_EXIT_RECOVERY_STAGING_REMOVAL_RC=$?"
        fi
        if [[ ! -e "$NEW_APP" && ! -L "$NEW_APP" ]]; then
          echo "D97AF_EXIT_RECOVERY_STAGING_ABSENT=PASS"
          if [[ -d "$LIVE_APP" && ! -L "$LIVE_APP" && \
                -f "$LIVE_EXE" && ! -L "$LIVE_EXE" && \
                "$(sha256_file "$LIVE_EXE" 2>/dev/null || true)" == "$D97AD_LIVE_EXE_SHA256_EXPECTED" ]]; then
            INSTALLED_APP_MUTATION_STATE="D97AD_LIVE_UNCHANGED_EXACT"
            echo "D97AF_EXIT_RECOVERY=PASS_STAGING_REMOVED_LIVE_D97AD_EXACT"
          else
            echo "D97AF_EXIT_RECOVERY=FAIL_LIVE_D97AD_IDENTITY"
          fi
        else
          echo "D97AF_EXIT_RECOVERY_STAGING_ABSENT=FAIL"
        fi
        ;;
      MOVING_LIVE_TO_BACKUP|LIVE_MOVED_TO_BACKUP|SWITCHING_TO_D97AF|D97AF_DEPLOYED_PENDING_POSTAUDIT)
        if [[ -d "$BACKUP_APP" && ! -L "$BACKUP_APP" ]]; then
          if [[ -e "$LIVE_APP" || -L "$LIVE_APP" ]]; then
            if [[ ! -e "$FAILED_APP" && ! -L "$FAILED_APP" ]]; then
              /usr/bin/sudo -n /bin/mv "$LIVE_APP" "$FAILED_APP"
              echo "D97AF_EXIT_RECOVERY_FAILED_APP_QUARANTINE_RC=$?"
            else
              echo "D97AF_EXIT_RECOVERY_FAILED_APP_QUARANTINE_RC=SKIPPED_PATH_EXISTS"
            fi
          fi
          if [[ ! -e "$LIVE_APP" && ! -L "$LIVE_APP" ]]; then
            /usr/bin/sudo -n /bin/mv "$BACKUP_APP" "$LIVE_APP"
            restore_move_rc=$?
            echo "D97AF_EXIT_RECOVERY_RESTORE_MOVE_RC=$restore_move_rc"
            if (( restore_move_rc == 0 )) && [[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" ]]; then
              restore_sha256="$(sha256_file "$LIVE_EXE" 2>/dev/null || true)"
              echo "D97AF_EXIT_RECOVERY_RESTORED_SHA256=$restore_sha256"
              if [[ "$restore_sha256" == "$D97AD_LIVE_EXE_SHA256_EXPECTED" ]]; then
                INSTALLED_APP_MUTATION_STATE="D97AD_RESTORED_EXACT"
                echo "D97AF_EXIT_RECOVERY=PASS"
              else
                echo "D97AF_EXIT_RECOVERY=FAIL_RESTORED_SHA_MISMATCH"
              fi
            fi
          else
            echo "D97AF_EXIT_RECOVERY=FAIL_LIVE_PATH_OCCUPIED"
          fi
        elif [[ -d "$LIVE_APP" && ! -L "$LIVE_APP" && \
                "$(sha256_file "$LIVE_EXE" 2>/dev/null || true)" == "$D97AD_LIVE_EXE_SHA256_EXPECTED" ]]; then
          INSTALLED_APP_MUTATION_STATE="D97AD_LIVE_UNCHANGED_EXACT"
          echo "D97AF_EXIT_RECOVERY=PASS_MOVE_DID_NOT_OCCUR"
        else
          echo "D97AF_EXIT_RECOVERY=FAIL_BACKUP_UNAVAILABLE"
        fi
        if [[ "$NEW_APP" == /Applications/OpenCore-Patcher.app.D97AF-deploying-* && \
              ( -e "$NEW_APP" || -L "$NEW_APP" ) ]]; then
          /usr/bin/sudo -n /bin/rm -rf "$NEW_APP"
          echo "D97AF_EXIT_RECOVERY_STAGING_REMOVAL_RC=$?"
        fi
        if [[ ! -e "$NEW_APP" && ! -L "$NEW_APP" ]]; then
          echo "D97AF_EXIT_RECOVERY_STAGING_ABSENT=PASS"
        else
          echo "D97AF_EXIT_RECOVERY_STAGING_ABSENT=FAIL"
        fi
        ;;
      D97AF_DEPLOYED_EXACT)
        echo "D97AF_EXIT_RECOVERY=NOT_REQUIRED_EXACT_D97AF_AND_BACKUP_RETAINED"
        ;;
      *)
        echo "D97AF_EXIT_RECOVERY=UNKNOWN_STATE:$INSTALLED_APP_MUTATION_STATE"
        ;;
    esac
    echo "D97AF_EXIT_RECOVERY_FINAL_STATE=$INSTALLED_APP_MUTATION_STATE"
  fi
  cleanup
  exit "$exit_rc"
}

trap finish EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

echo "===== OCLP7 D97AF — EXACT GITHUB ARTIFACT AUDIT / APP DEPLOY ====="
echo "PURPOSE=download_exact_pre-audited_D97AF_artifact_verify_all_identities_backup_deploy_open_OCLP_STOP"
echo "REPOSITORY=$REPO"
echo "WORKFLOW_ID=$WORKFLOW_ID"
echo "RUN_ID=$RUN_ID"
echo "JOB_ID=$JOB_ID"
echo "RUN_HEAD_SHA=$RUN_HEAD_SHA"
echo "ARTIFACT_ID=$ARTIFACT_ID"
echo "ARTIFACT_NAME=$ARTIFACT_NAME"
echo "ARTIFACT_BYTES_EXPECTED=$ARTIFACT_BYTES_EXPECTED"
echo "ARTIFACT_DIGEST_EXPECTED=$ARTIFACT_DIGEST_EXPECTED"
echo "INNER_APP_ZIP_SHA256_EXPECTED=$INNER_APP_ZIP_SHA256_EXPECTED"
echo "D97AF_EXE_SHA256_EXPECTED=$D97AF_EXE_SHA256_EXPECTED"
echo "D97AD_LIVE_EXE_SHA256_EXPECTED=$D97AD_LIVE_EXE_SHA256_EXPECTED"
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
  /usr/bin/grep \
  /usr/bin/lipo \
  /usr/bin/open \
  /usr/bin/pgrep \
  /usr/bin/plutil \
  /usr/bin/shasum \
  /usr/bin/stat \
  /usr/bin/tee \
  /usr/bin/tr \
  /usr/bin/unzip \
  /usr/bin/wc \
  /usr/bin/xattr \
  /usr/bin/id \
  /bin/date \
  /bin/df \
  /bin/kill \
  /bin/mkdir \
  /bin/mv \
  /bin/ps \
  /bin/rm \
  /bin/sleep \
  /usr/sbin/chown \
  /usr/bin/sudo; do
  [[ -x "$tool_path" ]] || fail "MISSING_ABSOLUTE_TOOL:$tool_path"
done

GH_BIN="$(command -v gh 2>/dev/null || true)"
PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
[[ -n "$GH_BIN" && -x "$GH_BIN" ]] || fail "MISSING_TOOL:gh"
[[ -n "$PYTHON_BIN" && -x "$PYTHON_BIN" ]] || fail "MISSING_TOOL:python3"
echo "TOOL_gh=$GH_BIN"
echo "TOOL_python3=$PYTHON_BIN"
"$PYTHON_BIN" --version

TEMP_IDENTITY="$(/usr/bin/stat -f '%u:%Lp:%l' "$TEMP_ROOT")"
echo "PRIVATE_TEMP_IDENTITY=$TEMP_IDENTITY"
[[ "$TEMP_IDENTITY" == "$(/usr/bin/id -u):700:2" ]] || fail "PRIVATE_TEMP_IDENTITY_INVALID:$TEMP_IDENTITY"

ACTIVE_GITHUB_LOGIN="$("$GH_BIN" api user --jq .login)"
echo "ACTIVE_GITHUB_LOGIN=$ACTIVE_GITHUB_LOGIN"
[[ "$ACTIVE_GITHUB_LOGIN" == "StefanAlMare" ]] || fail "WRONG_GITHUB_LOGIN:$ACTIVE_GITHUB_LOGIN"

FREE_KB="$(/bin/df -Pk /Applications | /usr/bin/awk 'NR==2 {print $4}')"
echo "APPLICATION_VOLUME_FREE_KB=$FREE_KB"
[[ "$FREE_KB" == <-> ]] || fail "FREE_SPACE_PARSE_FAIL:$FREE_KB"
(( FREE_KB >= MIN_FREE_KB )) || fail "INSUFFICIENT_FREE_SPACE_KB:$FREE_KB"

/bin/mkdir -p "$PAYLOAD_DIR" "$APP_EXTRACT_DIR"
RUN_JSON="$TEMP_ROOT/run.json"
ARTIFACT_JSON="$TEMP_ROOT/artifact.json"
JOB_JSON="$TEMP_ROOT/job.json"

"$GH_BIN" api "repos/$REPO/actions/runs/$RUN_ID" > "$RUN_JSON" || fail "RUN_METADATA_DOWNLOAD_FAILED"
"$GH_BIN" api "repos/$REPO/actions/artifacts/$ARTIFACT_ID" > "$ARTIFACT_JSON" || fail "ARTIFACT_METADATA_DOWNLOAD_FAILED"
"$GH_BIN" api "repos/$REPO/actions/jobs/$JOB_ID" > "$JOB_JSON" || fail "JOB_METADATA_DOWNLOAD_FAILED"

"$PYTHON_BIN" - "$RUN_JSON" "$ARTIFACT_JSON" "$JOB_JSON" <<'PY'
import json
import os
import sys
from pathlib import Path

run = json.loads(Path(sys.argv[1]).read_text())
artifact = json.loads(Path(sys.argv[2]).read_text())
job = json.loads(Path(sys.argv[3]).read_text())
expected_run = {
    'id': int(os.environ['RUN_ID']),
    'workflow_id': int(os.environ['WORKFLOW_ID']),
    'head_sha': os.environ['RUN_HEAD_SHA'],
    'path': os.environ['RUN_WORKFLOW_PATH'],
    'status': 'completed',
    'conclusion': 'success',
}
for key, expected in expected_run.items():
    actual = run.get(key)
    print(f'RUN_{key.upper()}={actual}')
    if actual != expected:
        raise SystemExit(f'RUN_IDENTITY_MISMATCH:{key}:{actual!r}:{expected!r}')
expected_artifact = {
    'id': int(os.environ['ARTIFACT_ID']),
    'name': os.environ['ARTIFACT_NAME'],
    'size_in_bytes': int(os.environ['ARTIFACT_BYTES_EXPECTED']),
    'digest': os.environ['ARTIFACT_DIGEST_EXPECTED'],
    'expired': False,
}
for key, expected in expected_artifact.items():
    actual = artifact.get(key)
    print(f'ARTIFACT_{key.upper()}={actual}')
    if actual != expected:
        raise SystemExit(f'ARTIFACT_IDENTITY_MISMATCH:{key}:{actual!r}:{expected!r}')
workflow_run = artifact.get('workflow_run') or {}
if workflow_run.get('id') != int(os.environ['RUN_ID']):
    raise SystemExit('ARTIFACT_RUN_ID_MISMATCH')
if workflow_run.get('head_sha') != os.environ['RUN_HEAD_SHA']:
    raise SystemExit('ARTIFACT_HEAD_SHA_MISMATCH')
expected_job = {
    'id': int(os.environ['JOB_ID']),
    'run_id': int(os.environ['RUN_ID']),
    'name': 'build',
    'status': 'completed',
    'conclusion': 'success',
}
for key, expected in expected_job.items():
    actual = job.get(key)
    print(f'JOB_{key.upper()}={actual}')
    if actual != expected:
        raise SystemExit(f'JOB_IDENTITY_MISMATCH:{key}:{actual!r}:{expected!r}')
steps = job.get('steps') or []
if not steps or any(step.get('status') != 'completed' or step.get('conclusion') != 'success' for step in steps):
    raise SystemExit('JOB_STEP_SUCCESS_SET_MISMATCH')
print(f'JOB_STEP_COUNT={len(steps)}')
print('D97AF_RUN_JOB_AND_ARTIFACT_METADATA=PASS')
PY

echo "===== DOWNLOAD EXACT IMMUTABLE ARTIFACT ARCHIVE ====="
"$GH_BIN" api \
  -H 'Accept: application/vnd.github+json' \
  -H 'X-GitHub-Api-Version: 2022-11-28' \
  "repos/$REPO/actions/artifacts/$ARTIFACT_ID/zip" > "$OUTER_ZIP" || fail "OUTER_ARTIFACT_DOWNLOAD_FAILED"

[[ -f "$OUTER_ZIP" && ! -L "$OUTER_ZIP" ]] || fail "OUTER_ZIP_MISSING_OR_SYMLINK"
OUTER_BYTES_ACTUAL="$(/usr/bin/stat -f '%z' "$OUTER_ZIP")"
OUTER_SHA256_ACTUAL="$(sha256_file "$OUTER_ZIP")"
echo "DOWNLOADED_OUTER_BYTES=$OUTER_BYTES_ACTUAL"
echo "DOWNLOADED_OUTER_SHA256=$OUTER_SHA256_ACTUAL"
[[ "$OUTER_BYTES_ACTUAL" == "$ARTIFACT_BYTES_EXPECTED" ]] || fail "OUTER_BYTES_MISMATCH:$OUTER_BYTES_ACTUAL"
[[ "$OUTER_SHA256_ACTUAL" == "$OUTER_SHA256_EXPECTED" ]] || fail "OUTER_SHA256_MISMATCH:$OUTER_SHA256_ACTUAL"
/usr/bin/unzip -tq "$OUTER_ZIP" >/dev/null || fail "OUTER_ZIP_CRC_FAIL"

"$PYTHON_BIN" - "$OUTER_ZIP" <<'PY'
from pathlib import Path, PurePosixPath
import sys
import zipfile

expected = [
    'dist/OCLP7-D97AF-OpenCore-Patcher.app.zip',
    'dist/OCLP7_D97AF_GITHUB_BUILD_AUDIT_REPORT.txt',
    'dist/OCLP7_D97AF_PACKAGED_EXECUTABLE_FILE.txt',
    'dist/SHA256SUMS-OCLP7-D97AF.txt',
    'dist/OCLP7_D97AF_PACKAGED_EXECUTABLE_ARCHS.txt',
    'dist/OCLP7_D97AF_MANIFEST.env',
    'dist/OCLP7_D97AF_SOURCE_TRANSITION.patch',
    'OCLP7_D97AF_GITHUB_SOURCE_AUDIT_REPORT.txt',
]
with zipfile.ZipFile(Path(sys.argv[1])) as archive:
    names = archive.namelist()
    print('D97AF_OUTER_MEMBER_COUNT=' + str(len(names)))
    if names != expected or len(archive.infolist()) != 8:
        raise SystemExit(f'OUTER_MEMBER_SET_OR_ORDER_MISMATCH:{names!r}')
    for name in names:
        path = PurePosixPath(name)
        if path.is_absolute() or '..' in path.parts:
            raise SystemExit(f'UNSAFE_OUTER_MEMBER:{name}')
print('D97AF_OUTER_MEMBER_SET=PASS')
PY

/usr/bin/unzip -q "$OUTER_ZIP" -d "$PAYLOAD_DIR" || fail "OUTER_EXTRACTION_FAIL"
[[ "$(/usr/bin/find "$PAYLOAD_DIR" -type f | /usr/bin/wc -l | /usr/bin/tr -d ' ')" == "8" ]] || fail "OUTER_EXTRACTED_FILE_CARDINALITY"

APP_ZIP="$PAYLOAD_DIR/dist/OCLP7-D97AF-OpenCore-Patcher.app.zip"
SUM_FILE="$PAYLOAD_DIR/dist/SHA256SUMS-OCLP7-D97AF.txt"
BUILD_AUDIT="$PAYLOAD_DIR/dist/OCLP7_D97AF_GITHUB_BUILD_AUDIT_REPORT.txt"
SOURCE_AUDIT="$PAYLOAD_DIR/OCLP7_D97AF_GITHUB_SOURCE_AUDIT_REPORT.txt"
ARCH_REPORT="$PAYLOAD_DIR/dist/OCLP7_D97AF_PACKAGED_EXECUTABLE_ARCHS.txt"
FILE_REPORT="$PAYLOAD_DIR/dist/OCLP7_D97AF_PACKAGED_EXECUTABLE_FILE.txt"

SUM_FILE_SHA256="$(sha256_file "$SUM_FILE")"
APP_ZIP_BYTES="$(/usr/bin/stat -f '%z' "$APP_ZIP")"
APP_ZIP_SHA256="$(sha256_file "$APP_ZIP")"
echo "SHA256SUMS_FILE_SHA256=$SUM_FILE_SHA256"
echo "INNER_APP_ZIP_BYTES=$APP_ZIP_BYTES"
echo "INNER_APP_ZIP_SHA256=$APP_ZIP_SHA256"
[[ "$SUM_FILE_SHA256" == "$SHA256SUMS_SHA256_EXPECTED" ]] || fail "SHA256SUMS_FILE_IDENTITY_MISMATCH"
[[ "$APP_ZIP_BYTES" == "$INNER_APP_ZIP_BYTES_EXPECTED" ]] || fail "INNER_APP_ZIP_BYTES_MISMATCH:$APP_ZIP_BYTES"
[[ "$APP_ZIP_SHA256" == "$INNER_APP_ZIP_SHA256_EXPECTED" ]] || fail "INNER_APP_ZIP_SHA256_MISMATCH:$APP_ZIP_SHA256"
/usr/bin/unzip -tq "$APP_ZIP" >/dev/null || fail "INNER_APP_ZIP_CRC_FAIL"

"$PYTHON_BIN" - "$PAYLOAD_DIR" "$APP_ZIP" <<'PY'
from pathlib import Path
import hashlib
import os
import sys
import zipfile

payload = Path(sys.argv[1])
app_zip = Path(sys.argv[2])
expected = {
    'dist/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher': os.environ['D97AF_EXE_SHA256_EXPECTED'],
    'dist/OCLP7-D97AF-OpenCore-Patcher.app.zip': os.environ['INNER_APP_ZIP_SHA256_EXPECTED'],
    'dist/OCLP7_D97AF_GITHUB_BUILD_AUDIT_REPORT.txt': 'a85a5c610d5cef0fd17e7578dc28a71c9316b59f3aee2b3ae90f1b318135fe56',
    'dist/OCLP7_D97AF_PACKAGED_EXECUTABLE_FILE.txt': '115edfbb0f491dfee4825ae6adbfb627c4cdc32ee622987cc9d3fd62fbe22f77',
    'dist/OCLP7_D97AF_PACKAGED_EXECUTABLE_ARCHS.txt': 'aaf631698ae5160ceb04a97681a14887fdcab47cd6e0f163c87485b3b1340b62',
    'OCLP7_D97AF_GITHUB_SOURCE_AUDIT_REPORT.txt': 'b9de666fce9d37dccd17e5d6605f35523b9adfa117e2d55633eb337eff40845d',
    'dist/OCLP7_D97AF_MANIFEST.env': '5d2ad66d88964f769c0e13316cea5adfbd5e4bd7141d8bf846ec466df79ab983',
    'dist/OCLP7_D97AF_SOURCE_TRANSITION.patch': 'fd708a3b7f1a0d914dd63781cabefad03f0d4d3569099ca6ff959a7311f4791e',
}
records = {}
for line in (payload / 'dist/SHA256SUMS-OCLP7-D97AF.txt').read_text().splitlines():
    digest, name = line.split('  ', 1)
    if name in records:
        raise SystemExit(f'DUPLICATE_SHA256SUM_RECORD:{name}')
    records[name] = digest
if records != expected:
    raise SystemExit(f'SHA256SUM_RECORD_SET_MISMATCH:{records!r}')
def hash_path(path):
    result = hashlib.sha256()
    with path.open('rb') as stream:
        while True:
            block = stream.read(8 * 1024 * 1024)
            if not block:
                break
            result.update(block)
    return result.hexdigest()

for name, digest in expected.items():
    if name.startswith('dist/OpenCore-Patcher.app/'):
        continue
    actual = hash_path(payload / name)
    if actual != digest:
        raise SystemExit(f'PAYLOAD_SHA256_MISMATCH:{name}:{actual}')
exe_member = 'OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher'
with zipfile.ZipFile(app_zip) as archive:
    matches = [info for info in archive.infolist() if info.filename == exe_member]
    if len(matches) != 1:
        raise SystemExit(f'PACKAGED_EXE_CARDINALITY_MISMATCH:{len(matches)}')
    digest = hashlib.sha256()
    size = 0
    with archive.open(matches[0]) as stream:
        while True:
            block = stream.read(8 * 1024 * 1024)
            if not block:
                break
            digest.update(block)
            size += len(block)
    print(f'PACKAGED_EXE_BYTES_FROM_ZIP={size}')
    print(f'PACKAGED_EXE_SHA256_FROM_ZIP={digest.hexdigest()}')
    if size != int(os.environ['D97AF_EXE_BYTES_EXPECTED']):
        raise SystemExit('PACKAGED_EXE_BYTES_FROM_ZIP_MISMATCH')
    if digest.hexdigest() != os.environ['D97AF_EXE_SHA256_EXPECTED']:
        raise SystemExit('PACKAGED_EXE_SHA256_FROM_ZIP_MISMATCH')
print('D97AF_COMPLETE_SHA256SUMS_AND_PACKAGED_EXE=PASS')
PY

for required_line in \
  "D97AF_PACKAGED_THREE_MODULE_SEMANTIC_IDENTITY=PASS" \
  "PACKAGED_D97AD_UNCHANGED=PASS" \
  "PACKAGED_D97AF_PRESENT_EXACTLY_ONCE=PASS" \
  "PACKAGED_D97AF_UUID_AND_POST_SHA_CONTRACT=PASS" \
  "PACKAGED_METAL_3802_TAHOE_COMPILER_SUBSTRATE=PASS" \
  "OCLP7_D97AF_GITHUB_BUILD_AUDIT=PASS"; do
  /usr/bin/grep -Fqx "$required_line" "$BUILD_AUDIT" || fail "BUILD_AUDIT_REQUIRED_LINE_MISSING:$required_line"
done
/usr/bin/grep -Fqx "D97AF_SOURCE_AST_AND_CALL_ORDER_AUDIT=PASS" "$SOURCE_AUDIT" || fail "SOURCE_AUDIT_REQUIRED_LINE_MISSING"
[[ "$(<"$ARCH_REPORT")" == "x86_64" ]] || fail "ARCH_REPORT_MISMATCH"
/usr/bin/grep -Fq "Mach-O 64-bit executable x86_64" "$FILE_REPORT" || fail "FILE_REPORT_MISMATCH"
echo "D97AF_DOWNLOADED_REPORTS=PASS"

echo "===== EXTRACT AND VERIFY STAGED APPLICATION ====="
/usr/bin/ditto -x -k "$APP_ZIP" "$APP_EXTRACT_DIR" || fail "APP_EXTRACTION_FAIL"
STAGED_APPS=("${(@f)$(/usr/bin/find "$APP_EXTRACT_DIR" -type d -name 'OpenCore-Patcher.app' -prune -print)}")
(( ${#STAGED_APPS[@]} == 1 )) || fail "STAGED_APP_CARDINALITY:${#STAGED_APPS[@]}"
STAGED_APP="$STAGED_APPS[1]"
STAGED_EXE="$STAGED_APP/Contents/MacOS/OpenCore-Patcher"
[[ -d "$STAGED_APP" && ! -L "$STAGED_APP" ]] || fail "STAGED_APP_MISSING_OR_SYMLINK"
[[ -f "$STAGED_EXE" && ! -L "$STAGED_EXE" && -x "$STAGED_EXE" ]] || fail "STAGED_EXE_INVALID"
/usr/bin/plutil -lint "$STAGED_APP/Contents/Info.plist" >/dev/null || fail "STAGED_INFO_PLIST_INVALID"
STAGED_EXE_BYTES="$(/usr/bin/stat -f '%z' "$STAGED_EXE")"
STAGED_EXE_SHA256="$(sha256_file "$STAGED_EXE")"
STAGED_EXE_ARCHS="$(/usr/bin/lipo -archs "$STAGED_EXE")"
STAGED_EXE_FILE="$(/usr/bin/file "$STAGED_EXE")"
echo "STAGED_APP=$STAGED_APP"
echo "STAGED_EXE_BYTES=$STAGED_EXE_BYTES"
echo "STAGED_EXE_SHA256=$STAGED_EXE_SHA256"
echo "STAGED_EXE_ARCHS=$STAGED_EXE_ARCHS"
echo "STAGED_EXE_FILE=$STAGED_EXE_FILE"
[[ "$STAGED_EXE_BYTES" == "$D97AF_EXE_BYTES_EXPECTED" ]] || fail "STAGED_EXE_BYTES_MISMATCH:$STAGED_EXE_BYTES"
[[ "$STAGED_EXE_SHA256" == "$D97AF_EXE_SHA256_EXPECTED" ]] || fail "STAGED_EXE_SHA256_MISMATCH:$STAGED_EXE_SHA256"
[[ "$STAGED_EXE_ARCHS" == "x86_64" ]] || fail "STAGED_EXE_ARCH_MISMATCH:$STAGED_EXE_ARCHS"
[[ "$STAGED_EXE_FILE" == *"Mach-O 64-bit executable x86_64"* ]] || fail "STAGED_EXE_FILE_MISMATCH:$STAGED_EXE_FILE"
echo "D97AF_STAGED_APP_IDENTITY=PASS"

[[ -d "$LIVE_APP" && ! -L "$LIVE_APP" ]] || fail "LIVE_D97AD_APP_MISSING_OR_SYMLINK"
[[ -f "$LIVE_EXE" && ! -L "$LIVE_EXE" && -x "$LIVE_EXE" ]] || fail "LIVE_D97AD_EXE_INVALID"
LIVE_PRE_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
LIVE_PRE_SHA256="$(sha256_file "$LIVE_EXE")"
echo "LIVE_PREDEPLOY_EXE_BYTES=$LIVE_PRE_BYTES"
echo "LIVE_PREDEPLOY_EXE_SHA256=$LIVE_PRE_SHA256"
[[ "$LIVE_PRE_BYTES" == "$D97AD_LIVE_EXE_BYTES_EXPECTED" ]] || fail "LIVE_PREDEPLOY_EXE_BYTES_MISMATCH:$LIVE_PRE_BYTES"
[[ "$LIVE_PRE_SHA256" == "$D97AD_LIVE_EXE_SHA256_EXPECTED" ]] || fail "LIVE_PREDEPLOY_EXE_SHA256_MISMATCH:$LIVE_PRE_SHA256"
echo "D97AF_LIVE_D97AD_PREIMAGE=PASS"

[[ ! -e "$BACKUP_APP" && ! -L "$BACKUP_APP" ]] || fail "BACKUP_PATH_ALREADY_EXISTS:$BACKUP_APP"
[[ ! -e "$NEW_APP" && ! -L "$NEW_APP" ]] || fail "NEW_APP_PATH_ALREADY_EXISTS:$NEW_APP"
[[ ! -e "$FAILED_APP" && ! -L "$FAILED_APP" ]] || fail "FAILED_APP_PATH_ALREADY_EXISTS:$FAILED_APP"

/usr/bin/sudo -v || fail "SUDO_AUTHENTICATION_FAILED"

echo "===== PREPARE EXACT D97AF APP BESIDE LIVE APP ====="
INSTALLED_APP_MUTATION_STATE="PREPARING_NEW_APP"
/usr/bin/sudo /usr/bin/ditto "$STAGED_APP" "$NEW_APP" || fail "NEW_APP_COPY_FAILED"
/usr/bin/sudo /usr/sbin/chown -R root:wheel "$NEW_APP" || fail "NEW_APP_OWNER_NORMALIZATION_FAILED"
/usr/bin/sudo /usr/bin/xattr -dr com.apple.quarantine "$NEW_APP" 2>/dev/null || true
NEW_EXE_SHA256="$(sha256_file "$NEW_APP/Contents/MacOS/OpenCore-Patcher")"
NEW_EXE_BYTES="$(/usr/bin/stat -f '%z' "$NEW_APP/Contents/MacOS/OpenCore-Patcher")"
NEW_EXE_ARCHS="$(/usr/bin/lipo -archs "$NEW_APP/Contents/MacOS/OpenCore-Patcher")"
echo "NEW_APP_EXE_BYTES=$NEW_EXE_BYTES"
echo "NEW_APP_EXE_SHA256=$NEW_EXE_SHA256"
echo "NEW_APP_EXE_ARCHS=$NEW_EXE_ARCHS"
[[ "$NEW_EXE_BYTES" == "$D97AF_EXE_BYTES_EXPECTED" ]] || fail "NEW_APP_EXE_BYTES_MISMATCH:$NEW_EXE_BYTES"
[[ "$NEW_EXE_SHA256" == "$D97AF_EXE_SHA256_EXPECTED" ]] || fail "NEW_APP_EXE_SHA256_MISMATCH:$NEW_EXE_SHA256"
[[ "$NEW_EXE_ARCHS" == "x86_64" ]] || fail "NEW_APP_EXE_ARCH_MISMATCH:$NEW_EXE_ARCHS"
INSTALLED_APP_MUTATION_STATE="NEW_APP_READY"

PIDS_BEFORE=("${(@f)$(/usr/bin/pgrep -f '/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' 2>/dev/null || true)}")
OLD_PID_SET=" ${PIDS_BEFORE[*]} "
echo "OLD_PROCESS_PIDS=${PIDS_BEFORE[*]:-NONE}"
for pid in $PIDS_BEFORE; do
  [[ -n "$pid" ]] || continue
  process_command="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
  echo "OLD_PROCESS_TERM=$pid|$process_command"
  if [[ "$process_command" == "$LIVE_EXE"* ]]; then
    /bin/kill -TERM "$pid" 2>/dev/null || true
  fi
done
/bin/sleep 2
for pid in $PIDS_BEFORE; do
  [[ -n "$pid" ]] || continue
  if /bin/kill -0 "$pid" 2>/dev/null; then
    process_command="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
    if [[ "$process_command" == "$LIVE_EXE"* ]]; then
      echo "OLD_PROCESS_KILL=$pid|$process_command"
      /bin/kill -KILL "$pid" 2>/dev/null || true
    fi
  fi
done
/bin/sleep 1
for pid in $PIDS_BEFORE; do
  [[ -n "$pid" ]] || continue
  if /bin/kill -0 "$pid" 2>/dev/null; then
    fail "OLD_OCLP_PROCESS_SURVIVED:$pid"
  fi
done
POST_TERMINATION_PIDS=("${(@f)$(/usr/bin/pgrep -f '/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' 2>/dev/null || true)}")
for pid in $POST_TERMINATION_PIDS; do
  [[ -n "$pid" ]] || continue
  process_command="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
  if [[ "$process_command" == "$LIVE_EXE"* ]]; then
    fail "OLD_OCLP_PROCESS_APPEARED_AFTER_CENSUS:$pid"
  fi
done
echo "D97AF_EXACT_PATH_PROCESS_CENSUS_BEFORE_SWITCH=EMPTY"
echo "D97AF_OLD_PROCESS_SET_TERMINATED=PASS"

echo "===== TRANSACTIONAL PATH SWITCH TO D97AF APP ====="
INSTALLED_APP_MUTATION_STATE="MOVING_LIVE_TO_BACKUP"
/usr/bin/sudo /bin/mv "$LIVE_APP" "$BACKUP_APP" || fail "LIVE_TO_BACKUP_MOVE_FAILED"
INSTALLED_APP_MUTATION_STATE="LIVE_MOVED_TO_BACKUP"
BACKUP_EXE_SHA256="$(sha256_file "$BACKUP_APP/Contents/MacOS/OpenCore-Patcher")"
echo "BACKUP_APP=$BACKUP_APP"
echo "BACKUP_EXE_SHA256=$BACKUP_EXE_SHA256"
[[ "$BACKUP_EXE_SHA256" == "$D97AD_LIVE_EXE_SHA256_EXPECTED" ]] || fail "BACKUP_EXE_SHA256_MISMATCH:$BACKUP_EXE_SHA256"

GAP_PIDS=("${(@f)$(/usr/bin/pgrep -f '/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' 2>/dev/null || true)}")
for pid in $GAP_PIDS; do
  [[ -n "$pid" ]] || continue
  process_command="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
  if [[ "$process_command" == "$LIVE_EXE"* ]]; then
    fail "OLD_OCLP_PROCESS_APPEARED_DURING_SWITCH:$pid"
  fi
done
echo "D97AF_EXACT_PATH_PROCESS_CENSUS_DURING_SWITCH=EMPTY"

INSTALLED_APP_MUTATION_STATE="SWITCHING_TO_D97AF"
/usr/bin/sudo /bin/mv "$NEW_APP" "$LIVE_APP" || fail "NEW_TO_LIVE_MOVE_FAILED"
INSTALLED_APP_MUTATION_STATE="D97AF_DEPLOYED_PENDING_POSTAUDIT"

LIVE_POST_BYTES="$(/usr/bin/stat -f '%z' "$LIVE_EXE")"
LIVE_POST_SHA256="$(sha256_file "$LIVE_EXE")"
LIVE_POST_ARCHS="$(/usr/bin/lipo -archs "$LIVE_EXE")"
echo "LIVE_POSTDEPLOY_EXE_BYTES=$LIVE_POST_BYTES"
echo "LIVE_POSTDEPLOY_EXE_SHA256=$LIVE_POST_SHA256"
echo "LIVE_POSTDEPLOY_EXE_ARCHS=$LIVE_POST_ARCHS"
[[ "$LIVE_POST_BYTES" == "$D97AF_EXE_BYTES_EXPECTED" && \
   "$LIVE_POST_SHA256" == "$D97AF_EXE_SHA256_EXPECTED" && \
   "$LIVE_POST_ARCHS" == "x86_64" ]] || fail "LIVE_POSTDEPLOY_IDENTITY_MISMATCH"
INSTALLED_APP_MUTATION_STATE="D97AF_DEPLOYED_EXACT"
echo "D97AF_LIVE_APP_IDENTITY=PASS"

/usr/bin/open -n "$LIVE_APP" || fail "OPEN_OCLP_FAILED"
FRESH_PROCESS_PROVEN=0
for wait_index in {1..15}; do
  PIDS_AFTER=("${(@f)$(/usr/bin/pgrep -f '/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' 2>/dev/null || true)}")
  for pid in $PIDS_AFTER; do
    [[ -n "$pid" ]] || continue
    process_command="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
    is_old=0
    [[ "$OLD_PID_SET" == *" $pid "* ]] && is_old=1
    echo "LIVE_PROCESS=$pid|OLD_PID=$is_old|$process_command"
    if (( is_old == 0 )) && [[ "$process_command" == "$LIVE_EXE"* ]]; then
      FRESH_PROCESS_PROVEN=1
    fi
  done
  (( FRESH_PROCESS_PROVEN == 1 )) && break
  /bin/sleep 1
done
(( FRESH_PROCESS_PROVEN == 1 )) || fail "FRESH_D97AF_PROCESS_PATH_PROVENANCE_FAIL"
echo "D97AF_FRESH_PROCESS_PROVENANCE=PASS"

echo "===== FINAL ====="
echo "D97AF_RUN_JOB_AND_ARTIFACT_METADATA=PASS"
echo "D97AF_DOWNLOADED_OUTER_ARTIFACT=PASS"
echo "D97AF_COMPLETE_SHA256SUMS_AND_PACKAGED_EXE=PASS"
echo "D97AF_DOWNLOADED_REPORTS=PASS"
echo "D97AF_STAGED_APP_IDENTITY=PASS"
echo "D97AF_LIVE_D97AD_PREIMAGE=PASS"
echo "D97AF_BACKUP_APP=$BACKUP_APP"
echo "D97AF_LIVE_APP_EXE_SHA256=$LIVE_POST_SHA256"
echo "D97AF_LIVE_APP_EXE_ARCHS=$LIVE_POST_ARCHS"
echo "D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY=PASS"
echo "INSTALLED_APP_MUTATION_STATE=$INSTALLED_APP_MUTATION_STATE"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "USER_ACTION_NOW=STOP_RETURN_COMPLETE_OUTPUT"
echo "REPORT=$REPORT"
