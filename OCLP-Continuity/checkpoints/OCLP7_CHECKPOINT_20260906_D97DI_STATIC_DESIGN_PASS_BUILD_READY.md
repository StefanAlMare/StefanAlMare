# OCLP7 CHECKPOINT — 2026-09-06 — D97DI latent functional design STATIC PASS; build ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DG_SITE_CAVE_RUNTIME_PROVEN_FUNCTIONAL_DESIGN_READY.md` for current execution.

## Entering runtime authority
ASUS2 remains unchanged:
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- unpatched VESA;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args retain `-igfxvesa -ocmcdiag`;
- D97DD `OCLPMetalCompat.kext` 0.0.4 remains deployed;
- executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

No Root Patch and no functional D97BV page mutation have been performed.

D97DG already proved the complete runtime delivery prerequisite on exact 25G82:
- `_cs_validate_page` route PASS;
- callback execution PASS;
- callback exact-build gate PASS;
- SITE exact preimage runtime PASS, Apple validated `0xF`, tainted 0, NX 0;
- CAVE full208 zero + functional18 zero runtime PASS, Apple validated `0xF`, tainted 0, NX 0.

## D97DI design
D97DI is the first functional-capable successor, version `0.0.6`.

It preserves the proven D97DD route/callback/build/path/page observation architecture and adds D97BV writes only behind the explicit second boot argument:
`-ocmcd97bv`.

The existing `-ocmcdiag` remains necessary to install the route.
Without `-ocmcd97bv`, D97DI is LATENT / observe-only and performs zero page writes.

## Exact D97BV payload
SITE original:
`3d187d0000b9177d00000f4cc1`

SITE replacement:
`3dda0e00007406e93bcee9ff90`

CAVE replacement:
`3d187d0000b9177d00000f4cc1e9b4311600`

Static arithmetic re-audit:
- SITE non-3802 rel32 lands exactly at CAVE `0x7FF80F47E560`;
- exact 3802 `JE +6` lands exactly at SITE+13 and bypasses the Tahoe floor;
- CAVE begins with the exact original 13-byte Tahoe floor sequence;
- CAVE rel32 returns exactly to SITE+13.

Classification:
`D97DI_D97BV_CONTROL_FLOW=STATIC_SEMANTIC_PROVEN`.

## Functional fail-closed gate order
A write can occur only after:
1. plugin route enabled by `-ocmcdiag`;
2. Tahoe kernel-family gate;
3. Haswell CPU gate;
4. routed Apple `_cs_validate_page` original executes first;
5. exact `osversion == 25G82` callback gate;
6. exact SITE/CAVE page offset;
7. exact main `dyld_shared_cache_x86_64h` vnode suffix;
8. non-null callback page buffer;
9. explicit `-ocmcd97bv` functional request;
10. Apple result exactly `validated=0xF`, `tainted=0`, `nx=0`;
11. exact SITE preimage or exact CAVE zero invariants.

Writes are fixed-offset/fixed-size only:
- SITE 13 bytes at in-page `0x719`;
- CAVE 18 bytes at in-page `0x560`.

No broad search/replace is used.
Postimage is verified immediately after each write; CAVE additionally verifies the remaining tail through the proven 208-byte window remains zero.

## Repeat-validation / publication hardening
- already-patched pages are not written twice;
- an already-patched observation is mutation-PASS only if Apple's validation result for that callback is also safe;
- first preimage/validation evidence is latched and not overwritten by later callbacks;
- when functional mode is ACTIVE, publisher completion waits for both SITE and CAVE mutation outcomes to resolve, avoiding a race where seen-counts could stop publication before mutation state is visible.

## Runtime properties added
- `D97DIFunctionalBootArg`;
- `D97DIFunctionalMode`;
- `D97DIFunctionalRequested`;
- SITE safety/mutation/postimage/write-count;
- CAVE safety/mutation/postimage/tail-zero/write-count.

## Upstream precedent
Pinned FeatureUnlock commit `201bd45766207e6cc10cd40a8ac1f9c6216f9acb` uses Apple-original-first `cs_validate_page` and then modifies the shared-cache page callback buffer. D97DI is narrower: exact vnode suffix + exact page offset + exact preimage + exact fixed write windows.

## Source / static audit identity
GitHub-persisted source:
`OCLP-Continuity/artifacts/OCLP7_D97DI_kern_start.cpp`
- source SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Static design audit:
`OCLP-Continuity/artifacts/OCLP7_D97DI_STATIC_DESIGN_AUDIT.md`
- SHA256 `ba904670495c8a70daad5bdb807debbbe8ca63cfd1d4383fb58916633737ddd0`;
- Git blob `08eec8fb1ed0767bba66a5c79fbc3590d0987241`.

Prepared iMac build helper:
- SHA256 `bbd360dd870e6e0395693cf1fd2caf777ab2cb9c5ddcab02fad8428e8955714e`;
- `bash -n` PASS;
- exact source SHA is pinned inside the helper;
- output version `0.0.6`;
- binary audit requires both exact D97BV replacement payloads and all D97DI marker strings;
- deploy authorization remains NO.

Authoritative static classifications:
- `D97DI_D97BV_CONTROL_FLOW=STATIC_SEMANTIC_PROVEN`;
- `D97DI_FUNCTIONAL_BOOTARG_FAIL_CLOSED=STATIC_PROVEN`;
- `D97DI_APPLE_VALIDATION_SAFETY_GATE=STATIC_PROVEN`;
- `D97DI_SITE_WRITE_BOUND=STATIC_PROVEN`;
- `D97DI_CAVE_WRITE_BOUND=STATIC_PROVEN`;
- `D97DI_POSTIMAGE_VERIFICATION=STATIC_PROVEN`;
- `D97DI_LATENT_DEFAULT=STATIC_PROVEN`;
- `D97DI_SOURCE_STATIC_AUDIT=PASS`;
- `D97DI_BUILD=UNTESTED`.

## CURRENT ACTION
Build D97DI 0.0.6 on the already-authorized iMac 9900K local build host and return the resulting ZIP for independent audit.

ASUS2 remains unchanged on D97DD 0.0.4.

This checkpoint does **not** authorize:
- deploying D97DI to ASUS2;
- adding `-ocmcd97bv`;
- functional page mutation;
- Root Patch;
- accelerated boot;
- reboot.
