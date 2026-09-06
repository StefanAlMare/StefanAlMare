# OCLP7 CHECKPOINT — 2026-09-06 — D97CS IOKit lifecycle PASS; persistent state channel ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CR_KEXT_LOADED_LOG_CHANNEL_INCONCLUSIVE_IOKIT_DISCRIMINATOR_READY.md` for current runtime state.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA diagnostic boot; `-igfxvesa -ocmcdiag` active.
- Audited observe-only `OCLPMetalCompat.kext` deployed and runtime-loaded.
- No Root Patch, no accelerated boot, no D97BV functional page mutation.

## D97CR retained result
`kmutil showloaded` proved exact D97CO binary runtime-loaded with UUID `319A3777-1BB1-3395-9E7A-6A0426C58723`, alongside Lilu `1.7.3` and WhateverGreen `1.7.1`.
Unified-log collection succeeded but captured zero D97CO marker lines, therefore logging channel remained INCONCLUSIVE and runtime timing remained UNPROVEN.

## Current-boot IOKit discriminator
Command:
`ioreg -r -c OCLPMetalCompat -l -w0`

Returned service:
- class `OCLPMetalCompat`;
- active;
- `CFBundleIdentifier = com.oclpmetalcompat.OCLPMetalCompat`;
- `IOMatchedAtBoot = Yes`;
- `VersionInfo = DBG-001-2026-09-06`;
- `IOProviderClass = IOResources`;
- `IOResourceMatch = IOKit`.

Interpretation:
- plugin bundle load is proven;
- standard Lilu-plugin IOKit personality/lifecycle is proven;
- `startSuccess`/probe-start path is sufficiently established for a persistent IORegistry state channel;
- absence of D97CO unified-log markers is now isolated to the observation/logging channel, not plugin non-loading/non-starting.

Authoritative classifications:
- `D97CS_OCLPMETALCOMPAT_IOKIT_LIFECYCLE=RUNTIME_PROVEN`;
- `D97CR_UNIFIED_LOG_MARKER_CHANNEL=INCONCLUSIVE_TOOLING_CHANNEL`;
- `D97CO_RUNTIME_TIMING=STILL_UNPROVEN`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## Next mechanism
Do not spend another reboot merely on unified-log retry.
Create D97CT observe-only successor using a persistent runtime state channel:
1. callback paths only update bounded atomic state/counters; no IORegistry allocation/write inside `_cs_validate_page`;
2. a preallocated asynchronous publisher transfers state to the existing `OCLPMetalCompat` IOService properties after callback execution;
3. retain all D97CO fail-closed gates: exact Tahoe `25G82`, Haswell, `-ocmcdiag`, exact x86_64h DSC path, exact page offsets and exact preimage/zero checks;
4. publish at minimum route status, site-seen count/preimage/validated/tainted/nx, cave-seen count/window18/full208/validated/tainted/nx;
5. remain observe-only: no page mutation, no `vm_map_write_user`, no `findAndReplace`, no injected payload/segment, no Root Patch.

The iMac 9900K remains the explicitly authorized local build host for this diagnostic-plugin lineage.

## CURRENT ACTION
Remain on current VESA boot; no reboot needed until D97CT is compiled/audited and identity-pinned deployment is ready.

IMAC: prepare/compile D97CT persistent-state diagnostic.
ASUS2: no change until an audited replacement kext is supplied.
