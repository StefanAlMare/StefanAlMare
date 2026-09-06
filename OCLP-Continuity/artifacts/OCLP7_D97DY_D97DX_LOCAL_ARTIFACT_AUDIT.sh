#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DY — LOCAL independent artifact audit for D97DX.
# Intel iMac only. READ-ONLY with respect to D97DX artifacts/worktree.
# Reads the large ZIP locally; emits only a small TXT report.
# NO Root Patch. NO EFI mutation. NO system-root mutation. NO reboot.

EXPECTED_ZIP_SHA="2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a"
EXPECTED_ZIP_BYTES="722858206"
EXPECTED_INNER_SHA="986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11"
EXPECTED_DEBUG_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_PATCHDICT_SHA="c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e"
EXPECTED_UNIVERSAL_SHA="33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7"
EXPECTED_PAYLOADS_SHA="e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b"
EXPECTED_OFFICIAL_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

ZIP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.zip"
APP="$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.app"
DIFF="$HOME/Desktop/OCLP7_D97DX_b9df76_NATIVE_METAL_SAFE.patch"
WORK="$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82"
PY="$WORK/.venv/bin/python"

INNER="$APP/Contents/Resources/OpenCore-Patcher.app"
INNER_EXE="$INNER/Contents/MacOS/OpenCore-Patcher"
DEBUG_HELPER="$APP/Contents/Resources/debug-privileged-helper"
EMBED_AUDIT="$APP/Contents/Resources/D97DX_AUDIT.txt"
EMBED_PATCH="$APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
LAUNCHER="$APP/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DX"

STAMP="$(date +%Y%m%d_%H%M%S)"
REPORT="$HOME/Desktop/OCLP7_D97DY_D97DX_LOCAL_ARTIFACT_AUDIT_${STAMP}.txt"

say() { printf '\n==> %s\n' "$*"; }
pass() { printf '%s=PASS\n' "$1"; }
fail() { printf '%s=FAIL\n' "$1"; FAILED=1; }
die() { echo "FATAL: $*" >&2; exit 1; }

FAILED=0
exec > >(tee "$REPORT") 2>&1

echo "===== OCLP7 D97DY — D97DX LOCAL ARTIFACT AUDIT ====="
echo "HOST=INTEL_IMAC"
echo "ROOT_PATCH=NO"
echo "EFI_MUTATION=NO"
echo "SYSTEM_ROOT_MUTATION=NO"
echo "REBOOT=NO"
echo

[[ "$(uname -s)" == "Darwin" ]] || die "macOS required."
[[ "$(uname -m)" == "x86_64" ]] || die "Intel/x86_64 host required."
[[ -f "$ZIP" ]] || die "Missing $ZIP"
[[ -d "$APP" ]] || die "Missing $APP"
[[ -f "$DIFF" ]] || die "Missing $DIFF"
[[ -x "$PY" ]] || die "Missing existing D97DU venv Python: $PY"

say "Pin large ZIP identity locally"
ZIP_SHA="$(shasum -a 256 "$ZIP" | awk '{print $1}')"
ZIP_BYTES="$(stat -f '%z' "$ZIP")"
echo "ZIP_SHA256=$ZIP_SHA"
echo "ZIP_BYTES=$ZIP_BYTES"
[[ "$ZIP_SHA" == "$EXPECTED_ZIP_SHA" ]] && pass ZIP_SHA_GATE || fail ZIP_SHA_GATE
[[ "$ZIP_BYTES" == "$EXPECTED_ZIP_BYTES" ]] && pass ZIP_SIZE_GATE || fail ZIP_SIZE_GATE

say "Pin on-disk app critical members"
for p in "$INNER_EXE" "$DEBUG_HELPER" "$EMBED_AUDIT" "$EMBED_PATCH" "$LAUNCHER"; do
    [[ -f "$p" ]] || die "Missing critical app member: $p"
done

LOCAL_INNER_SHA="$(shasum -a 256 "$INNER_EXE" | awk '{print $1}')"
LOCAL_DEBUG_SHA="$(shasum -a 256 "$DEBUG_HELPER" | awk '{print $1}')"
LOCAL_DIFF_SHA="$(shasum -a 256 "$DIFF" | awk '{print $1}')"
LOCAL_EMBED_PATCH_SHA="$(shasum -a 256 "$EMBED_PATCH" | awk '{print $1}')"
LOCAL_INNER_ARCH="$(lipo -archs "$INNER_EXE")"
LOCAL_DEBUG_ARCH="$(lipo -archs "$DEBUG_HELPER")"

echo "LOCAL_INNER_EXEC_SHA256=$LOCAL_INNER_SHA"
echo "LOCAL_INNER_ARCH=$LOCAL_INNER_ARCH"
echo "LOCAL_DEBUG_HELPER_SHA256=$LOCAL_DEBUG_SHA"
echo "LOCAL_DEBUG_HELPER_ARCH=$LOCAL_DEBUG_ARCH"
echo "LOCAL_SOURCE_DIFF_SHA256=$LOCAL_DIFF_SHA"
echo "LOCAL_EMBEDDED_SOURCE_PATCH_SHA256=$LOCAL_EMBED_PATCH_SHA"

[[ "$LOCAL_INNER_SHA" == "$EXPECTED_INNER_SHA" ]] && pass LOCAL_INNER_SHA_GATE || fail LOCAL_INNER_SHA_GATE
[[ "$LOCAL_INNER_ARCH" == "x86_64" ]] && pass LOCAL_INNER_ARCH_GATE || fail LOCAL_INNER_ARCH_GATE
[[ "$LOCAL_DEBUG_SHA" == "$EXPECTED_DEBUG_SHA" ]] && pass LOCAL_DEBUG_SHA_GATE || fail LOCAL_DEBUG_SHA_GATE
[[ "$LOCAL_DEBUG_ARCH" == "x86_64" ]] && pass LOCAL_DEBUG_ARCH_GATE || fail LOCAL_DEBUG_ARCH_GATE
[[ "$LOCAL_DIFF_SHA" == "$EXPECTED_DIFF_SHA" ]] && pass LOCAL_DIFF_SHA_GATE || fail LOCAL_DIFF_SHA_GATE
[[ "$LOCAL_EMBED_PATCH_SHA" == "$EXPECTED_DIFF_SHA" ]] && pass EMBEDDED_PATCH_SHA_GATE || fail EMBEDDED_PATCH_SHA_GATE
cmp -s "$DIFF" "$EMBED_PATCH" && pass DESKTOP_VS_EMBEDDED_PATCH_BYTE_GATE || fail DESKTOP_VS_EMBEDDED_PATCH_BYTE_GATE

codesign --verify --deep --strict "$INNER" >/dev/null 2>&1 && pass INNER_CODESIGN_GATE || fail INNER_CODESIGN_GATE
codesign --verify --strict "$DEBUG_HELPER" >/dev/null 2>&1 && pass DEBUG_HELPER_CODESIGN_GATE || fail DEBUG_HELPER_CODESIGN_GATE

if [[ -e "$APP/Contents/Resources/official-privileged-helper" ]]; then
    fail OFFICIAL_HELPER_NOT_BUNDLED_GATE
else
    pass OFFICIAL_HELPER_NOT_BUNDLED_GATE
fi

say "Audit outer target launcher safety semantics"
"$PY" - "$LAUNCHER" "$EXPECTED_OFFICIAL_SHA" "$EXPECTED_OFFICIAL_TEAM" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1])
sha=sys.argv[2]
team=sys.argv[3]
t=p.read_text(errors="replace")

required = {
    "EXPECTED_OFFICIAL_SHA": f'EXPECTED_OFFICIAL_SHA="{sha}"',
    "EXPECTED_OFFICIAL_TEAM": f'EXPECTED_OFFICIAL_TEAM="{team}"',
    "VERIFY_BEFORE_SWAP": 'verify_official "$SYSTEM_HELPER" || fail',
    "SAVE_INSTALLED_OFFICIAL": '/bin/cp -p "$SYSTEM_HELPER" "$BACKUP"',
    "VERIFY_SAVED_BACKUP": 'verify_official "$BACKUP" || fail',
    "TEMP_DEBUG_INSTALL": 'install_helper "$DEBUG_HELPER"',
    "EXPLICIT_RESTORE": 'restore_official || fail',
    "RESTORE_POSTVERIFY": 'verify_official "$SYSTEM_HELPER"',
    "OPEN_WAIT": '/usr/bin/open -W -n "$INNER"',
}
bad=0
for k,v in required.items():
    ok=v in t
    print(f"LAUNCHER_{k}={'PASS' if ok else 'FAIL'}")
    bad |= not ok

forbidden = {
    "NO_NVRAM_MUTATION": "/usr/sbin/nvram",
    "NO_BLESS": "/usr/sbin/bless",
    "NO_REBOOT_COMMAND": "/sbin/reboot",
    "NO_SHUTDOWN_COMMAND": "/sbin/shutdown",
    "NO_ROOTPATCH_AUTOMATION_LITERAL": "--patch_sys_vol",
}
for k,v in forbidden.items():
    ok=v not in t
    print(f"LAUNCHER_{k}={'PASS' if ok else 'FAIL'}")
    bad |= not ok

raise SystemExit(1 if bad else 0)
PY
if [[ "$?" -eq 0 ]]; then
    pass LAUNCHER_POLICY_GATE
else
    fail LAUNCHER_POLICY_GATE
fi

say "Audit embedded D97DX audit contract"
"$PY" - "$EMBED_AUDIT" <<'PY'
from pathlib import Path
import sys
t=Path(sys.argv[1]).read_text(errors="replace")
required = [
"D97DX_25G82_METALLIB_ENTRY_COUNT=182",
"D97DX_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0",
"D97DX_METALOLD_DYLIB_COUNT=0",
"D97DX_MAIN_METAL_BINARY_INSTALL_COUNT=0",
"D97DX_XPC_ONLY_LEGACY_METAL_INGRESS=PASS",
"D97DX_TAHOE_NATIVE_METAL4_PRESERVATION_POLICY=PASS",
"D97DX_TRUE_FIVE_REAPPLY=NO",
"D97DX_OFFICIAL_HELPER_BUNDLED=NO",
"ROOT_PATCH_RUN=NO",
"EFI_MUTATION=NO",
"REBOOT_RUN=NO",
]
bad=0
for s in required:
    ok=s in t
    key=s.split("=",1)[0]
    print(f"EMBED_AUDIT_{key}={'PASS' if ok else 'FAIL'}")
    bad |= not ok
raise SystemExit(1 if bad else 0)
PY
if [[ "$?" -eq 0 ]]; then
    pass EMBEDDED_AUDIT_CONTRACT_GATE
else
    fail EMBEDDED_AUDIT_CONTRACT_GATE
fi

say "Re-synthesize Tahoe patch dictionary from preserved worktree"
"$PY" - <<'PY'
from opencore_legacy_patcher.sys_patch.patchsets.shared_patches.metal_3802 import LegacyMetal3802
from opencore_legacy_patcher.sys_patch.patchsets.base import PatchType

p=LegacyMetal3802(25,0,"26.6.2").patches()
common=p["Metal 3802 Common"]
co=common[PatchType.OVERWRITE_SYSTEM_VOLUME]
cm=common[PatchType.MERGE_SYSTEM_VOLUME]
assert co["/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices"]["MTLCompilerService.xpc"]=="12.5-3802-23"
assert cm["/System/Library/PrivateFrameworks"]["MTLCompiler.framework"]=="12.7.6-3802"
assert cm["/System/Library/PrivateFrameworks"]["GPUCompiler.framework"]=="12.7.6-3802"

ext=p["Metal 3802 Common Extended"][PatchType.MERGE_SYSTEM_VOLUME]
assert "Metal.framework" not in ext["/System/Library/Frameworks"]
assert ext["/System/Library/Frameworks"]["CoreImage.framework"]=="14.0 Beta 3-24"
assert ext["/System/Library/PrivateFrameworks"]["RenderBox.framework"]=="14.0-3802"
assert ext["/System/Library/PrivateFrameworks"]["MTLCompiler.framework"]=="14.2 Beta 1"
assert ext["/System/Library/PrivateFrameworks"]["GPUCompiler.framework"]=="14.2 Beta 1"

met=p["Metal 3802 .metallibs"][PatchType.OVERWRITE_SYSTEM_VOLUME]
assert sum(len(v) for v in met.values())==182

for name,patch in p.items():
    for ptype,roots in patch.items():
        if not isinstance(roots,dict):
            continue
        fw=roots.get("/System/Library/Frameworks")
        if isinstance(fw,dict):
            assert "Metal.framework" not in fw, (name,ptype,fw)

flat=repr(p)
assert "MetalOld.dylib" not in flat
assert "13.2.1-24/Metal.framework" not in flat
print("RESYNTH_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0")
print("RESYNTH_METALOLD_DYLIB_COUNT=0")
print("RESYNTH_MAIN_METAL_BINARY_INSTALL_COUNT=0")
print("RESYNTH_XPC_ONLY_LEGACY_METAL_INGRESS=PASS")
print("RESYNTH_PRIVATE_COMPILER_LANES=PASS")
print("RESYNTH_25G82_METALLIB_ENTRY_COUNT=182")
PY
if [[ "$?" -eq 0 ]]; then
    pass RESYNTH_PATCHDICT_GATE
else
    fail RESYNTH_PATCHDICT_GATE
fi

say "Audit source diff changed-file set"
"$PY" - "$DIFF" <<'PY'
from pathlib import Path
import re,sys
t=Path(sys.argv[1]).read_text(errors="replace")
paths=[]
for line in t.splitlines():
    if line.startswith("diff --git a/"):
        m=re.match(r"diff --git a/(.+?) b/(.+)", line)
        if not m or m.group(1)!=m.group(2):
            print("SOURCE_DIFF_PATH_PARSE=FAIL")
            raise SystemExit(1)
        paths.append(m.group(1))
expected=sorted([
"OpenCore-Patcher-GUI.spec",
"opencore_legacy_patcher/support/metallib_handler.py",
"opencore_legacy_patcher/sys_patch/patchsets/detect.py",
"opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py",
])
print("SOURCE_DIFF_PATHS="+";".join(sorted(paths)))
assert sorted(paths)==expected, sorted(paths)
print("SOURCE_DIFF_CHANGED_FILE_SET=PASS")
PY
if [[ "$?" -eq 0 ]]; then
    pass SOURCE_DIFF_CHANGED_FILE_GATE
else
    fail SOURCE_DIFF_CHANGED_FILE_GATE
fi

say "Stream-audit ZIP CRC and selected members without extraction"
ZIP_ENV="$ZIP" \
EXPECTED_INNER_SHA_ENV="$EXPECTED_INNER_SHA" \
EXPECTED_DEBUG_SHA_ENV="$EXPECTED_DEBUG_SHA" \
EXPECTED_DIFF_SHA_ENV="$EXPECTED_DIFF_SHA" \
EXPECTED_OFFICIAL_SHA_ENV="$EXPECTED_OFFICIAL_SHA" \
EXPECTED_OFFICIAL_TEAM_ENV="$EXPECTED_OFFICIAL_TEAM" \
"$PY" - <<'PY'
import hashlib, os, sys, zipfile

zp=os.environ["ZIP_ENV"]
expected_inner=os.environ["EXPECTED_INNER_SHA_ENV"]
expected_debug=os.environ["EXPECTED_DEBUG_SHA_ENV"]
expected_diff=os.environ["EXPECTED_DIFF_SHA_ENV"]
official_sha=os.environ["EXPECTED_OFFICIAL_SHA_ENV"]
official_team=os.environ["EXPECTED_OFFICIAL_TEAM_ENV"]

def digest_member(z, name):
    h=hashlib.sha256()
    with z.open(name) as f:
        while True:
            b=f.read(1024*1024)
            if not b: break
            h.update(b)
    return h.hexdigest()

with zipfile.ZipFile(zp) as z:
    names=z.namelist()
    print(f"ZIP_ENTRY_COUNT={len(names)}")
    bad=z.testzip()
    print(f"ZIP_CRC_TEST={'PASS' if bad is None else 'FAIL:'+bad}")
    if bad is not None:
        raise SystemExit(1)

    def one(suffix):
        found=[n for n in names if n.endswith(suffix)]
        if len(found)!=1:
            print(f"ZIP_MEMBER_UNIQUE_{suffix}=FAIL:{len(found)}")
            raise SystemExit(1)
        return found[0]

    inner=one("/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher")
    debug=one("/Contents/Resources/debug-privileged-helper")
    audit=one("/Contents/Resources/D97DX_AUDIT.txt")
    patch=one("/Contents/Resources/OCLP7_D97DX_SOURCE.patch")
    launcher=one("/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DX")

    official=[n for n in names if n.endswith("/Contents/Resources/official-privileged-helper")]
    print(f"ZIP_OFFICIAL_HELPER_MEMBER_COUNT={len(official)}")
    if official:
        raise SystemExit(1)

    inner_sha=digest_member(z,inner)
    debug_sha=digest_member(z,debug)
    patch_sha=digest_member(z,patch)
    print(f"ZIP_INNER_EXEC_SHA256={inner_sha}")
    print(f"ZIP_DEBUG_HELPER_SHA256={debug_sha}")
    print(f"ZIP_EMBEDDED_PATCH_SHA256={patch_sha}")
    assert inner_sha==expected_inner
    assert debug_sha==expected_debug
    assert patch_sha==expected_diff

    audit_text=z.read(audit).decode("utf-8","replace")
    required_audit=[
        "D97DX_25G82_METALLIB_ENTRY_COUNT=182",
        "D97DX_WHOLE_METAL_FRAMEWORK_DONOR_COUNT=0",
        "D97DX_METALOLD_DYLIB_COUNT=0",
        "D97DX_MAIN_METAL_BINARY_INSTALL_COUNT=0",
        "D97DX_XPC_ONLY_LEGACY_METAL_INGRESS=PASS",
        "D97DX_TAHOE_NATIVE_METAL4_PRESERVATION_POLICY=PASS",
        "D97DX_TRUE_FIVE_REAPPLY=NO",
        "D97DX_OFFICIAL_HELPER_BUNDLED=NO",
    ]
    for s in required_audit:
        assert s in audit_text, s

    launcher_text=z.read(launcher).decode("utf-8","replace")
    required_launcher=[
        f'EXPECTED_OFFICIAL_SHA="{official_sha}"',
        f'EXPECTED_OFFICIAL_TEAM="{official_team}"',
        'verify_official "$SYSTEM_HELPER" || fail',
        '/bin/cp -p "$SYSTEM_HELPER" "$BACKUP"',
        'install_helper "$DEBUG_HELPER"',
        'restore_official || fail',
    ]
    for s in required_launcher:
        assert s in launcher_text, s

    print("ZIP_SELECTED_MEMBER_IDENTITY=PASS")
    print("ZIP_EMBEDDED_AUDIT_CONTRACT=PASS")
    print("ZIP_LAUNCHER_POLICY=PASS")
PY
if [[ "$?" -eq 0 ]]; then
    pass ZIP_STREAM_AUDIT_GATE
else
    fail ZIP_STREAM_AUDIT_GATE
fi

echo
echo "===== FINAL CLASSIFIER ====="
if [[ "$FAILED" -eq 0 ]]; then
    echo "D97DY_LOCAL_ARTIFACT_AUDIT=PASS"
    echo "D97DY_D97DX_ARTIFACT_IDENTITY=PASS"
    echo "D97DY_NATIVE_METAL_SAFE_POLICY=PASS"
    echo "D97DY_ZIP_UPLOAD_REQUIRED=NO"
    echo "D97DY_STATUS=PASS"
else
    echo "D97DY_LOCAL_ARTIFACT_AUDIT=FAIL"
    echo "D97DY_STATUS=FAIL"
fi
echo "ROOT_PATCH_RUN=NO"
echo "EFI_MUTATION=NO"
echo "REBOOT_RUN=NO"
echo "REPORT=$REPORT"
