# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97AEB_MATCHER_FALSE_NEGATIVE_D97AEC_READY.md`.
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

## D97AB / D97AC — whole-stage finite outcomes
D97AB reconstructed exact P7 and mapped 408 instructions, 81 blocks, 75 reachable blocks and the REL+0x279 switch. It found candidate REL+0x58B, three known early errors, two residual finite outcomes, safe cave and six safe patch windows. Its zero-cycle exhaustiveness gate was a methodology false negative.

D97AC wrapper commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`, blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.
Tarjan SCC and reverse reachability proved:
- zero closed nonterminal SCCs;
- zero reachable outside/unresolved edges;
- zero blocks without a classified finite-outcome path;
- finite-path partition exhaustive STATIC PASS;
- static global termination not claimed;
- all six windows and shared exit-stub cave safe.

Outcome codes:
- 110 candidate REL+0x58B;
- 111 buffer index REL+0x29A;
- 112 sampler index REL+0x2D9;
- 113 nested argument buffer REL+0x3E2;
- 114 other early REL+0xB9 or REL+0x6CC.
Mandatory runtime liveness gate: every spawned service PID must emit exactly one 110–114.

## D97AD — final identity/source transition FULL PASS
Artifact commit `96d91d25f9959666c1ade1df10ff2c3c4dfe0cc8`, blob `536009a4d1ba9497f0a33fdb17f62dfa9a5089c4`.
D97AD proved selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact P7 reconstruction, six exact non-overlapping postimages, synthetic disassembly PASS and final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Planned active order is `selector -> control -> P6 -> P7 -> D97AD`, by replacement rather than stacking.

## D97AEA — expected-SHA map false failure
Wrapper commit `5c2510b2e6c3ee613f44afecf96b1f57e1ff8515`, blob `35c8328caf111a5f57e4a5cc656ada1f38ce6f83`; original core SHA256 `d8166ed5697cf281a60b19dba4c902470c4900de740006431d7cff5580fa5bb6`.
D97AEA passed identity, offline transition, all six postimages, non-overlap, final SHA and disassembly, then stopped before source integration because its expected P6/P7 helper-SHA association rejected the authoritative P6 segment SHA `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0d545f0da06c13a`.

## D97AEB — matcher false negative
D97AEB verified all payloads, original core SHA and the unique `PYINTEGRATE` owner block, but its regex found zero P6 entries because it assumed only narrow dict/tuple textual forms. It did not modify or execute the core and did not reach integration, build or deploy.

## D97AEC — AST semantic correction ready
Artifact `OCLP7_D97AEC_AST_SEMANTIC_P6_P7_SHA_BINDING_FIX_WRAPPER.command`:
- commit `d6b90d246ce10481295e225d4fee99d588ddbe1c`;
- blob `e638b2eab6f590fb20e80524de8fab28e974ece9`;
- branch `d97aec-ready`.

D97AEC reconstructs the exact original core, parses the unique failing Python owner block with AST, semantically binds P6/P7 helper identities to their expected SHA literals across assignment/dict/tuple/list/call forms, refuses ambiguous matches, changes only the two bound SHA literals, proves all other owner-block text unchanged, recompiles and parses the generated core, preserves all D97AE runtime/source-transition anchors, and executes the complete D97AE FASTLANE. No automatic Root Patch or reboot.

## CURRENT ACTION
Run D97AEC only and return:
- `OCLP7_D97AEC_AST_SEMANTIC_P6_P7_SHA_BINDING_FIX_WRAPPER_REPORT.txt`;
- `OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_REPORT.txt`.

Do not Root Patch or reboot even on PASS. Manual Root Patch requires a separate assistant audit.

D82 remains reserve-only; Patch8 unauthorized.
