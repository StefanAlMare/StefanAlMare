# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97DB_D97CY_EFI_DEPLOY_PASS_RUNTIME_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is an index, not the full evidence corpus. Detailed per-step evidence remains in checkpoints and the permanent database.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: native Tahoe Metal/Metal4 preserved in dyld shared cache, with bounded selective 3802 ingress and otherwise unchanged Tahoe 32023/32024 semantics.

## Golden / compiler-generation closure
Pinned Golden OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; working Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort showed 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK proved that forcing the full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI and is permanently NEGATIVE.
D97BL established that bounded legacy MTLCompilerService/private compiler use remains possible, but legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic PROVEN:
- exact input 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe behavior.

Native `__TEXT` base `0x7FF80F47D000`.
Site `0x7FF80F5E1719 = +0x164719`, original `3d187d0000b9177d00000f4cc1`, replacement `3dda0e00007406e93bcee9ff90`.
Cave `0x7FF80F47E560 = +0x1560`, replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied and unauthorized pending runtime timing/preimage proof.

## D97BW-D97CJ — standalone reconstruction path closed
D97BW/BX showed sparse reconstruction preserves native code/Metal4 but is not standalone-loadable.
D97BY-BZ-CA-CB repaired progressively real DSC export metadata and segment ordering.
D97CB-v5 proved a valid cold harness; D97CC/CD solved page-aligned mappings and reached Objective-C loading.
D97CE showed `--slide` did not advance the fault; D97CF closed duplicate-Metal causality; D97CG LLDB hook was tooling-negative.
D97CH tied the first crash to preoptimized shared-cache Objective-C bookkeeping.
D97CI-v2 cleared that first fault but exposed an unrebased class pointer.
D97CJ proved broad cache-origin Objective-C relocation state across classlist/catlist/protolist/superrefs.

Final standalone classifications:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Production direction shifted to native shared-cache Metal plus separate bounded `OCLPMetalCompat.kext`.

## D97CL-D97CN — shared-cache/Lilu substrate closure
D97CL: Haswell AVX2, Lilu `1.7.3`, WhateverGreen `1.7.1`, no relevant Lilu user-patcher blockers, exact Cryptex x86_64h cache plus map, native Metal present.
D97CM: Lilu map parser resolves exact Metal TEXT; plain BinaryModInfo blocked by absent canonical standalone Metal.
D97CN: both future D97BV targets resolve uniquely into main `dyld_shared_cache_x86_64h`, UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`.
Site page `0xF5E1000`, in-page `0x719`, exact 13-byte preimage PASS.
Cave page `0xF47E000`, in-page `0x560`, full 208-byte zero cave PASS and first 18-byte future window zero PASS.
Classification: `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

## D97CO-D97CS — first observe-only plugin and channel closure
D97CO 0.0.1 routes `_cs_validate_page`, calls Apple first, observes only exact target pages, and performs no page mutation.
Compiled executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.
D97CQ deployed D97CO in active EFI and added `-ocmcdiag`, preserving `-igfxvesa`.
D97CR proved exact runtime load but unified-log markers were absent, so logging channel was INCONCLUSIVE.
D97CS `ioreg` proved active plugin lifecycle with `IOMatchedAtBoot=Yes`; persistent IORegistry became preferred evidence channel.

## D97CT-D97CX — persistent channel and build-gate negative
D97CT 0.0.2 moved gate/route/site/cave state into atomic counters asynchronously published to IORegistry.
Compiled UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`, executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.
D97CV/D97CW re-audited EFI after OpenCore/OCLP update and deployed D97CT.
D97CX runtime proved:
- D97CT loaded;
- IORegistry channel works;
- BootArgGate=1;
- KernelGate=1;
- BuildGate=2 because early `sysctlbyname("kern.osversion")` failed;
- CPU gate not reached;
- route not attempted;
- site/cave timing untested.

Classifications:
- `D97CX_D97CT_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CX_D97CT_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97CX_EARLY_SYSCTL_BUILD_GATE_IMPLEMENTATION=NEGATIVE`;
- `D97CX_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97CX_SITE_CAVE_RUNTIME_TIMING=UNTESTED`.

## D97CY — kernel-global exact-build gate repair
D97CY removes failed early sysctl query and compares kernel-global `osversion[]` directly to `25G82` inside Lilu patcher-load callback immediately before route installation.
Publishes `D97CYBuildGateMethod=kernel-global-osversion-v1` and `D97CYObservedBuild=osversion`.

First source revision failed compile only from linkage conflict caused by full `libkern/version.h`; v2 declares only `extern "C" char osversion[];`.
Authorized source SHA256 `1fb91340c3fbfe4fab6dfffcad8df96c3576c39f4b3b23f46894c24e45b4884f`.
Returned build ZIP SHA256 `ce9f364ce05f41d189d812aae869bf1037e08b61036b50dd58f94aec20227084`.
Compiled D97CY 0.0.3 UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`, executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.
Audited deploy package SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`.
Independent audit: both builds PASS, manifest mismatches 0, `sysctlbyname` absent, D97BV functional bytes absent, write/injection paths absent.

## D97DA — latest full EFI re-audit
D97DA read-only report `OCLP7_D97DA_CURRENT_EFI_FULL_REAUDIT_20260906_200508.txt` established current active EFI:
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- `BOOTx64.efi` and `OpenCore.efi` unchanged from prior audit;
- Kernel/Add count 37;
- Lilu index 0 / 1.7.3;
- AMFIPass index 4 / 1.4.1;
- OCLPMetalCompat unique index 5 / exact D97CT 0.0.2;
- WEG index 30 / 1.7.1;
- KDKlessWorkaround index 31 / 1.0.0;
- boot args preserve `-igfxvesa -ocmcdiag`;
- all enumerated UEFI Driver and ACPI Add files exist.

## D97DB — D97CY EFI deployment PASS
Returned report `OCLP7_D97DB_D97CY_EFI_REPLACE_20260906_201309.txt`, SHA256 `2cd9ead11a26cde82459b124284c42e4ada312de8011ff01d0bf22ac1828111d`.

D97DB verified exact current config, unique index 5, Lilu 1.7.3, old D97CT executable, audited D97CY package and new executable; all gates passed.
It then replaced only `EFI/OC/Kexts/OCLPMetalCompat.kext` and created backup `OCLPMetalCompat.kext.D97CT-20260906_201309.bak`.

Final state:
- D97CY version `0.0.3` active in EFI;
- executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- config SHA256 unchanged `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- no Root Patch;
- no reboot;
- no config mutation;
- no functional D97BV mutation.

Classification: `D97DB_D97CY_IDENTITY_PINNED_EFI_DEPLOY=PASS`.

## CURRENT ACTION
Remain unpatched Tahoe VESA.
One manual VESA diagnostic reboot is authorized with D97CY 0.0.3 already deployed.
After desktop returns, collect D97CY observed build/method, D97CT persistent gate/route/site/cave state and Apple validated/tainted/nx values.
No Root Patch, accelerated boot or functional shared-cache mutation is authorized.
