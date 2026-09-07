#!/bin/bash
set -Eeuo pipefail

PKG="$HOME/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg"
EXPECTED_PKG_SHA="602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3"
EXPECTED_PKG_BYTES="116574513"
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_REAL_METALLIB_COUNT=180

LOCAL_PARENT="/Library/Application Support/Dortania/MetallibSupportPkg"
LOCAL="$LOCAL_PARENT/26.6.2-25G82"

STAMP="$(date +%Y%m%d_%H%M%S)"
WORK="$HOME/Desktop/OCLP7_D97FX_SOURCE_RECONSTRUCT_${STAMP}"
EXPANDED="$WORK/expanded"
STAGE_ROOT="$WORK/stage"
STAGE="$STAGE_ROOT/26.6.2-25G82"
REPORT="$WORK/D97FX_REPORT.txt"
BACKUP="$LOCAL_PARENT/26.6.2-25G82.D97FX_STUB_BACKUP_${STAMP}"

mkdir -p "$WORK" "$STAGE_ROOT"
exec > >(tee "$REPORT") 2>&1

fail() {
    echo "D97FX_STATUS=FAIL"
    echo "D97FX_REASON=$*"
    exit 1
}

echo "===== D97FX SOURCE RECONSTRUCTION ====="
echo "ROOT_PATCH=NO"
echo "ROOT_VOLUME_MUTATION=NO"
echo "EFI_MUTATION=NO"
echo "NVRAM_MUTATION=NO"
echo "REBOOT=NO"

[[ "$(uname -s)" == "Darwin" ]] || fail "NOT_DARWIN"
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail "NOT_25G82"
[[ -f "$PKG" ]] || fail "PKG_NOT_FOUND"
[[ -d "$LOCAL" ]] || fail "CURRENT_LOCAL_TREE_NOT_FOUND"

PKG_SHA="$(/usr/bin/shasum -a 256 "$PKG" | /usr/bin/awk '{print $1}')"
PKG_BYTES="$(/usr/bin/stat -f '%z' "$PKG")"
echo "PKG_SHA256=$PKG_SHA"
echo "PKG_BYTES=$PKG_BYTES"
[[ "$PKG_SHA" == "$EXPECTED_PKG_SHA" ]] || fail "PKG_SHA_MISMATCH"
[[ "$PKG_BYTES" == "$EXPECTED_PKG_BYTES" ]] || fail "PKG_SIZE_MISMATCH"

CURRENT_CORE="$LOCAL/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
[[ -f "$CURRENT_CORE" ]] || fail "CURRENT_CORE_STUB_MISSING"
CURRENT_CORE_SHA="$(/usr/bin/shasum -a 256 "$CURRENT_CORE" | /usr/bin/awk '{print $1}')"
CURRENT_CORE_BYTES="$(/usr/bin/stat -f '%z' "$CURRENT_CORE")"
CURRENT_CORE_TYPE="$(/usr/bin/file -b "$CURRENT_CORE")"
echo "CURRENT_CORE_SHA256=$CURRENT_CORE_SHA"
echo "CURRENT_CORE_BYTES=$CURRENT_CORE_BYTES"
echo "CURRENT_CORE_TYPE=$CURRENT_CORE_TYPE"
[[ "$CURRENT_CORE_TYPE" == *"ASCII text"* ]] || fail "CURRENT_TREE_NO_LONGER_MATCHES_STUB_STATE"

/bin/rm -rf "$EXPANDED" "$STAGE"
/usr/sbin/pkgutil --expand-full "$PKG" "$EXPANDED"

BASE="$(/usr/bin/find "$EXPANDED" -type d -path '*/Payload/Library/Application Support/Pyquick/MetallibSupportPkg/26.6.2-25G82' -print -quit)"
[[ -n "$BASE" && -d "$BASE" ]] || fail "REAL_PAYLOAD_BASE_NOT_FOUND"
echo "REAL_PAYLOAD_BASE=$BASE"

/usr/bin/ditto "$BASE" "$STAGE"

/usr/bin/python3 - "$BASE" "$STAGE" "$EXPECTED_REAL_METALLIB_COUNT" "$EXPECTED_CORE_SHA" <<'PY'
import hashlib, os, pathlib, sys
base = pathlib.Path(sys.argv[1])
stage = pathlib.Path(sys.argv[2])
expected_metallibs = int(sys.argv[3])
expected_core_sha = sys.argv[4]

def sha(p):
    h=hashlib.sha256()
    with open(p,'rb') as f:
        for b in iter(lambda:f.read(1024*1024), b''):
            h.update(b)
    return h.hexdigest()

def regular_map(root):
    out={}
    for p in root.rglob('*'):
        if p.is_file() and not p.is_symlink():
            out[str(p.relative_to(root))]=(p.stat().st_size, sha(p))
    return out

def symlink_map(root):
    out={}
    for dirpath, dirnames, filenames in os.walk(root, followlinks=False):
        for name in list(dirnames)+list(filenames):
            p=pathlib.Path(dirpath)/name
            if p.is_symlink():
                out[str(p.relative_to(root))]=os.readlink(p)
    return out

bfiles=regular_map(base)
sfiles=regular_map(stage)
if bfiles != sfiles:
    missing=sorted(set(bfiles)-set(sfiles))[:20]
    extra=sorted(set(sfiles)-set(bfiles))[:20]
    mismatch=sorted(k for k in set(bfiles)&set(sfiles) if bfiles[k]!=sfiles[k])[:20]
    raise SystemExit(f"STAGE_REGULAR_TREE_MISMATCH missing={missing} extra={extra} mismatch={mismatch}")

blinks=symlink_map(base)
slinks=symlink_map(stage)
if blinks != slinks:
    raise SystemExit(f"STAGE_SYMLINK_TREE_MISMATCH base={len(blinks)} stage={len(slinks)}")

mets=[k for k in bfiles if k.endswith('.metallib')]
if len(mets) != expected_metallibs:
    raise SystemExit(f"REAL_METALLIB_COUNT={len(mets)} expected={expected_metallibs}")

for rel in mets:
    if bfiles[rel] != sfiles[rel]:
        raise SystemExit(f"METALLIB_STAGE_MISMATCH={rel}")

core='System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib'
if core not in sfiles:
    raise SystemExit('CORE_NOT_IN_STAGE')
if sfiles[core][1] != expected_core_sha:
    raise SystemExit(f"CORE_SHA_MISMATCH={sfiles[core][1]}")
with open(stage/core,'rb') as f:
    if f.read(4) != b'MTLB':
        raise SystemExit('CORE_MAGIC_NOT_MTLB')

print(f"D97FX_STAGE_REGULAR_FILE_COUNT={len(sfiles)}")
print(f"D97FX_STAGE_SYMLINK_COUNT={len(slinks)}")
print(f"D97FX_STAGE_REAL_METALLIB_COUNT={len(mets)}")
print("D97FX_STAGE_FULL_TREE_IDENTITY=PASS")
print("D97FX_STAGE_CORE_MTLB=PASS")
PY

echo "===== ATOMIC SOURCE SWAP ====="
echo "BACKUP_PATH=$BACKUP"

sudo /bin/bash -c '
set -e
local_tree="$1"
backup="$2"
stage="$3"
parent="$4"
/bin/mkdir -p "$parent"
/bin/mv "$local_tree" "$backup"
if ! /bin/mv "$stage" "$local_tree"; then
    /bin/mv "$backup" "$local_tree" || true
    exit 1
fi
/usr/sbin/chown -R root:wheel "$local_tree"
' _ "$LOCAL" "$BACKUP" "$STAGE" "$LOCAL_PARENT" || fail "ATOMIC_SWAP_FAILED"

# Post-swap exhaustive verification. On failure, restore the original stub source tree.
if ! /usr/bin/python3 - "$BASE" "$LOCAL" "$EXPECTED_REAL_METALLIB_COUNT" "$EXPECTED_CORE_SHA" <<'PY'
import hashlib, os, pathlib, sys
base=pathlib.Path(sys.argv[1]); local=pathlib.Path(sys.argv[2]); exp=int(sys.argv[3]); core_sha=sys.argv[4]
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
if b!=l: raise SystemExit('POSTSWAP_REGULAR_TREE_MISMATCH')
if lm(base)!=lm(local): raise SystemExit('POSTSWAP_SYMLINK_TREE_MISMATCH')
m=[k for k in b if k.endswith('.metallib')]
if len(m)!=exp: raise SystemExit(f'POSTSWAP_METALLIB_COUNT={len(m)}')
core='System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib'
if l[core][1]!=core_sha: raise SystemExit('POSTSWAP_CORE_SHA_MISMATCH')
with open(local/core,'rb') as f:
    if f.read(4)!=b'MTLB': raise SystemExit('POSTSWAP_CORE_MAGIC_BAD')
print(f'D97FX_POSTSWAP_METALLIB_EXACT={len(m)}')
print('D97FX_POSTSWAP_FULL_TREE_IDENTITY=PASS')
PY
then
    echo "POSTSWAP_VERIFY_FAILED_ROLLING_BACK=YES"
    sudo /bin/bash -c '
set -e
local_tree="$1"; backup="$2"; failed="$3"
/bin/mv "$local_tree" "$failed"
/bin/mv "$backup" "$local_tree"
' _ "$LOCAL" "$BACKUP" "${LOCAL}.D97FX_FAILED_${STAMP}" || true
    fail "POSTSWAP_VERIFY_FAILED_ROLLED_BACK"
fi

CORE="$LOCAL/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"
echo "CORRECTED_CORE_SHA256=$(/usr/bin/shasum -a 256 "$CORE" | /usr/bin/awk '{print $1}')"
echo "CORRECTED_CORE_BYTES=$(/usr/bin/stat -f '%z' "$CORE")"
echo "CORRECTED_CORE_TYPE=$(/usr/bin/file -b "$CORE")"

/bin/rm -rf "$EXPANDED"

echo "D97FX_STATUS=PASS"
echo "D97FX_SOURCE_RECONSTRUCTION=PASS"
echo "D97FX_BACKUP=$BACKUP"
echo "D97FX_ROOT_PATCH=NO"
echo "D97FX_REBOOT=NO"
