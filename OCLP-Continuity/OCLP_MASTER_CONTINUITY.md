# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DC_BUILD_GATE_TIMING_NEGATIVE_D97DD_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

This MASTER is intentionally consolidated around the current frontier. Historical detail remains in the permanent database, HISTORY, RETROSPECTIVE and checkpoint corpus.

## Mandatory startup order
Before any technical modification:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current machine / goal
- ASUS2: Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state: unpatched VESA;
- no active Root Patch;
- `-igfxvesa` retained;
- `-ocmcdiag` retained;
- active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- Lilu `1.7.3` at Kernel/Add index 0;
- AMFIPass `1.4.1` at index 4;
- OCLPMetalCompat unique entry at index 5;
- WhateverGreen `1.7.1` at index 30;
- KDKlessWorkaround `1.0.0` at index 31;
- active EFI contains D97CY `OCLPMetalCompat.kext` 0.0.3, executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- D97DC VESA runtime proved D97CY load and persistent IORegistry but exact-build gate still ran too early in `onPatcherLoadForce`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this OCLPMetalCompat development lineage.

## Durable architecture
Pinned Golden OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Final target remains one native Tahoe Metal image with two logical compiler-generation lanes. Preserve true 3802 selectively; otherwise preserve Tahoe 32023/32024 behavior.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` production repair;
- no pointer-by-pointer standalone ObjC rehabilitation as production mainline;
- no fake canonical Metal file to satisfy BinaryModInfo prelookup;
- no functional D97BV page write until runtime route/timing/preimage proof passes.

## D97BV retained facts
Native Tahoe Metal `__TEXT` base `0x7FF80F47D000`, SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
D97BV exact site `0x7FF80F5E1719`, cave `0x7FF80F47E560`.
Site original `3d187d0000b9177d00000f4cc1`.
Site replacement `3dda0e00007406e93bcee9ff90`.
Cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied.

## Observation-channel closure
D97CO 0.0.1: compile/binary observe-only PASS; runtime load proven, unified-log marker channel inconclusive.
D97CS: OCLPMetalCompat IOKit lifecycle runtime-proven.
D97CT 0.0.2: persistent IORegistry channel compile/audit PASS.
D97CX: D97CT runtime load + persistent channel proven; early `sysctlbyname(kern.osversion)` build gate NEGATIVE before route.
D97CY 0.0.3: replaced sysctl with direct kernel-global `osversion[]`, compile/audit PASS, deployed by D97DB.

## D97DC — current decisive runtime result
Returned ZIP `OCLP7_D97DC_D97CY_VESA_RUNTIME_20260906_202541.zip`:
- bytes `1708`;
- SHA256 `ded250e9bd9a086ba343b9e89dea6bc74870dcad0b7d5e50a33737a38b847de6`.

Runtime:
- D97CY 0.0.3 UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193` loaded;
- `VersionInfo=DBG-003-2026-09-06`;
- `D97CYObservedBuild=25G82`;
- BootArgGate=1;
- KernelGate=1;
- CpuGate=1;
- BuildGate=2;
- RouteStatus=PENDING;
- SiteSeenCount=0;
- CaveSeenCount=0;
- PublisherTicks=300.

Source/runtime synthesis: the Lilu patcher-load callback executes before `osversion[]` is initialized. The gate latches NEGATIVE there, while the later publisher correctly sees `25G82`. Therefore this is a timing/tooling negative of gate placement, not a build mismatch and not a route/page negative.

Authoritative classifications:
- `D97DC_D97CY_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97DC_D97CY_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97DC_BOOTARG_GATE=PASS`;
- `D97DC_KERNEL_GATE=PASS`;
- `D97DC_CPU_GATE=PASS`;
- `D97DC_PATCHERLOAD_OSVERSION_TIMING_GATE=NEGATIVE`;
- `D97DC_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97DC_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97DD design / CURRENT ACTION
D97DD version `0.0.4` must:
- retain `-ocmcdiag`, Tahoe and Haswell gates in pluginStart;
- install `_cs_validate_page` route during Lilu patcher-load without consulting `osversion[]`;
- call Apple original first in the wrapper;
- increment an atomic callback-seen counter;
- then evaluate `osversion == 25G82` fail-closed on every callback;
- return immediately on build mismatch;
- only after exact-build PASS observe exact D97CN site/cave pages and invariants;
- publish callback count/build/route/site/cave state via IORegistry;
- perform no validation-page mutation, no Root Patch and no D97BV functional replacement.

Prepared D97DD source SHA256 `6d1292eb812d4df83d0185c8a19c025131fe0e213048221099618e80790aa7c2`.
Prepared iMac build script SHA256 `51236cd4276e138b07ac69c0ce4e0425ec8548f4eaf22632e454079a9582a7bc`.

CURRENT ACTION: build D97DD 0.0.4 on the already-authorized iMac 9900K host, return the resulting ZIP for independent audit, and do not alter ASUS2 EFI until that audit passes.

No Root Patch, accelerated boot or functional shared-cache mutation is authorized.
