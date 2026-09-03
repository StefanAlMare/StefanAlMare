#!/bin/zsh -f
set -euo pipefail

REPO="StefanAlMare/Private-Work"
WORKFLOW_ID="348947684"
RUN_ID="33696449978"
JOB_ID="100466229401"
RUN_HEAD_SHA="4bde01b09717d076499ebf3640b5e4c0378798dd"
RUN_HEAD_BRANCH="oclp7-d97ag-github-build"
RUN_WORKFLOW_PATH=".github/workflows/oclp7-d97ag-build.yml"

PART00_ID="9872061067"
PART00_NAME="OCLP7-D97AG-RUN-33696449978-ATTEMPT-1-PART-00"
PART00_OUTER_BYTES="390001616"
PART00_OUTER_SHA256="a3f0426126126a3e71351c645135757f7a89f7cc1a9f9d269e2cb9fdf17b926a"
PART00_PAYLOAD_NAME="OCLP7-D97AG-OpenCore-Patcher.app.zip.part-00"
PART00_PAYLOAD_BYTES="390000000"
PART00_PAYLOAD_SHA256="87189ac03eb044b3d674dddeb091ccafbb4705ac246c26d9f648bba5e66dc60e"

PART01_ID="9872064375"
PART01_NAME="OCLP7-D97AG-RUN-33696449978-ATTEMPT-1-PART-01"
PART01_OUTER_BYTES="361496036"
PART01_OUTER_SHA256="7e167cef69dd9fa602a314ca138b2e94b6f76cf777fc3a65edf73b848fdc0e40"
PART01_PAYLOAD_NAME="OCLP7-D97AG-OpenCore-Patcher.app.zip.part-01"
PART01_PAYLOAD_BYTES="361494420"
PART01_PAYLOAD_SHA256="9952bf53e223fb9688102f18865afdb2ea58fa07362d807da61651e908955d23"

REPORTS_ID="9872066045"
REPORTS_NAME="OCLP7-D97AG-RUN-33696449978-ATTEMPT-1-REPORTS"
REPORTS_OUTER_BYTES="18021887"
REPORTS_OUTER_SHA256="da5b9e2d2a55786c1b6a4f3c64c054779ad73f394578e1a5e07c2bd0fd287217"

APP_ZIP_NAME="OCLP7-D97AG-OpenCore-Patcher.app.zip"
APP_ZIP_BYTES="751494420"
APP_ZIP_SHA256="d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846"
PACKAGED_EXE_BYTES="6596544"
PACKAGED_EXE_SHA256="29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628"
FROZEN_AUDITOR_SHA256="042fbd18f3bae5f0878ee7b5c16dcae26c63b3c21e1492d0c0a857095d140017"
PARTS_SUMS_SHA256="925b5ec65f8a87ac7a8719c714f6556ba80601eefbd8436b322e6ac07d327086"
SPLIT_MANIFEST_SHA256="9db663ff0768d3f22627ba1002f2e000db9f6a939b73b449c792e17bd85b6dfc"
MIN_FREE_KB="3145728"

STAMP="$(/bin/date +%Y%m%d-%H%M%S)"
REPORT="$HOME/Desktop/OCLP7_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_REPORT_$STAMP.txt"
VERIFIED_APP_ZIP="$HOME/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip"
TEMP_ROOT="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AG_AUDIT.XXXXXX)"

cleanup() {
  if [[ "$TEMP_ROOT" == /private/tmp/OCLP7_D97AG_AUDIT.* && -d "$TEMP_ROOT" && ! -L "$TEMP_ROOT" ]]; then
    /bin/rm -rf "$TEMP_ROOT"
  fi
}
trap cleanup EXIT
exec > >(/usr/bin/tee "$REPORT") 2>&1

fail() {
  echo "D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT=FAIL_CLOSED|REASON=$*"
  echo "SOURCE_MUTATION=NO"
  echo "INSTALLED_APP_MUTATION=NO"
  echo "SYSTEM_TARGET_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

for tool_path in /usr/bin/awk /usr/bin/file /usr/bin/id /usr/bin/lipo /usr/bin/mktemp /usr/bin/stat /usr/bin/tee /bin/date /bin/df /bin/rm; do
  [[ -x "$tool_path" ]] || fail "MISSING_ABSOLUTE_TOOL:$tool_path"
done
GH_BIN="$(command -v gh 2>/dev/null || true)"
PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
[[ -n "$GH_BIN" && -x "$GH_BIN" ]] || fail "MISSING_TOOL:gh"
[[ -n "$PYTHON_BIN" && -x "$PYTHON_BIN" ]] || fail "MISSING_TOOL:python3"

TEMP_IDENTITY="$(/usr/bin/stat -f '%u:%Lp:%l' "$TEMP_ROOT")"
[[ "$TEMP_IDENTITY" == "$(/usr/bin/id -u):700:2" ]] || fail "PRIVATE_TEMP_IDENTITY_INVALID:$TEMP_IDENTITY"
ACTIVE_GITHUB_LOGIN="$("$GH_BIN" api user --jq .login)"
[[ "$ACTIVE_GITHUB_LOGIN" == "StefanAlMare" ]] || fail "WRONG_GITHUB_LOGIN:$ACTIVE_GITHUB_LOGIN"
FREE_KB="$(/bin/df -Pk /private/tmp | /usr/bin/awk 'NR==2 {print $4}')"
[[ "$FREE_KB" == <-> ]] || fail "FREE_SPACE_PARSE_FAIL:$FREE_KB"
(( FREE_KB >= MIN_FREE_KB )) || fail "INSUFFICIENT_FREE_SPACE_KB:$FREE_KB"

echo "===== OCLP7 D97AG — ASUS2 EXACT ARTIFACT + PACKAGED-RUNTIME AUDIT ====="
echo "PURPOSE=verify_exact_build_artifacts_reassemble_app_test_frozen_xattr_locally_STOP_before_deploy"
echo "ACTIVE_GITHUB_LOGIN=$ACTIVE_GITHUB_LOGIN"
echo "TEMP_VOLUME_FREE_KB=$FREE_KB"
echo "REPOSITORY=$REPO"
echo "RUN_ID=$RUN_ID"
echo "JOB_ID=$JOB_ID"
echo "RUN_HEAD_SHA=$RUN_HEAD_SHA"
echo "REPORT=$REPORT"
echo "VERIFIED_APP_ZIP=$VERIFIED_APP_ZIP"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

export REPO WORKFLOW_ID RUN_ID JOB_ID RUN_HEAD_SHA RUN_HEAD_BRANCH RUN_WORKFLOW_PATH
export PART00_ID PART00_NAME PART00_OUTER_BYTES PART00_OUTER_SHA256 PART00_PAYLOAD_NAME PART00_PAYLOAD_BYTES PART00_PAYLOAD_SHA256
export PART01_ID PART01_NAME PART01_OUTER_BYTES PART01_OUTER_SHA256 PART01_PAYLOAD_NAME PART01_PAYLOAD_BYTES PART01_PAYLOAD_SHA256
export REPORTS_ID REPORTS_NAME REPORTS_OUTER_BYTES REPORTS_OUTER_SHA256
export APP_ZIP_NAME APP_ZIP_BYTES APP_ZIP_SHA256 PACKAGED_EXE_BYTES PACKAGED_EXE_SHA256 FROZEN_AUDITOR_SHA256
export PARTS_SUMS_SHA256 SPLIT_MANIFEST_SHA256 TEMP_ROOT VERIFIED_APP_ZIP GH_BIN

"$PYTHON_BIN" - <<'PY'
from __future__ import annotations
import hashlib
import json
import os
import shutil
import stat
import subprocess
import sys
import zipfile
from pathlib import Path, PurePosixPath

E = os.environ
root = Path(E['TEMP_ROOT'])
work = root / 'work'
work.mkdir(mode=0o700)
gh = E['GH_BIN']

def die(msg: str):
    raise SystemExit(msg)

def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(8 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()

def gh_json(endpoint: str):
    p = subprocess.run([gh, 'api', endpoint], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p.returncode != 0:
        die('GH_API_JSON_FAIL:' + endpoint + ':' + p.stderr.decode(errors='replace'))
    return json.loads(p.stdout)

def gh_download_artifact(artifact_id: str, path: Path, expected_bytes: int, expected_sha: str):
    with path.open('xb') as out:
        p = subprocess.run([
            gh, 'api',
            '-H', 'Accept: application/vnd.github+json',
            '-H', 'X-GitHub-Api-Version: 2022-11-28',
            f"repos/{E['REPO']}/actions/artifacts/{artifact_id}/zip",
        ], stdout=out, stderr=subprocess.PIPE)
    if p.returncode != 0:
        die('GH_ARTIFACT_DOWNLOAD_FAIL:' + artifact_id + ':' + p.stderr.decode(errors='replace'))
    actual_bytes = path.stat().st_size
    actual_sha = sha256(path)
    print(f'OUTER_ARTIFACT={artifact_id}|BYTES={actual_bytes}|SHA256={actual_sha}')
    if actual_bytes != expected_bytes or actual_sha != expected_sha:
        die('OUTER_ARTIFACT_IDENTITY_MISMATCH:' + artifact_id)
    with zipfile.ZipFile(path) as z:
        bad = z.testzip()
        if bad is not None:
            die('OUTER_ARTIFACT_CRC_FAIL:' + artifact_id + ':' + bad)

def safe_names(z: zipfile.ZipFile):
    names = z.namelist()
    if len(names) != len(set(names)):
        die('ZIP_DUPLICATE_MEMBER')
    for name in names:
        p = PurePosixPath(name)
        if p.is_absolute() or '..' in p.parts or not name:
            die('ZIP_UNSAFE_MEMBER:' + name)
    return names

def copy_member(z: zipfile.ZipFile, name: str, dest: Path):
    infos = [i for i in z.infolist() if i.filename == name]
    if len(infos) != 1:
        die('ZIP_MEMBER_CARDINALITY:' + name + ':' + str(len(infos)))
    mode = (infos[0].external_attr >> 16) & 0o170000
    if mode == stat.S_IFLNK:
        die('ZIP_SYMLINK_MEMBER_REJECTED:' + name)
    dest.parent.mkdir(parents=True, exist_ok=True)
    with z.open(infos[0]) as src, dest.open('xb') as out:
        shutil.copyfileobj(src, out, length=8 * 1024 * 1024)

run = gh_json(f"repos/{E['REPO']}/actions/runs/{E['RUN_ID']}")
job = gh_json(f"repos/{E['REPO']}/actions/jobs/{E['JOB_ID']}")
expected_run = {
    'id': int(E['RUN_ID']), 'workflow_id': int(E['WORKFLOW_ID']),
    'head_sha': E['RUN_HEAD_SHA'], 'head_branch': E['RUN_HEAD_BRANCH'],
    'path': E['RUN_WORKFLOW_PATH'], 'status': 'completed', 'conclusion': 'success',
}
for key, expected in expected_run.items():
    actual = run.get(key)
    print(f'RUN_{key.upper()}={actual}')
    if actual != expected:
        die(f'RUN_IDENTITY_MISMATCH:{key}:{actual!r}:{expected!r}')
expected_job = {'id': int(E['JOB_ID']), 'run_id': int(E['RUN_ID']), 'name': 'build', 'status': 'completed', 'conclusion': 'success'}
for key, expected in expected_job.items():
    actual = job.get(key)
    print(f'JOB_{key.upper()}={actual}')
    if actual != expected:
        die(f'JOB_IDENTITY_MISMATCH:{key}:{actual!r}:{expected!r}')
steps = job.get('steps') or []
if not steps or any(s.get('status') != 'completed' or s.get('conclusion') != 'success' for s in steps):
    die('JOB_STEP_SUCCESS_SET_MISMATCH')
required_steps = {
    'Verify Intel runner and immutable inputs',
    'Reassemble exact D97AD snapshot',
    'Verify and apply exact D97AD to D97AF source transition',
    'Verify and apply exact D97AF to D97AG correction',
    'Build OpenCore-Patcher application',
    'Audit packaged D97AG application',
    'Upload validated D97AG part 00',
    'Upload validated D97AG part 01',
    'Upload validated D97AG reports and audit executable',
}
missing_steps = sorted(required_steps - {s.get('name') for s in steps})
print('JOB_STEP_COUNT=' + str(len(steps)))
print('JOB_REQUIRED_STEPS_MISSING=' + repr(missing_steps))
if missing_steps:
    die('JOB_REQUIRED_STEP_MISSING')

art_specs = [
    ('PART00', E['PART00_ID'], E['PART00_NAME'], int(E['PART00_OUTER_BYTES']), E['PART00_OUTER_SHA256']),
    ('PART01', E['PART01_ID'], E['PART01_NAME'], int(E['PART01_OUTER_BYTES']), E['PART01_OUTER_SHA256']),
    ('REPORTS', E['REPORTS_ID'], E['REPORTS_NAME'], int(E['REPORTS_OUTER_BYTES']), E['REPORTS_OUTER_SHA256']),
]
for label, aid, name, size, digest in art_specs:
    a = gh_json(f"repos/{E['REPO']}/actions/artifacts/{aid}")
    expected = {'id': int(aid), 'name': name, 'size_in_bytes': size, 'digest': 'sha256:' + digest, 'expired': False}
    for key, value in expected.items():
        actual = a.get(key)
        print(f'{label}_{key.upper()}={actual}')
        if actual != value:
            die(f'{label}_METADATA_MISMATCH:{key}:{actual!r}:{value!r}')
    wr = a.get('workflow_run') or {}
    if wr.get('id') != int(E['RUN_ID']) or wr.get('head_sha') != E['RUN_HEAD_SHA']:
        die(label + '_WORKFLOW_BINDING_MISMATCH')
print('D97AG_RUN_JOB_ARTIFACT_METADATA=PASS')

p00_outer = root / 'part00-artifact.zip'
p01_outer = root / 'part01-artifact.zip'
reports_outer = root / 'reports-artifact.zip'
gh_download_artifact(E['PART00_ID'], p00_outer, int(E['PART00_OUTER_BYTES']), E['PART00_OUTER_SHA256'])
gh_download_artifact(E['PART01_ID'], p01_outer, int(E['PART01_OUTER_BYTES']), E['PART01_OUTER_SHA256'])
gh_download_artifact(E['REPORTS_ID'], reports_outer, int(E['REPORTS_OUTER_BYTES']), E['REPORTS_OUTER_SHA256'])

p00_dir, p01_dir, reports_dir = work / 'part00', work / 'part01', work / 'reports'
for d in (p00_dir, p01_dir, reports_dir):
    d.mkdir()
part_common = {'PARTS.SHA256', 'D97AG_SPLIT_MANIFEST.env'}
with zipfile.ZipFile(p00_outer) as z:
    names = set(safe_names(z))
    expected = part_common | {E['PART00_PAYLOAD_NAME']}
    if names != expected:
        die('PART00_MEMBER_SET_MISMATCH:' + repr(sorted(names)))
    for name in expected:
        copy_member(z, name, p00_dir / name)
with zipfile.ZipFile(p01_outer) as z:
    names = set(safe_names(z))
    expected = part_common | {E['PART01_PAYLOAD_NAME']}
    if names != expected:
        die('PART01_MEMBER_SET_MISMATCH:' + repr(sorted(names)))
    for name in expected:
        copy_member(z, name, p01_dir / name)
report_names = {
    'D97AG_SPLIT_MANIFEST.env', 'OCLP7_D97AF_PARENT_SOURCE_TRANSITION.patch',
    'OCLP7_D97AG_APP_IDENTITY.txt', 'OCLP7_D97AF_PARENT_MANIFEST.env',
    'OCLP7_D97AG_EXACT_BUILD_DEPENDENCIES.txt', 'OCLP7_D97AG_FINAL_APP_FROZEN_XATTR_RUNTIME_REPORT.txt',
    'OCLP7_D97AG_FINAL_APP_XATTR_RUNTIME_AUDITOR.py', 'OCLP7_D97AG_FROZEN_AUDITOR_BINARY',
    'OCLP7_D97AG_FROZEN_AUDITOR_FILE.txt', 'OCLP7_D97AG_GITHUB_BUILD_AUDIT_REPORT.txt',
    'OCLP7_D97AG_GITHUB_SOURCE_AUDIT_REPORT.txt', 'OCLP7_D97AG_MANIFEST.env',
    'OCLP7_D97AG_NATIVE_XATTR_CODE_OBJECT_REPORT.txt', 'OCLP7_D97AG_PACKAGED_EXECUTABLE',
    'OCLP7_D97AG_PACKAGED_EXECUTABLE_ARCHS.txt', 'OCLP7_D97AG_PART_ARTIFACT_METADATA.txt',
    'OCLP7_D97AG_PACKAGED_EXECUTABLE_FILE.txt', 'OCLP7_D97AG_REASSEMBLY_AUDIT.txt',
    'OCLP7_D97AG_SOURCE_CORRECTION.patch', 'PARTS.SHA256', 'REPORTS.SHA256',
    'SHA256SUMS-OCLP7-D97AG-AUDITOR-BUILD.txt', 'SHA256SUMS-OCLP7-D97AG-FINAL-RUNTIME-AUDIT.txt',
    'SHA256SUMS-OCLP7-D97AG.txt',
}
with zipfile.ZipFile(reports_outer) as z:
    names = set(safe_names(z))
    if names != report_names:
        die('REPORTS_MEMBER_SET_MISMATCH:' + repr(sorted(names)))
    for name in report_names:
        copy_member(z, name, reports_dir / name)
print('D97AG_OUTER_ARTIFACT_MEMBER_SETS=PASS')

for name, expected_sha in (('PARTS.SHA256', E['PARTS_SUMS_SHA256']), ('D97AG_SPLIT_MANIFEST.env', E['SPLIT_MANIFEST_SHA256'])):
    files = [p00_dir / name, p01_dir / name, reports_dir / name]
    hashes = [sha256(p) for p in files]
    print(f'SHARED_{name}_SHA256S=' + ','.join(hashes))
    if any(h != expected_sha for h in hashes) or not (files[0].read_bytes() == files[1].read_bytes() == files[2].read_bytes()):
        die('SHARED_FILE_IDENTITY_MISMATCH:' + name)

parts_records = {}
for raw in (reports_dir / 'PARTS.SHA256').read_text().splitlines():
    digest, name = raw.split('  ', 1)
    parts_records[name] = digest
expected_parts_records = {E['PART00_PAYLOAD_NAME']: E['PART00_PAYLOAD_SHA256'], E['PART01_PAYLOAD_NAME']: E['PART01_PAYLOAD_SHA256']}
if parts_records != expected_parts_records:
    die('PARTS_SHA256_RECORD_SET_MISMATCH:' + repr(parts_records))

manifest = {}
for raw in (reports_dir / 'D97AG_SPLIT_MANIFEST.env').read_text().splitlines():
    if raw and '=' in raw:
        k, v = raw.split('=', 1); manifest[k] = v
expected_manifest = {
    'D97AG_SPLIT_FORMAT': 'EXACT_TWO_BINARY_PARTS_V1',
    'D97AG_ORIGINAL_NAME': E['APP_ZIP_NAME'], 'D97AG_ORIGINAL_BYTES': E['APP_ZIP_BYTES'],
    'D97AG_ORIGINAL_SHA256': E['APP_ZIP_SHA256'], 'D97AG_PART_COUNT': '2', 'D97AG_CHUNK_BYTES': '390000000',
    'D97AG_PART_00_NAME': E['PART00_PAYLOAD_NAME'], 'D97AG_PART_00_BYTES': E['PART00_PAYLOAD_BYTES'],
    'D97AG_PART_00_SHA256': E['PART00_PAYLOAD_SHA256'], 'D97AG_PART_01_NAME': E['PART01_PAYLOAD_NAME'],
    'D97AG_PART_01_BYTES': E['PART01_PAYLOAD_BYTES'], 'D97AG_PART_01_SHA256': E['PART01_PAYLOAD_SHA256'],
    'GITHUB_REPOSITORY': E['REPO'], 'GITHUB_RUN_ID': E['RUN_ID'], 'GITHUB_RUN_ATTEMPT': '1', 'GITHUB_HEAD_SHA': E['RUN_HEAD_SHA'],
    'SYSTEM_TARGET_MUTATION': 'NO', 'GOLDEN_MUTATION': 'NO', 'ROOT_PATCH': 'AUTO-NO', 'REBOOT': 'AUTO-NO',
}
for key, expected in expected_manifest.items():
    if manifest.get(key) != expected:
        die(f'SPLIT_MANIFEST_MISMATCH:{key}:{manifest.get(key)!r}:{expected!r}')
print('D97AG_SHARED_SPLIT_MANIFEST_AND_PART_SUMS=PASS')

report_records = {}
for raw in (reports_dir / 'REPORTS.SHA256').read_text().splitlines():
    digest, name = raw.split('  ', 1)
    if name in report_records:
        die('REPORT_SHA_DUPLICATE:' + name)
    report_records[name] = digest
if set(report_records) != report_names - {'REPORTS.SHA256'}:
    die('REPORT_SHA_RECORD_SET_MISMATCH')
for name, expected in report_records.items():
    actual = sha256(reports_dir / name)
    if actual != expected:
        die(f'REPORT_SHA_MISMATCH:{name}:{actual}:{expected}')
print('D97AG_REPORTS_CHECKSUM_SET=PASS')

parts = [
    (p00_dir / E['PART00_PAYLOAD_NAME'], int(E['PART00_PAYLOAD_BYTES']), E['PART00_PAYLOAD_SHA256']),
    (p01_dir / E['PART01_PAYLOAD_NAME'], int(E['PART01_PAYLOAD_BYTES']), E['PART01_PAYLOAD_SHA256']),
]
for path, expected_bytes, expected_sha in parts:
    actual_bytes, actual_sha = path.stat().st_size, sha256(path)
    print(f'PART_PAYLOAD={path.name}|BYTES={actual_bytes}|SHA256={actual_sha}')
    if actual_bytes != expected_bytes or actual_sha != expected_sha:
        die('PART_PAYLOAD_IDENTITY_MISMATCH:' + path.name)
app_zip = work / E['APP_ZIP_NAME']
with app_zip.open('xb') as out:
    for path, _, _ in parts:
        with path.open('rb') as src:
            shutil.copyfileobj(src, out, length=8 * 1024 * 1024)
actual_bytes, actual_sha = app_zip.stat().st_size, sha256(app_zip)
print('REASSEMBLED_APP_ZIP_BYTES=' + str(actual_bytes))
print('REASSEMBLED_APP_ZIP_SHA256=' + actual_sha)
if actual_bytes != int(E['APP_ZIP_BYTES']) or actual_sha != E['APP_ZIP_SHA256']:
    die('REASSEMBLED_APP_ZIP_IDENTITY_MISMATCH')

exe_out = work / 'OCLP7_D97AG_PACKAGED_EXECUTABLE_FROM_APP_ZIP'
with zipfile.ZipFile(app_zip) as z:
    safe_names(z)
    bad = z.testzip()
    if bad is not None:
        die('APP_ZIP_CRC_FAIL:' + bad)
    copy_member(z, 'OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher', exe_out)
exe_out.chmod(0o500)
if exe_out.stat().st_size != int(E['PACKAGED_EXE_BYTES']) or sha256(exe_out) != E['PACKAGED_EXE_SHA256']:
    die('PACKAGED_EXE_FROM_APP_ZIP_IDENTITY_MISMATCH')
report_exe = reports_dir / 'OCLP7_D97AG_PACKAGED_EXECUTABLE'
if report_exe.stat().st_size != int(E['PACKAGED_EXE_BYTES']) or sha256(report_exe) != E['PACKAGED_EXE_SHA256']:
    die('REPORT_PACKAGED_EXE_IDENTITY_MISMATCH')
if report_exe.read_bytes() != exe_out.read_bytes():
    die('REPORT_VS_APP_ZIP_EXECUTABLE_BYTE_MISMATCH')

auditor = reports_dir / 'OCLP7_D97AG_FROZEN_AUDITOR_BINARY'
if sha256(auditor) != E['FROZEN_AUDITOR_SHA256']:
    die('FROZEN_AUDITOR_SHA_MISMATCH')
auditor.chmod(0o500)

app_identity = set((reports_dir / 'OCLP7_D97AG_APP_IDENTITY.txt').read_text().splitlines())
required_identity = {
    'D97AG_APP_ZIP_BYTES=' + E['APP_ZIP_BYTES'], 'D97AG_APP_ZIP_SHA256=' + E['APP_ZIP_SHA256'],
    'D97AG_PACKAGED_EXE_BYTES=' + E['PACKAGED_EXE_BYTES'], 'D97AG_PACKAGED_EXE_SHA256=' + E['PACKAGED_EXE_SHA256'],
    'D97AG_FINAL_APP_XATTR_CODE_OBJECT_FROZEN_RUNTIME=PASS', 'D97AG_APP_STATIC_AND_EXACT_CODE_OBJECT_AUDIT=PASS',
}
if not required_identity <= app_identity:
    die('APP_IDENTITY_REQUIRED_LINE_MISSING:' + repr(sorted(required_identity - app_identity)))
build_audit = set((reports_dir / 'OCLP7_D97AG_GITHUB_BUILD_AUDIT_REPORT.txt').read_text().splitlines())
for required in (
    'D97AG_PACKAGED_THREE_MODULE_SEMANTIC_IDENTITY=PASS', 'PACKAGED_D97AG_XATTR_BACKEND_EXACT_AND_NO_OS_API=PASS',
    'PACKAGED_D97AD_UNCHANGED=PASS', 'PACKAGED_D97AG_PRESENT_EXACTLY_ONCE=PASS',
    'PACKAGED_D97AG_UUID_AND_POST_SHA_CONTRACT=PASS', 'PACKAGED_METAL_3802_TAHOE_COMPILER_SUBSTRATE=PASS',
    'OCLP7_D97AG_GITHUB_BUILD_AUDIT=PASS',
):
    if required not in build_audit:
        die('BUILD_AUDIT_REQUIRED_LINE_MISSING:' + required)
print('D97AG_ARTIFACT_REASSEMBLY_AND_STATIC_IDENTITY=PASS')

for label, path in (('PACKAGED_EXE', exe_out), ('FROZEN_AUDITOR', auditor)):
    arch = subprocess.run(['/usr/bin/lipo', '-archs', str(path)], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if arch.returncode != 0 or arch.stdout.strip() != 'x86_64':
        die(label + '_ARCH_MISMATCH:' + arch.stdout.strip() + ':' + arch.stderr.strip())
    desc = subprocess.run(['/usr/bin/file', str(path)], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if desc.returncode != 0 or 'Mach-O 64-bit executable x86_64' not in desc.stdout:
        die(label + '_FILE_IDENTITY_MISMATCH:' + desc.stdout.strip())
    print(label + '_ARCHS=x86_64')
    print(label + '_FILE=' + desc.stdout.strip())

runtime = subprocess.run([str(auditor), '--packaged-app', str(exe_out)], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
print('===== ASUS2 FROZEN AUDITOR STDOUT =====')
print(runtime.stdout, end='')
if runtime.stderr:
    print('===== ASUS2 FROZEN AUDITOR STDERR =====')
    print(runtime.stderr, end='')
if runtime.returncode != 0:
    die('LOCAL_FROZEN_AUDITOR_RC:' + str(runtime.returncode))
lines = set(runtime.stdout.splitlines())
required_runtime = {
    'D97AG_RUNTIME_AUDIT_MODE=PACKAGED_FROZEN', 'D97AG_RUNTIME_PROCESS_FROZEN=YES',
    'D97AG_RUNTIME_OS_LISTXATTR_AVAILABLE=NO', 'D97AG_RUNTIME_BACKEND_FREEVARS=_os,_subprocess',
    'D97AG_RUNTIME_BACKEND_FINGERPRINT=71959f823a2da72c12e53581c85773ebdfd0100b22a780152bf8c69fe2d56286',
    'D97AG_RUNTIME_BACKEND_SOURCE_SHA256=d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019',
    'D97AG_RUNTIME_EMPTY_MANIFEST=PASS', 'D97AG_RUNTIME_EMPTY_TEXT_BINARY_VALUES=PASS',
    'D97AG_EXACT_XATTR_CODE_OBJECT_RUNTIME=PASS',
}
missing = sorted(required_runtime - lines)
print('ASUS2_FROZEN_RUNTIME_REQUIRED_LINES_MISSING=' + repr(missing))
if missing:
    die('LOCAL_FROZEN_RUNTIME_REQUIRED_LINE_MISSING')
print('D97AG_ASUS2_FROZEN_XATTR_RUNTIME=PASS')

destination = Path(E['VERIFIED_APP_ZIP'])
if destination.exists() or destination.is_symlink():
    if destination.is_symlink() or not destination.is_file() or destination.stat().st_size != int(E['APP_ZIP_BYTES']) or sha256(destination) != E['APP_ZIP_SHA256']:
        die('EXISTING_VERIFIED_APP_ZIP_IDENTITY_MISMATCH')
    print('VERIFIED_APP_ZIP_RETAINED=EXISTING_EXACT')
else:
    with app_zip.open('rb') as src, destination.open('xb') as out:
        shutil.copyfileobj(src, out, length=8 * 1024 * 1024)
    if destination.stat().st_size != int(E['APP_ZIP_BYTES']) or sha256(destination) != E['APP_ZIP_SHA256']:
        destination.unlink(missing_ok=True)
        die('VERIFIED_APP_ZIP_POSTCOPY_IDENTITY_MISMATCH')
    print('VERIFIED_APP_ZIP_RETAINED=NEW_EXACT')
print('VERIFIED_APP_ZIP=' + str(destination))
print('D97AG_ASUS2_ARTIFACT_REASSEMBLY=PASS')
print('D97AG_ASUS2_PACKAGED_EXECUTABLE_IDENTITY=PASS')
print('D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT=PASS')
PY

echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT_BEFORE_DEPLOY"
echo "REPORT=$REPORT"
