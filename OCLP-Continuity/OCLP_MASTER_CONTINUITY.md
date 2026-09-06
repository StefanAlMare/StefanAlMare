# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- current boot mode: VESA (`-igfxvesa` retained);
- diagnostic route `-ocmcdiag` present;
- full D97BV boot arg `-ocmcd97bv` present;
- cave-only arg appears only as commented `#-ocmcd97bvcave`, therefore not active;
- active kext D97DL `OCLPMetalCompat.kext` 0.0.7;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- no active Root Patch yet.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions remain:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV exact adapter semantics
Static semantics remain PROVEN:
- exact `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## Proven delivery substrate before D97DT
D97DF/D97DG proved `_cs_validate_page` route/callback/exact-build `25G82`, SITE exact original preimage, CAVE zero invariants and Apple validation `0xF/0/0`.
D97DJ/D97DK proved D97DI 0.0.6 LATENT deploy/runtime.
D97DM/D97DN proved D97DL 0.0.7 LATENT deploy/runtime and cave-first property channel.
D97DO/D97DR then proved first real CAVE write and direct cross-process visibility of the exact CAVE postimage.

## D97DT — FULL VESA PAIR PASS
Returned ZIP `OCLP7_D97DT_D97DL_FULL_VESA_PAIR_20260907_005133.zip`:
- bytes `1774`;
- SHA256 `48f1e5940cb0e6806e4231b50380210193d9bab8b09c7d0b1b0d16044c64cc0b`.

Inner TXT:
- bytes `4869`;
- SHA256 `a206c0449135b90245154f39eeaebaf1544bd9fcaaa30864dace3c539c8c0316`.

Runtime identity:
- exact D97DL 0.0.7 loaded;
- UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- `D97DIFunctionalMode=ACTIVE`;
- `D97DIFunctionalRequested=1`;
- route PASS;
- callback exact-build `25G82` PASS.

Same userspace PID `870` mapped exact main Cryptex cache CAVE first and SITE second.

CAVE:
- exact 18-byte replacement `3d187d0000b9177d00000f4cc1e9b4311600` PASS;
- retained 190-byte tail zero PASS;
- page SHA256 `aa0100e1a73637835627eabaa5698c5b03af35a33357b3cd9879cf5c0ba572e0`;
- mutation PASS;
- postimage PASS;
- write count 1;
- Apple validated `0xF`, tainted 0, NX 0.

SITE:
- exact 13-byte replacement `3dda0e00007406e93bcee9ff90` PASS;
- page SHA256 `1267dff997a989d4ac5691df8c79f6a3f7f189411376a862de38faa416e2975b`;
- `D97DLSiteCavePrereq=PASS`;
- safety PASS;
- mutation PASS;
- postimage PASS;
- write count 1;
- Apple validated `0xF`, tainted 0, NX 0.

Collector classifications:
- `D97DT_FULL_VESA_PAIR_GATE=PASS`;
- `D97DT_STATUS=PASS`.

Authoritative closure:
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
The complete runtime delivery mechanism for the exact D97BV selective-3802 adapter is now CLOSED PASS under VESA on exact Tahoe 25G82.

This closes:
- runtime route/timing;
- exact CAVE delivery and integrity;
- cross-process CAVE visibility;
- cave-first ordering;
- exact SITE delivery;
- Apple validation safety;
- same-process CAVE -> SITE visibility.

## NEXT ACTION
Perform final FASTLANE/root-patch baseline audit, then separately authorize manual Root Patch if that audit remains clean.

Still not authorized automatically:
- Root Patch;
- accelerated boot;
- reboot into an accelerated/root-patched configuration.
