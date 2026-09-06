# OCLP7 CHECKPOINT — 2026-09-06 — D97DF route/callback/build/cave runtime PROVEN; site active-fault next

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DE_D97DD_DEPLOY_PASS_RUNTIME_READY.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Unpatched VESA only; `-igfxvesa -ocmcdiag` retained.
- Active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- D97DD `OCLPMetalCompat.kext` 0.0.4 deployed, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`, UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.
- No Root Patch and no functional D97BV shared-cache mutation.

## Returned D97DF evidence
Returned ZIP: `OCLP7_D97DF_D97DD_VESA_RUNTIME_20260906_205320.zip`.
- ZIP bytes: `1783`.
- ZIP SHA256: `7cfe5586dd5671da1ae42a3c0575c79ebc24bc9bd96bc73033adfdb30485681a`.

Inner TXT:
- bytes: `4249`.
- SHA256: `7797af1775f70649a49a5ef319b3d1a729a993aac11be2f7728e0562579fa229`.

Boot time: `Sun Sep 6 20:48:05 2026`.
Boot args preserve `-igfxvesa -ocmcdiag`.

## Runtime identity
`kmutil showloaded` proves:
- OCLPMetalCompat 0.0.4 UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644` loaded;
- Lilu 1.7.3 loaded;
- WhateverGreen 1.7.1 loaded.

IORegistry service:
- `VersionInfo=DBG-004-2026-09-06`;
- `D97CTChannel=IORegistry-AtomicAsync-v1`;
- `D97DDRouteBuildGateMethod=cs-validate-page-callback-osversion-v1`;
- `D97DDObservedBuild=25G82`.

## Decisive route/callback/build proof
Persistent state:
- `D97CTBootArgGate=1` PASS;
- `D97CTKernelGate=1` PASS;
- `D97CTCpuGate=1` PASS;
- `D97CTRouteStatus=PASS`;
- `D97DDCallbackSeenCount=256069`;
- `D97CTBuildGate=1` PASS;
- `D97CTPublisherTicks=300`.

Therefore:
- `_cs_validate_page` route installation is runtime PROVEN;
- routed wrapper execution is runtime PROVEN at very high coverage;
- callback-phase direct `osversion[]` exact-build gate is runtime PROVEN for 25G82.

Authoritative classifications:
- `D97DF_D97DD_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97DF_D97DD_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_CALLBACK_EXECUTION=RUNTIME_PROVEN`;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`.

## Cave page runtime proof
Natural VESA boot observation:
- `D97CTCaveSeenCount=1`;
- `D97CTCaveWindow18=PASS`;
- `D97CTCaveFull208=PASS`;
- `D97CTCaveValidated=15` (`0xF`);
- `D97CTCaveTainted=0`;
- `D97CTCaveNX=0`.

XNU defines `VMP_CS_ALL_TRUE = 0xF`, so `validated=15` means the complete code-sign validation bitmask is set. Tainted and NX remain clear.

Classification:
- `D97DF_D97BV_CAVE_PAGE_RUNTIME_SEEN=PROVEN`;
- `D97DF_D97BV_CAVE_FULL208_ZERO=RUNTIME_PROVEN`;
- `D97DF_D97BV_CAVE_FUNCTIONAL18_ZERO=RUNTIME_PROVEN`;
- `D97DF_D97BV_CAVE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`;
- `D97DF_D97BV_CAVE_TAINTED=0`;
- `D97DF_D97BV_CAVE_NX=0`.

## Site page remains not naturally observed in VESA
- `D97CTSiteSeenCount=0`;
- site preimage/validated/tainted/nx properties therefore absent.

This is **not** classified NEGATIVE. The D97BV site is deep in native Metal `__TEXT` at shared-cache file page offset `0xF5E1000`, while the cave is near image start at `0xF47E000`. A VESA boot can naturally fault the cave page without ever executing/faulting the deep Metal site page.

Classification:
- `D97DF_D97BV_SITE_PAGE_NATURAL_VESA_OBSERVATION=NOT_OBSERVED_WITHIN_300S`;
- `D97DF_D97BV_SITE_PREIMAGE_RUNTIME=STILL_UNPROVEN`.

## Next bounded diagnostic — D97DG
No new kext build or EFI mutation is required.

Perform one additional VESA boot with unchanged D97DD 0.0.4 and run an immediate userspace **read-only active page-fault trigger** while the 300-second publisher window is still active:
1. verify D97DD loaded and publisher still below cutoff;
2. open exact main Cryptex `dyld_shared_cache_x86_64h` read-only;
3. `mmap` exact site page offset `0xF5E1000` and cave page offset `0xF47E000` as `MAP_PRIVATE`, `PROT_READ|PROT_EXEC`;
4. read bytes from each mapping to force page faults without changing file/page contents;
5. poll IORegistry until site/cave properties update;
6. collect final route/build/site/cave state.

The active-fault diagnostic must create no system/EFI/cache mutation and must not Root Patch.

Success criterion:
- site count > 0;
- exact site preimage PASS;
- site validated/tainted/nx captured;
- cave remains PASS;
- route/build remain PASS.

Only after this runtime site closure may a separately authorized functional D97BV page-write successor be designed/deployed. Functional D97BV remains unauthorized now.

## CURRENT ACTION
Prepare and run D97DG active read-only page-fault collector on ASUS2 after one manually authorized VESA reboot. Download the collector before reboot and run it immediately after desktop returns, before the D97DD publisher reaches 300 ticks.
