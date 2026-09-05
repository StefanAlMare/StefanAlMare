# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BR_FULL_PASS_CLAMP_3802_TO_32023_ESCAPE_HATCHES_D97BS_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline remains `P1 + P2b + P3 + AIR00 + D34`.
Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## Golden producer / selector closure
Golden primary Metal request builder uses `[arg1+0x20] -> llvmVersion`; Golden original service maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches Metal compositor success.

## D97AA — failing Tahoe generation cohort
Accelerated Tahoe cohort: 12/12 observed MTLCompilerService requests carried exact `llvmVersion=32023`; 3802=0; other=0.

## D97BJ / BK — whole legacy Metal rejected
Exact Tahoe root patch execution passed, but full legacy `13.2.1-24/Metal.framework` removed Tahoe Metal4 superclass ABI. Accelerated boots reached WindowServer, then critical userspace services failed and launchd shut down. Permanent NEGATIVE: full legacy main Metal on Tahoe.

## D97BL — native-Metal selective hybrid
Current architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Legacy service bundle can be bounded; legacy main Metal must never shadow cache-resident Tahoe Metal. Historical native-Metal + legacy-XPC/private-compilers + true-five already failed and must not be repeated unchanged.

## D97BM / BN — native producer mapping
Native Tahoe Metal start `0x7FF80F47D000`, `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Builder A: llvmVersion `[arg1+0x1C]`; Builder B: llvmVersion `[arg1+0x38]`.
Generation census: 3802 present, 31001 absent, 32023 present. Do not copy Golden offsets or globally rewrite 32023->31001.

## D97BO — native generation singleton architecture
3802 singleton global `0x7FF843D65C90`; 32023 singleton global `0x7FF843D65CB0`; selector `0x7FF80F5EFFEB..0x7FF80F5F009C` distinguishes 3802/3902/32023/32024.

Generation-aware constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88` builds `+0x1C/+0x20/+0x38` layouts and contains 32023 generation logic.

## D97BP / BQ — shared generation accessor
Shared accessor `0x7FF80F5E16C3..0x7FF80F5E1778` is used both by constructor discriminator and all six validated generation-selector call sites.

D97BQ proved selector generation argument is ABI arg2/RSI. Each caller uses:
`call accessor -> movl %eax,%esi -> call selector`.

Thus common generation boundary is STATIC PROVEN:
`generation-bearing object -> shared accessor -> constructor discriminator / native selector`.

## D97BR — accessor CFG + clamp FULL PASS
Bundle:
`OCLP7_D97BR_GENERATION_ACCESSOR_CFG_AND_CLAMP_20260905_232748.zip`
- bytes `4515`;
- SHA256 `1b3d252e8824f9e531980afdd1f9ca93b06d2c83e6e2bf7bb18ded44f90d22f7`.

Accessor CFG closure:
- 57 edges;
- all 50 instructions reachable;
- one normal ret;
- one external tail.

Decisive clamp sequence:
- compare EAX with 32024;
- load 32023 into ECX;
- `cmovl ECX,EAX`.

Classification:
`D97BR_ACCESSOR_INPUT_3802_ON_CLAMP_PATH_BECOMES_32023=SEMANTIC_PROVEN`.

This provides a concrete static mechanism consistent with Tahoe's 12/12 runtime 32023 cohort while preserving the fact that real 3802 machinery still exists elsewhere.

Accessor has two escape classes that prevent universal suppression from being claimed yet:
1. direct nonzero global override `0x7FF843853E18`, current static value 0, single writer `0x7FF80F612B06` in function `0x7FF80F612AF4..0x7FF80F612B0E`;
2. fallback external tail `0x7FF80F5E15C6..0x7FF80F5E1624` returning a lazy global.

Two indirect source calls remain at `0x7FF80F5E1713` and `0x7FF80F5E1732`.

Do not claim accessor-wide 3802 suppression until these escape paths are closed.

## CURRENT ACTION — D97BS
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BS_accessor_escape_hatches.sh`:
- bytes `20670`;
- SHA256 `4aa35c3afd3774f3385e70e4147cf80e942c96e3a3c0608fac5d2ad328300d9d`.

It must audit global override writer/callers, resolve actual indirect call-slot targets where possible, enumerate tail lazy global writers/sources, and classify escape-hatch 3802 capability.

No Root Patch and no accelerated reboot are authorized.