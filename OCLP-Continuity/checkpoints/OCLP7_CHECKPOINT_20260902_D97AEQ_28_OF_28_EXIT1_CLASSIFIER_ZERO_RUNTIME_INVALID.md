# OCLP7 CHECKPOINT — 2026-09-02 — D97AEQ 28/28 natural exit(1), zero 110–114

## Selected runtime cohort
Authoritative accelerated boot remains `2026-09-02 00:10`; VESA recovery `00:12` is excluded. Runtime-log window is `00:10:00 <= t < 00:12:00` EEST. Fatal WindowServer anchor is PID 394, crash `00:11:47.9888`, boot UUID `B6B4D4C3-D751-4FB0-AE64-2AF8AA1B9CC0`.

## D97AEQ visible identity — PASS
Read-only D97AEQ verified:
- selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- all six exact D97AD terminal-site postimages PASS;
- shared Darwin exit stub at fileoff `0xF80` exact PASS.

Therefore the currently visible root-patched files are exactly the intended D97AD postimages.

## Runtime result — liveness gate FAIL
D97AEQ observed:
- 28 MTLCompilerService spawn events;
- 28 unique spawned service PIDs;
- 28 exact launchd `exited due to` events;
- zero missing exit records;
- zero signals;
- zero exits 110,111,112,113,114;
- every one of the 28 PIDs terminated by normal `exit(1)`.

Histogram: 110=0, 111=0, 112=0, 113=0, 114=0.
`CLASSIFIED_PID_COUNT=0`; `INVALID_PID_COUNT=28`.

Authoritative classification:
- `D97AEQ_AUDIT_TOOL_EXECUTION=PASS`;
- `D97AD_VISIBLE_DISK_IDENTITY=PASS`;
- `D97AD_CLASSIFIER_EXIT_EXECUTION_FOR_OBSERVED_COHORT=NEGATIVE`;
- `D97AD_RUNTIME_LIVENESS_GATE=FAIL`;
- `D97AD_WHOLE_STAGE_OUTCOME_CLASSIFICATION=INVALID`;
- `NATURAL_MTLCOMPILERSERVICE_EXIT1=RUNTIME_PROVEN_28_OF_28`.

Do not infer that candidate/buffer/sampler/nested/early-return outcome was selected. The classifier did not establish execution of any terminal site.

## Fatal WindowServer same-host lane
WindowServer PID 394 spawned 12 observed compiler-service children: 408,410,412,413,426,428,429,432,433,435,437,441. All 12 terminated with natural `exit(1)` and none emitted 110–114.

The final child PID 441 terminated at `00:11:47.968`; WindowServer PID 394 crashed at `00:11:47.9888`, about 20.8 ms later with COREANIMATION `XPC_ERROR_CONNECTION_INTERRUPTED`. This strongly corroborates the retained causal ordering `MTLCompilerService failure -> XPC interruption -> pipeline creation abort -> WindowServer death` for the exact fatal host lane.

## Runtime log clue
Every observed service PID logged an MTLCompiler message immediately before exit(1) containing the fragment `...supported in the simulator but ... were used`; unified-log decoding shows a repeated `STRING sz:9` mismatch, and PIDs 347, 380 and 433 additionally show two `STRING sz:24` variants before the common size-9 message.

This is new causal evidence because the natural compiler diagnostic appears before each exit(1), while none of the six D97AD terminal patches fires.

## Interpretation boundary
The static D97AC finite-path proof is retained as a proof about the mapped 32023 `validSimulatorMetadata` CFG. D97AEQ demonstrates that the intended terminal-classifier coverage assumption does not hold for the actual observed runtime execution. Plausible explanations to discriminate, without promoting any to fact:
1. runtime does not execute the patched MTLCompiler image/copy despite visible-file identity;
2. the logged failure occurs in another compiler generation/copy or another function before the mapped validator outcomes;
3. static CFG/outcome mapping missed a runtime-relevant path/indirection;
4. a runtime loader/cache/provenance distinction separates the visible patched file from executed code.

## CURRENT SINGLE NEXT ACTION
Perform a read-only D97AER provenance mapper. It must:
- verify current D97AD visible identities;
- locate every static string in visible MTLCompiler 32023 containing `supported in the simulator` / `were used` and map all xrefs to symbols/functions and `validSimulatorMetadata` relative offsets where applicable;
- compare occurrence/xref structure against visible MTLCompiler 3802 when available;
- search the selected accelerated unified-log window for explicit 32023/3802 MTLCompiler load/path provenance without mutating or launching services;
- correlate the universal pre-exit diagnostic with static candidate functions.

No Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
