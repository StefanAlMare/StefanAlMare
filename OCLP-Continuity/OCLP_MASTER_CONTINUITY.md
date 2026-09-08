# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HU_ACTIVE_P1_P3_VESA_PASS_CURRENT_COMPILER_INTERRUPTION_D97HV_READY.md`
- commit `1c76769b0cd0b76e64f49aa9906b0a406a8e1e1e`.

Immediate decisive predecessors:
- D97HU helper-hash false-negative correction: `bb14fc276b85585a0adcb36a667a3680ab9cfa85`;
- D97HS pre-reboot P1+P3 FULL PASS: `5693992b5115b2c3e301920caeff13da30557e41`;
- D97HO Root Patch P1+P3 PASS: `bd7e059537618175a33949193532cb3e53166d11`;
- D97HR clean-native VESA PASS: `d80304f308cd30af224984bbf27da0c494993f5f`;
- upstream OCLP 2.5.0/Nightly review — no target update: `dcdb38756fdd09b8b6bb4362572bd70c26f62ae5`;
- D97HN inner audit PASS / D97HO wrapper PASS: `e75fec4b3c5921ec0a2a28760bf7c699fc96a333`;
- D97HF P1 runtime semantic progress / measured P3 frontier: `1af98134a40236290484037548dfba621df1c626`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.
Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only. Never compile on ASUS2.
Portable non-target Intel build hosts are allowed only with exact source/provenance/hash gates.
Preserve `ipc_control_port_options=0`, `-amfipassbeta`.
Current optional iGPU properties remain OFF.

## Measured compiler state / hypothesis
P1 runtime semantic progress is PROVEN: old `RIP=0 / r15=32023 / MTLConnectionCtx+56` disappeared 9/9 after P1.
Measured post-P1 frontier was:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
P2b is not justified as the current automatic next patch.
P3 serialized-bitcode bridge was the measured next intervention.
AIR00/D34 remain unauthorized.

Exact P1 service post-SHA:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.
Exact P3-only MTLCompiler32023 post-SHA:
`0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
P2 original bytes remain `418b81d0000000 @ 0x9A8CD`.
P3 postimage is `81c900002000 @ 0xA1573`.

## D97HI / D97HO artifact chain — CLOSED PASS
D97HI exact source diff `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.
P1 AST preserved byte-identical; P3 is the only new functional delta; P2b/AIR00/D34 absent.
D97HI inner executable SHA `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`.
D97HI inner ZIP SHA `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`, bytes `722927108`.
D97HO wrapper ZIP SHA `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`, bytes `722975756`.

## Upstream OCLP 2.5.0 / Nightly review
Official OCLP 2.5.0 was published 2026-09-08. Tag `2.5.0` and then-current `main` both pointed to `af9b49ac0539c684590ac35c7d695c7e706f6aea`.
Our functional base `b9df76ebdf3e768b37c1cc980e8444aa837c623e` already contained the relevant functional changes; the remaining release delta was changelog/constants, principally PatcherSupportPkg `1.9.6 -> 1.9.7`.
1.9.7 changed four IO80211 binaries and one CoreImage wrapper LC_ID_DYLIB fix, not the measured MTLCompiler/GPUCompiler/Haswell backend frontier.
Decision: do not replace the ASUS2 experiment with official 2.5.0/Nightly during this lane.

## D97HO Root Patch / D97HS pre-reboot — PASS
After controlled D97GS Revert and D97HR clean-native verification, exact D97HO Root Patch completed normally.
Patcher reported exact P1 and exact P3-only post identities; AuxKC built and forced.
D97HS independently proved on the underlying sealed System volume before reboot:
- exact P1 service `a8716ffd...`;
- exact P3-only MTLCompiler32023 `0066a944...`, bytes 1636896, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 original / no P2b;
- P3 exact postimage;
- corrected metallibs exact 180/180, missing0, different0;
- Haswell bundles present and new AuxKC contains Azul+HD5000;
- official helper exact.
Classification: `STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

## D97HU — ACTIVE SNAPSHOT FULL PASS
After the authorized single VESA reboot, exact D97HU proved the now-active runtime snapshot is exactly P1+P3-only:
- 25G82;
- `-igfxvesa` active, D97EZ inert;
- active P1 service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, bytes 85520, exact postimage;
- active P3-only MTLCompiler32023 SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`, bytes 1636896, UUID exact;
- P2 remains original `418b81d0000000`;
- P3 postimage `81c900002000` exact;
- active corrected metallibs exact 180/180, CoreDisplay `b848d54e... / 20739 / MTLB`;
- Azul and HD5000 both present in AuxKC;
- `kmutil check --collection aux --load-info` RC0;
- official helper exact `9b74b7c...`, Team `S74BDJXQMD`;
- D97HO ZIP still exact.

In this VESA boot, both Haswell kexts report loaded and IOKit contains `IntelAccelerator` and `IntelFramebuffer`. D97HQ had previously shown a VESA boot where those kexts were unloaded. Permanent interpretation: loaded/unloaded and IOKit state under `-igfxvesa` are informational, not a gate; VESA must not be equated with kernel absence of the Haswell stack.

D97HU final:
`D97HU_STATUS=PASS_ACTIVE_P1_P3_VESA`
`D97HU_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS_ACTIVE_SNAPSHOT`
`D97HU_ACTIVE_P1=EXACT`
`D97HU_ACTIVE_P3=EXACT_P3_ONLY`
`D97HU_P2B_REPLAY=NO`
`D97HU_AIR00_REPLAY=NO`
`D97HU_D34_REPLAY=NO`
`D97HU_ACTIVE_METALLIBS=180_OF_180_EXACT`.

Report:
`/Users/alex/Desktop/OCLP7_D97HU_POST_VESA_ACTIVE_P1_P3_20260908_144116/D97HU_REPORT.txt`.

## Same-boot WindowServer compiler interruption
In the SAME VESA boot, WindowServer launched at `2026-09-08 14:25:56.6519 +0300` and crashed at `14:26:07.0357 +0300` with COREANIMATION code4, `spec=PBGRAXb_Xc`, and repeated `XPC_ERROR_CONNECTION_INTERRUPTED` during `CA::OGL::MetalContext::create_pipeline_state(...)+6896` / SkyLight Metal composition.
GPUCompiler 32023 libraries and `AppleIntelHD5000GraphicsMTLDriver` were loaded in the process image set.
Classification:
- Metal compositor/compiler path `REACHED`;
- XPC interruption `CONTROL-FLOW PROVEN`;
- NOT an accelerated test because `-igfxvesa` remains active;
- P3 semantic runtime effect remains UNKNOWN until current-boot MTLCompilerService crashes are inspected.

## CURRENT ACTION — D97HV current-boot compiler frontier, before D97EW
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HV_CURRENT_P1_P3_VESA_COMPILER_FRONTIER_COLLECTOR.sh`
- creation commit `01de20bcaff4f916183dd8144216bc7a660d3c28`;
- exact git blob `491a73071449a130bc1fdc4d48ad946e51d22ec0`;
- bytes `12224`.

D97HV is read-only with respect to Root Patch/Restore/EFI/NVRAM/framebuffer; it does not reboot or accelerate and writes evidence only to Desktop.
It binds to the current boot, copies only current-boot `MTLCompilerService` and `WindowServer` IPS reports, checks the old NULL-call family, the post-P1 StringMap family, backend-compile path, simulator-metadata path, WindowServer XPC/pipeline state and same-boot unified logs.

Possible P3 runtime classifications:
- `P3_MOVED_POST_P1_STRINGMAP_FRONTIER`;
- `P3_DID_NOT_MOVE_POST_P1_STRINGMAP_FRONTIER`;
- `P3_MIXED_CURRENT_BOOT_FRONTIER`;
- `INCONCLUSIVE_NO_MTL_IPS_CURRENT_BOOT`.

Execution rule now:
- DO NOT reboot;
- DO NOT change boot-args;
- DO NOT accelerate;
- DO NOT run/reinstall D97EW yet;
- run exact D97HV and review its evidence first.

After D97HV is classified, revalidate/repair D97EW persistent capture before any accelerated P1+P3 boot.
