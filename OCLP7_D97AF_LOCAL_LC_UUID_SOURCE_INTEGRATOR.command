#!/bin/zsh
set -euo pipefail

ROOT="${1:-/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82}"
TARGET="${2:-/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler}"
EVIDENCE_PARENT="${3:-$HOME/Desktop}"
UUID_FILE="${4:-$HOME/Desktop/OCLP7_D97AF_UUID.txt}"

EXPECTED_ROOT_BRANCH="alex-tahoe-25G82-custom"
EXPECTED_ROOT_HEAD="4143b7077a9a4e5aa41ec7a06c0888597eda9b06"
EXPECTED_HELPERS_SHA="fd37ede683ccb0612a7ba77ffe82b80bb8e081f4192f7485d05cdf8f9b51f515"
EXPECTED_SYSPATCH_SHA="115153b0465102cba0fdd477cc6215c4531e50b2927a99c1c64d12325c64d948"
EXPECTED_METAL_SHA="fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24"
EXPECTED_TARGET_PRE_SHA="524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755"
EXPECTED_TARGET_POST_SHA="a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e"
EXPECTED_OLD_UUID="D5CE0008-587C-3861-971A-4BAEFB7B9C5B"
D97AF_UUID="A4F456DF-7447-49BF-AC4F-102D90023A1E"

STAMP="$(/bin/date +%Y%m%d_%H%M%S)"
REPORT="$EVIDENCE_PARENT/OCLP7_D97AF_LOCAL_LC_UUID_SOURCE_INTEGRATION_REPORT_${STAMP}_$$_${RANDOM}.txt"
BACKUP="$EVIDENCE_PARENT/OCLP7_D97AF_SOURCE_BACKUP_$STAMP"
BACKUP_PARTIAL="$BACKUP.partial"
TMP_BASE="/private/tmp"
[[ -d "$TMP_BASE" ]] || TMP_BASE="/tmp"
umask 077
REPORT_FD_OPEN=0
LOGGING_ACTIVE=0

early_fail() {
  local reason="$1"
  local message
  message="$({
    echo "D97AF_LOCAL_SOURCE_INTEGRATION=FAIL_CLOSED|REASON=$reason"
    echo "INSTALLED_APP_MUTATION=NO"
    echo "SYSTEM_TARGET_MUTATION=NO"
    echo "ROOT_PATCH=AUTO-NO"
    echo "REBOOT=AUTO-NO"
    echo "REPORT=${REPORT:-NOT_CREATED}"
  })"
  printf '%s\n' "$message" >&2
  if [[ "${REPORT_FD_OPEN:-0}" == "1" ]]; then
    printf '%s\n' "$message" >&7 || true
  fi
  if [[ -n "${TMP:-}" && -n "${TMP_BASE:-}" && \
        "$TMP" == "$TMP_BASE"/OCLP7_D97AF_INTEGRATE.* && -d "$TMP" ]]; then
    /bin/rm -rf -- "$TMP" || true
  fi
  exit 2
}

/bin/mkdir -p "$EVIDENCE_PARENT" || early_fail "EVIDENCE_PARENT_CREATE_FAILED"
[[ -d "$EVIDENCE_PARENT" && ! -L "$EVIDENCE_PARENT" ]] || early_fail "EVIDENCE_PARENT_INVALID"
setopt NO_CLOBBER
if ! { exec 7> "$REPORT"; } 2>/dev/null; then
  unsetopt NO_CLOBBER
  early_fail "REPORT_EXCLUSIVE_CREATE_FAILED"
fi
unsetopt NO_CLOBBER
REPORT_FD_OPEN=1
# Keep the wrapper and its report-capture child alive across the complete
# transaction.  The embedded Python child installs its own controlled handlers
# so HUP/INT/QUIT/TERM still trigger a verified source rollback there.
trap '' HUP INT QUIT TERM
/bin/chmod 0600 "$REPORT" || early_fail "REPORT_MODE_FAILED"

TMP=""
TMP="$(/usr/bin/mktemp -d "$TMP_BASE/OCLP7_D97AF_INTEGRATE.XXXXXX")" || {
  early_fail "PRIVATE_TEMP_CREATE_FAILED"
}
[[ -d "$TMP" && ! -L "$TMP" && "$TMP" == "$TMP_BASE"/OCLP7_D97AF_INTEGRATE.* ]] || {
  early_fail "PRIVATE_TEMP_IDENTITY_INVALID"
}

REPORT_PIPE="$TMP/report.pipe"
/usr/bin/mkfifo "$REPORT_PIPE" || early_fail "REPORT_PIPE_CREATE_FAILED"
exec 8>&1 9>&2
{
  while IFS= read -r CAPTURE_LINE || [[ -n "$CAPTURE_LINE" ]]; do
    print -r -- "$CAPTURE_LINE" >&8 || exit 91
    print -r -- "$CAPTURE_LINE" >&7 || exit 92
  done
} < "$REPORT_PIPE" &
CAPTURE_PID=$!
exec > "$REPORT_PIPE" 2>&1
LOGGING_ACTIVE=1

stop_capture() {
  local capture_rc=0
  if [[ "${LOGGING_ACTIVE:-0}" == "1" ]]; then
    exec 1>&8 2>&9
    set +e
    wait "$CAPTURE_PID"
    capture_rc=$?
    set -e
    LOGGING_ACTIVE=0
    exec 8>&- 9>&-
  fi
  return "$capture_rc"
}

cleanup() {
  local rc=$?
  local capture_rc=0
  trap - EXIT
  trap '' HUP INT QUIT TERM
  if [[ "${LOGGING_ACTIVE:-0}" == "1" ]]; then
    set +e
    stop_capture
    capture_rc=$?
    set -e
  fi
  if [[ -n "${TMP:-}" && "$TMP" == "$TMP_BASE"/OCLP7_D97AF_INTEGRATE.* && -d "$TMP" ]]; then
    /bin/rm -rf -- "$TMP" || {
      echo "D97AF_PRIVATE_TEMP_CLEANUP=FAIL|PATH=$TMP" >&2
      rc=2
    }
  fi
  if [[ "$capture_rc" -ne 0 ]]; then
    echo "D97AF_REPORT_CAPTURE=FAIL|CAPTURE_RC=$capture_rc" >&2
    [[ "$rc" -ne 0 ]] || rc=2
  fi
  if [[ "${REPORT_FD_OPEN:-0}" == "1" ]]; then
    exec 7>&-
    REPORT_FD_OPEN=0
  fi
  exit "$rc"
}
trap cleanup EXIT

backup_status() {
  if [[ -d "$BACKUP" && ! -L "$BACKUP" && \
        -f "$BACKUP/.D97AF_BACKUP_COMPLETE" && ! -L "$BACKUP/.D97AF_BACKUP_COMPLETE" ]]; then
    echo "SOURCE_BACKUP_STATE=COMPLETE"
    echo "SOURCE_BACKUP=$BACKUP"
  elif [[ -e "$BACKUP_PARTIAL" || -L "$BACKUP_PARTIAL" ]]; then
    echo "SOURCE_BACKUP_STATE=PARTIAL"
    echo "SOURCE_BACKUP_PARTIAL=$BACKUP_PARTIAL"
  else
    echo "SOURCE_BACKUP_STATE=NOT_CREATED"
  fi
}

source_mutation_status() {
  local state_file="$BACKUP/SOURCE_UPDATE_STATE"
  local state_line=""
  if [[ -f "$state_file" && ! -L "$state_file" ]]; then
    state_line="$(/bin/cat "$state_file" 2>/dev/null || true)"
  fi
  case "$state_line" in
    SOURCE_UPDATE_STATE=COMPLETE)
      echo "SOURCE_MUTATION=YES_EXACT_TWO_FILES"
      ;;
    SOURCE_UPDATE_STATE=ROLLED_BACK)
      echo "SOURCE_MUTATION=NO_NET_ROLLED_BACK"
      ;;
    SOURCE_UPDATE_STATE=PREPARED|SOURCE_UPDATE_STATE=CAS_FAILED_NO_SOURCE_MUTATION)
      echo "SOURCE_MUTATION=NO"
      ;;
    SOURCE_UPDATE_STATE=UPDATE_STARTING|SOURCE_UPDATE_STATE=HELPERS_COMMITTED|SOURCE_UPDATE_STATE=BOTH_SOURCE_FILES_COMMITTED_PENDING_VALIDATION|SOURCE_UPDATE_STATE=ROLLBACK_PARTIAL_EXTERNAL_EDIT_PRESERVED_MANUAL_RECOVERY_REQUIRED|SOURCE_UPDATE_STATE=ROLLBACK_FAILED_MANUAL_RECOVERY_REQUIRED)
      echo "SOURCE_MUTATION=UNKNOWN_OR_PARTIAL_MANUAL_INSPECTION_REQUIRED"
      ;;
    *)
      if [[ -d "$BACKUP" && ! -L "$BACKUP" ]]; then
        echo "SOURCE_MUTATION=UNKNOWN_BACKUP_STATE_UNREADABLE"
      else
        echo "SOURCE_MUTATION=NO"
      fi
      ;;
  esac
}

fail() {
  echo "D97AF_LOCAL_SOURCE_INTEGRATION=FAIL_CLOSED|REASON=$1"
  backup_status
  source_mutation_status
  echo "INSTALLED_APP_MUTATION=NO"
  echo "SYSTEM_TARGET_MUTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

echo "===== OCLP7 D97AF — LOCAL IN-OCLP LC_UUID BUILD-STAMP INTEGRATION ====="
echo "PURPOSE=integrate_exact_frozen_LC_UUID_build_stamp_after_D97AD_without_executable_instruction_change"
echo "SOURCE_ROOT=$ROOT"
echo "TARGET_AUDIT_INPUT=$TARGET"
echo "D97AF_LC_UUID=$D97AF_UUID"
echo "EXPECTED_TARGET_PRE_SHA256=$EXPECTED_TARGET_PRE_SHA"
echo "EXPECTED_TARGET_POST_SHA256=$EXPECTED_TARGET_POST_SHA"
echo "SOURCE_MUTATION=PLANNED_EXACT_TWO_FILES_AFTER_ALL_GATES"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for tool in git shasum codesign otool file mktemp mkfifo; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL_$tool"
done

PYTHON_BIN=""
for candidate in "$ROOT/.venv/bin/python" /usr/local/bin/python3 "$(command -v python3 2>/dev/null || true)"; do
  if [[ -n "$candidate" && -x "$candidate" ]] &&
     "$candidate" -c 'import ast, hashlib, pathlib, shutil, signal, struct, subprocess, sys, uuid; assert sys.version_info >= (3, 10); pathlib.Path(".").stat(follow_symlinks=False)' \
       >/dev/null 2>&1; then
    PYTHON_BIN="$candidate"
    break
  fi
done
[[ -n "$PYTHON_BIN" ]] || fail "PYTHON_NOT_FOUND"
echo "PYTHON_BIN=$PYTHON_BIN"
PYTHON_VERSION="$("$PYTHON_BIN" --version 2>&1)" || fail "PYTHON_VERSION_PROBE_FAILED"
echo "PYTHON_VERSION=$PYTHON_VERSION"

[[ -f "$UUID_FILE" && ! -L "$UUID_FILE" ]] || fail "UUID_FILE_MISSING_OR_SYMLINK"
UUID_FILE_LINE="$(/bin/cat "$UUID_FILE")"
echo "UUID_FILE=$UUID_FILE"
echo "UUID_FILE_LINE=$UUID_FILE_LINE"
[[ "$UUID_FILE_LINE" == "D97AF_LC_UUID=$D97AF_UUID" ]] || fail "UUID_FILE_CONTENT_MISMATCH"

[[ -d "$ROOT/.git" ]] || fail "SOURCE_GIT_REPOSITORY_MISSING"
[[ -f "$TARGET" && ! -L "$TARGET" ]] || fail "TARGET_MISSING_OR_SYMLINK"
[[ ! -e "$BACKUP" && ! -L "$BACKUP" ]] || fail "BACKUP_PATH_ALREADY_EXISTS"
[[ ! -e "$BACKUP_PARTIAL" && ! -L "$BACKUP_PARTIAL" ]] || fail "BACKUP_PARTIAL_PATH_ALREADY_EXISTS"

set +e
"$PYTHON_BIN" - \
  "$ROOT" "$TARGET" "$BACKUP" "$TMP" \
  "$EXPECTED_ROOT_BRANCH" "$EXPECTED_ROOT_HEAD" \
  "$EXPECTED_HELPERS_SHA" "$EXPECTED_SYSPATCH_SHA" "$EXPECTED_METAL_SHA" \
  "$EXPECTED_TARGET_PRE_SHA" "$EXPECTED_TARGET_POST_SHA" \
  "$EXPECTED_OLD_UUID" "$D97AF_UUID" <<'PY'
from __future__ import annotations

import ast
import difflib
import hashlib
import os
import re
import shutil
import signal
import stat
import struct
import subprocess
import sys
import uuid
from pathlib import Path

(
    root_s,
    target_s,
    backup_s,
    tmp_s,
    expected_branch,
    expected_head,
    expected_helpers_sha,
    expected_syspatch_sha,
    expected_metal_sha,
    expected_target_pre_sha,
    expected_target_post_sha,
    expected_old_uuid_s,
    d97af_uuid_s,
) = sys.argv[1:]

root = Path(root_s)
target = Path(target_s)
backup = Path(backup_s)
backup_partial = Path(backup_s + ".partial")
tmp = Path(tmp_s)

helpers_rel = Path("opencore_legacy_patcher/sys_patch/sys_patch_helpers.py")
syspatch_rel = Path("opencore_legacy_patcher/sys_patch/sys_patch.py")
metal_rel = Path("opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py")
helpers = root / helpers_rel
syspatch = root / syspatch_rel
metal = root / metal_rel

expected_changed = sorted(str(p) for p in (metal_rel, syspatch_rel, helpers_rel))
expected_target_size = 1_636_896
expected_d97ad_method_sha = "bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12"
expected_old_uuid = uuid.UUID(expected_old_uuid_s).bytes
d97af_uuid_obj = uuid.UUID(d97af_uuid_s)
d97af_uuid = d97af_uuid_obj.bytes
expected_uuid_command_offset = 0xAA8
expected_uuid_payload_offset = 0xAB0
expected_load_commands_end = 0xEF8
expected_lc_codesig_offset = 0xEE8
expected_codesig_dataoff = 0x188180
expected_codesig_datasize = 0x78A0

new_helper_name = "patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp"
d97ad_helper_name = "patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier"


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def run(command: list[str], *, check: bool = True) -> subprocess.CompletedProcess[str]:
    result = subprocess.run(command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if check and result.returncode != 0:
        raise RuntimeError(
            f"COMMAND_FAILED_RC_{result.returncode}: {' '.join(command)}\n{result.stdout}"
        )
    return result


def xattr_snapshot(path: Path) -> dict[str, bytes]:
    xattrs: dict[str, bytes] = {}
    if hasattr(os, "listxattr") and hasattr(os, "getxattr"):
        for name in sorted(os.listxattr(path, follow_symlinks=False)):
            xattrs[name] = os.getxattr(path, name, follow_symlinks=False)
    return xattrs


def extended_acl_entries(path: Path) -> tuple[str, ...]:
    if sys.platform == "darwin":
        listing = run(["/bin/ls", "-lde", str(path)]).stdout.splitlines()
        return tuple(
            line
            for line in listing[1:]
            if re.match(r"^\s*\d+:\s", line)
        )
    # On non-Darwin validation hosts, POSIX ACLs surface as this xattr.  The
    # delivered wrapper runs on Darwin and uses the native ls -le enumeration.
    attrs = xattr_snapshot(path)
    return ("NON_DARWIN_POSIX_ACL_XATTR",) if "system.posix_acl_access" in attrs else ()


def source_file_gate(path: Path, label: str, *, emit: bool) -> None:
    path_lstat = path.lstat()
    if path.is_symlink() or not stat.S_ISREG(path_lstat.st_mode):
        raise RuntimeError(f"SOURCE_IDENTITY_NOT_REGULAR_NON_SYMLINK:{label}")
    if path_lstat.st_nlink != 1:
        raise RuntimeError(f"SOURCE_LINK_COUNT_MISMATCH:{label}:{path_lstat.st_nlink}")
    if path_lstat.st_uid != os.geteuid():
        raise RuntimeError(f"SOURCE_OWNER_NOT_EFFECTIVE_USER:{label}:{path_lstat.st_uid}")
    source_flags = getattr(path_lstat, "st_flags", 0)
    if source_flags != 0:
        raise RuntimeError(f"SOURCE_FLAGS_NONZERO:{label}:{source_flags}")
    parent_lstat = path.parent.lstat()
    if path.parent.is_symlink() or not stat.S_ISDIR(parent_lstat.st_mode):
        raise RuntimeError(f"SOURCE_PARENT_NOT_REGULAR_DIRECTORY:{label}")
    access_kwargs = {"effective_ids": True} if os.access in os.supports_effective_ids else {}
    if not os.access(path.parent, os.W_OK | os.X_OK, **access_kwargs):
        raise RuntimeError(f"SOURCE_PARENT_NOT_WRITABLE_SEARCHABLE:{label}")
    if parent_lstat.st_dev != path_lstat.st_dev:
        raise RuntimeError(f"SOURCE_PARENT_DEVICE_MISMATCH:{label}")
    acl_entries = extended_acl_entries(path)
    if acl_entries:
        raise RuntimeError(f"SOURCE_EXTENDED_ACL_NOT_ALLOWED:{label}:{acl_entries!r}")
    attrs = xattr_snapshot(path)
    if emit:
        xattr_manifest = [
            (name, len(value), sha256_bytes(value))
            for name, value in sorted(attrs.items())
        ]
        print(f"SOURCE_GATE_{label}=PASS|REGULAR=YES|NLINK=1|OWNER_EUID=YES|FLAGS=0")
        print(f"SOURCE_GATE_{label}_PARENT=WRITABLE_SEARCHABLE_SAME_DEVICE")
        print(f"SOURCE_GATE_{label}_ACL_POLICY=NONE_REQUIRED|ACTUAL=NONE")
        print(f"SOURCE_GATE_{label}_XATTR_POLICY=PRESERVE_EXACT|ACTUAL={xattr_manifest!r}")


def exact_method(tree: ast.AST, name: str) -> ast.FunctionDef:
    hits = [
        node for node in ast.walk(tree)
        if isinstance(node, ast.FunctionDef) and node.name == name
    ]
    if len(hits) != 1:
        raise RuntimeError(f"METHOD_CARDINALITY_MISMATCH:{name}:{len(hits)}")
    return hits[0]


def parse_exact_macho(data: bytes, expected_uuid: bytes) -> dict[str, int]:
    if len(data) != expected_target_size:
        raise RuntimeError(f"MACHO_SIZE_MISMATCH:{len(data)}")
    if len(data) < 32:
        raise RuntimeError("MACHO_HEADER_TRUNCATED")

    magic, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags, reserved = struct.unpack_from(
        "<IiiIIIII", data, 0
    )
    if magic != 0xFEEDFACF:
        raise RuntimeError(f"MACHO_MAGIC_MISMATCH:0x{magic:08X}")
    if cputype != 0x01000007 or cpusubtype != 3 or filetype != 6:
        raise RuntimeError(
            f"MACHO_ARCH_OR_FILETYPE_MISMATCH:{cputype}:{cpusubtype}:{filetype}"
        )
    if ncmds != 25 or sizeofcmds != 3800:
        raise RuntimeError(f"MACHO_LOAD_TOPOLOGY_MISMATCH:{ncmds}:{sizeofcmds}")

    command_end = 32 + sizeofcmds
    if command_end != expected_load_commands_end or command_end > len(data):
        raise RuntimeError(f"MACHO_LOAD_END_MISMATCH:0x{command_end:X}")

    cursor = 32
    uuid_hits: list[tuple[int, int, int]] = []
    codesig_hits: list[tuple[int, int, int, int, int]] = []
    for index in range(ncmds):
        if cursor + 8 > command_end:
            raise RuntimeError(f"MACHO_COMMAND_HEADER_TRUNCATED:{index}")
        cmd, cmdsize = struct.unpack_from("<II", data, cursor)
        if cmdsize < 8 or cursor + cmdsize > command_end:
            raise RuntimeError(f"MACHO_COMMAND_BOUNDS_INVALID:{index}:0x{cursor:X}:{cmdsize}")
        if cmd == 0x1B:
            if cmdsize != 24:
                raise RuntimeError(f"LC_UUID_CMDSIZE_MISMATCH:{cmdsize}")
            uuid_hits.append((index, cursor, cursor + 8))
        if cmd == 0x1D:
            if cmdsize != 16:
                raise RuntimeError(f"LC_CODE_SIGNATURE_CMDSIZE_MISMATCH:{cmdsize}")
            dataoff, datasize = struct.unpack_from("<II", data, cursor + 8)
            codesig_hits.append((index, cursor, cmdsize, dataoff, datasize))
        cursor += cmdsize

    if cursor != command_end:
        raise RuntimeError(f"MACHO_FINAL_CURSOR_MISMATCH:0x{cursor:X}")
    if uuid_hits != [(8, expected_uuid_command_offset, expected_uuid_payload_offset)]:
        raise RuntimeError(f"LC_UUID_TOPOLOGY_MISMATCH:{uuid_hits!r}")
    if codesig_hits != [
        (24, expected_lc_codesig_offset, 16, expected_codesig_dataoff, expected_codesig_datasize)
    ]:
        raise RuntimeError(f"LC_CODE_SIGNATURE_TOPOLOGY_MISMATCH:{codesig_hits!r}")
    if expected_codesig_dataoff + expected_codesig_datasize != len(data):
        raise RuntimeError("LC_CODE_SIGNATURE_END_MISMATCH")
    if data[expected_uuid_payload_offset:expected_uuid_payload_offset + 16] != expected_uuid:
        raise RuntimeError("LC_UUID_PAYLOAD_MISMATCH")

    return {
        "uuid_command_offset": expected_uuid_command_offset,
        "uuid_payload_offset": expected_uuid_payload_offset,
        "codesig_dataoff": expected_codesig_dataoff,
        "codesig_datasize": expected_codesig_datasize,
    }


def metadata_signature(path: Path) -> tuple[int, int, int, int | None, dict[str, bytes]]:
    path_stat = path.lstat()
    return (
        stat.S_IMODE(path_stat.st_mode),
        path_stat.st_uid,
        path_stat.st_gid,
        getattr(path_stat, "st_flags", None),
        xattr_snapshot(path),
    )


def atomic_write(
    path: Path,
    data: bytes,
    expected_metadata: tuple[int, int, int, int | None, dict[str, bytes]],
    expected_current_bytes: bytes,
    *,
    metadata_template: Path | None = None,
    require_current_metadata: bool = True,
) -> None:
    temporary = path.with_name(path.name + ".D97AF-new")
    if temporary.exists() or temporary.is_symlink():
        raise RuntimeError(f"SOURCE_TEMP_PATH_ALREADY_EXISTS:{temporary}")
    source_file_gate(path, "ATOMIC_DESTINATION", emit=False)
    if path.read_bytes() != expected_current_bytes:
        raise RuntimeError(f"SOURCE_CURRENT_BYTES_FIRST_CAS_MISMATCH:{path}")
    if require_current_metadata and metadata_signature(path) != expected_metadata:
        raise RuntimeError(f"SOURCE_METADATA_CAS_MISMATCH:{path}")
    template = metadata_template if metadata_template is not None else path
    if metadata_template is not None:
        validate_rollback_template(template, data, expected_metadata)
    if metadata_signature(template) != expected_metadata:
        raise RuntimeError(f"SOURCE_METADATA_TEMPLATE_MISMATCH:{template}")
    try:
        # macOS /bin/cp -p carries the source ACL, flags and extended metadata to
        # the same-directory sibling; the explicit signature below gates the
        # portable metadata fields and every visible extended attribute.
        run(["/bin/cp", "-p", str(template), str(temporary)])
        if temporary.is_symlink() or not temporary.is_file():
            raise RuntimeError(f"SOURCE_TEMP_IDENTITY_INVALID:{temporary}")
        with temporary.open("r+b") as handle:
            handle.seek(0)
            handle.write(data)
            handle.truncate()
            handle.flush()
            os.fsync(handle.fileno())
        shutil.copystat(template, temporary, follow_symlinks=False)
        temp_stat = temporary.stat(follow_symlinks=False)
        _, expected_uid, expected_gid, _, _ = expected_metadata
        if (temp_stat.st_uid, temp_stat.st_gid) != (expected_uid, expected_gid):
            os.chown(temporary, expected_uid, expected_gid, follow_symlinks=False)
        if metadata_signature(temporary) != expected_metadata:
            raise RuntimeError(f"SOURCE_TEMP_METADATA_MISMATCH:{temporary}")
        if temporary.read_bytes() != data:
            raise RuntimeError(f"SOURCE_TEMP_BYTES_MISMATCH:{temporary}")
        source_file_gate(temporary, "ATOMIC_STAGED", emit=False)
        source_file_gate(path, "ATOMIC_DESTINATION_SECOND_CAS", emit=False)
        if path.read_bytes() != expected_current_bytes:
            raise RuntimeError(f"SOURCE_CURRENT_BYTES_SECOND_CAS_MISMATCH:{path}")
        if metadata_signature(path) != expected_metadata:
            raise RuntimeError(f"SOURCE_CURRENT_METADATA_SECOND_CAS_MISMATCH:{path}")
        os.replace(temporary, path)
        if path.read_bytes() != data:
            raise RuntimeError(f"SOURCE_COMMITTED_BYTES_MISMATCH:{path}")
        if metadata_signature(path) != expected_metadata:
            raise RuntimeError(f"SOURCE_COMMITTED_METADATA_MISMATCH:{path}")
    finally:
        try:
            temporary.unlink()
        except FileNotFoundError:
            pass


branch = run(["git", "-C", str(root), "branch", "--show-current"]).stdout.strip()
head = run(["git", "-C", str(root), "rev-parse", "HEAD"]).stdout.strip()
print(f"SOURCE_BRANCH={branch}")
print(f"SOURCE_HEAD={head}")
if branch != expected_branch:
    raise RuntimeError(f"SOURCE_BRANCH_MISMATCH:{branch}")
if head != expected_head:
    raise RuntimeError(f"SOURCE_HEAD_MISMATCH:{head}")

changed_output = run(["git", "-C", str(root), "diff", "--name-only", "HEAD", "--"]).stdout
changed = sorted(line for line in changed_output.splitlines() if line)
print("SOURCE_TRACKED_CHANGED_FILES=" + ",".join(changed))
if changed != expected_changed:
    raise RuntimeError(f"SOURCE_CHANGED_SET_MISMATCH:{changed!r}")
run(["git", "-C", str(root), "diff", "--check", "HEAD", "--", *expected_changed])
print("SOURCE_PRE_DIFF_CHECK=PASS")

source_file_gate(helpers, "HELPERS", emit=True)
source_file_gate(syspatch, "SYSPATCH", emit=True)
source_file_gate(metal, "METAL_3802", emit=True)

helpers_bytes = helpers.read_bytes()
syspatch_bytes = syspatch.read_bytes()
metal_bytes = metal.read_bytes()
target_bytes = target.read_bytes()

actual_pre_hashes = {
    "helpers": sha256_bytes(helpers_bytes),
    "syspatch": sha256_bytes(syspatch_bytes),
    "metal": sha256_bytes(metal_bytes),
    "target": sha256_bytes(target_bytes),
}
for key, value in actual_pre_hashes.items():
    print(f"PRE_SHA256_{key.upper()}={value}")
expected_pre_hashes = {
    "helpers": expected_helpers_sha,
    "syspatch": expected_syspatch_sha,
    "metal": expected_metal_sha,
    "target": expected_target_pre_sha,
}
if actual_pre_hashes != expected_pre_hashes:
    raise RuntimeError(f"PRE_SHA_SET_MISMATCH:{actual_pre_hashes!r}")

helpers_text = helpers_bytes.decode("utf-8")
syspatch_text = syspatch_bytes.decode("utf-8")
compile(helpers_text, str(helpers), "exec")
compile(syspatch_text, str(syspatch), "exec")
helpers_tree = ast.parse(helpers_text)
syspatch_tree = ast.parse(syspatch_text)

d97ad_node = exact_method(helpers_tree, d97ad_helper_name)
if any(
    isinstance(node, ast.FunctionDef) and node.name == new_helper_name
    for node in ast.walk(helpers_tree)
):
    raise RuntimeError("D97AF_HELPER_ALREADY_PRESENT")
d97ad_segment = ast.get_source_segment(helpers_text, d97ad_node) or ""
if sha256_bytes(d97ad_segment.encode("utf-8")) != expected_d97ad_method_sha:
    raise RuntimeError("D97AD_METHOD_SOURCE_IDENTITY_MISMATCH")
if d97ad_node.end_lineno is None:
    raise RuntimeError("D97AD_METHOD_END_LINE_UNKNOWN")

pre_class = next(
    node for node in helpers_tree.body
    if isinstance(node, ast.ClassDef) and node.name == "SysPatchHelpers"
)
pre_method_count = sum(isinstance(node, ast.FunctionDef) for node in pre_class.body)
if pre_method_count != 86:
    raise RuntimeError(f"PRE_HELPER_METHOD_COUNT_MISMATCH:{pre_method_count}")

if target_bytes.count(expected_old_uuid) != 1:
    raise RuntimeError("OLD_UUID_RAW_CARDINALITY_MISMATCH")
if target_bytes.count(d97af_uuid) != 0:
    raise RuntimeError("NEW_UUID_ALREADY_PRESENT_IN_PREIMAGE")
macho = parse_exact_macho(target_bytes, expected_old_uuid)

patched_target = bytearray(target_bytes)
uuid_off = macho["uuid_payload_offset"]
patched_target[uuid_off:uuid_off + 16] = d97af_uuid
patched_target_bytes = bytes(patched_target)

if patched_target_bytes[:uuid_off] != target_bytes[:uuid_off]:
    raise RuntimeError("TARGET_PREFIX_CHANGED_OUTSIDE_UUID")
if patched_target_bytes[uuid_off + 16:] != target_bytes[uuid_off + 16:]:
    raise RuntimeError("TARGET_SUFFIX_CHANGED_OUTSIDE_UUID")
diff_positions = [
    index for index, (before, after) in enumerate(zip(target_bytes, patched_target_bytes))
    if before != after
]
if diff_positions != list(range(uuid_off, uuid_off + 16)):
    raise RuntimeError(f"TARGET_CHANGED_POSITION_SET_MISMATCH:{diff_positions!r}")
parse_exact_macho(patched_target_bytes, d97af_uuid)
target_post_sha = sha256_bytes(patched_target_bytes)
print(f"D97AF_TARGET_CHANGED_BYTE_COUNT={len(diff_positions)}")
print(f"D97AF_TARGET_CHANGED_RANGE=0x{diff_positions[0]:X}..0x{diff_positions[-1]:X}")
print(f"D97AF_TARGET_POST_SHA256={target_post_sha}")
if target_post_sha != expected_target_post_sha:
    raise RuntimeError(f"TARGET_POST_SHA_MISMATCH:{target_post_sha}")

codesig_off = macho["codesig_dataoff"]
codesig_end = codesig_off + macho["codesig_datasize"]
if patched_target_bytes[codesig_off:codesig_end] != target_bytes[codesig_off:codesig_end]:
    raise RuntimeError("CODE_SIGNATURE_BLOB_CHANGED")

method_block = f'''

    def {new_helper_name}(self, mount_point):
        from pathlib import Path as _Path
        import hashlib as _hashlib
        import os as _os
        import stat as _stat
        import struct as _struct
        import subprocess as _subprocess
        import tempfile as _tempfile
        import uuid as _uuid

        expected_pre_sha = '{expected_target_pre_sha}'
        expected_post_sha = '{expected_target_post_sha}'
        expected_size = {expected_target_size}
        expected_old_uuid_string = '{expected_old_uuid_s}'
        expected_new_uuid_string = '{d97af_uuid_s}'
        expected_old_uuid = _uuid.UUID(expected_old_uuid_string).bytes
        expected_new_uuid = _uuid.UUID(expected_new_uuid_string).bytes
        expected_uuid_command_offset = 0x{expected_uuid_command_offset:X}
        expected_uuid_payload_offset = 0x{expected_uuid_payload_offset:X}
        expected_load_commands_end = 0x{expected_load_commands_end:X}
        expected_codesig_command_offset = 0x{expected_lc_codesig_offset:X}
        expected_codesig_dataoff = 0x{expected_codesig_dataoff:X}
        expected_codesig_datasize = 0x{expected_codesig_datasize:X}
        target = _Path(mount_point) / 'System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler'

        def _sha(blob):
            return _hashlib.sha256(bytes(blob)).hexdigest()

        def _xattrs(path):
            result = {{}}
            for name in sorted(_os.listxattr(path, follow_symlinks=False)):
                result[name] = _os.getxattr(path, name, follow_symlinks=False)
            return result

        def _acl_entries(path):
            result = _subprocess.run(
                ['/bin/ls', '-lde', str(path)],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
                text=True,
            )
            if result.returncode != 0:
                raise RuntimeError('D97AF ACL enumeration failed: ' + result.stdout)
            entries = []
            for line in result.stdout.splitlines()[1:]:
                stripped = line.lstrip()
                prefix = stripped.split(':', 1)[0]
                if prefix.isdigit() and ':' in stripped:
                    entries.append(line)
            return tuple(entries)

        def _target_metadata(path):
            path_lstat = path.lstat()
            if path.is_symlink() or not _stat.S_ISREG(path_lstat.st_mode):
                raise RuntimeError('D97AF target is not a regular non-symlink file')
            if path_lstat.st_nlink != 1:
                raise RuntimeError('D97AF target link count mismatch: ' + str(path_lstat.st_nlink))
            parent_lstat = path.parent.lstat()
            if path.parent.is_symlink() or not _stat.S_ISDIR(parent_lstat.st_mode):
                raise RuntimeError('D97AF target parent identity invalid')
            if parent_lstat.st_dev != path_lstat.st_dev:
                raise RuntimeError('D97AF target parent device mismatch')
            mode_owner = (_stat.S_IMODE(path_lstat.st_mode), path_lstat.st_uid, path_lstat.st_gid)
            if mode_owner != (0o755, 0, 0):
                raise RuntimeError('D97AF target mode/owner mismatch: ' + repr(mode_owner))
            acl_entries = _acl_entries(path)
            if acl_entries:
                raise RuntimeError('D97AF target extended ACL unsupported: ' + repr(acl_entries))
            return (
                mode_owner,
                getattr(path_lstat, 'st_flags', 0),
                _xattrs(path),
                acl_entries,
            )

        def _owned_stage_identity(path, expected_identity):
            path_lstat = path.lstat()
            identity = (path_lstat.st_dev, path_lstat.st_ino)
            if path.is_symlink() or not _stat.S_ISREG(path_lstat.st_mode):
                raise RuntimeError('D97AF owned sibling identity became non-regular')
            if path_lstat.st_nlink != 1 or path_lstat.st_uid != 0:
                raise RuntimeError('D97AF owned sibling link count or owner mismatch')
            if identity != expected_identity:
                raise RuntimeError('D97AF owned sibling inode changed')
            return path_lstat

        def _parse_exact_uuid(blob, expected_uuid):
            if len(blob) != expected_size:
                raise RuntimeError('D97AF exact target size mismatch: ' + str(len(blob)))
            if len(blob) < 32:
                raise RuntimeError('D97AF Mach-O header truncated')
            magic, cputype, cpusubtype, filetype, ncmds, sizeofcmds, flags, reserved = _struct.unpack_from('<IiiIIIII', blob, 0)
            if magic != 0xFEEDFACF or cputype != 0x01000007 or cpusubtype != 3 or filetype != 6:
                raise RuntimeError('D97AF Mach-O identity mismatch')
            if ncmds != 25 or sizeofcmds != 3800:
                raise RuntimeError('D97AF Mach-O load-command topology mismatch')
            command_end = 32 + sizeofcmds
            if command_end != expected_load_commands_end or command_end > len(blob):
                raise RuntimeError('D97AF Mach-O load-command end mismatch')
            cursor = 32
            uuid_hits = []
            codesig_hits = []
            for index in range(ncmds):
                if cursor + 8 > command_end:
                    raise RuntimeError('D97AF Mach-O command header truncated')
                cmd, cmdsize = _struct.unpack_from('<II', blob, cursor)
                if cmdsize < 8 or cursor + cmdsize > command_end:
                    raise RuntimeError('D97AF Mach-O command bounds invalid')
                if cmd == 0x1B:
                    if cmdsize != 24:
                        raise RuntimeError('D97AF LC_UUID cmdsize mismatch')
                    uuid_hits.append((index, cursor, cursor + 8))
                if cmd == 0x1D:
                    if cmdsize != 16:
                        raise RuntimeError('D97AF LC_CODE_SIGNATURE cmdsize mismatch')
                    dataoff, datasize = _struct.unpack_from('<II', blob, cursor + 8)
                    codesig_hits.append((index, cursor, cmdsize, dataoff, datasize))
                cursor += cmdsize
            if cursor != command_end:
                raise RuntimeError('D97AF Mach-O final cursor mismatch')
            if uuid_hits != [(8, expected_uuid_command_offset, expected_uuid_payload_offset)]:
                raise RuntimeError('D97AF LC_UUID topology mismatch: ' + repr(uuid_hits))
            if codesig_hits != [(24, expected_codesig_command_offset, 16, expected_codesig_dataoff, expected_codesig_datasize)]:
                raise RuntimeError('D97AF LC_CODE_SIGNATURE topology mismatch: ' + repr(codesig_hits))
            if expected_codesig_dataoff + expected_codesig_datasize != len(blob):
                raise RuntimeError('D97AF LC_CODE_SIGNATURE end mismatch')
            if bytes(blob[expected_uuid_payload_offset:expected_uuid_payload_offset + 16]) != expected_uuid:
                raise RuntimeError('D97AF LC_UUID payload mismatch')
            return expected_uuid_payload_offset

        target_metadata = _target_metadata(target)
        target_lstat_initial = target.lstat()
        target_identity_initial = (target_lstat_initial.st_dev, target_lstat_initial.st_ino)
        target_xattr_manifest = [
            (name, len(value), _sha(value))
            for name, value in sorted(target_metadata[2].items())
        ]
        logging.info('D97AF_TARGET_METADATA_POLICY=MODE_OWNER_FLAGS_XATTRS_PRESERVE_EXACT|ACL_NONE_REQUIRED|TIMES_ALLOWED_TO_CHANGE')
        logging.info('D97AF_TARGET_FLAGS_PRE=' + str(target_metadata[1]))
        logging.info('D97AF_TARGET_XATTRS_PRE=' + repr(target_xattr_manifest))
        logging.info('D97AF_TARGET_ACL_PRE=NONE')

        data = bytearray(target.read_bytes())
        pre_data = bytes(data)
        pre_sha = _sha(pre_data)
        logging.info('D97AF_LC_UUID_BUILD_STAMP_PRE_SHA=' + pre_sha)
        if pre_sha != expected_pre_sha:
            raise RuntimeError('D97AF expected exact D97AD preimage ' + expected_pre_sha + ', got ' + pre_sha)
        if pre_data.count(expected_old_uuid) != 1 or pre_data.count(expected_new_uuid) != 0:
            raise RuntimeError('D97AF UUID raw cardinality mismatch')
        uuid_off = _parse_exact_uuid(pre_data, expected_old_uuid)
        data[uuid_off:uuid_off + 16] = expected_new_uuid
        post_data = bytes(data)
        if post_data[:uuid_off] != pre_data[:uuid_off] or post_data[uuid_off + 16:] != pre_data[uuid_off + 16:]:
            raise RuntimeError('D97AF bytes outside LC_UUID payload changed')
        changed = [index for index, (before, after) in enumerate(zip(pre_data, post_data)) if before != after]
        if changed != list(range(uuid_off, uuid_off + 16)):
            raise RuntimeError('D97AF changed-byte position set mismatch: ' + repr(changed))
        _parse_exact_uuid(post_data, expected_new_uuid)
        post_sha = _sha(post_data)
        if post_sha != expected_post_sha:
            raise RuntimeError('D97AF LC_UUID postimage SHA mismatch: ' + post_sha + ' != ' + expected_post_sha)
        if post_data[expected_codesig_dataoff:expected_codesig_dataoff + expected_codesig_datasize] != pre_data[expected_codesig_dataoff:expected_codesig_dataoff + expected_codesig_datasize]:
            raise RuntimeError('D97AF code-signature blob changed')

        temp_name = None
        staged_target = None
        staged_target_created_by_us = False
        staged_target_identity = None
        try:
            with _tempfile.NamedTemporaryFile(prefix='MTLCompiler-32023-Tahoe-D97AF-', dir='/private/tmp', delete=False) as temp_handle:
                temp_handle.write(post_data)
                temp_handle.flush()
                _os.fsync(temp_handle.fileno())
                temp_name = temp_handle.name
            if _hashlib.sha256(_Path(temp_name).read_bytes()).hexdigest() != expected_post_sha:
                raise RuntimeError('D97AF private temporary SHA mismatch')

            staged_target = target.with_name(target.name + '.D97AF-new-' + _uuid.uuid4().hex)
            if staged_target.exists() or staged_target.is_symlink():
                raise RuntimeError('D97AF destination sibling already exists')
            subprocess_wrapper.run_as_root_and_verify(
                ['/bin/sh', '-c', 'set -C; umask 077; : > "$1"', 'D97AF-reserve', str(staged_target)],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
            )
            reserved_lstat = staged_target.lstat()
            target_parent_lstat = target.parent.lstat()
            if staged_target.is_symlink() or not _stat.S_ISREG(reserved_lstat.st_mode):
                raise RuntimeError('D97AF reserved sibling identity invalid')
            reserved_mode_owner = (
                _stat.S_IMODE(reserved_lstat.st_mode),
                reserved_lstat.st_uid,
                reserved_lstat.st_gid,
            )
            if reserved_lstat.st_nlink != 1 or reserved_mode_owner != (0o600, 0, 0):
                raise RuntimeError('D97AF reserved sibling link count, mode or owner mismatch')
            if reserved_lstat.st_dev != target_parent_lstat.st_dev:
                raise RuntimeError('D97AF reserved sibling filesystem mismatch')
            staged_target_identity = (reserved_lstat.st_dev, reserved_lstat.st_ino)
            staged_target_created_by_us = True

            # Copy all target metadata first, without replacing the exclusively
            # reserved inode.  Then overwrite only its data fork in that inode.
            subprocess_wrapper.run_as_root_and_verify(
                ['/bin/cp', '-p', str(target), str(staged_target)],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
            )
            _owned_stage_identity(staged_target, staged_target_identity)
            if _target_metadata(staged_target) != target_metadata:
                raise RuntimeError('D97AF cp -p did not preserve exact target metadata')
            subprocess_wrapper.run_as_root_and_verify(
                ['/bin/chflags', '0', str(staged_target)],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
            )
            _owned_stage_identity(staged_target, staged_target_identity)
            subprocess_wrapper.run_as_root_and_verify(
                ['/bin/dd', 'if=' + temp_name, 'of=' + str(staged_target), 'bs=1048576', 'conv=notrunc'],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
            )
            subprocess_wrapper.run_as_root_and_verify(
                ['/bin/chflags', format(target_metadata[1], 'o'), str(staged_target)],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
            )
            _owned_stage_identity(staged_target, staged_target_identity)
            if _target_metadata(staged_target) != target_metadata:
                raise RuntimeError('D97AF staged target metadata changed after data-fork write')
            staged_data = staged_target.read_bytes()
            staged_sha = _sha(staged_data)
            if staged_sha != expected_post_sha:
                raise RuntimeError('D97AF destination sibling SHA mismatch: ' + staged_sha)
            _parse_exact_uuid(staged_data, expected_new_uuid)
            if target.read_bytes() != pre_data:
                raise RuntimeError('D97AF immediate target CAS mismatch before atomic rename')
            target_lstat_cas = target.lstat()
            if (target_lstat_cas.st_dev, target_lstat_cas.st_ino) != target_identity_initial:
                raise RuntimeError('D97AF immediate target inode CAS mismatch before atomic rename')
            if _target_metadata(target) != target_metadata:
                raise RuntimeError('D97AF immediate target metadata CAS mismatch before atomic rename')

            # The verified sibling resides on the destination APFS volume;
            # /bin/mv therefore commits it with one same-filesystem rename.
            subprocess_wrapper.run_as_root_and_verify(
                ['/bin/mv', '-f', str(staged_target), str(target)],
                stdout=_subprocess.PIPE,
                stderr=_subprocess.STDOUT,
            )
        finally:
            if temp_name is not None:
                try:
                    _Path(temp_name).unlink()
                except Exception as cleanup_error:
                    logging.warning('D97AF private temporary cleanup non-fatal: ' + repr(cleanup_error))
            if staged_target_created_by_us and staged_target is not None and staged_target_identity is not None:
                try:
                    cleanup_lstat = staged_target.lstat()
                except FileNotFoundError:
                    pass
                except Exception as cleanup_error:
                    logging.warning('D97AF sibling cleanup lstat non-fatal: ' + repr(cleanup_error))
                else:
                    cleanup_identity = (cleanup_lstat.st_dev, cleanup_lstat.st_ino)
                    cleanup_owned = (
                        cleanup_identity == staged_target_identity
                        and not staged_target.is_symlink()
                        and _stat.S_ISREG(cleanup_lstat.st_mode)
                        and cleanup_lstat.st_nlink == 1
                        and cleanup_lstat.st_uid == 0
                        and cleanup_lstat.st_gid == 0
                    )
                    if cleanup_owned:
                        try:
                            subprocess_wrapper.run_as_root_and_verify(
                                ['/bin/rm', '-f', str(staged_target)],
                                stdout=_subprocess.PIPE,
                                stderr=_subprocess.STDOUT,
                            )
                        except Exception as cleanup_error:
                            logging.warning('D97AF owned sibling cleanup non-fatal: ' + repr(cleanup_error))
                    else:
                        logging.error('D97AF sibling cleanup refused: path identity is not the owned inode')

        committed = target.read_bytes()
        committed_sha = _sha(committed)
        if committed_sha != expected_post_sha:
            raise RuntimeError('D97AF committed SHA mismatch: ' + committed_sha + ' != ' + expected_post_sha)
        _parse_exact_uuid(committed, expected_new_uuid)
        committed_stat = target.lstat()
        if staged_target_identity is None or (committed_stat.st_dev, committed_stat.st_ino) != staged_target_identity:
            raise RuntimeError('D97AF committed inode is not the verified staged inode')
        if _target_metadata(target) != target_metadata:
            raise RuntimeError('D97AF committed metadata differs from exact preimage metadata')
        logging.info('D97AF_LC_UUID_BUILD_STAMP_OLD=' + expected_old_uuid_string)
        logging.info('D97AF_LC_UUID_BUILD_STAMP_NEW=' + expected_new_uuid_string)
        logging.info('D97AF_LC_UUID_BUILD_STAMP_OFFSET=0xAB0')
        logging.info('D97AF_LC_UUID_BUILD_STAMP_POST_SHA=' + committed_sha)
        logging.info('D97AF_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS')
        logging.info('D97AF_TARGET_METADATA_PRESERVE_EXACT=PASS')
        logging.info('D97AF_LC_UUID_BUILD_STAMP=PASS')
        logging.info('D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED')
        logging.info('D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED')
'''

helper_lines = helpers_text.splitlines(keepends=True)
insert_index = d97ad_node.end_lineno
helpers_new = "".join(helper_lines[:insert_index]) + method_block + "".join(helper_lines[insert_index:])
if helpers_new.count(f"    def {new_helper_name}(") != 1:
    raise RuntimeError("D97AF_HELPER_TEXT_CARDINALITY_MISMATCH")
if helpers_new.replace(method_block, "", 1) != helpers_text:
    raise RuntimeError("HELPERS_TRANSFORM_NOT_INSERTION_ONLY")

d97ad_call = (
    "                sys_patch_helpers.SysPatchHelpers(self.constants)."
    + d97ad_helper_name
    + "(mount_point=self.mount_location)\n"
)
d97af_call = (
    "                sys_patch_helpers.SysPatchHelpers(self.constants)."
    + new_helper_name
    + "(mount_point=self.mount_location)\n"
)
if syspatch_text.count(d97ad_call) != 1:
    raise RuntimeError("D97AD_CALL_TEXT_CARDINALITY_MISMATCH")
if d97af_call in syspatch_text:
    raise RuntimeError("D97AF_CALL_ALREADY_PRESENT")
syspatch_new = syspatch_text.replace(d97ad_call, d97ad_call + d97af_call, 1)
if syspatch_new.replace(d97af_call, "", 1) != syspatch_text:
    raise RuntimeError("SYSPATCH_TRANSFORM_NOT_ONE_CALL_INSERTION")

compile(helpers_new, str(helpers), "exec")
compile(syspatch_new, str(syspatch), "exec")
helpers_new_tree = ast.parse(helpers_new)
syspatch_new_tree = ast.parse(syspatch_new)
new_d97ad_node = exact_method(helpers_new_tree, d97ad_helper_name)
new_d97af_node = exact_method(helpers_new_tree, new_helper_name)
new_d97ad_segment = ast.get_source_segment(helpers_new, new_d97ad_node) or ""
if sha256_bytes(new_d97ad_segment.encode("utf-8")) != expected_d97ad_method_sha:
    raise RuntimeError("D97AD_METHOD_CHANGED_DURING_INTEGRATION")

post_class = next(
    node for node in helpers_new_tree.body
    if isinstance(node, ast.ClassDef) and node.name == "SysPatchHelpers"
)
post_method_count = sum(isinstance(node, ast.FunctionDef) for node in post_class.body)
if post_method_count != pre_method_count + 1 or post_method_count != 87:
    raise RuntimeError(f"POST_HELPER_METHOD_COUNT_MISMATCH:{post_method_count}")

ordered_names = [
    "patch_mtl_compiler_service_version_selector",
    "patch_mtl_compiler_tahoe_request_layout",
    "patch_mtl_compiler_tahoe_force_serialized_bitcode",
    "patch_mtl_compiler_tahoe_air_request_default_2_6",
    "patch_mtl_compiler_tahoe_true_five_clean_control",
    "patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports",
    "patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports",
    d97ad_helper_name,
    new_helper_name,
]
target_name_set = set(ordered_names)
actual_calls = sorted(
    (
        node.lineno,
        node.func.attr,
    )
    for node in ast.walk(syspatch_new_tree)
    if isinstance(node, ast.Call)
    and isinstance(node.func, ast.Attribute)
    and node.func.attr in target_name_set
)
actual_order = [name for _, name in actual_calls]
if actual_order != ordered_names:
    raise RuntimeError(f"ACTIVE_CALL_ORDER_MISMATCH:{actual_order!r}")
for name in ordered_names:
    if actual_order.count(name) != 1:
        raise RuntimeError(f"ACTIVE_CALL_CARDINALITY_MISMATCH:{name}")

helpers_new_bytes = helpers_new.encode("utf-8")
syspatch_new_bytes = syspatch_new.encode("utf-8")
helpers_post_sha = sha256_bytes(helpers_new_bytes)
syspatch_post_sha = sha256_bytes(syspatch_new_bytes)
new_method_segment = ast.get_source_segment(helpers_new, new_d97af_node) or ""
new_method_sha = sha256_bytes(new_method_segment.encode("utf-8"))

staged_helpers = tmp / "sys_patch_helpers.py.D97AF"
staged_syspatch = tmp / "sys_patch.py.D97AF"
staged_target = tmp / "MTLCompiler.D97AF"
staged_helpers.write_bytes(helpers_new_bytes)
staged_syspatch.write_bytes(syspatch_new_bytes)
staged_target.write_bytes(patched_target_bytes)

pre_codesign = run(["/usr/bin/codesign", "--verify", "--verbose=4", str(target)], check=False)
post_codesign = run(["/usr/bin/codesign", "--verify", "--verbose=4", str(staged_target)], check=False)
print(f"TARGET_PRE_CODESIGN_RC={pre_codesign.returncode}")
print(f"TARGET_POST_CODESIGN_RC={post_codesign.returncode}")
if pre_codesign.returncode == 0:
    raise RuntimeError("PRE_D97AD_CODESIGN_VALID_STOP")
if pre_codesign.returncode != 1 or post_codesign.returncode != 1:
    raise RuntimeError(
        f"CODESIGN_CLASS_CHANGED:{pre_codesign.returncode}:{post_codesign.returncode}"
    )

diff_text = "".join(
    difflib.unified_diff(
        helpers_text.splitlines(keepends=True),
        helpers_new.splitlines(keepends=True),
        fromfile=str(helpers_rel) + ".D97AD-pre-D97AF",
        tofile=str(helpers_rel) + ".D97AF",
    )
) + "".join(
    difflib.unified_diff(
        syspatch_text.splitlines(keepends=True),
        syspatch_new.splitlines(keepends=True),
        fromfile=str(syspatch_rel) + ".D97AD-pre-D97AF",
        tofile=str(syspatch_rel) + ".D97AF",
    )
)

manifest_lines = [
    f"SOURCE_ROOT={root}",
    f"SOURCE_BRANCH={branch}",
    f"SOURCE_HEAD={head}",
    f"D97AF_LC_UUID={d97af_uuid_s}",
    f"D97AF_LC_UUID_RAW={d97af_uuid.hex()}",
    f"D97AF_LC_UUID_COMMAND_OFFSET=0x{expected_uuid_command_offset:X}",
    f"D97AF_LC_UUID_PAYLOAD_OFFSET=0x{expected_uuid_payload_offset:X}",
    f"D97AF_TARGET_PRE_SHA256={expected_target_pre_sha}",
    f"D97AF_TARGET_POST_SHA256={expected_target_post_sha}",
    f"D97AF_TARGET_BYTES={len(patched_target_bytes)}",
    f"D97AF_TARGET_CHANGED_BYTE_COUNT={len(diff_positions)}",
    f"D97AF_HELPERS_PRE_SHA256={expected_helpers_sha}",
    f"D97AF_HELPERS_POST_SHA256={helpers_post_sha}",
    f"D97AF_SYSPATCH_PRE_SHA256={expected_syspatch_sha}",
    f"D97AF_SYSPATCH_POST_SHA256={syspatch_post_sha}",
    f"D97AF_METAL_3802_UNCHANGED_SHA256={expected_metal_sha}",
    f"D97AD_METHOD_SOURCE_SHA256={expected_d97ad_method_sha}",
    f"D97AF_METHOD_SOURCE_SHA256={new_method_sha}",
    "D97AF_ACTIVE_CALL_ORDER=" + "->".join(ordered_names),
    "D97AF_LC_UUID_BUILD_STAMP_SOURCE_STATE=READY",
    "D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED",
    "D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED",
]

helpers_metadata = metadata_signature(helpers)
syspatch_metadata = metadata_signature(syspatch)
metal_metadata = metadata_signature(metal)
manifest_lines.extend(
    [
        "D97AF_HELPERS_METADATA=" + repr(helpers_metadata[:4]),
        "D97AF_SYSPATCH_METADATA=" + repr(syspatch_metadata[:4]),
        "D97AF_METAL_3802_METADATA=" + repr(metal_metadata[:4]),
        "D97AF_HELPERS_XATTR_NAMES=" + repr(sorted(helpers_metadata[4])),
        "D97AF_SYSPATCH_XATTR_NAMES=" + repr(sorted(syspatch_metadata[4])),
        "D97AF_METAL_3802_XATTR_NAMES=" + repr(sorted(metal_metadata[4])),
    ]
)


class ControlledSignal(BaseException):
    pass


managed_signals = tuple(
    sig_value
    for sig_value in (
        getattr(signal, "SIGHUP", None),
        getattr(signal, "SIGINT", None),
        getattr(signal, "SIGQUIT", None),
        getattr(signal, "SIGTERM", None),
    )
    if sig_value is not None
)


def controlled_signal_handler(signum: int, frame: object) -> None:
    del frame
    raise ControlledSignal(f"CONTROLLED_SIGNAL_{signum}")


def install_controlled_signal_handlers() -> dict[int, object]:
    previous: dict[int, object] = {}
    for sig_value in managed_signals:
        previous[sig_value] = signal.getsignal(sig_value)
        signal.signal(sig_value, controlled_signal_handler)
    return previous


def ignore_managed_signals() -> None:
    for sig_value in managed_signals:
        signal.signal(sig_value, signal.SIG_IGN)


def restore_signal_handlers(previous: dict[int, object]) -> None:
    for sig_value, handler in previous.items():
        signal.signal(sig_value, handler)


def write_private_file(path: Path, data: bytes) -> None:
    descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    try:
        with os.fdopen(descriptor, "wb", closefd=False) as handle:
            handle.write(data)
            handle.flush()
            os.fsync(handle.fileno())
    finally:
        os.close(descriptor)


helpers_backup_replica = backup / "sys_patch_helpers.py.D97AD-pre-D97AF"
syspatch_backup_replica = backup / "sys_patch.py.D97AD-pre-D97AF"
backup_handlers = install_controlled_signal_handlers()
try:
    backup_partial.mkdir(mode=0o700)
    partial_helpers_replica = backup_partial / helpers_backup_replica.name
    partial_syspatch_replica = backup_partial / syspatch_backup_replica.name
    run(["/bin/cp", "-p", str(helpers), str(partial_helpers_replica)])
    run(["/bin/cp", "-p", str(syspatch), str(partial_syspatch_replica)])
    if partial_helpers_replica.read_bytes() != helpers_bytes:
        raise RuntimeError("BACKUP_HELPERS_BYTE_MISMATCH")
    if partial_syspatch_replica.read_bytes() != syspatch_bytes:
        raise RuntimeError("BACKUP_SYSPATCH_BYTE_MISMATCH")
    if metadata_signature(partial_helpers_replica) != helpers_metadata:
        raise RuntimeError("BACKUP_HELPERS_METADATA_MISMATCH")
    if metadata_signature(partial_syspatch_replica) != syspatch_metadata:
        raise RuntimeError("BACKUP_SYSPATCH_METADATA_MISMATCH")

    write_private_file(backup_partial / "metal_3802.py.D97AD-unchanged", metal_bytes)
    write_private_file(backup_partial / "MTLCompiler.D97AD-pre-D97AF", target_bytes)
    write_private_file(backup_partial / "MTLCompiler.D97AF-expected", patched_target_bytes)
    write_private_file(backup_partial / "codesign-pre.txt", pre_codesign.stdout.encode("utf-8"))
    write_private_file(
        backup_partial / "codesign-post-staged.txt",
        post_codesign.stdout.encode("utf-8"),
    )
    write_private_file(
        backup_partial / "D97AF_SOURCE_INTEGRATION.diff",
        diff_text.encode("utf-8"),
    )
    write_private_file(
        backup_partial / "D97AF_INTEGRATION_MANIFEST.env",
        ("\n".join(manifest_lines) + "\n").encode("utf-8"),
    )
    write_private_file(
        backup_partial / "SOURCE_UPDATE_STATE",
        b"SOURCE_UPDATE_STATE=PREPARED\n",
    )
    # This marker is written last.  Only a directory carrying it may be
    # advertised by the outer wrapper as a complete recovery backup.
    write_private_file(
        backup_partial / ".D97AF_BACKUP_COMPLETE",
        b"D97AF_BACKUP=COMPLETE\n",
    )
    os.replace(backup_partial, backup)
except BaseException:
    ignore_managed_signals()
    try:
        if backup_partial.exists() and not backup_partial.is_symlink():
            shutil.rmtree(backup_partial)
    finally:
        restore_signal_handlers(backup_handlers)
    raise
else:
    restore_signal_handlers(backup_handlers)

if not (backup / ".D97AF_BACKUP_COMPLETE").is_file():
    raise RuntimeError("TRANSACTIONAL_BACKUP_COMPLETION_MARKER_MISSING")
print(f"D97AF_TRANSACTIONAL_SOURCE_BACKUP=PASS|PATH={backup}")


def validate_rollback_template(
    template: Path,
    expected_data: bytes,
    expected_metadata: tuple[int, int, int, int | None, dict[str, bytes]],
) -> None:
    if template.parent != backup:
        raise RuntimeError(f"ROLLBACK_TEMPLATE_OUTSIDE_EXACT_BACKUP:{template}")
    backup_lstat = backup.lstat()
    if backup.is_symlink() or not stat.S_ISDIR(backup_lstat.st_mode):
        raise RuntimeError("ROLLBACK_BACKUP_DIRECTORY_IDENTITY_INVALID")
    if backup_lstat.st_uid != os.geteuid() or stat.S_IMODE(backup_lstat.st_mode) != 0o700:
        raise RuntimeError("ROLLBACK_BACKUP_DIRECTORY_OWNER_OR_MODE_INVALID")
    if getattr(backup_lstat, "st_flags", 0) != 0:
        raise RuntimeError("ROLLBACK_BACKUP_DIRECTORY_FLAGS_NONZERO")
    marker = backup / ".D97AF_BACKUP_COMPLETE"
    marker_lstat = marker.lstat()
    if marker.is_symlink() or not stat.S_ISREG(marker_lstat.st_mode) or marker_lstat.st_nlink != 1:
        raise RuntimeError("ROLLBACK_BACKUP_COMPLETION_MARKER_IDENTITY_INVALID")
    if marker_lstat.st_uid != os.geteuid() or marker.read_bytes() != b"D97AF_BACKUP=COMPLETE\n":
        raise RuntimeError("ROLLBACK_BACKUP_COMPLETION_MARKER_CONTENT_INVALID")
    source_file_gate(template, "ROLLBACK_TEMPLATE", emit=False)
    if template.read_bytes() != expected_data:
        raise RuntimeError(f"ROLLBACK_TEMPLATE_BYTES_MISMATCH:{template}")
    if metadata_signature(template) != expected_metadata:
        raise RuntimeError(f"ROLLBACK_TEMPLATE_METADATA_MISMATCH:{template}")


validate_rollback_template(helpers_backup_replica, helpers_bytes, helpers_metadata)
validate_rollback_template(syspatch_backup_replica, syspatch_bytes, syspatch_metadata)
print("D97AF_ROLLBACK_TEMPLATE_GATES=PASS")


def write_source_update_state(value: str) -> None:
    state_path = backup / "SOURCE_UPDATE_STATE"
    temporary = backup / "SOURCE_UPDATE_STATE.D97AF-new"
    if temporary.exists() or temporary.is_symlink():
        raise RuntimeError("SOURCE_UPDATE_STATE_TEMP_ALREADY_EXISTS")
    try:
        write_private_file(temporary, ("SOURCE_UPDATE_STATE=" + value + "\n").encode("utf-8"))
        os.replace(temporary, state_path)
    finally:
        try:
            temporary.unlink()
        except FileNotFoundError:
            pass


def assert_immediate_source_cas() -> None:
    source_file_gate(helpers, "HELPERS_IMMEDIATE_CAS", emit=False)
    source_file_gate(syspatch, "SYSPATCH_IMMEDIATE_CAS", emit=False)
    source_file_gate(metal, "METAL_IMMEDIATE_CAS", emit=False)
    if helpers.read_bytes() != helpers_bytes:
        raise RuntimeError("IMMEDIATE_CAS_HELPERS_BYTES_CHANGED")
    if syspatch.read_bytes() != syspatch_bytes:
        raise RuntimeError("IMMEDIATE_CAS_SYSPATCH_BYTES_CHANGED")
    if metal.read_bytes() != metal_bytes:
        raise RuntimeError("IMMEDIATE_CAS_METAL_BYTES_CHANGED")
    if target.read_bytes() != target_bytes:
        raise RuntimeError("IMMEDIATE_CAS_TARGET_BYTES_CHANGED")
    if metadata_signature(helpers) != helpers_metadata:
        raise RuntimeError("IMMEDIATE_CAS_HELPERS_METADATA_CHANGED")
    if metadata_signature(syspatch) != syspatch_metadata:
        raise RuntimeError("IMMEDIATE_CAS_SYSPATCH_METADATA_CHANGED")
    if metadata_signature(metal) != metal_metadata:
        raise RuntimeError("IMMEDIATE_CAS_METAL_METADATA_CHANGED")
    cas_branch = run(["git", "-C", str(root), "branch", "--show-current"]).stdout.strip()
    cas_head = run(["git", "-C", str(root), "rev-parse", "HEAD"]).stdout.strip()
    if (cas_branch, cas_head) != (expected_branch, expected_head):
        raise RuntimeError(f"IMMEDIATE_CAS_GIT_IDENTITY_CHANGED:{cas_branch}:{cas_head}")
    cas_changed = sorted(
        line
        for line in run(["git", "-C", str(root), "diff", "--name-only", "HEAD", "--"]).stdout.splitlines()
        if line
    )
    if cas_changed != expected_changed:
        raise RuntimeError(f"IMMEDIATE_CAS_CHANGED_SET_MISMATCH:{cas_changed!r}")
    run(["git", "-C", str(root), "diff", "--check", "HEAD", "--", *expected_changed])


source_update_started = False
update_handlers = install_controlled_signal_handlers()
try:
    assert_immediate_source_cas()
    print("D97AF_IMMEDIATE_PRECOMMIT_CAS=PASS")
    write_source_update_state("UPDATE_STARTING")
    source_update_started = True
    atomic_write(helpers, helpers_new_bytes, helpers_metadata, helpers_bytes)
    write_source_update_state("HELPERS_COMMITTED")
    atomic_write(syspatch, syspatch_new_bytes, syspatch_metadata, syspatch_bytes)
    write_source_update_state("BOTH_SOURCE_FILES_COMMITTED_PENDING_VALIDATION")

    if sha256_bytes(helpers.read_bytes()) != helpers_post_sha:
        raise RuntimeError("COMMITTED_HELPERS_SHA_MISMATCH")
    if sha256_bytes(syspatch.read_bytes()) != syspatch_post_sha:
        raise RuntimeError("COMMITTED_SYSPATCH_SHA_MISMATCH")
    if sha256_bytes(metal.read_bytes()) != expected_metal_sha:
        raise RuntimeError("METAL_3802_CHANGED_DURING_COMMIT")
    compile(helpers.read_text(), str(helpers), "exec")
    compile(syspatch.read_text(), str(syspatch), "exec")
    run(["git", "-C", str(root), "diff", "--check", "HEAD", "--", *expected_changed])
    changed_after = sorted(
        line for line in run(["git", "-C", str(root), "diff", "--name-only", "HEAD", "--"]).stdout.splitlines()
        if line
    )
    if changed_after != expected_changed:
        raise RuntimeError(f"POST_SOURCE_CHANGED_SET_MISMATCH:{changed_after!r}")
    write_source_update_state("COMPLETE")
except BaseException as original_error:
    ignore_managed_signals()
    if source_update_started:
        try:
            helpers_rollback_current = helpers.read_bytes()
            syspatch_rollback_current = syspatch.read_bytes()
            rollback_conflicts: list[str] = []
            if helpers_rollback_current in (helpers_bytes, helpers_new_bytes):
                atomic_write(
                    helpers,
                    helpers_bytes,
                    helpers_metadata,
                    helpers_rollback_current,
                    metadata_template=helpers_backup_replica,
                    require_current_metadata=False,
                )
            else:
                rollback_conflicts.append("HELPERS_EXTERNAL_BYTES_PRESERVED")
            if syspatch_rollback_current in (syspatch_bytes, syspatch_new_bytes):
                atomic_write(
                    syspatch,
                    syspatch_bytes,
                    syspatch_metadata,
                    syspatch_rollback_current,
                    metadata_template=syspatch_backup_replica,
                    require_current_metadata=False,
                )
            else:
                rollback_conflicts.append("SYSPATCH_EXTERNAL_BYTES_PRESERVED")
            if rollback_conflicts:
                write_source_update_state("ROLLBACK_PARTIAL_EXTERNAL_EDIT_PRESERVED_MANUAL_RECOVERY_REQUIRED")
                print("D97AF_ROLLBACK_EXTERNAL_EDIT_PRESERVED=" + ",".join(rollback_conflicts))
            else:
                if helpers.read_bytes() != helpers_bytes or syspatch.read_bytes() != syspatch_bytes:
                    raise RuntimeError("SOURCE_ROLLBACK_BYTE_VERIFICATION_FAILED")
                if metadata_signature(helpers) != helpers_metadata:
                    raise RuntimeError("SOURCE_ROLLBACK_HELPERS_METADATA_FAILED")
                if metadata_signature(syspatch) != syspatch_metadata:
                    raise RuntimeError("SOURCE_ROLLBACK_SYSPATCH_METADATA_FAILED")
                write_source_update_state("ROLLED_BACK")
                print("D97AF_SOURCE_ROLLBACK=PASS")
        except BaseException as rollback_error:
            try:
                write_source_update_state("ROLLBACK_FAILED_MANUAL_RECOVERY_REQUIRED")
            except BaseException:
                pass
            restore_signal_handlers(update_handlers)
            raise RuntimeError(
                f"SOURCE_ROLLBACK_FAILED_AFTER:{type(original_error).__name__}:"
                f"{type(rollback_error).__name__}:{rollback_error}"
            ) from rollback_error
    else:
        try:
            write_source_update_state("CAS_FAILED_NO_SOURCE_MUTATION")
        except BaseException:
            pass
    restore_signal_handlers(update_handlers)
    raise
else:
    # Source state is now final.  Ignore managed termination signals until this
    # short-lived child has emitted every conclusive marker and exited.
    ignore_managed_signals()

print(f"D97AF_HELPERS_POST_SHA256={helpers_post_sha}")
print(f"D97AF_SYSPATCH_POST_SHA256={syspatch_post_sha}")
print(f"D97AF_METAL_3802_UNCHANGED_SHA256={sha256_bytes(metal.read_bytes())}")
print(f"D97AD_METHOD_SOURCE_SHA256_UNCHANGED={expected_d97ad_method_sha}")
print(f"D97AF_METHOD_SOURCE_SHA256={new_method_sha}")
print("D97AF_ACTIVE_CALL_ORDER=" + "->".join(ordered_names))
print("D97AF_PYTHON_COMPILE_AND_AST=PASS")
print("D97AF_EXACT_TWO_SOURCE_FILE_INTEGRATION=PASS")
print("D97AF_LC_UUID_BUILD_STAMP_SOURCE_STATE=READY")
print("D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED")
print("D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED")
print(f"SOURCE_BACKUP={backup}")
PY
PY_RC=$?
set -e

if [[ "$PY_RC" -ne 0 ]]; then
  fail "PYTHON_INTEGRATOR_RC_$PY_RC"
fi

echo "===== FINAL ====="
echo "D97AF_LOCAL_SOURCE_INTEGRATION_CORE=PASS|REPORT_CAPTURE=PENDING"
echo "D97AF_LC_UUID=$D97AF_UUID"
echo "D97AF_TARGET_EXPECTED_POST_SHA256=$EXPECTED_TARGET_POST_SHA"
echo "D97AF_SOURCE_BACKUP=$BACKUP"
echo "SOURCE_MUTATION=YES_EXACT_TWO_FILES"
echo "INSTALLED_APP_MUTATION=NO"
echo "SYSTEM_TARGET_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "USER_ACTION_NOW=STOP"
echo "REPORT=$REPORT"

set +e
stop_capture
CAPTURE_RC=$?
set -e
if [[ "$CAPTURE_RC" -ne 0 ]]; then
  FINAL_FAILURE="D97AF_LOCAL_SOURCE_INTEGRATION=FAIL_CLOSED|REASON=REPORT_CAPTURE_RC_$CAPTURE_RC"
  printf '%s\n' "$FINAL_FAILURE" >&2
  if [[ "${REPORT_FD_OPEN:-0}" == "1" ]]; then
    printf '%s\n' "$FINAL_FAILURE" >&7 || true
  fi
  source_mutation_status >&2
  exit 2
fi

if ! {
  print -r -- "D97AF_REPORT_CAPTURE=PASS" >&7 &&
  print -r -- "D97AF_LOCAL_SOURCE_INTEGRATION=PASS" >&7
}; then
  echo "D97AF_LOCAL_SOURCE_INTEGRATION=FAIL_CLOSED|REASON=FINAL_REPORT_FD_WRITE_FAILED" >&2
  exit 2
fi
print -r -- "D97AF_REPORT_CAPTURE=PASS"
print -r -- "D97AF_LOCAL_SOURCE_INTEGRATION=PASS"
exec 7>&-
REPORT_FD_OPEN=0
