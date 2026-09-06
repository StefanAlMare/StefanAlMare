# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CBV5_COLD_HARNESS_PASS_TEXT_MAP_DATA_CONST_MMAP_ALIGNMENT_FAIL_D97CC_NEXT.md`
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
6. retrospective/history when strategic context is needed.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Golden / architecture authority
Pinned Golden OCLP: upstream `dortania/OpenCore-Legacy-Patcher`, exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`, PatcherSupportPkg `1.9.6`.
Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes and reaches compositor success.
Historical accepted functional lineage remains `P1 + P2b + P3 + AIR00 + D34`; D34 cave protected.

Current required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Retained prohibitions:
- never install legacy `13.2.1-24/Versions/A/Metal` over cache-resident Tahoe Metal;
- no global `32023 -> 31001` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- no repeat of historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Exact target Metallib authority: local `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact map 182 entries.

## Durable causal closure
D97BJ/BK: full legacy Metal.framework removes Tahoe `_MTL4*` superclass ABI and is permanently incompatible on Tahoe.
Native Tahoe Metal cache base `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`; native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`. Native generation census contains 3802 and 32023, no 31001.
D97BT proved default-environment accessor-wide suppression of 3802: primary -> 32023; lazy fallbacks -> 32023/32024; sole bypass explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`, default/current zero.
Retained D97AA runtime: failing cohort 12/12 `llvmVersion=32023`, 3802=0.

## D97BV selective adapter
Exact patch window `0x7FF80F5E1719..0x7FF80F5E1726`, preimage `3d187d0000b9177d00000f4cc1`.
Safe unsectioned executable cave `0x7FF80F47E560..0x7FF80F47E630`, 208 zero bytes.
Site `3dda0e00007406e93bcee9ff90`; cave `3d187d0000b9177d00000f4cc1e9b4311600`.
Semantics: preserve exact 3802; every non-3802 input executes Tahoe original floor unchanged.
Classification: `D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## Standalone native-Metal reconstruction frontier
D97BW-v2/D97BX: sparse reconstruction is analysis-only; parsers/preflight/signing pass but real load is not viable. D97BV is not the sparse-load regression.
D97BY: pinned `blacktop/ipsw v3.1.713` real RAW and `--slide` extraction both succeed, each 5,722,944 bytes and preserving exact native `__text` rel `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a` plus exact Metal4 counts. First real-dlopen rejection was missing `SG_READ_ONLY` on `__DATA_CONST`.
D97BZ: exact metadata-only `SG_READ_ONLY` fix (`0x0 -> 0x10`, one effective changed byte) passes that gate; next rejection was `segment '__DATA_DIRTY' vm address out of order`.

## D97CA — remap surface fully enumerated
RAW file/load order was `__TEXT,__DATA_CONST,__DATA,__DATA_DIRTY,__LINKEDIT`; VM order was `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`.
D97CA proved a coherent reorder is bounded:
- dyld segment-index rewrites: 0;
- relocation section-ordinal rewrites: 0;
- chained fixups absent;
- split-seg info absent;
- unknown order-sensitive loads: 0;
- file-backed section offsets to rewrite: 5;
- symtab `n_sect` rewrites: 3652.
Classification: `D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## D97CB — atomic remap structural PASS
Exact atomic temporary remap is now durable/proven:
- `SG_READ_ONLY` on `__DATA_CONST`;
- `__DATA_DIRTY` payload fileoff `0x35C000`;
- `__DATA` payload fileoff `0x361000`;
- `__LINKEDIT` remains `0x36E000`;
- command order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all segment/section VM addresses preserved;
- exactly 5 section file offsets rewritten;
- exactly 3652 symtab `n_sect` values remapped with D97CA counts;
- pre-sign diff count `40655`, outside audited domains `0`;
- `file`, `otool -l`, `otool -L` PASS.

Unsigned and signed remapped images pass `dlopen_preflight`; Python-child actual `dlopen` returns `RC=-11` SIGSEGV. That Python lane is not standalone proof because native Metal is already present there.

## D97CB-v2/v3/v4 tooling corrections
D97CB-v2: `shutil.copy2('/usr/bin/true')` failed only because macOS Python tried to propagate BSD flags via `chflags`; fixed with `copyfile`.
D97CB-v3: cold host construction/signing/baseline exit passed; raw substring parser falsely treated delayed closure members as active loads. Dyld source proved `move loaded to delayed` and reverse `move delayed to loaded` are real state transitions.
D97CB-v4: final-state parser design was correct but embedded Python omitted `import re`; tooling-only stop.

## D97CB-v5 — validated cold harness; true mapping frontier reached
Returned bundle `OCLP7_D97CB_V5_ATOMIC_REMAP_COLD_HOST_20260906_030103.zip`:
- bytes `134957`;
- SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`;
- TXT SHA256 `ffd4cad23e1c224803096ac649dfae548dacb849eeab5a4612f9b7b66abf60ab`;
- JSON SHA256 `13c4969165ff9f28d70f20de2ce928630830fa94c0a2e91245f9fccf0c094e73`.

Cold-host baseline is now valid:
- `/usr/bin/true` copy, signature removal, ad-hoc sign, strict verify PASS;
- baseline exit 0;
- final `Metal=delayed`;
- final `libbz2.1.0.dylib=delayed`.

Positive insertion control is proven:
- `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib`;
- exit 0;
- path observed;
- final libbz2 state `loaded`.

Classification: `D97CBV5_COLD_LOAD_HARNESS=PROVEN_VALID`.

Signed remapped Metal cold insertion then reaches real mapping:
- explicit temp target path observed;
- dyld logs `Mapping .../Metal.SGRO.ORDER.adhoc`;
- remapped `__TEXT` is mapped successfully;
- dyld then terminates on `__DATA_CONST` with exact failure:
  `mmap(addr=0x13BE35CD0, size=0x00070000) failed with errno=22`.

The preserved shared-cache `__DATA_CONST` VM start is `0x7FF84119DCD0` while standalone fileoff is `0x2EC000`. Previous SG_READ_ONLY and VM-order validation failures are absent. The current blocker is therefore actual mmap geometry/alignment, not semantic validation/order.

Authoritative classifications:
- `D97CBV5_REMAPPED_METAL_TARGET_PATH_OBSERVED=PROVEN`;
- `D97CBV5_REMAPPED_METAL___TEXT_MAPPED=PROVEN`;
- `D97CBV5_DATA_CONST_MMAP_ADDR_NON_PAGE_ALIGNED_FAILURE=PROVEN`;
- `D97CBV5_PREVIOUS_SGRO_AND_SEGMENT_ORDER_GATES=PASSED`;
- `D97CBV5_CURRENT_REMAPPED_STANDALONE_LOADABLE=NEGATIVE`.

D97BV remains intentionally skipped because original standalone baseline is not yet loadable.

## CURRENT ACTION — D97CC read-only page-prefix / LINKEDIT remap feasibility audit
Remain unpatched in Tahoe VESA.

D97CC must reproduce the exact pinned RAW export and the D97CB order transform for analysis, but perform no output-binary mutation and no load test. It must enumerate:
1. page size and each segment VM residue;
2. page-floored mapping start and synthetic leading-prefix bytes required per non-aligned segment;
3. a page-aligned standalone fileoff plan that keeps original section/content VM addresses unchanged;
4. expanded segment mapping ranges and prove they stay ordered/non-overlapping;
5. every file-backed section offset that would change;
6. exact `__LINKEDIT` fileoff shift;
7. every load-command file-offset field into `__LINKEDIT` requiring remap;
8. proof that code VM addresses, section VM addresses, symtab `n_value`, D97BV site/cave VM positions and section ordinals need not change;
9. unknown/order-sensitive structures that would block a bounded repair.

Only if D97CC closes the surface may a later D97CD build a temporary page-prefix-aligned image and repeat the validated cold-load harness.

No Root Patch, installation, local/source build, or accelerated reboot authorized. GitHub Actions compile/build/package remains suspended until explicit quota-unblocked confirmation.