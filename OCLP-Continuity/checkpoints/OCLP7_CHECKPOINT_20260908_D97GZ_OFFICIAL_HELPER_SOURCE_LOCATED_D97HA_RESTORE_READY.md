# OCLP7 CHECKPOINT — D97GZ official helper source located; D97HA restore ready

Date: 2026-09-08 EEST

## Entering state
After D97DX Restore + VESA reboot, D97GY proved the System baseline itself is clean:
- Tahoe native MTLCompilerService restored, SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`, UUID/arches PASS;
- native CoreDisplay metallib restored, `24128` bytes, SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, `MTLB`;
- Haswell AuxKC Data kexts removed;
- corrected local 25G82 metallib source survived: 180 files, zero bad magic, CoreDisplay `20739 / b848d54e... / MTLB`.

D97GY then stopped at official-helper validation. Manual inspection proved this was a real wrapper-state residue, not a collector-only false negative:
- active helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- ad-hoc signature;
- TeamIdentifier not set;
- this is exact D97DX DEBUG helper identity.

Classification:
`D97GY_SYSTEM_RESTORE=STRUCTURAL_SEMANTIC_PASS`
`D97GY_HELPER_STATE=FAIL_EXACT_DEBUG_HELPER_STILL_ACTIVE`
`D97GY_OVERALL=PARTIAL_PASS_HELPER_REMEDIATION_REQUIRED`.

## D97GZ read-only locator
D97GZ inspected the exact D97DX-derived launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c` and proved its helper policy:
- requires exact official helper before swap;
- creates backup with `/usr/bin/mktemp "/tmp/d97dx-official-helper.XXXXXX"`;
- copies official helper to backup;
- installs DEBUG helper temporarily;
- `restore_official` reinstalls saved helper;
- cleanup trap attempts restore and then removes the temporary backup.

The temporary `/tmp` backup no longer exists after reboot/cleanup, but D97GZ found two persistent exact official copies, both SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`:
1. `/Users/alex/Desktop/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`;
2. `/Library/Application Support/Dortania/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`.

D97GZ result:
- candidate files checked `208`;
- exact official SHA matches `2`;
- exact official SHA + Team PASS `2`;
- `D97GZ_OFFICIAL_BACKUP_LOCATED=PASS`;
- no helper replacement, Root Patch, Restore, EFI/NVRAM/framebuffer mutation or reboot.

## D97HA remediation design
Use the persistent Application Support source only:
`/Library/Application Support/Dortania/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`.

D97HA requirements:
- active helper must still be exact DEBUG SHA `993bf7e8...`;
- source must be exact official SHA `9b74b7c9...`, Team `S74BDJXQMD`, codesign PASS;
- save DEBUG helper backup to Desktop;
- stage official helper under `/private/tmp`, root:wheel mode 4755;
- verify staged SHA/Team/codesign;
- replace only `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`;
- verify final exact official SHA/Team/codesign;
- no Root Patch/Restore/EFI/NVRAM/framebuffer/reboot.

Helper:
`OCLP-Continuity/artifacts/OCLP7_D97HA_ASUS2_RESTORE_OFFICIAL_HELPER_ONLY.sh`
- commit `5c5ffddc7db7c2d6113115c90b9ef0e74449e977`;
- Git blob `5eec076996619bab2b2d8a17f57b086b6d0ac011`.

## Current action
Run D97HA on ASUS2. If PASS, rerun D97GY unchanged to obtain full post-Restore baseline PASS before D97GS Root Patch is re-authorized.

Do not Root Patch or reboot before D97HA + D97GY closure.
