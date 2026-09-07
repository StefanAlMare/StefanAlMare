# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime checkpoint: `OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`.
Current static-analysis checkpoint: `OCLP7_CHECKPOINT_20260907_D97FT_GPUPASS_BOOTSTRAP_EQUIVALENCE_AND_NATIVE_METAL_VALIDATION_CONTEXT_FRONTIER.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`. D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave protected. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired. Permanent method remains module-boundary + semantic evidence + far-frontier, with universal/no-PID coverage where requests vary.

## D97BV / D97DT — selective 3802 runtime closure
Selective true-3802 adapter semantics and runtime delivery CLOSED PASS under exact 25G82. Exact design postimages:
- CAVE `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`;
- SITE `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`.
Do not retest absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch PASS: native Tahoe main Metal authoritative; bounded legacy compiler/compatibility lanes; exact 25G82 metallib; Monterey GVA/OpenCL + Haswell drivers; no legacy main Metal shadow, MetalOld or true-five replay.

## D97DZ — post-Root-Patch shared-cache pristine gate
Immediately after D97DX under VESA, D97BV SITE and CAVE remained pristine:
- SITE exact original preimage `3d187d0000b9177d00000f4cc1`;
- CAVE exact zero preimage.
Thus D97DX itself did not write the D97BV SITE/CAVE modifications.

## D97EB / D97EE — framebuffer count negative
Normal 3/3/3 and isolated 1/1/1 both reached `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV. No panic, no `_MTL4*`; 1/1/1 CLOSED NEGATIVE, 3/3/3 authoritative.

## D97EG-D97EP — exact set_id_mode observer
Mapped exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` and established observe-only exact passthrough. D97EP VESA route PASS with zero calls as expected.

## D97EQ / D97ER — evidence transport gap
Accelerated failure reproduced; exact tuple unavailable from unified log/dmesg, reclassifying the problem as evidence transport.

## D97ES-D97EV — IORegistry tuple telemetry
D97ES 0.0.11 added first-eight post-original tuple capture while preserving exact passthrough. Independent build/EFI/VESA audits PASS.

## D97EW / D97EX — persistent accelerated evidence
Root LaunchDaemon collector persists OCLPMetalCompat evidence under `/Users/Shared/OCLP-D97EW-Capture`; live VESA persistence PASS.

## D97EY — exact tuple semantic proof
Accelerated run `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295` proved accepted `mode=0x24` / Apple `0` versus rejected `mode=0x224`, additional `0x200`, Apple `0xE00002C2 = kIOReturnBadArgument`. Meaning of `0x200` UNKNOWN; no global mask authorized.
Checkpoint commit `f2762e713565b1e72498241de639bdd5698c82c6`.

## D97EZ — exact-match handoff experiment
LATENT by default; ACTIVE only with `-ocmcd97ez`; exact `0x224 -> 0x24`; every other mode exact passthrough; unchanged `that/id`; one Apple call; exact return passthrough; global counters + original/passed first-eight telemetry.
Generator commit `cd76d912018bfa60284af3cb732ae8bca84db091`, blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

## D97FA / D97FB — build execution lane
GitHub Actions produced no runs and quota/execution remained blocked. User explicitly authorized compilation on home Intel iMac. Do not retry GitHub Actions compilation during this quota-limited period.

## D97FC / D97FD — local build + independent audit
Helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`, blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.
Returned build `OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`, bytes `154432`, SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`.
Independent audit PASS. D97EZ 0.0.12 x86_64 UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`, executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`, Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`.
D97FD commit `4cc0928f94f9d28bcb1b5b91660a221c570742c4`.

## D97FE / D97FF — deployment identity
User manually replaced EFI kext. Exact D97EZ 0.0.12 active-EFI identity verified before runtime boot.

## D97FG — LATENT VESA runtime PASS
Exact loaded identity PASS; `FunctionalMode=LATENT`; observer route PASS; zero set_id_mode calls/adaptations; publisher 300 ticks. D97FG commit `6c71ca6ead28321ac338323f96365208f1037f34`.

## D97FH — ACTIVE adapter semantic PASS / set_id_mode CLOSED
Persisted ACTIVE accelerated run `/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290`.
At stable 20 routed calls:
- exact-224 seen/adapted/succeeded 16/16/16, failures 0;
- other modes/passthrough succeeded 4/4, failures 0;
- exhaustive 16+4=20 PASS.
First-eight direct telemetry proves captured original `0x224` passed as `0x24` with Apple ret 0; original `0x24` passed unchanged with ret 0.
Thus exact adapter STRUCTURAL-SEMANTIC PASS and prior bad-bits rejection CLOSED PASS as measured causal blocker. End-to-end GUI still failed.
D97FH checkpoint commit `3b882d7428a010a48d4744f290ab97a9232d4b4e`.

## D97FI — downstream CoreDisplay/framebuffer localization
Read-only unified log after D97FH proved GPUWrangler/IntelAccelerator/3 framebuffer presence, fb0 online, DPCD readability, display0/AppleBacklightDisplay publication and CoreDisplay `GPU: FB: 3 of 3 opened`.

Observed negatives:
- `getPixelInformation for framebuffer 0 failed`;
- failed `IOFBGetDisplayModeInformation` mode lookup;
- `capabilities with no devices`;
- repeated main-display-offline CoreDisplay path -> WindowServer crash.

A later restart logged native Metal `validateWithDevice, line 5044: error '<private>'`. IOVersatile was classified non-discriminating because it also occurs in VESA.
D97FI checkpoint `6099a8b3a12fc69a115408c3e1ee11fc85e5fd95`; MASTER `bc4856b31fc3ecdbf6e157a3ad5c5ec6791aee18`.

## D97FJ — WindowServer IPS proves CoreDisplay Metal pipeline frontier
Returned crash archive:
`OCLP7_D97FI_WINDOWSERVER_IPS_20260907_172621.zip`
- bytes `17676`;
- SHA256 `cfec028c394362326e92b88097bb4eef40030967085a811f91e5c92ab863b793`.

Two WindowServer `.ips` reports share bootSessionUUID `48324BF1-0934-44C2-B2B9-A1208109B19E` and converge on `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState`.

Crash A:
- EXC_BAD_ACCESS/SIGSEGV, KERN_INVALID_ADDRESS at `0x18`;
- main thread stack begins `objc_msgSend +29 -> GetGPUPassRenderPipelineState +599 -> CreateMetalDevice +589 -> CoreDisplay display-device construction -> CoreDisplayManager::initialize`.

Crash B:
- EXC_CRASH/SIGABRT;
- main thread stack reaches `MTLReportFailure -> validateWithDevice(...)+716 -> MTLRenderPipelineDescriptorInternal validate -> MTLCompiler newRenderPipelineState... -> _MTLDevice newRenderPipelineState... -> GetGPUPassRenderPipelineState +1720 -> CreateMetalDevice -> same CoreDisplayManager path`.

Unified log corroborates:
- `GetGPUPassRenderPipelineState: 0x1000004e9 F_NymriCY`;
- `(Metal) validateWithDevice, line 5044: error '<private>'`.

Loaded userspace identities:
- legacy Haswell `AppleIntelHD5000GraphicsMTLDriver` 18.8.4 / UUID `d5cf0007-37a7-35cf-bb5e-a6baaa145ad2`;
- native CoreDisplay 291.4 / UUID `8bfeff75-c8c8-3b5b-afa0-61385199a1bb`;
- native SkyLight 1.600.0 / UUID `7b70d8df-984a-3fa9-829e-c26afc896d9d`;
- native Metal 373.7 / UUID `5d64fa80-29ce-32aa-bab6-4e5034132c0b`;
- GPUCompiler 32023 support libraries present.

D97FJ checkpoint commit `c3ef589e7f9ee8688dc6a08c9d4a488aec0fb8c1`.

## D97FK / D97FL / D97FM — cache-resident CoreDisplay discovery
D97FK standalone filesystem dump was INCONCLUSIVE because CoreDisplay/Metal are cache-resident on exact 25G82.
D97FL found the active `dyld_shared_cache_x86_64h` in Cryptex OS plus Apple `dsc_extractor.bundle`.
D97FM LLDB process-load route was blocked before CoreDisplay load; no further LLDB retries authorized.

## D97FN-D97FQ — audited Apple DSC extraction wrapper
Minimal wrapper around `dyld_shared_cache_extract_dylibs_progress` built on authorized Intel iMac after SDK/tool-path hardening.
Final audited x86_64 binary:
- SHA256 `04f0e1aa835f7dcafc3ccf989fe90bf3324b9d173824a7540d0232e9e7464bff`;
- UUID `213B833D-A864-3A3D-97E5-BB4AB8824033`;
- exact source lineage PASS;
- disassembly/dependency/code-sign audit PASS.
D97FQ checkpoint commit `864d4d4d19d54c2a18a6203b78ea03de7d9a2377`.

## D97FR — active cache signature mismatch vs valid Incoming
Apple extractor rejected active main cache at page 62590 due code-signature mismatch.
Direct comparison proved:
- active `Cryptexes/OS` cache signature invalid;
- same-sized `Cryptexes/Incoming/OS` cache valid;
- the first observed differing page is exact validator page 62590;
- Incoming therefore provides a pristine signature-valid 25G82 reference.
D97FR checkpoint commit `555dbb8fea4db84e7705613d3225f71fdb9427d9`.

## D97FS — exact active mutations map to native Metal and D97BV
Returned `OCLP7_D97FS_CACHE_MAP_20260907_195458.zip` direct audit:
- bytes `1525842`;
- SHA256 `f694969d4c9c4cb33ee8e1b0b1b28c4af0b01283da029fb3a4a9ce43a2f5aa52`;
- CRC PASS.

Active and Incoming cache headers/maps/atlases have identical layout. The two differing code regions map to native Tahoe `Metal.__TEXT`:
- CAVE `Metal+0x1560`;
- SITE `Metal+0x164719`.

Exact bytes prove ACTIVE CAVE/SITE are exact accepted D97BV postimages; Incoming contains the pristine zero/original preimages. D97DZ proved these bytes pristine after Root Patch; D97DT proved runtime OCLPMetalCompat mutation to exact postimages. Therefore the active signature failure is intentional D97BV runtime mutation, not corruption and not D97DX Root Patch writing these bytes.

D97FS checkpoint commit `f22b93fb0361d7333afaf689e43c3effd4ab0c42`.
D97BV remains CLOSED PASS.

## D97FT — exact Incoming CoreDisplay/Metal extraction and GPUPass map
Returned:
`OCLP7_D97FT_INCOMING_SELECTED_20260907_200933.zip`
- bytes `6829957`;
- SHA256 `937e77b54edd1741b9cb19b89142a98380e77ac74a2811a9f6f1e060b375018b`;
- CRC PASS.

Exact extracted identities:
- CoreDisplay x86_64 UUID `8BFEFF75-C8C8-3B5B-AFA0-61385199A1BB`, SHA256 `e8ca1d0b851143235aa2acb500bab5e8ca2d5dbb708647d135f9f8458d3d933f`;
- Metal x86_64 UUID `5D64FA80-29CE-32AA-BAB6-4E5034132C0B`, SHA256 `f9287f12f4ed6247d53cf322c468db96ed877abe54912c990f5697e916b45ec8`.
Both match the D97FJ crash images exactly.

`CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` starts `0x7FF80543D1B4`.
Crash offsets map:
- +599 `0x7FF80543D40B`;
- +636 `0x7FF80543D430`;
- +1720 `0x7FF80543D86C`.

Static flow proves two function constants -> specialized `GPUPass` -> descriptor construction -> vertexFunction -> GPUPass fragmentFunction -> color attachment 0 pixelFormat -> `newRenderPipelineStateWithDescriptor:error:`.

The +599/+636 crash mode is inside the NSError-report path after `newFunctionWithName:@"GPUPass" constantValues:... error:&error`; hence non-null NSError path is CONTROL-FLOW PROVEN for that captured mode. Exact error reason remains UNKNOWN.

Exact `CreateMetalDevice +589` tuple is:
`GetGPUPassRenderPipelineState(0xFFFFFFFF,0xFFFFFFFF,0x5E)`; `0x5E` is `MTLPixelFormatBGR10A2Unorm`.
Persisted Golden Sequoia CoreDisplay evidence uses the same tuple and descriptor recipe. Thus no Tahoe-only CoreDisplay bootstrap divergence is found in mapped scope.

Tahoe native Metal `validateWithDevice(...)` starts `0x7FF80F645727`. D97FJ `+716` is the return address immediately after `__MTLMessageContextEnd`, not an individual validation predicate. Therefore Metal accumulated one or more validation messages before context finalization/abort; exact predicate remains UNKNOWN.

Mapped validation families include function validity/device association/specialization and render-raster/device pixel-format/capability checks. Fragment nil alone is not statically sufficient to prove the validation error. BGR10A2 device renderability is only a candidate, not proven causal.

Exact 25G82 CoreDisplay `default.metallib` is already pinned in project evidence at SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d` and D97DX installed it, but no existing shader-level GPUPass AIR/metadata comparator was recovered.

D97FT checkpoint commit `c9ffb5f30458118c7c97725811f643e926c09802`.

## Current causal frontier
Closed/excluded for measured scope:
- `set_id_mode 0x224` rejection;
- D97BV delivery;
- Tahoe-only CoreDisplay GPUPass bootstrap tuple/descriptor divergence.

Earliest captured current negative:
`CoreDisplay -> newFunctionWithName:@"GPUPass" constants(-1,-1) -> non-null NSError path`.

Parallel downstream negative:
`GPUPass descriptor -> native Tahoe Metal validation accumulates error -> __MTLMessageContextEnd -> abort -> WindowServer death`.

Exact common semantic cause remains UNKNOWN.

## Current action
Remain in VESA. No reboot and no EFI/Root Patch/framebuffer/NVRAM/bootarg changes.
Statically inspect exact installed 25G82 `CoreDisplay.framework/Versions/A/Resources/default.metallib`, especially GPUPass: function presence/constants, target triple, AIR/Metal language/SDK metadata and other recoverable metadata. Compare to persisted/read-only Golden evidence if available. Only if this static boundary remains insufficient should a bounded runtime observer be designed.