# OCLP7 CHECKPOINT — 2026-09-07 — D97DP D97DO LATENT deployment PASS; runtime ready

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; no Root Patch.
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and contain neither `-ocmcd97bvcave` nor `-ocmcd97bv`.
- active EFI now contains D97DO `OCLPMetalCompat.kext` 0.0.8.
- executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`.
- expected UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`.
- D97DL backup exists at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DL-20260907_001401.bak`, executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`.

## D97DP returned report
`OCLP7_D97DP_D97DO_LATENT_EFI_REPLACE_20260907_001401.txt`.

PASS evidence:
- config expected/actual SHA exact and plist validation PASS;
- unique OCLPMetalCompat Kernel/Add index 5;
- Lilu 1.7.3 at index 0;
- current D97DL identity exact before replacement;
- audited D97DO package/source/executable identities exact;
- D97DO binary gate PASS: CAVE payload present, SITE replacement absent;
- staged executable SHA exact;
- D97DL backup exact;
- final D97DO executable SHA exact;
- final version 0.0.8;
- config remains byte-identical;
- both functional boot args remain absent;
- no CAVE-only mutation;
- SITE mutation capability absent in D97DO;
- no Root Patch;
- no reboot.

Authoritative classifications:
- `D97DP_D97DO_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DP_D97DO_LATENT_DEPLOY=PASS`;
- `D97DP_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DP_CAVE_ONLY_BOOTARG_PRESENT=NO`;
- `D97DP_FULL_FUNCTIONAL_BOOTARG_PRESENT=NO`;
- `D97DP_CAVE_ONLY_FUNCTIONAL_MUTATION=NO`;
- `D97DP_SITE_MUTATION_CAPABILITY=ABSENT`.

## CURRENT ACTION — D97DQ LATENT runtime proof
One unchanged VESA reboot is authorized through the same active EFI.

D97DQ must prove:
- exact D97DO 0.0.8 loaded, UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- route PASS;
- callback exact-build 25G82 PASS;
- `D97DOFunctionalMode=LATENT`;
- `D97DOCaveOnlyRequested=0`;
- `D97DOFullFunctionalArgPresent=0`;
- `D97DOSiteWriteBlocked=PASS`;
- `D97DOCaveWritePhase=0`;
- `D97DICaveWriteCount=0`;
- `D97DISiteWriteCount=0`;
- boot args still exclude both `-ocmcd97bvcave` and `-ocmcd97bv`.

Only after D97DQ runtime PASS may the first actual CAVE-only write be armed.

Still NOT authorized:
- adding `-ocmcd97bvcave` before D97DQ audit;
- adding `-ocmcd97bv`;
- SITE mutation;
- Root Patch;
- accelerated boot.
