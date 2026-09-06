# OCLP7 CHECKPOINT — D97EA accelerated boot failure chronology fixed

Date: 2026-09-07 EEST

## Entering state
- D97DX native-Metal-safe Root Patch completed PASS on ASUS2.
- Pre-reboot helper identity PASS: official Dortania helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, TeamIdentifier `S74BDJXQMD`.
- Boot args before test retained `-igfxvesa -ocmcdiag -ocmcd97bv`.

## User-observed accelerated boot attempt
User reports that the accelerated/root-patched attempt progressed through verbose boot to the black-screen GUI transition point where the progress bar would normally appear. Verbose text then reappeared. User powered the machine off with the physical button and recovered into the established VESA configuration.

This observation is not yet classified as kernel panic, compiler failure, or userspace orderly shutdown.

## Exact reboot chronology
Returned `last reboot | head -n 8`:
- reboot `2026-09-07 02:25` — current VESA recovery boot;
- reboot `2026-09-07 02:23` — accelerated diagnostic boot;
- shutdown `2026-09-07 02:23` — lifecycle event associated with accelerated attempt;
- reboot `2026-09-07 02:12` — prior root-patched VESA boot;
- shutdown `2026-09-07 02:11`;
- older boots excluded.

Authoritative classification:
- `D97EA_ACCELERATED_BOOT=2026-09-07 02:23 EEST`;
- `D97EA_VESA_RECOVERY_BOOT=2026-09-07 02:25 EEST`;
- `D97EA_ACCELERATED_LOG_WINDOW=2026-09-07 02:22:30 through 2026-09-07 02:24:59 EEST`;
- current VESA session MUST be excluded from accelerated failure analysis.

The same-minute `shutdown time 02:23` is evidence that an orderly userspace shutdown/restart remains plausible and must be distinguished from panic/watchdog/power loss using unified logs and crash reports.

## Current action
Do NOT repeat accelerated boot.
Do NOT remove or alter recovery VESA policy.
Collect read-only evidence only from the exact accelerated window above, plus relevant crash reports and lifecycle records, while currently booted in VESA.

Permanent VESA recovery rule remains authoritative.
