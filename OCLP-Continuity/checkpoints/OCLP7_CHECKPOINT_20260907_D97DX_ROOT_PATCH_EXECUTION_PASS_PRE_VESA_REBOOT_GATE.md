# OCLP7 CHECKPOINT — D97DX Root Patch execution PASS; pre-VESA reboot gate

Date: 2026-09-07 EEST

## Entering authority
- ASUS2: Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.
- Current boot remains VESA with `-igfxvesa -ocmcdiag -ocmcd97bv`.
- Active EFI compatibility kext remains D97DL 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`.
- D97BV runtime delivery was already CLOSED PASS under VESA by D97DT.
- D97DX native-Metal-safe Root Patch artifact had passed build/artifact/source audit and manual Root Patch was authorized.

## Returned D97DX Root Patch execution
The user ran Root Patch manually from the exact outer D97DX app on ASUS2 and returned the complete patcher output.

### Metallib / preflight
Runtime output proved:
- Darwin 25 patchset detection;
- exact local `MetallibSupportPkg/26.6.2-25G82` found before API fallback;
- patching capability PASS;
- Universal-Binaries.dmg mounted;
- sanity checks PASS;
- preflight completed.

### Native-Metal-safe 3802 policy executed exactly as designed
`Metal 3802 Common`:
- overwrote sandbox profile `com.apple.mtlcompilerservice.sb`;
- overwrote only `/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc`;
- installed private `MTLCompiler.framework`;
- installed private `GPUCompiler.framework`.

`Metal 3802 Common Extended`:
- installed `CoreImage.framework`;
- installed private `RenderBox.framework`;
- installed private `MTLCompiler.framework`;
- installed private `GPUCompiler.framework`;
- NO whole `Metal.framework` donor was installed;
- NO `MetalOld.dylib` was installed;
- NO legacy main `Versions/A/Metal` donor was installed.

`Metal 3802 .metallibs`:
- exact Tahoe 25G82 metallib map executed;
- RenderBox `archive.metallib` removed as designed;
- Tahoe framework/private-framework/application/iOSSupport metallibs were replaced from the audited map.

### Haswell / supporting patchsets
Runtime output also proved execution of:
- Monterey GVA: `AppleGVA.framework`, `AppleGVACore.framework`;
- Monterey OpenCL: `OpenCL.framework`;
- Intel Haswell:
  - `AppleIntelFramebufferAzul.kext`;
  - `AppleIntelHD5000Graphics.kext`;
  - `AppleIntelHD5000GraphicsGLDriver.bundle`;
  - `AppleIntelHD5000GraphicsMTLDriver.bundle`;
  - `AppleIntelHD5000GraphicsVADriver.bundle`;
  - `AppleIntelHSWVA.bundle`;
  - `AppleIntelGraphicsShared.bundle`;
- Modern Wireless Common was also detected by OCLP and installed; it is orthogonal to the Metal route.

### Completion
- GPUCompiler libraries merged;
- patchset information written to Root Volume;
- RSR monitor condition detected for Haswell GPU companion bundles;
- Auxiliary Kernel Collection rebuilt;
- Auxiliary KC usage forced;
- root volume unmounted;
- patcher ended with `Patching complete` and requested reboot.

Classifications:
- `D97DX_ROOT_PATCH_PREFLIGHT=PASS`
- `D97DX_EXACT_25G82_METALLIB_RUNTIME=PASS`
- `D97DX_NATIVE_METAL_SAFE_3802_EXECUTION=PASS`
- `D97DX_LEGACY_MAIN_METAL_SHADOW=ABSENT_RUNTIME_LOG_PROVEN`
- `D97DX_HASWELL_PATCHSET_EXECUTION=PASS`
- `D97DX_AUXKC_REBUILD=PASS`
- `D97DX_ROOT_PATCH_EXECUTION=PASS`

## Current safety gate before reboot
Do NOT remove `-igfxvesa` yet.
Do NOT attempt an accelerated/non-VESA boot yet.

Before any reboot, close the inner OCLP application completely so the D97DX outer wrapper can restore the exact official Dortania privileged helper.

Then verify current installed helper identity:
- expected SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- expected TeamIdentifier `S74BDJXQMD`.

If and only if that helper identity is restored, authorize one manual reboot with VESA still retained (`-igfxvesa -ocmcdiag -ocmcd97bv`).

The purpose of the next boot is only to validate the newly root-patched snapshot safely under VESA. It is NOT the accelerated test.

Still NOT authorized:
- removal of `-igfxvesa`;
- accelerated/non-VESA boot;
- further Root Patch;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
