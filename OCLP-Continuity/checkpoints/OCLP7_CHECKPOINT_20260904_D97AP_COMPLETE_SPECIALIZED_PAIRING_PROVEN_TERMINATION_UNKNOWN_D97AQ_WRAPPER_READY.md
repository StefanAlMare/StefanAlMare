# OCLP7 CHECKPOINT — 2026-09-04 — D97AP complete; specialized pairing PROVEN; exact termination UNKNOWN; D97AQ wrapper ready

## Authority / carry-forward
Target ASUS2 Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600, SMBIOS `MacBookAir6,2`. Accepted functional baseline exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/static/log work ASUS2; GitHub only major compile/build/package. Root Patch/reboot manual-only.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AP_SPECIALIZED_TIMING_PAIRING_PROVEN_TERMINATION_UNBOUND_D97AQ_RUNNINGBOARD_MONITOR_BINDING_NEXT.md`.

Historical accelerated window remains `2026-09-04 02:29:00..02:31:59` local; 02:32 VESA recovery excluded. Later current boots do not redefine this historical evidence.

## D97AP exact result
Read-only wrapper `OCLP7_D97AP_READONLY_ACCEL_0229_TERMINATION_AND_OUTER_LOGSITE_LIFECYCLE_AUDIT.command`, commit/blob `1def667693ad51fdfb436eb5f5b60459ce2da430 / 2f7f0ad4e48232f32f78d7de7e6308164c412bcd`.

Exact target revalidated `1636896 / e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`, UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`.

Three exact static os_log sites:
- specialized start call `0x9FFE9`, sender PC `0x9FFEE`, `Build request: %s`;
- specialized timing call `0xA051C`, sender PC `0xA0521`, `Compilation (%s) time %f ms`;
- backend start call `0xA5F7C`, sender PC `0xA5F81`, `Build request: %s`.

D97AN runtime PCs reconcile exactly: `D97AP_D97AN_OUTER_PC_LOGSITE_RECONCILIATION=PASS`. Exact natural-UUID counts remain 7 specialized start, 7 specialized timing, 65 backend start = 79.

Specialized lifecycle:
```text
SPECIALIZED_START_RUNTIME_COUNT=7
SPECIALIZED_TIMING_RUNTIME_COUNT=7
SPECIALIZED_PID_HAS_START_AND_TIMING=5
SPECIALIZED_PID_HAS_START_WITHOUT_TIMING=0
SPECIALIZED_PID_HAS_TIMING_WITHOUT_START=0
D97AP_SPECIALIZED_START_TIMING_PAIRING=PROVEN_FOR_OBSERVED_LOGSITE_COHORT
```
Classification: CONTROL-FLOW PROVEN from specialized start to timing site for the observed logsite cohort. Not semantic proof.

Backend has one start log site and zero timing log sites statically; therefore backend timing absence is non-evidence.

## Termination-channel raw audit
D97AP printed 225 relevant / 11 strong candidates. Raw audit invalidates all 11 as direct MTLCompilerService termination evidence:
- 2 unrelated fskit.msdos jetsam-priority records;
- 9 coalition-role lookup records where resource/jetsam numeric IDs coincidentally matched known service PID numbers; the actual queried PID was not one of the exact natural-UUID service PIDs.

Five RunningBoard monitor exits remain unbound:
- C49BD1BD-7C83-4485-BABF-3E68EF7C360E -> wait4() status=0 @ 02:31:02.000262;
- BA998713-FA47-412C-9759-15A4D57D5C25 -> wait4() status=0 @ 02:31:06.659851;
- DC536E1E-D54D-4B60-A6D4-1BE777B29FA2 -> exit reason namespace=2 code=9 @ 02:31:06.685618;
- 763AB483-36ED-4AFF-ABE0-06F8316501C1 -> wait4() status=0 @ 02:31:18.120745;
- 367EC4A6-D491-4FF2-AD31-FE96164B7B2F -> wait4() status=0 @ 02:31:31.937501.

These are not MTLCompilerService evidence until same-monitor direct identity/PID is recovered. Exact MTLCompilerService termination remains UNKNOWN/INCONCLUSIVE.

DiagnosticReports: 14 MTLCompilerService files found, all from 2026-08-31 historical SIGILL instrumentation-era runs; none belongs to 2026-09-04 02:29. Missing current .ips is not a hard negative.

D97AO remains: natural P7 all five late xrefs STATIC-PROVEN reachable, zero reachable unresolved indirects. Runtime late-xref reachability and exact semantic predicate/counter values remain unresolved.

Retrospective confirms D96C/D97JB had a stable/universal six-counter boundary, but recovered public continuity/commit messages do not preserve the raw exact values. Do not invent or assume those values.

## D97AQ wrapper prepared
Public read-only wrapper:
- `OCLP7_D97AQ_READONLY_ACCEL_0229_RUNNINGBOARD_MONITOR_TO_MTLCOMPILER_PID_BINDING_AUDIT.command`;
- commit `a2762e5c452c904f528d66fe0b463aaa62746e3b`;
- Git blob `e45a966be84327615321a872855fde9204486981`.

D97AQ revalidates exact target, reconstructs the exact natural-UUID MTLCompilerService PID set from the fixed historical window, queries all RunningBoard records, groups every monitor-exit UUID across all same-UUID records, and permits a direct MTLCompilerService binding only if the same monitor group contains direct `MTLCompilerService` identity text and exactly one PID belonging to the exact natural-UUID PID set. Temporal proximity is explicitly not used as identity.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Run D97AQ once on ASUS2 and return complete output. STOP after D97AQ. No Root Patch, reboot, service launch, source/app/system/Golden/snapshot mutation.

If D97AQ cannot bind the monitor exits directly, exact termination stays UNKNOWN and the next reboot, if any, must be a semantic payload/branch-state diagnostic rather than another coarse control-flow marker.