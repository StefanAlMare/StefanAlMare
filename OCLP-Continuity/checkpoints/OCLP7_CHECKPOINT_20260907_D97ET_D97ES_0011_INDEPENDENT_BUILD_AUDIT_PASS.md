# OCLP7 D97ET — D97ES 0.0.11 independent build audit PASS

Date: 2026-09-07 EEST

## Input artifact
User-returned Intel-iMac build:
`OCLP7_D97ES_IMAC_BUILD_20260907_135316.zip`

Independent artifact checks:
- bytes: `65332`
- SHA256: `f6392b2fdb255b19e5abc46c99afe675ad8e1c1050961368f87e50e2e487327d`
- ZIP CRC/test: PASS
- every one of the 9 `SHA256SUMS.txt` entries validates exactly.

Packaging-only notes:
- `ditto` included one AppleDouble metadata entry `._OCLP7_D97ES_kern_start.cpp`; it is not part of the payload manifest and does not affect source/kext identity;
- the packaged `D97ES_BUILD_REPORT.txt` ends at `BINARY_MARKER_AUDIT=PASS` because the builder appends final ZIP status lines only after the ZIP is created. This is a report/packaging ordering quirk, not a build/payload failure;
- Xcode log contains two `** BUILD SUCCEEDED **` markers (Lilu and plugin), zero BUILD FAILED markers.

## Generated source
- file: `OCLP7_D97ES_kern_start.cpp`
- bytes: `31083`
- SHA256: `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`
- deterministic generation reported PASS.

## D97ES generator identity
Packaged generator:
- SHA256 `c9bcf0e2b70b3c10525b4d6a182b4c20de4d5f651a7074b4bdebd1aa6d04aba0`
- authority commit `62fac73c0d834be92bcab208234112a4b046e385`
- authority blob `dc7e244c3734f5dd0cd6f24d6d8c43da76d41fad`.

## Kext identity
`OCLPMetalCompat.kext`:
- CFBundleIdentifier `com.oclpmetalcompat.OCLPMetalCompat`
- version `0.0.11`
- arch `x86_64`
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`
- Info.plist SHA256 `3e3a18347d4e4550e13a5407c394ab9196dda83cf6fa3139c17c0a74efeaaed8`.

Mach-O parsed independently as 64-bit x86_64 kext bundle; LC_UUID equals the build report UUID exactly.

Binary marker audit independently finds:
- `-ocmcd97eh`
- exact symbol `__ZN14IOAccelSurface11set_id_modeEjj`
- `D97EH_SET_ID_MODE`
- `D97ELRouteStatus`
- D97ES tuple keys including `D97ESCaptureSlots`, `D97ESCapturedCount`, `D97ES01Id`, `D97ES01Mode`, `D97ES01BadBits`, `D97ES01GoodBits`, `D97ES01Ret`.

## Exact lineage proof
Independent reverse application of generator substitutions from the packaged final D97ES source:

1. Reverse exactly the four D97ES substitutions:
   - reconstructed D97EL bytes `26688`
   - reconstructed SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`
   - exact match to audited D97EL authority.

2. Reverse exactly the five D97EL substitutions:
   - reconstructed D97EH bytes `24097`
   - reconstructed SHA256 `2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d`
   - exact match to audited D97EH authority.

3. Reverse exactly the three D97EH substitutions:
   - reconstructed D97DL bytes `21727`
   - reconstructed SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`
   - exact match to D97DL source authority.

Thus D97ES preserves the entire validated D97DL -> D97EH -> D97EL lineage exactly outside the D97ES telemetry additions.

## Static semantic audit
`patchedSetIdMode(void *that, uint32_t id, uint32_t mode)`:
- calls Apple original first with exact original `(that,id,mode)`;
- only after original returns does it increment count and compute `badBits`/`goodBits`;
- only first 8 calls are stored atomically into D97ES kernel-memory slots;
- valid flag is published last with release ordering;
- no `setProperty()` is executed inside set_id_mode critical path;
- IORegistry publication occurs asynchronously in the existing publisher thread;
- existing SYSLOG remains bounded to first 32 calls;
- original IOReturn is returned unchanged.

Forbidden mutation token audit:
- no `patchedMode`;
- no `~0xff8073c0` or `~0xFF8073C0`;
- no `mode &=`;
- no `return kIOReturnSuccess`.

Publisher change is telemetry-liveness only:
- when `-ocmcd97eh` is active, publisher remains alive until at least one set_id_mode tuple is observed;
- still bounded to the original 300-second early-boot window.

## Independent x86_64 disassembly
Wrapper at `0x2710`:
- saves original `rdi/esi/edx` (`that/id/mode`);
- resolves original trampoline;
- restores `rdi` at `0x2735`, `esi` at `0x2739`, `edx` at `0x273c`;
- indirect Apple call at `0x273f`;
- stores original `eax` return at `0x2741`;
- only then computes diagnostic masks and stores tuple fields;
- final return reloads original return at `0x286c` and returns at `0x2874`.

Classification:
- `D97ET_D97ES_BUILD_INTEGRITY=PASS`
- `D97ET_D97ES_LINEAGE=PASS`
- `D97ET_D97ES_STATIC_PASSTHROUGH=PASS`
- `D97ET_D97ES_BINARY_PASSTHROUGH=PASS`
- `D97ET_D97ES_IOREG_TELEMETRY_ONLY=PASS`
- `D97ET_D97ES_VESA_DEPLOYMENT_AUTHORIZED=YES`
- `D97ET_D97ES_ACCELERATED_BOOT_AUTHORIZED=NO`

## Next gate
On ASUS2, while in current VESA recovery:
1. keep backup of active D97EL 0.0.10;
2. replace only active EFI `EFI/OC/Kexts/OCLPMetalCompat.kext` with audited D97ES 0.0.11;
3. keep `Kernel -> Add -> BundlePath` unchanged;
4. keep VESA args `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`; `#-ocmcd97bvcave` inert;
5. no Root Patch, no framebuffer change, no T2/Haswell extra boot-arg;
6. verify active EFI identity before reboot.

Required pre-reboot identity:
- version `0.0.11`
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`.

After identity PASS, exactly one VESA reboot may be separately authorized. Accelerated boot remains forbidden until D97ES route/publisher and empty-slot behavior are proven in VESA.
