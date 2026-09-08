#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HL v2 — tooling-only correction for D97HK portable bootstrap.
# Replaces only D97HK's ambiguous transformation of the historical D97DU
# Python-selection block with an exact region-bounded replacement using the
# already-proven /usr/local/bin/python3.13 x86_64 on this build host.
# All functional D97DX/D97GS/D97HI authority remains unchanged.
# NO Root Patch. NO EFI/NVRAM/framebuffer/system-root mutation. NO reboot.

D97HK_COMMIT="cb878d7a9541f6400c198017931e72eaa7dcf426"
D97HK_BLOB="b3d8022ac3d543fd1fd38fedc14ebab6bd0ccfe8"
D97HK_PATH="OCLP-Continuity/artifacts/OCLP7_D97HK_PORTABLE_INTEL_HOST_BOOTSTRAP_AND_D97HI_INNER_BUILD.sh"
PYTHON="/usr/local/bin/python3.13"
STAMP="$(date +%Y%m%d_%H%M%S)"
TMP="$HOME/Library/Caches/OCLP7-D97HL-$STAMP"
ORIG="$TMP/D97HK_v1.sh"
FIXED="$TMP/D97HK_v2_python_region_fixed.sh"
REPORT="$HOME/Desktop/OCLP7_D97HL_TOOLING_FIX_REPORT_${STAMP}.txt"

mkdir -p "$TMP"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HL_STATUS=FAIL"; echo "D97HL_REASON=$*"; echo "D97HL_REPORT=$REPORT"; exit 1; }
blob(){ /usr/local/bin/git hash-object "$1"; }

cat <<'HDR'
===== OCLP7 D97HL v2 — D97HK PYTHON-REGION TOOLING FIX =====
TOOLING_FIX_ONLY=YES
FUNCTIONAL_AUTHORITY_CHANGE=NO
ROOT_PATCH=NO
SYSTEM_ROOT_MUTATION=NO
EFI_MUTATION=NO
NVRAM_MUTATION=NO
FRAMEBUFFER_MUTATION=NO
REBOOT=NO
HDR

[[ "$(uname -s)" == Darwin ]] || fail NOT_DARWIN
[[ "$(uname -m)" == x86_64 ]] || fail NOT_INTEL_X86_64
[[ -x "$PYTHON" ]] || fail PYTHON_313_MISSING
[[ "$($PYTHON -c 'import platform;print(platform.machine())')" == x86_64 ]] || fail PYTHON_313_NOT_X86_64
[[ -x /usr/local/bin/git ]] || fail USR_LOCAL_GIT_MISSING

echo "D97HL_HOST_PRODUCT=$(/usr/bin/sw_vers -productVersion)"
echo "D97HL_HOST_BUILD=$(/usr/bin/sw_vers -buildVersion)"
echo "D97HL_PYTHON=$($PYTHON --version 2>&1)"

printf '\n===== FETCH EXACT D97HK V1 =====\n'
/usr/bin/curl -fL \
  "https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${D97HK_COMMIT}/${D97HK_PATH}" \
  -o "$ORIG"

ACTUAL_ORIG_BLOB="$(blob "$ORIG")"
echo "D97HL_D97HK_V1_BLOB=$ACTUAL_ORIG_BLOB"
[[ "$ACTUAL_ORIG_BLOB" == "$D97HK_BLOB" ]] || fail D97HK_V1_BLOB_MISMATCH
echo "D97HL_D97HK_V1_IDENTITY=PASS"

printf '\n===== APPLY SINGLE REGION-BOUNDED TOOLING CORRECTION =====\n'
"$PYTHON" - "$ORIG" "$FIXED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1]).read_text()

start_marker = '# Prefer the explicitly proven x86_64 Python 3.13 on this portable host.\n'
end_marker = '# Build-host prep does not need target-local MetallibSupportPkg or an official target helper.\n'

if src.count(start_marker) != 1:
    raise SystemExit(f'python transform start marker count={src.count(start_marker)}')
if src.count(end_marker) != 1:
    raise SystemExit(f'python transform end marker count={src.count(end_marker)}')

start = src.index(start_marker)
end = src.index(end_marker, start)
if not (start < end):
    raise SystemExit('python transform marker ordering invalid')

new_block = """# Prefer the explicitly proven x86_64 Python 3.13 on this portable host.
# D97HL v2: replace the entire unique D97DU Python-selection region; do not
# search for generic `for p in` loops.
py_anchor=src.find('PYTHON_BIN=""')
section_end=src.find('say "Verify exact local 25G82 MetallibSupportPkg"')
if py_anchor < 0 or section_end < 0 or not (py_anchor < section_end):
    raise SystemExit(f'python selection region invalid: py={py_anchor} end={section_end}')
replacement=(
    'PYTHON_BIN="/usr/local/bin/python3.13"\\n'
    '[[ -x "$PYTHON_BIN" ]] || die "D97HK portable Python 3.13 missing."\\n'
    '[[ "$("$PYTHON_BIN" -c \\'import platform;print(platform.machine())\\')" == "x86_64" ]] || die "D97HK portable Python is not x86_64."\\n'
    'ok "Python=$($PYTHON_BIN --version 2>&1) [$PYTHON_BIN]"\\n\\n'
)
src=src[:py_anchor] + replacement + src[section_end:]

"""

fixed = src[:start] + new_block + src[end:]
if fixed == src:
    raise SystemExit('tooling replacement produced no change')

# Functional authority strings must remain exactly unchanged and unique.
required = (
    'EXPECTED_D97DX_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"',
    'EXPECTED_D97GS_DIFF_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"',
    'EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"',
    'EXPECTED_P3_POST_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"',
    'D97DU_COMMIT="d8faeb3b108e57f35ee9576a8cbf1f7149c7bc9b"',
    'D97GS_COMMIT="8f86bfa76282b3b1c5b9aca311e95324406224d5"',
    'D97HI_COMMIT="4ca10b8e9a1b0db046d570bc2e1d2710ab16fa9a"',
)
for token in required:
    c = fixed.count(token)
    print(f'D97HL_AUTHORITY_TOKEN_COUNT={c}::{token}')
    if c != 1:
        raise SystemExit(f'authority token count mismatch: {token} -> {c}')

Path(sys.argv[2]).write_text(fixed)
print('D97HL_TOOLING_PATCH=PASS')
print('D97HL_TOOLING_SCOPE=PYTHON_SELECTION_REGION_ONLY')
PY

/bin/chmod +x "$FIXED"
/bin/bash -n "$FIXED" || fail FIXED_SCRIPT_SYNTAX_FAIL

FIXED_BLOB="$(blob "$FIXED")"
echo "D97HL_FIXED_D97HK_BLOB=$FIXED_BLOB"
echo "D97HL_FUNCTIONAL_SCOPE=UNCHANGED_D97HK"
echo "D97HL_STATIC_GATE=PASS"

printf '\n===== EXECUTE CORRECTED D97HK =====\n'
/bin/bash "$FIXED"
RC=$?
[[ "$RC" -eq 0 ]] || fail "CORRECTED_D97HK_EXIT_$RC"

echo "D97HL_STATUS=PASS_D97HK_CORRECTED_RUN"
echo "D97HL_REPORT=$REPORT"
echo "D97HL_REBOOT=NO"
