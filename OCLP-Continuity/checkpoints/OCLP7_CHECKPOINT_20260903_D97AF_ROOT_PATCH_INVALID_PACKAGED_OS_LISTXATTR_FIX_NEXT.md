# OCLP7 CHECKPOINT — 2026-09-03 — D97AF Root Patch invalid / packaged `os.listxattr` correction next

## Authority and supersession
This checkpoint supersedes the execution state and next action in `OCLP7_CHECKPOINT_20260903_D97AF_OLD_ROOT_PATCH_UNPATCH_PASS_VESA_REBOOT_NEXT.md`.

All accepted D97AF source/build/artifact/deployment identities, the recoverable D97AD application backup, the exact functional lineage and every permanent safety invariant remain unchanged. This checkpoint records the first manual D97AF Root Patch attempt and its explicit failure inside the D97AF method.

## Exact evidence identity
The returned complete Root Patch log has:

```text
SHA256=b1a263a7bddadbbf46ad8c10abcbfb82043edb17a5c15a21637de6ecae0a24a1
GIT_BLOB=b22c777844a2253a8e7fafab851acd86149b9067
BYTES=26879
LOGICAL_LINES=731
FINAL_NEWLINE=NO
```

## Exact successful prefix
The log proves this custom chain before the failure:

```text
P1_SELECTOR=PASS
P2B_REQUEST_LAYOUT=PASS
P3_SERIALIZED_BITCODE=PASS
AIR00=PASS
D34=PASS
TRUE_FIVE_SHA256=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6_RETAINED=PASS
P7_RETAINED=PASS
D97AD=PASS
D97AD_COMMITTED_MTL_SHA256=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
```

P6/P7 remain retained diagnostics with runtime sufficiency NEGATIVE; their build-time PASS does not add them to the exact five-patch functional baseline.

## Decisive D97AF failure
Immediately after D97AD PASS, OCLP reported:

```text
- Failed to patch GPU compiler libraries: module 'os' has no attribute 'listxattr'
File "opencore_legacy_patcher/sys_patch/sys_patch_helpers.py", line 10367, in patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp
File "opencore_legacy_patcher/sys_patch/sys_patch_helpers.py", line 10308, in _target_metadata
File "opencore_legacy_patcher/sys_patch/sys_patch_helpers.py", line 10267, in _xattrs
AttributeError: module 'os' has no attribute 'listxattr'
```

The source sequence is decisive: D97AF first calls `_target_metadata(target)`; that calls `_xattrs(target)`; the first `_os.listxattr` call raises. This is before D97AF reads the target data, transforms the UUID in memory, creates a private temporary, reserves a destination sibling or performs the atomic rename.

```text
D97AF_PACKAGED_RUNTIME_OS_LISTXATTR=ABSENT
D97AF_METHOD_TARGET_READ=NOT_REACHED
D97AF_METHOD_TARGET_MUTATION=NOT_REACHED
D97AF_LC_UUID_BUILD_STAMP=FAILED_NOT_APPLIED
```

This exposes a validation gap: source Python and static packaged-source audits passed, but the exact PyInstaller runtime API surface used by the D97AF method was not executed before deployment.

## Partial snapshot state
OCLP caught the custom-step exception and continued with patchset information, launchd records, Auxiliary Kernel Collection handling, APFS snapshot creation and root-volume unmount. It then printed generic `Patching complete` and requested reboot.

That generic terminal line is not a D97AF PASS. The log proves snapshot creation after a partial custom sequence but does not provide a post-snapshot byte read. D97AD is the last exact committed MTLCompiler identity reported before the exception; the exact final inactive-snapshot identity is not yet independently read.

```text
D97AF_ROOT_PATCH=INVALID_PARTIAL
APFS_SNAPSHOT_AFTER_PARTIAL_PATCH=OCLP_REPORTED_CREATED
POST_SNAPSHOT_MTL_IDENTITY=NOT_YET_READ
CURRENT_D97AF_APP_ROOT_PATCH_COMPATIBILITY=NEGATIVE
REBOOT_AFTER_PARTIAL_PATCH=NOT_AUTHORIZED
```

## CURRENT SINGLE NEXT ACTION — correct packaged-runtime xattr path; remain in VESA
Do not reboot and do not rerun Root Patch from the current D97AF application.

Implement the smallest exact correction that retains the `MODE_OWNER_FLAGS_XATTRS_PRESERVE_EXACT|ACL_NONE_REQUIRED` policy without relying on unavailable `os.listxattr`/`os.getxattr` in the packaged runtime. Then follow FASTLANE exactly: source validation and transactional tests -> integration -> compile/diff -> substantial Intel build -> executable packaged-runtime test -> artifact and packaged-app audit -> exact SHA/identity -> recoverable backup/deploy -> open OCLP -> STOP.

Only after the corrected app is proven will the assistant authorize one bounded recovery/unpatch action. Root Patch and reboot remain manual and separately gated.

## Safety invariants
- Target is Intel x86_64 Haswell / MacBookAir6,2, never ARM.
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEX/D97AEZ external task-port method remains retired.
- Frozen D97AF UUID remains `A4F456DF-7447-49BF-AC4F-102D90023A1E`.
- Current D97AF app must not be used for another Root Patch.
- No automatic Root Patch or reboot is authorized.
