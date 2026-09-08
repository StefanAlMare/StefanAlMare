# OCLP7 CHECKPOINT — 2026-09-08 — D97HV full-corpus/permanent reconciliation / D97HW ready

## Purpose
This checkpoint is the post-audit reconciliation authority after re-reading the complete current checkpoint corpus through D97HV, including the 2026-09-08 OCLP 2.5.0/Nightly review and auxiliary correction checkpoints.

It does not represent a new accelerated boot, Root Patch, EFI/NVRAM change, or functional patch. It reconciles chronology, current state, evidence authority, and stale permanent documentation before D97HW.

## Full-corpus audit status
The checkpoint corpus present on the repository default branch has been reviewed through the latest functional checkpoint D97HV. No D97HW execution checkpoint exists yet. The repository contains the D97HW read-only static-map helper artifact, but D97HW has not been executed and no D97HW result may be inferred.

Historical checkpoints remain evidence for their own phase, but current-state wording in this reconciliation checkpoint plus MASTER supersedes stale `CURRENT ACTION`, stale boot-argument baselines, stale execution-lane wording, and earlier automatic classifications that later checkpoints explicitly invalidated.

## Target and current functional root
Target remains:
- macOS Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- framebuffer baseline `3/3/3`;
- end goal: stable real hardware acceleration and usable GUI.

Current intended patched root is exactly **P1 + P3 only**:
- P1 MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- P3-only MTLCompiler32023 SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- P2 remains original `418b81d0000000 @ 0x9A8CD`;
- P3 postimage `81c900002000 @ 0xA1573`;
- P2b inactive;
- AIR00 inactive;
- D34 inactive.

Corrected 25G82 metallib layer is exact `180/180`, with CoreDisplay metallib SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92`, bytes `20739`, direct `MTLB`.

D97HO wrapper artifact remains:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

## Proven compiler progression
### Corrected metallib progression
The real 25G82 metallib reconstruction closed the earlier CoreDisplay/native-Metal validation fatal frontier. The subsequent accelerated runs moved upstream to MTLCompilerService failure/XPC interruption. Therefore metallib repair is semantic progress, not cosmetic packaging work.

### P1
Before P1, the recurring compiler-service startup failure was:
`RIP=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Exact P1 removed that NULL indirect-call failure. In the P1-only accelerated boot around `2026-09-08 03:35 +0300`, 9/9 current MTLCompilerService crash reports moved to:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

Classification:
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

### P3
P3 was reconstructed as the exact measured one-byte compiler delta on top of P1. The P1+P3 artifact was independently audited with P1 preserved and no P2b/AIR00/D34 replay.

The authoritative accelerated P1+P3 experiment proves the prior StringMap crash family disappears and execution moves into a deterministic simulator/bitcode diagnostic path.

Classification:
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`
`P1_PLUS_P3_GUI=NEGATIVE_NO_USABLE_GUI`.

## Authoritative P1+P3 accelerated boot chronology
The user explicitly identified the accelerated/recovery ordering. Under the permanent VESA evidence rule this identification is authoritative.

Correct accelerated window:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Evidence:
- first accelerated WindowServer launch evidence `14:24:02.6523`;
- compiler/WindowServer restart loop through approximately `14:27:16.953`;
- recovery VESA WindowServer begins only around `14:28:38.955`;
- console login follows later.

Therefore WindowServer events and crash reports at `14:25:*` and `14:26:*` belong to the accelerated P1+P3 experiment, not to the later VESA recovery boot.

Any earlier D97HU wording that described the `14:25:56 -> 14:26:07` WindowServer compiler interruption as current-VESA/free runtime evidence is superseded on chronology only. D97HU's structural active-snapshot audit remains valid; only that runtime-event attribution is corrected.

Permanent evidence identity must use the explicit experiment/timestamp window, not mutable ordinal language such as "penultimate" or "antepenultimate" boot.

## D97HV collector defect and corrected interpretation
D97HV helper identity:
- Git blob `491a73071449a130bc1fdc4d48ad946e51d22ec0`.

D97HV evidence package reported by the collector:
- `OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_20260908_151239.zip`;
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`.

The collector parsed `kern.boottime` incorrectly and emitted a 1970 boot time. It therefore copied and automatically mixed:
- historical 2026-09-07 NULL-call MTLCompilerService IPS;
- historical P1-only 03:35 StringMap IPS;
- 14:24-14:27 P1+P3 WindowServer evidence;
- later logs.

Thus:
`D97HV_AUTOMATIC_P3_MIXED_CLASSIFICATION=INVALID_TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`.

Do not rerun or trust the as-is automatic current-boot classification from D97HV. Raw evidence remains useful after exact timestamp re-scoping.

The File Library exposure available during this reconciliation supplied the full D97HV collector transcript/package metadata, but did not expose the binary ZIP object itself for an independent archive-byte re-open. Therefore archive **identity is collector-reported and checkpoint-persisted**, while an independent re-open of the ZIP payload remains pending if the user re-uploads the exact ZIP. No technical conclusion in this checkpoint claims an independent second archive-byte audit.

## Corrected P1+P3 runtime evidence
Within `14:24:02 -> ~14:27:17`:
- 12 WindowServer processes;
- 145 MTLCompilerService launches;
- 0 current MTLCompilerService crash IPS;
- 0 current old NULL-call signature;
- 0 current post-P1 StringMap crash family.

All 145 compiler-service invocations reach the same recurring partially decoded diagnostic route with stable fragments including:
- `...upported in the simulator but <decode: mismatch for [%u] got [STRING sz:9]> were used`;
- `n bitcode.`

Exact missing string text remains UNKNOWN and must not be reconstructed from guesswork.

WindowServer then shows deterministic compiler connection loss:
- 132 `XPC_ERROR_CONNECTION_INTERRUPTED` retry lines;
- exact distribution: try1=33, try2=33, try3=33, try4=33;
- repeated GPUPass/render-pipeline failures;
- WindowServer abort/restart;
- no usable GUI.

Current measured causal chain:
`P1 + P3 serialized-bitcode path -> recurring MTLCompiler simulator/bitcode diagnostic -> compiler-service connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

Do not yet identify the current validator as `MTLSimCompiler::validSimulatorMetadata`; that symbol is historical directional evidence only until the active P3 binary's current path is statically proven.

## P2b decision
Historical P2b is the request-layout adapter `+0xD0 -> +0x110` at offset `0x9A8CD`.

P2b is now plausible because P3 moved execution into a serialized-bitcode/simulator-related frontier where request layout may be causal. However:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

AIR00 and D34 also remain unauthorized. No true-five replay is allowed merely because the old full chain once progressed farther.

## Upstream OCLP 2.5.0/Nightly decision
The 2026-09-08 review found official 2.5.0/current Nightly provided no measured MTLCompiler/Haswell/compiler-backend improvement over the pinned functional base relevant to this frontier. Do not replace the project app/assets with official 2.5.0/Nightly during this experiment solely because a newer package label exists.

## Execution responsibility
Permanent GitHub-first policy remains binding:
- assistant performs GitHub-eligible validation/integration/build/package/audit work in GitHub;
- ASUS2/user actions are limited to identity-pinned work inherently requiring installed/live target state;
- if GitHub-eligible work is blocked, stop and document blocker rather than silently compiling locally;
- local compilation requires explicit user authorization;
- Root Patch and reboot remain manual-only and separately authorized.

## Current action — D97HW
Artifact already present:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has **not yet been executed**.

D97HW must remain read-only and must:
1. pin exact active P1 and P3-only identities;
2. prove P2 is still original and P3 exact;
3. recover exact strings containing `simulator` / `bitcode` from active MTLCompiler32023;
4. map file offsets, virtual addresses and xrefs;
5. disassemble the relevant call paths;
6. map relation to P2 offset `0x9A8CD` and P3 offset `0xA1573`;
7. inspect `MTLSimCompiler::validSimulatorMetadata` only if current binary evidence supports it;
8. determine whether P2b is upstream/causal to the measured diagnostic;
9. perform no Root Patch/Restore/EFI/NVRAM/framebuffer mutation, no acceleration change and no reboot.

Because the existing helper binds exact active files under `/System/Library` on Darwin x86_64 25G82, execution is inherently ASUS2/live-state dependent unless an independently proven byte-identical active binary is made available remotely.

## Current classification
`FULL_CHECKPOINT_CORPUS_REVIEW=COMPLETE_THROUGH_D97HV`
`PERMANENT_RECONCILIATION=REQUIRED_AND_AUTHORIZED`
`AUTHORITATIVE_ACCEL_WINDOW=2026-09-08_14:24:02_TO_14:27:17_EEST`
`P1=PROVEN_ACTIVE_EXPERIMENT_DELTA`
`P3=PROVEN_SEMANTIC_PROGRESS`
`P2B=NOT_YET_AUTHORIZED`
`AIR00=NOT_AUTHORIZED`
`D34=NOT_AUTHORIZED`
`GUI=NEGATIVE_NO_USABLE_GUI`
`NEXT=D97HW_READONLY_STATIC_SIMULATOR_BITCODE_MAP`
