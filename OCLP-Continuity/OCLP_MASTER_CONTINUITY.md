# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`

Current authoritative static/materialization checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FY_FINAL_PRE_ROOTPATCH_GATE_PASS_CORRECTED_METALLIB_SOURCE.md`

Previous source-reconstruction checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FX_SOURCE_RECONSTRUCTION_PASS_ROOTPATCH_PREFLIGHT_NEXT.md`

Previous causal-materialization checkpoints:
- `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FV_REAL_COREDISPLAY_METALLIB_RECOVERED_INSTALLED_STUB_PRIMARY_CAUSAL_CANDIDATE.md`
- D97FW global metallib audit checkpoint commit `41df9c6582227c61e8bfb2e99bf8469829db4830`.

Previous exact GPUPass static checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FT_GPUPASS_BOOTSTRAP_EQUIVALENCE_AND_NATIVE_METAL_VALIDATION_CONTEXT_FRONTIER.md`

Previous active-cache static checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FS_ACTIVE_METAL_BYTES_EXACT_D97BV_RUNTIME_POSTIMAGES_INCOMING_PRISTINE_REFERENCE.md`

Previous downstream-localization checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FI_CORE_DISPLAY_OFFLINE_CRASH_LOOP_FRAMEBUFFER_METADATA_FRONTIER.md`

Previous decisive adapter checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FH_SET_ID_MODE_ADAPTER_SEMANTIC_PASS_NEW_DOWNSTREAM_FRONTIER.md`

Previous LATENT VESA gate:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FG_D97EZ_LATENT_VESA_RUNTIME_PASS_ACTIVE_ACCEL_AUTHORIZED.md`

Current independent build-audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT_PASS_VESA_DEPLOY_AUTHORIZED.md`

Original exact tuple semantic checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EY_EXACT_SET_ID_MODE_TUPLE_SEMANTIC_PROOF.md`

Current Root Patch execution checkpoint remains the prior invalid-payload run until a corrected-payload Root Patch is executed:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

## Current D97EZ authority
Design:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_DESIGN.md`

Generator:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py`
- commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

Audited local Intel-iMac build helper:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_IMAC_BUILD.sh`
- helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`;
- Git blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.

Audited D97EZ build:
- archive `OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`;
- bytes `154432`;
- ZIP SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`;
- generated source SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`;
- version `0.0.12` x86_64;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

D97FD independently proved ZIP/package/lineage/source/build/Mach-O/disassembly integrity PASS.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- prior D97DX Root Patch remains installed, but its 25G82 metallib layer is now proven semantically invalid because it installed metadata stubs rather than real MetalLib payloads;
- active EFI kext remains audited D97EZ `OCLPMetalCompat.kext` 0.0.12;
- loaded/runtime UUID when tested: `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- D97EW persistent collector remains installed and proven LIVE/PASS;
- normal framebuffer baseline remains 3/3/3;
- current session is VESA recovery after the D97FH ACTIVE accelerated experiment;
- recovery state has active `-igfxvesa`, `-ocmcdiag`, `-ocmcd97bv`, and absent/inert `-ocmcd97ez`;
- active native Metal shared-cache SITE/CAVE may contain D97BV runtime postimages after the relevant pages are validated/mapped;
- signature-valid pristine 25G82 shared-cache reference exists at `Cryptexes/Incoming/OS/.../dyld_shared_cache_x86_64h`;
- exact CoreDisplay and native Metal images extracted from Incoming match D97FJ IPS UUIDs;
- exact original MetallibSupportPkg is present at `/Users/alex/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg`, bytes `116574513`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- corrected local source tree exists at `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82` and is exact to the package payload for all regular files;
- D97FX/D97FY prove `180/180` regular `.metallib` payloads exact and all local metallib magic values `MTLB`;
- corrected CoreDisplay default.metallib is 20739 bytes, MetalLib 1.2.7, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- prior stub source tree is preserved at `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82.D97FX_STUB_BACKUP_20260907_212451`;
- installed root still contains exactly the old `180/180` metadata-stub metallib layer until the APFS revert/corrected Root Patch sequence is completed;
- exact D97DX outer app remains `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97DX.app` with exact inner/helper/source identities PASS;
- official privileged helper SHA/team identity remains PASS;
- no new T2/Haswell boot variable is authorized.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Functional baseline and permanent method
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave `0xEF8..0xEFE` remains protected. D50/D68/D82 remain reserve-only; D84 retired. Golden Sequoia remains immutable/read-only.

Module-boundary + semantic evidence + far-frontier methodology remains mandatory. Universal/no-PID coverage is required when requests vary. Control-flow success is never semantic proof by itself.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no true-five reapplication;
- no global functional masking of `set_id_mode` bits;
- no semantic claim for bit `0x200` beyond measured evidence.

## Settled architecture
- D97BV/D97DT selective true-3802 runtime delivery is CLOSED PASS.
- D97DX native-Metal-safe patch policy/driver/compiler architecture remains accepted, but the previously installed metallib bytes are reclassified INVALID because the source tree contained metadata stubs.
- D97EB/D97EE framebuffer-count tuning is CLOSED NEGATIVE; 3/3/3 authoritative.
- D97EG-D97EP exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` observer route and passthrough are CLOSED PASS for proven scope.
- D97ES/D97ET added first-eight tuple telemetry without mutation.
- D97EW/D97EX closed hard-recovery evidence transport.

## D97EY — pre-fix semantic failure proof
Accepted `mode=0x24` returned `0`; rejected `mode=0x224` carried extra `0x200` and returned `0xE00002C2 = kIOReturnBadArgument`. Semantic meaning of `0x200` remains UNKNOWN.

## D97EZ exact-match rule
LATENT unless `-ocmcd97ez` active. ACTIVE only translates exact `0x224 -> 0x24`; every other mode is exact passthrough; `that/id` unchanged; one Apple original call; exact Apple IOReturn returned unchanged.

## D97FG — LATENT VESA runtime PASS
Exact D97EZ 0.0.12 runtime identity PASS; functional mode LATENT; observer route PASS; zero set_id_mode calls/adaptations; publisher bounded 300 ticks.

## D97FH — ACTIVE exact adapter STRUCTURAL-SEMANTIC PASS
Persisted accelerated run `/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290` proved at stable 20 calls:
- exact-224 seen/adapted/succeeded `16/16/16`, failures `0`;
- other-mode seen/passthrough succeeded `4/4`, failures `0`;
- exhaustive `16+4=20` classification PASS;
- first-eight telemetry shows captured `0x224` passed as `0x24` and Apple returned `0`.

Thus prior `Surface mode contains bad bits` rejection is CLOSED PASS as a causal blocker for this measured path. End-to-end GUI remains unproven.

## D97FI — downstream progress before IPS
Read-only unified log proved:
- GPUWrangler sees `8086:0412` and `/IntelAccelerator`;
- AppleIntelFramebuffer@0/@1/@2 exist;
- fb0 is online; internal DPCD is readable;
- `display0` and `AppleBacklightDisplay` publish;
- CoreDisplay reaches `GPU: FB: 3 of 3 opened`.

Observed negatives include:
- `IOAccelDisplayPipe::init_framebuffer_resource(...): getPixelInformation for framebuffer 0 failed`;
- `IOFBSetDisplayModeAndDepth: Failed to obtain mode info from IOFBGetDisplayModeInformation()`;
- `Attempting to get capabilities from capabilities with no devices`;
- repeated main-display-offline path followed by WindowServer crash.

`IOVersatile` failure remains NON-DISCRIMINATING because it also appears in usable VESA.

## D97FJ / D97FT — exact CoreDisplay GPUPass fatal localization
D97FJ WindowServer crashes converged on `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` and native Metal render-pipeline validation.
D97FT then proved:
- exact 25G82 CoreDisplay/Metal identities from pristine Incoming;
- GPUPass static recipe;
- exact bootstrap tuple `0xFFFFFFFF / 0xFFFFFFFF / 0x5E`;
- same mapped bootstrap recipe in working Golden;
- Crash A is in the post-`newFunctionWithName:@"GPUPass" ... error:` error-report path;
- Crash B reaches Metal validation-context finalization/abort;
- `validateWithDevice +716` is not itself a unique predicate.

## D97FR / D97FS — active cache mutation explained
The active x86_64h cache signature mismatch is exactly the intentional D97BV SITE/CAVE text mutation in native Metal, not corruption and not D97DX Root Patch writing those bytes. D97BV remains CLOSED PASS.

## D97FV — real CoreDisplay metallib recovered
Exact original 25G82 package contains a valid binary CoreDisplay `default.metallib`:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MetalLib 1.2.7 / `MTLB` magic;
- contains `GPUPass` with function constants `availableFeatures` index 0 and `optionalFeatures` index 1, both type code `0x21`;
- compiler metadata includes Apple metal `32023.886`, AIR `32023.883`, target `air64_v26-apple-macosx14.0.0`.

Installed/root and old local source copies of that path were instead 319-byte ASCII metadata stubs. CoreDisplay statically loads that exact path with `newLibraryWithFile:error:`. Therefore invalid metallib materialization became the primary common causal candidate for both D97FJ crash modes.

## D97FW — global metallib materialization failure proven
Global package-vs-local-vs-installed audit proved:
- real regular `.metallib` total `180`;
- local exact `0`;
- local metadata stubs `180`;
- local stub declared-size match `180/180`;
- installed exact `0`;
- installed metadata stubs `180`.

Therefore the failure is systemic across the 25G82 metallib layer, not isolated to CoreDisplay.

## D97FX — exact source reconstruction PASS
D97FX reconstructed the full local 25G82 source tree from the exact original package using a staged full-tree identity check and atomic swap with rollback support.

Final proof:
- stage regular files `181`;
- stage symlinks `0`;
- stage real metallibs `180`;
- `D97FX_STAGE_FULL_TREE_IDENTITY=PASS`;
- `D97FX_POSTSWAP_METALLIB_EXACT=180`;
- `D97FX_POSTSWAP_FULL_TREE_IDENTITY=PASS`;
- corrected CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- corrected CoreDisplay bytes `20739`;
- corrected type `MetalLib executable (MacOS), version 1.2.7`;
- no Root Patch, root-volume mutation, EFI mutation, NVRAM mutation or reboot occurred.

## D97FY — final pre-Root-Patch gate PASS
D97FY revalidated the full corrected-source and execution boundary immediately before remediation:
- system `26.6.2 / 25G82`, x86_64;
- VESA active with `-igfxvesa -ocmcdiag -ocmcd97bv` and D97EZ ACTIVE mode absent/inert;
- exact original package identity PASS;
- corrected local regular files `181` and real metallibs exact `180/180`;
- every corrected local metallib has `MTLB` magic;
- corrected CoreDisplay SHA PASS;
- installed root remains exactly `180` metadata stubs, zero exact/missing/other;
- exact D97DX app/helper/source identities PASS;
- patchdict closure PASS: `182 = 180` current exact MetallibSupportPkg entries + `2` unchanged `14.6.1` donors;
- official privileged helper SHA/team identity PASS;
- `D97FY_STATUS=PASS`.

D97FY checkpoint commit: `efe286948b322e41f9479f84b9e60027799dddf3`.

## Current causal frontier
The previous D97FJ userspace failure is now strongly explained by a proven upstream installation defect:
`invalid metadata-stub metallib layer -> CoreDisplay cannot obtain valid GPUPass library/function -> GPUPass specialization error path and/or invalid render-pipeline descriptor -> native Metal validation abort -> WindowServer death`.

Classification:
- invalid local source metallib layer: CLOSED PASS by D97FX/D97FY reconstruction and revalidation;
- invalid currently installed root metallib layer: REACHED_NEGATIVE / still present until APFS revert then corrected Root Patch;
- invalid metallib layer as D97FJ common cause: PRIMARY CAUSAL CANDIDATE STRONGLY SUPPORTED, runtime causal closure still pending one corrected-payload ACTIVE test;
- pure Tahoe-vs-Haswell GPUPass descriptor divergence is no longer the leading hypothesis.

## Execution-lane authority
User explicitly authorized local compilation on the home Intel iMac because GitHub Actions quota/execution is blocked. Do not retry GitHub Actions compilation during the current quota-limited period.

## CURRENT ACTION — MANUAL APFS ROOT-PATCH REVERT, THEN VESA REBOOT
D97FY authorizes the remediation sequence, but Root Patch and reboot remain manual user actions.

Do NOT chain Revert and corrected Root Patch in the same running snapshot.

Current authorized action:
1. Launch exact outer `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97DX.app`.
2. Run manual Root Patch Restore/Revert only.
3. After OCLP reports unpatch/revert complete, close the inner OCLP and allow the outer D97DX launcher to restore and verify the official privileged helper.
4. Reboot once into the same VESA configuration. This reboot is specifically authorized only to make the APFS snapshot revert effective.
5. After reboot, perform a read-only post-revert gate before any corrected Root Patch. The post-revert gate must prove the stubbed installed metallib layer is gone/restored and the corrected local source remains exact.
6. Only after that gate passes may the exact D97DX app be run again for corrected manual Root Patch.
7. After corrected Root Patch completes, do not reboot until post-patch payload identity is audited.

Still forbidden until the corrected post-patch audit passes:
- accelerated/non-VESA boot;
- removal of `-igfxvesa`;
- active `-ocmcd97ez`;
- EFI/NVRAM/framebuffer changes;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
