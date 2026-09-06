# OCLP7 CHECKPOINT — 2026-09-07 — D97DR CAVE-only write + cross-process propagation PROVEN

## Entering authority
ASUS2:
- Tahoe 26.6.2 / 25G82;
- Haswell 8086:0412, SMBIOS MacBookAir6,2;
- VESA only; no Root Patch;
- active EFI D97DO OCLPMetalCompat 0.0.8;
- D97DO executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`;
- D97DO UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- boot args contain `-igfxvesa -ocmcdiag -ocmcd97bvcave` and do not contain `-ocmcd97bv`.

## Returned D97DR evidence
ZIP `OCLP7_D97DR_D97DO_CAVE_ONLY_PROPAGATION_20260907_003453.zip`:
- bytes `2104`;
- SHA256 `51161f0f58b1dee18e409f556df3200a4b69ea655010b9de22eefbece62d1076`.

Inner TXT:
- bytes `6501`;
- SHA256 `9686af4773433a4133e91fbdc9d9ac13a0f836957209b1369646b32f3ee248d5`.

Boot:
- boot time 2026-09-07 00:30:12 EEST;
- exact D97DO 0.0.8 UUID loaded;
- cave-only boot arg present;
- full functional boot arg absent.

## CAVE write happened naturally before collector
IORegistry before active faults already showed:
- `D97DOFunctionalMode=CAVE_ONLY`;
- `D97DOCaveOnlyRequested=1`;
- `D97DOFullFunctionalArgPresent=0`;
- `D97DOSiteWriteBlocked=PASS`;
- `D97DOCaveWritePhase=2` (WRITE_PASS);
- `D97DICaveWriteCount=1`;
- `D97DICaveMutation=PASS`;
- `D97DICavePostimage=PASS`;
- `D97DICaveTailZeroAfter=PASS`;
- writer PID `2`;
- SITE write count `0` and SiteSeenCount `0`;
- route PASS and exact-build 25G82 PASS.

Thus the first actual runtime mutation in the project was exactly one bounded CAVE write. SITE remained native and unmodified.

## Direct cross-process visibility proof
Collector created two separate userspace mappings of the exact CAVE page from the main Cryptex `dyld_shared_cache_x86_64h`:

Process 1 PID 899:
- exact first18 replacement `3d187d0000b9177d00000f4cc1e9b4311600`;
- tail 190 bytes zero;
- page SHA256 `aa0100e1a73637835627eabaa5698c5b03af35a33357b3cd9879cf5c0ba572e0`.

Process 2 PID 901:
- exact same first18 replacement;
- tail 190 bytes zero;
- exact same page SHA256 `aa0100e1a73637835627eabaa5698c5b03af35a33357b3cd9879cf5c0ba572e0`.

PIDs are distinct. Both processes independently mapped the page and observed the same postimage.

## Why IORegistry propagation classifier stayed PENDING
`D97DOCavePropagation=PENDING` after the two mappings is not a negative result. The page had already been validated and modified earlier in the boot, so the later process mappings did not produce fresh `_cs_validate_page` callbacks for D97DO's callback-based propagation classifier.

Therefore:
- callback classifier: `INCONCLUSIVE_NO_REVALIDATION`;
- direct userspace cross-process readback: `RUNTIME_PROVEN`.

The direct readback is the stronger evidence for the question being tested: whether the CAVE postimage is visible across process/address-space mappings.

## Authoritative classifications
- `D97DR_D97DO_RUNTIME_IDENTITY=PASS`;
- `D97DR_CAVE_ONLY_MODE=RUNTIME_PROVEN`;
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
The D97DL global CAVE-ready prerequisite is now backed by direct evidence that the modified shared-cache CAVE page is globally visible across distinct userspace process mappings.

The cross-page ordering concern that blocked full D97DL activation is CLOSED for a bounded VESA functional pair test.

## CURRENT ACTION
Prepare full D97BV VESA-only test using exact previously audited D97DL 0.0.7:
- restore exact D97DL backup identity;
- replace `-ocmcd97bvcave` with full `-ocmcd97bv` while retaining `-igfxvesa -ocmcdiag`;
- no Root Patch;
- reboot VESA;
- active collector must map CAVE first, then SITE, and verify exact postimages + write counts + cave prerequisite PASS.

Root Patch and accelerated boot remain unauthorized.