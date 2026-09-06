# OCLP7 CHECKPOINT — 2026-09-06 — D97CE --slide does not advance ObjC frontier; duplicate native+standalone Metal becomes next discriminator

## State / safety
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with active `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; full legacy main Metal remains forbidden.
- No Root Patch, installation, accelerated boot or reboot authorized.
- D97BV was NOT applied.

## Returned D97CE evidence
User returned complete Terminal paste `Text lipit(5).txt` rather than a ZIP because the collector hit a late JSON-packaging bug after all decisive runtime markers had already printed.

Local mounted-text identity:
- bytes `369222`;
- SHA256 `f236a0d5112fc8f58a3538ea22436f9e85d37319f882370f58eb1682ecbb6f41`.

Runtime/source identity gates passed:
- OS `26.6.2 / 25G82`;
- native Tahoe MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- `-igfxvesa` active;
- pinned `ipsw v3.1.713` manifest/archive/binary identities matched.

## RAW vs --slide extraction
RAW:
- bytes `5722944`;
- SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`.

SLIDE:
- bytes `5722944`;
- SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.

Proven invariants:
- load commands identical through `LOAD_END=0x1560`;
- native `__text` identical, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- exact Metal4 counts unchanged.

`--slide` makes a large real semantic pointer transformation:
- changed bytes: `88012`;
- changed 8-byte chunks: `43909`;
- by segment: `__DATA_CONST=39479`, `__DATA=2670`, `__DATA_DIRTY=1760`;
- target classes: in-image `__TEXT=26698`, `__DATA_CONST=3341`, `__DATA=3161`, `__DATA_DIRTY=1113`, external-cache-like `9596`.

Major changed Objective-C/data sections include:
- `__DATA_CONST,__objc_const=25320` chunks;
- `__DATA_CONST,__cfstring=4906`;
- `__DATA_CONST,__objc_selrefs=4674`;
- `__DATA,__objc_data=1616`;
- `__DATA_DIRTY,__objc_data=1760`;
- plus class/protocol/superref/GOT and other Objective-C sections.

Representative raw slide-info encoded pointer `0x20043D61250` becomes resolved cache address `0x7FF843D61250`.

Classification:
`D97CE_SLIDE_REBASE_MASSIVE_DATA_OBJC_TRANSFORM=RUNTIME_STATIC_PROVEN`.

## SLIDE page-aligned transform
D97CE materialized the exact D97CD geometry from the SLIDE payload and passed:
- `D97CE_SLIDE_PAGE_ALIGNED_TRANSFORM=PASS`;
- `D97CE_SLIDE_SECTION_VM_PRESERVATION=PASS`;
- `D97CE_SLIDE_PAYLOAD_IDENTITY=PASS`;
- `D97CE_SLIDE_LINKEDIT_NSECT=PASS`;
- external `file`/`otool` PASS;
- unsigned preflight PASS;
- ad-hoc sign + strict verify PASS;
- signed preflight PASS;
- proven `/usr/bin/true` + libbz2 cold harness PASS.

Transient unsigned SLIDE-page transform:
- bytes `5735232`;
- SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`.

Codesign again inserted `LC_CODE_SIGNATURE` at `0x1560`, post-sign load-command end `0x1570`; D97BV remains unauthorized.

## Decisive runtime result — --slide does NOT advance D97CD
Cold target:
- RC `-11` = SIGSEGV;
- target path observed: true;
- target final state: `loaded`;
- native system Metal final state: `loaded`;
- mapping seen: true;
- `makeSegmentsReadWrite` marker seen: true;
- lines after the target read-write marker: `0`;
- first post-marker line: `NONE`.

Last dyld line before SIGSEGV:
`mprotect ... to read-write (Metal.SLIDE.PAGE.adhoc)`.

Collector classifications printed before the tooling failure:
- `D97CE_SLIDE_COLD_LOAD_CLASSIFICATION=TARGET_FINAL_LOADED_THEN_PROCESS_FAILED`;
- `D97CE_VS_D97CD_FRONTIER=IDENTICAL_D97CD_RW_MARKER_THEN_SIGSEGV`;
- `D97CE_D97BV_APPLIED=NO`.

Authoritative interpretation:
- resolving raw DSC slide-info pointers is not sufficient to pass the Objective-C `map_images` frontier;
- `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`;
- `D97CE_RAW_CACHE_SLIDE_INFO_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`;
- usable standalone Metal remains NEGATIVE.

This does NOT prove slide-info irrelevant globally; it proves that full `ipsw --slide` resolution is insufficient at the exact D97CD/D97CE frontier.

## Active confounder / next hypothesis
Both D97CD and D97CE cold runs end with two Metal images loaded simultaneously:
1. the transient standalone page-aligned Metal;
2. native Metal from the Tahoe dyld shared cache.

They carry the same native Metal UUID `5D64FA80-29CE-32AA-BAB6-4E5034132C0B` and the same Objective-C class universe.

Therefore the next discriminator is whether the `map_images` SIGSEGV is caused by duplicate native+standalone Metal registration/coalescing rather than unresolved slide-info.

This is a hypothesis only, not yet proven causal.

## Collector tooling defect
After all decisive markers, embedded Python raised:
`TypeError: list indices must be integers or slices, not str`.

Cause: variable `post` was first a parsed post-codesign Mach-O dictionary, then reused for `lines[idx+1:]`; final JSON serialization later attempted `post['load_end']`.

Classification:
`D97CE_JSON_PACKAGE_FAILURE=TOOLING_ONLY_AFTER_DECISIVE_RUNTIME`.

No D97CE ZIP was produced and explicit collection-complete markers were not reached. The shell EXIT cleanup trap was present, but the returned text does not itself prove post-failure cleanup completion.

Do not rerun D97CE merely to obtain a ZIP.

## CURRENT ACTION
Remain unpatched in VESA.

Next bounded transient test should attempt a framework-path override so that canonical `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` resolves to the temporary page-aligned SLIDE Metal, while proving from dyld trace whether native cache Metal is or is not loaded.

Fail closed if the shared-cache framework override is not honored. If a true single-Metal process is achieved, compare its ObjC frontier against D97CE.

D97BV remains NOT applied. No Root Patch, installation, local/source compilation, accelerated boot or reboot authorized.
