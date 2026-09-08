# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST — D97HW GitHub Golden comparison prepared; execution trigger blocked
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current authoritative checkpoint: `OCLP7_CHECKPOINT_20260908_D97HW_GITHUB_GOLDEN_P3_COMPARE_SOURCE_READY_CI_TRIGGER_BLOCKED.md`.
Last runtime/archive checkpoint: `OCLP7_CHECKPOINT_20260908_D97HV_INDEPENDENT_ARCHIVE_AUDIT_PASS_D97HW_READY.md`.

This index preserves accepted causal milestones. Individual checkpoints remain authoritative for exact evidence and historical execution details. Stale historical CURRENT ACTION, boot-arg baselines, old execution-lane wording and later-invalidated automatic classifications are not current authority.

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
Golden read-only work then established the XPC request schema, 3802/31001 selector semantics, and producer sources for llvmVersion, requestType and timeout. This produced the durable architecture principle: adapt the earliest non-equivalent contract, not the whole framework.

## OCLP base / Tahoe architecture
Exact upstream base pinned:
`b9df76ebdf3e768b37c1cc980e8444aa837c623e`.
The broad .dortania_developer bypass was rejected. Exact-local-first 25G82 metallib handling was added.
Full legacy 13.2.1-24 main Metal on Tahoe was permanently rejected after userspace proved _MTL4* superclass/ABI incompatibility. The two attempted accelerated boots did not kernel panic; controlled userspace failure/shutdown was the real mechanism.
`FULL_LEGACY_MAIN_METAL_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## Shared-cache / selective ingress closure
The standalone/shared-cache investigation eliminated multiple incomplete loadability hypotheses and moved to a Lilu/shared-cache page route.
D97DR proved cross-process page propagation. D97DT proved the complete CAVE->SITE pair under VESA with exact postimages and Apple validation state. D97DX then became the native-Metal-safe Root Patch baseline.

## Exact set_id_mode frontier
After native-Metal-safe acceleration, framebuffer-count 1/1/1 was CLOSED NEGATIVE; 3/3/3 remained authoritative.
Persistent measurement proved:
- mode=0x24 -> Apple success;
- mode=0x224 -> extra exact bit 0x200 -> kIOReturnBadArgument.
D97EZ implemented only exact 0x224 -> 0x24, not a global mask. D97FH proved adapted + passthrough success; later corrected-payload evidence expanded this to 58/58 successful routed calls.
`SET_ID_MODE_0x224_FRONTIER=CLOSED`.

## CoreDisplay / metallib frontier
After set_id_mode closure, failure moved into CoreDisplay GPUPass/render-pipeline construction. Static comparison found the mapped Tahoe GPUPass bootstrap recipe equivalent to Golden.
D97FU/FV/FW exposed the systemic problem: all 180 dynamic metallib files in the old materialized local tree/installed root were metadata stubs rather than real MTLB payloads.
Exact package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.
Real CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MTLB; GPUPass present.
D97FX reconstructed exact source. Restore removed old stubs. Corrected Root Patch installed 180/180 real payloads and closed active-snapshot identity.

## Corrected metallibs move fatal frontier
Corrected-payload accelerated boots showed:
- old validateWithDevice / MTLReportFailure fatal mode absent;
- set_id_mode bad-bits absent;
- repeated MTLCompilerService failure interrupted WindowServer compiler XPC.
Thus metallib repair produced real semantic progress.
Optional igfxfw, rps-control, Max Pixel Clock Override were present in one run and absent in another while compiler frontier persisted. Current minimal baseline keeps all three OFF.

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
`NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

## P1-only build / runtime semantic progress
D97GS built exact P1-only on the D97DX base; D97GV independently audited it. Controlled Restore established clean native state and Root Patch installed exact P1 + corrected metallibs.
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
D97HI/D97HN proved P1 byte-identical, P3 sole new compiler functional delta, P2b/AIR00/D34 absent.
D97HO wrapper ZIP:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

## OCLP 2.5.0/Nightly review
Official 2.5.0/current Nightly was reviewed. No measured MTLCompiler/GPUCompiler/Haswell frontier improvement relevant to this lane justified replacing the pinned custom chain. Do not substitute official/Nightly merely because the package is newer.

## P1+P3 Root Patch structural closure
After clean-native verification, exact D97HO Root Patch completed.
D97HS pre-reboot proved exact P1, exact P3-only compiler, P2 original/no P2b, corrected metallibs 180/180, Haswell bundles/AuxKC and official helper exact.
D97HU later proved the active VESA recovery snapshot retains the exact P1+P3-only patched root.
D97HU structural state remains valid. Earlier attribution of 14:25/14:26 events to VESA is superseded: those events belong to the immediately preceding accelerated boot.

## Authoritative P1+P3 accelerated experiment
Durable window:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.
Do not persist mutable labels such as penultimate/antepenultimate; use the explicit experiment window.
D97HV's original collector misparsed kern.boottime as 1970 and mixed historical IPS/log evidence, so automatic P3_MIXED_CURRENT_BOOT_FRONTIER is invalid tooling contamination.
Corrected timestamp rescope proved P3 runtime movement:
- old NULL-call current = 0;
- P1-only StringMap current = 0;
- current MTLCompilerService crash IPS = 0;
- recurring simulator/bitcode diagnostic route reached;
- compiler-service connection loss -> XPC interruption -> GPUPass/render-pipeline failure -> WindowServer restart -> no GUI.
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

## D97HV independent archive audit — CLOSED PASS
User re-uploaded exact D97HV ZIP and it was independently opened byte-for-byte.
Canonical archive identity:
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`;
- 53 entries;
- ZIP CRC PASS.
The report listed 46 copied IPS payloads. Independent audit matched all 46 by size and SHA256, mismatches 0.
Independent raw-log rescope of 14:24:02 -> ~14:27:17 yields:
- 10911 bounded log lines;
- 12 WindowServer PIDs;
- 145 MTLCompilerService PIDs;
- all 145 peer-host mappings resolved;
- 144 compiler services = exactly 12 per each of 12 WindowServers;
- one compiler service belongs to SecurityAgent PID405;
- 145/145 emit exactly one simulator fragment and exactly one bitcode fragment;
- validateWithDevice=0, MTLReportFailure=0, bad-bits=0, StringMap/current post-P1 family=0;
- 132 exact compiler interruption retry lines, try1/2/3/4 each exactly 33;
- 21 MTLCompilerService IPS all historical by captureTime; current MTL IPS=0;
- six current WindowServer IPS confirm CopyPipelineState / COREANIMATION XPC-pipeline aborts, GPUCompiler32023 and Haswell MTL driver images.
Exact service termination mechanism remains UNKNOWN because there is no current MTLCompilerService IPS. Durable wording: service becomes inactive / compiler connection is lost.
Current chain:
`P1 + P3 serialized-bitcode path -> exhaustive recurring simulator/bitcode diagnostic route -> compiler-service connection loss / service inactive -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

## P2b decision
Historical P2b = request-layout adapter `+0xD0 -> +0x110 @ 0x9A8CD`.
After P3 moved execution into serialized-bitcode/simulator-related behavior, P2b is plausible but NOT_YET_AUTHORIZED.
AIR00 and D34 remain unauthorized.
Exact validator/function is UNKNOWN; do not call it MTLSimCompiler::validSimulatorMetadata until current evidence proves it.

## D97HW — transition to GitHub-first Golden/P3 static comparison
The old local D97HW mapper has no execution result. Following the user's Sequoia comparison request, the assistant found a remotely available original donor source:
- dortania/PatcherSupportPkg release 1.9.6;
- Universal-Binaries.dmg asset 332386253;
- metadata size 641964544;
- metadata SHA `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`, matching persisted project asset pin.
This is metadata/provenance, not a newly completed binary audit.

Published source/workflow head:
`56df870a781d9d9f20e4a8fdd3375ebc4c188e8e`.
Comparator: `OCLP-Continuity/artifacts/OCLP7_D97HW_GITHUB_GOLDEN_P3_STATIC_COMPARE.py`.
Workflow: `.github/workflows/oclp-d97hw-golden-p3-static-compare.yml`.
Name: `OCLP D97HW Golden vs P3 static comparison`.
Requested runner: macos-15-intel.

Intended GitHub gates reconstruct exact original/P1/P3 copies, verify all pinned hashes and original P2, then collect section-owned strings, symbols, disassembly and instruction-boundary RIP-relative xref candidates. Only text/JSON evidence is published; no donor executable is executed or redistributed by the job.

Important methodological correction: identical donor code does not prove the working Sequoia shader traverses the exact failing Tahoe branch. Data, route, dependency and runtime-context differences all remain possibilities. Static equality is not same-boundary Golden runtime proof, and P3 frontier movement alone does not validate all bitcode semantics.

## CURRENT ACTION — GitHub execution trigger blocked
Checkpoint: `OCLP7_CHECKPOINT_20260908_D97HW_GITHUB_GOLDEN_P3_COMPARE_SOURCE_READY_CI_TRIGGER_BLOCKED.md`, creation commit `3120d338f5b8088b753972543396a4d9edeb696a`.

After workflow publication, GitHub actions/runs returned total_count=0 for both the source head and repository inventory. The branch ref confirmed the files exist. The connector rejects the workflow endpoint with HTTP400 URL-not-allowed and exposes no workflow_dispatch action.

Observed classification:
`CI_TRIGGER_NOT_OBSERVED_AND_DIRECT_DISPATCH_UNAVAILABLE_IN_CURRENT_CONNECTOR`.
No run/job/artifact or executed CI validation exists. Do not attribute to quota, billing, disabled Actions or YAML without further evidence.

The smallest external unblock is GitHub Actions -> OCLP D97HW Golden vs P3 static comparison -> Run workflow -> main, when the UI permits it. Record any actual enablement/restriction message rather than guessing.
Then the assistant audits the actual run and artifact before causal interpretation.
Do NOT rerun the old local D97HW script as an implicit fallback. No ASUS2/Golden mutation, Root Patch or reboot is authorized.

## Current classification
`FULL_CHECKPOINT_CORPUS_REVIEW=COMPLETE_THROUGH_D97HV`
`PERMANENT_RECONCILIATION=COMPLETE`
`D97HV_ARCHIVE_INDEPENDENT_AUDIT=PASS`
`AUTHORITATIVE_ACCEL_WINDOW=2026-09-08_14:24:02_TO_14:27:17_EEST`
`CURRENT_PATCH_STATE=P1_PLUS_P3_ONLY`
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`D97HW_SOURCE_AND_WORKFLOW=PUBLISHED`
`D97HW_CI_EXECUTION=NOT_OBSERVED`
`D97HW_STATIC_COMPARISON_RESULT=NOT_OBTAINED`
`GOLDEN_SAME_BOUNDARY_RUNTIME_EQUIVALENCE=UNKNOWN`
`P2B=NOT_YET_AUTHORIZED`
`AIR00=NOT_AUTHORIZED`
`D34=NOT_AUTHORIZED`
`GUI=NEGATIVE_NO_USABLE_GUI`
`NEXT=UNBLOCK_D97HW_GITHUB_TRIGGER_THEN_AUDIT_RUN_AND_ARTIFACT`
