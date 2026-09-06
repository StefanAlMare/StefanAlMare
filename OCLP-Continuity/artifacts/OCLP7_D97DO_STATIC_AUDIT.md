# OCLP7 D97DO — one-shot CAVE-only propagation probe static audit

Date: 2026-09-06 EEST

## Purpose
D97DO is a diagnostic successor to D97DL. It is designed for the first actual runtime write while keeping the D97BV SITE entirely native/unmodified.

D97DO compiles only the CAVE payload and accepts only the diagnostic boot argument:
`-ocmcd97bvcave`.

The full functional boot argument:
`-ocmcd97bv`
is explicitly detected as a blocked request and disables CAVE-only writes.

## Safety boundary
- Apple original `_cs_validate_page` runs first.
- `-ocmcdiag` remains required for route installation.
- exact build `25G82`, Haswell, main `dyld_shared_cache_x86_64h`, exact CAVE page offset, non-null data, Apple validated `0xF`, tainted 0, NX 0, and exact zero preimage are all required.
- SITE replacement bytes are not compiled into D97DO.
- there is no SITE write target and no SITE write call.
- CAVE write may happen at most once globally per boot.
- CAVE writer must be a userspace PID (`proc_selfpid() > 0`).
- first CAVE writer PID is recorded.
- later callbacks are observation-only and never rewrite CAVE.
- propagation PASS/NEGATIVE is classified only on a different userspace PID from the writer PID.

## One-shot state machine
`D97DOCaveWritePhase`:
- `0`: UNCLAIMED
- `1`: WRITING
- `2`: WRITE_PASS
- `3`: WRITE_FAIL

The first safe zero-CAVE callback claims phase `0 -> 1` with atomic CAS.
After exact CAVE postimage + retained tail-zero verification:
- mutation PASS is published;
- write count increments once;
- phase becomes `2` with release ordering.

No later callback can execute `writeExact`.

## Propagation classifier
When phase is `2`:
- same writer PID: no propagation classification;
- different PID + exact CAVE postimage + safe Apple result: `D97DOCavePropagation=PASS`;
- different PID + original zero CAVE: `D97DOCavePropagation=NEGATIVE`.

Properties:
- `D97DOCaveWritePid`
- `D97DOCavePropagationPid`
- `D97DOCavePropagation`
- `D97DOCavePostimageSeenAfterWrite`
- `D97DOCaveZeroSeenAfterWrite`
- `D97DOCaveWritePhase`
- `D97DOSiteWriteBlocked=PASS`

## Static source audit
Reconstructed source SHA256:
`7da66e31f9967601c39fef0e4630b4a194fd0c4f00f35b16f08675e0789bb6f7`

GitHub source authority is split byte-exactly into:
- `OCLP7_D97DO_kern_start.part1.cpp`
- `OCLP7_D97DO_kern_start.part2.cpp`
- `OCLP7_D97DO_kern_start.part3.cpp`

The authoritative build helper must concatenate those three files in that exact order and refuse compilation unless the reconstructed SHA matches the value above.

Required static facts:
- SITE replacement array absent: PASS
- `mutablePage + SiteInPage` absent: PASS
- CAVE write target appears exactly once: PASS
- `writeExact` has exactly one call site in addition to its definition: PASS
- CAVE-only bootarg check present exactly once: PASS
- full functional bootarg is separately detected: PASS
- `proc_selfpid()` gate present: PASS
- writer PID and propagation PID properties present: PASS
- one-shot atomic compare-exchange present: PASS
- exact CAVE payload retained:
  `3d187d0000b9177d00000f4cc1e9b4311600`
- broad patching APIs absent:
  `findAndReplace`, `findAndReplaceWithMask`, `vm_map_write_user`,
  `orgVmMapWriteUser`, `vmProtect`, `injectPayload`, `injectSegment`.

## Classification
`D97DO_SITE_MUTATION_CAPABILITY=ABSENT_STATIC_PROVEN`
`D97DO_CAVE_ONLY_BOOTARG_FAIL_CLOSED=STATIC_PROVEN`
`D97DO_CAVE_ONE_SHOT_WRITE=STATIC_PROVEN`
`D97DO_CROSS_PID_PROPAGATION_CLASSIFIER=STATIC_PROVEN`
`D97DO_FULL_FUNCTIONAL_ARG_BLOCKED=STATIC_PROVEN`
`D97DO_SOURCE_STATIC_AUDIT=PASS`
`D97DO_BUILD=UNTESTED`

## Authorization boundary
This design does not authorize Root Patch or accelerated boot.
Its intended first functional write is CAVE-only and inert because SITE remains native.
