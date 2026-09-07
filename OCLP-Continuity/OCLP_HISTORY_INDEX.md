# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`. D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave protected. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired. Permanent method remains module-boundary + semantic evidence + far-frontier, with universal/no-PID coverage where requests vary.

## D97BV / D97DT — selective 3802 runtime closure
Selective true-3802 adapter semantics and runtime delivery CLOSED PASS under exact 25G82. Do not retest absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch PASS: native Tahoe main Metal authoritative; bounded legacy compiler/compatibility lanes; exact 25G82 metallib; Monterey GVA/OpenCL + Haswell drivers; no legacy main Metal shadow, MetalOld or true-five replay.

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
- report SHA256 `3a90c0d19e0e928273cbb2d3d32d432d949ab61a3e8ee807584a704cccedc3cb`;
- EXC_BAD_ACCESS/SIGSEGV, KERN_INVALID_ADDRESS at `0x18`;
- main thread stack begins `objc_msgSend +29 -> GetGPUPassRenderPipelineState +599 -> CreateMetalDevice +589 -> CoreDisplay display-device construction -> CoreDisplayManager::initialize`.

Crash B:
- report SHA256 `6c27adc301ab3c9c1650ae02295c4c98f18e317e7d1424f1c20e250b3665f852`;
- EXC_CRASH/SIGABRT;
- main thread stack reaches `MTLReportFailure -> validateWithDevice(...)+716 -> MTLRenderPipelineDescriptorInternal validate -> MTLCompiler newRenderPipelineState... -> _MTLDevice newRenderPipelineState... -> GetGPUPassRenderPipelineState +1720 -> CreateMetalDevice -> same CoreDisplayManager path`.

Unified log corroborates:
- `GetGPUPassRenderPipelineState: 0x1000004e9 F_NymriCY`;
- `(Metal) validateWithDevice, line 5044: error '<private>'`.

Loaded userspace identities:
- legacy Haswell `AppleIntelHD5000GraphicsMTLDriver` 18.8.4 / UUID `d5cf0007-37a7-35cf-bb5e-a6baaa145ad2`;
- native CoreDisplay 291.4 / UUID `8bfeff75-c8c8-3b5b-afa0-61385199a1bb`;
- native SkyLight 1.600.0 / UUID `7b70d8df-984a-3fa9-829e-c26afc896d9d`;
- native Metal 373.7 / UUID `5d64fa80-29ce-32aa-bab6-4e5034132c0b` in the validation-abort crash;
- GPUCompiler 32023 support libraries present.

Reclassification:
- `getPixelInformation` remains REACHED_NEGATIVE but primary cause UNPROVEN;
- strongest captured fatal boundary is now CoreDisplay GPU-pass render-pipeline construction/device validation;
- native Metal `validateWithDevice` is REACHED_NEGATIVE;
- exact descriptor field/device capability mismatch remains UNKNOWN;
- IOVersatile remains UNPROVEN/NON-DISCRIMINATING.

D97FJ checkpoint commit `c3ef589e7f9ee8688dc6a08c9d4a488aec0fb8c1`.
MASTER advance to D97FJ: `d6283656bd7875d55a283a677b2fef485e11079f`.

## Current causal frontier
Closed:
`Tahoe 0x224 -> legacy IOAccelSurface bad-bits rejection`.

Current:
`successful set_id_mode -> CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline/device validation -> WindowServer fatal failure -> main display offline`.

## Current action
Remain in VESA. No reboot and no EFI/Root Patch/framebuffer/NVRAM/bootarg changes.
Perform static/read-only mapping of exact 25G82 CoreDisplay around `GetGPUPassRenderPipelineState +599` and `+1720`, plus strings near `F_NymriCY`. Determine the descriptor property or device query immediately preceding native `validateWithDevice` if statically recoverable. Do not repeat ACTIVE boot before this boundary is mapped.