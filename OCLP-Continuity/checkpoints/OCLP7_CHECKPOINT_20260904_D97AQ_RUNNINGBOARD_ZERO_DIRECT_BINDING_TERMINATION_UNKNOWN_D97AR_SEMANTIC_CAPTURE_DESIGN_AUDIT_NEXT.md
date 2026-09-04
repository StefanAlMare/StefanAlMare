# OCLP7 CHECKPOINT — 2026-09-04 — D97AQ RunningBoard zero direct binding; termination UNKNOWN; D97AR semantic-capture design audit next

## Authority / carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600, SMBIOS `MacBookAir6,2`. Accepted functional baseline exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/static/log work stays ASUS2. GitHub only major compile/build/package. Root Patch/reboot manual-only.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AP_COMPLETE_SPECIALIZED_PAIRING_PROVEN_TERMINATION_UNKNOWN_D97AQ_WRAPPER_READY.md`.

Historical accelerated window remains fixed `2026-09-04 02:29:00..02:31:59` local; 02:32 VESA recovery excluded. Later boots do not redefine the historical accelerated evidence.

## D97AQ exact result
Read-only wrapper:
- `OCLP7_D97AQ_READONLY_ACCEL_0229_RUNNINGBOARD_MONITOR_TO_MTLCOMPILER_PID_BINDING_AUDIT.command`;
- commit `a2762e5c452c904f528d66fe0b463aaa62746e3b`;
- Git blob `e45a966be84327615321a872855fde9204486981`.

Wrapper identity/parse passed. Exact current natural target revalidated:
```text
TARGET_BYTES=1636896
TARGET_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
```

Historical exact sender cohort reconstructed exactly:
```text
EXACT_NATURAL_32023_RECORD_COUNT=79
EXACT_NATURAL_32023_PID_COUNT=65
D97AQ_EXPECTED_RECORD_COUNT_MATCH=PASS
```

The 65 exact natural-UUID MTLCompilerService PIDs are persisted in the raw report.

## RunningBoard monitor-exit audit — zero direct binding
D97AQ found `23` RunningBoard monitor exit records across the historical window, including wait4 status0 and several exit-reason namespace/code records.

For each monitor UUID, same-UUID RunningBoard records expose process PIDs such as 252, 272, 348, 177/406/443/498/550, 378, 418, 420, 136, 180, 203, 466, 460, 462, 455, 428, 528, 529, 506, 509, 531. None is one of the 65 exact natural-UUID MTLCompilerService PIDs.

Additionally:
```text
RBS_DIRECT_MTLCOMPILERSERVICE_RECORD_COUNT=0
DIRECT_BOUND_MONITOR_EXIT_COUNT=0
UNBOUND_OR_AMBIGUOUS_MONITOR_EXIT_COUNT=23
D97AQ_MTLCOMPILERSERVICE_TERMINATION_BINDING=NO_DIRECT_MONITOR_TO_EXACT_PID_BINDING_RECOVERED
```

D97AQ deliberately did not use temporal proximity as identity. Therefore none of the RunningBoard wait4/namespace exit records can be attributed to the exact natural MTLCompilerService cohort.

Authoritative classification:
`D97AQ_RUNNINGBOARD_TERMINATION_BINDING=NEGATIVE_ZERO_DIRECT_BINDINGS_FOR_EXACT_NATURAL_UUID_COHORT`.

This is a NEGATIVE about the RunningBoard binding channel, not a process-exit classification.

Exact MTLCompilerService process termination status remains:
`UNKNOWN/INCONCLUSIVE`.

The RunningBoard termination channel is now exhausted for this historical cohort and should not be revisited unless genuinely new identity evidence appears.

## Retained D97AP / D97AO evidence
D97AP specialized start->timing pairing remains CONTROL-FLOW PROVEN for observed logsite cohort: 7 starts, 7 timing logs, 5 PIDs with start+timing, zero unmatched starts/timings. Backend has 65 start logs and no static timing log site.

D97AO natural P7 validator CFG remains fully resolved: 408 decoded, 397 reachable, zero reachable unresolved indirects, all five known late xrefs STATIC-PROVEN reachable from normal entry. Runtime late-xref reachability and exact late predicate/counter values remain unresolved.

Retrospective confirms D96C/D97JB had a stable/universal six-counter boundary but recovered public continuity does not preserve exact raw counter values; do not invent them.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — D97AR read-only semantic capture design audit
Do not spend another reboot on coarse control-flow or termination plumbing.

D97AR must be a bounded ASUS2 read-only static audit of the exact current natural P7 validator, with no service launch or mutation. It should:
1. pin exact current target `e7739c... / UUID 0FC4...` without requiring current boot identity;
2. disassemble exact `validSimulatorMetadata` range and especially natural late region from former D97AD site through all five resource-limit predicates and the natural return/unwind region;
3. enumerate every stack/local/register operand used by the six late resource/metadata counters, without guessing names or offsets;
4. map each of the five predicates to exact compare instruction, condition code, diagnostic xref, failure path, success continuation and later return path;
5. enumerate calls in that region and all live/clobbered registers needed to design transparent pass-through instrumentation;
6. identify safe candidate instrumentation locations only after complete-instruction boundaries and prove they do not overlap D34 cave or existing P1/P2b/P3/AIR00/D34/P6/P7 patches;
7. inspect whether an existing non-destructive output/logging mechanism can transport raw numeric counter/predicate values without unified-log privacy truncation; if no safe existing channel is proven, report that explicitly rather than invent one;
8. output a concrete semantic-capture design matrix for a future single reboot: what values can be captured, at what exact addresses, with what preservation obligations, and what evidence class each capture could support.

D97AR is design/audit only. No source edit, no build, no Root Patch, no reboot. STOP after D97AR.
