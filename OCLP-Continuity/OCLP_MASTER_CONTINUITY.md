# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DN_D97DL_LATENT_RUNTIME_PASS_FUNCTIONAL_VESA_READY.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; no Root Patch.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv`.
- active EFI contains D97DL `OCLPMetalCompat.kext` 0.0.7, executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`.
- D97DI backup: `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DI-20260906_233117.bak`.
- D97DD backup remains available.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Proven runtime substrate
D97DF/D97DG proved route, callback, exact 25G82 gate, SITE exact preimage and CAVE zero invariants with Apple validated `0xF`, tainted 0, NX 0.
D97DJ deployed D97DI in LATENT mode.
D97DK proved D97DI LATENT runtime.
D97DM deployed D97DL 0.0.7 LATENT while preserving config and keeping `-ocmcd97bv` absent.

## D97BV exact adapter
Static semantics remain PROVEN:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DI ordering finding
D97DI functional activation is superseded: it could write SITE without requiring CAVE mutation PASS first. Since SITE jumps cross-page into CAVE, direct D97DI arming remains blocked.

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
- cave-first release/acquire ordering static PASS;
- default without `-ocmcd97bv` remains LATENT.

## D97DM — LATENT deployment PASS
D97DL 0.0.7 replaced D97DI in active EFI with exact identity, config byte-identical and `-ocmcd97bv` absent. No Root Patch, reboot or functional mutation during deployment.

## D97DN — LATENT runtime PASS
Returned ZIP `OCLP7_D97DN_D97DL_LATENT_RUNTIME_20260906_234102.zip`:
- bytes `2068`;
- SHA256 `a1a2034342db65ad4f57c5443c4b638dfa748c8ec5408790837f21ca00f656b8`.

Inner TXT:
- bytes `5740`;
- SHA256 `edb61a00de6250adac89367fcadbd7286f068563c600d862714593efed77eac6`.

Runtime proof:
- exact D97DL 0.0.7 UUID loaded;
- `VersionInfo=DBG-007-2026-09-06`;
- `FunctionalMode=LATENT`;
- `FunctionalRequested=0`;
- SITE write count 0;
- CAVE write count 0;
- `D97DLSiteCavePrereq=PENDING` as expected in LATENT mode;
- route PASS;
- callback exact-build 25G82 PASS;
- CAVE naturally seen with window18/full208 PASS, validated 15/0xF, tainted 0, NX 0;
- SITE not naturally faulted in this VESA boot, not negative.

Authoritative classifications:
- `D97DN_D97DL_RUNTIME_IDENTITY=PASS`;
- `D97DN_D97DL_LATENT_MODE=RUNTIME_PROVEN`;
- `D97DN_D97DL_SITE_WRITE_COUNT=0`;
- `D97DN_D97DL_CAVE_WRITE_COUNT=0`;
- `D97DN_D97DL_CAVE_FIRST_PROPERTY_CHANNEL=RUNTIME_PROVEN`;
- `D97DN_D97DL_ROUTE=PASS`;
- `D97DN_D97DL_CALLBACK_BUILD_GATE_25G82=PASS`;
- `D97DN_D97DL_LATENT_RUNTIME_GATE=PASS`.

## CURRENT ACTION — first functional VESA mutation requires explicit authorization
The next test is the first actual D97BV runtime mutation.

When separately authorized:
1. retain `-igfxvesa -ocmcdiag`;
2. add only `-ocmcd97bv` to active boot args with config backup/identity pinning;
3. reboot VESA through same EFI; no Root Patch;
4. run a same-process collector that maps CAVE first and SITE second from exact main Cryptex `dyld_shared_cache_x86_64h`;
5. verify exact CAVE and SITE postimages in that same process plus IORegistry ACTIVE/mutation/write-count/prerequisite states;
6. do not Root Patch or attempt accelerated boot until this VESA functional pair test is audited PASS.

Still NOT authorized by current state:
- adding `-ocmcd97bv`;
- first functional D97BV page mutation;
- Root Patch;
- accelerated boot.
