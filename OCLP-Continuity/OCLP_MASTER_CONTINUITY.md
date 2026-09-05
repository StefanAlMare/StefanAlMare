# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BR_FULL_PASS_CLAMP_3802_TO_32023_ESCAPE_HATCHES_D97BS_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Target / current machine state
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA after saved/sealed snapshot restore;
- `-igfxvesa` active;
- no active Root Patch.

End goal: stable hardware acceleration + usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Golden authority
Working Golden OCLP lineage: upstream `dortania/OpenCore-Legacy-Patcher`, exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`, PatcherSupportPkg `1.9.6`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.
Golden primary Metal request-builder: `0x7FF80D370756..0x7FF80D370C28`, `[arg1+0x20] -> llvmVersion`, `[arg2+0x08] -> requestType`, `[arg2+0x18] -> timeout`, alternate requestType 9.
Golden runtime naturally uses both 3802 and 32023 donor lanes and reaches Metal compositor success.

## Durable architecture
Historical accepted true-five: `P1 + P2b + P3 + AIR00 + D34`. P6/P7 sufficiency NEGATIVE; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Required current architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Legacy `12.5-3802-23` can be bounded to `MTLCompilerService.xpc` only. Legacy `13.2.1-24/Versions/A/Metal` shadows native cache-resident Metal and is forbidden. Historical native-Metal + legacy-XPC/private-compilers + true-five already failed; do not repeat unchanged.

Exact target Metallib authority: local `MetallibSupportPkg-26.6.2-25G82`, package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact Tahoe map 182 entries.

## D97BJ / D97BK closure
D97BJ Root Patch execution itself passed. Accelerated boots were not kernel panics: userspace/WindowServer reached, then full legacy Metal.framework removed Tahoe `_MTL4*` superclass surface and launchd performed orderly shutdown.

Permanent NEGATIVE: `D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## D97AA runtime generation fact
Failing Tahoe accelerated cohort: 12/12 observed service requests `llvmVersion=32023`; 3802=0; other=0. Golden naturally uses both 3802 and 32023 lanes.

## Native Tahoe producer closure
Native Tahoe Metal cache image starts at `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`. Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`. Native `_MTL4*` / `IOGPUMetal4*` surface is present.

Tahoe Builder A `0x7FF80F635510..0x7FF80F635A4D`: llvmVersion `[arg1+0x1C]`, requestType helper `+0xAC`, timeout `+0xB8`, three direct E8 callers.

Tahoe Builder B `0x7FF80F663CA9..0x7FF80F66492C`: llvmVersion `[arg1+0x38]`, same requestType/timeout helper family via subordinate object, no direct E8 callers.

Both alternate requestType paths use immediate 9.

Native generation census: 3802 raw 11 / validated 9; 31001 zero; 32023 raw 10 / validated 10. Do not globally replace `32023 -> 31001`; do not transplant Golden `+0x20` offsets.

## Shared generation architecture
3802 initializer -> singleton global `0x7FF843D65C90`; 32023 initializer -> singleton global `0x7FF843D65CB0`. Selector `0x7FF80F5EFFEB..0x7FF80F5F009C` distinguishes 3802/3902/32023/32024.

Generation-aware constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88` uses shared accessor `0x7FF80F5E16C3`, stores EAX into discriminator `-0x27C`, optionally overrides from `[arg1+0x138]`, and builds layouts containing `+0x1C/+0x20/+0x38` writes.

D97BQ proved selector generation input is ABI arg2/RSI. All six validated selector callers do `call accessor -> movl %eax,%esi -> call selector`. Common boundary is therefore STATIC PROVEN:
`generation-bearing object -> shared accessor -> constructor discriminator / native selector`.

## D97BR FULL PASS — current frontier
Returned bundle `OCLP7_D97BR_GENERATION_ACCESSOR_CFG_AND_CLAMP_20260905_232748.zip`:
- bytes `4515`;
- SHA256 `1b3d252e8824f9e531980afdd1f9ca93b06d2c83e6e2bf7bb18ded44f90d22f7`.

Accessor `0x7FF80F5E16C3..0x7FF80F5E1778` CFG is complete for direct branches: 57 edges, all 50 instructions reachable, one normal return and one external tail.

Exact clamp path:
`cmp EAX,32024; ECX=32023; cmovl ECX,EAX`.

Thus `3802 -> 32023` on that path is `SEMANTIC_PROVEN`.

Accessor output classes:
1. clamp path: values below 32024 are floored to exact 32023;
2. nonzero global override `0x7FF843853E18` bypasses clamp and returns directly; current static value 0; single writer function `0x7FF80F612AF4..0x7FF80F612B0E`, store at `0x7FF80F612B06`;
3. alternate path defaults to 32023 but may tail to `0x7FF80F5E15C6..0x7FF80F5E1624`, which returns a lazy global.

Two indirect generation-source calls remain at `0x7FF80F5E1713` and `0x7FF80F5E1732`.

Do NOT yet claim accessor-wide suppression of 3802. Global override and lazy-tail semantics remain open.

## CURRENT ACTION — D97BS
Remain unpatched in Tahoe VESA.

Run only `OCLP7_D97BS_accessor_escape_hatches.sh`.
Pinned identity:
- bytes `20670`;
- SHA256 `4aa35c3afd3774f3385e70e4147cf80e942c96e3a3c0608fac5d2ad328300d9d`.

D97BS must close global override writer/callers, resolve accessor indirect call-slot targets where possible, identify tail lazy globals and every writer/source, and classify whether any escape hatch can supply 3802. Absence of a 3802 immediate alone is not proof of semantic impossibility.

No Root Patch and no accelerated reboot are authorized.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until native Tahoe Metal4 remains authoritative, no legacy main Metal shadows it, legacy compiler ingress remains bounded, exact 25G82 Metallib handling is intact, and producer normalization is statically complete across every relevant accessor/request path.

GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback.