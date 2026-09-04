# OCLP7 CHECKPOINT — 2026-09-04 — D97AP specialized timing pairing PROVEN; termination monitor exits unbound; D97AQ next

## Authority / carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/static/log work stays ASUS2. GitHub only for major compile/build/package. Root Patch/reboot manual-only.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AO_NATURAL_P7_ALL_FIVE_STATIC_REACHABLE_RUNTIME_PCS_OUTER_D97AP_TERMINATION_LOGSITE_AUDIT_NEXT.md`.

Historical runtime window remains fixed to accelerated D97AM boot `2026-09-04 02:29:00..02:31:59` local, with 02:32 VESA recovery excluded. Later current boot `10:08:19` does not alter the historical accelerated window.

## D97AP wrapper / target identity
Read-only wrapper:
- `OCLP7_D97AP_READONLY_ACCEL_0229_TERMINATION_AND_OUTER_LOGSITE_LIFECYCLE_AUDIT.command`;
- commit `1def667693ad51fdfb436eb5f5b60459ce2da430`;
- Git blob `2f7f0ad4e48232f32f78d7de7e6308164c412bcd`.

Wrapper identity/parse passed. Exact current natural target revalidated:
```text
TARGET_BYTES=1636896
TARGET_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
MACHO_LC_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
D97AP_TARGET_SHA_IDENTITY=PASS
D97AP_TARGET_LC_UUID_IDENTITY=PASS
```
No source/app/system/Golden/service-launch/Root-Patch/snapshot/reboot mutation occurred.

## Exact outer os_log site reconciliation — PASS
D97AP found exactly three relevant `__os_log_impl` sites in the two outer functions:

```text
SPECIALIZED 0x9FFE9 -> sender PC 0x9FFEE -> "Build request: %s"
SPECIALIZED 0xA051C -> sender PC 0xA0521 -> "Compilation (%s) time %f ms"
BACKEND     0xA5F7C -> sender PC 0xA5F81 -> "Build request: %s"
```

All three D97AN runtime PCs map exactly to those sender return PCs:
`D97AP_D97AN_OUTER_PC_LOGSITE_RECONCILIATION=PASS`.

Exact natural-UUID runtime record count remained 79:
- `0x9FFEE` specialized start = 7;
- `0xA0521` specialized timing = 7;
- `0xA5F81` backend start = 65.

This definitively reclassifies the D97AN sender PCs as outer os_log sender PCs, not validator-local late-xref PCs.

## Specialized request lifecycle — CONTROL-FLOW PROVEN for observed logsite cohort
Static site counts:
```text
SPECIALIZED_START_STATIC_SITE_COUNT=1
SPECIALIZED_TIMING_STATIC_SITE_COUNT=1
BACKEND_START_STATIC_SITE_COUNT=1
BACKEND_TIMING_STATIC_SITE_COUNT=0
```

Runtime counts:
```text
SPECIALIZED_START_RUNTIME_COUNT=7
SPECIALIZED_TIMING_RUNTIME_COUNT=7
BACKEND_START_RUNTIME_COUNT=65
BACKEND_TIMING_RUNTIME_COUNT=0
```

Per-PID ordering shows all observed specialized starts are followed by the specialized timing site in the same PID. Five PIDs contain the specialized cohort; two of those PIDs carry two start->timing pairs. Counters:
```text
SPECIALIZED_PID_HAS_START_AND_TIMING=5
SPECIALIZED_PID_HAS_START_WITHOUT_TIMING=0
SPECIALIZED_PID_HAS_TIMING_WITHOUT_START=0
D97AP_SPECIALIZED_START_TIMING_PAIRING=PROVEN_FOR_OBSERVED_LOGSITE_COHORT
```

Classification: `CONTROL-FLOW PROVEN` from specialized start to specialized timing site for the observed logsite cohort. This is not semantic proof that compilation output is correct.

Every one of those five specialized PIDs subsequently also has at least one backend-start log. The 65 backend-start records dominate the cohort. Since `backendCompileExecutableRequest` has no analogous timing os_log site statically, absence of a backend timing event carries no completion/termination meaning.

## D97AP selected-system-log termination parser — raw-audit correction
D97AP printed:
```text
SYSTEM_TERMINATION_RELEVANT_COUNT=225
SYSTEM_TERMINATION_STRONG_TEXT_COUNT=11
D97AP_EXACT_TERMINATION_CHANNEL=STRONG_TEXT_CANDIDATES_PRESENT_REQUIRES_RAW_AUDIT
```

Raw audit invalidates all 11 as direct MTLCompilerService termination evidence:
- 2 records are unrelated `com.apple.fskit.msdos` jetsam-priority messages;
- 9 records are RunningBoard/kernel coalition-role lookup messages. They matched because a coalition/resource/jetsam numeric ID happened to equal one of the known MTLCompilerService PID numbers; the message's actual `PID N` is not a known natural-UUID MTLCompilerService PID.

Therefore `SYSTEM_TERMINATION_STRONG_TEXT_COUNT=11` must NOT be promoted to termination evidence.

## Unbound monitor-exit records remain potentially useful
D97AP also exposed monitor-level exit records that are not yet bound to a concrete process identity:
- `C49BD1BD-7C83-4485-BABF-3E68EF7C360E` -> `wait4() status=0` at 02:31:02.000262;
- `BA998713-FA47-412C-9759-15A4D57D5C25` -> `wait4() status=0` at 02:31:06.659851;
- `DC536E1E-D54D-4B60-A6D4-1BE777B29FA2` -> `exit reason namespace=2 code=9` at 02:31:06.685618;
- `763AB483-36ED-4AFF-ABE0-06F8316501C1` -> `wait4() status=0` at 02:31:18.120745;
- `367EC4A6-D491-4FF2-AD31-FE96164B7B2F` -> `wait4() status=0` at 02:31:31.937501.

A separate earlier monitor UUID `04460BC6-8141-403C-9025-E8386A1A2D2E` is directly associated with unrelated `fskit.msdos` activity and is not relevant.

The five remaining monitor UUIDs cannot yet be called MTLCompilerService exits. They require direct monitor-UUID -> process descriptor/PID binding from RunningBoard logs.

Authoritative current MTLCompilerService exact termination status remains `UNKNOWN/INCONCLUSIVE`.

## DiagnosticReports scan
D97AP found 14 filesystem DiagnosticReports mentioning MTLCompilerService. Every listed file/capture belongs to `2026-08-31`, with historical SIGILL instrumentation-era crashes. None belongs to the D97AM `2026-09-04 02:29` accelerated cohort.

Per permanent rules, absence of a new `.ips`/`.crash` report is NOT a hard negative and does not establish normal exit.

## D97AO evidence retained
Natural P7 `validSimulatorMetadata` CFG remains fully resolved with zero reachable unresolved indirects and all five late xrefs STATIC-PROVEN reachable from normal entry. This remains static evidence only; runtime late-xref reachability and exact late semantic counter/predicate values remain unresolved.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — D97AQ RunningBoard monitor binding
Before any new build/Root Patch/reboot, use a bounded read-only historical-log audit to bind the five unbound monitor UUIDs to actual process identities.

D97AQ should:
1. revalidate exact natural target `e7739c... / 0FC4...` without requiring a particular current boot;
2. re-query the fixed 02:29..02:31:59 historical MTLCompilerService log to reconstruct the exact natural-UUID PID set;
3. query all RunningBoard records in the historical window;
4. for each monitor UUID that emitted `wait4() status=0` or `exit reason namespace=2 code=9`, print all same-monitor records and extract any direct process descriptor, executable/bundle/service name and PID;
5. classify a monitor exit as MTLCompilerService only if the same monitor UUID is directly bound in RunningBoard text/structured fields to MTLCompilerService and a PID in the exact natural-UUID PID set;
6. keep temporal-nearest launchd service events separate as correlation only, never as direct identity;
7. if exact binding succeeds, report the directly supported exit/wait status per MTLCompilerService PID; otherwise keep termination UNKNOWN.

STOP after D97AQ. No Root Patch/reboot/service launch/source/app/system/Golden/snapshot mutation. Any later reboot must capture semantic payload/branch information.