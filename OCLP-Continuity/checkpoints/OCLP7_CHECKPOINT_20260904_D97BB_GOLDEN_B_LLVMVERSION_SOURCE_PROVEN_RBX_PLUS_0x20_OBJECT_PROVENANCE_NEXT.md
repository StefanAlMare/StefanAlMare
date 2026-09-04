# OCLP7 CHECKPOINT — 2026-09-04 — D97BB GOLDEN_B llvmVersion static source PROVEN; producer object provenance next

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Remain in working GOLDEN_B Sequoia `15.8 / 24H22` until the Golden contract book is sufficiently complete. Do not start Tahoe eligibility bypass yet.

## D97BB returned batch — exact identities
User returned:
- TXT `OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.txt`: 4779 bytes / SHA256 `694647bdfa56ca79b9446df8d9fb1a383e48834c13bbdd7462d68e1f6810c4e1`;
- JSON `OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.json`: 4113 bytes / SHA256 `3ede6711d2494b3a9f3ae3900c0c9f8572b0c955b46b325789a7e6026fca63e2`.

JSON parses successfully and agrees with TXT.

Identity revalidated:
- Sequoia `15.8 / 24H22`;
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- cached Metal text SHA `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.

Final marker `D97BB_AUDIT=COMPLETE`; no system mutation, cache mmap, persistent extraction/instrumentation, debugger attach, Root Patch or reboot.

Classification: `D97BB_GOLDEN_B_LLVMVERSION_FUNCTION_BOUNDARY_AND_STATIC_SOURCE=PASS`.

## Containing function boundary — LC_FUNCTION_STARTS PROVEN
D97BB parsed cached Metal `LC_FUNCTION_STARTS` at `0x7FF8801EB400`, 11083 function starts.

The primary request builder containing llvmVersion xref is exactly:
- function start `0x7FF80D370756`;
- function end `0x7FF80D370C28`;
- llvmVersion xref `0x7FF80D37081F`, offset `0xC9` inside function.

Classification: `G1_GOLDEN_PRIMARY_REQUEST_BUILDER_FUNCTION_BOUNDARY=LC_FUNCTION_STARTS_PROVEN`.

## llvmVersion exact static source — PROVEN
Exact sequence:
- `0x7FF80D37081B`: `movslq 0x20(%rbx), %rdx`;
- `0x7FF80D37081F`: RIP-relative LEA of key `llvmVersion` into RSI;
- `0x7FF80D370826`: `movq %rax, %rdi`;
- `0x7FF80D370829`: call target `0x7FF80D50FDCE`, the previously schema-supported uint64-setter family target.

Therefore the Golden primary Metal request builder reads llvmVersion from signed 32-bit memory field `[RBX+0x20]`, sign-extends it into RDX, and sends it as the uint64-setter value.

Authoritative classification:
`G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

This supersedes the prior D97AZ `UNKNOWN_RANGE_LEFT_EDGE` classification.

## Adjacent producer structure facts retained
D97AZ already proved:
- primary requestType source = 32-bit `[R13+0x8]` -> R14 -> RDX;
- timeout source = qword `[R13+0x18]` -> RDX;
- sandboxTokens path is conditioned by byte `[R13+0x70]` before helper return -> RDX;
- alternate requestType path writes exact immediate `9` to EDX before the same uint64-setter family.

D97BB function context also shows `[RBX+0x20]` used earlier as ESI before a virtual call through R13, reinforcing that this field is a stable producer-side state input. Do not infer semantic class beyond the directly proven llvmVersion setter use.

## Golden runtime value logic — strongest currently supported chain
Original MTLCompilerService selector is exhaustive for the relevant visible generation branches:
- request `llvmVersion=3802` -> `Versions/3802/MTLCompiler`;
- request `llvmVersion=31001` -> `Versions/32023/MTLCompiler`;
- no original immediate 32023 selector branch.

GOLDEN_A D97AU observed exact runtime sender generations 3802 and 32023 in distinct PIDs. Combined with the exhaustive selector chain, this constrains the corresponding original-service request values to 3802 for the 3802 donor lane and 31001 for the 32023 donor lane. This is a logical composition of static exhaustive selector semantics plus runtime provenance; preserve it distinctly from a direct runtime register capture.

GOLDEN_B D97BA's generation log channel remains `INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`; do not transfer GOLDEN_A PID/counts to GOLDEN_B as current runtime observations.

## CURRENT FRONTIER / NEXT ACTION — producer object provenance
Remain in GOLDEN_B `15.8 / 24H22`.

Next bounded read-only static collector should use the now-proven function boundary `0x7FF80D370756..0x7FF80D370C28` and inspect only the function entry/prelude needed to establish the provenance of RBX and R13.

Goals:
1. identify the exact writes that initialize/copy RBX and R13 in the containing function;
2. map them to ABI arguments, object pointers or upstream fields where statically resolvable;
3. consolidate producer layout facts `[RBX+0x20]=llvmVersion`, `[R13+0x8]=requestType`, `[R13+0x18]=timeout`, `[R13+0x70]` sandbox-token condition into explicit root-object relationships;
4. avoid broad shared-cache rescans and avoid runtime instrumentation;
5. no debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After RBX/R13 provenance is established, decide whether one short Golden runtime channel is still needed for exact per-request values, or whether the Golden contract is sufficient to begin the separately audited identical-OCLP Tahoe eligibility-bypass phase.