# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`
Current build checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DW_SOURCE_POLICY_AND_ASSETS_PASS_DEBUG_HELPER_SDK_TOOLING_FAIL_D97DX_RESUME.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`
Current resume authority: `OCLP-Continuity/artifacts/OCLP7_D97DX_IMAC_RESUME_BUILD.sh`
Current pinned bootstrap: `OCLP-Continuity/artifacts/OCLP7_D97DX_IMAC_RESUME_BOOTSTRAP.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- current boot mode VESA; `-igfxvesa` retained;
- `-ocmcdiag` present;
- full D97BV arg `-ocmcd97bv` present;
- active `OCLPMetalCompat.kext` = D97DL 0.0.7;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- no active Root Patch.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV / D97DT runtime closure
D97DT remains FULL VESA PAIR PASS on exact Tahoe 25G82:
- exact D97DL 0.0.7 loaded;
- functional mode ACTIVE;
- route/build 25G82 PASS;
- same PID mapped CAVE then SITE;
- CAVE exact replacement, tail zero, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- SITE cave-prereq PASS, exact replacement, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- D97DR separately proved cross-process CAVE visibility.

Therefore the selective-3802 adapter delivery mechanism is CLOSED PASS under VESA.

## D97DU — native-Metal-safe Root Patch baseline
Exact source baseline:
- OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Tahoe-only functional policy:
- `detect.py`: host max Sequoia -> Tahoe;
- `metallib_handler.py`: exact local host-build MetallibSupportPkg before API;
- `metal_3802.py`:
  - Common installs only legacy `MTLCompilerService.xpc` into native Metal.framework plus private compiler lanes;
  - Extended retains CoreImage/RenderBox/private compiler compatibility but NO whole `Metal.framework` donor;
  - exact 25G82 Pyquick metallib map, 182 entries;
  - upstream behavior preserved off Tahoe;
- packaging-only `OpenCore-Patcher-GUI.spec`: x86_64.

Forbidden in synthesized Tahoe patch dictionary:
- whole `/System/Library/Frameworks/Metal.framework` donor;
- donor `13.2.1-24/Metal.framework`;
- `MetalOld.dylib`;
- donor main `Versions/A/Metal`;
- true-five reapplication.

## D97DW returned build run — functional policy and assets PASS
Returned iMac output proved:
- authority/base Git identities PASS;
- Python `3.13.15` x86_64 PASS;
- exact b9df76 checkout PASS;
- exact Pyquick 25G82 patchdict PASS;
- source delta bounded to 3 functional files + x86_64 packaging spec;
- Python syntax PASS;
- synthesized Tahoe patch dictionary PASS;
- whole Metal donor count 0;
- `MetalOld.dylib` count 0;
- main legacy Metal install count 0;
- XPC-only legacy ingress PASS;
- private compiler lanes PASS;
- exact 25G82 metallib entry count 182;
- exact Universal-Binaries SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7` PASS;
- generated payloads.dmg SHA256 `e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b` PASS.

D97DW then stopped only while compiling the DEBUG privileged helper because exact b9df76 Makefile invokes plain `clang -framework Foundation -framework Security ...` without explicit macOS SDK/sysroot and the build host no longer exposes Foundation headers through `/System/Library/Frameworks`.

Classification:
`D97DW_ROOTPATCH_POLICY=PASS`
`D97DW_PATCHER_SUPPORT_ASSETS=PASS`
`D97DW_DEBUG_HELPER_FAILURE=BUILD_TOOLING_SDK_DISCOVERY_ONLY`

No Root Patch, EFI mutation, system root mutation, or reboot occurred.

## D97DX — current resume authority
Checkpoint commit: `ab7f0b074745f776cb18c6039da55eb1041277c3`.
Resume authority commit: `b476b755c95eaf9e6cc2bed967b9650e72fbc907`.
Resume authority Git blob: `b9a2f673bcd382df6d4f2282ad4d6a588fde0b51`.
Pinned bootstrap commit: `c14e230cafe6deaf0f00acacba4b19dfd4250286`.

D97DX does NOT reclone and does NOT reinstall requirements. It reuses:
`~/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82`

D97DX must re-pin all already-proven identities and then:
- resolve macOS SDK with `xcrun --sdk macosx --show-sdk-path`;
- verify exact Foundation/Security SDK headers;
- compile DEBUG helper x86_64-only with explicit `-isysroot`;
- ad-hoc sign and verify helper;
- continue x86_64 application build;
- assemble target wrapper with target-side exact official-helper backup/restore policy;
- bundle no official helper from the iMac.

## NEXT ACTION
Run only the pinned D97DX resume bootstrap on the authorized Intel iMac build host.
If it stops, return exact output and do not repair manually.
If it completes, return:
- `OpenCore-Patcher-Tahoe-D97DX.zip`;
- `OCLP7_D97DX_IMAC_RESUME_REPORT.txt`;
- `OCLP7_D97DX_b9df76_NATIVE_METAL_SAFE.patch`.

After independent audit of returned D97DX artifacts, manual Root Patch on ASUS2 may be separately authorized.

Still NOT authorized:
- Root Patch now;
- removal of `-igfxvesa`;
- accelerated boot;
- any reboot into a new root-patched/accelerated configuration.
