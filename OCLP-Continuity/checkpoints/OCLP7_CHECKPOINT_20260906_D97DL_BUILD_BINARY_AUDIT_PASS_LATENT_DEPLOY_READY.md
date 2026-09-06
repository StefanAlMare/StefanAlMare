# OCLP7 CHECKPOINT — 2026-09-06 — D97DL 0.0.7 build/binary audit PASS; LATENT deploy ready

## Entering ASUS2 state
- Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.
- VESA only; no Root Patch.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and do not contain `-ocmcd97bv`.
- active EFI remains D97DI 0.0.6, executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`.
- D97DK latent runtime PASS: FunctionalMode=LATENT, FunctionalRequested=0, SITE/CAVE write counts 0, route/build PASS.

## Why D97DL supersedes D97DI for future functional activation
D97DI allowed SITE mutation without requiring the cross-page CAVE trampoline to be already mutated. Natural VESA ordering (CAVE seen, SITE unseen) is useful evidence but not accepted as a universal accelerated-boot guarantee.

D97DL 0.0.7 preserves the exact D97BV payload and adds a cave-first prerequisite:
- CAVE mutation PASS is published with release semantics only after CAVE postimage/tail verification;
- SITE performs an acquire load of CAVE mutation state before any SITE write;
- SITE writes only if CAVE state is exactly PASS;
- otherwise SITE remains native and publishes `D97DLSiteCavePrereq=WAITING_CAVE`.

## Returned build
`OCLP7_D97DL_IMAC_BUILD_20260906_232239.zip`
- bytes `59325`;
- SHA256 `4a32606751ddd0d5862b2f58fc70361e843ac03953704edcc25226223ad7979c`;
- manifest mismatches 0;
- Lilu xcodebuild PASS;
- D97DL xcodebuild PASS;
- two BUILD SUCCEEDED, zero BUILD FAILED, zero errors;
- 6 non-functional build/toolchain warnings.

Source identity:
- SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- Git blob `af52267e8e5fbbc975715b1c3a7a3fceab994c1b`;
- authority commit `72dbc5f29aedf4f8190700de9f1c2c45f949b56f`.

Compiled D97DL:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.7`;
- thin x86_64 KEXTBUNDLE;
- UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- built Info.plist SHA256 `e09e026901269ca16b5169104a1feb8f5ca950d3999e426945d95b2a88db873d`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency 1.7.3.

## Binary/static audit
- exact SITE replacement `3dda0e00007406e93bcee9ff90` occurs once;
- exact CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600` occurs once;
- D97DLSiteCavePrereq marker present;
- WAITING_CAVE marker present;
- SITE acquire-before-write ordering PASS;
- CAVE release-after-postimage ordering PASS;
- exact 25G82/path/page/Apple validation/preimage gates retained;
- no broad `findAndReplace`, `vm_map_write_user`, `vmProtect`, injection surface;
- default without `-ocmcd97bv` remains LATENT.

Classifications:
- `D97DL_LOCAL_COMPILE=PASS`;
- `D97DL_MANIFEST_AUDIT=PASS`;
- `D97DL_SOURCE_IDENTITY=PASS`;
- `D97DL_D97BV_PAYLOAD_BINARY_AUDIT=PASS`;
- `D97DL_CAVE_FIRST_PREREQUISITE=STATIC_PROVEN`;
- `D97DL_CAVE_RELEASE_SITE_ACQUIRE_ORDERING=STATIC_PROVEN`;
- `D97DL_SITE_FAIL_CLOSED_IF_CAVE_NOT_READY=STATIC_PROVEN`;
- `D97DL_LATENT_DEFAULT=PASS`.

Audited LATENT package:
`OCLP7_D97DL_AUDITED_LATENT_DEPLOY_20260906.zip`
- SHA256 `8e84e98d244ec02570f65b569c7da533c93a6ae01ed32d26a84872d0292c04c2`;
- bytes `26405`.

## CURRENT ACTION
Prepare/run identity-pinned D97DM replacement from current D97DI 0.0.6 to D97DL 0.0.7 in LATENT mode only. `-ocmcd97bv` must remain absent. No Root Patch and no reboot until the D97DM report is returned and audited.
