# OCLP7 CHECKPOINT — 2026-09-08 — D97GS Revert PASS / D97HR clean-native audit ready

## Scope
ASUS2 Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## Pre-revert context
- exact D97HO wrapper was built and audited;
- OCLP UI exposed only `Revert Root Patch`, not `Start Root Patch`;
- therefore direct D97HO patching was superseded by Restore-first workflow.

## D97GS Revert Root Patch — PASS
User ran Revert Root Patch using the exact D97GS lineage.
Observed output:
- `Starting Unpatch Process`;
- exact local MetallibSupportPkg 26.6.2-25G82 found;
- installed patchsets detected: Metal 3802 Common, Metal 3802 .metallibs, Intel Haswell, Metal 3802 Common Extended, Monterey GVA, Monterey OpenCL;
- SkylightPlugins removed;
- Auxiliary Kernel Collection cleanup performed;
- `AppleIntelFramebufferAzul.kext` removed;
- `AppleIntelHD5000Graphics.kext` removed;
- `Unpatching complete`;
- OCLP requests reboot for changes to take effect.

Classification:
`D97GS_REVERT_ROOT_PATCH=PASS`
`REVERT_WORKFLOW=EXPECTED`
`D97HO_P3_NOT_APPLIED_YET`

## Current authorization
Reboot is authorized now, with **no other changes**:
- keep `-igfxvesa` active;
- keep D97EZ inert;
- no EFI/NVRAM/framebuffer changes;
- no Root Patch before post-reboot clean/native audit.

## D97HR — post-reboot clean/native audit
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HR_ASUS2_POST_REVERT_REBOOT_CLEAN_NATIVE_AUDIT.sh`
- commit `27ce582a14ecf4486fb9397208da2905bddfd4a4`.

D97HR must prove after reboot:
1. Tahoe build 25G82 and VESA gate PASS;
2. native MTLCompilerService SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
3. native CoreDisplay metallib SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128, MTLB;
4. Haswell patch bundles removed from /Library/Extensions;
5. AuxKC consistency RC=0;
6. official privileged helper exact SHA/team/codesign;
7. exact D97HO ZIP remains available and unchanged.

Only after D97HR PASS may D97HO Root Patch be authorized on the clean native state.

P2b/AIR00/D34 remain unauthorized.
