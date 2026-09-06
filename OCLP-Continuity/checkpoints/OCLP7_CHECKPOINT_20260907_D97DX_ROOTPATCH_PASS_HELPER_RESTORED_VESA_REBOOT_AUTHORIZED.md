# OCLP7 CHECKPOINT — D97DX Root Patch PASS; official helper restored; VESA reboot authorized

Date: 2026-09-07 EEST

## Root Patch result
ASUS2 completed the exact D97DX native-Metal-safe Root Patch on Tahoe 26.6.2 / 25G82.

Observed patch execution:
- exact local MetallibSupportPkg `26.6.2-25G82` found and used;
- `Metal 3802 Common` installed legacy `MTLCompilerService.xpc` only under native Metal.framework plus private MTLCompiler/GPUCompiler frameworks;
- `Metal 3802 Common Extended` installed CoreImage/RenderBox/private compiler compatibility with no whole legacy Metal.framework donor;
- exact Tahoe 25G82 metallib set installed;
- Monterey GVA installed;
- Monterey OpenCL installed;
- Intel Haswell drivers installed, including AppleIntelFramebufferAzul.kext, AppleIntelHD5000Graphics.kext, GL/MTL/VA bundles;
- Auxiliary Kernel Collection rebuilt successfully;
- patcher reached `Patching complete`.

Classification:
`D97DX_ROOT_PATCH_EXECUTION=PASS`
`D97DX_NATIVE_METAL_SAFE_POLICY_RUNTIME_EXECUTION=PASS`

## Post-patch helper gate
After closing OCLP completely:
- no OpenCore-Patcher process remained;
- installed privileged helper SHA256:
  `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier: `S74BDJXQMD`.

Classification:
`D97DX_OFFICIAL_HELPER_RESTORED=PASS`.

## Boot-args gate
Current boot-args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv`

Active required tokens remain:
- `-igfxvesa`;
- `-ocmcdiag`;
- `-ocmcd97bv`.

The `#-ocmcd97bvcave` token is not the exact active cave-only boot arg and does not satisfy the plugin's exact `-ocmcd97bvcave` check.

Classification:
`D97DX_POSTPATCH_BOOTARGS_VESA_D97BV=PASS`.

## Authorization
A manual reboot is now authorized while retaining the exact current VESA boot args.

Purpose of this reboot:
- validate the newly root-patched snapshot under the established recovery-safe VESA configuration;
- verify D97DL remains loaded and functional under the new snapshot;
- do not yet test accelerated/non-VESA GUI.

Authorized now:
`D97DX_POSTPATCH_VESA_REBOOT=YES`.

Still NOT authorized:
- removal of `-igfxvesa`;
- accelerated/non-VESA boot;
- Root Patch rerun;
- legacy main Metal shadow;
- true-five reapplication.

## NEXT ACTION
User manually reboots ASUS2 with the current unchanged boot args. On return, inspect root-patched snapshot state, D97DL identity/runtime properties, graphics/driver loading and any boot anomalies before separately considering removal of `-igfxvesa`.
