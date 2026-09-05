# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BZ_SGRO_GATE_PASS_D97CA_REMAP_SURFACE_ENUMERATED_D97CB_NEXT.md`
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
Historical accepted functional lineage remains `P1 + P2b + P3 + AIR00 + D34`; P6/P7 insufficient; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Current required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Retained prohibitions:
- never install legacy `13.2.1-24/Versions/A/Metal` over cache-resident Tahoe Metal;
- no global `32023 -> 31001` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- no repeat of historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Exact target Metallib authority: local `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact map 182 entries.

## Whole legacy Metal closure
D97BJ Root Patch execution passed, but D97BK proved full legacy Metal.framework removes Tahoe `_MTL4*` superclass ABI and causes userspace shutdown after WindowServer starts.
Permanent NEGATIVE: `D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## Native Tahoe producer / accessor closure
Native Tahoe Metal cache base `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`; native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`. Native generation census contains 3802 and 32023, no 31001.
Shared accessor `0x7FF80F5E16C3..0x7FF80F5E1778`; all six validated selector callers source generation from it.
D97BT proved default-environment accessor-wide suppression of 3802: primary -> 32023; lazy fallbacks -> 32023/32024; sole bypass explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`, current/default zero.
Classification: `D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.
Retained D97AA runtime: failing cohort 12/12 `llvmVersion=32023`, 3802=0.

## D97BV selective adapter
Exact patch window `0x7FF80F5E1719..0x7FF80F5E1726`, preimage `3d187d0000b9177d00000f4cc1`.
Safe unsectioned executable cave `0x7FF80F47E560..0x7FF80F47E630`, 208 zero bytes.
Exact adapter:
- site `3dda0e00007406e93bcee9ff90`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`.
Semantics: preserve exact 3802; every non-3802 input executes Tahoe original floor unchanged.
Classification: `D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 / D97BX sparse closure
Sparse reconstruction preserves native code/Metal4 and exact D97BV diff, but is analysis-only. D97BX: unsigned/signed preflight and ad-hoc signing PASS; real child `dlopen` fails identically original/patched due shared-cache standalone mapping geometry. D97BV is not the regression; signing is not the blocker.

## D97BY real DSC export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` real export both RC 0, each 5,722,944 bytes, preserving exact native Tahoe `__text` rel `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a` and exact native Metal4 counts.
Unsigned/signed preflight and ad-hoc signing pass. Real child `dlopen` first rejects with `__DATA_CONST segment missing SG_READ_ONLY flag`.

## D97BZ — SG_READ_ONLY gate passed
D97BZ changed only exported RAW `__DATA_CONST` flags at file offset `0x50C`: `0x0 -> 0x10`. Pre-sign diff was exactly one changed byte, zero outside the 32-bit flags word. Previous dyld rejection disappeared.
New exact real child `dlopen` failure: `segment '__DATA_DIRTY' vm address out of order`.
No coalescing ambiguity: handle NULL, target temp path absent, image count unchanged.
Classifications:
- `D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`;
- `D97BZ_REAL_DLOPEN=NEGATIVE_NEXT_GATE_DATA_DIRTY_VM_ADDRESS_OUT_OF_ORDER`.

## D97CA — segment-order dependency surface fully enumerated
Bundle `OCLP7_D97CA_SEGMENT_ORDER_DEPENDENCY_AUDIT_20260906_014835.zip`:
- bytes `84192`;
- SHA256 `90a9edb0abc2832a86db5c3d54c0429894844e56d6f258a91a7de93dfb40e1f0`.

Current RAW load/file order:
`__TEXT -> __DATA_CONST -> __DATA -> __DATA_DIRTY -> __LINKEDIT`.
VM order:
`__TEXT -> __DATA_CONST -> __DATA_DIRTY -> __DATA -> __LINKEDIT`.
Apple dyld source confirms a non-cache dyld-managed image requires load-command order to match both file order and VM order.

Exact D97CA geometry:
- `__DATA`: index 2, VM `0x7FF843D590C0`, fileoff `0x35C000`, filesize `0xD000`, command `0x9C0..0xB98`, sections 30..34;
- `__DATA_DIRTY`: index 3, VM `0x7FF84384F510`, fileoff `0x369000`, filesize `0x5000`, command `0xB98..0xD20`, sections 35..38;
- `__LINKEDIT`: fileoff `0x36E000`.
The two data payloads are contiguous and total `0x12000`, so a physical reorder can keep `__LINKEDIT` fileoff unchanged.

Required new order: `__DATA_DIRTY` then `__DATA`.
Segment-index map: old 2 -> new 3; old 3 -> new 2.
Section ordinal map:
- old 30..34 -> new 34..38;
- old 35..38 -> new 30..33.

D97CA census:
- dyld rebase/bind/weak/lazy segment-index rewrites needed: **0**;
- relocation section-ordinal rewrites: **0**;
- `LC_DYLD_CHAINED_FIXUPS`: absent;
- `LC_SEGMENT_SPLIT_INFO`: absent;
- unknown order-sensitive loads: **0**;
- file-backed section offsets requiring rewrite: **5**;
- symtab `n_sect` rewrites: **3652**.

Affected symbol counts:
`30->34` 2236; `31->35` 404; `32->36` 305; `33->37` 127; `34->38` 9; `35->30` 440; `36->31` 25; `37->32` 101; `38->33` 5.

Classification: `D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## CURRENT ACTION — D97CB
Remain unpatched in Tahoe VESA.

Next transient collector must reproduce exact RAW export and perform one atomic temporary remap only:
1. retain every segment VM address and every section VM address unchanged;
2. set/retain `SG_READ_ONLY` on `__DATA_CONST`;
3. physically place `__DATA_DIRTY` payload at `0x35C000` and `__DATA` payload at `0x361000`; keep `__LINKEDIT=0x36E000`;
4. swap the complete `__DATA_DIRTY` / `__DATA` segment-command blocks so load-command order becomes VM/file order;
5. update their two segment fileoffs and exactly five file-backed section offsets from VM-relative positions;
6. remap exactly the 3652 affected symtab `n_sect` bytes using the proven ordinal map;
7. prove all pre-sign diffs fall only in audited domains;
8. verify parser/order/section/symtab invariants, then unsigned and ad-hoc-signed real child `dlopen`;
9. only if the explicit temp path truly loads may D97BV be re-audited/applied to a second temp copy;
10. stop at the next exact dyld/runtime error; do not automatically alter VM addresses/section VM addresses or reconstruct missing fixup streams.

No Root Patch, installation, or accelerated reboot authorized.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
