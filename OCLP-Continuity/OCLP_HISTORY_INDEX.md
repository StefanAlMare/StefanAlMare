# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BY_REAL_EXPORT_EXACT_TEXT_DLOPEN_SG_READ_ONLY_NEGATIVE_D97BZ_NEXT.md`.
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
Sparse reconstruction from exact Tahoe shared cache retained native bytes and Metal4 surface. Structural parsers passed and D97BV diff was exactly 23 bytes with zero outside site+cave.
This is an analysis container only.

## D97BX — preflight/sign PASS, real sparse dlopen NEGATIVE
Unsigned/signed preflight and ad-hoc signing passed for original and D97BV sparse mirrors. Real `dlopen` failed identically on both due shared-cache segment mapping geometry. D97BV was not the regression; signing was not the blocker.

## D97BY — real DSC single-image export, first standalone dyld gate identified
Bundle:
`OCLP7_D97BY_REAL_DSC_SINGLE_IMAGE_EXPORT_20260906_012127.zip`
- bytes `748714`;
- SHA256 `c2517f1a3758fcbdabe0ab033a7bc7f07385aadf6f13f9369bb1cecb10fd2b53`;
- TXT SHA256 `33835943e2bf117c945b064aa626dd4339db5a7d44ae9e18cf838c38df7c84c4`;
- JSON SHA256 `3fcd4a1413b330249da185ce1ad073423e91f2b7e3cc2e77603893e9dbdb84e2`.

Pinned transient extractor:
- `blacktop/ipsw v3.1.713`;
- checksum manifest SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`;
- macOS x86_64 asset SHA256 `7f5719d0a2a53996fca4dba4826aa015a6ddecfbba822a21e92400a80da7f1ab`;
- extracted `ipsw` executable SHA256 `d02498ccd0a88e0afc461cbfd5f4a9df34a6194386595226b10a9a46fe078d6a`.

RAW and `--slide` extraction both RC 0, each producing a 5,722,944-byte compact Mach-O. Both preserve exact native Tahoe `__text` (`EXACT_NATIVE=True`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`) and the exact native Metal4 count surface.

Both compact exports retain shared-cache VM addresses but page-pack file offsets. Unsigned preflight PASS, ad-hoc signing/strict verification PASS, signed preflight PASS.

Real child `dlopen` fails identically for RAW/SLIDE, before/after signing, with exact first validation error:
`__DATA_CONST segment missing SG_READ_ONLY flag`.

Thus:
- real export itself succeeds and preserves native code;
- `--slide` does not improve loadability;
- signing is not the first blocker;
- D97BV was not applied because no original baseline was yet loadable.

Public `go-macho` Export implementation remaps segment file offsets/filesizes and section offsets while preserving segment VM addresses; the audited load-command optimization path does not add the modern `SG_READ_ONLY` requirement to `__DATA_CONST`.

## CURRENT ACTION — D97BZ
Remain unpatched in Tahoe VESA.

Reproduce only RAW extraction with the same pinned extractor. Record all segment flags, then create exactly one metadata-only temp variant by OR-ing `SG_READ_ONLY (0x10)` into `__DATA_CONST` segment flags. Prove pre-sign diff is confined to that flags field, test unsigned and ad-hoc-signed preflight + real child dlopen, and stop at the next exact dyld condition if it still fails. Do not move VM/section addresses automatically.

Only if this metadata-only fix yields a real-dlopen loadable original baseline may D97BV be re-audited/applied in the same exported layout.

No Root Patch and no accelerated reboot are authorized.
