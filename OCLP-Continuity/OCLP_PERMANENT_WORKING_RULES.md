# OCLP PERMANENT WORKING RULES

Recovered/restored: 2026-09-01 EEST
Updated: 2026-09-08 EEST — reconciled after full checkpoint review through D97HV
Scope: ASUS2 Tahoe Haswell project and every future OCLP continuation.

This file is the permanent procedural contract. Future checkpoints inherit it unless the user explicitly changes a rule. Historical checkpoints remain evidence for what happened, but stale procedural/current-state wording does not override this file + MASTER + current checkpoint.

## 1. Evidence classes remain distinct
Use only the strongest directly supported label:
- `REACHED`: execution arrived at the address/stage.
- `CONTROL-FLOW PROVEN`: branch/call/return relationship directly demonstrated.
- `SEMANTIC PROVEN`: payload/state required by the next stage is directly shown correct against persisted Golden or another already-proven contract.
- `STRUCTURAL-SEMANTIC PROVEN`: object/layout/invariant needed by the next consumer is validated, but exact Golden runtime values are unavailable.
- `STATIC-MAPPED`, `STATIC-PROVEN`, `NEGATIVE`, `INCONCLUSIVE`, `UNKNOWN` remain separate.

Control-flow success alone must never be called semantic correctness.

## 2. Large jumps require two questions
Every broad diagnostic must answer:
1. where did execution go?
2. is the handoff payload/state still good?

Before advancing another large interval, establish a semantic or structural-semantic checkpoint at or near the new frontier whenever safely observable.

## 3. Module-boundary workflow is default
Work by natural functional modules rather than one instruction per reboot whenever architecture permits.

For each boundary:
- validate the end of the current module;
- validate the beginning of the next;
- validate the handoff payload/status/object;
- only then mark the boundary GREEN.

GREEN requires CONTROL-FLOW PROVEN plus the strongest safely obtainable semantic/structural-semantic validation.

Once a boundary is GREEN, do not rescan the completed module instruction-by-instruction unless later evidence directly invalidates it.

## 4. Binary search only inside the failed module
If module start/handoff is GREEN but module end is not:
1. place a midpoint inside only that failed module;
2. test control-flow plus payload integrity;
3. retain the failing half;
4. repeat;
5. switch to instruction-level probing only when the interval is genuinely small.

The project objective remains usable accelerated GUI, not maximum diagnostic density.

## 5. Semantic checkpoint content
Use the strongest safe subset relevant to the stage, including when appropriate:
- AIR/Metal semantic versions;
- return/status values;
- selector/request-layout fields;
- serialized-bitcode state;
- pointer null/non-null state;
- consumer-required object/vector invariants;
- exact branch decision and causing data;
- raw observed values, not only PASS/FAIL.

Do not invent checks for fields whose runtime location is unknown.

## 6. Golden Sequoia immutable
Golden Sequoia must never be booted or modified for evidence collection.

If exact Golden runtime equivalence is unavailable:
- do not guess;
- mark it UNKNOWN;
- still record safe structural/runtime facts.

For root-patched components, compare Tahoe primarily against the working Golden root-patched component when persisted evidence exists.

## 7. Historical five-patch chain is design evidence, not current active baseline
Historical accepted chain:
- P1 selector bridge;
- P2b request-layout `+0xD0 -> +0x110`;
- P3 serialized-bitcode;
- AIR00 AIR 2.6 / Metal 3.1 fallback;
- D34 semantic-equivalent reset.

D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave `0xEF8..0xEFE` remains protected.

Important current methodology rule:
**never replay all five blindly.** Apply only the earliest currently measured failed module. Later historical modules are reintroduced only after current evidence makes them causal/necessary.

P6/P7 runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized unless a later current checkpoint explicitly promotes it.

## 8. Multi-threshold / whole-stage diagnostics
Do not revert to one-address/one-reboot scanning for broad localization.

When possible:
1. map unresolved stage statically;
2. choose natural thresholds;
3. instrument as many as safely possible;
4. preserve original semantics for pass-through probes;
5. use deterministic distinct markers for mutually exclusive outcomes;
6. track deepest progress for the same request/process;
7. use universal/no-PID coverage when requests vary;
8. include semantic checkpoints;
9. reserve instruction-level probing for the final small interval.

A terminal probe cannot prove later sequential thresholds. Prefer transparent probes for sequential progress.

## 9. Same-cohort / universal coverage rules
For mutually exclusive outcomes of one decision:
- use the same PID/request cohort;
- use distinct codes;
- make the classifier exhaustive when possible;
- never infer branch A vs B by sampling different PIDs.

When MTLCompilerService respawns can carry different requests, do not GREEN-seal a boundary from partial PID sampling. Universal/no-PID instrumentation is preferred.

## 10. Instrumentation transparency
Any diagnostic that continues original execution must preserve complete overwritten instructions, flags, registers, stack, branch targets and continuation.

Only complete instructions may be overwritten unless an audited trampoline reconstructs a split instruction exactly.

Terminal diagnostics must state terminality explicitly.

D34 cave `0xEF8..0xEFE` is protected. Every diagnostic cave allocation requires overlap/xref/branch-target/preimage audit.

## 11. FASTLANE order
Preserve exact order:
`validations -> integration -> compile/diff -> build -> packaged-app audit -> SHA/identity -> backup/deploy -> open OCLP -> STOP`.

Never skip an audit because a helper printed PASS.

Never auto Root Patch. Never auto reboot. Audit complete FASTLANE before Root Patch; audit complete Root Patch before accelerated boot.

## 12. Permanent GitHub-first responsibility split
Everything technically executable in GitHub is performed by the assistant in GitHub rather than delegated to ASUS2/user. This includes:
- validations;
- source/workflow integration;
- compile/diff;
- build/package;
- packaged-app audit;
- SHA/manifest/provenance work;
- CI audit/artifact preparation.

ASUS2/user is reserved for identity-pinned operations inherently dependent on installed/live target state:
- hardware/cache/live filesystem/log evidence not remotely resolvable;
- target-local deploy when necessary;
- opening OCLP;
- manual Root Patch only after explicit authorization;
- accelerated boot;
- VESA recovery;
- physical power/boot selection.

If GitHub-eligible work is genuinely blocked, STOP and document the blocker. Do not silently fall back to local compilation. Local compilation requires explicit user authorization.

Never compile on ASUS2 unless a later explicit user authorization overrides that rule for a specific bounded task.

Portable non-target Intel build hosts may be used only after explicit authorization and with exact source/provenance/hash gates.

## 13. Runtime evidence discipline — accelerated vs recovery
The user frequently cannot return to ChatGPT from a no-GUI accelerated boot and must hard-recover to VESA first.

Therefore:
- current/latest online boot is often VESA recovery;
- accelerated evidence belongs to the immediately preceding accelerated experiment, not automatically the latest boot;
- hard restart/VESA recovery are not themselves compiler-failure evidence.

The user's identification of which boot was accelerated and which was recovery is authoritative.

Use `last reboot`, WindowServer launch/crash times, launchd and crash-report timestamps to bind an explicit accelerated window.

**Durable identity rule:** store accelerated experiments by explicit date/time window or unique experiment name. Do not rely on mutable ordinal terms such as "last", "penultimate" or "antepenultimate" in permanent state.

Do not mix logs/IPS from later VESA recovery into the accelerated cohort.

D97HV is the canonical warning example: a bad `kern.boottime` parser produced a 1970 window and contaminated an automatic classifier with historical IPS. Raw evidence remained useful only after exact timestamp re-scoping.

## 14. Missing `.ips` is not automatically negative
Prefer reliable launchd/process/unified-log evidence. Absence of `.ips` alone is never a hard negative.

Correlate MTLCompilerService children with exact host process and exact test window when possible.

If launchd reports controlled termination after host abort, do not treat the accounting timestamp as the exact final compiler instruction.

## 15. Far-downstream evidence may advance the frontier
Reliable crash stacks or equivalent evidence can prove far-downstream control flow even if an earlier semantic handoff remains unresolved.

When this occurs:
- do not force linear continuation from the earlier point;
- identify the nearest natural handoff before the far failure;
- compare its semantic contract against persisted Golden/static evidence;
- promote the stronger accepted frontier if justified;
- retain earlier unresolved points as reserve diagnostics.

Retained causal model:
`MTLCompilerService/compiler failure -> XPC interruption -> render-pipeline/GPUPass failure -> SkyLight/QuartzCore abort -> WindowServer death`.

WindowServer is downstream, not root cause.

## 16. Persistence rule
Persist immediately after every decisive PROVEN/NEGATIVE result, major methodology change, or material current-state change; otherwise no later than every ~10 substantive technical responses.

Update as appropriate:
- `OCLP_MASTER_CONTINUITY.md`;
- `OCLP_HISTORY_INDEX.md` when phase/history changes;
- `OCLP_PERMANENT_PROJECT_DATABASE.md` when durable current facts change;
- a new incremental checkpoint.

Do not let MASTER/HISTORY/DATABASE drift into mutually contradictory current states.

## 17. Mandatory continuation protocol
Before proposing any technical modification in a new continuation, read in full from `StefanAlMare/StefanAlMare`:
1. `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`;
2. `OCLP-Continuity/OCLP_MASTER_CONTINUITY.md`;
3. `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. exact `Current authoritative checkpoint` named by MASTER;
5. `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP-Continuity/OCLP_HISTORY_INDEX.md`.

Treat them as durable source of truth. Resume exactly from current `CURRENT ACTION`. Do not reconstruct current state from memory alone and do not ask the user to repeat persisted history.

## 18. Current project-specific patch discipline after D97HV
Current exact intended compiler state is P1+P3-only; P2 remains original. P2b/AIR00/D34 are not active.

P1 semantic progress is PROVEN. P3 semantic progress is PROVEN. GUI remains NEGATIVE.

The current measured frontier is the recurring simulator/bitcode diagnostic path reached in the timestamped accelerated P1+P3 experiment `2026-09-08 14:24:02 -> ~14:27:17 +0300`.

Before authorizing P2b or any later historical module, statically map that current diagnostic path and prove whether the candidate is upstream/causal.

Current next action is D97HW read-only static simulator/bitcode mapping. No Root Patch/reboot/EFI mutation is implied by this rule.