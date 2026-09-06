# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CM_LILU_TEXT_PASS_STANDARD_BINARYMODINFO_BLOCKED_CS_VALIDATE_PAGE_D97CN_READY.md`
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
Production evaluation now preserves Apple Tahoe Metal/Metal4 in its original dyld shared cache and uses a separate OCLP-specific Lilu plugin/kext. Lilu itself is not modified. WhateverGreen is not modified.

Provisional mechanism layer name: `OCLPMetalCompat.kext`.
OCLP remains the policy/orchestration layer that decides OS/build/hardware eligibility.

## D97CL PASS
D97CL returned full preflight PASS:
- Haswell AVX2 -> Lilu selects `x86_64h`;
- Lilu `1.7.3` loaded;
- WhateverGreen `1.7.1` loaded;
- `-liluuseroff` absent;
- `-liluslow` absent;
- Tahoe x86_64h cache and `.map` readable;
- exact Metal map entry present.

## D97CM closure
Returned ZIP SHA256 `bc587bcb48eb6c4350b444c9c41566cfbb86c092c63c66f498c31924b91b41dd`.

Exact x86_64h map Metal block:
- `__TEXT 0x7FF80F47D000 -> 0x7FF80F76815A`;
- `__DATA_CONST 0x7FF84119DCD0 -> 0x7FF84120D4F0`;
- `__DATA 0x7FF843D590C0 -> 0x7FF843D65DC0`.

Current Lilu `mapAddresses()` emulation:
- Metal record unique;
- `__TEXT start/end` parity PASS;
- D97BV site/cave arithmetic exact PASS;
- current DATA parsing is not reliable for this Tahoe map format, but D97BV is TEXT-only.

Critical blocker:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal` is absent as a standalone canonical file. Therefore standard Lilu `BinaryModInfo` cannot complete `loadFilesForPatching()` even though the shared-cache map parser can resolve Metal correctly.

Authoritative D97CM classifications:
- `D97CM_LILU_MAP_PARSER_TEXT_SUBSTRATE=PASS`;
- `D97CM_D97BV_TEXT_ADDRESS_ARITHMETIC=PASS`;
- `D97CM_STANDARD_LILU_TARGET_FILE_PRELOOKUP=BLOCKED_CANONICAL_METAL_NOT_READABLE_REGULAR_FILE`;
- `D97CM_PLAIN_STANDARD_BINARYMODINFO_FOR_TAHOE_METAL=NEGATIVE`;
- `D97CM_LILU_GENERAL_SUBSTRATE=POSITIVE`.

## Preferred delivery mechanism after D97CM
Current upstream FeatureUnlock provides the relevant architecture precedent: on Big Sur+ it hooks `_cs_validate_page`, confirms the vnode is a dyld shared cache via `UserPatcher::matchSharedCachePath(path)`, then patches bytes directly in the validated cache page.

This avoids the missing canonical Metal file and avoids standalone reconstruction.

Preferred D97BV delivery candidate:
`OpenCore -> Lilu + OCLPMetalCompat -> _cs_validate_page hook -> exact DSC vnode/page -> exact preimage verification -> D97BV site/cave bytes -> normal cache mapping/execution`.

No runtime build is authorized yet.

## CURRENT ACTION — D97CN
Remain unpatched Tahoe VESA.
Run only `OCLP7_D97CN_DSC_CODEVALIDATION_PAGE_TOPOLOGY_PREFLIGHT.sh`.

D97CN must map the D97BV site and cave preferred VM addresses to the exact split-cache vnode/file offsets and 4K `cs_validate_page` offsets, then verify:
1. unique target mappings;
2. exact site preimage;
3. full 208-byte native cave is still zero in the original cache representation;
4. site and cave patch windows each fit one 4K page;
5. final `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

If D97CN passes, next step is static source construction of the minimal separate `OCLPMetalCompat.kext` prototype using a FeatureUnlock-style code-validation-page hook. Still no Root Patch, install, accelerated reboot or automatic runtime mutation.