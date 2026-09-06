# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CD_PAGE_ALIGNED_FULL_MAPPING_OBJC_MAP_IMAGES_SIGSEGV_D97CE_SLIDE_NEXT.md`.
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
Bundle:
`OCLP7_D97CD_PAGE_ALIGNED_TRANSFORM_COLD_LOAD_20260906_033115.zip`
- bytes `122681`;
- SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`;
- TXT SHA256 `b973b761f57e783d67ab55f5e77b78977fc5b0f96e13056ca8590c7d5eb75d22`;
- JSON SHA256 `2907be66e4943262209bc282dc5db6bfd111ac378f574033f3e878877cb3e1c2`.

Transient unsigned page-aligned Metal:
- bytes `5735232`;
- SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.

D97CD proves the full page-aligned transform, section-VM preservation, LINKEDIT shift/fields, payload identity, 3652 n_sect remaps, file/otool, unsigned/signed preflight, ad-hoc signing and cold harness all pass.

Codesign inserts one new `LC_CODE_SIGNATURE` at load-command offset `0x1560`, increasing load-command end to `0x1570`; old D97BV cave start is therefore consumed by 16 bytes.

Cold injection maps all five standalone Metal segments successfully:
- `__TEXT`;
- `__DATA_CONST`;
- `__DATA_DIRTY`;
- `__DATA`;
- `__LINKEDIT`.
The previous sub-page mmap blocker is CLOSED.

Runtime then reaches `mprotect ... to read-write (Metal.PAGE.adhoc)` and the process exits `RC=-11` SIGSEGV. Target final state is loaded; native system Metal also reaches loaded through dependencies.
Apple dyld places this transition immediately before Objective-C `map_images` registration/fixups.

Classifications:
- `D97CD_STANDALONE_PAGE_ALIGNED_MAPPING=RUNTIME_PROVEN`;
- `D97CD_ALL_SEGMENTS_MAPPED=RUNTIME_PROVEN`;
- `D97CD_OBJECTIVE_C_MAP_IMAGES_FRONTIER=REACHED`;
- `D97CD_COLD_TARGET_FINAL_LOADED_THEN_SIGSEGV=NEGATIVE_RUNTIME`;
- usable standalone load remains NEGATIVE.

Pinned `ipsw` source states ordinary extraction leaves raw cache slide-info pointers while `--slide` runs `rebaseMachO()` and writes resolved rebase targets. This becomes the next causal discriminator.

## CURRENT ACTION — D97CE
Run only the next transient RAW-vs-`--slide` discriminator. It must page-align the SLIDE export with the exact D97CD transform, preserve all proven geometry/metadata repairs, cold-inject only that signed image, and determine whether Objective-C registration advances beyond D97CD. D97BV remains not applied.

Remain unpatched in VESA. No Root Patch, installation, local/source build, accelerated boot or reboot authorized.
