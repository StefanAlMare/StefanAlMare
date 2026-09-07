# OCLP7 CHECKPOINT — D97FX 25G82 metallib source reconstruction helper ready

Date: 2026-09-07 EEST

## Entering authority
D97FW proved a systemic metallib materialization failure:
- exact original package identity PASS;
- 180 regular real `.metallib` package payloads;
- local exact payloads `0/180`;
- local metadata stubs `180/180`;
- installed exact payloads `0/180`;
- installed metadata stubs `180/180`;
- every stub's declared size matches its corresponding real package file size.

D97FW checkpoint:
`OCLP7_CHECKPOINT_20260907_D97FW_GLOBAL_METALLIB_TREE_ALL_180_METADATA_STUBS.md`
commit `41df9c6582227c61e8bfb2e99bf8469829db4830`.

## Repair principle
Do not repair individual metallibs.
Do not directly mutate the current root volume.
Reconstruct the complete local 25G82 source tree from the exact original package payload, preserving all regular files and symlinks. This automatically preserves any alias/non-regular representation relevant to the previously synthesized 182-entry patch map.

The later D97DX Root Patch preflight remains the authoritative closure gate for all expected patch targets.

## Helper authority
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97FX_RECONSTRUCT_25G82_METALLIB_SOURCE.sh`

Source commit:
`a02e75e3d4284942fa2112f2964b818a59cc9c7b`

Git blob:
`b8e9675b16b38575bccfad5cb5c24438531480e7`

## Helper behavior
Fail-close checks:
- Darwin;
- exact host build `25G82`;
- exact original package bytes `116574513`;
- exact package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- current local CoreDisplay file still matches the known ASCII-stub state before proceeding.

Reconstruction:
- `pkgutil --expand-full` only in a Desktop working directory;
- identifies exact package payload root;
- copies the complete 25G82 tree with `ditto`;
- compares every regular file by path, bytes and SHA256 between package payload and staging tree;
- compares all symlink paths and targets;
- requires exactly 180 regular `.metallib` files;
- requires CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d` and `MTLB` magic.

Atomic source swap:
- existing local Dortania 25G82 tree is moved to timestamped backup;
- verified staging tree is moved to the exact local Dortania path;
- source tree is set root:wheel;
- exhaustive post-swap comparison repeats;
- if post-swap verification fails, helper automatically restores the old source tree.

Explicit non-actions:
- no Root Patch;
- no root-volume mutation;
- no EFI/NVRAM/framebuffer/bootarg change;
- no reboot.

## Authorization
D97FX helper is authorized to reconstruct only the local source tree.
It does NOT authorize Root Patch or reboot.

After D97FX PASS, next gate is:
1. verify corrected local source identity;
2. user manually performs Root Patch Restore + Root Patch using D97DX only after explicit separate authorization;
3. VESA verification boot first;
4. only then one measured ACTIVE acceleration retest.