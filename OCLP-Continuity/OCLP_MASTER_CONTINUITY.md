# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BY_REAL_EXPORT_EXACT_TEXT_DLOPEN_SG_READ_ONLY_NEGATIVE_D97BZ_NEXT.md`
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
- do not transplant Golden `+0x20` layout into Tahoe's two native layouts;
- do not globally force `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- do not repeat historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Legacy `12.5-3802-23` may be bounded to `MTLCompilerService.xpc` only. Exact target Metallib authority remains local `MetallibSupportPkg-26.6.2-25G82`, package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact Tahoe map 182 entries.

## D97BJ/BK whole-Metal closure
D97BJ Root Patch execution itself passed. Accelerated boots were not kernel panics: userspace and WindowServer were reached, then full legacy Metal.framework removed Tahoe `_MTL4*` superclass surface and launchd performed orderly shutdown.

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
- no incoming branch into the window interior.

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

## D97BW-v2 / D97BX — sparse analysis container closure
D97BW-v2 proved sparse reconstruction can preserve exact native bytes, Metal4 surface and the exact 23-byte D97BV diff. Structural parsers pass, but this is only an analysis container.

D97BX proved:
- unsigned and signed `dlopen_preflight` PASS for original and D97BV sparse mirrors;
- ad-hoc signing and strict verification PASS;
- real child `dlopen` NEGATIVE identically for original and patched due shared-cache segment mapping geometry;
- D97BV is not the loadability regression;
- signing is not the current blocker.

Do not deploy the sparse mirror.

## D97BY — real DSC single-image export
Returned bundle:
`OCLP7_D97BY_REAL_DSC_SINGLE_IMAGE_EXPORT_20260906_012127.zip`
- bytes `748714`;
- SHA256 `c2517f1a3758fcbdabe0ab033a7bc7f07385aadf6f13f9369bb1cecb10fd2b53`;
- TXT SHA256 `33835943e2bf117c945b064aa626dd4339db5a7d44ae9e18cf838c38df7c84c4`;
- JSON SHA256 `3fcd4a1413b330249da185ce1ad073423e91f2b7e3cc2e77603893e9dbdb84e2`.

Pinned extractor provenance:
- `blacktop/ipsw v3.1.713`;
- checksum manifest SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`;
- selected macOS x86_64 tarball SHA256 `7f5719d0a2a53996fca4dba4826aa015a6ddecfbba822a21e92400a80da7f1ab`;
- transient ipsw executable SHA256 `d02498ccd0a88e0afc461cbfd5f4a9df34a6194386595226b10a9a46fe078d6a`.

RAW and `--slide` exports both returned RC 0 and produced compact 5,722,944-byte Mach-O files. Both preserve exact native `__text` (`EXACT_NATIVE=True`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`) and exact native Metal4 string counts.

Exporter geometry keeps shared-cache VM addresses while compacting fileoffs:
- `__TEXT` VM `0x7FF80F47D000`, fileoff `0x0`;
- `__DATA_CONST` VM `0x7FF84119DCD0`, fileoff `0x2EC000`;
- `__DATA` VM `0x7FF843D590C0`, fileoff `0x35C000`;
- `__DATA_DIRTY` VM `0x7FF84384F510`, fileoff `0x369000`;
- `__LINKEDIT` VM `0x7FF880000000`, fileoff `0x36E000`.

For RAW and SLIDE, unsigned preflight PASS, ad-hoc signing/strict verification PASS, signed preflight PASS. Real child `dlopen` fails identically with exact first rejection:
`__DATA_CONST segment missing SG_READ_ONLY flag`.

Thus:
- `D97BY_REAL_EXPORT_RAW_AND_SLIDE=PASS`;
- `D97BY_REAL_EXPORT_NATIVE___TEXT_AND_METAL4_PRESERVATION=STATIC_PROVEN`;
- `D97BY_REAL_DLOPEN_RAW_SLIDE=NEGATIVE_IDENTICAL_MISSING_SG_READ_ONLY`;
- `D97BY_SLIDE_OPTION_LOADABILITY_IMPROVEMENT=NEGATIVE`;
- `D97BY_CODE_SIGNING_IS_FIRST_BLOCKER=NEGATIVE`.

No D97BV patch was applied because no original extracted baseline was real-dlopen loadable.

Public `go-macho` exporter source confirms compact fileoff remapping while preserving segment VM addresses; the shown `optimizeLoadCommands()` path does not add `SG_READ_ONLY` to `__DATA_CONST`.

## CURRENT ACTION — D97BZ metadata-only SG_READ_ONLY gate
Remain unpatched in Tahoe VESA.

Next transient test must:
1. reproduce only the RAW real export using the same pinned/verified `ipsw` release;
2. record all `LC_SEGMENT_64` flags;
3. create one temporary copy changing only the `__DATA_CONST` segment flags word by OR-ing `SG_READ_ONLY (0x10)`;
4. prove pre-sign diff is confined to that 32-bit load-command field;
5. test unsigned preflight + real child `dlopen`;
6. ad-hoc sign/strict verify and repeat preflight + real child `dlopen`;
7. if this yields a true loadable original baseline, then and only then re-audit/apply D97BV on a second temp copy;
8. if dyld reveals another geometry requirement, stop there; do not auto-move segment or section VM addresses;
9. delete extractor/archive/Apple binaries; package TXT+JSON only.

No Root Patch, installation, or accelerated reboot authorized.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
