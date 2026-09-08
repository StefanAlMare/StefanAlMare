# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST — full-corpus reconciliation through D97HV

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for their own historical evidence. This MASTER and its current checkpoint are the current execution/causal authority. If historical `CURRENT ACTION`, boot-arg baselines, execution-lane wording, or automatic classifications conflict with the current checkpoint, they are superseded prospectively.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HV_FULL_CORPUS_PERMANENT_RECONCILIATION_D97HW_READY.md`
- creation commit `8c6d095ff97e6d3ebd2775fb132903bc4281f1d1`.

Immediate decisive predecessor:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HV_CORRECT_ACCEL_WINDOW_P3_SEMANTIC_PROGRESS_SIMULATOR_BITCODE_FRONTIER.md`
- commit `541e7fa63a92a577bd5c82136809463f38134bde`.

Other decisive predecessors:
- D97HU active P1+P3 snapshot PASS / D97HV ready: `1c76769b0cd0b76e64f49aa9906b0a406a8e1e1e`;
- D97HS pre-reboot P1+P3 FULL PASS: `5693992b5115b2c3e301920caeff13da30557e41`;
- D97HO Root Patch P1+P3 PASS: `bd7e059537618175a33949193532cb3e53166d11`;
- D97HR clean-native VESA PASS: `d80304f308cd30af224984bbf27da0c494993f5f`;
- D97HF P1 runtime semantic progress / measured P3 frontier: `1af98134a40236290484037548dfba621df1c626`;
- D97GR exact P1 reconstruction / missing-P1 NULL-call closure;
- D97GM corrected-metallib semantic frontier movement.

## Target / invariant platform
- macOS Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- framebuffer baseline `3/3/3`;
- end goal: stable hardware-accelerated GUI, not merely suppression of a late WindowServer crash.

Permanent operational invariants:
- never auto Root Patch;
- never auto reboot;
- never modify EFI/NVRAM automatically;
- Golden Sequoia is immutable/read-only and never booted for evidence collection;
- never compile on ASUS2 unless a later explicit user authorization says otherwise;
- GitHub-first for all technically GitHub-eligible validation/integration/build/package/audit work;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- current optional iGPU properties (`igfxfw`, `rps-control`, Max Pixel Clock Override) remain OFF until a measured result justifies changing them;
- no whole true-five replay without a newly measured causal requirement.

## Current intended functional root — EXACT P1 + P3 ONLY
P1 MTLCompilerService:
- SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- bytes `85520`;
- selector postimage `81fe177d0000 @ 0x3494`.

P3-only MTLCompiler32023:
- SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- bytes `1636896`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 remains original `418b81d0000000 @ 0x9A8CD`;
- P3 exact postimage `81c900002000 @ 0xA1573`.

Inactive/unauthorized in the current experiment:
- P2b: inactive, `NOT_YET_AUTHORIZED`;
- AIR00: inactive/unauthorized;
- D34: inactive/unauthorized.

Historical P1+P2b+P3+AIR00+D34 remains design evidence only. It must not be replayed automatically.

## Corrected 25G82 metallib layer — CLOSED PASS
Exact local/materialized layer:
- 180/180 exact real metallibs;
- missing `0`;
- different `0`.

CoreDisplay metallib:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- direct `MTLB`.

The metallib repair eliminated the previous `validateWithDevice` / `MTLReportFailure` fatal frontier and moved the failure upstream to MTLCompilerService/compiler-XPC behavior. This is proven semantic progress.

## Compiler progression — PROVEN
### P1
Before P1, the recurring legacy service failure was:
`RIP=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.

P1 removed this NULL indirect-call failure. The P1-only accelerated boot around `2026-09-08 03:35 +0300` then produced 9/9 current MTLCompilerService crashes in the exact StringMap/LLVM family:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

Classification:
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

### P3
P3 was reconstructed as the exact measured one-byte compiler delta and added on top of exact P1 with P2b/AIR00/D34 absent.

The authoritative P1+P3 accelerated experiment has:
- zero current old NULL-call crashes;
- zero current post-P1 StringMap crash IPS;
- zero current MTLCompilerService crash IPS;
- 145/145 MTLCompilerService invocations reaching a recurring simulator/bitcode diagnostic path.

Classification:
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`
`P1_PLUS_P3_GUI=NEGATIVE_NO_USABLE_GUI`.

Do not yet equate the current simulator/bitcode path with `MTLSimCompiler::validSimulatorMetadata`; that exact current identity remains UNKNOWN until D97HW static mapping proves it.

## D97HI / D97HO artifact chain — CLOSED PASS
D97HI source diff SHA256:
`c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

D97HI inner executable SHA256:
`1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`.

D97HI inner ZIP:
- SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- bytes `722927108`.

D97HO wrapper ZIP:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

Independent audit proved P1 preserved byte-identical, P3 the sole new compiler functional delta, and no P2b/AIR00/D34 replay.

## D97HO Root Patch / D97HS / D97HU — structural state PASS
After controlled Restore/Revert and clean-native verification, exact D97HO Root Patch completed normally.

D97HS proved the underlying patched System volume before reboot:
- exact P1;
- exact P3-only MTLCompiler32023;
- P2 original/no P2b;
- exact corrected metallibs 180/180;
- Haswell bundles and new AuxKC;
- exact official helper.

D97HU subsequently proved the active recovery snapshot contains the same intended P1+P3-only patched root and exact metallib layer.

D97HU's structural active-snapshot result remains valid. However, one D97HU runtime-attribution statement is superseded: WindowServer events at `14:25:*` and `14:26:*` were later proven to belong to the immediately preceding accelerated boot, not the later VESA recovery boot.

Permanent interpretation of Haswell loaded/unloaded state under `-igfxvesa`: informational, not a pass/fail gate. Earlier VESA sessions proved both loaded and unloaded variants while VESA policy remained active.

## Authoritative P1+P3 accelerated window
User boot identification plus timestamp reconstruction makes this the durable identity:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Key boundary evidence:
- first accelerated WindowServer launch evidence `14:24:02.6523`;
- compiler/WindowServer restart loop through approximately `14:27:16.953`;
- recovery VESA WindowServer starts only at approximately `14:28:38.955`.

Therefore do not call the accelerated experiment merely "penultimate" or "antepenultimate" in durable state. Those ordinals change after later recovery/reboots. Use the explicit timestamped experiment window.

Within the accelerated window:
- 12 WindowServer processes;
- 145 MTLCompilerService launches;
- recurring MTLCompiler diagnostic fragments include `...upported in the simulator but ... were used` and `n bitcode.`;
- exact missing string text remains UNKNOWN and must not be invented;
- 132 compiler-XPC interruption retry lines, exactly 33 each for try 1/2/3/4;
- repeated GPUPass/render-pipeline failures;
- WindowServer abort/restart;
- no usable GUI.

Current measured chain:
`P1 + P3 serialized-bitcode path -> recurring MTLCompiler simulator/bitcode diagnostic -> compiler-service connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

## D97HV collector — raw evidence useful, automatic classification INVALID
D97HV helper Git blob:
`491a73071449a130bc1fdc4d48ad946e51d22ec0`.

Collector-produced evidence package:
- filename `OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_20260908_151239.zip`;
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`.

The helper misparsed `kern.boottime` and emitted a 1970 start time, so it mixed historical IPS/logs. Its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` classification is therefore invalid:
`D97HV_AUTOMATIC_CLASSIFICATION=TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`.

Raw evidence becomes authoritative only after exact timestamp re-scoping to the accelerated window above.

During the 2026-09-08 permanent reconciliation, the full collector transcript/package metadata was accessible, but the binary ZIP object itself was not exposed by File Library for an independent second archive-byte inspection. Do not state that a second independent archive-byte audit has occurred unless the exact ZIP is subsequently re-uploaded and opened.

## OCLP 2.5.0 / Nightly review
Official 2.5.0 and then-current Nightly did not alter the measured MTLCompiler/GPUCompiler/Haswell compiler frontier relative to the pinned functional base in a way relevant to this experiment. Do not replace the current project app/assets with official 2.5.0/Nightly merely because they are newer packages.

## P2b decision
Historical P2b is the request-layout adapter `+0xD0 -> +0x110` at `0x9A8CD`.

P2b is now a plausible candidate because P3 moved execution into a serialized-bitcode/simulator-related path. It is **not** authorized yet.

Required order:
1. map the new exact diagnostic/xref path;
2. establish whether P2b is upstream and causal;
3. only then decide whether a P2b experiment is warranted.

## CURRENT ACTION — D97HW read-only simulator/bitcode static map
Artifact already present:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has **not yet been executed** and has no result checkpoint.

D97HW must:
1. pin active P1 service and active P3-only MTLCompiler32023;
2. prove P2 is still original and P3 exact;
3. recover exact full strings containing `simulator` and `bitcode`;
4. map their file offsets, VAs and xrefs;
5. disassemble relevant paths;
6. relate those paths to P2 offset `0x9A8CD` and P3 offset `0xA1573`;
7. inspect `MTLSimCompiler::validSimulatorMetadata` only if supported by current binary evidence;
8. classify whether P2b is the next measured causal adapter.

No Root Patch, Restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot during D97HW.

The existing helper binds exact active `/System/Library` files on Darwin x86_64 25G82, so its execution is inherently ASUS2/live-state dependent unless byte-identical active binaries are separately made available under an audited remote path.

## Continuation startup order
Before any new technical modification, read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact current authoritative checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

Then resume exactly from `CURRENT ACTION`; do not reconstruct current state from memory or from a stale historical checkpoint.