# OCLP7 D97FI — downstream CoreDisplay offline crash loop / framebuffer-metadata frontier localized

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2

## Input authority
D97FH remains decisive for the previous boundary:
- exact D97EZ 0.0.12 ACTIVE `0x224 -> 0x24` translation is STRUCTURAL-SEMANTIC PROVEN for captured calls;
- all 16/16 observed exact-224 calls were accepted by Apple;
- all 4/4 observed non-224 passthrough calls were accepted;
- prior `Surface mode contains bad bits` blocker is CLOSED PASS.

New downstream evidence source:
`OCLP7_D97FH_DOWNSTREAM_20260907_171607.txt`, collected read-only from the accelerated boot around 2026-09-07 16:50 EEST, followed by VESA recovery.

## Accelerated boot chronology
`last reboot` distinguishes:
- accelerated experiment reboot around 16:49;
- VESA recovery reboot around 16:51.

The analyzed 16:50 WindowServer/IOAccelerator/CoreDisplay events belong to the ACTIVE accelerated boot, not the later VESA recovery.

## Downstream progress newly REACHED
During accelerated WindowServer PID 177 initialization:
- GPUWrangler identifies IGPU `8086:0412`;
- `/IntelAccelerator` exists;
- `AppleIntelFramebuffer@0`, `@1`, `@2` are present;
- framebuffer 0 is detected online;
- internal panel DPCD is readable (`DPCD_REV 1.2`, link rate `0xA`, lane count 1, sink count 1, eDP configuration 3);
- `display0` and `AppleBacklightDisplay` publish under framebuffer 0;
- CoreDisplay proceeds through `Creating FB 1 of 3`, `Created FB 1 of 3`, `Creating FB 2 of 3`, `Created FB 2 of 3`, `Creating FB 3 of 3`;
- CoreDisplay ultimately reports `GPU: FB: 3 of 3 opened`.

Thus the system progresses materially beyond the former set_id_mode rejection.

## First direct accelerated framebuffer-resource failure
At approximately 16:50:25.047:
`IOAccelDisplayPipe::init_framebuffer_resource(IOAccelResource2 *): getPixelInformation for framebuffer 0 failed`

This occurs after fb0 online/DPCD/EDID-side discovery and before completion of CoreDisplay's framebuffer/device initialization.

Classification:
- `D97FI_GET_PIXEL_INFORMATION_FAILURE=REACHED_NEGATIVE`
- exact causal sufficiency: `UNKNOWN`.

Reason for bounded classification: historical Intel graphics logs can contain this message without proving it is alone fatal. It is nevertheless the first direct IOAccelerator framebuffer-resource failure in the measured accelerated sequence and is currently the highest-value candidate boundary.

## Related mode/capability failures
The same WindowServer cycle later reports:
- `IOFBSetDisplayModeAndDepth: Failed to obtain mode info from IOFBGetDisplayModeInformation()`;
- `Attempting to get capabilities from capabilities with no devices`;
- CoreBrightness reports CoreDisplay/windowserver ports unavailable while the display stack is not established.

These are consistent with incomplete/invalid framebuffer display metadata/device construction downstream of raw framebuffer publication.

## Fatal repeatable CoreDisplay path
After all three framebuffer user clients are opened, CoreDisplay reports:
`Setting offline display 0x00000000 main in AddCGXDisplayDeviceToDeviceList`

Stack:
- `AddCGXDisplayDeviceToDeviceList`
- `CGXDisplayDriverInitialize`
- `WS::Displays::CoreDisplayManager::initialize()`
- `WSInitialize`
- `SLXServer`

WindowServer PID 177 then exits due to SIGSEGV around 16:50:26.149.

The same CoreDisplay offline-display path and SIGSEGV repeat in later WindowServer restarts, including PID 368 around 16:50:37.822 and PID 406 around 16:50:49.105.

Therefore the post-D97EZ fatal behavior is repeatable and belongs to CoreDisplay/display-device initialization rather than the previously closed set_id_mode rejection.

## Secondary Metal evidence
A later WindowServer restart (PID 332) logs immediately before its second crash:
`(Metal) validateWithDevice, line 5044: error '<private>'`

Classification:
- `D97FI_METAL_VALIDATE_WITH_DEVICE_ERROR=REACHED`
- semantic cause and relationship to framebuffer metadata: `UNKNOWN` pending crash-report inspection.

Do not infer a renewed compiler/Metal4 regression from this line alone.

## IOVersatile classification
The accelerated boot logs repeated:
- `com.apple.driver.IOVersatile - can't resolve dependencies; OSBundleLibraries missing/invalid type`;
- allocation failures for `IOVersatileHWA`, `IOVersatileNub`, `IOVersatileSoftBitstreamManager`.

However the later usable VESA recovery boot also logs the same IOVersatile dependency failure.

Therefore:
- `D97FI_IOVERSATILE_FAILURE_PRESENT=YES`
- `D97FI_IOVERSATILE_ACCEL_VS_VESA_DISCRIMINATING=NO`
- `D97FI_IOVERSATILE_CAUSAL_BLOCKER=UNPROVEN`

Do not Root Patch or alter IOVersatile based only on this evidence.

## Current causal frontier
Closed:
`Tahoe mode 0x224 -> IOAccelSurface bad-bits rejection`.

Current localized module:
`successful set_id_mode acceptance -> framebuffer 0 resource / pixel+mode metadata construction -> CoreDisplay device-capability construction -> main display forced offline -> WindowServer SIGSEGV`.

The exact faulting instruction/stack for the crash remains UNKNOWN because the downstream collection listed the `.ips` files but did not include their contents.

## Existing crash reports
The accelerated/recovery evidence lists recent system diagnostic reports including WindowServer `.ips` files modified around 16:50-16:51. These must be read next to resolve:
- exact exception/fault address;
- faulting thread;
- precise stack;
- whether first and repeated crashes share one stack;
- whether `Metal validateWithDevice` and CoreDisplay offline paths converge on the same fault;
- loaded-image identities around CoreDisplay/Metal/Haswell driver.

## Classification
- `D97FI_D97EZ_SET_ID_MODE_FIX_REMAINS_PASS=YES`
- `D97FI_GPUWRANGLER_HASWELL_IGPU_REACHED=YES`
- `D97FI_FRAMEBUFFER_0_ONLINE_REACHED=YES`
- `D97FI_FB_3_OF_3_OPENED_REACHED=YES`
- `D97FI_GET_PIXEL_INFORMATION_FAILURE=REACHED_NEGATIVE`
- `D97FI_MODE_INFO_FAILURE=REACHED_NEGATIVE`
- `D97FI_CORE_DISPLAY_CAPABILITIES_NO_DEVICES=REACHED_NEGATIVE`
- `D97FI_MAIN_DISPLAY_OFFLINE=REPEATABLE`
- `D97FI_WINDOWSERVER_SIGSEGV=REPEATABLE`
- `D97FI_IOVERSATILE_CAUSAL=UNPROVEN_NON_DISCRIMINATING`
- `D97FI_EXACT_CRASH_STACK=UNKNOWN_PENDING_IPS`
- `D97FI_NEW_BOOT_AUTHORIZED=NO`
- `D97FI_ROOT_PATCH_AUTHORIZED=NO`
- `D97FI_EFI_BOOTARG_FRAMEBUFFER_CHANGE_AUTHORIZED=NO`

## CURRENT ACTION — read existing WindowServer crash reports only
Remain in VESA. Do not reboot and do not change EFI, Root Patch, framebuffer counts or boot args.

Collect the newest WindowServer `.ips` diagnostic reports corresponding to the 16:50 accelerated crash loop and return them for exact fault-stack analysis. This is the next evidence gate before any new experiment.
