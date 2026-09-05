# OCLP7 CHECKPOINT — D97BJ accelerated boot kernel panic; snapshot restored; evidence collection next

Date: 2026-09-05 EEST

## Entering state
- D97BJ Tahoe 26.6.2 / 25G82 Root Patch execution previously completed successfully.
- Exact local MetallibSupportPkg 26.6.2-25G82 was used.
- Exact Tahoe 25G82 metallib map, Monterey GVA/OpenCL and Intel Haswell patchset were installed.
- Official Dortania privileged helper was restored and verified before accelerated boot.

## New user-reported accelerated boot result
The user manually attempted the accelerated/root-patched Tahoe boot.

Observed behavior reported by user:
- the machine did not progress to the historical black-screen / later-VESA behavior;
- instead it hit a kernel panic and automatically restarted;
- the user attempted accelerated boot twice and reports both relevant accelerated attempts as the two boots preceding the later VESA/recovery boots, but exact chronology still requires `last reboot` confirmation;
- after recovery into VESA, the user could not obtain a usable patched boot and therefore restored the sealed/saved system snapshot;
- current state is Tahoe VESA / no Root Patch.

The snapshot restore is a recovery action and does not invalidate the accelerated-boot failure evidence.

## Evidence classification at this checkpoint
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS` remains unchanged.
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE` by user-observed outcome.
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_RESTART=USER_OBSERVED_PROVEN`.
- `D97BJ_ACCELERATED_BOOT_PANIC_ROOT_CAUSE=UNKNOWN_PENDING_LOCAL_EVIDENCE`.
- `D97BJ_CURRENT_ROOT_PATCH_STATE=RESTORED_TO_UNPATCHED_SNAPSHOT`.

Do not reuse the older 03:31/03:35 crash evidence as a substitute for this incident. Library search confirms those older artifacts predate the D97BJ accelerated attempts and contain no directly matching `panic(cpu...)` / Haswell-kext panic record.

## Public comparator
A current OCLP-T2 issue exists for MacBookPro11,1 (Haswell-era) on Tahoe 26.6.2 with boot failure. The maintainer explicitly requests NVRAM `aapl,panic-info` or verbose `debug=0x100` evidence before assigning a root cause. This is contextual evidence only; it does not classify ASUS2.

## CURRENT ACTION
Remain unpatched in current VESA/recovery state.

Collect read-only evidence for the relevant boot sequence before any new Root Patch or accelerated attempt:
1. `last reboot` chronology (at least last 8 entries);
2. NVRAM panic keys including `aapl,panic-info` and current boot-args;
3. all Kernel/panic DiagnosticReports generated on 2026-09-05 around the accelerated attempts;
4. filtered unified logs for kernel panic / Previous shutdown cause / watchdog / kernel collection / kext / Haswell graphics events over the relevant time window;
5. current snapshot/root-patch state only as recovery baseline.

Then identify the two accelerated boot windows exactly and analyze only those windows. If a panic report names a kext/backtrace, promote that module boundary immediately. Do not return to MTLCompilerService/WindowServer diagnostics unless evidence proves userspace/graphics-server execution was reached.

No Root Patch is authorized. No accelerated reboot is authorized until panic root-cause evidence is audited.