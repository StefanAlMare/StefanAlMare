# OCLP7 CHECKPOINT — 2026-09-01 — D97AD final identity PASS / D97AEA FASTLANE ready

## Retained causal state
D97AA proved that all 12 observed accelerated MTLCompilerService requests carried runtime `llvmVersion=32023`; compiler-generation selection no longer explains the missing downstream D97 marker.

D97AC proved the finite-path outcome partition inside `MTLSimCompiler::validSimulatorMetadata(llvm::Module*)` from entry through REL+`0x58B`:
- zero closed nonterminal SCCs;
- zero reachable outside/unresolved edges;
- zero reachable blocks without a path to a classified finite outcome;
- all six terminal windows and the shared exit-stub cave are safe;
- global loop termination is not claimed;
- runtime liveness gate remains mandatory.

## D97AD read-only result — FULL PASS
Artifact:
- `OCLP7_D97AD_READONLY_PRE_D97_WHOLE_STAGE_FINAL_IMAGE_AND_SOURCE_TRANSITION_MAP.command`;
- commit `96d91d25f9959666c1ade1df10ff2c3c4dfe0cc8`;
- blob `536009a4d1ba9497f0a33fdb17f62dfa9a5089c4`.

Exact live preimages verified:
- D97Z app SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`;
- D97Z MTLCompilerService SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- D97 MTLCompiler 32023 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`;
- branch `alex-tahoe-25G82-custom`, HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.

Exact transitions:
- D97Z service block removal reconstructs selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97 site/cave removal reconstructs P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
- all six site preimages/postimages and the shared stub were exact;
- no overlap with D34, P6, P7 or another D97AD site;
- synthetic site disassembly PASS;
- exact final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

Outcome transport:
- exit 110 = candidate/D97 boundary REL+`0x58B`;
- exit 111 = buffer-index error REL+`0x29A`;
- exit 112 = sampler-index error REL+`0x2D9`;
- exit 113 = nested argument-buffer error REL+`0x3E2`;
- exit 114 = normal early return REL+`0xB9` or unwind/cleanup REL+`0x6CC`.

Current source preimage was also proven exactly:
`selector -> D97Z -> control -> P6 -> P7 -> D97`.
Planned target order:
`selector -> control -> P6 -> P7 -> D97AD`.

Classification:
- `D97AD_SERVICE_D97Z_REMOVAL_TO_SELECTOR_ONLY=STATIC_PROVEN`;
- `D97AD_MTL_D97_REPLACEMENT_BY_WHOLE_STAGE_CLASSIFIER=STATIC_PROVEN`;
- `D97AD_FASTLANE_DESIGN_AUTHORIZED=YES_WITH_RUNTIME_LIVENESS_GATE`.

## D97AE/D97AEA FASTLANE artifact ready
Wrapper:
- `OCLP7_D97AEA_DIRECT_PINNED_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_FASTLANE_WRAPPER.command`;
- commit `5c2510b2e6c3ee613f44afecf96b1f57e1ff8515`;
- blob `35c8328caf111a5f57e4a5cc656ada1f38ce6f83`.

Pinned payload:
- payload commit `473d4bab1571e2a8907d3ae500fb88e5fd9639c0`;
- part blobs `bcfcc00786676f3d946e9782f4fe94f3980b392d`, `a389b2eedcd1960475de0ddd3024b0afaec6f930`, `c34f26b9a111aef8926ee49cfaa0f6fa4edd8423`, `c74b2b02171f1c38669f6b45f8f0bf14aa7a9d17`;
- decompressed core SHA256 `d8166ed5697cf281a60b19dba4c902470c4900de740006431d7cff5580fa5bb6`.

FASTLANE contract:
1. reverify exact app/service/MTL/source identities;
2. prove offline D97Z -> selector-only and D97 -> P7 -> D97AD;
3. remove D97Z helper/call completely;
4. replace D97 helper/call with D97AD, not stacked;
5. retain selector/control/P6/P7 byte-identical;
6. compile and audit only the two allowed tracked source files;
7. build the app;
8. audit the packaged PyInstaller code objects and active call order;
9. back up and deploy the app, verify SHA and fresh-process provenance;
10. stop without Root Patch or reboot.

## Mandatory runtime gate after a future authorized Root Patch
Every spawned MTLCompilerService PID must emit exactly one primary classifier exit in 110–114. Any missing exit, signal exit, other code or ambiguous process pairing invalidates the runtime classification.

## CURRENT SINGLE NEXT ACTION
Run D97AEA only and return both complete reports:
- `OCLP7_D97AEA_DIRECT_PINNED_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_FASTLANE_WRAPPER_REPORT.txt`;
- `OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_REPORT.txt`.

Do not Root Patch or reboot even if FASTLANE reports PASS. Manual Root Patch requires a separate full assistant audit.

D82 remains reserve-only. Patch8 remains unauthorized.
