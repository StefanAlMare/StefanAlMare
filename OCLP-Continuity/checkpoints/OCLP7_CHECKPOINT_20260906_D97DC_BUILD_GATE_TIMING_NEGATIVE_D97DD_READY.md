# OCLP7 CHECKPOINT — 2026-09-06 — D97DC build-gate timing NEGATIVE; D97DD ready

Authority: supersedes the D97DB deploy-ready checkpoint for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA diagnostic boot only; `-igfxvesa` and `-ocmcdiag` retained.
- No active Root Patch.
- Active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- D97DB successfully replaced D97CT 0.0.2 with D97CY 0.0.3 while preserving config byte-identically.
- D97CY executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`, UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`.

## D97DC returned evidence
Returned ZIP: `OCLP7_D97DC_D97CY_VESA_RUNTIME_20260906_202541.zip`.
- bytes: `1708`.
- SHA256: `ded250e9bd9a086ba343b9e89dea6bc74870dcad0b7d5e50a33737a38b847de6`.

Inner TXT:
- bytes: `3712`.
- SHA256: `d6dbba3234acb1950000f753a1e28c511a9d258a2de68d335bc645ec1148e7ce`.

Boot time: `Sun Sep 6 20:20:35 2026`.
Runtime boot args retain both `-igfxvesa` and `-ocmcdiag`.

## Runtime identity proof
`kmutil showloaded` proves:
- Lilu `1.7.3`, UUID `38ACFA46-F60C-3795-B868-EF32F98C78ED`;
- D97CY `OCLPMetalCompat` `0.0.3`, UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`;
- WhateverGreen `1.7.1`, UUID `823C2949-3D4D-32C0-97B7-2D92BD231B33`.

IORegistry service is active and exposes:
- `VersionInfo = DBG-003-2026-09-06`;
- `D97CTChannel = IORegistry-AtomicAsync-v1`;
- `D97CYBuildGateMethod = kernel-global-osversion-v1`;
- `D97CYObservedBuild = 25G82`.

Classification:
`D97DC_D97CY_KEXT_RUNTIME_LOAD=PROVEN`.
`D97DC_D97CY_IOREG_PERSISTENT_CHANNEL=PROVEN`.

## Gate / route evidence
Persistent state:
- `D97CTBootArgGate = 1` PASS;
- `D97CTKernelGate = 1` PASS;
- `D97CTCpuGate = 1` PASS;
- `D97CTBuildGate = 2` NEGATIVE;
- `D97CTRouteStatus = PENDING` NOT ATTEMPTED;
- `D97CTSiteSeenCount = 0`;
- `D97CTCaveSeenCount = 0`;
- `D97CTPublisherTicks = 300`.

At the same time the asynchronous publisher reads the same kernel-global `osversion[]` later and publishes exact `25G82`.

Source review shows D97CY sets `buildGate` only once inside `lilu.onPatcherLoadForce`, before routing. Therefore the only interpretation consistent with runtime is that `osversion[]` was still empty/uninitialized at the patcher-load callback, causing the fail-closed build gate to latch NEGATIVE. Later, after kernel initialization progressed, the publisher observed `osversion[] = 25G82` correctly.

This is a timing/tooling negative of the gate placement, not a real OS-build mismatch and not evidence against `_cs_validate_page` routing or target-page timing.

Authoritative classifications:
- `D97DC_BOOTARG_GATE=PASS`;
- `D97DC_KERNEL_GATE=PASS`;
- `D97DC_CPU_GATE=PASS`;
- `D97DC_PATCHERLOAD_OSVERSION_TIMING_GATE=NEGATIVE`;
- `D97DC_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97DC_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97DD repair direction
D97DD must preserve all observe-only safety properties but relocate the exact-build check:
1. keep bootarg, Tahoe-major and Haswell gates in `pluginStart`;
2. install the `_cs_validate_page` route in the Lilu patcher-load callback without consulting `osversion[]` there;
3. inside `patchedCsValidatePage`, call Apple original first;
4. increment a bounded atomic callback-seen counter;
5. then evaluate `osversion == 25G82` on every callback and update the persistent build gate;
6. if the exact build does not match, return immediately with no target-page observation and no mutation;
7. only after exact-build PASS may site/cave path/page/preimage checks execute;
8. publish a new method marker and callback count through IORegistry;
9. still contain no D97BV replacement bytes, no shared-cache writes and no Root Patch logic.

This preserves fail-closed exact-build behavior while evaluating the build string only at a phase where it is expected to be initialized.

## CURRENT ACTION
Prepare and compile D97DD `OCLPMetalCompat.kext` version `0.0.4` on the already-authorized iMac 9900K local build host, audit it independently, and do not alter ASUS2 EFI until that audit passes.

No Root Patch, accelerated boot or functional D97BV shared-cache mutation is authorized.
