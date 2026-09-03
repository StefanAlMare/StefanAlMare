#!/bin/zsh -f
set -euo pipefail

OUT="$HOME/Desktop/OCLP7_D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT.txt"
WORK="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AM_ARTIFACT_AUDIT.XXXXXX)"

cleanup() {
    local rc=$?
    trap - EXIT
    [[ -d "$WORK" ]] && /bin/rm -rf "$WORK" || true
    exit "$rc"
}
trap cleanup EXIT

exec > >(/usr/bin/tee "$OUT") 2>&1

echo "===== OCLP7 D97AM — ASUS2 PRIVATE RELEASE ARTIFACT AUDIT ====="
echo "PURPOSE=download_and_audit_exact_private_release_without_deploy_or_system_mutation"
echo "PRIVATE_REPOSITORY=StefanAlMare/Private-Work"
echo "EXPECTED_RELEASE_ID=382366988"
echo "EXPECTED_RELEASE_TAG=oclp7-d97am-run-33812721798-attempt-1"
echo "EXPECTED_RELEASE_TARGET_HEAD=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d"
echo "EXPECTED_APP_ZIP_BYTES=751495650"
echo "EXPECTED_APP_ZIP_SHA256=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca"
echo "EXPECTED_PACKAGED_EXE_BYTES=6596496"
echo "EXPECTED_PACKAGED_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3"
echo "EXPECTED_PACKAGED_ARCH=x86_64"
echo "SOURCE_MUTATION=NO"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo

GH="$(command -v gh 2>/dev/null || true)"
PYTHON="$(command -v python3 2>/dev/null || true)"
[[ -n "$GH" && -x "$GH" ]] || { echo "FAIL=MISSING_GH_CLI"; exit 2; }
[[ -n "$PYTHON" && -x "$PYTHON" ]] || { echo "FAIL=MISSING_PYTHON3"; exit 2; }
"$GH" auth status -h github.com >/dev/null 2>&1 || { echo "FAIL=GH_NOT_AUTHENTICATED_FOR_GITHUB_COM"; exit 2; }

echo "GH=$GH"
echo "PYTHON=$PYTHON"
echo "WORK=$WORK"
echo "GH_AUTH_GATE=PASS"
echo

"$PYTHON" - "$WORK" "$GH" <<'PY'
from __future__ import annotations

import hashlib
import json
import os
import pathlib
import posixpath
import stat
import subprocess
import sys
import zipfile

work = pathlib.Path(sys.argv[1])
gh = sys.argv[2]
repo = "StefanAlMare/Private-Work"
tag = "oclp7-d97am-run-33812721798-attempt-1"
release_id = 382366988
head = "6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d"
app_zip_name = "OCLP7-D97AM-OpenCore-Patcher.app.zip"
app_zip_bytes = 751495650
app_zip_sha = "d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca"
exe_bytes_expected = 6596496
exe_sha_expected = "fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3"
reports_bytes_expected = 6517739
reports_sha_expected = "ab0e5926efed5ddbe3c4032bfd7584097a309b2bd1964e2e6349e3734eb03481"

assets_expected = {
    "D97AM_SPLIT_MANIFEST.env": (543427741, 737, "a5aa00d48c2b973113971b2f2db4e66c865b3f82449b6199d2d95ff0a8cda09c"),
    "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00": (543427689, 390000000, "9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67"),
    "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01": (543427740, 361495650, "80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08"),
    "OCLP7-D97AM-REPORTS.zip": (543427739, reports_bytes_expected, reports_sha_expected),
    "OCLP7_D97AM_RELEASE_ASSET_IDENTITY.txt": (543427758, 516, "4969b5f306d1b7afd458655237f692da166d4a13db3629e31495c30b772d53a4"),
    "PARTS.SHA256": (543427716, 222, "974b12a2e882a922262be9b0d0243f63260eec2fd9f937bf1acc6f9eedab6a60"),
    "RELEASE-ASSETS.SHA256": (543427759, 587, "f33a6fe1c35aaa5a64aa91cb6782d80736082ef36b70f92dd77c95ba70a1f0c1"),
}


def sha256_path(path: pathlib.Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(8 * 1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def gh_json(endpoint: str):
    return json.loads(subprocess.check_output([gh, "api", endpoint], text=True))


def download_asset(asset_id: int, path: pathlib.Path):
    with path.open("wb") as out:
        result = subprocess.run(
            [gh, "api", "-H", "Accept: application/octet-stream", f"repos/{repo}/releases/assets/{asset_id}"],
            stdout=out,
            stderr=subprocess.PIPE,
        )
    if result.returncode != 0:
        raise SystemExit(f"ASSET_DOWNLOAD_FAIL|ID={asset_id}|STDERR={result.stderr.decode(errors='replace')}")


def env_map(text: str):
    out = {}
    for raw in text.splitlines():
        if not raw or raw.lstrip().startswith("#") or "=" not in raw:
            continue
        k, v = raw.split("=", 1)
        out[k] = v
    return out


def parse_sum_file(text: str):
    out = {}
    for raw in text.splitlines():
        if not raw.strip():
            continue
        parts = raw.split(None, 1)
        if len(parts) != 2:
            raise SystemExit("SHA_FILE_FRAMING_INVALID:" + repr(raw))
        digest, name = parts
        name = name.strip()
        if name.startswith("*"):
            name = name[1:]
        out[name] = digest
    return out


def safe_zip_audit(path: pathlib.Path, label: str):
    with zipfile.ZipFile(path) as zf:
        bad = zf.testzip()
        if bad is not None:
            raise SystemExit(f"{label}_CRC_FAIL:{bad}")
        infos = zf.infolist()
        if not infos:
            raise SystemExit(f"{label}_EMPTY")
        seen = set()
        for info in infos:
            name = info.filename
            if "\x00" in name or "\\" in name:
                raise SystemExit(f"{label}_UNSAFE_MEMBER:{name!r}")
            if name.startswith("/") or name.startswith("~"):
                raise SystemExit(f"{label}_UNSAFE_MEMBER:{name!r}")
            norm = posixpath.normpath(name)
            parts = pathlib.PurePosixPath(norm).parts
            if norm == ".." or ".." in parts or (parts and ":" in parts[0]):
                raise SystemExit(f"{label}_UNSAFE_MEMBER:{name!r}")
            if name in seen:
                raise SystemExit(f"{label}_DUPLICATE_MEMBER:{name!r}")
            seen.add(name)
        print(f"{label}_MEMBER_COUNT={len(infos)}")
        print(f"{label}_CRC=PASS")
        print(f"{label}_SAFE_MEMBERS=PASS")
        return infos


print("===== PRIVATE RELEASE METADATA =====")
release = gh_json(f"repos/{repo}/releases/tags/{tag}")
if int(release.get("id", -1)) != release_id:
    raise SystemExit("RELEASE_ID_MISMATCH")
if release.get("tag_name") != tag or release.get("target_commitish") != head:
    raise SystemExit("RELEASE_TAG_OR_HEAD_MISMATCH")
if release.get("draft") is not False or release.get("prerelease") is not False:
    raise SystemExit("RELEASE_STATE_MISMATCH")
assets = release.get("assets") or []
by_name = {a.get("name"): a for a in assets}
if set(by_name) != set(assets_expected) or len(assets) != 7:
    raise SystemExit("RELEASE_ASSET_SET_MISMATCH:" + repr(sorted(by_name)))
print(f"RELEASE_ID={release['id']}")
print(f"RELEASE_TAG={release['tag_name']}")
print(f"RELEASE_TARGET_HEAD={release['target_commitish']}")
print(f"RELEASE_ASSET_COUNT={len(assets)}")
for name, (asset_id, size, digest) in assets_expected.items():
    a = by_name[name]
    observed_digest = a.get("digest")
    if int(a.get("id", -1)) != asset_id or int(a.get("size", -1)) != size or a.get("state") != "uploaded":
        raise SystemExit("RELEASE_ASSET_METADATA_MISMATCH:" + name)
    if observed_digest and observed_digest != "sha256:" + digest:
        raise SystemExit("RELEASE_ASSET_API_DIGEST_MISMATCH:" + name)
    print(f"RELEASE_ASSET_META|ID={asset_id}|NAME={name}|BYTES={size}|DIGEST={observed_digest}")
print("D97AM_RELEASE_METADATA_BINDING=PASS")

print("\n===== DOWNLOAD + LOCAL ASSET HASHES =====")
local = {}
for name, (asset_id, size, digest) in assets_expected.items():
    path = work / name
    download_asset(asset_id, path)
    actual_size = path.stat().st_size
    actual_sha = sha256_path(path)
    print(f"LOCAL_ASSET|ID={asset_id}|NAME={name}|BYTES={actual_size}|SHA256={actual_sha}")
    if actual_size != size or actual_sha != digest:
        raise SystemExit("LOCAL_ASSET_IDENTITY_MISMATCH:" + name)
    local[name] = path
print("D97AM_ALL_SEVEN_LOCAL_ASSET_IDENTITIES=PASS")

print("\n===== RELEASE ASSET CHECKSUM FILE =====")
release_sums = parse_sum_file(local["RELEASE-ASSETS.SHA256"].read_text(errors="strict"))
expected_release_sum_names = set(assets_expected) - {"RELEASE-ASSETS.SHA256"}
if set(release_sums) != expected_release_sum_names:
    raise SystemExit("RELEASE_ASSETS_SUM_SET_MISMATCH:" + repr(sorted(release_sums)))
for name in sorted(expected_release_sum_names):
    if release_sums[name] != assets_expected[name][2]:
        raise SystemExit("RELEASE_ASSETS_SUM_DIGEST_MISMATCH:" + name)
    print(f"RELEASE_SUM_BINDING|NAME={name}|SHA256={release_sums[name]}")
print("D97AM_RELEASE_ASSETS_SHA256_FILE=PASS")

print("\n===== PARTS CHECKSUM FILE =====")
part_sums = parse_sum_file(local["PARTS.SHA256"].read_text(errors="strict"))
part_names = {
    "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00",
    "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01",
}
if set(part_sums) != part_names:
    raise SystemExit("PARTS_SUM_SET_MISMATCH:" + repr(sorted(part_sums)))
for name in sorted(part_names):
    if part_sums[name] != assets_expected[name][2]:
        raise SystemExit("PARTS_SUM_DIGEST_MISMATCH:" + name)
    print(f"PART_SUM_BINDING|NAME={name}|SHA256={part_sums[name]}")
print("D97AM_PARTS_SHA256_FILE=PASS")

print("\n===== SPLIT MANIFEST =====")
manifest_text = local["D97AM_SPLIT_MANIFEST.env"].read_text(errors="strict")
manifest = env_map(manifest_text)
manifest_required = {
    "D97AM_ORIGINAL_NAME": app_zip_name,
    "D97AM_ORIGINAL_BYTES": str(app_zip_bytes),
    "D97AM_ORIGINAL_SHA256": app_zip_sha,
    "D97AM_PART_COUNT": "2",
    "D97AM_PART_00_NAME": "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00",
    "D97AM_PART_00_BYTES": "390000000",
    "D97AM_PART_00_SHA256": assets_expected["OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00"][2],
    "D97AM_PART_01_NAME": "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01",
    "D97AM_PART_01_BYTES": "361495650",
    "D97AM_PART_01_SHA256": assets_expected["OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01"][2],
    "GITHUB_REPOSITORY": repo,
    "GITHUB_RUN_ID": "33812721798",
    "GITHUB_RUN_ATTEMPT": "1",
    "GITHUB_HEAD_SHA": head,
    "SYSTEM_TARGET_MUTATION": "NO",
    "GOLDEN_MUTATION": "NO",
    "ROOT_PATCH": "AUTO-NO",
    "REBOOT": "AUTO-NO",
}
for key, expected in manifest_required.items():
    actual = manifest.get(key)
    print(f"SPLIT_MANIFEST_FIELD|{key}={actual}")
    if actual != expected:
        raise SystemExit(f"SPLIT_MANIFEST_FIELD_MISMATCH:{key}:{actual!r}!={expected!r}")
print("D97AM_SPLIT_MANIFEST_CONTENT=PASS")

print("\n===== RELEASE IDENTITY TEXT =====")
identity_text = local["OCLP7_D97AM_RELEASE_ASSET_IDENTITY.txt"].read_text(errors="strict")
identity = env_map(identity_text)
identity_required = {
    "D97AM_RELEASE_BUILD_HEAD": head,
    "D97AM_RELEASE_APP_ZIP_BYTES": str(app_zip_bytes),
    "D97AM_RELEASE_APP_ZIP_SHA256": app_zip_sha,
    "D97AM_RELEASE_PACKAGED_EXE_BYTES": str(exe_bytes_expected),
    "D97AM_RELEASE_PACKAGED_EXE_SHA256": exe_sha_expected,
    "D97AM_RELEASE_REPORTS_ZIP_BYTES": str(reports_bytes_expected),
    "D97AM_RELEASE_REPORTS_ZIP_SHA256": reports_sha_expected,
    "D97AM_CURRENT_RUN_IDENTITY_BINDING": "PASS",
}
for key, expected in identity_required.items():
    actual = identity.get(key)
    print(f"RELEASE_IDENTITY_FIELD|{key}={actual}")
    if actual != expected:
        raise SystemExit(f"RELEASE_IDENTITY_FIELD_MISMATCH:{key}:{actual!r}!={expected!r}")
print("D97AM_RELEASE_IDENTITY_CONTENT=PASS")

print("\n===== REASSEMBLE APPLICATION ZIP =====")
app_zip = work / app_zip_name
with app_zip.open("wb") as out:
    for name in [
        "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00",
        "OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01",
    ]:
        with local[name].open("rb") as src:
            for block in iter(lambda: src.read(8 * 1024 * 1024), b""):
                out.write(block)
actual_zip_size = app_zip.stat().st_size
actual_zip_sha = sha256_path(app_zip)
print(f"REASSEMBLED_APP_ZIP_BYTES={actual_zip_size}")
print(f"REASSEMBLED_APP_ZIP_SHA256={actual_zip_sha}")
if actual_zip_size != app_zip_bytes or actual_zip_sha != app_zip_sha:
    raise SystemExit("REASSEMBLED_APP_ZIP_IDENTITY_MISMATCH")
print("D97AM_TWO_PART_REASSEMBLY_LOCAL=PASS")

print("\n===== APPLICATION ZIP CRC / SAFE MEMBER / EXECUTABLE =====")
safe_zip_audit(app_zip, "APP_ZIP")
with zipfile.ZipFile(app_zip) as zf:
    exe_members = [i for i in zf.infolist() if i.filename.endswith("OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher") and not i.is_dir() and not i.filename.startswith("__MACOSX/")]
    if len(exe_members) != 1:
        raise SystemExit("APP_ZIP_EXECUTABLE_MEMBER_CARDINALITY:" + repr([x.filename for x in exe_members]))
    info = exe_members[0]
    exe_data = zf.read(info)
    exe_sha = hashlib.sha256(exe_data).hexdigest()
    print(f"APP_ZIP_EXECUTABLE_MEMBER={info.filename}")
    print(f"APP_ZIP_EXECUTABLE_BYTES={len(exe_data)}")
    print(f"APP_ZIP_EXECUTABLE_SHA256={exe_sha}")
    if len(exe_data) != exe_bytes_expected or exe_sha != exe_sha_expected:
        raise SystemExit("APP_ZIP_EXECUTABLE_IDENTITY_MISMATCH")
    exe_path = work / "OpenCore-Patcher-D97AM"
    exe_path.write_bytes(exe_data)
    exe_path.chmod(0o500)
arch = subprocess.check_output(["/usr/bin/lipo", "-archs", str(exe_path)], text=True).strip()
print(f"APP_ZIP_EXECUTABLE_ARCHS={arch}")
if arch != "x86_64":
    raise SystemExit("APP_ZIP_EXECUTABLE_ARCH_MISMATCH:" + arch)
print("D97AM_APP_ZIP_EXECUTABLE_EXACT=PASS")

print("\n===== REPORTS ZIP CRC / SAFE MEMBER =====")
reports = local["OCLP7-D97AM-REPORTS.zip"]
safe_zip_audit(reports, "REPORTS_ZIP")

with zipfile.ZipFile(reports) as zf:
    infos = [i for i in zf.infolist() if not i.is_dir() and not i.filename.startswith("__MACOSX/") and "/._" not in i.filename and not pathlib.PurePosixPath(i.filename).name.startswith("._")]
    by_base = {}
    for i in infos:
        by_base.setdefault(pathlib.PurePosixPath(i.filename).name, []).append(i)
    print("REPORTS_FILE_COUNT_NON_APPLEDOUBLE=" + str(len(infos)))
    for i in sorted(infos, key=lambda x: x.filename):
        if i.file_size <= 8 * 1024 * 1024:
            digest = hashlib.sha256(zf.read(i)).hexdigest()
            print(f"REPORT_FILE|NAME={i.filename}|BYTES={i.file_size}|SHA256={digest}")
        else:
            print(f"REPORT_FILE|NAME={i.filename}|BYTES={i.file_size}|SHA256=SKIPPED_LARGE")

    def exact_one(base: str):
        hits = by_base.get(base, [])
        if len(hits) != 1:
            raise SystemExit(f"REPORT_REQUIRED_FILE_CARDINALITY:{base}:{len(hits)}")
        return hits[0]

    source_audit = zf.read(exact_one("OCLP7_D97AM_GITHUB_SOURCE_AUDIT_REPORT.txt")).decode("utf-8", errors="strict")
    build_audit = zf.read(exact_one("OCLP7_D97AM_GITHUB_BUILD_AUDIT_REPORT.txt")).decode("utf-8", errors="strict")
    transform_report = zf.read(exact_one("OCLP7_D97AM_TRANSFORM_REPORT.txt")).decode("utf-8", errors="strict")
    app_identity = zf.read(exact_one("OCLP7_D97AM_APP_IDENTITY.txt")).decode("utf-8", errors="strict")
    report_exe = zf.read(exact_one("OCLP7_D97AM_PACKAGED_EXECUTABLE"))

    source_markers = [
        "D97AM_SOURCE_SHA256=sys_patch_helpers.py|7c1127a62379ea5cef9efd42f5d14e7956def01e6f7635defe4f64e77473a844",
        "D97AM_SOURCE_SHA256=sys_patch.py|78e096b982c8a2e8c78f8bd18b32fc0961fa84e26d573a8d8fa304393d6a29a3",
        "D97AM_SOURCE_SHA256=metal_3802.py|fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24",
        "D97AM_METHOD_SOURCE_SHA256=45e3b803a52fc876b0a1c4ebae6fe23878f32febc44368c4aaf32453170dcc6f",
        "D97AM_D97AD_ACTIVE_CALL_COUNT=0",
        "D97AM_D97AD_DORMANT_HELPER_COUNT=1",
        "OCLP7_D97AM_GITHUB_SOURCE_AUDIT=PASS",
    ]
    for marker in source_markers:
        if marker not in source_audit:
            raise SystemExit("SOURCE_AUDIT_MARKER_MISSING:" + marker)

    build_markers = [
        "D97AM_PACKAGED_EXE_SHA256=" + exe_sha_expected,
        "D97AM_PACKAGED_ARCH=x86_64",
        "D97AM_PACKAGED_THREE_MODULE_SEMANTIC_IDENTITY=PASS",
        "D97AM_PACKAGED_METHOD_NATURAL_FLOW_IDENTITY=PASS",
        "D97AM_PACKAGED_D97AD_DORMANT_IDENTITY=PASS",
        "D97AM_PACKAGED_XATTR_CHFLAGS_IDENTITY=PASS",
        "OCLP7_D97AM_GITHUB_BUILD_AUDIT=PASS",
    ]
    for marker in build_markers:
        if marker not in build_audit:
            raise SystemExit("BUILD_AUDIT_MARKER_MISSING:" + marker)

    transform_markers = [
        "D97AM_POST_HELPERS_SHA256=7c1127a62379ea5cef9efd42f5d14e7956def01e6f7635defe4f64e77473a844",
        "D97AM_POST_SYSPATCH_SHA256=78e096b982c8a2e8c78f8bd18b32fc0961fa84e26d573a8d8fa304393d6a29a3",
        "D97AM_POST_METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24",
        "D97AM_D97AD_ACTIVE_CALL_COUNT=0",
        "D97AM_D97AD_DORMANT_HELPER_COUNT=1",
        "D97AM_P7_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7",
        "D97AM_P7_POST_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9",
        "D97AM_EXACT_SOURCE_TRANSITION=PASS",
    ]
    for marker in transform_markers:
        if marker not in transform_report:
            raise SystemExit("TRANSFORM_REPORT_MARKER_MISSING:" + marker)

    app_id = env_map(app_identity)
    app_required = {
        "D97AM_APP_ZIP_NAME": app_zip_name,
        "D97AM_APP_ZIP_BYTES": str(app_zip_bytes),
        "D97AM_APP_ZIP_SHA256": app_zip_sha,
        "D97AM_PACKAGED_EXE_BYTES": str(exe_bytes_expected),
        "D97AM_PACKAGED_EXE_SHA256": exe_sha_expected,
        "D97AM_BUILD_HEAD": head,
        "D97AM_PACKAGED_STATIC_IDENTITY": "PASS",
    }
    for key, expected in app_required.items():
        if app_id.get(key) != expected:
            raise SystemExit(f"APP_IDENTITY_REPORT_MISMATCH:{key}:{app_id.get(key)!r}!={expected!r}")

    report_exe_sha = hashlib.sha256(report_exe).hexdigest()
    print(f"REPORTS_PACKAGED_EXECUTABLE_BYTES={len(report_exe)}")
    print(f"REPORTS_PACKAGED_EXECUTABLE_SHA256={report_exe_sha}")
    if len(report_exe) != exe_bytes_expected or report_exe_sha != exe_sha_expected or report_exe != exe_data:
        raise SystemExit("REPORTS_PACKAGED_EXECUTABLE_MISMATCH")

    split_hits = by_base.get("D97AM_SPLIT_MANIFEST.env", [])
    if len(split_hits) == 1:
        reports_manifest = zf.read(split_hits[0])
        if reports_manifest != local["D97AM_SPLIT_MANIFEST.env"].read_bytes():
            raise SystemExit("REPORTS_SPLIT_MANIFEST_BYTE_MISMATCH")
        print("REPORTS_SPLIT_MANIFEST_BYTE_IDENTITY=PASS")
    else:
        raise SystemExit("REPORTS_SPLIT_MANIFEST_CARDINALITY:" + str(len(split_hits)))

print("D97AM_REPORTS_CONTENT_BINDING=PASS")
print("\n===== FINAL CLASSIFICATION =====")
print("D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=FULL_PASS")
print("D97AM_VERIFIED_APP_ZIP_BYTES=" + str(app_zip_bytes))
print("D97AM_VERIFIED_APP_ZIP_SHA256=" + app_zip_sha)
print("D97AM_VERIFIED_PACKAGED_EXE_BYTES=" + str(exe_bytes_expected))
print("D97AM_VERIFIED_PACKAGED_EXE_SHA256=" + exe_sha_expected)
print("D97AM_VERIFIED_PACKAGED_ARCH=x86_64")
print("SOURCE_MUTATION=NO")
print("INSTALLED_APP_MUTATION=NO")
print("SYSTEM_TARGET_MUTATION=NO")
print("GOLDEN_MUTATION=NO")
print("ROOT_PATCH=AUTO-NO")
print("REBOOT=AUTO-NO")
print("STOP=RETURN_COMPLETE_TERMINAL_OUTPUT")
PY

echo
echo "REPORT=$OUT"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "STOP=RETURN_COMPLETE_TERMINAL_OUTPUT"
