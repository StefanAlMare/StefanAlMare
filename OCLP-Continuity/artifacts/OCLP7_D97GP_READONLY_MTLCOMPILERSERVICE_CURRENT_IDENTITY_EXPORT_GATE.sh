#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97GP — current on-disk MTLCompilerService / MTLCompiler 32023 identity and export audit.
# READ-ONLY. Does not dlopen either payload, does not launch MTLCompilerService, does not compile.
# NO Root Patch/Restore. NO EFI/NVRAM/framebuffer mutation. NO reboot.

SERVICE="/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService"
MTLC="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"
EXPECTED_D97M_SERVICE_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"
EXPECTED_SELECTOR_HEX="81fe177d0000"
EXPECTED_NULL_CALL_HEX="41ff5608"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97GP_READONLY_MTLCOMPILER_IDENTITY_EXPORT_GATE_${STAMP}"
REPORT="$OUT/D97GP_REPORT.txt"
ZIP="$HOME/Desktop/OCLP7_D97GP_READONLY_MTLCOMPILER_IDENTITY_EXPORT_GATE_${STAMP}.zip"
mkdir -p "$OUT"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97GP_STATUS=FAIL"; echo "D97GP_REASON=$*"; echo "D97GP_REPORT=$REPORT"; exit 1; }
sha256(){ /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'; }
bytes(){ /usr/bin/stat -f '%z' "$1"; }

printf '%s\n' "===== D97GP READ-ONLY MTLCOMPILER IDENTITY / EXPORT GATE ====="
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "SERVICE_LAUNCH=NO"
echo "DLOPEN_EXECUTION=NO"
echo "COMPILATION=NO"
echo "ROOT_PATCH=NO"
echo "RESTORE=NO"
echo "EFI_MUTATION=NO"
echo "NVRAM_MUTATION=NO"
echo "FRAMEBUFFER_MUTATION=NO"
echo "REBOOT=NO"

echo
echo "===== SYSTEM / VESA SAFETY GATE ====="
[[ "$(uname -s)" == "Darwin" ]] || fail NOT_DARWIN
[[ "$(uname -m)" == "x86_64" ]] || fail NOT_X86_64
[[ "$(/usr/bin/sw_vers -buildVersion)" == "25G82" ]] || fail NOT_25G82
/usr/bin/sw_vers
BOOTARGS="$(/usr/sbin/sysctl -n kern.bootargs 2>/dev/null || true)"
echo "BOOTARGS=$BOOTARGS"
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-igfxvesa")f=1}END{exit(f?0:1)}' || fail VESA_NOT_ACTIVE
printf '%s\n' "$BOOTARGS" | /usr/bin/awk '{for(i=1;i<=NF;i++)if($i=="-ocmcd97ez")f=1}END{exit(f?0:1)}' && fail D97EZ_ACTIVE_IN_RECOVERY || true
echo "D97GP_VESA_GATE=PASS"

[[ -f "$SERVICE" ]] || fail SERVICE_MISSING
[[ -f "$MTLC" ]] || fail MTLC_32023_MISSING

echo
echo "===== CURRENT MTLCOMPILERSERVICE IDENTITY ====="
S_SHA="$(sha256 "$SERVICE")"
S_BYTES="$(bytes "$SERVICE")"
echo "SERVICE_PATH=$SERVICE"
echo "SERVICE_BYTES=$S_BYTES"
echo "SERVICE_SHA256=$S_SHA"
/usr/bin/file "$SERVICE" | tee "$OUT/service_file.txt"
/usr/bin/dwarfdump --uuid "$SERVICE" 2>&1 | tee "$OUT/service_uuid.txt" || true
/usr/bin/codesign -dv --verbose=4 "$SERVICE" 2>&1 | tee "$OUT/service_codesign.txt" || true
if [[ "$S_SHA" == "$EXPECTED_D97M_SERVICE_SHA" ]]; then
  echo "D97GP_SERVICE_MATCHES_D97M=YES"
else
  echo "D97GP_SERVICE_MATCHES_D97M=NO"
fi

# Pure byte reads of previously mapped x86_64 file offsets.
/usr/bin/python3 - "$SERVICE" "$EXPECTED_SELECTOR_HEX" "$EXPECTED_NULL_CALL_HEX" <<'PY'
import pathlib,sys
p=pathlib.Path(sys.argv[1]); data=p.read_bytes(); exp_sel=sys.argv[2]; exp_call=sys.argv[3]
for off,n,label,exp in [
    (0x3494,6,'SELECTOR_CMP_0x3494',exp_sel),
    (0x3444,4,'INDIRECT_CALL_0x3444',exp_call),
]:
    b=data[off:off+n]
    print(f'{label}_HEX={b.hex()}')
    print(f'{label}_MATCH=' + ('YES' if b.hex()==exp else 'NO'))
# Also expose nearby bytes without interpreting them beyond static evidence.
for off,n,label in [(0x3410,0x50,'MTLCONNECTIONCTX_0x3410_0x345f'),(0x346a,0xc8,'PLUGIN_CTOR_0x346a_0x3531')]:
    print(f'{label}_HEX={data[off:off+n].hex()}')
PY

/usr/bin/otool -tvV "$SERVICE" > "$OUT/service_disassembly.txt" 2>&1 || true
/usr/bin/strings -a "$SERVICE" | /usr/bin/grep -E 'MTLCompiler.framework/Versions/(3802|32023)|MTLCodeGenService(Create|Destroy|BuildRequest|SetPluginPath)' > "$OUT/service_relevant_strings.txt" 2>/dev/null || true
echo "----- SERVICE RELEVANT STRINGS -----"
/bin/cat "$OUT/service_relevant_strings.txt" 2>/dev/null || true

echo
echo "===== CURRENT MTLCOMPILER 32023 IDENTITY ====="
C_SHA="$(sha256 "$MTLC")"
C_BYTES="$(bytes "$MTLC")"
echo "MTLC_PATH=$MTLC"
echo "MTLC_BYTES=$C_BYTES"
echo "MTLC_SHA256=$C_SHA"
/usr/bin/file "$MTLC" | tee "$OUT/mtlc_file.txt"
/usr/bin/dwarfdump --uuid "$MTLC" 2>&1 | tee "$OUT/mtlc_uuid.txt" || true
/usr/bin/codesign -dv --verbose=4 "$MTLC" 2>&1 | tee "$OUT/mtlc_codesign.txt" || true
/usr/bin/otool -L "$MTLC" > "$OUT/mtlc_otool_L.txt" 2>&1 || true
/usr/bin/otool -l "$MTLC" > "$OUT/mtlc_load_commands.txt" 2>&1 || true

echo "----- MTLC DEPENDENCIES -----"
/bin/cat "$OUT/mtlc_otool_L.txt" 2>/dev/null || true

echo
echo "===== STATIC EXPORTED-SYMBOL AUDIT ====="
# Never load/execute the compiler. nm only reads Mach-O symbol metadata.
set +e
/usr/bin/nm -gU "$MTLC" > "$OUT/mtlc_nm_gU.txt" 2> "$OUT/mtlc_nm_gU.err"
NM_GU_RC=$?
/usr/bin/nm -m "$MTLC" > "$OUT/mtlc_nm_m.txt" 2> "$OUT/mtlc_nm_m.err"
NM_M_RC=$?
set -e
echo "NM_GU_RC=$NM_GU_RC"
echo "NM_M_RC=$NM_M_RC"

/usr/bin/strings -a "$MTLC" | /usr/bin/grep -E '^_?MTLCodeGenService(Create|Destroy|BuildRequest|SetPluginPath)$' > "$OUT/mtlc_codegen_strings.txt" 2>/dev/null || true

/usr/bin/python3 - "$OUT/mtlc_nm_gU.txt" "$OUT/mtlc_nm_m.txt" "$OUT/mtlc_codegen_strings.txt" <<'PY'
import pathlib,re,sys
ngu=pathlib.Path(sys.argv[1]).read_text(errors='replace') if pathlib.Path(sys.argv[1]).exists() else ''
nmm=pathlib.Path(sys.argv[2]).read_text(errors='replace') if pathlib.Path(sys.argv[2]).exists() else ''
strings=pathlib.Path(sys.argv[3]).read_text(errors='replace') if pathlib.Path(sys.argv[3]).exists() else ''
required=[
 'MTLCodeGenServiceCreate',
 'MTLCodeGenServiceDestroy',
 'MTLCodeGenServiceBuildRequest',
 'MTLCodeGenServiceSetPluginPath',
]
exp=0
for s in required:
    # nm output may prefix C symbols with underscore.
    rx=re.compile(r'(?<![A-Za-z0-9_])_?'+re.escape(s)+r'(?![A-Za-z0-9_])')
    gu=bool(rx.search(ngu))
    mm=bool(rx.search(nmm))
    st=bool(rx.search(strings))
    if gu: exp+=1
    print(f'SYMBOL_{s}_NM_GU=' + ('PRESENT' if gu else 'ABSENT'))
    print(f'SYMBOL_{s}_NM_M=' + ('PRESENT' if mm else 'ABSENT'))
    print(f'SYMBOL_{s}_STRING=' + ('PRESENT' if st else 'ABSENT'))
print(f'D97GP_REQUIRED_EXPORT_COUNT={exp}')
print('D97GP_ALL_REQUIRED_EXPORTS=' + ('PASS' if exp==4 else 'FAIL'))
PY

echo "----- NM -gU MATCHES -----"
/usr/bin/grep -E 'MTLCodeGenService(Create|Destroy|BuildRequest|SetPluginPath)' "$OUT/mtlc_nm_gU.txt" || true

echo "----- NM -m MATCHES -----"
/usr/bin/grep -E 'MTLCodeGenService(Create|Destroy|BuildRequest|SetPluginPath)' "$OUT/mtlc_nm_m.txt" || true

echo "----- STRINGS MATCHES -----"
/bin/cat "$OUT/mtlc_codegen_strings.txt" 2>/dev/null || true

echo
echo "===== STATIC SERVICE / COMPILER CORRELATION ====="
# Conservative machine classification only. No runtime dlsym claim is made here.
EXPORT_COUNT="$(/usr/bin/python3 - "$OUT/mtlc_nm_gU.txt" <<'PY'
import pathlib,re,sys
s=pathlib.Path(sys.argv[1]).read_text(errors='replace') if pathlib.Path(sys.argv[1]).exists() else ''
r=['MTLCodeGenServiceCreate','MTLCodeGenServiceDestroy','MTLCodeGenServiceBuildRequest','MTLCodeGenServiceSetPluginPath']
print(sum(bool(re.search(r'(?<![A-Za-z0-9_])_?'+re.escape(x)+r'(?![A-Za-z0-9_])',s)) for x in r))
PY
)"
echo "D97GP_EXPORT_COUNT_RECHECK=$EXPORT_COUNT"
if [[ "$EXPORT_COUNT" == "4" ]]; then
  echo "D97GP_STATIC_MISSING_EXPORT_HYPOTHESIS=NEGATIVE"
  echo "D97GP_NEXT_IF_NEEDED=RUNTIME_DLSYM_OR_LOADER_NAMESPACE_LOCALIZATION"
else
  echo "D97GP_STATIC_MISSING_EXPORT_HYPOTHESIS=SUPPORTED"
  echo "D97GP_NEXT_IF_NEEDED=IDENTIFY_EXPECTED_COMPILER_DONOR_OR_RESTORE_ACCEPTED_BRIDGE_PAYLOAD"
fi

echo
echo "===== PACKAGE ====="
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"
echo "D97GP_ZIP=$ZIP"
echo "D97GP_ZIP_SHA256=$(sha256 "$ZIP")"
echo "D97GP_ZIP_BYTES=$(bytes "$ZIP")"

echo
echo "===== FINAL ====="
echo "D97GP_STATUS=PASS_READONLY_CAPTURE"
echo "D97GP_SERVICE_SHA256=$S_SHA"
echo "D97GP_MTLC_SHA256=$C_SHA"
echo "D97GP_REBOOT=NO"
echo "D97GP_REPORT=$REPORT"
