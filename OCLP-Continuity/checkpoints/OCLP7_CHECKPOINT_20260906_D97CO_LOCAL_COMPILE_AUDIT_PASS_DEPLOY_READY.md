# OCLP7 CHECKPOINT — 2026-09-06 — D97CO local compile/audit PASS; VESA diagnostic deploy ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CN_PAGE_TOPOLOGY_PASS_D97CO_OBSERVE_ONLY_SOURCE_READY.md` for current execution state.

## Entering state
- ASUS2 remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current state remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- D97CL substrate PASS, D97CM map/parser PASS with plain BinaryModInfo NEGATIVE, and D97CN exact code-validation page topology PASS remain authoritative.
- D97BV functional shared-cache mutation remains unapplied and unauthorized.
- Local compilation was explicitly authorized by the user for the iMac 9900K build host.

## D97CO authoritative source identity
Experimental branch: `oclpmc-d97co-observe-only`.
Exact project head: `8c4904870b8512fe356fcb48e82fb32a9e980634`.
Source path: `OCLPMetalCompat/OCLPMetalCompat/kern_start.cpp`.
Source Git blob: `532643ed9d041db2b1af8a865a6949396b77980d`.
Source SHA256: `f115b269b6fff23b369da05d4ab916dd36c87bdca7dd47b12b38e1a6f515e22e`.
Info.plist Git blob: `7d6b00ac1e8cbc26396a114c550ccac01c0bc008`.
Authoritative Info.plist SHA256: `985412089712247f13098adaccf751cb7e844aea22b74f80add267882f57ade5`.

## Local build provenance
Build host:
- macOS `26.6.2 / 25G83`;
- Darwin `25.6.0` x86_64;
- Intel Core i9-9900K;
- Xcode `26.5`, build `17F42`;
- Apple clang `21.0.0`.

Pinned build inputs:
- FeatureUnlock scaffold commit `201bd45766207e6cc10cd40a8ac1f9c6216f9acb`;
- Lilu commit `0515f40b7f2a096adc85e832a4c6104fbd07f936`, built version `1.7.3`;
- MacKernelSDK commit `05094e5e88cec7caedbfb35e8449ed0db94bf95b`.

Both Lilu and plugin builds returned `xcodebuild RC=0` / `BUILD SUCCEEDED`.
There were zero build errors. Six warnings were non-functional build-system/toolchain warnings: old deployment target notice for Lilu, script phases without outputs, one unused `-stdlib=libc++`, duplicate `-lkmod`, and archive-phase dependency-analysis notice.

## Returned iMac build artifact
Returned ZIP: `OCLP7_D97CO_IMAC_BUILD_20260906_164754.zip`.
ZIP bytes: `52559`.
ZIP SHA256: `937332463f94bc32898432e9ad66775adb97292d57e65f238cc11e97fb184ad8`.

Inner hashes independently verified:
- build log SHA256 `db45118d55828e4a0a11be7ea488c46c7437a040e2c45b096f29e0b8049a5b27`;
- authoritative source SHA256 `f115b269b6fff23b369da05d4ab916dd36c87bdca7dd47b12b38e1a6f515e22e`;
- authoritative plist SHA256 `985412089712247f13098adaccf751cb7e844aea22b74f80add267882f57ade5`;
- compiled executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`;
- built Info.plist SHA256 `c28a4ce392d889b85dc49d16087fecc01b4e199311b741be4188eec52c82f4b3`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`.

Packaging-only defect in the original ZIP:
- `SHA256SUMS.txt` captured `D97CO_BUILD_REPORT.txt` before the script appended its last report lines;
- therefore only the report hash in that original manifest is stale;
- final report actual SHA256 is `65ce62465bc5f4138c3a71320f9f3c3d06a7abfaf4f2871b2ecfa6d5cf81ae69`;
- all binary/source/plist/CodeResources hashes matched exactly.
This is tooling-only and does not invalidate the compiled kext.

## Compiled kext identity
Bundle: `OCLPMetalCompat.kext`.
Bundle ID: `com.oclpmetalcompat.OCLPMetalCompat`.
Version: `0.0.1`.
Architecture: thin x86_64 Mach-O kext bundle.
Mach-O UUID: `319A3777-1BB1-3395-9E7A-6A0426C58723`.
Signature: ad-hoc.
Lilu dependency: exact `1.7.3`.
Built Info.plist records build host `25G83`, but runtime logic remains gated to exact target `kern.osversion == 25G82`; the host/target build difference is therefore non-blocking.

## Independent observe-only binary audit
The compiled binary contains:
- one copy of the original 13-byte D97BV site preimage `3d187d0000b9177d00000f4cc1`, used as comparison data;
- zero copies of the D97BV site replacement `3dda0e00007406e93bcee9ff90`;
- zero copies of the D97BV cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

No symbol/path for any of the following exists in the compiled binary:
- `vm_map_write_user`;
- `orgVmMapWriteUser`;
- `findAndReplace`;
- `vmProtect`;
- payload/segment injection.

Expected observation dependencies/markers are present:
- `UserPatcher::matchSharedCachePath`;
- `_vn_getpath`;
- `_sysctlbyname`;
- `_memcmp`;
- `D97CO_ROUTE_CS_VALIDATE_PAGE=PASS`;
- `D97CO_SITE_SEEN`;
- `D97CO_CAVE_SEEN`.

Upstream FeatureUnlock commit `201bd457...` uses the same Big Sur+ `_cs_validate_page` wrapper signature and calls the Apple validator first, matching D97CO's route ABI precedent.

Authoritative classification:
`D97CO_LOCAL_COMPILE_AND_BINARY_IDENTITY_AUDIT=PASS`.
`D97CO_COMPILED_OBSERVE_ONLY_NO_FUNCTIONAL_PAGE_MUTATION=PASS`.

D97CO is compile-proven and static/binary-audited, but not yet runtime timing-proven.

## Audited deploy package
A corrected audit/deploy package was generated without changing any kext file bytes:
`OCLP7_D97CO_AUDITED_DEPLOY_20260906.zip`.
ZIP SHA256: `e062ef672c003d2d6ff11508d1f4cd5e43b94c45ec7de1c9919358cbd0a9fad7`.
Manifest SHA256: `58e2d25925b3dacc607c374a625bb04e91cd501d2b656c18122c27e90b1c186d`.
The executable inside remains SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.

## CURRENT ACTION
Remain unpatched VESA. No Root Patch and no accelerated boot.

Next bounded experiment is an identity-pinned EFI deployment of **D97CO observe-only only**, retaining `-igfxvesa` and adding explicit activation `-ocmcdiag` for one VESA diagnostic boot.

The runtime experiment may establish only:
1. `D97CO_ROUTE_CS_VALIDATE_PAGE=PASS`;
2. whether the site page is seen with `preimage=PASS`;
3. whether the cave page is seen with `window18=PASS full208=PASS`;
4. Apple's returned `validated/tainted/nx` state for those pages.

No functional D97BV byte write is authorized until this runtime timing/preimage proof passes.
