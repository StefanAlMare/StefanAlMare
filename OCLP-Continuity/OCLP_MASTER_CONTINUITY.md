# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HV_CORRECT_ACCEL_WINDOW_P3_SEMANTIC_PROGRESS_SIMULATOR_BITCODE_FRONTIER.md`
- commit `541e7fa63a92a577bd5c82136809463f38134bde`.

Immediate decisive predecessors:
- D97HU active P1+P3 snapshot PASS / D97HV ready: `1c76769b0cd0b76e64f49aa9906b0a406a8e1e1e`;
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

Permanent boot-evidence rule remains binding: an accelerated no-GUI boot may be followed by a VESA recovery boot; the immediately preceding accelerated window is authoritative for accelerated behavior, the recovery VESA window must never be mixed into it, and the user's boot identification is authoritative.

## Compiler progression now proven
### P1
P1 runtime semantic progress is PROVEN. Before P1 the legacy service died at:
`RIP=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.
After exact P1 this startup failure disappeared and 9/9 P1-only accelerated compiler crashes moved to:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

Exact P1 service post-SHA:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

### P3
Exact P3-only MTLCompiler32023 post-SHA:
`0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
P2 original bytes remain `418b81d0000000 @ 0x9A8CD`.
P3 postimage is `81c900002000 @ 0xA1573`.
No P2b, AIR00 or D34 is active.

The corrected immediately preceding accelerated P1+P3 boot now proves P3 runtime semantic progress. The old post-P1 StringMap crash family is absent from the P1+P3 accelerated window and execution instead reaches a deterministic serialized-bitcode/simulator-related diagnostic path before compiler connection loss.

Classification:
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`
`P1_PLUS_P3_GUI=NEGATIVE_NO_USABLE_GUI`.

AIR00/D34 remain unauthorized. P2b is now plausible but still not authorized without static causal mapping of the new measured failure.

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
After the Root Patch reboot and subsequent recovery sequence, exact D97HU proved the current active VESA snapshot contains exactly the intended P1+P3-only patched root:
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

In this recovery VESA boot, both Haswell kexts report loaded and IOKit contains `IntelAccelerator` and `IntelFramebuffer`. D97HQ had previously shown another VESA boot where they were unloaded. Permanent interpretation: loaded/unloaded and IOKit state under `-igfxvesa` are informational, not a gate.

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

## D97HV — tooling time-window defect
D97HV helper blob `491a73071449a130bc1fdc4d48ad946e51d22ec0` completed and produced evidence ZIP:
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`.

However D97HV parsed `kern.boottime` incorrectly and reported a 1970 boot time, causing the collector to scan historical logs and mix:
- 12 historical 2026-09-07 old NULL-call MTLCompilerService IPS;
- 9 historical 2026-09-08 03:35 P1-only StringMap MTLCompilerService IPS;
- current/recent WindowServer evidence.

Therefore its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` result is invalid and is classified:
`D97HV_AUTOMATIC_CLASSIFICATION=TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`.

Do not rerun D97HV as-is.

## Correct authoritative P1+P3 accelerated boot — 14:24:02 to approximately 14:27:17
The user explicitly identified the boot immediately before current VESA as accelerated. Correct boundary reconstruction confirms:
- first accelerated WindowServer launch `14:24:02.6523`;
- accelerated compiler/WindowServer loop continues through approximately `14:27:16.953`;
- recovery VESA WindowServer begins only at approximately `14:28:38.955`.

This 14:24:02–14:27:17 window is the authoritative P1+P3 accelerated experiment.

### Accelerated WindowServer evidence
Twelve distinct WindowServer processes occurred in this window:
`177, 387, 426, 471, 518, 565, 608, 637, 663, 691, 717, 743`.

Captured accelerated IPS include:
- pid177, capture14:24:59.8518: EXC_CRASH/SIGABRT in `MetalShader::CopyPipelineState(...)+2930`;
- pid387, capture14:25:13.7930: COREANIMATION code4, `PBGRAXb_Xc`, interrupted compiler connection after multiple retries, `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- pid426 14:25:28.6413: same compiler-XPC/pipeline family;
- pid471 14:25:43.0220: same family;
- pid518 14:25:56.6587: same family;
- pid565 14:26:07.0357: same family.
Later WindowServer processes continue the same loop until recovery.

### Accelerated MTLCompilerService evidence
There are 145 distinct compiler-service launches in the accelerated window. 144 are associated with the 12 WindowServer processes, approximately 12 compiler-service launches per WindowServer; one is associated with SecurityAgent.

All 145 invocations reach the same two recurrent, partially decode-truncated MTLCompiler diagnostics containing stable fragments:
- `...upported in the simulator but <decode: mismatch for [%u] got [STRING sz:9]> were used`
- `n bitcode.`

Exact missing wording is UNKNOWN and must not be invented.

Critically, in this authoritative accelerated window:
- current MTLCompilerService IPS = 0;
- old NULL-call signature = 0 current;
- post-P1 StringMap SIGSEGV family = 0 current.

Thus the old StringMap crashes printed by D97HV came entirely from the historical 03:35 P1-only boot, not from P1+P3.

### Deterministic downstream consequence
The accelerated WindowServer log contains 132 compiler interruption retry lines:
`MTLCompiler: Compilation failed with XPC_ERROR_CONNECTION_INTERRUPTED on N try`.
Distribution is exact:
- try1 = 33;
- try2 = 33;
- try3 = 33;
- try4 = 33.

Repeated GPUPass/render-pipeline failures follow, including `GetGPUPassRenderPipelineState ... <error>` and `Metal failed to build render pipeline`, followed by WindowServer abort/restart.

Current causal chain:
`P1 + P3 serialized-bitcode path -> recurring MTLCompiler simulator/bitcode diagnostic -> MTLCompilerService connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

This is runtime semantic movement attributable to P3 because P3 is the sole new compiler functional delta and specifically changes the backend handoff to serialized bitcode, while the previous StringMap/llvm::Module* crash family disappears completely and the new diagnostic explicitly involves bitcode/simulator semantics.

Do NOT yet equate this new path with `MTLSimCompiler::validSimulatorMetadata`; that historical symbol is directionally consistent but current identity is not proven.

## P2b decision
Historical P2b is the request-layout adapter `+0xD0 -> +0x110` at MTLCompiler offset `0x9A8CD`.
P2b did not move the old StringMap crash when tested before P3, so P3 was correctly selected first.
Now that P3 has moved execution into the serialized-bitcode/simulator-related path, P2b becomes a plausible next candidate and is consistent with the old accepted chain that reached much farther.

Nevertheless:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

We first map the exact new diagnostic/xref path and determine whether P2b is upstream/causal to it.

## CURRENT ACTION — D97HW read-only static simulator/bitcode frontier map
No Root Patch, no reboot, no EFI/NVRAM/framebuffer mutation, no acceleration change.

Next analysis must:
1. pin active P1 service `a8716ffd...` and active P3-only MTLCompiler32023 `0066a944...`;
2. recover full strings in MTLCompiler32023 containing `simulator` and `bitcode`;
3. map file offsets/virtual addresses and xrefs;
4. disassemble the paths reaching those diagnostics;
5. map their relationship to P2 offset `0x9A8CD` and P3 offset `0xA1573`;
6. inspect `MTLSimCompiler::validSimulatorMetadata` only if current binary evidence supports that symbol/path;
7. classify whether P2b is the next measured causal adapter.

D97EW may separately be inventoried for the already-completed 14:24–14:27 accelerated boot, but the D97HV evidence archive already proves the compiler-frontier movement. Do not reinstall/reboot merely for D97EW before the static map.
