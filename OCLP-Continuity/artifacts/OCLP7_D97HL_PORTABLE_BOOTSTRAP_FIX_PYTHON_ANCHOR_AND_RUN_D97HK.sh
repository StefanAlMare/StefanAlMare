#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97HL — tooling-only correction for D97HK portable bootstrap.
# Fixes the overly-generic Python-loop anchor in D97HK v1, then executes the
# otherwise byte-identical D97HK logic.
# NO Root Patch. NO EFI/NVRAM/framebuffer/system-root mutation. NO reboot.

D97HK_COMMIT="cb878d7a9541f6400c198017931e72eaa7dcf426"
D97HK_BLOB="b3d8022ac3d543fd1fd38fedc14ebab6bd0ccfe8"
D97HK_PATH="OCLP-Continuity/artifacts/OCLP7_D97HK_PORTABLE_INTEL_HOST_BOOTSTRAP_AND_D97HI_INNER_BUILD.sh"
PYTHON="/usr/local/bin/python3.13"
STAMP="$(date +%Y%m%d_%H%M%S)"
TMP="$HOME/Library/Caches/OCLP7-D97HL-$STAMP"
ORIG="$TMP/D97HK_v1.sh"
FIXED="$TMP/D97HK_v2_python_anchor_fixed.sh"
REPORT="$HOME/Desktop/OCLP7_D97HL_TOOLING_FIX_REPORT_${STAMP}.txt"

mkdir -p "$TMP"
exec > >(tee "$REPORT") 2>&1

fail(){ echo "D97HL_STATUS=FAIL"; echo "D97HL_REASON=$*"; echo "D97HL_REPORT=$REPORT"; exit 1; }
blob(){ /usr/local/bin/git hash-object "$1"; }

cat <<'HDR'
===== OCLP7 D97HL — D97HK PYTHON-ANCHOR TOOLING FIX =====
TOOLING_FIX_ONLY=YES
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

printf '\n===== APPLY SINGLE TOOLING CORRECTION =====\n'
"$PYTHON" - "$ORIG" "$FIXED" <<'PY'
from pathlib import Path
import sys

src = Path(sys.argv[1]).read_text()

old = '''# Prefer the explicitly proven x86_64 Python 3.13 on this portable host.\nneedle='for p in \\\\\\n'\nif src.count(needle) != 1:\n    raise SystemExit(f'python loop anchor count={src.count(needle)}')\nsrc=src.replace(needle, needle+'    \"/usr/local/bin/python3.13\" \\\\\\n',1)\n'''

new = '''# Prefer the explicitly proven x86_64 Python 3.13 on this portable host.\n# D97HL: the historical authority contains more than one generic `for p in \\` loop.\n# Anchor the first replacement to the unique PYTHON_BIN selection region instead.\nneedle='for p in \\\\\\n'\npy_anchor=src.find('PYTHON_BIN=\"\"')\nsection_end=src.find('say \"Verify exact local 25G82 MetallibSupportPkg\"')\nloop_anchor=src.find(needle, py_anchor)\nif py_anchor < 0 or section_end < 0 or loop_anchor < 0 or not (py_anchor < loop_anchor < section_end):\n    raise SystemExit(f'python selection anchor invalid: py={py_anchor} loop={loop_anchor} end={section_end}')\nsrc=src[:loop_anchor] + needle + '    \"/usr/local/bin/python3.13\" \\\\\\n' + src[loop_anchor+len(needle):]\n'''

count = src.count(old)
print(f'D97HL_OLD_TOOLING_BLOCK_COUNT={count}')
if count != 1:
    raise SystemExit(f'old D97HK tooling block count={count}')

fixed = src.replace(old, new, 1)
if fixed == src:
    raise SystemExit('tooling replacement produced no change')

# Assert the functional authority strings remain present and unique.
for token in (
    'EXPECTED_D97DX_DIFF_SHA="c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4"',
    'EXPECTED_D97GS_DIFF_SHA="cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f"',
    'EXPECTED_P1_POST_SHA="a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43"',
    'EXPECTED_P3_POST_SHA="0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90"',
    'P2B_REPLAY=NO',
    'AIR00_REPLAY=NO',
    'D34_REPLAY=NO',
):
    c = fixed.count(token)
    print(f'D97HL_AUTHORITY_TOKEN_COUNT={c}::{token}')
    if c != 1:
        raise SystemExit(f'authority token count mismatch: {token} -> {c}')

Path(sys.argv[2]).write_text(fixed)
print('D97HL_TOOLING_PATCH=PASS')
PY

/bin/chmod +x "$FIXED"
/bin/bash -n "$FIXED" || fail FIXED_SCRIPT_SYNTAX_FAIL

FIXED_BLOB="$(blob "$FIXED")"
echo "D97HL_FIXED_D97HK_BLOB=$FIXED_BLOB"
echo "D97HL_FUNCTIONAL_SCOPE=UNCHANGED_D97HK"
echo "D97HL_TOOLING_DELTA=PYTHON_SELECTION_ANCHOR_ONLY"
echo "D97HL_STATIC_GATE=PASS"

printf '\n===== EXECUTE CORRECTED D97HK =====\n'
/bin/bash "$FIXED"
RC=$?
[[ "$RC" -eq 0 ]] || fail "CORRECTED_D97HK_EXIT_$RC"

echo "D97HL_STATUS=PASS_D97HK_CORRECTED_RUN"
echo "D97HL_REPORT=$REPORT"
echo "D97HL_REBOOT=NO"
