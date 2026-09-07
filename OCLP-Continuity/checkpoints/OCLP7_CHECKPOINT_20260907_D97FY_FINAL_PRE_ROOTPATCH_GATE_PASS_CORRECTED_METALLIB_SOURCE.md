# OCLP7 CHECKPOINT — D97FY final pre-Root-Patch gate PASS with corrected 25G82 metallib source

Date: 2026-09-07 EEST

## Entering state
- ASUS2 is running Tahoe `26.6.2 / 25G82`, x86_64, in established VESA recovery mode.
- D97FW proved the prior 25G82 MetallibSupportPkg materialization was systemically invalid: all 180 package `.metallib` payloads had become metadata-text stubs both in the local Dortania tree and in the installed root.
- D97FX reconstructed the entire local source tree atomically from the exact original package, preserving the old stub tree as backup and making no Root Patch/root-volume/EFI/NVRAM/reboot changes.
- Exact original package remains `MetallibSupportPkg-26.6.2-25G82.pkg`, bytes `116574513`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## D97FX reconstructed-source result
User returned:
- `D97FX_STAGE_REGULAR_FILE_COUNT=181`;
- `D97FX_STAGE_SYMLINK_COUNT=0`;
- `D97FX_STAGE_REAL_METALLIB_COUNT=180`;
- `D97FX_STAGE_FULL_TREE_IDENTITY=PASS`;
- `D97FX_STAGE_CORE_MTLB=PASS`;
- `D97FX_POSTSWAP_METALLIB_EXACT=180`;
- `D97FX_POSTSWAP_FULL_TREE_IDENTITY=PASS`;
- corrected CoreDisplay `default.metallib` SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- corrected CoreDisplay bytes `20739`;
- corrected CoreDisplay type `MetalLib executable (MacOS), version 1.2.7`;
- `D97FX_STATUS=PASS`;
- `D97FX_SOURCE_RECONSTRUCTION=PASS`;
- no Root Patch and no reboot.

Backup retained at:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82.D97FX_STUB_BACKUP_20260907_212451`.

## D97FY returned final gate
Exact helper identity:
- Git blob `28a075c7e1017f1fc1babefbe16ec96541f1548e` PASS.

System/boot:
- ProductVersion `26.6.2`;
- BuildVersion `25G82`;
- x86_64;
- boot args include active `-igfxvesa`, `-ocmcdiag`, `-ocmcd97bv`;
- `-ocmcd97ez` absent/inert;
- `D97FY_VESA_STATE=PASS`.

Original package:
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- bytes `116574513`;
- `D97FY_ORIGINAL_PACKAGE_IDENTITY=PASS`.

Corrected local source vs package:
- `D97FY_LOCAL_REGULAR_FILE_COUNT=181`;
- `D97FY_LOCAL_REAL_METALLIB_EXACT=180`;
- `D97FY_LOCAL_FULL_TREE_IDENTITY=PASS`;
- `D97FY_LOCAL_ALL_METALLIB_MAGIC=MTLB`;
- `D97FY_CORE_SHA=PASS`.

Current installed root remains intentionally unrepaired at this gate:
- `D97FY_INSTALLED_EXACT=0`;
- `D97FY_INSTALLED_METADATA_STUB=180`;
- missing `0`;
- other `0`;
- `D97FY_INSTALLED_PRE_REPAIR_STATE=PASS`.

Exact D97DX artifact identity:
- outer app `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97DX.app`;
- inner executable SHA256 `986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- source diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- `D97FY_D97DX_ARTIFACT_IDENTITY=PASS`.

182-entry closure:
- prior exact static patchdict total `182`;
- `180` DynamicPatchset/MetallibSupportPkg entries;
- `2` unchanged `14.6.1` donor entries;
- current exact dynamic payload count `180`;
- `D97FY_PATCHDICT_182_RESOLUTION=PASS_BY_EXACT_SOURCE_IDENTITY_PLUS_180_DYNAMIC_CURRENT_IDENTITY_PLUS_2_UNCHANGED_DONORS`.

Official privileged helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- `D97FY_OFFICIAL_HELPER_IDENTITY=PASS`.

Final gate:
- `D97FY_STATUS=PASS`;
- `D97FY_CORRECTED_SOURCE_GATE=PASS`;
- `D97FY_D97DX_GATE=PASS`;
- `D97FY_182_ENTRY_CLOSURE=PASS`;
- `D97FY_VESA_GATE=PASS`;
- `D97FY_ROOT_PATCH=NO`;
- `D97FY_REBOOT=NO`.

## Classification
- corrected local 25G82 MetallibSupportPkg source = STRUCTURAL-SEMANTIC PASS for package/tree identity and MTLB validity;
- exact D97DX Root Patch vehicle = PASS;
- VESA safety gate = PASS;
- 182-entry source resolution = PASS;
- installed root still contains the proven 180 metadata stubs and requires controlled Root Patch replacement.

## Root-patch execution authorization boundary
D97FY authorizes the controlled remediation sequence, but does not itself mutate the root or reboot.

Because OpenCore Legacy Patcher Root Patch Restore performs an APFS snapshot revert and the established OCLP output requires reboot for the revert to take effect, do NOT chain Restore and Root Patch in the same running snapshot.

Authorized sequence:
1. Launch exact outer `OpenCore-Patcher-Tahoe-D97DX.app`.
2. Run manual Root Patch Restore/Revert only.
3. Close the inner OCLP so the outer launcher restores/verifies the official privileged helper.
4. Reboot once into the same VESA configuration (`-igfxvesa` active; D97EZ active mode absent/inert). This reboot is specifically authorized for the completed APFS revert.
5. Before applying Root Patch again, perform a read-only post-revert gate to prove the stubbed installed root has been removed/restored and the corrected local 25G82 source remains exact.
6. Only after that post-revert gate passes, launch exact D97DX again and perform the corrected manual Root Patch.
7. After Root Patch completes, do not reboot until post-patch payload identity is audited.

Still forbidden before the post-patch audit:
- accelerated/non-VESA boot;
- removal of `-igfxvesa`;
- active `-ocmcd97ez`;
- EFI/NVRAM/framebuffer changes;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
