# OCLP7 CHECKPOINT — 2026-09-06 — D97DD compile/audit PASS; deploy ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DC_BUILD_GATE_TIMING_NEGATIVE_D97DD_READY.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current running mode: unpatched VESA.
- No active Root Patch.
- Boot args retain `-igfxvesa -ocmcdiag`.
- Active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- Lilu `1.7.3` index 0; AMFIPass `1.4.1` index 4; OCLPMetalCompat unique index 5; WhateverGreen `1.7.1` index 30; KDKlessWorkaround `1.0.0` index 31.
- Active EFI contains D97CY `OCLPMetalCompat.kext` 0.0.3, executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.
- D97DC proved `onPatcherLoadForce` still runs before kernel-global `osversion[]` initialization; route was not attempted.

## D97DD design
D97DD version `0.0.4` preserves the observe-only native-shared-cache direction and changes only exact-build gate placement:
- pluginStart still requires explicit `-ocmcdiag`, Tahoe and Haswell;
- Lilu patcher-load installs `_cs_validate_page` route without reading `osversion[]`;
- wrapper calls Apple original `_cs_validate_page` first;
- atomic callback counter increments immediately after Apple original returns;
- wrapper then evaluates `osversion == 25G82` fail-closed on every callback;
- on mismatch it returns immediately;
- target site/cave page observation occurs only after exact-build PASS;
- callback never mutates validation-page bytes;
- asynchronous publisher exposes `D97DDRouteBuildGateMethod`, `D97DDObservedBuild`, `D97DDCallbackSeenCount`, existing gate/route/site/cave state and publisher ticks through IORegistry.

## Authorized source
`OCLP7_D97DD_kern_start.cpp`
- bytes `12407`;
- SHA256 `6d1292eb812d4df83d0185c8a19c025131fe0e213048221099618e80790aa7c2`.

Static audit:
- source returned by build is byte-identical to authorized source;
- Apple original call occurs before callback counter/build gate/page observation;
- exact-build gate is inside `patchedCsValidatePage`;
- no exact-build gate remains in `onPatcherLoadForce`;
- page pointer remains const; no `const_cast`, page assignment, memcpy/memmove write, vm_map write, injection or protection path.

## Returned build
`OCLP7_D97DD_IMAC_BUILD_20260906_203451.zip`
- bytes `53717`;
- SHA256 `8873f3c0c64e03997fd1018d24e34f49d2315a77115bdf187fd35d6ba842845c`.

Build host:
- macOS `26.6.2 / 25G83`;
- Intel i9-9900K;
- Xcode `26.5 / 17F42`;
- Apple clang `21.0.0`;
- pinned Lilu `1.7.3`.

Build audit:
- Lilu xcodebuild PASS;
- D97DD plugin xcodebuild PASS;
- `BUILD SUCCEEDED` count 2;
- `BUILD FAILED` count 0;
- build errors 0;
- 3 non-functional warnings only;
- manifest mismatches 0.

## Compiled D97DD identity
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.4`;
- thin x86_64 KEXTBUNDLE;
- UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- built Info.plist SHA256 `5bb00bece5db5e936da2a1ed1804b783889d96abef9424410235261cce64a41b`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature.

## Binary observe-only audit
Present:
- `D97DDRouteBuildGateMethod`;
- `D97DDObservedBuild`;
- `D97DDCallbackSeenCount`;
- `cs-validate-page-callback-osversion-v1`;
- target `25G82`;
- existing D97CT route/site/cave persistent properties;
- exact main `/dyld_shared_cache_x86_64h` suffix;
- `-ocmcdiag`.

Absent:
- `sysctlbyname`;
- `vm_map_write_user`;
- `orgVmMapWriteUser`;
- `findAndReplace`;
- `vmProtect`;
- `injectPayload`;
- `injectSegment`;
- `const_cast`.

D97BV byte audit:
- original 13-byte preimage occurs once as comparison data;
- site replacement occurs 0 times;
- cave replacement occurs 0 times.

## Classifications
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
Prepare an audited D97DD deploy package and an ASUS2-only identity-pinned replacement that changes only `EFI/OC/Kexts/OCLPMetalCompat.kext` from current D97CY 0.0.3 to D97DD 0.0.4, preserving config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48` and OCLPMetalCompat index 5.

After deployment, return the replacement report and do not reboot until that report is audited.

No Root Patch, accelerated boot or functional D97BV shared-cache mutation is authorized.