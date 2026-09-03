# OCLP7 CHECKPOINT — D97AH accelerated runtime collector attempt 1 pipefail false failure; rerun next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ROOTPATCH_FULL_PASS_ACCELERATED_BOOT_READY.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. No Root Patch or reboot mutation is authorized during runtime evidence collection.

D97AH Root Patch remains FULL PASS. Boot chronology supplied by ASUS2:

```text
reboot 23:17
reboot 23:15
shutdown 23:14
reboot 01:50
```

Operational interpretation remains: 23:15 accelerated D97AH boot; 23:17 VESA recovery boot. The WindowServer crash report captured at 23:17:13 launched at 23:16:59 and therefore belongs to VESA and is excluded from accelerated D97AH evidence.

## Collector attempt 1 — tooling false failure
The first read-only accelerated-runtime collector used `set -euo pipefail` and then executed:

```zsh
/usr/bin/last reboot | /usr/bin/head -n 8
```

The output contains exactly the eight expected chronology lines and then terminates immediately before the next command (`sysctl kern.boottime`). Under `pipefail`, `head` may close the pipe after eight lines and cause upstream `last` to terminate with SIGPIPE/non-zero status, which aborts the shell under `set -e`.

No runtime log collection, report scan, system mutation, Root Patch or reboot occurred.

Classification:
`D97AH_ACCEL_RUNTIME_COLLECTOR_ATTEMPT1=TOOLING_FALSE_FAILURE_PIPEFAIL_HEAD_SIGPIPE_NO_MUTATION`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 only. Rerun the same bounded read-only collector over the exact accelerated window `2026-09-03 23:14:55` through `2026-09-03 23:16:58`, changing only the chronology display from `last | head` to a pipefail-safe form such as `last reboot | sed -n '1,8p'`.

Preserve the same runtime predicates and diagnostic-report scan. The goal remains to establish from the accelerated boot only:
1. presence/absence of stamped UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E` versus old `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
2. actual `MTLCompiler` generation/path (`32023`, `3802`, or other);
3. launchd/MTLCompilerService termination outcomes;
4. any accelerated-window MTLCompilerService/WindowServer diagnostic reports.

STOP after collector output. No Root Patch, reboot, source/app/system/Golden mutation.