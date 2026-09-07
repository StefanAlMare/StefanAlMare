# OCLP7 CHECKPOINT — D97GB corrected Root Patch execution PASS; post-patch payload audit required

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- D97GA closed APFS Root Patch Restore PASS and authorized one corrected manual D97DX Root Patch in VESA.
- Corrected local MetallibSupportPkg source remains exact to the pinned original package, with `180/180` real dynamic metallibs and exact CoreDisplay donor SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`.
- D97EZ ACTIVE mode remains inert/commented.

## Corrected Root Patch transcript
User returned the complete manual Root Patch transcript from exact D97DX outer wrapper.

The patcher explicitly reported:
- `Exact local metallib found (26.6.2-25G82), skipping API fallback`;
- `Patcher is capable of patching`;
- preflight PASS;
- `Using MetalLibSupportPkg: /Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
- no download required;
- no missing metallib package;
- no unexpected donor failure;
- no preflight failure.

Patchsets executed include:
- Metal 3802 Common;
- Metal 3802 Common Extended;
- Metal 3802 .metallibs;
- Monterey GVA;
- Monterey OpenCL;
- Intel Haswell;
- Modern Wireless Common.

The transcript explicitly includes overwrite/install operations for the metallib layer, including:
- CoreDisplay `default.metallib`;
- QuartzCore `default.metallib`;
- Metal.framework metallibs;
- CoreImage metallibs;
- SkyLight shader metallib;
- all other mapped dynamic metallib targets.

Haswell driver layer installed:
- `AppleIntelFramebufferAzul.kext`;
- `AppleIntelHD5000Graphics.kext`;
- GL/MTL/VA bundles and HSWVA/shared support.

Final patch lifecycle:
- patchset information written to root volume;
- RSRMonitor decision/install completed;
- Auxiliary Kernel Collection rebuilt;
- Auxiliary Kernel Collection usage forced;
- root volume unmounted;
- final output `Patching complete` and reboot prompt.

No Root Patch error appears in the returned transcript.

Classification:
- `D97GB_CORRECTED_ROOTPATCH_CONTROL_FLOW=PASS`;
- `D97GB_CORRECTED_ROOTPATCH_EXECUTION=PASS`;
- `D97GB_CORRECTED_METALLIB_SOURCE_SELECTION=CONTROL_FLOW_PROVEN`;
- `D97GB_CORRECTED_METALLIB_INSTALLED_BYTES_SEMANTIC_IDENTITY=NOT_YET_PROVEN`.

## Why reboot is still blocked
The running `/` remains the currently booted pre-patch snapshot. Direct reads from `/System/...` can therefore observe the old native snapshot rather than the newly modified underlying System volume/new snapshot.

To avoid confusing current-snapshot bytes with the just-patched bytes, the next gate must mount the underlying APFS System volume read-only in a separate temporary mountpoint and compare the 180 dynamic metallib targets byte-for-byte against the corrected local source.

Required post-patch proof before reboot:
1. identify parent APFS System volume behind current root snapshot;
2. mount that volume read-only/nobrowse in a temporary directory;
3. compare every local corrected `.metallib` path against the mounted patched System volume;
4. require exact `180/180` byte identity;
5. require metadata-stub count `0`;
6. require CoreDisplay exact SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes `20739`, direct `MTLB`;
7. verify patched Haswell kexts exist in the mounted volume;
8. verify official privileged helper exact identity after outer-wrapper restoration;
9. unmount the audit mountpoint cleanly.

## CURRENT ACTION — D97GC READ-ONLY POST-PATCH SYSTEM-VOLUME AUDIT
Do not reboot.
Do not modify EFI/NVRAM/framebuffers/bootargs.
Do not run Root Patch or Restore again.
Run only the audited D97GC read-only helper against the underlying System volume.

Only a D97GC full PASS may authorize the next reboot. Accelerated boot remains forbidden until later explicit authorization.