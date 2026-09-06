# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CE_SLIDE_IDENTICAL_OBJC_SIGSEGV_DUPLICATE_METAL_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: `native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compilers may be bounded; legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic proven: preserve exact 3802, otherwise execute original Tahoe floor.
Pre-sign cave was `0x1560..0x1630`. D97CD later proved ad-hoc codesign consumes `0x1560..0x1570`; any standalone D97BV requires a new cave audit.

## D97BW-v2 / D97BX — sparse closure
Sparse reconstruction preserves native code/Metal4 but is not standalone-loadable. Signing and D97BV were not the blocker.

## D97BY — real DSC export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` extraction succeed and preserve native `__text`/Metal4. First real-load rejection was missing `SG_READ_ONLY`.

## D97BZ — SG_READ_ONLY gate passed
Metadata-only flag repair passes that gate. Next exact rejection was segment VM order.

## D97CA — order-remap surface enumerated
Coherent repair surface: 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.

## D97CB — atomic order remap structural PASS
Exact order/SG_READ_ONLY/n_sect repair passed parser/preflight. v2-v4 contained only harness tooling defects. v5 finally proved a valid cold harness.

## D97CB-v5 — cold harness proven; sub-page mapping frontier
Bundle SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.
Baseline `/usr/bin/true` exit 0 with native Metal/libbz2 delayed. Positive control `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib` exit 0 with libbz2 final loaded.
Signed remapped RAW Metal target observed; `__TEXT` maps; next failure `__DATA_CONST mmap(...CD0) errno=22`.

## D97CC — page-prefix/LINKEDIT static closure
4K page-prefix plan preserves all original section/content VM addresses while page-aligning segment mapping starts/fileoffs. Exactly 20 section offsets change; `__LINKEDIT +0x3000`; 7 total LINKEDIT metadata updates; no unknown blocker after identifying the printed `0xD48` hit as `__LINKEDIT.fileoff` itself.

## D97CD — page-aligned standalone mapping succeeds; Objective-C frontier
Bundle `OCLP7_D97CD_PAGE_ALIGNED_TRANSFORM_COLD_LOAD_20260906_033115.zip`, SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient unsigned page-aligned Metal: bytes `5735232`, SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.

D97CD proves full page-aligned transform, section-VM preservation, LINKEDIT shift/fields, 3652 n_sect remaps, file/otool, unsigned/signed preflight, signing and cold harness all pass.
Codesign inserts `LC_CODE_SIGNATURE` at `0x1560`, increasing load-command end to `0x1570`; old D97BV cave start is consumed by 16 bytes.

Cold injection maps all five standalone Metal segments successfully. The previous sub-page mmap blocker is CLOSED.
Runtime then reaches `mprotect ... to read-write (Metal.PAGE.adhoc)` and exits `RC=-11` SIGSEGV. Target final state is loaded; native system Metal also becomes loaded.
Apple dyld places this transition immediately before Objective-C `map_images` registration/fixups.

Classifications:
- `D97CD_STANDALONE_PAGE_ALIGNED_MAPPING=RUNTIME_PROVEN`;
- `D97CD_ALL_SEGMENTS_MAPPED=RUNTIME_PROVEN`;
- `D97CD_OBJECTIVE_C_MAP_IMAGES_FRONTIER=REACHED`;
- `D97CD_COLD_TARGET_FINAL_LOADED_THEN_SIGSEGV=NEGATIVE_RUNTIME`.

## D97CE — `--slide` makes massive ObjC/data pointer changes but runtime frontier is identical
Returned Terminal paste `Text lipit(5).txt`:
- bytes `369222`;
- SHA256 `f236a0d5112fc8f58a3538ea22436f9e85d37319f882370f58eb1682ecbb6f41`.

RAW Metal remains SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`.
SLIDE Metal:
- bytes `5722944`;
- SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.

RAW/SLIDE load commands and native `__text` are identical; Metal4 counts are unchanged.
`--slide` changes `88012` bytes across `43909` 8-byte chunks, with `39479` changed chunks in `__DATA_CONST`, concentrated heavily in Objective-C metadata (`__objc_const=25320`, `__cfstring=4906`, `__objc_selrefs=4674`, class/protocol/super refs), plus `__objc_data`, GOT and other data.

SLIDE-page transform:
- bytes `5735232`;
- SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`.
Structural transform, parsers, preflight, ad-hoc sign/verify and proven cold harness pass.

Cold result exactly reproduces D97CD:
- target final loaded;
- native system Metal final loaded;
- target mapped;
- `makeSegmentsReadWrite` marker seen;
- zero dyld lines after marker;
- process `RC=-11` SIGSEGV.

Printed:
- `D97CE_SLIDE_COLD_LOAD_CLASSIFICATION=TARGET_FINAL_LOADED_THEN_PROCESS_FAILED`;
- `D97CE_VS_D97CD_FRONTIER=IDENTICAL_D97CD_RW_MARKER_THEN_SIGSEGV`;
- `D97CE_D97BV_APPLIED=NO`.

Therefore full `ipsw --slide` resolution does not advance the Objective-C frontier. It is insufficient as the current repair.

Late JSON packaging failed with `TypeError: list indices must be integers or slices, not str` because the collector reused variable `post` as a line-list after previously using it as the post-codesign Mach-O dictionary. This occurred after decisive runtime markers; do not repeat D97CE just for packaging.

## CURRENT ACTION — duplicate native+standalone Metal discriminator
Both D97CD and D97CE load two Metal images simultaneously: temporary standalone native-derived Metal and native Tahoe shared-cache Metal, with the same native UUID and Objective-C class universe.

Next bounded transient test should attempt `DYLD_FRAMEWORK_PATH` override of canonical Metal with the temporary signed page-aligned SLIDE image, prove from dyld trace whether shared-cache override is honored, fail closed if not, and only if a true single-Metal process is obtained compare Objective-C progress against D97CE.

D97BV remains not applied. Remain unpatched in VESA. No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized.
