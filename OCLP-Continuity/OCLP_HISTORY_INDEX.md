# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CC_SURFACE_CLOSED_D97CD_SCRIPT_READY.md`.
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
Patch window `0x7FF80F5E1719..0x7FF80F5E1726`; safe pre-sign unsectioned cave `0x7FF80F47E560..0x7FF80F47E630`.
Site `3dda0e00007406e93bcee9ff90`; cave `3d187d0000b9177d00000f4cc1e9b4311600`.
Semantics: preserve exact 3802, otherwise execute original Tahoe floor. `STATIC_SEMANTIC_PROVEN`.
The cave begins at current load-command end and must be re-audited after codesign before any standalone deployment.

## D97BW-v2 / D97BX — sparse analysis closure
Sparse reconstruction preserved native code/Metal4 and D97BV diff, but standalone real load failed because shared-cache mapping geometry is not directly valid. Signing and D97BV were not the blocker. Sparse mirror is analysis-only.

## D97BY — real DSC export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` exports succeed and preserve exact native Tahoe `__text`/Metal4. First real-load rejection: `__DATA_CONST segment missing SG_READ_ONLY flag`.

## D97BZ — SG_READ_ONLY gate passed
Exact metadata-only `0x0 -> 0x10` on `__DATA_CONST` passes that gate. Next exact rejection: `segment '__DATA_DIRTY' vm address out of order`.

## D97CA — segment-order surface enumerated
RAW file/load order `__TEXT,__DATA_CONST,__DATA,__DATA_DIRTY,__LINKEDIT` conflicts with VM order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`.
Coherent repair surface:
- dyld segment-index rewrites 0;
- relocation section-ordinal rewrites 0;
- chained fixups absent;
- split-seg info absent;
- unknown order-sensitive loads 0;
- 5 file-backed section offsets;
- 3652 symtab `n_sect` rewrites.
Classification: `STATIC_REMAP_SURFACE_ENUMERATED`.

## D97CB — atomic order remap structural PASS
Exact remap:
- `SG_READ_ONLY` on `__DATA_CONST`;
- physical/load order `__DATA_DIRTY` before `__DATA`;
- all segment/section VM addresses preserved;
- 5 section fileoffs rewritten;
- 3652 symtab `n_sect` remaps;
- diff outside audited domains 0;
- `file`, `otool -l`, `otool -L` PASS;
- unsigned/signed preflight PASS.

## D97CB-v2/v3/v4 — harness tooling corrections
v2: `copy2()->chflags` PermissionError on copied `/usr/bin/true`; fixed with `copyfile`.
v3: delayed closure entries were misclassified by substring matching; dyld source proved loaded/delayed transitions.
v4: final-state parser omitted `import re`; tooling-only stop.

## D97CB-v5 — cold harness proven, true mapping frontier
Bundle `OCLP7_D97CB_V5_ATOMIC_REMAP_COLD_HOST_20260906_030103.zip`, SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.
Cold baseline `/usr/bin/true`: exit 0, native Metal delayed, libbz2 delayed.
Positive control `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib`: exit 0, final libbz2 loaded. Cold harness therefore PROVEN VALID.

Signed remapped Metal target is explicitly observed; dyld maps `__TEXT` successfully. Next exact failure:
`__DATA_CONST mmap(addr=...5CD0, size=0x70000) failed with errno=22`.
Thus SG_READ_ONLY and segment-order gates are passed; current blocker is sub-page shared-cache VM mapping geometry.

## D97CC — page-prefix / LINKEDIT feasibility FULL STATIC CLOSURE
Bundle `OCLP7_D97CC_PAGE_PREFIX_LINKEDIT_FEASIBILITY_20260906_031505.zip`:
- bytes `5713`;
- SHA256 `8edf16651be320d3ace7dadc706e243c35ed68b92192fc2a7fa50a5ebbff19a3`;
- TXT SHA256 `39a76f7ba9a6b14b7247b37ac384951e2b0e6fd07bc602c5e42cbf77ef30fd71`;
- JSON SHA256 `18ed61878d5a775ffd925b465e8a10cf76e4e7d1b339fafc0bd1cfd58e518038`.

4K page-prefix plan preserving all original section/content VM addresses:
- `__DATA_CONST`: floor VM `...D000`, prefix `0xCD0`, fileoff `0x2EC000`, content `0x2ECCD0`, filesize `0x70CD0`, vmsize `0x71000`;
- `__DATA_DIRTY`: floor VM `...F000`, prefix `0x510`, fileoff `0x35D000`, content `0x35D510`, filesize `0x5510`, vmsize `0x6000`;
- `__DATA`: floor VM `...59000`, prefix `0xC0`, fileoff `0x363000`, content `0x3630C0`, filesize `0xD0C0`, vmsize `0xE000`;
- `__LINKEDIT`: fileoff `0x371000`, exact shift `+0x3000`.

All planned map VM starts and fileoffs are page aligned and VM/file ranges do not overlap.
Exactly 20 file-backed section offsets change.
LINKEDIT shift requires 7 metadata updates total: `__LINKEDIT.fileoff` itself plus 6 payload fields (`LC_DYLD_EXPORTS_TRIE.dataoff`, `LC_SYMTAB.symoff`, `LC_SYMTAB.stroff`, `LC_DYSYMTAB.indirectsymoff`, `LC_FUNCTION_STARTS.dataoff`, `LC_DATA_IN_CODE.dataoff`).
Section relocation remaps 0; symtab `n_value` rewrites 0; no new ordinal remap beyond D97CB.

D97CC printed one unknown load-field hit at `0xD48`; this was statically identified as the standard `__LINKEDIT segment_command_64.fileoff` field (`LC_SEGMENT_64` at `0xD20` + `0x28`). It is not an unknown blocker.
Corrected classification:
`D97CC_PAGE_PREFIX_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## CURRENT ACTION — D97CD
Run only `OCLP7_D97CD_page_aligned_transform_cold_load.sh`:
- bytes `28199`;
- SHA256 `67ec2f791de401e1e2007e9b2af898cd40059131bd2ac8d158cf8a139c61309a`;
- shell syntax PASS;
- embedded Python compile PASS.

D97CD materializes the exact page-prefix plan only in `/private/tmp`, integrates D97CB order/SG_READ_ONLY/n_sect repair, validates payload identities and all shifted LINKEDIT fields, runs external parsers and unsigned/signed preflight, audits codesign load-command/header-padding growth, reuses the proven `/usr/bin/true` + libbz2 cold harness, and cold-injects only the signed unpatched page-aligned Metal.

D97BV remains explicitly NOT applied in D97CD, even if the baseline becomes loadable. Any cave relocation/signing work is a later separate gate.

Remain unpatched in VESA. No Root Patch, installation, local/source build, accelerated boot or reboot authorized.
