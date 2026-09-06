# OCLP7 CHECKPOINT — 2026-09-06 — D97DN D97DL LATENT runtime PASS; functional VESA design ready

## Entering authority
ASUS2:
- Tahoe 26.6.2 / 25G82;
- Haswell 8086:0412, SMBIOS MacBookAir6,2;
- VESA only, no Root Patch;
- active EFI D97DL OCLPMetalCompat 0.0.7;
- D97DL executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv`.

## Returned D97DN evidence
ZIP `OCLP7_D97DN_D97DL_LATENT_RUNTIME_20260906_234102.zip`:
- bytes `2068`;
- SHA256 `a1a2034342db65ad4f57c5443c4b638dfa748c8ec5408790837f21ca00f656b8`.

Inner TXT:
- bytes `5740`;
- SHA256 `edb61a00de6250adac89367fcadbd7286f068563c600d862714593efed77eac6`.

Boot:
- Tahoe 26.6.2 / 25G82;
- boot time `Sun Sep 6 23:37:06 2026`;
- boot args unchanged `-igfxvesa -ocmcdiag`;
- `-ocmcd97bv` absent PASS.

## Runtime identity
Loaded exact:
- Lilu 1.7.3;
- D97DL OCLPMetalCompat 0.0.7 UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- WhateverGreen 1.7.1.

`D97DL_RUNTIME_IDENTITY=PASS`.

## Persistent state
- `VersionInfo=DBG-007-2026-09-06`;
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- `D97DISiteWriteCount=0`;
- `D97DICaveWriteCount=0`;
- `D97DLSiteCavePrereq=PENDING` as expected in LATENT mode;
- `D97CTRouteStatus=PASS`;
- `D97CTBuildGate=1`;
- `D97DDObservedBuild=25G82`;
- callback count `244799`;
- publisher ticks `239`.

Natural VESA page observation:
- SITE not naturally seen (`SiteSeenCount=0`), not negative;
- CAVE seen once;
- CAVE window18 PASS;
- CAVE full208 PASS;
- CAVE validated 15/0xF;
- CAVE tainted 0;
- CAVE NX 0;
- cave functional mutation state remains PENDING and write count 0 because functional mode is LATENT.

## Authoritative classifications
- `D97DN_D97DL_RUNTIME_IDENTITY=PASS`;
- `D97DN_D97DL_LATENT_MODE=RUNTIME_PROVEN`;
- `D97DN_D97DL_FUNCTIONAL_REQUESTED=0`;
- `D97DN_D97DL_SITE_WRITE_COUNT=0`;
- `D97DN_D97DL_CAVE_WRITE_COUNT=0`;
- `D97DN_D97DL_CAVE_FIRST_PROPERTY_CHANNEL=RUNTIME_PROVEN`;
- `D97DN_D97DL_ROUTE=PASS`;
- `D97DN_D97DL_CALLBACK_BUILD_GATE_25G82=PASS`;
- `D97DN_D97DL_LATENT_RUNTIME_GATE=PASS`.

## Next bounded test design — functional VESA only
The next engineering test is the first actual D97BV runtime mutation and therefore requires separate explicit user authorization.

When authorized:
1. keep VESA (`-igfxvesa`) and diagnostic route (`-ocmcdiag`);
2. add only `-ocmcd97bv` to active boot args, with config identity pinning and backup;
3. reboot VESA through same EFI; no Root Patch;
4. run a same-process active functional collector that maps CAVE first and SITE second from exact main Cryptex `dyld_shared_cache_x86_64h`;
5. verify in that same process:
   - CAVE exact 18-byte postimage;
   - CAVE retained zero tail through 208-byte window;
   - SITE exact 13-byte postimage;
   - IORegistry `FunctionalMode=ACTIVE`, `FunctionalRequested=1`;
   - CAVE mutation PASS/write count >0;
   - SITE cave prerequisite PASS;
   - SITE mutation PASS/write count >0;
   - route/build remain PASS.

This same-process CAVE-first -> SITE-second readback is required before any Root Patch or accelerated boot.

## Authorization boundary
NOT authorized by this checkpoint alone:
- adding `-ocmcd97bv`;
- first functional D97BV page mutation;
- Root Patch;
- accelerated boot.

Current action: await explicit user authorization for the first functional VESA mutation test. No other ASUS2 change is required now.
