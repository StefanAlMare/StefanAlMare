# OCLP7 CHECKPOINT — 2026-09-06 — D97CB-v5 cold harness proven; D97CC page-prefix/LINKEDIT surface enumerated; D97CD next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; legacy main Metal shadow remains forbidden.
- No Root Patch or accelerated reboot authorized.

## D97CB-v5 decisive runtime result
Returned bundle `OCLP7_D97CB_V5_ATOMIC_REMAP_COLD_HOST_20260906_030103.zip`:
- bytes `134957`;
- SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`;
- TXT SHA256 `ffd4cad23e1c224803096ac649dfae548dacb849eeab5a4612f9b7b66abf60ab`;
- JSON SHA256 `13c4969165ff9f28d70f20de2ce928630830fa94c0a2e91245f9fccf0c094e73`.

The exact D97CB atomic remap was reconfirmed: SG_READ_ONLY, `__DATA_DIRTY` before `__DATA`, all VM/section VM addresses preserved, 5 section fileoff rewrites, 3652 symtab n_sect remaps, diff outside audited domains 0, parsers PASS.

The corrected cold harness is now proven:
- copied/re-signed `/usr/bin/true` baseline exits 0;
- final baseline states Metal=delayed and libbz2=delayed;
- `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib` exits 0 and final libbz2 state is loaded.
Thus DYLD insertion is genuinely exercised.

Signed remapped Metal injection reaches actual mapping. `__TEXT` maps successfully. The next exact failure is `__DATA_CONST` mapping:
`mmap(addr=...5CD0, size=0x00070000) failed with errno=22`.
This corresponds to the shared-cache residue of native `__DATA_CONST.vmaddr = 0x7FF84119DCD0` (page residue `0xCD0`).

Authoritative classifications:
- `D97CBV5_COLD_LOAD_HARNESS=PROVEN_VALID`;
- `D97CBV5_REMAPPED_METAL_TARGET_PATH_OBSERVED=PROVEN`;
- `D97CBV5_REMAPPED_METAL___TEXT_MAPPED=PROVEN`;
- `D97CBV5_DATA_CONST_MMAP_ADDR_NON_PAGE_ALIGNED_FAILURE=PROVEN`;
- `D97CBV5_PREVIOUS_SGRO_AND_SEGMENT_ORDER_GATES=PASSED`;
- `D97CBV5_CURRENT_REMAPPED_STANDALONE_LOADABLE=NEGATIVE`.

D97BV was not applied.

## D97CC returned evidence
Bundle `OCLP7_D97CC_PAGE_PREFIX_LINKEDIT_FEASIBILITY_20260906_031505.zip`:
- bytes `5713`;
- SHA256 `8edf16651be320d3ace7dadc706e243c35ed68b92192fc2a7fa50a5ebbff19a3`;
- TXT bytes `7714`, SHA256 `39a76f7ba9a6b14b7247b37ac384951e2b0e6fd07bc602c5e42cbf77ef30fd71`;
- JSON bytes `13088`, SHA256 `18ed61878d5a775ffd925b465e8a10cf76e4e7d1b339fafc0bd1cfd58e518038`.

D97CC is read-only; no transformed Metal was created and no load test occurred.

Exact host page size: `0x1000`.
Exact native `__text` identity reconfirmed: rel `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`.

## Page-prefix plan
Goal: make every segment mapping start page-aligned without changing any original section/content VM address. Each nonaligned segment gets a synthetic prefix equal to its original VM residue, while its segment vmaddr is rounded down.

Planned geometry:
- `__TEXT`: map VM `0x7FF80F47D000`, prefix `0`, fileoff `0x0`, filesize `0x2EC000`, vmsize `0x2EC000`;
- `__DATA_CONST`: original VM `0x7FF84119DCD0`, residue/prefix `0xCD0`, map VM `0x7FF84119D000`, fileoff `0x2EC000`, content fileoff `0x2ECCD0`, new filesize `0x70CD0`, vmsize `0x71000`;
- `__DATA_DIRTY`: original VM `0x7FF84384F510`, residue/prefix `0x510`, map VM `0x7FF84384F000`, fileoff `0x35D000`, content fileoff `0x35D510`, new filesize `0x5510`, vmsize `0x6000`;
- `__DATA`: original VM `0x7FF843D590C0`, residue/prefix `0xC0`, map VM `0x7FF843D59000`, fileoff `0x363000`, content fileoff `0x3630C0`, new filesize `0xD0C0`, vmsize `0xE000`;
- `__LINKEDIT`: VM already aligned, new fileoff `0x371000`, filesize `0x207340`, vmsize `0x208000`.

All mapping VMs and fileoffs are page aligned; VM ranges are non-overlapping. Original section VM addresses remain unchanged.

Exactly 20 file-backed section offsets would change under this plan:
- 15 in `__DATA_CONST`, each by `+0xCD0`;
- 2 in `__DATA_DIRTY`, each by `+0x1510` relative to D97CB logical layout;
- 3 in `__DATA`, each by `+0x20C0` relative to D97CB logical layout.

## LINKEDIT relocation surface
`__LINKEDIT` moves from D97CB logical fileoff `0x36E000` to `0x371000`: exact delta `+0x3000`.

Known load-command file-offset fields requiring the same `+0x3000` shift:
1. `LC_DYLD_EXPORTS_TRIE.dataoff`: `0x36E000 -> 0x371000`;
2. `LC_SYMTAB.symoff`: `0x37DA18 -> 0x380A18`;
3. `LC_SYMTAB.stroff`: `0x3DF048 -> 0x3E2048`;
4. `LC_DYSYMTAB.indirectsymoff`: `0x3DDC48 -> 0x3E0C48`;
5. `LC_FUNCTION_STARTS.dataoff`: `0x379870 -> 0x37C870`;
6. `LC_DATA_IN_CODE.dataoff`: `0x379440 -> 0x37C440`.

Section relocation-offset remaps required: 0.
Symtab `n_value` rewrites required: 0, because section/content VM addresses remain unchanged.
No further section ordinal remap is required beyond the already-proven D97CB order remap.

## Critical correction to D97CC printed classification
D97CC printed one `UNKNOWN_LINKEDIT_FIELD_HIT`:
- load index 4;
- command `LC_SEGMENT_64`;
- absolute field offset `0xD48`;
- value `0x36E000`.

This is not unknown. Load index 4 is the `__LINKEDIT` segment command at `0xD20`; `segment_command_64.fileoff` is at command offset `+0x28`, hence exact field address `0xD20 + 0x28 = 0xD48`. The generic scanner reported it only because segment-command standard fields were not registered in its recognized-field set.

Therefore the corrected classification is:
`D97CC_PAGE_PREFIX_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

The later transform must update `__LINKEDIT.fileoff` itself from `0x36E000 -> 0x371000` in addition to the 6 explicit LINKEDIT payload-offset fields above.

## D97BV cave/signing warning
D97CC reconfirmed unsigned pre-sign positions:
- patch site rel/fileoff `0x164719`, exact preimage PASS;
- original cave rel/fileoff `0x1560`, 208 zero bytes PASS.

However `0x1560` is exactly the end of current load commands. Ad-hoc `codesign` may use header padding starting there for `LC_CODE_SIGNATURE`. Therefore no future D97BV application may assume the old `0x1560` cave remains free after signing. A page-prefix runtime test must first audit the signed header/load-command growth and remaining zero padding. D97BV remains unauthorized.

## CURRENT ACTION — D97CD
Remain unpatched in Tahoe VESA.

D97CD may create only a temporary page-prefix transformed native Metal based on the fully enumerated D97CC surface. It must:
1. reproduce exact RAW export identity;
2. integrate the already-proven D97CB order/SG_READ_ONLY/symtab remap;
3. implement the exact D97CC page-prefix geometry above while preserving every original section/content VM address;
4. shift `__LINKEDIT` payload by `+0x3000` and update exactly the 7 enumerated fields: its own segment fileoff plus the 6 LINKEDIT payload-offset fields;
5. update exactly the 20 file-backed section offsets implied by the page-prefix plan;
6. prove native `__text` and Metal4 contents unchanged;
7. prove all map VM starts and fileoffs page aligned and all ranges non-overlapping;
8. run file/otool parsers, unsigned/signed preflight, ad-hoc signing and signed cold-load using the already-proven `/usr/bin/true` + libbz2 final-state harness;
9. record exactly how codesign changes load-command/header padding, especially bytes at and after `0x1560`;
10. do not apply D97BV even if original page-prefix Metal becomes loadable; D97BV cave relocation/signing must be a separate later gate;
11. stop at the next exact dyld/runtime error and delete all transient binaries before packaging TXT/JSON only.

No Root Patch, installation, accelerated boot or reboot authorized.
