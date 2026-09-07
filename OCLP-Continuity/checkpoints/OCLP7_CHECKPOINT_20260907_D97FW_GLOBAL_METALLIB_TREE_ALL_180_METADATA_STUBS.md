# OCLP7 CHECKPOINT — D97FW global 25G82 metallib audit; all 180 real payloads materialized/installed as metadata stubs

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current session remains VESA recovery; no new accelerated boot authorized.
- D97BV/D97DT selective-3802 delivery remains CLOSED PASS.
- D97DX native-Metal-safe Root Patch structure/selection remains PASS, but metallib payload-byte correctness was re-opened by D97FV.
- D97FV recovered the real 20,739-byte CoreDisplay `default.metallib` from the exact original package and proved the installed/local 319-byte file is an invalid metadata stub.

## Returned D97FW archive
`OCLP7_D97FW_METALLIB_GLOBAL_AUDIT_20260907_211022.zip`
- bytes `21231`;
- SHA256 `1d06590109b99e6528c115d1db42064ea2a2bf3c80dd31adcf2d118f79568e71`;
- ZIP CRC PASS.

Inner audit artifacts include:
- `D97FW_REPORT.txt`;
- `D97FW_ALL_METALLIBS.tsv` with 180 path-level rows;
- `D97FW_STUB_SAMPLES.txt`.

## Exact package identity revalidated
Original package:
`/Users/alex/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg`

Identity:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- exact previously pinned 25G82 package PASS.

`pkgutil --expand-full` provided the actual binary payload tree under the Pyquick package root.

## Global result — systemic materialization failure
Package contains `180` regular `.metallib` payload files.

For all 180 rows:
- real package payload exists;
- local Dortania tree counterpart exists;
- installed root counterpart exists;
- local counterpart is `ASCII text` metadata stub;
- installed counterpart is `ASCII text` metadata stub;
- stub's embedded `Size:` field exactly equals the corresponding real package payload byte size.

Exact summary:
- `REAL_METALLIB_TOTAL=180`;
- `LOCAL_EXACT=0`;
- `LOCAL_MISSING=0`;
- `LOCAL_METADATA_STUB=180`;
- `LOCAL_DIFFERENT_OTHER=0`;
- `LOCAL_STUB_DECLARED_SIZE_MATCH=180`;
- `INSTALLED_EXACT=0`;
- `INSTALLED_MISSING=0`;
- `INSTALLED_METADATA_STUB=180`;
- `INSTALLED_DIFFERENT_OTHER=0`.

Independent TSV aggregation:
- total real package bytes across the 180 files: `270102725`;
- total local stub bytes across the same 180 paths: `58119`.

This is not an isolated CoreDisplay defect. It is a complete 25G82 metallib-tree materialization failure for every regular `.metallib` payload audited.

Classification:
- `D97FW_GLOBAL_REAL_METALLIB_PAYLOAD_COUNT=180`;
- `D97FW_LOCAL_TREE_REAL_PAYLOAD_IDENTITY=NEGATIVE_0_OF_180`;
- `D97FW_LOCAL_TREE_METADATA_STUBS=SEMANTIC_PROVEN_180_OF_180`;
- `D97FW_INSTALLED_ROOT_REAL_PAYLOAD_IDENTITY=NEGATIVE_0_OF_180`;
- `D97FW_INSTALLED_ROOT_METADATA_STUBS=SEMANTIC_PROVEN_180_OF_180`;
- `D97FW_STUB_DECLARED_SIZE_MATCH_REAL=SEMANTIC_PROVEN_180_OF_180`;
- `D97FW_GLOBAL_MATERIALIZATION_FAILURE=STRUCTURAL_SEMANTIC_PROVEN`.

## CoreDisplay exact row
`System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`

Real package:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- valid MetalLib.

Local + installed stub:
- bytes `319`;
- SHA256 `b073e3e1089c2c3f5cf5af43dca30a1237db1d2a1ae6b0d5c2d4fabd5353cd52`;
- ASCII metadata text;
- embedded declared size `20739`.

Thus D97FV's CoreDisplay observation is one instance of the global 180/180 failure.

## Relation to D97FJ causal frontier
D97FT proved:
- CoreDisplay loads its installed `default.metallib` via `newLibraryWithFile:error:`;
- `GetGPUPassRenderPipelineState` subsequently specializes `GPUPass`;
- Crash A reaches the GPUPass error-report branch;
- Crash B reaches native Metal render-pipeline validation/context abort;
- the mapped CoreDisplay bootstrap recipe itself matches Golden semantics.

D97FV proved the real 25G82 CoreDisplay metallib contains `GPUPass` and the two exact function constants expected by CoreDisplay, while the installed stub cannot contain that contract.

D97FW now proves the defect is not a single-file accident but a complete metallib payload substitution across all 180 regular files.

Therefore the strongest current causal interpretation is:
`D97DX selected/copies local 25G82 metallib paths -> local tree contains metadata stubs rather than package binaries -> root receives invalid stubs -> CoreDisplay cannot load valid GPUPass library -> GPUPass specialization / render-pipeline construction fails -> WindowServer fatal path`.

Important evidence discipline:
- global invalid metallib installation is STRUCTURAL-SEMANTIC PROVEN;
- exact CoreDisplay loader-to-invalid-file relation is STATIC-MAPPED/PROVEN from D97FV;
- runtime root-cause closure still requires a corrected metallib payload and one measured ACTIVE boot;
- do not yet classify the GUI failure as CLOSED PASS.

## 180 vs previously synthesized 182 map entries
D97DX source synthesis previously counted `182` entries under `Metal 3802 .metallibs / OVERWRITE_SYSTEM_VOLUME` by dictionary-entry count.
D97FW counts `180` regular `.metallib` files in the actual package payload.

This two-entry delta is not evidence of two additional missing binary payloads by itself. It may represent aliases/symlink/non-regular entries or another dictionary/package representation difference. Exact reconciliation remains required before mutation so the repair gate is exhaustive.

Classification:
- `D97FW_182_MAP_VS_180_REGULAR_PAYLOAD_DELTA=UNRESOLVED_2_ENTRY_REPRESENTATION_DELTA`.

## Reclassification of D97DX metallib result
Retain:
- exact package/build selection logic PASS;
- exact map/patch-path selection PASS;
- Root Patch execution completed PASS structurally.

Withdraw/restrict:
- any prior semantic claim that the 25G82 metallib payload bytes installed were correct.

New classification:
`D97DX_METALLIB_PATH_SELECTION=PASS`
`D97DX_METALLIB_PAYLOAD_BYTE_VALIDITY=NEGATIVE_FOR_180_OF_180_AUDITED_REGULAR_METALLIBS`.

## CURRENT ACTION — D97FX 182-vs-180 reconciliation + repair-source design
Remain in VESA.
No Root Patch yet.
No reboot.
No EFI/NVRAM/framebuffer/bootarg mutation.

Before repair:
1. reconcile the D97DX 182 dictionary entries against the exact package representation, including symlinks/non-regular entries;
2. prove a complete mapping from every D97DX metallib target to real package payload bytes or an intentional non-file action;
3. design a fail-close local source reconstruction from the exact original package;
4. back up the current local Dortania tree before replacement;
5. verify reconstructed source payload identities before any Root Patch is authorized.

Only after this reconciliation/source-repair gate passes should the user manually perform Root Patch Restore + Root Patch using the corrected tree. One VESA verification boot must precede any ACTIVE acceleration retest.