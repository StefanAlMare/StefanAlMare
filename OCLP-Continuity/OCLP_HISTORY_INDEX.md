# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97AC_FINITE_OUTCOME_PARTITION_STATIC_PROVEN_D97AD_FINAL_IDENTITY_MAP_READY.md`.
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
- D71R: service lifecycle and deterministic termination observable through launchd.
- D83: upstream `llvm::Module*`; metadata counters derived internally.
- D93: primary RMP contract.
- D95D: wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN.
- D96C: six-counter state stable at validator REL+0x58B.
- D97JB: REL+0x58B universal for all six late predicates and earliest post-final-write common dominator.

## D97 compiler generation provenance
D97K-T traced MTLCompilerService selection to XPC key `llvmVersion` and proved cached Metal.framework writes it through exact `_xpc_dictionary_set_uint64`.
Selector semantics STATIC PROVEN: 3802 loads MTLCompiler 3802; 32023 loads 32023; other values select no valid path.

## D97U through D97Z
D97U mapped the receiver post-getter boundary with RAX/EAX live. D97V register capture produced repeated SIGILL but no register report. D97Z replaced it with launchd exits 123/124/125. D97X found no safe zero cave; D97Y proved the service in-place block. D97ZA/D97Z FASTLANE and Root Patch FULL PASS.

## D97AA — runtime llvmVersion 32023 PROVEN
Accelerated boot `17:12`; VESA `17:14` excluded.
Twelve MTLCompilerService children produced twelve primary exit 124 results, zero 123, zero 125, zero signals and zero missing exits.
Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`.
H4 (`runtime selects 3802`) rejected for the observed cohort. Unresolved interval returned to `validSimulatorMetadata` entry through REL+0x58B.

## D97AB — CFG map and methodology false negative
D97AB exact read-only map:
- exact D97 -> P7 reconstruction;
- validator 408 instructions / 81 blocks / 75 reachable;
- indirect switch REL+0x279 resolved;
- candidate, three known early errors and two residual finite outcomes mapped;
- shared cave and all six patch windows SAFE.

It marked the partition incomplete only because cycles existed. That cycle-count gate was retired: cyclic SCCs with outgoing paths are not outcomes.

## D97AC — finite-path outcome partition STATIC PROVEN
Wrapper commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`, blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.

Wrapper/core PASS, RC 0. Tarjan SCC and reverse reachability established:
- zero closed nonterminal SCCs;
- zero reachable outside/unresolved edges;
- zero reachable blocks without a path to a classified finite outcome;
- all reachable blocks have a finite outcome path;
- finite-path partition exhaustive STATIC PASS;
- static global termination not claimed because cyclic SCCs exist;
- classifier static ready YES.

Mapped outcomes:
- 110 candidate REL+0x58B;
- 111 buffer index REL+0x29A;
- 112 sampler index REL+0x2D9;
- 113 nested argument buffer REL+0x3E2;
- 114 other early REL+0xB9 or REL+0x6CC.

Cave `0xF80..0xF90` and all six windows SAFE. Shared exit stub `b8010000020f050f0b`.
Classification: whole-stage design STATIC PROVEN with mandatory runtime liveness gate: every spawned service PID must emit exactly one 110–114.

## Required replacement architecture
The classifier must not stack:
- remove D97Z service helper/call and restore selector-only service;
- replace D97 MTL helper/call with the pre-D97 whole-stage classifier;
- retain selector/control/P6/P7.

## D97AD — final identity/source transition mapper ready
Artifact commit `96d91d25f9959666c1ade1df10ff2c3c4dfe0cc8`, blob `536009a4d1ba9497f0a33fdb17f62dfa9a5089c4`.

D97AD is read-only. It calculates the exact final MTL SHA from exact P7 plus six site postimages and the shared stub, verifies non-overlap/disassembly, reconstructs selector-only service, and proves the current D97Z+D97 source state can be transitioned to selector-only+D97AD by replacement rather than stacking.

## CURRENT ACTION
Run D97AD only and return its complete report. Do not Root Patch or reboot. The next FASTLANE requires D97AD full audit.

D82 remains reserve-only; Patch8 unauthorized.
