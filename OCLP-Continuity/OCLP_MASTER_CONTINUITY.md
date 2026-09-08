# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HU_HELPER_HASH_GATE_TOOLING_FALSE_NEGATIVE_RERUN_READY.md`
- commit `bb14fc276b85585a0adcb36a667a3680ab9cfa85`.

Immediate decisive predecessors:
- D97HS pre-reboot P1+P3 FULL PASS / VESA reboot authorized: `5693992b5115b2c3e301920caeff13da30557e41`;
- D97HT tooling false negative / direct D97HS rerun: `08d174b574ec400222cd1218cac7015ee9461fb2`;
- D97HO Root Patch P1+P3 PASS / first D97HS helper residual: `bd7e059537618175a33949193532cb3e53166d11`;
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
Exact source diff: `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.
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
Exact D97HO completed Root Patch on the D97HR clean/native baseline.
Patcher-reported decisive evidence:
- exact local MetallibSupportPkg 26.6.2-25G82 used;
- Metal 3802 Common / Common Extended / .metallibs, Monterey GVA/OpenCL, Intel Haswell and Modern Wireless Common applied;
- D97GS P1 exact historical identity PASS, service post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97HI P3 exact P3-only identity PASS, MTLCompiler32023 post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- new AuxKC built and forced;
- patching complete.

Classification:
`D97HO_ROOT_PATCH_EXECUTION=PASS`
`P1_EXACT=PROVEN_BY_PATCHER`
`P3_EXACT_P3_ONLY=PROVEN_BY_PATCHER`
`P2B_AIR00_D34=NOT_REPLAYED`.

## D97HS — FULL PRE-REBOOT P1+P3 AUDIT PASS
Exact artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HS_ASUS2_POST_D97HO_PRE_REBOOT_P1_P3_AUDIT.sh`
- commit `dcfc861b9bd23a8ac00d7d07c43f4166ea402f18`;
- blob `dd71dbd1149a6c96b3e754ff500f029f536bdef5`.

D97HS full rerun proved:
- VESA active, D97EZ inert;
- active booted snapshot remains native pre-reboot: service `4262e71f...`, CoreDisplay `daee638d... / 24128`, legacy 32023 absent;
- official helper exact SHA `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team `S74BDJXQMD`;
- local corrected metallib source exact 180, CoreDisplay `b848d54e... / 20739`;
- D97HO ZIP exact `a1aa24d5... / 722975756`;
- underlying sealed System volume mounted read-only;
- underlying P1 service exact SHA `a8716ffd...`, bytes 85520, postimage `81fe177d0000 @ 0x3494`;
- underlying P3-only MTLCompiler32023 exact SHA `0066a944...`, bytes 1636896, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 remains exact original `418b81d0000000 @ 0x9A8CD`, no P2b;
- P3 exact postimage `81c900002000 @ 0xA1573`;
- corrected metallibs exact 180/180, missing0, different0, CoreDisplay exact MTLB;
- Azul and HD5000 bundles present;
- new AuxKC `/Library/KernelCollections/AuxiliaryKernelExtensions.kc`, bytes 5439488, contains both Haswell kexts;
- `kmutil check --collection aux --load-info` RC0 informational pre-reboot.

Final classification:
`D97HS_STATUS=PASS_PRE_REBOOT_P1_P3_AUDIT`
`D97HS_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97HS_PATCHED_P1=EXACT`
`D97HS_PATCHED_P3=EXACT_P3_ONLY`
`D97HS_P2B_REPLAY=NO`
`D97HS_AIR00_REPLAY=NO`
`D97HS_D34_REPLAY=NO`
`D97HS_PATCHED_METALLIBS=180_OF_180_EXACT`
`D97HS_HASWELL_AUXKC=ON_DISK_PRESENT_PASS`.

Report:
`/Users/alex/Desktop/OCLP7_D97HS_POST_D97HO_PRE_REBOOT_20260908_141929/D97HS_REPORT.txt`.

## D97HU first invocation — helper identity gate false-negative
The authorized VESA reboot has now occurred. No further reboot is required before D97HU.

The user downloaded D97HU from exact commit `19ee3a189bbbb6af2ca83b425e613fe4724f21b8`, but the command supplied an incorrect expected Git blob `771c11b8c0529137f4c3939d202d49204d04874d` and stopped before executing the helper.

Repository truth for the exact D97HU artifact is:
- path `OCLP-Continuity/artifacts/OCLP7_D97HU_ASUS2_POST_VESA_REBOOT_ACTIVE_P1_P3_AUDIT.sh`;
- commit `19ee3a189bbbb6af2ca83b425e613fe4724f21b8`;
- blob `2f023cb10d544794e88a06ba58ab7c276f3d060f`;
- bytes `12256`.

Classification:
`D97HU_HELPER_IDENTITY_FAILURE=TOOLING_FALSE_NEGATIVE_WRONG_EXPECTED_BLOB`
`D97HU_SCRIPT_EXECUTED=NO`
`D97HO_P1_P3_ACTIVE_STATE=NOT_INVALIDATED`
`ROOT_PATCH_RERUN=NO`
`REBOOT_AGAIN=NO`.

A same-boot WindowServer crash at `2026-09-08 14:26:07 +0300` records COREANIMATION code4 / `spec=PBGRAXb_Xc` / repeated `XPC_ERROR_CONNECTION_INTERRUPTED`, with GPUCompiler 32023 libraries and AppleIntelHD5000GraphicsMTLDriver present in the image list. Treat this as useful post-reboot compiler-path reachability evidence only; it is not an accelerated-test result and does not replace D97HU.

## CURRENT ACTION — rerun exact D97HU directly, no reboot
Do NOT reboot again. Do NOT rerun Root Patch. Do NOT change EFI/NVRAM/framebuffer/boot-args.

Run the already downloaded exact helper after verifying the corrected blob:
`2f023cb10d544794e88a06ba58ab7c276f3d060f`.

D97HU is read-only and must prove the active snapshot contains:
1. exact P1 service SHA/postimage;
2. exact P3-only MTLCompiler32023 SHA/UUID;
3. P2 original and P3 exact postimage;
4. corrected metallibs exact 180/180;
5. Haswell bundles and AuxKC present and consistent;
6. official helper exact;
7. D97HO artifact exact.

D97HU intentionally treats Azul/HD5000 `loaded/unloaded` state and IOKit state under `-igfxvesa` as informational rather than a gate, incorporating D97HQ evidence.

Expected final:
`D97HU_STATUS=PASS_ACTIVE_P1_P3_VESA`
`D97HU_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS_ACTIVE_SNAPSHOT`
`D97HU_NEXT=REVALIDATE_D97EW_CAPTURE_BEFORE_ANY_ACCELERATED_BOOT`
`D97HU_ACCELERATION=NOT_YET_AUTHORIZED`.

Even after D97HU PASS, acceleration remains unauthorized until D97EW persistent capture is repaired/revalidated, because the previous P1-only accelerated attempt produced an incomplete current accelerated tuple capture.
