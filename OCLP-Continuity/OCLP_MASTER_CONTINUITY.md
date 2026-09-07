# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

Current authoritative runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EU_D97ES_VESA_DEPLOY_IDENTITY_PASS_REBOOT_AUTHORIZED.md`

Current observer build audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97ET_D97ES_0011_INDEPENDENT_BUILD_AUDIT_PASS.md`

Previous accelerated runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EQ_ACCEL_REPRO_OBSERVER_TUPLE_NOT_CAPTURED.md`

Previous decisive observer-route checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EP_D97EL_VESA_ROUTE_PASS_ACCEL_MEASUREMENT_GATE.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

Current build design:
`OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

Current observer build helper:
`OCLP-Continuity/artifacts/OCLP7_D97ES_IMAC_BUILD.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext is audited D97ES `OCLPMetalCompat.kext` 0.0.11;
- active D97ES executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- active D97ES UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64;
- current session remains VESA recovery after D97EQ accelerated failure; D97ES has been deployed to EFI but has not yet been boot-validated;
- recovery args must remain exactly `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- `#-ocmcd97bvcave` inert;
- normal pre-D97ED 3/3/3 framebuffer baseline is authoritative;
- no new EFI/boot-arg variable from the T2/Haswell audit is authorized yet;
- no functional set_id_mode masking is authorized;
- D97EH/D97EL custom markers are absent from both post-recovery unified log and current live `dmesg`;
- D97EU pre-reboot active-EFI identity is exact PASS for D97ES 0.0.11.

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

D97EL 0.0.10 preserves D97EH observer semantics and adds route/callback telemetry only.

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

Negative findings:
- no kernel panic;
- no `_MTL4*` regression;
- no MTLCompilerService failure before first WindowServer death.

Recovery boot `Previous shutdown cause: 5` is manual hard power-off, not a kernel panic.

Exact accelerated observer tuple remains UNCAPTURED.

## D97ER — telemetry transport classification
Current live VESA `dmesg` filtered for `D97EH|D97EL|ocmc|set_id_mode|badBits|goodBits` returned no matches.

Therefore:
- post-recovery unified log custom markers = ABSENT;
- live dmesg custom markers = ABSENT;
- repeating unchanged D97EL accelerated boot is not justified;
- D97EP route PASS remains valid independent IORegistry proof;
- next problem is tuple transport/capture, not a newly demonstrated graphics regression.

D97ER checkpoint commit:
`3203836f8ef7ddf6f2e4e52926f759515f37e672`.

## D97ES 0.0.11 — independent build audit PASS
Purpose: preserve exact D97EL route/observer semantics while publishing first set_id_mode tuples asynchronously through IORegistry.

User-returned artifact:
- `OCLP7_D97ES_IMAC_BUILD_20260907_135316.zip`;
- bytes `65332`;
- ZIP SHA256 `f6392b2fdb255b19e5abc46c99afe675ad8e1c1050961368f87e50e2e487327d`;
- ZIP CRC PASS;
- all 9 manifest payload hashes PASS.

Generated source:
- bytes `31083`;
- SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`.

D97ES kext:
- version `0.0.11`;
- x86_64;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- Info.plist SHA256 `3e3a18347d4e4550e13a5407c394ab9196dda83cf6fa3139c17c0a74efeaaed8`.

Independent exact lineage proof:
- reverse D97ES four substitutions -> exact D97EL SHA256 `3a103b84...`;
- reverse D97EL five substitutions -> exact D97EH SHA256 `2d93b4bc...`;
- reverse D97EH three substitutions -> exact D97DL SHA256 `f966d348...`.

Independent x86_64 disassembly confirms:
- saved original `that/id/mode` restored into `rdi/esi/edx` before original Apple call;
- Apple original call occurs before diagnostic masks/tuple storage;
- first 8 tuple slots store `id/mode/badBits/goodBits/raw ret` atomically;
- final return is exact original IOReturn;
- no functional mode mutation or return coercion.

Publisher liveness change is telemetry-only:
- if `-ocmcd97eh` is active, existing publisher remains alive until at least first set_id_mode tuple;
- publication remains asynchronous and bounded to 300 seconds.

Packaging-only notes, not payload failures:
- `ditto` added one AppleDouble metadata file;
- packaged build report omits final ZIP-status lines because those are appended after ZIP creation;
- Xcode log independently contains two BUILD SUCCEEDED markers and zero BUILD FAILED markers.

D97ET classification:
- BUILD INTEGRITY PASS;
- LINEAGE PASS;
- STATIC/BINARY PASSTHROUGH PASS;
- IOREG TELEMETRY-ONLY PASS;
- VESA DEPLOYMENT AUTHORIZED;
- ACCELERATED BOOT NOT YET AUTHORIZED.

D97ET checkpoint commit:
`af16880e29d0ae51492a5252cda354bc52b52c9d`.

## D97EU — D97ES VESA deploy identity PASS
ASUS2 direct active-EFI verification after deployment proved exact audited D97ES 0.0.11 identity:
- version `0.0.11`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.

Classification:
- active EFI D97ES identity = PASS;
- exactly one VESA reboot with unchanged VESA configuration = AUTHORIZED;
- Root Patch = NOT AUTHORIZED;
- accelerated boot = NOT AUTHORIZED;
- functional set_id_mode masking = NOT AUTHORIZED.

D97EU checkpoint commit:
`3861969fe3d6ead6c8684a099e3a5abd80500814`.

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

## CURRENT ACTION — ONE D97ES VESA VALIDATION BOOT AUTHORIZED
On ASUS2:
1. make no further EFI, framebuffer, Root Patch or filesystem mutation;
2. keep VESA boot args exactly `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
3. keep `#-ocmcd97bvcave` inert;
4. perform exactly one reboot into VESA;
5. after returning, collect D97ES IORegistry route/publisher and tuple-slot evidence for audit.

Accelerated boot remains forbidden until D97ES route/publisher and empty-slot behavior are proven in VESA and separately persisted.
