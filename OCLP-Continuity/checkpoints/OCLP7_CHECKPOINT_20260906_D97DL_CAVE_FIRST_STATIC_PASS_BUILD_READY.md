# OCLP7 CHECKPOINT — 2026-09-06 — D97DK LATENT runtime PASS; D97DL cave-first STATIC PASS; build ready

## Runtime authority entering this checkpoint
ASUS2 remains on D97DI 0.0.6 LATENT:
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- VESA with `-igfxvesa -ocmcdiag`;
- `-ocmcd97bv` absent;
- no Root Patch;
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- D97DI 0.0.6 executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`.

D97DK runtime ZIP `OCLP7_D97DK_D97DI_LATENT_RUNTIME_20260906_230656.zip` SHA256 `95e19deb4591a9bdfa803567513210e91a7ae13db962ec2d1a24334883bc6723` proved:
- exact D97DI runtime identity PASS;
- route PASS;
- callback build gate PASS / observed build 25G82;
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- SITE write count 0;
- CAVE write count 0;
- no D97BV functional mutation.

## Pre-arming source review finding
Before adding `-ocmcd97bv`, review of the exact D97DI source found an unsafe unguarded ordering condition:
- SITE and CAVE are on different validation pages;
- SITE non-3802 execution branches into CAVE;
- D97DI could write SITE without first requiring CAVE mutation PASS.

Natural VESA observations repeatedly show CAVE faults before SITE, but this is not accepted as a universal accelerated-boot guarantee.

Therefore:
`D97DI_FUNCTIONAL_ACTIVATION=BLOCKED_SUPERSEDED_BY_D97DL`.

## D97DL 0.0.7 design
D97DL preserves every D97DI/D97BV byte and gate, and adds cave-first ordering:
- CAVE writes/postimage completion publish mutation state with release semantics;
- SITE uses acquire load of CAVE mutation state;
- SITE write is permitted only when CAVE mutation state is exactly PASS;
- if SITE arrives early, `D97DLSiteCavePrereq=WAITING_CAVE` and SITE remains unmodified/native;
- no cross-page unsafe trampoline is introduced before CAVE is ready.

Exact D97BV payload remains unchanged:
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DL source authority
Path: `OCLP-Continuity/artifacts/OCLP7_D97DL_kern_start.cpp`
- source SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- Git blob `af52267e8e5fbbc975715b1c3a7a3fceab994c1b`;
- source commit `2c5268c1e57a5b0a7e555d18fb0e5010f8855a87`.

Static audit: `OCLP-Continuity/artifacts/OCLP7_D97DL_STATIC_ORDERING_AUDIT.md`.
Static classifications:
- `D97DL_CAVE_FIRST_PREREQUISITE=STATIC_PROVEN`;
- `D97DL_CAVE_RELEASE_SITE_ACQUIRE_ORDERING=STATIC_PROVEN`;
- `D97DL_SITE_FAIL_CLOSED_IF_CAVE_NOT_READY=STATIC_PROVEN`;
- `D97DL_D97BV_PAYLOAD_IDENTITY=STATIC_PROVEN`;
- `D97DL_SOURCE_STATIC_AUDIT=PASS`;
- `D97DL_BUILD=UNTESTED`.

## Build helper authority
Path: `OCLP-Continuity/artifacts/OCLP7_D97DL_IMAC_BUILD_AUTHORITY.sh`.
- helper Git blob `d44b65f166bdfc29859ed1fe3647cb7ef7edceb4`;
- helper commit `5ee84f055654f29c44b2ea57cf970ed96991f286`;
- local delivered helper SHA256 `8e56f5cf01c5fa9a8d5f3ec61b924befa92f24f3e4809e097b2e09596feb57f0`;
- `bash -n` PASS;
- target version 0.0.7;
- exact source commit/blob/SHA pinned;
- build-only; no deployment/arming authorization.

## CURRENT ACTION
Build D97DL 0.0.7 on the already-authorized iMac 9900K host and return `OCLP7_D97DL_IMAC_BUILD_<timestamp>.zip` for independent audit.

ASUS2 remains unchanged on D97DI 0.0.6 LATENT.

NOT authorized:
- D97DL deployment before build audit;
- adding `-ocmcd97bv`;
- functional D97BV activation;
- Root Patch;
- accelerated boot.
