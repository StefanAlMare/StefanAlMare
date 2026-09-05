# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BW_TOOLING_GUARD_SPARSE_MIRROR_V2_READY.md`.
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
Bundle `OCLP7_D97BV_TEXT_INTERSECTION_PADDING_CAVE_PREFLIGHT_20260906_001956.zip`, SHA256 `c39198d603664b921f57abd0d09d24ad7fc1d08c2da8f44677c86de93301cbfd`.

D97BV found one safe unsectioned padding cave inside executable native `__TEXT`:
- `0x7FF80F47E560..0x7FF80F47E630`;
- 208 zero bytes;
- outside all Mach-O sections;
- zero function-start, branch-target and RIP-target hits.

Exact selective adapter:
- site `3dda0e00007406e93bcee9ff90`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`.

Semantics: preserve exact 3802; every other input executes original Tahoe floor. Truth table showed no non-3802 semantic drift.

Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW — compact reconstruction tooling guard
D97BW revalidated exact native service and Metal identities and recovered declared Mach-O segments:
- `__TEXT`: fileoff `0xF47D000`, size `0x2EB15A`;
- `__DATA_CONST`: fileoff `0x27D91CD0`, size `0x6F820`;
- `__DATA_DIRTY`: fileoff `0x2A443510`, size `0x4938`;
- `__DATA`: fileoff `0x2A94D0C0`, size `0xCD00`;
- `__LINKEDIT`: fileoff `0x2AEFC000`, size `0x99F0000`.

It then stopped before copying with `FAIL=RECONSTRUCT_SIZE_UNSAFE:881770496`. Highest declared file end is `0x348EC000`, 881,770,496 bytes, while actual segment payload is about 157 MiB.

Classification:
`D97BW_RESULT=PARTIAL_PASS_READONLY_TOOLING_COMPACT_BUFFER_SIZE_GUARD`.

This is not a reconstruction negative. It only rejects allocating one dense ~841 MiB bytearray in the collector.

## CURRENT ACTION — D97BW v2 sparse mirror
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BW_v2_native_metal_sparse_mirror.sh`:
- bytes `21700`;
- SHA256 `273ad9b6fcc9c7cdcc1175627e70eaabaa026c4c1ccd8ad79cf33e4e4b561ceb`.

V2 creates temporary sparse standalone mirrors in `/private/tmp`, clones the Mach-O header/load commands at offset zero, writes every segment at its unchanged original fileoff, performs no load-command rebasing, validates `file`/`otool`/load-command bounds/native Metal4, applies D97BV only to the second temp mirror, proves bounded diffs, deletes both Apple binaries, and packages TXT+JSON only.

No Root Patch and no accelerated reboot are authorized.
