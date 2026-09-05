# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BT_FULL_PASS_DEFAULT_ACCESSOR_3802_SUPPRESSION_ENV_OVERRIDE_EXCEPTION_D97BU_NEXT.md`.
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
D97BQ proved selector generation argument is ABI arg2/RSI; each caller uses `call accessor -> movl %eax,%esi -> call selector`.

## D97BR — accessor CFG + clamp FULL PASS
Accessor direct-branch CFG is complete. Primary clamp sequence:
`cmp EAX,32024; ECX=32023; cmovl ECX,EAX`.

Classification:
`D97BR_ACCESSOR_INPUT_3802_ON_CLAMP_PATH_BECOMES_32023=SEMANTIC_PROVEN`.

## D97BS — escape-hatch census FULL PASS
Direct nonzero global override and lazy fallback were isolated. Lazy fallback has two cached writes, both floor legacy candidates upward; explicit override producer remained open.

## D97BT — default accessor-wide 3802 suppression FULL PASS
Bundle:
`OCLP7_D97BT_OVERRIDE_PRODUCER_AND_LAZY_FLOOR_20260905_235137.zip`
- bytes `3719`;
- SHA256 `6741153378f842849df5436ad3ea7734f7e79607aa33f3edbb7131cedaf18197`.

All collector final markers passed; no mutation.

### Lazy fallback fully closed
First lazy write computes `max(candidate,32023)`.
Second lazy write computes `max(candidate,32024)`.
Thus 3802 cannot survive either lazy branch.

Classifications:
- `D97BT_LAZY_FIRST_WRITE_3802_TO_32023=SEMANTIC_PROVEN`;
- `D97BT_LAZY_SECOND_WRITE_3802_TO_32024=SEMANTIC_PROVEN`;
- `D97BT_LAZY_FALLBACK_PRESERVES_3802=NEGATIVE`.

The collector's second `PROOF=False` was a checker limitation: it recognized only the first floor pair, while raw code proves the second floor separately.

### Explicit override identified
Override writer uses exact key string:
`MTL_FORCE_MTLCOMPILER_LLVM_VERSION`.

It passes key + fallback zero to producer `0x7FF80F58A5F4` and stores returned EAX into override global `0x7FF843853E18`.
Producer returns fallback zero when lookup is absent; if a value exists it forwards the string to a numeric parser tail. Current override global is zero.

Therefore the nonzero bypass is an intentional explicit environment/config override, not ordinary generation selection.

Classifications:
- override key identity = STATIC PROVEN;
- override fallback zero = STATIC PROVEN;
- current override disabled = STATIC PROVEN;
- explicit override path = STRUCTURAL-SEMANTIC PROVEN nondefault exception.

### Strongest current conclusion
Under the current/default environment:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

This supplies a concrete upstream mechanism consistent with Tahoe's 12/12 runtime 32023 cohort and Golden's real 3802 lane.
Do not claim absolute suppression when the explicit force override is deliberately set.

## CURRENT ACTION — D97BU
Remain unpatched in Tahoe VESA.
Next read-only preflight should resolve the override lookup/parser import semantics if possible and audit a minimal complete-instruction upstream adapter around the shared generation accessor, preserving native 32023/32024 behavior, explicit override semantics and Tahoe Metal4 ABI.

No Root Patch and no accelerated reboot are authorized.