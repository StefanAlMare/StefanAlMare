#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97FY — final read-only gate before corrected-payload Root Patch.
# NO Root Patch. NO root-volume mutation. NO EFI/NVRAM mutation. NO reboot.

PKG="$HOME/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg"
LOCAL="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"

EXPECTED_PKG_SHA="602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3"
EXPECTED_PKG_BYTES="116574513"
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_REAL_METALLIB_COUNT=180
EXPECTED_PATCHDICT_TOTAL=182
EXPECTED_PATCHDICT_DYNAMIC=180
EXPECTED_PATCHDICT_DONOR=2

EXPECTED_INNER_SHA="986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11"
EXPECTED_DEBUG_HELPER_SHA="993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9"
EXPECTED_SOURCE_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

STAMP="$(date +%Y%m%d_%H%M%S)"
WORK="$HOME/Desktop/OCLP7_D97FY_FINAL_PRE_ROOTPATCH_GATE_${STAMP}"
EXPANDED="$WORK/expanded"
REPORT="$WORK/D97FY_REPORT.txt"
mkdir -p "$WORK"
exec > >(tee "$REPORT") 2>&1

fail() {
    echo "D97FY_STATUS=FAIL"
    echo "D97FY_REASON=$*"
    echo "D97FY_REPORT=$REPORT"
    exit 1
}

sha256() { /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

exact_bootarg() {
    local needle="$1"
    printf '%s\n' "$BOOTARGS" | /usr/bin/awk -v n="$needle" '{for(i=1;i<=NF;i++) if($i==n) found=1} END{exit(found?0:1)}'
}

team_id() {
    /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}'
}

echo "===== D97FY FINAL PRE-ROOT-PATCH GATE ====="
echo "ROOT_PATCH=NO"
echo "ROOT_VOLUME_MUTATION=NO"
echo "EFI_MUTATION=NO"
echo "NVRAM_MUTATION=NO"
echo "REBOOT=NO"

echo
echo "===== SYSTEM / BOOT ====="
[[ "$(uname -s)" == "Darwin" ]] || fail "NOT_DARWIN"
[[ "$(uname -m)" == "x86_64" ]] || fail "NOT_X86_64"
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail "NOT_25G82"
/usr/bin/sw_vers
uname -m

SYSCTL="$(command -v sysctl || true)"
[[ -x "$SYSCTL" ]] || fail "SYSCTL_NOT_FOUND"
BOOTARGS="$($SYSCTL -n kern.bootargs 2>/dev/null || true)"
echo "BOOTARGS=$BOOTARGS"
exact_bootarg "-igfxvesa" || fail "VESA_BOOTARG_NOT_ACTIVE"
exact_bootarg "-ocmcdiag" || fail "OCMCDIAG_NOT_ACTIVE"
exact_bootarg "-ocmcd97bv" || fail "D97BV_BOOTARG_NOT_ACTIVE"
if exact_bootarg "-ocmcd97ez"; then
    fail "D97EZ_ACTIVE_MODE_MUST_BE_INERT_FOR_ROOTPATCH_GATE"
fi
echo "D97FY_VESA_STATE=PASS"
echo "D97FY_D97EZ_ACTIVE_MODE=ABSENT_OR_INERT"

echo
echo "===== EXACT ORIGINAL PACKAGE ====="
[[ -f "$PKG" ]] || fail "PKG_NOT_FOUND"
PKG_SHA="$(sha256 "$PKG")"
PKG_BYTES="$(/usr/bin/stat -f '%z' "$PKG")"
echo "PKG_SHA256=$PKG_SHA"
echo "PKG_BYTES=$PKG_BYTES"
[[ "$PKG_SHA" == "$EXPECTED_PKG_SHA" ]] || fail "PKG_SHA_MISMATCH"
[[ "$PKG_BYTES" == "$EXPECTED_PKG_BYTES" ]] || fail "PKG_SIZE_MISMATCH"
echo "D97FY_ORIGINAL_PACKAGE_IDENTITY=PASS"

echo
echo "===== CORRECTED LOCAL SOURCE VS ORIGINAL PACKAGE ====="
[[ -d "$LOCAL" ]] || fail "CORRECTED_LOCAL_TREE_NOT_FOUND"
/bin/rm -rf "$EXPANDED"
/usr/sbin/pkgutil --expand-full "$PKG" "$EXPANDED"
BASE="$(/usr/bin/find "$EXPANDED" -type d -path '*/Payload/Library/Application Support/Pyquick/MetallibSupportPkg/26.6.2-25G82' -print -quit)"
[[ -n "$BASE" && -d "$BASE" ]] || fail "REAL_PAYLOAD_BASE_NOT_FOUND"
echo "REAL_PAYLOAD_BASE=$BASE"

/usr/bin/python3 - "$BASE" "$LOCAL" "$EXPECTED_REAL_METALLIB_COUNT" "$EXPECTED_CORE_SHA" <<'PY'
import hashlib, os, pathlib, sys
base=pathlib.Path(sys.argv[1]); local=pathlib.Path(sys.argv[2])
expected=int(sys.argv[3]); expected_core=sys.argv[4]

def sha(p):
    h=hashlib.sha256()
    with open(p,'rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()

def fm(root):
    return {str(p.relative_to(root)):(p.stat().st_size,sha(p)) for p in root.rglob('*') if p.is_file() and not p.is_symlink()}

def lm(root):
    d={}
    for dp,dn,fn in os.walk(root,followlinks=False):
        for n in list(dn)+list(fn):
            p=pathlib.Path(dp)/n
            if p.is_symlink(): d[str(p.relative_to(root))]=os.readlink(p)
    return d

b=fm(base); l=fm(local)
if b != l:
    missing=sorted(set(b)-set(l))[:20]
    extra=sorted(set(l)-set(b))[:20]
    mismatch=sorted(k for k in set(b)&set(l) if b[k]!=l[k])[:20]
    raise SystemExit(f'LOCAL_TREE_MISMATCH missing={missing} extra={extra} mismatch={mismatch}')
if lm(base) != lm(local): raise SystemExit('LOCAL_SYMLINK_TREE_MISMATCH')
m=[k for k in b if k.endswith('.metallib')]
if len(m)!=expected: raise SystemExit(f'REAL_METALLIB_COUNT={len(m)} expected={expected}')
for rel in m:
    p=local/rel
    with open(p,'rb') as f:
        magic=f.read(4)
    if magic != b'MTLB': raise SystemExit(f'NON_MTLB_LOCAL_METALLIB={rel} magic={magic!r}')
core='System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib'
if l[core][1]!=expected_core: raise SystemExit(f'CORE_SHA={l[core][1]}')
print(f'D97FY_LOCAL_REGULAR_FILE_COUNT={len(l)}')
print(f'D97FY_LOCAL_REAL_METALLIB_EXACT={len(m)}')
print('D97FY_LOCAL_FULL_TREE_IDENTITY=PASS')
print('D97FY_LOCAL_ALL_METALLIB_MAGIC=MTLB')
print('D97FY_CORE_SHA=PASS')
PY

echo
echo "===== CURRENT INSTALLED ROOT EXPECTED PRE-REPAIR STATE ====="
/usr/bin/python3 - "$BASE" <<'PY'
import pathlib, subprocess, sys
base=pathlib.Path(sys.argv[1])
mets=[p for p in base.rglob('*.metallib') if p.is_file() and not p.is_symlink()]
stub=exact=missing=other=0
for p in mets:
    rel=p.relative_to(base)
    q=pathlib.Path('/')/rel
    if not q.is_file():
        missing+=1; continue
    rb=p.read_bytes(); qb=q.read_bytes()
    if rb==qb:
        exact+=1
    elif qb.startswith(b'Name') and b'Unverified CRC-32' in qb:
        stub+=1
    else:
        other+=1
print(f'D97FY_INSTALLED_EXACT={exact}')
print(f'D97FY_INSTALLED_METADATA_STUB={stub}')
print(f'D97FY_INSTALLED_MISSING={missing}')
print(f'D97FY_INSTALLED_OTHER={other}')
if not (stub==180 and exact==0 and missing==0 and other==0):
    raise SystemExit('INSTALLED_ROOT_DRIFT_FROM_D97FW_PRE_REPAIR_STATE')
print('D97FY_INSTALLED_PRE_REPAIR_STATE=PASS')
PY
/bin/rm -rf "$EXPANDED"

echo
echo "===== LOCATE EXACT D97DX OUTER APP ====="
APP=""
check_candidate() {
    local c="$1"
    local exe="$c/Contents/Resources/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher"
    [[ -f "$exe" ]] || return 1
    [[ "$(sha256 "$exe")" == "$EXPECTED_INNER_SHA" ]] || return 1
    APP="$c"
    return 0
}

for C in \
    "$HOME/Desktop/OpenCore-Patcher-Tahoe-D97DX.app" \
    "$HOME/Downloads/OpenCore-Patcher-Tahoe-D97DX.app"
do
    if [[ -d "$C" ]] && check_candidate "$C"; then break; fi
done

if [[ -z "$APP" ]]; then
    while IFS= read -r C; do
        if check_candidate "$C"; then break; fi
    done < <(/usr/bin/find "$HOME/Desktop" "$HOME/Downloads" -maxdepth 4 -type d -name 'OpenCore-Patcher-Tahoe-D97DX.app' -print 2>/dev/null)
fi
[[ -n "$APP" ]] || fail "EXACT_D97DX_APP_NOT_FOUND"
echo "D97DX_APP=$APP"

INNER="$APP/Contents/Resources/OpenCore-Patcher.app"
INNER_EXE="$INNER/Contents/MacOS/OpenCore-Patcher"
DEBUG_HELPER="$APP/Contents/Resources/debug-privileged-helper"
SOURCE_DIFF="$APP/Contents/Resources/OCLP7_D97DX_SOURCE.patch"
LAUNCHER="$APP/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DX"

[[ -f "$INNER_EXE" ]] || fail "D97DX_INNER_EXE_MISSING"
[[ -f "$DEBUG_HELPER" ]] || fail "D97DX_DEBUG_HELPER_MISSING"
[[ -f "$SOURCE_DIFF" ]] || fail "D97DX_SOURCE_DIFF_MISSING"
[[ -f "$LAUNCHER" ]] || fail "D97DX_LAUNCHER_MISSING"

INNER_SHA="$(sha256 "$INNER_EXE")"
DEBUG_SHA="$(sha256 "$DEBUG_HELPER")"
DIFF_SHA="$(sha256 "$SOURCE_DIFF")"
echo "D97DX_INNER_SHA256=$INNER_SHA"
echo "D97DX_DEBUG_HELPER_SHA256=$DEBUG_SHA"
echo "D97DX_SOURCE_DIFF_SHA256=$DIFF_SHA"
[[ "$INNER_SHA" == "$EXPECTED_INNER_SHA" ]] || fail "D97DX_INNER_SHA_MISMATCH"
[[ "$DEBUG_SHA" == "$EXPECTED_DEBUG_HELPER_SHA" ]] || fail "D97DX_DEBUG_HELPER_SHA_MISMATCH"
[[ "$DIFF_SHA" == "$EXPECTED_SOURCE_DIFF_SHA" ]] || fail "D97DX_SOURCE_DIFF_SHA_MISMATCH"

LIPO="$(/usr/bin/xcrun --find lipo 2>/dev/null || command -v lipo || true)"
[[ -x "$LIPO" ]] || fail "LIPO_NOT_FOUND"
[[ "$($LIPO -archs "$INNER_EXE")" == "x86_64" ]] || fail "D97DX_INNER_ARCH_NOT_X86_64"
[[ "$($LIPO -archs "$DEBUG_HELPER")" == "x86_64" ]] || fail "D97DX_DEBUG_HELPER_ARCH_NOT_X86_64"
/usr/bin/codesign --verify --deep --strict "$INNER" || fail "D97DX_INNER_CODESIGN_FAIL"
/usr/bin/codesign --verify --strict "$DEBUG_HELPER" || fail "D97DX_DEBUG_HELPER_CODESIGN_FAIL"
/usr/bin/grep -q "$EXPECTED_OFFICIAL_HELPER_SHA" "$LAUNCHER" || fail "LAUNCHER_OFFICIAL_SHA_PIN_MISSING"
/usr/bin/grep -q "$EXPECTED_OFFICIAL_TEAM" "$LAUNCHER" || fail "LAUNCHER_OFFICIAL_TEAM_PIN_MISSING"
echo "D97FY_D97DX_ARTIFACT_IDENTITY=PASS"

# Transitive 182-entry closure: exact D97DX source diff was independently audited at D97DY
# as 182 total entries = 180 DynamicPatchset.MetallibSupportPkg + 2 unchanged 14.6.1 donors.
# D97FY freshly proves all 180 dynamic payloads exact; exact D97DX artifact/source identity
# preserves the already-audited two donor entries.
echo "D97FY_PATCHDICT_TOTAL_PRIOR_STATIC=$EXPECTED_PATCHDICT_TOTAL"
echo "D97FY_PATCHDICT_DYNAMIC_PRIOR_STATIC=$EXPECTED_PATCHDICT_DYNAMIC"
echo "D97FY_PATCHDICT_DONOR14_6_1_PRIOR_STATIC=$EXPECTED_PATCHDICT_DONOR"
echo "D97FY_PATCHDICT_DYNAMIC_CURRENT_EXACT=$EXPECTED_REAL_METALLIB_COUNT"
echo "D97FY_PATCHDICT_182_RESOLUTION=PASS_BY_EXACT_SOURCE_IDENTITY_PLUS_180_DYNAMIC_CURRENT_IDENTITY_PLUS_2_UNCHANGED_DONORS"

echo
echo "===== OFFICIAL PRIVILEGED HELPER ====="
SYSTEM_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
[[ -f "$SYSTEM_HELPER" ]] || fail "OFFICIAL_SYSTEM_HELPER_MISSING"
SYSTEM_HELPER_SHA="$(sha256 "$SYSTEM_HELPER")"
SYSTEM_HELPER_TEAM="$(team_id "$SYSTEM_HELPER")"
echo "SYSTEM_HELPER_SHA256=$SYSTEM_HELPER_SHA"
echo "SYSTEM_HELPER_TEAM=$SYSTEM_HELPER_TEAM"
/usr/bin/codesign --verify --strict "$SYSTEM_HELPER" || fail "OFFICIAL_SYSTEM_HELPER_CODESIGN_FAIL"
[[ "$SYSTEM_HELPER_SHA" == "$EXPECTED_OFFICIAL_HELPER_SHA" ]] || fail "OFFICIAL_SYSTEM_HELPER_SHA_MISMATCH"
[[ "$SYSTEM_HELPER_TEAM" == "$EXPECTED_OFFICIAL_TEAM" ]] || fail "OFFICIAL_SYSTEM_HELPER_TEAM_MISMATCH"
echo "D97FY_OFFICIAL_HELPER_IDENTITY=PASS"

echo
echo "===== FINAL ====="
echo "D97FY_STATUS=PASS"
echo "D97FY_CORRECTED_SOURCE_GATE=PASS"
echo "D97FY_D97DX_GATE=PASS"
echo "D97FY_182_ENTRY_CLOSURE=PASS"
echo "D97FY_VESA_GATE=PASS"
echo "D97FY_ROOT_PATCH=NO"
echo "D97FY_REBOOT=NO"
echo "D97FY_REPORT=$REPORT"
