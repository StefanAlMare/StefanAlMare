# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-02 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260902_D97AD_ACCELERATED_0010_VESA_0012_D97AEQ_READY.md`.
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
D97K-T traced MTLCompilerService selection to XPC key `llvmVersion` and proved cached Metal.framework writes it through exact `_xpc_dictionary_set_uint64`. Selector semantics STATIC PROVEN: 3802 loads MTLCompiler 3802; 32023 loads 32023; other values select no valid path.

## D97U through D97Z
D97U mapped the receiver post-getter boundary with RAX/EAX live. D97V register capture produced repeated SIGILL but no register report. D97Z replaced it with launchd exits 123/124/125. D97X found no safe zero cave; D97Y proved the service in-place block. D97ZA/D97Z FASTLANE and Root Patch FULL PASS.

## D97AA — runtime llvmVersion 32023 PROVEN
Accelerated boot `17:12`; VESA `17:14` excluded. Twelve service children produced twelve primary exit 124 results, zero 123, zero 125, zero signals and zero missing exits. Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`; H4 rejected for that cohort.

## D97AB / D97AC — whole-stage finite outcomes
D97AB reconstructed exact P7 and mapped 408 instructions, 81 blocks, 75 reachable blocks and the REL+0x279 switch. D97AC Tarjan SCC/reverse reachability proved zero closed nonterminal SCCs, zero reachable unresolved edges, zero blocks without a classified finite-outcome path, finite-path partition exhaustive STATIC PASS, and all six windows/shared cave safe. Global termination not claimed.

Outcome codes: 110 candidate REL+0x58B; 111 buffer index REL+0x29A; 112 sampler index REL+0x2D9; 113 nested arg buffer REL+0x3E2; 114 other early REL+0xB9 or REL+0x6CC. Mandatory runtime gate: every spawned service PID exactly one exit 110–114.

## D97AD — final transition FULL PASS
D97AD proved selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact P7 reconstruction, six exact non-overlapping postimages, synthetic disassembly PASS and final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Active order `selector -> control -> P6 -> P7 -> D97AD` by replacement.

## D97AEA through D97AEJ — tooling cleanup and Tahoe substrate
Tooling failures were separated from Haswell evidence. D97AEI reproduced historical retained-helper source hashes with `ast.get_source_segment`. D97AEJ classified dirty `metal_3802.py` as required historical Tahoe compiler substrate (blob `2ea2a73c...`, SHA256 `fe751967...`), authorizing three tracked source files.

## Private D97AD snapshot/build/deploy — FULL PASS
Exact snapshot pushed to private `StefanAlMare/Private-Work`, branch `oclp7-d97ad-github-build`, commit `1faab13865eb945198f3551688f11f1ba645e29a`. GitHub Actions run `33553271179`, Intel runner, succeeded. Artifact `9818489515`; inner zip SHA `c795147...`; packaged executable SHA `5a214ab...`. Packaged audit proved D97Z/D97 absent, D97AD exactly once and Tahoe substrate PASS.

D97AEO/D97AEP downloaded, audited and deployed the exact app. Live `/Applications/OpenCore-Patcher.app` executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`; D97Z backup retained.

## D97AD manual Root Patch — FULL PASS
Transcript proved selector, P2b, P3, AIR00, D34, true-five, P6, P7, D97AD exact final MTL SHA `524a16...`; D97Z and D97 absent. Patch completed through AKC/APFS snapshot/unmount without error.

## D97AD accelerated boot — 2026-09-02 00:10 selected
User returned through VESA and supplied chronology:
- `00:10` accelerated D97AD boot SELECTED;
- `00:12` VESA recovery EXCLUDED;
- `00:09` shutdown transition;
- older 23:37 entries excluded.

Accelerated WindowServer crash anchor: PID 394, launched 00:11:32.9517, crashed 00:11:47.9888, boot UUID `B6B4D4C3-D751-4FB0-AE64-2AF8AA1B9CC0`, COREANIMATION code 4 with `XPC_ERROR_CONNECTION_INTERRUPTED` after multiple retries. GPUCompiler 32023 libraries were loaded. This retains the established downstream causal chain and does not determine the classifier outcome.

## D97AEQ — read-only D97AD outcome audit ready
Artifact `OCLP7_D97AEQ_READONLY_D97AD_ACCELERATED_WHOLE_STAGE_EXIT_AUDIT.command`:
- commit `c3da3efe2e53c2e74703df7d0385415df0b4eeb4`;
- blob `463d30a4e3b640994e68bebebc91a01e14fd2be9`.

It verifies visible selector-only service SHA and D97AD MTL SHA/postimages, then audits only `00:10:00..00:12:00`, enumerates every service spawn/exit, enforces the liveness gate, prints code histogram/sequence 110–114 and correlates WindowServer PID 394. Entirely read-only.

## CURRENT ACTION
Run D97AEQ only and return the complete report. Do not Root Patch or reboot. Runtime result is valid only if every spawned MTLCompilerService PID has exactly one classifier exit 110–114 and no signal/other/missing exit.

D82 remains reserve-only; Patch8 unauthorized.
