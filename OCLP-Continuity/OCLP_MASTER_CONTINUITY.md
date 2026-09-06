# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DA_EFI_REAUDIT_PASS_D97DB_REPINNED.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

This MASTER is intentionally consolidated around the current frontier. Detailed historical evidence remains in the permanent database, history index, retrospective and checkpoint corpus.

## Mandatory startup order
Before any technical modification:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current machine / goal
- ASUS2: Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current running state unpatched VESA;
- no active Root Patch;
- `-igfxvesa` retained;
- `-ocmcdiag` retained;
- active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- active EFI currently contains D97CT `OCLPMetalCompat.kext` 0.0.2, executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- Lilu `1.7.3` is Kernel/Add index 0;
- AMFIPass `1.4.1` is index 4;
- OCLPMetalCompat is unique Kernel/Add index 5;
- WhateverGreen `1.7.1` is index 30;
- KDKlessWorkaround `1.0.0` is index 31.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this D97CO/D97CT/D97CY development sequence.

## Durable architecture
Pinned Golden OCLP:
- commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Final target remains one native Tahoe Metal image with two logical compiler-generation lanes. Preserve true 3802 selectively; otherwise preserve Tahoe 32023/32024 behavior.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` production repair;
- no pointer-by-pointer standalone ObjC rehabilitation as production mainline;
- no fake canonical Metal file to satisfy BinaryModInfo prelookup;
- no functional D97BV page write until runtime timing/preimage proof passes.

Exact target Metallib package remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Native producer / D97BV retained facts
Native Tahoe Metal `__TEXT` base `0x7FF80F47D000`.
Native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`.
D97BT proved default-environment 3802 suppression to 32023/32024.

D97BV selective adapter remains static-semantic PROVEN:
- exact input 3802 bypasses the Tahoe floor;
- every non-3802 input executes original Tahoe behavior.

D97BV exact locations:
- site `0x7FF80F5E1719 = __TEXT + 0x164719`;
- cave `0x7FF80F47E560 = __TEXT + 0x1560`.

Bytes:
- site original `3d187d0000b9177d00000f4cc1`;
- site replacement `3dda0e00007406e93bcee9ff90`;
- cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

D97BV remains unapplied.

## Standalone Metal production path CLOSED
D97CI/D97CJ proved broad cache-origin Objective-C relocation state in extracted standalone Metal.
Authoritative closure:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Production direction preserves native Tahoe Metal/Metal4 inside the dyld shared cache and uses a separate OCLP-specific Lilu plugin. Lilu itself and WhateverGreen are not modified.

## D97CL / D97CM / D97CN substrate closure
D97CL proved ASUS2 runtime substrate: Haswell AVX2, Lilu `1.7.3`, WhateverGreen `1.7.1`, expected Cryptex x86_64h cache plus map, no relevant Lilu user-patcher blockers.

D97CM proved Lilu map/parser obtains exact native Metal `__TEXT`, but standard BinaryModInfo is blocked because canonical standalone Metal is absent. Lilu general substrate remains positive.

D97CN exact native-cache page topology PASS:
- returned ZIP SHA256 `a468b57ed1bb0917790c803848e084f67aecabf2ad18ccc8893d7f325bef24ea`;
- TXT SHA256 `fe0b48280d08a6b77dae03acd67a720770663e1cdb3c95c1fae2b1b46bed0b6e`;
- embedded report SHA256 `c17b8ac6598e86688b19c3a22ccdcbc28bd12204a0ae7cbc376195a5b791303e`.

Main cache UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`, mapping 0 r-x.
Site page `0xF5E1000`, in-page `0x719`, exact 13-byte preimage PASS.
Cave page `0xF47E000`, in-page `0x560`, 208-byte zero cave PASS, 18-byte future window zero PASS.
Classification: `D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

## D97CO / D97CR / D97CS observation-channel closure
D97CO 0.0.1 compile/binary audit PASS and observe-only proof remain authoritative. Executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.

D97CR first VESA diagnostic boot proved exact D97CO runtime load but unified-log markers were absent:
- `D97CR_D97CO_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CR_UNIFIED_LOG_MARKER_CHANNEL=INCONCLUSIVE`;
- `D97CR_D97CO_RUNTIME_TIMING=UNPROVEN`.

D97CS proved the plugin IOKit lifecycle: active `OCLPMetalCompat`, `IOMatchedAtBoot=Yes`, `VersionInfo=DBG-001-2026-09-06`.
Classification: `D97CS_OCLPMETALCOMPAT_IOKIT_LIFECYCLE=RUNTIME_PROVEN`.
Persistent IORegistry became the preferred runtime evidence channel.

## D97CT / D97CV / D97CW / D97CX closure
D97CT 0.0.2 moved evidence into persistent IORegistry and remained observe-only.
Returned build `OCLP7_D97CT_IMAC_BUILD_20260906_190411.zip` SHA256 `1e32326568f22abfc42020de0530babb8459a72557fc789f2143869012e1125f`.
Compiled D97CT executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`, UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`.
Audited deploy package SHA256 `d033c3195fa9bd098e4e1d080c59d09609269c7691d5ac6399c74fecc9cdee1e`.

D97CV re-audited an earlier current EFI state after OpenCore/OCLP update:
- config SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`;
- `BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`;
- Kernel/Add count 37; Lilu index 0; OCLPMetalCompat then at index 2; boot args preserve `-igfxvesa -ocmcdiag`.

D97CW replaced only D97CO with D97CT in EFI and preserved that config byte-identically. Old D97CO backup: `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CO-20260906_192422.bak`.

D97CX runtime proved:
- D97CT 0.0.2 loaded;
- IORegistry persistent channel works;
- `BootArgGate=1`, `KernelGate=1`;
- `BuildGate=2` because early `sysctlbyname("kern.osversion")` returned false;
- CPU gate not reached;
- `_cs_validate_page` route not attempted;
- site/cave timing therefore remains untested.

Classifications:
- `D97CX_D97CT_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CX_D97CT_IOREG_PERSISTENT_CHANNEL=PROVEN`;
- `D97CX_EARLY_SYSCTL_BUILD_GATE_IMPLEMENTATION=NEGATIVE`;
- `D97CX_CS_VALIDATE_PAGE_ROUTE=NOT_ATTEMPTED`;
- `D97CX_SITE_CAVE_RUNTIME_TIMING=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97CY 0.0.3 — exact-build gate repair compile/audit PASS
D97CY replaces the failed early sysctl gate with direct kernel-global `osversion[]` comparison to `25G82`, performed inside the Lilu patcher-load callback immediately before route installation.

D97CY v2 source:
- `OCLP7_D97CY_kern_start_v2.cpp`;
- SHA256 `1fb91340c3fbfe4fab6dfffcad8df96c3576c39f4b3b23f46894c24e45b4884f`.

First D97CY source revision failed compile only because `libkern/version.h` conflicted with Lilu's existing C++ linkage declarations for `version_major/version_minor`. D97CY v2 removes that header and declares only `extern "C" char osversion[];`.

Returned build:
- `OCLP7_D97CY_IMAC_BUILD_20260906_195136.zip`;
- bytes `53587`;
- SHA256 `ce9f364ce05f41d189d812aae869bf1037e08b61036b50dd58f94aec20227084`.

Independent audit:
- manifest mismatches 0;
- Lilu build PASS;
- plugin build PASS;
- build errors 0;
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.3`;
- UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`;
- executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- built Info.plist SHA256 `0c175c6c83c0d086e14da8be22e6233efdf2e95b1eb6e862294841d53c53954d`;
- Lilu dependency `1.7.3`;
- `D97CYBuildGateMethod`, `D97CYObservedBuild`, `kernel-global-osversion-v1`, `25G82` and persistent D97CT observation properties present;
- `sysctlbyname`, write/injection symbols and D97BV functional replacement payloads absent.

Audited deploy package:
- `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip`;
- SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`;
- manifest SHA256 `5a6c0f1c8546ecf32efff8b6b814a184aefe63e1838df0a747cc01d57c575768`.

Classifications:
- `D97CY_LOCAL_COMPILE=PASS`;
- `D97CY_MANIFEST_AUDIT=PASS`;
- `D97CY_COMPILED_OBSERVE_ONLY_NO_FUNCTIONAL_PAGE_MUTATION=PASS`;
- `D97CY_EXACT_BUILD_GATE_RUNTIME=UNTESTED`;
- `D97CY_CS_VALIDATE_PAGE_ROUTE_RUNTIME=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97DA — latest full EFI re-audit PASS
D97DA is the current active-EFI authority before D97CY deployment.
Returned report: `OCLP7_D97DA_CURRENT_EFI_FULL_REAUDIT_20260906_200508.txt`.

Current config:
- SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- plist validation PASS.

OpenCore core files remain unchanged:
- `BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`.

Kernel/Add current ordering:
- count 37;
- Lilu index 0, version 1.7.3;
- AMFIPass index 4, version 1.4.1;
- OCLPMetalCompat unique index 5, enabled, Darwin 25 only;
- WhateverGreen index 30, version 1.7.1;
- KDKlessWorkaround index 31, version 1.0.0.

Current OCLPMetalCompat remains exact D97CT 0.0.2:
- executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- Info.plist SHA256 `b386aded0a0d2a4490916f32236e22c2c38056638546c546153a5d7371ea4d8d`.

Boot args still contain `-igfxvesa -ocmcdiag`; Lilu disable/slow/user-off bootargs are absent.
All enumerated UEFI Driver and ACPI Add files are present.

D97DA collector note: reported `UUID=24` fields are a formatting bug in the collector's `otool` parsing and are not treated as UUID evidence. Executable SHA256 values are authoritative.

Classification:
`D97DA_CURRENT_EFI_FULL_REAUDIT=PASS_READ_ONLY`.

## D97DB — D97CY deploy repinned to D97DA
Prior D97CZ is superseded and must not be used.
Prepared replacement:
- `OCLP7_D97DB_D97CY_EFI_REPLACE_REPINNED.sh`;
- SHA256 `39c4819608d7a5c05cedcdd9de0a06839a123b6d131bfc4e91230fe79e71b839`;
- `bash -n` PASS.

D97DB is pinned to current config SHA `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`, OCLPMetalCompat index 5, exact current D97CT executable, exact audited D97CY executable/package, Lilu 1.7.3 at index 0, and required VESA diagnostic bootargs.
It modifies only `EFI/OC/Kexts/OCLPMetalCompat.kext`, backs up D97CT, leaves config unchanged, does not Root Patch and does not reboot.

## CURRENT ACTION
On ASUS2 only:
1. keep active EFI mounted at `/Volumes/EFI`;
2. place `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip` and `OCLP7_D97DB_D97CY_EFI_REPLACE_REPINNED.sh` in `~/Downloads`;
3. run D97DB once;
4. return the generated Desktop D97DB report to ChatGPT;
5. do not reboot until that report is audited.

No Root Patch, accelerated boot or functional shared-cache mutation is authorized.
