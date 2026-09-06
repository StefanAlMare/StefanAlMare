# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DZ_POST_ROOTPATCH_VESA_SHARED_CACHE_IDENTITY_PASS_ACCELERATED_BOOT_AUTHORIZED.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch is installed and first root-patched reboot has completed successfully under VESA;
- current boot args include active `-igfxvesa -ocmcdiag -ocmcd97bv`;
- `#-ocmcd97bvcave` remains inert;
- active EFI compatibility kext remains D97DL `OCLPMetalCompat.kext` 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- exact official Dortania privileged helper was restored before reboot.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication.

## D97BV / D97DT runtime closure
D97DT remains FULL VESA PAIR PASS on exact Tahoe 25G82:
- exact D97DL 0.0.7 loaded;
- functional mode ACTIVE;
- route/build 25G82 PASS;
- CAVE and SITE exact D97BV runtime delivery proven with write count 1 each and Apple validation safe;
- D97DR separately proved cross-process CAVE visibility.

Therefore the selective-3802 adapter delivery mechanism is CLOSED PASS under VESA.

## D97DX native-Metal-safe Root Patch — PASS
Exact source baseline b9df76; exact tracked delta four files only.
Tahoe policy:
- Common: only legacy `MTLCompilerService.xpc` under native Metal.framework plus private MTLCompiler/GPUCompiler lanes;
- Extended: CoreImage/RenderBox/private compiler compatibility only; NO whole Metal.framework donor;
- exact Pyquick 25G82 metallib map, 182 entries;
- no `MetalOld.dylib`;
- no main legacy `Versions/A/Metal` donor;
- no true-five.

Manual Root Patch execution PASS:
- exact 25G82 MetallibSupportPkg used;
- Metal 3802 Common/Extended/metallibs executed;
- Monterey GVA/OpenCL executed;
- Intel Haswell patchset executed;
- Auxiliary Kernel Collection rebuilt and forced;
- final `Patching complete` reached.

## D97DZ — post-Root-Patch VESA validation PASS
Root-patched VESA boot proved:
- Root Patch metadata present;
- legacy main on-disk `Metal.framework/Versions/A/Metal` ABSENT;
- `MetalOld.dylib` ABSENT;
- legacy `MTLCompilerService` SHA256 exact `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- Lilu 1.7.3, OCLPMetalCompat 0.0.7, WhateverGreen 1.7.1 loaded;
- patched AppleIntelFramebufferAzul and AppleIntelHD5000Graphics loaded;
- D97BV functional mode ACTIVE/requested=1;
- display remained VESA, HD4400 4 MB, 1366x768.

Exact shared-cache topology remained byte-identical after Root Patch:
- SITE page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43` PASS;
- SITE13 preimage `3d187d0000b9177d00000f4cc1` PASS;
- CAVE page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140` PASS;
- CAVE 18-byte zero window PASS;
- CAVE 208-byte zero region PASS.

Checkpoint commit: `d99fe62b65e8633611368241c8dabb2cfb273492`.

## CURRENT ACTION — FIRST ACCELERATED BOOT AUTHORIZED
Manual EFI edit only:
- change only active `-igfxvesa` to inert/commented `#-igfxvesa`;
- retain `-ocmcdiag` active;
- retain `-ocmcd97bv` active;
- retain `#-ocmcd97bvcave` inert;
- do not modify any other boot arg, kext, config item, Root Patch or snapshot;
- reboot once.

If usable accelerated GUI appears, do not Root Patch again; collect runtime state before any further change.
If no usable GUI appears or userspace fails, hard restart/power-cycle and return to the established VESA recovery configuration, then analyze only that immediately preceding accelerated attempt per permanent VESA recovery rule.

Still forbidden:
- any EFI change besides this single `-igfxvesa` deactivation;
- global 3802 forcing;
- legacy main Metal shadow;
- true-five reapplication;
- Golden mutation.
