# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DG_PUBLISHER_WINDOW_TOOLING_NEGATIVE_D97DH_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

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
- active EFI contains D97DD `OCLPMetalCompat.kext` 0.0.4;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- previous D97CY backup: `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CY-20260906_204307.bak`.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this OCLPMetalCompat lineage.

## End goal / architecture
End goal: stable hardware acceleration and usable GUI.

Pinned Golden OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.

Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` production repair;
- no standalone Objective-C rehabilitation as production mainline;
- no fake canonical Metal file for BinaryModInfo;
- no functional D97BV page write until runtime site preimage closure passes and the user separately authorizes functional mutation.

## D97BV retained facts
Native Tahoe Metal `__TEXT` base `0x7FF80F47D000`, SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`.
D97BT proved default-environment 3802 suppression to 32023/32024.

D97BV selective adapter is static-semantic PROVEN:
- exact input 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe behavior.

Exact targets:
- site VM `0x7FF80F5E1719`, shared-cache page offset `0xF5E1000`, in-page `0x719`;
- site original `3d187d0000b9177d00000f4cc1`;
- site replacement `3dda0e00007406e93bcee9ff90`;
- cave VM `0x7FF80F47E560`, page offset `0xF47E000`, in-page `0x560`;
- cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

D97BV remains unapplied and functionally unauthorized.

## Observation-channel closure through D97DF
D97CO 0.0.1 established the first observe-only plugin. D97CR proved runtime load; unified log was inconclusive. D97CS proved OCLPMetalCompat IOKit lifecycle. D97CT 0.0.2 moved state into persistent IORegistry.

D97CX showed early `sysctlbyname(kern.osversion)` was too early. D97CY 0.0.3 replaced it with direct `osversion[]`, but D97DC proved `onPatcherLoadForce` still precedes `osversion[]` initialization.

D97DD 0.0.4 installs `_cs_validate_page` before any exact-build read, calls Apple original first, increments callback count, then enforces `osversion == 25G82` per callback before target-page observation. Compile/source/binary audit PASS; no page mutation or D97BV replacement bytes. D97DE deployed it while preserving config byte-identically.

D97DF runtime PROVEN:
- D97DD 0.0.4 loaded, UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- `D97CTRouteStatus=PASS`;
- callback count `256069`;
- `D97CTBuildGate=1`;
- `D97DDObservedBuild=25G82`;
- BootArg/Kernel/Cpu gates PASS.

Authoritative classifications:
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_CALLBACK_EXECUTION=RUNTIME_PROVEN`;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`.

Natural VESA cave runtime PROVEN:
- CaveSeenCount=1;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15/0xF = `VMP_CS_ALL_TRUE`;
- CaveTainted=0;
- CaveNX=0.

Site remained `NOT_OBSERVED_WITHIN_300S_VESA`, not NEGATIVE.

## D97DG — current tooling result
Second active-fault attempt returned `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_212953.txt`:
- bytes `2437`;
- SHA256 `6622a56e51b73343fe1a77b2d7fe0202115fa17033e9b5881e446fee782fc5c8`.

Boot time `21:25:09`; collector started about `21:29:53`, roughly 284 seconds after boot. At collector start `D97CTPublisherTicks=288`, callback count `251445`, route/build remained PASS and cave remained PASS. The safety gate stopped before mmap because insufficient publication time remained.

This is the second demonstration that the D97DD 300-second publisher window is operationally too short for post-desktop active site faulting on ASUS2.

Classifications:
- `D97DG_ACTIVE_SITE_MMAP_TRIGGER=NOT_EXECUTED`;
- `D97DG_SITE_RUNTIME_PREIMAGE=UNTESTED`;
- `D97DG_PUBLISHER_300S_WINDOW=TOOLING_NEGATIVE_FOR_POST_DESKTOP_ACTIVE_FAULT`;
- no site-negative conclusion;
- D97DF route/build/callback/cave runtime proofs remain authoritative.

## D97DH design / CURRENT ACTION
D97DH is a minimal tooling-only successor to D97DD. It changes only the asynchronous IORegistry publication lifetime:
- preserve route installation unchanged;
- preserve Apple-original-first callback unchanged;
- preserve callback exact-build gate unchanged;
- preserve site/cave matching and all read-only invariants unchanged;
- preserve zero page writes and zero functional D97BV replacement bytes;
- publisher cutoff `300 -> 900` seconds;
- publisher still stops early as soon as both site and cave are seen;
- publish `D97DHPublisherPolicy=extended-until-site-cave-or-900-v1` and `D97DHPublisherLimitTicks=900`.

Prepared D97DH source:
- `OCLP7_D97DH_kern_start.cpp`;
- SHA256 `63541e7135388ee73ca3b8a408a45578e742734a79f6d313f8aef919405251f1`.

Prepared iMac build script:
- `OCLP7_D97DH_IMAC_BUILD.sh`;
- SHA256 `d269baf9b841216ced0d202595c228772823b49a248962e6466575d99084e71a`;
- `bash -n` PASS;
- intended plugin version `0.0.5`.

CURRENT ACTION: build D97DH 0.0.5 on the already-authorized iMac 9900K host and return the build ZIP for independent audit. Do not alter ASUS2 EFI until audit passes.

No Root Patch, accelerated boot or functional shared-cache mutation is authorized.
