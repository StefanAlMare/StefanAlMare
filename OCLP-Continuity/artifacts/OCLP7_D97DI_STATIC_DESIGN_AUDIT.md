# OCLP7 D97DI — latent functional D97BV static design audit

Date: 2026-09-06 EEST

## Authority / input
D97DG closed the runtime delivery prerequisite on exact Tahoe 25G82:
- D97DD `_cs_validate_page` route runtime PROVEN;
- callback execution runtime PROVEN;
- callback exact-build `25G82` gate runtime PROVEN;
- SITE active fault runtime PROVEN with exact original 13-byte preimage, Apple validated-all `0xF`, tainted 0, NX 0;
- CAVE active fault runtime PROVEN with full 208-byte zero invariant, first 18-byte zero window, Apple validated-all `0xF`, tainted 0, NX 0.

D97DH is superseded and must not be deployed.

## D97DI design
D97DI is version `0.0.6`.

D97DI preserves the D97DD route and observation substrate and adds the exact D97BV mutations behind a second explicit functional boot argument:
`-ocmcd97bv`.

Without that boot argument, D97DI remains latent/observe-only even if installed.

The existing `-ocmcdiag` gate remains required to install the route.

## Exact functional bytes
SITE original:
`3d187d0000b9177d00000f4cc1`

SITE replacement:
`3dda0e00007406e93bcee9ff90`

CAVE replacement:
`3d187d0000b9177d00000f4cc1e9b4311600`

Static target arithmetic:
- SITE VM `0x7FF80F5E1719`;
- SITE non-3802 rel32 target = exact CAVE VM `0x7FF80F47E560`;
- SITE exact-3802 `JE +6` target = exact original continuation `SITE+13`;
- CAVE rel32 return target = exact original continuation `SITE+13`.

Semantic closure:
- exact input `3802` bypasses the Tahoe floor;
- every non-3802 input executes the exact original 13-byte Tahoe floor sequence in CAVE, then returns to the original continuation.

## Functional fail-closed gates
A page write is possible only after all of the following:
1. `-ocmcdiag` enables the plugin route;
2. exact Tahoe kernel family gate;
3. exact Haswell CPU-generation gate;
4. `_cs_validate_page` route succeeds;
5. Apple original `_cs_validate_page` executes first;
6. callback exact-build gate `osversion == 25G82`;
7. exact target page offset is SITE or CAVE;
8. vnode path resolves to the main `dyld_shared_cache_x86_64h`;
9. `data` is non-null;
10. explicit functional boot arg `-ocmcd97bv` is present;
11. Apple result is exactly `validated=0xF`, `tainted=0`, `nx=0`;
12. SITE exact 13-byte preimage matches before SITE write; or CAVE full 208-byte zero + first 18-byte zero invariants match before CAVE write.

No broad search/replace API is used. Writes are direct, fixed-size and fixed-offset:
- SITE: exactly 13 bytes at in-page `0x719`;
- CAVE: exactly 18 bytes at in-page `0x560`.

Post-write verification is mandatory in the callback:
- SITE exact postimage;
- CAVE exact 18-byte postimage plus zero tail through the retained 208-byte cave window.

## Idempotency / repeat validation handling
If an exact target postimage is already present, no second write is performed.
Such an already-patched observation can only be classified mutation-PASS when Apple's validation result for that callback is also safe.

Preimage/Apple-result observation state is latched from the first target-page observation so later callbacks cannot overwrite the original runtime evidence.

## Runtime evidence properties added
- `D97DIFunctionalBootArg`
- `D97DIFunctionalMode` (`LATENT` or `ACTIVE`)
- `D97DIFunctionalRequested`
- `D97DISiteSafety`
- `D97DISiteMutation`
- `D97DISitePostimage`
- `D97DISiteWriteCount`
- `D97DICaveSafety`
- `D97DICaveMutation`
- `D97DICavePostimage`
- `D97DICaveTailZeroAfter`
- `D97DICaveWriteCount`

When functional mode is ACTIVE, the asynchronous publisher does not stop merely because SITE+CAVE were seen; it also waits until both functional mutation outcomes are resolved, preventing an observation-race at completion.

## Upstream implementation precedent
Pinned FeatureUnlock commit `201bd45766207e6cc10cd40a8ac1f9c6216f9acb` uses the same architectural order for Big Sur and newer:
Apple original `cs_validate_page` first, then shared-cache page modification through the callback buffer.

D97DI is materially narrower than FeatureUnlock's search-based page patching: it uses exact path + exact page offset + exact preimage + exact fixed write windows.

## Static audit
- source SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- iMac build script SHA256 `c016f4dd21de9e7debf72fe772109e50b31c7098953eb8de3856f4b2675f1fa8`;
- build script `bash -n` PASS;
- D97BV site bytes exact PASS;
- D97BV cave bytes exact PASS;
- SITE rel32 -> CAVE exact PASS;
- CAVE rel32 -> SITE+13 exact PASS;
- exact 3802 bypass branch exact PASS;
- original Tahoe floor copied intact into CAVE PASS;
- Apple-original-first ordering PASS;
- build/path/page/safety/functional gates all precede writes PASS;
- default functional state latent PASS;
- no `findAndReplace` / `findAndReplaceWithMask`;
- no `vm_map_write_user` / `orgVmMapWriteUser`;
- no `vmProtect`;
- no payload/segment injection API;
- no Root Patch / EFI / reboot logic in plugin.

## Classifications
`D97DI_D97BV_CONTROL_FLOW=STATIC_SEMANTIC_PROVEN`
`D97DI_FUNCTIONAL_BOOTARG_FAIL_CLOSED=STATIC_PROVEN`
`D97DI_APPLE_VALIDATION_SAFETY_GATE=STATIC_PROVEN`
`D97DI_SITE_WRITE_BOUND=STATIC_PROVEN`
`D97DI_CAVE_WRITE_BOUND=STATIC_PROVEN`
`D97DI_POSTIMAGE_VERIFICATION=STATIC_PROVEN`
`D97DI_LATENT_DEFAULT=STATIC_PROVEN`
`D97DI_SOURCE_STATIC_AUDIT=PASS`
`D97DI_BUILD=UNTESTED`

## Authorization boundary
This artifact authorizes only build/audit of D97DI on the already-authorized iMac 9900K local build host.

It does **not** authorize:
- ASUS2 deployment;
- adding `-ocmcd97bv`;
- functional page mutation;
- Root Patch;
- accelerated boot;
- reboot.
