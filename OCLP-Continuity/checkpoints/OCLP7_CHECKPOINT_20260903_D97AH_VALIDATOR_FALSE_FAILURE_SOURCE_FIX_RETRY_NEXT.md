# OCLP7 CHECKPOINT — D97AH VALIDATOR FALSE FAILURE; SOURCE FIX RETRY NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_ROOT_PATCH_FAIL_CHFLAGS_PATH_PROBE_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/small tests and source edits stay on ASUS2; GitHub is reserved for major compile/build/package workloads. Never auto Root Patch or reboot.

## D97AG Root Patch / chflags path facts carried forward
D97AG Root Patch reached the corrected xattr backend in the real frozen app, read target flags/xattrs/ACL and exact D97AD pre-SHA, then failed closed on hard-coded `/bin/chflags`. Fatal propagation/unmount worked and no later snapshot commit was reached. ASUS2 path probe proved `/bin/chflags` absent and `/usr/bin/chflags` present/executable with x86_64 support; all other absolute tools used by the transaction are valid at their current paths.

The D97AF/D97AG transaction itself has two intended `/bin/chflags` literals: clear flags on the owned staged sibling before data-fork overwrite, then restore original flags after the overwrite. D97AH is limited to replacing those exact two method-local string literals with `/usr/bin/chflags`.

## First D97AH local source correction attempt — tooling false failure, no mutation
Returned ASUS2 output proved source preimages remained exact:

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

This is a validator defect, not source drift. Python `str.count('/bin/chflags')` also counts the `/bin/chflags` suffix inside the separate string `/usr/bin/chflags`. Therefore global substring counts `3` and `1` are compatible with exactly two true `/bin/chflags` literals plus one unrelated `/usr/bin/chflags` literal elsewhere in the file.

The wrapper failed before backup-directory creation and before any source write. Classification:

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

Retry one bounded D97AH local source correction using AST/string-token identity rather than overlapping substring counts. Gates must prove:
1. same branch/HEAD and exact three source preimage SHA256 values above;
2. exactly one definition of `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`;
3. inside that exact function AST, exactly two string constants equal to `/bin/chflags` and zero string constants equal to `/usr/bin/chflags`;
4. source-wide replacement is forbidden; only the two exact method-local literals may be changed;
5. resulting function has zero `/bin/chflags` constants and exactly two `/usr/bin/chflags` constants;
6. unified diff contains exactly two removed and two added lines and no other semantic/source changes;
7. preserve source inode/metadata, create recoverable backup and patch artifact, compile/AST-validate, and prove `sys_patch.py` and `metal_3802.py` remain unchanged.

No local major compilation, no `/Applications` mutation, no Root Patch and no reboot. After D97AH local source PASS, persist exact new SHA identities and only then authorize a new major GitHub build/package.