# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BX_PREFLIGHT_SIGN_PASS_DLOPEN_MMAP_ALIGNMENT_NEGATIVE_REAL_DSC_EXTRACTOR_NEXT.md`
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
6. retrospective/history when strategic context is needed.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Golden authority
Pinned Golden OCLP: upstream `dortania/OpenCore-Legacy-Patcher`, exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`, PatcherSupportPkg `1.9.6`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.
Golden primary request builder: `0x7FF80D370756..0x7FF80D370C28`, `[arg1+0x20] -> llvmVersion`, `[arg2+0x08] -> requestType`, `[arg2+0x18] -> timeout`, alternate requestType `9`.
Golden runtime naturally uses both 3802 and 32023 lanes and reaches compositor success.

## Durable architecture / prohibitions
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; P6/P7 insufficient; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Current required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Retained prohibitions:
- never install legacy `13.2.1-24/Versions/A/Metal` over cache-resident Tahoe Metal;
- do not globally rewrite `32023 -> 31001`;
- do not transplant Golden `+0x20` layout into Tahoe's two native layouts;
- do not globally force `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- do not repeat historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Legacy `12.5-3802-23` may be bounded to `MTLCompilerService.xpc` only. Exact target Metallib authority remains local `MetallibSupportPkg-26.6.2-25G82`, package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact Tahoe map 182 entries.

## D97BJ/BK whole-Metal closure
D97BJ Root Patch execution itself passed. Accelerated boots were not kernel panics: userspace and WindowServer were reached, then full legacy Metal.framework removed Tahoe `_MTL4*` superclass surface and launchd performed orderly shutdown.

Permanent NEGATIVE:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## Native Tahoe producer closure
Native Tahoe Metal starts at `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`. Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`. Native `_MTL4*` / `IOGPUMetal4*` surface is present.

Tahoe Builder A `0x7FF80F635510..0x7FF80F635A4D`: llvmVersion `[arg1+0x1C]`, requestType helper `+0xAC`, timeout `+0xB8`.
Tahoe Builder B `0x7FF80F663CA9..0x7FF80F66492C`: llvmVersion `[arg1+0x38]`, same helper family via subordinate object.
Both alternate requestType paths use immediate `9`.

Native generation census: 3802 present, 31001 absent, 32023 present.
Retained D97AA runtime fact: failing accelerated cohort delivered 12/12 requests as exact `llvmVersion=32023`, 3802=0, other=0.

## Shared accessor / suppression closure
Shared generation accessor: `0x7FF80F5E16C3..0x7FF80F5E1778`.
Generation selector: `0x7FF80F5EFFEB..0x7FF80F5F009C`, generation input ABI arg2/RSI. All six validated selector callers use `call accessor -> movl %eax,%esi -> call selector`.

D97BT proved default-environment accessor-wide suppression of 3802:
- primary path floors to 32023;
- lazy fallbacks floor to 32023 or 32024;
- sole bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`, current/default value zero.

Classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BV selective adapter — static-semantic FULL PASS
Exact accessor patch window:
- `0x7FF80F5E1719..0x7FF80F5E1726`;
- preimage `3d187d0000b9177d00000f4cc1`;
- no incoming branch into the window interior.

Safe executable inter-section cave:
- `0x7FF80F47E560..0x7FF80F47E630`;
- 208 zero bytes;
- outside Mach-O sections/header/load commands;
- zero function-start, direct branch-target and decoded RIP-target hits.

Exact adapter bytes:
- site `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`.

Semantics: exact input 3802 is preserved; every non-3802 input executes Tahoe's original floor unchanged.
Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 sparse reconstruction — structural PASS only
Bundle `OCLP7_D97BW_V2_NATIVE_METAL_SPARSE_MIRROR_20260906_003847.zip`, SHA256 `180cc1e9a28c6c6a763c695305e47a05798c1d2e46c65b650c4ebbe6e4a21707`.

Sparse mirror preserves shared-cache fileoffs and clones header/load commands at offset zero. Structural parsers pass; native `__TEXT` identity and Metal4 surface are preserved. D97BV diff is exactly 23 changed bytes and 0 outside site+cave.

Classifications:
- `D97BW_V2_SPARSE_STANDALONE_STRUCTURAL=PASS`;
- `D97BW_V2_PATCHED_SPARSE_STRUCTURAL=PASS`;
- `D97BW_V2_D97BV_DIFF_BOUNDED_TO_SITE_AND_CAVE=STATIC_PROVEN`.

This mirror is an analysis container, not yet a deployable dylib.

## D97BX — loadability/trust closure
Returned bundle:
`OCLP7_D97BX_DYLD_LOADABILITY_AND_ADHOC_SIGN_20260906_010046.zip`
- bytes `746802`;
- SHA256 `f25f364bb8bb9fb89f3f289cd217620ccc32ff81631ff354669301fcdf74ca57`;
- TXT SHA256 `3dfdc48a6051475cfa4ffeac3c2e300ffe93cd786851f84a752c692ad0d71ff3`;
- JSON SHA256 `6f7e0146059cd3fdd26149ec54ec7e27f96510b17d9ea9467607ba9c55a95452`.

Unsigned `dlopen_preflight`:
- original PASS;
- D97BV-patched PASS.

Temporary ad-hoc signing:
- original PASS;
- patched PASS;
- strict verification PASS (`valid on disk`, `satisfies its Designated Requirement`).

Signed `dlopen_preflight`:
- original PASS;
- patched PASS.

Real child-process `dlopen`:
- original NEGATIVE;
- patched NEGATIVE;
- before and after signing, both fail identically in shared-cache `__DATA_CONST` mapping with `mmap(...CD0, size=0x6F820) -> errno=22`.

Interpretation:
- signing/trust is not the current blocker;
- D97BV patch is not the loadability regression;
- shared-cache segment geometry is unsuitable as a true standalone dylib even though `file`/`otool`/preflight accept it;
- `__DATA_CONST` starts at a shared-cache VM geometry ending in `0xCD0`, which standalone dyld cannot mmap as a normal page-aligned segment.

Authoritative classifications:
- `D97BX_UNSIGNED_PREFLIGHT_ORIGINAL_PATCHED=PASS`;
- `D97BX_ADHOC_SIGN_ORIGINAL_PATCHED=PASS`;
- `D97BX_SIGNED_PREFLIGHT_ORIGINAL_PATCHED=PASS`;
- `D97BX_REAL_DLOPEN_ORIGINAL_PATCHED=NEGATIVE_IDENTICAL_MMAP_EINVAL`;
- `D97BX_D97BV_PATCH_LOADABILITY_REGRESSION=NEGATIVE`;
- `D97BX_CODE_SIGNING_IS_CURRENT_BLOCKER=NEGATIVE`;
- `D97BX_SPARSE_MIRROR_IS_NOT_STANDALONE_LOADABLE=NEGATIVE`.

Do not manually edit one segment alignment in isolation. A real dyld shared-cache extractor must coherently reconstruct standalone Mach-O segment/file/linkedit/fixup geometry.

## CURRENT ACTION — real DSC single-image extraction
Remain unpatched in Tahoe VESA.

Next static/transient lane:
1. use a pinned, verified prebuilt real DSC extractor; no installation and no local compilation;
2. preferred current candidate is `blacktop/ipsw` because `ipsw dyld extract <DSC> <DYLIB>` exports one image rather than the entire cache;
3. exact source DSC: `/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`;
4. exact target image: `/System/Library/Frameworks/Metal.framework/Versions/A/Metal`;
5. extract only under `/private/tmp`;
6. test the unmodified extracted original with `file`, `otool`, segment alignment, Metal4 surface, `dlopen_preflight`, then real child `dlopen` BEFORE applying D97BV;
7. only if extracted original truly loads, re-audit the 13-byte site and safe cave in the exported layout, then patch a second temp copy and test it;
8. delete extractor archive/binary and every Apple binary before return; package TXT+JSON only.

Public-source pin currently audited: `blacktop/ipsw` release `v3.1.713` published 2026-08-30; release checksum manifest asset SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`.

No Root Patch, no installation of extracted Metal, and no accelerated reboot are authorized.
GitHub Actions compile/build/package remains suspended until explicit quota-unblocked confirmation.