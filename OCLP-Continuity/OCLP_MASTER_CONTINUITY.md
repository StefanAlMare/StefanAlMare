# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DL_BUILD_BINARY_AUDIT_PASS_LATENT_DEPLOY_READY.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; no Root Patch.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv`.
- active EFI remains D97DI `OCLPMetalCompat.kext` 0.0.6, executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`.
- D97DD backup remains available.

## Proven runtime substrate
D97DF/D97DG proved route, callback, exact 25G82 gate, SITE exact preimage and CAVE zero invariants with Apple validated `0xF`, tainted 0, NX 0.
D97DJ deployed D97DI in LATENT mode.
D97DK proved D97DI LATENT runtime: `FunctionalMode=LATENT`, `FunctionalRequested=0`, SITE/CAVE write counts 0, route/build PASS. Cave was naturally seen; SITE not naturally faulted in that boot.

## D97BV exact adapter
Static semantics remain PROVEN:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DI ordering finding
Pre-arming review found D97DI could write SITE without requiring CAVE mutation PASS first. Because SITE branches cross-page into CAVE, D97DI functional activation is blocked and superseded by D97DL.

## D97DL 0.0.7 — build/binary audit PASS
D97DL preserves the exact payload and all fail-closed gates, plus cave-first cross-page ordering:
- CAVE mutation success is published with release semantics only after postimage/tail verification;
- SITE performs acquire load of CAVE mutation state before any SITE write;
- SITE write allowed only if CAVE mutation state is exactly PASS;
- early SITE yields `D97DLSiteCavePrereq=WAITING_CAVE` and remains native/unmodified.

Source authority:
- SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- Git blob `af52267e8e5fbbc975715b1c3a7a3fceab994c1b`;
- authority commit `72dbc5f29aedf4f8190700de9f1c2c45f949b56f`.

Returned build `OCLP7_D97DL_IMAC_BUILD_20260906_232239.zip`:
- bytes 59325;
- SHA256 `4a32606751ddd0d5862b2f58fc70361e843ac03953704edcc25226223ad7979c`;
- manifest mismatches 0;
- Lilu build PASS;
- D97DL build PASS;
- zero errors;
- six non-functional build/toolchain warnings.

Compiled D97DL:
- version `0.0.7`;
- UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- built Info.plist SHA256 `e09e026901269ca16b5169104a1feb8f5ca950d3999e426945d95b2a88db873d`;
- Lilu dependency `1.7.3`.

Binary/static audit PASS:
- exact SITE and CAVE payloads each occur once;
- D97DLSiteCavePrereq and WAITING_CAVE markers present;
- SITE acquire-before-write ordering PASS;
- CAVE release-after-postimage ordering PASS;
- exact build/path/page/Apple-validation/preimage gates retained;
- generic patching surfaces absent;
- default without `-ocmcd97bv` remains LATENT.

Audited LATENT package:
- `OCLP7_D97DL_AUDITED_LATENT_DEPLOY_20260906.zip`;
- SHA256 `8e84e98d244ec02570f65b569c7da533c93a6ae01ed32d26a84872d0292c04c2`;
- bytes 26405.

Classifications:
- `D97DL_LOCAL_COMPILE=PASS`;
- `D97DL_MANIFEST_AUDIT=PASS`;
- `D97DL_SOURCE_IDENTITY=PASS`;
- `D97DL_D97BV_PAYLOAD_BINARY_AUDIT=PASS`;
- `D97DL_CAVE_FIRST_PREREQUISITE=STATIC_PROVEN`;
- `D97DL_CAVE_RELEASE_SITE_ACQUIRE_ORDERING=STATIC_PROVEN`;
- `D97DL_SITE_FAIL_CLOSED_IF_CAVE_NOT_READY=STATIC_PROVEN`;
- `D97DL_LATENT_DEFAULT=PASS`.

## CURRENT ACTION
Deploy D97DL 0.0.7 to ASUS2 in LATENT mode only via identity-pinned D97DM replacement from current D97DI 0.0.6. `config.plist` must remain byte-identical and `-ocmcd97bv` must remain absent.

After D97DM, return the report before reboot. Do not Root Patch and do not attempt accelerated boot.
