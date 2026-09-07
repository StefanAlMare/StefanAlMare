# OCLP7 D97EE — 1/1/1 accelerated FAIL chronology and compare collector

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## State
- D97DX native-Metal-safe Root Patch remains installed.
- D97DL OCLPMetalCompat 0.0.7 remains the active compatibility kext.
- D97ED DeviceProperties experiment was manually armed before the test:
  - AAPL,ig-platform-id = 0600260A (0x0A260006)
  - device-id = 12040000 (0x0412)
  - framebuffer-patch-enable = 01000000
  - framebuffer-cursormem = 00009000
  - framebuffer-pipecount = 01000000
  - framebuffer-portcount = 01000000
  - framebuffer-memorycount = 01000000
  - con2 enable/type overrides removed.
- Accelerated diagnostic boot was attempted with -igfxvesa inactive and -ocmcdiag / -ocmcd97bv retained.
- User reports the accelerated boot crashed / produced unusable GUI and recovered into VESA.

## Exact chronology
`last reboot | head -n 8` returned:
- reboot 2026-09-07 10:07 — current VESA recovery boot
- reboot 2026-09-07 03:06 — D97ED 1/1/1 accelerated diagnostic boot
- shutdown 2026-09-07 03:06 — prior lifecycle marker
- reboot 2026-09-07 02:25 — prior VESA recovery
- reboot 2026-09-07 02:23 — prior D97EB accelerated diagnostic boot

Therefore D97ED accelerated evidence is unambiguously the 03:06 boot. The current 10:07 VESA boot must be excluded.

## Current classification
- `D97ED_ACCELERATED_GUI=FAIL_OBSERVED`
- Do NOT yet classify D97ED as the same root cause as D97EB.
- Need to determine whether 1/1/1 actually changed CoreDisplay enumeration and crash signature.

## D97EE compare collector
Generated read-only collector:
`OCLP7_D97EE_1FB_ACCEL_COMPARE.sh`

SHA256:
`6d55dbb93b202fea4b61d20bf50f7edc644b7f3959485bf8bd0dab97ea2201a7`

Collector window:
`2026-09-07 03:05:30` through `2026-09-07 03:30:00` EEST.
This window is safely before current VESA boot at 10:07.

Collector compares only decisive evidence:
- `GPU: FB:` count;
- IOFBGetDisplayModeInformation / capability failures;
- CoreDisplay offline-display events;
- IOAccelSurface bad-bits events;
- WindowServer crash/SIGSEGV lifecycle;
- MTLCompilerService/Metal activity;
- panic/watchdog/GPU-restart negatives.

## Decision gate
If D97ED proves:
1. `GPU: FB: 1 of 1 opened`,
2. FB2/FB3 mode-info errors disappear,
3. WindowServer still dies with the same IOAccelSurface/CoreDisplay/SIGSEGV signature,
then close the inactive-external-framebuffer hypothesis and move the causal frontier to:
`Tahoe CoreDisplay / IOAccelSurface semantics <-> legacy Haswell IOAccelerator/framebuffer`.

Until D97EE analysis:
- remain in VESA;
- do not revert 1/1/1 yet;
- do not repeat accelerated boot;
- do not Root Patch again;
- do not mutate EFI further;
- do not introduce CoreDisplay donor/downgrade or global 3802 forcing.
