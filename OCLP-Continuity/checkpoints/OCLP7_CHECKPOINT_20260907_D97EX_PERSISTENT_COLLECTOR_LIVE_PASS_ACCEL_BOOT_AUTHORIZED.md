# OCLP7 D97EX — persistent collector live PASS / accelerated measurement gate

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2

## Settled authority
- D97DX native-Metal-safe Root Patch remains installed.
- Active EFI kext is audited D97ES `OCLPMetalCompat.kext` 0.0.11.
- D97ES executable SHA256: `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`.
- D97ES UUID: `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.
- D97EV already proved D97ES VESA route/publisher/empty-slot behavior PASS.
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34. Golden remains immutable/read-only. D50/D68/D82 remain reserve-only.

## D97EW collector identity/install PASS
Authoritative artifact:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`

Pinned identity:
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

ASUS2 verified expected blob equals actual blob exactly.

Installer result:
- plist lint PASS;
- `D97EW_INSTALL_STATUS=PASS`;
- installed capture SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- installed plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`;
- output base `/Users/Shared/OCLP-D97EW-Capture`;
- launchd label `com.oclp.d97ew.capture`;
- install performed no EFI mutation, Root Patch or reboot.

## Live VESA proof
Live run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T114037Z-1039`

Launchd reports the collector running as PID 1039.

Repeated samples through at least ticks 10..29 all report:
- service `present`;
- `captured_count=0`;
- `set_id_mode_calls=0`;
- `route=PASS`.

Direct IORegistry cross-check at the same time reports:
- `D97ELRouteStatus=PASS`;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCapturedCount=0`;
- all `D97ES01Valid`..`D97ES08Valid=0`.

Therefore the collector's read path and persisted summary agree exactly with the authoritative live D97ES state.

## Transport conclusion
D97ES records the first eight tuples atomically after Apple's original `set_id_mode` returns and publishes them asynchronously to IORegistry. The collector is independent of WindowServer and persists full IORegistry snapshots under `/Users/Shared`; when `D97ESCapturedCount` becomes positive it preserves the full snapshot plus boot/kext identity and syncs the evidence. The prior observability gap is therefore closed sufficiently for one accelerated measurement boot.

## Classification
- `D97EX_COLLECTOR_SOURCE_IDENTITY=PASS`
- `D97EX_COLLECTOR_INSTALL=PASS`
- `D97EX_LAUNCHD_RUNNING=PASS`
- `D97EX_LIVE_IOREG_READ=PASS`
- `D97EX_LIVE_DISK_PERSISTENCE=PASS`
- `D97EX_VESA_ZERO_TUPLE_CROSSCHECK=PASS`
- `D97EX_ACCELERATED_EVIDENCE_TRANSPORT_READY=PASS`
- `D97EX_ROOT_PATCH_AUTHORIZED=NO`
- `D97EX_FUNCTIONAL_SET_ID_MODE_MASKING_AUTHORIZED=NO`
- `D97EX_ONE_ACCELERATED_MEASUREMENT_BOOT_AUTHORIZED=YES`

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Required next runtime evidence remains exact `id`, `mode`, `badBits`, `goodBits` and original IOReturn from the accelerated boot.

## CURRENT ACTION
Perform exactly one accelerated diagnostic boot by making only `-igfxvesa` inert/disabled. Keep `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh`, inert `#-ocmcd97bvcave`, D97DX, D97ES 0.0.11, D97EW collector, normal 3/3/3 framebuffer baseline and every other settled state unchanged. No Root Patch and no additional T2/Haswell boot variables or functional `set_id_mode` change are authorized.

If the accelerated boot has no usable image, allow the running system enough time for the already-installed collector to persist its evidence before VESA recovery. After returning to VESA, analyze the persisted D97EW run that corresponds to the immediately preceding accelerated boot, excluding the later recovery run.
