# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DB_D97CY_EFI_DEPLOY_PASS_RUNTIME_READY.md`
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
- active EFI now contains D97CY `OCLPMetalCompat.kext` 0.0.3, executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this D97CO/D97CT/D97CY development sequence.

## Durable architecture
Pinned Golden OCLP:
- commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`.

Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Final target remains one native Tahoe Metal image with two logical compiler-generation lanes. Preserve exact 3802 selectively; preserve Tahoe 32023/32024 semantics otherwise.

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` repair;
- no pointer-by-pointer standalone ObjC rehabilitation as production mainline;
- no fake canonical Metal file to satisfy BinaryModInfo prelookup;
- no functional D97BV page write until runtime timing/preimage proof passes.

Exact target MetallibSupportPkg remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## D97BV retained functional design
Native Tahoe Metal `__TEXT` base `0x7FF80F47D000`; native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`.
D97BT proved default-environment 3802 suppression to 32023/32024.

D97BV selective adapter remains static-semantic PROVEN:
- exact input 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe behavior.

Exact locations/bytes:
- site `0x7FF80F5E1719 = __TEXT + 0x164719`;
- site original `3d187d0000b9177d00000f4cc1`;
- site replacement `3dda0e00007406e93bcee9ff90`;
- cave `0x7FF80F47E560 = __TEXT + 0x1560`;
- cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

D97BV remains unapplied and unauthorized.

## Shared-cache plugin direction
Standalone Metal production path is CLOSED by D97CI/D97CJ broad Objective-C relocation evidence.
Production direction preserves Apple Tahoe Metal/Metal4 in the original dyld shared cache and uses separate `OCLPMetalCompat.kext`; Lilu and WhateverGreen are not modified.

D97CL proved runtime Lilu/DSC substrate. D97CM proved exact Metal TEXT mapping but plain BinaryModInfo is blocked by the absent canonical standalone Metal file. D97CN proved both future D97BV targets resolve uniquely into the main x86_64h DSC and that site preimage / cave zero-window are exact.

D97CN topology:
- main cache UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`;
- site page offset `0xF5E1000`, in-page `0x719`, exact 13-byte preimage PASS;
- cave page offset `0xF47E000`, in-page `0x560`, full 208-byte zero cave PASS, first 18-byte future window zero PASS.

## D97CO -> D97CX observation-channel closure
D97CO 0.0.1 compile/binary audit PASS, observe-only.
D97CR proved exact kext runtime load but unified-log marker channel was INCONCLUSIVE.
D97CS proved active IOKit lifecycle (`IOMatchedAtBoot=Yes`).
D97CT 0.0.2 moved evidence into persistent IORegistry.

D97CX runtime proved:
- D97CT 0.0.2 loaded;
- IORegistry persistent channel works;
- `D97CTBootArgGate=1`;
- `D97CTKernelGate=1`;
- `D97CTBuildGate=2` because early `sysctlbyname("kern.osversion")` failed;
- CPU gate not reached;
- `_cs_validate_page` route not attempted;
- site/cave timing therefore untested.

Classifications:
- `D97CX_D97CT_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CX_D97CT_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97CX_EARLY_SYSCTL_BUILD_GATE_IMPLEMENTATION=NEGATIVE`;
- `D97CX_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97CX_SITE_CAVE_RUNTIME_TIMING=UNTESTED`.

## D97CY 0.0.3 — exact-build gate repair
D97CY replaces the failed early sysctl query with direct kernel-global `osversion[]` comparison to `25G82` inside the Lilu patcher-load callback immediately before route installation.
It publishes:
- `D97CYBuildGateMethod = kernel-global-osversion-v1`;
- `D97CYObservedBuild = osversion`.

Authorized D97CY v2 source SHA256 `1fb91340c3fbfe4fab6dfffcad8df96c3576c39f4b3b23f46894c24e45b4884f`.
Returned build `OCLP7_D97CY_IMAC_BUILD_20260906_195136.zip` SHA256 `ce9f364ce05f41d189d812aae869bf1037e08b61036b50dd58f94aec20227084`.
Compiled D97CY 0.0.3:
- UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`;
- executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- Info.plist SHA256 `0c175c6c83c0d086e14da8be22e6233efdf2e95b1eb6e862294841d53c53954d`;
- Lilu dependency `1.7.3`.

Independent audit: manifest mismatches 0, both builds PASS, `sysctlbyname` absent, D97BV functional replacement bytes absent, write/injection paths absent.
Audited deploy package `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip` SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`.

## D97DA / D97DB — latest EFI authority and deploy PASS
D97DA full read-only EFI re-audit established current config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`, Kernel/Add count 37, Lilu index 0, AMFIPass index 4, OCLPMetalCompat index 5, WEG index 30, KDKlessWorkaround index 31, boot args `-igfxvesa -ocmcdiag`, and unchanged core OpenCore files.

D97DB then replaced only D97CT 0.0.2 with D97CY 0.0.3:
- returned report `OCLP7_D97DB_D97CY_EFI_REPLACE_20260906_201309.txt`;
- report SHA256 `2cd9ead11a26cde82459b124284c42e4ada312de8011ff01d0bf22ac1828111d`;
- final executable SHA256 exact `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- final config SHA256 unchanged `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- D97CT backup `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CT-20260906_201309.bak` with exact old executable SHA;
- no Root Patch, no reboot, no config mutation.

Classification:
`D97DB_D97CY_IDENTITY_PINNED_EFI_DEPLOY=PASS`.

## CURRENT ACTION
One manual **VESA diagnostic reboot** is authorized using the already-deployed D97CY 0.0.3.

For this boot:
1. make no further EFI changes;
2. do not Root Patch;
3. preserve `-igfxvesa` and `-ocmcdiag`;
4. reboot normally through the same active OpenCore EFI;
5. after VESA desktop returns, collect D97CY runtime identity and persistent IORegistry evidence:
   - `D97CYBuildGateMethod`;
   - `D97CYObservedBuild`;
   - D97CT BootArg/Kernel/Build/CPU gates;
   - `D97CTRouteStatus`;
   - site/cave counts, preimage/zero-window checks;
   - Apple `validated/tainted/nx` values when observed.

This is still an observe-only VESA boot. No Root Patch, accelerated boot or functional D97BV shared-cache mutation is authorized.
