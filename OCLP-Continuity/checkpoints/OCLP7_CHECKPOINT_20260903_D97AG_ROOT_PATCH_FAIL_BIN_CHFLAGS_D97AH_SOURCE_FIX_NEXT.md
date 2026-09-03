# OCLP7 CHECKPOINT — D97AG ROOT PATCH FAIL-CLOSED AT `/bin/chflags`; D97AH LOCAL SOURCE FIX NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_LIVE_APP_DEPLOY_PASS_ROOT_PATCH_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia is immutable/read-only. D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Never auto Root Patch or reboot.

Routine tests, source inspection, small edits and validation remain ASUS2-only. GitHub is reserved only for major compilation/build/package workloads.

## D97AG live app state carried forward
Live `/Applications/OpenCore-Patcher.app` remains exact D97AG x86_64 executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`. Exact D97AF backup remains `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## Manual D97AG Root Patch result
The returned Root Patch log reaches and verifies the complete retained chain through D97AD:

```text
MTLCompilerService selector patch PASS
P2b request-layout bridge PASS
P3 serialized-bitcode path PASS
AIR00 PASS
D34 PASS
TRUE_FIVE_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6 PASS
P7 PASS
D97AD_COMMITTED_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
D97AD_PRE_D97_VALIDATOR_WHOLE_STAGE_EXIT_CLASSIFIER=PASS
```

D97AG also proves the packaged xattr correction works in the real Root Patch path. It successfully reaches target metadata inspection and reports:

```text
D97AF_TARGET_FLAGS_PRE=524288
D97AF_TARGET_XATTRS_PRE=[]
D97AF_TARGET_ACL_PRE=NONE
D97AF_LC_UUID_BUILD_STAMP_PRE_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
```

The former D97AF packaged-runtime `AttributeError: os.listxattr` does not recur.

The new failure is:

```text
FileNotFoundError: File not found: /bin/chflags
```

inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`.

Exact method ordering proves the failure occurs while operating on the exclusively reserved same-directory staged sibling, after metadata copy but before the `/bin/dd` data-fork overwrite and before the same-filesystem `/bin/mv` atomic commit over the real MTLCompiler target. Therefore:

```text
D97AG_ROOT_PATCH=FAIL_CLOSED
D97AG_XATTR_BACKEND_REAL_ROOT_PATCH=PROVEN_PASS
D97AF_LC_UUID_BUILD_STAMP=NOT_COMMITTED
D97AF_TARGET_ATOMIC_RENAME=NOT_REACHED
D97AG_FATAL_BOUNDARY=PROVEN_PASS
```

After the exception OCLP immediately unmounted the root volume and terminated the patch flow with `We have a problem to execute patches and rebuild the Kernel Cache.` It did not continue through the previous invalid-partial AuxKC/snapshot path and did not print generic `Patching complete`. Reboot remains unauthorized.

## ASUS2 absolute-tool probe
A bounded read-only ASUS2 probe proves:

```text
/bin/chflags=ABSENT
/usr/bin/chflags=EXISTS_REGULAR_EXECUTABLE
/usr/bin/chflags_ARCHS=x86_64 arm64e
COMMAND_V_CHFLAGS=/usr/bin/chflags
```

`/bin/sh`, `/bin/cp`, `/bin/dd`, `/bin/mv`, `/bin/ls`, `/usr/bin/stat` and `/usr/bin/xattr` are all present and executable at the paths currently used by the method.

The exact D97AF/D97AG method source contains two absolute `/bin/chflags` calls: one to clear flags on the staged sibling before data overwrite and one to restore original flags afterward. Both must use `/usr/bin/chflags` on Tahoe.

## Mutation ledger
```text
ROOT_PATCH_ATTEMPT=YES_MANUAL_FAIL_CLOSED
SYSTEM_TARGET_PREPARATION=YES_ROOT_VOLUME_PATCHSET_WORK_BEFORE_CUSTOM_FAILURE
D97AF_LC_UUID_TARGET_COMMIT=NO
ATOMIC_TARGET_RENAME=NO
AUXKC_REBUILD_AFTER_CUSTOM_FAILURE=NO
SNAPSHOT_CREATION_AFTER_CUSTOM_FAILURE=NO
REBOOT=NO
GOLDEN_MUTATION=NO
SOURCE_MUTATION_FROM_TOOL_PROBE=NO
INSTALLED_APP_MUTATION_FROM_TOOL_PROBE=NO
```

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not reboot and do not run Root Patch again.

Next bounded action is **D97AH local source correction** only. It must fail closed unless the local source is still branch `alex-tahoe-25G82-custom`, HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`, helpers preimage SHA256 `ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2`, sys_patch SHA256 `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`, metal_3802 SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, and the D97AF/D97AG method contains exactly two `/bin/chflags` literals and no unexpected tool-path drift.

If those gates pass, replace exactly those two literals with `/usr/bin/chflags`, create a local recoverable source backup and exact patch artifact, compile/AST-validate the modified Python, verify only `sys_patch_helpers.py` changes in this D97AH correction, and STOP. No local major compilation, no `/Applications` mutation, no Root Patch and no reboot.

Only after returned ASUS2 D97AH source-correction evidence is accepted may a new major GitHub build/package be launched.