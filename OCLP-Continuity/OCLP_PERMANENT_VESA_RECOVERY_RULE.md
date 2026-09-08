# OCLP PERMANENT VESA RECOVERY / ACCELERATED-BOOT EVIDENCE RULE

Restored: 2026-09-01 EEST
Updated: 2026-09-08 EEST — reconciled after D97HV chronology correction
Scope: ASUS2 Tahoe Haswell and every future OCLP continuation.

## Core recovery rule
After a Root Patch test, an accelerated boot may produce no usable image. The user can then return to ChatGPT only after a hard restart/power-cycle and a VESA recovery boot.

Normal sequence:
1. Root Patch is applied and audited.
2. User boots the accelerated/root-patched configuration.
3. If no usable image appears, user hard-restarts/power-cycles.
4. User restores the VESA-safe boot state and boots recovery.
5. User returns to ChatGPT from the VESA session.

Consequently:
- the current/latest online boot is often VESA recovery;
- the accelerated experiment may be an earlier immediately preceding boot;
- hard restart and VESA recovery are recovery actions, not compiler-failure evidence by themselves.

Never assume the latest boot equals the accelerated boot merely because the user is online.

## Authoritative boot identification
The user's identification of which boot was accelerated and which boot was VESA recovery is authoritative.

Corroborate with:
- `last reboot` chronology;
- WindowServer launch/crash times;
- launchd events;
- MTLCompilerService events;
- crash-report `captureTime` / launch time;
- persistent collector bootargs when reliable.

If collector-derived boot chronology conflicts with the user's identified boot and the collector has a tooling defect, the tooling result is not allowed to override the user-authoritative boot boundary.

## Durable experiment identity
For permanent documentation, identify each accelerated experiment by an explicit timestamped window or unique experiment name.

Do **not** use mutable ordinal labels such as:
- latest boot;
- previous boot;
- penultimate boot;
- antepenultimate boot.

Those labels change after later recovery/reboots and are not durable identifiers.

## Runtime evidence selection
Analyze only the accelerated experiment's own bounded window.

Scope to that window:
- unified logs;
- WindowServer activity;
- MTLCompilerService activity;
- launchd service lifecycle;
- `.ips` reports;
- GPU/compiler diagnostics;
- IORegistry/persistent collector state when it belongs to that same boot.

Do not mix the later VESA recovery session into the accelerated cohort.

Do not mix historical crash reports merely because they still exist in `/Library/Logs/DiagnosticReports`.

## Missing `.ips` discipline
Absence of a current `.ips` file is not automatically a negative. A process may exit/be invalidated without producing a crash report.

Use the strongest available combination of launchd, unified log, process restart behavior and crash-report evidence.

## Canonical D97HV warning example
D97HV incorrectly parsed `kern.boottime` and produced a 1970 boot start. Its collector then copied historical IPS and automatically mixed:
- old pre-P1 NULL-call reports;
- P1-only StringMap reports;
- current P1+P3 WindowServer evidence.

Therefore D97HV's automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` was invalid tooling contamination, not a semantic result.

The authoritative P1+P3 accelerated experiment was reconstructed from user identification and timestamps as:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Recovery VESA begins only around `14:28:38.955` with the next WindowServer session.

Thus `14:25:*` and `14:26:*` WindowServer crashes belong to the accelerated P1+P3 experiment and must not be labeled recovery-VESA evidence.

## Current permanent rule
Whenever a no-GUI experiment is followed by VESA recovery:
1. bind the accelerated experiment explicitly by time;
2. bind recovery separately;
3. analyze only accelerated evidence for compiler/frontier claims;
4. use recovery only to verify post-recovery safety/current root state;
5. persist the timestamped accelerated boundary immediately after it is established.