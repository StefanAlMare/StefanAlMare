# OCLP7 CHECKPOINT — D97FX source reconstruction PASS; Root Patch preflight next

Date: 2026-09-07 EEST

## Entering authority
- ASUS2: Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current session remains VESA recovery.
- D97FW proved all 180 regular `.metallib` payloads in the materialized Dortania 25G82 tree and in the current installed root were metadata-text stubs rather than actual MetalLib binaries.
- Exact original package remains pinned:
  - `MetallibSupportPkg-26.6.2-25G82.pkg`
  - bytes `116574513`
  - SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.
- D97FX helper authority:
  - artifact `OCLP-Continuity/artifacts/OCLP7_D97FX_RECONSTRUCT_25G82_METALLIB_SOURCE.sh`
  - commit `a02e75e3d4284942fa2112f2964b818a59cc9c7b`
  - Git blob `b8e9675b16b38575bccfad5cb5c24438531480e7`.

## User-executed D97FX source reconstruction
Downloaded helper Git blob identity:
`b8e9675b16b38575bccfad5cb5c24438531480e7` PASS.

Helper declarations:
- ROOT_PATCH=NO
- ROOT_VOLUME_MUTATION=NO
- EFI_MUTATION=NO
- NVRAM_MUTATION=NO
- REBOOT=NO

Exact package precheck PASS:
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`
- bytes `116574513`.

Entering local source state confirmed expected stub:
- CoreDisplay default.metallib SHA256 `b073e3e1089c2c3f5cf5af43dca30a1237db1d2a1ae6b0d5c2d4fabd5353cd52`
- bytes `319`
- type `ASCII text`.

Expanded exact package base:
`/Users/alex/Desktop/OCLP7_D97FX_SOURCE_RECONSTRUCT_20260907_212451/expanded/MetallibSupportPkg-26.6.2-25G82.pkg/Payload/Library/Application Support/Pyquick/MetallibSupportPkg/26.6.2-25G82`

Staging verification:
- regular files `181`
- symlinks `0`
- real `.metallib` files `180`
- full regular-tree identity to package payload PASS
- CoreDisplay MTLB magic PASS.

Atomic source swap:
- prior stub tree backed up at:
  `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82.D97FX_STUB_BACKUP_20260907_212451`
- corrected tree installed at:
  `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`

Post-swap exhaustive verification:
- `D97FX_POSTSWAP_METALLIB_EXACT=180`
- `D97FX_POSTSWAP_FULL_TREE_IDENTITY=PASS`
- CoreDisplay corrected SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`
- CoreDisplay corrected bytes `20739`
- CoreDisplay type `MetalLib executable (MacOS), version 1.2.7`
- `D97FX_STATUS=PASS`
- `D97FX_SOURCE_RECONSTRUCTION=PASS`
- `D97FX_ROOT_PATCH=NO`
- `D97FX_REBOOT=NO`.

## Classification
- `D97FX_EXACT_ORIGINAL_PACKAGE=PASS`
- `D97FX_SOURCE_TREE_RECONSTRUCTION=PASS`
- `D97FX_ALL_REGULAR_METALLIBS_EXACT=180_OF_180`
- `D97FX_CORE_DISPLAY_METALLIB_VALID_MTLB=PASS`
- `D97FX_LOCAL_SOURCE_PAYLOAD_CORRUPTION=CLOSED_PASS`
- installed root remains in the prior stub state until a new Root Patch is deliberately executed.

## 182-vs-180 reconciliation policy
D97DX patch dictionary contains 182 overwrite entries, while the package payload contains 180 regular `.metallib` files plus one non-metallib regular file and no symlinks. Do not infer two missing metallib binaries from the numerical difference alone. The next Root Patch preflight must validate the full D97DX patch dictionary against the corrected source tree and fail-close if any mapped path is unresolved.

## Current action — final Root Patch preflight only
Remain in VESA. Do not Root Patch yet and do not reboot.

Next gate must verify:
1. exact reconstructed local tree still matches the original package payload;
2. exact CoreDisplay payload identity remains valid;
3. D97DX app/source identity is unchanged;
4. all 182 D97DX `Metal 3802 .metallibs` patch-dictionary targets resolve successfully against the corrected local source tree, accounting explicitly for remove/derived semantics if any;
5. official privileged helper state is known before opening D97DX;
6. active boot remains VESA and D97EZ active mode remains absent/inert.

Only after that preflight passes may a manual Root Patch Restore + Root Patch be separately authorized. No auto Root Patch and no auto reboot.