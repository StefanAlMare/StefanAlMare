# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DR_CAVE_ONLY_WRITE_CROSS_PROCESS_PROPAGATION_PROVEN.md`
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
- active EFI contains D97DO `OCLPMetalCompat.kext` 0.0.8;
- D97DO executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`;
- D97DO UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- boot args contain `-igfxvesa -ocmcdiag -ocmcd97bvcave` and do not contain `-ocmcd97bv`;
- D97DL exact backup remains at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DL-20260907_001401.bak`;
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

## D97BV exact adapter semantics
Static semantics remain PROVEN:
- exact `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## Proven runtime substrate through D97DN
D97DF/D97DG proved `_cs_validate_page` route/callback/exact-build 25G82, SITE exact original preimage, CAVE zero invariants and Apple validation 0xF/0/0.
D97DJ/D97DK proved D97DI 0.0.6 LATENT deploy/runtime.
D97DM/D97DN proved D97DL 0.0.7 LATENT deploy/runtime and cave-first property channel.

## D97DO 0.0.8
D97DO is the CAVE-only one-shot propagation probe:
- full SITE replacement absent from binary;
- SITE write target absent;
- exact CAVE payload compiled once;
- only `-ocmcd97bvcave` requests mutation;
- full `-ocmcd97bv` is blocked;
- CAVE write is one-shot per boot;
- writer PID is recorded;
- later callbacks never rewrite CAVE.

Identity:
- reconstructed source SHA256 `4607658c5a7d1967d7b0ae1b507f0e160ba2201aed6fe5b4a9a936a263cb520a`;
- version 0.0.8;
- UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`.

## D97DR — first real write + propagation proof
Returned ZIP `OCLP7_D97DR_D97DO_CAVE_ONLY_PROPAGATION_20260907_003453.zip`:
- bytes 2104;
- SHA256 `51161f0f58b1dee18e409f556df3200a4b69ea655010b9de22eefbece62d1076`.

Inner TXT:
- bytes 6501;
- SHA256 `9686af4773433a4133e91fbdc9d9ac13a0f836957209b1369646b32f3ee248d5`.

Boot authority:
- boot time 2026-09-07 00:30:12 EEST;
- exact D97DO loaded;
- `-ocmcd97bvcave` present;
- full `-ocmcd97bv` absent.

Before collector active faults, IORegistry already proved the first actual runtime write had occurred naturally:
- `D97DOFunctionalMode=CAVE_ONLY`;
- `D97DOCaveOnlyRequested=1`;
- `D97DOSiteWriteBlocked=PASS`;
- `D97DOCaveWritePhase=2`;
- `D97DICaveWriteCount=1`;
- `D97DICaveMutation=PASS`;
- `D97DICavePostimage=PASS`;
- `D97DICaveTailZeroAfter=PASS`;
- writer PID 2;
- SITE write count 0 and SITE unseen;
- route/build PASS.

Direct cross-process visibility:
- PID 899 mapped CAVE and saw exact replacement + zero tail, page SHA `aa0100e1a73637835627eabaa5698c5b03af35a33357b3cd9879cf5c0ba572e0`;
- PID 901 independently mapped CAVE and saw the same exact replacement + zero tail and the exact same page SHA.

Thus cross-process CAVE postimage visibility is `RUNTIME_PROVEN`.

The internal callback-based `D97DOCavePropagation` remained PENDING because the page was already validated/cached and the later mappings did not trigger fresh `_cs_validate_page` callbacks. Classification: `INCONCLUSIVE_NO_REVALIDATION`, not negative.

Authoritative classifications:
- `D97DR_CAVE_ONE_SHOT_WRITE=RUNTIME_PROVEN`;
- `D97DR_CAVE_POSTIMAGE=RUNTIME_PROVEN`;
- `D97DR_CAVE_TAIL_ZERO=RUNTIME_PROVEN`;
- `D97DR_SITE_WRITE_COUNT=0`;
- `D97DR_SITE_MUTATION_CAPABILITY=ABSENT_BINARY_PROVEN`;
- `D97DR_CROSS_PROCESS_CAVE_VISIBILITY=RUNTIME_PROVEN`;
- `D97DR_CALLBACK_PROPAGATION_CLASSIFIER=INCONCLUSIVE_NO_REVALIDATION`;
- `D97DR_ROUTE=PASS`;
- `D97DR_CALLBACK_BUILD_GATE_25G82=PASS`.

## Consequence
The global CAVE-ready state used by D97DL is now backed by direct runtime evidence that the modified CAVE shared-cache page is visible across distinct userspace process mappings.
The cross-page ordering concern is CLOSED for a bounded full D97BV VESA test.

## CURRENT ACTION
Prepare full VESA-only D97BV test using exact previously audited D97DL 0.0.7:
1. restore exact D97DL backup over D97DO;
2. replace `-ocmcd97bvcave` with `-ocmcd97bv` while retaining `-igfxvesa -ocmcdiag`;
3. no Root Patch;
4. reboot VESA;
5. collector maps CAVE first, then SITE, and verifies both exact postimages, write counts, and cave prerequisite PASS.

Root Patch and accelerated boot remain unauthorized.