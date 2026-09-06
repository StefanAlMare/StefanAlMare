# OCLP7 CHECKPOINT — 2026-09-06 — D97CB-v5 cold harness PASS; remapped Metal __TEXT maps; __DATA_CONST mmap EINVAL; D97CC next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; legacy main Metal shadow remains forbidden.
- No Root Patch, installation, or accelerated reboot authorized.

## Returned D97CB-v5 bundle
`OCLP7_D97CB_V5_ATOMIC_REMAP_COLD_HOST_20260906_030103.zip`
- bytes `134957`;
- SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.

Contents contain TXT + JSON only, no Apple binary:
- TXT bytes `225254`, SHA256 `ffd4cad23e1c224803096ac649dfae548dacb849eeab5a4612f9b7b66abf60ab`;
- JSON bytes `388294`, SHA256 `13c4969165ff9f28d70f20de2ce928630830fa94c0a2e91245f9fccf0c094e73`.

Transient cleanup passed and no Apple binary is present in the returned ZIP.

## Atomic remap reconfirmed — structural FULL PASS
D97CB-v5 again reproduced the exact D97CB atomic temporary remap:
- RAW Metal SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`;
- native `__text` rel `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- exact native Metal4 count surface retained;
- `SG_READ_ONLY` set on `__DATA_CONST`;
- segment/load/file order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- `__DATA_DIRTY` fileoff `0x35C000`, `__DATA` fileoff `0x361000`, `__LINKEDIT` fileoff `0x36E000`;
- all segment and section VM addresses preserved;
- exactly 5 section file offsets remapped;
- exactly 3652 symtab `n_sect` values remapped with the D97CA-proven ordinal counts;
- pre-sign diff count `40655`, outside audited domains `0`;
- `file`, `otool -l`, `otool -L` PASS.

Markers:
- `D97CB_ATOMIC_REMAP_STRUCTURAL=PASS`;
- `D97CB_VM_ADDRESS_PRESERVATION=PASS`;
- `D97CB_SECTION_FILEOFF_REMAP=PASS`;
- `D97CB_SYMTAB_N_SECT_REMAP=PASS`;
- `D97CB_DIFF_DOMAIN=PASS`.

Classification remains:
`D97CB_ATOMIC_SEGMENT_ORDER_REMAP=STRUCTURAL_STATIC_PROVEN`.

## Python-child dlopen retained later-frontier signal
Unsigned and ad-hoc-signed remapped Metal both pass `dlopen_preflight`, while Python-child actual `dlopen` returns `RC=-11` (SIGSEGV). This is retained as a later runtime signal but not used as standalone-loadability proof because Python already has native Metal loaded.

## D97CB-v5 cold-host harness — FULL PASS
The corrected `/usr/bin/true` host path is now valid and the dyld final-state parser works.

Baseline:
- copied `/usr/bin/true` signature removed;
- ad-hoc sign PASS;
- strict verify PASS;
- baseline process exit `0`;
- final `Metal=delayed`;
- final `libbz2.1.0.dylib=delayed`.

Positive `DYLD_INSERT_LIBRARIES` control:
- injected `/usr/lib/libbz2.1.0.dylib`;
- process exit `0`;
- path observed;
- final `libbz2.1.0.dylib=loaded`.

Therefore the cold host and `DYLD_INSERT_LIBRARIES` channel are validated.

Authoritative classifications:
- `D97CBV5_COLD_HOST_BASELINE_FINAL_STATE=PASS`;
- `D97CBV5_DYLD_INSERT_LIBRARIES_CONTROL=PASS`;
- `D97CBV5_COLD_LOAD_HARNESS=PROVEN_VALID`.

## Remapped Metal true cold-load attempt — next exact frontier
The signed remapped Metal target path is explicitly observed in the validated cold host.
Dyld logs:
- `Mapping /private/tmp/.../Metal.SGRO.ORDER.adhoc`;
- `__TEXT (r.x) ...` successfully mapped;
- then termination while attempting the next segment.

Exact failure:
`mmap(addr=0x13BE35CD0, size=0x00070000) failed with errno=22`.

This address corresponds to remapped Metal `__DATA_CONST`, whose preserved shared-cache VM address ends in `0xCD0`:
- `__DATA_CONST vmaddr = 0x7FF84119DCD0`;
- fileoff = `0x2EC000`;
- filesize = `0x70000`.

The previous dyld semantic validation failures (`SG_READ_ONLY`, segment VM order) are absent. The cold trace proves dyld progressed into actual segment mapping and mapped `__TEXT` before failing on the non-page-aligned `__DATA_CONST` mapping address.

Authoritative classifications:
- `D97CBV5_REMAPPED_METAL_TARGET_PATH_OBSERVED=PROVEN`;
- `D97CBV5_REMAPPED_METAL___TEXT_MAPPED=PROVEN`;
- `D97CBV5_DATA_CONST_MMAP_ADDR_NON_PAGE_ALIGNED_FAILURE=PROVEN`;
- `D97CBV5_CURRENT_REMAPPED_STANDALONE_LOADABLE=NEGATIVE`;
- `D97CBV5_PREVIOUS_SGRO_AND_SEGMENT_ORDER_GATES=PASSED`.

The process returns `RC=-6` because dyld aborts after inserted-dylib load failure; this is not a Metal initializer crash. The target never reaches final-loaded state.

## D97BV remains intentionally untested
D97BV was correctly skipped because the remapped original baseline is not yet true-cold-loadable:
`D97CB_D97BV_SKIPPED=REMAPPED_ORIGINAL_NOT_TRUE_COLD_LOADABLE`.

Do not apply D97BV until an unmodified-code original extracted Metal baseline becomes true-cold-loadable.

## Architectural implication
The shared-cache image uses sub-page segment VM starts (`__DATA_CONST ...CD0`, and other data segments also have non-zero page residues). A standalone image cannot simply preserve those segment starts and present them directly to `mmap`.

The next repair must preserve actual code/section VM semantics while presenting page-aligned mapping regions. A promising bounded architecture is to page-floor each non-aligned segment mapping start and insert a synthetic prefix in the standalone file so the original section/content bytes still land at their original virtual addresses relative to the image slide. This must be audited before mutation because it shifts standalone file layout and therefore all affected section file offsets plus `__LINKEDIT`-referencing load-command offsets.

Do not globally rebase code or section VM addresses without a separate fixup proof.

## CURRENT ACTION — D97CC read-only page-prefix / linkedit-remap feasibility audit
Remain unpatched in Tahoe VESA.

D97CC must reproduce the exact pinned RAW export and D97CB segment-order transform in memory/read-only analysis, then **perform no output-binary mutation or load test**. It must enumerate:
1. host page size and every segment VM residue;
2. page-floored mapping start and required synthetic leading prefix for each non-aligned segment;
3. a page-aligned standalone fileoff plan preserving original section/content VM addresses;
4. whether expanded page-floor segment VM ranges remain non-overlapping and ordered;
5. exact count/list of all file-backed section offsets that would change;
6. exact shift of `__LINKEDIT` fileoff;
7. every load-command field referring into `__LINKEDIT` that must be shifted/remapped (`LC_SYMTAB`, `LC_DYSYMTAB`, function starts, data-in-code, exports, code-sign related/other linkedit-data commands as present);
8. proof that symtab `n_value`, section VM addresses, code VM addresses, D97BV site/cave VM positions, and section ordinals need not change under the page-prefix plan;
9. any unknown file-offset-bearing or VM-order-sensitive structure that blocks a bounded repair.

Only if D97CC closes this remap surface may a later D97CD create a temporary page-prefix-aligned standalone image and repeat the validated cold-load harness.

No Root Patch, installation, source build, or accelerated reboot authorized.