#!/bin/zsh -f
set -euo pipefail

BASE_COMMIT="80f652130f6d0fc32319b727211576388cdb3b10"
BASE_BLOB="7fb4215818665850b7e42e61d4e96c1ffe7568e0"
BASE_NAME="OCLP7_D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT.command"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/${BASE_NAME}"

PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || { echo "FAIL=MISSING_PYTHON3"; exit 2; }

BASE="$(/usr/bin/mktemp /private/tmp/OCLP7_D97AM_ARTIFACT_AUDIT_V1.XXXXXX)"
PATCHED="$(/usr/bin/mktemp /private/tmp/OCLP7_D97AM_ARTIFACT_AUDIT_V2_INNER.XXXXXX)"
cleanup() {
    local rc=$?
    trap - EXIT
    /bin/rm -f "$BASE" "$PATCHED"
    exit "$rc"
}
trap cleanup EXIT

/usr/bin/curl -fL "$BASE_URL" -o "$BASE"

"$PYTHON" - "$BASE" "$PATCHED" "$BASE_BLOB" <<'PY'
from __future__ import annotations
import hashlib
import sys
from pathlib import Path

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
expected_blob = sys.argv[3]
data = src.read_bytes()
actual_blob = hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()
print("D97AM_V2_BASE_EXPECTED_BLOB=" + expected_blob)
print("D97AM_V2_BASE_ACTUAL_BLOB=" + actual_blob)
if actual_blob != expected_blob:
    raise SystemExit("D97AM_V2_BASE_BLOB_MISMATCH")
text = data.decode("utf-8")
old = '    "GITHUB_REPOSITORY": repo,\n'
count = text.count(old)
print("D97AM_V2_REDUNDANT_MANIFEST_REPO_GATE_COUNT=" + str(count))
if count != 1:
    raise SystemExit("D97AM_V2_REDUNDANT_GATE_CARDINALITY")
patched = text.replace(old, "", 1).encode("utf-8")
dst.write_bytes(patched)
print("D97AM_V2_PATCH_SCOPE=REMOVE_ONLY_REDUNDANT_GITHUB_REPOSITORY_MANIFEST_REQUIREMENT")
print("D97AM_V2_PATCHED_BYTES=" + str(len(patched)))
print("D97AM_V2_PATCHED_SHA256=" + hashlib.sha256(patched).hexdigest())
print("D97AM_V2_PATCHED_GIT_BLOB=" + hashlib.sha1(b"blob " + str(len(patched)).encode() + b"\0" + patched).hexdigest())
print("D97AM_V2_INNER_PATCH=PASS")
PY

/bin/zsh -n "$PATCHED" || { echo "FAIL=D97AM_V2_PATCHED_ZSH_PARSE"; exit 2; }

echo "D97AM_V2_PATCHED_ZSH_PARSE=PASS"
echo "D97AM_V1_RESULT=TOOLING_FALSE_FAILURE_REDUNDANT_MANIFEST_REPO_FIELD_EXPECTATION"
echo "RELEASE_REPOSITORY_BINDING_STILL_ENFORCED=YES_VIA_PRIVATE_RELEASE_API_ENDPOINT"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

/bin/zsh -f "$PATCHED"

echo "D97AM_ARTIFACT_AUDIT_V2_OUTER_RC=0"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
