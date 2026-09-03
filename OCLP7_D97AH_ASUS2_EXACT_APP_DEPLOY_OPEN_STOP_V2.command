#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="fe47aa9c06bd416d387e3f64a137b18d471479c1"
BASE_BLOB="55304b6e3db1d1d9ab4e86b7e3b9aa154a744567"
BASE_SHA256="9e8d15eb78974053ae7a5a831062f2d0ce0d02677037035455088c967f160cab"
BASE_BYTES="7779"
BASE_NAME="OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"

TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_DEPLOY_V2.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_DEPLOY_V2.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_DEPLOY_V2=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO_UNLESS_INNER_EXPLICITLY_REPORTS_OTHERWISE"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

echo "===== OCLP7 D97AH — EXACT DEPLOY WRAPPER V2 ====="
echo "PURPOSE=pin_false_failed_v1_fix_placeholder_collision_only_then_execute_full_exact_deploy_STOP"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_EXPECTED_BLOB=$BASE_BLOB"
echo "BASE_EXPECTED_SHA256=$BASE_SHA256"
echo "BASE_EXPECTED_BYTES=$BASE_BYTES"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_WRAPPER_DOWNLOAD_FAILED"

BASE_ACTUAL_BLOB="$("$PYTHON" - "$BASE" <<'PY'
import hashlib,sys
from pathlib import Path
data=Path(sys.argv[1]).read_bytes()
print(hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest())
PY
)"
BASE_ACTUAL_SHA256="$(/usr/bin/shasum -a 256 "$BASE" | /usr/bin/awk '{print $1}')"
BASE_ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$BASE")"

echo "BASE_ACTUAL_BLOB=$BASE_ACTUAL_BLOB"
echo "BASE_ACTUAL_SHA256=$BASE_ACTUAL_SHA256"
echo "BASE_ACTUAL_BYTES=$BASE_ACTUAL_BYTES"
[[ "$BASE_ACTUAL_BLOB" == "$BASE_BLOB" ]] || fail "BASE_BLOB_MISMATCH"
[[ "$BASE_ACTUAL_SHA256" == "$BASE_SHA256" ]] || fail "BASE_SHA256_MISMATCH"
[[ "$BASE_ACTUAL_BYTES" == "$BASE_BYTES" ]] || fail "BASE_BYTES_MISMATCH"
/bin/zsh -n "$BASE" || fail "BASE_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_V2_BASE_IDENTITY_AND_PARSE=PASS"

"$PYTHON" - "$BASE" "$PATCHED" <<'PY'
from pathlib import Path
import hashlib, os, sys
src=Path(sys.argv[1]); dst=Path(sys.argv[2])
text=src.read_text(encoding='utf-8')
old="placeholder='__OCLP7_PREIMAGE_ROLE_D97AG__'"
new="placeholder='__OCLP7_PREIMAGE_ROLE_OLD__'"
old_count=text.count(old)
new_count=text.count(new)
print('D97AH_DEPLOY_V2_OLD_PLACEHOLDER_PRE_COUNT='+str(old_count))
print('D97AH_DEPLOY_V2_NEW_PLACEHOLDER_PRE_COUNT='+str(new_count))
if old_count != 1:
    raise SystemExit('D97AH_DEPLOY_V2_OLD_PLACEHOLDER_CARDINALITY:'+str(old_count))
if new_count != 0:
    raise SystemExit('D97AH_DEPLOY_V2_NEW_PLACEHOLDER_ALREADY_PRESENT:'+str(new_count))
text=text.replace(old,new,1)
old_post=text.count(old); new_post=text.count(new)
print('D97AH_DEPLOY_V2_OLD_PLACEHOLDER_POST_COUNT='+str(old_post))
print('D97AH_DEPLOY_V2_NEW_PLACEHOLDER_POST_COUNT='+str(new_post))
if old_post != 0 or new_post != 1:
    raise SystemExit('D97AH_DEPLOY_V2_PLACEHOLDER_POST_CARDINALITY')
# The neutral placeholder must not be touched by the embedded D97AG->D97AH role shift.
if 'D97AG' in new:
    raise SystemExit('D97AH_DEPLOY_V2_NEUTRAL_PLACEHOLDER_INVALID')
out=text.encode('utf-8')
with dst.open('xb') as f:
    f.write(out); f.flush(); os.fsync(f.fileno())
os.chmod(dst,0o700)
print('D97AH_DEPLOY_V2_EXACT_ONE_LINE_PLACEHOLDER_FIX=PASS')
print('D97AH_DEPLOY_V2_PATCHED_SHA256='+hashlib.sha256(out).hexdigest())
print('D97AH_DEPLOY_V2_PATCHED_BYTES='+str(len(out)))
PY

/bin/zsh -n "$PATCHED" || fail "PATCHED_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_V2_PATCHED_LOCAL_PARSE=PASS"
echo "D97AH_DEPLOY_V2_READY_TO_EXECUTE_FULL_INNER=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AH_DEPLOY_V2=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT_BEFORE_ROOT_PATCH"
