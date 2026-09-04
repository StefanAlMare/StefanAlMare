# OCLP PERMANENT WORKING RULES

Recovered/restored: 2026-09-01 EEST
Updated: 2026-09-05 EEST — permanent GitHub-first execution policy restored by explicit user instruction
Scope: ASUS2 Tahoe Haswell project and every continuation named OCLP6, OCLP7, OCLP8, OCLP9, OCLP10, OCLP11, OCLP12, etc.

This file is the permanent procedural contract. Future checkpoints and conversations inherit it unless the user explicitly changes a rule.

## 1. Evidence classes are distinct
Every diagnostic boundary must be classified with the strongest directly supported label only:
- `REACHED`: execution arrived at the address.
- `CONTROL-FLOW PROVEN`: the relevant original branch/call/return relationship is directly demonstrated.
- `SEMANTIC PROVEN`: the payload/state required by the next stage is directly shown to be semantically correct against persisted Golden Sequoia evidence or another already-PROVEN semantic contract.
- `STRUCTURAL-SEMANTIC PROVEN`: object/pointer/layout invariants needed by the next consumer are directly validated, but exact Golden runtime values are unavailable.
- `STATIC-MAPPED`, `STATIC-PROVEN`, `NEGATIVE`, `INCONCLUSIVE`, and `UNKNOWN` remain separate labels.

Control-flow success must never be described as semantic correctness by itself.

## 2. Large jumps require two simultaneous questions
Every coarse or multi-threshold diagnostic must answer:
1. Where did execution go?
2. Is the payload/state still good?

Before advancing across another large interval, establish a semantic or structural-semantic checkpoint at or near the new frontier whenever safely observable.

## 3. Module-boundary workflow is the default
Work by natural functional modules, not individual instructions, whenever binary/control-flow architecture permits it.
For each module boundary:
- validate the end of the current module;
- validate the beginning of the next module;
- validate the handoff payload/status/object;
- only then mark the boundary `GREEN`.

`GREEN` requires CONTROL-FLOW PROVEN plus the strongest safely obtainable semantic/structural-semantic validation. If exact Golden runtime equivalence is unavailable, state that explicitly.

Once a boundary is GREEN, do not re-scan the completed module instruction-by-instruction unless later evidence directly invalidates it.

## 4. Binary-search localization inside a failed module
When module start/handoff is GREEN but module end is not:
1. place a coarse midpoint inside only that module;
2. test control-flow and semantic/structural-semantic integrity there;
3. retain only the failing half;
4. repeat by halving;
5. switch to instruction-level probing only when the remaining interval is genuinely small.

The end goal is accelerated graphical output and a usable GUI. Continue module-by-module from the last accepted frontier until image acceleration appears.

## 5. Semantic checkpoint contents
Use the strongest safely observable subset relevant to the stage, for example:
- AIR semantic major/minor and Metal semantic version;
- return/status values before branch decisions;
- request-layout fields and selector values;
- serialized-bitcode state;
- pointer null/non-null state;
- object/vector invariants and safely dereferenced consumer-required fields;
- exact branch decision and causing data condition;
- raw observed values, not only PASS/FAIL.

Do not invent a semantic check for a field whose runtime location is unknown.

## 6. Golden Sequoia is immutable
Golden Sequoia 15.7.9 / 24G830 must never be booted or modified. Use only persisted Golden data or inspect the already-mounted Golden read-only when genuinely new static comparison is required.

If an exact Golden runtime value is unavailable:
- do not guess;
- label exact Golden runtime equivalence `UNKNOWN`;
- still record safe structural/runtime facts;
- never boot or modify Golden to obtain it.

Static identity of a patch/binary is not runtime semantic identity. For root-patched components, compare Tahoe primarily against the working Golden root-patched component when available.

## 7. Functional baseline
The accepted five-functional-patch baseline is:
- P1 selector bridge;
- P2b request layout bridge `+0xD0 -> +0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 is the accepted upstream runtime semantic proof for AIR 2.6 / Metal 3.1. D34 functional cave `0xEF8..0xEFE` is protected and untouchable by diagnostics.

P6 and P7 are retained but their runtime sufficiency is NEGATIVE. D50/D68/D82 are reserve-only unless a future authoritative checkpoint explicitly promotes one. D84 is retired. Patch 8 is not authorized unless a later checkpoint explicitly says so.

## 8. Multi-threshold and whole-stage diagnostics
Do not return to one-address/one-reboot scanning for broad localization.
- Use multiple meaningful thresholds in one build/Root Patch/accelerated boot.
- Include semantic/structural-semantic gates where safe.
- Use instruction-level probing only after isolating a genuinely small interval.
- Absence of a marker is a hard negative only when observation channel, request coverage, and branch semantics justify it.
- Cross-PID/request differences must not be treated as the same request.

When static CFG/binary architecture is sufficiently known, first attempt whole-stage coverage in one diagnostic:
1. map the unresolved interval statically;
2. choose natural semantic/control-flow thresholds;
3. instrument as many as safely possible;
4. preserve overwritten instructions, flags, registers, stack, targets and continuation at pass-through thresholds;
5. use deterministic distinct markers for mutually exclusive terminal/error outcomes;
6. determine deepest progress for the same request/process without inferring from different PIDs;
7. use universal/no-PID coverage where requests vary;
8. include semantic checkpoints where safe;
9. reserve one-address probing for the final tiny interval or when whole-stage design is technically impossible.

A terminal marker on a sequential path cannot map later thresholds. Prefer transparent checkpoints for sequential progress and terminal markers only for explicit outcomes or final boundaries.

## 9. Same-cohort rule
When a sampled classifier is still useful and probes classify mutually exclusive outcomes of one decision:
- all outcomes must use the same PID cohort/lane;
- use distinct codes within that cohort;
- make the classifier exhaustive for that cohort when possible;
- never assign branch A to one PID lane and branch B to another and infer from marker absence.

## 10. Universal/exhaustive coverage before GREEN
When MTLCompilerService respawns can carry different requests:
- do not GREEN-seal a boundary from PID-lane sampling if the result may vary by request;
- classify every process/request reaching the handoff whenever safely possible;
- use distinct deterministic markers with no PID filter;
- if universal instrumentation is infeasible, keep the boundary below GREEN and state the limitation.

## 11. Instrumentation transparency
Any diagnostic that continues original execution must preserve original semantics: complete overwritten instructions, flags, registers, stack, branch targets and continuation.

Only complete instructions may be replaced unless a fully audited trampoline reconstructs a split instruction exactly.

A terminal diagnostic may deliberately stop execution; it must state terminality explicitly and make no pass-through claim.

D34 cave `0xEF8..0xEFE` is protected. Every diagnostic cave allocation must be audited for identity, zero/preimage, xrefs, branch targets, symbols and overlap.

## 12. FASTLANE discipline
FASTLANE preserves this exact order regardless of where an individual step runs:
`validations -> integration -> compile/diff -> build -> packaged-app audit -> SHA/identity -> backup/deploy -> open OCLP -> STOP`.

The permanent default is GitHub-first. Everything technically executable in GitHub is executed by the assistant in GitHub rather than delegated to the user as a local ASUS2 build/compile/validation step. This includes validations, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest generation, artifact publication and CI audit.

ASUS2 is reserved for identity-pinned work that inherently depends on ASUS2 or its installed/live state: cache/files/log/hardware evidence, unpublished dirty-worktree or local-object evidence not remotely resolvable, target-local download/verification/backup/deploy when required, opening OCLP, manual Root Patch after authorization, accelerated boot, VESA recovery and physical/manual boot actions.

If a GitHub-eligible operation is genuinely blocked in GitHub, STOP and document the exact blocker. Local compilation is not an implicit fallback and requires the user's explicit authorization.

Never auto-Root-Patch. Never auto-reboot. Audit the complete FASTLANE before Root Patch; audit the complete Root Patch before accelerated boot.

### 12A. Permanent GitHub/ASUS2 responsibility and interaction protocol
1. First classify every next action by whether it is technically executable in GitHub or inherently ASUS2/live-state dependent.
2. The assistant performs all GitHub-eligible validations, source/workflow integrations, compile/diff, build/package, packaged-app audit, SHA/manifest work, artifact publication/preparation and CI audit in GitHub.
3. The assistant repairs GitHub workflow failures when possible and audits the complete result; a printed PASS is not sufficient.
4. For GitHub build/package work, persist repository, branch/ref, workflow/run/job, runner when relevant, head SHA, artifact ID/digest, inner artifact SHA, packaged executable SHA and packaged audit result when applicable.
5. Existing audited artifact-delivery mechanisms may be used to bring GitHub artifacts to ASUS2; reproducing such builds locally is not required and local compilation requires explicit user authorization.
6. User/ASUS2 operations are limited to identity-pinned evidence or state changes that inherently require ASUS2: cache/file/log/hardware/live-state proof; unpublished dirty-worktree/local-object proof if not remotely resolvable; target-local download/verify/backup/deploy when needed; opening OCLP; manual Root Patch; accelerated boot; VESA recovery; power cycling and manual boot selection.
7. Only after explicit assistant authorization does the user manually Root Patch and return the complete Root Patch output.
8. Assistant audits Root Patch and only then authorizes accelerated boot.
9. User boots accelerated, recovers via VESA if necessary, and returns requested evidence.
10. Assistant analyzes only that immediately preceding accelerated boot, persists decisive evidence, and chooses the next GitHub-first or inherently ASUS2-only bounded action.
11. If GitHub is genuinely blocked for a GitHub-eligible operation, STOP and document the exact blocker; do not silently fall back to ASUS2/local compilation.
12. If a target-local action or Root Patch fails, STOP, explain the exact failure and correct it in the shortest appropriate lane; do not continue with scattered mutations.

Rhythm: `assistant GitHub validate/integrate/compile/build/package/audit whenever technically possible -> identity-pinned ASUS2 delivery/live-state action only when inherently required -> assistant audit -> manual Root Patch authorization when warranted -> accelerated boot -> VESA recovery/evidence -> persistence`.

## 13. Runtime evidence discipline
Analyze only the immediately preceding accelerated diagnostic boot, excluding the later VESA recovery boot.

Reliable deterministic launchd exit codes are preferred over `.ips` absence. Missing `.ips` alone is never a hard negative.

Correlate MTLCompilerService children to the exact host process and fatal-time window where possible. If launchd reports a controlled termination after host abort, do not treat accounting timestamp as the exact final compiler instruction.

## 14. Persistence
Persist immediately after every decisive PROVEN/NEGATIVE/major methodology result, otherwise no later than every 10 substantive technical responses.
Update:
- `OCLP_MASTER_CONTINUITY.md`;
- `OCLP_HISTORY_INDEX.md` when phase/history changes;
- a new incremental checkpoint.

Future OCLP phase numbers inherit these rules automatically.

## 15. Proven far-downstream evidence may advance the frontier
Reliable crash stacks or equivalent evidence may establish far-downstream CONTROL-FLOW PROVEN even if an earlier handoff remains semantically unresolved.
When this occurs:
- do not force linear continuation from the earlier checkpoint;
- identify the nearest natural handoff before the far failure;
- compare its contract against Golden/static semantics;
- compare semantic content, not pointer addresses;
- promote the stronger accepted frontier if justified;
- retain earlier unresolved points as reserve diagnostics.

Retained causal model: MTLCompilerService failure precedes XPC interruption, pipeline creation failure, SkyLight/CopyPipelineState abort and WindowServer death. WindowServer is downstream, not the root cause.

## 16. Mandatory continuation protocol
At the start of every new OCLP7+ continuation, before proposing a technical modification, read in full from `StefanAlMare/StefanAlMare`:
1. `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`;
2. `OCLP-Continuity/OCLP_MASTER_CONTINUITY.md`;
3. `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact `Current authoritative checkpoint` named by MASTER;
5. `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP-Continuity/OCLP_HISTORY_INDEX.md`.

Treat those files as the durable source of truth. Resume exactly from `CURRENT ACTION`. Do not reconstruct from memory alone and do not ask the user to repeat persisted history.

## 17. 2026-09-05 execution-lane authority
This section is the latest explicit user instruction on execution responsibility and supersedes prospectively the 2026-09-03 ASUS2-local-default wording and any earlier wording inconsistent with GitHub-first execution. Historical results remain historically valid and are not reclassified merely because their execution lane differed.

Permanent rule:
- everything technically executable in GitHub is performed by the assistant in GitHub: validations, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest, artifact publication and CI audit;
- ASUS2/user execution is limited to identity-pinned evidence/actions that inherently require ASUS2: cache/files/log/hardware/live state, unpublished local state not remotely resolvable, target-local download/verify/backup/deploy when necessary, opening OCLP, manual Root Patch after authorization, accelerated boot and VESA recovery;
- if GitHub is genuinely blocked for a GitHub-eligible operation, STOP and document the exact blocker;
- local compilation is not an implicit fallback and requires explicit user authorization;
- Root Patch and reboot remain manual-only and separately authorized;
- decisive technical and methodology results are persisted immediately in MASTER + HISTORY + a new checkpoint.
