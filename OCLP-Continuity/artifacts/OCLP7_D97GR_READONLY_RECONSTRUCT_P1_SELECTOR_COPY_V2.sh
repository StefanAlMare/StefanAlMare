#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GR — fixed reconstruction of historical P1 selector bridge on a disposable copy only.
# Supersedes D97GQ, which stopped because `cp -p` attempted to copy protected filesystem flags.
# NO system/root/EFI/NVRAM/framebuffer mutation. NO Root Patch/Restore. NO reboot.

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
EXPECTED_ORIGINAL_SHA="31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5"
EXPECTED_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
PREIMAGE_HEX="81fe19790000"
POSTIMAGE_HEX="81fe177d0000"
OFFSET=$((0x3494))

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GR_P1_RECONSTRUCTION_${STAMP}"
COPY="$OUT/MTLCompilerService.P1.copy"
REPORT="$OUT/D97GR_REPORT.txt"
ZIP="$HOME/Desktop/OCLP7_D97GR_P1_RECONSTRUCTION_${STAMP}.zip"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97GR_STATUS=FAIL"; echo "D97GR_REASON=$*"; echo "D97GR_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }

cat <<'HDR'
===== D97GR READ-ONLY P1 SELECTOR RECONSTRUCTION V2 =====
SYSTEM_MUTATION=NO
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
PATCH_TARGET=DISPOSABLE_COPY_ONLY
COPY_METADATA_PRESERVATION=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == 25G82 ]] || fail NOT_25G82
[[ -f "$SERVICE" ]] || fail SERVICE_MISSING

BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE_IN_RECOVERY || true

echo
echo "===== ORIGINAL ====="
ORIG_SHA="$(sha256 "$SERVICE")"
echo "D97GR_ORIGINAL_SHA256=$ORIG_SHA"
[[ "$ORIG_SHA" == "$EXPECTED_ORIGINAL_SHA" ]] || fail ORIGINAL_SHA_MISMATCH

# Intentionally do NOT use -p: filesystem flags/ownership/timestamps are irrelevant to byte identity
# and protected SSV flags caused D97GQ's tooling false negative.
/bin/rm -f "$COPY"
/bin/cp "$SERVICE" "$COPY" || fail COPY_FAILED
[[ -f "$COPY" ]] || fail COPY_MISSING_AFTER_CP
COPY_SHA="$(sha256 "$COPY")"
echo "D97GR_COPY_SHA256_BEFORE_PATCH=$COPY_SHA"
[[ "$COPY_SHA" == "$ORIG_SHA" ]] || fail COPY_BYTE_IDENTITY_MISMATCH
/bin/chmod u+w "$COPY" || fail COPY_CHMOD_FAILED

echo "D97GR_COPY_BYTE_IDENTITY=PASS"

/usr/bin/python3 - "$COPY" "$OFFSET" "$PREIMAGE_HEX" "$POSTIMAGE_HEX" <<'PY'
import pathlib,sys
p=pathlib.Path(sys.argv[1]); off=int(sys.argv[2]); pre=bytes.fromhex(sys.argv[3]); post=bytes.fromhex(sys.argv[4])
b=bytearray(p.read_bytes())
actual=bytes(b[off:off+len(pre)])
print(f'D97GR_PREIMAGE_OFFSET=0x{off:x}')
print(f'D97GR_PREIMAGE_HEX={actual.hex()}')
if actual != pre:
    raise SystemExit('PREIMAGE_MISMATCH')
occ=[]; start=0
raw=bytes(b)
while True:
    i=raw.find(pre,start)
    if i<0: break
    occ.append(i); start=i+1
print('D97GR_PREIMAGE_OCCURRENCES=' + ','.join(hex(x) for x in occ))
print(f'D97GR_PREIMAGE_OCCURRENCE_COUNT={len(occ)}')
if len(occ)!=1 or occ[0]!=off:
    raise SystemExit('PREIMAGE_NOT_UNIQUE_AT_EXPECTED_OFFSET')
b[off:off+len(pre)]=post
p.write_bytes(b)
print(f'D97GR_POSTIMAGE_HEX={bytes(b[off:off+len(post)]).hex()}')
PY

echo
echo "===== PATCHED COPY IDENTITY ====="
PATCHED_SHA="$(sha256 "$COPY")"
echo "D97GR_PATCHED_COPY_SHA256=$PATCHED_SHA"
if [[ "$PATCHED_SHA" == "$EXPECTED_P1_SHA" ]]; then
  echo "D97GR_PATCHED_COPY_MATCHES_HISTORICAL_P1=PASS"
else
  echo "D97GR_PATCHED_COPY_MATCHES_HISTORICAL_P1=FAIL"
fi

/usr/bin/python3 - "$SERVICE" "$COPY" "$OFFSET" <<'PY'
import pathlib,sys
A=pathlib.Path(sys.argv[1]).read_bytes(); B=pathlib.Path(sys.argv[2]).read_bytes(); off=int(sys.argv[3])
if len(A)!=len(B): raise SystemExit('SIZE_CHANGED')
d=[i for i,(a,b) in enumerate(zip(A,B)) if a!=b]
print(f'D97GR_DIFF_BYTE_COUNT={len(d)}')
print('D97GR_DIFF_OFFSETS=' + ','.join(hex(i) for i in d))
for i in d: print(f'D97GR_DIFF_{i:#x}={A[i]:02x}->{B[i]:02x}')
allowed=set(range(off,off+6))
if not d or not set(d).issubset(allowed): raise SystemExit('UNEXPECTED_DIFF_OUTSIDE_SELECTOR')
PY

/usr/bin/otool -tvV "$COPY" > "$OUT/patched_copy_disassembly.txt" 2>&1 || true
/usr/bin/grep -E '0000000100003494|000000010000349a|00000001000034a1|00000001000034aa' "$OUT/patched_copy_disassembly.txt" | tee "$OUT/patched_selector_excerpt.txt" || true

echo
echo "===== RESULT ====="
if [[ "$PATCHED_SHA" == "$EXPECTED_P1_SHA" ]]; then
  echo "D97GR_P1_RECONSTRUCTION=EXACT_HISTORICAL_MATCH"
  echo "D97GR_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN"
else
  echo "D97GR_P1_RECONSTRUCTION=BYTE_PATCH_VALID_BUT_HISTORICAL_SHA_MISMATCH"
  echo "D97GR_CLASSIFICATION=STATIC_PATCH_SEMANTICS_PROVEN_IDENTITY_NOT_CLOSED"
fi

/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
echo "D97GR_ZIP=$ZIP"
echo "D97GR_ZIP_SHA256=$(sha256 "$ZIP")"
echo "D97GR_ZIP_BYTES=$(/usr/bin/stat -f '%z' "$ZIP")"
echo "D97GR_STATUS=PASS_READONLY_COPY_RECONSTRUCTION"
echo "D97GR_REBOOT=NO"
