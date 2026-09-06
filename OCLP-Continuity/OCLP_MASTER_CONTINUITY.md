# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CE_SLIDE_IDENTICAL_OBJC_SIGSEGV_DUPLICATE_METAL_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
Before any technical modification:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable architecture
Pinned Golden OCLP: `dortania/OpenCore-Legacy-Patcher` commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.
Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; D34 cave remains protected.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- no repeat of historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Exact target Metallib package remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Native producer / D97BV closure
Native Tahoe Metal cache base `0x7FF80F47D000`; native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`; native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`. Native 3802 and 32023 lanes exist; no 31001.
D97BT proved default-environment accessor-wide 3802 suppression to 32023/32024.

D97BV selective adapter remains static-semantic proven:
- site `0x7FF80F5E1719..0x7FF80F5E1726`;
- pre-sign cave `0x7FF80F47E560..0x7FF80F47E630`;
- exact 3802 preserve semantics with no non-3802 drift.
D97CD proved codesign inserts `LC_CODE_SIGNATURE` at file/VM-relative `0x1560..0x1570`, consuming the first 16 bytes of the old cave. Remaining zero padding `0x1570..0x1630` is 192 bytes but requires a fresh safety audit before any D97BV relocation. D97BV remains unauthorized.

## Standalone native-Metal reconstruction closure to D97CC
D97BW-v2/BX: sparse mirror is analysis-only.
D97BY: real `ipsw v3.1.713` extraction preserves native `__text`/Metal4; first load rejection missing `SG_READ_ONLY`.
D97BZ: SG_READ_ONLY fixed; next rejection segment VM order.
D97CA: coherent order-remap surface fully enumerated: 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.
D97CB: atomic order/SG_READ_ONLY/n_sect remap structural PASS.
D97CB-v5: cold harness proven; remapped RAW Metal maps `__TEXT`, then fails `__DATA_CONST mmap(...CD0) errno=22`.
D97CC: exact 4K page-prefix/LINKEDIT plan statically closed; 20 section fileoffs, `__LINKEDIT +0x3000`, 7 total LINKEDIT metadata updates, section/content VM addresses preserved.

## D97CD — page-aligned mapping FULL PASS; Objective-C frontier
Bundle `OCLP7_D97CD_PAGE_ALIGNED_TRANSFORM_COLD_LOAD_20260906_033115.zip`, SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient unsigned transformed Metal: bytes `5735232`, SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.

D97CD proves full page-aligned transform, section-VM preservation, LINKEDIT shift/fields, 3652 n_sect remaps, parser/preflight/signing and cold harness PASS.
All five standalone Metal segments map successfully; prior sub-page `mmap errno=22` blocker is CLOSED.
Runtime then reaches `mprotect ... to read-write (Metal.PAGE.adhoc)` and exits `RC=-11` SIGSEGV. Target final state is loaded and native system Metal also becomes loaded through dependencies.
Apple dyld places this transition immediately before Objective-C `map_images` registration/fixups.

Classifications:
- `D97CD_STANDALONE_PAGE_ALIGNED_MAPPING=RUNTIME_PROVEN`;
- `D97CD_ALL_SEGMENTS_MAPPED=RUNTIME_PROVEN`;
- `D97CD_OBJECTIVE_C_MAP_IMAGES_FRONTIER=REACHED`;
- `D97CD_COLD_TARGET_FINAL_LOADED_THEN_SIGSEGV=NEGATIVE_RUNTIME`.

## D97CE — full --slide rebase does NOT advance ObjC frontier
Returned complete Terminal paste `Text lipit(5).txt`:
- bytes `369222`;
- SHA256 `f236a0d5112fc8f58a3538ea22436f9e85d37319f882370f58eb1682ecbb6f41`.
No ZIP exists because a late JSON-packaging bug occurred after decisive runtime markers.

RAW extraction remains SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`.
SLIDE extraction:
- bytes `5722944`;
- SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.

`--slide` changes `88012` bytes / `43909` 8-byte chunks, heavily concentrated in Objective-C/data metadata (`__objc_const`, `__cfstring`, `__objc_data`, GOT, selectors, class/protocol/super refs), while load commands, native `__text` and Metal4 counts remain identical.

Transient SLIDE-page transform:
- bytes `5735232`;
- SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`.
Structural transform, parser/preflight/signing and proven cold harness all PASS.

Cold result is identical to D97CD:
- RC `-11` SIGSEGV;
- target path observed;
- target final state `loaded`;
- native system Metal final state `loaded`;
- mapping seen;
- target `makeSegmentsReadWrite` marker seen;
- zero dyld lines after that marker.

Printed classifications before tooling failure:
- `D97CE_SLIDE_COLD_LOAD_CLASSIFICATION=TARGET_FINAL_LOADED_THEN_PROCESS_FAILED`;
- `D97CE_VS_D97CD_FRONTIER=IDENTICAL_D97CD_RW_MARKER_THEN_SIGSEGV`;
- `D97CE_D97BV_APPLIED=NO`.

Therefore:
- `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`;
- `D97CE_RAW_CACHE_SLIDE_INFO_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`;
- full `ipsw --slide` resolution is insufficient at this exact frontier.

Late collector `TypeError: list indices must be integers or slices, not str` is tooling-only: variable `post` was reused as a list after the runtime marker and then indexed as the earlier parsed Mach-O dictionary during JSON serialization. Do not rerun D97CE merely for packaging.

## CURRENT ACTION — duplicate native+standalone Metal discriminator
Remain unpatched in Tahoe VESA.

Both D97CD and D97CE end with two Metal images loaded simultaneously:
1. transient standalone native-derived Metal;
2. native Tahoe Metal from the dyld shared cache.
They carry the same native Metal UUID and Objective-C class universe.

Next bounded transient test should use a temporary `DYLD_FRAMEWORK_PATH` override so that canonical `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` resolves to the page-aligned SLIDE Metal itself. The test must:
1. prove from dyld trace whether the framework override is actually honored;
2. fail closed if shared-cache override is disallowed;
3. if honored, prove whether native cache Metal remains absent or is still loaded;
4. only if a true single-Metal process exists, compare Objective-C `map_images` progress against D97CE;
5. keep D97BV absent;
6. use only temporary files and make no system/root/cache mutation.

No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
