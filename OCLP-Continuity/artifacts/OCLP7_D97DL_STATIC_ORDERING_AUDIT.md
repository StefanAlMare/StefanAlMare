# OCLP7 D97DL — cave-first cross-page ordering hardening static audit

Date: 2026-09-06 EEST

## Trigger
D97DK proved D97DI 0.0.6 is safely LATENT at runtime: `D97DIFunctionalMode=LATENT`, `D97DIFunctionalRequested=0`, SITE/CAVE write counts both zero, route/build PASS.

Before arming `-ocmcd97bv`, source review identified one remaining functional ordering hazard in D97DI: SITE and CAVE are on different validation pages, and D97DI could write SITE whenever its own preimage/safety gates passed without requiring the CAVE trampoline page to have been mutated first.

Because SITE's non-3802 path branches into CAVE, a SITE-first functional write would create an unsafe cross-page dependency window. Natural VESA evidence shows CAVE faults before SITE, but that observation is not accepted as a universal ordering guarantee for future accelerated execution.

Therefore D97DI functional activation is NOT authorized.

## D97DL design
D97DL version target: `0.0.7`.

D97DL preserves the exact D97DI/D97BV payload and every existing fail-closed gate, and adds a cave-first prerequisite before any SITE write:

1. CAVE callback still requires exact main x86_64h path/page, exact 25G82, `-ocmcd97bv`, Apple validated `0xF`, tainted 0, NX 0, and exact zero/postimage invariants.
2. CAVE mutation state is published with release semantics after the CAVE bytes/postimage are complete.
3. SITE callback performs an acquire load of `d97diCaveMutationState`.
4. SITE write is allowed only when that state is exactly PASS (`1`).
5. If SITE arrives before CAVE PASS, D97DL records `D97DLSiteCavePrereq=WAITING_CAVE` and returns without modifying SITE.
6. Therefore a premature SITE fault remains native Tahoe behavior rather than creating a branch into an unprepared cave.

## Exact payload unchanged
SITE original:
`3d187d0000b9177d00000f4cc1`

SITE replacement:
`3dda0e00007406e93bcee9ff90`

CAVE replacement:
`3d187d0000b9177d00000f4cc1e9b4311600`

Control-flow arithmetic remains unchanged and previously PROVEN:
- exact 3802 -> SITE+13;
- non-3802 -> exact CAVE;
- CAVE begins with exact original Tahoe floor sequence;
- CAVE -> SITE+13.

## New runtime evidence
D97DL adds:
- `D97DLSiteCavePrereq=PENDING|WAITING_CAVE|PASS`.

In the future ACTIVE VESA test, CAVE must be proven mutation PASS before SITE is actively faulted. The active collector must fault/verify CAVE first, then SITE.

## Static source identity
Authoritative source:
`OCLP-Continuity/artifacts/OCLP7_D97DL_kern_start.cpp`

- SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- Git blob `af52267e8e5fbbc975715b1c3a7a3fceab994c1b`;
- source commit `2c5268c1e57a5b0a7e555d18fb0e5010f8855a87`.

## Static audit results
- D97BV SITE payload unchanged: PASS.
- D97BV CAVE payload unchanged: PASS.
- Existing exact build/path/page/Apple-validation/bootarg gates retained: PASS.
- `D97DLSiteCavePrereq` property present: PASS.
- explicit `WAITING_CAVE` state present: PASS.
- SITE uses acquire load of CAVE mutation state before any SITE write: PASS.
- CAVE success publishes mutation state with release semantics after postimage verification: PASS.
- CAVE already-patched/failure state helper stores now use release semantics: PASS.
- SITE write remains fixed 13 bytes at `+0x719`: PASS.
- CAVE write remains fixed 18 bytes at `+0x560`: PASS.
- no broad `findAndReplace` or masked search/replace path: PASS.
- no `vm_map_write_user`, `vmProtect`, payload/segment injection API: PASS.
- default state without `-ocmcd97bv` remains LATENT: PASS.

## Classifications
`D97DK_D97DI_LATENT_RUNTIME=PASS`
`D97DI_CROSS_PAGE_SITE_BEFORE_CAVE_FUNCTIONAL_ORDERING=UNSAFE_UNGUARDED`
`D97DI_FUNCTIONAL_ACTIVATION=BLOCKED_SUPERSEDED_BY_D97DL`
`D97DL_CAVE_FIRST_PREREQUISITE=STATIC_PROVEN`
`D97DL_CAVE_RELEASE_SITE_ACQUIRE_ORDERING=STATIC_PROVEN`
`D97DL_SITE_FAIL_CLOSED_IF_CAVE_NOT_READY=STATIC_PROVEN`
`D97DL_D97BV_PAYLOAD_IDENTITY=STATIC_PROVEN`
`D97DL_SOURCE_STATIC_AUDIT=PASS`
`D97DL_BUILD=UNTESTED`

## Authorization boundary
Authorized now only because the iMac 9900K build host was previously authorized for this OCLPMetalCompat lineage:
- build D97DL 0.0.7 on iMac;
- return ZIP for independent audit.

Not authorized:
- deploy D97DL to ASUS2 before build audit;
- add `-ocmcd97bv`;
- functional D97BV mutation;
- Root Patch;
- accelerated boot.
