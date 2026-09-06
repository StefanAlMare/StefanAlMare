#!/bin/bash
set -Eeuo pipefail

# OCLP7 D97DX resume bootstrap — Intel iMac build host only.
# Fetch exact GitHub authority, verify Git blob, bash syntax, execute.
# NO Root Patch. NO EFI mutation. NO reboot.

URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/main/OCLP-Continuity/artifacts/OCLP7_D97DX_IMAC_RESUME_BUILD.sh"
EXPECTED_BLOB="b9a2f673bcd382df6d4f2282ad4d6a588fde0b51"
DEST="$HOME/Downloads/OCLP7_D97DX_IMAC_RESUME_BUILD.authority.sh"

[[ "$(uname -s)" == "Darwin" ]] || { echo "FATAL: macOS required" >&2; exit 2; }
[[ "$(uname -m)" == "x86_64" ]] || { echo "FATAL: Intel/x86_64 build host required" >&2; exit 3; }

/bin/rm -f "$DEST"
/usr/bin/curl -fL --retry 3 "$URL" -o "$DEST"

ACTUAL_BLOB="$(/usr/bin/git hash-object "$DEST")"
ACTUAL_SHA256="$(/usr/bin/shasum -a 256 "$DEST" | /usr/bin/awk '{print $1}')"

echo "D97DX_AUTHORITY_EXPECTED_GIT_BLOB=$EXPECTED_BLOB"
echo "D97DX_AUTHORITY_ACTUAL_GIT_BLOB=$ACTUAL_BLOB"
echo "D97DX_AUTHORITY_SHA256=$ACTUAL_SHA256"

[[ "$ACTUAL_BLOB" == "$EXPECTED_BLOB" ]] || {
    echo "FATAL: D97DX authority identity mismatch" >&2
    exit 4
}

/bin/bash -n "$DEST"
echo "D97DX_AUTHORITY_BASH_N=PASS"
/bin/chmod 755 "$DEST"

exec /bin/bash "$DEST"
