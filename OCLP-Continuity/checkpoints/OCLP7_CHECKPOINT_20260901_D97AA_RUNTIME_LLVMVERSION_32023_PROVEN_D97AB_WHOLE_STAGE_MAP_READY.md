# OCLP7 CHECKPOINT — 2026-09-01 — D97AA runtime llvmVersion 32023 PROVEN / D97AB whole-stage map ready

## D97AA accelerated-boot selection
- Accelerated D97Z boot: `2026-09-01 17:12` EEST.
- VESA recovery boot: `17:14`, excluded.
- Analysis window: `17:11:30` through but not including `17:14:00`.
- Host WindowServer PID for the classified cohort: `177`.

## D97Z identity retained
The read-only D97AA audit verified the current root-patched artifacts before reading runtime evidence:
- visible MTLCompilerService SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- exact in-place classifier block at `0x25C3..0x25EB`:
  `3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b90909090`;
- identity gate PASS.

Classifier semantics retained:
- exit `123` = EAX/`llvmVersion` exactly `3802` (`0xEDA`);
- exit `124` = EAX/`llvmVersion` exactly `32023` (`0x7D17`);
- exit `125` = every other value.

## Decisive runtime result
D97AA extracted 12 unique MTLCompilerService spawns for the same WindowServer host and 12 corresponding explicit launchd lines of the form `exited due to exit(124)`.

Observed service PIDs:
`323, 326, 328, 331, 334, 337, 340, 343, 351, 353, 357, 361`.

Exact primary histogram:
- exit 123 / 3802: `0`;
- exit 124 / 32023: `12`;
- exit 125 / other: `0`;
- signal terminations: `0`;
- spawned PIDs without a recorded explicit exit: `0`.

The mapper's `PRIMARY_UNKNOWN_OR_SIGNAL_EXIT_COUNT=33` is not 33 additional service terminations. It is a parser overcount of the three ancillary launchd lifecycle lines repeated after each of the first 11 explicit classifier exits: `process exited in a dirty state`, `service state: exited`, and `internal event: EXITED, code = 0`. There are exactly 12 unique service PIDs and exactly one causal explicit `exit(124)` per PID.

Authoritative classifications:
- `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`;
- `PRIMARY_LAUNCHD_EXIT_CLASSIFIER_CHANNEL_POSITIVE`;
- `D97Z_VISIBLE_SERVICE_RUNTIME_EXECUTION=PROVEN_BY_CLASSIFIER_EXIT`;
- no request variation was observed in this accelerated cohort.

## Causal consequence
Hypothesis H4 — that the failing accelerated requests select MTLCompiler 3802 rather than the instrumented 32023 donor — is rejected for the complete observed cohort.

Therefore the historical absence of the downstream D97 `+0x58B` terminal marker is **not explained by compiler-generation selection**. The runtime request selects 32023 consistently.

Retained prior facts:
- D78D established entry into `MTLSimCompiler::validSimulatorMetadata` for the failing path;
- D97JB proved REL+`0x58B` is the earliest post-final-write common dominator for all six late resource predicates;
- D97H showed no downstream D97 marker.

The next causal interval is consequently the portion of `validSimulatorMetadata` from function entry through, but not including, REL+`0x58B`. The next diagnostic must classify the whole interval, not return to one-address scanning.

## D97AB artifact
`OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP.command`
- commit `e0519e5b38c029e5bfd6ba141c422b43ca64246e`;
- blob `366fb2a45895723d103b7edb31679a4cd5dd9a16`.

D97AB is strict read-only. It:
1. verifies exact current D97 MTLCompiler SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`;
2. reconstructs exact P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda` by removing D97 site/cave bytes in a temporary copy;
3. verifies exact `validSimulatorMetadata` range `0x7FFB162C7132..0x7FFB162C7830`;
4. reconstructs the full CFG, including the already-proven REL+`0x279` indirect switch;
5. treats the following as natural whole-stage outcomes: candidate REL+`0x58B`, buffer-index error REL+`0x29A`, sampler-index error REL+`0x2D9`, nested-argument-buffer error REL+`0x3E2`, and any remaining early terminal blocks;
6. proves or rejects exhaustive path partitioning and reports residual cycles/outcomes;
7. audits the reusable D97 cave at fileoff `0xF80` for a shared normal-exit stub;
8. maps complete-instruction 8-byte terminal patch windows and proposed universal launchd exit codes `110..114` without integrating anything.

D97AB performs no source/system/Golden mutation, service launch, runtime instrumentation, Root Patch, reboot, D82 or Patch8.

## CURRENT SINGLE NEXT ACTION
Run D97AB only and return the complete report:
`OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP_REPORT.txt`.

Do not Root Patch or reboot. A FASTLANE may be designed only after the assistant audits CFG completeness, outcome exhaustiveness, patch-window safety and shared-cave safety.

D82 remains reserve-only. Patch8 remains unauthorized.
