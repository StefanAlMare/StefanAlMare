# OCLP7 D97FF — D97EZ EFI identity PASS / LATENT VESA reboot authorized

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Settled authority
- D97FD independent audit PASS for D97EZ `OCLPMetalCompat.kext` 0.0.12.
- Audited D97EZ executable SHA256: `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`.
- Audited D97EZ Info.plist SHA256: `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`.
- Audited D97EZ UUID: `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64.
- D97EZ source SHA256: `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`.
- D97EZ exact-match experiment remains LATENT unless `-ocmcd97ez` is present.
- No Root Patch change is required or authorized.

## ASUS2 manual EFI replacement evidence
User manually replaced the already-configured `EFI/OC/Kexts/OCLPMetalCompat.kext` in the mounted EFI with the audited D97EZ 0.0.12 bundle.

Direct pre-reboot identity verification from `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext` reports:
- `CFBundleShortVersionString = 0.0.12`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64.

This matches D97FD audited identity exactly.

## Pre-reboot boot-args
Current saved boot args are:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh`

Required gate facts:
- active `-igfxvesa` = YES;
- active `-ocmcdiag` = YES;
- active `-ocmcd97bv` = YES;
- active `-ocmcd97eh` = YES;
- inert `#-ocmcd97bvcave` preserved;
- `-ocmcd97ez` = ABSENT;
- `#-igfxvesa` = ABSENT.

Therefore the first D97EZ boot will be VESA and D97EZ functional exact-match mode will remain LATENT.

## Classification
- `D97FF_D97EZ_EFI_VERSION_IDENTITY=PASS`
- `D97FF_D97EZ_EFI_EXEC_SHA256_IDENTITY=PASS`
- `D97FF_D97EZ_EFI_UUID_IDENTITY=PASS`
- `D97FF_VESA_BOOTARG_GATE=PASS`
- `D97FF_D97EZ_FUNCTIONAL_BOOTARG_PRESENT=NO`
- `D97FF_D97EZ_EXPECTED_RUNTIME_MODE=LATENT`
- `D97FF_ROOT_PATCH_AUTHORIZED=NO`
- `D97FF_ACTIVE_ACCELERATION_AUTHORIZED=NO`
- `D97FF_ONE_LATENT_VESA_REBOOT_AUTHORIZED=YES`

## CURRENT ACTION
Perform exactly one reboot with current boot args unchanged.

Expected boot state:
- VESA active via `-igfxvesa`;
- D97EZ 0.0.12 loaded;
- `-ocmcd97ez` absent, therefore `D97EZFunctionalMode=LATENT`;
- existing D97BV route remains requested;
- exact `set_id_mode` observer route remains requested;
- zero functional `0x224 -> 0x24` translation should occur because the functional bootarg is absent.

After boot, do not alter boot args, Root Patch, EFI, framebuffer or NVRAM. Return live IORegistry + loaded-kext identity evidence for LATENT validation before any active accelerated experiment is considered.
