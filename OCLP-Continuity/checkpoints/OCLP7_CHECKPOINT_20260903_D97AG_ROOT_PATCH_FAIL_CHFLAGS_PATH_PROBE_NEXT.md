# OCLP7 CHECKPOINT — D97AG ROOT PATCH FAILS CLOSED AT CHFLAGS PATH; ASUS2 PATH PROBE NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_LIVE_APP_DEPLOY_PASS_ROOT_PATCH_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/small tests and probes stay on ASUS2; GitHub is reserved for major compile/build/package workloads. Never auto Root Patch or reboot.

## Exact returned D97AG Root Patch log
Returned log identity from the uploaded text file:

```text
SHA256=d44389530c34274c4a2552d5256f4f8e531bb64263c27b62cc9ef3b8d3f4c66a
BYTES=26582
PHYSICAL_NEWLINES=716
```

Root Patch began normally, found exact local metallib `26.6.2-25G82`, mounted the root volume elevated, passed root-patching capability/preflight, and installed the expected patchsets through Metal 3802, Haswell and Modern Wireless.

The retained functional chain completed in the expected order:

```text
P1 selector bridge=PASS
P2b request-layout bridge=PASS
P3 serialized-bitcode path=PASS
AIR00=PASS
D34=PASS
TRUE_FIVE_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6=PASS
P7=PASS
D97AD=PASS
D97AD_COMMITTED_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
```

## D97AG packaged xattr correction is reached and no longer fails at os.listxattr
The D97AF/D97AG build-stamp method progressed beyond the exact point that failed under D97AF. It successfully emitted:

```text
D97AF_TARGET_METADATA_POLICY=MODE_OWNER_FLAGS_XATTRS_PRESERVE_EXACT|ACL_NONE_REQUIRED|TIMES_ALLOWED_TO_CHANGE
D97AF_TARGET_FLAGS_PRE=524288
D97AF_TARGET_XATTRS_PRE=[]
D97AF_TARGET_ACL_PRE=NONE
D97AF_LC_UUID_BUILD_STAMP_PRE_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
```

Therefore the D97AG external `/usr/bin/xattr` backend is operational in the real Root Patch path; the former packaged-Python `AttributeError: module 'os' has no attribute 'listxattr'` is not reproduced.

## New failure — hard-coded `/bin/chflags`
Immediately after the exact metadata/preimage gate, Root Patch failed with:

```text
- Failed to patch GPU compiler libraries: File not found: /bin/chflags
FileNotFoundError: File not found: /bin/chflags
```

The stack identifies `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp` through `subprocess_wrapper.run_as_root_and_verify`.

Authoritative D97AF source ordering proves the first hard-coded `['/bin/chflags', '0', staged_target]` invocation occurs only after an exclusively reserved same-directory staged sibling is created and metadata is copied to it, but before `/bin/dd` writes the transformed postimage into that staged inode. The later second `/bin/chflags` restore and the final same-filesystem `/bin/mv -f staged_target target` atomic commit are still downstream.

Thus:

```text
D97AG_XATTR_BACKEND_REAL_ROOT_PATCH=PROVEN_REACHED_AND_WORKING
D97AF_TARGET_PRE_SHA=PROVEN_EXACT
D97AF_STAGED_SIBLING_METADATA_COPY=REACHED_OR_IMMEDIATELY_PRECEDING_FAILURE
D97AF_STAGED_POSTIMAGE_DD=NOT_REACHED
D97AF_ATOMIC_TARGET_RENAME=NOT_REACHED
D97AF_LC_UUID_BUILD_STAMP_COMMIT=NOT_REACHED
ORIGINAL_TARGET_BYTE_REPLACEMENT_BY_D97AF_METHOD=NOT_REACHED
```

The helper has cleanup logic for its private temp and owned staged sibling, but this checkpoint does not claim independent filesystem proof of cleanup; the root volume was subsequently unmounted.

## D97AG fatal-boundary correction works
Unlike the invalid D97AF run, the exception did not fall through into later patchset write/AuxKC/snapshot continuation. The returned log shows:

```text
- Unmounting root volume
We have a problem to execute patches and rebuild the Kernel Cache.
```

There is no later `Patching complete`, no returned AuxKC rebuild completion and no APFS snapshot creation after the exception. This is the intended D97AG bare re-raise/fatal boundary.

Classification:

```text
D97AG_ROOT_PATCH=FAIL_CLOSED_NEW_TOOL_PATH_DEFECT
D97AG_FATAL_BOUNDARY=PROVEN_WORKING
D97AG_NEW_SNAPSHOT_COMMIT=NOT_REACHED
REBOOT=NOT_AUTHORIZED
```

The live application remains the exact D97AG executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`; retained D97AF backup remains `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## Static path hypothesis
The current D97AF/D97AG source contains two hard-coded `/bin/chflags` calls inside the transactional build-stamp method: one to clear flags on the staged sibling before data-fork write and one to restore the original numeric flags after the staged write. Public macOS references place `chflags` at `/usr/bin/chflags`; this is only a hypothesis until ASUS2 proves the exact Tahoe installation path and executable identity locally.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not Root Patch again and do not reboot.

Run one bounded, read-only ASUS2 path/capability probe. It must:
1. report existence, regular-file/symlink status, executable bit, architecture/file identity for `/bin/chflags` and `/usr/bin/chflags`;
2. report `command -v chflags` and all shell-resolved chflags candidates;
3. verify the other absolute tools used in the D97AF/D97AG transaction (`/bin/sh`, `/bin/cp`, `/bin/dd`, `/bin/mv`, `/bin/ls`, `/usr/bin/stat`, `/usr/bin/xattr`) so this path class is audited as a set rather than one command at a time;
4. make no source, app, system-target, Golden, Root Patch, snapshot or reboot mutation;
5. STOP and return complete output.

Only after that ASUS2 probe is accepted may the exact source correction be defined. If `/usr/bin/chflags` is proven and all other tools pass, the expected correction is limited to the two `/bin/chflags` literals; routine source edit/validation remains ASUS2-local, while any subsequent substantial packaged-app rebuild remains GitHub-only.