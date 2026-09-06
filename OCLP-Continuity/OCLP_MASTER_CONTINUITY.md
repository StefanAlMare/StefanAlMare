# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DE_D97DD_DEPLOY_PASS_RUNTIME_READY.md`
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

## Current machine / EFI
- ASUS2: Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current operating mode: unpatched VESA;
- no active Root Patch;
- boot args retain `-igfxvesa -ocmcdiag`;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- Lilu `1.7.3` index 0;
- AMFIPass `1.4.1` index 4;
- OCLPMetalCompat unique index 5;
- WhateverGreen `1.7.1` index 30;
- KDKlessWorkaround `1.0.0` index 31;
- active EFI contains D97DD `OCLPMetalCompat.kext` `0.0.4`;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- previous D97CY backup: `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CY-20260906_204307.bak`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; the user authorized the iMac 9900K build host for this OCLPMetalCompat lineage.

## Durable architecture
Pinned Golden OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.

Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Final target remains one native Tahoe Metal image with two logical compiler-generation lanes: preserve true 3802 selectively; preserve Tahoe 32023/32024 semantics otherwise.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` production repair;
- no standalone Objective-C rehabilitation as production mainline;
- no fake canonical Metal file for BinaryModInfo;
- no functional D97BV page write until runtime route/timing/preimage proof passes.

## D97BV retained facts
Native Tahoe Metal `__TEXT` base `0x7FF80F47D000`, SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`.
D97BT proved default-environment 3802 suppression to 32023/32024.

D97BV selective adapter remains static-semantic PROVEN:
- exact input 3802 bypasses the Tahoe floor;
- every non-3802 input executes original Tahoe behavior.

Exact locations / bytes:
- site `0x7FF80F5E1719 = __TEXT + 0x164719`;
- site original `3d187d0000b9177d00000f4cc1`;
- site replacement `3dda0e00007406e93bcee9ff90`;
- cave `0x7FF80F47E560 = __TEXT + 0x1560`;
- cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

D97BV remains unapplied and functionally unauthorized.

## Native-cache substrate / observation closure
D97CL proved Haswell AVX2, Lilu 1.7.3, WEG 1.7.1 and expected x86_64h shared-cache substrate.
D97CM proved Lilu maps the exact native Metal TEXT; plain BinaryModInfo is blocked by absent canonical standalone Metal.
D97CN proved exact validation-page topology:
- site page `0xF5E1000`, in-page `0x719`, 13-byte preimage PASS;
- cave page `0xF47E000`, in-page `0x560`, full 208-byte zero PASS and future 18-byte window zero PASS.
Classification: `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

D97CO 0.0.1 established the first observe-only plugin. D97CR proved runtime load while unified logging was inconclusive. D97CS proved OCLPMetalCompat IOKit lifecycle, making persistent IORegistry the preferred evidence channel.

D97CT 0.0.2 added atomic/persistent IORegistry state. D97CX showed the early `sysctlbyname(kern.osversion)` build gate failed before route evaluation. D97CY 0.0.3 replaced sysctl with direct `osversion[]`, but D97DC proved `onPatcherLoadForce` still runs before `osversion[]` initialization: publisher later saw `25G82`, while the build gate had already latched NEGATIVE and route remained NOT ATTEMPTED.

D97DC authoritative classifications:
- `D97DC_D97CY_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97DC_D97CY_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97DC_BOOTARG_GATE=PASS`;
- `D97DC_KERNEL_GATE=PASS`;
- `D97DC_CPU_GATE=PASS`;
- `D97DC_PATCHERLOAD_OSVERSION_TIMING_GATE=NEGATIVE`;
- `D97DC_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97DC_SITE_CAVE_RUNTIME_TIMING=UNTESTED`.

## D97DD 0.0.4 — current runtime probe
D97DD moves exact-build enforcement into the routed `_cs_validate_page` callback:
- pluginStart gates `-ocmcdiag`, Tahoe and Haswell;
- patcher-load installs `_cs_validate_page` without reading `osversion[]`;
- wrapper calls Apple original first;
- atomic callback counter increments;
- then fail-closed `osversion == 25G82` is evaluated per callback;
- only after build PASS can exact D97CN site/cave pages be observed;
- no validation-page mutation occurs.

Authorized source SHA256 `6d1292eb812d4df83d0185c8a19c025131fe0e213048221099618e80790aa7c2`.
Returned build ZIP `OCLP7_D97DD_IMAC_BUILD_20260906_203451.zip` SHA256 `8873f3c0c64e03997fd1018d24e34f49d2315a77115bdf187fd35d6ba842845c`.
Compile/source/binary audit PASS; D97BV replacement bytes absent; write/injection paths absent.

Audited deploy package `OCLP7_D97DD_AUDITED_DEPLOY_20260906.zip`, SHA256 `e6be2563e68000d1f2744c1cd2261e87feb002068540169aa17f1b428ab13abe`.

## D97DE — identity-pinned EFI deployment PASS
Returned report `OCLP7_D97DE_D97DD_EFI_REPLACE_20260906_204307.txt`.

Pre-deploy identity:
- config expected/actual SHA `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48` PASS;
- OCLPMetalCompat unique index 5;
- Lilu index 0 / 1.7.3;
- D97CY 0.0.3 executable expected/actual SHA `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77` PASS;
- audited D97DD package and executable identity PASS.

Replacement:
- staged D97DD executable SHA PASS;
- D97CY backup created with exact old SHA;
- final D97DD executable SHA `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- final version 0.0.4;
- final config SHA unchanged `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.

Classifications:
- `D97DE_D97DD_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DE_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DE_D97CY_BACKUP=PASS`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## CURRENT ACTION
One manual VESA diagnostic reboot is authorized through the same active OpenCore EFI.

Rules:
1. make no further EFI/config changes;
2. do not Root Patch;
3. retain `-igfxvesa -ocmcdiag`;
4. reboot normally through the same active EFI;
5. after VESA desktop returns, collect D97DD runtime IORegistry + loaded-kext identity.

Required runtime evidence:
- D97DD 0.0.4 loaded, UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- `D97DDRouteBuildGateMethod`;
- `D97DDObservedBuild`;
- `D97DDCallbackSeenCount`;
- `D97CTRouteStatus`;
- `D97CTBuildGate`;
- site/cave counts and invariant/validated/tainted/nx state;
- publisher ticks.

Interpretation:
- route PASS + callback count > 0 + build PASS closes the routing/timing and callback-phase exact-build substrate;
- site/cave counts > 0 plus invariant PASS closes runtime target-page timing/preimage observation;
- functional D97BV page writes remain separately unauthorized.

No accelerated boot, Root Patch or functional shared-cache mutation is authorized by this MASTER.