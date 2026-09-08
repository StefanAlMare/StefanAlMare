# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST — reconciled through D97HV
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current authoritative reconciliation checkpoint: `OCLP7_CHECKPOINT_20260908_D97HV_FULL_CORPUS_PERMANENT_RECONCILIATION_D97HW_READY.md`.

This index preserves accepted causal milestones. Individual checkpoints remain authoritative for exact evidence and historical execution details. Stale historical `CURRENT ACTION`, stale boot-arg baselines and later-invalidated automatic classifications are not current authority.

## End goal
Run Tahoe `26.6.2 / 25G82` on ASUS2 with Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and a usable GUI.

The objective is not to suppress the last visible WindowServer failure. The project repairs the earliest measured non-equivalent handoff in the Tahoe-native -> legacy compiler -> Haswell path and then advances to the next measured frontier.

## Durable architecture / method
Current architectural principle:
`Tahoe-native Metal/Metal4 outer ABI -> bounded compatibility adapter(s) at measured frontier -> legacy compiler/backend lane -> Haswell driver -> compositor/image`.

Golden Sequoia is immutable/read-only. The project does not shadow Tahoe's cache-resident native Metal with the full legacy main Metal framework.

Historical accepted five-functional-patch chain:
`P1 + P2b + P3 + AIR00 + D34`.

That chain is retained as design evidence only. Current rule: never replay all five blindly; reintroduce only the earliest patch whose causal necessity is measured in the current experiment.

P6/P7 runtime sufficiency remains NEGATIVE. D50/D68/D82 remain reserve-only. D84 is retired. D36-D44 are invalidated for D34 cave overlap. Patch8 is unauthorized unless a later authoritative checkpoint explicitly promotes it.

## Early compiler bridge history
Early Tahoe work repeatedly encountered the legacy MTLCompilerService startup signature later rediscovered in September:
- MTLCompilerService 263.8;
- `RIP=0`;
- `r15=32023`;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Historical P1/P2b/P3/AIR00/D34 moved execution substantially farther, eventually into a simulator-metadata-related lane. That late path is directional design evidence, not proof that the current P1+P3 frontier is the same function.

## D97W -> D97AD — whole-stage compiler classification discipline
The September diagnostic series established exhaustive/universal classification rules, corrected several tooling false negatives and proved that observed requests were selecting the 32023 compiler generation. It also demonstrated why file identity, cache identity and executed runtime text must be treated separately.

D97AD's terminal classifier was later recognized as perturbative diagnostic machinery rather than a production fix. The project therefore removed it and returned to the natural compiler flow.

## D97AH — runtime provenance closure
After packaging/tooling corrections, D97AH proved the intended 32023 runtime provenance across the observed cohort. This eliminated the hypothesis that an unseen alternate compiler generation was responsible for the late failures.

## D97AI/D97AJ -> D97AM — natural P7 flow
Static CFG analysis resolved the relevant late validator paths and showed that simply removing the artificial D97AD classifier did not restore GUI. Natural P7 still ended in compiler-XPC interruption and WindowServer failure.

This shifted the investigation from local terminal behavior to producer/request semantics and comparison with the known-working Golden path.

## D97AN -> D97AR — semantic-boundary methodology
The project distinguished static reachability from runtime reachability and recovered the late six-counter predicate structure without inventing unavailable runtime values. This phase hardened the permanent rule that a boundary is not GREEN merely because control flow reaches it; semantic payload must also be measured when possible.

## D97AT -> D97BC — Golden contract closure
Read-only Golden analysis established:
- the MTLCompilerService XPC request schema;
- the real donor dialect;
- the working Haswell -> compiler -> Metal compositor corridor;
- producer-side sources for `llvmVersion`, `requestType` and timeout;
- original selector semantics in the legacy service.

Key Golden producer facts retained:
- `llvmVersion` originates from `[RBX+0x20]` in the primary request builder;
- `requestType` originates from `[R13+0x08]`;
- original service selector recognizes 3802 and 31001, with 31001 selecting the 32023 lane.

This phase established the durable architecture: adapt the earliest non-equivalent contract rather than transplant an entire legacy framework.

## D97BE/D97BF/D97BG — exact OCLP lineage / Tahoe eligibility
The exact OCLP base `b9df76ebdf3e768b37c1cc980e8444aa837c623e` was pinned. Tahoe eligibility was separated from actual root-patch compatibility.

The broad `.dortania_developer` bypass was rejected because it changes more behavior than required. The project retained a target-specific Tahoe eligibility path instead of accepting a global developer-mode shortcut.

Temporary GitHub quota problems on 5 September created local-build exceptions in historical checkpoints. Those exceptions are superseded prospectively by the restored permanent GitHub-first policy; the historical results themselves remain valid.

## D97BH/D97BI — exact 25G82 metallib resolver problem
The local exact `26.6.2-25G82` MetallibSupportPkg existed, but the stock resolver order preferred an official manifest that lacked the Tahoe mapping and only used the local fallback after manifest failure.

The project therefore added exact-local-first handling and a Tahoe 25G82 map rather than treating the package as absent.

## D97BJ/D97BK — full legacy Metal on Tahoe rejected
D97BJ Root Patch itself completed, but the accelerated system did **not** kernel panic. Later evidence corrected the initial visual interpretation: Tahoe userspace reached WindowServer, then IOGPU Metal4 classes failed because the full legacy `13.2.1-24` Metal framework lacked the native Tahoe `_MTL4*` superclass surface. launchd subsequently performed controlled shutdown.

Permanent classification:
`FULL_LEGACY_MAIN_METAL_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

This permanently rejects shadowing the cache-resident native Tahoe Metal image with the legacy main Metal binary.

## D97BL -> D97BT — bounded hybrid / producer investigation
Static analysis separated the legacy MTLCompilerService/compiler payloads from the forbidden full main-Metal shadow. Tahoe's native request producer was then mapped, including the default generation accessor behavior that suppresses the Golden 3802 lane in normal current conditions.

This made clear that historical patches such as P1/P2b/P3 are compatibility adapters, not arbitrary binary hacks.

## D97BU -> D97CF — selective 3802 standalone reconstruction experiments
The project found no safe ordinary `__TEXT` cave and then identified executable intersection padding. Sparse/standalone reconstructions were used to test loadability without system mutation.

The sequence eliminated several incomplete explanations:
- raw sparse reconstruction layout problems;
- segment-read-only metadata mismatch;
- delayed dyld/tooling false positives;
- slide identity alone;
- duplicate-Metal loading alone.

The isolated image reached Objective-C image mapping and failed there, motivating a move away from treating standalone `dlopen` equivalence as the final delivery model.

## D97CH -> D97CN — Objective-C/shared-cache topology and Lilu route
Exact fault localization reached Objective-C image registration. Subsequent relocation/metadata analysis showed why a copied standalone cache image could not simply be treated like the shared-cache resident original.

The project then shifted to the Lilu/shared-cache page-route mechanism, where Apple-validated cache pages could be observed and later modified under controlled, minimal conditions.

## D97CO -> D97DR — runtime observer and cross-process propagation proof
A series of EFI kext/observer builds established:
- kext lifecycle and IOKit state channels;
- exact route/callback activation;
- controlled page-site/cave instrumentation;
- persistent state reporting;
- cross-process propagation of the modified cave page.

D97DR was the decisive proof that a cave postimage written through the shared-cache route is visible across processes, enabling a safe two-page site/cave design.

## D97DT — full VESA site/cave pair PASS
D97DT proved the complete CAVE -> SITE pair under VESA:
- one exact write per intended page;
- exact postimages;
- Apple page validation state `0xF`, untainted/non-NX;
- no unrelated page mutation.

This was the first fully validated functional route for bounded cache-page adaptation.

## D97DX/D97DY/D97DZ — native-Metal-safe Root Patch baseline
The D97DX line produced a Root Patch design that kept Tahoe's native main Metal safe from legacy shadowing. Independent artifact auditing and post-patch VESA checks proved the shared-cache pages remained Apple-identical until explicitly armed.

This became the clean functional base used by the later P1/P3 experiments.

## D97EA -> D97EY — CoreDisplay / exact set_id_mode frontier
The first legitimate accelerated test after the native-Metal-safe Root Patch reached a CoreDisplay/Haswell framebuffer-related failure. A temporary 1/1/1 framebuffer experiment was CLOSED NEGATIVE; 3/3/3 remained authoritative.

Persistent measurement then proved the exact semantic discrepancy:
- `mode=0x24` accepted;
- `mode=0x224` rejected with `kIOReturnBadArgument`;
- delta exactly `0x200`.

The project therefore designed an exact-only adapter `0x224 -> 0x24`, not a global mask.

## D97EZ -> D97FH — exact 0x224 adapter semantic closure
The exact adapter was built/audited and tested. D97FH proved semantic movement:
- adapted calls succeeded;
- passthrough calls succeeded;
- failure moved downstream.

Later corrected accelerated evidence expanded success to 58/58 total calls with no adapter failure.

Permanent classification:
`SET_ID_MODE_0x224_FRONTIER=CLOSED`.

## D97FI/D97FJ/D97FT — GPUPass/CoreDisplay frontier
After set_id_mode closure, IntelAccelerator/framebuffer/display initialization progressed farther. WindowServer failed around CoreDisplay Metal GPUPass pipeline creation.

Static mapping of the GPUPass bootstrap tuple/descriptor showed the native Tahoe producer recipe was structurally equivalent to the Golden recipe, so the project did not mutate the framebuffer tuple blindly.

## D97FU/D97FV/D97FW — systemic metallib materialization defect discovered
The installed/local dynamic metallib tree was found to contain metadata stubs rather than real compiled MTLB payloads.

Exact 25G82 package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

D97FW proved the defect was systemic: 180/180 old local/installed dynamic metallibs were invalid materializations.

## D97FX/D97FY/D97GA -> D97GH — corrected metallib closure
D97FX reconstructed the exact 25G82 local source. Restore removed the installed stub layer. Corrected Root Patch then installed exact real payloads.

D97GD/D97GE/D97GF/D97GH proved:
- 180/180 exact metallibs;
- Haswell userspace/AuxKC placement;
- active booted VESA snapshot contains the intended corrected payload;
- exact CoreDisplay real MTLB active.

This is a permanent closed result.

## D97GI/D97GL/D97GM — metallib repair moves fatal frontier
Corrected-payload accelerated runs showed:
- old CoreDisplay `validateWithDevice` / `MTLReportFailure` fatal signature absent;
- GPUPass still requested;
- repeated MTLCompilerService deaths interrupted WindowServer compiler XPC.

Thus metallib repair genuinely moved the causal frontier upstream into compiler service behavior.

## D97GO — optional iGPU baseline split
Two corrected-payload accelerated runs used different optional iGPU settings yet converged on the same compiler failure. Therefore optional `igfxfw`, `rps-control` and Max Pixel Clock Override are **OFF** in the current baseline until a usable image exists or a later measurement justifies changing them.

Any older HISTORY wording that left `igfxfw=2` or `rps-control=1` active is superseded.

## D97GN/D97GP/D97GR — NULL indirect-call cause closed as missing P1
Twelve compiler crash reports converged on:
- MTLCompilerService 263.8;
- `EXC_BAD_ACCESS/SIGSEGV` at address 0;
- `RIP=0 / CR2=0`;
- `r15=32023`;
- return from exact indirect `callq *0x8(%r14)` in `MTLConnectionCtx`.

Static identity then showed:
- legacy service still had original 31001 selector bytes;
- MTLCompiler32023 itself was exact Golden and exported all required service entry points;
- missing-export theory was negative;
- P1 selector bridge was absent.

D97GR reconstructed exact P1 on a disposable copy:
- preimage `81fe19790000 @ 0x3494`;
- postimage `81fe177d0000`;
- exactly two changed bytes;
- post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact historical P1 identity.

Classification:
`NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

## D97GS/D97GV -> D97HD — P1-only experiment prepared and activated
D97GS built exact P1-only on top of the native-Metal-safe D97DX base, with no P2b/P3/AIR00/D34 replay. D97GV independently audited the artifact.

A controlled Restore produced a clean native baseline; the official privileged helper was restored after an old DEBUG helper residual was discovered. Root Patch then installed exact P1 plus exact corrected metallibs and Haswell patches.

D97HC pre-reboot and D97HD post-reboot audits proved exact P1 and exact metallib 180/180 state on the active snapshot.

## D97EW live gate / first post-P1 acceleration
Persistent instrumentation was revalidated before the P1-only accelerated test. The P1-only boot around `2026-09-08 03:35 +0300` showed the old NULL call gone and 9/9 compiler crashes moved to:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor`.

Classification:
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

This measured failure selected P3 as the next patch candidate. P2b remained unneeded at that stage because its historical request-layout change had not moved the StringMap frontier when tested before P3.

## D97HG -> D97HN — exact P3-only reconstruction/build/audit
Current MTLCompiler32023 was proven to retain original P2 bytes. P3 was reconstructed as the exact one-byte serialized-bitcode delta and layered on exact P1.

D97HI/D97HN proved:
- P1 byte-identical;
- P3 sole new compiler functional delta;
- P2b absent;
- AIR00 absent;
- D34 absent;
- independent inner artifact audit PASS.

D97HO wrapper ZIP:
- SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

## OCLP 2.5.0/Nightly review — no target update
Official OCLP 2.5.0/current Nightly was reviewed at source/package level. The delta relevant to the newer release did not touch the measured MTLCompiler/GPUCompiler/Haswell compiler frontier. The current experiment therefore remains on its exact pinned custom chain; official/Nightly is not substituted merely because it is newer.

## D97HR/D97HO/D97HS/D97HU — P1+P3 root state closure
After clean-native verification, exact D97HO Root Patch completed.

D97HS proved the patched underlying System volume before reboot:
- exact P1;
- exact P3-only compiler;
- original P2/no P2b;
- exact P3 postimage;
- corrected metallibs 180/180;
- Haswell bundles/AuxKC;
- exact official helper.

D97HU proved the active recovery snapshot retains that exact P1+P3-only state.

D97HU structural state remains accepted. One runtime-attribution phrase from D97HU is superseded by the later boot chronology correction: the `14:25:*` and `14:26:*` WindowServer crashes belong to the accelerated experiment, not the recovery VESA boot.

## D97HV collector defect
D97HV helper blob:
`491a73071449a130bc1fdc4d48ad946e51d22ec0`.

Evidence package reported by the collector:
- `OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_20260908_151239.zip`;
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`.

The helper misparsed `kern.boottime` as 1970, causing historical crash-report/log contamination. Its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` classification is invalid.

Permanent classification:
`D97HV_AUTOMATIC_CLASSIFICATION=TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`.

Raw evidence is retained; interpretation must use exact reconstructed timestamps.

## Authoritative P1+P3 accelerated experiment — 2026-09-08 14:24:02 -> ~14:27:17
The user's boot identification is authoritative under the permanent recovery rule. Timestamp reconstruction confirms:
- first accelerated WindowServer evidence `14:24:02.6523`;
- compiler/WindowServer restart loop through ~`14:27:16.953`;
- recovery VESA WindowServer starts only ~`14:28:38.955`.

Therefore all `14:25:*` and `14:26:*` WindowServer crashes are accelerated evidence.

Within this window:
- 12 WindowServer processes;
- 145 MTLCompilerService launches;
- 0 current compiler crash IPS;
- 0 current old NULL-call signature;
- 0 current post-P1 StringMap crash family;
- 145/145 compiler invocations reach recurring simulator/bitcode diagnostic fragments;
- exact missing wording remains UNKNOWN;
- 132 compiler-XPC interruption retry lines, 33 each for tries 1/2/3/4;
- GPUPass/render-pipeline failure follows;
- WindowServer abort/restart follows;
- GUI remains unusable.

Current causal chain:
`P1 + P3 serialized-bitcode path -> simulator/bitcode diagnostic -> MTLCompilerService connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

Classification:
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`
`GUI=NEGATIVE_NO_USABLE_GUI`.

Do not label the current path `MTLSimCompiler::validSimulatorMetadata` until current P3 binary evidence proves that exact symbol/path.

## P2b status now
Historical P2b adapts request layout `+0xD0 -> +0x110` at MTLCompiler offset `0x9A8CD`.

P3 has now moved execution into a serialized-bitcode/simulator-related frontier, so P2b is a plausible next candidate. It remains:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

The next step is static causal mapping, not another Root Patch/reboot.

## CURRENT ACTION — D97HW
Existing artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has not yet been executed and no D97HW result checkpoint exists.

Required D97HW result:
- exact P1/P3 binding;
- P2 original / P3 exact proof;
- exact full `simulator`/`bitcode` strings;
- Mach-O offsets/VAs/xrefs;
- relevant disassembly path;
- relation to P2 `0x9A8CD` and P3 `0xA1573`;
- `validSimulatorMetadata` considered only if supported by current binary evidence;
- classification of whether P2b is the next causal adapter.

No Root Patch, restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot during D97HW.

Because the helper binds exact active `/System/Library` files on Darwin x86_64 25G82, its execution is an identity-pinned ASUS2/live-state action under the permanent GitHub-first responsibility split.