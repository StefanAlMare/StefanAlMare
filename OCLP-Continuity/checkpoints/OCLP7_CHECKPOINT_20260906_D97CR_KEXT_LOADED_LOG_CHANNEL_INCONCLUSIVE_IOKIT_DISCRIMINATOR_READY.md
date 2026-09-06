# OCLP7 CHECKPOINT — 2026-09-06 — D97CR kext loaded; log channel inconclusive; current-boot IOKit discriminator ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CQ_EFI_DEPLOY_PASS_VESA_RUNTIME_READY.md` for current runtime evidence state.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA diagnostic boot only; `-igfxvesa` retained.
- D97CO audited observe-only `OCLPMetalCompat.kext` deployed in EFI.
- Explicit `-ocmcdiag` present.
- No Root Patch, no accelerated boot, no D97BV functional page mutation.

## D97CR returned artifact
Returned ZIP: `OCLP7_D97CR_D97CO_RUNTIME_20260906_180624.zip`.
- ZIP bytes: `1345`.
- ZIP SHA256: `91209b0dd50cc0b53501c4cc0cc7d8571f3661625d3cebc633477f1cf55bef3b`.

Inner TXT:
- bytes: `2889`;
- SHA256: `c83764f2868a066982eeb28106a6f0c9a64d8df221a9527380ea9e706939227c`.

Boot time:
- `Sun Sep 6 18:00:31 2026`.

Runtime boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag`

## Kext load proof
`kmutil showloaded` proves exact D97CO binary is loaded:
- `com.oclpmetalcompat.OCLPMetalCompat (0.0.1)`;
- UUID `319A3777-1BB1-3395-9E7A-6A0426C58723`;
- Lilu `1.7.3` loaded;
- WhateverGreen `1.7.1` loaded.

Kernelmanager also reports a kext load notification for `com.oclpmetalcompat.OCLPMetalCompat`.

Classification:
`D97CR_D97CO_KEXT_RUNTIME_LOAD=PROVEN`.

## Unified-log result
Current-boot unified-log collection succeeded (`LOG_SHOW_RC=0`) but returned no plugin marker lines:
- `D97CO_ROUTE_CS_VALIDATE_PAGE_COUNT=0`;
- `D97CO_SITE_SEEN_COUNT=0`;
- `D97CO_CAVE_SEEN_COUNT=0`;
- `D97CO_BUILD_COUNT=0`;
- `D97CO_INACTIVE_COUNT=0`.

The log did prove `-ocmcdiag` appears in launchd/kernel boot-args.

## Interpretation
This result is **not** evidence that the `_cs_validate_page` hook or target pages were absent.

Reason:
1. the exact D97CO kext is runtime-loaded;
2. Tahoe 25G82 and `-ocmcdiag` are independently proven from the same boot;
3. even the early `D97CO_BUILD`/inactive messages are absent from unified log;
4. Lilu `SYSLOG` ultimately uses `lilu_os_log`, which emits `IOLog` only when interrupts are enabled; Lilu source explicitly documents missing early output/buffering and provides `liludelay` as a workaround.

Therefore absence of all D97CO marker strings is a **logging/observation-channel ambiguity**, not a hard runtime hook NEGATIVE.

Authoritative classification:
`D97CR_UNIFIED_LOG_MARKER_CHANNEL=INCONCLUSIVE`.
`D97CR_D97CO_RUNTIME_TIMING=UNPROVEN`.
`D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## Current action — no reboot yet
Before changing source or consuming another boot, use the current running boot to test whether the standard Lilu-plugin IOKit personality is alive.

Run read-only on ASUS2:
`ioreg -r -c OCLPMetalCompat -l -w0`

Interpretation:
- if an `OCLPMetalCompat` service with `VersionInfo` is present, plugin `startSuccess`/IOKit lifecycle is proven and the missing D97CO messages are further isolated to the output channel; proceed to a more robust runtime evidence channel (IORegistry/state publication or an audited debug-delay retry), not functional D97BV.
- if no service exists, inspect plugin-start/shouldLoad/IOKit lifecycle before any further runtime adapter work.

No EFI mutation, no Root Patch, no reboot and no functional shared-cache mutation are authorized by this checkpoint.
