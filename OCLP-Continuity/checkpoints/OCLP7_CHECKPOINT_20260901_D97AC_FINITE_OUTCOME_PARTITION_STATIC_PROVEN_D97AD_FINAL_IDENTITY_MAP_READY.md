# OCLP7 CHECKPOINT — 2026-09-01 — D97AC finite-outcome partition STATIC PROVEN / D97AD final identity map ready

## Retained runtime facts
D97AA remains decisive for the observed accelerated cohort:
- 12 unique MTLCompilerService children;
- 12 primary `exit(124)` results;
- zero `123`, zero `125`, zero signal exits and zero spawned PIDs without an explicit exit.

Therefore runtime `llvmVersion=32023` is PROVEN for all 12 observed requests, and selection of compiler generation 3802 is rejected for this cohort. The unresolved causal interval is inside `MTLSimCompiler::validSimulatorMetadata(llvm::Module*)`, from entry through but not including REL+`0x58B`.

## D97AC artifact and wrapper audit
Wrapper:
`OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER.command`
- commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`;
- blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.

Wrapper gates all passed:
- exact D97AB base blob identity;
- transform PASS;
- generated core zsh parse PASS;
- embedded Python compile PASS;
- required anchors present;
- retired cycle-count false-negative logic absent;
- static contract audit PASS.

Core remained strictly read-only and completed with RC 0.

## Exact binary/CFG identity retained
D97AC reconstructed exact P7 from current D97:
- current D97 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`;
- reconstructed P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

Validator identity:
- start `0x7FFB162C7132`;
- end `0x7FFB162C7830`;
- 408 instructions;
- 81 basic blocks;
- 75 reachable blocks;
- indirect switch at REL+`0x279` resolved.

Known finite outcomes:
- exit `110`: candidate/D97 boundary REL+`0x58B`;
- exit `111`: buffer-index error REL+`0x29A`;
- exit `112`: sampler-index error REL+`0x2D9`;
- exit `113`: nested argument-buffer error REL+`0x3E2`;
- exit `114`: other early finite outcomes at REL+`0xB9` and REL+`0x6CC`.

## SCC-hardened finite-outcome proof
Two cyclic SCCs exist, but both have outgoing edges and reach classified finite outcomes. D97AC did not claim global loop termination.

Decisive gates:
- `CLOSED_NONTERMINAL_SCC_COUNT=0`;
- `REACHABLE_OUTSIDE_OR_UNRESOLVED_EDGE_COUNT=0`;
- `BLOCKS_WITHOUT_PATH_TO_CLASSIFIED_FINITE_OUTCOME_COUNT=0`;
- `ALL_REACHABLE_BLOCKS_HAVE_CLASSIFIED_FINITE_OUTCOME_PATH=PASS`;
- `FINITE_PATH_OUTCOME_PARTITION_EXHAUSTIVE_STATIC=PASS`;
- `STATIC_TERMINATION_PROOF=NOT_CLAIMED_CYCLIC_SCCS_PRESENT`;
- `SCC_HARDENED_CLASSIFIER_STATIC_READY=YES`.

Classification: **finite-path outcome partition STATIC PROVEN**. This supersedes the D97AB cycle-count methodology false negative.

## Shared stub and six patch windows
Shared cave `0xF80..0xF90`:
- zero preimage PASS;
- no direct target, RIP-relative target or symbol;
- shared exit stub `b8010000020f050f0b`;
- cave safety PASS.

All complete-instruction terminal windows are SAFE:
- candidate REL+`0x58B`, exit 110, postimage `6a6e5fe9bb38f6ff90`;
- buffer REL+`0x29A`, exit 111, postimage `6a6f5fe9ac3bf6ff90909090`;
- sampler REL+`0x2D9`, exit 112, postimage `6a705fe96d3bf6ff9090`;
- nested REL+`0x3E2`, exit 113, postimage `6a715fe9643af6ff90`;
- normal early return REL+`0xB9`, exit 114, postimage `6a725fe98d3df6ff9090`;
- unwind/cleanup REL+`0x6CC`, exit 114, postimage `6a725fe97a37f6ff90909090`.

D97AC classification:
`STATIC_PROVEN_FOR_FASTLANE_DESIGN_ONLY_WITH_RUNTIME_LIVENESS_GATE`.

Mandatory runtime liveness gate:
**every spawned MTLCompilerService PID must emit exactly one exit 110–114; any missing classifier exit, signal exit or other exit invalidates the runtime classification.**

## Required integration architecture
The next diagnostic must not be stacked:
1. remove the terminal D97Z service classifier so Root Patch leaves MTLCompilerService at the selector-only image;
2. replace the downstream D97 MTLCompiler snapshot with the D97AD whole-stage classifier because it reuses D97's site/cave;
3. retain selector, true-five control, P6 and P7 unchanged.

## D97AD mapper ready
Artifact:
`OCLP7_D97AD_READONLY_PRE_D97_WHOLE_STAGE_FINAL_IMAGE_AND_SOURCE_TRANSITION_MAP.command`
- commit `96d91d25f9959666c1ade1df10ff2c3c4dfe0cc8`;
- blob `536009a4d1ba9497f0a33fdb17f62dfa9a5089c4`.

D97AD is strictly read-only. It will:
- verify the exact live D97Z app/service and D97 MTLCompiler;
- reconstruct exact selector-only service and exact P7 MTLCompiler;
- verify all six exact preimages and postimages;
- verify no overlap with D34, P6 or P7;
- build the synthetic final MTL image and print its exact SHA;
- disassemble all six synthetic site heads;
- map the exact current OCLP helper/call cardinality and order;
- prove the planned simultaneous transition: remove D97Z service helper/call and replace D97 helper/call with D97AD, not stacked.

## CURRENT SINGLE NEXT ACTION
Run D97AD only and return its complete report:
`OCLP7_D97AD_READONLY_PRE_D97_WHOLE_STAGE_FINAL_IMAGE_AND_SOURCE_TRANSITION_MAP_REPORT.txt`.

Do not Root Patch or reboot. The FASTLANE will be built only after the exact final MTL SHA and source-transition preimage are audited.

D82 remains reserve-only. Patch8 remains unauthorized.
