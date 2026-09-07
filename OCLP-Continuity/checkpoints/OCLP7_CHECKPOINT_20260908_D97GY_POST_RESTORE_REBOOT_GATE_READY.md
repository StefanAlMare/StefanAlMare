# OCLP7 CHECKPOINT — post-Restore reboot completed; D97GY native-baseline gate ready

Date: 2026-09-08 EEST

## User-authoritative transition
The user completed the requested Root Patch Restore/Revert and then rebooted ASUS2 back into VESA before applying D97GS.

This supersedes the previously planned direct D97GS-over-D97DX layering. The project now intentionally requires a clean native Tahoe baseline before the P1-only Root Patch.

No claim is made yet that Restore succeeded semantically until D97GY verifies the running post-reboot state.

## Expected clean post-Restore state
D97GY will require:
- Tahoe `26.6.2 / 25G82`, x86_64;
- `-igfxvesa` active and `-ocmcd97ez` inert;
- native Tahoe `MTLCompilerService` restored:
  - SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
  - UUID `022C1750-8735-389A-A8BA-A8A67F54235D`;
  - universal x86_64 + arm64e;
- native CoreDisplay metallib restored:
  - bytes `24128`;
  - SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
  - `MTLB` magic;
- Data-volume Haswell AuxKC kexts removed and not loaded;
- corrected local `MetallibSupportPkg/26.6.2-25G82` source survives:
  - 180 `.metallib` files;
  - CoreDisplay bytes `20739`;
  - SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
  - no bad magic;
- official OCLP privileged helper exact SHA/team/codesign PASS.

## Current action
Run only:
`OCLP-Continuity/artifacts/OCLP7_D97GY_ASUS2_POST_RESTORE_VESA_BASELINE_GATE.sh`

Helper authority:
- commit `c0069758ab2585ad9af3aedb49fbe3633e6f919d`.

No Root Patch, no EFI/NVRAM/framebuffer mutation, no reboot during D97GY.

Only if D97GY returns `D97GY_STATUS=PASS_READONLY_POST_RESTORE_GATE` may D97GS P1-only Root Patch be authorized on this clean base.
