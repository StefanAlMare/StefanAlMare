# OCLP7 CHECKPOINT — D97GC APFS snapshot parse false negative; D97GD ready

Date: 2026-09-07 EEST

## Entering state
- Corrected D97DX Root Patch execution completed successfully under VESA and ended with `Patching complete` / reboot prompt.
- No reboot was performed.
- D97GC was intended to audit the just-patched underlying APFS System volume read-only before authorizing any reboot.

## D97GC result
D97GC passed:
- Tahoe `26.6.2 / 25G82`, x86_64;
- VESA boot state;
- D97EZ ACTIVE mode inert;
- corrected local source count `180`;
- all local metallibs direct `MTLB`;
- corrected local CoreDisplay SHA PASS.

It then parsed:
`D97GC_SYSTEM_VOLUME=disk1s8s1`
and stopped with:
`D97GC_REASON=SYSTEM_VOLUME_PARSE_FAILED_disk1s8s1`.

## Classification
On this system, `diskutil apfs listSnapshots /` reports the mounted root snapshot device as `disk1s8s1`. The underlying APFS System volume is the parent `disk1s8`.

The D97GC helper accepted only the base-volume form `diskNsN` and did not normalize the snapshot form `diskNsNsN` before its validation regex.

Therefore:
- `D97GC_APFS_DEVICE_PARSE=TOOLING_FALSE_NEGATIVE`;
- `D97GC_SYSTEM_VOLUME_MOUNT_ATTEMPT=NOT_REACHED`;
- `D97GC_SYSTEM_VOLUME_WRITE=NO`;
- `D97GC_ROOT_PATCH_STATE=UNCHANGED`;
- `D97GC_REBOOT=NO`.

No Root Patch, Restore, mount, system-volume write, EFI/NVRAM/framebuffer change, or reboot occurred during the failed D97GC run.

## D97GD correction
New helper:
`OCLP-Continuity/artifacts/OCLP7_D97GD_POSTPATCH_SYSTEM_VOLUME_AUDIT_V2.sh`

Authority:
- commit `36677ac32b0e3923057147aeff2a3068ab654e25`;
- Git blob `5ec730e726a532d94eedb8bf0a4e646e214f397b`.

Correction:
- explicitly normalizes snapshot device `diskNsNsN -> diskNsN`;
- validates the resulting APFS System volume before mount;
- mounts the underlying System volume `rdonly,nobrowse`;
- compares all 180 dynamic MetallibSupportPkg targets byte-for-byte against the corrected local source;
- verifies corrected CoreDisplay exact SHA/size/MTLB magic;
- verifies Haswell driver presence;
- verifies official privileged helper identity;
- unmounts the audit volume;
- performs no reboot or system mutation.

## CURRENT ACTION
Remain in the current VESA boot. Do not reboot.
Run D97GD and require full PASS before any reboot is authorized.