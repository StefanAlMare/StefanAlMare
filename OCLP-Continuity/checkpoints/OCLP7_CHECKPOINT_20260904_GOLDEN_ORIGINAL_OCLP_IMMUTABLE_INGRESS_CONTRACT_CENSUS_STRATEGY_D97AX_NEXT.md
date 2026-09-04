# OCLP7 CHECKPOINT — 2026-09-04 — Golden original-OCLP ingress contract census strategy; D97AX next

## Explicit user architecture override
User has now fixed the project objective more strictly than the earlier custom-patch-centric lineage:

1. Working Golden Sequoia `15.7.9 / 24G830` is the runtime oracle.
2. The ORIGINAL OCLP donor/root-patch implementation is to remain semantically unchanged as the target donor path.
3. The project must determine what working Sequoia delivers into that donor path and make Tahoe deliver an equivalent contract.
4. Investigation therefore moves upstream/below the OCLP donor boundary: producer/request construction, XPC contract, generation selector input, request header/payload/AIR/bitcode/module semantics, and later compiler-output/Haswell-driver handoff.
5. Custom P1/P2b/P3/AIR00/D34/P6/P7 are historical hypotheses/adapters only. None is an architectural axiom. They may eventually be retired if Tahoe producer normalization makes the original OCLP donor path sufficient.
6. Do not patch or relax the original OCLP donor merely to accept Tahoe-specific data. Normalize Tahoe at the earliest proven non-equivalent producer/handoff.
7. User authorizes remaining in Golden for as many read-only comparator runs and manual reboots as are useful. Repeated Golden boots may be used to distinguish invariant contract data from one-boot noise. Assistant still does not automate Root Patch or reboot.

Target end architecture is now expressed as:

`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor path -> Golden-equivalent compiler output -> Haswell driver handoff -> image`

The purpose is not to imitate Sequoia logs. Logs are observation channels. The objects of comparison are the actual cross-boundary contracts/messages and semantic payloads.

## Evidence discipline for Golden contract book
For each boundary field/message distinguish:
- `SCHEMA_STATIC_PROVEN`: key/type/layout/source is statically demonstrated;
- `RUNTIME_OBSERVED`: runtime request/lane/event is observed for an exact cohort;
- `RUNTIME_VALUE_PROVEN`: exact runtime value is directly recovered;
- `GOLDEN_INVARIANT_PROVISIONAL`: observed identically across repeated Golden boots/workloads but not yet architectural proof;
- `UNKNOWN`: exact value unavailable;
- `INCONCLUSIVE`: observation channel insufficient.

Never substitute a static constant or inferred label for an unavailable runtime value.

## Golden contract-book layers
### G1 — producer / XPC ingress
Map Metal.framework producer -> MTLCompilerService request contract:
- complete statically recoverable XPC dictionary getter/setter vocabulary and value types;
- exact `llvmVersion` producer/receiver chain;
- request-class/type selectors and generation split `3802` vs `31001 -> 32023`;
- all runtime-observable sender UUID/path/PC/PID/request-lane sequences;
- repeated-boot stability.

### G2 — MTLCompiler donor ingress/internal handoff
Map selected MTLCompiler request semantics:
- request header fields/offsets read by donor;
- bitcode type/length/pointer and optional payload families;
- AIR/Metal semantic version state;
- `getReadParametersFromRequest`, `upgradeAIRModule`, specialized/backend paths, module reconstruction and metadata handoff;
- exact values where observable, otherwise schema + UNKNOWN runtime value.

### G3 — compiler output to Haswell driver
Map the final compiler/pipeline output and driver-facing handoff:
- GPUCompiler/Metal/IOGPU/AppleIntelHD5000GraphicsMTLDriver identities and load state;
- pipeline/library/function output paths and observable status/result contracts;
- Metal System Trace/xctrace capability where available;
- earliest Tahoe-vs-Golden output divergence before the Haswell driver consumes the result.

Do not return to Tahoe for functional mutation until the Golden contract book is sufficiently complete to define concrete target values/contracts.

## Retained D97AV V2 facts
D97AV V2 static map remains valid; its erroneous 1970 boot subsection remains retired. D97AU fixed Golden window remains runtime authority.

Golden original MTLCompilerService selector has:
- 3802 at fileoff `0x3478` -> MTLCompiler 3802;
- 31001 at fileoff `0x3496` -> MTLCompiler 32023;
- no selector immediate 32023.

Tahoe P1 changes only 31001->32023 and leaves 3802 untouched. Therefore zero 3802 in Tahoe is upstream of P1, not caused by P1 alone.

Golden 32023 runtime PC `0x9A9FC` maps to `upgradeAIRModule`; working Golden reaches it heavily while Tahoe failing cohort does not. P2b/AIR00/P7 are historically located in `getReadParametersFromRequest`, but they are now treated only as possible Tahoe adapters, not as target behavior.

## D97AW status
Prepared D97AW `8187316e... / e2d77333...` is RETIRED UNRUN because the user broadened the objective before execution. Its narrow producer/callgraph questions are subsumed by the Golden contract census.

## CURRENT ACTION — D97AX Golden ingress contract census
Prepare and run a strictly read-only Golden census that:
1. fail-closes on Golden OS/build and exact 3802/32023/service identities;
2. records robust current boot chronology plus the fixed D97AU reference window without greedy `kern.boottime` parsing;
3. enumerates MTLCompilerService XPC dictionary getter/setter call sites, statically recoverable keys, value types and source/destination operands;
4. enumerates Metal.framework XPC dictionary setter/getter call sites visible through the shared-cache-aware tool path and recovers statically visible keys/value sources;
5. maps the intersection between sender and receiver vocabulary;
6. inventories exact generation/request-lane runtime evidence by sender UUID/path/PC/PID for the fixed Golden window and current boot;
7. inventories key MTLCompiler donor functions, their direct call relationships, and request-memory displacement access sets for later field naming;
8. inventories GPUCompiler/Haswell Metal driver identities/load state and available xctrace/DTrace/ktrace observation capabilities;
9. makes no debugger attach, system-file mutation, cache extraction, Root Patch or reboot.

STOP after D97AX and audit its report/JSON before deciding the first repeated-boot/workload capture.
