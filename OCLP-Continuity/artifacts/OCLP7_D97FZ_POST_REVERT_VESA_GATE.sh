#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97FZ — read-only post-APFS-revert gate before corrected Root Patch.
# NO Root Patch. NO root-volume mutation. NO EFI/NVRAM mutation. NO reboot.

LOCAL="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_REAL_METALLIB_COUNT=180
EXPECTED_OFFICIAL_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97FZ_POST_REVERT_VESA_GATE_${STAMP}.txt"
exec > >(tee "$OUT") 2>&1

fail() {
    echo "D97FZ_STATUS=FAIL"
    echo "D97FZ_REASON=$*"
    echo "D97FZ_REPORT=$OUT"
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

echo "===== D97FZ POST-REVERT VESA GATE ====="
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
    fail "D97EZ_ACTIVE_MODE_MUST_BE_INERT"
fi
echo "D97FZ_VESA_STATE=PASS"

echo
echo "===== CORRECTED LOCAL SOURCE ====="
[[ -d "$LOCAL" ]] || fail "CORRECTED_LOCAL_TREE_NOT_FOUND"
/usr/bin/python3 - "$LOCAL" "$EXPECTED_REAL_METALLIB_COUNT" "$EXPECTED_CORE_SHA" <<'PY'
import hashlib, pathlib, sys
root=pathlib.Path(sys.argv[1]); expected=int(sys.argv[2]); core_sha=sys.argv[3]
def sha(p):
    h=hashlib.sha256()
    with open(p,'rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
mets=[p for p in root.rglob('*.metallib') if p.is_file() and not p.is_symlink()]
if len(mets)!=expected: raise SystemExit(f'LOCAL_METALLIB_COUNT={len(mets)} expected={expected}')
for p in mets:
    with open(p,'rb') as f: magic=f.read(4)
    if magic!=b'MTLB': raise SystemExit(f'LOCAL_NON_MTLB={p.relative_to(root)} magic={magic!r}')
core=root/'System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib'
if not core.is_file(): raise SystemExit('LOCAL_CORE_MISSING')
if sha(core)!=core_sha: raise SystemExit(f'LOCAL_CORE_SHA={sha(core)}')
print(f'D97FZ_LOCAL_METALLIB_COUNT={len(mets)}')
print('D97FZ_LOCAL_ALL_MTLB=PASS')
print('D97FZ_LOCAL_CORE_SHA=PASS')
PY

echo
echo "===== INSTALLED ROOT AFTER REVERT ====="
/usr/bin/python3 - "$LOCAL" <<'PY'
import hashlib, pathlib, sys
local=pathlib.Path(sys.argv[1])
mets=[p for p in local.rglob('*.metallib') if p.is_file() and not p.is_symlink()]
stub=exact=mtlb=missing=other=0
samples=[]
for lp in mets:
    rel=lp.relative_to(local)
    rp=pathlib.Path('/')/rel
    if not rp.is_file():
        missing+=1
        continue
    lb=lp.read_bytes(); rb=rp.read_bytes()
    if rb==lb:
        exact+=1
    if rb[:4]==b'MTLB':
        mtlb+=1
    elif rb.startswith(b'Name') and b'Unverified CRC-32' in rb:
        stub+=1
        if len(samples)<20: samples.append(str(rel))
    else:
        other+=1
print(f'D97FZ_INSTALLED_CORRECTED_EXACT={exact}')
print(f'D97FZ_INSTALLED_MTLB={mtlb}')
print(f'D97FZ_INSTALLED_METADATA_STUB={stub}')
print(f'D97FZ_INSTALLED_MISSING={missing}')
print(f'D97FZ_INSTALLED_OTHER_NONSTUB={other}')
if samples:
    print('D97FZ_STUB_SAMPLES='+';'.join(samples))
if stub!=0:
    raise SystemExit(f'POST_REVERT_METADATA_STUBS_REMAIN={stub}')
print('D97FZ_INSTALLED_STUB_LAYER_REMOVED=PASS')
PY

SYS_CORE="/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
echo
echo "===== SYSTEM COREDISPLAY DEFAULT.METALLIB ====="
if [[ -f "$SYS_CORE" ]]; then
    SYS_CORE_BYTES="$(/usr/bin/stat -f '%z' "$SYS_CORE")"
    SYS_CORE_SHA="$(sha256 "$SYS_CORE")"
    SYS_CORE_TYPE="$(/usr/bin/file -b "$SYS_CORE")"
    echo "SYSTEM_CORE_PRESENT=YES"
    echo "SYSTEM_CORE_BYTES=$SYS_CORE_BYTES"
    echo "SYSTEM_CORE_SHA256=$SYS_CORE_SHA"
    echo "SYSTEM_CORE_TYPE=$SYS_CORE_TYPE"
    if [[ "$SYS_CORE_TYPE" == *"ASCII text"* ]] && /usr/bin/grep -q '^Name[[:space:]]*:' "$SYS_CORE" 2>/dev/null; then
        fail "SYSTEM_CORE_METADATA_STUB_REMAINS"
    fi
    echo "D97FZ_SYSTEM_CORE_NOT_METADATA_STUB=PASS"
else
    echo "SYSTEM_CORE_PRESENT=NO"
    echo "D97FZ_SYSTEM_CORE_NOT_METADATA_STUB=PASS_BY_ABSENCE"
fi

echo
echo "===== LEGACY HASWELL LOAD OBSERVATION ====="
/usr/bin/kmutil showloaded 2>/dev/null | /usr/bin/grep -E 'AppleIntelHD5000Graphics|AppleIntelFramebufferAzul' || echo "D97FZ_LEGACY_HASWELL_KEXTS_NOT_LISTED"

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
echo "D97FZ_OFFICIAL_HELPER_IDENTITY=PASS"

echo
echo "===== FINAL ====="
echo "D97FZ_STATUS=PASS"
echo "D97FZ_POST_REVERT_GATE=PASS"
echo "D97FZ_INSTALLED_STUB_LAYER_REMOVED=PASS"
echo "D97FZ_CORRECTED_LOCAL_SOURCE=PASS"
echo "D97FZ_VESA_GATE=PASS"
echo "D97FZ_ROOT_PATCH=NO"
echo "D97FZ_REBOOT=NO"
echo "D97FZ_REPORT=$OUT"
