#!/bin/zsh -f
set -euo pipefail

REPO="StefanAlMare/Private-Work"
TAG="oclp7-d97ah-run-33769927671-attempt-1"
RELEASE_ID="382116519"
HEAD_SHA="d04ddd28c784a0b30c6629feeface10804d5d591"
RUN_ID="33769927671"

APP_ZIP_BYTES="751494634"
APP_ZIP_SHA="d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48"
EXE_BYTES="6596544"
EXE_SHA="207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf"

PART0="OCLP7-D97AH-OpenCore-Patcher.app.zip.part-00"
PART0_BYTES="390000000"
PART0_SHA="bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5"
PART1="OCLP7-D97AH-OpenCore-Patcher.app.zip.part-01"
PART1_BYTES="361494634"
PART1_SHA="8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e"
MANIFEST="D97AH_SPLIT_MANIFEST.env"
MANIFEST_BYTES="829"
MANIFEST_SHA="2997451ebf1a1b16e7425e897c06e03c9b8dc81d2080e2e247e61a7903518ddd"
PART_SUMS="PARTS.SHA256"
PART_SUMS_BYTES="222"
PART_SUMS_SHA="ec7dfa09ad14a7c6e9f8c79d9cc8e630a5ff16b9b1c128b6090b61d0b4cb5799"
REPORTS_ZIP="OCLP7-D97AH-REPORTS.zip"
REPORTS_ZIP_BYTES="6515462"
REPORTS_ZIP_SHA="54d382b74aabd02ceba0fcb62a0489ba9f93f95932657a75f8ecc1652f0428d5"
RELEASE_IDENTITY="OCLP7_D97AH_RELEASE_ASSET_IDENTITY.txt"
RELEASE_IDENTITY_BYTES="776"
RELEASE_IDENTITY_SHA="3a5b6cca6e01c4c8b8fa6c084b223ae277737d74c38a89a7053502f4c23f8114"
RELEASE_SUMS="RELEASE-ASSETS.SHA256"
RELEASE_SUMS_BYTES="587"
RELEASE_SUMS_SHA="92307b80c3fdb1063bb212a5a1b780e8cebe74b3ec69b0dd106b617ec99ae61f"

STAMP="$(/bin/date +%Y%m%d-%H%M%S)-$$"
TMP="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AH_RELEASE_AUDIT.XXXXXX)"
DL="$TMP/assets"
APP_EXTRACT="$TMP/app-extract"
REPORT_EXTRACT="$TMP/report-extract"
REASSEMBLED="$TMP/OCLP7-D97AH-OpenCore-Patcher.app.zip"
REPORT="$HOME/Desktop/OCLP7_D97AH_ASUS2_PRIVATE_RELEASE_AUDIT_REPORT_$STAMP.txt"
VERIFIED="$HOME/Desktop/OCLP7_D97AH_VERIFIED_RUN${RUN_ID}_OpenCore-Patcher.app.zip"
mkdir -m 700 "$DL" "$APP_EXTRACT" "$REPORT_EXTRACT"

exec > >(/usr/bin/tee "$REPORT") 2>&1

cleanup() {
    local rc=$?
    trap - EXIT
    if [[ -n "${TMP:-}" && "$TMP" == /private/tmp/OCLP7_D97AH_RELEASE_AUDIT.* && -d "$TMP" ]]; then
        /bin/rm -rf -- "$TMP" || true
    fi
    exit "$rc"
}
trap cleanup EXIT

fail() {
    echo "D97AH_ASUS2_PRIVATE_RELEASE_AUDIT=FAIL_CLOSED|REASON=$1"
    echo "SOURCE_MUTATION=NO"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "GOLDEN_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    echo "REPORT=$REPORT"
    exit 2
}

sha() {
    /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

bytes() {
    /usr/bin/stat -f '%z' "$1"
}

echo "===== OCLP7 D97AH — ASUS2 PRIVATE RELEASE ARTIFACT / REASSEMBLY AUDIT ====="
echo "PURPOSE=download_exact_private_release_verify_reassemble_compare_reports_retain_verified_zip_STOP"
echo "REPOSITORY=$REPO"
echo "RELEASE_TAG=$TAG"
echo "RELEASE_ID_EXPECTED=$RELEASE_ID"
echo "RELEASE_TARGET_HEAD_EXPECTED=$HEAD_SHA"
echo "VERIFIED_APP_ZIP=$VERIFIED"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

GH="$(command -v gh 2>/dev/null || true)"
[[ -n "$GH" && -x "$GH" ]] || fail "GH_MISSING"
PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$PYTHON" && -x "$PYTHON" ]] || fail "PYTHON3_MISSING"
[[ -x /usr/bin/unzip ]] || fail "UNZIP_MISSING"
[[ -x /usr/bin/ditto ]] || fail "DITTO_MISSING"
[[ -x /usr/bin/lipo ]] || fail "LIPO_MISSING"
[[ -x /usr/bin/file ]] || fail "FILE_MISSING"

"$GH" auth status -h github.com >/dev/null 2>&1 || fail "GITHUB_AUTH_INVALID"
LOGIN="$("$GH" api user --jq .login 2>/dev/null || true)"
[[ "$LOGIN" == "StefanAlMare" ]] || fail "GITHUB_LOGIN_MISMATCH:$LOGIN"
echo "ACTIVE_GITHUB_LOGIN=$LOGIN"

FREE_KB="$(/bin/df -Pk /private/tmp | /usr/bin/awk 'NR==2 {print $4}')"
echo "TEMP_VOLUME_FREE_KB=$FREE_KB"
[[ "$FREE_KB" -ge 3145728 ]] || fail "INSUFFICIENT_TEMP_SPACE"

RELEASE_JSON="$TMP/release.json"
"$GH" api "repos/$REPO/releases/tags/$TAG" > "$RELEASE_JSON" || fail "RELEASE_API_FAILED"

"$PYTHON" - "$RELEASE_JSON" <<'PY'
from __future__ import annotations
import json, sys
from pathlib import Path

p = json.loads(Path(sys.argv[1]).read_text())
expected = {
    'D97AH_SPLIT_MANIFEST.env': (542931721, 829, 'sha256:2997451ebf1a1b16e7425e897c06e03c9b8dc81d2080e2e247e61a7903518ddd'),
    'OCLP7-D97AH-OpenCore-Patcher.app.zip.part-00': (542931717, 390000000, 'sha256:bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5'),
    'OCLP7-D97AH-OpenCore-Patcher.app.zip.part-01': (542931727, 361494634, 'sha256:8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e'),
    'OCLP7-D97AH-REPORTS.zip': (542931720, 6515462, 'sha256:54d382b74aabd02ceba0fcb62a0489ba9f93f95932657a75f8ecc1652f0428d5'),
    'OCLP7_D97AH_RELEASE_ASSET_IDENTITY.txt': (542931733, 776, 'sha256:3a5b6cca6e01c4c8b8fa6c084b223ae277737d74c38a89a7053502f4c23f8114'),
    'PARTS.SHA256': (542931718, 222, 'sha256:ec7dfa09ad14a7c6e9f8c79d9cc8e630a5ff16b9b1c128b6090b61d0b4cb5799'),
    'RELEASE-ASSETS.SHA256': (542931734, 587, 'sha256:92307b80c3fdb1063bb212a5a1b780e8cebe74b3ec69b0dd106b617ec99ae61f'),
}
if p.get('id') != 382116519:
    raise SystemExit('RELEASE_ID_MISMATCH')
if p.get('tag_name') != 'oclp7-d97ah-run-33769927671-attempt-1':
    raise SystemExit('RELEASE_TAG_MISMATCH')
if p.get('target_commitish') != 'd04ddd28c784a0b30c6629feeface10804d5d591':
    raise SystemExit('RELEASE_HEAD_MISMATCH')
if p.get('draft') is not False or p.get('prerelease') is not False:
    raise SystemExit('RELEASE_STATE_MISMATCH')
assets = p.get('assets') or []
if len(assets) != 7:
    raise SystemExit('RELEASE_ASSET_COUNT_MISMATCH:' + str(len(assets)))
seen = {}
for a in assets:
    n = a.get('name')
    if n in seen:
        raise SystemExit('DUPLICATE_RELEASE_ASSET:' + str(n))
    seen[n] = a
if set(seen) != set(expected):
    raise SystemExit('RELEASE_ASSET_SET_MISMATCH:' + repr(sorted(seen)))
for n, (aid, size, digest) in expected.items():
    a = seen[n]
    if a.get('id') != aid or a.get('size') != size or a.get('digest') != digest or a.get('state') != 'uploaded':
        raise SystemExit('RELEASE_ASSET_METADATA_MISMATCH:' + n)
    print(f'RELEASE_ASSET={aid}|{n}|BYTES={size}|DIGEST={digest}')
print('D97AH_RELEASE_API_BINDING_AND_ASSET_SET=PASS')
PY

echo "RELEASE_ID_ACTUAL=$RELEASE_ID"
echo "RELEASE_TARGET_HEAD_ACTUAL=$HEAD_SHA"

"$GH" release download "$TAG" --repo "$REPO" --dir "$DL" || fail "RELEASE_DOWNLOAD_FAILED"

"$PYTHON" - "$DL" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
expected = {
'D97AH_SPLIT_MANIFEST.env',
'OCLP7-D97AH-OpenCore-Patcher.app.zip.part-00',
'OCLP7-D97AH-OpenCore-Patcher.app.zip.part-01',
'OCLP7-D97AH-REPORTS.zip',
'OCLP7_D97AH_RELEASE_ASSET_IDENTITY.txt',
'PARTS.SHA256',
'RELEASE-ASSETS.SHA256',
}
items = list(root.iterdir())
if len(items) != 7 or {p.name for p in items} != expected:
    raise SystemExit('DOWNLOADED_ASSET_SET_MISMATCH:' + repr(sorted(p.name for p in items)))
for p in items:
    if p.is_symlink() or not p.is_file():
        raise SystemExit('DOWNLOADED_ASSET_NOT_REGULAR:' + p.name)
print('D97AH_DOWNLOADED_RELEASE_ASSET_SET=PASS')
PY

verify_asset() {
    local name="$1" expected_bytes="$2" expected_sha="$3"
    local p="$DL/$name"
    [[ -f "$p" && ! -L "$p" ]] || fail "ASSET_NOT_REGULAR:$name"
    local actual_bytes actual_sha
    actual_bytes="$(bytes "$p")"
    actual_sha="$(sha "$p")"
    echo "DOWNLOADED_ASSET=$name|BYTES=$actual_bytes|SHA256=$actual_sha"
    [[ "$actual_bytes" == "$expected_bytes" ]] || fail "ASSET_BYTES_MISMATCH:$name"
    [[ "$actual_sha" == "$expected_sha" ]] || fail "ASSET_SHA_MISMATCH:$name"
}

verify_asset "$PART0" "$PART0_BYTES" "$PART0_SHA"
verify_asset "$PART1" "$PART1_BYTES" "$PART1_SHA"
verify_asset "$MANIFEST" "$MANIFEST_BYTES" "$MANIFEST_SHA"
verify_asset "$PART_SUMS" "$PART_SUMS_BYTES" "$PART_SUMS_SHA"
verify_asset "$REPORTS_ZIP" "$REPORTS_ZIP_BYTES" "$REPORTS_ZIP_SHA"
verify_asset "$RELEASE_IDENTITY" "$RELEASE_IDENTITY_BYTES" "$RELEASE_IDENTITY_SHA"
verify_asset "$RELEASE_SUMS" "$RELEASE_SUMS_BYTES" "$RELEASE_SUMS_SHA"
echo "D97AH_DOWNLOADED_RELEASE_ASSET_IDENTITIES=PASS"

(
    cd "$DL"
    /usr/bin/shasum -a 256 -c "$RELEASE_SUMS"
) || fail "RELEASE_ASSETS_CHECKSUM_SET_FAILED"
echo "D97AH_RELEASE_ASSETS_CHECKSUM_SET=PASS"

(
    cd "$DL"
    /usr/bin/shasum -a 256 -c "$PART_SUMS"
) || fail "PARTS_CHECKSUM_SET_FAILED"
echo "D97AH_PARTS_CHECKSUM_SET=PASS"

"$PYTHON" - "$DL/$MANIFEST" "$DL/$RELEASE_IDENTITY" <<'PY'
from pathlib import Path
import sys

def env(path):
    out={}
    for line in Path(path).read_text().splitlines():
        if not line or '=' not in line: continue
        k,v=line.split('=',1)
        if k in out: raise SystemExit('DUPLICATE_KEY:'+k)
        out[k]=v
    return out
m=env(sys.argv[1]); r=env(sys.argv[2])
expected_manifest={
'D97AH_ORIGINAL_NAME':'OCLP7-D97AH-OpenCore-Patcher.app.zip',
'D97AH_ORIGINAL_BYTES':'751494634',
'D97AH_ORIGINAL_SHA256':'d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48',
'D97AH_PART_COUNT':'2',
'D97AH_PART_00_NAME':'OCLP7-D97AH-OpenCore-Patcher.app.zip.part-00',
'D97AH_PART_00_BYTES':'390000000',
'D97AH_PART_00_SHA256':'bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5',
'D97AH_PART_01_NAME':'OCLP7-D97AH-OpenCore-Patcher.app.zip.part-01',
'D97AH_PART_01_BYTES':'361494634',
'D97AH_PART_01_SHA256':'8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e',
'GITHUB_REPOSITORY':'StefanAlMare/Private-Work',
'GITHUB_RUN_ID':'33769927671',
'GITHUB_RUN_ATTEMPT':'1',
'GITHUB_HEAD_SHA':'d04ddd28c784a0b30c6629feeface10804d5d591',
'SYSTEM_TARGET_MUTATION':'NO',
'GOLDEN_MUTATION':'NO',
'ROOT_PATCH':'AUTO-NO',
'REBOOT':'AUTO-NO',
}
for k,v in expected_manifest.items():
    if m.get(k) != v: raise SystemExit('SPLIT_MANIFEST_MISMATCH:'+k+':'+repr(m.get(k))+':'+repr(v))
expected_release={
'D97AH_RELEASE_BUILD_HEAD':'d04ddd28c784a0b30c6629feeface10804d5d591',
'D97AH_RELEASE_APP_ZIP_BYTES':'751494634',
'D97AH_RELEASE_APP_ZIP_SHA256':'d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48',
'D97AH_RELEASE_PACKAGED_EXE_BYTES':'6596544',
'D97AH_RELEASE_PACKAGED_EXE_SHA256':'207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf',
'D97AH_RELEASE_PART00_BYTES':'390000000',
'D97AH_RELEASE_PART00_SHA256':'bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5',
'D97AH_RELEASE_PART01_BYTES':'361494634',
'D97AH_RELEASE_PART01_SHA256':'8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e',
'D97AH_RELEASE_REPORTS_ZIP_BYTES':'6515462',
'D97AH_RELEASE_REPORTS_ZIP_SHA256':'54d382b74aabd02ceba0fcb62a0489ba9f93f95932657a75f8ecc1652f0428d5',
'D97AH_CURRENT_RUN_IDENTITY_BINDING':'PASS',
}
for k,v in expected_release.items():
    if r.get(k) != v: raise SystemExit('RELEASE_IDENTITY_MISMATCH:'+k+':'+repr(r.get(k))+':'+repr(v))
print('D97AH_SPLIT_MANIFEST_IDENTITY=PASS')
print('D97AH_RELEASE_IDENTITY_BINDING=PASS')
PY

/bin/cat "$DL/$PART0" "$DL/$PART1" > "$REASSEMBLED" || fail "REASSEMBLY_CAT_FAILED"
RE_BYTES="$(bytes "$REASSEMBLED")"
RE_SHA="$(sha "$REASSEMBLED")"
echo "REASSEMBLED_APP_ZIP_BYTES=$RE_BYTES"
echo "REASSEMBLED_APP_ZIP_SHA256=$RE_SHA"
[[ "$RE_BYTES" == "$APP_ZIP_BYTES" ]] || fail "REASSEMBLED_APP_ZIP_BYTES_MISMATCH"
[[ "$RE_SHA" == "$APP_ZIP_SHA" ]] || fail "REASSEMBLED_APP_ZIP_SHA_MISMATCH"
/usr/bin/unzip -tq "$REASSEMBLED" >/dev/null || fail "REASSEMBLED_APP_ZIP_CRC_FAILED"
echo "D97AH_APP_ZIP_REASSEMBLY_AND_CRC=PASS"

"$PYTHON" - "$REASSEMBLED" <<'PY'
from pathlib import Path, PurePosixPath
import sys, zipfile
p=Path(sys.argv[1])
with zipfile.ZipFile(p) as z:
    names=z.namelist()
    if not names: raise SystemExit('EMPTY_APP_ZIP')
    for raw in names:
        pp=PurePosixPath(raw)
        if pp.is_absolute() or '..' in pp.parts:
            raise SystemExit('UNSAFE_APP_ZIP_MEMBER:'+raw)
    app_members=[n for n in names if n.startswith('OpenCore-Patcher.app/')]
    if not app_members:
        raise SystemExit('APP_BUNDLE_MEMBER_MISSING')
    exe='OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher'
    if names.count(exe)!=1:
        raise SystemExit('APP_EXECUTABLE_MEMBER_CARDINALITY:'+str(names.count(exe)))
print('D97AH_APP_ZIP_SAFE_MEMBER_AUDIT=PASS')
PY

/usr/bin/ditto -x -k "$REASSEMBLED" "$APP_EXTRACT" || fail "APP_ZIP_EXTRACT_FAILED"
APP="$APP_EXTRACT/OpenCore-Patcher.app"
APP_EXE="$APP/Contents/MacOS/OpenCore-Patcher"
[[ -d "$APP" && ! -L "$APP" ]] || fail "EXTRACTED_APP_INVALID"
[[ -f "$APP_EXE" && ! -L "$APP_EXE" ]] || fail "EXTRACTED_EXE_INVALID"
ACTUAL_EXE_BYTES="$(bytes "$APP_EXE")"
ACTUAL_EXE_SHA="$(sha "$APP_EXE")"
ACTUAL_EXE_ARCHS="$(/usr/bin/lipo -archs "$APP_EXE" 2>/dev/null || true)"
echo "PACKAGED_EXE_BYTES=$ACTUAL_EXE_BYTES"
echo "PACKAGED_EXE_SHA256=$ACTUAL_EXE_SHA"
echo "PACKAGED_EXE_ARCHS=$ACTUAL_EXE_ARCHS"
/usr/bin/file "$APP_EXE" | sed 's/^/PACKAGED_EXE_FILE=/'
[[ "$ACTUAL_EXE_BYTES" == "$EXE_BYTES" ]] || fail "PACKAGED_EXE_BYTES_MISMATCH"
[[ "$ACTUAL_EXE_SHA" == "$EXE_SHA" ]] || fail "PACKAGED_EXE_SHA_MISMATCH"
[[ "$ACTUAL_EXE_ARCHS" == "x86_64" ]] || fail "PACKAGED_EXE_ARCH_MISMATCH"
echo "D97AH_PACKAGED_EXECUTABLE_IDENTITY=PASS"

"$PYTHON" - "$DL/$REPORTS_ZIP" <<'PY'
from pathlib import Path, PurePosixPath
import sys, zipfile
p=Path(sys.argv[1])
with zipfile.ZipFile(p) as z:
    names=z.namelist()
    if not names: raise SystemExit('EMPTY_REPORTS_ZIP')
    for raw in names:
        pp=PurePosixPath(raw)
        if pp.is_absolute() or '..' in pp.parts:
            raise SystemExit('UNSAFE_REPORT_ZIP_MEMBER:'+raw)
print('D97AH_REPORTS_ZIP_SAFE_MEMBER_AUDIT=PASS')
PY

/usr/bin/ditto -x -k "$DL/$REPORTS_ZIP" "$REPORT_EXTRACT" || fail "REPORTS_ZIP_EXTRACT_FAILED"
REPORT_ROOT="$REPORT_EXTRACT/reports"
[[ -d "$REPORT_ROOT" && ! -L "$REPORT_ROOT" ]] || fail "REPORTS_ROOT_MISSING"

"$PYTHON" - "$REPORT_ROOT" <<'PY'
from pathlib import Path
import sys
r=Path(sys.argv[1])
expected={
'OCLP7_D97AH_PACKAGED_EXECUTABLE',
'OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt',
'OCLP7_D97AH_PACKAGED_EXECUTABLE_FILE.txt',
'OCLP7_D97AH_PACKAGED_EXECUTABLE_ARCHS.txt',
'OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt',
'OCLP7_D97AH_MANIFEST.env',
'OCLP7_D97AH_SOURCE_CORRECTION.patch',
'OCLP7_D97AH_EXACT_BUILD_DEPENDENCIES.txt',
'OCLP7_D97AH_APP_IDENTITY.txt',
'SHA256SUMS-OCLP7-D97AH.txt',
'PARTS.SHA256',
'D97AH_SPLIT_MANIFEST.env',
'OCLP7_D97AH_REASSEMBLY_AUDIT.txt',
'REPORTS.SHA256',
}
items=[p for p in r.iterdir()]
if {p.name for p in items} != expected or len(items)!=len(expected):
    raise SystemExit('REPORT_FILE_SET_MISMATCH:'+repr(sorted(p.name for p in items)))
for p in items:
    if p.is_symlink() or not p.is_file(): raise SystemExit('REPORT_NOT_REGULAR:'+p.name)
print('D97AH_REPORT_FILE_SET=PASS')
PY

(
    cd "$REPORT_ROOT"
    /usr/bin/shasum -a 256 -c REPORTS.SHA256
) || fail "REPORTS_CHECKSUM_SET_FAILED"
echo "D97AH_REPORTS_CHECKSUM_SET=PASS"

REPORT_EXE="$REPORT_ROOT/OCLP7_D97AH_PACKAGED_EXECUTABLE"
[[ "$(bytes "$REPORT_EXE")" == "$EXE_BYTES" ]] || fail "REPORT_EXE_BYTES_MISMATCH"
[[ "$(sha "$REPORT_EXE")" == "$EXE_SHA" ]] || fail "REPORT_EXE_SHA_MISMATCH"
/bin/cmp -s "$REPORT_EXE" "$APP_EXE" || fail "REPORT_AND_APP_EXECUTABLE_DIFFER"
echo "D97AH_REPORT_AND_APP_EXECUTABLE_BYTE_IDENTITY=PASS"

[[ "$(sha "$REPORT_ROOT/OCLP7_D97AH_SOURCE_CORRECTION.patch")" == "66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c" ]] || fail "REPORT_D97AH_PATCH_SHA_MISMATCH"
[[ "$(bytes "$REPORT_ROOT/OCLP7_D97AH_SOURCE_CORRECTION.patch")" == "1005" ]] || fail "REPORT_D97AH_PATCH_BYTES_MISMATCH"

grep -Fxq 'D97AH_METHOD_BIN_CHFLAGS_COUNT=0' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt" || fail "SOURCE_REPORT_OLD_CHFLAGS_MISSING"
grep -Fxq 'D97AH_METHOD_USR_BIN_CHFLAGS_COUNT=2' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt" || fail "SOURCE_REPORT_NEW_CHFLAGS_MISSING"
grep -Fxq 'D97AH_EXACT_TWO_CHFLAGS_PATHS=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt" || fail "SOURCE_REPORT_CHFLAGS_PASS_MISSING"
grep -Fxq 'D97AH_D97AD_UNCHANGED=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt" || fail "SOURCE_REPORT_D97AD_PASS_MISSING"
grep -Fxq 'D97AH_XATTR_BACKEND_UNCHANGED=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt" || fail "SOURCE_REPORT_XATTR_PASS_MISSING"
grep -Fxq 'D97AH_FATAL_BOUNDARY_UNCHANGED=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_SOURCE_AUDIT_REPORT.txt" || fail "SOURCE_REPORT_FATAL_PASS_MISSING"

grep -Fxq 'PACKAGED_D97AH_BIN_CHFLAGS_CONSTANT_POOL_COUNT=0' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_OLD_CONSTANT_MISSING"
grep -Fxq 'PACKAGED_D97AH_USR_BIN_CHFLAGS_CONSTANT_POOL_COUNT=1' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_NEW_CONSTANT_MISSING"
grep -Fxq 'PACKAGED_D97AH_BIN_CHFLAGS_LOAD_CONST_COUNT=0' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_OLD_LOAD_MISSING"
grep -Fxq 'PACKAGED_D97AH_USR_BIN_CHFLAGS_LOAD_CONST_COUNT=2' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_NEW_LOAD_MISSING"
grep -Fxq 'D97AH_PACKAGED_CHFLAGS_CONSTANT_POOL_DEDUP_AUDIT=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_DEDUP_PASS_MISSING"
grep -Fxq 'D97AH_PACKAGED_THREE_MODULE_SEMANTIC_IDENTITY=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_MODULE_PASS_MISSING"
grep -Fxq 'D97AH_PACKAGED_METHOD_AND_CHFLAGS_IDENTITY=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_METHOD_PASS_MISSING"
grep -Fxq 'D97AH_PACKAGED_XATTR_BACKEND_UNCHANGED=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_XATTR_PASS_MISSING"
grep -Fxq 'OCLP7_D97AH_GITHUB_BUILD_AUDIT=PASS' "$REPORT_ROOT/OCLP7_D97AH_GITHUB_BUILD_AUDIT_REPORT.txt" || fail "BUILD_REPORT_FINAL_PASS_MISSING"

echo "D97AH_REPORT_CONTENT_AUDIT=PASS"

APP_ID="$REPORT_ROOT/OCLP7_D97AH_APP_IDENTITY.txt"
grep -Fxq 'D97AH_APP_ZIP_BYTES=751494634' "$APP_ID" || fail "REPORT_APP_BYTES_MISMATCH"
grep -Fxq 'D97AH_APP_ZIP_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48' "$APP_ID" || fail "REPORT_APP_SHA_MISMATCH"
grep -Fxq 'D97AH_PACKAGED_EXE_BYTES=6596544' "$APP_ID" || fail "REPORT_EXE_BYTES_FIELD_MISMATCH"
grep -Fxq 'D97AH_PACKAGED_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf' "$APP_ID" || fail "REPORT_EXE_SHA_FIELD_MISMATCH"
grep -Fxq 'D97AH_PACKAGED_STATIC_IDENTITY=PASS' "$APP_ID" || fail "REPORT_STATIC_IDENTITY_PASS_MISSING"
echo "D97AH_REPORT_APP_IDENTITY=PASS"

if [[ -e "$VERIFIED" || -L "$VERIFIED" ]]; then
    [[ -f "$VERIFIED" && ! -L "$VERIFIED" ]] || fail "VERIFIED_DEST_EXISTS_NOT_REGULAR"
    EXISTING_BYTES="$(bytes "$VERIFIED")"
    EXISTING_SHA="$(sha "$VERIFIED")"
    [[ "$EXISTING_BYTES" == "$APP_ZIP_BYTES" && "$EXISTING_SHA" == "$APP_ZIP_SHA" ]] || fail "VERIFIED_DEST_PREEXISTS_MISMATCH"
    echo "VERIFIED_APP_ZIP_RETAINED=EXISTING_EXACT"
else
    /bin/cp -p "$REASSEMBLED" "$VERIFIED" || fail "VERIFIED_ZIP_COPY_FAILED"
    [[ -f "$VERIFIED" && ! -L "$VERIFIED" ]] || fail "VERIFIED_DEST_POSTCOPY_INVALID"
    [[ "$(bytes "$VERIFIED")" == "$APP_ZIP_BYTES" ]] || fail "VERIFIED_DEST_BYTES_MISMATCH"
    [[ "$(sha "$VERIFIED")" == "$APP_ZIP_SHA" ]] || fail "VERIFIED_DEST_SHA_MISMATCH"
    echo "VERIFIED_APP_ZIP_RETAINED=NEW_EXACT"
fi

echo "VERIFIED_APP_ZIP=$VERIFIED"
echo "D97AH_ASUS2_PRIVATE_RELEASE_DOWNLOAD=PASS"
echo "D97AH_ASUS2_ARTIFACT_REASSEMBLY=PASS"
echo "D97AH_ASUS2_PACKAGED_EXECUTABLE_IDENTITY=PASS"
echo "D97AH_ASUS2_REPORTS_AUDIT=PASS"
echo "D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=PASS"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT_BEFORE_DEPLOY"
echo "REPORT=$REPORT"
