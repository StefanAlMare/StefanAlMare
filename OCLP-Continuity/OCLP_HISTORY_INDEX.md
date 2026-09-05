# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BS_FULL_PASS_TAIL_FLOOR_32023_ONLY_OVERRIDE_PRODUCER_OPEN_D97BT_NEXT.md`.
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

Accessor still had two escape classes: nonzero direct global override and external lazy tail.

## D97BS — escape-hatch census FULL PASS
Bundle:
`OCLP7_D97BS_ACCESSOR_ESCAPE_HATCHES_20260905_233839.zip`
- bytes `17024`;
- SHA256 `a84ee8d0bf74701f7359b664902922f32a6b4182e3cfe0cf5333e96ba324df6b`.

Inner TXT SHA256 `fb6bd8f2d22565f315d991109c7a94b5b3ff77d7d4c891f3db1d29300efb5350`; JSON SHA256 `5e2090b8b039dd69d1fe8c9da961f119ed67d1ddefddac5709faa8a06bdb5be6`.

All final markers passed; no mutation.

### Direct global override
Global `0x7FF843853E18` has static image value 0 and exactly one writer:
`0x7FF80F612AF4..0x7FF80F612B0E`, store at `0x7FF80F612B06`.
Writer stores EAX returned by exact producer `0x7FF80F58A5F4`.
No direct E8 callers of writer were found, consistent with possible init/registration use. Producer return semantics remain the sole unresolved direct-override question.

### Indirect generation-source calls
Both accessor indirect calls share the same unresolved cached call slot. Reliable semantic target names were not recovered from offline pointer encoding.

This is not independently blocking because first result is clamped and second result selects default 32023 vs lazy tail rather than returning directly.

### Lazy tail
Tail `0x7FF80F5E15C6..0x7FF80F5E1624` returns lazy global `0x7FF843853CE0`.
Exactly two code writes exist, both in block-invoke `0x7FF80F5E1624..0x7FF80F5E16C3`.
The persisted writer pattern sets ECX=32023 and keeps candidate EAX only when EAX>=32024 before storing ECX. Therefore a 3802 candidate becomes 32023 before caching.

Classification:
`D97BS_LAZY_TAIL_INPUT_3802_TO_CACHED_32023=STRUCTURAL_SEMANTIC_PROVEN`.

Two of the three accessor output classes now floor 3802 to 32023. Do not yet claim accessor-wide suppression because producer `0x7FF80F58A5F4` remains open.

## CURRENT ACTION — D97BT
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BT_override_producer_and_lazy_floor.sh`:
- bytes `20882`;
- SHA256 `14553b7f884fe033cbcabd033daa2740fb17da419ed843ea6b8e8ec14a611a99`.

D97BT must reconstruct exact CFG/returns of override producer `0x7FF80F58A5F4`, resolve the key/object supplied by its writer, formalize both lazy-floor writes, and promote accessor-wide suppression only if every escape path is semantically closed.

No Root Patch and no accelerated reboot are authorized.