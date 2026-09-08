# OCLP7 CHECKPOINT — 2026-09-08 — D97HS pre-reboot P1+P3 FULL PASS / D97HU VESA reboot audit ready

## Scope
ASUS2, macOS Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## D97HO Root Patch context
Exact D97HO Root Patch completed on the D97HR clean/native VESA baseline.
Patcher itself reported:
- D97GS P1 exact historical identity PASS, post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97HI P3 exact P3-only identity PASS, post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- AuxKC rebuilt/forced;
- patching complete.
No reboot occurred before D97HS.

## D97HS FULL PASS
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HS_ASUS2_POST_D97HO_PRE_REBOOT_P1_P3_AUDIT.sh`
- commit `dcfc861b9bd23a8ac00d7d07c43f4166ea402f18`;
- blob `dd71dbd1149a6c96b3e754ff500f029f536bdef5`.

User reran D97HS after the privileged helper had returned to the exact official helper.

### Boot / active snapshot
- 25G82;
- `-igfxvesa` active;
- D97EZ inert;
- active booted snapshot still native Tahoe pre-reboot;
- active native MTLCompilerService SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- active native CoreDisplay metallib SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes `24128`;
- active legacy MTLCompiler 32023 absent, as expected before reboot.
Classification: `ACTIVE_SNAPSHOT_NATIVE_UNCHANGED=PASS`.

### Official helper
- SHA `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team `S74BDJXQMD`;
- codesign PASS.
Classification: `OFFICIAL_HELPER=PASS`.

### Corrected local metallib source
- exact count `180`;
- CoreDisplay local corrected SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`.
Classification: PASS.

### D97HO artifact
- ZIP `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip`;
- SHA `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.
Classification: `PASS_EXACT`.

### Underlying System volume
Resolved active root `disk1s8s1`, underlying System volume `disk1s8` and mounted it sealed/read-only.

#### Exact P1
- MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- bytes `85520`;
- offset `0x3494`;
- postimage `81fe177d0000`;
- exact postimage PASS.
Classification: `PATCHED_P1=EXACT`.

#### Exact P3-only MTLCompiler 32023
- SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- bytes `1636896`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 offset `0x9A8CD`, current bytes `418b81d0000000`, exact original PASS;
- P3 offset `0xA1573`, current bytes `81c900002000`, exact serialized-bitcode postimage PASS.
Classification:
`P2_STATE=ORIGINAL_D0_NO_P2B`
`P3_STATE=EXACT_SERIALIZED_BITCODE_POSTIMAGE`
`PATCHED_COMPILER_P3_ONLY=PASS`.

No P2b, AIR00 or D34 replay.

### Corrected metallib tree on underlying System
- exact `180`;
- missing `0`;
- different `0`;
- CoreDisplay SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- magic `MTLB`.
Classification: `PATCHED_METALLIB_LAYER=PASS`.

### Haswell / new AuxKC
- `/Library/Extensions/AppleIntelFramebufferAzul.kext` present;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext` present;
- bundle IDs correct;
- AuxKC `/Library/KernelCollections/AuxiliaryKernelExtensions.kc`, bytes `5439488`;
- Azul in new AuxKC PASS;
- HD5000 in new AuxKC PASS;
- `kmutil check --collection aux --load-info` RC `0` informational pre-reboot.
Classification: `HASWELL_PRE_REBOOT_GATE=ON_DISK_AND_AUXKC_PRESENT`.

## Final D97HS classification
`D97HS_STATUS=PASS_PRE_REBOOT_P1_P3_AUDIT`
`D97HS_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97HS_ACTIVE_SNAPSHOT=NATIVE_TAHOE_UNCHANGED`
`D97HS_PATCHED_P1=EXACT`
`D97HS_PATCHED_P3=EXACT_P3_ONLY`
`D97HS_P2B_REPLAY=NO`
`D97HS_AIR00_REPLAY=NO`
`D97HS_D34_REPLAY=NO`
`D97HS_PATCHED_METALLIBS=180_OF_180_EXACT`
`D97HS_HASWELL_AUXKC=ON_DISK_PRESENT_PASS`.

Report:
`/Users/alex/Desktop/OCLP7_D97HS_POST_D97HO_PRE_REBOOT_20260908_141929/D97HS_REPORT.txt`.

## Authorization
A single reboot into VESA is now authorized.
During reboot / postboot:
- keep `-igfxvesa` active;
- keep D97EZ inert;
- no EFI/NVRAM/framebuffer changes;
- no acceleration yet;
- no P2b/AIR00/D34.

## D97HU — active-snapshot post-VESA reboot audit
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HU_ASUS2_POST_VESA_REBOOT_ACTIVE_P1_P3_AUDIT.sh`
- commit `19ee3a189bbbb6af2ca83b425e613fe4724f21b8`;
- blob `771c11b8c0529137f4c3939d202d49204d04874d`;
- bytes `11849`.

D97HU is read-only and must prove on the newly active snapshot:
1. exact P1 service SHA/postimage;
2. exact P3-only MTLCompiler32023 SHA/UUID;
3. P2 remains original and P3 remains exact postimage;
4. corrected metallibs exact 180/180;
5. Haswell bundles and AuxKC present/consistent;
6. helper official exact;
7. D97HO artifact exact.

D97HU deliberately treats Haswell `loaded/unloaded` and IOKit state under `-igfxvesa` as informational, not a gate, incorporating D97HQ evidence.

Expected final:
`D97HU_STATUS=PASS_ACTIVE_P1_P3_VESA`
`D97HU_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS_ACTIVE_SNAPSHOT`
`D97HU_NEXT=REVALIDATE_D97EW_CAPTURE_BEFORE_ANY_ACCELERATED_BOOT`
`D97HU_ACCELERATION=NOT_YET_AUTHORIZED`.

After D97HU PASS, acceleration is still NOT authorized until D97EW persistent capture is repaired/revalidated because the previous P1-only accelerated attempt produced an incomplete current accelerated tuple capture.
