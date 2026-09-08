# OCLP PERMANENT PROJECT DATABASE — ASUS2 Tahoe Haswell

Updated: 2026-09-08 EEST — D97HW GitHub comparison prepared; trigger gate pending
Scope: every continuation of the ASUS2 Tahoe Haswell/OCLP project.
Purpose: durable consolidated technical state. Exact chronological evidence remains in MASTER, HISTORY, RETROSPECTIVE and checkpoint corpus. If current-state wording conflicts, the current checkpoint linked by MASTER wins.

## 1. End goal / target
Run macOS Tahoe `26.6.2 / 25G82` on ASUS2 with Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and a usable GUI.
Framebuffer baseline: `3/3/3`.
Optional iGPU tuning baseline remains OFF: igfxfw, rps-control, Max Pixel Clock Override.

## 2. Current architecture authority
`Tahoe-native Metal/Metal4 outer ABI -> bounded adapter(s) at measured incompatibility -> legacy compiler/backend lane -> Haswell driver -> compositor/image`.
Permanent constraints:
- preserve Tahoe native Metal4 ABI;
- never shadow cache-resident Tahoe Metal with full legacy main Metal;
- exact 25G82 MetallibSupportPkg handling;
- patch only earliest measured failed module;
- never replay historical true-five blindly;
- never spend Root Patch/recovery cycles recreating a known failed state without new causal information.
Full legacy main Metal on Tahoe is permanently NEGATIVE due _MTL4* ABI/superclass incompatibility, not a kernel-panic wall.

## 3. Golden / immutable authority
Golden Sequoia remains immutable/read-only and must not be booted or modified for evidence collection.
Persisted Golden invariants:
- MTLCompiler32023 SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- MTLCompiler3802 SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- original legacy MTLCompilerService SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- AppleIntelHD5000GraphicsMTLDriver SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.
Original selector contract: 3802 -> 3802 lane; 31001 -> 32023 lane.

## 4. Exact OCLP lineage / execution policy
Pinned functional base:
`b9df76ebdf3e768b37c1cc980e8444aa837c623e`.
Official helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team `S74BDJXQMD`.
Permanent execution split:
- GitHub-first for all technically GitHub-eligible validation/integration/build/package/audit;
- ASUS2/user only for identity-pinned live/installed/hardware actions;
- local compilation requires explicit authorization;
- never auto Root Patch or auto reboot.

## 5. Corrected 25G82 metallib authority — CLOSED PASS
Exact package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.
Exact local tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.
Current corrected layer: exact real metallibs 180/180, missing 0, different 0.
CoreDisplay real metallib:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- direct MTLB.
Old 180/180 metadata-stub materialization is permanently closed/repaired.
The repair removed the previous validateWithDevice / MTLReportFailure fatal mode and moved the frontier into compiler-service/XPC behavior.

## 6. set_id_mode / framebuffer closure
Exact measured behavior: 0x24 accepted; 0x224 rejected because of observed extra 0x200 class.
D97EZ adapts only exact 0x224 -> 0x24; all other modes passthrough. Later accelerated evidence accounted for 58/58 successes.
`SET_ID_MODE_0x224_FRONTIER=CLOSED`.
Framebuffer 1/1/1 = CLOSED NEGATIVE. Keep 3/3/3.

## 7. Historical five-patch chain — design evidence only
Historical chain:
`P1 + P2b + P3 + AIR00 + D34`.
Historical true-five SHA256:
`6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Current experiment does not have P2b/AIR00/D34 active.
P6/P7 runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized unless explicitly promoted.
D22 remains accepted AIR 2.6 / Metal 3.1 semantic evidence. D34 cave 0xEF8..0xEFE remains protected.

## 8. P1 — causal closure + runtime semantic progress
Pre-P1 recurring failure:
`RIP=0 / CR2=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.
Cause proven: service still recognized original selector 31001; runtime request was 32023; MTLCompiler32023 exports valid; P1 bridge missing.
Exact P1:
- preimage `81fe19790000 @ 0x3494`;
- postimage `81fe177d0000`;
- post-SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.
P1-only accelerated experiment around 2026-09-08 03:35 +0300 moved 9/9 current crashes to:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

## 9. P3 — current compiler delta + runtime semantic progress
Exact P3-only state:
- P2 original `418b81d0000000 @ 0x9A8CD`;
- P3 postimage `81c900002000 @ 0xA1573`;
- compiler SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- bytes `1636896`.
P3 is one-byte delta 0xA1574 e1 -> c9, independently audited as the only new compiler functional change on top of exact P1.

## 10. Current P1+P3 artifact/root chain — CLOSED PASS
D97HI source diff:
`c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.
D97HI inner executable:
`1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`.
D97HI inner ZIP:
- SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- bytes `722927108`.
D97HO wrapper ZIP:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.
D97HS proved underlying System volume exact P1+P3, P2 original/no P2b, metallibs 180/180, Haswell/AuxKC, helper exact. D97HU proved active recovery snapshot retains the same intended root.
Haswell loaded/unloaded/IOKit state under -igfxvesa is informational, not a gate.

## 11. Authoritative P1+P3 accelerated experiment
Durable window:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.
User boot identification is authoritative and timestamps corroborate it. Recovery VESA begins only around 14:28:38.955.
Never use mutable ordinal labels such as penultimate/antepenultimate for durable experiment identity.

## 12. D97HV independent archive audit — CLOSED PASS
Exact ZIP independently reopened after user re-upload:
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`;
- entries 53;
- ZIP CRC PASS.
Report contained 46 copied IPS identities; independent verification matched 46/46 size+SHA256, mismatches 0.
Independent raw-log analysis within 14:24:02 -> ~14:27:17:
- 10911 bounded log lines;
- 12 WindowServer PIDs;
- 145 MTLCompilerService PIDs;
- host mappings resolved 145/145;
- exactly 12 compiler services for each of 12 WindowServers = 144;
- one additional service belongs to SecurityAgent PID405;
- 145/145 emit one simulator fragment and one bitcode fragment;
- current validateWithDevice=0, MTLReportFailure=0, bad-bits=0, StringMap/post-P1 family=0;
- 132 interruption retry lines: try1=33, try2=33, try3=33, try4=33;
- 21 MTLCompilerService IPS all historical by captureTime; current-window MTL IPS=0;
- six current WindowServer IPS confirm CopyPipelineState / COREANIMATION XPC-pipeline aborts and load GPUCompiler32023 + Haswell MTLDriver.
D97HV_BOOT_UTC=1970 caused historical contamination. Automatic P3_MIXED_CURRENT_BOOT_FRONTIER is INVALID.
Exact service termination mechanism remains UNKNOWN; no current MTLCompilerService IPS exists. Durable wording: compiler service becomes inactive / connection is lost.
Current measured chain:
`P1 + P3 serialized-bitcode path -> exhaustive recurring simulator/bitcode diagnostic -> compiler-service connection loss/service inactive -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

## 13. P2b status and comparison limits
Historical P2b = `+0xD0 -> +0x110 @ 0x9A8CD`.
P2b is plausible but NOT_YET_AUTHORIZED. AIR00/D34 remain unauthorized.
Exact current validator remains UNKNOWN; do not call it MTLSimCompiler::validSimulatorMetadata until current evidence proves it.
Equal donor bytes are static identity, not proof that Sequoia traverses the same current Tahoe branch with a corresponding shader. Data, route, dependencies and context all require separation. P3 frontier movement alone does not prove all serialized-bitcode semantics valid.

## 14. Current system and CURRENT ACTION
Recorded target remains exact P1+P3-only, reachable via VESA recovery. GUI remains NEGATIVE.

D97HW now has a GitHub-first implementation, not a new target patch:
- comparator `OCLP-Continuity/artifacts/OCLP7_D97HW_GITHUB_GOLDEN_P3_STATIC_COMPARE.py`;
- workflow `.github/workflows/oclp-d97hw-golden-p3-static-compare.yml`;
- workflow name OCLP D97HW Golden vs P3 static comparison;
- source/workflow head `56df870a781d9d9f20e4a8fdd3375ebc4c188e8e`;
- requested runner macos-15-intel.

Remotely available PatcherSupportPkg 1.9.6 asset metadata matches exact historical package pin:
- Universal-Binaries.dmg, asset ID 332386253;
- declared bytes 641964544;
- declared SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`.
The new CI must verify downloaded bytes, reconstruct exact P1/P3 on disposable copies, and produce static strings/symbols/disassembly/xrefs without accessing Golden or ASUS2. Static output remains pending causal review.

CURRENT ACTION: unblock the GitHub execution trigger, then assistant audits actual run/job/artifact.
Observed: actions/runs returned total_count=0; source/workflow commit exists; connector rejects workflow endpoint GET with HTTP400 URL-not-allowed and has no workflow_dispatch action.
No job has been observed. This is not evidence of quota/billing/disabled Actions/YAML failure; cause is UNKNOWN.
The minimal web intervention is repository Actions -> OCLP D97HW Golden vs P3 static comparison -> Run workflow -> main, when available. Record any restriction message rather than guessing.

Current checkpoint:
`OCLP7_CHECKPOINT_20260908_D97HW_GITHUB_GOLDEN_P3_COMPARE_SOURCE_READY_CI_TRIGGER_BLOCKED.md`, creation commit `3120d338f5b8088b753972543396a4d9edeb696a`.

Old `OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh` remains historical, not a current local fallback. No ASUS2 commands, Root Patch, Restore, EFI/NVRAM/framebuffer change, acceleration or reboot are authorized.
`D97HW_CI_EXECUTION=NOT_OBSERVED`
`D97HW_STATIC_COMPARISON_RESULT=NOT_OBTAINED`

## 15. Continuation startup order
Read in full:
1. OCLP_PERMANENT_WORKING_RULES.md;
2. OCLP_MASTER_CONTINUITY.md;
3. OCLP_PERMANENT_VESA_RECOVERY_RULE.md;
4. exact current checkpoint from MASTER;
5. OCLP_PROJECT_RETROSPECTIVE_20260827.md;
6. OCLP_HISTORY_INDEX.md.
Then resume exactly from CURRENT ACTION.
