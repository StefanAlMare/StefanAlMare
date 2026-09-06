# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`
Current build checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DU_IMAC_PREFLIGHT_FALSE_BLOCKER_D97DV_READY.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`
Current build authority helper: `OCLP-Continuity/artifacts/OCLP7_D97DU_IMAC_NATIVE_METAL_SAFE_BUILD.sh`
Current corrected build launcher: `OCLP-Continuity/artifacts/OCLP7_D97DV_IMAC_BUILD_AUTHORITY_V2.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- current boot mode: VESA (`-igfxvesa` retained);
- diagnostic route `-ocmcdiag` present;
- full D97BV boot arg `-ocmcd97bv` present;
- active kext D97DL `OCLPMetalCompat.kext` 0.0.7;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- no active Root Patch yet.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions remain:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV exact adapter semantics
Static semantics remain PROVEN:
- exact `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97DT — FULL VESA PAIR PASS
Returned ZIP `OCLP7_D97DT_D97DL_FULL_VESA_PAIR_20260907_005133.zip`:
- SHA256 `48f1e5940cb0e6806e4231b50380210193d9bab8b09c7d0b1b0d16044c64cc0b`.

Runtime closure:
- exact D97DL 0.0.7 loaded;
- `D97DIFunctionalMode=ACTIVE`;
- route/build 25G82 PASS;
- same PID mapped CAVE then SITE;
- CAVE exact replacement, tail zero, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- SITE cave-prereq PASS, exact replacement, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- D97DR had already proved direct cross-process visibility of the CAVE postimage;
- `D97DT_FULL_VESA_PAIR_GATE=PASS`.

Therefore the exact D97BV selective-3802 runtime delivery mechanism is CLOSED PASS under VESA on exact Tahoe 25G82.

## D97DU — ROOT PATCH BASELINE
D97DU replaces the unsafe D97BJ Root Patch policy with a Tahoe-native-Metal-safe patcher.

Exact source baseline:
- OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Tahoe-only functional policy:
- `detect.py`: host max Sequoia -> Tahoe;
- `metallib_handler.py`: exact local host-build MetallibSupportPkg before API;
- `metal_3802.py`:
  - Common installs only legacy `MTLCompilerService.xpc` into native Metal.framework plus private 3802 compilers;
  - Extended retains CoreImage/RenderBox/private compiler compatibility but has NO whole `Metal.framework` donor;
  - exact 25G82 Pyquick metallib map, 182 entries;
  - upstream behavior preserved off Tahoe.
- packaging-only `OpenCore-Patcher-GUI.spec`: x86_64.

Forbidden in synthesized Tahoe patch dictionary:
- whole `/System/Library/Frameworks/Metal.framework` donor;
- donor `13.2.1-24/Metal.framework`;
- `MetalOld.dylib`;
- donor main `Versions/A/Metal`;
- true-five reapplication.

D97DU design commit: `a9521b0985bf74e9020d35c271d78f5259c62cb8`.
D97DU build helper commit: `d8faeb3b108e57f35ee9576a8cbf1f7149c7bc9b`.
D97DU build helper Git blob: `ceed3890b5d35efbefc38ebf1a40f358884e58b9`.

## D97DU first iMac build attempt — fail-closed preflight only
The first bootstrap verified exact helper identity and `bash -n`, then stopped before clone/build because the helper incorrectly required exact 25G82 MetallibSupportPkg on the iMac build host.
The same output showed `/usr/local/bin/python3` = Python 3.14.7 was selected, although proven D97BJ packaging lineage used Python 3.13.x.

No Root Patch, EFI mutation, system patch mutation or reboot occurred.

## D97DV corrected build-host launcher
Persisted:
`OCLP-Continuity/artifacts/OCLP7_D97DV_IMAC_BUILD_AUTHORITY_V2.sh`

Identity:
- commit `551a97d09c3f5e1ea02ae2e695e81764e388d43a`;
- Git blob `e7a69e0b8e2c637f4d04ab209bc8eaf5a5dc8357`.

D97DV applies only two local build-host corrections to the exact D97DU authority helper:
1. exact 25G82 MetallibSupportPkg is recorded as target-ASUS2 Root Patch input and is no longer required on the iMac build host;
2. build interpreter is constrained to exact x86_64 Python 3.13.x, searching the preserved D97BJ worktree/venv first; Python 3.14 is rejected.

D97DU native-Metal-safe Root Patch policy is otherwise unchanged.

## NEXT ACTION
Run D97DV on the authorized Intel iMac build host.
If exact x86_64 Python 3.13.x is absent, stop and return output; do not install/change Python manually.
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
