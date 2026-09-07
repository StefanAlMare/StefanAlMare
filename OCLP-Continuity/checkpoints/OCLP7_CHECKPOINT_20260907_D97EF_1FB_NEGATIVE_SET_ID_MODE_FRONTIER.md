# OCLP7 D97EF — 1/1/1 NEGATIVE; IOAccelSurface::set_id_mode frontier

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## Authority / current safe state
- Current running session is VESA recovery at 2026-09-07 10:07 EEST.
- D97DX native-Metal-safe Root Patch remains installed.
- D97DL OCLPMetalCompat 0.0.7 remains the active compatibility kext.
- Active recovery boot args retain `-igfxvesa -ocmcdiag -ocmcd97bv`; `#-ocmcd97bvcave` remains inert.
- No Root Patch, accelerated reboot, or additional functional mutation is authorized by this checkpoint.

## D97EE returned evidence
Returned file: `OCLP7_D97EE_1FB_ACCEL_COMPARE.txt`.

Important window correction:
- collector range began at 03:05:30 and therefore includes the tail of the pre-test VESA session and its orderly shutdown around 03:06;
- the D97ED accelerated boot proper begins around 03:07:54–03:07:55;
- current VESA recovery begins only at 10:07 and is excluded.

## 1/1/1 application PROVEN
D97ED DeviceProperties count-vector was genuinely active in accelerated mode:
- CoreDisplay: `Creating FB 1 of 1`;
- CoreDisplay: `Created FB 1 of 1`;
- CoreDisplay: `GPU: FB: 1 of 1 opened`.

Therefore the experiment successfully suppressed FB2/FB3 enumeration.

## Core failure signature persists
Despite true 1/1/1 enumeration, accelerated WindowServer still reaches the same critical surface/display failure class:
1. one framebuffer is created/opened;
2. kernel emits four consecutive `IOAccelSurface::set_id_mode(uint32_t, uint32_t): Surface mode contains bad bits` messages;
3. CoreDisplay sets the main display offline;
4. WindowServer exits via SIGSEGV;
5. launchd respawns WindowServer and the sequence repeats.

Second WindowServer PID 336 additionally shows:
- `IOFBSetDisplayModeAndDepth: Setting mode 0x0 with depth 0x0`;
- `Failed to obtain mode info from IOFBGetDisplayModeInformation()`;
- `GPU: FB: 1 of 1 opened`;
- same four surface bad-bits failures;
- offline main display;
- SIGSEGV at 03:08:00.629301 EEST.

## Classifications
- `D97EE_1FB_APPLIED=YES`;
- `D97EE_GPU_FB=1_OF_1`;
- `D97EE_EXTERNAL_FB2_FB3_NECESSARY_FOR_CORE_CRASH=NO`;
- `D97EE_IOACCEL_SURFACE_BAD_BITS=PERSISTS`;
- `D97EE_WINDOWSERVER_SIGSEGV=PERSISTS`;
- `D97EE_SINGLE_FB_VECTOR_SOLUTION=NEGATIVE`;
- `D97EE_FRAMEBUFFER_COUNT_TUNING_FRONTIER=CLOSED_NEGATIVE`.

Nuance: the 1/1/1 experiment changed mode-info behavior for the sole framebuffer, so do not claim the entire accelerated trace is byte-for-byte identical to D97EB. What is causally proven is that external FB2/FB3 are not required for the core `set_id_mode bad bits -> offline display -> WindowServer SIGSEGV` failure class.

## Required baseline restoration before future accelerated tests
The 1/1/1 vector is diagnostic-only and must be removed before the next accelerated experiment. Restore the pre-D97ED IGPU baseline:
- remove `framebuffer-pipecount`;
- remove `framebuffer-portcount`;
- remove `framebuffer-memorycount`;
- restore `framebuffer-con2-enable = 01000000`;
- restore `framebuffer-con2-type = 00080000`;
- retain `AAPL,ig-platform-id = 0600260A`;
- retain `device-id = 12040000`;
- retain `framebuffer-patch-enable = 01000000`;
- retain `framebuffer-cursormem = 00009000`;
- keep `-igfxvesa` active while preparing the next diagnostic.

## New causal frontier
Current highest-value frontier is no longer compiler ingress, Metal4 superclass ABI, Root Patch loading, or framebuffer count topology.

It is now:
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

The immediate question is: which exact `mode` value(s) Tahoe supplies and which bit(s) cause IOAcceleratorFamily2 to reject them.

## External orientation — methodology only
A modern Intel compatibility project, NootedGreen, contains a `set_id_mode` hook and classifies mode bits with masks:
- candidate bad-bit mask `0xff8073c0`;
- candidate good-bit mask `0x007f8c3f`.

Its hardware/generation context differs from ASUS2 Haswell/Tahoe. Therefore its functional masking MUST NOT be transplanted blindly. Only the diagnostic methodology is accepted at this stage.

NootedGreen currently routes `IOAccelLegacySurface::set_id_mode` (`__ZN20IOAccelLegacySurface11set_id_modeEjj`), while Tahoe 25G82 kernel logging on ASUS2 names `IOAccelSurface::set_id_mode`. Exact symbol/class resolution on the target IOAcceleratorFamily2 binary is mandatory before implementing any hook.

## NEXT ACTION — exact symbol audit, then diagnostic-only hook
Remain in VESA.

1. Resolve the exact 25G82 symbol(s) in `/System/Library/Extensions/IOAcceleratorFamily2.kext/Contents/MacOS/IOAcceleratorFamily2` corresponding to `set_id_mode`.
2. Starting from exact D97DL source, design a new fail-closed diagnostic-only OCLPMetalCompat revision gated by a new explicit boot arg.
3. Hook the exact resolved method and call the original with `id` and `mode` UNCHANGED.
4. Log a bounded number of calls, including:
   - `id`;
   - original `mode`;
   - `mode & 0xff8073c0` as diagnostic candidate badBits;
   - `mode & 0x007f8c3f` as diagnostic candidate goodBits;
   - original IOReturn.
5. No bit stripping, return coercion, framebuffer mutation, Root Patch change, or shared-cache mutation in the diagnostic build.
6. Build locally on the authorized Intel iMac 9900K; static/binary audit before ASUS2 deployment.
7. First boot with the new kext must remain VESA to prove route/load safety. Only then may one accelerated diagnostic boot be separately authorized.

## Still forbidden
- immediate masking/clearing of `0xff8073c0` or any other mode bits;
- another unchanged accelerated boot;
- retaining 1/1/1 as production configuration;
- another Root Patch;
- CoreDisplay donor/downgrade without ABI audit;
- legacy main Metal shadow;
- global forced-3802;
- true-five reapplication;
- Golden mutation.
