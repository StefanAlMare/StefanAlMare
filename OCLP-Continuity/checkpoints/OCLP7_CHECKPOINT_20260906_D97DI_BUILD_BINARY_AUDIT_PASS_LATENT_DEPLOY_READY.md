# OCLP7 CHECKPOINT — 2026-09-06 — D97DI build/binary audit PASS; latent deploy ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DI_HELPER_SHA_CORRECTED_BUILD_READY.md` for current execution.

## Entering ASUS2 state
ASUS2 remains unchanged:
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- unpatched VESA;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag`;
- boot args do **not** contain `-ocmcd97bv`;
- Lilu `1.7.3` at Kernel/Add index 0;
- OCLPMetalCompat unique index 5;
- active EFI remains D97DD `OCLPMetalCompat.kext` 0.0.4;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

No Root Patch and no functional D97BV mutation have been performed.

## Runtime prerequisite already closed
D97DG previously proved on exact 25G82:
- `_cs_validate_page` route PASS;
- callback execution PASS;
- callback exact-build gate PASS;
- exact SITE runtime preimage PASS;
- SITE Apple validated `0xF`, tainted 0, NX 0;
- exact CAVE full208 zero and first18 zero PASS;
- CAVE Apple validated `0xF`, tainted 0, NX 0.

Thus the runtime delivery/timing/preimage prerequisite for D97BV is CLOSED PASS.

## D97DI 0.0.6 source authority
Pinned source:
- path `OCLP-Continuity/artifacts/OCLP7_D97DI_kern_start.cpp`;
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Static design is already PASS. Functional writes are additionally gated by explicit `-ocmcd97bv`; without it D97DI is LATENT / observe-only.

Historical iMac helper identity correction is authoritative:
- commit `9d867d14c9be80e74ec9cefb50a30597de017959`;
- helper Git blob `8cc7f350f6fee51d17a6fbe1bbdfced4554a9ccf`;
- actual helper SHA256 `faea187c1e1f4b43dabcc231b62f4110c903cf3543f2711324bcbedf7854f49c`;
- previous documented `bbd360...` is stale/incorrect.

## Returned D97DI build
Returned ZIP:
`OCLP7_D97DI_IMAC_BUILD_20260906_223615.zip`

- bytes `56369`;
- SHA256 `671d3a19af6a0168b89272c7833547e49a84dbf44fb03765e9c40bc61a4b0642`;
- manifest mismatches `0`;
- Lilu build PASS;
- D97DI build PASS;
- two `BUILD SUCCEEDED`;
- zero `BUILD FAILED`;
- zero compiler errors;
- six non-functional toolchain/build-system warnings.

Build host: macOS `26.6.2 / 25G83`, Intel i9-9900K, Xcode `26.5 (17F42)`, Apple clang `21.0.0`.

## Compiled D97DI identity
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.6`;
- thin x86_64 Mach-O KEXTBUNDLE;
- UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- built Info.plist SHA256 `b228aa9e1e33f8d27b8e139afbde3c376076de12114b1a3d579eaf2465774484`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature per returned build report.

## Binary D97BV audit
Exact SITE payload `3dda0e00007406e93bcee9ff90`: one occurrence.
Exact CAVE payload `3d187d0000b9177d00000f4cc1e9b4311600`: one occurrence.

Control flow independently re-audited:
- SITE non-3802 rel32 -> exact CAVE VM PASS;
- SITE exact-3802 `JE +6` -> SITE+13 PASS;
- CAVE first 13 bytes == exact original Tahoe floor PASS;
- CAVE rel32 -> SITE+13 PASS.

All D97DD substrate markers and all D97DI functional mode/safety/mutation/postimage/write-count strings are present in the executable.

Forbidden generic patch/write surface absent from executable strings:
- `vm_map_write_user`;
- `orgVmMapWriteUser`;
- `findAndReplace`;
- `findAndReplaceWithMask`;
- `injectPayload`;
- `injectSegment`;
- `vmProtect`.

## Latent / fail-closed boundary
D97DI can write only after:
1. route enabled by `-ocmcdiag`;
2. Apple original `_cs_validate_page` returns;
3. exact build `25G82` callback gate passes;
4. exact SITE/CAVE page offset;
5. exact main x86_64h shared-cache vnode suffix;
6. explicit `-ocmcd97bv` present;
7. Apple result exactly validated `0xF`, tainted 0, NX 0;
8. exact SITE preimage or exact CAVE zero invariants;
9. exact fixed-size write;
10. exact postimage verification.

Without `-ocmcd97bv`, functional writes cannot occur.

## Audited latent deployment package
Prepared:
`OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`

- ZIP SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`;
- bytes `23614`;
- embedded AUDIT.txt SHA256 `e8b8b6e941fb976cfb2f7d01b9517d9e22895458ea3127317a48a4e31cae208c`;
- embedded manifest SHA256 `fccce61cd6d4502eae9b31f4bb3e98d1ff5cd7accb0796b9dde1610a4d1462d3`.

## Authoritative classifications
- `D97DI_LOCAL_COMPILE=PASS`;
- `D97DI_MANIFEST_AUDIT=PASS`;
- `D97DI_SOURCE_IDENTITY=PASS`;
- `D97DI_MACHO_IDENTITY=PASS`;
- `D97DI_D97BV_BINARY_PAYLOAD=PASS`;
- `D97DI_D97BV_CONTROL_FLOW_REAUDIT=PASS`;
- `D97DI_REQUIRED_RUNTIME_MARKERS=PASS`;
- `D97DI_FORBIDDEN_GENERIC_PATCH_SURFACE=ABSENT`;
- `D97DI_LATENT_DEFAULT=PASS`;
- `D97DI_BUILD_BINARY_AUDIT=PASS`.

## CURRENT ACTION
D97DI 0.0.6 is ready for an identity-pinned **LATENT** deployment design from D97DD 0.0.4, explicitly preserving the current config and leaving `-ocmcd97bv` absent.

No ASUS2 deployment is yet authorized by this checkpoint. No boot-arg change, functional mutation, Root Patch, accelerated boot or reboot is authorized.