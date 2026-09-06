# OCLP7 CHECKPOINT — 2026-09-06 — D97CW D97CT deploy PASS; persistent IORegistry runtime boot ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CQ_EFI_DEPLOY_PASS_VESA_RUNTIME_READY.md` for current execution state.

## Current machine
- ASUS2: macOS Tahoe `26.6.2 / 25G82`.
- Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current running mode remains unpatched VESA.
- No active Root Patch.
- `-igfxvesa` remains present.
- `-ocmcdiag` remains present.
- No D97BV functional page mutation is deployed or authorized.

## D97CR — first D97CO runtime boot
Returned `OCLP7_D97CR_D97CO_RUNTIME_20260906_180624.zip`.
- ZIP SHA256 `91209b0dd50cc0b53501c4cc0cc7d8571f3661625d3cebc633477f1cf55bef3b`.
- Inner TXT SHA256 `c83764f2868a066982eeb28106a6f0c9a64d8df221a9527380ea9e706939227c`.
- Boot args contained `-igfxvesa -ocmcdiag`.
- `kmutil showloaded` proved exact D97CO `com.oclpmetalcompat.OCLPMetalCompat 0.0.1` loaded with UUID `319A3777-1BB1-3395-9E7A-6A0426C58723`.
- Lilu `1.7.3` and WhateverGreen `1.7.1` were loaded.
- Unified log returned zero D97CO markers, including route/site/cave and build/inactive markers.

Classifications:
- `D97CR_D97CO_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CR_UNIFIED_LOG_MARKER_CHANNEL=INCONCLUSIVE`;
- `D97CR_D97CO_RUNTIME_TIMING=UNPROVEN`.

Absence of markers is not a runtime-hook NEGATIVE because even plugin-start markers were absent and Lilu's logging path is known to lose/buffer early output.

## D97CS — plugin lifecycle runtime proof
Current-boot read-only command:
`ioreg -r -c OCLPMetalCompat -l -w0`

Observed service:
- class `OCLPMetalCompat`;
- `active`;
- `IOMatchedAtBoot = Yes`;
- `CFBundleIdentifier = com.oclpmetalcompat.OCLPMetalCompat`;
- `VersionInfo = DBG-001-2026-09-06`.

This proves the standard Lilu-plugin IOKit personality/lifecycle started successfully.

Classification:
`D97CS_OCLPMETALCOMPAT_IOKIT_LIFECYCLE=RUNTIME_PROVEN`.

Therefore the missing D97CO markers are an observation-channel problem, not evidence that the kext/plugin failed to start.

## D97CT — persistent IORegistry observe-only design
D97CT replaces volatile early SYSLOG evidence with persistent runtime state:
- `_cs_validate_page` still calls Apple's original validator first;
- callback never writes to the validation page;
- callback records bounded state only into atomics;
- an asynchronous `thread_call` publisher exposes state through the already-proven `OCLPMetalCompat` IORegistry service;
- exact gates remain Tahoe 25G82, Haswell, `-ocmcdiag`, main `/dyld_shared_cache_x86_64h`;
- exact target pages remain site `0xF5E1000` / in-page `0x719` and cave `0xF47E000` / in-page `0x560`.

Persistent properties include:
- `D97CTChannel`;
- `D97CTBootArgGate`, `D97CTKernelGate`, `D97CTBuildGate`, `D97CTCpuGate`;
- `D97CTRouteStatus`;
- `D97CTSiteSeenCount`, `D97CTSitePreimage`, `D97CTSiteValidated`, `D97CTSiteTainted`, `D97CTSiteNX`;
- `D97CTCaveSeenCount`, `D97CTCaveWindow18`, `D97CTCaveFull208`, `D97CTCaveValidated`, `D97CTCaveTainted`, `D97CTCaveNX`;
- `D97CTPublisherTicks`.

## D97CT local compile/audit PASS
First D97CT attempt failed only because `_Atomic uint32_t value {0}` is invalid for the kernel C11 atomic type under the current Clang mode. No target/system mutation occurred. v2 changed all 17 declarations to upstream-compatible `_Atomic(uint32_t) value = ATOMIC_VAR_INIT(0)` and aligned delayed publication with Lilu's own absolute-time pattern.

Authorized v2 source SHA256:
`74a0ba83e7da9875ed150b9413f2716fda1e81fd47d74a8d2911eae7fae0a561`.

Returned v2 build:
`OCLP7_D97CT_IMAC_BUILD_20260906_190411.zip`
- bytes `53555`;
- SHA256 `1e32326568f22abfc42020de0530babb8459a72557fc789f2143869012e1125f`.

Independent audit:
- Lilu build `RC=0`;
- plugin build `RC=0`;
- zero build errors;
- manifest mismatches `0`;
- source in ZIP byte-identical to authorized v2 source;
- D97CT property strings present;
- D97BV site replacement bytes absent;
- D97BV cave replacement bytes absent;
- no `vm_map_write_user`, `orgVmMapWriteUser`, `findAndReplace`, `vmProtect`, `injectPayload`, `injectSegment`, or validation-page write path.

Compiled D97CT kext:
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.2`;
- thin x86_64;
- UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`;
- executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- built Info.plist SHA256 `b386aded0a0d2a4490916f32236e22c2c38056638546c546153a5d7371ea4d8d`;
- Lilu dependency `1.7.3`.

Audited deploy package:
`OCLP7_D97CT_AUDITED_DEPLOY_20260906.zip`
- SHA256 `d033c3195fa9bd098e4e1d080c59d09609269c7691d5ac6399c74fecc9cdee1e`;
- manifest SHA256 `b8e70324a76d9f2e6b461b152aa8a324656b42b55d2c033d42bd0100e7f7a655`.

Classification:
`D97CT_COMPILED_PERSISTENT_IOREG_OBSERVE_ONLY=PASS`.

## D97CV — EFI re-audit after OpenCore/OCLP update
The user updated OpenCore/OCLP before D97CT deployment, so the prior config SHA was intentionally invalidated and a new read-only audit was performed.

Current active EFI facts:
- config path `/Volumes/EFI/EFI/OC/config.plist`;
- config SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`;
- plist valid;
- `BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`;
- boot args still contain `-igfxvesa -ocmcdiag`;
- Kernel/Add count `37`;
- Lilu `1.7.3` is index `0`;
- OCLPMetalCompat is uniquely index `2`, enabled, x86_64, MinKernel `25.0.0`, MaxKernel `25.99.99`;
- D97CO executable remained exact SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`;
- WhateverGreen `1.7.1` and AMFIPass `1.4.1` remain present.

Classification:
`D97CV_CURRENT_EFI_REAUDIT=PASS_READ_ONLY`.

## D97CW — re-pinned D97CT EFI replacement PASS
Returned report:
`OCLP7_D97CW_D97CT_EFI_REPLACE_20260906_192422.txt`.

All identity and semantic gates passed:
- config expected/actual SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`;
- exactly one OCLPMetalCompat entry at index `2`;
- boot args preserve `-igfxvesa -ocmcdiag`;
- Lilu remains index `0`, version `1.7.3`;
- current D97CO executable expected/actual SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`;
- audited D97CT package expected/actual SHA256 `d033c3195fa9bd098e4e1d080c59d09609269c7691d5ac6399c74fecc9cdee1e`;
- new executable expected/actual SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- bundle ID exact, version `0.0.2`, Lilu dependency `1.7.3`;
- staged copy identity PASS.

Replacement:
- old D97CO backed up at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CO-20260906_192422.bak`;
- backup executable SHA256 remains exact old D97CO `6b3534cb...`;
- active `OCLPMetalCompat.kext` is now D97CT 0.0.2 executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- config final SHA256 remains unchanged `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`.

Final report:
`D97CW_STATUS=PASS`.

Classifications:
- `D97CW_D97CT_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97CW_CONFIG_MUTATION=NO`;
- `D97CW_ROOT_PATCH=NO`;
- `D97CW_REBOOT_PERFORMED=NO`.

## CURRENT ACTION
One manual **VESA-only D97CT diagnostic reboot** is now authorized.

Before reboot:
1. make no further EFI/config/kext changes;
2. retain `-igfxvesa` and `-ocmcdiag`;
3. do not Root Patch.

After the desktop returns, collect persistent runtime state from the `OCLPMetalCompat` IORegistry service. The key success criteria are:
- D97CT 0.0.2 actually loaded;
- `D97CTRouteStatus=PASS`;
- site seen count > 0 with `D97CTSitePreimage=PASS`;
- cave seen count > 0 with `D97CTCaveWindow18=PASS` and `D97CTCaveFull208=PASS`;
- record Apple's validated/tainted/nx values for both pages.

Only if these runtime conditions pass may a separately designed and separately authorized functional D97BV page-write build be considered.

No Root Patch, accelerated boot, or functional shared-cache mutation is authorized by this checkpoint.
