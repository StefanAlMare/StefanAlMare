# OCLP7 CHECKPOINT — 2026-09-08 — D97HV full-corpus/permanent reconciliation COMPLETE / D97HW ready

## Purpose
This is the final reconciliation authority after reviewing the current checkpoint corpus through D97HV and repairing the permanent continuity files so a future conversation cannot resume from a stale P1-only/D97BM/local-first state.

No new functional patch, Root Patch, reboot, EFI/NVRAM/framebuffer mutation or accelerated experiment occurred during this reconciliation.

## Full-corpus status
- checkpoint corpus reviewed through latest functional D97HV;
- OCLP 2.5.0/Nightly review included;
- auxiliary tooling-false-negative/correction checkpoints included;
- no D97HW execution checkpoint exists yet;
- D97HW helper artifact exists but has not been executed.

Historical checkpoints remain authoritative for their own evidence. Current-state instructions in MASTER/current checkpoint supersede stale historical `CURRENT ACTION`, stale boot baselines, stale execution-lane instructions and automatic classifiers later invalidated by corrected evidence.

## Permanent files repaired
The following durable files were reconciled:
- MASTER — commit `d9c0ceae84ac4347d40c4a41cfc04ec88daebd7f`;
- HISTORY — commit `03677b86f4a4e11cb20075941961e3b6d468a8a5`;
- PERMANENT DATABASE — commit `fa1daede02f51319a0d5d79805170e2ba0f22162`;
- PERMANENT WORKING RULES — commit `48db39717e2d326eb1ec35544f5224523c84e5c2`;
- PERMANENT VESA RULE — commit `b0afdacd189066866895c30bdc63f8c1fca8add1`;
- NEXT CHAT BOOTSTRAP — commit `7b4c5f0f4f5bd1554c8f15c2607e031032759f52`;
- PROJECT RETROSPECTIVE interpretation — commit `9352987b9705c3e2a95acbd05e4ed5349cdf2d39`.

Repaired contradictions include:
1. HISTORY no longer stops at D97HD/P1-only.
2. DATABASE no longer claims D97BM/no active Root Patch as current state.
3. bootstrap no longer says local-first and no longer treats true-five as active.
4. historical five-patch baseline is explicitly design evidence, not current patchset.
5. optional iGPU properties are current OFF baseline.
6. VESA/accelerated evidence is permanently bound by explicit timestamp window, not mutable boot ordinals.
7. D97HU structural active-snapshot PASS is retained, but its old 14:25-14:26 runtime attribution to VESA is superseded by corrected accelerated chronology.

## Current target and exact intended compiler state
Target:
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- framebuffer `3/3/3`.

Current intended patched root is exact **P1 + P3 only**:
- P1 MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- P3-only MTLCompiler32023 SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- P2 remains original `418b81d0000000 @ 0x9A8CD`;
- P3 postimage `81c900002000 @ 0xA1573`;
- P2b inactive/not authorized;
- AIR00 inactive/not authorized;
- D34 inactive/not authorized.

Corrected metallibs:
- exact 180/180;
- CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- direct `MTLB`.

D97HO wrapper:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

## Proven semantic progression
### Metallib repair
The real 25G82 metallib repair removed the old `validateWithDevice/MTLReportFailure` fatal frontier and moved failure into compiler-service/XPC behavior.

Classification: semantic progress PROVEN.

### P1
Pre-P1 recurring failure:
`RIP=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Exact P1 removed that failure. P1-only accelerated evidence around `2026-09-08 03:35 +0300` moved 9/9 current MTLCompilerService crashes to:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

### P3
Exact P3 was the sole new compiler functional delta over P1.

In the authoritative P1+P3 accelerated experiment:
- old NULL-call current count `0`;
- P1-only StringMap current count `0`;
- current MTLCompilerService crash IPS `0`;
- 145 compiler-service invocations reach a new recurring simulator/bitcode diagnostic path.

`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`.
`GUI=NEGATIVE_NO_USABLE_GUI`.

Do not yet identify the current path as `MTLSimCompiler::validSimulatorMetadata`; current binary mapping is pending.

## Authoritative P1+P3 accelerated experiment
Durable identity:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Evidence boundary:
- first accelerated WindowServer evidence `14:24:02.6523`;
- accelerated compiler/WindowServer restart loop through ~`14:27:16.953`;
- recovery VESA WindowServer begins only ~`14:28:38.955`.

Therefore all `14:25:*` and `14:26:*` WindowServer crash evidence belongs to the accelerated P1+P3 experiment, not the later VESA recovery boot.

Current measured chain:
`P1 + P3 serialized-bitcode path -> recurring simulator/bitcode diagnostic -> compiler-service connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

## D97HV collector / ZIP authority
D97HV helper blob:
`491a73071449a130bc1fdc4d48ad946e51d22ec0`.

Collector-produced ZIP metadata:
- `OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_20260908_151239.zip`;
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`.

D97HV misparsed `kern.boottime` as 1970, causing historical IPS/log contamination. Its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` classification is invalid tooling contamination.

Raw evidence is useful after exact timestamp re-scoping to the accelerated window above.

During reconciliation, File Library exposed the full collector transcript/package metadata but repeatedly failed to expose/search the binary ZIP object itself. Therefore the ZIP identity is collector-reported/checkpoint-persisted; no independent second archive-byte re-open is claimed. If the exact ZIP is later re-uploaded, it may be independently opened without changing the already-established timestamped runtime conclusion unless new contradictory evidence appears.

## P2b decision
Historical P2b adapts request layout `+0xD0 -> +0x110` at `0x9A8CD`.

P2b is now plausible because P3 moved the current experiment into a serialized-bitcode/simulator-related path, but:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

AIR00 and D34 remain unauthorized.

The permanent method requires mapping the new diagnostic path first and proving whether P2b is upstream/causal.

## Execution rule
GitHub-first remains permanent for all technically GitHub-eligible validation/integration/build/package/audit work.

ASUS2/user remains for identity-pinned target/live-state operations. Local compilation is not an implicit fallback and requires explicit authorization. Never auto Root Patch or auto reboot.

## CURRENT ACTION — D97HW
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has not yet been executed.

Required D97HW outcome:
1. bind exact active P1/P3 identities;
2. confirm P2 original and P3 exact;
3. recover complete active-binary `simulator`/`bitcode` strings;
4. map file offsets/VAs/xrefs;
5. disassemble relevant paths;
6. map relation to P2 `0x9A8CD` and P3 `0xA1573`;
7. inspect `MTLSimCompiler::validSimulatorMetadata` only if supported by current binary evidence;
8. classify whether P2b is the next measured causal adapter.

D97HW is read-only: no Root Patch, Restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot.

## Final reconciliation classification
`FULL_CHECKPOINT_CORPUS_REVIEW=COMPLETE_THROUGH_D97HV`
`PERMANENT_RECONCILIATION=COMPLETE`
`AUTHORITATIVE_ACCEL_WINDOW=2026-09-08_14:24:02_TO_14:27:17_EEST`
`CURRENT_PATCH_STATE=P1_PLUS_P3_ONLY`
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`P2B=NOT_YET_AUTHORIZED`
`AIR00=NOT_AUTHORIZED`
`D34=NOT_AUTHORIZED`
`GUI=NEGATIVE_NO_USABLE_GUI`
`NEXT=D97HW_READONLY_STATIC_SIMULATOR_BITCODE_MAP`