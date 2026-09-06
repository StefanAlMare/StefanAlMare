# OCLP7 CHECKPOINT — 2026-09-06 — D97CN page topology PASS; D97CO observe-only source ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CM_LILU_TEXT_PASS_STANDARD_BINARYMODINFO_BLOCKED_CS_VALIDATE_PAGE_D97CN_READY.md`.

## Entering state
- ASUS2 remains Tahoe `26.6.2 / 25G82`, Darwin 25, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current boot remains unpatched VESA with `-igfxvesa`.
- No Root Patch, accelerated reboot, system/cache mutation or local compilation is authorized.
- Native Tahoe Metal/Metal4 in dyld shared cache remains authoritative.
- Standalone-Metal reconstruction remains closed as production mainline.

## D97CM retained closure
Returned ZIP `OCLP7_D97CM_LILU_MAP_PARSER_AND_TARGET_PRELOOKUP_AUDIT_20260906_151912.zip`:
- ZIP bytes `2341`;
- ZIP SHA256 `bc587bcb48eb6c4350b444c9c41566cfbb86c092c63c66f498c31924b91b41dd`;
- TXT bytes `5567`;
- TXT SHA256 `1d998ac1b793b2eb76f6ad1a6b298b42a4fc6c070ab8bfd681b6718a6e348675`;
- embedded pre-append report SHA256 `b42fbc898794b7d143fcbbc172b4d01ae8d09fdeebd9440f7f6948a56c486cc6`, independently verified.

D97CM proved:
- exact Metal map `__TEXT` start `0x7FF80F47D000` and end `0x7FF80F76815A`;
- Lilu `mapAddresses()` emulation obtains the same `__TEXT` range;
- D97BV site `0x7FF80F5E1719` and cave `0x7FF80F47E560` derive exactly from that base;
- `D97CM_LILU_MAP_PARSER_TEXT_SUBSTRATE=PASS`;
- `D97CM_D97BV_TEXT_ADDRESS_ARITHMETIC=PASS`;
- canonical `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` is absent/not readable/not a regular file;
- standard Lilu `BinaryModInfo` prelookup is therefore blocked before shared-cache application.

Authoritative D97CM classification:
- Lilu general patching/hooking infrastructure remains viable;
- plain standard `BinaryModInfo` is not the Tahoe Metal delivery mechanism;
- do not create/shadow a fake canonical Metal file to satisfy that prelookup.

## D97CN returned evidence
Returned ZIP `OCLP7_D97CN_DSC_CODEVALIDATION_PAGE_TOPOLOGY_PREFLIGHT_20260906_153134.zip`:
- ZIP bytes `2892`;
- ZIP SHA256 `a468b57ed1bb0917790c803848e084f67aecabf2ad18ccc8893d7f325bef24ea`;
- TXT bytes `10885`;
- TXT SHA256 `fe0b48280d08a6b77dae03acd67a720770663e1cdb3c95c1fae2b1b46bed0b6e`;
- embedded pre-append report SHA256 `c17b8ac6598e86688b19c3a22ccdcbc28bd12204a0ae7cbc376195a5b791303e`, independently verified.

Host gates:
- `PRODUCT_VERSION=26.6.2`;
- `BUILD=25G82`;
- page size `4096`;
- `D97CN_OS_BUILD_GATE=PASS`;
- `D97CN_PAGE_SIZE_GATE=PASS`.

### Exact split-cache topology
The target D97BV site and cave both resolve uniquely into the **main** cache vnode:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`

Main cache UUID:
`5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`.

Both are in mapping index 0:
- preferred VM `0x7FF800000000 .. 0x7FF826BF4000`;
- file offset base `0x0`;
- max/init protection `5/5` (`r-x`).

### D97BV site page
- preferred VM `0x7FF80F5E1719`;
- cache-file offset `0xF5E1719`;
- `cs_validate_page` page offset `0xF5E1000`;
- offset inside 4K page `0x719`;
- page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- expected/actual preimage exact:
  `3d187d0000b9177d00000f4cc1`;
- `D97CN_SITE_PREIMAGE_MATCH=PASS`;
- D97BV site replacement fits wholly inside that page.

### D97BV cave page
- preferred VM `0x7FF80F47E560`;
- cache-file offset `0xF47E560`;
- `cs_validate_page` page offset `0xF47E000`;
- offset inside 4K page `0x560`;
- page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- full native cave length `208` bytes;
- full 208-byte cave is zero: PASS;
- cave SHA256 `46f531b7ea0428fbf2c3ca2b60e8dc33d6bbfa000e0fd1b489c5e39140a47006`;
- first 18-byte future D97BV functional window is all zero: PASS;
- D97BV cave replacement fits wholly inside that page.

Site and cave:
- same cache vnode: YES;
- same 4K page: NO.

Final classification:
`D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

Important interpretation: the historical statement that the standalone reconstructed carrier consumed part of the `0x1560` cave under its code-signature geometry does **not** invalidate the native shared-cache cave. D97CN directly proves the original Apple cache representation still contains the complete 208-byte zero cave.

## Upstream mechanism precedent
Current FeatureUnlock uses a Lilu `onPatcherLoadForce` route for `_cs_validate_page` on Big Sur+ and calls Apple's original validator before examining/patching dyld shared-cache page bytes. It identifies DSC vnodes with `UserPatcher::matchSharedCachePath`.

This is treated as architectural precedent only; D97CO still must runtime-prove that the two exact Tahoe 25G82 D97BV pages are observed through the hook before functional mutation is authorized.

## D97CO — observe-only OCLPMetalCompat source
Experimental branch:
`oclpmc-d97co-observe-only`

Branch head after initial source integration:
`8c4904870b8512fe356fcb48e82fb32a9e980634`.

Source:
`OCLPMetalCompat/OCLPMetalCompat/kern_start.cpp`
Git blob SHA `532643ed9d041db2b1af8a865a6949396b77980d`.

Additional source-only files:
- `OCLPMetalCompat/OCLPMetalCompat/Info.plist`;
- `OCLPMetalCompat/README.md`.

D97CO design is deliberately **observation-only**:
- explicit activation requires `-ocmcdiag`;
- plugin config is Tahoe-only;
- runtime build gate requires exact `kern.osversion == 25G82`;
- CPU gate requires Haswell;
- wrapper calls original `_cs_validate_page` first;
- callback returns immediately unless page offset is exactly `0xF5E1000` or `0xF47E000`;
- vnode must be a dyld shared-cache path ending exactly in `/dyld_shared_cache_x86_64h`;
- site observer compares the exact 13-byte D97BV preimage;
- cave observer checks both first 18 bytes and full 208 bytes are zero;
- it logs Apple's post-validation `validated`, `tainted`, and `nx` state.

Static no-mutation audit:
- `data` remains `const`;
- no `const_cast`;
- no `KernelPatcher::findAndReplace`;
- no `vm_map_write_user` path;
- no Root Patch or reboot logic.

Classification:
`D97CO_OBSERVE_ONLY_LOGIC=STATIC_AUDITED_NO_PAGE_MUTATION`.

This is **not yet compile-proven or runtime-proven**. No kext binary exists yet.

## Build-lane blocker
Per permanent project rules, GitHub Actions build/package remains suspended until explicit confirmation that the quota/blocker is cleared. Local compilation is not an implicit fallback and is not authorized.

Therefore no GitHub Actions run and no ASUS2 local compile are performed at this checkpoint.

## CURRENT ACTION
Remain unpatched Tahoe VESA.

Next allowed GitHub-side work when build execution is available:
1. finish/pin build project infrastructure for `OCLPMetalCompat` against current Lilu/MacKernelSDK;
2. compile D97CO observe-only;
3. audit symbol dependencies, Info.plist, bundle identity and binary SHA;
4. package a diagnostic kext artifact;
5. only then provide identity-pinned EFI deployment instructions for a **VESA diagnostic boot** with `-ocmcdiag`;
6. collect only D97CO route/site/cave log markers;
7. functional D97BV page writes remain unauthorized until D97CO runtime timing/preimage proof passes.

No Root Patch is required for the D97CO timing probe. No accelerated boot is authorized. No functional shared-cache mutation is authorized.