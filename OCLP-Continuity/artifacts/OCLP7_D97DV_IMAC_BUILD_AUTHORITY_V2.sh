#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DV — corrected iMac build authority launcher for D97DU.
# Fixes two build-host preflight defects only:
# 1) exact 25G82 MetallibSupportPkg is TARGET-ASUS2 runtime/root-patch input,
#    not a required iMac build-host installation;
# 2) build Python is pinned to x86_64 Python 3.13.x (D97BJ lineage), never 3.14.
#
# This launcher downloads the previously persisted D97DU authority helper,
# verifies its exact Git blob, applies only those two local build-host corrections,
# validates bash syntax, and executes it.
#
# BUILD HOST ONLY. NO Root Patch. NO EFI mutation. NO reboot.

AUTHORITY_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/main/OCLP-Continuity/artifacts/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.sh"
AUTHORITY_GIT_BLOB="ceed3890b5d35efbefc38ebf1a40f358884e58b9"
RAW="$HOME/Downloads/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.raw.sh"
FIXED="$HOME/Downloads/OCLP7_D97DV_IMAC_NATIVE_METAL_SAFE_BUILD.fixed.sh"

fail() { echo "FATAL: $*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || fail "macOS required"
[[ "$(uname -m)" == "x86_64" ]] || fail "Intel/x86_64 build host required"
command -v curl >/dev/null 2>&1 || fail "curl missing"
command -v git >/dev/null 2>&1 || fail "git missing"
REWRITE_PY="$(command -v python3 || true)"
[[ -n "$REWRITE_PY" ]] || fail "python3 required for deterministic text transform"

/bin/rm -f "$RAW" "$FIXED"
/usr/bin/curl -fL --retry 3 "$AUTHORITY_URL" -o "$RAW"
ACTUAL_BLOB="$(/usr/bin/git hash-object "$RAW")"
echo "D97DV_BASE_EXPECTED_GIT_BLOB=$AUTHORITY_GIT_BLOB"
echo "D97DV_BASE_ACTUAL_GIT_BLOB=$ACTUAL_BLOB"
[[ "$ACTUAL_BLOB" == "$AUTHORITY_GIT_BLOB" ]] || fail "base D97DU authority identity mismatch"

RAW_ENV="$RAW" FIXED_ENV="$FIXED" "$REWRITE_PY" - <<'PYFIX'
import os
from pathlib import Path

raw = Path(os.environ["RAW_ENV"])
fixed = Path(os.environ["FIXED_ENV"])
t = raw.read_text(encoding="utf-8")

# Correction 1: pin build interpreter to Python 3.13.x / x86_64.
start_marker = 'PYTHON_BIN=""\n'
end_marker = 'ok "Python=$($PYTHON_BIN --version 2>&1) [$PYTHON_BIN]"\n'
if t.count(start_marker) != 1 or t.count(end_marker) != 1:
    raise SystemExit("D97DV Python block anchors are not unique")
start = t.index(start_marker)
end = t.index(end_marker, start) + len(end_marker)
new_python = r'''PYTHON_BIN=""
PYTHON_CANDIDATES=(
    "$D97BJ_WORK/.venv/bin/python"
    "$D97BJ_WORK/venv/bin/python"
    "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3.13"
    "/usr/local/bin/python3.13"
    "/opt/homebrew/bin/python3.13"
)
if [[ -d "$D97BJ_WORK" ]]; then
    while IFS= read -r p; do
        PYTHON_CANDIDATES+=("$p")
    done < <(/usr/bin/find "$D97BJ_WORK" -maxdepth 4 -type f \( -name python -o -name python3 -o -name python3.13 \) 2>/dev/null | /usr/bin/sort -u)
fi
for p in "${PYTHON_CANDIDATES[@]}"; do
    [[ -x "$p" ]] || continue
    if "$p" - <<'PY' >/dev/null 2>&1
import platform, sys
raise SystemExit(0 if sys.version_info[:2] == (3, 13) and platform.machine() == "x86_64" else 1)
PY
    then
        PYTHON_BIN="$p"
        break
    fi
done
[[ -n "$PYTHON_BIN" ]] || die "Exact x86_64 Python 3.13.x not found. D97DU will not build with Python 3.14."
ok "Python=$($PYTHON_BIN --version 2>&1) [$PYTHON_BIN]"
'''
t = t[:start] + new_python + t[end:]

# Correction 2: 25G82 MetallibSupportPkg is not a build-host prerequisite.
start_marker = 'say "Verify exact local 25G82 MetallibSupportPkg"\n'
end_marker = 'echo "LOCAL_25G82_METALLIB_FILE_COUNT=$LOCAL_METALLIB_COUNT"\n'
if t.count(start_marker) != 1 or t.count(end_marker) != 1:
    raise SystemExit("D97DV Metallib preflight anchors are not unique")
start = t.index(start_marker)
end = t.index(end_marker, start) + len(end_marker)
new_metallib = r'''say "Record target-only 25G82 MetallibSupportPkg contract"
echo "BUILD_HOST_LOCAL_25G82_METALLIB_REQUIRED=NO"
echo "TARGET_ASUS2_EXACT_25G82_METALLIB_REQUIRED=YES"
echo "TARGET_ASUS2_METALLIB_PATH=/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
'''
t = t[:start] + new_metallib + t[end:]

# Structural guarantees: exactly the two intended build-host corrections.
if 'sys.version_info[:2] == (3, 13)' not in t:
    raise SystemExit("Python 3.13 pin missing after transform")
if 'BUILD_HOST_LOCAL_25G82_METALLIB_REQUIRED=NO' not in t:
    raise SystemExit("build-host metallib correction missing after transform")
if '[[ -d "$LOCAL_METALLIB" ]] || die' in t:
    raise SystemExit("old iMac local metallib hard gate survived")

fixed.write_text(t, encoding="utf-8")
PYFIX

/bin/chmod 755 "$FIXED"
/bin/bash -n "$FIXED"
FIXED_SHA="$(/usr/bin/shasum -a 256 "$FIXED" | /usr/bin/awk '{print $1}')"
FIXED_BLOB="$(/usr/bin/git hash-object "$FIXED")"

echo "D97DV_FIXED_HELPER_SHA256=$FIXED_SHA"
echo "D97DV_FIXED_HELPER_GIT_BLOB=$FIXED_BLOB"
echo "D97DV_FIXED_HELPER_BASH_N=PASS"
echo "D97DV_BUILD_HOST_METALLIB_REQUIREMENT_REMOVED=PASS"
echo "D97DV_PYTHON_3_13_X86_64_PIN=PASS"

exec /bin/bash "$FIXED"
