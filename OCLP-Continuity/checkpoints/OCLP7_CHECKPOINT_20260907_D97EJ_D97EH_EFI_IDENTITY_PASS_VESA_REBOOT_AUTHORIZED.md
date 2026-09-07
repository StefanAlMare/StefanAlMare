# OCLP7 D97EJ — D97EH EFI identity PASS, VESA reboot authorized

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## State
- D97DX native-Metal-safe Root Patch remains installed.
- D97EH 0.0.9 observer-only build passed independent source/binary audit in D97EI.
- User manually deployed D97EH to the active EFI BundlePath `EFI/OC/Kexts/OCLPMetalCompat.kext`.
- No Root Patch was rerun.
- No accelerated boot has occurred yet with D97EH.

## Exact active-EFI identity proof
ASUS2 read-only verification returned:
- `VERSION=0.0.9`
- executable SHA256 `23bbc4a30a0c445a20a2821530a427256662e4e4832eaa6c82b1219540460fcf`
- UUID `E3BE3246-7F7A-36B8-822D-7D1AEB35D721` (x86_64)
- active path `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext/Contents/MacOS/OCLPMetalCompat`.

These values exactly match the independently audited D97EH artifact.

Classifications:
- `D97EJ_ACTIVE_EFI_D97EH_VERSION=PASS`
- `D97EJ_ACTIVE_EFI_D97EH_EXEC_SHA=PASS`
- `D97EJ_ACTIVE_EFI_D97EH_UUID=PASS`
- `D97EJ_ACTIVE_EFI_D97EH_IDENTITY=PASS`

## Boot policy for next boot
The next boot is authorized only as a VESA-first deployment validation.
Required boot-arg state:
- `-igfxvesa` ACTIVE;
- `-ocmcdiag` ACTIVE;
- `-ocmcd97bv` ACTIVE;
- `-ocmcd97eh` ACTIVE;
- `#-ocmcd97bvcave` remains inert.

IGPU must be normal pre-D97ED 3/3/3 baseline, not 1/1/1.

Purpose of VESA-first boot:
1. prove D97EH 0.0.9 loads successfully from OpenCore;
2. prove D97BV remains healthy and unchanged;
3. verify no new kext/load regression;
4. confirm observer is safely dormant if IOAcceleratorFamily2 is not active under VESA.

This boot does NOT attempt to collect `set_id_mode` calls; the accelerator observer is expected to become useful only in a later separately authorized accelerated boot.

## Authorization
- One VESA reboot with D97EH is AUTHORIZED.
- Accelerated boot remains NOT AUTHORIZED.
- No Root Patch, framebuffer mutation, mode-bit masking, CoreDisplay donor/downgrade, legacy main Metal shadow, global 3802 forcing, true-five replay, or Golden mutation is authorized.

After VESA returns, run read-only load/runtime verification before considering any accelerated observer boot.
