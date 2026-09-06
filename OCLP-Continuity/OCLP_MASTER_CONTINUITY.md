# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CD_PAGE_ALIGNED_FULL_MAPPING_OBJC_MAP_IMAGES_SIGSEGV_D97CE_SLIDE_NEXT.md`
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
Bundle `OCLP7_D97CD_PAGE_ALIGNED_TRANSFORM_COLD_LOAD_20260906_033115.zip`:
- bytes `122681`;
- SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.

Transient unsigned transformed Metal:
- bytes `5735232`;
- SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.

D97CD proves:
- exact page-aligned transform structural PASS;
- all section/content VM addresses preserved;
- 20 section-fileoff rewrites, LINKEDIT shift/fields and 3652 n_sect remaps PASS;
- payload identity PASS;
- file/otool PASS;
- unsigned preflight PASS;
- ad-hoc signing and strict verify PASS;
- signed preflight PASS;
- cold baseline + libbz2 control PASS.

Signed page-aligned target is explicitly observed and all five segments map successfully. Prior `mmap errno=22` alignment blocker is therefore CLOSED.

Runtime then reaches:
`mprotect ... to read-write (Metal.PAGE.adhoc)`
and the cold process exits `RC=-11` SIGSEGV. Target final state is `loaded`; native system Metal also becomes `loaded` through the dependency graph.
Apple dyld source places this read-write transition immediately before Objective-C `map_images` registration/fixups for images with read-only ObjC metadata.

Classifications:
- `D97CD_STANDALONE_PAGE_ALIGNED_MAPPING=RUNTIME_PROVEN`;
- `D97CD_ALL_SEGMENTS_MAPPED=RUNTIME_PROVEN`;
- `D97CD_PREVIOUS_MMAP_ALIGNMENT_GATE=CLOSED`;
- `D97CD_OBJECTIVE_C_MAP_IMAGES_FRONTIER=REACHED`;
- `D97CD_COLD_TARGET_FINAL_LOADED_THEN_SIGSEGV=NEGATIVE_RUNTIME`;
- usable standalone load remains NEGATIVE.

## Exact extractor semantic relevant to current frontier
Pinned `blacktop/ipsw v3.1.713` source explicitly says ordinary extraction leaves `raw cache slide-info pointers` in the extracted dylib. `--slide` executes `rebaseMachO()` and writes the resolved cache-rebase targets. `--objc` implies `--slide` for the same reason.

This is the next causal discriminator because D97CD maps the RAW image completely and then dies exactly at Objective-C registration/fixup time.

## CURRENT ACTION — D97CE
Remain unpatched in Tahoe VESA.

Next transient target-local test must:
1. extract exact RAW and `--slide` Metal using pinned `ipsw v3.1.713`;
2. pin RAW identity and record exact SLIDE identity;
3. prove `__text`, load-command geometry and Metal4 remain equivalent where expected;
4. enumerate/classify RAW-vs-SLIDE rebase changes by segment/section and target class;
5. materialize the exact already-proven D97CD page-aligned/order/SG_READ_ONLY/LINKEDIT/n_sect transform from the SLIDE export;
6. validate payload identity against SLIDE, external parsers, preflight, signing/header growth and cold harness;
7. cold-inject only signed page-aligned SLIDE Metal and test whether Objective-C registration advances beyond the D97CD `makeSegmentsReadWrite -> SIGSEGV` frontier;
8. do not apply D97BV;
9. stop at the next exact runtime frontier and delete all transient binaries.

No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
