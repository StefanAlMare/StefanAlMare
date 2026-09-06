# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`
Current build checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DV_HELPER_FALSE_BLOCKER_D97DW_READY.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`
Current base build authority helper: `OCLP-Continuity/artifacts/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.sh`
Current corrected build authority: `OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_V3.sh`
Current pinned bootstrap: `OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_BOOTSTRAP.sh`

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

## Build-host corrections
D97DU first attempt failed closed before build because it incorrectly required exact 25G82 MetallibSupportPkg on the iMac.
D97DV removed that false requirement and pinned Python 3.13 x86_64. Returned D97DV output proved Python `3.13.15` at `/usr/local/bin/python3.13`, then failed closed because it still incorrectly required the exact official privileged-helper restore asset on the iMac.

Historical D97BJ evidence proves that official helper restoration is post-run cleanup, not Root Patch functionality: D97BJ Root Patch had already completed successfully when the DEBUG helper remained installed; reboot was blocked only until official helper restoration.

## D97DW — current build authority
D97DW changes helper logistics only; D97DU Root Patch semantics remain unchanged.

D97DW authority:
- path `OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_V3.sh`;
- commit `738390d5a7dedec8b2d67f43baf6a9ef34c3a084`;
- Git blob `9d8c8ddc25a1359af0192e657fddd6765015f984`;
- syntax check `bash -n=PASS`.

Pinned bootstrap:
- path `OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_BOOTSTRAP.sh`;
- commit `9ac756f949f2843ddfd32d013d7a02550d9ba7c0`.

D97DW build-host policy:
- exact Python 3.13.x x86_64 required;
- no local 25G82 MetallibSupportPkg required on iMac;
- no official helper required or bundled from iMac.

Generated target wrapper policy:
- before any helper swap on ASUS2, require installed helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a` and TeamIdentifier `S74BDJXQMD`;
- save and verify that exact helper locally on ASUS2;
- install DEBUG helper temporarily;
- after custom OCLP exits, explicitly restore and verify the saved official helper;
- trap is secondary restore fallback only.

## NEXT ACTION
Run only the pinned D97DW bootstrap on the authorized Intel iMac build host.
If it stops, return exact output and do not repair manually.
If build completes, return:
- `OpenCore-Patcher-Tahoe-D97DU.zip`;
- `OCLP7_D97DU_IMAC_BUILD_REPORT.txt`;
- `OCLP7_D97DU_b9df76_NATIVE_METAL_SAFE.patch`.

After independent audit of returned build artifacts, manual Root Patch on ASUS2 may be separately authorized.

Still NOT authorized:
- Root Patch now;
- removal of `-igfxvesa`;
- accelerated boot;
- any reboot into a new root-patched/accelerated configuration.
