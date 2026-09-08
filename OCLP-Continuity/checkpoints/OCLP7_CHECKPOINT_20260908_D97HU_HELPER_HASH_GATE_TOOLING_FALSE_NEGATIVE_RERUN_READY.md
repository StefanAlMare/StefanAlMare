# OCLP7 CHECKPOINT — 2026-09-08 — D97HU HELPER HASH GATE TOOLING FALSE NEGATIVE / RERUN READY

## Context
After D97HS FULL PASS, ASUS2 was rebooted once with `-igfxvesa` still active, as authorized. The user then downloaded the exact published D97HU post-VESA active-snapshot audit helper from commit `19ee3a189bbbb6af2ca83b425e613fe4724f21b8`.

## Observed stop
The wrapper command compared the downloaded helper against an incorrect expected Git blob value `771c11b8c0529137f4c3939d202d49204d04874d` and therefore stopped before executing D97HU.

Actual downloaded helper Git blob reported locally:
`2f023cb10d544794e88a06ba58ab7c276f3d060f`.

Repository verification at commit `19ee3a189bbbb6af2ca83b425e613fe4724f21b8` confirms:
- path: `OCLP-Continuity/artifacts/OCLP7_D97HU_ASUS2_POST_VESA_REBOOT_ACTIVE_P1_P3_AUDIT.sh`
- blob: `2f023cb10d544794e88a06ba58ab7c276f3d060f`
- bytes: `12256`.

Therefore the stop is classified:
`D97HU_HELPER_IDENTITY_FAILURE=TOOLING_FALSE_NEGATIVE_WRONG_EXPECTED_BLOB`
`D97HU_SCRIPT_EXECUTED=NO`
`D97HO_P1_P3_ACTIVE_STATE=NOT_INVALIDATED`
`ROOT_PATCH_RERUN=NO`
`REBOOT_AGAIN=NO`
`EFI_NVRAM_FRAMEBUFFER_MUTATION=NO`.

## Additional boot evidence observed before D97HU rerun
A WindowServer crash report from the same post-reboot boot session records:
- macOS `26.6.2 (25G82)`, model `MacBookAir6,2`;
- WindowServer launch `2026-09-08 14:25:56 +0300`, crash `14:26:07 +0300`;
- COREANIMATION code 4, `spec=PBGRAXb_Xc`;
- `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED` after multiple retries;
- `GPUCompiler.framework/Versions/32023` libraries present in WindowServer image list;
- `AppleIntelHD5000GraphicsMTLDriver.bundle` present in WindowServer image list.

This is useful evidence that the newly booted patched snapshot is participating in the graphics/compiler path, but because this is a VESA safety boot and D97HU has not yet executed, it is **not** classified as an accelerated-test result and does not replace the active-snapshot structural audit.

Classification:
`POST_REBOOT_WINDOWSERVER_COMPILER_PATH=REACHED`
`POST_REBOOT_XPC_INTERRUPTION=PROVEN`
`ACCELERATED_TEST_RESULT=NOT_APPLICABLE`
`ACTIVE_SNAPSHOT_P1_P3_STRUCTURAL_PROOF=PENDING_D97HU`.

## Immediate next action
Do not reboot again. Do not rerun Root Patch. Do not change EFI/NVRAM/framebuffer/boot-args.

Rerun the already downloaded exact D97HU helper after verifying the **correct** Git blob:
`2f023cb10d544794e88a06ba58ab7c276f3d060f`.

D97HU remains read-only and its intended gate is unchanged:
1. exact active P1 service;
2. exact active P3-only MTLCompiler32023;
3. P2 original / no P2b;
4. corrected metallibs 180/180;
5. Haswell bundles + AuxKC consistency;
6. official privileged helper exact;
7. D97HO artifact exact.

Expected final remains:
`D97HU_STATUS=PASS_ACTIVE_P1_P3_VESA`
`D97HU_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS_ACTIVE_SNAPSHOT`
`D97HU_NEXT=REVALIDATE_D97EW_CAPTURE_BEFORE_ANY_ACCELERATED_BOOT`
`D97HU_ACCELERATION=NOT_YET_AUTHORIZED`.
