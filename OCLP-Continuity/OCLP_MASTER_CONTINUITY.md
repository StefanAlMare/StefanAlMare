# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DL_CAVE_FIRST_STATIC_PASS_BUILD_READY.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; no Root Patch.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv`.
- active EFI contains D97DI `OCLPMetalCompat.kext` 0.0.6, executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`.
- D97DD backup remains available.

## Proven runtime substrate
D97DF/D97DG proved route, callback, exact 25G82 gate, SITE exact preimage and CAVE zero invariants with Apple validated `0xF`, tainted 0, NX 0.
D97DJ deployed D97DI in LATENT mode.
D97DK proved D97DI LATENT runtime: functional requested 0, SITE write count 0, CAVE write count 0, route/build PASS.

## D97BV adapter
Static semantics remain PROVEN:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics.
- SITE replacement `3dda0e00007406e93bcee9ff90`.
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DI ordering finding
Pre-arming review found D97DI allowed SITE to be written without requiring CAVE mutation PASS first. Because SITE branches cross-page into CAVE, D97DI active use is blocked.

## D97DL 0.0.7 — current frontier
D97DL preserves all payload/gates and adds cave-first ordering:
- CAVE publishes mutation completion with release semantics;
- SITE performs acquire load of CAVE mutation state;
- SITE write allowed only when CAVE state is PASS;
- early SITE observation yields `D97DLSiteCavePrereq=WAITING_CAVE` and leaves SITE native/unmodified.

Source authority:
- `OCLP-Continuity/artifacts/OCLP7_D97DL_kern_start.cpp`;
- SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- Git blob `af52267e8e5fbbc975715b1c3a7a3fceab994c1b`.

Static audit: `OCLP-Continuity/artifacts/OCLP7_D97DL_STATIC_ORDERING_AUDIT.md`.
Build helper: `OCLP-Continuity/artifacts/OCLP7_D97DL_IMAC_BUILD_AUTHORITY.sh`.

Classifications:
- `D97DK_D97DI_LATENT_RUNTIME=PASS`;
- `D97DI_FUNCTIONAL_ACTIVATION=BLOCKED_SUPERSEDED_BY_D97DL`;
- `D97DL_CAVE_FIRST_PREREQUISITE=STATIC_PROVEN`;
- `D97DL_CAVE_RELEASE_SITE_ACQUIRE_ORDERING=STATIC_PROVEN`;
- `D97DL_SITE_FAIL_CLOSED_IF_CAVE_NOT_READY=STATIC_PROVEN`;
- `D97DL_SOURCE_STATIC_AUDIT=PASS`;
- `D97DL_BUILD=UNTESTED`.

## CURRENT ACTION
Build D97DL 0.0.7 on the already-authorized iMac 9900K and return the ZIP for independent audit.

Do not change ASUS2, do not add `-ocmcd97bv`, do not Root Patch, and do not attempt accelerated boot.