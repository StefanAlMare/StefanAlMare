# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST — independent D97HV archive audit closed
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current authoritative checkpoint: `OCLP7_CHECKPOINT_20260908_D97HV_INDEPENDENT_ARCHIVE_AUDIT_PASS_D97HW_READY.md`.

This index preserves accepted causal milestones. Individual checkpoints remain authoritative for exact evidence and historical execution details. Stale historical `CURRENT ACTION`, stale boot-arg baselines, old execution-lane wording and later-invalidated automatic classifications are not current authority.

## End goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer `3/3/3`, stable real hardware acceleration and usable GUI.

The project repairs the earliest measured non-equivalent handoff in the Tahoe-native -> legacy compiler -> Haswell path, then advances to the next measured frontier. WindowServer is downstream evidence, not automatically root cause.

## Durable architecture / method
Current architecture:
`Tahoe-native Metal/Metal4 outer ABI -> bounded compatibility adapter(s) at measured frontier -> legacy compiler/backend lane -> Haswell driver -> compositor/image`.

Golden Sequoia immutable/read-only. No full legacy main-Metal shadow on Tahoe.

Historical accepted five-patch chain:
`P1 + P2b + P3 + AIR00 + D34`.

This is historical design evidence only. Current rule is measured-module-only; do not replay all five blindly.

P6/P7 runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap. Patch8 unauthorized unless explicitly promoted.

## Early compiler / provenance phases
Early Tahoe work identified the legacy service startup family later rediscovered in September:
`RIP=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.

The D97W->D97AD series established whole-stage/universal classification discipline and corrected multiple tooling false negatives. D97AH closed runtime provenance on the intended 32023 lane. Natural P7 still failed downstream, pushing the project toward producer/request-contract comparison rather than terminal suppressors.

Golden read-only work then established the XPC request schema, 3802/31001 selector semantics, and producer sources for `llvmVersion`, `requestType` and timeout. This produced the durable architecture principle: adapt the earliest non-equivalent contract, not the whole framework.

## OCLP base / Tahoe architecture
Exact upstream base pinned:
`b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

The broad `.dortania_developer` bypass was rejected. Exact-local-first 25G82 metallib handling was added.

Full legacy `13.2.1-24` main Metal on Tahoe was permanently rejected after userspace proved `_MTL4*` superclass/ABI incompatibility. The two attempted accelerated boots did not kernel panic; controlled userspace failure/shutdown was the real mechanism.

Permanent classification:
`FULL_LEGACY_MAIN_METAL_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## Shared-cache / selective ingress closure
The standalone/shared-cache investigation eliminated multiple incomplete loadability hypotheses and moved to a Lilu/shared-cache page route.

D97DR proved cross-process page propagation. D97DT proved the complete CAVE->SITE pair under VESA with exact postimages and Apple validation state. D97DX then became the native-Metal-safe Root Patch baseline.

## Exact set_id_mode frontier
After native-Metal-safe acceleration, framebuffer-count 1/1/1 was CLOSED NEGATIVE; 3/3/3 remained authoritative.

Persistent measurement proved:
- `mode=0x24` -> Apple success;
- `mode=0x224` -> extra exact bit `0x200` -> `kIOReturnBadArgument`.

D97EZ implemented only exact `0x224 -> 0x24`, not a global mask. D97FH proved adapted + passthrough success; later corrected-payload evidence expanded this to 58/58 successful routed calls.

Permanent classification:
`SET_ID_MODE_0x224_FRONTIER=CLOSED`.

## CoreDisplay / metallib frontier
After set_id_mode closure, failure moved into CoreDisplay GPUPass/render-pipeline construction. Static comparison found the mapped Tahoe GPUPass bootstrap recipe equivalent to Golden.

D97FU/FV/FW then exposed the actual systemic problem: all 180 dynamic metallib files in the old materialized local tree/installed root were metadata stubs rather than real MTLB payloads.

Exact package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MTLB; GPUPass present.

D97FX reconstructed the exact source. Restore removed the old stubs. Corrected Root Patch installed 180/180 real payloads and closed active-snapshot identity.

## Corrected metallibs move fatal frontier
Corrected-payload accelerated boots showed:
- old `validateWithDevice` / `MTLReportFailure` fatal mode absent;
- set_id_mode bad-bits absent;
- repeated MTLCompilerService failure interrupted WindowServer compiler XPC.

Thus metallib repair produced real semantic progress.

Optional `igfxfw`, `rps-control`, Max Pixel Clock Override were present in one run and absent in another while the compiler frontier persisted. Current minimal baseline keeps all three OFF.

## Missing P1 causal closure
Twelve MTLCompilerService IPS converged on the exact historical startup NULL-call signature.

Static audit proved:
- installed legacy service still recognized original selector 31001;
- runtime requests carried 32023;
- MTLCompiler32023 was exact Golden and exported all four required service entry points;
- missing-export theory NEGATIVE;
- P1 selector bridge MISSING PROVEN.

D97GR reconstructed exact P1 on a disposable copy:
- preimage `81fe19790000 @ 0x3494`;
- postimage `81fe177d0000`;
- exactly two changed bytes;
- post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Classification:
`NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

## P1-only build / runtime semantic progress
D97GS built exact P1-only on the D97DX base; D97GV independently audited it. Controlled Restore established a clean native state and Root Patch installed exact P1 + corrected metallibs.

D97HC/D97HD proved exact active P1 VESA state.

The P1-only accelerated experiment around `2026-09-08 03:35 +0300` proved:
- old NULL-call signature absent 9/9;
- new 9/9 MTLCompilerService crash family:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

This measured frontier selected P3, not P2b, as the next adapter.

## P3-only reconstruction/build/audit
Current MTLCompiler32023 retained original P2 bytes. P3 was reconstructed as exactly one byte:
- preimage `81e100002000 @ 0xA1573`;
- byte `0xA1574: e1 -> c9`;
- postimage `81c900002000`;
- P3-only SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.

D97HI/D97HN proved:
- P1 byte-identical;
- P3 sole new compiler functional delta;
- P2b absent;
- AIR00 absent;
- D34 absent.

D97HO wrapper ZIP:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

## OCLP 2.5.0/Nightly review
Official 2.5.0/current Nightly was reviewed. No measured MTLCompiler/GPUCompiler/Haswell frontier improvement relevant to this lane justified replacing the pinned custom chain. Do not substitute official/Nightly merely because the package is newer.

## P1+P3 Root Patch structural closure
After clean-native verification, exact D97HO Root Patch completed.

D97HS pre-reboot proved:
- exact P1;
- exact P3-only compiler;
- P2 original/no P2b;
- corrected metallibs 180/180;
- Haswell bundles/AuxKC;
- official helper exact.

D97HU later proved the active VESA recovery snapshot retains the exact P1+P3-only patched root.

D97HU structural state remains valid. Its earlier attribution of `14:25:*`/`14:26:*` events to VESA is superseded: those events belong to the immediately preceding accelerated boot.

## Authoritative P1+P3 accelerated experiment
Durable window:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Do not persist mutable labels such as penultimate/antepenultimate; use this explicit experiment window.

D97HV's original collector misparsed `kern.boottime` as 1970 and mixed historical IPS/log evidence, so its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` result is invalid tooling contamination.

Corrected timestamp rescope proved P3 runtime movement:
- old NULL-call current = 0;
- P1-only StringMap current = 0;
- current MTLCompilerService crash IPS = 0;
- new recurring simulator/bitcode diagnostic route is reached;
- compiler-service connection loss -> XPC interruption -> GPUPass/render-pipeline failure -> WindowServer restart -> no GUI.

`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

## D97HV independent archive audit — CLOSED PASS
User re-uploaded exact D97HV ZIP and it was independently opened byte-for-byte.

Canonical archive identity:
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`;
- 53 entries;
- ZIP CRC PASS.

The report listed 46 copied IPS payloads. Independent audit matched all 46 archived IPS by size and SHA256, mismatches `0`.

Independent raw-log rescope of `14:24:02 -> ~14:27:17` yields:
- 10911 bounded log lines;
- 12 WindowServer PIDs;
- 145 MTLCompilerService PIDs;
- all 145 peer-host mappings resolved;
- 144 compiler services = exactly 12 per each of 12 WindowServers;
- one compiler service belongs to SecurityAgent PID405;
- all 145/145 MTLCompilerService processes emit exactly one simulator diagnostic fragment and exactly one bitcode fragment;
- `validateWithDevice=0`;
- `MTLReportFailure=0`;
- bad-bits=0;
- StringMap/current post-P1 family=0;
- 132 exact compiler interruption retry lines, try1/2/3/4 each exactly 33;
- 21 MTLCompilerService IPS in archive are all historical by captureTime; current MTL IPS = 0;
- six WindowServer IPS are current and confirm CopyPipelineState / COREANIMATION XPC-pipeline abort families plus GPUCompiler32023 and Haswell MTL driver images.

Exact service termination mechanism is still UNKNOWN because there is no current MTLCompilerService IPS. Durable wording: service becomes inactive / compiler connection is lost.

Current causal chain:
`P1 + P3 serialized-bitcode path -> exhaustive recurring simulator/bitcode diagnostic route -> compiler-service connection loss / service inactive -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

## P2b decision
Historical P2b = request-layout adapter `+0xD0 -> +0x110 @ 0x9A8CD`.

After P3 moved execution into a serialized-bitcode/simulator-related route, P2b is plausible but remains:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

AIR00 and D34 remain unauthorized.

Exact validator/function is still UNKNOWN; do not call it `MTLSimCompiler::validSimulatorMetadata` until current static evidence proves that path.

## CURRENT ACTION — D97HW
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has not yet been executed.

It must:
1. pin exact active P1/P3 identities;
2. confirm P2 original and P3 exact;
3. recover full `simulator`/`bitcode` strings;
4. map file offsets/VAs/xrefs;
5. disassemble the relevant path;
6. map relation to P2 `0x9A8CD` and P3 `0xA1573`;
7. map `MTLSimCompiler::validSimulatorMetadata` only if the current binary supports it;
8. determine whether P2b is actually upstream/causal.

D97HW is read-only. No Root Patch, Restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot.

Because it binds exact active `/System/Library` files on Darwin x86_64 25G82, its execution is inherently ASUS2/live-state dependent unless byte-identical active binaries are supplied separately under audited identity.

## Current classification
`FULL_CHECKPOINT_CORPUS_REVIEW=COMPLETE_THROUGH_D97HV`
`PERMANENT_RECONCILIATION=COMPLETE`
`D97HV_ARCHIVE_INDEPENDENT_AUDIT=PASS`
`AUTHORITATIVE_ACCEL_WINDOW=2026-09-08_14:24:02_TO_14:27:17_EEST`
`CURRENT_PATCH_STATE=P1_PLUS_P3_ONLY`
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`P2B=NOT_YET_AUTHORIZED`
`AIR00=NOT_AUTHORIZED`
`D34=NOT_AUTHORIZED`
`GUI=NEGATIVE_NO_USABLE_GUI`
`NEXT=D97HW_READONLY_STATIC_SIMULATOR_BITCODE_MAP`.