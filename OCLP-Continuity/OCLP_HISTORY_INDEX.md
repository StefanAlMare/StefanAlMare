# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BX_PREFLIGHT_SIGN_PASS_DLOPEN_MMAP_ALIGNMENT_NEGATIVE_REAL_DSC_EXTRACTOR_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline remains `P1 + P2b + P3 + AIR00 + D34`.
Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

Current target:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden producer / selector closure
Golden primary Metal request builder uses `[arg1+0x20] -> llvmVersion`; Golden original service maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches compositor success.

## D97AA — failing Tahoe generation cohort
Accelerated Tahoe cohort: 12/12 observed MTLCompilerService requests carried exact `llvmVersion=32023`; 3802=0; other=0.

## D97BJ / BK — whole legacy Metal rejected
Exact Tahoe root patch execution passed, but full legacy `13.2.1-24/Metal.framework` removed Tahoe Metal4 superclass ABI. Accelerated boots reached WindowServer, then critical userspace services failed and launchd shut down. Permanent NEGATIVE: full legacy main Metal on Tahoe.

## D97BL — native-Metal selective hybrid
Legacy service bundle can be bounded to `MTLCompilerService.xpc`; legacy main Metal must never shadow cache-resident Tahoe Metal. Historical native-Metal + legacy-XPC/private-compilers + true-five already failed and must not be repeated unchanged.

## D97BM / BN — native producer mapping
Native Tahoe Metal start `0x7FF80F47D000`, `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Builder A: llvmVersion `[arg1+0x1C]`; Builder B: llvmVersion `[arg1+0x38]`.
Generation census: 3802 present, 31001 absent, 32023 present. Do not copy Golden offsets or globally rewrite 32023->31001.

## D97BO / BP / BQ — shared generation architecture
3802 and 32023 native singleton lanes exist. Shared accessor `0x7FF80F5E16C3..0x7FF80F5E1778` is used by the generation-aware constructor and all six validated generation-selector call sites. Selector generation argument is ABI arg2/RSI.

## D97BR / BS / BT — accessor-wide default 3802 suppression
Primary accessor floor converts 3802 to 32023. Lazy fallbacks floor to 32023 or 32024. Sole bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`; current/default value zero.

Classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BU / BV — selective 3802-preserve adapter
Exact patch window `0x7FF80F5E1719..0x7FF80F5E1726`, original 13 bytes `3d187d0000b9177d00000f4cc1`.
D97BV found safe unsectioned executable padding cave `0x7FF80F47E560..0x7FF80F47E630`, 208 zero bytes, outside sections/header/load commands with zero function-start/branch-target/RIP-target hits.

Exact adapter:
- site `3dda0e00007406e93bcee9ff90`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`.

Semantics: preserve exact 3802, otherwise execute original Tahoe floor unchanged.
Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 — sparse structural reconstruction PASS
Sparse reconstruction from exact Tahoe shared cache retained native bytes and Metal4 surface. `file`, `otool -l`, `otool -L` passed. D97BV patch diff was exactly 23 bytes with zero outside site+cave.

Classifications:
- `D97BW_V2_SPARSE_STANDALONE_STRUCTURAL=PASS`;
- `D97BW_V2_PATCHED_SPARSE_STRUCTURAL=PASS`;
- `D97BW_V2_D97BV_DIFF_BOUNDED_TO_SITE_AND_CAVE=STATIC_PROVEN`.

## D97BX — preflight/sign PASS, real dlopen alignment NEGATIVE
Bundle `OCLP7_D97BX_DYLD_LOADABILITY_AND_ADHOC_SIGN_20260906_010046.zip`:
- bytes `746802`;
- SHA256 `f25f364bb8bb9fb89f3f289cd217620ccc32ff81631ff354669301fcdf74ca57`;
- TXT SHA256 `3dfdc48a6051475cfa4ffeac3c2e300ffe93cd786851f84a752c692ad0d71ff3`;
- JSON SHA256 `6f7e0146059cd3fdd26149ec54ec7e27f96510b17d9ea9467607ba9c55a95452`.

Unsigned `dlopen_preflight` passed on both original and D97BV-patched sparse mirrors.
Temporary ad-hoc signing and strict codesign verification passed on both.
Signed `dlopen_preflight` again passed on both.

Real child `dlopen` nevertheless failed identically for original and patched, before and after signing, at shared-cache `__DATA_CONST` mmap with `errno=22`; the mapped VM geometry ends in `0xCD0` and is not normal standalone page-aligned segment geometry.

Thus:
- signing/trust is not the blocker;
- D97BV is not the regression;
- parser/preflight acceptance is weaker than actual standalone loadability;
- sparse mirroring of shared-cache geometry is not a deployable extraction method.

Classifications:
`D97BX_REAL_DLOPEN_ORIGINAL_PATCHED=NEGATIVE_IDENTICAL_MMAP_EINVAL`.
`D97BX_D97BV_PATCH_LOADABILITY_REGRESSION=NEGATIVE`.
`D97BX_CODE_SIGNING_IS_CURRENT_BLOCKER=NEGATIVE`.
`D97BX_SPARSE_MIRROR_IS_NOT_STANDALONE_LOADABLE=NEGATIVE`.

## CURRENT ACTION — real DSC single-image extraction
Remain unpatched in Tahoe VESA.

Use a pinned, verified prebuilt real DSC extractor transiently in `/private/tmp`; do not install or compile locally. Preferred current candidate is `blacktop/ipsw`, whose `ipsw dyld extract <DSC> <DYLIB>` path can export one image rather than the entire cache.

Exact source DSC:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`.
Exact target image:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`.

First prove the unpatched real extraction is truly standalone-loadable; only then re-audit D97BV site/cave in that exported layout and patch a second temp copy.

No Root Patch and no accelerated reboot are authorized.