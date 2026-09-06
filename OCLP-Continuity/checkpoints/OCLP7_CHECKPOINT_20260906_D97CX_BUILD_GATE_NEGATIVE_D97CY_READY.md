# OCLP7 CHECKPOINT — 2026-09-06 — D97CX build-gate implementation NEGATIVE; D97CY ready

Authority: supersedes the prior D97CW/D97CX runtime-ready state for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA diagnostic boot only; `-igfxvesa` and `-ocmcdiag` retained.
- D97CT `OCLPMetalCompat.kext` version `0.0.2` was deployed successfully in EFI by D97CW.
- D97CT compiled executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.
- No Root Patch, no accelerated boot, no D97BV functional page mutation.

## D97CX returned artifact
Returned ZIP: `OCLP7_D97CX_D97CT_IOREG_RUNTIME_20260906_193502.zip`.
- ZIP bytes: `1508`.
- ZIP SHA256: `926e3ed1dd5ed2df8e129c4ff78cfa1ae7c8513d5b3eb83b6063881d83374bdb`.

Inner TXT:
- bytes: `2946`.
- SHA256: `2e622de31dfe1f7cd7abfcc5483cb09af57c6130b56134ff672e99938cadc0c7`.

Boot time: `Sun Sep 6 19:30:34 2026`.

Runtime boot args retain both `-igfxvesa` and `-ocmcdiag`.

## Runtime identity proof
`kmutil showloaded` proves D97CT `0.0.2` is loaded:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`;
- Lilu `1.7.3` loaded;
- WhateverGreen `1.7.1` loaded.

IORegistry service is active and exposes `VersionInfo = DBG-002-2026-09-06` and `D97CTChannel = IORegistry-AtomicAsync-v1`.

Classification:
`D97CX_D97CT_KEXT_RUNTIME_LOAD=PROVEN`.
`D97CX_D97CT_IOREG_PERSISTENT_CHANNEL=PROVEN`.

## Gate evidence
Persistent IORegistry state:
- `D97CTBootArgGate = 1` PASS;
- `D97CTKernelGate = 1` PASS;
- `D97CTBuildGate = 2` NEGATIVE;
- `D97CTCpuGate = 0` NOT REACHED;
- `D97CTRouteStatus = PENDING` NOT ATTEMPTED;
- `D97CTSiteSeenCount = 0`;
- `D97CTCaveSeenCount = 0`;
- publisher reached at least tick 274.

Because D97CT returns immediately when its exact-build gate fails, this run does **not** test `_cs_validate_page` routing or page timing.

Authoritative classifications:
- `D97CX_BOOTARG_GATE=PASS`;
- `D97CX_KERNEL_GATE=PASS`;
- `D97CX_EARLY_SYSCTL_BUILD_GATE_IMPLEMENTATION=NEGATIVE`;
- `D97CX_CPU_GATE=NOT_REACHED`;
- `D97CX_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97CX_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## Root cause / repair direction
D97CT implemented exact build matching via early `sysctlbyname("kern.osversion", ...)` in `pluginStart`. Runtime proves that mechanism returned false during this early phase even though the booted OS is independently `25G82`.

XNU exports the kernel-global `osversion[]`, and the pinned MacKernelSDK declares the same symbol in `libkern/version.h`. D97CY therefore removes the early `sysctlbyname` build query and compares the exported kernel-global `osversion` directly to `25G82`, fail-closed.

D97CY additionally:
- publishes `D97CYBuildGateMethod = kernel-global-osversion-v1`;
- publishes `D97CYObservedBuild = osversion`;
- performs the exact build gate inside the existing Lilu patcher-load callback immediately before `_cs_validate_page` routing;
- preserves the same read-only validation callback and atomic/IORegistry observation channel;
- contains no D97BV functional replacement bytes or validation-page writes.

## CURRENT ACTION
Build D97CY `OCLPMetalCompat.kext` version `0.0.3` on the already-authorized iMac 9900K local build host, return the build ZIP for independent audit, and do not alter ASUS2 EFI until that audit passes.

No Root Patch, accelerated boot or functional shared-cache mutation is authorized.
