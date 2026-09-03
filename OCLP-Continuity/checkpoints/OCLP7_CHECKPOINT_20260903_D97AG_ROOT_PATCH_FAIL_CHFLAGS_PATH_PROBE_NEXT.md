# OCLP7 CHECKPOINT — D97AG ROOT PATCH FAILS CLOSED AT CHFLAGS PATH; D97AH SOURCE FIX RETRY NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_LIVE_APP_DEPLOY_PASS_ROOT_PATCH_NEXT.md`.
Detailed D97AH validator-failure record: `OCLP7_CHECKPOINT_20260903_D97AH_VALIDATOR_FALSE_FAILURE_SOURCE_FIX_RETRY_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/small tests and source edits stay on ASUS2; GitHub is reserved for major compile/build/package workloads. Never auto Root Patch or reboot.

## D97AG Root Patch result
The real D97AG Root Patch reached and successfully used the corrected packaged xattr backend. It emitted exact target metadata (`flags=524288`, `xattrs=[]`, `ACL=NONE`) and exact D97AD target pre-SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Thus the former packaged `os.listxattr` defect is closed in the real Root Patch path.

Root Patch then failed closed at `FileNotFoundError: File not found: /bin/chflags`. Exact source ordering proves the first chflags call occurs on the owned staged sibling before `/bin/dd` writes the D97AF postimage and before the final same-filesystem `/bin/mv` atomic target commit. Therefore the D97AF LC_UUID postimage was not committed to the original MTLCompiler target.

D97AG fatal propagation worked: the root volume was unmounted and no later AuxKC/snapshot completion or generic `Patching complete` followed. Classification remains:

```text
D97AG_XATTR_BACKEND_REAL_ROOT_PATCH=PROVEN_REACHED_AND_WORKING
D97AF_STAGED_POSTIMAGE_DD=NOT_REACHED
D97AF_ATOMIC_TARGET_RENAME=NOT_REACHED
D97AF_LC_UUID_BUILD_STAMP_COMMIT=NOT_REACHED
D97AG_FATAL_BOUNDARY=PROVEN_WORKING
D97AG_ROOT_PATCH=FAIL_CLOSED_NEW_TOOL_PATH_DEFECT
D97AG_NEW_SNAPSHOT_COMMIT=NOT_REACHED
REBOOT=NOT_AUTHORIZED
```

Live installed application remains exact D97AG x86_64 executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`; D97AF backup remains `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## ASUS2 absolute-tool path probe PASS
The bounded read-only probe proved:

```text
/bin/chflags=ABSENT
/usr/bin/chflags=EXISTS_REGULAR_EXECUTABLE
/usr/bin/chflags_ARCHS=x86_64 arm64e
command -v chflags=/usr/bin/chflags
```

All other absolute tools used by the transaction are valid at their existing paths: `/bin/sh`, `/bin/cp`, `/bin/dd`, `/bin/mv`, `/bin/ls`, `/usr/bin/stat`, `/usr/bin/xattr`. No other tool-path change is authorized.

## First D97AH source-fix attempt — TOOLING FALSE FAILURE, NO MUTATION
ASUS2 returned exact source preimages:

```text
SOURCE_BRANCH=alex-tahoe-25G82-custom
SOURCE_HEAD=4143b7077a9a4e5aa41ec7a06c0888597eda9b06
HELPERS_PRE_SHA256=ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2
SYSPATCH_PRE_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_PRE_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AH_GLOBAL_BIN_CHFLAGS_PRE_COUNT=3
D97AH_GLOBAL_USR_BIN_CHFLAGS_PRE_COUNT=1
D97AH_LOCAL_SOURCE_CORRECTION=FAIL_CLOSED|REASON=OLD_CHFLAGS_GLOBAL_CARDINALITY
```

This fail is caused by an overlapping-substring validator bug: Python `str.count('/bin/chflags')` also counts the `/bin/chflags` suffix inside an existing `/usr/bin/chflags` string elsewhere in the file. Therefore `3` plus `1` is compatible with exactly two true `/bin/chflags` literals plus one unrelated `/usr/bin/chflags` literal. The attempt stopped before backup creation and before any source write.

Classification:

```text
D97AH_FIRST_SOURCE_FIX_ATTEMPT=TOOLING_FALSE_FAILURE_SUBSTRING_OVERLAP
SOURCE_MUTATION=NO
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

The trailing shell-session-save warning is unrelated to OCLP/source state.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not Root Patch and do not reboot.

Retry one bounded D97AH local source correction using AST-exact string constants and source-position edits, never overlapping substring counts and never source-wide replacement. Required gates:
1. same branch/HEAD and exact three preimage SHA256 values above;
2. exactly one `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp` function;
3. within that function AST, exactly two string constants equal to `/bin/chflags` and zero equal to `/usr/bin/chflags`;
4. mutate exactly those two source spans to `/usr/bin/chflags`;
5. post-function AST has zero `/bin/chflags` constants and exactly two `/usr/bin/chflags` constants;
6. unified diff contains exactly two removed and two added lines and no other code change;
7. preserve source inode/metadata, create recoverable backup and patch artifact, compile/AST-validate, and prove `sys_patch.py` plus `metal_3802.py` unchanged.

No local major compilation, no `/Applications` mutation, no Root Patch and no reboot. After D97AH source PASS, persist exact new hashes and only then authorize the next major GitHub build/package.