# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260903_D97AH_LOCAL_SOURCE_PASS_GITHUB_BUILD_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-03 EEST

## Mandatory startup
Before any technical change read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

The detailed historical checkpoints remain authoritative for their completed phases; this MASTER is the current-state/frontier summary and must not be used to reinterpret older evidence.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4600/4400 family, SMBIOS `MacBookAir6,2`. Local source branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.

Golden root-patched MTLCompiler SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` is immutable/read-only. Accepted true-five SHA256 is `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

Protocol defaults to short, visible, explained ASUS2 collaboration with one bounded action and STOP gate at a time. Routine/small tests, source inspection, ordinary validations, small edits, probes, diff checks, packaged-runtime checks, artifact/reassembly verification, live application checks, hardware evidence, accelerated boots and VESA evidence stay on ASUS2 under user control. GitHub is reserved only for major/substantial compile/build/package workloads. Major GitHub builds remain assistant-run and fully audited; their outputs return to ASUS2 through audited artifact-delivery mechanisms. Local major compilation is not an implicit fallback and requires explicit user authorization. Never auto Root Patch or reboot.

D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized. D97AEX/D97AEZ retired. Golden immutable/read-only.

Interaction chain: `short ASUS2 action -> user result -> assistant audit -> next bounded action`; only a major compile/build inserts `assistant GitHub compile/build/package -> artifact delivery -> ASUS2 audit/test/deploy` before the normal manual Root Patch / accelerated boot / VESA sequence.

Architecture remains: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.

## Accepted functional lineage
Exactly P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR 2.6 / Metal 3.1 -> D34 semantic-equivalent reset. P6/P7 retained with runtime sufficiency NEGATIVE. D22 is semantic proof for AIR 2.6 / Metal 3.1.

Evidence labels remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/STATIC-PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN. Control-flow must never be silently promoted to semantic proof.

## Durable D97 lineage
D97AA proved runtime 32023 selection for an earlier cohort. D97AC mapped finite validator outcomes. D97AD produced selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

D97AD private build/deploy/manual Root Patch passed. Selected accelerated boot `2026-09-02 00:10`; VESA recovery `00:12` excluded. D97AEQ: 28/28 service PIDs normal `exit(1)`, zero signals, whole-stage classifier invalid. D97AER: visible late simulator-limit xrefs lie after candidate terminal REL+0x58B. D97AES: all 33 diagnostics across 28/28 PIDs came from `Versions/32023/MTLCompiler`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 NEGATIVE for that cohort. D97AET archived PCs did not prove traversal beyond the validator terminal.

Cache work established one logical cached 32023 image UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, executable bytes in x86_64h subcache `.05`. Physical cache reads are VALID, but D5CE filesystem offsets cannot be mapped semantically into D226 without same-input identity: `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE`. D97AES directly proves D5CE as the immediate diagnostic sender for its cohort; exact current D97AD runtime text remains UNKNOWN.

D97AEZ caught natural exact-path MTLCompilerService PID `434` but `task_read_for_pid=-1 errno=1` before any runtime byte window; external task-port observation is retired and exact runtime text remains UNKNOWN. No LLDB/SIP/AMFI bypass is authorized.

## D97AF frozen LC_UUID contract
Frozen UUID is `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Exact D97AD preimage SHA256 is `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; changing only the 16-byte LC_UUID payload at `0xAB0..0xABF` yields expected SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`. This stamp is provenance evidence for covered diagnostic-sender cohorts, not a direct runtime text read.

## D97AF / D97AG correction lineage
D97AF local source integration/build/deploy succeeded, but manual Root Patch was invalid because packaged Python lacked `os.listxattr`. The D97AF method failed before target mutation, while the old exception boundary incorrectly allowed later patchset/AuxKC/snapshot continuation. That run is `D97AF_ROOT_PATCH=INVALID_PARTIAL`; generic `Patching complete` was not accepted.

D97AG corrected both defects: `_xattrs` uses fail-closed `/usr/bin/xattr -s` and `/usr/bin/xattr -s -p -x`, and the Metal-chain exception boundary best-effort unmounts then bare re-raises before later patchset/AuxKC/snapshot continuation.

Correct D97AG private major build provenance: repo `StefanAlMare/Private-Work`, branch `oclp7-d97ag-github-build`, head `4bde01b09717d076499ebf3640b5e4c0378798dd`, workflow/run/job `348876070 / 33696449978 / 100466229401`, Intel x86_64, success.

Exact D97AG app ZIP: `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`. Packaged executable: `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64.

ASUS2 exact artifact/reassembly audit and exact frozen-runtime xattr auditor passed. The frozen process still reported `OS_LISTXATTR_AVAILABLE=NO`, but the D97AG external xattr code object passed empty/text/binary values and exact code-object runtime validation. `D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT=PASS`.

Exact D97AG is currently live at `/Applications/OpenCore-Patcher.app`, executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, `6596544` bytes, x86_64. D97AF backup is `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## D97AG real Root Patch result
Manual D97AG Root Patch passed P1/P2b/P3/AIR00/D34/P6/P7/D97AD and reached the D97AF/D97AG build-stamp method. It successfully read target flags `524288`, xattrs `[]`, ACL `NONE` and exact D97AD preimage SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Therefore the D97AG xattr backend is PROVEN working in the real Root Patch path and the old `os.listxattr` defect is closed.

The run then failed with `FileNotFoundError: File not found: /bin/chflags`. Exact source ordering places that first call on the owned staged sibling after metadata copy but before `/bin/dd` writes the postimage and before atomic `/bin/mv -f staged_target target`. Thus staged postimage write, target rename and LC_UUID stamp commit were NOT REACHED.

The D97AG fatal boundary worked: root volume was unmounted and the patch operation stopped with no later AuxKC/snapshot completion and no misleading generic `Patching complete`. Classification: `D97AG_ROOT_PATCH=FAIL_CLOSED_NEW_TOOL_PATH_DEFECT`, `D97AG_FATAL_BOUNDARY=PROVEN_WORKING`, `D97AG_NEW_SNAPSHOT_COMMIT=NOT_REACHED`, `REBOOT=NOT_AUTHORIZED`.

## ASUS2 chflags probe
Read-only ASUS2 probe proves `/bin/chflags` is absent; `/usr/bin/chflags` is a regular executable universal Mach-O containing x86_64 and arm64e, and all shell resolution paths point to `/usr/bin/chflags`. Other absolute transaction tools remain valid at `/bin/sh`, `/bin/cp`, `/bin/dd`, `/bin/mv`, `/bin/ls`, `/usr/bin/stat`, `/usr/bin/xattr`.

## D97AH local source correction PASS
A first D97AH wrapper stopped before mutation because substring counting incorrectly counted `/bin/chflags` inside an existing `/usr/bin/chflags`. This is `TOOLING_FALSE_FAILURE_SUBSTRING_OVERLAP_NO_MUTATION`; helpers remained exact D97AG SHA256 `ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2`.

The corrected AST/token-exact D97AH action selected exactly two `/bin/chflags` string tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp` and replaced only them with `/usr/bin/chflags`. Method pre-counts were old=2/new=0; post-counts old=0/new=2. Diff removed exactly two lines and added exactly two lines. AST/compile and source inode/metadata preservation passed.

Exact current local D97AH identities:
- `sys_patch_helpers.py` SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`;
- D97AH method SHA256 `fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a`;
- D97AH patch SHA256 `66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c`, `1005` bytes;
- `sys_patch.py` unchanged SHA256 `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`;
- `metal_3802.py` unchanged SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`.

Local backup: `/Users/alex/Desktop/OCLP7_D97AH_SOURCE_BACKUP_20260903-172844-10591`. Patch: `/Users/alex/Desktop/OCLP7_D97AH_CHFLAGS_SOURCE_CORRECTION_20260903-172844-10591.patch`. Report: `/Users/alex/Desktop/OCLP7_D97AH_LOCAL_SOURCE_CORRECTION_REPORT_20260903-172844-10591.txt`.

Mutation: `SOURCE_MUTATION=YES_EXACT_ONE_FILE_SYS_PATCH_HELPERS`; no installed-app/system-target/Golden/Root Patch/reboot mutation.

## CURRENT ACTION — D97AH major Intel GitHub build/package
ASUS2 remains at STOP. Do not Root Patch and do not reboot.

Local D97AH source work is complete. Run one major Intel GitHub compile/build/package derived from the exact D97AG build lineage plus the exact D97AH one-file/two-token correction. The build must reconstruct the exact D97AG preimage, apply only D97AH, prove helpers SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`, preserve sys_patch/metal identities, prove method literal cardinality old=0/new=2, build the x86_64 packaged application, audit packaged/source code identity, and export split artifacts plus reports.

After GitHub build success, the next execution lane returns to ASUS2 for exact artifact/reassembly and packaged-runtime validation before deploy. Root Patch and reboot remain separately unauthorized.