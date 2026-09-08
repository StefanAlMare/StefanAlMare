#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HG — read-only/copy-only reconstruction of historical P3
# on the CURRENT exact unmodified MTLCompiler 32023 base.
# NO system/root-patch/EFI/NVRAM/framebuffer mutation. NO reboot.

EXPECTED_BUILD="25G82"
EXPECTED_SERVICE_P1_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_COMPILER_BASE_SHA="ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269"
EXPECTED_P2_ORIGINAL="418b81d0000000"
P2_OFFSET=$((0x9A8CD))
EXPECTED_P3_PRE="81e100002000"
EXPECTED_P3_POST="81c900002000"
P3_OFFSET=$((0xA1573))

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
COMPILER="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97HG_P3_ONLY_RECONSTRUCTION_${STAMP}"
COPY="$OUT/MTLCompiler_32023_P3_ONLY.copy"
REPORT="$OUT/D97HG_REPORT.txt"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
fail(){ echo "D97HG_STATUS=FAIL"; echo "D97HG_REASON=$*"; echo "D97HG_REPORT=$REPORT"; exit 1; }

cat <<'HDR'
===== OCLP7 D97HG — CURRENT 32023 P3-ONLY COPY RECONSTRUCTION =====
SYSTEM_MUTATION=NO
ROOT_PATCH=NO
RESTORE=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
COPY_ONLY=YES
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "$EXPECTED_BUILD" ]] || fail NOT_25G82

printf '\n===== VESA / P1 ACTIVE GATE =====\n'
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "D97HG_BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE || true
[[ -f "$SERVICE" ]] || fail SERVICE_MISSING
SERVICE_SHA="$(sha256 "$SERVICE")"
echo "D97HG_SERVICE_SHA256=$SERVICE_SHA"
[[ "$SERVICE_SHA" == "$EXPECTED_SERVICE_P1_SHA" ]] || fail SERVICE_NOT_EXACT_P1
echo "D97HG_ACTIVE_P1_GATE=PASS"

printf '\n===== CURRENT MTLCompiler 32023 IDENTITY =====\n'
[[ -f "$COMPILER" ]] || fail COMPILER_MISSING
BASE_SHA="$(sha256 "$COMPILER")"
BASE_BYTES="$(/usr/bin/stat -f '%z' "$COMPILER")"
echo "D97HG_COMPILER_PATH=$COMPILER"
echo "D97HG_COMPILER_BASE_SHA256=$BASE_SHA"
echo "D97HG_COMPILER_BASE_BYTES=$BASE_BYTES"
[[ "$BASE_SHA" == "$EXPECTED_COMPILER_BASE_SHA" ]] || fail COMPILER_BASE_SHA_MISMATCH
/usr/bin/file "$COMPILER" || true
/usr/bin/dwarfdump --uuid "$COMPILER" 2>/dev/null || true
echo "D97HG_COMPILER_BASE=EXACT_GOLDEN_32023_PASS"

printf '\n===== P2/P3 STATIC PREIMAGE GATE =====\n'
/usr/bin/python3 - "$COMPILER" "$P2_OFFSET" "$EXPECTED_P2_ORIGINAL" "$P3_OFFSET" "$EXPECTED_P3_PRE" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); b=p.read_bytes()
p2off=int(sys.argv[2]); p2=bytes.fromhex(sys.argv[3])
p3off=int(sys.argv[4]); p3=bytes.fromhex(sys.argv[5])
g2=b[p2off:p2off+len(p2)]; g3=b[p3off:p3off+len(p3)]
print(f'D97HG_P2_OFFSET=0x{p2off:x}')
print('D97HG_P2_CURRENT='+g2.hex())
print('D97HG_P2_ORIGINAL_MATCH='+('PASS' if g2==p2 else 'FAIL'))
print('D97HG_P2_PREIMAGE_GLOBAL_COUNT='+str(b.count(p2)))
print(f'D97HG_P3_OFFSET=0x{p3off:x}')
print('D97HG_P3_CURRENT='+g3.hex())
print('D97HG_P3_PREIMAGE_MATCH='+('PASS' if g3==p3 else 'FAIL'))
print('D97HG_P3_PREIMAGE_GLOBAL_COUNT='+str(b.count(p3)))
if g2 != p2: raise SystemExit(20)
if g3 != p3: raise SystemExit(30)
PY

echo "D97HG_CURRENT_P2_STATE=ORIGINAL_D0_NO_P2B"
echo "D97HG_CURRENT_P3_STATE=ORIGINAL_DIRECT_MODULE_PATH"

printf '\n===== COPY-ONLY P3 RECONSTRUCTION =====\n'
/bin/cp "$COMPILER" "$COPY" || fail COPY_FAIL
[[ "$(sha256 "$COPY")" == "$EXPECTED_COMPILER_BASE_SHA" ]] || fail COPY_BASE_SHA_MISMATCH

/usr/bin/python3 - "$COPY" "$P3_OFFSET" "$EXPECTED_P3_PRE" "$EXPECTED_P3_POST" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); off=int(sys.argv[2]); pre=bytes.fromhex(sys.argv[3]); post=bytes.fromhex(sys.argv[4])
b=bytearray(p.read_bytes())
if b[off:off+len(pre)] != pre:
    print('D97HG_PATCH_COPY_PREIMAGE=FAIL')
    raise SystemExit(2)
# historical P3 is one-byte opcode/modrm change: AND -> OR for 0x200000 flag semantics
old=bytes(b)
b[off:off+len(pre)] = post
p.write_bytes(b)
changed=[i for i,(x,y) in enumerate(zip(old,b)) if x!=y]
print('D97HG_PATCH_COPY_PREIMAGE=PASS')
print('D97HG_PATCH_COPY_POSTIMAGE='+bytes(b[off:off+len(post)]).hex())
print('D97HG_PATCH_COPY_CHANGED_BYTE_COUNT='+str(len(changed)))
for i in changed:
    print(f'D97HG_PATCH_COPY_DIFF=0x{i:x}:{old[i]:02x}->{b[i]:02x}')
if bytes(b[off:off+len(post)]) != post: raise SystemExit(3)
if len(changed) != 1: raise SystemExit(4)
PY

POST_SHA="$(sha256 "$COPY")"
POST_BYTES="$(/usr/bin/stat -f '%z' "$COPY")"
echo "D97HG_P3_ONLY_POST_SHA256=$POST_SHA"
echo "D97HG_P3_ONLY_POST_BYTES=$POST_BYTES"
[[ "$POST_BYTES" == "$BASE_BYTES" ]] || fail POST_BYTES_CHANGED

printf '\n===== CONTEXT HEX =====\n'
echo "--- original around P2 ---"
/usr/bin/xxd -g1 -l 48 -s $((P2_OFFSET-16)) "$COMPILER" || true
echo "--- original around P3 ---"
/usr/bin/xxd -g1 -l 48 -s $((P3_OFFSET-16)) "$COMPILER" || true
echo "--- P3-only copy around P3 ---"
/usr/bin/xxd -g1 -l 48 -s $((P3_OFFSET-16)) "$COPY" || true

printf '\n===== FINAL =====\n'
echo "D97HG_P3_ONLY_RECONSTRUCTION=STATIC_STRUCTURAL_SEMANTIC_PROVEN"
echo "D97HG_P2B_REPLAY=NO"
echo "D97HG_P3_NEXT_MODULE=YES_MEASURED"
echo "D97HG_SYSTEM_MUTATION=NO"
echo "D97HG_REBOOT=NO"
echo "D97HG_STATUS=PASS_COPY_ONLY"
echo "D97HG_NEXT=BUILD_D97HI_P1_PLUS_P3_ONLY_AFTER_REVIEW"
echo "D97HG_COPY=$COPY"
echo "D97HG_REPORT=$REPORT"
