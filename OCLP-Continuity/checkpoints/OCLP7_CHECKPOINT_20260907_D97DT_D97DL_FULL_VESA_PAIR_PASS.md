# OCLP7 CHECKPOINT — 2026-09-07 — D97DT D97DL full VESA pair runtime PASS

## Entering authority
ASUS2:
- Tahoe 26.6.2 / 25G82;
- Haswell 8086:0412, SMBIOS MacBookAir6,2;
- VESA retained via `-igfxvesa`;
- active diagnostic route `-ocmcdiag`;
- full functional D97BV armed with `-ocmcd97bv`;
- cave-only arg appears only as commented token `#-ocmcd97bvcave`, therefore is not active;
- active kext D97DL OCLPMetalCompat 0.0.7;
- UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- no Root Patch.

## Returned D97DT evidence
ZIP `OCLP7_D97DT_D97DL_FULL_VESA_PAIR_20260907_005133.zip`:
- bytes `1774`;
- SHA256 `48f1e5940cb0e6806e4231b50380210193d9bab8b09c7d0b1b0d16044c64cc0b`.

Inner TXT:
- bytes `4869`;
- SHA256 `a206c0449135b90245154f39eeaebaf1544bd9fcaaa30864dace3c539c8c0316`.

## Boot/runtime identity
Boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv`

Loaded exact D97DL:
- version 0.0.7;
- UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`.

Before active same-process mapping:
- `D97DIFunctionalMode=ACTIVE`;
- `D97DIFunctionalRequested=1`;
- CAVE already mutated PASS;
- CAVE postimage PASS;
- CAVE tail-zero-after PASS;
- CAVE write count 1;
- SITE still pending/write count 0;
- route PASS;
- callback exact-build `25G82` PASS.

## Same-process CAVE -> SITE runtime proof
Single userspace PID `870` mapped exact main Cryptex shared cache CAVE page first and SITE page second.

CAVE readback:
- exact first 18 bytes `3d187d0000b9177d00000f4cc1e9b4311600`;
- exact D97BV CAVE replacement PASS;
- retained 190-byte cave tail zero PASS;
- CAVE page SHA256 `aa0100e1a73637835627eabaa5698c5b03af35a33357b3cd9879cf5c0ba572e0`.

SITE readback:
- exact 13 bytes `3dda0e00007406e93bcee9ff90`;
- exact D97BV SITE replacement PASS;
- SITE page SHA256 `1267dff997a989d4ac5691df8c79f6a3f7f189411376a862de38faa416e2975b`.

After mapping, IORegistry proves:
- `D97DIFunctionalMode=ACTIVE`;
- `D97DIFunctionalRequested=1`;
- `D97DICaveMutation=PASS`;
- `D97DICavePostimage=PASS`;
- `D97DICaveTailZeroAfter=PASS`;
- `D97DICaveWriteCount=1`;
- `D97DLSiteCavePrereq=PASS`;
- `D97DISiteSafety=PASS`;
- `D97DISiteMutation=PASS`;
- `D97DISitePostimage=PASS`;
- `D97DISiteWriteCount=1`;
- SITE Apple validation `validated=15/0xF`, tainted 0, NX 0;
- CAVE Apple validation `validated=15/0xF`, tainted 0, NX 0;
- `D97CTRouteStatus=PASS`;
- `D97CTBuildGate=1`;
- observed build `25G82`.

Collector classification:
`D97DT_FULL_VESA_PAIR_GATE=PASS`
`D97DT_STATUS=PASS`

## Authoritative classifications
- `D97DT_D97DL_RUNTIME_IDENTITY=PASS`;
- `D97DT_D97BV_CAVE_POSTIMAGE=RUNTIME_PROVEN`;
- `D97DT_D97BV_CAVE_TAIL_ZERO=RUNTIME_PROVEN`;
- `D97DT_D97BV_SITE_CAVE_PREREQ=RUNTIME_PROVEN`;
- `D97DT_D97BV_SITE_POSTIMAGE=RUNTIME_PROVEN`;
- `D97DT_D97BV_CAVE_WRITE_COUNT_ONE=RUNTIME_PROVEN`;
- `D97DT_D97BV_SITE_WRITE_COUNT_ONE=RUNTIME_PROVEN`;
- `D97DT_D97BV_APPLE_VALIDATION_SAFE=RUNTIME_PROVEN`;
- `D97DT_D97BV_SAME_PROCESS_CAVE_THEN_SITE=RUNTIME_PROVEN`;
- `D97DT_FULL_VESA_PAIR_GATE=PASS`.

## Meaning
The complete runtime delivery mechanism for the exact D97BV selective 3802 adapter is closed PASS under VESA on exact Tahoe 25G82:
- page route/timing;
- CAVE propagation;
- CAVE exact postimage and tail integrity;
- SITE prerequisite ordering;
- SITE exact postimage;
- Apple validation safety;
- same-process CAVE -> SITE visibility.

No Root Patch has yet been performed in this D97DT state.

## Authorization boundary
This checkpoint does not itself perform or auto-authorize Root Patch. Permanent rule remains: never auto Root Patch and never auto reboot.

Next step must be a separate explicit FASTLANE/root-patch authorization after final audit of the intended root-patch baseline and retained VESA recovery path.
