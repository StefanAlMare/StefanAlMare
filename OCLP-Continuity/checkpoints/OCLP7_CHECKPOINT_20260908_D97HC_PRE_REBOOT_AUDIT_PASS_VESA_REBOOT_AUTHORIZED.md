# OCLP7 CHECKPOINT — 2026-09-08 — D97HC PRE-REBOOT AUDIT PASS / VESA REBOOT AUTHORIZED

## Context
ASUS2 / Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.
User chose clean Restore-first sequencing before D97GS P1-only Root Patch.

## Clean post-Restore baseline already proven
D97GY final PASS after D97HA official-helper restoration:
- VESA active; D97EZ inert;
- native Tahoe MTLCompilerService exact SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- native CoreDisplay metallib exact SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128, MTLB;
- Haswell AuxKC Data kexts removed;
- corrected local MetallibSupportPkg survives with 180 metallibs, zero bad magic; local CoreDisplay exact SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes 20739;
- official privileged helper exact SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

## D97GS P1-only Root Patch result
Manual D97GS Root Patch completed successfully on the clean restored base.
Transcript proves:
- exact local 25G82 MetallibSupportPkg selected;
- Metal 3802 Common / Common Extended installed;
- corrected 180 metallib patchset installed;
- Monterey GVA/OpenCL installed;
- Intel Haswell patchset installed;
- Modern Wireless patchset installed;
- D97GS P1 hook executed;
- exact P1 final SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- Auxiliary Kernel Collection rebuilt;
- `Patching complete` reached.

Classification:
`D97GS_P1_ROOTPATCH=PASS`.

## D97HB tooling false negative
D97HB pre-reboot audit passed all gates through successful read-only mount of underlying System volume, then stopped because it invoked `/usr/bin/mount`, which does not exist on macOS.
No semantic failure was demonstrated.
Classification:
`D97HB_POST_MOUNT_RESULT=INCONCLUSIVE_TOOLING_FALSE_NEGATIVE`.

## D97HC corrected pre-reboot audit PASS
D97HC corrected `/usr/bin/mount` to `/sbin/mount` and returned full PASS.

### Active snapshot before reboot
Still native Tahoe as expected:
- active MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- active CoreDisplay SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- active CoreDisplay bytes 24128.

### Official helper
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`;
- codesign PASS.

### Underlying newly patched System volume
Mounted read-only:
`/dev/disk1s8 on /private/tmp/OCLP7_D97HC_MNT_8478 (apfs, sealed, local, read-only, journaled, nobrowse)`.

Exact P1 service proven:
- SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- bytes 85520;
- postimage at offset 0x3494: `81fe177d0000`;
- postimage match PASS.

Corrected metallib layer proven:
- exact 180;
- missing 0;
- different 0;
- patched CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes 20739;
- MTLB magic.

Final D97HC outputs:
- `D97HC_STATUS=PASS_PRE_REBOOT_AUDIT`
- `D97HC_ACTIVE_SNAPSHOT=NATIVE_TAHOE_UNCHANGED`
- `D97HC_PATCHED_P1=STRUCTURAL_SEMANTIC_PASS_PRE_REBOOT`
- `D97HC_PATCHED_METALLIBS=180_OF_180_EXACT`
- `D97HC_OFFICIAL_HELPER=RESTORED_PASS`.

## Current authorization
A single reboot in VESA is now authorized.
Keep unchanged:
- `-igfxvesa` ACTIVE;
- `#-ocmcd97ez` INERT;
- framebuffer baseline 3/3/3;
- optional iGPU properties `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override all OFF;
- no EFI/NVRAM/framebuffer edits;
- no acceleration attempt yet.

After VESA reboot, perform a read-only active-snapshot audit before removing `-igfxvesa` or enabling D97EZ.
Expected active state after reboot:
- MTLCompilerService exact P1 SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- corrected metallibs 180/180 exact;
- CoreDisplay exact `b848d54e...` / 20739 / MTLB;
- Haswell AuxKC kexts installed and loaded;
- official helper still exact.

No accelerated boot is authorized until that post-reboot VESA audit passes.
