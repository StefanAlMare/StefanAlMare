# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DD_COMPILE_AUDIT_PASS_DEPLOY_READY.md`
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
- current state: unpatched VESA;
- no active Root Patch;
- boot args retain `-igfxvesa -ocmcdiag`;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- Lilu `1.7.3` index 0;
- AMFIPass `1.4.1` index 4;
- OCLPMetalCompat unique index 5;
- WhateverGreen `1.7.1` index 30;
- KDKlessWorkaround `1.0.0` index 31;
- active EFI currently contains D97CY `OCLPMetalCompat.kext` 0.0.3, executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this OCLPMetalCompat lineage.

## Durable architecture
Pinned Golden OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.

Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

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
D97BV site `0x7FF80F5E1719`, cave `0x7FF80F47E560`.
Site original `3d187d0000b9177d00000f4cc1`.
Site replacement `3dda0e00007406e93bcee9ff90`.
Cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied.

## Observation-channel closure
D97CO 0.0.1: compile/binary observe-only PASS; runtime load proven, unified-log channel inconclusive.
D97CS: OCLPMetalCompat IOKit lifecycle runtime-proven.
D97CT 0.0.2: persistent IORegistry channel compile/audit PASS.
D97CX: D97CT runtime proved persistent channel; early `sysctlbyname(kern.osversion)` build gate NEGATIVE before route.
D97CY 0.0.3: direct kernel-global `osversion[]` compile/audit PASS, deployed by D97DB.
D97DC: publisher later saw `25G82`, but `onPatcherLoadForce` still ran before `osversion[]` initialization; BuildGate latched NEGATIVE, route remained NOT ATTEMPTED. This is a gate-placement timing negative, not a build mismatch and not a route/page negative.

## D97DD 0.0.4 — compile/audit PASS
D97DD moves exact-build enforcement into the routed `_cs_validate_page` callback:
- pluginStart still gates `-ocmcdiag`, Tahoe and Haswell;
- patcher-load installs `_cs_validate_page` without reading `osversion[]`;
- wrapper calls Apple original first;
- atomic callback count increments;
- then fail-closed `osversion == 25G82` is evaluated on each callback;
- only after build PASS can exact D97CN site/cave pages be observed;
- callback does not mutate validation-page bytes.

Authorized source:
- `OCLP7_D97DD_kern_start.cpp`;
- SHA256 `6d1292eb812d4df83d0185c8a19c025131fe0e213048221099618e80790aa7c2`.

Returned build:
- `OCLP7_D97DD_IMAC_BUILD_20260906_203451.zip`;
- bytes `53717`;
- SHA256 `8873f3c0c64e03997fd1018d24e34f49d2315a77115bdf187fd35d6ba842845c`;
- manifest mismatches 0;
- two `BUILD SUCCEEDED`, zero `BUILD FAILED`, zero errors;
- 3 non-functional warnings.

Compiled D97DD:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.4`;
- UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- built Info.plist SHA256 `5bb00bece5db5e936da2a1ed1804b783889d96abef9424410235261cce64a41b`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature.

Independent static/binary audit:
- returned source byte-identical to authorized source;
- Apple original precedes callback counter/build gate/page observation;
- exact-build gate absent from patcher-load and present inside callback;
- `D97DDRouteBuildGateMethod`, `D97DDObservedBuild`, `D97DDCallbackSeenCount`, target `25G82` and persistent route/site/cave markers present;
- `sysctlbyname`, write/injection/protection paths and `const_cast` absent;
- D97BV original preimage occurs once as comparison data;
- D97BV site/cave replacement payloads occur zero times.

Classifications:
- `D97DD_LOCAL_COMPILE=PASS`;
- `D97DD_MANIFEST_AUDIT=PASS`;
- `D97DD_SOURCE_IDENTITY=PASS`;
- `D97DD_CALLBACK_GATE_CONTROL_FLOW_STATIC_AUDIT=PASS`;
- `D97DD_COMPILED_OBSERVE_ONLY_NO_FUNCTIONAL_PAGE_MUTATION=PASS`;
- `D97DD_CS_VALIDATE_PAGE_ROUTE_RUNTIME=UNTESTED`;
- `D97DD_CALLBACK_EXACT_BUILD_GATE_RUNTIME=UNTESTED`;
- `D97DD_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## CURRENT ACTION
Prepare audited D97DD deploy package and ASUS2-only identity-pinned replacement from current D97CY 0.0.3 to D97DD 0.0.4.
The replacement must preserve config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`, OCLPMetalCompat index 5, Lilu 1.7.3 and boot args `-igfxvesa -ocmcdiag`, and modify only `EFI/OC/Kexts/OCLPMetalCompat.kext`.

After deployment, return the report and do not reboot until it is audited.

No Root Patch, accelerated boot or functional shared-cache mutation is authorized.