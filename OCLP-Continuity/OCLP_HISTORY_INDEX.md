# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BV_FULL_PASS_EXECUTABLE_INTERSECTION_CAVE_SELECTIVE_3802_ADAPTER_D97BW_RECONSTRUCTION_NEXT.md`.
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
Primary accessor floor converts 3802 to 32023. Lazy fallback floors to 32023 or 32024. The only bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`; current/default value is zero.

Strongest retained classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BU — exact patch window valid; cave inside `__text` NEGATIVE
Exact accessor patch window `0x7FF80F5E1719..0x7FF80F5E1726`, 13-byte preimage `3d187d0000b9177d00000f4cc1`, no incoming branch into window interior. Strict homogeneous safe-padding search inside `__text` found zero candidates. This rejected only `__text`-padding trampoline placement.

## D97BV — executable inter-section cave + selective adapter FULL PASS
Bundle:
`OCLP7_D97BV_TEXT_INTERSECTION_PADDING_CAVE_PREFLIGHT_20260906_001956.zip`
- bytes `2574`;
- SHA256 `c39198d603664b921f57abd0d09d24ad7fc1d08c2da8f44677c86de93301cbfd`.

All final markers passed; no mutation/extraction/Root Patch/reboot.

D97BV found exactly one safe unsectioned padding cave inside executable native `__TEXT`:
- `0x7FF80F47E560..0x7FF80F47E630`;
- 208 zero bytes;
- before `__text`;
- outside every section and load-command region;
- zero function-start, direct branch-target and decoded RIP-relative-target hits.

Classification:
`D97BV_NATIVE_METAL_EXECUTABLE_INTERSECTION_PADDING_CAVE=STATIC_PROVEN_SAFE_BY_CURRENT_GATES`.

Exact selective adapter:
- site bytes `3dda0e00007406e93bcee9ff90`;
- cave bytes `3d187d0000b9177d00000f4cc1e9b4311600`.

Semantics: preserve exactly 3802; every other input executes exact original Tahoe floor. Truth table showed no non-3802 semantic drift.

Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

This is the first fully positive bounded upstream adapter preflight. It is not P1, not a global force-3802, not 32023->31001 and not Golden-layout transplantation.

## Current frontier — native Metal standalone delivery
Adapter logic and executable placement are statically closed. The next question is whether exact native Tahoe Metal can be reconstructed locally from the current dyld shared cache into a structurally valid temporary standalone Mach-O without redistributing Apple binaries.

Apple xcrun `dyld_shared_cache_util` / `dsc_extractor` are absent. A custom segment-reconstruction audit is therefore the next read-only action.

## CURRENT ACTION — D97BW
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BW_native_metal_temp_reconstruction.sh`:
- bytes `18302`;
- SHA256 `20e2d042447eba578b857faeb221fd615751da37514afafd56921ecd581f09c1`.

D97BW reconstructs only temporary local copies under `/private/tmp`, validates native Mach-O/load-command/Metal4 structure, applies the exact D97BV adapter to a second temporary copy, proves bounded diffs, then deletes both Apple binaries before packaging TXT+JSON only.

No Root Patch and no accelerated reboot are authorized.