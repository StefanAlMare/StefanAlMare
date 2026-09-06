# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DM_D97DL_LATENT_DEPLOY_PASS_RUNTIME_READY.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; no Root Patch.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv`.
- active EFI now contains D97DL `OCLPMetalCompat.kext` 0.0.7, executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`.
- D97DI backup: `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DI-20260906_233117.bak`.
- D97DD backup remains available.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Proven runtime substrate
D97DF/D97DG proved route, callback, exact 25G82 gate, SITE exact preimage and CAVE zero invariants with Apple validated `0xF`, tainted 0, NX 0.
D97DJ deployed D97DI in LATENT mode.
D97DK proved D97DI LATENT runtime: FunctionalMode LATENT, FunctionalRequested 0, SITE/CAVE write counts 0, route/build PASS.

## D97BV exact adapter
Static semantics remain PROVEN:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DI ordering finding
D97DI functional activation is superseded: it could write SITE without requiring CAVE mutation PASS first. Since SITE jumps cross-page into CAVE, direct D97DI arming is blocked.

## D97DL 0.0.7 — cave-first hardened successor
D97DL preserves D97BV exact payload and fail-closed gates, plus hard cross-page ordering:
- CAVE mutation success is published with release semantics only after postimage/tail verification;
- SITE performs acquire load of CAVE mutation state before any SITE write;
- SITE write allowed only if CAVE mutation state is exactly PASS;
- early SITE remains native/unmodified and reports `WAITING_CAVE`.

Source authority:
- SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- Git blob `af52267e8e5fbbc975715b1c3a7a3fceab994c1b`;
- authority commit `72dbc5f29aedf4f8190700de9f1c2c45f949b56f`.

Build/binary audit PASS:
- build ZIP `OCLP7_D97DL_IMAC_BUILD_20260906_232239.zip`, SHA256 `4a32606751ddd0d5862b2f58fc70361e843ac03953704edcc25226223ad7979c`;
- manifest mismatches 0;
- version 0.0.7;
- UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- exact SITE/CAVE payloads present once each;
- cave-first release/acquire ordering static PASS;
- default without `-ocmcd97bv` remains LATENT.

Audited LATENT package:
- `OCLP7_D97DL_AUDITED_LATENT_DEPLOY_20260906.zip`;
- SHA256 `8e84e98d244ec02570f65b569c7da533c93a6ae01ed32d26a84872d0292c04c2`.

## D97DM — LATENT deployment PASS
Returned report `OCLP7_D97DM_D97DL_LATENT_EFI_REPLACE_20260906_233117.txt`:
- bytes `3361`;
- SHA256 `dba4b4aba53e4c183fa4fabf013f77db6f13dc86987b289d4a9f6480a6ef3fb5`.

PASS evidence:
- config expected/actual exact and `plutil` PASS;
- OCLPMetalCompat unique index 5;
- Lilu 1.7.3 index 0;
- current D97DI identity exact before replacement;
- audited D97DL package/source/executable identity exact;
- staged D97DL SHA exact;
- D97DI backup exact;
- final D97DL executable SHA exact `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- final version 0.0.7;
- config remained byte-identical;
- boot args remained `-igfxvesa -ocmcdiag` without `-ocmcd97bv`;
- post-replace latent gate PASS;
- no Root Patch, reboot or functional mutation.

Classifications:
- `D97DM_D97DL_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DM_D97DL_LATENT_DEPLOY=PASS`;
- `D97DM_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DM_FUNCTIONAL_BOOTARG_PRESENT=NO`;
- `D97DM_D97BV_FUNCTIONAL_MUTATION=NO`.

## CURRENT ACTION — D97DN LATENT runtime proof
One unchanged VESA reboot is authorized through the same active EFI.

D97DN must prove:
- exact D97DL 0.0.7 UUID `45EAD92D-43BF-3F42-B37B-EB5007345000` loaded;
- route PASS;
- callback exact-build 25G82 PASS;
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- SITE and CAVE write counts remain 0;
- `D97DLSiteCavePrereq` property exists; in LATENT mode its expected state is PENDING unless functional path is entered;
- boot args still exclude `-ocmcd97bv`.

Still NOT authorized:
- adding `-ocmcd97bv`;
- functional D97BV activation;
- Root Patch;
- accelerated boot.
