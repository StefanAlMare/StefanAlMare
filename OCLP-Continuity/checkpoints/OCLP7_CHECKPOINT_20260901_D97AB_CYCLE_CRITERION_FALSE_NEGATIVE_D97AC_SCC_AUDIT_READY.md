# OCLP7 CHECKPOINT — 2026-09-01 — D97AB cycle criterion false negative / D97AC SCC audit ready

## Retained decisive runtime fact
D97AA remains authoritative for the accelerated cohort:
- 12 unique MTLCompilerService children;
- 12/12 primary `exit(124)`;
- `exit(123)=0`, `exit(125)=0`, signal exits `0`, spawn without exit `0`;
- runtime `llvmVersion=32023` PROVEN for all observed requests;
- runtime selection of MTLCompiler 3802 is rejected for that cohort.

## D97AB artifact
`OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP.command`
- commit `e0519e5b38c029e5bfd6ba141c422b43ca64246e`;
- blob `366fb2a45895723d103b7edb31679a4cd5dd9a16`.

## D97AB observed result
D97AB was strict read-only and returned mapper PASS.

Identity and CFG gates:
- current D97 MTLCompiler SHA exact `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`;
- exact D97 -> P7 reconstruction SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
- validator symbol/range exact `0x7FFB162C7132..0x7FFB162C7830`;
- 408 disassembled instructions;
- indirect switch REL+`0x279` resolved to the seven previously proven entries;
- full CFG 81 blocks, 75 reachable;
- candidate REL+`0x58B` reachable;
- buffer-index, sampler-index and nested-argument-buffer error xrefs all reachable.

Known finite outcome anchors:
- candidate REL+`0x58B`, planned exit 110;
- buffer-index REL+`0x29A`, exit 111;
- sampler-index REL+`0x2D9`, exit 112;
- nested argument-buffer REL+`0x3E2`, exit 113.

Residual finite terminals mapped:
- B10, REL `0xB9..0xCE`, normal early return path;
- B80, REL `0x6CC..0x6FE`, cleanup/tail region whose block head is valid but whose tail requires explicit provenance reporting;
- both assigned planned class 114 (`other early`).

D97AB also reported two residual graph cycles:
- B1/B2/B4/B5/B6;
- B16/B17/B32/B33/B35..B45.

The mapper declared the partition incomplete solely because its criterion was `no cycle at all`. That criterion is too strong: a cyclic CFG component is not itself an outcome when it has outgoing edges to classified outcomes. D97AB did not compute SCC condensation, closed nonterminal SCCs, or reverse outcome reachability. Therefore:
- the D97AB `ENTRY_PATH_PARTITION_EXHAUSTIVE_STATIC=FAIL` is a mapper-methodology false negative until SCC analysis is completed;
- it is not evidence that runtime entered an unknown path;
- no FASTLANE is authorized from D97AB alone.

Patch substrate retained from D97AB:
- shared zero cave `0xF80..0xF90` passed zero/direct-target/RIP-target/symbol gates;
- shared Darwin exit stub contract passed;
- all six mapped terminal patch windows were individually SAFE;
- classifier remained unauthorized only because the partition gate was incomplete.

## D97AC artifact
`OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER.command`
- commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`;
- blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.

D97AC is an identity-pinned wrapper over the exact D97AB blob. It changes only the static analysis method:
1. Tarjan SCC condensation;
2. closed nonterminal SCC detection;
3. reverse reachability from all known and residual finite outcomes;
4. reachable outside/unresolved edge gate;
5. residual terminal inbound-edge and raw-byte provenance;
6. separate finite-path exhaustiveness from a global termination claim.

D97AC explicitly does not claim that cyclic loops terminate for every state. Any future runtime classifier must require a launchd liveness gate: every spawned MTLCompilerService PID must emit exactly one classifier exit; a spawned PID without a classifier exit invalidates runtime classification.

D97AC is read-only: no source/system/Golden mutation, no service launch, no integration, no Root Patch, no reboot, no D82 and no Patch8.

## CURRENT SINGLE NEXT ACTION
Run D97AC only and return both complete reports:
- `OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER_REPORT.txt`;
- `OCLP7_D97AC_READONLY_PRE_D97_VALIDATOR_SCC_FINITE_OUTCOME_AUDIT_REPORT.txt`.

Do not Root Patch or reboot. A FASTLANE may be designed only if D97AC proves zero closed nonterminal SCCs, zero reachable unresolved/outside edges, every reachable block has a path to a classified finite outcome, all patch windows remain safe, and the runtime liveness gate is retained.

D82 remains reserve-only. Patch8 remains unauthorized.
