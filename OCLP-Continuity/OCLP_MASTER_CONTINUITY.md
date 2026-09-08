# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST — independent D97HV archive audit closed

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for their own historical evidence. This MASTER and its current checkpoint are the current execution/causal authority. If historical `CURRENT ACTION`, boot-arg baselines, execution-lane wording, or automatic classifications conflict with the current checkpoint, they are superseded prospectively.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HV_INDEPENDENT_ARCHIVE_AUDIT_PASS_D97HW_READY.md`
- creation commit `0801b6b5b73cc4ce2b515252413eae542900b860`.

Immediate reconciliation predecessor:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HV_FULL_CORPUS_PERMANENT_RECONCILIATION_D97HW_READY.md`
- creation commit `8c6d095ff97e6d3ebd2775fb132903bc4281f1d1`.

Immediate runtime predecessor:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HV_CORRECT_ACCEL_WINDOW_P3_SEMANTIC_PROGRESS_SIMULATOR_BITCODE_FRONTIER.md`
- commit `541e7fa63a92a577bd5c82136809463f38134bde`.

Other decisive predecessors:
- D97HU active P1+P3 snapshot PASS;
- D97HS pre-reboot P1+P3 FULL PASS;
- D97HO Root Patch P1+P3 PASS;
- D97HR clean-native VESA PASS;
- D97HF P1 runtime semantic progress / measured P3 frontier;
- D97GR exact P1 reconstruction / missing-P1 NULL-call closure;
- D97GM corrected-metallib semantic frontier movement.

## Target / invariant platform
- macOS Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- framebuffer baseline `3/3/3`;
- end goal: stable real hardware-accelerated GUI, not merely suppression of a late WindowServer crash.

Permanent operational invariants:
- never auto Root Patch;
- never auto reboot;
- never modify EFI/NVRAM automatically;
- Golden Sequoia immutable/read-only and never booted for evidence collection;
- no compile on ASUS2 unless a later explicit user authorization says otherwise;
- GitHub-first for all technically GitHub-eligible validation/integration/build/package/audit work;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- `igfxfw`, `rps-control`, Max Pixel Clock Override remain OFF until measured evidence justifies changing them;
- no whole true-five replay without a newly measured causal requirement.

## Current functional root — EXACT P1 + P3 ONLY
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

Inactive/unauthorized in current experiment:
- P2b: inactive, `NOT_YET_AUTHORIZED`;
- AIR00: inactive/unauthorized;
- D34: inactive/unauthorized.

Historical P1+P2b+P3+AIR00+D34 remains design evidence only; never replay automatically.

## Corrected 25G82 metallib layer — CLOSED PASS
- real metallibs exact `180/180`;
- missing `0`;
- different `0`.

CoreDisplay metallib:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- direct `MTLB`.

The metallib repair removed the old `validateWithDevice` / `MTLReportFailure` fatal frontier and moved failure upstream to compiler-service/XPC behavior. This is semantic progress.

## Compiler progression — PROVEN
### P1
Before P1:
`RIP=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.

After exact P1, the P1-only accelerated boot around `2026-09-08 03:35 +0300` produced 9/9 current MTLCompilerService crashes in:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

### P3
P3 is the exact one-byte measured compiler delta added on top of exact P1 with P2b/AIR00/D34 absent.

In the authoritative P1+P3 accelerated experiment:
- current old NULL-call crash = `0`;
- current post-P1 StringMap crash IPS = `0`;
- current MTLCompilerService crash IPS = `0`;
- 145/145 MTLCompilerService invocations reach the recurring simulator/bitcode diagnostic route.

`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`
`P1_PLUS_P3_GUI=NEGATIVE_NO_USABLE_GUI`.

Do not label the current validator `MTLSimCompiler::validSimulatorMetadata` until D97HW current-binary static mapping proves it.

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

## Root Patch structural state — PASS
D97HO Root Patch completed after controlled Restore/Revert and clean-native verification.

D97HS proved underlying patched System before reboot:
- exact P1;
- exact P3-only MTLCompiler32023;
- P2 original/no P2b;
- corrected metallibs exact 180/180;
- Haswell bundles/new AuxKC;
- official helper exact.

D97HU proved the later active VESA recovery snapshot contains the same intended P1+P3-only root and exact metallib layer.

D97HU structural result remains valid. Its old runtime attribution of `14:25:*` / `14:26:*` to VESA is superseded; those events belong to the immediately preceding accelerated experiment.

Haswell loaded/unloaded state under `-igfxvesa` is informational, not a pass/fail gate.

## Authoritative P1+P3 accelerated experiment
Durable identity:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Independent ZIP/log audit proves:
- 12 distinct WindowServer PIDs;
- exactly 12 `Server is starting up` markers through `14:27:05.792`;
- 145 distinct MTLCompilerService PIDs;
- all 145 have explicit host peer mapping;
- 144 = exactly 12 MTLCompilerService processes for each of 12 WindowServer processes;
- 1 = SecurityAgent PID405;
- every 145/145 MTLCompilerService PID emits exactly one recurring simulator fragment and exactly one bitcode fragment;
- 0 current `validateWithDevice`;
- 0 current `MTLReportFailure`;
- 0 current `Surface mode contains bad bits`;
- 0 current StringMap/collectUsedGlobalVariables/getOrInsertNamedMetadata/addMsaaPositionInfo family;
- 132 exact WindowServer compiler interruption retry lines: try1=33, try2=33, try3=33, try4=33;
- repeated GPUPass/render-pipeline failures;
- WindowServer abort/restart;
- no usable GUI.

Recovery VESA is distinct: WindowServer activity begins around `14:28:38.955`; `Server is starting up` at `14:28:41.325`.

Do not use mutable ordinal labels such as penultimate/antepenultimate in permanent state; use the explicit timestamped window.

## D97HV archive — INDEPENDENT BYTE AUDIT PASS
Exact re-uploaded ZIP bytes independently verified:
- canonical package identity SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`;
- ZIP CRC PASS;
- 53 entries.

The D97HV report listed 46 copied IPS payloads; independent archive audit matched all 46 by size and SHA256, mismatches `0`.

The archive contains 21 MTLCompilerService IPS files, all historical by embedded captureTime; current 14:24–14:27 MTLCompilerService IPS = `0`.

Six WindowServer IPS fall inside the current accelerated window and independently confirm:
- pid177 `MetalShader::CopyPipelineState(...)+2930` abort;
- pids387/426/471/518/565 COREANIMATION code4 `PBGRAXb_Xc`, compiler connection interrupted after retries, `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- all six load GPUCompiler 32023 `libllvm-flatbuffers.dylib`, `libGPUCompilerUtils.dylib`, and AppleIntelHD5000GraphicsMTLDriver 18.8.4 / bundle 18.0.8.

D97HV collector still has a real tooling defect: it misparsed `kern.boottime` and emitted a 1970 start time, mixing historical IPS/logs. Its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` classification remains INVALID.

Raw evidence is authoritative only after timestamp re-scoping to the window above.

Exact service termination mechanism after the diagnostic remains UNKNOWN: log shows service inactive/connection loss and WindowServer describes compiler-service crash during communication, but there is no current MTLCompilerService IPS. Durable wording is `compiler-service connection loss / service inactive`, not a proven crash mechanism.

Current measured chain:
`P1 + P3 serialized-bitcode path -> exhaustive recurring simulator/bitcode diagnostic route -> compiler-service connection loss / service inactive -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

## OCLP 2.5.0 / Nightly
2026-09-08 review found no measured MTLCompiler/GPUCompiler/Haswell frontier improvement relevant to this lane over the pinned functional base. Do not replace the project app/assets solely because official/nightly package label is newer.

## P2b decision
Historical P2b = request-layout adapter `+0xD0 -> +0x110` at `0x9A8CD`.

P2b is plausible after P3 moved execution to serialized-bitcode/simulator-related behavior, but remains **NOT_YET_AUTHORIZED**.

Required order:
1. map exact diagnostic/xref path;
2. establish whether P2b is upstream/causal;
3. only then decide on a P2b experiment.

## CURRENT ACTION — D97HW read-only simulator/bitcode static map
Artifact already present:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has not yet been executed and has no result checkpoint.

D97HW must:
1. pin active P1 service and active P3-only MTLCompiler32023;
2. prove P2 still original and P3 exact;
3. recover exact full strings containing `simulator` and `bitcode`;
4. map file offsets, VAs and xrefs;
5. disassemble relevant paths;
6. relate paths to P2 `0x9A8CD` and P3 `0xA1573`;
7. inspect `MTLSimCompiler::validSimulatorMetadata` only if current binary evidence supports it;
8. classify whether P2b is the next measured causal adapter.

No Root Patch, Restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot during D97HW.

The helper binds exact active `/System/Library` files on Darwin x86_64 25G82, so execution is inherently ASUS2/live-state dependent unless byte-identical active binaries are separately supplied under an audited remote path.

## Continuation startup order
Before any new technical modification, read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact current authoritative checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

Then resume exactly from `CURRENT ACTION`; never reconstruct current state from memory or a stale checkpoint.