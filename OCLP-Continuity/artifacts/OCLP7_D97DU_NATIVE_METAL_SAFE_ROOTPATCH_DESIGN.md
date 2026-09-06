# OCLP7 D97DU — Tahoe native-Metal-safe Root Patch design

Date: 2026-09-07 EEST

## Entering authority
- D97DT full D97BV VESA pair runtime = PASS.
- Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2.
- EFI functional component remains D97DL 0.0.7 with `-ocmcd97bv`.
- D97BV runtime has proven exact cave-first CAVE+SITE delivery, one write each, safe Apple validation, and cross-process CAVE visibility.

## Root Patch architecture
The next Root Patch must preserve Tahoe native Metal / Metal4 as the outer ABI and introduce only the legacy compiler/driver substrate needed by Haswell.

### Keep
- Haswell model-specific root patches from exact OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`.
- Monterey GVA shared patchset.
- Monterey OpenCL shared patchset.
- legacy 3802 sandbox profile.
- legacy `MTLCompilerService.xpc` from `12.5-3802-23`, but install it directly at `Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc`.
- private `MTLCompiler.framework` / `GPUCompiler.framework` 3802 and 32023 lanes as selected by the existing Metal3802 patchset.
- `RenderBox.framework` and `CoreImage.framework` compatibility payloads selected by Metal3802 Extended.
- exact Tahoe 25G82 metallib destination/source map from Pyquick `sys_patch_dict.py`, SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`.
- exact local MetallibSupportPkg preference for host build 25G82.

### Forbidden
- any merge/overwrite of the whole `/System/Library/Frameworks/Metal.framework` on Tahoe.
- donor `13.2.1-24/Metal.framework`.
- donor `Versions/A/Metal`.
- donor `MetalOld.dylib`.
- creation of an on-disk canonical Tahoe `Versions/A/Metal` merely to satisfy a lookup.
- true-five P1/P2b/P3/AIR00/D34 reapplication.
- global LLVM version coercion.

## D97DU source policy
Start from exact b9df76 source and change only functional files:
1. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
   - max supported host OS Sequoia -> Tahoe.
2. `opencore_legacy_patcher/support/metallib_handler.py`
   - prefer exact local host-build MetallibSupportPkg before remote API.
3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`
   - Tahoe Common: XPC-only Metal.framework modification + private compiler frameworks.
   - Tahoe Extended: CoreImage + RenderBox/private compilers; no main Metal.framework entry.
   - Tahoe metallibs: exact 25G82 map; preserve upstream behavior off Tahoe.

Packaging-only:
4. `OpenCore-Patcher-GUI.spec`
   - target_arch universal2 -> x86_64, because the proven Python 3.13 wxPython wheel is x86_64-only and ASUS2 is Intel-only.

## Mandatory static gates before application build
For a synthesized Tahoe 25G82 `LegacyMetal3802(...).patches()` result:
- whole-framework `Metal.framework` donor entry = 0.
- `MetalOld.dylib` = 0.
- legacy main `Versions/A/Metal` install entry = 0.
- Tahoe Common exact XPC overwrite source = `12.5-3802-23`.
- private MTLCompiler/GPUCompiler 3802 lane present.
- Tahoe Extended CoreImage donor = `14.0 Beta 3-24`.
- Tahoe Extended RenderBox donor = `14.0-3802`.
- Tahoe Extended MTLCompiler/GPUCompiler = `14.2 Beta 1`.
- Tahoe 25G82 metallib entries = 182.
- Python compile = PASS.
- git diff --check = PASS.

## Execution boundary
D97DU build is authorized on the Intel iMac build host only.
The build helper must perform no Root Patch, no EFI mutation, no Root Patch Restore, and no reboot.
After the returned D97DU build ZIP/report is independently audited, only then may Root Patch be authorized on ASUS2.
