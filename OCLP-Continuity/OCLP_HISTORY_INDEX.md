# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97AB_CYCLE_CRITERION_FALSE_NEGATIVE_D97AC_SCC_AUDIT_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.
Repository recovery: `OCLP_REPOSITORY_RECOVERY_20260901.md`.

## Permanent protocol
Identity-pinned FASTLANE -> complete audit -> manual Root Patch -> complete audit -> accelerated boot -> VESA recovery -> analyze only immediately preceding accelerated boot -> persist. Golden immutable/read-only. No automatic Root Patch/reboot. Missing `.ips` alone never hard negative. Control-flow is not semantic proof.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34.
True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Golden SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
D34 cave protected. P6/P7 retained, sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized.

## Durable milestones
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D69/D70: WindowServer downstream of compiler XPC failure.
- D71R: service lifecycle/termination observable through launchd.
- D83: upstream `llvm::Module*`; counters derived internally.
- D93: primary RMP contract.
- D95D: wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN.
- D96C: six-counter state stable at validator REL+0x58B.
- D97JB: REL+0x58B universal for all six late predicates and earliest post-final-write common dominator.

## D97 compiler-version provenance
D97K-T traced the selector to XPC key `llvmVersion` and proved cached Metal.framework writes it through exact `_xpc_dictionary_set_uint64`.
Selector semantics STATIC PROVEN: 3802 loads MTLCompiler 3802; 32023 loads 32023; other values select no valid path.

## D97U through D97Z
D97U mapped the post-getter boundary at service fileoff `0x25C3` with RAX/EAX live.
D97V register capture produced repeated SIGILL but no accessible register report.
A deterministic launchd classifier replaced it:
- exit 123 = 3802;
- exit 124 = 32023;
- exit 125 = other.
D97X found no safe zero cave. D97Y proved the safe in-place block `0x25C3..0x25EB`.
D97ZA/D97Z FASTLANE and manual Root Patch FULL PASS; committed service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.

## D97AA — runtime llvmVersion 32023 PROVEN
Accelerated boot `17:12`; VESA `17:14` excluded.
Twelve unique MTLCompilerService children for WindowServer PID 177 produced twelve primary `exit(124)` results, with zero 123, zero 125, zero signals and zero spawned PIDs without an exit.
Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`.
H4 (`runtime selects 3802`) rejected for the observed cohort. The unresolved interval returned to `validSimulatorMetadata` entry through REL+0x58B.

## D97AB — static mapper result
Artifact commit `e0519e5b38c029e5bfd6ba141c422b43ca64246e`, blob `366fb2a45895723d103b7edb31679a4cd5dd9a16`.

D97AB read-only PASS:
- exact D97 -> P7 reconstruction;
- exact validator symbol/range;
- 408 instructions, 81 blocks, 75 reachable;
- indirect switch REL+0x279 resolved;
- candidate and three early error outcomes reachable;
- residual finite terminals B10 and B80;
- shared cave and all six mapped patch windows SAFE.

It also found two cyclic regions. Its partition gate incorrectly required zero cycles, so it returned incomplete. This is a methodology false negative until SCC condensation is done: loops with exits are not independent outcomes. D97AB did not prove a runtime unknown path and did not authorize integration.

## D97AC — SCC/sink audit ready
Wrapper `OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER.command`:
- commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`;
- blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.

D97AC is pinned to the exact D97AB core and replaces only the flawed partition method with:
- Tarjan SCC analysis;
- closed nonterminal SCC detection;
- reverse finite-outcome reachability;
- reachable unresolved/outside edge checks;
- residual terminal inbound/raw-byte provenance;
- explicit separation of finite-path coverage from a loop-termination claim.

Any future runtime classifier must require exactly one classifier exit for every spawned service PID; a missing classifier exit invalidates the runtime run.

## CURRENT ACTION
Run D97AC only and return both complete reports. Do not Root Patch or reboot. FASTLANE design requires full assistant audit and explicit authorization.

D82 remains reserve-only; Patch8 unauthorized.
