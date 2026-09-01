# OCLP7 CHECKPOINT — 2026-09-01 — D97W SIGILL channel positive / register-report channel negative / D97X ready

## Retained causal chain
- D97M: request selector `32023` loads MTLCompiler 32023; `3802` loads MTLCompiler 3802; other values select no valid compiler path.
- D97O: selector is low32 of `xpc_dictionary_get_uint64(request,"llvmVersion")` in MTLCompilerService.
- D97T: cached Metal.framework writes XPC key `llvmVersion` through exact `_xpc_dictionary_set_uint64`.
- D97U: immediately after the getter, full RAX and low32 EAX are live; exact capture site fileoff `0x25C3` is safe for terminal instrumentation.
- D97V FASTLANE and manual Root Patch were FULL PASS. Installed service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`, site `0x25C3 = 0f0b9090909090`.

## Boot chronology
- accelerated D97V boot: 2026-09-01 14:00 EEST;
- VESA recovery boot: 14:03, excluded;
- analysis window: 13:59:30 through but not including 14:03:00.

## D97W / D97WA artifacts
`OCLP7_D97W_READONLY_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT.command`
- commit `c849255bd90a59d8c01378708ff8780cdedbeded`;
- blob `db02543255b73026b5474686e2014c330c594a45`.

`OCLP7_D97WA_DIRECT_PINNED_ACCELERATED_LLVMVERSION_CRASH_REGISTER_AUDIT_WRAPPER.command`
- commit `c577ee81f1ec1477ec666697ce0b450fe0b95a55`;
- blob `80a18e7bbc0aeb88414aeeffcdcadd77bdaa8eaa`.

## D97W observed result
Identity and chronology gates:
- wrapper/core identity, zsh parse, Python compile and read-only contract PASS;
- current VESA view of service SHA is exact D97V `bdb861da...`;
- current site `0x25C3` is exact `0f0b9090909090`;
- accelerated 14:00 and VESA 14:03 selection PASS.

Diagnostic report channel:
- 17 existing MTLCompilerService reports parsed with zero parser failures;
- zero reports had content time inside the accelerated window;
- exact terminal report count = 0;
- exact terminal report with RAX count = 0.

Classification: `D97W_DIAGNOSTIC_REPORT_REGISTER_CHANNEL=NEGATIVE`. This is a channel failure only; it does not mean the terminal site was not reached.

Unified log channel:
- launchd repeatedly spawned MTLCompilerService for WindowServer;
- the displayed accelerated window contains 15 explicit `exited due to SIGILL | sent by exc handler` terminations across successive service PIDs;
- first five generated allowed corpses, then corpse production was throttled as `too many`;
- this is strong runtime corroboration that the D97V-instrumented service executed and hit a SIGILL path.

Conservative classification:
- `D97W_UNIFIED_LOG_SIGILL_TERMINATION_CHANNEL=POSITIVE_REPEATED`;
- `D97V_TERMINAL_CONTROL_FLOW=STRONGLY_CORROBORATED_NOT_EXACT_RIP_PROVEN` because no report supplied RIP;
- runtime `llvmVersion` remains UNKNOWN because RAX was not preserved in an accessible report.

## Methodology decision
Do not repeat a register-dependent SIGILL capture. The permanent rules prefer deterministic launchd exit accounting when `.ips` is absent.

The next diagnostic will classify the exact known selector alternatives before compiler selection and terminate normally with deterministic codes:
- exit 123 = exact compare matched `3802`;
- exit 124 = exact compare matched `32023`;
- exit 125 = neither value.

This classifier must be universal/no-PID and terminal. It must not depend on crash reports.

## D97X artifact
`OCLP7_D97X_READONLY_EXIT_CODE_CLASSIFIER_CAVE_SAFETY_AND_DESIGN_MAP.command`
- commit `09d9a64bbf8789a3227693adec37c3d06551ee53`;
- blob `71bd9caedd19b71d16637d9bdbd5263930824192`.

D97X is strict read-only. It:
1. verifies exact current D97V service SHA/site;
2. reconstructs selector-only preimage SHA `a8716ffd...`;
3. maps Mach-O sections and `__TEXT,__text`;
4. scans executable zero runs;
5. rejects caves with direct targets, RIP-relative xrefs, symbols, nonterminal predecessor or overlap;
6. constructs and audits a 36-byte three-way exact classifier using `cmp EAX`, deterministic exit codes and Darwin x86_64 `exit` syscall `0x2000001`;
7. constructs the site trampoline, derives deterministic final SHA and disassembles a synthetic patched copy;
8. performs no integration, build, deployment, Root Patch or reboot.

## CURRENT SINGLE NEXT ACTION
Run D97X only and return its complete report. Do not Root Patch or reboot. Only after assistant audit may an identity-pinned FASTLANE replacing D97V with the exit-code classifier be designed.

D82 remains reserve-only. Patch8 remains unauthorized.
