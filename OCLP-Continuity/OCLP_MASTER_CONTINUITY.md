# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DO_CAVE_ONLY_STATIC_PASS_BUILD_READY.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; no Root Patch.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv` or `-ocmcd97bvcave`.
- active EFI contains D97DL `OCLPMetalCompat.kext` 0.0.7, executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`.
- D97DI backup and D97DD backup remain available.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Proven runtime substrate
D97DF/D97DG proved route, callback, exact 25G82 gate, SITE exact preimage and CAVE zero invariants with Apple validated `0xF`, tainted 0, NX 0.
D97DJ deployed D97DI LATENT; D97DK proved D97DI LATENT runtime.
D97DM deployed D97DL 0.0.7 LATENT.
D97DN proved exact D97DL LATENT runtime:
- `FunctionalMode=LATENT`;
- `FunctionalRequested=0`;
- SITE/CAVE write counts 0;
- `D97DLSiteCavePrereq=PENDING`;
- route/build PASS;
- CAVE naturally seen and fully safe;
- SITE not naturally faulted, not negative.

## D97BV exact adapter
Static semantics remain PROVEN:
- exact `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DI/D97DL ordering finding
D97DI functional activation was blocked because SITE could be written without a CAVE prerequisite.
D97DL hardened this with CAVE release -> SITE acquire and `WAITING_CAVE`, but the CAVE-ready state is global to the kext. Before allowing SITE to branch cross-page, propagation of the modified CAVE page across process/address-space faults must be characterized directly.

Therefore full `-ocmcd97bv` activation remains blocked.

## D97DO 0.0.8 — one-shot CAVE-only propagation probe STATIC PASS
D97DO narrows the first actual write further:
- dedicated diagnostic boot arg `-ocmcd97bvcave`;
- full `-ocmcd97bv` is separately detected and disables CAVE-only writes;
- SITE replacement bytes are absent from source;
- SITE write target is absent from source;
- SITE callback is observation-only;
- only exact CAVE payload is compiled;
- first safe userspace CAVE callback may claim exactly one write via atomic CAS;
- writer PID is captured with `proc_selfpid()`;
- later CAVE callbacks are observation-only;
- propagation classification occurs only on a different userspace PID than the writer.

Exact CAVE payload:
`3d187d0000b9177d00000f4cc1e9b4311600`.

Propagation classification after one-shot write:
- different PID sees exact postimage with safe Apple validation => PASS;
- different PID sees original zero CAVE => NEGATIVE;
- same writer PID never classifies propagation.

Source authority is split byte-exactly into three ordered GitHub fragments at authority commit `52f286d6e693c88123fc11403608038f7982082e`:
- part1 blob `5308074eb75d76531eef19481ded76b641c3f301`;
- part2 blob `fac28701be3acae370866483b94d04d620d41916`;
- part3 blob `54861bd997619551e64c264f9e02b1d4e66c13b2`.

Static audit: `OCLP-Continuity/artifacts/OCLP7_D97DO_STATIC_AUDIT.md`.

Classifications:
- `D97DO_SITE_MUTATION_CAPABILITY=ABSENT_STATIC_PROVEN`;
- `D97DO_CAVE_ONLY_BOOTARG_FAIL_CLOSED=STATIC_PROVEN`;
- `D97DO_CAVE_ONE_SHOT_WRITE=STATIC_PROVEN`;
- `D97DO_CROSS_PID_PROPAGATION_CLASSIFIER=STATIC_PROVEN`;
- `D97DO_FULL_FUNCTIONAL_ARG_BLOCKED=STATIC_PROVEN`;
- `D97DO_SOURCE_STATIC_AUDIT=PASS`;
- `D97DO_BUILD=UNTESTED`.

Prepared iMac build helper:
- `OCLP7_D97DO_IMAC_BUILD_AUTHORITY.sh`;
- SHA256 `7b3f34c058ffe8af6c8c8531afc870bfb550a0bb5d5bb52ab90f2b64a5136618`;
- `bash -n` PASS;
- reconstructs source from exact three blob-pinned fragments;
- target version 0.0.8;
- binary audit requires CAVE payload present and full SITE replacement absent.

## CURRENT ACTION
Build D97DO 0.0.8 on the already-authorized iMac 9900K host and return the resulting ZIP for independent audit.

ASUS2 remains unchanged on D97DL 0.0.7 LATENT.

NOT authorized yet:
- any ASUS2 D97DO deployment;
- adding `-ocmcd97bvcave`;
- adding `-ocmcd97bv`;
- functional write;
- Root Patch;
- accelerated boot;
- reboot.