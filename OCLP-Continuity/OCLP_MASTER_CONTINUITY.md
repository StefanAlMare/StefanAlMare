# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CN_PAGE_TOPOLOGY_PASS_D97CO_OBSERVE_ONLY_SOURCE_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
Before any technical modification:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
No local compilation unless explicitly authorized.

## Durable architecture
Pinned Golden OCLP: `dortania/OpenCore-Legacy-Patcher` commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.
Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Final target remains one native Tahoe Metal image with two logical compiler-generation lanes. Preserve true 3802 selectively; otherwise preserve Tahoe 32023/32024 behavior.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` production repair;
- no repeat of native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot;
- no pointer-by-pointer standalone ObjC rehydration as production mainline;
- do not create a fake canonical Metal file merely to satisfy Lilu BinaryModInfo prelookup.

Exact target Metallib package remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Native producer / D97BV retained facts
Native Tahoe Metal `__TEXT` base `0x7FF80F47D000`; native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`.
D97BT proved default-environment 3802 suppression to 32023/32024.

D97BV selective adapter static-semantic proof remains authoritative:
- exact input 3802 bypasses the Tahoe floor;
- every non-3802 input executes original Tahoe behavior.

D97BV exact locations:
- site `0x7FF80F5E1719 = __TEXT + 0x164719`;
- cave `0x7FF80F47E560 = __TEXT + 0x1560`.

Bytes:
- site original `3d187d0000b9177d00000f4cc1`;
- site replacement `3dda0e00007406e93bcee9ff90`;
- cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## Standalone Metal path CLOSED
D97CI/D97CJ proved broad cache-origin Objective-C relocation state remains in extracted standalone Metal. D97CJ ties the current readClass fault exactly to an unrebased classlist pointer and shows broad preferred/cache pointer topology.

Authoritative closure:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Preserve standalone reconstruction only as evidence/reserve.

## Native shared-cache plugin direction
Production evaluation preserves Apple Tahoe Metal/Metal4 in its original dyld shared cache and uses a separate OCLP-specific Lilu plugin/kext. Lilu itself is not modified. WhateverGreen is not modified.

Provisional mechanism layer name: `OCLPMetalCompat.kext`.
OCLP remains the policy/orchestration layer that decides OS/build/hardware eligibility.

## D97CL — Lilu / DSC substrate PASS
ASUS2 has Haswell AVX2, loaded Lilu `1.7.3`, loaded WhateverGreen `1.7.1`, no `-liluuseroff`, no `-liluslow`, and the expected Cryptex `dyld_shared_cache_x86_64h` plus `.map`. The exact native Metal path is present in that map.

Classifications:
- `D97CL_FAST_SHARED_CACHE_MAPPING_PRECONDITION=PASS`;
- `D97CL_EXPECTED_CACHE_BINARY_PRECONDITION=PASS`;
- `D97CL_USERPATCHER_BOOTARG_PRECONDITION=PASS`.

## D97CM — Lilu TEXT mapping PASS; standard BinaryModInfo blocked
Returned ZIP SHA256 `bc587bcb48eb6c4350b444c9c41566cfbb86c092c63c66f498c31924b91b41dd`.
TXT SHA256 `1d998ac1b793b2eb76f6ad1a6b298b42a4fc6c070ab8bfd681b6718a6e348675`.
Embedded report SHA256 `b42fbc898794b7d143fcbbc172b4d01ae8d09fdeebd9440f7f6948a56c486cc6`, independently verified.

D97CM proved current Lilu `mapAddresses()` obtains exact Metal `__TEXT 0x7FF80F47D000 -> 0x7FF80F76815A`, and exact D97BV site/cave arithmetic passes.

But `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` is absent as a readable regular standalone file, so standard `BinaryModInfo::loadFilesForPatching()` cannot prepare this Tahoe Metal target.

Authoritative classifications:
- `D97CM_LILU_MAP_PARSER_TEXT_SUBSTRATE=PASS`;
- `D97CM_D97BV_TEXT_ADDRESS_ARITHMETIC=PASS`;
- `D97CM_STANDARD_LILU_TARGET_FILE_PRELOOKUP=BLOCKED_CANONICAL_METAL_NOT_READABLE_REGULAR_FILE`;
- `D97CM_PLAIN_STANDARD_BINARYMODINFO_FOR_TAHOE_METAL=NEGATIVE`;
- `D97CM_LILU_GENERAL_SUBSTRATE=POSITIVE`.

Current upstream FeatureUnlock is the architectural precedent for the alternative: on Big Sur+ it routes `_cs_validate_page`, calls Apple validation first, identifies dyld shared-cache vnodes and then inspects/patches validated page bytes.

## D97CN — exact code-validation page topology PASS
Returned ZIP SHA256 `a468b57ed1bb0917790c803848e084f67aecabf2ad18ccc8893d7f325bef24ea`.
TXT SHA256 `fe0b48280d08a6b77dae03acd67a720770663e1cdb3c95c1fae2b1b46bed0b6e`.
Embedded report SHA256 `c17b8ac6598e86688b19c3a22ccdcbc28bd12204a0ae7cbc376195a5b791303e`, independently verified.

Both D97BV targets resolve uniquely to the **main** `dyld_shared_cache_x86_64h` vnode, UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`, mapping index 0 (`r-x`).

Site:
- VM `0x7FF80F5E1719`;
- file offset `0xF5E1719`;
- `cs_validate_page` page offset `0xF5E1000`;
- offset inside page `0x719`;
- page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- exact 13-byte preimage match PASS.

Cave:
- VM `0x7FF80F47E560`;
- file offset `0xF47E560`;
- `cs_validate_page` page offset `0xF47E000`;
- offset inside page `0x560`;
- page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- full 208-byte native cave is zero PASS;
- cave SHA256 `46f531b7ea0428fbf2c3ca2b60e8dc33d6bbfa000e0fd1b489c5e39140a47006`;
- 18-byte future functional window zero PASS.

Site and cave are in the same vnode but different 4K pages. Both future replacement windows fit wholly in one page.

Final classification:
`D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

The standalone-carrier code-signature cave conflict does not apply to this native shared-cache representation; D97CN directly proves the original 208-byte cache cave is intact.

## D97CO — observe-only prototype source
Experimental branch: `oclpmc-d97co-observe-only`.
Branch head: `8c4904870b8512fe356fcb48e82fb32a9e980634`.
Source path: `OCLPMetalCompat/OCLPMetalCompat/kern_start.cpp`, Git blob `532643ed9d041db2b1af8a865a6949396b77980d`.

D97CO is deliberately non-functional/observation-only:
- explicit activation `-ocmcdiag` required;
- Tahoe-only PluginConfiguration;
- exact `kern.osversion == 25G82` gate;
- Haswell CPU gate;
- original `_cs_validate_page` called first;
- only page offsets `0xF5E1000` and `0xF47E000` are observed;
- vnode path must resolve to main `/dyld_shared_cache_x86_64h`;
- exact site preimage and cave zero state are logged;
- Apple `validated/tainted/nx` results are logged.

Static audit:
- `data` stays const;
- no `const_cast`;
- no `findAndReplace`;
- no `vm_map_write_user`;
- no Root Patch/reboot path.

Classification:
`D97CO_OBSERVE_ONLY_LOGIC=STATIC_AUDITED_NO_PAGE_MUTATION`.

D97CO is not yet compile-proven or runtime-proven. No kext binary exists.

## CURRENT ACTION
Remain unpatched Tahoe VESA.

GitHub-side next phase, once build execution is available:
1. finish/pin build-project infrastructure against current Lilu/MacKernelSDK;
2. compile D97CO observe-only;
3. audit dependencies, Info.plist, binary identity and artifact SHA;
4. package only the diagnostic kext;
5. provide identity-pinned EFI deployment instructions for a VESA diagnostic boot using `-ocmcdiag`;
6. collect `D97CO_ROUTE_CS_VALIDATE_PAGE`, `D97CO_SITE_SEEN`, `D97CO_CAVE_SEEN` markers;
7. only if runtime timing/preimage proof passes may a separately authorized functional D97BV page-write build be designed.

GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation. Local compilation is not an implicit fallback. No Root Patch, accelerated boot or functional shared-cache mutation is authorized.