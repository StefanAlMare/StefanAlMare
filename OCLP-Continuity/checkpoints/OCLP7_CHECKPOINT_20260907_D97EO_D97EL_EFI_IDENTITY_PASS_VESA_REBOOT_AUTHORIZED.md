# OCLP7 CHECKPOINT — D97EO — D97EL EFI identity PASS, VESA reboot authorized

Date: 2026-09-07 EEST

## ASUS2 state
- Tahoe 26.6.2 / 25G82
- Haswell 8086:0412
- SMBIOS MacBookAir6,2
- current session remains VESA
- D97DX native-Metal-safe Root Patch remains installed
- normal pre-D97ED 3/3/3 framebuffer baseline remains required

## D97EL build authority
D97EL = OCLPMetalCompat 0.0.10, telemetry-only successor to D97EH.
Independent audit already PASS.

Audited artifact identity:
- ZIP `OCLP7_D97EL_IMAC_BUILD_20260907_123115.zip`
- bytes `61617`
- ZIP SHA256 `b0d8c265a239f8051a4b505a4ce5649f874c95e8e26671bd586b62dd11705181`
- generated source SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`
- kext version `0.0.10`
- arch `x86_64`
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`

Lineage audit:
- reverse D97EL telemetry additions -> exact D97EH source SHA `2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d`
- reverse D97EH observer additions -> exact D97DL authority SHA `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`

Observer invariants remain unchanged:
- exact target `__ZN14IOAccelSurface11set_id_modeEjj`
- original `that`, `id`, `mode` passed unchanged
- original IOReturn returned unchanged
- no mode bit stripping
- no return coercion
- no framebuffer mutation

D97EL adds only IORegistry telemetry:
- `D97ELObserverRequested`
- `D97ELCallbackSeenCount`
- `D97ELTargetCallbackSeenCount`
- `D97ELLastCallbackIndex`
- `D97ELKextLoadIndex`
- `D97ELRouteStatus`
- `D97ELSetIdModeCallCount`

## Active EFI identity — PASS
User manually replaced active EFI `EFI/OC/Kexts/OCLPMetalCompat.kext` with D97EL and verified before reboot:

- `VERSION=0.0.10`
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089` x86_64

Therefore active EFI payload exactly matches the audited D97EL artifact.

Classification:
- `D97EO_D97EL_EFI_IDENTITY=PASS`
- `D97EO_VESA_REBOOT_AUTHORIZED=YES`
- `D97EO_ACCELERATED_BOOT_AUTHORIZED=NO`

## Authorized next action
Perform exactly one VESA reboot with the existing diagnostic arguments unchanged:
- `-igfxvesa`
- `-ocmcdiag`
- `-ocmcd97bv`
- `-ocmcd97eh`
- `#-ocmcd97bvcave` remains inert

Do not Root Patch.
Do not disable `-igfxvesa`.
Do not alter framebuffer properties.

After VESA returns, read-only gate must inspect D97EL telemetry. Accelerated execution remains forbidden until `D97ELRouteStatus=PASS` is proven explicitly.
