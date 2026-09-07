# OCLP7 CHECKPOINT — D97GJ pipefail false negative; D97GK capture ready

Date: 2026-09-08 EEST

## Entering authority
- Corrected Root Patch is active and structurally/semantically proven through D97GH.
- User-authoritative accelerated boot boundaries remain:
  - accelerated #1: reboot 2026-09-07 23:41 local;
  - accelerated #2: reboot 2026-09-07 23:50 local;
  - recovery reboot: 2026-09-07 23:52 local.
- D97GI preserves the two accelerated experiments as distinct cohorts.

## D97GJ tooling stop
The first D97GJ capture helper printed system identity and boot history, then exited before either `ACCEL1_2341` or `ACCEL2_2350` log-capture section began.

Root cause is a shell-tooling false negative:
- helper used `set -Eeuo pipefail`;
- boot-history line was `/usr/bin/last reboot | /usr/bin/head -n 12 | tee ...`;
- `head` closes the pipe after 12 lines;
- upstream `last` can receive SIGPIPE;
- with `pipefail`, the pipeline becomes nonzero and `set -e` exits the helper.

Classification:
- D97GJ_ACCEL_LOG_CAPTURE=NOT_REACHED;
- D97GJ_ACCEL_RUNTIME_RESULT=INCONCLUSIVE / no new runtime claim;
- D97GJ_SYSTEM_MUTATION=NO;
- D97GJ_REBOOT=NO;
- D97GJ_STOP=TOOLING_FALSE_NEGATIVE.

No EFI, root, NVRAM or framebuffer mutation occurred.

## D97GK replacement helper
Published:
`OCLP-Continuity/artifacts/OCLP7_D97GK_TWO_ACCEL_BOOT_LOG_CAPTURE_V2.sh`

Identity:
- commit `5498cb7fe129141249cdd47c626ce272ae737ced`;
- Git blob `34d32b096472b850a1a154f7274b044df0e35609`.

Fix:
- writes complete `last reboot` output to a file first;
- reads first 12 lines from that file separately, eliminating the SIGPIPE/pipefail path.

D97GK retains the exact user-authoritative windows:
- ACCEL1: `2026-09-07 23:41:00` -> `23:49:59`;
- ACCEL2: `2026-09-07 23:50:00` -> `23:51:59`.

It captures read-only:
- focused unified logs;
- full WindowServer logs;
- graphics-kernel logs;
- decisive GPUPass/validateWithDevice/bad-bits/framebuffer hits;
- recent diagnostic reports;
- bounded D97EW cohort files for both accelerated boots and recovery.

## Current action
Remain in VESA recovery. Do not reboot and do not modify EFI.
Run D97GK and return its ZIP for exact comparison of the two accelerated windows against the prior D97FJ GPUPass/Metal validation frontier.
