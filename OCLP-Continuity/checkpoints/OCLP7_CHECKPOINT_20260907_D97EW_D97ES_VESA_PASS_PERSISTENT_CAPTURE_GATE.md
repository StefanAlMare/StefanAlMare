# OCLP7 D97EW — D97ES VESA PASS; persistent-capture gate before accelerated measurement

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Decisive VESA runtime result inherited from D97EV
The authorized D97ES 0.0.11 VESA validation boot completed with exact runtime PASS:
- loaded `OCLPMetalCompat` version `0.0.11`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- `D97ELObserverRequested = 1`;
- `D97ELCallbackSeenCount = 17`;
- `D97ELTargetCallbackSeenCount = 1`;
- `D97ELLastCallbackIndex = 20`;
- `D97ELKextLoadIndex = 9`;
- `D97ELRouteStatus = PASS`;
- `D97ELSetIdModeCallCount = 0`;
- `D97ESCaptureSlots = 8`;
- `D97ESCapturedCount = 0`;
- all `D97ES01Valid ... D97ES08Valid = 0`;
- `D97CTRouteStatus = PASS`;
- `D97CTBootArgGate = 1`;
- `D97CTKernelGate = 1`;
- `D97CTCpuGate = 1`;
- `D97CTBuildGate = 1`;
- `D97DDObservedBuild = 25G82`;
- `D97DIFunctionalRequested = 1`;
- `D97DIFunctionalMode = ACTIVE`;
- `D97CTPublisherTicks = 300`.

The active VESA args were unchanged:
`-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`, with `#-ocmcd97bvcave` inert.

Interpretation:
- exact D97ES observer route is healthy;
- publisher/schema are healthy;
- VESA correctly produces zero `set_id_mode` calls and zero tuples;
- publisher remains active to its bounded 300-second limit when no tuple arrives;
- D97ES tuple telemetry is ready for an accelerated request.

D97BV/D97DT remains CLOSED PASS. The zero SITE/CAVE touches in this particular VESA boot do not invalidate the already-proven runtime delivery path and are not to be retested absent contradiction.

## Methodology correction before acceleration
The D97ES tuple channel is live IORegistry state. A hard reboot into VESA necessarily destroys the immediately previous accelerated boot's IORegistry.

Therefore an accelerated test is only causally useful if tuple evidence is copied to persistent storage during that accelerated boot, independently of WindowServer, before any recovery power-cycle.

The preliminary D97EV accelerated authorization is consequently tightened prospectively: **do not perform the accelerated boot until a persistent collector is installed and itself live-validated in the current VESA session.** No accelerated boot occurred between D97EV and this D97EW correction.

## D97EW persistent collector authority
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`

Pinned identity:
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Static audit:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_CAPTURE_STATIC_AUDIT.md`
- commit `c0fb94b0a92d52ede5527bf8478b94c0593d948b`.

Collector design:
- bounded LaunchDaemon independent of WindowServer;
- starts every boot;
- polls `OCLPMetalCompat` IORegistry once per second, maximum 300 seconds;
- writes full snapshots and a compact summary to `/Users/Shared/OCLP-D97EW-Capture`;
- on first `D97ESCapturedCount > 0`, writes the first positive full snapshot, boot args and kext identity, issues immediate filesystem `sync`, captures five further one-second snapshots with sync, then exits;
- no EFI/NVRAM write, Root Patch, framebuffer change, Golden access or reboot.

## Classification
- `D97EW_D97ES_VESA_RUNTIME=PASS`;
- `D97EW_SET_ID_MODE_ROUTE=PASS`;
- `D97EW_PUBLISHER_SCHEMA=PASS`;
- `D97EW_EMPTY_SLOT_BEHAVIOR_VESA=PASS`;
- `D97EW_PERSISTENT_CAPTURE_STATIC_AUDIT=PASS`;
- `D97EW_ACCELERATED_BOOT_AUTHORIZED=NO_PENDING_LIVE_COLLECTOR_TEST`;
- `D97EW_ROOT_PATCH_AUTHORIZED=NO`;
- `D97EW_FUNCTIONAL_SET_ID_MODE_MASKING_AUTHORIZED=NO`.

## CURRENT ACTION — install and live-test persistent collector in current VESA session
On ASUS2, while remaining in the current VESA boot:
1. download the exact commit-pinned `OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh` artifact;
2. verify its identity against GitHub commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d` / blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`;
3. run the installer with `sudo`;
4. return the complete installer output including `D97EW_INSTALL_STATUS`, installed capture/plist SHA256 values, and the printed live-test summary rows.

Expected current-VESA live test:
- `D97EW_INSTALL_STATUS=PASS`;
- service `present`;
- `captured_count=0`;
- `set_id_mode_calls=0`;
- `route=PASS`.

No reboot, Root Patch, EFI change, boot-arg change or framebuffer change is authorized at this gate.

After the live-test evidence is independently audited and persisted, one accelerated diagnostic boot may be separately authorized with only `-igfxvesa` made inert and all other settled state unchanged.
