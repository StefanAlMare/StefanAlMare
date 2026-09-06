# OCLPMetalCompat — D97CO observe-only prototype

Status: **source-only / not built / not deployed**.

This branch contains the first narrow OCLP-specific Lilu plugin prototype for the ASUS2 Tahoe Haswell project. It does **not** modify Lilu, WhateverGreen, the dyld shared cache, Metal.framework, the system volume, or any userspace page.

## D97CO purpose

Prove the runtime timing/provenance assumption behind the native-shared-cache delivery path before applying D97BV functionally.

The plugin hooks `_cs_validate_page` using the same Lilu/KernelPatcher substrate used by FeatureUnlock on Big Sur and later. Apple's original validator is always called first. The observer then examines only two exact 4K page offsets from the main `dyld_shared_cache_x86_64h` vnode:

- D97BV site page: `page_offset 0xF5E1000`, target offset within page `0x719`;
- D97BV cave page: `page_offset 0xF47E000`, target offset within page `0x560`.

D97CN proved both locations are in the main x86_64h cache vnode UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`, mapping index 0 (`r-x`), and that the raw cache bytes exactly match the retained D97BV preimages.

## Fail-closed gates

D97CO registers the hook only when all of the following hold:

1. explicit boot argument `-ocmcdiag` is present;
2. Lilu reports `KernelVersion::Tahoe`;
3. `kern.osversion` equals exact build `25G82`;
4. Lilu reports CPU generation Haswell.

Inside the hook, the observer returns immediately unless `page_offset` is one of the two D97BV offsets. It then requires the vnode path to be a dyld shared-cache path whose suffix is exactly `/dyld_shared_cache_x86_64h`.

## Observation markers

Expected log markers if the timing hypothesis is correct:

- `D97CO_ROUTE_CS_VALIDATE_PAGE=PASS`
- `D97CO_SITE_SEEN ... preimage=PASS ...`
- `D97CO_CAVE_SEEN ... window18=PASS full208=PASS ...`

The observer also records Apple's `validated`, `tainted`, and `nx` output state after the original `cs_validate_page` returns.

## Safety

D97CO contains no write to `data`, no `const_cast` of the validation buffer, no `KernelPatcher::findAndReplace`, no `vm_map_write_user`, no Root Patch logic, and no reboot logic. It is an observation-only timing probe.

The future functional phase must remain separately authorized and must fail closed on exact vnode/page/preimage identity before writing the D97BV site and cave payloads.

## Build state

No build/package workflow is executed in this phase. Project rules currently suspend GitHub Actions build/package until explicit confirmation that the quota/blocker is cleared. Local compilation is not an implicit fallback.
