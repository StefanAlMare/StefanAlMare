#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GC — read-only audit of the just-patched underlying APFS System volume.
# NO Root Patch. NO Restore. NO root-volume writes. NO EFI/NVRAM/framebuffer changes. NO reboot.

LOCAL="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_REAL_METALLIB_COUNT=180
EXPECTED_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_HELPER_TEAM="S74BDJXQMD"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GC_POSTPATCH_SYSTEM_VOLUME_AUDIT_${STAMP}"
REPORT="$OUT/D97GC_REPORT.txt"
TSV="$OUT/D97GC_METALLIBS.tsv"
MNT="/private/tmp/OCLP7_D97GC_SYSVOL_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97GC_POSTPATCH_SYSTEM_VOLUME_AUDIT_${STAMP}.zip"

mkdir -p "$OUT" "$MNT"
exec > >(tee "$REPORT") 2>&1

MOUNTED=0
cleanup() {
    set +e
    if [[ "$MOUNTED" == "1" ]]; then
        sudo /sbin/umount "$MNT" >/dev/null 2>&1 || true
    fi
    /bin/rmdir "$MNT" >/dev/null 2>&1 || true
}
trap cleanup EXIT

fail() {
    echo "D97GC_STATUS=FAIL"
    echo "D97GC_REASON=$*"
    echo "D97GC_REPORT=$REPORT"
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

echo "===== D97GC POST-PATCH SYSTEM-VOLUME AUDIT ====="
echo "ROOT_PATCH=NO"
echo "RESTORE=NO"
echo "SYSTEM_VOLUME_WRITE=NO"
echo "EFI_MUTATION=NO"
echo "NVRAM_MUTATION=NO"
echo "FRAMEBUFFER_MUTATION=NO"
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
echo "D97GC_VESA_GATE=PASS"

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
m=[p for p in root.rglob('*.metallib') if p.is_file() and not p.is_symlink()]
if len(m)!=expected: raise SystemExit(f'LOCAL_METALLIB_COUNT={len(m)} expected={expected}')
for p in m:
    with open(p,'rb') as f: magic=f.read(4)
    if magic!=b'MTLB': raise SystemExit(f'LOCAL_NON_MTLB={p.relative_to(root)} magic={magic!r}')
core=root/'System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib'
if not core.is_file(): raise SystemExit('LOCAL_CORE_MISSING')
if sha(core)!=core_sha: raise SystemExit(f'LOCAL_CORE_SHA={sha(core)}')
print(f'D97GC_LOCAL_METALLIB_COUNT={len(m)}')
print('D97GC_LOCAL_ALL_MTLB=PASS')
print('D97GC_LOCAL_CORE_SHA=PASS')
PY

echo
echo "===== LOCATE UNDERLYING APFS SYSTEM VOLUME ====="
SNAPS="$(/usr/sbin/diskutil apfs listSnapshots / 2>&1 || true)"
printf '%s\n' "$SNAPS" > "$OUT/D97GC_SNAPSHOTS.txt"
SYSVOL="$(printf '%s\n' "$SNAPS" | /usr/bin/sed -n 's/^Snapshots for \(disk[^ ]*\).*/\1/p' | /usr/bin/head -n 1)"

if [[ -z "$SYSVOL" ]]; then
    ROOTDEV="$(/usr/sbin/diskutil info / | /usr/bin/awk '/Device Identifier:/ {print $3; exit}')"
    [[ -n "$ROOTDEV" ]] || fail "ROOT_DEVICE_NOT_FOUND"
    # Current root commonly appears as snapshot diskXsYsZ; strip only the final snapshot suffix.
    SYSVOL="$(printf '%s' "$ROOTDEV" | /usr/bin/sed -E 's/(disk[0-9]+s[0-9]+)s[0-9]+$/\1/')"
fi

echo "D97GC_SYSTEM_VOLUME=$SYSVOL"
[[ "$SYSVOL" =~ ^disk[0-9]+s[0-9]+$ ]] || fail "SYSTEM_VOLUME_PARSE_FAILED_$SYSVOL"
[[ -e "/dev/$SYSVOL" ]] || fail "SYSTEM_VOLUME_DEVICE_MISSING"

echo
echo "===== READ-ONLY MOUNT ====="
sudo /sbin/mount_apfs -o rdonly,nobrowse "/dev/$SYSVOL" "$MNT" || fail "READONLY_MOUNT_FAILED"
MOUNTED=1
MOUNT_LINE="$(/sbin/mount | /usr/bin/grep " on $MNT " || true)"
echo "MOUNT_LINE=$MOUNT_LINE"
[[ -n "$MOUNT_LINE" ]] || fail "AUDIT_MOUNT_NOT_VISIBLE"
printf '%s\n' "$MOUNT_LINE" | /usr/bin/grep -Eq 'read-only|rdonly' || fail "AUDIT_MOUNT_NOT_READONLY"
echo "D97GC_READONLY_MOUNT=PASS"

echo
echo "===== BYTE-FOR-BYTE METALLIB AUDIT ====="
printf 'RELATIVE_PATH\tLOCAL_BYTES\tLOCAL_SHA256\tPATCHED_BYTES\tPATCHED_SHA256\tSTATUS\n' > "$TSV"

/usr/bin/python3 - "$LOCAL" "$MNT" "$TSV" "$EXPECTED_REAL_METALLIB_COUNT" "$EXPECTED_CORE_SHA" <<'PY'
import hashlib, pathlib, sys
local=pathlib.Path(sys.argv[1]); mnt=pathlib.Path(sys.argv[2]); tsv=pathlib.Path(sys.argv[3])
expected=int(sys.argv[4]); core_expected=sys.argv[5]
def sha_bytes(b): return hashlib.sha256(b).hexdigest()
def sha_file(p):
    h=hashlib.sha256()
    with open(p,'rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
mets=sorted(p for p in local.rglob('*.metallib') if p.is_file() and not p.is_symlink())
if len(mets)!=expected: raise SystemExit(f'LOCAL_COUNT={len(mets)} expected={expected}')
exact=missing=different=stub=0
bad=[]
with tsv.open('a') as out:
    for lp in mets:
        rel=lp.relative_to(local)
        rp=mnt/rel
        lb=lp.read_bytes(); lsha=sha_bytes(lb)
        if not rp.is_file():
            missing+=1; status='MISSING'; rbytes=''; rsha=''; bad.append((str(rel),status))
        else:
            rb=rp.read_bytes(); rsha=sha_bytes(rb); rbytes=str(len(rb))
            is_stub=rb.startswith(b'Name') and b'Unverified CRC-32' in rb
            if is_stub: stub+=1
            if rb==lb:
                exact+=1; status='EXACT'
            else:
                different+=1; status='DIFFERENT_STUB' if is_stub else 'DIFFERENT'
                bad.append((str(rel),status))
        out.write(f'{rel}\t{len(lb)}\t{lsha}\t{rbytes}\t{rsha}\t{status}\n')
print(f'D97GC_PATCHED_METALLIB_EXACT={exact}')
print(f'D97GC_PATCHED_METALLIB_MISSING={missing}')
print(f'D97GC_PATCHED_METALLIB_DIFFERENT={different}')
print(f'D97GC_PATCHED_METADATA_STUB={stub}')
if bad:
    print('D97GC_MISMATCH_SAMPLES='+';'.join(f'{p}:{s}' for p,s in bad[:20]))
if not (exact==expected and missing==0 and different==0 and stub==0):
    raise SystemExit('PATCHED_METALLIB_IDENTITY_FAIL')
core_rel=pathlib.Path('System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib')
cp=mnt/core_rel
if not cp.is_file(): raise SystemExit('PATCHED_CORE_MISSING')
cb=cp.read_bytes(); csha=sha_bytes(cb)
print(f'D97GC_PATCHED_CORE_BYTES={len(cb)}')
print(f'D97GC_PATCHED_CORE_SHA256={csha}')
print(f'D97GC_PATCHED_CORE_MAGIC={cb[:4].hex()}')
if len(cb)!=20739: raise SystemExit(f'PATCHED_CORE_BYTES={len(cb)}')
if csha!=core_expected: raise SystemExit('PATCHED_CORE_SHA_MISMATCH')
if cb[:4]!=b'MTLB': raise SystemExit('PATCHED_CORE_MAGIC_NOT_MTLB')
print('D97GC_PATCHED_CORE_IDENTITY=PASS')
print('D97GC_180_DYNAMIC_METALLIB_IDENTITY=PASS')
PY

echo
echo "===== PATCHED HASWELL DRIVER PRESENCE ====="
for P in \
  "System/Library/Extensions/AppleIntelFramebufferAzul.kext" \
  "System/Library/Extensions/AppleIntelHD5000Graphics.kext" \
  "System/Library/Extensions/AppleIntelHD5000GraphicsMTLDriver.bundle"
do
    if [[ -e "$MNT/$P" ]]; then
        echo "PRESENT=/$P"
    else
        fail "PATCHED_DRIVER_MISSING_/$P"
    fi
done
echo "D97GC_HASWELL_DRIVER_PRESENCE=PASS"

echo
echo "===== PATCHED COREDISPLAY QUICK TYPE ====="
/usr/bin/file "$MNT/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib"

echo
echo "===== OFFICIAL PRIVILEGED HELPER ====="
HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
[[ -f "$HELPER" ]] || fail "OFFICIAL_HELPER_MISSING"
HELPER_SHA="$(sha256 "$HELPER")"
HELPER_TEAM="$(team_id "$HELPER")"
echo "HELPER_SHA256=$HELPER_SHA"
echo "HELPER_TEAM=$HELPER_TEAM"
/usr/bin/codesign --verify --strict "$HELPER" || fail "OFFICIAL_HELPER_CODESIGN_FAIL"
[[ "$HELPER_SHA" == "$EXPECTED_HELPER_SHA" ]] || fail "OFFICIAL_HELPER_SHA_MISMATCH"
[[ "$HELPER_TEAM" == "$EXPECTED_HELPER_TEAM" ]] || fail "OFFICIAL_HELPER_TEAM_MISMATCH"
echo "D97GC_OFFICIAL_HELPER_IDENTITY=PASS"

echo
echo "===== UNMOUNT AUDIT VOLUME ====="
sudo /sbin/umount "$MNT" || fail "AUDIT_UNMOUNT_FAILED"
MOUNTED=0
/bin/rmdir "$MNT" || true
echo "D97GC_AUDIT_UNMOUNT=PASS"

echo
echo "===== PACKAGE EVIDENCE ====="
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
echo "D97GC_ZIP=$ZIP"
echo "D97GC_ZIP_SHA256=$(sha256 "$ZIP")"
echo "D97GC_ZIP_BYTES=$(/usr/bin/stat -f '%z' "$ZIP")"

echo
echo "===== FINAL ====="
echo "D97GC_STATUS=PASS"
echo "D97GC_PATCHED_SYSTEM_VOLUME=PASS"
echo "D97GC_180_DYNAMIC_METALLIB_IDENTITY=PASS"
echo "D97GC_PATCHED_CORE_IDENTITY=PASS"
echo "D97GC_HASWELL_DRIVER_PRESENCE=PASS"
echo "D97GC_OFFICIAL_HELPER_IDENTITY=PASS"
echo "D97GC_REBOOT=NO"
echo "D97GC_REPORT=$REPORT"
