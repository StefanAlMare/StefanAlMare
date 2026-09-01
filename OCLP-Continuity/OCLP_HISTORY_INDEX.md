# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97AA_RUNTIME_LLVMVERSION_32023_PROVEN_D97AB_WHOLE_STAGE_MAP_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.
Repository recovery: `OCLP_REPOSITORY_RECOVERY_20260901.md`.

## Permanent protocol
Identity-pinned FASTLANE -> complete audit -> manual Root Patch -> complete audit -> accelerated boot -> VESA recovery -> analyze only immediately preceding accelerated boot -> persist. Golden immutable/read-only. No automatic Root Patch/reboot. Missing `.ips` alone never hard negative. Control-flow is not semantic proof.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34.
True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Golden SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
D34 cave protected. P6/P7 retained, sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized.

## Major durable milestones
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D69/D70: WindowServer downstream of compiler XPC failure.
- D71R: service lifecycle/termination observable through launchd.
- D83: upstream `llvm::Module*`; resource counters derived internally.
- D93: primary RMP contract.
- D95D: 14/14 deliberate SIGILL; wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN.
- D96C: six-counter state stable at validator REL+0x58B.
- D97JB: REL+0x58B universal for all six late predicates and earliest post-final-write common dominator.

## D97 compiler-version provenance
D97K-T traced the receiver selector to XPC key `llvmVersion` and proved cached Metal.framework writes the key through exact `_xpc_dictionary_set_uint64`.
Selector semantics STATIC PROVEN:
- 3802 loads MTLCompiler 3802;
- 32023 loads MTLCompiler 32023;
- other values select no valid path.

## D97U/V/W register capture
D97U mapped exact post-getter boundary at service fileoff `0x25C3` with RAX/EAX live.
D97V/VA FASTLANE and manual Root Patch FULL PASS; installed service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`.
D97W found no in-window crash-register report, but repeated launchd SIGILL terminations. Register channel NEGATIVE; SIGILL channel POSITIVE_REPEATED.

## D97X/Y/Z deterministic exit methodology
Universal launchd-visible classifier:
- exit 123 = 3802;
- exit 124 = 32023;
- exit 125 = other.

D97X: no safe executable zero cave, valid STATIC NEGATIVE.
D97Y: safe in-place block `0x25C3..0x25EB`, exact classifier plus four NOPs, no inbound target/xref/symbol, final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.
D97ZA/D97Z FASTLANE FULL PASS; D97V replaced, not stacked; downstream D97 retained; app SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.
D97Z manual Root Patch FULL PASS; selector/true-five/P6/P7/D97/AuxKC/APFS snapshot all retained and verified.

## D97AA — runtime llvmVersion 32023 PROVEN
Artifact `OCLP7_D97AA_READONLY_ACCELERATED_EXIT_CLASSIFIER_LAUNCHD_AUDIT.command`:
- commit `dec4a51d8b62e3e4d243b3763a7c56c0975ca60e`;
- blob `1af7ea1b5438a3e447e7df821b4eb94228402206`.

Accelerated boot `17:12`; VESA `17:14` excluded.
D97AA verified exact D97Z service/block and classified 12 unique MTLCompilerService children for WindowServer PID 177.

Explicit primary launchd outcomes:
- exit 123: 0;
- exit 124: 12;
- exit 125: 0;
- signal: 0;
- spawn without explicit exit: 0.

Service PIDs: `323,326,328,331,334,337,340,343,351,353,357,361`.
The 33 additional parser `unknown` entries are duplicate ancillary lifecycle lines, not independent process outcomes.

Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`. No request variation.
H4 (`runtime selects 3802`) is rejected for the observed accelerated cohort. D97H zero downstream marker is therefore not explained by compiler generation selection.

## D97AB — pre-D97 validator whole-stage mapper ready
Artifact `OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP.command`:
- commit `e0519e5b38c029e5bfd6ba141c422b43ca64246e`;
- blob `366fb2a45895723d103b7edb31679a4cd5dd9a16`.

D97AB is read-only. It reconstructs exact P7 from current D97 in a temporary copy, rebuilds the full `validSimulatorMetadata` CFG including the REL+0x279 indirect switch, and attempts an exhaustive partition before REL+0x58B into candidate reached, three known early metadata errors, and any other early terminal outcomes. It also audits the reusable D97 cave and complete-instruction terminal windows for a possible universal whole-stage launchd classifier.

## CURRENT ACTION
Run D97AB only and return its complete report. Do not Root Patch or reboot. Any FASTLANE requires subsequent full assistant audit and explicit authorization.

D82 remains reserve-only; Patch8 unauthorized.
