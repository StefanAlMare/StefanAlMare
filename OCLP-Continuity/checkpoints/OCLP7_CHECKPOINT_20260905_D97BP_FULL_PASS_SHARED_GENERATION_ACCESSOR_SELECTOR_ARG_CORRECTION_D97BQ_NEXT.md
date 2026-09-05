# OCLP7 CHECKPOINT — 2026-09-05 — D97BP FULL PASS; shared generation accessor exposed; selector-argument tracing corrected; D97BQ next

## Entering state
Target remains Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`. Current machine state remains unpatched VESA with `-igfxvesa` and no active Root Patch.

D97BL architecture remains:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

No Root Patch or accelerated reboot is authorized.

## D97BP returned evidence
Bundle:
`OCLP7_D97BP_CONSTRUCTOR_SELECTOR_DATAFLOW_20260905_230558.zip`
- bytes `20273`;
- SHA256 `22258abc2b4ce017cb77ae20f1c93baff4377428d18642b2e80f18eb6ef541d2`.

All final markers passed:
- `D97BP_CONSTRUCTOR_LOCAL_DATAFLOW=PASS`;
- `D97BP_CONSTRUCTOR_CALLER_CENSUS=PASS`;
- `D97BP_SELECTOR_CALLER_CENSUS=PASS`;
- `D97BP_DIRECT_E8_PATH_AUDIT=PASS`;
- `D97BP_AUDIT=PASS`;
- collection complete.

No source/system/cache mutation occurred.

## Constructor local dataflow — STATIC PROVEN
Generation-aware constructor:
`0x7FF80F4A5DF8..0x7FF80F4A7A88`.

### Generation discriminator `-0x27C`
Initial value:
- object is produced into `-0x358(%rbp)`;
- constructor calls function `0x7FF80F5E16C3` on that object;
- return EAX is stored at `-0x27C`.

Later override:
- original constructor ABI arg1 is saved at `-0x258(%rbp)`;
- `[arg1+0x138]` is loaded;
- if nonzero, `cmov` replaces the previous discriminator;
- result is written back to `-0x27C`.

The constructor then compares this final discriminator against exact `32023 (0x7D17)` at `0x7FF80F4A6283`.

Classification:
`D97BP_CONSTRUCTOR_GENERATION_DISCRIMINATOR_SOURCE=SHARED_ACCESSOR_WITH_OPTIONAL_ARG1_PLUS_0x138_OVERRIDE_STATIC_PROVEN`.

### Layout source `-0x3A0`
`-0x3A0` is produced from an earlier branch-dependent RAX state around `0x7FF80F4A62EE..0x7FF80F4A631C` and later copied into `+0x1C` of a constructed object at `0x7FF80F4A726F`.

This source is not yet semantically identified as generation. Do not equate `-0x3A0` with the generation discriminator solely because its destination offset matches Builder-A llvmVersion layout.

### Layout source `-0x2C4`
`-0x2C4` is branch-produced from locals `-0x280/-0x318`, and later appears in a second layout at `+0x38`.

This source is not yet semantically identified as generation.

## Constructor/selector direct-call relation — NEGATIVE
D97BP found:
- constructor direct E8 caller count = 0;
- selector direct E8 caller count = 6;
- no direct-E8 path within depth 8 from selector to constructor;
- no direct-E8 path selector -> Builder A;
- no direct-E8 path constructor -> Builder A or Builder B;
- caller-set intersections = 0.

Classification:
`D97BP_SIMPLE_DIRECT_CALLGRAPH_ADAPTER_BOUNDARY=NOT_PROVEN`.

This does not reject an object/dataflow relationship through indirect/virtual calls.

## Decisive shared generation accessor
A stronger relation was exposed by the raw contexts.

Exact function:
`0x7FF80F5E16C3`.

The constructor calls this function on its generation-bearing object and stores EAX into `-0x27C`.

Multiple selector callers independently show the same pattern:
`object -> call 0x7FF80F5E16C3 -> movl %eax,%esi -> call selector 0x7FF80F5EFFEB`.

Therefore the same accessor is used in both the constructor generation-discriminator path and the native 3802/32023 singleton-selector path.

Classification:
`D97BP_SHARED_GENERATION_ACCESSOR_BETWEEN_CONSTRUCTOR_AND_SELECTOR=STATIC_PROVEN`.

This is the first common static semantic bridge between the high-priority constructor region and the native generation selector.

## Selector-argument tooling correction
D97BP's scripted selector-caller backslice traced RDX. That is not authoritative for generation semantics.

Raw caller contexts show the generation accessor return copied into `ESI` immediately before the selector call, for example:
`call generation_accessor; movl %eax,%esi; call selector`.

The selector body later compares a working register against 3802/32023, but exact entry-ABI propagation from ESI to that working register was not explicitly mapped by D97BP.

Therefore:
- D97BP RDX-origin rows are retained only as tooling output, not generation evidence;
- exact selector generation-argument ABI mapping is `PENDING_D97BQ`.

Classification:
`D97BP_SELECTOR_GENERATION_RDX_BACKSLICE=TOOLING_WRONG_REGISTER_RETIRED`.

## Current frontier
The strongest current upstream relation is:
`generation-bearing object -> shared accessor 0x7FF80F5E16C3 -> generation discriminator / selector input`.

The remaining questions before any adapter design are:
1. what exact object field/value does `0x7FF80F5E16C3` return;
2. what exact selector ABI argument receives that value and how it reaches the 3802/32023 comparisons;
3. which constructor object and selector-caller objects share that generation-bearing class/layout;
4. whether the runtime 12/12 32023 cohort results from object-field population upstream of this accessor;
5. whether Builder-A/B request objects can be linked to the same generation-bearing object family without late value-forcing.

## CURRENT ACTION — D97BQ
Remain unpatched in Tahoe VESA.

D97BQ must be read-only and must:
- pin exact 25G82 native Metal identity;
- disassemble exact generation accessor `0x7FF80F5E16C3` and recover its return-value/object-field source;
- enumerate its direct callers and argument-object provenance;
- disassemble exact selector `0x7FF80F5EFFEB..0x7FF80F5F009C` from function start and prove which ABI argument carries generation to the 3802/32023 comparisons;
- redo all selector-caller generation back-slices using the proven argument register;
- explicitly map the constructor call to the shared accessor and the optional `[constructor arg1+0x138]` override;
- test whether Builder-A wrapper ancestry or nearby dataflow uses the same generation accessor/object field;
- perform no source/system/cache mutation, Root Patch or reboot.

## Safety / execution contract
- native Tahoe Metal4 must remain authoritative;
- no legacy main Metal may shadow it;
- exact 25G82 Metallib handling remains retained;
- GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation;
- local compilation is not an implicit fallback;
- no Root Patch and no accelerated reboot are authorized.