# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HO_ROOTPATCH_P1_P3_PASS_D97HS_HELPER_DEBUG_RESIDUAL_D97HT_RESTORE_AND_RERUN.md`
- commit `bd7e059537618175a33949193532cb3e53166d11`.

Immediate decisive predecessors:
- D97HR clean-native VESA PASS / D97HO authorized: `d80304f308cd30af224984bbf27da0c494993f5f`;
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
P1 AST preservation byte-identical: bytes 3466/3466, SHA both `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`.
D97HN independently proved P1 exact, P3-only, hook order P1 -> P3 -> continuation, P2b/AIR00/D34 absent, x86_64 inner executable SHA `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`, inner ZIP SHA `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`, bytes 722927108, manifest exact 156/156.

## D97HO wrapper — CLOSED PASS
Exact D97GS wrapper + exact audited D97HI inner.
ZIP SHA `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`, bytes `722975756`.
Preserved D97GS components: launcher `344ea23b...`, DEBUG helper `993bf7e8...`, D97DX source patch `c8b45d7f...`, D97GS source patch `cae9c340...`.

## Upstream OCLP 2.5.0 / current Nightly review
Official OCLP 2.5.0 published 2026-09-08. Tag `2.5.0` and current `main` both point to `af9b49ac0539c684590ac35c7d695c7e706f6aea`; current Nightly has no newer source commit.
Our base `b9df76ebdf3e768b37c1cc980e8444aa837c623e` differs from 2.5.0 only in `CHANGELOG.md` and `constants.py`; no functional patchset/sys_patch/Metal3802/Haswell/compiler-path changes.
Only material constants delta is PatcherSupportPkg `1.9.6 -> 1.9.7`; 1.9.7 changes four IO80211 binaries and one CoreImage wrapper LC_ID_DYLIB fix, not MTLCompiler/GPUCompiler/Haswell/Metal backend.
Decision: no official 2.5.0 or Nightly install on ASUS2 during this experiment.

## D97HR — CLEAN NATIVE VESA CLOSED PASS
After controlled D97GS Revert and reboot:
- 25G82, VESA active, D97EZ inert;
- native MTLCompilerService SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`, bytes 239120;
- native CoreDisplay metallib SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128;
- Azul/HD5000 absent from `/Library/Extensions`, no IntelAccelerator/IntelFramebuffer IOKit services;
- AuxKC consistency RC=0;
- official helper exact `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team `S74BDJXQMD`;
- D97HO exact;
- active legacy MTLCompiler 32023 absent.

## D97HO Root Patch — EXECUTION PASS
User ran exact D97HO on the D97HR clean/native state. Root Patch completed normally.
Decisive patcher-reported evidence:
- exact local MetallibSupportPkg 26.6.2-25G82 used;
- Metal 3802 Common / Common Extended / .metallibs, Monterey GVA/OpenCL, Intel Haswell and Modern Wireless Common applied;
- D97GS P1 exact historical identity PASS with service post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97HI P3 exact P3-only identity PASS with MTLCompiler32023 post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- new AuxKC built and forced;
- patching complete;
- no reboot yet.

Classification:
`D97HO_ROOT_PATCH_EXECUTION=PASS`
`P1_EXACT=PROVEN_BY_PATCHER`
`P3_EXACT_P3_ONLY=PROVEN_BY_PATCHER`
`P2B_AIR00_D34=NOT_REPLAYED`.

## D97HS first run — partial PASS / helper residual only
Before stopping D97HS proved:
- VESA gate PASS;
- active booted snapshot still native Tahoe;
- active native service exact `4262e71f...`;
- active native CoreDisplay exact `daee638d... / 24128`;
- active legacy 32023 absent, expected before reboot.

D97HS then found active privileged helper SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`, Team not set.
This is the exact known D97GS/D97HO DEBUG helper preserved in the custom wrapper, not an unknown binary and not P3 failure.
Classification:
`D97HS_FAIL=INFRASTRUCTURE_HELPER_RESIDUAL_ONLY`
`D97HS_P3_STATUS=NOT_INVALIDATED`
`REBOOT=NO`.

## CURRENT ACTION — D97HT restore official helper + rerun exact D97HS
D97HT artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HT_RESTORE_OFFICIAL_HELPER_AND_RERUN_D97HS.sh`
- commit `0d778babaa1c8c8318bcf1cbff11c3516d270aa6`;
- blob `69a5b2e57e857f2fc735b030c0aa8caa24504f68`.

D97HT pins and executes:
1. exact proven D97HA official-helper-only restore, commit `5c5ffddc7db7c2d6113115c90b9ef0e74449e977`, blob `5eec076996619bab2b2d8a17f57b086b6d0ac011`;
2. exact D97HS pre-reboot audit, commit `dcfc861b9bd23a8ac00d7d07c43f4166ea402f18`, blob `dd71dbd1149a6c96b3e754ff500f029f536bdef5`.

Only system mutation authorized is replacing the exact DEBUG helper with the exact official helper. No Root Patch, Restore, EFI/NVRAM/framebuffer change or reboot.

D97HS full PASS must prove on underlying System volume:
- exact P1 service SHA `a8716ffd...`;
- exact P3-only MTLCompiler32023 SHA `0066a944...`;
- P2 original `418b81d0000000 @ 0x9A8CD`;
- P3 postimage `81c900002000 @ 0xA1573`;
- corrected metallibs 180/180 exact;
- Haswell bundles present and new AuxKC contains both.

Only after D97HT/D97HS full PASS may a VESA reboot be authorized. No acceleration before post-reboot active-snapshot audit.
