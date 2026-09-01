# OCLP7 CHECKPOINT — 2026-09-01 — D97AD Root Patch FULL PASS / accelerated boot ready

## Live application
- `/Applications/OpenCore-Patcher.app` is the validated D97AD build from private GitHub Actions.
- Executable SHA256: `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.
- D97Z backup remains available at `/Applications/OpenCore-Patcher.app.D97Z-before-D97AD-GitHub-20260901-232929`, executable SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.

## D97AD Root Patch transcript audit — FULL PASS
The complete manual Root Patch from the validated D97AD app completed successfully and created a new APFS snapshot.

Retained functional chain was applied in exact order:
- selector bridge `31001 -> 32023` verified;
- P2b request layout `+0xD0 -> +0x110` verified;
- P3 serialized-bitcode path verified;
- AIR00 verified;
- D34 verified;
- true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`;
- P6 committed SHA `4b7660f6ddebd615cca4e67667f2e29a29366aa5b872866cfa79592d2cb6be76`;
- P7 committed SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

D97Z service classifier is absent from the Root Patch transcript. The service receives only the retained selector patch; packaged/source audits already proved D97Z absent and selector-only target semantics.

D97 downstream six-counter diagnostic is absent from the Root Patch transcript.

D97AD whole-stage classifier is present and committed:
- preimage P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
- `D97AD_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- `D97AD_COMMITTED_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- `D97AD_PRE_D97_VALIDATOR_WHOLE_STAGE_EXIT_CLASSIFIER=PASS`.

Outcome contract retained:
- 110 = candidate REL+`0x58B`;
- 111 = buffer-index REL+`0x29A`;
- 112 = sampler-index REL+`0x2D9`;
- 113 = nested argument-buffer REL+`0x3E2`;
- 114 = other early REL+`0xB9` or REL+`0x6CC`.

Mandatory runtime gate retained exactly:
`every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114_or_runtime_run_invalid`.

Patch process completed through AKC build, APFS snapshot creation and unmount, ending with `Patching complete` / reboot prompt. No Root Patch error was observed.

## CURRENT SINGLE NEXT ACTION
Accelerated boot is authorized now.
- Reboot into the root-patched accelerated configuration.
- If there is no usable image, perform the normal hard-restart/power-cycle and boot VESA recovery.
- After returning in VESA, report `last reboot | head -n 5` before any log audit so the accelerated and recovery boot entries can be pinned exactly.
- Do not mix VESA recovery logs with the accelerated cohort.

Runtime classification must enforce the D97AC liveness gate: every spawned MTLCompilerService PID in the accelerated boot must have exactly one launchd exit 110–114. Any spawned PID with no classifier exit, signal termination, or another exit code invalidates the runtime run.

D82 remains reserve-only. Patch8 remains unauthorized.
