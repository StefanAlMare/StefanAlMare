# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`
Current Root Patch authorization checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DY_D97DX_ARTIFACT_AUDIT_PASS_ROOTPATCH_AUTHORIZED.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- current boot mode VESA; `-igfxvesa` retained;
- `-ocmcdiag` present;
- full D97BV arg `-ocmcd97bv` present;
- active `OCLPMetalCompat.kext` = D97DL 0.0.7;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- no active Root Patch yet.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication.

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

## D97DX native-Metal-safe Root Patch build — PASS
Exact source baseline:
- OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Exact tracked delta is four files only:
1. `OpenCore-Patcher-GUI.spec` — x86_64 packaging only;
2. `opencore_legacy_patcher/support/metallib_handler.py` — exact local host-build MetallibSupportPkg before API;
3. `opencore_legacy_patcher/sys_patch/patchsets/detect.py` — host max Sequoia -> Tahoe;
4. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py` — Tahoe-native-Metal-safe 3802 policy.

Tahoe policy:
- Common: inject only `MTLCompilerService.xpc` under native Metal.framework plus private MTLCompiler/GPUCompiler lanes;
- Extended: CoreImage/RenderBox/private compiler compatibility only; NO whole `Metal.framework` donor;
- exact Pyquick 25G82 metallib map, 182 entries;
- upstream behavior preserved off Tahoe;
- no `MetalOld.dylib`;
- no main legacy `Versions/A/Metal` donor;
- no true-five.

D97DX build identities:
- patchdict SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- Universal-Binaries SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- payloads.dmg SHA256 `e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b`;
- DEBUG helper x86_64 SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- inner OCLP x86_64 executable SHA256 `986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11`;
- source diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- ZIP bytes `722858206`;
- ZIP SHA256 `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- `D97DX_BUILD_STATUS=PASS`.

## D97DY local artifact audit — PASS with collector false-negative after decisive gates
Returned D97DY report proved before its optional re-synthesis step:
- ZIP SHA/size PASS;
- local inner executable SHA/arch PASS;
- local DEBUG helper SHA/arch PASS;
- desktop source diff == embedded patch byte-for-byte;
- codesign gates PASS;
- official helper not bundled PASS;
- launcher exact official helper SHA/team pin PASS;
- launcher pre-swap verification, backup, temporary DEBUG install, explicit restore and post-restore verification PASS;
- launcher has no NVRAM, bless, reboot, shutdown, or Root Patch automation path;
- embedded audit contract PASS.

The collector then stopped with `ModuleNotFoundError: No module named 'opencore_legacy_patcher'` because the optional re-synthesis invocation lacked worktree cwd/PYTHONPATH. This is classified `TOOLING_FALSE_NEGATIVE`, not build failure.

Independent direct source-diff audit closed the same remaining gate without another user run:
- uploaded diff SHA exact match `c8b45d7f...`;
- exact four-file changed set;
- metallib map = 139 parent destinations / 182 file entries;
- no duplicate map keys;
- 180 DynamicPatchset entries + 2 donor `14.6.1` entries;
- zero `MetalOld.dylib`;
- zero `13.2.1-24/Metal.framework`;
- only bounded Metal.framework additions are XPCServices path and Resources metallib path.

Pyquick release `26.6.2-25G82` independently confirms:
- `sys_patch_dict.py` digest `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- MetallibSupportPkg digest `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

D97DY/D97DX Root Patch authorization checkpoint commit: `abc1f2dfa062c5b87d7d2b330b8f0b6fd315f75c`.

## CURRENT ACTION — MANUAL ROOT PATCH AUTHORIZED
Manual Root Patch on ASUS2 is now authorized using ONLY the exact D97DX outer app/wrapper.

Execution contract:
1. transfer `OpenCore-Patcher-Tahoe-D97DX.zip` locally from iMac to ASUS2 (network/USB/NAS is fine; chat upload is not required);
2. unzip on ASUS2 and launch the OUTER `OpenCore-Patcher-Tahoe-D97DX.app`, never the inner app directly;
3. outer launcher must pass exact current official helper identity before any swap;
4. exact local `MetallibSupportPkg/26.6.2-25G82` must be available to inner OCLP; if OCLP reports it missing or resolves an unexpected donor, STOP and return output;
5. user may run manual Root Patch;
6. retain `-igfxvesa -ocmcdiag -ocmcd97bv` throughout this Root Patch cycle;
7. after patch completes, CLOSE inner OCLP so outer wrapper restores and verifies the official helper;
8. DO NOT reboot yet; return complete Root Patch output/status for audit.

Authorized now:
`D97DX_MANUAL_ROOT_PATCH_ON_ASUS2=YES`.

Still NOT authorized:
- removal of `-igfxvesa`;
- accelerated/non-VESA boot;
- reboot after Root Patch before post-patch audit;
- Golden mutation;
- any legacy main Metal shadow;
- true-five reapplication.
