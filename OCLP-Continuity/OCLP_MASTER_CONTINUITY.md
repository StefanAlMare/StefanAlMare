# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- current running boot is still VESA; `-igfxvesa` retained;
- `-ocmcdiag` present;
- full D97BV arg `-ocmcd97bv` present;
- active EFI compatibility kext remains D97DL `OCLPMetalCompat.kext` 0.0.7;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- D97DX Root Patch has now completed successfully but the new snapshot has not yet been rebooted.

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
- same PID mapped CAVE then SITE;
- CAVE exact replacement, tail zero, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- SITE cave-prereq PASS, exact replacement, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- D97DR separately proved cross-process CAVE visibility.

Therefore the selective-3802 adapter delivery mechanism is CLOSED PASS under VESA.

## D97DX native-Metal-safe Root Patch artifact — PASS
Exact source baseline:
- OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Exact tracked delta is four files only:
1. `OpenCore-Patcher-GUI.spec` — x86_64 packaging only;
2. `opencore_legacy_patcher/support/metallib_handler.py` — exact local host-build MetallibSupportPkg before API;
3. `opencore_legacy_patcher/sys_patch/patchsets/detect.py` — host max Sequoia -> Tahoe;
4. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py` — Tahoe-native-Metal-safe 3802 policy.

Tahoe policy:
- Common: inject only `MTLCompilerService.xpc` under native Metal.framework plus private MTLCompiler/GPUCompiler lanes;
- Extended: CoreImage/RenderBox/private compiler compatibility only; NO whole `Metal.framework` donor;
- exact Pyquick 25G82 metallib map, 182 entries;
- no `MetalOld.dylib`;
- no main legacy `Versions/A/Metal` donor;
- no true-five.

Artifact/source audit closed PASS before Root Patch.

## D97DX manual Root Patch execution — PASS
Returned complete ASUS2 patcher output proves:
- Darwin 25 detection;
- exact local `MetallibSupportPkg/26.6.2-25G82` found and used;
- patcher capable / sanity / preflight PASS;
- Universal-Binaries.dmg mounted;
- `Metal 3802 Common` installed only sandbox profile + legacy `MTLCompilerService.xpc` under native Metal.framework + private MTLCompiler/GPUCompiler lanes;
- `Metal 3802 Common Extended` installed CoreImage + RenderBox + private compiler lanes with NO whole Metal.framework donor;
- exact Tahoe 25G82 metallib patchset executed;
- Monterey GVA executed;
- Monterey OpenCL executed;
- Intel Haswell patchset executed, including `AppleIntelFramebufferAzul.kext`, `AppleIntelHD5000Graphics.kext`, GL/MTL/VA bundles and shared graphics bundle;
- Modern Wireless Common also executed, orthogonal to the Metal route;
- GPUCompiler libraries merged;
- patchset metadata written;
- RSR monitor installed/updated as required;
- Auxiliary Kernel Collection rebuilt and forced;
- root volume unmounted;
- final `Patching complete` reached.

Classifications:
- `D97DX_ROOT_PATCH_PREFLIGHT=PASS`;
- `D97DX_EXACT_25G82_METALLIB_RUNTIME=PASS`;
- `D97DX_NATIVE_METAL_SAFE_3802_EXECUTION=PASS`;
- `D97DX_LEGACY_MAIN_METAL_SHADOW=ABSENT_RUNTIME_LOG_PROVEN`;
- `D97DX_HASWELL_PATCHSET_EXECUTION=PASS`;
- `D97DX_AUXKC_REBUILD=PASS`;
- `D97DX_ROOT_PATCH_EXECUTION=PASS`.

Root Patch execution checkpoint commit: `7c1c0d9b4bafd9ad778f1a73809d26ab331f165c`.

## CURRENT ACTION — PRE-VESA REBOOT SAFETY GATE
Do NOT remove `-igfxvesa`.
Do NOT attempt accelerated/non-VESA boot yet.

First close the inner D97DX OCLP application completely so the outer wrapper can finish and restore the exact official privileged helper.

Then verify installed helper:
- expected SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- expected TeamIdentifier `S74BDJXQMD`.

If helper identity PASS, authorize one manual reboot while retaining exact VESA/D97BV boot policy:
`-igfxvesa -ocmcdiag -ocmcd97bv`

Purpose of the next boot: validate the newly root-patched snapshot safely under VESA only.

Still NOT authorized:
- removal of `-igfxvesa`;
- accelerated/non-VESA boot;
- another Root Patch before evaluating the first root-patched VESA boot;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
