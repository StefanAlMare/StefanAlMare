# OCLP7 CHECKPOINT — 2026-09-06 — D97DK D97DI LATENT runtime PASS; functional arming ready

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`.
- Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Unpatched VESA only; no Root Patch.
- Active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- Boot args retain `-igfxvesa -ocmcdiag` and do NOT contain `-ocmcd97bv`.
- Active EFI contains D97DI `OCLPMetalCompat.kext` 0.0.6, executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`.

## Returned D97DK evidence
Returned ZIP: `OCLP7_D97DK_D97DI_LATENT_RUNTIME_20260906_230656.zip`.
- ZIP bytes: 2022.
- ZIP SHA256: `95e19deb4591a9bdfa803567513210e91a7ae13db962ec2d1a24334883bc6723`.

Inner TXT:
- bytes: 5491.
- SHA256: `9303157cd79f0ae31032400e6c40dfc3a51e35a181e80690b43fd33834b5750b`.

Boot time: Sun Sep 6 23:02:58 2026.

## Runtime identity
Loaded:
- Lilu 1.7.3;
- D97DI 0.0.6 UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- WhateverGreen 1.7.1.

`D97DI_RUNTIME_IDENTITY=PASS`.

## LATENT safety proof
Boot args exclude `-ocmcd97bv`: PASS.

IORegistry:
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- `D97DISiteWriteCount=0`;
- `D97DICaveWriteCount=0`.

Classifier:
- `FUNCTIONAL_MODE_GATE=PASS`;
- `FUNCTIONAL_REQUESTED_GATE=PASS`;
- `SITE_WRITE_COUNT_ZERO_GATE=PASS`;
- `CAVE_WRITE_COUNT_ZERO_GATE=PASS`;
- `D97DK_LATENT_RUNTIME_GATE=PASS`;
- `D97DK_STATUS=PASS`.

This proves the functional-capable payload remains fully inert when `-ocmcd97bv` is absent.

## Proven substrate retained
- `D97CTRouteStatus=PASS`;
- `D97CTBuildGate=1`;
- `D97DDObservedBuild=25G82`;
- `D97DDCallbackSeenCount=243523`.

Natural cave observation remains clean:
- CaveSeenCount=1;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15 / 0xF;
- CaveTainted=0;
- CaveNX=0.

SiteSeenCount=0 in this natural VESA boot is not negative; no active site fault was requested.

## Authoritative classifications
- `D97DK_D97DI_RUNTIME_IDENTITY=PASS`;
- `D97DK_D97DI_LATENT_MODE=RUNTIME_PROVEN`;
- `D97DK_D97DI_FUNCTIONAL_REQUESTED=0`;
- `D97DK_D97DI_SITE_WRITE_COUNT=0`;
- `D97DK_D97DI_CAVE_WRITE_COUNT=0`;
- `D97DK_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DK_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`;
- `D97DK_D97BV_FUNCTIONAL_MUTATION=NO`.

## Functional readiness boundary
The following prerequisites are now closed PASS on exact ASUS2/25G82:
1. static D97BV semantics;
2. exact route/callback build gate runtime;
3. exact SITE and CAVE target delivery/preimages runtime;
4. compiled D97DI payload/binary audit;
5. identity-pinned LATENT deployment;
6. LATENT runtime proof with zero writes.

The next bounded action may be a VESA-only functional activation by adding explicit `-ocmcd97bv` while retaining `-igfxvesa -ocmcdiag`, followed by a dedicated collector that proves SITE and CAVE safety, mutation, exact postimages and write counts. This should occur before any Root Patch or accelerated boot.

## CURRENT ACTION
Functional arming is technically ready but remains a separate explicit authorization boundary.

No Root Patch or accelerated boot is authorized by this checkpoint.
