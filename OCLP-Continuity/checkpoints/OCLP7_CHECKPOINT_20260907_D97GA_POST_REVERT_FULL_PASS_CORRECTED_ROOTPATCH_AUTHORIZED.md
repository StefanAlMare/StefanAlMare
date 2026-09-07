# OCLP7 CHECKPOINT — D97GA post-revert full PASS; corrected-payload Root Patch authorized

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- D97FX reconstructed the local `26.6.2-25G82` MetallibSupportPkg source exactly from the pinned original package.
- D97FY closed the final pre-restore/pre-Root-Patch gate.
- User executed Root Patch Restore through the exact D97DX outer wrapper, rebooted back to VESA, then corrected an accidentally still-active `-ocmcd97ez` token in EFI and rebooted once more with D97EZ ACTIVE mode inert.

## D97FZ post-revert VESA state
Boot args after corrected reboot:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh #-ocmcd97ez`

Classification:
- `D97GA_VESA_STATE=PASS`;
- `D97GA_D97EZ_ACTIVE_MODE=INERT`.

## Corrected local source survives revert
D97FZ proved:
- local metallib count `180`;
- all local metallibs have direct `MTLB` magic;
- CoreDisplay corrected SHA PASS;
- local source therefore remains the exact corrected 25G82 source after APFS revert.

Classification:
`D97GA_CORRECTED_LOCAL_SOURCE=PASS`.

## Installed root after APFS revert
D97FZ observed across the 180 dynamic MetallibSupportPkg target paths:
- corrected exact `0`;
- direct-MTLB `179`;
- metadata stubs `0`;
- missing `0`;
- other non-stub `1`.

The unique non-direct-MTLB path was subsequently identified exactly:
`/System/Library/Frameworks/QuartzCore.framework/Versions/A/Resources/default.metallib`

Identity:
- bytes `160202560`;
- SHA256 `45ebcfee208d1428e2834693152ebcf92e985d7714250c2fdc03e52ffec94204`;
- first bytes `cafebabe...`;
- `file` reports Mach-O universal binary with 19 architectures, including an `air64` slice classified as `MetalLib executable (MacOS), version 1.2.9` plus multiple AppleGPU slices.

Therefore this file is a valid fat/universal Metal library container and is not a metadata stub. Its top-level magic is fat-Mach-O `CAFEBABE`, so it is expected not to begin directly with `MTLB`.

Classification:
- `D97GA_INSTALLED_METADATA_STUB_COUNT=0` — SEMANTIC PROVEN;
- `D97GA_QUARTZCORE_FAT_METALLIB_VALID_CONTAINER=STRUCTURAL_PROVEN`;
- `D97GA_INSTALLED_STUB_LAYER_REMOVED=PASS`.

## Native CoreDisplay restored
Post-revert system CoreDisplay file:
`/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`

Identity:
- present;
- bytes `24128`;
- SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- `MetalLib executable (MacOS), version 1.2.9`.

This is neither the old 319-byte metadata stub nor the corrected package donor (`20739`, MetalLib 1.2.7). It is the native Tahoe restored file.

Classification:
`D97GA_NATIVE_COREDISPLAY_RESTORED=PASS`.

## Legacy Haswell load observation under VESA
`kmutil showloaded` did not list `AppleIntelHD5000Graphics` or `AppleIntelFramebufferAzul` in the post-revert VESA boot.
This is consistent with the restore removing the prior root-patched legacy driver layer before a corrected Root Patch is reapplied.

Classification:
`D97GA_LEGACY_HASWELL_KEXTS_POST_REVERT_NOT_LOADED=OBSERVED_EXPECTED`.

## Official privileged helper closure
Direct micro-gate proved exact system helper:
`/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`

Identity:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- universal x86_64/arm64;
- TeamIdentifier `S74BDJXQMD`;
- Developer ID Application: Mykola Grymalyuk (S74BDJXQMD);
- codesign designated-requirement verification PASS;
- `CODESIGN_VERIFY_RC=0`.

Classification:
`D97GA_OFFICIAL_HELPER_IDENTITY=PASS`.

## D97FZ closure
The original D97FZ helper did not emit its final PASS line because it stopped before helper validation. The subsequent direct micro-gate supplied the missing helper and unique non-MTLB classification evidence.

By composition:
- VESA state PASS;
- corrected local source PASS;
- installed metadata stubs zero;
- unique non-direct-MTLB file structurally valid fat MetalLib container;
- native CoreDisplay restored;
- official helper exact identity/codesign PASS.

Therefore:
`D97FZ_POST_REVERT_GATE=PASS_BY_COMPOSED_EVIDENCE`.

## APFS Root Patch Restore classification
The prior invalid-payload root-patched metallib layer is gone and native Tahoe metallib objects are restored.

Classification:
`D97GA_ROOT_PATCH_RESTORE=PASS`.

## Corrected Root Patch authorization
The exact D97DX outer app remains the authorized patch vehicle, with exact artifact/source/helper identities already closed PASS by D97FY.
The corrected local 25G82 source remains exact and contains 180/180 real dynamic MetalLib payloads; D97DX patchdict remains 182 total entries = 180 dynamic MetallibSupportPkg + 2 unchanged 14.6.1 donors.

AUTHORIZED NOW:
`D97GA_D97DX_CORRECTED_MANUAL_ROOT_PATCH=YES`.

Execution constraints:
1. stay in current VESA boot;
2. launch `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97DX.app` outer wrapper;
3. run Root Patch only — do NOT run Restore again;
4. preserve current boot args; no EFI/NVRAM/framebuffer changes;
5. allow patcher to consume corrected local `26.6.2-25G82` source;
6. if it reports missing metallib package, unexpected donor, or preflight failure, STOP and return output;
7. after Root Patch completes, fully close the inner OCLP so the outer wrapper restores/verifies the official helper;
8. DO NOT reboot after Root Patch;
9. return complete Root Patch output/status for post-patch audit.

Still NOT authorized:
- accelerated boot;
- disabling `-igfxvesa`;
- reboot after Root Patch before audit;
- EFI/NVRAM/framebuffer changes;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
