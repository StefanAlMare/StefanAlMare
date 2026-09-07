# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

Current authoritative runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EQ_ACCEL_REPRO_OBSERVER_TUPLE_NOT_CAPTURED.md`

Previous decisive observer-route checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EP_D97EL_VESA_ROUTE_PASS_ACCEL_MEASUREMENT_GATE.md`

Current observer build audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EN_D97EL_0010_INDEPENDENT_BUILD_AUDIT_PASS.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

Current build design:
`OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

Current observer build helper:
`OCLP-Continuity/artifacts/OCLP7_D97EL_IMAC_BUILD.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext is audited D97EL `OCLPMetalCompat.kext` 0.0.10;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089` x86_64;
- current session is VESA recovery after D97EQ accelerated failure;
- recovery args: `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- `#-ocmcd97bvcave` inert;
- normal pre-D97ED 3/3/3 framebuffer baseline is authoritative;
- no new EFI/boot-arg variable from the T2/Haswell audit is currently authorized;
- no functional set_id_mode masking is authorized.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication;
- no functional masking of set_id_mode before exact measurement.

## Settled runtime/build facts

### D97BV / D97DT
Selective-3802 runtime delivery is CLOSED PASS under VESA exact 25G82 using D97DL 0.0.7. CAVE/SITE exact runtime delivery, validation safety and cross-process visibility were proven. Do not retest absent contradiction.

D97DL source authority SHA256:
`f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`.

### D97DX Root Patch
Native-Metal-safe Root Patch execution PASS:
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes, CoreImage/RenderBox compatibility;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL;
- Haswell graphics drivers;
- no legacy main Metal shadow;
- no MetalOld;
- no true-five replay.

### D97EB / D97EE
Both normal 3/3/3 accelerated boot and 1/1/1 experiment reached the same core failure:
- `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits`;
- display offline;
- WindowServer SIGSEGV;
- no kernel panic;
- no `_MTL4*` superclass regression.

1/1/1 did not solve the failure. Framebuffer-count tuning is CLOSED NEGATIVE.

### D97EG exact symbol
AppleIntelHD5000Graphics dynamically imports:
`__ZN14IOAccelSurface11set_id_modeEjj`
= `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)`.

IOAcceleratorFamily2 identity:
- bundle id `com.apple.iokit.IOAcceleratorFamily2`;
- version `487.4.3`.

### D97EH / D97EL observer lineage
D97EH 0.0.9 independent audit PASS:
- exact symbol observer;
- original `that/id/mode` passed unchanged;
- original IOReturn returned unchanged;
- candidate masks computed only after original return;
- no mode mutation or return coercion.

D97EL 0.0.10 preserves D97EH observer semantics and adds telemetry only.

D97EL exact identities:
- source SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`.

### D97EP VESA route PASS
D97EL VESA telemetry proved:
- `D97ELObserverRequested=1`;
- global callback path active;
- exact IOAcceleratorFamily2 callback matched;
- `D97ELRouteStatus=PASS`;
- `D97ELSetIdModeCallCount=0` in VESA;
- D97BV route PASS and functional mode ACTIVE.

Thus registration/matching/symbol routing is CLOSED PASS in VESA.

## D97EQ — accelerated failure reproduced with D97EL
Collector artifact:
- `OCLP7_D97EQ_ACCEL_FAIL_20260907_132111.zip`;
- bytes `352126`;
- SHA256 `82c884ff6c5ae642a5c4a4a029fbd78fee123e5c74631f5e34a791e467fad748`;
- ZIP CRC PASS.

Correct chronology:
- accelerated diagnostic boot around 13:13 / userspace 13:14 with `#-igfxvesa`;
- recovery VESA boot at 13:15 with `-igfxvesa` restored.

Accelerated WindowServer PID 177 sequence:
- `GPU: FB: 3 of 3 opened` at 13:14:56.623169;
- four exact `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` errors at 13:14:56.723835, .724216, .724494, .724772;
- main display offline at 13:14:56.727861 (~3.089 ms after fourth error);
- WindowServer SIGSEGV at 13:14:56.745335 (~20.563 ms after fourth error).

WindowServer PID 340 respawned and again reached 3/3 framebuffer open state, but main display remained offline.

Negative findings:
- no kernel panic;
- no `_MTL4*` regression;
- no MTLCompilerService failure before first WindowServer death.

Recovery boot `Previous shutdown cause: 5` is manual hard power-off, not a kernel panic.

### D97EQ telemetry limitation
Post-recovery unified log contains no custom observer markers:
- no `D97EH_ROUTE`;
- no `D97EH_SET_ID_MODE`;
- no `badBits=` / `goodBits=` tuple.

This absence does NOT prove observer routing failed in the accelerated boot, because the same custom route marker was absent from unified log in VESA even while IORegistry independently proved `D97ELRouteStatus=PASS`.

Therefore exact accelerated `id/mode/badBits/goodBits/ret` remains UNCAPTURED. The next problem is telemetry transport/persistence, not a demonstrated new graphics-path failure.

D97EQ checkpoint commit:
`eb01d27dc538d7ac0a841950556980f2623ba289`.

## OCLP T2 / Haswell audit integration policy
Do not add new EFI/boot-arg variables while exact set_id_mode measurement is still unresolved.
Existing `ipc_control_port_options=0` and `-amfipassbeta` remain.
Do NOT add `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0`, or other new variables at this gate.
Any such lead must be a later isolated A/B experiment after measurement.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Still need exact accelerated runtime:
- `id`;
- `mode`;
- `mode & 0xFF8073C0`;
- `mode & 0x007F8C3F`;
- original IOReturn.

No functional correction before measurement.

## CURRENT ACTION — LIVE TELEMETRY TRANSPORT CHECK
Remain in current VESA recovery. No reboot and no EFI change.

Before rebuilding OCLPMetalCompat, test the current boot's kernel message buffer (`dmesg`) for D97EH/D97EL custom markers.

If current live `dmesg` exposes the custom route marker while unified log does not, keep D97EL 0.0.10 and use a live capture method on the next accelerated boot (prefer SSH from another Mac before hard power-off) to recover the observer tuples.

If custom markers are absent even from live `dmesg`, design a telemetry successor that exposes the first set_id_mode tuple(s) through a live-readable channel. No bit masking or return coercion is authorized.
