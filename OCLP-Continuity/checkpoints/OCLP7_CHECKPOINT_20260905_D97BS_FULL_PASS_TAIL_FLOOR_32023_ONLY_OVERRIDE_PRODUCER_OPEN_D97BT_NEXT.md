# OCLP7 CHECKPOINT — 2026-09-05 — D97BS full PASS; lazy-tail floors to 32023; only override producer remains; D97BT next

## Entering state
- Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine state remains unpatched Tahoe VESA after saved/sealed snapshot restore.
- `-igfxvesa` active; no active Root Patch.
- Native Tahoe cache-resident Metal/Metal4 remains authoritative.
- No Root Patch or accelerated reboot is authorized.

## D97BS returned bundle
`OCLP7_D97BS_ACCESSOR_ESCAPE_HATCHES_20260905_233839.zip`
- bytes `17024`;
- SHA256 `a84ee8d0bf74701f7359b664902922f32a6b4182e3cfe0cf5333e96ba324df6b`.

Inner evidence:
- TXT bytes `54729`, SHA256 `fb6bd8f2d22565f315d991109c7a94b5b3ff77d7d4c891f3db1d29300efb5350`;
- JSON bytes `127737`, SHA256 `5e2090b8b039dd69d1fe8c9da961f119ed67d1ddefddac5709faa8a06bdb5be6`.

All collector final markers passed:
- `D97BS_GLOBAL_OVERRIDE_WRITER=PASS`;
- `D97BS_INDIRECT_SOURCE_TARGETS=PASS`;
- `D97BS_TAIL_LAZY_GLOBAL=PASS`;
- `D97BS_ESCAPE_HATCH_CENSUS=PASS`;
- `D97BS_AUDIT=PASS`.

No source/system/cache mutation, Root Patch or reboot occurred.

## Global override escape path
Accessor direct override global:
`0x7FF843853E18`.

Static image value is `0`.
Exactly one writer remains:
- function `0x7FF80F612AF4..0x7FF80F612B0E`;
- store `0x7FF80F612B06`: `movl %eax,<override global>`.

Writer body:
- loads one RIP-relative argument/key into RDI;
- clears ESI;
- calls exact producer function `0x7FF80F58A5F4`;
- stores returned EAX into the override global.

No direct E8 callers of the writer were found; this is consistent with initialization/registration-style invocation and is not evidence that it never runs.

Critical remaining unknown:
`0x7FF80F58A5F4` return semantics.

The global override bypasses the main accessor clamp when nonzero, so accessor-wide 3802 suppression cannot yet be claimed until this producer is audited.

## Accessor indirect call slots
D97BS confirmed both indirect calls at:
- `0x7FF80F5E1713`;
- `0x7FF80F5E1732`
share the same indirect call slot.

Offline cached pointer decoding did not resolve a trustworthy concrete target/symbol; no semantic claim is made from the unresolved pointer encoding.

This no longer blocks the main suppression question by itself:
- first indirect result is always subjected to the proven `<32024 -> 32023` clamp;
- second indirect result is not returned directly: it selects between default 32023 and the external lazy-tail path.

## Lazy-tail escape path — stronger closure
External tail function:
`0x7FF80F5E15C6..0x7FF80F5E1624`.

It uses a once/lazy-initialized dword global at:
`0x7FF843853CE0`.

D97BS found exactly two writes to this dword, both in the adjacent block-invoke function `0x7FF80F5E1624..0x7FF80F5E16C3`.

Persisted instruction context from D97BN/D97BS proves at least the first write sequence exactly:
- load current candidate into EAX;
- compare EAX with 32024;
- set ECX = 32023;
- `cmovge EAX,ECX`;
- store ECX to lazy global.

Semantics:
`lazy_global := max(candidate, 32023)` for positive legacy-generation candidates.

The second write is the same structural `ECX` store family and no other writer exists. Therefore 3802 cannot survive the lazy-global initialization as 3802: a 3802 candidate is promoted to 32023 before the tail returns the cached value.

Classification:
`D97BS_LAZY_TAIL_INPUT_3802_TO_CACHED_32023=STRUCTURAL_SEMANTIC_PROVEN`.

A dedicated D97BT bounded function audit will formalize both write paths before accessor-wide promotion, but the lazy tail is no longer the leading unresolved escape hatch.

## What D97BS did NOT prove
The collector correctly printed:
`D97BS_ACCESSOR_WIDE_3802_SUPPRESSION=NOT_YET_PROVEN_FROM_NO_IMMEDIATE_ALONE`.

That limitation remains authoritative. Absence of a literal 3802 in escape writers is not sufficient semantic proof.

Current unresolved item is now narrowly:
- exact return/value semantics of override producer `0x7FF80F58A5F4`.

## Current causal model
Strongest current model:
`generation-bearing object -> shared accessor -> primary clamp (3802 -> 32023) OR lazy-tail floor (3802 -> 32023) OR nonzero global override -> native selector/XPC producer`.

Thus two of the three output classes now have a concrete 32023 floor mechanism. The override path remains the only semantic escape capable of defeating accessor-wide suppression until its producer is closed.

This model is directly consistent with retained D97AA runtime evidence: 12/12 observed Tahoe requests arrived at MTLCompilerService as exact 32023, with zero 3802.

## CURRENT ACTION — D97BT
Remain unpatched in Tahoe VESA.

Next read-only audit must:
1. disassemble and reconstruct complete CFG/return semantics of exact producer `0x7FF80F58A5F4`;
2. resolve the RIP-relative key/string/object passed to it by writer `0x7FF80F612AF4`;
3. enumerate every EAX return source and determine whether 3802 can be produced;
4. formalize both writes in lazy block-invoke `0x7FF80F5E1624..0x7FF80F5E16C3` and prove/reject `max(candidate,32023)` semantics on each;
5. only if both escape classes are semantically closed, decide whether accessor-wide 3802 suppression can be promoted;
6. make no source/system/cache mutation, Root Patch or reboot.

No Root Patch and no accelerated reboot are authorized.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until:
1. native Tahoe Metal4 remains authoritative;
2. no legacy main Metal shadows cache Metal;
3. legacy service/compiler ingress remains bounded;
4. exact 25G82 Metallib handling remains intact;
5. producer normalization is statically complete across every relevant accessor/request path;
6. the proposed test adds new causal information beyond historical true-five.

GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed; local compilation is not an implicit fallback.