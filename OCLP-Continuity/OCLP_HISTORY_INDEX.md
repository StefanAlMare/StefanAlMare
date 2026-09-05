# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BU_PARTIAL_PASS_NO___TEXT_CAVE_D97BV_INTERSECTION_PADDING_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline remains `P1 + P2b + P3 + AIR00 + D34`.
Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## Golden producer / selector closure
Golden primary Metal request builder uses `[arg1+0x20] -> llvmVersion`; Golden original service maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches Metal compositor success.

## D97AA — failing Tahoe generation cohort
Accelerated Tahoe cohort: 12/12 observed MTLCompilerService requests carried exact `llvmVersion=32023`; 3802=0; other=0.

## D97BJ / BK — whole legacy Metal rejected
Exact Tahoe root patch execution passed, but full legacy `13.2.1-24/Metal.framework` removed Tahoe Metal4 superclass ABI. Accelerated boots reached WindowServer, then critical userspace services failed and launchd shut down. Permanent NEGATIVE: full legacy main Metal on Tahoe.

## D97BL — native-Metal selective hybrid
Current architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Legacy service bundle can be bounded; legacy main Metal must never shadow cache-resident Tahoe Metal. Historical native-Metal + legacy-XPC/private-compilers + true-five already failed and must not be repeated unchanged.

## D97BM / BN — native producer mapping
Native Tahoe Metal start `0x7FF80F47D000`, `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Builder A: llvmVersion `[arg1+0x1C]`; Builder B: llvmVersion `[arg1+0x38]`.
Generation census: 3802 present, 31001 absent, 32023 present. Do not copy Golden offsets or globally rewrite 32023->31001.

## D97BO — native generation singleton architecture
3802 singleton global `0x7FF843D65C90`; 32023 singleton global `0x7FF843D65CB0`; selector `0x7FF80F5EFFEB..0x7FF80F5F009C` distinguishes 3802/3902/32023/32024.

Generation-aware constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88` builds `+0x1C/+0x20/+0x38` layouts and contains 32023 generation logic.

## D97BP / BQ — shared generation accessor
Shared accessor `0x7FF80F5E16C3..0x7FF80F5E1778` is used both by constructor discriminator and all six validated generation-selector call sites.
D97BQ proved selector generation argument is ABI arg2/RSI; each caller uses `call accessor -> movl %eax,%esi -> call selector`.

## D97BR / BT — accessor-wide default suppression closure
Primary accessor floor is `cmp 32024; floor to 32023`; a 3802 input becomes 32023.
Lazy fallback floors to at least 32023 or 32024, so 3802 also cannot survive there.
The only bypass is explicit key `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`; current/default fallback/global value is zero.

Strongest retained classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BU — minimal selective adapter preflight PARTIAL PASS
User ran `OCLP7_D97BU_minimal_3802_preserve_adapter_preflight.sh`.

Exact accessor patch site is statically valid:
- `0x7FF80F5E1719..0x7FF80F5E1726`;
- 13-byte preimage `3d187d0000b9177d00000f4cc1`;
- complete compare/mov/cmov instructions;
- no incoming branch targets the middle of the window.

However strict safe-padding search inside native Metal `__text` found zero candidates and fail-closed:
`CAVE_CANDIDATE_COUNT=0`, `FAIL=NO_STATIC_SAFE_PADDING_CAVE`.

Classification:
`D97BU_NATIVE_METAL___TEXT_SAFE_PADDING_CAVE_GE_32=NEGATIVE`.

No mutation occurred. This rejects only the `__text`-padding trampoline placement, not the selective-adapter semantics.

Apple xcrun cache extraction tools were absent on ASUS2 (`dyld_shared_cache_util` / `dsc_extractor`, RC 72). Other audited extraction/reconstruction methods remain open.

Do not respond by using a live function as a cave, globally forcing 3802, globally mapping 32023->31001, transplanting Golden offsets or lowering the Tahoe clamp threshold without a finite-domain proof.

## CURRENT ACTION — D97BV
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BV_text_intersection_padding_cave_preflight.sh`.

D97BV searches unsectioned padding inside executable native `__TEXT` and rejects any region touched by header/load commands, a Mach-O section, function starts, direct branch targets or decoded RIP-relative targets. If a safe ≥18-byte padding region exists, it assembles the exact `3802 only -> preserve; otherwise original floor` trampoline and proves no semantic drift. If none exists, it returns a clean negative result for this placement strategy.

No Root Patch and no accelerated reboot are authorized.