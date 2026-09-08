# OCLP7 CHECKPOINT — 2026-09-08 — D97HR clean/native VESA PASS / D97HO Root Patch authorized

## Scope
ASUS2 Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## D97HR — PASS after controlled D97GS Revert + reboot
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HR_ASUS2_POST_REVERT_REBOOT_CLEAN_NATIVE_AUDIT.sh`
- commit `27ce582a14ecf4486fb9397208da2905bddfd4a4`;
- blob `c4c8a054069faf6c8cb88903f741ea8ab0247d1f`.

Exact live results:
- macOS `26.6.2 / 25G82`;
- `-igfxvesa` active;
- D97EZ inert;
- `D97HR_VESA_GATE=PASS`.

Native Metal compiler service:
- SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- bytes `239120`;
- UUID x86_64 `022C1750-8735-389A-A8BA-A8A67F54235D`;
- `D97HR_NATIVE_SERVICE=PASS`.

Native CoreDisplay metallib:
- SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- bytes `24128`;
- magic `MTLB`;
- `D97HR_NATIVE_CORE=PASS`.

Haswell post-revert state:
- `/Library/Extensions/AppleIntelFramebufferAzul.kext` absent;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext` absent;
- IOKit counts for Azul/HD5000/IntelAccelerator/IntelFramebuffer all zero;
- AuxKC query still listed the historical bundle IDs once each, but physical patch bundles are absent and `kmutil check --collection aux --load-info` returned RC=0. This is not treated as an active Haswell patch layer.

Official privileged helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team `S74BDJXQMD`;
- codesign PASS.

D97HO artifact remains exact:
- ZIP SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`;
- `D97HR_D97HO_ARTIFACT=PASS_EXACT`.

Legacy compiler residual:
- `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` absent on the active native snapshot;
- `D97HR_LEGACY_32023_PRESENT=NO`.

Final classification:
`D97HR_STATUS=PASS_CLEAN_NATIVE_VESA`
`D97HR_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS`
`D97HR_ROOT_PATCH_STATE=CLEAN_NATIVE_AFTER_REVERT`.

## Authorization
Exact D97HO Root Patch is now authorized on this clean native state.

Expected new functional state after patch, before reboot:
- active booted snapshot remains native Tahoe until reboot;
- underlying System volume receives bounded legacy compiler service with exact P1 SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- MTLCompiler 32023 appears with exact P3-only SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- P2 remains original `418b81d0000000 @ 0x9A8CD`;
- P3 postimage becomes `81c900002000 @ 0xA1573`;
- corrected metallibs must be exact 180/180;
- Haswell bundles/AuxKC must be rebuilt;
- P2b/AIR00/D34 remain absent.

Do not reboot immediately after D97HO Root Patch. Run a D97HC-derived P1+P3 pre-reboot audit first.
