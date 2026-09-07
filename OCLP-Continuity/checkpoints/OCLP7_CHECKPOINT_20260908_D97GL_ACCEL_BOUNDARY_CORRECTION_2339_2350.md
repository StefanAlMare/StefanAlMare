# OCLP7 CHECKPOINT — D97GL accelerated boot boundary correction

Date: 2026-09-08 EEST

User-authoritative accelerated boot boundaries are:
- Accelerated #1: reboot at `2026-09-07 23:39` local time.
- Accelerated #2: reboot at `2026-09-07 23:50` local time.
- Recovery VESA begins at reboot `2026-09-07 23:52` local time.

The prior D97GK helper used `23:41` as ACCEL1 start and is therefore superseded for the first-window boundary.

D97GL corrected capture windows:
- ACCEL1: `2026-09-07 23:39:00` through `2026-09-07 23:49:59`.
- ACCEL2: `2026-09-07 23:50:00` through `2026-09-07 23:51:59`.

No EFI, NVRAM, framebuffer, Root Patch, Restore, or reboot action is authorized or implied by this correction.

Helper authority:
- `OCLP-Continuity/artifacts/OCLP7_D97GL_TWO_ACCEL_BOOT_LOG_CAPTURE_V3.sh`
- commit `d90195836c860996a4abf5ce5aabe6b3f16ad653`
- Git blob `9b8c09827f99b3ad9a23ddb5239831f104acc898`.
