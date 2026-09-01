# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-02 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260902_D97AEQ_28_OF_28_EXIT1_CLASSIFIER_ZERO_RUNTIME_INVALID.md`.
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
D97U mapped receiver post-getter RAX/EAX. D97V register capture produced repeated SIGILL but no register report. D97Z replaced it with launchd exits 123/124/125. D97AA later proved all 12 observed requests selected 32023.

## D97AB / D97AC — static whole-stage map
D97AB mapped `validSimulatorMetadata`; D97AC proved finite-path partition exhaustive STATIC PASS with no closed nonterminal SCC and no unresolved reachable edges. Outcomes: 110 candidate REL+0x58B; 111 buffer-index; 112 sampler-index; 113 nested arg-buffer; 114 other early return/unwind. Runtime liveness gate required every service PID exactly one 110–114.

## D97AD — exact transition FULL PASS
D97AD proved selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, with six exact terminal postimages and shared stub. Active order `selector -> control -> P6 -> P7 -> D97AD` by replacement.

## D97AEA through D97AEJ — tooling cleanup / Tahoe substrate
Tooling failures were separated from Haswell evidence. D97AEI reproduced retained-helper hashes through `ast.get_source_segment`. D97AEJ classified `metal_3802.py` as required historical Tahoe compiler substrate, authorizing three tracked source files.

## Private D97AD build/deploy — FULL PASS
Snapshot commit `1faab13865eb945198f3551688f11f1ba645e29a` built successfully in private GitHub Actions run `33553271179`. Artifact `9818489515`; packaged/live D97AD executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`. D97AEO/D97AEP exact download/audit/deploy FULL PASS; D97Z app backup retained.

## D97AD manual Root Patch — FULL PASS
Transcript proved selector, P2b, P3, AIR00, D34, P6, P7 and exact D97AD final MTL SHA; D97Z/D97 absent. Root Patch completed through AKC/APFS snapshot/unmount.

## Accelerated D97AD boot selected
`2026-09-02 00:10` accelerated boot selected; `00:12` VESA recovery excluded. WindowServer PID 394 crash at `00:11:47.9888`, COREANIMATION code 4, `XPC_ERROR_CONNECTION_INTERRUPTED`, retains downstream failure model.

## D97AEQ — decisive runtime coverage failure
D97AEQ verified visible selector-only service SHA, exact D97AD MTL SHA, six site postimages and shared stub. The selected accelerated window contained 28 unique MTLCompilerService spawns and 28 exact launchd exit records.

Runtime result:
- 110=0;
- 111=0;
- 112=0;
- 113=0;
- 114=0;
- signals=0;
- missing exits=0;
- natural exit(1)=28/28.

Classification: D97AEQ audit PASS; visible D97AD identity PASS; classifier execution NEGATIVE for observed cohort; liveness gate FAIL; whole-stage outcome classification INVALID; natural service exit(1) RUNTIME PROVEN 28/28.

Fatal WindowServer PID 394 hosted 12 compiler-service children, all exit(1). Final child PID 441 exited `00:11:47.968`, ~20.8 ms before WindowServer crash `00:11:47.9888`.

Every observed service emitted an MTLCompiler diagnostic before exit(1) containing `...supported in the simulator but ... were used`; a common `STRING sz:9` decode mismatch appears for all PIDs, with extra size-24 variants on PIDs 347/380/433.

D97AC remains a STATIC CFG proof only; D97AEQ disproves the runtime coverage assumption for the observed execution. Executed-code provenance versus visible patched-file identity is unresolved.

## CURRENT ACTION
Run a read-only D97AER provenance mapper: map the pre-exit diagnostic strings/xrefs in visible 32023, compare 3802, and search the selected historical unified-log window for explicit compiler load/path provenance. No Root Patch/reboot. D82 reserve-only; Patch8 unauthorized.
