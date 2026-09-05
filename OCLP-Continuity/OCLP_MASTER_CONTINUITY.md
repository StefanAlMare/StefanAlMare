# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BZ_SGRO_GATE_PASS_NEXT_DATA_DIRTY_VM_ORDER_D97CA_FILE_LAYOUT_SWAP_NEXT.md`
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

## Golden authority
Pinned Golden OCLP: upstream `dortania/OpenCore-Legacy-Patcher`, exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`, PatcherSupportPkg `1.9.6`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.
Golden primary request builder: `0x7FF80D370756..0x7FF80D370C28`, `[arg1+0x20] -> llvmVersion`, `[arg2+0x08] -> requestType`, `[arg2+0x18] -> timeout`, alternate requestType `9`.
Golden runtime naturally uses both 3802 and 32023 lanes and reaches compositor success.

## Durable architecture / prohibitions
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; P6/P7 insufficient; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Current required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Retained prohibitions:
- never install legacy `13.2.1-24/Versions/A/Metal` over cache-resident Tahoe Metal;
- do not globally rewrite `32023 -> 31001`;
- do not transplant Golden `+0x20` into Tahoe's native `+0x1C/+0x38` layouts;
- do not globally force `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- do not repeat historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Legacy `12.5-3802-23` may be bounded to `MTLCompilerService.xpc` only. Exact target Metallib authority remains local `MetallibSupportPkg-26.6.2-25G82`, package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact Tahoe map 182 entries.

## D97BJ/BK whole-Metal closure
D97BJ Root Patch execution passed, but full legacy Metal.framework removed Tahoe `_MTL4*` superclass ABI. Accelerated boots reached userspace/WindowServer, then critical services failed and launchd shut down.

Permanent NEGATIVE:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## Native Tahoe producer closure
Native Tahoe Metal starts at `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`. Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`. Native `_MTL4*` / `IOGPUMetal4*` surface is present.

Tahoe Builder A `0x7FF80F635510..0x7FF80F635A4D`: llvmVersion `[arg1+0x1C]`, requestType helper `+0xAC`, timeout `+0xB8`.
Tahoe Builder B `0x7FF80F663CA9..0x7FF80F66492C`: llvmVersion `[arg1+0x38]`, same helper family via subordinate object.
Both alternate requestType paths use immediate `9`.

Native generation census: 3802 present, 31001 absent, 32023 present.
Retained D97AA runtime fact: failing accelerated cohort delivered 12/12 requests as exact `llvmVersion=32023`, 3802=0, other=0.

## Shared accessor / suppression closure
Shared generation accessor: `0x7FF80F5E16C3..0x7FF80F5E1778`.
Generation selector: `0x7FF80F5EFFEB..0x7FF80F5F009C`, generation input ABI arg2/RSI. All six validated selector callers use `call accessor -> movl %eax,%esi -> call selector`.

D97BT proved default-environment accessor-wide suppression of 3802:
- primary path floors to 32023;
- lazy fallbacks floor to 32023 or 32024;
- sole bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`, current/default value zero.

Classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BV selective adapter — static-semantic FULL PASS
Exact accessor patch window:
- `0x7FF80F5E1719..0x7FF80F5E1726`;
- preimage `3d187d0000b9177d00000f4cc1`;
- no incoming branch into window interior.

Safe executable inter-section cave:
- `0x7FF80F47E560..0x7FF80F47E630`;
- 208 zero bytes;
- outside Mach-O sections/header/load commands;
- zero function-start, direct branch-target and decoded RIP-target hits.

Exact adapter bytes:
- site `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`.

Semantics: exact input 3802 is preserved; every non-3802 input executes Tahoe's original floor unchanged.
Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 / D97BX sparse-analysis closure
D97BW-v2 proved sparse reconstruction can preserve native code/Metal4 and exact D97BV 23-byte bounded diff. Structural parsers pass, but the sparse mirror is analysis-only.

D97BX proved unsigned/signed preflight and ad-hoc signing PASS, but real child `dlopen` fails identically for original and D97BV sparse mirrors because shared-cache segment geometry is not standalone-loadable. D97BV is not the regression; signing is not the blocker.

## D97BY real DSC export
Bundle `OCLP7_D97BY_REAL_DSC_SINGLE_IMAGE_EXPORT_20260906_012127.zip`, SHA256 `c2517f1a3758fcbdabe0ab033a7bc7f07385aadf6f13f9369bb1cecb10fd2b53`.

Pinned extractor provenance:
- `blacktop/ipsw v3.1.713`;
- checksum manifest SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`;
- macOS x86_64 tarball SHA256 `7f5719d0a2a53996fca4dba4826aa015a6ddecfbba822a21e92400a80da7f1ab`;
- transient `ipsw` SHA256 `d02498ccd0a88e0afc461cbfd5f4a9df34a6194386595226b10a9a46fe078d6a`.

RAW and `--slide` export RC 0; each produces a compact 5,722,944-byte Mach-O preserving exact native Tahoe `__text` (relative `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`) and exact native Metal4 counts.

Both pass unsigned/signed preflight and ad-hoc verification. Real `dlopen` first rejects both with:
`__DATA_CONST segment missing SG_READ_ONLY flag`.

## D97BZ — SG_READ_ONLY gate PASS; next dyld gate identified
Returned bundle:
`OCLP7_D97BZ_SG_READ_ONLY_METADATA_GATE_20260906_013542.zip`
- bytes `4013`;
- SHA256 `efe3bc569e6be515a6a1d7d2742589785e4329527b2a10656626169fb70952ee`;
- TXT SHA256 `65696bca289f6d9e9a64f556a2b7196ae47e03454a00dedaccf0c110f17df6f0`;
- JSON SHA256 `289f8afec996ea29024ff36dbebd13406597b3db70bc05524c5a44b13d019c1c`.

D97BZ revalidated exact RAW identity and changed only `__DATA_CONST` segment flags at file offset `0x50C`:
`0x0 -> 0x10 (SG_READ_ONLY)`.
Only one byte differed pre-sign and zero bytes differed outside the 32-bit flags word.

After the flag fix:
- unsigned preflight PASS;
- ad-hoc signing + strict verify PASS;
- signed preflight PASS;
- previous missing-SG_READ_ONLY rejection disappears.

Authoritative classification:
`D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`.

Real child `dlopen` now stops at the next exact validation:
`segment '__DATA_DIRTY' vm address out of order`.
No coalesced-load ambiguity exists: handle NULL, image count unchanged, temp target absent before/after.

Current export order/file order:
`__TEXT -> __DATA_CONST -> __DATA -> __DATA_DIRTY -> __LINKEDIT`.
VM order:
`__TEXT -> __DATA_CONST -> __DATA_DIRTY -> __DATA -> __LINKEDIT`.

Apple dyld source confirms non-cache dyld-managed images are checked so segment load-command order must match both file-content order and VM order. A load-command-only permutation would repair VM order but break fileoff order.

## Critical correction before any physical segment swap
A full `__DATA_DIRTY`/`__DATA` segment-command reorder changes segment indices and section ordinals. Exported `__LINKEDIT` retains dyld rebase/bind streams and symbol/relocation metadata that can encode those indices/ordinals. Therefore a blind physical/load-command swap is not semantically closed.

Do not mutate layout until the complete order-sensitive metadata surface is enumerated.

## CURRENT ACTION — D97CA read-only dependency audit
Remain unpatched in Tahoe VESA.
Run only:
`OCLP7_D97CA_segment_order_dependency_audit.sh`
- bytes `24666`;
- SHA256 `237b1f93cb1255cb0d5d56aeeb3db7442971e69c03a5a6706f6f66ba73a991ce`.

D97CA reproduces the pinned RAW export and performs no binary mutation. It must census:
1. load-command/segment indices and section ordinal ranges;
2. proposed old->new segment/section maps for a possible `__DATA_DIRTY`/`__DATA` reorder;
3. parsed dyld rebase/bind/weak/lazy segment-index references;
4. symtab `n_sect` references;
5. DYSYMTAB and per-section relocation section-ordinal references;
6. split-seg/chained-fixup or other explicit order-sensitive unknown structures;
7. exact count of all remaps a coherent repair would require.

Only if this surface is bounded may a later experiment reorder physical payload/load commands while preserving all VM/section addresses and coherently remapping every affected metadata reference.

No Root Patch, installation, source build or accelerated reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.