# OCLP7 CHECKPOINT — D97DZ post-Root-Patch VESA validation; shared-cache identity PASS; first accelerated boot authorized

Date: 2026-09-07 EEST

## Entering state
ASUS2 booted successfully into Tahoe 26.6.2 / 25G82 after D97DX native-Metal-safe Root Patch, still with VESA policy active.

Active boot args include:
- `-igfxvesa`
- `-ocmcdiag`
- `-ocmcd97bv`
- `#-ocmcd97bvcave` remains inert/commented.

## Post-Root-Patch VESA validation
Confirmed:
- Root Patch metadata present;
- exact local MetallibSupportPkg 26.6.2-25G82 recorded;
- Metal 3802 Common / Extended / metallibs present;
- Monterey GVA / OpenCL present;
- Intel Haswell patchset present;
- legacy main on-disk `Metal.framework/Versions/A/Metal` ABSENT;
- `MetalOld.dylib` ABSENT;
- exact legacy `MTLCompilerService` SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5` PASS;
- Lilu 1.7.3, OCLPMetalCompat 0.0.7 UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`, WhateverGreen 1.7.1 loaded;
- patched `AppleIntelFramebufferAzul` and `AppleIntelHD5000Graphics` loaded;
- D97DI functional mode ACTIVE and requested=1;
- CAVE/SITE mutation remained PENDING under VESA because the relevant Metal pages were not naturally validated/mapped in this boot; this is not a failure.

Display remained VESA: Intel HD Graphics 4400, VRAM 4 MB, 1366x768.

## Shared-cache byte identity after Root Patch
Main Cryptex cache:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`

SITE page:
- offset `0xF5E1000`;
- SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43` PASS;
- SITE13 preimage `3d187d0000b9177d00000f4cc1` PASS.

CAVE page:
- offset `0xF47E000`;
- SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140` PASS;
- CAVE 18-byte zero window PASS;
- CAVE 208-byte zero region PASS.

Therefore D97DL/D97BV runtime topology and exact byte preconditions are unchanged by the D97DX Root Patch.

## Classifications
- `D97DZ_ROOTPATCHED_VESA_BOOT=PASS`;
- `D97DZ_NATIVE_METAL_SHADOW=ABSENT`;
- `D97DZ_LEGACY_MTLSERVICE_IDENTITY=PASS`;
- `D97DZ_HASWELL_KEXTS_LOADED_UNDER_VESA=PASS`;
- `D97DZ_D97BV_MODE_ACTIVE=PASS`;
- `D97DZ_SHARED_CACHE_SITE_PAGE_IDENTITY=PASS`;
- `D97DZ_SHARED_CACHE_SITE_PREIMAGE=PASS`;
- `D97DZ_SHARED_CACHE_CAVE_PAGE_IDENTITY=PASS`;
- `D97DZ_SHARED_CACHE_CAVE_ZERO_REGION=PASS`;
- `D97DZ_PRE_ACCELERATED_BOOT_GATE=PASS`.

## CURRENT ACTION — FIRST ACCELERATED BOOT AUTHORIZED
Manual user action only:
- change only `-igfxvesa` to inert/commented `#-igfxvesa` in the active OpenCore `boot-args`;
- retain `-ocmcdiag` and `-ocmcd97bv` active;
- retain `#-ocmcd97bvcave` inert;
- do not change any other EFI/config item;
- reboot once.

If a usable accelerated GUI appears, do not Root Patch again and immediately collect post-accelerated runtime state before making any further changes.

If no usable image/GUI appears or the system fails in userspace, hard restart/power-cycle and boot the established VESA recovery configuration, then analyze only that immediately preceding accelerated attempt per the permanent VESA recovery rule.

Still forbidden:
- global 3802 forcing;
- legacy main Metal shadow;
- true-five reapplication;
- Golden mutation;
- any EFI change other than the single `-igfxvesa` deactivation for this experiment.
