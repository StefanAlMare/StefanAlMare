# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CW_D97CT_DEPLOY_PASS_IOREG_RUNTIME_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

This MASTER is intentionally consolidated around the current frontier. Detailed historical evidence remains in the permanent database, history index, retrospective, and checkpoint corpus.

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
- active EFI now contains D97CT `OCLPMetalCompat.kext` 0.0.2, persistent-IORegistry observe-only build.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local compilation remains explicit-authorization-only; user authorized the iMac 9900K build host for this D97CO/D97CT development sequence.

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
D97CL proved ASUS2 runtime substrate:
- Haswell AVX2;
- Lilu `1.7.3`;
- WhateverGreen `1.7.1`;
- no `-liluuseroff` / `-liluslow`;
- exact Cryptex `dyld_shared_cache_x86_64h` + map;
- native Metal present in map.

D97CM proved Lilu map/parser obtains exact native Metal `__TEXT`, but standard BinaryModInfo is blocked because canonical standalone Metal is absent. Lilu general substrate remains positive.

D97CN exact native-cache page topology PASS:
- returned ZIP SHA256 `a468b57ed1bb0917790c803848e084f67aecabf2ad18ccc8893d7f325bef24ea`;
- TXT SHA256 `fe0b48280d08a6b77dae03acd67a720770663e1cdb3c95c1fae2b1b46bed0b6e`;
- embedded report SHA256 `c17b8ac6598e86688b19c3a22ccdcbc28bd12204a0ae7cbc376195a5b791303e`.

Main cache UUID `5235B75A-6BDF-39F7-BAB8-A0AAD80EBFFA`, mapping 0 r-x.
Site page `0xF5E1000`, in-page `0x719`, exact 13-byte preimage PASS.
Cave page `0xF47E000`, in-page `0x560`, 208-byte zero cave PASS, 18-byte future window zero PASS.

Classification:
`D97CN_CS_VALIDATE_PAGE_D97BV_STATIC_TOPOLOGY=PASS`.

## D97CO runtime observations
D97CO 0.0.1 compile/binary audit PASS and observe-only proof remain authoritative.
Executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`.

D97CR first VESA diagnostic boot proved exact D97CO runtime load but unified-log markers were absent.
Classifications:
- `D97CR_D97CO_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CR_UNIFIED_LOG_MARKER_CHANNEL=INCONCLUSIVE`;
- `D97CR_D97CO_RUNTIME_TIMING=UNPROVEN`.

D97CS then proved the plugin's IOKit lifecycle in the same runtime family:
- `OCLPMetalCompat` service active;
- `IOMatchedAtBoot=Yes`;
- `VersionInfo=DBG-001-2026-09-06`.

Classification:
`D97CS_OCLPMETALCOMPAT_IOKIT_LIFECYCLE=RUNTIME_PROVEN`.

Therefore logging, not plugin startup, was the unresolved observation channel.

## D97CT persistent IORegistry observe-only build
D97CT moves evidence from early logging into persistent IORegistry properties.
The `_cs_validate_page` wrapper still calls Apple first and never modifies validation-page bytes. Callback state is atomic; asynchronous publisher exposes it through the proven `OCLPMetalCompat` IORegistry service.

Authorized D97CT v2 source SHA256:
`74a0ba83e7da9875ed150b9413f2716fda1e81fd47d74a8d2911eae7fae0a561`.

Returned build:
`OCLP7_D97CT_IMAC_BUILD_20260906_190411.zip`
- bytes `53555`;
- SHA256 `1e32326568f22abfc42020de0530babb8459a72557fc789f2143869012e1125f`.

Compiled D97CT 0.0.2:
- UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`;
- executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- built Info.plist SHA256 `b386aded0a0d2a4490916f32236e22c2c38056638546c546153a5d7371ea4d8d`;
- Lilu dependency `1.7.3`.

Independent audit:
- Lilu build PASS;
- plugin build PASS;
- manifest mismatches 0;
- D97CT persistent property strings present;
- D97BV functional replacement bytes absent;
- no shared-cache write/injection path.

Audited deploy package:
`OCLP7_D97CT_AUDITED_DEPLOY_20260906.zip`, SHA256 `d033c3195fa9bd098e4e1d080c59d09609269c7691d5ac6399c74fecc9cdee1e`.

Classification:
`D97CT_COMPILED_PERSISTENT_IOREG_OBSERVE_ONLY=PASS`.

## Current EFI after OpenCore/OCLP update — D97CV
User updated OpenCore/OCLP before D97CT deployment, invalidating the previous config hash by design.
Read-only D97CV re-audit established current active EFI:
- config SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`;
- `BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`;
- Kernel/Add count `37`;
- Lilu index `0`, version `1.7.3`;
- OCLPMetalCompat unique index `2`;
- boot args preserve `-igfxvesa -ocmcdiag`;
- D97CO 0.0.1 binary identity unchanged before replacement.

Classification:
`D97CV_CURRENT_EFI_REAUDIT=PASS_READ_ONLY`.

## D97CW — D97CT deployed into current EFI
Returned report `OCLP7_D97CW_D97CT_EFI_REPLACE_20260906_192422.txt`.

All identity/config/ordering gates passed.
Old D97CO backup:
`/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CO-20260906_192422.bak`.

Active kext is now D97CT 0.0.2:
- executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- Lilu dependency `1.7.3`.

Config was not modified and remains SHA256:
`cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`.

Classification:
`D97CW_D97CT_IDENTITY_PINNED_EFI_REPLACE=PASS`.

## CURRENT ACTION
One manual **VESA-only D97CT diagnostic reboot** is authorized.

Before reboot:
1. no further EFI/config/kext changes;
2. retain `-igfxvesa` and `-ocmcdiag`;
3. no Root Patch.

After the VESA desktop returns, collect D97CT persistent IORegistry state.
Success criteria:
- exact D97CT 0.0.2 loaded;
- `D97CTRouteStatus=PASS`;
- `D97CTSiteSeenCount > 0` and `D97CTSitePreimage=PASS`;
- `D97CTCaveSeenCount > 0`, `D97CTCaveWindow18=PASS`, `D97CTCaveFull208=PASS`;
- record Apple's site/cave `validated/tainted/nx` values.

Only if this runtime timing/preimage proof passes may a separately designed and separately authorized functional D97BV page-write build be considered.

No Root Patch, accelerated boot, or functional shared-cache mutation is authorized by this MASTER.
