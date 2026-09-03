# OCLP7 CHECKPOINT — D97AH ACCELERATED NEGATIVE; D97AF RUNTIME PROVENANCE 28/28; H4 NEGATIVE

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ROOTPATCH_FULL_PASS_ACCELERATED_BOOT_READY.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Root Patch/reboot remain manual-only and separately authorized.

D97AH exact application remains live at `/Applications/OpenCore-Patcher.app`, executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. D97AH manual Root Patch was previously audited FULL PASS, including exact D97AF UUID transaction and postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e` with frozen UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`.

## Correct accelerated/VESA chronology
Initial minute-level `last reboot` output showed reboot entries at 23:15 and 23:17. A later exact `kern.boottime` read established that the current VESA recovery session began at:

```text
Thu Sep 3 23:17:53 2026
kern.boottime sec=1788466673
```

Therefore all runtime evidence strictly before `2026-09-03 23:17:53 +0300` belongs to the D97AH accelerated/root-patched boot. This corrects an earlier provisional assumption that the WindowServer launched around 23:16:59 was VESA; it was still accelerated-boot evidence.

The current VESA session is excluded from accelerated-runtime conclusions in accordance with `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## D97AH accelerated boot — NEGATIVE_NO_USABLE_GUI
The accelerated boot did not produce a usable accelerated GUI.

Runtime evidence nevertheless proved the Haswell graphics stack reached real accelerated components: WindowServer initialized the Intel GPU `8086:0412`, `/IntelAccelerator`, and `AppleIntelFramebuffer@0/@1/@2`. WindowServer repeatedly requested Metal shader compilation. MTLCompilerService repeatedly spawned, became inactive during compiler communication, and WindowServer repeatedly reported `XPC_ERROR_CONNECTION_INTERRUPTED`; WindowServer itself entered the known downstream Metal pipeline failure/SIGABRT cycle.

The compact-log collector found exactly 28 MTLCompilerService spawn events and 28 corresponding service-inactive transitions in the accelerated boot cohort. This preserves the causal model:

`MTLCompilerService failure -> XPC interruption -> pipeline creation failure -> WindowServer abort`

Classification:

`D97AH_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`

WindowServer remains downstream, not the root cause.

## D97AF runtime provenance — PROVEN 28/28
A read-only JSON unified-log audit was run from the unchanged VESA recovery boot. It verified the current VESA boot identity before reading the preceding accelerated window, then collected structured MTLCompilerService and launchd records.

Exact cohort:

```text
MTL_JSON_RECORDS=140
LAUNCHD_JSON_RECORDS=5087
MTL_PROCESS_PID_COUNT=28
MTL_PROCESS_PIDS=350,358,362,364,370,372,375,379,383,386,390,391,398,403,405,407,423,425,429,431,432,434,435,437,440,442,444,446
```

Structured sender distribution contained exactly 28 records from:

```text
/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler
senderImageUUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
```

The diagnostic-specific subset was exhaustive for the cohort:

```text
DIAGNOSTIC_RECORD_COUNT=28
DIAG_SENDER_COUNT=28|PATH=/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler|UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
EXPECTED_STAMP_UUID_ALL_RECORD_MATCHES=28
OLD_UUID_ALL_RECORD_MATCHES=0
EXPECTED_STAMP_UUID_DIAG_MATCHES=28
OLD_UUID_DIAG_MATCHES=0
```

Every one of the 28 PIDs had exactly one diagnostic record whose `senderImagePath` was the exact 32023 MTLCompiler and whose `senderImageUUID` was the exact D97AF stamped UUID. The MTLCompilerService process image itself was consistently:

```text
/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService
processImageUUID=3716D20F-B990-3906-B3E5-44E88AE63AF8
```

Strongest supported classification:

- `D97AF_RUNTIME_PROVENANCE=PROVEN_28_OF_28_DIAGNOSTIC_COHORT`;
- `D97AF_RUNTIME_DIAGNOSTIC_SENDER_PATH=PROVEN_32023`;
- `D97AF_RUNTIME_DIAGNOSTIC_SENDER_UUID=PROVEN_A4F456DF_STAMP`;
- old D5CE UUID is NEGATIVE for this complete diagnostic cohort.

This proves that the UUID-only D97AF stamp was present in the exact runtime 32023 binary that emitted every observed compiler diagnostic in the failing accelerated cohort.

## H4 resolution
Retrospective H4 was:

`runtime request selects a different MTLCompiler generation than the instrumented visible 32023 donor`.

The exhaustive 28/28 sender-path + sender-UUID evidence directly rejects that hypothesis for the real D97AH failing diagnostic cohort.

Classification:

`H4=NEGATIVE_FOR_D97AH_28_OF_28_FAILING_DIAGNOSTIC_COHORT`

Do not broaden this beyond the observed cohort, but no further reboot should be spent merely asking whether the failing diagnostic sender is some hidden non-32023 MTLCompiler generation.

## Important remaining limitations
The JSON collector did NOT recover a reliable exact MTLCompilerService exit status. It printed:

```text
D97AD_110_114_LAUNCHD_EVIDENCE=110:0;111:0;112:0;113:0;114:0
LAUNCHD_EXIT1_TEXT_EVIDENCE_COUNT=0
```

These are only zero textual matches in captured launchd messages. They are NOT proof that those exit codes did not occur. The per-PID extraction recovered spawn/lifecycle records but no authoritative termination-status field.

Therefore:

- `D97AH_MTLSERVICE_EXACT_EXIT_STATUS=UNKNOWN_FROM_CURRENT_JSON_AUDIT`;
- `D97AD_110_114_RUNTIME_OUTCOME=INCONCLUSIVE_FROM_CURRENT_JSON_AUDIT`;
- do not reinterpret the zero textual matches as NEGATIVE evidence.

Also unchanged:

`D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED`.

Direct runtime text-byte reading is no longer required to establish sender provenance because structured unified-log sender metadata already proved the exact path and stamped UUID.

## Strategic consequence
D97AF has completed its intended provenance purpose. The project returns from H4 to the remaining causal families in the strategic retrospective:

- H1: Tahoe supplies an `llvm::Module*` whose metadata/resource representation differs from what the unchanged donor expects;
- H2: module data is equivalent but an external dependency/runtime ABI/context differs;
- H3: Tahoe generates a semantically different request/shader/module earlier and requires normalization before the donor consumes it.

Preserve the architecture rule: do not patch a late validator merely to tolerate bad data. The next functional correction, if eventually justified, must normalize the earliest demonstrated non-equivalent handoff.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
No Root Patch and no reboot are authorized now.

The next action must be a bounded read-only/static ASUS2 investigation that uses the now-proven 32023 provenance and decides which H1/H2/H3 boundary is worth testing. Before designing any new instrumentation, first determine from existing static/runtime evidence whether the exact diagnostic emitter / `senderProgramCounter` site is already mapped sufficiently. If it is already mapped, do not spend another probe on provenance/emitter localization; move directly to the nearest upstream payload/state handoff where Tahoe can be compared against persisted Golden/static donor semantics.

One bounded read-only action at a time; return complete raw output and STOP before any source mutation, build, Root Patch, or reboot.
