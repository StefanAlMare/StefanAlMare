# OCLP7 CHECKPOINT — D97FZ post-revert VESA gate STOP: D97EZ active after reboot

Date: 2026-09-07 EEST

## Entering authority
- D97FY final pre-Root-Patch gate passed completely before APFS Root Patch revert.
- Corrected local 25G82 MetallibSupportPkg source remains exact from D97FX: 180/180 regular metallibs are real MTLB payloads and CoreDisplay default.metallib SHA256 is `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`.
- User then performed Root Patch revert and rebooted back toward VESA per the authorized sequence.

## Returned D97FZ report
File:
`OCLP7_D97FZ_POST_REVERT_VESA_GATE_20260907_221113.txt`

Observed system:
- macOS 26.6.2 / 25G82;
- x86_64.

Observed boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh -ocmcd97ez`

D97FZ stopped immediately with:
- `D97FZ_STATUS=FAIL`;
- `D97FZ_REASON=D97EZ_ACTIVE_MODE_MUST_BE_INERT`.

## Comparison to D97FY
Immediately before revert, D97FY proved VESA with D97EZ ACTIVE mode absent/inert.
After the revert reboot, exact `-ocmcd97ez` is active.

This is a gate-state divergence. It does NOT prove Root Patch revert failed; D97FZ terminated before auditing the installed root, CoreDisplay file, stub removal, Haswell kext state or official helper state.

Classification:
- `D97FZ_VESA_BOOT=REACHED`;
- `D97FZ_D97EZ_ACTIVE_AFTER_REVERT_REBOOT=NEGATIVE`;
- `D97FZ_POST_REVERT_ROOT_STATE=UNKNOWN` because the gate stopped before that section;
- `D97FZ_ROOT_PATCH_AUTHORIZATION=NO`;
- no corrected Root Patch is authorized yet.

## Current action
Do not run Root Patch.
First verify read-only that the loaded OCLPMetalCompat identity still matches the authorized D97EZ 0.0.12 EFI/runtime build and that no broader EFI drift is apparent.
Then make only the manual boot-arg state correction required to render `-ocmcd97ez` absent/inert, reboot once into the same VESA configuration, and rerun the unchanged D97FZ gate.

Do not alter any other EFI setting, NVRAM policy, framebuffer setting, Root Patch content or Golden state.