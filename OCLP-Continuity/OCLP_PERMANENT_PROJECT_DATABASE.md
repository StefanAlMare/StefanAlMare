# OCLP PERMANENT PROJECT DATABASE — ASUS2 Tahoe Haswell

Updated: 2026-09-08 EEST — reconciled through D97HV
Scope: every continuation of the ASUS2 Tahoe Haswell/OCLP project.
Purpose: durable consolidated technical state. Exact chronological evidence remains in MASTER, HISTORY, RETROSPECTIVE and checkpoint corpus. If current-state wording conflicts, the newest authoritative checkpoint linked by MASTER wins. Permanent procedure is governed by `OCLP_PERMANENT_WORKING_RULES.md` and `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

---

## 1. End goal / target
Run macOS Tahoe `26.6.2 / 25G82` on ASUS2 with Intel Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and a usable GUI.

Framebuffer baseline: `3/3/3`.
Current optional iGPU tuning properties remain OFF:
- `igfxfw` OFF;
- `rps-control` OFF;
- Max Pixel Clock Override OFF.

---

## 2. Current architecture authority
Required architecture:
`Tahoe-native Metal/Metal4 outer ABI -> bounded adapter(s) at the measured incompatibility -> legacy compiler/backend lane -> Haswell driver -> compositor/image`.

Permanent architecture constraints:
- preserve Tahoe native Metal4 Objective-C ABI;
- never shadow cache-resident Tahoe Metal with full legacy `13.2.1-24/Versions/A/Metal`;
- keep exact 25G82 MetallibSupportPkg handling;
- patch only the earliest currently measured failed module;
- never replay historical P1+P2b+P3+AIR00+D34 blindly;
- do not spend Root Patch/recovery cycles recreating a historical failed state without new causal information.

The full legacy-main-Metal experiment is permanently NEGATIVE: Tahoe userspace reached WindowServer, then IOGPU Metal4 superclass resolution failed. It was not a kernel-panic wall.

---

## 3. Golden / immutable authority
Golden Sequoia remains immutable/read-only and must not be booted or modified to obtain new evidence.

Persisted Golden donor invariants:
- MTLCompiler32023 SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- MTLCompiler3802 SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- original legacy MTLCompilerService SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- AppleIntelFramebufferAzul SHA256 `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics SHA256 `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

Original service selector contract:
- request `3802 -> Versions/3802`;
- request `31001 -> Versions/32023`.

Persisted Golden request producer contract includes:
- `llvmVersion` from signed dword `[RBX+0x20]`;
- `requestType` from `[R13+0x08]`;
- timeout from `[R13+0x18]`;
- `[R13+0x70]` gates sandboxTokens.

---

## 4. Exact OCLP lineage / execution policy
Pinned functional source base:
- upstream `dortania/OpenCore-Legacy-Patcher`;
- commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Official privileged helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`.

Official OCLP 2.5.0/current Nightly was reviewed on 2026-09-08. It did not provide a measured MTLCompiler/GPUCompiler/Haswell-backend change relevant to the current frontier, so the project chain is not replaced merely because a newer official package exists.

Permanent execution split is GitHub-first:
- assistant performs technically GitHub-eligible validation/integration/build/package/audit work;
- ASUS2/user performs identity-pinned actions that inherently require installed/live target state;
- local compilation requires explicit user authorization;
- never auto Root Patch or auto reboot.

---

## 5. Exact 25G82 metallib authority — CLOSED PASS
Exact package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact local tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

D97FW proved the former local/installed dynamic metallib layer was systemically wrong: 180/180 metadata stubs.

D97FX->D97GH reconstructed and activated the correct layer:
- exact real metallibs `180/180`;
- missing `0`;
- different `0`.

CoreDisplay real metallib:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- direct `MTLB`.

The real metallib repair removed the former native-Metal `validateWithDevice` / `MTLReportFailure` fatal frontier and moved failure into MTLCompilerService/XPC. This is proven semantic progress.

---

## 6. Shared-cache/set_id_mode infrastructure — CLOSED where proven
The controlled Lilu/shared-cache page route and cross-process page propagation were proven before the current compiler lane.

Exact set_id_mode frontier:
- `0x24` accepted;
- `0x224` rejected;
- exact difference `0x200`.

D97EZ adapts only exact `0x224 -> 0x24`; all other modes passthrough. Runtime evidence later accounted for 58/58 calls with zero failures.

Permanent classification:
`SET_ID_MODE_0x224_FRONTIER=CLOSED`.

Framebuffer `1/1/1` experiment is CLOSED NEGATIVE. Keep `3/3/3`.

---

## 7. Historical five-patch chain — evidence, not active state
Historical chain:
1. P1 selector bridge;
2. P2b request-layout `+0xD0 -> +0x110`;
3. P3 serialized-bitcode;
4. AIR00 AIR 2.6 / Metal 3.1 fallback;
5. D34 semantic-equivalent reset.

Historical true-five SHA256:
`6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

D22 remains accepted semantic evidence for AIR 2.6 / Metal 3.1. D34 cave `0xEF8..0xEFE` remains protected.

Current experiment does **not** have P2b/AIR00/D34 active.

P6/P7 runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized unless a later authoritative checkpoint promotes it.

---

## 8. P1 — causal and runtime semantic progress PROVEN
Pre-P1 recurring MTLCompilerService failure:
`RIP=0 / CR2=0 / r15=32023 / MTLConnectionCtx::MTLConnectionCtx(int)+56`.

D97GP proved:
- installed legacy service still mapped original selector 31001, not 32023;
- MTLCompiler32023 itself was exact Golden and exported all four required MTLCodeGenService entrypoints;
- missing-export hypothesis NEGATIVE;
- missing P1 selector bridge PROVEN.

D97GR reconstructed exact P1:
- preimage `81fe19790000 @ 0x3494`;
- postimage `81fe177d0000`;
- exactly two changed bytes;
- P1 post-SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

P1-only accelerated boot around `2026-09-08 03:35 +0300` proved the NULL-call frontier disappeared. 9/9 current compiler crash reports moved to:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.

Classification:
`P1_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

---

## 9. P3 — current exact compiler delta and semantic progress PROVEN
D97HF matched the P1-only StringMap frontier to the historical pre-P3 boundary. Current P2 state was still original, so P2b was not selected first.

D97HG reconstructed exact P3-only on Golden-base MTLCompiler32023:
- P2 original `418b81d0000000 @ 0x9A8CD`;
- P3 preimage `81e100002000 @ 0xA1573`;
- one-byte change `0xA1574: e1 -> c9`;
- P3 postimage `81c900002000`;
- exact P3-only post-SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.

D97HI/D97HN independently proved:
- P1 preserved byte-identical;
- P3 sole new compiler functional delta;
- P2b absent;
- AIR00 absent;
- D34 absent.

---

## 10. Current P1+P3 artifact/root chain — CLOSED STRUCTURAL PASS
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

After controlled Revert/clean-native verification, D97HO Root Patch completed normally.

D97HS proved on underlying System volume before reboot:
- exact P1;
- exact P3-only MTLCompiler32023;
- P2 original/no P2b;
- corrected metallibs exact 180/180;
- Haswell bundles/new AuxKC;
- official helper exact.

D97HU proved the active recovery snapshot contains the same exact P1+P3-only root and corrected metallib layer.

Haswell loaded/unloaded/IOKit state under `-igfxvesa` is informational, not a gate: different VESA sessions have legitimately shown both loaded and unloaded states while AuxKC remained coherent.

---

## 11. Authoritative P1+P3 accelerated experiment
Do not identify this durable experiment by mutable ordinal language such as "penultimate" or "antepenultimate". Use its timestamped window.

Authoritative accelerated window:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

User boot identification is authoritative under the permanent VESA rule. Timestamp reconstruction confirms:
- first accelerated WindowServer evidence `14:24:02.6523`;
- compiler/WindowServer restart loop through ~`14:27:16.953`;
- recovery VESA WindowServer begins only ~`14:28:38.955`.

Therefore `14:25:*` and `14:26:*` WindowServer events are accelerated evidence, not VESA-recovery evidence.

Within the accelerated window:
- 12 WindowServer processes;
- 145 MTLCompilerService launches;
- 0 current MTLCompilerService crash IPS;
- 0 current old P1 NULL-call signature;
- 0 current P1-only StringMap SIGSEGV family;
- 145/145 compiler invocations reach a recurring simulator/bitcode diagnostic route;
- stable decoded fragments include `...upported in the simulator but ... were used` and `n bitcode.`;
- exact missing string text remains UNKNOWN and must not be invented;
- 132 `XPC_ERROR_CONNECTION_INTERRUPTED` retry lines, exactly 33 each for tries 1/2/3/4;
- repeated GPUPass/render-pipeline failure;
- WindowServer abort/restart;
- no usable GUI.

Current causal chain:
`P1 + P3 serialized-bitcode path -> simulator/bitcode diagnostic -> compiler-service connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

Classification:
`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_P1_PLUS_P3_ACCEL_EXPERIMENT`
`P1_PLUS_P3_GUI=NEGATIVE_NO_USABLE_GUI`.

Do not yet assert `MTLSimCompiler::validSimulatorMetadata`; current binary evidence must map that exact path first.

---

## 12. D97HV evidence package / tooling defect
D97HV helper Git blob:
`491a73071449a130bc1fdc4d48ad946e51d22ec0`.

Collector-produced ZIP metadata:
- filename `OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_20260908_151239.zip`;
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- bytes `5390949`.

D97HV parsed `kern.boottime` incorrectly and produced a 1970 start time. It therefore mixed historical 2026-09-07 NULL-call IPS, P1-only 03:35 StringMap IPS and current/recent WindowServer evidence.

Its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` result is invalid:
`D97HV_AUTOMATIC_CLASSIFICATION=TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`.

Raw evidence remains useful only after exact timestamp re-scoping to the authoritative accelerated window above.

During the 2026-09-08 permanent reconciliation, File Library exposed the full D97HV collector transcript/package metadata but not the binary ZIP object itself for an independent second archive-byte open. Therefore the ZIP identity above is collector-reported/checkpoint-persisted. Do not claim an independent second archive-byte audit unless the exact ZIP is re-uploaded and opened.

---

## 13. P2b status / current measured frontier
Historical P2b changes the request layout from `+0xD0` to `+0x110` at MTLCompiler offset `0x9A8CD`.

P2b did not move the pre-P3 StringMap crash in earlier historical A/B request-layout testing, so selecting P3 before P2b was correct.

Now that P3 has moved execution into a serialized-bitcode/simulator-related path, P2b is plausible. It remains:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

AIR00 and D34 remain unauthorized.

Required next decision method: map the exact current simulator/bitcode diagnostic/xref path first and determine whether P2b is upstream/causal.

---

## 14. Permanent runtime/VESA evidence discipline
After a no-GUI accelerated test, the user normally returns only after a hard recovery and VESA boot. Therefore the current/latest online session is often recovery, not the accelerated experiment.

Always:
- use explicit timestamped accelerated windows;
- use `last reboot` plus WindowServer/launchd/crash timing;
- accept user identification of accelerated vs VESA boot as authoritative;
- never mix recovery VESA logs into the preceding accelerated cohort;
- do not use mutable ordinal labels as durable identities.

---

## 15. CURRENT ACTION — D97HW read-only static simulator/bitcode map
Existing artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has not yet been executed and no D97HW result checkpoint exists.

It must:
1. pin exact active P1 and P3-only identities;
2. prove P2 remains original and P3 exact;
3. recover full active-binary strings containing `simulator` and `bitcode`;
4. map file offsets, VAs and xrefs;
5. disassemble relevant call paths;
6. map relation to P2 `0x9A8CD` and P3 `0xA1573`;
7. inspect `MTLSimCompiler::validSimulatorMetadata` only if current binary evidence supports it;
8. determine whether P2b is the next measured causal adapter;
9. make no Root Patch/Restore/EFI/NVRAM/framebuffer mutation, acceleration change or reboot.

The helper binds exact active `/System/Library` binaries on Darwin x86_64 25G82, so execution is inherently ASUS2/live-state dependent unless those exact active bytes are independently made available remotely.

Startup order for every continuation:
1. read permanent working rules;
2. read MASTER;
3. read permanent VESA rule;
4. read the exact current checkpoint linked by MASTER;
5. read retrospective;
6. read HISTORY;
7. resume exactly from `CURRENT ACTION`.