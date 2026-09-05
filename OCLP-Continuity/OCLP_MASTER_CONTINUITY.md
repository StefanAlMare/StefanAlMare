# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BW_TOOLING_GUARD_SPARSE_MIRROR_V2_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Golden authority
Pinned Golden OCLP: upstream `dortania/OpenCore-Legacy-Patcher`, commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`, PatcherSupportPkg `1.9.6`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.
Golden primary request builder: `0x7FF80D370756..0x7FF80D370C28`, `[arg1+0x20] -> llvmVersion`, `[arg2+0x08] -> requestType`, `[arg2+0x18] -> timeout`, alternate requestType `9`.
Golden runtime naturally uses both 3802 and 32023 lanes and reaches compositor success.

## Durable architecture
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; P6/P7 insufficient; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Required current architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Legacy `12.5-3802-23` can be bounded to `MTLCompilerService.xpc` only. Legacy `13.2.1-24/Versions/A/Metal` shadows native cache Metal and is forbidden. Historical native-Metal + legacy-XPC/private-compilers + true-five already failed; do not repeat unchanged.

Exact target Metallib authority: local `MetallibSupportPkg-26.6.2-25G82`, package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact Tahoe map 182 entries.

## Native Tahoe producer closure
Native Tahoe Metal starts at `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`. Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`. Native `_MTL4*` / `IOGPUMetal4*` surface is present.

Tahoe Builder A `0x7FF80F635510..0x7FF80F635A4D`: llvmVersion `[arg1+0x1C]`, requestType helper `+0xAC`, timeout `+0xB8`.
Tahoe Builder B `0x7FF80F663CA9..0x7FF80F66492C`: llvmVersion `[arg1+0x38]`, same helper family via subordinate object.
Both alternate requestType paths use immediate `9`.

Native generation census: 3802 present, 31001 absent, 32023 present. Never globally rewrite `32023->31001` and never transplant Golden `+0x20` offsets.

## Shared accessor / suppression closure
Shared accessor: `0x7FF80F5E16C3..0x7FF80F5E1778`.
Generation selector: `0x7FF80F5EFFEB..0x7FF80F5F009C`, generation input ABI arg2/RSI. All six validated selector callers use `call accessor -> movl %eax,%esi -> call selector`.

D97BT proved default-environment accessor-wide suppression of 3802:
- primary path floors to 32023;
- lazy fallbacks floor to 32023 or 32024;
- sole bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`, current/default value zero.

Classification: `D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.
Retained runtime D97AA: failing cohort was 12/12 `llvmVersion=32023`, 3802=0.

## Selective adapter closure
Exact accessor patch window:
- `0x7FF80F5E1719..0x7FF80F5E1726`;
- preimage `3d187d0000b9177d00000f4cc1`;
- complete compare/mov/cmov instructions;
- no incoming branch into the window.

D97BV found safe executable inter-section zero padding:
- cave `0x7FF80F47E560..0x7FF80F47E630`;
- 208 bytes;
- outside all Mach-O sections;
- zero function-start, branch-target and RIP-target hits.

Exact D97BV adapter bytes:
- site `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`.

Semantics: exact input 3802 is preserved; every other input executes Tahoe's original floor unchanged. No non-3802 semantic drift.

Classification: `D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW tooling guard
D97BW revalidated native identity and recovered exact segment layout, then stopped before segment copy with `FAIL=RECONSTRUCT_SIZE_UNSAFE:881770496`.

Exact segments:
- `__TEXT`: fileoff `0xF47D000`, size `0x2EB15A`;
- `__DATA_CONST`: fileoff `0x27D91CD0`, size `0x6F820`;
- `__DATA_DIRTY`: fileoff `0x2A443510`, size `0x4938`;
- `__DATA`: fileoff `0x2A94D0C0`, size `0xCD00`;
- `__LINKEDIT`: fileoff `0x2AEFC000`, size `0x99F0000`.

Highest file end is `0x348EC000` / 881,770,496 bytes; actual segment payload is about 157 MiB. The stop is an artificial compact-buffer guard, not a reconstruction negative.

Classification: `D97BW_RESULT=PARTIAL_PASS_READONLY_TOOLING_COMPACT_BUFFER_SIZE_GUARD`.

## CURRENT ACTION — D97BW v2 sparse mirror
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BW_v2_native_metal_sparse_mirror.sh`:
- bytes `21700`;
- SHA256 `273ad9b6fcc9c7cdcc1175627e70eaabaa026c4c1ccd8ad79cf33e4e4b561ceb`.

V2 creates temporary sparse standalone mirrors only in `/private/tmp`:
1. apparent file size follows original shared-cache fileoffs;
2. Mach-O header + load commands are cloned at file offset zero for standalone parser discovery;
3. all segment bytes are written at unchanged declared fileoffs; no load-command rebasing;
4. `file`, `otool -l`, `otool -L`, load-command data bounds, native `__TEXT` identity and Metal4 strings are audited;
5. second sparse copy receives only exact D97BV site+cave bytes;
6. byte diff is proven bounded to those two ranges;
7. both Apple binaries are deleted before packaging; ZIP contains TXT+JSON only.

No source integration/build/package, Root Patch or accelerated reboot is authorized yet. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
