# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BV_FULL_PASS_D97BW_V2_SPARSE_STANDALONE_STRUCTURAL_PASS_D97BX_LOADABILITY_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline remains `P1 + P2b + P3 + AIR00 + D34`.
Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden producer / selector closure
Golden primary Metal request builder uses `[arg1+0x20] -> llvmVersion`; Golden original service maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches Metal compositor success.

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
Exact accessor patch window `0x7FF80F5E1719..0x7FF80F5E1726`, 13-byte preimage `3d187d0000b9177d00000f4cc1`, no incoming branch into window interior. Strict safe-padding search inside `__text` found zero candidates. This rejected only `__text`-padding trampoline placement.

## D97BV — executable inter-section cave + selective adapter FULL PASS
Bundle `OCLP7_D97BV_TEXT_INTERSECTION_PADDING_CAVE_PREFLIGHT_20260906_001956.zip`:
- bytes `2574`;
- SHA256 `c39198d603664b921f57abd0d09d24ad7fc1d08c2da8f44677c86de93301cbfd`.

D97BV found safe unsectioned padding cave inside executable native `__TEXT`:
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

## D97BW v1 — compact reconstruction guard
First reconstruction attempt stopped before copying because shared-cache-native fileoffs imply apparent size `881770496` bytes. This was an artificial dense-buffer guard, not a reconstruction negative.

## D97BW-v2 — sparse standalone native Metal structural FULL PASS
Bundle `OCLP7_D97BW_V2_NATIVE_METAL_SPARSE_MIRROR_20260906_003847.zip`:
- bytes `4811`;
- SHA256 `180cc1e9a28c6c6a763c695305e47a05798c1d2e46c65b650c4ebbe6e4a21707`;
- inner TXT SHA256 `c4ccea417e412f0f1c07a9d62cf15e8ab58bf5c29dd690469be6f4b22bb54085`;
- inner JSON SHA256 `d07953a0f8bac305673f5c64c71fc11ec077f6946be4470de62035aa8c718242`.

The collector built temporary sparse original and D97BV-patched Metal mirrors under `/private/tmp`, retained original segment fileoffs, cloned Mach header/load commands at file offset zero only for standalone parser discovery, and performed no load-command rebasing.

Geometry:
- apparent size 881770496 bytes / 840.921875 MiB;
- allocated space 176193536 bytes / 168.03125 MiB;
- actual segment payload written 165003186 bytes.

Original standalone `__TEXT` exactly matched native cache SHA. All audited load-command data ranges were in bounds.

`file`, `otool -l` and `otool -L` returned RC 0 for both original and patched mirrors.

Metal4 class-name counts remained identical before/after patch:
- command queue 82;
- command buffer 103;
- command allocator 49;
- render encoder 79;
- compute encoder 97;
- machine-learning encoder 38.

D97BV patch diff:
- original site `3d187d0000b9177d00000f4cc1` -> patched site `3dda0e00007406e93bcee9ff90`;
- 18-byte zero cave -> exact adapter cave `3d187d0000b9177d00000f4cc1e9b4311600`;
- total differing bytes 23;
- bytes differing outside allowed site+cave 0.

Classifications:
`D97BW_V2_SPARSE_STANDALONE_STRUCTURAL=PASS`.
`D97BW_V2_PATCHED_SPARSE_STRUCTURAL=PASS`.
`D97BW_V2_D97BV_DIFF_BOUNDED_TO_SITE_AND_CAVE=STATIC_PROVEN`.

Both temp mirrors were unsigned (`codesign` RC 1 / `not signed at all`) and were deleted before return. Report ZIP contains no Apple binary.

## CURRENT ACTION — D97BX
Remain unpatched in Tahoe VESA.
Next read-only/transient collector must rebuild the same sparse mirrors only in `/private/tmp`, test `dlopen_preflight` and sacrificial-child `dlopen`, separately test a temporary ad-hoc-signed patched copy if safe, record sparse allocation/signing effects, clean every Apple binary, and return TXT+JSON only.

No Root Patch and no accelerated reboot are authorized.
