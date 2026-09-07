# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`

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

Current Root Patch execution checkpoint:
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
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext remains audited D97EZ `OCLPMetalCompat.kext` 0.0.12;
- loaded/runtime UUID when tested: `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- D97EW persistent collector remains installed and proven LIVE/PASS;
- normal framebuffer baseline remains 3/3/3;
- current session is VESA recovery after the D97FH ACTIVE accelerated experiment;
- recovery state has active `-igfxvesa` and absent/inert `-ocmcd97ez`;
- no new T2/Haswell boot variable is authorized;
- no Root Patch change is authorized.

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
- D97DX native-Metal-safe Root Patch is PASS.
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

`IOVersatile` failure is currently NON-DISCRIMINATING because it also appears in usable VESA.

## D97FJ — exact WindowServer IPS fatal frontier
Archive:
`OCLP7_D97FI_WINDOWSERVER_IPS_20260907_172621.zip`
- bytes `17676`;
- SHA256 `cfec028c394362326e92b88097bb4eef40030967085a811f91e5c92ab863b793`.

Two relevant WindowServer `.ips` reports share bootSessionUUID `48324BF1-0934-44C2-B2B9-A1208109B19E` and converge on the same CoreDisplay function.

Crash A:
- `EXC_BAD_ACCESS / SIGSEGV`, invalid address `0x18`;
- faulting main thread;
- `objc_msgSend +29`
-> `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState(...) const +599`
-> `CoreDisplay::CreateMetalDevice +589`
-> display-device construction
-> `CoreDisplayManager::initialize`.

Crash B:
- `EXC_CRASH / SIGABRT`;
- faulting main thread;
- `MTLReportFailure`
-> `_MTLMessageContextEndNewNSErrorOrAbort`
-> `validateWithDevice(id<MTLDevice>, MTLRenderPipelineDescriptorPrivate const&) +716`
-> render-pipeline descriptor validation/compiler methods
-> `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState(...) const +1720`
-> same display-device/CoreDisplayManager path.

Unified log in the same accelerated run records:
- `GetGPUPassRenderPipelineState: 0x1000004e9 F_NymriCY`;
- `(Metal) validateWithDevice, line 5044: error '<private>'`.

Loaded relevant identities:
- legacy `AppleIntelHD5000GraphicsMTLDriver` 18.8.4 / UUID `d5cf0007-37a7-35cf-bb5e-a6baaa145ad2`;
- native Tahoe `CoreDisplay` 291.4 / UUID `8bfeff75-c8c8-3b5b-afa0-61385199a1bb`;
- native Tahoe `SkyLight` 1.600.0 / UUID `7b70d8df-984a-3fa9-829e-c26afc896d9d`;
- native Tahoe `Metal` 373.7 / UUID `5d64fa80-29ce-32aa-bab6-4e5034132c0b` in the explicit validation-abort report;
- GPUCompiler 32023 support libraries present.

Therefore the strongest fatal frontier is no longer generic framebuffer metadata. It is:
`CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline/device validation`.

Classification:
- fatal CoreDisplay GPU-pass pipeline frontier REACHED_NEGATIVE;
- native Metal `validateWithDevice` abort REACHED_NEGATIVE;
- exact incompatible descriptor field/device capability UNKNOWN;
- `getPixelInformation` remains real but primary causal status UNPROVEN;
- IOVersatile primary causal status UNPROVEN/NON-DISCRIMINATING.

## Current causal frontier
Closed:
`Tahoe 0x224 -> legacy IOAccelSurface bad-bits rejection`.

Current:
`successful set_id_mode -> CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline/device validation -> WindowServer fatal failure -> main display offline`.

## Execution-lane authority
User explicitly authorized local compilation on the home Intel iMac because GitHub Actions quota/execution is blocked. Do not retry GitHub Actions compilation during the current quota-limited period.

## CURRENT ACTION — STATIC/READ-ONLY CORE DISPLAY MAPPING
Remain in VESA. No reboot and no changes to EFI, Root Patch, framebuffer counts, NVRAM or boot variables.

Map exact 25G82 `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` around offsets `+599` and `+1720`, plus strings around `F_NymriCY`, using the installed binaries. Determine, if statically recoverable, the descriptor property or device query immediately preceding native `validateWithDevice`.

Do not repeat ACTIVE acceleration until this static boundary is resolved and a bounded observer/adapter is designed.