#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEO_HARDENED_GITHUB_ARTIFACT_DOWNLOAD_AUDIT_DEPLOY_REPORT.txt"
REPO="StefanAlMare/Private-Work"
RUN_ID="33553271179"
JOB_ID="100007798331"
RUN_HEAD_SHA="1faab13865eb945198f3551688f11f1ba645e29a"
ARTIFACT_ID="9818489515"
ARTIFACT_NAME="OCLP7-D97AD-OpenCore-Patcher-v2"
ARTIFACT_SIZE_EXPECTED="751552700"
ARTIFACT_DIGEST_EXPECTED="sha256:d570342beed9ceac1f37df24d7c4fa1ba0ad106114139f2e555ccba3f64ccc63"
INNER_APP_ZIP_SHA_EXPECTED="c7951479492acbb2ce352d0958a2be84219db4b10484a0ce8cbb9238d0ef778c"
D97AD_EXE_SHA_EXPECTED="5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0"
LIVE_D97Z_EXE_SHA_EXPECTED="0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f"
MIN_FREE_KB="4194304"
STAMP="$(/bin/date +%Y%m%d-%H%M%S)"
STAGE="$HOME/Desktop/OCLP7_D97AEO_GITHUB_ARTIFACT_STAGE_$STAMP"
DOWNLOAD_DIR="$STAGE/download"
EXTRACT_DIR="$STAGE/extracted"
LIVE_APP="/Applications/OpenCore-Patcher.app"
LIVE_EXE="$LIVE_APP/Contents/MacOS/OpenCore-Patcher"
BACKUP_APP="/Applications/OpenCore-Patcher.app.D97Z-before-D97AD-GitHub-$STAMP"
NEW_APP="/Applications/OpenCore-Patcher.app.D97AD-deploying-$STAMP"

exec > >(/usr/bin/tee "$REPORT") 2>&1

fail() {
  echo "D97AEO_FAIL=$*"
  echo "LOCAL_SOURCE_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

sha256_file() {
  /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

echo "===== OCLP7 D97AEO — HARDENED EXACT GITHUB ARTIFACT DOWNLOAD / AUDIT / DEPLOY ====="
echo "INPUT_PUSH_COMMIT=$RUN_HEAD_SHA"
echo "INPUT_WORKFLOW_RUN=$RUN_ID"
echo "INPUT_WORKFLOW_JOB=$JOB_ID"
echo "INPUT_ARTIFACT_ID=$ARTIFACT_ID"
echo "INPUT_ARTIFACT_NAME=$ARTIFACT_NAME"
echo "EXPECTED_ARTIFACT_DIGEST=$ARTIFACT_DIGEST_EXPECTED"
echo "EXPECTED_INNER_APP_ZIP_SHA256=$INNER_APP_ZIP_SHA_EXPECTED"
echo "EXPECTED_D97AD_EXE_SHA256=$D97AD_EXE_SHA_EXPECTED"
echo "EXPECTED_LIVE_D97Z_PREIMAGE_SHA256=$LIVE_D97Z_EXE_SHA_EXPECTED"
echo "FRESH_PROCESS_GATE=old_PIDs_must_be_gone_and_postdeploy_PID_must_be_new"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for tool in gh git python3 shasum awk find ditto lipo file plutil pgrep ps open sudo df grep; do
  path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${path:-MISSING}"
  [[ -n "$path" ]] || fail "MISSING_TOOL:$tool"
done

LOGIN="$(gh api user --jq .login)"
echo "ACTIVE_GITHUB_LOGIN=$LOGIN"
[[ "$LOGIN" == "StefanAlMare" ]] || fail "WRONG_GITHUB_LOGIN:$LOGIN"

FREE_KB="$(/bin/df -Pk "$HOME" | /usr/bin/awk 'NR==2 {print $4}')"
echo "HOME_FREE_KB=$FREE_KB"
[[ "$FREE_KB" == <-> ]] || fail "FREE_SPACE_PARSE_FAIL:$FREE_KB"
(( FREE_KB >= MIN_FREE_KB )) || fail "INSUFFICIENT_FREE_SPACE_KB:$FREE_KB"

/bin/mkdir -p "$DOWNLOAD_DIR" "$EXTRACT_DIR"

RUN_JSON="$STAGE/run.json"
ARTIFACT_JSON="$STAGE/artifact.json"
gh api "repos/$REPO/actions/runs/$RUN_ID" > "$RUN_JSON"
gh api "repos/$REPO/actions/artifacts/$ARTIFACT_ID" > "$ARTIFACT_JSON"

/usr/local/bin/python3 - "$RUN_JSON" "$ARTIFACT_JSON" "$RUN_ID" "$RUN_HEAD_SHA" "$ARTIFACT_ID" "$ARTIFACT_NAME" "$ARTIFACT_SIZE_EXPECTED" "$ARTIFACT_DIGEST_EXPECTED" <<'PY'
import json
import sys
from pathlib import Path
run = json.loads(Path(sys.argv[1]).read_text())
artifact = json.loads(Path(sys.argv[2]).read_text())
run_id = int(sys.argv[3])
head_sha = sys.argv[4]
artifact_id = int(sys.argv[5])
artifact_name = sys.argv[6]
artifact_size = int(sys.argv[7])
artifact_digest = sys.argv[8]
print(f"RUN_STATUS={run.get('status')}")
print(f"RUN_CONCLUSION={run.get('conclusion')}")
print(f"RUN_HEAD_SHA={run.get('head_sha')}")
print(f"RUN_WORKFLOW_PATH={run.get('path')}")
if run.get('id') != run_id or run.get('status') != 'completed' or run.get('conclusion') != 'success' or run.get('head_sha') != head_sha:
    raise SystemExit('RUN_IDENTITY_OR_SUCCESS_GATE_FAIL')
print('D97AEO_WORKFLOW_RUN_IDENTITY_AND_SUCCESS=PASS')
print(f"ARTIFACT_NAME={artifact.get('name')}")
print(f"ARTIFACT_SIZE={artifact.get('size_in_bytes')}")
print(f"ARTIFACT_DIGEST={artifact.get('digest')}")
print(f"ARTIFACT_EXPIRED={artifact.get('expired')}")
wr = artifact.get('workflow_run') or {}
print(f"ARTIFACT_WORKFLOW_HEAD_SHA={wr.get('head_sha')}")
if artifact.get('id') != artifact_id:
    raise SystemExit('ARTIFACT_ID_MISMATCH')
if artifact.get('name') != artifact_name:
    raise SystemExit('ARTIFACT_NAME_MISMATCH')
if artifact.get('size_in_bytes') != artifact_size:
    raise SystemExit('ARTIFACT_SIZE_MISMATCH')
if artifact.get('digest') != artifact_digest:
    raise SystemExit('ARTIFACT_DIGEST_MISMATCH')
if artifact.get('expired') is not False:
    raise SystemExit('ARTIFACT_EXPIRED_OR_UNKNOWN')
if wr.get('head_sha') != head_sha:
    raise SystemExit('ARTIFACT_HEAD_SHA_MISMATCH')
print('D97AEO_ARTIFACT_METADATA_IDENTITY=PASS')
PY

echo "===== DOWNLOAD PRIVATE VALIDATED ARTIFACT ====="
gh run download "$RUN_ID" --repo "$REPO" --name "$ARTIFACT_NAME" --dir "$DOWNLOAD_DIR"

APP_ZIPS=("${(@f)$(/usr/bin/find "$DOWNLOAD_DIR" -type f -name 'OCLP7-D97AD-OpenCore-Patcher.app.zip' -print)}")
SUM_FILES=("${(@f)$(/usr/bin/find "$DOWNLOAD_DIR" -type f -name 'SHA256SUMS-OCLP7-D97AD.txt' -print)}")
AUDIT_FILES=("${(@f)$(/usr/bin/find "$DOWNLOAD_DIR" -type f -name 'OCLP7_D97AD_GITHUB_BUILD_AUDIT_REPORT.txt' -print)}")
(( ${#APP_ZIPS[@]} == 1 )) || fail "INNER_APP_ZIP_CARDINALITY:${#APP_ZIPS[@]}"
(( ${#SUM_FILES[@]} == 1 )) || fail "SHA_SUM_FILE_CARDINALITY:${#SUM_FILES[@]}"
(( ${#AUDIT_FILES[@]} == 1 )) || fail "AUDIT_REPORT_CARDINALITY:${#AUDIT_FILES[@]}"
APP_ZIP="$APP_ZIPS[1]"
SUM_FILE="$SUM_FILES[1]"
AUDIT_FILE="$AUDIT_FILES[1]"
echo "DOWNLOADED_APP_ZIP=$APP_ZIP"
echo "DOWNLOADED_SUM_FILE=$SUM_FILE"
echo "DOWNLOADED_AUDIT_FILE=$AUDIT_FILE"

APP_ZIP_SHA="$(sha256_file "$APP_ZIP")"
echo "DOWNLOADED_INNER_APP_ZIP_SHA256=$APP_ZIP_SHA"
[[ "$APP_ZIP_SHA" == "$INNER_APP_ZIP_SHA_EXPECTED" ]] || fail "INNER_APP_ZIP_SHA_MISMATCH:$APP_ZIP_SHA"
/usr/bin/grep -Fq "$INNER_APP_ZIP_SHA_EXPECTED" "$SUM_FILE" || fail "SUM_FILE_MISSING_ZIP_SHA"
/usr/bin/grep -Fq "$D97AD_EXE_SHA_EXPECTED" "$SUM_FILE" || fail "SUM_FILE_MISSING_EXE_SHA"
echo "D97AEO_INNER_ZIP_AND_SUM_MANIFEST=PASS"

for required_line in \
  "PACKAGED_APP_EXE_SHA256=$D97AD_EXE_SHA_EXPECTED" \
  "PACKAGED_D97Z_ABSENT=PASS" \
  "PACKAGED_D97_ABSENT=PASS" \
  "PACKAGED_D97AD_PRESENT_EXACTLY_ONCE=PASS" \
  "PACKAGED_D97AD_RUNTIME_CONTRACT=PASS" \
  "PACKAGED_METAL_3802_TAHOE_COMPILER_SUBSTRATE=PASS" \
  "OCLP7_D97AD_GITHUB_BUILD_AUDIT=PASS"; do
  /usr/bin/grep -Fqx "$required_line" "$AUDIT_FILE" || fail "BUILD_AUDIT_REQUIRED_LINE_MISSING:$required_line"
done
echo "D97AEO_DOWNLOADED_BUILD_AUDIT_REPORT=PASS"

echo "===== EXTRACT AND VERIFY APP ====="
/usr/bin/ditto -x -k "$APP_ZIP" "$EXTRACT_DIR"
STAGED_APPS=("${(@f)$(/usr/bin/find "$EXTRACT_DIR" -type d -name 'OpenCore-Patcher.app' -prune -print)}")
(( ${#STAGED_APPS[@]} == 1 )) || fail "STAGED_APP_CARDINALITY:${#STAGED_APPS[@]}"
STAGED_APP="$STAGED_APPS[1]"
STAGED_EXE="$STAGED_APP/Contents/MacOS/OpenCore-Patcher"
[[ -x "$STAGED_EXE" ]] || fail "STAGED_EXE_MISSING_OR_NOT_EXECUTABLE"
/usr/bin/plutil -lint "$STAGED_APP/Contents/Info.plist"
STAGED_EXE_SHA="$(sha256_file "$STAGED_EXE")"
echo "STAGED_APP=$STAGED_APP"
echo "STAGED_EXE_SHA256=$STAGED_EXE_SHA"
[[ "$STAGED_EXE_SHA" == "$D97AD_EXE_SHA_EXPECTED" ]] || fail "STAGED_EXE_SHA_MISMATCH:$STAGED_EXE_SHA"
ARCHS="$(/usr/bin/lipo -archs "$STAGED_EXE")"
FILE_IDENTITY="$(/usr/bin/file "$STAGED_EXE")"
echo "STAGED_EXE_ARCHS=$ARCHS"
echo "STAGED_EXE_FILE=$FILE_IDENTITY"
[[ " $ARCHS " == *" x86_64 "* ]] || fail "STAGED_EXE_MISSING_X86_64:$ARCHS"
echo "D97AEO_STAGED_APP_IDENTITY=PASS"

[[ -x "$LIVE_EXE" ]] || fail "LIVE_D97Z_EXE_MISSING"
LIVE_PRE_SHA="$(sha256_file "$LIVE_EXE")"
echo "LIVE_PREDEPLOY_EXE_SHA256=$LIVE_PRE_SHA"
[[ "$LIVE_PRE_SHA" == "$LIVE_D97Z_EXE_SHA_EXPECTED" ]] || fail "LIVE_PREIMAGE_NOT_D97Z:$LIVE_PRE_SHA"
echo "D97AEO_LIVE_D97Z_PREIMAGE=PASS"

[[ ! -e "$BACKUP_APP" ]] || fail "BACKUP_PATH_ALREADY_EXISTS:$BACKUP_APP"
[[ ! -e "$NEW_APP" ]] || fail "NEW_APP_PATH_ALREADY_EXISTS:$NEW_APP"

sudo -v

echo "===== BACKUP CURRENT D97Z APPLICATION ====="
sudo /usr/bin/ditto "$LIVE_APP" "$BACKUP_APP"
BACKUP_EXE_SHA="$(sha256_file "$BACKUP_APP/Contents/MacOS/OpenCore-Patcher")"
echo "BACKUP_APP=$BACKUP_APP"
echo "BACKUP_EXE_SHA256=$BACKUP_EXE_SHA"
[[ "$BACKUP_EXE_SHA" == "$LIVE_D97Z_EXE_SHA_EXPECTED" ]] || fail "BACKUP_SHA_MISMATCH:$BACKUP_EXE_SHA"

echo "===== PREPARE D97AD APPLICATION IN /Applications ====="
sudo /usr/bin/ditto "$STAGED_APP" "$NEW_APP"
sudo /usr/sbin/chown -R root:wheel "$NEW_APP"
NEW_EXE_SHA="$(sha256_file "$NEW_APP/Contents/MacOS/OpenCore-Patcher")"
echo "NEW_APP_EXE_SHA256=$NEW_EXE_SHA"
[[ "$NEW_EXE_SHA" == "$D97AD_EXE_SHA_EXPECTED" ]] || fail "NEW_APP_SHA_MISMATCH:$NEW_EXE_SHA"

PIDS_BEFORE=("${(@f)$(/usr/bin/pgrep -f '/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' 2>/dev/null || true)}")
OLD_PID_SET=" ${PIDS_BEFORE[*]} "
echo "OLD_PROCESS_PIDS=${PIDS_BEFORE[*]:-NONE}"
for pid in $PIDS_BEFORE; do
  [[ -n "$pid" ]] || continue
  cmd="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
  echo "TERMINATING_OLD_PROCESS_TERM=$pid|$cmd"
  if [[ "$cmd" == /Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher* ]]; then
    /bin/kill -TERM "$pid" 2>/dev/null || true
  fi
done
/bin/sleep 2
for pid in $PIDS_BEFORE; do
  [[ -n "$pid" ]] || continue
  if /bin/kill -0 "$pid" 2>/dev/null; then
    cmd="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
    echo "TERMINATING_OLD_PROCESS_KILL=$pid|$cmd"
    if [[ "$cmd" == /Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher* ]]; then
      /bin/kill -KILL "$pid" 2>/dev/null || true
    fi
  fi
done
/bin/sleep 1
for pid in $PIDS_BEFORE; do
  [[ -n "$pid" ]] || continue
  if /bin/kill -0 "$pid" 2>/dev/null; then
    fail "OLD_PROCESS_SURVIVED:$pid"
  fi
done
echo "D97AEO_OLD_PROCESS_SET_TERMINATED=PASS"

echo "===== DEPLOY EXACT D97AD APPLICATION ====="
sudo /bin/rm -rf "$LIVE_APP"
sudo /bin/mv "$NEW_APP" "$LIVE_APP"
LIVE_POST_SHA="$(sha256_file "$LIVE_EXE")"
echo "LIVE_POSTDEPLOY_EXE_SHA256=$LIVE_POST_SHA"
if [[ "$LIVE_POST_SHA" != "$D97AD_EXE_SHA_EXPECTED" ]]; then
  echo "D97AEO_DEPLOY_POST_SHA_MISMATCH=$LIVE_POST_SHA"
  sudo /bin/rm -rf "$LIVE_APP"
  sudo /usr/bin/ditto "$BACKUP_APP" "$LIVE_APP"
  RESTORED_SHA="$(sha256_file "$LIVE_EXE")"
  echo "D97AEO_ROLLBACK_RESTORED_SHA=$RESTORED_SHA"
  fail "DEPLOY_SHA_MISMATCH_ROLLBACK_ATTEMPTED"
fi
echo "D97AEO_DEPLOY_SHA_MATCH=PASS"

/usr/bin/open "$LIVE_APP"
/bin/sleep 5
PIDS_AFTER=("${(@f)$(/usr/bin/pgrep -f '/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher' 2>/dev/null || true)}")
(( ${#PIDS_AFTER[@]} >= 1 )) || fail "NO_FRESH_LIVE_PROCESS_FOUND"
PROVEN=0
for pid in $PIDS_AFTER; do
  [[ -n "$pid" ]] || continue
  cmd="$(/bin/ps -p "$pid" -o command= 2>/dev/null || true)"
  is_old=0
  [[ "$OLD_PID_SET" == *" $pid "* ]] && is_old=1
  echo "LIVE_PROCESS=$pid|OLD_PID=$is_old|$cmd"
  if (( is_old == 0 )) && [[ "$cmd" == /Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher* ]]; then
    PROVEN=1
  fi
done
(( PROVEN == 1 )) || fail "FRESH_NEW_PROCESS_PATH_PROVENANCE_FAIL"
echo "D97AEO_FRESH_NEW_PROCESS_PROVENANCE=PASS"

echo "===== FINAL ====="
echo "D97AEO_WORKFLOW_RUN=PASS"
echo "D97AEO_ARTIFACT_METADATA=PASS"
echo "D97AEO_DOWNLOADED_ARTIFACT_AUDIT=PASS"
echo "D97AEO_STAGED_APP_EXE_SHA256=$STAGED_EXE_SHA"
echo "D97AEO_BACKUP_APP=$BACKUP_APP"
echo "D97AEO_LIVE_D97AD_EXE_SHA256=$LIVE_POST_SHA"
echo "D97AEO_HARDENED_GITHUB_ARTIFACT_DOWNLOAD_AUDIT_DEPLOY=PASS"
echo "LOCAL_SOURCE_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_audit_live_D97AD_before_manual_Root_Patch"
echo "STAGE=$STAGE"
echo "REPORT=$REPORT"
