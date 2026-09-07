# OCLP7 D97EU — D97ES VESA deployment identity PASS; one VESA reboot authorized

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Input evidence
While ASUS2 remained in the current VESA recovery session, the active EFI kext at:
`/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext`
was identity-checked directly on ASUS2.

Observed:
- `CFBundleShortVersionString = 0.0.11`
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64

These values match the independently audited D97ES 0.0.11 build exactly.

## Classification
- `D97EU_D97ES_ACTIVE_EFI_VERSION=PASS`
- `D97EU_D97ES_ACTIVE_EFI_SHA256=PASS`
- `D97EU_D97ES_ACTIVE_EFI_UUID=PASS`
- `D97EU_D97ES_VESA_DEPLOY_IDENTITY=PASS`
- `D97EU_ROOT_PATCH_AUTHORIZED=NO`
- `D97EU_ACCELERATED_BOOT_AUTHORIZED=NO`
- `D97EU_FUNCTIONAL_SET_ID_MODE_MASKING_AUTHORIZED=NO`
- `D97EU_ONE_VESA_REBOOT_AUTHORIZED=YES`

## Preserved configuration contract
For the authorized VESA reboot:
- keep boot args exactly `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- keep `#-ocmcd97bvcave` inert;
- do not alter framebuffer configuration;
- do not add any T2/Haswell audit boot arg or EFI variable;
- do not Root Patch;
- do not make any functional `set_id_mode` correction.

## Purpose of the single VESA reboot
Prove D97ES route/publisher behavior and empty-slot behavior under VESA before any accelerated boot is considered.

Expected VESA semantic condition remains that `set_id_mode` is not exercised by the accelerated Haswell path, so tuple slots should remain empty while route/publisher telemetry remains healthy.

## CURRENT ACTION
Perform exactly one VESA reboot with the preserved VESA configuration above. After returning to the VESA session, collect the D97ES IORegistry route/publisher and tuple-slot properties requested by the assistant. Accelerated boot remains forbidden until that evidence is audited and persisted.
