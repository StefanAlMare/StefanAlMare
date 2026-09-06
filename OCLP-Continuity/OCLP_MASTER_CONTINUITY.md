# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DP_D97DO_LATENT_DEPLOY_PASS_RUNTIME_READY.md`
D97DO build audit: `OCLP-Continuity/artifacts/OCLP7_D97DO_BUILD_BINARY_AUDIT_20260907.md`
D97DO static audit: `OCLP-Continuity/artifacts/OCLP7_D97DO_STATIC_AUDIT.md`

## Mandatory startup order
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. history/retrospective as needed.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- VESA only; no active Root Patch;
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag`;
- boot args contain neither `-ocmcd97bvcave` nor `-ocmcd97bv`;
- active EFI now contains D97DO `OCLPMetalCompat.kext` 0.0.8;
- D97DO executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`;
- D97DO expected UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- D97DL backup exists at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DL-20260907_001401.bak`, executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- D97DI and D97DD backups remain available.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions remain:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## Proven runtime substrate
D97DF/D97DG proved `_cs_validate_page` route/callback/exact-build `25G82`, SITE exact original preimage, CAVE zero invariants and Apple validation `0xF/0/0`.

D97DJ/D97DK proved D97DI 0.0.6 LATENT deploy/runtime.
D97DM/D97DN proved D97DL 0.0.7 LATENT deploy/runtime with route/build PASS and zero functional writes.

## D97BV exact adapter semantics
Static semantics remain PROVEN:
- exact `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DL ordering limitation
D97DL added CAVE-before-SITE release/acquire ordering, but its CAVE-ready state is global to the kext. Before allowing SITE -> CAVE cross-page control flow, page-modification propagation between userspace processes/address spaces must be measured directly.

Therefore full D97DL functional activation remains blocked pending D97DO propagation evidence.

## D97DO 0.0.8 — CAVE-only one-shot propagation probe
Purpose: make the first actual runtime write an inert CAVE-only probe while SITE remains native and unmodifiable.

Safety design:
- Apple original `_cs_validate_page` first;
- exact 25G82 / Haswell / main x86_64h / page / Apple-validation / zero-preimage gates;
- only `-ocmcd97bvcave` can request mutation;
- full `-ocmcd97bv` is explicitly blocked;
- SITE replacement bytes absent from source and binary;
- SITE write target absent;
- exact CAVE replacement compiled once;
- CAVE write one-shot per boot via atomic CAS;
- writer must be userspace PID and writer PID is recorded;
- later callbacks never rewrite CAVE;
- propagation PASS/NEGATIVE classified only on a callback from a different userspace PID.

Correct source authority is exact concatenation of Git blobs:
1. `5308074eb75d76531eef19481ded76b641c3f301`;
2. `fac28701be3acae370866483b94d04d620d41916`;
3. `54861bd997619551e64c264f9e02b1d4e66c13b2`.

Reconstructed source:
- bytes `25693`;
- SHA256 `4607658c5a7d1967d7b0ae1b507f0e160ba2201aed6fe5b4a9a936a263cb520a`.

Returned D97DO build `OCLP7_D97DO_IMAC_BUILD_20260907_000350.zip`:
- SHA256 `01900232f6c77fe72cad6759d2a1a1c851e772ced0d4e036f66fa3f0fba96d36`;
- manifest mismatches 0;
- Lilu build PASS;
- D97DO build PASS;
- errors 0.

Compiled D97DO:
- version `0.0.8`;
- UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`;
- Lilu dependency `1.7.3`;
- CAVE replacement count 1;
- SITE replacement count 0.

Audited LATENT package:
- `OCLP7_D97DO_AUDITED_LATENT_DEPLOY_20260907.zip`;
- SHA256 `c336816e5b87b7af7d4960d6024cc5a31e3188bd901ab35bc649c54169ca560b`.

## D97DP — LATENT deployment PASS
Returned report `OCLP7_D97DP_D97DO_LATENT_EFI_REPLACE_20260907_001401.txt`.

PASS evidence:
- config exact and plist validation PASS;
- OCLPMetalCompat unique index 5;
- Lilu 1.7.3 index 0;
- D97DL pre-replace identity exact;
- D97DO package/source/executable identity exact;
- D97DO cave-only binary gate PASS;
- staged D97DO SHA exact;
- D97DL backup exact;
- final D97DO executable SHA exact;
- final version 0.0.8;
- config remained byte-identical;
- both `-ocmcd97bvcave` and `-ocmcd97bv` absent;
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
- exact D97DO 0.0.8 UUID loaded;
- route PASS;
- callback exact-build 25G82 PASS;
- `D97DOFunctionalMode=LATENT`;
- `D97DOCaveOnlyRequested=0`;
- `D97DOFullFunctionalArgPresent=0`;
- `D97DOSiteWriteBlocked=PASS`;
- `D97DOCaveWritePhase=0`;
- CAVE write count 0;
- SITE write count 0;
- boot args still exclude both functional args.

Only after D97DQ runtime PASS may the first actual CAVE-only write be armed.

Still NOT authorized:
- adding `-ocmcd97bvcave` before D97DQ audit;
- adding `-ocmcd97bv`;
- SITE mutation;
- Root Patch;
- accelerated boot.
