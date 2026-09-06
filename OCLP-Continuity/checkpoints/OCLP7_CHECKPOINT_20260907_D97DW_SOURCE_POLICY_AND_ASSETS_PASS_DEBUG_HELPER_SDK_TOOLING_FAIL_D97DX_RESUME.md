# OCLP7 CHECKPOINT — D97DW source policy/assets PASS; debug-helper SDK tooling fail; D97DX resume

Date: 2026-09-07 EEST

## Returned iMac build run
User ran the GitHub-pinned D97DW authority on the authorized Intel iMac build host.

## Proven PASS before failure
- D97DW authority Git blob `9d8c8ddc25a1359af0192e657fddd6765015f984` verified.
- Base D97DU authority Git blob `ceed3890b5d35efbefc38ebf1a40f358884e58b9` verified.
- Python pinned successfully to `Python 3.13.15` at `/usr/local/bin/python3.13` on x86_64.
- build-host MetallibSupportPkg requirement removed PASS.
- build-host official-helper requirement removed PASS.
- target helper save/restore policy PASS.
- exact OCLP base commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e` checked out.
- exact Pyquick `26.6.2-25G82/sys_patch_dict.py` checksum PASS.
- D97DU source policy applied PASS.
- exact Tahoe metallib entry count = 182.
- changed tracked files are bounded to:
  1. `OpenCore-Patcher-GUI.spec`
  2. `opencore_legacy_patcher/support/metallib_handler.py`
  3. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
  4. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`
- isolated Python environment dependency install completed.
- Python syntax PASS.
- synthesized Tahoe LegacyMetal3802 patch dictionary PASS:
  - whole `Metal.framework` donor count 0;
  - `MetalOld.dylib` count 0;
  - main legacy Metal binary install count 0;
  - XPC-only legacy Metal ingress PASS;
  - private compiler lanes PASS;
  - exact 25G82 metallib entry count 182.
- PatcherSupportPkg asset regeneration PASS.
- exact `Universal-Binaries.dmg` SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7` PASS.
- generated `payloads.dmg` SHA256 `e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b`.

## Failure classification
Build stopped at DEBUG privileged-helper compilation:
`main.m:13:9: fatal error: 'Foundation/Foundation.h' file not found`.

Exact b9df76 helper Makefile invokes plain:
`clang -framework Foundation -framework Security -arch x86_64 -arch arm64 -mmacosx-version-min=10.9 ...`
without an explicit SDK/sysroot.

This is classified as a BUILD TOOLING/SDK DISCOVERY failure only. It occurred after the functional Root Patch policy and PatcherSupportPkg asset gates had already passed. No Root Patch, EFI mutation, system root mutation, or reboot occurred.

## D97DX direction
Do not rerun clone/dependency installation.
Reuse the exact existing worktree:
`~/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82`

D97DX must:
1. re-verify exact HEAD and bounded source diff;
2. re-verify exact Pyquick patchdict, Universal-Binaries, payloads.dmg, Python 3.13 x86_64, and synthesized native-Metal-safe patch dictionary;
3. resolve macOS SDK with `xcrun --sdk macosx --show-sdk-path`;
4. verify Foundation and Security SDK headers exist;
5. compile DEBUG privileged helper x86_64-only with explicit `-isysroot` against that SDK;
6. ad-hoc sign and verify helper;
7. continue the D97DU/D97DW application build and target-side official-helper save/restore wrapper assembly;
8. run no Root Patch and no reboot.

## Current authorization
- D97DX iMac build resume: authorized.
- Root Patch on ASUS2: still NOT authorized until returned D97DX build artifacts are independently audited.
- removal of `-igfxvesa`, accelerated boot, or reboot into root-patched state: NOT authorized.
