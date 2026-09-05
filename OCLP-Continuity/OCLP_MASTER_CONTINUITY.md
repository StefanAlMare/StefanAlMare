# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BP_FULL_PASS_SHARED_GENERATION_ACCESSOR_SELECTOR_ARG_CORRECTION_D97BQ_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact current checkpoint above;
6. retrospective/history when strategic context is needed.

## Target / current machine state
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA after saved/sealed snapshot restore;
- `-igfxvesa` active;
- no active Root Patch.

End goal: stable hardware acceleration + usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Exact Golden authority
Original working OCLP lineage:
- upstream `dortania/OpenCore-Legacy-Patcher`;
- commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`, PatcherSupportPkg `1.9.6`;
- root-patch manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector:
- `3802 -> Versions/3802`;
- `31001 -> Versions/32023`.

Golden primary Metal request-builder:
- `0x7FF80D370756..0x7FF80D370C28`;
- `[ABI arg1 +0x20] -> llvmVersion`;
- `[ABI arg2 +0x08] -> requestType`;
- `[ABI arg2 +0x18] -> timeout`;
- `[ABI arg2 +0x70]` sandbox gate;
- alternate requestType immediate `9`.

Golden runtime naturally uses both 3802 and 32023 donor lanes and reaches Metal compositor success.

## Durable functional/methodology authority
Historical accepted true-five:
`P1 + P2b + P3 + AIR00 + D34`.

P6/P7 sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated. D34 cave `0xEF8..0xEFE` protected.

Architecture principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## Exact 25G82 Metallib authority
- package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- local tree `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
- Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact Tahoe map 182 entries.

## D97BJ / D97BK closure
D97BJ Root Patch execution itself passed, including Haswell kexts, exact metallibs and AuxKC.

Accelerated boots were not kernel panics. D97BK proved userspace/WindowServer reached, then critical services died because full legacy `13.2.1-24/Metal.framework` removed Tahoe `_MTL4*` superclass surface; launchd committed orderly shutdown.

Permanent NEGATIVE:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## D97BL selective-hybrid authority
Required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Donor collision closure:
- `12.5-3802-23/Metal.framework` can be bounded to legacy `MTLCompilerService.xpc` only;
- `13.2.1-24/Versions/A/Metal` shadows cache-resident native Metal and is forbidden.

Historical native-Metal + legacy-XPC/private-compilers + true-five already failed; do not repeat unchanged.

## D97AA runtime generation fact
Failing Tahoe accelerated cohort:
- 12/12 observed service requests `llvmVersion=32023`;
- 3802=0;
- other=0.

Golden naturally uses both 3802 and 32023 lanes.

## D97BM / D97BN native producer closure
Native Tahoe Metal:
- cache path `/System/Library/Frameworks/Metal.framework/Versions/A/Metal`;
- start `0x7FF80F47D000`;
- cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Native MTLCompilerService SHA256:
`4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.

Native `_MTL4*` / `IOGPUMetal4*` class surface is present.

Tahoe Builder A `0x7FF80F635510..0x7FF80F635A4D`:
- llvmVersion `[arg1+0x1C]`;
- requestType helper `+0xAC` from arg2 object;
- timeout helper `+0xB8`;
- three direct E8 callers, two source arg1 from `[incoming+0x38]`.

Tahoe Builder B `0x7FF80F663CA9..0x7FF80F66492C`:
- llvmVersion `[arg1+0x38]`;
- requestType/timeout same helper families via subordinate object;
- no direct E8 callers.

Both alternate requestType paths use immediate `9`.

Native generation census:
- 3802 raw 11 / validated 9;
- 31001 raw 0 / validated 0;
- 32023 raw 10 / validated 10.

Do not globally replace `32023 -> 31001` and do not transplant Golden `+0x20` offsets.

## D97BO generation architecture
3802 initializer stores singleton global `0x7FF843D65C90`.
32023 initializer stores singleton global `0x7FF843D65CB0`.
Selector `0x7FF80F5EFFEB..0x7FF80F5F009C` explicitly distinguishes 3802/3902/32023/32024 and returns corresponding singleton.

Generation-aware constructor candidate:
`0x7FF80F4A5DF8..0x7FF80F4A7A88`.

It compares generation-like local `-0x27C` against 32023 and constructs layouts containing writes to `+0x1C`, `+0x20`, and `+0x38`. No simple direct generation-function/global -> builder-field writer edge was found.

## D97BP FULL PASS — shared generation accessor frontier
Returned bundle:
`OCLP7_D97BP_CONSTRUCTOR_SELECTOR_DATAFLOW_20260905_230558.zip`
- bytes `20273`;
- SHA256 `22258abc2b4ce017cb77ae20f1c93baff4377428d18642b2e80f18eb6ef541d2`.

All D97BP final markers passed; no mutation.

### Constructor discriminator source
Constructor calls exact function `0x7FF80F5E16C3` on a generation-bearing object and stores returned EAX into local `-0x27C`.
Original constructor arg1 is saved; `[arg1+0x138]` optionally overrides the accessor-derived discriminator when nonzero. Final discriminator is compared to exact 32023.

Classification:
`D97BP_CONSTRUCTOR_GENERATION_DISCRIMINATOR_SOURCE=SHARED_ACCESSOR_WITH_OPTIONAL_ARG1_PLUS_0x138_OVERRIDE_STATIC_PROVEN`.

### Shared generation accessor
Multiple selector caller contexts independently show:
`object -> call 0x7FF80F5E16C3 -> movl %eax,%esi -> call selector 0x7FF80F5EFFEB`.

The same accessor is therefore used by the constructor generation-discriminator path and immediately upstream of the native generation selector.

Classification:
`D97BP_SHARED_GENERATION_ACCESSOR_BETWEEN_CONSTRUCTOR_AND_SELECTOR=STATIC_PROVEN`.

### Selector-caller tracing correction
D97BP scripted RDX back-slice is retired for generation semantics. Raw contexts show accessor return copied into ESI immediately before selector call. Exact selector entry-ABI propagation to its compare register remains pending D97BQ.

Classification:
`D97BP_SELECTOR_GENERATION_RDX_BACKSLICE=TOOLING_WRONG_REGISTER_RETIRED`.

### No simple direct callgraph bridge
- constructor direct E8 caller count 0;
- selector direct E8 callers 6;
- no selector->constructor, selector->Builder-A, constructor->Builder-A/B direct-E8 path within depth 8;
- caller-set intersections 0.

Thus object/dataflow—not simple direct call graph—is the active frontier.

## D97BQ collector
`OCLP7_D97BQ_shared_generation_accessor_selector_abi.sh`
- bytes `22773`;
- SHA256 `228978fc900358958963c25acf1bf47add6fd7a05b8ba79ed8f2f25bc1746f25`.

It maps accessor return source, selector ABI argument, corrected selector caller back-slices, accessor caller result stores, constructor shared-accessor use/override, and Builder-A wrapper ancestry.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only D97BQ and return its ZIP.

No Root Patch and no accelerated reboot are authorized.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until:
1. native Tahoe Metal4 remains authoritative;
2. legacy main Metal is absent from proposed root;
3. legacy service/compiler ingress remains bounded;
4. exact 25G82 Metallib handling remains intact;
5. producer normalization is statically complete across relevant request families;
6. test adds new causal information beyond historical true-five.

## Execution contract
GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback.