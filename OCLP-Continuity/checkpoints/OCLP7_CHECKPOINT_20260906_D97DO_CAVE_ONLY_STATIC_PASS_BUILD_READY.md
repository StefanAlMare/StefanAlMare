# OCLP7 CHECKPOINT — 2026-09-06 — D97DO CAVE-only one-shot static PASS; build ready

## Entering authority
ASUS2 remains on D97DL 0.0.7 in LATENT VESA mode:
- Tahoe 26.6.2 / 25G82;
- Haswell 8086:0412, MacBookAir6,2;
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args retain `-igfxvesa -ocmcdiag`;
- no `-ocmcd97bv`;
- no Root Patch.

D97DN runtime already proved exact D97DL 0.0.7 LATENT load, route/build PASS, SITE/CAVE write counts 0 and cave-first property channel PENDING as expected.

## Pre-functional safety finding
D97DL cave-first ordering protects SITE from being written before a CAVE mutation PASS, but the CAVE-ready state is global to the kext. Before relying on that state for a cross-page branch in another process/address space, propagation of the modified CAVE page must be characterized.

Therefore the first real write is narrowed further to CAVE-only.

## D97DO design
D97DO version target: 0.0.8.

D97DO is a one-shot CAVE-only functional propagation probe:
- dedicated boot arg `-ocmcd97bvcave`;
- full functional arg `-ocmcd97bv` is separately detected and blocks CAVE-only writes;
- SITE replacement bytes are absent from source;
- SITE write target is absent from source;
- SITE callback remains observation-only;
- exact CAVE payload is retained;
- first safe userspace CAVE callback may claim exactly one write via atomic CAS;
- writer PID is recorded with `proc_selfpid()`;
- later callbacks never rewrite CAVE;
- propagation classification occurs only on a different userspace PID from the writer PID.

Exact CAVE payload:
`3d187d0000b9177d00000f4cc1e9b4311600`.

## Propagation classifier
After a successful one-shot CAVE write:
- different PID sees exact postimage + safe Apple validation => propagation PASS;
- different PID sees original zero CAVE => propagation NEGATIVE;
- same writer PID is not used to classify cross-process propagation.

Runtime properties include:
- `D97DOFunctionalMode`;
- `D97DOSiteWriteBlocked`;
- `D97DOCaveWritePhase`;
- `D97DOCavePropagation`;
- `D97DOCaveWritePid`;
- `D97DOCavePropagationPid`;
- postimage/zero-after-write counters.

## Source authority
Byte-exact source is persisted as three ordered GitHub fragments:
- `OCLP7_D97DO_kern_start.part1.cpp`, blob `5308074eb75d76531eef19481ded76b641c3f301`;
- `OCLP7_D97DO_kern_start.part2.cpp`, blob `fac28701be3acae370866483b94d04d620d41916`;
- `OCLP7_D97DO_kern_start.part3.cpp`, blob `54861bd997619551e64c264f9e02b1d4e66c13b2`.

Authority commit containing all three plus static audit:
`52f286d6e693c88123fc11403608038f7982082e`.

Static audit artifact:
`OCLP-Continuity/artifacts/OCLP7_D97DO_STATIC_AUDIT.md`.

Static classifications:
- `D97DO_SITE_MUTATION_CAPABILITY=ABSENT_STATIC_PROVEN`;
- `D97DO_CAVE_ONLY_BOOTARG_FAIL_CLOSED=STATIC_PROVEN`;
- `D97DO_CAVE_ONE_SHOT_WRITE=STATIC_PROVEN`;
- `D97DO_CROSS_PID_PROPAGATION_CLASSIFIER=STATIC_PROVEN`;
- `D97DO_FULL_FUNCTIONAL_ARG_BLOCKED=STATIC_PROVEN`;
- `D97DO_SOURCE_STATIC_AUDIT=PASS`;
- `D97DO_BUILD=UNTESTED`.

## Build helper
Prepared local iMac build helper:
`OCLP7_D97DO_IMAC_BUILD_AUTHORITY.sh`
- SHA256 `7b3f34c058ffe8af6c8c8531afc870bfb550a0bb5d5bb52ab90f2b64a5136618`;
- `bash -n` PASS;
- clones exact authority commit;
- verifies all three Git blob identities;
- reconstructs source in exact part1+part2+part3 order;
- target version 0.0.8;
- binary audit requires CAVE payload present and full SITE replacement absent.

## CURRENT ACTION
Build D97DO 0.0.8 on the already-authorized iMac 9900K host and return the ZIP for independent audit.

ASUS2 must remain unchanged on D97DL 0.0.7 LATENT.
No boot-arg change, functional write, Root Patch or reboot is authorized until D97DO build/binary audit passes.