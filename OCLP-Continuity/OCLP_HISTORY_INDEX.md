# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BQ_FULL_PASS_SHARED_ACCESSOR_SELECTOR_RSI_CFG_CLAMP_D97BR_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This is the high-level chronological index. Detailed evidence remains in `OCLP-Continuity/checkpoints/`; current state is in MASTER and the permanent database.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / methodology
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`. P6/P7 insufficient; D50/D68/D82 reserve-only; D84 retired; D36-D44 invalidated.

Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## 2026-09-01 to 2026-09-04 — Golden producer/selector closure
Golden primary Metal builder `0x7FF80D370756..0x7FF80D370C28`: `[arg1+0x20] -> llvmVersion`, `[arg2+0x08] -> requestType`, `[arg2+0x18] -> timeout`, alternate requestType 9. Golden service selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`. Golden runtime uses both compiler generations and reaches Metal compositor success.

## D97AA — failing Tahoe cohort generation proven
Accelerated Tahoe cohort: 12/12 observed MTLCompilerService requests carried `llvmVersion=32023`; 3802=0; other=0.

## D97BH / BI / BJ / BK — exact Tahoe OCLP lane and whole-Metal rejection
Exact local 25G82 MetallibSupportPkg works. D97BJ completed Root Patch/AuxKC successfully but forced full legacy `13.2.1-24/Metal.framework`. D97BK proved accelerated failures were not kernel panics: WindowServer reached running, then Tahoe IOGPU Metal4 superclasses were missing and launchd shut down cleanly.

Permanent NEGATIVE:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## D97BL — native-Metal selective hybrid
Required architecture became:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Donor audit proved legacy `12.5-3802-23` can be bounded to `MTLCompilerService.xpc`; legacy `13.2.1-24/Versions/A/Metal` shadows native cache Metal and is forbidden. Historical native-Metal + legacy-XPC/private compilers + true-five already failed, so repeating it is rejected.

## D97BM — exact native Tahoe cache producer PASS
Native Metal start `0x7FF80F47D000`, `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`. Native Metal4/IOGPU class surface present.

## D97BN — two Tahoe builder layouts and generation census
Builder A `0x7FF80F635510..0x7FF80F635A4D`: llvmVersion `[arg1+0x1C]`, requestType helper `+0xAC`, timeout `+0xB8`.

Builder B `0x7FF80F663CA9..0x7FF80F66492C`: llvmVersion `[arg1+0x38]`, same requestType/timeout helper family via subordinate object.

Native Metal generation census: 3802 raw 11 / validated 9; 31001 zero; 32023 raw 10 / validated 10. Do not transplant Golden `+0x20` or globally rewrite 32023->31001.

## D97BO — generation singleton architecture
3802 initializer -> singleton global `0x7FF843D65C90`; 32023 initializer -> singleton global `0x7FF843D65CB0`. Selector `0x7FF80F5EFFEB..0x7FF80F5F009C` distinguishes 3802/3902/32023/32024.

Generation-aware constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88` compares a generation-like local to 32023 and builds request-layout-like `+0x1C/+0x20/+0x38` fields.

## D97BP — shared accessor frontier
Constructor calls `0x7FF80F5E16C3`, stores EAX into discriminator `-0x27C`, and optionally overrides it from `[arg1+0x138]`. Selector caller contexts independently showed `call accessor -> movl %eax,%esi -> call selector`. D97BP RDX back-slice was retired as wrong-register tooling.

## D97BQ — selector ABI + all six callers FULL PASS
Bundle:
`OCLP7_D97BQ_SHARED_GENERATION_ACCESSOR_SELECTOR_ABI_20260905_231651.zip`
- bytes `13102`;
- SHA256 `0d02a719c71c00770d767f319f922d43c92d2da68e5a464479d8e05839c953b8`.

All D97BQ final markers passed; no mutation.

Selector `0x7FF80F5EFFEB..0x7FF80F5F009C` copies `ESI -> EDX` and compares EDX to 3802/3902/32023/32024. Thus generation input is ABI arg2 / RSI — STATIC PROVEN.

All six validated selector callers source RSI from the same accessor:
`call 0x7FF80F5E16C3 -> movl %eax,%esi -> call selector`.

Constructor uses the same accessor and directly stores EAX into its generation discriminator, with optional `[arg1+0x138]` override.

Therefore common boundary is STATIC PROVEN:
`generation-bearing object -> shared accessor 0x7FF80F5E16C3 -> constructor discriminator / native generation selector`.

Accessor body contains a path with `cmp EAX,32024; mov 32023,ECX; cmovl ECX,EAX`, so a positive 3802 entering that path becomes 32023. However accessor has other branches/global/tail exits; universal return semantics remain unproven.

## CURRENT ACTION — D97BR
Remain unpatched in Tahoe VESA. Run only `OCLP7_D97BR_generation_accessor_cfg_and_clamp.sh` to reconstruct complete accessor CFG, enumerate all exits, prove path-local clamp semantics, resolve global override/xrefs, resolve indirect generation-source method references where possible, and inspect external tail semantics.

No Root Patch and no accelerated reboot are authorized.