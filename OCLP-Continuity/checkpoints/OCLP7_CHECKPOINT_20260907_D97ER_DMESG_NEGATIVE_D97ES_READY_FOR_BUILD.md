# OCLP7 D97ER — live dmesg negative, D97ES IORegistry tuple telemetry ready for build

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Input observation
After D97EQ accelerated failure and VESA recovery, user ran:

`sudo dmesg | grep -Ei 'D97EH|D97EL|ocmc|set_id_mode|badBits|goodBits' | tail -n 200`

Result: no matching output.

## Interpretation
- D97EH/D97EL custom observer markers are absent from both post-recovery unified log and current live `dmesg`.
- Repeating the same accelerated boot with unchanged D97EL 0.0.10 will not improve observability.
- This does NOT overturn D97EP, which independently proved `D97ELRouteStatus=PASS` in VESA via IORegistry.
- The graphics causal frontier remains the D97EQ sequence: four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` errors -> display offline -> WindowServer SIGSEGV.
- The unresolved issue is exact tuple transport/capture: `id`, `mode`, candidate bit classes, original IOReturn.

## D97ES design
D97ES is planned as OCLPMetalCompat 0.0.11, derived deterministically from exact D97EL 0.0.10.

Functional semantics remain unchanged:
- same `-ocmcd97eh` observer gate;
- same IOAcceleratorFamily2 registration and exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` route;
- Apple original is called first with exact original `that/id/mode`;
- original IOReturn is returned unchanged;
- no mode masking/clearing;
- no return coercion;
- no framebuffer, EFI, NVRAM, filesystem, Root Patch or Golden mutation.

Telemetry-only additions:
- atomically capture first 8 post-original tuples in kernel memory;
- per slot: `id`, `mode`, `badBits = mode & 0xFF8073C0`, `goodBits = mode & 0x007F8C3F`, raw original `ret`;
- publish tuples asynchronously through the existing IORegistry publisher, not from inside the critical `set_id_mode` call;
- keep the bounded publisher alive until at least one observer tuple is captured when `-ocmcd97eh` is active, still retaining the original 5-minute bound.

Expected IORegistry properties include:
- `D97ESCaptureSlots`
- `D97ESCapturedCount`
- `D97ES01Valid` .. `D97ES08Valid`
- `D97ES01Id` .. `D97ES08Id`
- `D97ES01Mode` .. `D97ES08Mode`
- `D97ES01BadBits` .. `D97ES08BadBits`
- `D97ES01GoodBits` .. `D97ES08GoodBits`
- `D97ES01Ret` .. `D97ES08Ret`

## Authority
Generator:
`OCLP-Continuity/artifacts/OCLP7_D97ES_IOREG_TUPLE_GENERATOR.py`
- commit `62fac73c0d834be92bcab208234112a4b046e385`
- Git blob `dc7e244c3734f5dd0cd6f24d6d8c43da76d41fad`

Intel iMac build helper:
`OCLP-Continuity/artifacts/OCLP7_D97ES_IMAC_BUILD.sh`
- commit `060e43f8c1bb427f4b9fbd8f610ae57780f6b7dd`

The build helper is fail-closed and verifies:
- exact D97DL source SHA;
- exact D97EH generated source SHA;
- exact D97EL generated source SHA;
- exact D97EL and D97ES generator Git blobs;
- deterministic D97ES generation by generating twice and byte-comparing;
- required tuple telemetry markers;
- preserved exact Apple passthrough call and return;
- forbidden mutation-token absence;
- x86_64 D97ES 0.0.11 build and binary markers.

## Classification
- `D97ER_DMESG_CUSTOM_MARKERS=ABSENT`
- `D97ER_REPEAT_D97EL_ACCELERATED_BOOT=NOT_JUSTIFIED`
- `D97ER_D97ES_TELEMETRY_DESIGN=READY_FOR_BUILD`
- `D97ER_D97ES_DEPLOYMENT_AUTHORIZED=NO`
- `D97ER_ACCELERATED_BOOT_AUTHORIZED=NO`
- `D97ER_FUNCTIONAL_MODE_MASKING_AUTHORIZED=NO`

## Current action
Build D97ES 0.0.11 on the authorized Intel iMac only. Return the resulting ZIP for independent audit. Do not alter ASUS2 EFI or reboot during the build/audit stage.
