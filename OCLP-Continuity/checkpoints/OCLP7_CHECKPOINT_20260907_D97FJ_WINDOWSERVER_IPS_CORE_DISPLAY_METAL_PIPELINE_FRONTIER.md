# OCLP7 D97FJ — WindowServer IPS proves CoreDisplay Metal pipeline frontier

Date: 2026-09-07 EEST
Target: ASUS2 / Tahoe 26.6.2 (25G82) / Haswell 8086:0412 / MacBookAir6,2

## Input authority
D97FH closed the exact `IOAccelSurface::set_id_mode` bad-bits blocker for the measured path: 16/16 exact `0x224 -> 0x24` adaptations returned Apple success, plus 4/4 passthrough successes, zero failures. D97FI then localized the next runtime failure downstream in CoreDisplay/WindowServer after 3/3 framebuffer opening.

User returned archive:
`OCLP7_D97FI_WINDOWSERVER_IPS_20260907_172621.zip`
- bytes: `17676`
- SHA256: `cfec028c394362326e92b88097bb4eef40030967085a811f91e5c92ab863b793`

Archive contains two relevant WindowServer crash reports from the same boot session UUID:
`48324BF1-0934-44C2-B2B9-A1208109B19E`.

### Crash A
`WindowServer-2026-09-07-1451092.ips`
- bytes `35551`
- SHA256 `3a90c0d19e0e928273cbb2d3d32d432d949ab61a3e8ee807584a704cccedc3cb`
- incident `13BFAC67-1F29-40F7-A87F-DE829351A14C`
- pid `346`
- consecutiveCrashCount `1`
- exception: `EXC_BAD_ACCESS / SIGSEGV`
- subtype: `KERN_INVALID_ADDRESS at 0x18`
- faulting thread: `ws_main_thread` / main queue.

Exact top stack:
1. `objc_msgSend + 29`
2. `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState(unsigned int, unsigned int, unsigned long) const + 599`
3. `CoreDisplay::CreateMetalDevice(unsigned int) + 589`
4. `CoreDisplay_CreateDisplayForCGXDisplayDevice + 885`
5. `UpdateCGXDisplayDevice + 1011`
6. `AddCGXDisplayDeviceToDeviceList + 161`
7. `CGXDisplayDriverInitialize + 1710`
8. `WS::Displays::CoreDisplayManager::initialize() + 43`
9. `WSInitialize + 3956`
10. `SLXServer + 1016`.

The crash thread register state records `cr2=24`, matching the invalid access at `0x18`. This directly places the first captured fatal fault inside `GetGPUPassRenderPipelineState` while it is performing Objective-C dispatch.

### Crash B
`WindowServer-2026-09-07-145119.ips`
- bytes `36910`
- SHA256 `6c27adc301ab3c9c1650ae02295c4c98f18e317e7d1424f1c20e250b3665f852`
- incident `BAC5E04F-8DF8-4E65-8131-8FE923CBD5FC`
- pid `430`
- consecutiveCrashCount `4`
- exception: `EXC_CRASH / SIGABRT`
- faulting thread: `ws_main_thread` / main queue.

Exact top stack:
1. `__pthread_kill`
2. `pthread_kill`
3. `abort`
4. `__assert_rtn`
5. `MTLReportFailure.cold.1`
6. `MTLReportFailure`
7. `_MTLMessageContextEndNewNSErrorOrAbort(...)`
8. `validateWithDevice(id<MTLDevice>, MTLRenderPipelineDescriptorPrivate const&) + 716`
9. `-[MTLRenderPipelineDescriptorInternal validateWithDevice:error:] + 91`
10. `-[MTLCompiler newRenderPipelineStateWithDescriptorInternal:...] + 190`
11. `-[MTLCompiler newRenderPipelineStateWithDescriptorInternal:...] + 29`
12. `-[MTLCompiler newRenderPipelineStateWithDescriptor:...] + 27`
13. `-[_MTLDevice newRenderPipelineStateWithDescriptor:error:] + 65`
14. `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState(...) const + 1720`
15. `CoreDisplay::CreateMetalDevice(unsigned int) + 589`
16. `CoreDisplay_CreateDisplayForCGXDisplayDevice + 885`
17. `UpdateCGXDisplayDevice + 1011`
18. `AddCGXDisplayDeviceToDeviceList + 161`
19. `CGXDisplayDriverInitialize + 1710`
20. `WS::Displays::CoreDisplayManager::initialize() + 43`
21. `WSInitialize + 3956`
22. `SLXServer + 1016`.

Unified log for the same accelerated run records immediately before the corresponding crash:
- `GetGPUPassRenderPipelineState: 0x1000004e9 F_NymriCY`
- `(Metal) validateWithDevice, line 5044: error '<private>'`.

## Loaded graphics userspace identities from IPS
Both reports load the legacy Haswell driver:
- `AppleIntelHD5000GraphicsMTLDriver`
- CFBundleShortVersionString `18.8.4`
- CFBundleVersion `18.0.8`
- UUID `d5cf0007-37a7-35cf-bb5e-a6baaa145ad2`.

Relevant Tahoe system frameworks:
- `CoreDisplay` 291.4, UUID `8bfeff75-c8c8-3b5b-afa0-61385199a1bb`;
- `SkyLight` 1.600.0, UUID `7b70d8df-984a-3fa9-829e-c26afc896d9d`;
- in Crash B, native `Metal` 373.7, UUID `5d64fa80-29ce-32aa-bab6-4e5034132c0b`;
- GPUCompiler 32023 support libraries are present.

## Interpretation
The two independent crash modes converge on one common function: `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState`.

This materially narrows D97FI:
- `getPixelInformation for framebuffer 0 failed` is still a real REACHED_NEGATIVE event in the same pipeline, but it is no longer the strongest fatal frontier;
- the strongest directly captured fatal boundary is CoreDisplay GPU-pass render-pipeline construction/validation against the active Metal device;
- one restart crashes during Objective-C dispatch inside this function;
- another restart reaches explicit native Metal render-pipeline descriptor validation and aborts in `validateWithDevice`;
- both then prevent `CoreDisplayManager::initialize()` from completing and keep the main display offline.

This is not yet semantic proof of which exact descriptor field/device capability is incompatible. The private validation message remains redacted in unified logging.

## Classification
- `D97FJ_IPS_ARCHIVE_INTEGRITY=PASS`
- `D97FJ_SAME_BOOT_SESSION=PASS`
- `D97FJ_CORE_DISPLAY_METAL_PIPELINE_REACHED=PASS`
- `D97FJ_GET_GPU_PASS_RENDER_PIPELINE_FATAL_FRONTIER=REACHED_NEGATIVE`
- `D97FJ_NATIVE_METAL_VALIDATE_WITH_DEVICE_ABORT=REACHED_NEGATIVE`
- `D97FJ_EXACT_DESCRIPTOR_FIELD_SEMANTICS=UNKNOWN`
- `D97FJ_PIXEL_INFO_PRIMARY_CAUSE=UNPROVEN`
- `D97FJ_IOVERSATILE_PRIMARY_CAUSE=UNPROVEN_NON_DISCRIMINANT`
- `D97FJ_SET_ID_MODE_BLOCKER=CLOSED_PASS`
- `D97FJ_NEW_ACCEL_BOOT_AUTHORIZED=NO`
- `D97FJ_ROOT_PATCH_CHANGE_AUTHORIZED=NO`
- `D97FJ_FRAMEBUFFER_CHANGE_AUTHORIZED=NO`

## Current causal frontier
`successful D97EZ set_id_mode acceptance -> CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline/device validation -> WindowServer fatal failure -> main display offline`

## Current action — static/read-only mapping only
Remain in VESA with D97EZ functional bootarg inactive. Do not alter EFI, Root Patch, framebuffer counts, NVRAM or boot variables and do not repeat the accelerated boot.

Next collect exact static mapping from the currently installed 25G82 binaries:
1. `CoreDisplay` symbol/address/disassembly around `GetGPUPassRenderPipelineState +599` and `+1720`;
2. relevant CoreDisplay strings around `F_NymriCY` and neighboring GPU-pass shader/function names;
3. exact native Metal/legacy Haswell MTLDriver identities already pinned by IPS;
4. if statically recoverable, identify the render-pipeline descriptor field or device query immediately preceding native `validateWithDevice`.

Only after this static boundary is mapped should a new bounded runtime observer/adapter be designed.