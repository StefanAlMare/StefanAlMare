# OCLP7 CHECKPOINT — 2026-09-06 — D97CM: Lilu __TEXT mapping PASS; standard BinaryModInfo blocked by cache-only Metal; cs_validate_page delivery path selected; D97CN ready

## Entering state
- Tahoe `26.6.2 / 25G82`.
- ASUS2 Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Runtime remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Golden Sequoia remains immutable/read-only.
- D97CJ closed standalone Metal reconstruction as production mainline because cache-origin Objective-C relocation state is broad.
- Current production direction remains native Tahoe Metal/Metal4 in the original dyld shared cache plus a separate OCLP-specific Lilu plugin for the bounded D97BV selective-3802 adapter.

## D97CM returned artifact
Returned ZIP:
`OCLP7_D97CM_LILU_MAP_PARSER_AND_TARGET_PRELOOKUP_AUDIT_20260906_151912.zip`

Hashes:
- ZIP SHA256 `bc587bcb48eb6c4350b444c9c41566cfbb86c092c63c66f498c31924b91b41dd`;
- TXT final SHA256 `1d998ac1b793b2eb76f6ad1a6b298b42a4fc6c070ab8bfd681b6718a6e348675`;
- embedded report SHA256 `b42fbc898794b7d143fcbbc172b4d01ae8d09fdeebd9440f7f6948a56c486cc6`, independently verified against the TXT bytes preceding the appended `REPORT_SHA256=` line.

Safety:
- system mutation NO;
- cache mutation NO;
- Root Patch NO;
- reboot NO;
- tool install NO;
- local compilation NO;
- Apple binary in ZIP NO.

## Runtime substrate reconfirmed
D97CM reconfirmed:
- OS/build exact gate PASS (`26.6.2 / 25G82`);
- Lilu `1.7.3` loaded;
- WhateverGreen `1.7.1` loaded;
- `-liluuseroff` absent;
- `-liluslow` absent.

## Exact Tahoe x86_64h map block
Map:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h.map`

Map SHA256:
`7ba135a8028731fafc6c1ccba10d0cda1c7b939a1402f10834c97c489bbf8a30`

Exact Metal record occurs once:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`

Exact block:
- `__TEXT 0x7FF80F47D000 -> 0x7FF80F76815A`
- `__DATA_CONST 0x7FF84119DCD0 -> 0x7FF84120D4F0`
- `__DATA 0x7FF843D590C0 -> 0x7FF843D65DC0`
- `__DATA_DIRTY 0x7FF84384F510 -> 0x7FF843853E48`
- `__LINKEDIT 0x7FF880000000 -> 0x7FF8899F0000`

## Lilu map parser classification
A faithful emulation of current upstream `UserPatcher::mapAddresses()` found:
- path match count = 1;
- Lilu-emulated `__TEXT start = 0x7FF80F47D000`;
- Lilu-emulated `__TEXT end = 0x7FF80F76815A`;
- independent record parser produced the same `__TEXT` start/end.

Classifications:
- `D97CM_METAL_RECORD_IDENTITY=PASS`;
- `D97CM_LILU_TEXT_START_PARITY=PASS`;
- `D97CM_LILU_TEXT_END_PARITY=PASS`;
- `D97CM_LILU_TEXT_BASE_MATCHES_RETAINED_NATIVE_METAL=PASS`;
- `D97CM_LILU_MAP_PARSER_TEXT_SUBSTRATE=PASS`.

The current parser mis-parses the Tahoe Metal `__DATA` bounds in this emulation (`start=0xC`, reused first arrow), but D97BV is an `__TEXT` code adapter. Therefore the DATA parser defect is not a blocker for this exact patch class. Do not generalize this result to DATA patches.

## Exact D97BV arithmetic survives Lilu __TEXT mapping
Retained D97BV addresses:
- native Metal `__TEXT base = 0x7FF80F47D000`;
- selective adapter site `0x7FF80F5E1719 = __TEXT + 0x164719`;
- executable cave `0x7FF80F47E560 = __TEXT + 0x1560`.

D97CM recomputed from Lilu's parsed `__TEXT` base:
- site = `0x7FF80F5E1719` exact;
- cave = `0x7FF80F47E560` exact.

Classification:
`D97CM_D97BV_TEXT_ADDRESS_ARITHMETIC=PASS`.

## Standard BinaryModInfo blocker
Canonical Tahoe Metal binary:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`

D97CM found:
- exists = NO;
- readable = NO;
- regular file = NO.

The framework directory and symlink surface exist, but the binary itself is cache-resident only.

Current upstream Lilu `UserPatcher::registerPatches()` calls `loadFilesForPatching()` before `loadDyldSharedCacheMapping()`. `loadFilesForPatching()` reads `BinaryModInfo.path` as a standalone Mach-O in order to derive section and patch offsets. Therefore a normal `BinaryModInfo` definition for Metal cannot prepare D97BV on Tahoe 25G82 even though the `.map` parser itself succeeds.

Authoritative classifications:
- `D97CM_STANDARD_LILU_TARGET_FILE_PRELOOKUP=BLOCKED_CANONICAL_METAL_NOT_READABLE_REGULAR_FILE`;
- `D97CM_STANDARD_BINARYMODINFO_STATIC_PREREQUISITES=PARTIAL_OR_BLOCKED`;
- `D97CM_LILU_GENERAL_SUBSTRATE=POSITIVE`;
- `D97CM_PLAIN_STANDARD_BINARYMODINFO_FOR_TAHOE_METAL=NEGATIVE`.

Do not create a fake canonical Metal file and do not reintroduce standalone Metal simply to satisfy `loadFilesForPatching()`.

## Upstream precedent changes the preferred delivery mechanism
Current FeatureUnlock, itself a standalone Lilu plugin used by OCLP, hooks `_cs_validate_page` on Big Sur and newer. Its handler:
1. calls the original code-sign validation routine;
2. resolves the vnode path;
3. checks `UserPatcher::matchSharedCachePath(path)`;
4. searches/modifies bytes directly in the validated dyld shared-cache page.

This path does not require the cache-resident framework to exist as a standalone canonical file and does not require reconstructing Metal.

For D97BV this is architecturally preferable to forcing standard BinaryModInfo:
`OpenCore -> Lilu + OCLPMetalCompat loaded -> cs_validate_page hook -> exact dyld shared-cache vnode/page -> verify exact preimage -> patch only D97BV bytes before normal mapping/execution`.

This remains a separate plugin. Lilu itself is not modified; WhateverGreen is not modified.

## D97BV bytes retained
Site original, 13 bytes:
`3d187d0000b9177d00000f4cc1`

Site replacement, 13 bytes:
`3dda0e00007406e93bcee9ff90`

Cave replacement, 18 bytes:
`3d187d0000b9177d00000f4cc1e9b4311600`

The native shared-cache cave must be revalidated in its actual cache page. The previous standalone signing cave conflict does not automatically apply to the original shared-cache representation.

## D97CN prepared
Script:
`OCLP7_D97CN_DSC_CODEVALIDATION_PAGE_TOPOLOGY_PREFLIGHT.sh`

Local artifact:
- bytes `11842`;
- SHA256 `2d77e64a39d59187d026b6f1644bc50650c7b3be7a281ad975ae78fc67945faa`;
- `bash -n` PASS;
- embedded Python compile PASS.

D97CN is read-only and does not compile or install anything. It enumerates the split x86_64h dyld cache files, parses each cache header/mapping table, maps D97BV site+cave preferred VM addresses to the exact cache vnode/file offset and 4K `cs_validate_page` page offset, then verifies the exact site preimage and the full 208-byte zero cave directly from the cache file.

## Decision gate after D97CN
If all of the following pass:
- unique mapping for site and cave;
- exact expected cache vnode/subcache identified;
- site preimage exact;
- full native 208-byte cave still zero;
- both replacement windows fit within one 4K page each;
- final `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`;

then the next mainline step is static source construction of the minimal separate `OCLPMetalCompat.kext` prototype using the FeatureUnlock-style `cs_validate_page` delivery mechanism, with exact page/preimage fail-closed gates.

No runtime plugin installation, Root Patch, accelerated boot or reboot is authorized by D97CN alone.

## CURRENT ACTION
Remain unpatched Tahoe VESA.
Run only `OCLP7_D97CN_DSC_CODEVALIDATION_PAGE_TOPOLOGY_PREFLIGHT.sh` and return its ZIP.

GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation. No local compilation is authorized unless explicitly changed later.