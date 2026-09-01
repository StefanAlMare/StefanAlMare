# OCLP PERMANENT VESA RECOVERY / ACCELERATED-BOOT EVIDENCE RULE

Restored: 2026-09-01 EEST
Scope: ASUS2 Tahoe Haswell and every OCLP7+ continuation.

## Core rule
After a Root Patch test, the accelerated boot normally produces no usable image on this machine. The user therefore cannot return to ChatGPT until recovering through VESA.

Normal sequence:
1. Root Patch is applied.
2. User boots the accelerated/root-patched configuration.
3. If no usable image appears, user hard-restarts/power-cycles.
4. User boots VESA and returns from that VESA session.

Consequently:
- the latest/current boot is ordinarily VESA recovery;
- the penultimate relevant boot is the accelerated diagnostic boot;
- hard restart and VESA boot are recovery operations, not compiler-failure evidence by themselves.

Never assume latest boot equals accelerated boot merely because the user is online.

## Runtime evidence selection
The authoritative rule is: analyze the immediately preceding accelerated diagnostic boot, not necessarily the immediately preceding system boot record.

Use `last reboot` chronology. If the user identifies which entry was accelerated and which was VESA, that identification is authoritative.

Scope unified logs, launchd markers, WindowServer events, MTLCompilerService events, crash reports and any other runtime evidence to the accelerated boot only. Do not mix the later VESA recovery session.

## Current D97V/D97W chronology
For the 2026-09-01 D97V test:
- 14:00 = accelerated D97V boot;
- 14:03 = current VESA recovery boot, excluded;
- 13:45 = older boot, excluded.

The D97W analysis window is `2026-09-01 13:59:30` through but not including `2026-09-01 14:03:00` EEST.
