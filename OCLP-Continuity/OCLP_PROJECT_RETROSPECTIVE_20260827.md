# OCLP PROJECT RETROSPECTIVE — 2026-08-27

Restored reconstruction: 2026-09-01 EEST

## Purpose
This strategic authority separates durable technical progress from invalidated evidence and operational churn, restates the end goal, and fixes the architectural direction.

## End goal
Run macOS Tahoe 26.6.2 / 25G82 on Intel Haswell HD4600 8086:0412, SMBIOS MacBookAir6,2, with stable hardware-accelerated graphical output and a usable GUI.

The objective is not merely to suppress WindowServer aborts or compiler errors. It is to identify and correct the earliest causal incompatibility that prevents the Haswell Metal compiler/pipeline path from completing correctly on Tahoe.

## Durable functional baseline
Exactly five functional patches are the accepted baseline:
1. P1 selector bridge.
2. P2b request-layout bridge `request+0xD0 -> request+0x110`.
3. P3 serialized-bitcode path.
4. AIR00 semantic fallback to AIR 2.6 / Metal 3.1.
5. D34 semantic-equivalent reset.

D22 is SEMANTIC PROVEN for the relevant post-FW AIR 2.6 / Metal 3.1 state.
True-five SHA: `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Golden root-patched MTLCompiler SHA: `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
Golden remains immutable/read-only.

## Durable progress
### Upstream compiler path
The five bridges take Tahoe well beyond initial request/FW handling. Historical diagnostics established progress through patchReflection, runLinking, cleanup and epilogue regions. D50/D68 remain reserve-only because sampling/request-coverage limitations prevented a universal GREEN seal and later evidence established a stronger far frontier.

### Downstream failure correctly reclassified
WindowServer/SkyLight/CopyPipelineState is downstream error handling after compiler XPC interruption:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.
WindowServer is not the root cause.

### Compiler-service frontier
D71R established the compiler-service lifecycle through launchd accounting. D72 and later work moved the frontier into `MTLSimCompiler::validSimulatorMetadata`. Tahoe and working Golden use the same effective donor implementation there, and the immediate caller/handoff is structurally equivalent.

D78D showed the failing request enters `validSimulatorMetadata` but does not return to the caller during the observed lifecycle. D79 mapped the function statically. D80 instrumentation was perturbative and its NULL-tree SIGSEGV was retired after clean-control evidence.

### Resource/metadata region
Static and runtime evidence placed activity in the late simulator/resource-limit family. The crucial strategic question is not merely which late predicate fires, but why unchanged donor code receives a different payload/state than working Sequoia.

## Invalidated or retired work
- D36-D44 overlapped the protected D34 cave and their conclusions were retracted.
- Excessive instruction-by-instruction probing caused unnecessary reboot churn; module-boundary/whole-stage methodology is now mandatory.
- D66/D67 illustrated that cross-PID sampling cannot GREEN-seal request-varying handoffs.
- Multiple collector/build/wrapper bugs were tooling failures, not Haswell semantic evidence.
- D80 was a perturbative instrumentation false frontier.
- D82 remains reserve-only; its execution/plumbing failures did not produce semantic evidence.

## Core architecture principle
Target architecture:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working Sequoia/OCLP donor path -> image`.

Do not patch a final validator merely to tolerate bad Tahoe data. Preserve proven working donor code downstream and normalize at the earliest causal boundary.

The five accepted patches already follow this architecture:
- P1 translates selector semantics.
- P2b translates request layout.
- P3 selects a compatible serialized-bitcode path.
- AIR00 normalizes AIR/Metal semantic versioning.
- D34 repairs semantic state while preserving downstream continuation.

Any further functional patch must be another boundary adapter, not a late error suppressor.

## Hypotheses to discriminate
- H1: Tahoe supplies an `llvm::Module*` whose metadata/resource representation differs from the donor's expected shape.
- H2: module data is equivalent, but an external dependency/runtime ABI/context differs.
- H3: Tahoe generates a semantically different request/shader/module earlier, requiring normalization before the donor receives it.
- H4, introduced by D97 provenance work: the runtime request selects a different MTLCompiler generation than the instrumented visible 32023 donor.

Do not promote a hypothesis to fact without direct evidence.

## Process corrections
1. Prefer read-only/static provenance until runtime observation is strictly necessary.
2. Reuse proven build, privileged-write and launch substrates.
3. Separate diagnostic logic from deployment plumbing.
4. Verify fresh-process provenance before every runtime test.
5. State what new causal information each reboot can provide.
6. Do not spend a reboot on a diagnostic that cannot alter the repair hypothesis.
7. Preserve downstream Golden/Sequoia donor code after a proven handoff.
8. Prefer deterministic launchd exit codes when crash-report register channels are absent.

## Current retrospective application
D95/D95D proved structurally valid wrapped LLVM bitcode. D96C and D97JB proved the late six-counter boundary is stable and universal, but D97H showed zero downstream SIGILL in 32023. D97K-T traced the runtime compiler selector back to XPC key `llvmVersion` and proved cached Metal.framework writes that key.

D97U/V installed a receiver-side terminal capture immediately after `xpc_dictionary_get_uint64`. The accelerated D97W run produced repeated launchd-visible MTLCompilerService SIGILL terminations but no `.ips/.crash` report, so the register channel failed. The next methodology is a universal exact three-way launchd exit-code classifier for `3802`, `32023`, or other, designed only after a read-only safe-cave audit.
