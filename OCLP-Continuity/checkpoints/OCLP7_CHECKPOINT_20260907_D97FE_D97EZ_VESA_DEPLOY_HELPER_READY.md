# OCLP7 D97FE — D97EZ VESA deploy helper READY

Date: 2026-09-07 EEST

## Input authority
D97FD independently audited D97EZ 0.0.12 PASS and authorized VESA-first deployment only.

Audited D97EZ identity:
- version `0.0.12`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64.

## Fail-closed deploy helper
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97FE_D97EZ_VESA_DEPLOY.sh`

Identity:
- commit `4c7b89e5aa2b66b7d25c5e6ed9f7f9a7a25d6e53`;
- Git blob `58af13327d31ea9b1e6b74c4b73374b2ea91f9f7`.

Helper behavior:
- requires sudo/x86_64;
- requires EFI mounted at `/Volumes/EFI`;
- requires current VESA args `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` and inert `#-ocmcd97bvcave`;
- rejects `#-igfxvesa` and rejects active `-ocmcd97ez`;
- verifies currently active D97ES 0.0.11 exact executable SHA/UUID before mutation;
- verifies incoming D97EZ 0.0.12 exact version/executable SHA/Info SHA/UUID/arch;
- copies incoming kext to temporary sibling and re-verifies identity before touching active kext;
- moves active D97ES to timestamped backup;
- activates D97EZ by same-volume rename;
- rolls back old D97ES if activation rename fails or final D97EZ identity fails;
- verifies `config.plist` SHA unchanged;
- verifies boot-args string unchanged;
- does not edit Kernel Add / BundlePath;
- performs no NVRAM write, Root Patch or reboot.

## User-visible deploy package
`OCLP7_D97FE_D97EZ_VESA_DEPLOY.zip`
- bytes `22153`;
- SHA256 `f4faf2266bbba41b15f6f450b120219fbb8c36cbf6ab2f394cee5fa144d746a6`.

Bootstrap inside package:
`OCLP7_D97FE_D97EZ_VESA_DEPLOY_BOOTSTRAP.command`
- SHA256 `79b5dd3f02ba23bfbabe51c195df62ae29c7eb3f474dca0e5f65bc93e1e00b0`;
- verifies included audited D97EZ executable + Info.plist SHA;
- downloads exact helper at commit `4c7b89e5...`;
- verifies helper Git blob `58af1332...` before execution;
- invokes helper through sudo.

## Classification
- `D97FE_DEPLOY_HELPER_STATIC_CONTRACT=PASS`
- `D97FE_AUDITED_KEXT_PACKAGED=PASS`
- `D97FE_VESA_DEPLOYMENT_AUTHORIZED=YES`
- `D97FE_VESA_REBOOT_AUTHORIZED=NO_PENDING_DEPLOY_IDENTITY_AUDIT`
- `D97FE_D97EZ_FUNCTIONAL_ACTIVE_AUTHORIZED=NO`
- `D97FE_ACCELERATED_BOOT_AUTHORIZED=NO`
- `D97FE_ROOT_PATCH_AUTHORIZED=NO`

## CURRENT ACTION
On ASUS2, remain in current VESA session. Mount the active EFI as `/Volumes/EFI`, extract the exact D97FE deploy ZIP, and run the bootstrap. Return the complete terminal output. Do not reboot or add `-ocmcd97ez` after deploy; one VESA validation reboot may be separately authorized only after the returned active-EFI identity is audited PASS.
