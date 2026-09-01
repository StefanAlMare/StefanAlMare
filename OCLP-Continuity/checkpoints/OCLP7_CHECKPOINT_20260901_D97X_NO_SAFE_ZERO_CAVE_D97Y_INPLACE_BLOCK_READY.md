# OCLP7 CHECKPOINT — 2026-09-01 — D97X no safe zero cave / D97Y in-place block mapper ready

## Retained runtime question
The exact fatal-request `llvmVersion` remains UNKNOWN.

Retained selector semantics:
- `3802` selects MTLCompiler 3802;
- `32023` selects MTLCompiler 32023;
- any other value selects no valid compiler path.

D97W established that the register-report channel is unavailable on this machine while launchd repeatedly reports MTLCompilerService SIGILL termination. The accepted replacement methodology is deterministic launchd-visible normal exit accounting:
- exit 123 = EAX exactly 3802;
- exit 124 = EAX exactly 32023;
- exit 125 = other.

## D97X artifact and observed result
`OCLP7_D97X_READONLY_EXIT_CODE_CLASSIFIER_CAVE_SAFETY_AND_DESIGN_MAP.command`
- commit `09d9a64bbf8789a3227693adec37c3d06551ee53`;
- blob `71bd9caedd19b71d16637d9bdbd5263930824192`.

D97X was strict read-only and returned PASS as a mapper.

Identity gates:
- product/build `26.6.2 / 25G82`;
- visible current service SHA exact D97V `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`;
- visible site12 at `0x25C3` exact `0f0b9090909090b9000000c0`;
- reconstruction to selector-only bytes `4c89b558ffffffb9000000c0` produced exact selector-only SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Mach-O/code map:
- `__TEXT` file `0x0..0x4000`, VM `0x100000000..0x100004000`;
- executable `__TEXT,__text` file `0x23C0..0x360A`, VM `0x1000023C0..0x10000360A`;
- classifier/capture site VM `0x1000025C3`.

Static cave result:
- 1329 disassembled instructions;
- 225 direct branch/call targets;
- 59 RIP-relative targets;
- 68 symbol addresses;
- executable zero-runs of at least 48 bytes in `__TEXT,__text`: `0`;
- safe cave candidates: `0`.

Authoritative classification:
- `D97X_RESULT=NO_STATICALLY_SAFE_EXECUTABLE_ZERO_CAVE_FOUND`;
- `D97X_EXIT_CLASSIFIER_AUTHORIZED=NO`;
- this is a valid STATIC NEGATIVE for the cave-placement architecture, not a tooling failure and not a negative for the classifier semantics themselves.

## Methodology decision after D97X
Do not weaken cave requirements, use a data/non-executable section, expand into stubs, or repurpose unproved bytes.

The permanent terminal-instrumentation rule permits replacing a contiguous sequence of complete original instructions when:
1. the diagnostic is explicitly terminal and makes no pass-through claim;
2. the replacement begins at the already-proven first instruction after `xpc_dictionary_get_uint64`;
3. the overwritten interval ends exactly at an instruction boundary;
4. no direct branch/call target, RIP-relative xref, symbol or function boundary enters its interior;
5. selector paths and all bytes outside the interval remain exact.

The known straight-line block after the getter appears large enough for the 36-byte classifier, but this must be statically proven before integration.

## D97Y artifact
`OCLP7_D97Y_READONLY_INPLACE_TERMINAL_CLASSIFIER_BLOCK_SAFETY_MAP.command`
- commit `4e3d2333d1d28350295ce2710e82431edba1ed3f`;
- blob `549c894920b9fb1d688272f6b50034b3763bcf55`.

D97Y is strict read-only. It:
1. verifies exact current D97V identity and reconstructs exact selector-only service;
2. disassembles the selector-only image and finds the minimum complete-instruction interval beginning at fileoff `0x25C3` that can hold the 36-byte classifier;
3. requires the expected straight-line instruction identities and an exact end boundary;
4. audits all direct targets, RIP-relative targets, symbols and containing-symbol boundaries for the whole overwrite interval;
5. verifies exact classifier bytes, all rel8 destinations, five semantic test values, Darwin exit syscall encoding, universal/no-PID and terminal/no-pass-through contracts;
6. pads only within the proven complete-instruction interval, derives deterministic final SHA, retains both selector paths and the next untouched instruction, and disassembles the synthetic postimage;
7. performs no source/system/Golden mutation, integration, build, deployment, Root Patch, reboot, service launch, D82 or Patch8.

## CURRENT SINGLE NEXT ACTION
Run D97Y only and return the complete report.

Do not Root Patch or reboot. Only if every D97Y block-boundary, inbound-reference, classifier and synthetic-disassembly gate passes may one identity-pinned FASTLANE replacing D97V with the in-place exit classifier be designed.

D82 remains reserve-only. Patch8 remains unauthorized.
