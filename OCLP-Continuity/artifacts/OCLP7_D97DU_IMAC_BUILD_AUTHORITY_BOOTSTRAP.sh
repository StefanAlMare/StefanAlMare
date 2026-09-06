#!/bin/bash
set -Eeuo pipefail

# D97DU bootstrap. Downloads only the GitHub-persisted authority helper,
# verifies its exact Git blob identity, validates shell syntax, then executes it.
# Intel build host only. The authority helper itself performs NO Root Patch,
# NO EFI mutation and NO reboot.

AUTHORITY_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/main/OCLP-Continuity/artifacts/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.sh"
AUTHORITY_BLOB="ceed3890b5d35efbefc38ebf1a40f358884e58b9"
DEST="$HOME/Downloads/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.authority.sh"

[[ "$(uname -s)" == "Darwin" ]] || { echo "FATAL: macOS required" >&2; exit 2; }
[[ "$(uname -m)" == "x86_64" ]] || { echo "FATAL: Intel/x86_64 build host required" >&2; exit 3; }
command -v curl >/dev/null 2>&1 || { echo "FATAL: curl missing" >&2; exit 4; }
command -v git >/dev/null 2>&1 || { echo "FATAL: git missing" >&2; exit 5; }

/bin/rm -f "$DEST"
/usr/bin/curl -fL --retry 3 "$AUTHORITY_URL" -o "$DEST"
ACTUAL_BLOB="$(/usr/bin/git hash-object "$DEST")"
ACTUAL_SHA256="$(/usr/bin/shasum -a 256 "$DEST" | /usr/bin/awk '{print $1}')"

echo "D97DU_AUTHORITY_EXPECTED_GIT_BLOB=$AUTHORITY_BLOB"
echo "D97DU_AUTHORITY_ACTUAL_GIT_BLOB=$ACTUAL_BLOB"
echo "D97DU_AUTHORITY_SHA256=$ACTUAL_SHA256"
[[ "$ACTUAL_BLOB" == "$AUTHORITY_BLOB" ]] || {
    echo "FATAL: D97DU authority helper identity mismatch" >&2
    exit 6
}

/bin/bash -n "$DEST"
echo "D97DU_AUTHORITY_BASH_N=PASS"
/bin/chmod 755 "$DEST"

exec /bin/bash "$DEST"
