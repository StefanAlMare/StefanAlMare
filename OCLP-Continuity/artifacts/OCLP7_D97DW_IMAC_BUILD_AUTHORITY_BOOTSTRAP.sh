#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DW bootstrap — Intel iMac build host only.
# Fetches exact GitHub-persisted D97DW authority v3, verifies Git blob,
# validates shell syntax, then executes it.
# NO Root Patch. NO EFI mutation. NO reboot.

URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/main/OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_V3.sh"
EXPECTED_BLOB="9d8c8ddc25a1359af0192e657fddd6765015f984"
DEST="$HOME/Downloads/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_V3.authority.sh"

[[ "$(uname -s)" == "Darwin" ]] || { echo "FATAL: macOS required" >&2; exit 2; }
[[ "$(uname -m)" == "x86_64" ]] || { echo "FATAL: Intel/x86_64 build host required" >&2; exit 3; }

/bin/rm -f "$DEST"
/usr/bin/curl -fL --retry 3 "$URL" -o "$DEST"

ACTUAL_BLOB="$(/usr/bin/git hash-object "$DEST")"
ACTUAL_SHA256="$(/usr/bin/shasum -a 256 "$DEST" | /usr/bin/awk '{print $1}')"

echo "D97DW_AUTHORITY_EXPECTED_GIT_BLOB=$EXPECTED_BLOB"
echo "D97DW_AUTHORITY_ACTUAL_GIT_BLOB=$ACTUAL_BLOB"
echo "D97DW_AUTHORITY_SHA256=$ACTUAL_SHA256"

[[ "$ACTUAL_BLOB" == "$EXPECTED_BLOB" ]] || {
    echo "FATAL: D97DW authority identity mismatch" >&2
    exit 4
}

/bin/bash -n "$DEST"
echo "D97DW_AUTHORITY_BASH_N=PASS"
/bin/chmod 755 "$DEST"

exec /bin/bash "$DEST"
