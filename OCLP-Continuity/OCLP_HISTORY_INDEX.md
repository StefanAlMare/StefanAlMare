# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AV_V2_STATIC_MAP_PASS_BOOT_SUBSECTION_TOOLING_FAIL_P1_UPSTREAM_PRODUCER_FRONTIER_D97AW_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / baseline
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package. No automatic Root Patch/reboot. Historical Tahoe baseline P1 -> P2b -> P3 -> AIR00 -> D34, true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 active historically with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Golden comparator override: user may manually restore original OCLP Root Patch and boot working Golden Sequoia. Assistant does not automate Golden Root Patch/reboot or install experimental Golden system-file patches without separate explicit authorization.

## Tahoe natural-flow retained state
D97AM source/build/artifact/deploy/Root Patch FULL PASS; accelerated 02:29 `NEGATIVE_NO_USABLE_GUI`, 02:32 VESA excluded.

D97AN exact natural 32023 provenance 79/79, 3802 zero; PCs `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`. D97AO natural validator all-five late xrefs STATIC-PROVEN reachable. D97AP specialized start->timing CONTROL-FLOW PROVEN. D97AQ exact termination remains UNKNOWN.

D97AR maps six threshold locals. D97AS proves a terminal six-bit classifier statically feasible but it remains reserve-only because a stronger earlier producer/lane divergence is active.

## Golden D97AT / D97AU
Working Golden Sequoia 15.7.9/24G830 confirmed HD4400 0x0412 / Metal2 / display online. Exact Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`; exact Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`.

Golden validator has exact same six-counter static contract as Tahoe. Working Golden also emits the same truncated simulator fragments, so those messages are not failure-specific.

D97AU authoritative Golden boot window `12:54:24..12:57:24`: 32023=220, 3802=193, 8 exact-generation PIDs, no mixed-generation PID. Golden 32023 PCs: `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`.

Tahoe failing reference: 32023=79, 3802=0, exact 32023 PIDs=65, `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.

Boot-aligned generation-selection divergence and internal-32023 request-lane divergence are RUNTIME-PROVEN observations; causality not yet proven.

D97AU explicit LLDB attach denial means raw Golden six-counter values remain UNKNOWN_ATTACH_DENIED; same debugger lane closed.

## D97AV V2 — static PASS, boot subsection tooling false
User returned JSON/TXT batch and identities were independently verified:
- JSON 12407 bytes / SHA256 `685acdd2df077908eec6cbeedff60d2bb66bbbe4b323c670fdb603dcf1385626`;
- TXT 36248 bytes / SHA256 `2d6d6d6c06df896d251441eb00172e0b2d5d72a6a8e3bba40e4c8a1ed6dc2542`.

Golden identity and static seven-patch map PASS.

D97AV V2 boot subsection printed `1970-01-03 08:18:27..08:21:27`, caused by greedy `sed` matching `usec =` instead of epoch `sec =` in `kern.boottime`. Its 305-row/18-PID sequence data is RETIRED as tooling-false; D97AU absolute window remains runtime authority.

### Static map changes strategy
`0x9A9FC` is `MTLCompilerObject::upgradeAIRModule` immediately after log `MTLCompiler upgrade pass forced to use air version %d.%d`.

P2b/AIR00/P7 all live in `getReadParametersFromRequest`; P3 in `backendCompileModule`; D34 callsite in `runFrameworkPasses`; P6 in `invokeLowerModule` + `runFrameworkPasses`.

Because Golden has 88 `upgradeAIRModule` events while Tahoe has zero, P2b/AIR00/P7 is now the highest-priority internal-32023 cluster for direct-call/field-consumer reevaluation. Causality not yet proven.

### P1 exact Golden semantics
Golden original service SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5` contains selector 3802 at `0x3478`, 31001 at `0x3496`, and no 32023 immediate.
Golden maps `3802 -> MTLCompiler 3802`, `31001 -> MTLCompiler 32023`.
Tahoe P1 changes only the `0x3496` compare `31001 -> 32023`, leaving the separate 3802 branch untouched.

Therefore P1 cannot directly turn 3802 into 32023 and cannot alone explain Tahoe zero-3802. Isolated P1 ablation is not useful: current Tahoe 32023 requests would lose their donor path. P1 is now classified `KEEP_TEMPORARY_SHIM / RETIRE_ONLY_WITH_PRODUCER_NORMALIZATION`.

The active earliest frontier is XPC request `llvmVersion` / request-class production upstream of P1. Internal P2b/AIR00/P7 influence on upgrade/specialized/backend remains the second high-priority question.

## Patch utility status after D97AV V2
- P1: temporary shim; no isolated ablation.
- P2b: provisional high-priority cluster.
- AIR00: high-priority reevaluate despite D22 local semantic proof.
- P7: high-priority reevaluate; runtime sufficiency NEGATIVE.
- P3: provisional; backendCompileModule.
- D34: provisional lower priority.
- P6: provisional lower priority / insufficient.
No patch retired solely from D97AV V2.

## CURRENT ACTION — D97AW Golden read-only
Run `OCLP7_D97AW_GOLDEN_FIXED_BOOT_3802_32023_CALLGRAPH_AND_SHARED_CACHE_LLVMVERSION_PRODUCER_AUDIT.command`, commit `8187316e61bfa47ace5db0da19d3df1cc60e887d`, blob `e2d77333fb4d67efe17b1afb6ffb9168aeafc828`.

It uses the fixed D97AU window, maps every observed 3802/32023 PC, maps direct callgraph among read-parameters/AIR-upgrade/specialized/backend/framework functions, and discovers Golden shared-cache Metal `llvmVersion` writer value sources for comparison against Tahoe D97R `[RBX+0x1C] / [RCX+0x38]`.

STOP after D97AW; return TXT + JSON. No debugger, cache extraction, Root Patch, system mutation or reboot.
