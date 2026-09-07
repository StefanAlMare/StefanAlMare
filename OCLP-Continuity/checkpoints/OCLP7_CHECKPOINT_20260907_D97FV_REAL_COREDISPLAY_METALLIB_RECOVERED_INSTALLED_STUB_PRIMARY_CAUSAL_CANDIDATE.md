# OCLP7 CHECKPOINT — D97FV real CoreDisplay metallib recovered; installed metadata stub is primary causal candidate

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current session remains VESA recovery; no new accelerated boot authorized.
- D97BV/D97DT selective-3802 delivery remains CLOSED PASS.
- D97DX native-Metal-safe Root Patch execution remains structurally PASS, but semantic validity of the installed 25G82 metallib payload is re-opened by this checkpoint.
- D97FT mapped both D97FJ crash modes into CoreDisplay GPUPass specialization / native Metal validation and proved the CoreDisplay bootstrap tuple/descriptor recipe is static-semantic equivalent to working Golden for the mapped scope.

## D97FU discovery that triggered this checkpoint
Direct on-system inspection proved:
`/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`
- bytes `319`;
- SHA256 `b073e3e1089c2c3f5cf5af43dca30a1237db1d2a1ae6b0d5c2d4fabd5353cd52`;
- `file` classification: ASCII text;
- contents are human-readable file metadata, including `Name`, `UTI`, `Kind`, `Owner`, `Group`, `Mode`, `Size : 20739`, `Unverified CRC-32`.

The local tree previously treated as exact 25G82 under:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82/.../CoreDisplay.framework/Versions/A/Resources/default.metallib`
contains the same 319-byte ASCII stub with the same SHA256.

Therefore the prior statement `exact 25G82 CoreDisplay metallib installed` was too strong. What D97DX runtime logs proved was only that the mapped local path was selected/copied; they did not prove the copied bytes were a valid MetalLib.

## D97FV returned archive
`OCLP7_D97FV_REAL_COREDISPLAY_METALLIB_20260907_205524.zip`
- ZIP bytes `14763`;
- ZIP SHA256 `d2572a8d16ca7cfc36d738295ea532e493c3f23965cfae2605f0d5d295e2bf48`;
- CRC PASS.

## Exact original package recovered
Local package:
`/Users/alex/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg`

Identity:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- exact previously pinned package identity PASS.

`pkgutil --expand-full` recovered the actual package payload under its Pyquick installation tree.

## Exact real CoreDisplay default.metallib recovered
From the original package payload:
`.../Payload/Library/Application Support/Pyquick/MetallibSupportPkg/26.6.2-25G82/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`

Identity:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- `file`: `MetalLib executable (MacOS), version 1.2.7`;
- magic bytes: `MTLB`.

Thus the earlier expected SHA was correct for the real payload, but the installed/local materialized file is not that payload.

Classification:
- `D97FV_ORIGINAL_25G82_PKG_IDENTITY=PASS`;
- `D97FV_REAL_COREDISPLAY_METALLIB_IDENTITY=PASS`;
- `D97FV_INSTALLED_COREDISPLAY_METALLIB=NEGATIVE_INVALID_METADATA_STUB`;
- `D97FV_LOCAL_DORTANIA_COREDISPLAY_METALLIB=NEGATIVE_INVALID_METADATA_STUB`.

## Shader-level GPUPass structure from the real metallib
The recovered real 20,739-byte MetalLib contains `GPUPass`.

Its MetalLib function entry statically exposes:
- function name `GPUPass`;
- two function constants:
  - `availableFeatures`, type code `0x21`, index `0`;
  - `optionalFeatures`, type code `0x21`, index `1`.

This exactly matches D97FT CoreDisplay code, which sets two function constants with type `0x21` at indices `0` and `1` before requesting the specialized `GPUPass` function.

Recovered shader/compiler metadata includes:
- `Apple metal version 32023.886 (metalfe-32023.886.1)`;
- AIR module/compiler marker `32023.883`;
- target triple `air64_v26-apple-macosx14.0.0`;
- AIR function-constant metadata and GPUPass alias-scope metadata.

Classification:
- `D97FV_REAL_GPUPASS_PRESENCE=STATIC_PROVEN`;
- `D97FV_REAL_GPUPASS_FUNCTION_CONSTANT_CONTRACT=STATIC_SEMANTIC_PROVEN` for name/type/index mapping.

## Exact CoreDisplay loader relation
D97FT extracted exact 25G82 CoreDisplay and static disassembly now proves `CoreDisplay::CreateMetalDevice` directly uses:
`/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`
through Objective-C `newLibraryWithFile:error:` on the active `MTLDevice`.

The returned MTLLibrary is stored in the MetalDevice object and is subsequently used by `GetGPUPassRenderPipelineState` for:
`newFunctionWithName:@"GPUPass" constantValues:... error:&error`.

The installed 319-byte ASCII file does not satisfy the MetalLib binary structural contract (`MTLB` magic absent) and cannot contain the GPUPass/function-constant payload recovered from the package.

Classification:
- `D97FV_COREDISPLAY_LOADS_INSTALLED_DEFAULT_METALLIB=STATIC_MAPPED`;
- `D97FV_INSTALLED_FILE_METALLIB_STRUCTURAL_VALIDITY=NEGATIVE`.

## Relation to the two D97FJ crash modes
D97FT already proved Crash A enters the GPUPass specialization error-report branch and Crash B reaches descriptor validation/context abort.

The newly proven invalid installed library provides one coherent common mechanism:
1. CoreDisplay asks Metal to load the invalid/stub `default.metallib`;
2. the valid GPUPass functions/constants are unavailable from that file;
3. subsequent GPUPass specialization / render-pipeline construction fails downstream;
4. this matches the already captured specialization-error and validation-abort branches.

Further exact static detail: the GPUPass function's local `NSError*` output slot is not explicitly initialized before the Objective-C specialization call. If the receiver/library is nil, Objective-C nil messaging can leave the out-error slot untouched, providing a structurally plausible explanation for the Crash-A invalid-object error-report path; later descriptor construction with missing functions is likewise consistent with Crash B.

However, do not overclaim runtime causality yet.

Classification:
- `D97FV_INVALID_COREDISPLAY_METALLIB_AS_COMMON_D97FJ_CAUSE=PRIMARY_CAUSAL_CANDIDATE_STRONGLY_SUPPORTED`;
- `D97FV_INVALID_COREDISPLAY_METALLIB_RUNTIME_CAUSAL_PROOF=NOT_YET_CLOSED`.

Runtime causal closure requires a controlled payload correction followed by one measured ACTIVE boot, but only after auditing the full 25G82 metallib tree so the repair is complete rather than piecemeal.

## Upstream reference
Current upstream OCLP installs MetallibSupportPkg via macOS `installer -pkg ... -target /`; upstream MetallibSupportPkg packages actual patched `.metallib` binaries. Therefore a metadata-text stub is not an expected valid MetallibSupportPkg payload.

## CURRENT ACTION — D97FW GLOBAL 25G82 METALLIB MATERIALIZATION AUDIT
Remain in VESA. No Root Patch, no reboot, no EFI/NVRAM/framebuffer/bootarg changes.

Use the already verified original package and `pkgutil --expand-full` in temporary space. Compare every `.metallib` in the package payload against the corresponding materialized local Dortania tree and installed System path where applicable.

Required output:
- total real package metallib count;
- local exact-match count;
- local missing count;
- local differing count;
- local ASCII/metadata-stub count;
- installed differing/stub count for mapped files;
- path-level TSV report, sizes and SHA256s;
- no mutation.

Only after D97FW determines scope should a bounded repair/root-patch strategy be designed.