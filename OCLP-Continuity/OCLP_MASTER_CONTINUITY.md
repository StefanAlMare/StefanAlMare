# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CC_SURFACE_CLOSED_D97CD_SCRIPT_READY.md`
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
- original cave `0x7FF80F47E560..0x7FF80F47E630`;
- exact 3802 preserve semantics with no non-3802 drift.
D97BV is not currently authorized for standalone delivery because codesign may consume the old cave header padding.

## Standalone native-Metal reconstruction frontier
D97BW-v2/BX: sparse mirror is analysis-only; signing/preflight pass but shared-cache geometry is not standalone-loadable.
D97BY: real `ipsw v3.1.713` extraction preserves native `__text`/Metal4; first real-load rejection was missing `SG_READ_ONLY`.
D97BZ: exact metadata fix passes SG_READ_ONLY gate; next rejection was `__DATA_DIRTY vm address out of order`.
D97CA: coherent segment-order remap surface fully enumerated; 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.
D97CB: atomic order/SG_READ_ONLY/symtab remap structural PASS; parsers and preflight pass.

## D97CB-v5 — cold harness proven, true mmap frontier
Bundle `OCLP7_D97CB_V5_ATOMIC_REMAP_COLD_HOST_20260906_030103.zip`, SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.
Validated cold host:
- `/usr/bin/true` baseline exit 0, Metal/libbz2 final delayed;
- `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib` exit 0, final libbz2 loaded.

Signed remapped Metal target path is observed; `__TEXT` maps successfully. Current exact failure:
`__DATA_CONST mmap(addr=...5CD0, size=0x70000) -> errno=22`.
Thus SG_READ_ONLY/order gates are passed and current blocker is actual sub-page shared-cache VM mapping geometry.

## D97CC — page-prefix / LINKEDIT surface closed
Bundle `OCLP7_D97CC_PAGE_PREFIX_LINKEDIT_FEASIBILITY_20260906_031505.zip`, SHA256 `8edf16651be320d3ace7dadc706e243c35ed68b92192fc2a7fa50a5ebbff19a3`.
Corrected classification:
`D97CC_PAGE_PREFIX_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

Exact 4K-page plan preserving original section/content VM addresses:
- `__TEXT`: unchanged;
- `__DATA_CONST`: floor VM `0x7FF84119D000`, prefix `0xCD0`, fileoff `0x2EC000`, content `0x2ECCD0`, filesize `0x70CD0`, vmsize `0x71000`;
- `__DATA_DIRTY`: floor VM `0x7FF84384F000`, prefix `0x510`, fileoff `0x35D000`, content `0x35D510`, filesize `0x5510`, vmsize `0x6000`;
- `__DATA`: floor VM `0x7FF843D59000`, prefix `0xC0`, fileoff `0x363000`, content `0x3630C0`, filesize `0xD0C0`, vmsize `0xE000`;
- `__LINKEDIT`: fileoff `0x371000`, exact shift `+0x3000`.

Exactly 20 file-backed section offsets change. LINKEDIT requires exactly 7 metadata updates: its own segment fileoff plus `LC_DYLD_EXPORTS_TRIE.dataoff`, `LC_SYMTAB.symoff`, `LC_SYMTAB.stroff`, `LC_DYSYMTAB.indirectsymoff`, `LC_FUNCTION_STARTS.dataoff`, `LC_DATA_IN_CODE.dataoff`.
The one printed D97CC unknown hit was only `__LINKEDIT.fileoff` itself at `0xD48`; no unknown blocker remains.

## CURRENT ACTION — D97CD
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97CD_page_aligned_transform_cold_load.sh`:
- bytes `28199`;
- SHA256 `67ec2f791de401e1e2007e9b2af898cd40059131bd2ac8d158cf8a139c61309a`;
- shell syntax PASS;
- embedded Python compile PASS.

D97CD creates only transient `/private/tmp` binaries. It materializes the exact D97CC page-prefix geometry plus D97CB order/SG_READ_ONLY/n_sect repair, validates byte domains, file/otool, unsigned/signed preflight, records codesign load-command/header-padding growth, proves the established cold harness, and cold-injects only the signed unpatched page-aligned Metal.

D97BV must not be applied by D97CD even if the baseline becomes loadable. Any D97BV cave/signing repair is a separate later gate.

No Root Patch, installation, source/local build, accelerated boot or reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
