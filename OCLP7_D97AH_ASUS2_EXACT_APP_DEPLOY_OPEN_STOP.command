#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="fcd817dec08e1ff782316516f7d2432e2b5d51df"
BASE_BLOB="e8dca8761903de7f612629ff85ea9ec81bc5d65c"
BASE_SHA256="64d7ceb501c8b909b7633a836c371257f1e2c48fd13d4f1f290095b6a4123c96"
BASE_BYTES="14858"
BASE_NAME="OCLP7_D97AG_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"

TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_DEPLOY_WRAPPER.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/d97ah.command"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_DEPLOY_WRAPPER.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_DEPLOY_TRANSFORM_WRAPPER=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

echo "===== OCLP7 D97AH — PINNED EXACT APP DEPLOY / OPEN WRAPPER ====="
echo "PURPOSE=derive_exact_D97AH_deploy_from_previously_passed_D97AG_deploy_then_execute_on_ASUS2_STOP"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_EXPECTED_BLOB=$BASE_BLOB"
echo "BASE_EXPECTED_SHA256=$BASE_SHA256"
echo "BASE_EXPECTED_BYTES=$BASE_BYTES"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DEPLOY_WRAPPER_DOWNLOAD_FAILED"

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
[[ "$BASE_ACTUAL_BLOB" == "$BASE_BLOB" ]] || fail "BASE_DEPLOY_WRAPPER_BLOB_MISMATCH"
[[ "$BASE_ACTUAL_SHA256" == "$BASE_SHA256" ]] || fail "BASE_DEPLOY_WRAPPER_SHA256_MISMATCH"
[[ "$BASE_ACTUAL_BYTES" == "$BASE_BYTES" ]] || fail "BASE_DEPLOY_WRAPPER_BYTES_MISMATCH"
/bin/zsh -n "$BASE" || fail "BASE_DEPLOY_WRAPPER_ZSH_PARSE_FAILED"
echo "D97AH_BASE_D97AG_DEPLOY_WRAPPER_IDENTITY_AND_PARSE=PASS"

"$PYTHON" - "$BASE" "$PATCHED" <<'PY'
from pathlib import Path
import hashlib, os, sys

src=Path(sys.argv[1])
dst=Path(sys.argv[2])
text=src.read_text(encoding='utf-8')

# Pin critical old substrate lines before any role transform.
old_critical = {
    'VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip"': 1,
    'D97AG_ZIP_BYTES="751494420"': 1,
    'D97AG_ZIP_SHA256="d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846"': 1,
    'D97AG_EXE_BYTES="6596544"': 1,
    'D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"': 1,
    'D97AF_EXE_BYTES="6595600"': 1,
    'D97AF_EXE_SHA256="ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470"': 1,
}
for needle, expected in old_critical.items():
    actual=text.count(needle)
    print('D97AH_DEPLOY_BASE_CRITICAL_COUNT='+str(actual)+'|'+needle.split('=')[0])
    if actual != expected:
        raise SystemExit('D97AH_DEPLOY_BASE_CRITICAL_CARDINALITY:'+needle+':'+str(actual))

# Collision-safe role shift: previous D97AF -> D97AG, new D97AG -> D97AH.
placeholder='__OCLP7_PREIMAGE_ROLE_D97AG__'
if placeholder in text:
    raise SystemExit('D97AH_DEPLOY_PLACEHOLDER_COLLISION')
text=text.replace('D97AF', placeholder)
text=text.replace('D97AG', 'D97AH')
text=text.replace(placeholder, 'D97AG')

# Replace only identities that differ between the two deployment generations.
exact_replacements = {
    'VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AH_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip"':
        'VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip"',
    'D97AH_ZIP_BYTES="751494420"':
        'D97AH_ZIP_BYTES="751494634"',
    'D97AH_ZIP_SHA256="d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846"':
        'D97AH_ZIP_SHA256="d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48"',
    'D97AH_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"':
        'D97AH_EXE_SHA256="207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf"',
    'D97AG_EXE_BYTES="6595600"':
        'D97AG_EXE_BYTES="6596544"',
    'D97AG_EXE_SHA256="ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470"':
        'D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"',
}
for old,new in exact_replacements.items():
    actual=text.count(old)
    print('D97AH_DEPLOY_IDENTITY_REPLACEMENT_PRE_COUNT='+str(actual)+'|'+old.split('=')[0])
    if actual != 1:
        raise SystemExit('D97AH_DEPLOY_IDENTITY_REPLACEMENT_CARDINALITY:'+old+':'+str(actual))
    text=text.replace(old,new,1)

required = {
    'VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip"': 1,
    'D97AH_ZIP_BYTES="751494634"': 1,
    'D97AH_ZIP_SHA256="d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48"': 1,
    'D97AH_EXE_BYTES="6596544"': 1,
    'D97AH_EXE_SHA256="207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf"': 1,
    'D97AG_EXE_BYTES="6596544"': 1,
    'D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"': 1,
    'PURPOSE=verify_local_D97AH_zip_backup_exact_D97AG_deploy_exact_D97AH_open_STOP': 1,
    'OpenCore-Patcher.app.D97AG-before-D97AH-': 1,
    'OpenCore-Patcher.app.D97AH-deploying-': 2,
    'D97AH_DEPLOYED_EXACT_OPENED': 2,
}
for needle, expected in required.items():
    actual=text.count(needle)
    print('D97AH_DEPLOY_POST_REQUIRED_COUNT='+str(actual)+'|'+needle[:72])
    if actual != expected:
        raise SystemExit('D97AH_DEPLOY_POST_REQUIRED_CARDINALITY:'+needle+':'+str(actual))

for forbidden in (
    'D97AF',
    '33696449978',
    'd6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846',
    'ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470',
):
    if forbidden in text:
        raise SystemExit('D97AH_DEPLOY_FORBIDDEN_REMAINS:'+forbidden)

# Guard the key exact live-state semantics after transformation.
semantic_needles = [
    '===== VERIFY EXACT LIVE D97AG PREIMAGE =====',
    'D97AG_LIVE_PREIMAGE=PASS',
    '===== SUDO GATE / PREPARE EXACT D97AH BESIDE LIVE =====',
    'D97AH_NEW_APP_READY_EXACT=PASS',
    'D97AH_LIVE_APP_IDENTITY=PASS',
    'D97AH_EXACT_APP_DEPLOY_OPEN_STOP=PASS',
    'INSTALLED_APP_MUTATION_STATE=D97AH_DEPLOYED_EXACT_OPENED',
]
for needle in semantic_needles:
    if needle not in text:
        raise SystemExit('D97AH_DEPLOY_SEMANTIC_MARKER_MISSING:'+needle)

out=text.encode('utf-8')
with dst.open('xb') as f:
    f.write(out)
    f.flush()
    os.fsync(f.fileno())
os.chmod(dst,0o700)
print('D97AH_DEPLOY_EXACT_ROLE_AND_IDENTITY_TRANSFORM=PASS')
print('D97AH_DEPLOY_PATCHED_WRAPPER_SHA256='+hashlib.sha256(out).hexdigest())
print('D97AH_DEPLOY_PATCHED_WRAPPER_BYTES='+str(len(out)))
PY

/bin/zsh -n "$PATCHED" || fail "D97AH_PATCHED_DEPLOY_WRAPPER_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_PATCHED_WRAPPER_LOCAL_PARSE=PASS"
echo "D97AH_DEPLOY_TRANSFORM_WRAPPER=PASS_READY_TO_EXECUTE_INNER"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AH_DEPLOY_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT_BEFORE_ROOT_PATCH"
