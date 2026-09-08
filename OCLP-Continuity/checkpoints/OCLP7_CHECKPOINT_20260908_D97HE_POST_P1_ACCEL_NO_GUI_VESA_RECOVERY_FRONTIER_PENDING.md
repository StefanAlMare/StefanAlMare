# OCLP7 CHECKPOINT — 2026-09-08 — POST-P1 ACCELERATED BOOT NO GUI / VESA RECOVERY / FRONTIER PENDING

## Context
ASUS2 / macOS Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.

Pre-accelerated authority was fully closed:
- D97GS P1-only Root Patch PASS;
- active service exact P1 SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active P1 postimage `81fe177d0000` at 0x3494 PASS;
- corrected metallibs 180/180 exact;
- CoreDisplay exact `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, 20739 bytes, MTLB;
- Haswell Azul + HD5000 kexts loaded;
- official helper exact;
- D97EW persistent collector live gate PASS (`service=present`, `captured_count=0`, `set_id_mode_calls=0`, `route=PASS`).

## Accelerated boot configuration
Authorized single-variable-family test:
- `-igfxvesa` made inert/commented;
- `-ocmcd97ez` activated;
- framebuffer remained 3/3/3;
- `igfxfw=2` OFF;
- `rps-control=1` OFF;
- Max Pixel Clock Override OFF;
- no other EFI/NVRAM/device-property changes.

## Runtime result
The accelerated boot produced no usable GUI/image. The user followed the permanent recovery rule and returned to VESA with D97EZ inert again.

Authoritative accelerated-boot evidence must remain the preceding accelerated boot, not the current VESA recovery boot.

## WindowServer crash evidence
User supplied WindowServer crash report from the accelerated boot:
- process WindowServer 600.00;
- launch time `2026-09-08 03:35:27.3200 +0300`;
- crash time `2026-09-08 03:35:43.5056 +0300`;
- uptime since boot 90s;
- EXC_CRASH / SIGABRT;
- termination namespace COREANIMATION code 4;
- `spec=PBGRAXb_Xc`;
- fatal reason: `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.`;
- top fatal compositor frame `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- path continues through QuartzCore Metal compositor and SkyLight `MetalCompositeLayer` / `CompositorMetal`.

Binary images in WindowServer prove presence of:
- `/System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/32023/Libraries/libllvm-flatbuffers.dylib`;
- `/System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/32023/Libraries/libGPUCompilerUtils.dylib`;
- `/System/Library/Extensions/AppleIntelHD5000GraphicsMTLDriver.bundle/...` version 18.8.4 / CFBundleVersion 18.0.8.

## Current classification
`D97HE_ACCEL_BOOT_GUI=NEGATIVE_NO_IMAGE`
`D97HE_WINDOWSERVER_METAL_COMPOSITOR=REACHED`
`D97HE_WINDOWSERVER_XPC_INTERRUPTED=PROVEN`
`D97HE_P1_RUNTIME_EFFECT=UNKNOWN_PENDING_MTLCOMPILERSERVICE_FRONTIER`

The WindowServer crash is downstream evidence only. It does NOT prove that P1 failed. The decisive question is whether post-P1 MTLCompilerService reports still contain the old pre-P1 startup signature:
- RIP=0;
- r15=32023;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`.

If that old signature is absent and MTLCompilerService now crashes deeper, P1 produced runtime semantic progress and the new measured frontier must be mapped before considering P2b/P3/AIR00/D34.

## Current action
Run only the read-only D97HE frontier collector:
`OCLP-Continuity/artifacts/OCLP7_D97HE_POST_P1_ACCEL_RECOVERY_FRONTIER_COLLECTOR.sh`
- commit `6ea8974bb24f01c681b8e2523025eeb1dc1d655f`;
- Git blob `9c2a8afdb6611149bf28108b346d01cce8c6e195`.

D97HE must:
1. verify current VESA recovery / D97EZ inert;
2. identify the authoritative D97EW accelerated run by exact boot-arg state;
3. preserve D97EW tuple evidence;
4. collect MTLCompilerService + WindowServer IPS reports in that accelerated window;
5. parse faulting RIP/r15/frames and explicitly count the old RIP0+ctx56 signature;
6. collect bounded unified logs;
7. package evidence to Desktop.

No new Root Patch, EFI/NVRAM/framebuffer change, accelerated boot, or replay of P2b/P3/AIR00/D34 is authorized until D97HE evidence is reviewed.
