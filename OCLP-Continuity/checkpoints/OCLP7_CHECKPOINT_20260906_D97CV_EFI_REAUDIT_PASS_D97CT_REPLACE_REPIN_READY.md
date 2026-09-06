# OCLP7 CHECKPOINT — 2026-09-06 — D97CV EFI re-audit PASS; D97CT replace repin ready

Authority: supersedes the prior D97CR/D97CS execution state for current EFI identity.

## Current machine
- ASUS2: macOS Tahoe 26.6.2 / 25G82.
- Unpatched VESA; no active Root Patch.
- `-igfxvesa` and `-ocmcdiag` remain present.

## D97CV — current EFI re-audit after OpenCore/OCLP update
Returned report: `OCLP7_D97CV_CURRENT_EFI_REAUDIT_20260906_192009.txt`.

Current active config:
- path `/Volumes/EFI/EFI/OC/config.plist`;
- plist validation PASS;
- new SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`.

OpenCore files:
- `EFI/BOOT/BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`, size 24576;
- `EFI/OC/OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`, size 630784.

Relevant kexts remain:
- Lilu 1.7.3, exec SHA256 `e3f00df5aca98c70363489292514f088ae3b667417c9c5afdd33799ff09390bd`;
- WhateverGreen 1.7.1, exec SHA256 `2b4189a7255c7dc50e9dad9c7cde15d998e1146438c519df2456829285c91b35`;
- AMFIPass 1.4.1, exec SHA256 `4c35bc196d35c69b5f9dca83fe733801211c7828716f51585c7f5450039ca884`;
- current D97CO `OCLPMetalCompat` 0.0.1, exact exec SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.

Kernel/Add:
- total count 37;
- Lilu remains first relevant entry;
- `OCLPMetalCompat.kext` is now at index 2, not index 36;
- entry is enabled, x86_64, MinKernel 25.0.0, MaxKernel 25.99.99;
- executable/plist paths unchanged.

Boot args still include both `-igfxvesa` and `-ocmcdiag`.

Classification:
`D97CV_CURRENT_EFI_REAUDIT=PASS_READ_ONLY`.

## Consequence
The previous D97CU replace script is invalid for this EFI because it pins the old config SHA and old Kernel/Add index 36. It must not be used.

Next bounded action:
- rebuild D97CU replace script pinned to config SHA `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f` and Kernel/Add index 2;
- replace only `EFI/OC/Kexts/OCLPMetalCompat.kext` D97CO 0.0.1 with already-audited D97CT 0.0.2;
- do not mutate `config.plist`;
- no Root Patch, no reboot until post-replace audit returns PASS.
