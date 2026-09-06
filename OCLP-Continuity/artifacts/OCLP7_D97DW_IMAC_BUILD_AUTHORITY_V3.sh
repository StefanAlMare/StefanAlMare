#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DW — corrected D97DU build authority v3
# Intel iMac build host ONLY.
#
# Corrects build-host preflight/packaging only:
# 1) pin functional build to Python 3.13.x x86_64;
# 2) do NOT require Tahoe 25G82 MetallibSupportPkg on the iMac build host;
# 3) do NOT require/bundle the official privileged helper on the iMac.
#
# Instead, the generated target wrapper will:
# - require the currently installed ASUS2 helper to match the exact official
#   Dortania helper before any swap;
# - save that exact helper locally on ASUS2;
# - install the DEBUG helper temporarily;
# - explicitly restore the saved official helper after the custom OCLP exits;
# - retain a trap as a secondary restore path.
#
# BUILD ONLY. NO Root Patch. NO EFI mutation. NO reboot.

BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/main/OCLP-Continuity/artifacts/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.sh"
BASE_GIT_BLOB="ceed3890b5d35efbefc38ebf1a40f358884e58b9"

RAW="$HOME/Downloads/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.raw.sh"
FIXED="$HOME/Downloads/OCLP7_D97DW_IMAC_NATIVE_METAL_SAFE_BUILD.fixed.sh"

fail() { echo "FATAL: $*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || fail "macOS required"
[[ "$(uname -m)" == "x86_64" ]] || fail "Intel/x86_64 build host required"
command -v curl >/dev/null 2>&1 || fail "curl missing"
command -v git >/dev/null 2>&1 || fail "git missing"
REWRITE_PY="$(command -v python3 || true)"
[[ -n "$REWRITE_PY" ]] || fail "python3 required for deterministic text transform"

/bin/rm -f "$RAW" "$FIXED"
/usr/bin/curl -fL --retry 3 "$BASE_URL" -o "$RAW"

ACTUAL_BLOB="$(/usr/bin/git hash-object "$RAW")"
ACTUAL_SHA256="$(/usr/bin/shasum -a 256 "$RAW" | /usr/bin/awk '{print $1}')"
echo "D97DW_BASE_EXPECTED_GIT_BLOB=$BASE_GIT_BLOB"
echo "D97DW_BASE_ACTUAL_GIT_BLOB=$ACTUAL_BLOB"
echo "D97DW_BASE_SHA256=$ACTUAL_SHA256"
[[ "$ACTUAL_BLOB" == "$BASE_GIT_BLOB" ]] || fail "base D97DU authority identity mismatch"

RAW_ENV="$RAW" FIXED_ENV="$FIXED" "$REWRITE_PY" - <<'PYFIX'
import os
from pathlib import Path

raw = Path(os.environ["RAW_ENV"])
fixed = Path(os.environ["FIXED_ENV"])
t = raw.read_text(encoding="utf-8")

start_marker = 'PYTHON_BIN=""\n'
end_marker = 'ok "Python=$($PYTHON_BIN --version 2>&1) [$PYTHON_BIN]"\n'
if t.count(start_marker) != 1 or t.count(end_marker) != 1:
    raise SystemExit("D97DW Python block anchors are not unique")
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

start_marker = 'say "Verify exact local 25G82 MetallibSupportPkg"\n'
end_marker = 'echo "LOCAL_25G82_METALLIB_FILE_COUNT=$LOCAL_METALLIB_COUNT"\n'
if t.count(start_marker) != 1 or t.count(end_marker) != 1:
    raise SystemExit("D97DW Metallib preflight anchors are not unique")
start = t.index(start_marker)
end = t.index(end_marker, start) + len(end_marker)

new_metallib = r'''say "Record target-only 25G82 MetallibSupportPkg contract"
echo "BUILD_HOST_LOCAL_25G82_METALLIB_REQUIRED=NO"
echo "TARGET_ASUS2_EXACT_25G82_METALLIB_REQUIRED=YES"
echo "TARGET_ASUS2_METALLIB_PATH=/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82"
'''
t = t[:start] + new_metallib + t[end:]

start_marker = 'say "Locate exact official privileged-helper restore asset"\n'
end_marker = 'ok "Official helper exact: $OFFICIAL_HELPER"\n'
if t.count(start_marker) != 1 or t.count(end_marker) != 1:
    raise SystemExit("D97DW official-helper preflight anchors are not unique")
start = t.index(start_marker)
end = t.index(end_marker, start) + len(end_marker)

new_helper_preflight = r'''say "Record target-side official helper contract"
echo "BUILD_HOST_OFFICIAL_HELPER_REQUIRED=NO"
echo "TARGET_ASUS2_OFFICIAL_HELPER_REQUIRED=YES"
echo "TARGET_ASUS2_OFFICIAL_HELPER_EXPECTED_SHA256=$OFFICIAL_HELPER_SHA256"
echo "TARGET_ASUS2_OFFICIAL_HELPER_EXPECTED_TEAM=$DORTANIA_TEAM"
'''
t = t[:start] + new_helper_preflight + t[end:]

bundle_line = 'ditto "$OFFICIAL_HELPER" "$OUT/Contents/Resources/official-privileged-helper"\n'
if t.count(bundle_line) != 1:
    raise SystemExit("D97DW official-helper bundle line is not unique")
t = t.replace(bundle_line, "", 1)

launcher_start = 'cat > "$OUT/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DU" <<\'LAUNCHER\'\n'
launcher_end = '\nLAUNCHER\n'
if t.count(launcher_start) != 1:
    raise SystemExit("D97DW launcher start anchor is not unique")
start = t.index(launcher_start)
end = t.index(launcher_end, start) + len(launcher_end)

new_launcher = r'''cat > "$OUT/Contents/MacOS/OpenCore-Patcher-Tahoe-D97DU" <<'LAUNCHER'
#!/bin/zsh
set -u

SELF_DIR="$(cd "$(dirname "$0")" && /bin/pwd -P)"
APP_ROOT="$(cd "$SELF_DIR/../.." && /bin/pwd -P)"
INNER="$APP_ROOT/Contents/Resources/OpenCore-Patcher.app"
DEBUG_HELPER="$APP_ROOT/Contents/Resources/debug-privileged-helper"
SYSTEM_HELPER="/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper"

EXPECTED_OFFICIAL_SHA="9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a"
EXPECTED_OFFICIAL_TEAM="S74BDJXQMD"

BACKUP=""
BACKUP_READY=0
RESTORED=0

fail() {
    local m="$1"
    echo "FATAL: $m" >&2
    /usr/bin/osascript - "$m" <<'OSA' >/dev/null 2>&1 || true
on run argv
    display alert "D97DU OpenCore Patcher" message (item 1 of argv) as critical
end run
OSA
    exit 1
}

sha256_file() {
    /usr/bin/shasum -a 256 "$1" | /usr/bin/awk '{print $1}'
}

team_id() {
    /usr/bin/codesign -dv --verbose=4 "$1" 2>&1 | /usr/bin/awk -F= '/^TeamIdentifier=/{print $2; exit}'
}

verify_official() {
    local p="$1"
    [[ -f "$p" ]] || return 1
    /usr/bin/codesign --verify --strict "$p" >/dev/null 2>&1 || return 1
    [[ "$(sha256_file "$p")" == "$EXPECTED_OFFICIAL_SHA" ]] || return 1
    [[ "$(team_id "$p")" == "$EXPECTED_OFFICIAL_TEAM" ]] || return 1
    return 0
}

install_helper() {
    local src="$1"
    /usr/bin/osascript - "$src" "$SYSTEM_HELPER" <<'OSA'
on run argv
    set src to item 1 of argv
    set dst to item 2 of argv
    set cmd to "/bin/mkdir -p /Library/PrivilegedHelperTools" & ¬
        " && /bin/cp -f " & quoted form of src & " " & quoted form of dst & ¬
        " && /usr/sbin/chown root:wheel " & quoted form of dst & ¬
        " && /bin/chmod 4755 " & quoted form of dst
    do shell script cmd with administrator privileges
end run
OSA
}

restore_official() {
    if [[ "$BACKUP_READY" -ne 1 || "$RESTORED" -eq 1 ]]; then
        return 0
    fi

    if ! verify_official "$BACKUP"; then
        echo "FATAL: saved official-helper backup failed identity verification" >&2
        return 1
    fi

    if ! install_helper "$BACKUP"; then
        echo "FATAL: failed to restore saved official helper" >&2
        return 1
    fi

    if ! verify_official "$SYSTEM_HELPER"; then
        echo "FATAL: installed helper is not the exact official helper after restore" >&2
        return 1
    fi

    RESTORED=1
    echo "D97DU_TARGET_OFFICIAL_HELPER_RESTORED=PASS"
    return 0
}

cleanup() {
    if [[ "$BACKUP_READY" -eq 1 && "$RESTORED" -ne 1 ]]; then
        restore_official >/dev/null 2>&1 || true
    fi
    if [[ -n "$BACKUP" ]]; then
        /bin/rm -f "$BACKUP" >/dev/null 2>&1 || true
    fi
}
trap cleanup EXIT HUP INT TERM

[[ -d "$INNER" ]] || fail "Custom inner OCLP missing."
[[ -f "$DEBUG_HELPER" ]] || fail "Debug helper missing."
/usr/bin/codesign --verify --deep --strict "$INNER" >/dev/null 2>&1 || fail "Custom inner app signature invalid."
/usr/bin/codesign --verify --strict "$DEBUG_HELPER" >/dev/null 2>&1 || fail "Debug helper signature invalid."

verify_official "$SYSTEM_HELPER" || fail "Current ASUS2 system helper is not the exact official Dortania helper. No swap performed."

BACKUP="$(/usr/bin/mktemp "/tmp/d97du-official-helper.XXXXXX")" || fail "Could not create official-helper backup path."
/bin/cp -p "$SYSTEM_HELPER" "$BACKUP" || fail "Could not save current official helper."
verify_official "$BACKUP" || fail "Saved official-helper backup identity mismatch."
BACKUP_READY=1
echo "D97DU_TARGET_OFFICIAL_HELPER_BACKUP=PASS"

install_helper "$DEBUG_HELPER" || fail "Could not install temporary DEBUG helper."
"$SYSTEM_HELPER" --version >/dev/null 2>&1 || fail "Installed DEBUG helper did not execute."
echo "D97DU_TARGET_DEBUG_HELPER_TEMPORARY=PASS"

/usr/bin/open -W -n "$INNER"
APP_RC=$?

restore_official || fail "Official helper restoration failed. Do NOT reboot."

exit "$APP_RC"
LAUNCHER
'''
t = t[:start] + new_launcher + t[end:]

replacements = {
    'BUNDLED_OFFICIAL="$OUT/Contents/Resources/official-privileged-helper"\n': '',
    'codesign --verify --strict "$BUNDLED_OFFICIAL"\n': '',
    'FINAL_OFFICIAL_SHA="$(shasum -a 256 "$BUNDLED_OFFICIAL" | awk \'{print $1}\')"\n':
        'FINAL_OFFICIAL_SHA="$OFFICIAL_HELPER_SHA256"\n',
    '[[ "$FINAL_OFFICIAL_SHA" == "$OFFICIAL_HELPER_SHA256" ]] || die "Official helper changed during wrapper assembly."\n':
        'echo "D97DW_OFFICIAL_HELPER_BUNDLED=NO"\n',
    'D97DU_OFFICIAL_HELPER_SHA256=$FINAL_OFFICIAL_SHA\n':
        'D97DU_TARGET_OFFICIAL_HELPER_EXPECTED_SHA256=$OFFICIAL_HELPER_SHA256\nD97DU_OFFICIAL_HELPER_BUNDLED=NO\n',
    'echo "OFFICIAL_HELPER_SHA256=$FINAL_OFFICIAL_SHA"\n':
        'echo "TARGET_OFFICIAL_HELPER_EXPECTED_SHA256=$OFFICIAL_HELPER_SHA256"\n',
}
for old, new in replacements.items():
    if t.count(old) != 1:
        raise SystemExit(f"D97DW final-audit anchor count != 1: {old!r} count={t.count(old)}")
    t = t.replace(old, new, 1)

required = [
    'sys.version_info[:2] == (3, 13)',
    'BUILD_HOST_LOCAL_25G82_METALLIB_REQUIRED=NO',
    'BUILD_HOST_OFFICIAL_HELPER_REQUIRED=NO',
    'D97DU_TARGET_OFFICIAL_HELPER_BACKUP=PASS',
    'D97DU_TARGET_OFFICIAL_HELPER_RESTORED=PASS',
    'verify_official "$SYSTEM_HELPER" || fail',
    'D97DU_OFFICIAL_HELPER_BUNDLED=NO',
]
for s in required:
    if s not in t:
        raise SystemExit("D97DW required transformed invariant missing: " + s)

forbidden = [
    '[[ -d "$LOCAL_METALLIB" ]] || die',
    'ditto "$OFFICIAL_HELPER" "$OUT/Contents/Resources/official-privileged-helper"',
    'BUNDLED_OFFICIAL="$OUT/Contents/Resources/official-privileged-helper"',
]
for s in forbidden:
    if s in t:
        raise SystemExit("D97DW forbidden build-host dependency survived: " + s)

fixed.write_text(t, encoding="utf-8")
PYFIX

/bin/chmod 755 "$FIXED"
/bin/bash -n "$FIXED"

FIXED_SHA="$(/usr/bin/shasum -a 256 "$FIXED" | /usr/bin/awk '{print $1}')"
FIXED_BLOB="$(/usr/bin/git hash-object "$FIXED")"

echo "D97DW_FIXED_HELPER_SHA256=$FIXED_SHA"
echo "D97DW_FIXED_HELPER_GIT_BLOB=$FIXED_BLOB"
echo "D97DW_FIXED_HELPER_BASH_N=PASS"
echo "D97DW_BUILD_HOST_METALLIB_REQUIREMENT_REMOVED=PASS"
echo "D97DW_PYTHON_3_13_X86_64_PIN=PASS"
echo "D97DW_BUILD_HOST_OFFICIAL_HELPER_REQUIREMENT_REMOVED=PASS"
echo "D97DW_TARGET_HELPER_SAVE_RESTORE_POLICY=PASS"

exec /bin/bash "$FIXED"
