#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="d926fbb736198409931e6bee13aeb3da896dcd73"
BASE_BLOB="7f11298c46a43c15d2ac1a77d80fd05d4e1e2f08"
BASE_NAME="OCLP7_D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"

TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_AUDIT_V2.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_AUDIT_V2.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_AUDIT_V2=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"
[[ -x /usr/bin/cmp ]] || fail "USR_BIN_CMP_NOT_EXECUTABLE"
[[ ! -e /bin/cmp && ! -L /bin/cmp ]] || fail "BIN_CMP_UNEXPECTEDLY_EXISTS"

echo "===== OCLP7 D97AH — ASUS2 PRIVATE RELEASE AUDIT V2 ====="
echo "PURPOSE=pin_old_audit_wrapper_replace_exact_cmp_line_only_run_full_audit_STOP"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_EXPECTED_BLOB=$BASE_BLOB"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
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
BASE_SHA256="$(/usr/bin/shasum -a 256 "$BASE" | /usr/bin/awk '{print $1}')"
BASE_BYTES="$(/usr/bin/stat -f '%z' "$BASE")"

echo "BASE_ACTUAL_BLOB=$BASE_ACTUAL_BLOB"
echo "BASE_SHA256=$BASE_SHA256"
echo "BASE_BYTES=$BASE_BYTES"
[[ "$BASE_ACTUAL_BLOB" == "$BASE_BLOB" ]] || fail "BASE_WRAPPER_BLOB_MISMATCH"

"$PYTHON" - "$BASE" "$PATCHED" <<'PY'
from pathlib import Path
import hashlib, os, sys
src=Path(sys.argv[1]); dst=Path(sys.argv[2])
text=src.read_text(encoding='utf-8')
old='/bin/cmp -s "$REPORT_EXE" "$APP_EXE" || fail "REPORT_AND_APP_EXECUTABLE_DIFFER"'
new='/usr/bin/cmp -s "$REPORT_EXE" "$APP_EXE" || fail "REPORT_AND_APP_EXECUTABLE_DIFFER"'
lines=text.splitlines(keepends=True)
old_idx=[i for i,line in enumerate(lines) if line.rstrip('\r\n') == old]
new_pre=[i for i,line in enumerate(lines) if line.rstrip('\r\n') == new]
print('D97AH_AUDIT_V2_EXACT_OLD_CMP_LINE_PRE_COUNT='+str(len(old_idx)))
print('D97AH_AUDIT_V2_EXACT_NEW_CMP_LINE_PRE_COUNT='+str(len(new_pre)))
if len(old_idx)!=1: raise SystemExit('D97AH_AUDIT_V2_OLD_CMP_LINE_CARDINALITY')
if len(new_pre)!=0: raise SystemExit('D97AH_AUDIT_V2_NEW_CMP_LINE_ALREADY_PRESENT')
i=old_idx[0]
ending='\n' if lines[i].endswith('\n') else ''
if lines[i].endswith('\r\n'): ending='\r\n'
lines[i]=new+ending
out=''.join(lines)
post=out.splitlines()
old_post=sum(1 for line in post if line==old)
new_post=sum(1 for line in post if line==new)
print('D97AH_AUDIT_V2_EXACT_OLD_CMP_LINE_POST_COUNT='+str(old_post))
print('D97AH_AUDIT_V2_EXACT_NEW_CMP_LINE_POST_COUNT='+str(new_post))
if old_post!=0 or new_post!=1: raise SystemExit('D97AH_AUDIT_V2_POST_CMP_LINE_CARDINALITY')
data=out.encode('utf-8')
with dst.open('xb') as f:
    f.write(data); f.flush(); os.fsync(f.fileno())
os.chmod(dst,0o700)
print('D97AH_AUDIT_V2_EXACT_ONE_LINE_TRANSFORM=PASS')
print('D97AH_AUDIT_V2_PATCHED_SHA256='+hashlib.sha256(data).hexdigest())
print('D97AH_AUDIT_V2_PATCHED_BYTES='+str(len(data)))
PY

/bin/zsh -n "$PATCHED" || fail "PATCHED_WRAPPER_ZSH_PARSE_FAILED"
echo "D97AH_AUDIT_V2_PATCHED_WRAPPER_LOCAL_PARSE=PASS"
echo "D97AH_AUDIT_V2_TRANSFORM=EXACT_ONE_LINE_/bin/cmp_TO_/usr/bin/cmp"

/bin/zsh -f "$PATCHED"

echo "D97AH_AUDIT_V2=PASS"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
