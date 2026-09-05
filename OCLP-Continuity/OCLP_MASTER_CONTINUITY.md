# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CB_ATOMIC_REMAP_STRUCTURAL_PASS_DLOPEN_SIGSEGV_COLD_HOST_TOOLING_FAIL_D97CBV2_NEXT.md`
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

## D97CB — atomic remap structural PASS; load harness unresolved
Returned Terminal log (no ZIP because fail-closed occurred before packaging):
- bytes `101328`;
- SHA256 `46797ea02b54ffdc728fe3203ec4ebc5c83956e6b2c812827dbf675cc23ee8e8`.

D97CB exact atomic temp remap PASS:
- set `SG_READ_ONLY` on `__DATA_CONST`;
- physical `__DATA_DIRTY` payload -> `0x35C000`, `__DATA` -> `0x361000`, `__LINKEDIT` remains `0x36E000`;
- complete command-block order becomes `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all segment/section VM addresses preserved;
- exactly five section file offsets rewritten;
- exactly 3652 symtab `n_sect` values remapped with D97CA counts;
- pre-sign diff count `40655`, outside audited domains `0`;
- `file`, `otool -l`, `otool -L` PASS.

Markers reached:
- `D97CB_ATOMIC_REMAP_STRUCTURAL=PASS`;
- `D97CB_VM_ADDRESS_PRESERVATION=PASS`;
- `D97CB_SECTION_FILEOFF_REMAP=PASS`;
- `D97CB_SYMTAB_N_SECT_REMAP=PASS`;
- `D97CB_DIFF_DOMAIN=PASS`.

Unsigned and ad-hoc-signed remapped images both pass `dlopen_preflight`, but Python child actual `dlopen` returns `RC=-11` (SIGSEGV) with no earlier explicit dyld validation rejection. Because Python already has native Metal loaded, standalone loadability remains `NOT_YET_PROVEN`.

Cold-host attempt was invalid: the chosen pinned `ipsw` executable itself preloads native Metal in its control run. Collector correctly stopped at `FAIL=COLD_HOST_PRELOADS_METAL`; no remapped-Metal cold injection was executed. This is tooling-only and does not invalidate the remap.

Authoritative classifications:
- `D97CB_ATOMIC_SEGMENT_ORDER_REMAP=STRUCTURAL_STATIC_PROVEN`;
- `D97CB_REMAP_UNSIGNED_SIGNED_PREFLIGHT=PASS`;
- `D97CB_REMAP_UNSIGNED_SIGNED_CHILD_DLOPEN=SIGSEGV_NEGATIVE`;
- `D97CB_REMAP_STANDALONE_LOADABILITY=NOT_YET_PROVEN`;
- `D97CB_COLD_HOST_IPSW=TOOLING_INVALID_PRELOADS_NATIVE_METAL`.

## CURRENT ACTION — D97CB-v2
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97CB_v2_atomic_remap_cold_host.sh`:
- bytes `32510`;
- SHA256 `811935f3b31fb863f1fdc763b70b11b6d3421e0f064c805c7e09a12dafdb3781`.

D97CB-v2 must reproduce the identical D97CB remap and alter only the cold-host harness:
1. copy `/usr/bin/true` into `/private/tmp`;
2. remove the copied Apple signature, then ad-hoc sign and strict-verify the copy;
3. require baseline exit 0 with no Metal and no `libbz2` in dyld trace;
4. positively prove `DYLD_INSERT_LIBRARIES` is honored by injecting `/usr/lib/libbz2.1.0.dylib`, requiring exit 0 and visible libbz2 path;
5. only then inject the signed remapped Metal with `DYLD_PRINT_LIBRARIES`, `DYLD_PRINT_SEGMENTS`, `DYLD_PRINT_INITIALIZERS`;
6. classify separately whether target path is observed/mapped and whether the host exits 0 or crashes;
7. if target path appears but process fails, stop at that later init/runtime frontier and do not apply D97BV;
8. only if remapped original target path appears and process exits 0 may D97BV be re-audited/applied to a second temp copy;
9. delete all transient binaries and package TXT/JSON only.

No Root Patch, installation, or accelerated reboot authorized.
GitHub Actions compile/build/package remains suspended until explicit quota-unblocked confirmation.
