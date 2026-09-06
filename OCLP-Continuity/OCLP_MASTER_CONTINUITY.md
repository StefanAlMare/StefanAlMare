# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DF_ROUTE_CALLBACK_CAVE_RUNTIME_PROVEN_SITE_ACTIVE_FAULT_NEXT.md`
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

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this OCLPMetalCompat lineage.

## Durable architecture
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

D97DD 0.0.4 therefore installs `_cs_validate_page` route before any exact-build read, calls Apple original first, increments an atomic callback counter, then enforces `osversion == 25G82` per callback before target-page observation. Compile/source/binary audit PASS; no page mutation or D97BV replacement bytes.

D97DE deployed D97DD 0.0.4 into EFI while preserving config byte-identically.

## D97DF — decisive current runtime result
Returned `OCLP7_D97DF_D97DD_VESA_RUNTIME_20260906_205320.zip`:
- ZIP bytes `1783`;
- ZIP SHA256 `7cfe5586dd5671da1ae42a3c0575c79ebc24bc9bd96bc73033adfdb30485681a`;
- inner TXT bytes `4249`;
- inner TXT SHA256 `7797af1775f70649a49a5ef319b3d1a729a993aac11be2f7728e0562579fa229`.

Runtime identity:
- D97DD 0.0.4 UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644` loaded;
- Lilu 1.7.3 and WhateverGreen 1.7.1 loaded;
- `VersionInfo=DBG-004-2026-09-06`;
- `D97DDObservedBuild=25G82`.

Decisive persistent state:
- BootArgGate=1;
- KernelGate=1;
- CpuGate=1;
- RouteStatus=PASS;
- D97DDCallbackSeenCount=256069;
- BuildGate=1;
- PublisherTicks=300.

Therefore classifications:
- `D97DF_D97DD_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_CALLBACK_EXECUTION=RUNTIME_PROVEN`;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`.

Natural VESA cave observation:
- CaveSeenCount=1;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15 (`0xF`, XNU `VMP_CS_ALL_TRUE`);
- CaveTainted=0;
- CaveNX=0.

Thus cave target delivery + preimage window + Apple full code-sign validation are runtime PROVEN.

Site remains:
- SiteSeenCount=0;
- no runtime site preimage/validated/tainted/nx state yet.

Do **not** classify site as NEGATIVE: a VESA boot need not fault the deep native Metal site page. Classification is `NOT_OBSERVED_WITHIN_300S_VESA`.

## CURRENT ACTION — D97DG active read-only site-page fault
No new kext build or EFI mutation is needed.

Prepare a read-only ASUS2 userspace collector to be downloaded before reboot. After one manually authorized unchanged VESA reboot, run it immediately while D97DD publisher is below 300 ticks.

D97DG must:
1. verify D97DD 0.0.4 is loaded and publisher window is still active;
2. open exact main Cryptex `dyld_shared_cache_x86_64h` read-only;
3. map exact site page `0xF5E1000` and cave page `0xF47E000` `MAP_PRIVATE` with `PROT_READ|PROT_EXEC`;
4. read target bytes only to force page faults, with no write access;
5. poll IORegistry for route/build/site/cave updates;
6. collect final evidence ZIP.

Success criterion:
- route/build remain PASS;
- callback count > 0;
- SiteSeenCount > 0;
- exact SitePreimage=PASS;
- site validated/tainted/nx captured;
- cave remains PASS.

Functional D97BV page write remains separately unauthorized. No Root Patch or accelerated boot is authorized.
