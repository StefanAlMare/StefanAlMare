# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CBV5_COLD_HARNESS_PASS_TEXT_MAP_DATA_CONST_MMAP_ALIGNMENT_FAIL_D97CC_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: `native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden / generation closure
Golden original selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches compositor success.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer: Builder A `[arg1+0x1C]`, Builder B `[arg1+0x38]`, native 3802 and 32023 lanes present, no 31001.
D97BP/BQ proved shared generation accessor and selector ABI arg2/RSI.
D97BT proved default-environment accessor-wide 3802 suppression; sole bypass explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`.

## Whole legacy Metal rejected
D97BJ/BK: full legacy `13.2.1-24/Metal.framework` shadows/removes Tahoe Metal4 superclass ABI. Accelerated boots reached WindowServer then failed in userspace. Permanent NEGATIVE.
D97BL: legacy `MTLCompilerService.xpc` may be bounded; legacy main Metal remains forbidden. Do not repeat unchanged native-Metal + legacy-XPC/private-compilers + true-five reboot.

## D97BV — selective 3802-preserve adapter
Patch window `0x7FF80F5E1719..0x7FF80F5E1726`; safe unsectioned cave `0x7FF80F47E560..0x7FF80F47E630`.
Site `3dda0e00007406e93bcee9ff90`; cave `3d187d0000b9177d00000f4cc1e9b4311600`.
Semantics: preserve exact 3802, otherwise execute original Tahoe floor. `STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 / D97BX — sparse analysis container closure
Sparse reconstruction preserved native code/Metal4 and D97BV diff, but real dlopen failed identically original/patched due shared-cache standalone mapping geometry. Signing and D97BV were not the blocker. Sparse mirror is analysis-only.

## D97BY — real DSC single-image export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` exports both succeed, preserve exact native Tahoe `__text` and Metal4 counts. Preflight/signing pass; real dlopen first rejects missing `SG_READ_ONLY` on `__DATA_CONST`.

## D97BZ — metadata SG_READ_ONLY gate passed
Only one effective pre-sign byte changed at `__DATA_CONST` flags (`0x00 -> 0x10`); previous dyld gate disappeared. New exact real dlopen rejection: `segment '__DATA_DIRTY' vm address out of order`.
Classification: `D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`.

## D97CA — segment-order dependency audit FULL PASS
D97CA proved current compact RAW file/load order `__TEXT,__DATA_CONST,__DATA,__DATA_DIRTY,__LINKEDIT` conflicts with VM order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`.
Dependency surface for coherent reorder:
- dyld segment-index rewrites: 0;
- relocation section-ordinal rewrites: 0;
- chained fixups absent;
- split-seg info absent;
- unknown order-sensitive loads: 0;
- file-backed section offsets: 5;
- symtab `n_sect` rewrites: 3652.
Classification: `D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## D97CB — atomic remap structural PASS
Target remap passed:
- `__DATA_CONST` has `SG_READ_ONLY`;
- `__DATA_DIRTY` payload fileoff `0x35C000`;
- `__DATA` payload fileoff `0x361000`;
- `__LINKEDIT` remains `0x36E000`;
- command order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all VM addresses preserved;
- 5 section fileoff rewrites;
- 3652 symtab `n_sect` remaps;
- pre-sign diff `40655`, zero outside audited domains;
- `file`, `otool -l`, `otool -L` PASS.
Unsigned/signed preflight PASS; Python child actual `dlopen` `RC=-11` SIGSEGV, but that process already has native Metal loaded.

## D97CB-v2/v3/v4 — harness corrections
D97CB-v2: macOS Python `copy2()->copystat()->chflags` failed on copied `/usr/bin/true`; tooling-only, fixed with `copyfile`.
D97CB-v3: copied/re-signed `/usr/bin/true` baseline exited 0. Raw substring matching falsely treated delayed closure entries as loaded. Dyld source proved `move loaded to delayed`/reverse transitions.
D97CB-v4: final-state parser implementation was correct but embedded Python omitted `import re`; tooling-only stop.

## D97CB-v5 — cold harness proven, true mapping reaches __DATA_CONST mmap alignment failure
Returned bundle:
`OCLP7_D97CB_V5_ATOMIC_REMAP_COLD_HOST_20260906_030103.zip`
- bytes `134957`;
- SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`;
- TXT SHA256 `ffd4cad23e1c224803096ac649dfae548dacb849eeab5a4612f9b7b66abf60ab`;
- JSON SHA256 `13c4969165ff9f28d70f20de2ce928630830fa94c0a2e91245f9fccf0c094e73`.

Cold baseline:
- `/usr/bin/true` copied, Apple signature removed, ad-hoc sign/verify PASS;
- exit 0;
- final native Metal state delayed;
- final libbz2 state delayed.

Positive control:
- `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib`;
- exit 0;
- path observed;
- final libbz2 state loaded.
Thus the cold-load harness is proven valid.

Signed remapped Metal injection:
- target temp path explicitly observed;
- dyld logs `Mapping ...Metal.SGRO.ORDER.adhoc`;
- `__TEXT` maps successfully;
- next mapping fails at `__DATA_CONST`:
  `mmap(addr=0x13BE35CD0, size=0x00070000) failed with errno=22`.

The original preserved `__DATA_CONST` segment VM start is `0x7FF84119DCD0`; its low page residue `0xCD0` is carried into the requested standalone mapping address. Previous SG_READ_ONLY and segment-order validation failures are gone.

Classifications:
- `D97CBV5_COLD_LOAD_HARNESS=PROVEN_VALID`;
- `D97CBV5_REMAPPED_METAL_TARGET_PATH_OBSERVED=PROVEN`;
- `D97CBV5_REMAPPED_METAL___TEXT_MAPPED=PROVEN`;
- `D97CBV5_DATA_CONST_MMAP_ADDR_NON_PAGE_ALIGNED_FAILURE=PROVEN`;
- `D97CBV5_PREVIOUS_SGRO_AND_SEGMENT_ORDER_GATES=PASSED`;
- `D97CBV5_CURRENT_REMAPPED_STANDALONE_LOADABLE=NEGATIVE`.

D97BV was correctly skipped because the original standalone baseline is not yet loadable.

## CURRENT ACTION — D97CC read-only page-prefix feasibility audit
Remain unpatched in VESA.

D97CC must audit a mapping-only repair before any new binary mutation:
- page-floor each non-aligned segment mapping start;
- add synthetic leading file prefix so original section/content bytes still land at original section VM addresses relative to slide;
- plan page-aligned standalone fileoffs;
- prove expanded VM ranges remain ordered/non-overlapping;
- enumerate every changed section fileoff;
- derive the resulting `__LINKEDIT` fileoff shift and every load-command field into LINKEDIT requiring remap;
- prove code/section VM addresses, symtab n_value, D97BV site/cave positions and section ordinals can remain unchanged;
- identify any unhandled file-offset-bearing/order-sensitive structure.

Only after this surface is fully bounded may a later D97CD construct a temporary page-prefix-aligned Metal and repeat the already-proven cold-load harness.

No Root Patch, installation, or accelerated reboot authorized.