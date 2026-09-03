#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="fcd817dec08e1ff782316516f7d2432e2b5d51df"
BASE_BLOB="e8dca8761903de7f612629ff85ea9ec81bc5d65c"
BASE_SHA256="64d7ceb501c8b909b7633a836c371257f1e2c48fd13d4f1f290095b6a4123c96"
BASE_BYTES="14858"
BASE_NAME="OCLP7_D97AG_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"

NAME="OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip"
EXPECTED_ZIP_BYTES="751494634"
EXPECTED_ZIP_SHA256="d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48"
TRASH_SOURCE="$HOME/.Trash/$NAME"
DESKTOP_SOURCE="$HOME/Desktop/$NAME"

TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_DEPLOY_V5.XXXXXX)"
BASE="$TMP/base.command"
PRIVATE_ZIP="$TMP/$NAME"
INNER="$TMP/d97ah-inner.command"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_DEPLOY_V5.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_DEPLOY_V5=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

sha256_file() {
    /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

bytes_file() {
    /usr/bin/stat -f '%z' "$1"
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

for tool in /usr/bin/curl /usr/bin/shasum /usr/bin/stat /usr/bin/awk /usr/bin/mktemp /bin/cp /bin/rm /bin/zsh; do
    [[ -x "$tool" ]] || fail "MISSING_TOOL:$tool"
done

echo "===== OCLP7 D97AH — EXACT DEPLOY V5 PRIVATE TEMP SOURCE ====="
echo "PURPOSE=select_exact_D97AH_zip_copy_to_private_temp_derive_exact_deploy_execute_open_STOP"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_EXPECTED_BLOB=$BASE_BLOB"
echo "BASE_EXPECTED_SHA256=$BASE_SHA256"
echo "BASE_EXPECTED_BYTES=$BASE_BYTES"
echo "EXPECTED_ZIP_BYTES=$EXPECTED_ZIP_BYTES"
echo "EXPECTED_ZIP_SHA256=$EXPECTED_ZIP_SHA256"
echo "TRASH_SOURCE=$TRASH_SOURCE"
echo "DESKTOP_SOURCE=$DESKTOP_SOURCE"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

SELECTED_SOURCE=""
for candidate in "$TRASH_SOURCE" "$DESKTOP_SOURCE"; do
    if [[ -f "$candidate" && ! -L "$candidate" ]]; then
        candidate_bytes="$(bytes_file "$candidate")"
        candidate_sha="$(sha256_file "$candidate")"
        echo "D97AH_DEPLOY_V5_SOURCE_CANDIDATE=$candidate|BYTES=$candidate_bytes|SHA256=$candidate_sha"
        if [[ "$candidate_bytes" == "$EXPECTED_ZIP_BYTES" && "$candidate_sha" == "$EXPECTED_ZIP_SHA256" ]]; then
            SELECTED_SOURCE="$candidate"
            break
        fi
    fi
done

[[ -n "$SELECTED_SOURCE" ]] || fail "NO_EXACT_SOURCE_IN_TRASH_OR_DESKTOP"
echo "D97AH_DEPLOY_V5_SELECTED_SOURCE=$SELECTED_SOURCE"
echo "D97AH_DEPLOY_V5_SELECTED_SOURCE_IDENTITY=PASS"

/bin/cp -p "$SELECTED_SOURCE" "$PRIVATE_ZIP" || fail "PRIVATE_SOURCE_COPY_FAILED"
[[ -f "$PRIVATE_ZIP" && ! -L "$PRIVATE_ZIP" ]] || fail "PRIVATE_SOURCE_COPY_INVALID"
PRIVATE_ZIP_BYTES="$(bytes_file "$PRIVATE_ZIP")"
PRIVATE_ZIP_SHA256="$(sha256_file "$PRIVATE_ZIP")"
echo "D97AH_DEPLOY_V5_PRIVATE_ZIP=$PRIVATE_ZIP"
echo "D97AH_DEPLOY_V5_PRIVATE_ZIP_BYTES=$PRIVATE_ZIP_BYTES"
echo "D97AH_DEPLOY_V5_PRIVATE_ZIP_SHA256=$PRIVATE_ZIP_SHA256"
[[ "$PRIVATE_ZIP_BYTES" == "$EXPECTED_ZIP_BYTES" ]] || fail "PRIVATE_ZIP_BYTES_MISMATCH"
[[ "$PRIVATE_ZIP_SHA256" == "$EXPECTED_ZIP_SHA256" ]] || fail "PRIVATE_ZIP_SHA_MISMATCH"
SELECTED_POST_BYTES="$(bytes_file "$SELECTED_SOURCE")"
SELECTED_POST_SHA="$(sha256_file "$SELECTED_SOURCE")"
[[ "$SELECTED_POST_BYTES" == "$EXPECTED_ZIP_BYTES" && "$SELECTED_POST_SHA" == "$EXPECTED_ZIP_SHA256" ]] || fail "SELECTED_SOURCE_CHANGED_AFTER_COPY"
echo "D97AH_DEPLOY_V5_PRIVATE_ZIP_IDENTITY=PASS"
echo "D97AH_DEPLOY_V5_SELECTED_SOURCE_RETAINED_EXACT=PASS"

/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD_FAILED"
BASE_ACTUAL_BLOB="$("$PYTHON" - "$BASE" <<'PY'
import hashlib,sys
from pathlib import Path
data=Path(sys.argv[1]).read_bytes()
print(hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest())
PY
)"
BASE_ACTUAL_SHA256="$(sha256_file "$BASE")"
BASE_ACTUAL_BYTES="$(bytes_file "$BASE")"
echo "BASE_ACTUAL_BLOB=$BASE_ACTUAL_BLOB"
echo "BASE_ACTUAL_SHA256=$BASE_ACTUAL_SHA256"
echo "BASE_ACTUAL_BYTES=$BASE_ACTUAL_BYTES"
[[ "$BASE_ACTUAL_BLOB" == "$BASE_BLOB" ]] || fail "BASE_BLOB_MISMATCH"
[[ "$BASE_ACTUAL_SHA256" == "$BASE_SHA256" ]] || fail "BASE_SHA256_MISMATCH"
[[ "$BASE_ACTUAL_BYTES" == "$BASE_BYTES" ]] || fail "BASE_BYTES_MISMATCH"
/bin/zsh -n "$BASE" || fail "BASE_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_V5_BASE_D97AG_DEPLOY_IDENTITY_AND_PARSE=PASS"

"$PYTHON" - "$BASE" "$INNER" "$PRIVATE_ZIP" <<'PY'
from pathlib import Path
import hashlib, os, sys
src=Path(sys.argv[1])
dst=Path(sys.argv[2])
private_zip=sys.argv[3]
text=src.read_text(encoding='utf-8')
old_critical={
'VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip"':1,
'D97AG_ZIP_BYTES="751494420"':1,
'D97AG_ZIP_SHA256="d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846"':1,
'D97AG_EXE_BYTES="6596544"':1,
'D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"':1,
'D97AF_EXE_BYTES="6595600"':1,
'D97AF_EXE_SHA256="ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470"':1,
}
for needle,expected in old_critical.items():
    actual=text.count(needle)
    print('D97AH_DEPLOY_V5_BASE_CRITICAL_COUNT='+str(actual)+'|'+needle.split('=')[0])
    if actual!=expected:
        raise SystemExit('BASE_CRITICAL_CARDINALITY:'+needle+':'+str(actual))
placeholder='__OCLP7_PREIMAGE_ROLE_OLD__'
if placeholder in text:
    raise SystemExit('PLACEHOLDER_COLLISION')
text=text.replace('D97AF',placeholder)
text=text.replace('D97AG','D97AH')
text=text.replace(placeholder,'D97AG')
replacements={
'VERIFIED_ZIP="$HOME/Desktop/OCLP7_D97AH_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip"':f'VERIFIED_ZIP="{private_zip}"',
'D97AH_ZIP_BYTES="751494420"':'D97AH_ZIP_BYTES="751494634"',
'D97AH_ZIP_SHA256="d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846"':'D97AH_ZIP_SHA256="d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48"',
'D97AH_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"':'D97AH_EXE_SHA256="207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf"',
'D97AG_EXE_BYTES="6595600"':'D97AG_EXE_BYTES="6596544"',
'D97AG_EXE_SHA256="ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470"':'D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"',
}
for old,new in replacements.items():
    actual=text.count(old)
    print('D97AH_DEPLOY_V5_IDENTITY_REPLACEMENT_PRE_COUNT='+str(actual)+'|'+old.split('=')[0])
    if actual!=1:
        raise SystemExit('IDENTITY_REPLACEMENT_CARDINALITY:'+old+':'+str(actual))
    text=text.replace(old,new,1)
required={
f'VERIFIED_ZIP="{private_zip}"':1,
'D97AH_ZIP_BYTES="751494634"':1,
'D97AH_ZIP_SHA256="d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48"':1,
'D97AH_EXE_BYTES="6596544"':1,
'D97AH_EXE_SHA256="207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf"':1,
'D97AG_EXE_BYTES="6596544"':1,
'D97AG_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"':1,
'PURPOSE=verify_local_D97AH_zip_backup_exact_D97AG_deploy_exact_D97AH_open_STOP':1,
'OpenCore-Patcher.app.D97AG-before-D97AH-':1,
'OpenCore-Patcher.app.D97AH-deploying-':3,
'D97AH_DEPLOYED_EXACT_OPENED':2,
'INSTALLED_APP_MUTATION_STATE="D97AH_DEPLOYED_EXACT_OPENED"':1,
}
for needle,expected in required.items():
    actual=text.count(needle)
    print('D97AH_DEPLOY_V5_POST_REQUIRED_COUNT='+str(actual)+'|'+needle[:80])
    if actual!=expected:
        raise SystemExit('POST_REQUIRED_CARDINALITY:'+needle+':'+str(actual))
for forbidden in (
'D97AF',
'33696449978',
'd6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846',
'ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470',
):
    if forbidden in text:
        raise SystemExit('FORBIDDEN_REMAINS:'+forbidden)
semantic_needles=(
'===== VERIFY EXACT LIVE D97AG PREIMAGE =====',
'D97AG_LIVE_PREIMAGE=PASS',
'===== SUDO GATE / PREPARE EXACT D97AH BESIDE LIVE =====',
'D97AH_NEW_APP_READY_EXACT=PASS',
'D97AH_LIVE_APP_IDENTITY=PASS',
'D97AH_EXACT_APP_DEPLOY_OPEN_STOP=PASS',
'INSTALLED_APP_MUTATION_STATE="D97AH_DEPLOYED_EXACT_OPENED"',
'STOP=OCLP_OPEN_DO_NOT_CLICK_ROOT_PATCH_RETURN_COMPLETE_TERMINAL_OUTPUT',
)
for needle in semantic_needles:
    if needle not in text:
        raise SystemExit('SEMANTIC_MARKER_MISSING:'+needle)
out=text.encode('utf-8')
with dst.open('xb') as f:
    f.write(out); f.flush(); os.fsync(f.fileno())
os.chmod(dst,0o700)
print('D97AH_DEPLOY_V5_EXACT_ROLE_IDENTITY_AND_PRIVATE_SOURCE_TRANSFORM=PASS')
print('D97AH_DEPLOY_V5_INNER_SHA256='+hashlib.sha256(out).hexdigest())
print('D97AH_DEPLOY_V5_INNER_BYTES='+str(len(out)))
PY

[[ -f "$INNER" && ! -L "$INNER" && -x "$INNER" ]] || fail "INNER_INVALID"
/bin/zsh -n "$INNER" || fail "INNER_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_V5_INNER_LOCAL_PARSE=PASS"
echo "D97AH_DEPLOY_V5_READY_TO_EXECUTE_INNER=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$INNER"

echo "D97AH_DEPLOY_V5=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT_BEFORE_ROOT_PATCH"
