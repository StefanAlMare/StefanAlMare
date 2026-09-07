# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97EX_PERSISTENT_COLLECTOR_LIVE_PASS_ACCEL_BOOT_AUTHORIZED.md`.
Permanent database/rules and the incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / baseline
Current architecture: native Tahoe Metal/Metal4 with selective true-3802 ingress and otherwise unchanged Tahoe semantics.

Accepted functional baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

Golden Sequoia remains immutable/read-only. D50/D68/D82 remain reserve-only. D84 is retired. D34 cave remains protected.

Closed branches include legacy-main-Metal shadowing, global forced-3802/global 32023 rewrite, standalone reconstructed carrier and framebuffer-count tuning.

## Early compiler/path history
Earlier OCLP1-OCLP7 work established the accepted five-patch compiler/request bridges, AIR 2.6 / Metal 3.1 semantics, downstream compiler-service progress, and the far-frontier methodology. Historical over-probing and cross-PID sampling errors drove the permanent module-boundary + semantic-evidence + universal/no-PID rules. Full detailed chronology remains in `OCLP_PERMANENT_PROJECT_DATABASE.md` and prior checkpoints.

## D97BV / D97DT — selective 3802 runtime closure
Selective adapter semantics:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor sequence.

D97DL 0.0.7 became source authority. D97DT closed runtime CAVE/SITE delivery, validation safety and cross-process visibility under exact 25G82. This lane is CLOSED PASS and should not be retested absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch execution PASS installed the bounded architecture:
- native Tahoe main Metal authoritative;
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes and compatibility payloads;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL plus Haswell graphics drivers;
- no legacy main Metal shadow, no MetalOld, no true-five replay.

## D97EB / D97EE — accelerated core failure
Normal 3/3/3 and isolated 1/1/1 both reached:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV.

No kernel panic and no `_MTL4*` superclass regression. The 1/1/1 experiment was NEGATIVE; normal 3/3/3 remains authoritative.

## D97EG-D97EP — exact set_id_mode observer
D97EG mapped the exact imported symbol as `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)` in IOAcceleratorFamily2 487.4.3.

D97EH established exact observe-only passthrough: Apple original receives unchanged `that/id/mode`, is called first, and exact original IOReturn is returned unchanged. D97EL preserved those semantics and added route/callback telemetry.

D97EP VESA proved observer request active, global callback active, exact IOAcceleratorFamily2 target callback seen and route PASS, with zero set_id_mode calls in VESA as expected.

## D97EQ / D97ER — accelerated repro and transport gap
D97EQ reproduced the accelerated failure after `GPU: FB: 3 of 3 opened`, with four bad-bits errors, display offline about 3 ms later and WindowServer SIGSEGV about 20.6 ms after the fourth error. No kernel panic, `_MTL4*` regression or preceding MTLCompilerService failure.

The exact observer tuple was not captured. D97ER showed post-recovery unified log and live dmesg custom markers absent, so repeating unchanged D97EL was not justified. The unresolved problem became tuple transport rather than graphics localization.

## D97ES / D97ET — IORegistry tuple telemetry build PASS
D97ES `OCLPMetalCompat.kext` 0.0.11 preserves D97EL passthrough semantics and captures first eight post-original tuples atomically:
- `id`;
- `mode`;
- `badBits = mode & 0xFF8073C0`;
- `goodBits = mode & 0x007F8C3F`;
- raw original IOReturn.

Independent build audit PASS:
- generated source SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- exact D97ES -> D97EL -> D97EH -> D97DL lineage proved;
- no functional mode mutation or return coercion.

Publisher cadence is asynchronous, about once per second, bounded to 300 seconds, and remains live until at least one observer tuple when observer mode is requested.

D97ET checkpoint commit: `af16880e29d0ae51492a5252cda354bc52b52c9d`.

## D97EU — active EFI identity PASS
ASUS2 direct pre-reboot verification matched audited D97ES exactly:
- version 0.0.11;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.

D97EU checkpoint commit: `3861969fe3d6ead6c8684a099e3a5abd80500814`.

## D97EV — D97ES VESA runtime PASS
Authorized VESA boot proved:
- exact D97ES loaded;
- observer requested;
- callback/target callback/route PASS;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCaptureSlots=8`;
- `D97ESCapturedCount=0`;
- all eight `D97ESxxValid=0`;
- D97CT route/build/cpu/kernel gates healthy;
- D97BV functional requested/ACTIVE;
- publisher reached tick 300.

Thus D97ES route, schema, liveness and VESA empty-slot behavior are PASS.

D97EV checkpoint commit: `3520d6a1c3d5b49af962d199230b58472b2b25bb`.

## D97EW — persistent transport-preservation gate
Because a hard recovery reboot destroys prior live IORegistry, D97EW required an on-disk collector independent of WindowServer before any new accelerated experiment.

GitHub-first collector:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Static audit PASS: root LaunchDaemon, boot-started, IORegistry polling, writable evidence under `/Users/Shared/OCLP-D97EW-Capture`, positive-tuple full snapshot + boot/kext identity + `sync` + five follow-ups, and no EFI/NVRAM/Root Patch/framebuffer/Golden/reboot mutation.

D97EW checkpoint commit: `930c308de295f412650e9454cefcce3cf305baa7`.

## D97EX — persistent collector current-VESA live PASS
ASUS2 verified exact source blob identity before install.

Install result:
- plist lint PASS;
- `D97EW_INSTALL_STATUS=PASS`;
- installed capture SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- installed plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`;
- launchd label `com.oclp.d97ew.capture`;
- no reboot, EFI mutation or Root Patch during install.

Current-VESA live run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T114037Z-1039`

Launchd state is running, PID 1039. Repeated samples through ticks 10..29 report service present, `captured_count=0`, `set_id_mode_calls=0`, `route=PASS`. Direct IORegistry simultaneously agrees: all eight Valid=0, CapturedCount=0, SetIdModeCallCount=0, RouteStatus=PASS.

Classification:
- collector source identity PASS;
- install/plist PASS;
- LaunchDaemon running PASS;
- live IORegistry read PASS;
- live disk persistence PASS;
- VESA zero-tuple cross-check PASS;
- accelerated evidence transport READY/PASS.

D97EX checkpoint commit: `eab27b10117750e19c0c8d01c3f0de25d1857c2c`.
Master update advancing authority to D97EX: `fc0d9002fe231ea730b6ebdd75a830785997896d`.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Still required: exact accelerated runtime `id`, `mode`, `badBits`, `goodBits`, original IOReturn. No functional correction before measurement.

## Current action
One accelerated D97ES/D97EW measurement boot is authorized. Make only `-igfxvesa` inert/disabled. Preserve `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh`, inert `#-ocmcd97bvcave`, D97DX, D97ES 0.0.11, D97EW collector, normal 3/3/3 baseline and all other settled state. No Root Patch, framebuffer change, new T2/Haswell variable or functional set_id_mode correction.

If image is lost, allow the running accelerated system enough time for D97ES publication and D97EW disk persistence before VESA recovery. After return, analyze the persisted D97EW run whose saved boot args identify the immediately preceding accelerated boot; exclude the later recovery run.