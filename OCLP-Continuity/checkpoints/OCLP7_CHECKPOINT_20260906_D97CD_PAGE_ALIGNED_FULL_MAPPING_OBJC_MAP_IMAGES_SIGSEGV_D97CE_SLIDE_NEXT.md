# OCLP7 CHECKPOINT — 2026-09-06 — D97CD page-aligned standalone mapping succeeds; Objective-C map_images frontier SIGSEGV; D97CE --slide next

## State / safety
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with active `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; full legacy main Metal remains forbidden.
- No Root Patch, installation, accelerated boot or reboot authorized.
- D97BV was NOT applied.

## Returned D97CD evidence
Bundle:
`OCLP7_D97CD_PAGE_ALIGNED_TRANSFORM_COLD_LOAD_20260906_033115.zip`
- bytes `122681`;
- SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`;
- TXT bytes `350389`, SHA256 `b973b761f57e783d67ab55f5e77b78977fc5b0f96e13056ca8590c7d5eb75d22`;
- JSON bytes `388674`, SHA256 `2907be66e4943262209bc282dc5db6bfd111ac378f574033f3e878877cb3e1c2`;
- ZIP contains only directory entry + TXT + JSON; no Apple binary.

## D97CD page-aligned transform — FULL STRUCTURAL PASS
Transient transformed unsigned Metal:
- bytes `5735232`;
- SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.

D97CD materialized the exact D97CC plan and reached all structural markers:
- `D97CD_PAGE_ALIGNED_TRANSFORM=PASS`;
- `D97CD_SECTION_VM_PRESERVATION=PASS`;
- `D97CD_LINKEDIT_SHIFT_AND_FIELDS=PASS`;
- `D97CD_PAYLOAD_IDENTITY=PASS`;
- `D97CD_SYMTAB_NSECT=PASS`;
- `D97CD_EXTERNAL_PARSERS=PASS`.

Exact retained repair:
- order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all segment mapping starts and fileoffs 4K aligned;
- original section/content VM addresses preserved;
- `SG_READ_ONLY` on `__DATA_CONST`;
- exactly 20 file-backed section offsets rewritten;
- `__LINKEDIT` shifted `+0x3000`;
- exactly six LINKEDIT payload-offset fields shifted in addition to `__LINKEDIT.fileoff` itself;
- exactly 3652 symtab `n_sect` values remapped using D97CA counts;
- native `__text` SHA256 remains `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- native Metal4 string-count surface unchanged.

Unsigned `dlopen_preflight` PASS.

## Codesign header-growth closure
Ad-hoc signing PASS; strict verify PASS; signed preflight PASS.

Pre-sign header:
- ncmds `34`;
- sizeofcmds `0x1540`;
- load-command end `0x1560`;
- old D97BV cave padding `0x1560..0x1630` all zero.

Post-sign header:
- ncmds `35`;
- sizeofcmds `0x1550`;
- load-command end `0x1570`;
- `LC_CODE_SIGNATURE` inserted at command offset `0x1560`;
- code-signature blob dataoff `0x578340`, datasize `0xF650`.

Therefore codesign consumes exactly the first `0x10` bytes of the old D97BV cave. The old cave start `0x1560` is no longer usable in a signed standalone image. The remaining `0x1570..0x1630` padding is 192 bytes and appears zero in D97CD, but it requires a fresh branch/xref/function-start safety audit before any D97BV relocation. D97BV remains unauthorized.

## Cold harness remains PROVEN
Baseline `/usr/bin/true`:
- RC 0;
- native Metal final state delayed;
- libbz2 final state delayed.

Positive control:
- `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib`;
- RC 0;
- final libbz2 state loaded.

Classification: `D97CD_COLD_HARNESS=PASS`.

## Decisive runtime frontier — all Metal segments map
Signed page-aligned target is explicitly observed and all five segments map successfully:
- `__TEXT` `0x111A90000..0x111D7C000`;
- `__DATA_CONST` `0x1437B0000..0x143821000`;
- `__DATA_DIRTY` `0x145E62000..0x145E68000`;
- `__DATA` `0x14636C000..0x14637A000`;
- `__LINKEDIT` `0x182613000..0x18282B000`.

Thus the prior sub-page `mmap errno=22` blocker is closed.

Dyld then marks `__DATA_CONST` read-only, performs delayed-image state transitions, begins initializer processing, and immediately before failure logs:
`mprotect 0x0001437B0000->0x000143821000 to read-write (Metal.PAGE.adhoc)`.

Cold target result:
- target path observed: true;
- target final state: loaded;
- native system Metal final state: loaded;
- process RC `-11` = SIGSEGV;
- classification printed by collector: `TARGET_FINAL_LOADED_THEN_PROCESS_FAILED`.

Apple dyld source establishes that this read-write transition is `Loader::makeSegmentsReadWrite()` and is invoked for read-only Objective-C metadata immediately before Objective-C `map_images` registration/fixups.

Authoritative classifications:
- `D97CD_STANDALONE_PAGE_ALIGNED_MAPPING=RUNTIME_PROVEN`;
- `D97CD_ALL_SEGMENTS_MAPPED=RUNTIME_PROVEN`;
- `D97CD_PREVIOUS_MMAP_ALIGNMENT_GATE=CLOSED`;
- `D97CD_OBJECTIVE_C_MAP_IMAGES_FRONTIER=REACHED`;
- `D97CD_COLD_TARGET_FINAL_LOADED_THEN_SIGSEGV=NEGATIVE_RUNTIME`;
- `D97CD_USABLE_STANDALONE_LOAD=NEGATIVE`;
- `D97CD_D97BV_APPLIED=NO`.

Do not attribute this SIGSEGV to D97BV; D97BV was not present.

## Crucial extractor semantic fact for next step
Pinned `blacktop/ipsw v3.1.713` source explicitly states that ordinary RAW extraction leaves `raw cache slide-info pointers` in the extracted dylib. Its `--slide` option runs `rebaseMachO()` and writes the resolved cache rebase targets into the exported Mach-O. `--objc` implies `--slide` for this reason.

This is directly aligned with the new D97CD frontier: RAW page-aligned Metal maps completely and then dies at Objective-C registration/fixup time.

## D97CE script identity
Authorized transient discriminator:
`OCLP7_D97CE_slide_page_aligned_objc_discriminator.sh`
- bytes `33001`;
- SHA256 `197415b197d2eb32ccbb29ea0f0493b1de8e6d98d2dbf3c6c06c407289dba813`;
- shell syntax PASS;
- embedded Python compile PASS.

D97CE reproduces RAW and `--slide` extraction, inventories every slide-induced byte/8-byte-word change by segment/section and pointer target class, then materializes the exact D97CD page-aligned transform from the SLIDE payload. It preserves all already-proven layout/metadata repairs and runs external parsers, unsigned/signed preflight, codesign/header audit, proven cold harness, and one signed SLIDE-page cold injection. It explicitly classifies whether execution advances beyond D97CD's final `makeSegmentsReadWrite -> SIGSEGV` marker.

## CURRENT ACTION — D97CE
Remain unpatched in VESA. Run only the exact D97CE script identity above and return its ZIP/output.

Interpretation gate:
- if SLIDE advances beyond the D97CD read-write marker or exits 0, raw cache slide-info is causal at this boundary;
- if SLIDE reproduces the identical read-write marker then SIGSEGV, slide-info resolution is insufficient and the next audit moves to duplicate/native-Metal Objective-C interaction or another runtime ABI/fixup dependency.

D97BV remains NOT applied. No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized.
