#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GF — post-reboot VESA gate after corrected Root Patch.
# READ-ONLY. NO Root Patch/Restore. NO EFI/NVRAM/framebuffer changes. NO reboot.

LOCAL="/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
EXPECTED_CORE_SHA="b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d"
EXPECTED_METALLIB_COUNT=180
EXPECTED_HELPER_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_HELPER_TEAM="S74BDJXQMD"
STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GF_POSTBOOT_VESA_GATE_${STAMP}"
REPORT="$OUT/D97GF_REPORT.txt"
TSV="$OUT/D97GF_METALLIBS.tsv"
ZIP="$HOME/Desktop/OCLP7_D97GF_POSTBOOT_VESA_GATE_${STAMP}.zip"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97GF_STATUS=FAIL"; echo "D97GF_REASON=$*"; echo "D97GF_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
exact_bootarg(){ local n="$1"; printf '%s\n' "$BOOTARGS" | /usr/bin/awk -v n="$n" '{for(i=1;i<=NF;i++)if($i==n)f=1}END{exit(f?0:1)}'; }
team_id(){ /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2;exit}'; }

echo "===== D97GF POSTBOOT VESA CORRECTED-ROOTPATCH GATE ====="
echo "ROOT_PATCH=NO"
echo "RESTORE=NO"
echo "EFI_MUTATION=NO"
echo "NVRAM_MUTATION=NO"
echo "FRAMEBUFFER_MUTATION=NO"
echo "REBOOT=NO"

echo; echo "===== SYSTEM / BOOT ====="
[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == 25G82 ]] || fail NOT_25G82
/usr/bin/sw_vers
uname -m
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || /usr/bin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "BOOTARGS=$BOOTARGS"
exact_bootarg -igfxvesa || fail VESA_NOT_ACTIVE
exact_bootarg -ocmcdiag || fail OCMCDIAG_NOT_ACTIVE
exact_bootarg -ocmcd97bv || fail D97BV_NOT_ACTIVE
if exact_bootarg -ocmcd97ez; then fail D97EZ_ACTIVE_MODE_MUST_BE_INERT; fi
echo "D97GF_VESA_GATE=PASS"

echo; echo "===== ACTIVE SNAPSHOT METALLIB IDENTITY ====="
[[ -d "$LOCAL" ]] || fail LOCAL_SOURCE_MISSING
printf 'RELATIVE_PATH\tLOCAL_SHA256\tACTIVE_SHA256\tSTATUS\n' > "$TSV"
/usr/bin/python3 - "$LOCAL" "$TSV" "$EXPECTED_METALLIB_COUNT" "$EXPECTED_CORE_SHA" <<'PY'
import hashlib,pathlib,sys
local=pathlib.Path(sys.argv[1]); tsv=pathlib.Path(sys.argv[2]); exp=int(sys.argv[3]); core_sha=sys.argv[4]
def sha(b): return hashlib.sha256(b).hexdigest()
mets=sorted(p for p in local.rglob('*.metallib') if p.is_file() and not p.is_symlink())
if len(mets)!=exp: raise SystemExit(f'LOCAL_COUNT={len(mets)} expected={exp}')
exact=missing=diff=stub=0
bad=[]
with tsv.open('a') as o:
    for lp in mets:
        rel=lp.relative_to(local); rp=pathlib.Path('/')/rel
        lb=lp.read_bytes(); ls=sha(lb)
        if not rp.is_file():
            missing+=1; rs=''; st='MISSING'; bad.append((str(rel),st))
        else:
            rb=rp.read_bytes(); rs=sha(rb)
            isstub=rb.startswith(b'Name') and b'Unverified CRC-32' in rb
            if isstub: stub+=1
            if rb==lb: exact+=1; st='EXACT'
            else: diff+=1; st='DIFFERENT_STUB' if isstub else 'DIFFERENT'; bad.append((str(rel),st))
        o.write(f'{rel}\t{ls}\t{rs}\t{st}\n')
print(f'D97GF_ACTIVE_METALLIB_EXACT={exact}')
print(f'D97GF_ACTIVE_METALLIB_MISSING={missing}')
print(f'D97GF_ACTIVE_METALLIB_DIFFERENT={diff}')
print(f'D97GF_ACTIVE_METADATA_STUB={stub}')
if bad: print('D97GF_MISMATCH_SAMPLES='+';'.join(f'{p}:{s}' for p,s in bad[:20]))
if not(exact==exp and missing==0 and diff==0 and stub==0): raise SystemExit('ACTIVE_METALLIB_IDENTITY_FAIL')
core=pathlib.Path('/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib')
cb=core.read_bytes(); cs=sha(cb)
print(f'D97GF_ACTIVE_CORE_BYTES={len(cb)}')
print(f'D97GF_ACTIVE_CORE_SHA256={cs}')
print(f'D97GF_ACTIVE_CORE_MAGIC={cb[:4].hex()}')
if len(cb)!=20739 or cs!=core_sha or cb[:4]!=b'MTLB': raise SystemExit('ACTIVE_CORE_IDENTITY_FAIL')
print('D97GF_ACTIVE_CORE_IDENTITY=PASS')
print('D97GF_180_ACTIVE_METALLIB_IDENTITY=PASS')
PY

echo; echo "===== HASWELL DATA KEXTS / AUXKC ====="
for K in AppleIntelFramebufferAzul.kext AppleIntelHD5000Graphics.kext; do
  P="/Library/Extensions/$K"; [[ -d "$P" ]] || fail "DATA_KEXT_MISSING_$K"
  OBR="$(/usr/bin/plutil -extract OSBundleRequired raw "$P/Contents/Info.plist" 2>/dev/null || true)"
  BID="$(/usr/bin/plutil -extract CFBundleIdentifier raw "$P/Contents/Info.plist" 2>/dev/null || true)"
  echo "KEXT=$K"; echo "CFBundleIdentifier=$BID"; echo "OSBundleRequired=$OBR"
  [[ "$OBR" == Auxiliary ]] || fail "OSBUNDLEREQUIRED_NOT_AUXILIARY_$K"
done
AUXPL="/private/var/db/KernelExtensionManagement/AuxKC/CurrentAuxKC/com.apple.kcgen.instructions.plist"
[[ -f "$AUXPL" ]] || fail AUXKC_INSTRUCTIONS_MISSING
sudo /usr/bin/python3 - "$AUXPL" <<'PY'
import plistlib,sys
with open(sys.argv[1],'rb') as f:p=plistlib.load(f)
w={'/Library/Extensions/AppleIntelFramebufferAzul.kext','/Library/Extensions/AppleIntelHD5000Graphics.kext'}
e=p.get('kextsToBuild',{}); vals=e.values() if isinstance(e,dict) else e
fnd={v.get('bundlePathMainOS') for v in vals if isinstance(v,dict)} & w
print(f'D97GF_AUXKC_MATCH_COUNT={len(fnd)}')
if fnd!=w: raise SystemExit('AUXKC_TARGETS_MISSING')
print('D97GF_AUXKC_INSTRUCTIONS=PASS')
PY

echo; echo "===== LOADED-STATE OBSERVATION ====="
/usr/bin/kmutil showloaded 2>/dev/null | /usr/bin/grep -E 'AppleIntelFramebufferAzul|AppleIntelHD5000Graphics' || echo "D97GF_HASWELL_KEXTS_NOT_LISTED_UNDER_VESA"

echo; echo "===== OFFICIAL HELPER ====="
HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"
[[ -f "$HELPER" ]] || fail OFFICIAL_HELPER_MISSING
HS="$(sha256 "$HELPER")"; HT="$(team_id "$HELPER")"
echo "HELPER_SHA256=$HS"; echo "HELPER_TEAM=$HT"
/usr/bin/codesign --verify --strict "$HELPER" || fail HELPER_CODESIGN_FAIL
[[ "$HS" == "$EXPECTED_HELPER_SHA" ]] || fail HELPER_SHA_MISMATCH
[[ "$HT" == "$EXPECTED_HELPER_TEAM" ]] || fail HELPER_TEAM_MISMATCH
echo "D97GF_OFFICIAL_HELPER_IDENTITY=PASS"

echo; echo "===== BOOT HISTORY ====="
/usr/bin/last reboot | /usr/bin/head -n 5 || true

echo; echo "===== PACKAGE EVIDENCE ====="
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
echo "D97GF_ZIP=$ZIP"
echo "D97GF_ZIP_SHA256=$(sha256 "$ZIP")"
echo "D97GF_ZIP_BYTES=$(/usr/bin/stat -f '%z' "$ZIP")"

echo; echo "===== FINAL ====="
echo "D97GF_STATUS=PASS"
echo "D97GF_POSTBOOT_VESA_ROOTPATCH=PASS"
echo "D97GF_180_ACTIVE_METALLIB_IDENTITY=PASS"
echo "D97GF_ACTIVE_CORE_IDENTITY=PASS"
echo "D97GF_AUXKC_INSTRUCTIONS=PASS"
echo "D97GF_OFFICIAL_HELPER_IDENTITY=PASS"
echo "D97GF_ACCELERATION=NOT_TESTED"
echo "D97GF_REBOOT=NO"
echo "D97GF_REPORT=$REPORT"
