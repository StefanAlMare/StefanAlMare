# OCLP7 CHECKPOINT — 2026-09-05 — D97BQ FULL PASS; shared generation accessor -> selector RSI closure; accessor CFG/clamp next

## Entering state
Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`. Current machine remains unpatched VESA after saved/sealed snapshot restore. No Root Patch or accelerated reboot is authorized.

Architecture remains:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Native Tahoe Metal cache identity remains:
- image start `0x7FF80F47D000`;
- cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

## D97BQ returned bundle
`OCLP7_D97BQ_SHARED_GENERATION_ACCESSOR_SELECTOR_ABI_20260905_231651.zip`
- bytes `13102`;
- SHA256 `0d02a719c71c00770d767f319f922d43c92d2da68e5a464479d8e05839c953b8`.

All final markers passed:
- `D97BQ_ACCESSOR_RETURN_SOURCE=PASS`;
- `D97BQ_SELECTOR_ABI_MAP=PASS`;
- `D97BQ_SELECTOR_CALLER_FIXED_BACKSLICE=PASS`;
- `D97BQ_ACCESSOR_CALLER_MATERIALIZATION_CENSUS=PASS`;
- `D97BQ_CONSTRUCTOR_SHARED_ACCESSOR_PROOF=PASS`;
- `D97BQ_WRAPPER_ANCESTRY_AUDIT=PASS`;
- `D97BQ_AUDIT=PASS`.

No system/cache/source mutation, Root Patch or reboot occurred.

## Selector generation ABI — STATIC PROVEN
Native selector function:
`0x7FF80F5EFFEB..0x7FF80F5F009C`.

At entry it executes `movl %esi,%edx`, then compares EDX against exact generation constants including:
- 3802 (`0xEDA`);
- 3902 (`0xF3E`);
- 32023 (`0x7D17`);
- 32024 (`0x7D18`).

Therefore selector generation input is exactly ABI argument 2 / RSI.

Classification:
`D97BQ_SELECTOR_GENERATION_INPUT=ABI_ARG2_RSI_STATIC_PROVEN`.

This permanently supersedes/retracts the D97BP scripted RDX caller back-slice for generation semantics.

## Six selector call sites converge through the same accessor — STATIC PROVEN
All six validated direct selector callers use the same dataflow immediately before selector invocation:
`call 0x7FF80F5E16C3 -> movl %eax,%esi -> call 0x7FF80F5EFFEB`.

Thus all six selector call sites source the selector's generation argument from shared accessor:
`0x7FF80F5E16C3`.

Classification:
`D97BQ_ALL_SIX_SELECTOR_CALLERS_SOURCE_GENERATION_FROM_SHARED_ACCESSOR=STATIC_PROVEN`.

## Constructor uses the same accessor — STATIC PROVEN
Generation-aware constructor:
`0x7FF80F4A5DF8..0x7FF80F4A7A88`.

It calls exact accessor `0x7FF80F5E16C3` on its generation-bearing object and stores returned EAX directly into local discriminator `-0x27C(%rbp)`.

Constructor also reads `[arg1+0x138]`; if that dword is nonzero it conditionally replaces the accessor-derived discriminator via `cmovnel`, then stores the final value back to `-0x27C`.

Classification:
`D97BQ_CONSTRUCTOR_GENERATION_DISCRIMINATOR=SHARED_ACCESSOR_RESULT_WITH_OPTIONAL_ARG1_PLUS_0x138_OVERRIDE_STATIC_PROVEN`.

This creates a common static dataflow boundary:
`generation-bearing object -> shared accessor 0x7FF80F5E16C3 -> constructor discriminator / native generation selector`.

## Accessor body — high-priority clamp candidate, but universal-return claim NOT YET PROVEN
Accessor function:
`0x7FF80F5E16C3..0x7FF80F5E1778`.

Its body contains explicit 32023/32024 logic. One path includes:
- compare EAX to 32024;
- load 32023 into ECX;
- conditional move ECX -> EAX when EAX is less than 32024.

Therefore, on that path, a positive generation such as 3802 would be normalized upward to 32023.

However the accessor has multiple branches, a RIP-relative global-value path, indirect method calls and an external tail-exit path. D97BQ's simple backward trace from the common `ret` found nearest immediate 32023 but was not path-sensitive CFG analysis.

Do **not** promote `accessor always returns 32023` from D97BQ.

Current classification:
- `D97BQ_ACCESSOR_32023_FLOOR_CLAMP_PATTERN=STATIC_MAPPED`;
- `D97BQ_ACCESSOR_ALL_RETURN_VALUES=UNKNOWN_PENDING_CFG`;
- `D97BQ_ACCESSOR_UNIVERSALLY_FORCES_32023=NOT_YET_PROVEN`.

## Runtime relation retained
D97AA previously proved the failing accelerated cohort delivered `llvmVersion=32023` for 12/12 observed MTLCompilerService requests; 3802=0, other=0.

D97BQ now identifies a shared upstream accessor that feeds every mapped native selector call and the generation-aware constructor. This makes the accessor the strongest current upstream causal candidate for Tahoe's 32023-only behavior, but static CFG closure is required before any patch design.

## No Builder ancestry claim from D97BQ
D97BQ found no direct short call-path from the shared accessor/selector family into Builder-A wrappers sufficient to prove exact object identity across that boundary. Existing Builder A/B layout facts remain valid, but no new exact object-equivalence claim is promoted here.

## CURRENT ACTION — D97BR
Remain unpatched in Tahoe VESA.

Run only read-only `OCLP7_D97BR_generation_accessor_cfg_and_clamp.sh`.

D97BR must:
1. reconstruct complete control-flow of accessor `0x7FF80F5E16C3..0x7FF80F5E1778`;
2. enumerate every normal return and external tail exit;
3. prove exact 3802 -> 32023 semantics of the floor/clamp path if structurally present;
4. resolve the RIP-relative global override value and all code xrefs/writers to it;
5. resolve selector/method references used by indirect generation-source calls where possible;
6. inspect external tail target semantics;
7. distinguish path-local clamp proof from universal accessor-return claims.

No Root Patch and no accelerated reboot are authorized.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until:
1. native Tahoe Metal4 remains authoritative;
2. no legacy main Metal shadows cache Metal;
3. legacy service/compiler ingress remains bounded;
4. exact 25G82 Metallib handling remains intact;
5. upstream producer normalization is statically complete for all relevant generation paths;
6. next runtime experiment adds new causal information beyond historical true-five.

GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed.