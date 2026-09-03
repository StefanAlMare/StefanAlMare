# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-03 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_LOCAL_SOURCE_PASS_GITHUB_BUILD_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is an index/frontier summary. Exact historical detail remains preserved in the incremental checkpoints and repository history.

## Permanent protocol
Current default is short, visible, explained ASUS2 collaboration, one bounded action and STOP gate at a time. Routine/small tests, ordinary validations, source inspection, small edits, probes, diff checks, packaged-runtime tests, artifact/reassembly checks and live-state evidence stay on ASUS2. GitHub is used only for major/substantial compile/build/package workloads. No automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34. True-five SHA256 `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained, runtime sufficiency NEGATIVE.

## Durable milestone index
D22 AIR semantics PROVEN. D69/D70 WindowServer downstream. D71R compiler lifecycle observable. D83 upstream llvm::Module*. D93 RMP contract. D95/D95D wrapped LLVM bitcode structural-semantic proof. D96C/D97JB stable late boundary/static CFG.

D97AA proved runtime 32023 selection in an earlier cohort. D97AC mapped finite validator outcomes. D97AD produced exact final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; private build/deploy/manual Root Patch passed. Selected accelerated boot `2026-09-02 00:10`, VESA `00:12` excluded.

D97AEQ: 28/28 normal exit(1), no signals, classifier experiment invalid. D97AER: visible late simulator xrefs after candidate terminal. D97AES: 33 diagnostics across 28/28 PIDs from 32023/D5CE, 3802 NEGATIVE for the cohort. D97AET: archived PCs do not directly prove traversal beyond terminal.

D97AEU/D97AEW established the D226 x86_64h cache image topology but not semantic cross-image site mapping: physical reads valid, cross-image correlation not established, cache discriminator inconclusive. D97AES directly proves D5CE as immediate sender for its diagnostic cohort; exact runtime D97AD text remains UNKNOWN.

D97AEZ natural PID watcher reached exact-path service PID but task-port read was denied (`errno=1`) before byte capture; external task-port method retired.

## D97AF
Frozen LC_UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`; exact D97AD preimage `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; deterministic UUID-only postimage `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

D97AF source/build/deploy passed, but Root Patch failed because packaged Python lacked `os.listxattr`. The custom step failed before target mutation, while old exception handling allowed later patchset/AuxKC/snapshot work. Classified `D97AF_ROOT_PATCH=INVALID_PARTIAL`.

## D97AG
D97AG replaced unavailable packaged `os.listxattr/getxattr` with fail-closed `/usr/bin/xattr` enumeration/value reads and changed the shared Metal-chain exception handler to unmount + bare re-raise before later patchset/AuxKC/snapshot continuation.

Major Intel build: private branch `oclp7-d97ag-github-build`, head `4bde01b09717d076499ebf3640b5e4c0378798dd`, workflow/run/job `348876070 / 33696449978 / 100466229401`, success. Exact app ZIP SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`, executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

ASUS2 artifact/reassembly and exact frozen-runtime audit passed. Exact D97AG was deployed live to `/Applications/OpenCore-Patcher.app`; D97AF backup retained at `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

Manual D97AG Root Patch proved the corrected xattr backend in the real patch path: flags `524288`, xattrs `[]`, ACL NONE, exact D97AD preimage. It then failed closed at a new tooling defect: hard-coded `/bin/chflags`. The D97AG fatal boundary worked; no post-exception AuxKC/snapshot completion and no misleading `Patching complete`. Reboot remained unauthorized.

## chflags path proof
ASUS2 read-only probe proved `/bin/chflags` absent and `/usr/bin/chflags` valid/executable universal x86_64+arm64e; shell resolution points only to `/usr/bin/chflags`. Other absolute transaction tools are valid at their existing locations.

## D97AH local source correction PASS
First D97AH attempt used substring counting and falsely counted `/bin/chflags` inside an existing `/usr/bin/chflags`; it stopped before mutation. Classification `TOOLING_FALSE_FAILURE_SUBSTRING_OVERLAP_NO_MUTATION`.

Corrected AST/token-exact D97AH action pinned exact D97AG preimages and selected exactly the two `/bin/chflags` string tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`. It changed only those two tokens to `/usr/bin/chflags`, preserving inode/metadata and compiling cleanly.

Exact D97AH local identities:

```text
HELPERS_POST_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
D97AH_METHOD_POST_SHA256=fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a
D97AH_PATCH_SHA256=66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c
D97AH_PATCH_BYTES=1005
SYSPATCH_POST_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_POST_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
```

Backup `/Users/alex/Desktop/OCLP7_D97AH_SOURCE_BACKUP_20260903-172844-10591`; patch `/Users/alex/Desktop/OCLP7_D97AH_CHFLAGS_SOURCE_CORRECTION_20260903-172844-10591.patch`; report `/Users/alex/Desktop/OCLP7_D97AH_LOCAL_SOURCE_CORRECTION_REPORT_20260903-172844-10591.txt`.

Mutation: source exactly one file (`sys_patch_helpers.py`); no installed-app/system-target/Golden/Root Patch/reboot mutation.

## CURRENT ACTION
ASUS2 STOP. Do not Root Patch and do not reboot.

Next action is a major Intel GitHub build/package derived from exact D97AG build lineage plus exact D97AH one-file/two-token patch. It must prove the D97AG preimage, apply only D97AH, verify helpers SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`, preserve sys_patch/metal identities, prove method literal cardinality old=0/new=2, build and audit the x86_64 packaged app, and export split delivery artifacts plus reports.

After that major build, work returns to ASUS2 for exact artifact/reassembly and packaged-runtime validation before deployment. Root Patch/reboot remain unauthorized.