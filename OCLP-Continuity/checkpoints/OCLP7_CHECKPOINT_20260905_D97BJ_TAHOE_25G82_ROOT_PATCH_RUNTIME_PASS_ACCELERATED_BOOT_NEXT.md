# OCLP7 CHECKPOINT — D97BJ Tahoe 25G82 Root Patch runtime PASS

Date: 2026-09-05 EEST

## State entering checkpoint
- Target: macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Booted in VESA.
- Exact Golden source lineage remains `dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`.
- D97BJ functional source delta had already passed prepackaging audit:
  - host max Sequoia -> Tahoe;
  - Tahoe Metal.framework donor -> `13.2.1-24`;
  - Tahoe-only exact Pyquick 25G82 metallib map;
  - exact local host-build MetallibSupportPkg preferred before API fallback.
- Local exact MetallibSupportPkg is `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

## Root Patch runtime result
User executed Root Patch with the D97BJ custom Tahoe patcher.

Observed PASS sequence:
- `Exact local metallib found (26.6.2-25G82), skipping API fallback`;
- `Patcher is capable of patching`;
- `Mounted Universal-Binaries.dmg`;
- preflight completed with exact local metallib and `Using MetalLibSupportPkg: /Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
- `Finished Preflight, starting patching`;
- `Metal 3802 Common` installed;
- `Metal 3802 Common Extended` installed, including `Metal.framework` without the prior nonexistent `13.2.1-25` failure;
- exact Tahoe `Metal 3802 .metallibs` patchset executed across the 25G82 destination map;
- `VisionKitCore.framework` path was reached and patched (the old Sequoia-only `VisionKitInternal` mismatch is absent from this runtime);
- `Monterey GVA` installed;
- `Monterey OpenCL` installed;
- `Intel Haswell` installed, including `AppleIntelFramebufferAzul.kext`, `AppleIntelHD5000Graphics.kext`, GL/MTL/VA drivers and `AppleIntelHSWVA.bundle`;
- `Modern Wireless Common` installed;
- `Merging GPUCompiler.framework libraries to match binary` completed;
- patchset information written to Root Volume;
- RSRMonitor requirement detected and monitor added for current Preboot cryptex OS.dmg;
- OCLP auto-patch/update/RSR/os-caching launchd plists installed;
- `Building new Auxiliary Kernel Collection`;
- `Forcing Auxiliary Kernel Collection usage`;
- root volume unmounted;
- final `Patching complete`;
- OCLP requested reboot.

No internal traceback, missing-file error, preflight failure, AuxKC failure or mount/unmount error is present in the supplied Root Patch output.

## Classifications
- `D97BJ_TAHOE_25G82_ROOT_PATCH_PREFLIGHT=PASS`
- `D97BJ_TAHOE_25G82_EXACT_LOCAL_METALLIB_RUNTIME=PASS`
- `D97BJ_TAHOE_25G82_METAL_13_2_1_24_RUNTIME=PASS_BY_PREVIOUS_BLOCKER_CLEARED`
- `D97BJ_TAHOE_25G82_EXACT_METALLIB_MAP_RUNTIME=PASS`
- `D97BJ_TAHOE_25G82_HASWELL_PATCHSET_RUNTIME=PASS`
- `D97BJ_TAHOE_25G82_AUXKC_BUILD=PASS`
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS`
- `D97BJ_ACCELERATED_BOOT_RESULT=NOT_YET_TESTED`

## Important helper boundary before reboot
D97BJ uses a DEBUG privileged helper only while the custom ad-hoc OCLP process is running, with the exact official Dortania helper embedded as a restore asset.

Before accelerated reboot:
1. fully quit the inner OCLP application so the outer wrapper exits and runs its cleanup trap;
2. verify the installed helper at `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper` has returned to exact official SHA256:
   `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
3. if the helper hash is not exact, do NOT reboot; restore/diagnose first.

## CURRENT ACTION
After official-helper restoration is verified:
1. reboot once into the normal accelerated/root-patched Tahoe configuration;
2. observe whether a usable accelerated GUI appears;
3. if image/GUI is unusable, hard restart/power-cycle as needed and boot the established VESA recovery configuration;
4. return from VESA;
5. analyze only the immediately preceding accelerated diagnostic boot under `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`, not the later VESA recovery boot.

Root Patch itself is now runtime PASS. Accelerated GUI remains the next unresolved experiment.