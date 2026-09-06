# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97DE_D97DD_DEPLOY_PASS_RUNTIME_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: one native Tahoe Metal/Metal4 image with selective 3802 ingress plus otherwise unchanged Tahoe 32023/32024 semantics.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort showed only 32023 requests.
D97BM/BN/BO mapped the Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Full legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compiler content may be bounded; legacy main Metal remains forbidden.

## D97BV selective adapter
Static-semantic PROVEN: preserve exact 3802, otherwise execute original Tahoe behavior.
Native `__TEXT` base `0x7FF80F47D000`.
Site `0x7FF80F5E1719`, original `3d187d0000b9177d00000f4cc1`, replacement `3dda0e00007406e93bcee9ff90`.
Cave `0x7FF80F47E560`, replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied and functionally unauthorized.

## Standalone reconstruction path closed
D97BW-D97CJ progressively solved sparse export, segment metadata, mapping and first Objective-C loader faults, then proved broad shared-cache-origin Objective-C relocation state.
Final classifications:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.
Production direction shifted to native shared-cache Metal plus a bounded OCLP-specific Lilu plugin.

## D97CL-D97CN native-cache substrate closure
D97CL proved Haswell AVX2, Lilu 1.7.3, WEG 1.7.1 and expected x86_64h shared-cache substrate.
D97CM proved Lilu can map exact native Metal TEXT but plain BinaryModInfo is blocked by absent canonical standalone Metal.
D97CN proved exact validation-page topology:
- site page `0xF5E1000`, in-page `0x719`, exact 13-byte preimage PASS;
- cave page `0xF47E000`, in-page `0x560`, full 208-byte zero PASS and future 18-byte window zero PASS.
Classification: `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

## D97CO-D97CS first plugin runtime closure
D97CO 0.0.1 compiled/audited observe-only; no replacement bytes or write path.
D97CQ deployed it to EFI.
D97CR proved exact runtime load but unified-log markers were absent; log channel INCONCLUSIVE.
D97CS proved active OCLPMetalCompat IOKit lifecycle; persistent IORegistry became the preferred evidence channel.

## D97CT-D97CX persistent IORegistry and first gate failure
D97CT 0.0.2 added atomic persistent IORegistry state and remained observe-only.
D97CV/D97DA re-audited evolving EFI states after OpenCore/OCLP changes.
D97CW/D97DB performed identity-pinned OCLPMetalCompat-only replacements while preserving config.
D97CX runtime proved persistent channel and showed early `sysctlbyname(kern.osversion)` exact-build gate failed before CPU/route evaluation.

## D97CY 0.0.3
D97CY replaced the sysctl build query with direct kernel-global `osversion[]` comparison inside `onPatcherLoadForce`.
Source v2 SHA256 `1fb91340c3fbfe4fab6dfffcad8df96c3576c39f4b3b23f46894c24e45b4884f`.
Compiled UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`, executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.
Compile/audit PASS; no functional mutation.
D97DB deployed D97CY 0.0.3 while preserving config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.

## D97DC decisive runtime result
Returned `OCLP7_D97DC_D97CY_VESA_RUNTIME_20260906_202541.zip`, SHA256 `ded250e9bd9a086ba343b9e89dea6bc74870dcad0b7d5e50a33737a38b847de6`.
Runtime proved D97CY 0.0.3 loaded and IORegistry active.
Publisher saw `D97CYObservedBuild=25G82`, but persistent state was BootArgGate=1, KernelGate=1, CpuGate=1, BuildGate=2, RouteStatus=PENDING, SiteSeenCount=0, CaveSeenCount=0, PublisherTicks=300.
Source/runtime synthesis proved `onPatcherLoadForce` still executes before `osversion[]` initialization. This is a gate-placement timing/tooling negative, not a real build mismatch and not a route/page negative.

Classifications:
- `D97DC_D97CY_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97DC_D97CY_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97DC_BOOTARG_GATE=PASS`;
- `D97DC_KERNEL_GATE=PASS`;
- `D97DC_CPU_GATE=PASS`;
- `D97DC_PATCHERLOAD_OSVERSION_TIMING_GATE=NEGATIVE`;
- `D97DC_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97DC_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97DD 0.0.4 compile/audit PASS
D97DD moves exact-build enforcement into the routed `_cs_validate_page` callback:
- Tahoe/Haswell/bootarg gates remain in pluginStart;
- route installs without reading `osversion[]` in patcher-load;
- Apple original called first;
- callback counter increments;
- fail-closed `osversion == 25G82` then evaluated per callback;
- target-page observation only after build PASS;
- no page mutation.

Authorized source SHA256 `6d1292eb812d4df83d0185c8a19c025131fe0e213048221099618e80790aa7c2`.
Returned build `OCLP7_D97DD_IMAC_BUILD_20260906_203451.zip` SHA256 `8873f3c0c64e03997fd1018d24e34f49d2315a77115bdf187fd35d6ba842845c`.
Manifest mismatches 0, both builds PASS, zero errors.
Compiled D97DD 0.0.4 UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`.
Independent source/control-flow/binary audit PASS; D97BV replacement bytes and write/injection paths absent.

## D97DE — D97DD identity-pinned deploy PASS
Returned report `OCLP7_D97DE_D97DD_EFI_REPLACE_20260906_204307.txt`.

Pre-deploy:
- config expected/actual SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48` PASS;
- OCLPMetalCompat unique index 5;
- Lilu 1.7.3 at index 0;
- old D97CY executable expected/actual SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77` PASS;
- audited D97DD package SHA256 `e6be2563e68000d1f2744c1cd2261e87feb002068540169aa17f1b428ab13abe` PASS;
- new D97DD executable expected/actual SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25` PASS.

Replacement:
- staged SHA PASS;
- D97CY backup created at `OCLPMetalCompat.kext.D97CY-20260906_204307.bak` with exact old executable SHA;
- final D97DD executable SHA `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- final version 0.0.4;
- final config SHA unchanged `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.

Classifications:
- `D97DE_D97DD_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DE_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DE_D97CY_BACKUP=PASS`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## CURRENT ACTION
One manual VESA diagnostic reboot is authorized with D97DD 0.0.4 through the same active OpenCore EFI.
Do not change EFI/config and do not Root Patch.
After VESA desktop returns, collect D97DD loaded identity, route status, callback count, callback-phase build gate, observed build, site/cave counts and invariants, validated/tainted/nx state and publisher ticks.

No accelerated boot, Root Patch or functional shared-cache mutation is authorized.