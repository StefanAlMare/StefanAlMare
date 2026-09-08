# OCLP7 CHECKPOINT — D97GS ROOT PATCH P1 PASS / D97HB TOOLING FALSE NEGATIVE / D97HC READY

Date: 2026-09-08 EEST
Host: ASUS2 / MacBookAir6,2 / Tahoe 26.6.2 build 25G82 / Haswell 8086:0412

## Clean baseline before patch
D97GY PASS proved:
- VESA active; D97EZ inert;
- active native Tahoe MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- active native CoreDisplay metallib SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128;
- Haswell AuxKC payload absent after Restore;
- corrected local MetallibSupportPkg retained 180 metallibs, CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes 20739;
- official helper restored exact SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team `S74BDJXQMD`.

## D97GS manual Root Patch — PASS
Root Patch transcript proves:
- exact local 25G82 metallib source selected;
- Metal 3802 Common / Extended installed;
- exact corrected metallib patchset installed;
- Monterey GVA + OpenCL installed;
- Intel Haswell payload installed and AuxKC support added;
- D97GS hook reached;
- `D97GS: applying exact P1 selector bridge`;
- exact P1 post-identity PASS: `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- AuxKC rebuilt;
- `Patching complete`.

Classification:
`D97GS_P1_ROOTPATCH=CONTROL_FLOW_AND_EXACT_P1_IDENTITY_PASS`
`D97GS_ROOTPATCH_COMPLETION=PASS`

No reboot performed after patch.

## D97HB first pre-reboot audit
PASS before tooling stop:
- VESA gate;
- current active snapshot remains native Tahoe service `4262e71f...`;
- current active CoreDisplay remains native `daee638d...`, bytes 24128;
- official helper exact `9b74b7c9... / S74BDJXQMD`;
- local corrected metallib source still 180 / exact CoreDisplay;
- underlying System volume resolved as `disk1s8` and mounted read-only at temporary mountpoint.

Tooling failure only:
`/usr/bin/mount: No such file or directory`
leading to `D97HB_REASON=MOUNT_LINE_NOT_FOUND`.

macOS mount utility is `/sbin/mount`; therefore D97HB stopped before auditing the newly patched underlying volume. This is not evidence of Root Patch failure or semantic failure.

Classification:
`D97HB_RESULT=INCONCLUSIVE_BEYOND_MOUNT_DUE_TO_TOOLING_FALSE_NEGATIVE`
`D97HB_PRE_MOUNT_GATES=PASS`

## Current action
Use corrected read-only D97HC:
`OCLP-Continuity/artifacts/OCLP7_D97HC_ASUS2_POST_D97GS_PRE_REBOOT_AUDIT_V2.sh`
- commit `1eb0f34d6b31c90d0d17cee0237fb0ac5bf16a11`
- Git blob `4ad8762b80a076f5c6ebce9e612e8bede40ddc38`

D97HC differs materially from D97HB only in the corrected mount utility path plus explicit mount-line reporting. It must prove before reboot:
- active snapshot remains native Tahoe;
- official helper remains restored;
- underlying System volume contains exact P1 SHA/postimage;
- all 180 patched metallibs are byte-identical to corrected local source;
- CoreDisplay patched metallib exact.

No reboot is authorized until D97HC PASS and review.
