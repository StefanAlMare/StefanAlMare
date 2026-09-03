# OCLP7 CHECKPOINT — D97AH accelerated boot NEGATIVE; 28-service crash loop; JSON provenance/exit next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ROOTPATCH_FULL_PASS_ACCELERATED_BOOT_READY.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Root Patch/reboot remain manual-only and separately authorized.

D97AH build/private-release/artifact audit/deploy/open and manual Root Patch remain FULL PASS. Exact live D97AH app identity before the boot was executable SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. The real Root Patch committed the D97AF UUID-only postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e` and UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E` with metadata preservation and atomic rename PASS.

## Corrected boot chronology
Initial minute-only `last reboot` output showed:
- reboot 23:15;
- reboot 23:17.

The first runtime collector also printed the exact current-session `kern.boottime`:

`Thu Sep 3 23:17:53 2026`.

Therefore the current VESA recovery boot starts at approximately `23:17:53`, not at the earlier WindowServer launch around `23:16:59`. This corrects the earlier conversational assumption that the WindowServer process launched at 23:16:59 belonged to VESA.

Consequently WindowServer activity and crash reports at 23:16:59, 23:17:07 and 23:17:16 are still part of the immediately preceding accelerated/root-patched D97AH boot and are authoritative accelerated evidence. The VESA boot begins only at 23:17:53 and must be excluded.

## Accelerated D97AH runtime collector v2 — decisive evidence
The collector was read-only. Its compact unified-log summary reported:

```text
MATCHED_LOG_LINES=2869
A4F_UUID_MATCHES=0
OLD_D5CE_UUID_MATCHES=0
MTLCOMPILER_32023_PATH_MATCHES=0
MTLCOMPILER_3802_PATH_MATCHES=0
MTLCOMPILERSERVICE_MATCHES=230
XPC_INTERRUPTED_MATCHES=247
```

The zero UUID/path matches are not hard NEGATIVE provenance evidence because compact unified-log output does not establish that sender-image metadata fields are rendered. They are classified INCONCLUSIVE for runtime provenance.

The same file contains exactly 28 `Successfully spawned MTLCompilerService[...]` records and exactly 28 matching `service inactive: com.apple.MTLCompilerService...` records. WindowServer repeatedly reports `Compiler failed with XPC_ERROR_CONNECTION_INTERRUPTED`, including explicit `compiler service crashed during communication` retry messages.

The first accelerated WindowServer PID 177 was spawned at `23:15:53.014`, initialized the Intel Haswell GPU `8086:0412`, IntelAccelerator and framebuffers, then began Metal shader compilation and repeated MTLCompilerService respawns. It exited via SIGABRT at `23:16:45.736` after `54964ms`, and WindowServer PID 393 was spawned immediately afterwards. PID 393 repeated the same MTLCompilerService failure loop; WindowServer PID 439, spawned at `23:16:59.356`, is still in the accelerated boot because VESA boot time is 23:17:53.

Three diagnostic-report candidates were found in the relevant pre-VESA time period, all WindowServer reports at approximately 23:17:07/23:17:16. No MTLCompilerService `.ips`/`.crash` report was found by that collector.

Strongest supported runtime classifications:
- `D97AH_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`;
- Haswell GPU/IntelAccelerator/WindowServer Metal path = REACHED;
- repeated MTLCompilerService spawn -> communication -> service inactive loop = CONTROL-FLOW/FAILURE-LIFECYCLE PROVEN for the observed cohort;
- observed cohort size = 28 spawned services / 28 inactive services;
- downstream WindowServer abort/restart after compiler interruption = PROVEN;
- exact MTLCompilerService termination code/signal for each PID = UNKNOWN from the compact collector;
- D97AF stamped runtime `senderImageUUID`/`senderImagePath` = UNKNOWN/INCONCLUSIVE, not NEGATIVE;
- direct runtime text-byte read remains NOT PERFORMED.

The UUID-only D97AF stamp therefore did not by itself repair the graphical failure; the accelerated boot still fails at the compiler-service communication stage. This does not yet establish whether the stamped 32023 image is or is not the actual runtime sender.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 VESA session only. Do not Root Patch, reboot, modify source, app, system target or Golden.

Run one bounded read-only provenance/lifecycle collector over the corrected accelerated window ending strictly before current VESA boot (`23:17:53`). Use unified-log JSON for MTLCompilerService records so sender-image metadata such as `senderImageUUID` and `senderImagePath` can be inspected directly, and collect complete launchd lifecycle/accounting records for the same 28 service PIDs/job labels to recover exact termination codes/signals if present.

The next result must answer independently:
1. Do diagnostic records from the accelerated cohort carry stamped UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`, old UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, or another sender UUID/path?
2. What exact exit code/signal/accounting result did each of the 28 MTLCompilerService processes produce?
3. Does the D97AD liveness contract (`110..114`) fire for the cohort, or does the prior normal-exit behavior remain?

STOP after returning that read-only output. No new accelerated boot is authorized yet.