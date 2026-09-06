# OCLP7 CHECKPOINT — 2026-09-06 — D97CR kext load PROVEN; early-log channel inconclusive; D97CS sysctl telemetry source ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CQ_EFI_DEPLOY_PASS_VESA_RUNTIME_READY.md` for current execution state.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- D97CO observe-only `OCLPMetalCompat.kext` `0.0.1` was identity-pinned into active OpenCore EFI by D97CQ.
- Boot remained VESA with `-igfxvesa`; `-ocmcdiag` was explicitly added.
- No Root Patch, no accelerated boot, no functional D97BV page mutation.

## D97CR returned runtime evidence
Returned ZIP: `OCLP7_D97CR_D97CO_RUNTIME_20260906_180624.zip`.
- ZIP bytes: `1345`.
- ZIP SHA256: `91209b0dd50cc0b53501c4cc0cc7d8571f3661625d3cebc633477f1cf55bef3b`.
- TXT: `OCLP7_D97CR_D97CO_RUNTIME_20260906_180624.txt`.
- TXT bytes: `2889`.
- TXT SHA256: `c83764f2868a066982eeb28106a6f0c9a64d8df221a9527380ea9e706939227c`.

Boot facts:
- build `25G82`;
- boot time `2026-09-06 18:00:31 +0300`;
- `kern.bootargs` includes both `-igfxvesa` and `-ocmcdiag`.

Loaded kext state from `kmutil showloaded`:
- Lilu `1.7.3` loaded;
- WhateverGreen `1.7.1` loaded;
- `com.oclpmetalcompat.OCLPMetalCompat (0.0.1)` loaded;
- OCLPMetalCompat Mach-O UUID exact `319A3777-1BB1-3395-9E7A-6A0426C58723`, matching the audited D97CO build.

Unified-log evidence:
- kernelmanagerd emitted a load notification for `com.oclpmetalcompat.OCLPMetalCompat`;
- `log show --last boot` captured no D97CO route/site/cave markers;
- marker counts were all zero for `D97CO_ROUTE_CS_VALIDATE_PAGE`, `D97CO_SITE_SEEN`, `D97CO_CAVE_SEEN`, `D97CO_BUILD`, `D97CO_INACTIVE`.

## Correct classification
`D97CR_OCLPMETALCOMPAT_KEXT_LOAD=RUNTIME_PROVEN`.

`D97CR_OCMCDIAG_BOOTARG_ACTIVE=RUNTIME_PROVEN`.

The zero unified-log marker counts are **not** a hard negative for hook registration/timing. Lilu's own `kern_util.hpp` documents that printf buffering can cause early kernel/plugin messages not to appear in the boot log and exposes `liludelay` as a workaround. Therefore the D97CR observation channel is not strong enough to distinguish:
1. pluginStart/hook not reached; from
2. hook reached but early SYSLOG messages lost before unified-log persistence.

Authoritative classification:
`D97CR_UNIFIED_LOG_OBSERVATION_CHANNEL=INCONCLUSIVE_EARLY_KERNEL_LOG_BUFFERING`.

`D97CR_ROUTE_SITE_CAVE_TIMING=INCONCLUSIVE`.

Do **not** classify site/cave as NEGATIVE and do **not** authorize functional D97BV page writes from D97CR.

The kernelmanager_helper message that it could not find the identifier in its helper does not override `kmutil showloaded`; the kext load itself is directly proven by the loaded-kext table and exact UUID.

## D97CS — durable read-only sysctl telemetry source
A new branch preserves D97CO-v1 unchanged:
- branch `oclpmc-d97cs-sysctl-telemetry`;
- head `b1dabcc15d6131f4359927183315bc494b560576`;
- source path `OCLPMetalCompat/OCLPMetalCompat/kern_start.cpp`;
- source Git blob `a0808aec1de8a06ce97309c255278e04e025e851`.

D97CS keeps the same observe-only `_cs_validate_page` route and same exact Tahoe/Haswell/page/path gates. It adds only ephemeral read-only sysctl telemetry under `kern.ocmc_*` so the post-boot collector can read durable state without depending on early log persistence.

Telemetry covers:
- pluginStart reached;
- `-ocmcdiag`, Tahoe, exact `25G82`, Haswell and aggregate gate status;
- `_cs_validate_page` route status;
- raw site/cave page-offset observation;
- exact x86_64h shared-cache path match;
- site preimage status;
- cave 18-byte and full-208-byte zero status;
- Apple's `validated`, `tainted`, `nx` outputs for both target pages.

Static safety retained:
- original Apple validator is called first;
- validation `data` remains `const`;
- no `const_cast`;
- no `findAndReplace`;
- no `vm_map_write_user` / `orgVmMapWriteUser`;
- no `vmProtect`;
- no payload/segment injection;
- no D97BV functional replacement bytes are introduced by source logic;
- sysctl telemetry changes only ephemeral plugin-owned kernel variables/OID registration, not Metal/shared-cache page contents.

D97CS is source/static only at this checkpoint; compile/runtime proof is still required.

## CURRENT ACTION
ASUS2 remains in VESA; no Root Patch and no functional D97BV mutation.

Next bounded action:
1. compile D97CS `0.0.2` on the explicitly authorized iMac 9900K build host from exact head `b1dabcc15d6131f4359927183315bc494b560576`;
2. return the full build ZIP for independent binary/package audit;
3. only after audit replace D97CO `0.0.1` in EFI with D97CS `0.0.2` and perform one VESA diagnostic boot;
4. read `kern.ocmc_*` sysctls after boot;
5. functional D97BV remains unauthorized until route/site/cave timing and exact preimage/cave state are runtime-proven.
