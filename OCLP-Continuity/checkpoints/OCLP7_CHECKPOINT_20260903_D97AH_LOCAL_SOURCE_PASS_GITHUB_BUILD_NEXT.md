# OCLP7 CHECKPOINT — D97AH LOCAL SOURCE PASS; MAJOR GITHUB BUILD NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_ROOT_PATCH_FAIL_CHFLAGS_PATH_PROBE_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/small tests, probes, source edits and local validation stay on ASUS2. GitHub is reserved only for major/substantial compilation, build and packaging. Never auto Root Patch or reboot.

## D97AG Root Patch failure carried forward
D97AG proved its packaged xattr correction in the real Root Patch path: target flags `524288`, xattrs `[]`, ACL `NONE`, and exact D97AD preimage SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` were read successfully. The former packaged-Python `os.listxattr` defect is therefore closed.

The D97AG Root Patch then failed closed because the D97AF/D97AG transaction hard-coded `/bin/chflags`, which is absent on this Tahoe installation. The exception propagated through the D97AG fatal boundary, root volume was unmounted, and no later AuxKC/snapshot completion or generic `Patching complete` occurred. D97AF staged postimage `dd`, target atomic rename, LC_UUID stamp commit and new snapshot commit were NOT REACHED. Reboot remains unauthorized.

## ASUS2 tool-path proof
Read-only ASUS2 probe proved:

```text
/bin/chflags=ABSENT
/usr/bin/chflags=EXISTS_REGULAR_EXECUTABLE
/usr/bin/chflags_ARCHS=x86_64 arm64e
command/whence/type/which chflags=/usr/bin/chflags
```

The other absolute transaction tools are valid at their existing paths: `/bin/sh`, `/bin/cp`, `/bin/dd`, `/bin/mv`, `/bin/ls`, `/usr/bin/stat`, `/usr/bin/xattr`.

The transaction contains exactly two genuine `/bin/chflags` string literals inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`: clear staged-sibling flags before the data-fork overwrite, then restore original flags afterward.

## First D97AH local correction attempt — tooling false failure / no mutation
The first local D97AH wrapper incorrectly used substring counting. Because `"/bin/chflags"` is a substring of `"/usr/bin/chflags"`, it reported raw counts `3` and `1` and stopped at `OLD_CHFLAGS_GLOBAL_CARDINALITY` before backup creation or source write.

Authoritative classification:

```text
D97AH_FIRST_LOCAL_ATTEMPT=TOOLING_FALSE_FAILURE_SUBSTRING_OVERLAP
SOURCE_MUTATION=NO
HELPERS_PREIMAGE_REMAINED=ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

## D97AH AST/token-exact local source correction PASS
The corrected local action pinned branch/head and all three D97AG source preimages, selected only exact AST string constants and exact STRING tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`, and changed exactly those two tokens from `/bin/chflags` to `/usr/bin/chflags`.

Preconditions and selection:

```text
SOURCE_BRANCH=alex-tahoe-25G82-custom
SOURCE_HEAD=4143b7077a9a4e5aa41ec7a06c0888597eda9b06
HELPERS_PRE_SHA256=ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2
SYSPATCH_PRE_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_PRE_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AH_METHOD_DEFINITION_COUNT=1
D97AH_METHOD_EXACT_BIN_CHFLAGS_PRE_COUNT=2
D97AH_METHOD_EXACT_USR_BIN_CHFLAGS_PRE_COUNT=0
D97AH_SELECTED_STRING_TOKEN_COUNT=2
```

Postconditions:

```text
D97AH_METHOD_EXACT_BIN_CHFLAGS_POST_COUNT=0
D97AH_METHOD_EXACT_USR_BIN_CHFLAGS_POST_COUNT=2
D97AH_DIFF_REMOVED_LINE_COUNT=2
D97AH_DIFF_ADDED_LINE_COUNT=2
D97AH_TRANSFORM_EXACT_TWO_METHOD_TOKENS=PASS
D97AH_AST_AND_COMPILE=PASS
D97AH_SOURCE_INODE_METADATA_PRESERVED=PASS
D97AH_FINAL_SOURCE_LITERAL_IDENTITY=PASS
D97AH_LOCAL_SOURCE_CORRECTION=PASS
```

Exact D97AH identities:

```text
HELPERS_POST_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
D97AH_METHOD_POST_SHA256=fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a
D97AH_PATCH_SHA256=66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c
D97AH_PATCH_BYTES=1005
SYSPATCH_POST_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_POST_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
BACKUP_HELPERS_SHA256=ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2
```

Local evidence paths:

```text
BACKUP=/Users/alex/Desktop/OCLP7_D97AH_SOURCE_BACKUP_20260903-172844-10591
PATCH=/Users/alex/Desktop/OCLP7_D97AH_CHFLAGS_SOURCE_CORRECTION_20260903-172844-10591.patch
REPORT=/Users/alex/Desktop/OCLP7_D97AH_LOCAL_SOURCE_CORRECTION_REPORT_20260903-172844-10591.txt
```

Mutation ledger:

```text
SOURCE_MUTATION=YES_EXACT_ONE_FILE_SYS_PATCH_HELPERS
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

The live installed application remains exact D97AG executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`; it is NOT authorized for another Root Patch. The retained D97AF backup remains `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not Root Patch and do not reboot.

D97AH local source work is complete. The next action is one **major Intel GitHub build/package** derived from the exact audited D97AG build lineage plus the exact one-file/two-token D97AH transition above. GitHub may perform the compilation/build/package and build-integrity audits required for that major workload; it must not replace subsequent ASUS2 artifact/reassembly/runtime/live-state validation.

The major build must prove the reconstructed D97AG preimage, apply exactly the D97AH patch, end at helpers SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`, preserve sys_patch and metal identities, prove exact method literal cardinality `0 /bin/chflags` and `2 /usr/bin/chflags`, build the x86_64 packaged application, audit the packaged source/code identity, and export split delivery artifacts plus reports for later ASUS2 verification.

After the build succeeds, return to ASUS2 for exact artifact/reassembly and packaged-runtime audit before any application deployment. Root Patch and reboot remain separately unauthorized.