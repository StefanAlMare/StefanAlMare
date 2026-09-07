# OCLP7 D97EV — D97ES VESA runtime PASS; one accelerated measurement boot authorized

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Authority entering this boot
D97EU had already proved the active EFI identity of audited D97ES `OCLPMetalCompat.kext` 0.0.11 before reboot:
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.

Exactly one VESA validation reboot was authorized with no other mutation.

## User-returned live VESA evidence
Current boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh`

Relevant preserved diagnostic state:
- `-igfxvesa` ACTIVE;
- `-ocmcdiag` ACTIVE;
- `-ocmcd97bv` ACTIVE;
- `-ocmcd97eh` ACTIVE;
- `#-ocmcd97bvcave` inert.

Loaded kext identity from `kmutil showloaded`:
- `com.oclpmetalcompat.OCLPMetalCompat (0.0.11)`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`.

IORegistry service `OCLPMetalCompat` reported:
- `D97CTPublisherTicks = 300`;
- `D97CTChannel = IORegistry-AtomicAsync-v1`;
- `D97ELObserverRequested = 1`;
- `D97ELCallbackSeenCount = 17`;
- `D97ELTargetCallbackSeenCount = 1`;
- `D97ELLastCallbackIndex = 20`;
- `D97ELKextLoadIndex = 9`;
- `D97ELRouteStatus = PASS`;
- `D97ELSetIdModeCallCount = 0`;
- `D97ESCaptureSlots = 8`;
- `D97ESCapturedCount = 0`;
- `D97ES01Valid = 0`;
- `D97ES02Valid = 0`;
- `D97ES03Valid = 0`;
- `D97ES04Valid = 0`;
- `D97ES05Valid = 0`;
- `D97ES06Valid = 0`;
- `D97ES07Valid = 0`;
- `D97ES08Valid = 0`;
- `D97CTRouteStatus = PASS`;
- `D97CTBootArgGate = 1`;
- `D97CTKernelGate = 1`;
- `D97CTCpuGate = 1`;
- `D97CTBuildGate = 1`;
- `D97DDObservedBuild = 25G82`;
- `D97DIFunctionalRequested = 1`;
- `D97DIFunctionalMode = ACTIVE`.

Also observed in this VESA boot:
- `D97CTSiteSeenCount = 0`;
- `D97CTCaveSeenCount = 0`;
- `D97DISiteWriteCount = 0`;
- `D97DICaveWriteCount = 0`;
- D97DI SITE/CAVE safety/postimage fields remain `PENDING`.

These latter per-boot page-touch fields do not invalidate the already CLOSED-PASS D97BV/D97DT runtime delivery evidence. This VESA validation boot did not exercise those pages; no retest is required absent contradiction. Route status, exact-build gates and functional-request state remain healthy.

## Interpretation
1. Exact audited D97ES 0.0.11 is loaded in the VESA boot.
2. The observer bootarg is recognized.
3. The global callback mechanism is active.
4. The exact IOAcceleratorFamily2 callback is observed once.
5. The exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` route installs successfully.
6. `set_id_mode` is not called in VESA, exactly as expected.
7. D97ES publishes eight capture slots and all remain clean/empty (`CapturedCount=0`, all Valid=0).
8. The asynchronous publisher survives to its bounded 300-second limit when no observer tuple arrives, as designed.
9. D97ES therefore closes the tuple-transport/publisher prerequisite in VESA without introducing functional mutation.
10. The next informative experiment is one accelerated boot using the same D97ES observer, changing only the VESA gate so the Haswell accelerated path executes.

## Classification
- `D97EV_D97ES_LOADED_IDENTITY=PASS`
- `D97EV_OBSERVER_REQUESTED=YES`
- `D97EV_GLOBAL_CALLBACK_PATH=PASS`
- `D97EV_TARGET_CALLBACK=PASS`
- `D97EV_SET_ID_MODE_ROUTE=PASS`
- `D97EV_PUBLISHER_CHANNEL=PASS`
- `D97EV_PUBLISHER_BOUNDED_LIVENESS=PASS`
- `D97EV_CAPTURE_SLOT_SCHEMA=PASS`
- `D97EV_SET_ID_MODE_CALLS_VESA=0_EXPECTED`
- `D97EV_CAPTURED_COUNT_VESA=0_EXPECTED`
- `D97EV_ALL_EIGHT_VALID_FLAGS=0_EXPECTED`
- `D97EV_D97BV_ROUTE=PASS`
- `D97EV_D97BV_FUNCTIONAL_MODE=ACTIVE`
- `D97EV_FUNCTIONAL_SET_ID_MODE_MASKING_AUTHORIZED=NO`
- `D97EV_ROOT_PATCH_AUTHORIZED=NO`
- `D97EV_ONE_ACCELERATED_MEASUREMENT_BOOT_AUTHORIZED=YES`

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Still required from the immediately next accelerated diagnostic boot:
- `id`;
- `mode`;
- `mode & 0xFF8073C0` (`badBits`);
- `mode & 0x007F8C3F` (`goodBits`);
- original IOReturn;
for the first captured calls, with no mutation/coercion.

## CURRENT ACTION — ONE D97ES ACCELERATED MEASUREMENT BOOT AUTHORIZED
On ASUS2, make exactly one diagnostic configuration change for the next boot:
- disable/comment/remove only `-igfxvesa` (the established inert convention may be used, e.g. `#-igfxvesa`).

Keep unchanged:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- `#-ocmcd97bvcave` inert;
- `ipc_control_port_options=0` and existing `-amfipassbeta`;
- normal pre-D97ED 3/3/3 framebuffer baseline;
- current D97DX Root Patch state;
- active D97ES 0.0.11 EFI kext;
- all other settled EFI state.

Do NOT:
- Root Patch again;
- add `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0`, or any new T2/Haswell variable;
- change framebuffer counts;
- mutate/mask `set_id_mode` bits;
- coerce IOReturn;
- shadow native Tahoe Metal;
- replay true-five;
- alter Golden.

After the accelerated boot, if no usable image appears, recover to VESA according to the permanent VESA recovery rule. Evidence analysis must target the immediately preceding accelerated diagnostic boot, not the later recovery boot. The persistent D97ES IORegistry tuple evidence should then be collected from the accelerated boot if it survives/reappears as designed; if a hard reboot clears it, use the next transport-preservation step rather than repeating unchanged boots blindly.
