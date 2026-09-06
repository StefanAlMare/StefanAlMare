# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97DA_EFI_REAUDIT_PASS_D97DB_REPINNED.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: one native Tahoe Metal/Metal4 image with a selective 3802 ingress lane plus otherwise unchanged Tahoe 32023/32024 semantics, feeding an audited legacy compiler path and Haswell driver.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compilers may be bounded; legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic proven: preserve exact 3802, otherwise execute original Tahoe floor.
Native `__TEXT` base `0x7FF80F47D000`.
Site `0x7FF80F5E1719 = +0x164719`, original `3d187d0000b9177d00000f4cc1`, replacement `3dda0e00007406e93bcee9ff90`.
Cave `0x7FF80F47E560 = +0x1560`, replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied.

## D97BW-D97CJ — standalone reconstruction path closed
D97BW/BX sparse closure: native code/Metal4 can be reconstructed but sparse output is not standalone-loadable.
D97BY real DSC export succeeded; D97BZ repaired `SG_READ_ONLY`; D97CA/CB mapped and repaired segment-order metadata.
D97CB-v5 proved a valid cold harness; D97CC/CD solved page-aligned standalone mappings and reached Objective-C loading.
D97CE showed `--slide` did not advance the fault; D97CF closed duplicate-Metal causality; D97CG LLDB hook was tooling-negative.
D97CH tied the first standalone crash to preoptimized shared-cache Objective-C bookkeeping.
D97CI-v2 cleared that fault by removing the OptimizedByDyld bit but exposed an unrebased readClass pointer.
D97CJ proved broad cache-origin Objective-C relocation state across classlist/catlist/protolist/superrefs.

Final standalone classifications:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Production direction shifted to native shared-cache Metal plus a bounded OCLP-specific Lilu plugin.

## D97CL — Lilu / DSC runtime substrate PASS
ASUS2 proved Haswell AVX2, Lilu `1.7.3`, WhateverGreen `1.7.1`, no relevant Lilu user-patcher blockers, exact Cryptex `dyld_shared_cache_x86_64h` plus map, and native Metal present in map.

Classifications:
- `D97CL_FAST_SHARED_CACHE_MAPPING_PRECONDITION=PASS`;
- `D97CL_EXPECTED_CACHE_BINARY_PRECONDITION=PASS`;
- `D97CL_USERPATCHER_BOOTARG_PRECONDITION=PASS`.

## D97CM — Lilu map TEXT PASS; plain BinaryModInfo NEGATIVE
Returned ZIP SHA256 `bc587bcb48eb6c4350b444c9c41566cfbb86c092c63c66f498c31924b91b41dd`.
TXT SHA256 `1d998ac1b793b2eb76f6ad1a6b298b42a4fc6c070ab8bfd681b6718a6e348675`.
Embedded report SHA256 `b42fbc898794b7d143fcbbc172b4d01ae8d09fdeebd9440f7f6948a56c486cc6`.
Lilu-emulated Metal `__TEXT` exactly matches the native range; D97BV site/cave arithmetic PASS. Canonical standalone Metal is absent, so plain BinaryModInfo prelookup is NEGATIVE while Lilu general substrate remains POSITIVE.

## D97CN — exact DSC code-validation page topology PASS
Returned ZIP SHA256 `a468b57ed1bb0917790c803848e084f67aecabf2ad18ccc8893d7f325bef24ea`.
TXT SHA256 `fe0b48280d08a6b77dae03acd67a720770663e1cdb3c95c1fae2b1b46bed0b6e`.
Embedded report SHA256 `c17b8ac6598e86688b19c3a22ccdcbc28bd12204a0ae7cbc376195a5b791303e`.

Both D97BV targets resolve uniquely into main `dyld_shared_cache_x86_64h`, UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`, mapping 0 r-x.
Site page `0xF5E1000`, in-page `0x719`, exact 13-byte preimage PASS.
Cave page `0xF47E000`, in-page `0x560`, full 208-byte zero cave PASS and future 18-byte window zero PASS.
Classification: `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

## D97CO — first observe-only OCLPMetalCompat
D97CO uses explicit `-ocmcdiag`, Tahoe/Haswell gates, routes `_cs_validate_page`, calls Apple first, observes only exact D97CN site/cave pages and main x86_64h cache path, and performs no page mutation.

Returned local build ZIP SHA256 `937332463f94bc32898432e9ad66775adb97292d57e65f238cc11e97fb184ad8`.
Compiled 0.0.1 UUID `319A3777-1BB1-3395-9E7A-6A0426C58723`, executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.
Audited deploy package SHA256 `e062ef672c003d2d6ff11508d1f4cd5e43b94c45ec7de1c9919358cbd0a9fad7`.
Binary audit: no D97BV replacement bytes and no write/injection path.

## D97CQ-D97CS — deployment and first runtime channel closure
D97CQ identity-pinned D97CO into active EFI and added `-ocmcdiag`, preserving `-igfxvesa`; no Root Patch or reboot during deployment.
D97CR VESA runtime proved the kext was loaded but unified-log markers were absent, so logging channel was INCONCLUSIVE rather than hook timing negative.
D97CS `ioreg` proved active OCLPMetalCompat lifecycle with `IOMatchedAtBoot=Yes` and `VersionInfo=DBG-001-2026-09-06`.
Persistent IORegistry became the preferred evidence channel.

## D97CT — persistent IORegistry observe-only build
D97CT 0.0.2 records gate/route/site/cave evidence atomically and publishes asynchronously into the proven IORegistry service.
Returned build ZIP SHA256 `1e32326568f22abfc42020de0530babb8459a72557fc789f2143869012e1125f`.
Compiled UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`, executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.
Audited deploy package SHA256 `d033c3195fa9bd098e4e1d080c59d09609269c7691d5ac6399c74fecc9cdee1e`.
Classification: `D97CT_COMPILED_PERSISTENT_IOREG_OBSERVE_ONLY=PASS`.

## D97CV / D97CW — earlier current EFI re-audit and D97CT deploy
After user updated OpenCore/OCLP, D97CV re-audited the then-active EFI read-only:
- config SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`;
- `BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`;
- Kernel/Add count 37;
- Lilu index 0 / version 1.7.3;
- OCLPMetalCompat then at unique index 2;
- boot args `-igfxvesa -ocmcdiag` retained.

D97CW replaced only D97CO 0.0.1 with D97CT 0.0.2; config remained byte-identical. Old D97CO backup is preserved at `OCLPMetalCompat.kext.D97CO-20260906_192422.bak`.

## D97CX — persistent channel PASS; early build gate NEGATIVE
Returned ZIP SHA256 `926e3ed1dd5ed2df8e129c4ff78cfa1ae7c8513d5b3eb83b6063881d83374bdb`.
D97CT 0.0.2 loaded and IORegistry channel proved active.
Runtime gate state:
- BootArgGate=1 PASS;
- KernelGate=1 PASS;
- BuildGate=2 NEGATIVE;
- CpuGate=0 NOT REACHED;
- RouteStatus=PENDING NOT ATTEMPTED;
- SiteSeenCount=0;
- CaveSeenCount=0.

Cause: early `sysctlbyname("kern.osversion")` implementation returned false despite independently confirmed host build 25G82.
Classifications:
- `D97CX_D97CT_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CX_D97CT_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97CX_EARLY_SYSCTL_BUILD_GATE_IMPLEMENTATION=NEGATIVE`;
- `D97CX_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97CX_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97CY — kernel-global exact-build gate repair
D97CY removes the failed early sysctl query and compares kernel-global `osversion[]` directly to `25G82` inside the Lilu patcher-load callback immediately before route installation. It publishes `D97CYBuildGateMethod=kernel-global-osversion-v1` and `D97CYObservedBuild=osversion` and otherwise preserves the D97CT observe-only path.

First D97CY source revision failed compile because full `libkern/version.h` redeclared `version_major/version_minor` with C linkage while Lilu already declared them with C++ linkage. This was a tooling/source integration failure only.

D97CY v2 removes the full header and declares only `extern "C" char osversion[];`.
Authorized source SHA256 `1fb91340c3fbfe4fab6dfffcad8df96c3576c39f4b3b23f46894c24e45b4884f`.

Returned build `OCLP7_D97CY_IMAC_BUILD_20260906_195136.zip`:
- bytes `53587`;
- SHA256 `ce9f364ce05f41d189d812aae869bf1037e08b61036b50dd58f94aec20227084`;
- manifest mismatches 0;
- Lilu and plugin builds both PASS;
- build errors 0.

Compiled D97CY 0.0.3:
- UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`;
- executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- built Info.plist SHA256 `0c175c6c83c0d086e14da8be22e6233efdf2e95b1eb6e862294841d53c53954d`;
- Lilu dependency 1.7.3;
- required build-gate and persistent IORegistry markers present;
- `sysctlbyname`, write/injection symbols and D97BV functional replacement bytes absent.

Audited deploy package:
- `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip`;
- SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`;
- manifest SHA256 `5a6c0f1c8546ecf32efff8b6b814a184aefe63e1838df0a747cc01d57c575768`.

Classifications:
- `D97CY_LOCAL_COMPILE=PASS`;
- `D97CY_MANIFEST_AUDIT=PASS`;
- `D97CY_COMPILED_OBSERVE_ONLY_NO_FUNCTIONAL_PAGE_MUTATION=PASS`;
- `D97CY_EXACT_BUILD_GATE_RUNTIME=UNTESTED`;
- `D97CY_CS_VALIDATE_PAGE_ROUTE_RUNTIME=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97DA — latest active-EFI full re-audit
Returned report `OCLP7_D97DA_CURRENT_EFI_FULL_REAUDIT_20260906_200508.txt`.
Classification: `D97DA_CURRENT_EFI_FULL_REAUDIT=PASS_READ_ONLY`.

Current config SHA256 is now `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`; plist validation PASS.
OpenCore core-file hashes are unchanged from D97CV:
- `BOOTx64.efi` `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`.

Kernel/Add count remains 37 but ordering changed:
- Lilu index 0 / version 1.7.3;
- AMFIPass index 4 / version 1.4.1;
- OCLPMetalCompat unique index 5 / current D97CT 0.0.2;
- WhateverGreen index 30 / version 1.7.1;
- KDKlessWorkaround index 31 / version 1.0.0.

Current D97CT executable SHA256 remains exact `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`; Info.plist SHA256 `b386aded0a0d2a4490916f32236e22c2c38056638546c546153a5d7371ea4d8d`.
Boot args preserve `-igfxvesa -ocmcdiag`; relevant Lilu disabling/slow bootargs are absent.
All enumerated UEFI Driver and ACPI Add files were present.

Tooling note: D97DA printed `UUID=24` because its `otool` awk extraction was wrong; those fields are ignored and do not affect SHA-based identity proof.

## D97DB — D97CY deployment repinned to D97DA
Old D97CZ is superseded and must not be run.
Prepared `OCLP7_D97DB_D97CY_EFI_REPLACE_REPINNED.sh`:
- SHA256 `39c4819608d7a5c05cedcdd9de0a06839a123b6d131bfc4e91230fe79e71b839`;
- `bash -n` PASS.

D97DB pins the new active config SHA, OCLPMetalCompat index 5, exact current D97CT executable, exact audited D97CY executable/package, Lilu 1.7.3 at index 0, and required VESA diagnostic bootargs. It modifies only `EFI/OC/Kexts/OCLPMetalCompat.kext`, backs up D97CT, preserves `config.plist`, performs no Root Patch and no reboot.

## CURRENT ACTION
Remain unpatched Tahoe VESA.
On ASUS2: deploy audited D97CY 0.0.3 with D97DB, return the D97DB report, and do not reboot until that report is audited.
No Root Patch, accelerated boot or functional shared-cache mutation is authorized.
