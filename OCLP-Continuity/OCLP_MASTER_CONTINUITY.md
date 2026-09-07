# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

Current authoritative runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EX_PERSISTENT_COLLECTOR_LIVE_PASS_ACCEL_BOOT_AUTHORIZED.md`

Previous transport-preservation checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EW_D97ES_VESA_PASS_PERSISTENT_CAPTURE_GATE.md`

Current D97ES VESA runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EV_D97ES_VESA_RUNTIME_PASS_ACCEL_MEASUREMENT_AUTHORIZED.md`

Current observer build audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97ET_D97ES_0011_INDEPENDENT_BUILD_AUDIT_PASS.md`

Previous accelerated runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EQ_ACCEL_REPRO_OBSERVER_TUPLE_NOT_CAPTURED.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

Current build design:
`OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

Current observer build helper:
`OCLP-Continuity/artifacts/OCLP7_D97ES_IMAC_BUILD.sh`

Current persistent accelerated-evidence collector:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`;
- installed capture SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- installed plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext is audited D97ES `OCLPMetalCompat.kext` 0.0.11;
- active D97ES executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- active D97ES UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64;
- D97ES VESA route/publisher/empty-slot behavior is PASS;
- current session is the validated D97ES VESA session;
- current VESA args are `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- `#-ocmcd97bvcave` remains inert;
- normal pre-D97ED 3/3/3 framebuffer baseline is authoritative;
- D97EW persistent collector is installed, launchd-running and live-tested PASS in current VESA;
- live collector run `/Users/Shared/OCLP-D97EW-Capture/20260907T114037Z-1039` repeatedly reported service present, `captured_count=0`, `set_id_mode_calls=0`, `route=PASS`;
- direct IORegistry cross-check simultaneously reported D97ES all eight Valid=0, CapturedCount=0, SetIdModeCallCount=0 and RouteStatus=PASS;
- no new T2/Haswell boot variable is authorized before exact set_id_mode measurement;
- no functional set_id_mode masking is authorized;
- one accelerated measurement boot is authorized under D97EX with only `-igfxvesa` made inert.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Functional baseline and durable rules
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains the accepted upstream semantic proof for AIR 2.6 / Metal 3.1. D34 cave `0xEF8..0xEFE` is protected. D50/D68/D82 remain reserve-only; D84 is retired. Golden Sequoia remains immutable/read-only.

Module-boundary + semantic evidence + far-frontier methodology remains mandatory. Universal/no-PID coverage is required when requests can vary. Control-flow success is never semantic proof by itself.

Permanent GitHub-first execution remains mandatory: all technically GitHub-executable validation/integration/build/package/audit work is done in GitHub; ASUS2 is reserved for identity-pinned live-state/deploy/manual boot/recovery evidence.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication;
- no functional masking of `set_id_mode` before exact measurement.

## Settled runtime/build facts

### D97BV / D97DT — selective 3802 delivery CLOSED PASS
Selective-3802 runtime delivery is CLOSED PASS under VESA exact 25G82 using D97DL 0.0.7. CAVE/SITE exact runtime delivery, validation safety and cross-process visibility were proven. Do not retest absent contradiction.

D97DL source authority SHA256:
`f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`.

### D97DX — native-Metal-safe Root Patch PASS
Installed bounded architecture:
- native Tahoe main Metal remains authoritative;
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes plus CoreImage/RenderBox compatibility;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL and Haswell graphics drivers;
- no MetalOld, no legacy main Metal shadow and no true-five replay.

### D97EB / D97EE — core accelerated failure
Normal 3/3/3 accelerated boot and isolated 1/1/1 framebuffer experiment reached the same core failure:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV.

No kernel panic and no `_MTL4*` superclass regression occurred. Framebuffer-count tuning is CLOSED NEGATIVE; 3/3/3 remains authoritative.

### D97EG-D97EP — exact observer route
AppleIntelHD5000Graphics imports `__ZN14IOAccelSurface11set_id_modeEjj` = `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)` from IOAcceleratorFamily2 487.4.3.

D97EH/D97EL proved observe-only passthrough semantics: original `that/id/mode` passed unchanged, Apple original called first, original IOReturn returned unchanged, candidate masks computed only after return, no mode mutation/coercion.

D97EP VESA proved observer requested, global callback path active, exact target callback and route PASS, with zero set_id_mode calls as expected.

### D97EQ / D97ER — tuple transport gap
D97EQ accelerated boot reproduced the failure after `GPU: FB: 3 of 3 opened`: four bad-bits errors, display offline about 3 ms later, WindowServer SIGSEGV about 20.6 ms after fourth error. No kernel panic, no `_MTL4*` regression, no preceding MTLCompilerService failure.

Exact tuple was not captured. D97ER established unified log and dmesg custom-marker absence, so repeating unchanged D97EL was not justified; the problem became tuple transport/capture.

### D97ES / D97ET — IORegistry tuple telemetry build PASS
D97ES 0.0.11 preserves D97EL passthrough semantics and adds first-eight tuple capture:
- `id`;
- `mode`;
- `badBits = mode & 0xFF8073C0`;
- `goodBits = mode & 0x007F8C3F`;
- raw original IOReturn.

Independent build audit PASS:
- source SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- exact D97ES -> D97EL -> D97EH -> D97DL lineage proved;
- no functional mode mutation or return coercion.

D97ES publisher updates IORegistry asynchronously on a one-second cadence and remains bounded to 300 seconds. Its completion condition is kept open while observer mode is requested until at least the first set_id_mode tuple exists.

### D97EU / D97EV — deployment and VESA runtime PASS
D97EU proved exact active EFI D97ES identity. D97EV VESA proved:
- loaded D97ES 0.0.11 exact UUID;
- observer/callback/target route PASS;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCaptureSlots=8`;
- `D97ESCapturedCount=0`;
- all eight Valid=0;
- D97CT route/build/cpu/kernel gates healthy;
- D97BV functional requested/ACTIVE;
- publisher reached bounded tick 300.

Thus D97ES route, schema, publisher liveness and empty-slot behavior are CLOSED PASS in VESA.

### D97EW / D97EX — persistent accelerated evidence transport PASS
D97EW identified that hard VESA recovery destroys prior live IORegistry, so a WindowServer-independent on-disk collector is required before acceleration.

Collector artifact:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

The collector is a root LaunchDaemon, starts at boot, polls full OCLPMetalCompat IORegistry and writes snapshots/summary under `/Users/Shared/OCLP-D97EW-Capture`. On first positive `D97ESCapturedCount` it preserves the full tuple snapshot, boot args and loaded-kext identity, calls `sync`, and takes five follow-up snapshots. It performs no EFI/NVRAM/Root Patch/framebuffer/Golden mutation and no reboot.

D97EX current-VESA live proof:
- exact source blob identity PASS;
- plist lint/install PASS;
- launchd state running, PID 1039;
- repeated samples service present / captured=0 / calls=0 / route=PASS;
- direct IORegistry agrees exactly.

Therefore accelerated evidence transport is READY/PASS and one accelerated measurement boot is authorized.

## OCLP T2 / Haswell audit integration policy
Do not add new EFI/boot-arg variables while exact `set_id_mode` measurement is unresolved. Existing `ipc_control_port_options=0` and `-amfipassbeta` remain. Do not add `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0` or any other new variable at this gate. Any such lead is a later isolated A/B experiment after measurement.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Still required from the immediately next accelerated boot:
- exact `id`;
- exact `mode`;
- `mode & 0xFF8073C0`;
- `mode & 0x007F8C3F`;
- original IOReturn.

No functional correction before measurement.

## CURRENT ACTION — ONE D97ES/D97EW ACCELERATED MEASUREMENT BOOT AUTHORIZED
On ASUS2 make exactly one diagnostic configuration change:
- make only `-igfxvesa` inert/disabled (the established `#-igfxvesa` convention is acceptable).

Keep unchanged:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- `#-ocmcd97bvcave` inert;
- `ipc_control_port_options=0` and existing `-amfipassbeta`;
- D97DX Root Patch;
- active D97ES 0.0.11;
- installed D97EW LaunchDaemon collector;
- normal 3/3/3 framebuffer baseline;
- every other settled EFI/system state.

Do not Root Patch again. Do not add any T2/Haswell variable. Do not change framebuffer counts or apply any functional `set_id_mode` correction.

If the accelerated boot loses usable image, keep the black/no-image system running long enough for D97ES publication and D97EW disk persistence before manual VESA recovery. After VESA return, identify and analyze the persisted D97EW run belonging to the immediately preceding accelerated boot by its saved boot args; exclude the later VESA recovery run.