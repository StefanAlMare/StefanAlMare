#!/bin/zsh -f

set -euo pipefail

readonly REPOSITORY="StefanAlMare/StefanAlMare"
readonly INPUT_COMMIT="4df8a88644e4694fffe3684983ee81af5ba1d212"
readonly WRAPPER_NAME="OCLP7_D97AG_LOCAL_SOURCE_CORRECTION.command"
readonly PATCH_NAME="D97AG_SOURCE_CORRECTION.patch"
readonly WRAPPER_SHA256="eeb8440c2576e7cdc38dc54a3475319c48f2510e8f38557bbfde04a65ce4cdab"
readonly WRAPPER_BLOB="7fd0d64a94ebad8e12428bd7f4d654c9e1bb78ae"
readonly WRAPPER_BYTES="16321"
readonly PATCH_SHA256="2c4e93e57b2d13762ef90020496f87c2a95c7e39553ff60f948bfacd2b6b659b"
readonly PATCH_BLOB="532f8729658b3bc287fa83963043a4d2a8aa816a"
readonly PATCH_BYTES="3137"
readonly TARGET="/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler"

echo "===== OCLP7 D97AG — PINNED TAHOE XATTR PROBE AND LOCAL SOURCE CORRECTION ====="
echo "PURPOSE=prove_exact_Tahoe_xattr_backend_then_integrate_exact_D97AG_source_correction"
echo "SOURCE_MUTATION=PLANNED_EXACT_TWO_FILES_AFTER_ALL_GATES"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"

for tool in /usr/bin/curl /usr/bin/git /usr/bin/shasum /usr/bin/awk \
            /usr/bin/stat /usr/bin/mktemp /usr/bin/tr /usr/bin/xattr \
            /bin/chmod /bin/zsh; do
    [[ -x "$tool" ]] || {
        echo "D97AG_PINNED_LOCAL=FAIL_CLOSED|REASON=MISSING_TOOL_${tool:t}"
        exit 2
    }
done

readonly WORK="$(/usr/bin/mktemp -d /private/tmp/OCLP7_D97AG_PINNED.XXXXXX)"
readonly WRAPPER="$WORK/$WRAPPER_NAME"
readonly PATCH="$WORK/$PATCH_NAME"
readonly PROBE="$WORK/xattr-probe"
readonly RAW_HOST="raw.githubusercontent.com"
readonly BASE_URL="https://$RAW_HOST/$REPOSITORY/$INPUT_COMMIT"

: > "$PROBE"
/usr/bin/xattr -s -w -x com.stefanalmare.d97ag 000A0DFF41 "$PROBE"

names="$(/usr/bin/xattr -s -- "$PROBE")"
value="$(/usr/bin/xattr -s -p -x -- com.stefanalmare.d97ag "$PROBE" \
    | /usr/bin/tr -d '[:space:]' \
    | /usr/bin/tr '[:lower:]' '[:upper:]')"

[[ "$names" == "com.stefanalmare.d97ag" ]] || {
    echo "D97AG_PINNED_LOCAL=FAIL_CLOSED|REASON=XATTR_NAME_MISMATCH"
    exit 2
}
[[ "$value" == "000A0DFF41" ]] || {
    echo "D97AG_PINNED_LOCAL=FAIL_CLOSED|REASON=XATTR_VALUE_MISMATCH"
    exit 2
}
echo "D97AG_TAHOE_XATTR_BACKEND=PASS"
if [[ -f "$TARGET" && ! -L "$TARGET" ]]; then
    /usr/bin/xattr -s -- "$TARGET" >/dev/null
    echo "D97AG_LIVE_SYSTEM_TARGET_XATTR_READ=PASS"
else
    echo "D97AG_LIVE_SYSTEM_TARGET=ABSENT_ACCEPTED_BEFORE_ROOT_PATCH_DONOR_INSTALL"
fi

/usr/bin/curl -fL "$BASE_URL/$WRAPPER_NAME" -o "$WRAPPER"
/usr/bin/curl -fL "$BASE_URL/$PATCH_NAME" -o "$PATCH"

actual_wrapper_sha="$(/usr/bin/shasum -a 256 "$WRAPPER" | /usr/bin/awk '{print $1}')"
actual_wrapper_blob="$(/usr/bin/git hash-object "$WRAPPER")"
actual_wrapper_bytes="$(/usr/bin/stat -f '%z' "$WRAPPER")"
actual_patch_sha="$(/usr/bin/shasum -a 256 "$PATCH" | /usr/bin/awk '{print $1}')"
actual_patch_blob="$(/usr/bin/git hash-object "$PATCH")"
actual_patch_bytes="$(/usr/bin/stat -f '%z' "$PATCH")"

echo "D97AG_INNER_WRAPPER_SHA256=$actual_wrapper_sha"
echo "D97AG_INNER_WRAPPER_BLOB=$actual_wrapper_blob"
echo "D97AG_INNER_WRAPPER_BYTES=$actual_wrapper_bytes"
echo "D97AG_PATCH_SHA256=$actual_patch_sha"
echo "D97AG_PATCH_BLOB=$actual_patch_blob"
echo "D97AG_PATCH_BYTES=$actual_patch_bytes"

[[ "$actual_wrapper_sha" == "$WRAPPER_SHA256" && \
   "$actual_wrapper_blob" == "$WRAPPER_BLOB" && \
   "$actual_wrapper_bytes" == "$WRAPPER_BYTES" ]] || {
    echo "D97AG_PINNED_LOCAL=FAIL_CLOSED|REASON=INNER_WRAPPER_IDENTITY_MISMATCH"
    exit 2
}
[[ "$actual_patch_sha" == "$PATCH_SHA256" && \
   "$actual_patch_blob" == "$PATCH_BLOB" && \
   "$actual_patch_bytes" == "$PATCH_BYTES" ]] || {
    echo "D97AG_PINNED_LOCAL=FAIL_CLOSED|REASON=PATCH_IDENTITY_MISMATCH"
    exit 2
}
echo "D97AG_PINNED_INPUT_IDENTITIES=PASS"

/bin/chmod 0500 "$WRAPPER"
if /bin/zsh -f "$WRAPPER"; then
    rc=0
else
    rc=$?
fi

echo "D97AG_PINNED_LOCAL_OUTER_RC=$rc"
echo "ROOT_PATCH=AUTO-NO|REBOOT=AUTO-NO|USER_ACTION_NOW=RETURN_COMPLETE_OUTPUT"
exit "$rc"
