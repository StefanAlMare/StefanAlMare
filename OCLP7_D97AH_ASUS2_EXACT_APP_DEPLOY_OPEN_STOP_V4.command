#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="fe47aa9c06bd416d387e3f64a137b18d471479c1"
BASE_BLOB="55304b6e3db1d1d9ab4e86b7e3b9aa154a744567"
BASE_SHA256="9e8d15eb78974053ae7a5a831062f2d0ce0d02677037035455088c967f160cab"
BASE_BYTES="7779"
BASE_NAME="OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"

TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_DEPLOY_V4_WRAPPER.XXXXXX)"
BASE="$TMP/base.command"
PATCHED="$TMP/patched.command"

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_DEPLOY_V4_WRAPPER.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_DEPLOY_V4_WRAPPER=FAIL_CLOSED|REASON=$1"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    exit 2
}

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"

echo "===== OCLP7 D97AH — DEPLOY V4 PUBLIC PINNED WRAPPER ====="
echo "PURPOSE=pin_D97AH_deploy_v1_apply_exact_three_validator_corrections_execute_full_deploy_open_STOP"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_EXPECTED_BLOB=$BASE_BLOB"
echo "BASE_EXPECTED_SHA256=$BASE_SHA256"
echo "BASE_EXPECTED_BYTES=$BASE_BYTES"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/usr/bin/curl -fL "$BASE_URL" -o "$BASE" || fail "BASE_DOWNLOAD_FAILED"

ACTUAL_BLOB="$("$PYTHON" - "$BASE" <<'PY'
import hashlib,sys
from pathlib import Path
d=Path(sys.argv[1]).read_bytes()
print(hashlib.sha1(b'blob '+str(len(d)).encode()+b'\0'+d).hexdigest())
PY
)"
ACTUAL_SHA256="$(/usr/bin/shasum -a 256 "$BASE" | /usr/bin/awk '{print $1}')"
ACTUAL_BYTES="$(/usr/bin/stat -f '%z' "$BASE")"

echo "BASE_ACTUAL_BLOB=$ACTUAL_BLOB"
echo "BASE_ACTUAL_SHA256=$ACTUAL_SHA256"
echo "BASE_ACTUAL_BYTES=$ACTUAL_BYTES"
[[ "$ACTUAL_BLOB" == "$BASE_BLOB" ]] || fail "BASE_BLOB_MISMATCH"
[[ "$ACTUAL_SHA256" == "$BASE_SHA256" ]] || fail "BASE_SHA256_MISMATCH"
[[ "$ACTUAL_BYTES" == "$BASE_BYTES" ]] || fail "BASE_BYTES_MISMATCH"
/bin/zsh -n "$BASE" || fail "BASE_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_V4_BASE_IDENTITY_AND_PARSE=PASS"

"$PYTHON" - "$BASE" "$PATCHED" <<'PY'
from pathlib import Path
import hashlib,os,sys
src=Path(sys.argv[1]); dst=Path(sys.argv[2])
text=src.read_text(encoding='utf-8')
original=text.splitlines(keepends=True)
lines=list(original)
fixes=[
("placeholder='__OCLP7_PREIMAGE_ROLE_D97AG__'","placeholder='__OCLP7_PREIMAGE_ROLE_OLD__'","PLACEHOLDER"),
("    'OpenCore-Patcher.app.D97AH-deploying-': 2,","    'OpenCore-Patcher.app.D97AH-deploying-': 3,","DEPLOYING_CARDINALITY"),
("    'INSTALLED_APP_MUTATION_STATE=D97AH_DEPLOYED_EXACT_OPENED',","    'INSTALLED_APP_MUTATION_STATE=\"D97AH_DEPLOYED_EXACT_OPENED\"',","FINAL_STATE_MARKER"),
]
for old,new,label in fixes:
    old_hits=[i for i,line in enumerate(lines) if line.rstrip('\r\n')==old]
    new_hits=[i for i,line in enumerate(lines) if line.rstrip('\r\n')==new]
    print(f'D97AH_DEPLOY_V4_{label}_OLD_PRE_COUNT={len(old_hits)}')
    print(f'D97AH_DEPLOY_V4_{label}_NEW_PRE_COUNT={len(new_hits)}')
    if len(old_hits)!=1: raise SystemExit(f'{label}_OLD_CARDINALITY:{len(old_hits)}')
    if len(new_hits)!=0: raise SystemExit(f'{label}_NEW_ALREADY_PRESENT:{len(new_hits)}')
    i=old_hits[0]
    ending='\r\n' if lines[i].endswith('\r\n') else ('\n' if lines[i].endswith('\n') else '')
    lines[i]=new+ending
out_text=''.join(lines)
out_lines=out_text.splitlines()
for old,new,label in fixes:
    old_post=sum(line==old for line in out_lines)
    new_post=sum(line==new for line in out_lines)
    print(f'D97AH_DEPLOY_V4_{label}_OLD_POST_COUNT={old_post}')
    print(f'D97AH_DEPLOY_V4_{label}_NEW_POST_COUNT={new_post}')
    if old_post!=0 or new_post!=1: raise SystemExit(f'{label}_POST_CARDINALITY')
if len(lines)!=len(original): raise SystemExit('LINE_COUNT_CHANGED')
changed=[i+1 for i,(a,b) in enumerate(zip(original,lines)) if a!=b]
print('D97AH_DEPLOY_V4_CHANGED_LINE_COUNT='+str(len(changed)))
print('D97AH_DEPLOY_V4_CHANGED_LINES='+','.join(map(str,changed)))
if len(changed)!=3: raise SystemExit('NOT_EXACTLY_THREE_CHANGED_LINES')
out=out_text.encode('utf-8')
with dst.open('xb') as f:
    f.write(out); f.flush(); os.fsync(f.fileno())
os.chmod(dst,0o700)
print('D97AH_DEPLOY_V4_EXACT_THREE_VALIDATOR_LINES=PASS')
print('D97AH_DEPLOY_V4_PATCHED_SHA256='+hashlib.sha256(out).hexdigest())
print('D97AH_DEPLOY_V4_PATCHED_BYTES='+str(len(out)))
PY

PATCHED_SHA256="$(/usr/bin/shasum -a 256 "$PATCHED" | /usr/bin/awk '{print $1}')"
PATCHED_BYTES="$(/usr/bin/stat -f '%z' "$PATCHED")"
echo "D97AH_DEPLOY_V4_PATCHED_SHA256_OUTER=$PATCHED_SHA256"
echo "D97AH_DEPLOY_V4_PATCHED_BYTES_OUTER=$PATCHED_BYTES"
[[ "$PATCHED_SHA256" == "8ba432e8dd1ac42de85213db1752eecdb7bb5fd823bb93fbfb054ae7857d90ad" ]] || fail "PATCHED_V4_SHA256_MISMATCH"
[[ "$PATCHED_BYTES" == "7779" ]] || fail "PATCHED_V4_BYTES_MISMATCH"
/bin/zsh -n "$PATCHED" || fail "PATCHED_ZSH_PARSE_FAILED"
echo "D97AH_DEPLOY_V4_PATCHED_LOCAL_PARSE=PASS"
echo "D97AH_DEPLOY_V4_READY_TO_EXECUTE_FULL_PINNED_FLOW=PASS"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AH_DEPLOY_V4_WRAPPER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT_BEFORE_ROOT_PATCH"
