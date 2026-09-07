# OCLP7 D97EW — persistent IORegistry capture static audit

Date: 2026-09-07 EEST

Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`

Pinned source authority:
- commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

## Purpose
D97ES 0.0.11 publishes captured `set_id_mode` tuples only through live IORegistry. A VESA recovery reboot necessarily destroys the prior boot's IORegistry. Therefore an accelerated boot that loses graphics must have an automatic, filesystem-persistent collector running independently of WindowServer before the experiment is authorized.

The D97EW helper installs one bounded LaunchDaemon and immediately starts the same collector in the current VESA boot for a no-reboot live test.

## Static behavior audit
Installer writes only its own bounded diagnostic files:
- `/Library/Application Support/OCLP-D97EW/d97ew-capture.sh`;
- `/Library/LaunchDaemons/com.oclp.d97ew.capture.plist`;
- `/Users/Shared/OCLP-D97EW-Capture/...` evidence output.

It does NOT:
- write EFI;
- write NVRAM;
- change boot args;
- Root Patch;
- change framebuffer state;
- write the sealed system/root snapshot;
- touch Golden;
- reboot or power-cycle.

Read-only identity/evidence commands used by the collector:
- `sw_vers`;
- `uname`;
- `nvram boot-args` (read only);
- `kmutil showloaded`;
- `ioreg -r -c OCLPMetalCompat -l -w0`.

## Capture semantics
At every system boot the LaunchDaemon starts independently of WindowServer and polls the `OCLPMetalCompat` IORegistry service once per second for at most 300 seconds.

Each tick stores the full IORegistry snapshot plus a summary containing:
- service present/absent;
- `D97ESCapturedCount`;
- `D97ELSetIdModeCallCount`;
- `D97ELRouteStatus`.

When `D97ESCapturedCount > 0`:
1. the first positive full IORegistry snapshot is copied to `TUPLE_CAPTURE_FIRST.txt`;
2. boot args and loaded-kext state are captured again;
3. filesystem `sync` is issued immediately;
4. five additional one-second IORegistry snapshots are written and synced;
5. the collector exits successfully.

If no tuple appears, it exits after 300 ticks with `D97EW_CAPTURE_STATUS=TIMEOUT_NO_TUPLE`.

The log/output directory is preserved across a later hard reboot. Thus D97ES tuple evidence can survive the mandatory VESA recovery sequence.

## Live-test gate
Installation itself bootstraps and kickstarts the LaunchDaemon in the current VESA session and prints the newest run plus the last summary rows after three seconds.

Required VESA live-test behavior before any accelerated boot:
- installer `PASS`;
- service becomes `present`;
- `captured_count=0`;
- `set_id_mode_calls=0`;
- `route=PASS`;
- no EFI/NVRAM/Root Patch/reboot action occurs.

## Uninstall behavior
`--uninstall` bootouts the LaunchDaemon and removes only the installed plist/capture script. Evidence under `/Users/Shared/OCLP-D97EW-Capture` is intentionally preserved.

## Classification
- `D97EW_STATIC_SCOPE_AUDIT=PASS`;
- `D97EW_WINDOWSERVER_INDEPENDENCE=PASS`;
- `D97EW_PERSISTENT_EVIDENCE_DESIGN=PASS`;
- `D97EW_NO_EFI_MUTATION=PASS`;
- `D97EW_NO_NVRAM_WRITE=PASS`;
- `D97EW_NO_ROOT_PATCH=PASS`;
- `D97EW_NO_REBOOT=PASS`;
- `D97EW_ACCELERATED_BOOT_AUTHORIZED=NO_UNTIL_LIVE_VESA_TEST_PASS`.
