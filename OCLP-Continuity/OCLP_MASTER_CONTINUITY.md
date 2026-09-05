# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BV_FULL_PASS_D97BW_V2_SPARSE_STANDALONE_STRUCTURAL_PASS_D97BX_LOADABILITY_NEXT.md`
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
- unpatched VESA, `-igfxvesa` active, no active Root Patch.

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

## Durable architecture
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; P6/P7 insufficient; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Required current architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

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

## D97BV selective adapter — FULL PASS
Bundle `OCLP7_D97BV_TEXT_INTERSECTION_PADDING_CAVE_PREFLIGHT_20260906_001956.zip`, bytes `2574`, SHA256 `c39198d603664b921f57abd0d09d24ad7fc1d08c2da8f44677c86de93301cbfd`.

Patch window:
- `0x7FF80F5E1719..0x7FF80F5E1726`;
- preimage `3d187d0000b9177d00000f4cc1`;
- no incoming branch into window interior.

Safe executable inter-section cave:
- `0x7FF80F47E560..0x7FF80F47E630`;
- 208 zero bytes;
- outside all Mach-O sections/header/load commands;
- zero function-start, direct branch-target and decoded RIP-target hits.

Exact adapter bytes:
- site `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`.

Semantics: exact input 3802 is preserved; every non-3802 input executes Tahoe's original floor unchanged.
Classification: `D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 standalone sparse reconstruction — structural FULL PASS
Bundle `OCLP7_D97BW_V2_NATIVE_METAL_SPARSE_MIRROR_20260906_003847.zip`:
- bytes `4811`;
- SHA256 `180cc1e9a28c6c6a763c695305e47a05798c1d2e46c65b650c4ebbe6e4a21707`;
- TXT SHA256 `c4ccea417e412f0f1c07a9d62cf15e8ab58bf5c29dd690469be6f4b22bb54085`;
- JSON SHA256 `d07953a0f8bac305673f5c64c71fc11ec077f6946be4470de62035aa8c718242`.

Sparse mirror retained original shared-cache segment fileoffs; Mach header/load commands were cloned at offset zero only for standalone parser discovery. No load-command rebasing.

Geometry:
- apparent size `881770496` bytes / `840.921875 MiB`;
- allocated `176193536` bytes / `168.03125 MiB`;
- actual segment bytes written `165003186`.

Original reconstructed `__TEXT` SHA is exact native cache SHA. All collected load-command referenced ranges are in bounds.

External parsers on original and patched sparse mirrors:
- `file` RC 0: Mach-O 64-bit dynamically linked shared library x86_64;
- `otool -l` RC 0;
- `otool -L` RC 0 with native Metal install-name/dependencies.

Native Metal4 counts are identical before/after patch:
- `_MTL4CommandQueue` 82;
- `_MTL4CommandBuffer` 103;
- `_MTL4CommandAllocator` 49;
- `_MTL4RenderCommandEncoder` 79;
- `_MTL4ComputeCommandEncoder` 97;
- `_MTL4MachineLearningCommandEncoder` 38.

D97BV patch on temp sparse copy:
- cave fileoff `0xF47E560` / `256370016`;
- site fileoff `0xF5E1719` / `257824537`;
- exact original/patched bytes match design;
- total differing bytes `23`;
- differing bytes outside site+cave `0`.

Classifications:
`D97BW_V2_SPARSE_STANDALONE_STRUCTURAL=PASS`.
`D97BW_V2_PATCHED_SPARSE_STRUCTURAL=PASS`.
`D97BW_V2_D97BV_DIFF_BOUNDED_TO_SITE_AND_CAVE=STATIC_PROVEN`.

Codesign status on both temporary mirrors: `code object is not signed at all` (RC 1). Both Apple binaries were deleted before return; ZIP contains only TXT+JSON.

## Current unresolved gate
Structural reconstruction is proven. Runtime loadability/trust is not.
Before any installation or Root Patch plan, determine whether dyld accepts the temporary standalone mirror and whether temporary ad-hoc signing changes acceptance.

## CURRENT ACTION — D97BX
Remain unpatched in Tahoe VESA.
Next collector must:
1. rebuild original and D97BV-patched sparse native Metal only under `/private/tmp`;
2. run `dlopen_preflight` on each in a sacrificial child;
3. if preflight passes, attempt actual `dlopen` only in a sacrificial child and capture exit/dlerror;
4. create a separate temporary ad-hoc-signed patched copy only if safe, then repeat preflight/load audit;
5. record sparse allocation before/after signing;
6. delete every temporary Apple binary before returning;
7. package only TXT/JSON evidence.

No Root Patch and no accelerated reboot are authorized.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation. GitHub reads/static audit/persistence remain allowed; local compilation is not an implicit fallback.
