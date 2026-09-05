# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BT_FULL_PASS_DEFAULT_ACCESSOR_3802_SUPPRESSION_ENV_OVERRIDE_EXCEPTION_D97BU_NEXT.md`
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

D97BQ proved selector generation input is ABI arg2/RSI. All six validated selector callers do `call accessor -> movl %eax,%esi -> call selector`.

## D97BR primary clamp closure
Accessor `0x7FF80F5E16C3..0x7FF80F5E1778` has complete direct-branch CFG.
Primary path: `cmp EAX,32024; ECX=32023; cmovl ECX,EAX`.
Thus `3802 -> 32023` on the normal clamp path is `SEMANTIC_PROVEN`.

## D97BT FULL PASS — default accessor-wide 3802 suppression
Returned bundle `OCLP7_D97BT_OVERRIDE_PRODUCER_AND_LAZY_FLOOR_20260905_235137.zip`:
- bytes `3719`;
- SHA256 `6741153378f842849df5436ad3ea7734f7e79607aa33f3edbb7131cedaf18197`.

All D97BT collector final markers passed; no mutation.

### Lazy fallback
Lazy block `0x7FF80F5E1624..0x7FF80F5E16C3` has two floors:
- first stored generation = `max(candidate,32023)`;
- second stored generation = `max(candidate,32024)`.

Therefore 3802 cannot survive the lazy fallback. The collector's second `PROOF=False` was a checker limitation: it only recognized the first 32024/32023 pattern and not the second 32025/32024 pattern.

Classifications:
- `D97BT_LAZY_FIRST_WRITE_3802_TO_32023=SEMANTIC_PROVEN`;
- `D97BT_LAZY_SECOND_WRITE_3802_TO_32024=SEMANTIC_PROVEN`;
- `D97BT_LAZY_FALLBACK_PRESERVES_3802=NEGATIVE`.

### Explicit override exception
Global override writer uses exact key string:
`MTL_FORCE_MTLCOMPILER_LLVM_VERSION`.

Writer passes this key plus fallback zero into producer `0x7FF80F58A5F4`, then stores EAX into global `0x7FF843853E18`.
Producer returns fallback zero when lookup is absent; when lookup is present it forwards the returned string to a numeric parser tail. Current global value is zero, so override is disabled in the current/default environment.

This is an explicit nondefault forcing mechanism, not ordinary generation selection.

Classifications:
- `D97BT_OVERRIDE_KEY_MTL_FORCE_MTLCOMPILER_LLVM_VERSION=STATIC_PROVEN`;
- `D97BT_OVERRIDE_DEFAULT_VALUE_ZERO=STATIC_PROVEN`;
- `D97BT_CURRENT_OVERRIDE_GLOBAL_ZERO=STATIC_PROVEN`;
- `D97BT_OVERRIDE_PATH_IS_EXPLICIT_NONDEFAULT_EXCEPTION=STRUCTURAL_SEMANTIC_PROVEN`.

### Current strongest conclusion
Combining main clamp + both lazy floors:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

Do not overstate this under a deliberate `MTL_FORCE_MTLCOMPILER_LLVM_VERSION` override.

This supplies a concrete causal mechanism consistent with Tahoe D97AA runtime 12/12 = 32023 and Golden's real 3802 lane.

## CURRENT ACTION — D97BU
Remain unpatched in Tahoe VESA.

Next read-only action must:
1. resolve the override producer's lookup and numeric-parser tail targets to exact import/stub semantics if statically possible;
2. audit the minimal complete-instruction adapter boundary around the shared generation accessor/floor;
3. preserve Tahoe's native 32023/32024 behavior and explicit override semantics;
4. define how legacy 3802 can be preserved only for the relevant Haswell/legacy request class rather than globally lowering all requests;
5. prove proposed adapter does not shadow native Metal or disturb Metal4 ABI;
6. make no source/system/cache mutation, Root Patch or reboot.

No Root Patch and no accelerated reboot are authorized.

GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback.