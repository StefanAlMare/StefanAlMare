# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CO_LOCAL_COMPILE_AUDIT_PASS_DEPLOY_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: one native Tahoe Metal/Metal4 image with a selective 3802 ingress lane plus the otherwise unchanged Tahoe 32023/32024 lane, feeding an audited legacy compiler path and Haswell driver.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compilers may be bounded; legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic proven: preserve exact 3802, otherwise execute original Tahoe floor.
Native `__TEXT` base `0x7FF80F47D000`.
Site `0x7FF80F5E1719 = +0x164719`, original `3d187d0000b9177d00000f4cc1`, replacement `3dda0e00007406e93bcee9ff90`.
Cave `0x7FF80F47E560 = +0x1560`, replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied.

## D97BW-v2 / D97BX — sparse closure
Sparse reconstruction preserves native code/Metal4 but is not standalone-loadable. Signing and D97BV were not the blocker.

## D97BY — real DSC export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` extraction succeed and preserve native `__text`/Metal4. First real-load rejection was missing `SG_READ_ONLY`.

## D97BZ — SG_READ_ONLY gate passed
Metadata-only flag repair passes that gate. Next exact rejection was segment VM order.

## D97CA — order-remap surface enumerated
0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.

## D97CB — atomic order remap structural PASS
Exact order/SG_READ_ONLY/n_sect repair passed parser/preflight. v2-v4 contained harness defects. v5 proved a valid cold harness.

## D97CB-v5 — cold harness proven; sub-page mapping frontier
Bundle SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.
Baseline `/usr/bin/true` exit 0 with Metal/libbz2 delayed. Positive control libbz2 exit 0 final loaded.
Signed remapped RAW Metal maps `__TEXT`; next failure `__DATA_CONST mmap(...CD0) errno=22`.

## D97CC — page-prefix/LINKEDIT static closure
4K page-prefix plan preserves original section/content VM addresses while page-aligning segment mapping starts/fileoffs. Exactly 20 section offsets; `__LINKEDIT +0x3000`; 7 total LINKEDIT metadata updates.

## D97CD — standalone mappings succeed; Objective-C frontier
Bundle SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient page-aligned Metal SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.
All five segments map; runtime reaches `makeSegmentsReadWrite`, then `RC=-11`.

## D97CE — --slide does not advance Objective-C frontier
SLIDE SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.
`--slide` changes `88012` bytes / `43909` qword chunks, heavily in ObjC/data metadata, but page-aligned SLIDE Metal reproduces D97CD. `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`.

## D97CF — true single Metal; duplicate cause CLOSED NEGATIVE
Bundle SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.
Temp Metal loaded, native cache Metal absent, one Metal path/UUID, yet same RW marker -> `RC=-11`.

## D97CG — LLDB hook tooling-negative
Bundle SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.
LLDB hook channel failed; no Metal causal conclusion. Do not rerun.

## D97CH — exact libobjc crash-site proof
Two independent runs stop at `libobjc.A.dylib map_images_nolock + 676`, instruction `orb $0x1,(%rcx)`, RIP `0x7ff804ad9bba`.
Source correlation: `header_info::setLoaded(true)` / preoptimized shared-cache RW bookkeeping.

## D97CI-v2 — OptimizedByDyld bit causal; later readClass fault
Returned bundle SHA256 `1dff54d95dbff8725d11e59e62506c4bca8367fcc2d5312474e72a4bd8662eb4`.
One `__objc_imageinfo` flags byte changed `0x49 -> 0x41`, XOR `0x08`; adapted SHA256 `c58780541c8079cbf9c095b01a906ed64ff998787918f13cfd600005acd848b7`.
D97CH setLoaded fault disappeared.
New fault: `readClass +69`, `EXC_BAD_ACCESS 0x20`, RAX `0x8`, RBX/RDI `0x7FF843D60620`.
That class pointer is preferred Metal `__DATA +0x7620`, while standalone runtime would require `0x134FB0620`.

Classifications:
- `D97CI_V2_D97CH_SETLOADED_FAULT_CLEARED=RUNTIME_PROVEN`;
- `D97CI_V2_NEW_READCLASS_FAULT=RUNTIME_PROVEN`;
- `D97CI_V2_CLASSLIST_OR_EQUIVALENT_INTERNAL_CLASS_POINTER_UNREBASED=RUNTIME_STRUCTURAL_PROVEN`.

## D97CJ — broad standalone ObjC relocation closure
Returned `OCLP7_D97CJ_OBJC_RELOCATION_TOPOLOGY_20260906_135939.zip`.
Raw LLDB ties RBX/RDI exactly to static `__objc_classlist[0]`.
Topology is broad: 422/422 classlist, 2/2 catlist, 144/144 protolist and 385/385 superrefs are in-image preferred, with further cache/preferred surfaces.
Final helper failure was tooling-only after decisive evidence.

Classifications:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Production direction shifts to native shared-cache Metal plus a bounded OCLP-specific Lilu plugin.

## D97CL — Lilu / DSC runtime substrate PASS
Returned ZIP SHA256 `3f97d2b82765d5e1a847b8c0a0ad1982fcced6c5c1978ff282f177ea39dd1f4e`.
TXT final SHA256 `ee9762f22ad15ed7185c184b5246298e091bdf9a97d44b07a56d402bb6c56774`.
Embedded report SHA256 `5443d54ea576d0739723eb0d501e86fc9f050abb64f2b8bacf12072cd2c28f58` verified.

ASUS2: AVX2, Lilu `1.7.3`, WhateverGreen `1.7.1`, no `-liluuseroff`, no `-liluslow`, exact Cryptex x86_64h cache plus `.map`, native Metal path present in map.

Classifications:
- `D97CL_FAST_SHARED_CACHE_MAPPING_PRECONDITION=PASS`;
- `D97CL_EXPECTED_CACHE_BINARY_PRECONDITION=PASS`;
- `D97CL_USERPATCHER_BOOTARG_PRECONDITION=PASS`.

## D97CM — Lilu map TEXT PASS; plain BinaryModInfo NEGATIVE
Returned `OCLP7_D97CM_LILU_MAP_PARSER_AND_TARGET_PRELOOKUP_AUDIT_20260906_151912.zip`:
- ZIP SHA256 `bc587bcb48eb6c4350b444c9c41566cfbb86c092c63c66f498c31924b91b41dd`;
- TXT SHA256 `1d998ac1b793b2eb76f6ad1a6b298b42a4fc6c070ab8bfd681b6718a6e348675`;
- embedded report SHA256 `b42fbc898794b7d143fcbbc172b4d01ae8d09fdeebd9440f7f6948a56c486cc6`, verified.

Lilu-emulated Metal `__TEXT` exactly matches `0x7FF80F47D000 -> 0x7FF80F76815A`; D97BV site/cave arithmetic exact PASS.
Canonical standalone Metal file is absent, so standard `loadFilesForPatching()` prelookup cannot prepare Metal.

Classifications:
- `D97CM_LILU_MAP_PARSER_TEXT_SUBSTRATE=PASS`;
- `D97CM_D97BV_TEXT_ADDRESS_ARITHMETIC=PASS`;
- `D97CM_STANDARD_LILU_TARGET_FILE_PRELOOKUP=BLOCKED_CANONICAL_METAL_NOT_READABLE_REGULAR_FILE`;
- plain standard BinaryModInfo for Tahoe Metal = NEGATIVE;
- Lilu general substrate = POSITIVE.

FeatureUnlock's `_cs_validate_page` route becomes the preferred architectural precedent.

## D97CN — exact DSC code-validation page topology PASS
Returned `OCLP7_D97CN_DSC_CODEVALIDATION_PAGE_TOPOLOGY_PREFLIGHT_20260906_153134.zip`:
- ZIP SHA256 `a468b57ed1bb0917790c803848e084f67aecabf2ad18ccc8893d7f325bef24ea`;
- TXT SHA256 `fe0b48280d08a6b77dae03acd67a720770663e1cdb3c95c1fae2b1b46bed0b6e`;
- embedded report SHA256 `c17b8ac6598e86688b19c3a22ccdcbc376195a5b791303e`, verified.

Both targets resolve uniquely into the main `dyld_shared_cache_x86_64h`, UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`, mapping 0 r-x.

Site:
- `page_offset=0xF5E1000`, in-page `0x719`;
- page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- exact 13-byte D97BV preimage PASS.

Cave:
- `page_offset=0xF47E000`, in-page `0x560`;
- page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- all 208 bytes zero PASS;
- cave SHA256 `46f531b7ea0428fbf2c3ca2b60e8dc33d6bbfa000e0fd1b489c5e39140a47006`;
- first future functional 18-byte window zero PASS.

Same vnode YES; same 4K page NO; both replacement windows fit within one page.
`D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

This directly reopens the original native-cache cave for page-hook delivery; the standalone carrier's code-signature cave collision is not relevant to the native cache representation.

## D97CO — observe-only OCLPMetalCompat compile/audit PASS
Experimental branch `oclpmc-d97co-observe-only`.
Exact source head `8c4904870b8512fe356fcb48e82fb32a9e980634`.
Source Git blob `532643ed9d041db2b1af8a865a6949396b77980d`.

D97CO requires explicit `-ocmcdiag`, exact Tahoe build `25G82`, Haswell CPU, calls original `_cs_validate_page` first, observes only D97CN page offsets and exact main x86_64h cache path, logs site/cave preimage state and Apple's validated/tainted/nx outputs.

Local compilation on the iMac 9900K was explicitly user-authorized.
Returned `OCLP7_D97CO_IMAC_BUILD_20260906_164754.zip`:
- bytes `52559`;
- SHA256 `937332463f94bc32898432e9ad66775adb97292d57e65f238cc11e97fb184ad8`.

Compiled kext identity:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.1`;
- thin x86_64;
- UUID `319A3777-1BB1-3395-9E7A-6A0426C58723`;
- executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`;
- Info.plist SHA256 `c28a4ce392d889b85dc49d16087fecc01b4e199311b741be4188eec52c82f4b3`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature.

Independent binary audit found no D97BV replacement bytes and no write/injection path. Required D97CO route/site/cave marker strings are present. The original build manifest had one tooling-only stale hash for the report because final report lines were appended after manifest creation; all kext/source/plist hashes matched.

Corrected audited deploy package:
- `OCLP7_D97CO_AUDITED_DEPLOY_20260906.zip`;
- SHA256 `e062ef672c003d2d6ff11508d1f4cd5e43b94c45ec7de1c9919358cbd0a9fad7`;
- executable remains exact SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.

Classifications:
- `D97CO_OBSERVE_ONLY_LOGIC=STATIC_AUDITED_NO_PAGE_MUTATION`;
- `D97CO_LOCAL_COMPILE_AND_BINARY_IDENTITY_AUDIT=PASS`;
- `D97CO_COMPILED_OBSERVE_ONLY_NO_FUNCTIONAL_PAGE_MUTATION=PASS`.

Runtime timing remains unproven.

## CURRENT ACTION
Remain unpatched Tahoe VESA.

Next bounded experiment:
1. deploy the identity-pinned D97CO observe-only kext in active OpenCore EFI after Lilu;
2. retain `-igfxvesa` and add `-ocmcdiag`;
3. perform one VESA diagnostic boot;
4. collect D97CO route/site/cave markers and Apple's validated/tainted/nx results;
5. functional D97BV page writes remain unauthorized until runtime timing proof passes.

No Root Patch, accelerated boot or functional shared-cache mutation is authorized.