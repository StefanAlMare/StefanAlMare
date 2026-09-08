# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HR_CLEAN_NATIVE_VESA_PASS_D97HO_ROOTPATCH_AUTHORIZED.md`
- commit `d80304f308cd30af224984bbf27da0c494993f5f`.

Immediate decisive predecessors:
- upstream OCLP 2.5.0/Nightly review — no target update: `dcdb38756fdd09b8b6bb4362572bd70c26f62ae5`;
- D97GS Revert PASS / D97HR ready: `22fa01b19306788c75911baf0eb7fdb5c55a1de4`;
- D97HO UI Revert-only / Restore-first required: `afb6fee84e8b7eae53a30693999049667d5be17a`;
- D97HQ AuxKC valid / VESA unloaded diagnostic: `1258ce510da9e25dbbfe8035b000df582fc39e89`;
- D97HN inner audit PASS / D97HO wrapper PASS: `e75fec4b3c5921ec0a2a28760bf7c699fc96a333`;
- D97HN independent inner audit PASS: `d169d7c63c7d69b3b9f49ce8dd12d8512bf8e546`;
- D97HM portable inner build PASS: `7fa87cc64fb44b4b1d527261c8e233197090ef09`;
- D97HG exact P3-only reconstruction PASS: `3aa5c5ea432b99fd538c44eb9bfe0ab481bf71ec`;
- D97HF P1 runtime semantic progress / measured P3 frontier: `1af98134a40236290484037548dfba621df1c626`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.
Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only. Never compile on ASUS2.
Portable non-target Intel build hosts are allowed only with exact source/provenance/hash gates.

## Measured compiler state / current hypothesis
- P1 runtime semantic progress PROVEN: old `RIP=0 / r15=32023 / MTLConnectionCtx+56` absent 9/9 current crashes.
- Measured post-P1 frontier: `MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
- P2b is NOT justified as current next patch.
- P3 serialized-bitcode bridge is measured and historically causal.
- Exact P3-only MTLCompiler 32023 post-SHA: `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
- AIR00/D34 remain unauthorized.

## D97HI inner — build + independent audit CLOSED PASS
Exact source diff:
`c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

P1 AST-bounded FunctionDef preservation:
- bytes `3466 / 3466`;
- SHA256 both `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`;
- byte-identical PASS.

D97HN independently proved:
- P1 exact, P3-only, hook order P1 -> P3 -> continuation;
- P2b/AIR00/D34 = NO;
- x86_64 inner executable SHA `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- inner ZIP SHA `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`, bytes `722927108`;
- built app vs extracted ZIP manifest exact 156/156.

## D97HO wrapper — CLOSED PASS
Exact D97GS wrapper + exact audited D97HI inner.
Output:
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.app`;
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip`;
- ZIP SHA `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

Preserved exact D97GS components:
- launcher SHA `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- DEBUG helper SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- D97DX source patch SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- D97GS source patch SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`.

## Pre-revert D97HP + D97HQ evidence
D97HP proved while P1-only patch was active:
- VESA active, D97EZ inert;
- D97HO artifact exact;
- active P1 exact SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active MTLCompiler 32023 exact pre-P3 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- P2 original `418b81d0000000 @ 0x9A8CD`;
- P3 preimage `81e100002000 @ 0xA1573`;
- corrected metallibs 180/180 exact.

D97HQ resolved the loaded-only VESA ambiguity:
- Azul/HD5000 present in valid AuxKC;
- both explicitly unloaded in VESA;
- `kmutil check --collection aux --load-info` RC=0;
- no IntelAccelerator/IntelFramebuffer IOKit services under VESA;
- official helper exact.

## Dirty-root workflow / controlled revert
Exact D97HO on the still-patched P1 snapshot exposed only `Revert Root Patch`, no `Start Root Patch`.
Classification: `RESTORE_FIRST=REQUIRED_BY_OCLP_WORKFLOW`.

Controlled D97GS Revert PASS:
- detected installed patchsets: Metal 3802 Common, Metal 3802 .metallibs, Intel Haswell, Metal 3802 Common Extended, Monterey GVA, Monterey OpenCL;
- SkylightPlugins removed;
- AuxKC cleaned;
- Azul and HD5000 removed;
- `Unpatching complete`.

## Upstream OCLP 2.5.0 / current Nightly review
Official OCLP 2.5.0 was published 2026-09-08. Tag `2.5.0` and current `main` both point to `af9b49ac0539c684590ac35c7d695c7e706f6aea`; current Nightly has no newer source commit.

Our base `b9df76ebdf3e768b37c1cc980e8444aa837c623e` differs from 2.5.0 only by two commits touching `CHANGELOG.md` and `constants.py`; no functional patchset/sys_patch/Metal3802/Haswell/compiler-path code differs.
Only material constants delta is PatcherSupportPkg `1.9.6 -> 1.9.7`. PatcherSupportPkg 1.9.7 changes four IO80211 binaries and one CoreImage wrapper LC_ID_DYLIB fix; no MTLCompiler/GPUCompiler/Haswell/Metal backend changes.

Decision remains:
`INSTALL_OFFICIAL_OCLP_250_ON_ASUS2=NO`
`INSTALL_CURRENT_NIGHTLY_ON_ASUS2=NO`
`KEEP_D97GS_D97HO_PINNED_PROJECT_CHAIN=YES`.

## D97HR — CLEAN NATIVE VESA CLOSED PASS
After controlled Revert and reboot, exact results:
- `26.6.2 / 25G82`;
- VESA active, D97EZ inert;
- native MTLCompilerService SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`, bytes `239120`, x86_64 UUID `022C1750-8735-389A-A8BA-A8A67F54235D`;
- native CoreDisplay metallib SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes `24128`, MTLB;
- Azul and HD5000 patch bundles absent from `/Library/Extensions`;
- IOKit Azul/HD5000/IntelAccelerator/IntelFramebuffer counts all zero;
- AuxKC consistency RC=0;
- official helper exact SHA `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team `S74BDJXQMD`;
- D97HO ZIP remains exact `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3 / 722975756`;
- active legacy MTLCompiler 32023 absent.

Classification:
`D97HR_STATUS=PASS_CLEAN_NATIVE_VESA`
`D97HR_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS`
`D97HR_ROOT_PATCH_STATE=CLEAN_NATIVE_AFTER_REVERT`.

## CURRENT ACTION — exact D97HO Root Patch, then D97HS BEFORE reboot
D97HO Root Patch is authorized now on the clean native snapshot.

Expected patch semantics:
- bounded legacy MTLCompilerService receives exact P1 and must become SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- MTLCompiler 32023 receives P3-only and must become SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- P2 must remain original `418b81d0000000 @ 0x9A8CD`;
- P3 must be `81c900002000 @ 0xA1573`;
- corrected metallibs must be exact 180/180;
- Haswell bundles/AuxKC rebuilt;
- P2b/AIR00/D34 remain absent.

After D97HO says patching completed, DO NOT reboot.
Run:
`OCLP-Continuity/artifacts/OCLP7_D97HS_ASUS2_POST_D97HO_PRE_REBOOT_P1_P3_AUDIT.sh`
- commit `dcfc861b9bd23a8ac00d7d07c43f4166ea402f18`;
- blob `dd71dbd1149a6c96b3e754ff500f029f536bdef5`.

D97HS is derived from the already-proven D97HC underlying-System-volume audit. It must prove active snapshot remains native, underlying P1+P3 exact, P2 unchanged, metallibs 180/180 exact, and Haswell bundles/new AuxKC present. Loaded/unloaded state is informational pre-reboot and is not a gate.

Only after D97HS PASS may a VESA reboot be authorized. No acceleration, EFI/NVRAM/framebuffer changes, P2b, AIR00 or D34 before that review.
