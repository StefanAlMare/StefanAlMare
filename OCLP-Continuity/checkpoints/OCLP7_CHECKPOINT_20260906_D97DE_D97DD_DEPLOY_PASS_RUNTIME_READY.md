# OCLP7 CHECKPOINT — 2026-09-06 — D97DE D97DD deploy PASS; VESA runtime ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DD_COMPILE_AUDIT_PASS_DEPLOY_READY.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current operating mode: unpatched VESA.
- No active Root Patch.
- Boot args preserve `-igfxvesa -ocmcdiag`.
- Active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- Lilu `1.7.3` at Kernel/Add index 0.
- OCLPMetalCompat unique entry at Kernel/Add index 5.

## D97DD compiled identity
Audited D97DD `OCLPMetalCompat.kext` version `0.0.4`:
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- Lilu dependency `1.7.3`;
- observe-only; no D97BV replacement bytes or page-write/injection path.

Audited deploy package:
- `OCLP7_D97DD_AUDITED_DEPLOY_20260906.zip`;
- SHA256 `e6be2563e68000d1f2744c1cd2261e87feb002068540169aa17f1b428ab13abe`.

## D97DE returned report
Returned report: `OCLP7_D97DE_D97DD_EFI_REPLACE_20260906_204307.txt`.

Pre-replace gates all PASS:
- config expected/actual SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- plist validation PASS;
- OCLPMetalCompat match count 1, index 5;
- `-igfxvesa` and `-ocmcdiag` retained;
- Lilu index 0, version 1.7.3;
- current D97CY 0.0.3 executable expected/actual SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- audited package expected/actual SHA256 `e6be2563e68000d1f2744c1cd2261e87feb002068540169aa17f1b428ab13abe`;
- new D97DD executable expected/actual SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- bundle ID/version/Lilu dependency exact.

EFI replacement:
- staged executable SHA exact PASS;
- old D97CY backup created at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CY-20260906_204307.bak`;
- backup executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.

Post-replace:
- final executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- final version `0.0.4`;
- final bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- final config SHA256 unchanged at `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- plist validation PASS.

Final status:
`D97DE_STATUS=PASS`.
`CONFIG_MUTATION=NO`.
`ROOT_PATCH=NO`.
`REBOOT_PERFORMED=NO`.

Classification:
- `D97DE_D97DD_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DE_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DE_D97CY_BACKUP=PASS`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## CURRENT ACTION
One manual VESA diagnostic reboot is now authorized through the same active OpenCore EFI.

For the next boot:
1. make no further EFI/config changes;
2. do not Root Patch;
3. retain `-igfxvesa -ocmcdiag`;
4. reboot normally through the same active EFI;
5. after the VESA desktop returns, collect D97DD runtime IORegistry state and loaded-kext identity.

Required runtime observations:
- D97DD 0.0.4 loaded with UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- `D97DDRouteBuildGateMethod`;
- `D97DDObservedBuild`;
- `D97DDCallbackSeenCount`;
- `D97CTRouteStatus`;
- `D97CTBuildGate`;
- `D97CTSiteSeenCount` / site preimage + validated/tainted/nx;
- `D97CTCaveSeenCount` / 18-byte + 208-byte invariants + validated/tainted/nx;
- publisher ticks.

Interpretation rules:
- route PASS + callback count > 0 + build PASS proves the routing/timing substrate and callback-phase exact-build gate;
- site/cave counts > 0 plus invariant PASS closes native-cache runtime timing/preimage observation;
- any route NEGATIVE remains a route diagnostic result, not a D97BV functional result;
- functional D97BV page writes remain separately unauthorized.

No accelerated boot, Root Patch or functional shared-cache mutation is authorized by this checkpoint.