# OCLP7 D97DI 0.0.6 — build / binary audit

Date: 2026-09-06 EEST

## Returned build
`OCLP7_D97DI_IMAC_BUILD_20260906_223615.zip`

- bytes: `56369`
- SHA256: `671d3a19af6a0168b89272c7833547e49a84dbf44fb03765e9c40bc61a4b0642`
- manifest mismatches: `0`
- Lilu build: PASS
- D97DI build: PASS
- BUILD SUCCEEDED count: `2`
- BUILD FAILED count: `0`
- compiler errors: `0`
- warnings: `6`, all non-functional build/toolchain warnings

Build host: macOS `26.6.2 / 25G83`, Intel i9-9900K, Xcode `26.5 (17F42)`, Apple clang `21.0.0`.

## Source identity
Authoritative D97DI source inside ZIP:
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`
- Git blob authority `df5f3a67b6117460c0c01b921db1affcb0c6489e`

Identity: PASS.

## Compiled kext
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`
- version `0.0.6`
- thin x86_64 Mach-O KEXTBUNDLE
- Mach-O UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`
- built Info.plist SHA256 `b228aa9e1e33f8d27b8e139afbde3c376076de12114b1a3d579eaf2465774484`
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`
- Lilu dependency `1.7.3`
- build report identifies ad-hoc signature

## D97BV binary payload audit
Exact SITE replacement:
`3dda0e00007406e93bcee9ff90`
- executable occurrence count: `1`

Exact CAVE replacement:
`3d187d0000b9177d00000f4cc1e9b4311600`
- executable occurrence count: `1`

Control-flow arithmetic independently rechecked:
- SITE non-3802 rel32 -> exact CAVE VM: PASS
- SITE exact-3802 `JE +6` -> SITE+13: PASS
- CAVE prefix equals exact original Tahoe 13-byte floor: PASS
- CAVE rel32 -> SITE+13: PASS

## Latent / fail-closed behavior
Source and binary retain:
- `-ocmcdiag` route gate;
- separate `-ocmcd97bv` functional gate;
- Apple-original-first `_cs_validate_page` call;
- callback exact-build `25G82` gate;
- exact SITE/CAVE page offsets;
- exact main `dyld_shared_cache_x86_64h` suffix;
- Apple result safety requirement validated `0xF`, tainted `0`, NX `0`;
- SITE exact preimage before exact 13-byte write at `+0x719`;
- CAVE full208 / first18 zero invariants before exact 18-byte write at `+0x560`;
- immediate postimage verification;
- D97DI IORegistry safety/mutation/postimage/write-count state.

Without `-ocmcd97bv`, D97DI remains LATENT / observe-only.

All required D97DD/D97DI runtime marker strings are present in the compiled executable.

Absent from executable strings:
- `vm_map_write_user`
- `orgVmMapWriteUser`
- `findAndReplace`
- `findAndReplaceWithMask`
- `injectPayload`
- `injectSegment`
- `vmProtect`

## Audited latent package
Prepared local package:
`OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`

- ZIP SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`
- bytes `23614`
- embedded AUDIT.txt SHA256 `e8b8b6e941fb976cfb2f7d01b9517d9e22895458ea3127317a48a4e31cae208c`
- embedded manifest SHA256 `fccce61cd6d4502eae9b31f4bb3e98d1ff5cd7accb0796b9dde1610a4d1462d3`

## Classifications
`D97DI_LOCAL_COMPILE=PASS`
`D97DI_MANIFEST_AUDIT=PASS`
`D97DI_SOURCE_IDENTITY=PASS`
`D97DI_MACHO_IDENTITY=PASS`
`D97DI_D97BV_BINARY_PAYLOAD=PASS`
`D97DI_D97BV_CONTROL_FLOW_REAUDIT=PASS`
`D97DI_REQUIRED_RUNTIME_MARKERS=PASS`
`D97DI_FORBIDDEN_GENERIC_PATCH_SURFACE=ABSENT`
`D97DI_LATENT_DEFAULT=PASS`
`D97DI_BUILD_BINARY_AUDIT=PASS`

## Authorization boundary
This audit does **not** authorize:
- D97DI deployment to ASUS2;
- adding `-ocmcd97bv`;
- functional D97BV mutation;
- Root Patch;
- accelerated boot;
- reboot.

ASUS2 remains on D97DD 0.0.4 until a separately authorized latent deployment step.