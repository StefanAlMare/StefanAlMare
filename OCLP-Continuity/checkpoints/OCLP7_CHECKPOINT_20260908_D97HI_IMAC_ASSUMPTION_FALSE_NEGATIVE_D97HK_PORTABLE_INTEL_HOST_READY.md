# OCLP7 CHECKPOINT — 2026-09-08 — D97HI iMac-assumption false negative / D97HK portable Intel host ready

## Event
User attempted D97HI on an Intel MacBook Pro at work instead of the historical Intel iMac.
D97HI stopped immediately with:
`D97HI_STATUS=FAIL`
`D97HI_REASON=WORKTREE_MISSING`.

No Root Patch, system-root, EFI, NVRAM, framebuffer or reboot action occurred.
Classification:
`D97HI_WORKTREE_MISSING=TOOLING_HOST_ASSUMPTION_FALSE_NEGATIVE`.
This is not compiler/Haswell/P3 evidence.

## New build host preflight
Host:
- Intel x86_64;
- macOS 15.7.9 / 24G830;
- CPU Intel Core i9-9880H;
- Xcode at `/Applications/Xcode.app/Contents/Developer`;
- macOS SDK 26.2;
- clang/xcrun/git/curl/shasum/codesign/lipo/ditto/make present;
- `/usr/local/bin/python3.13` = Python 3.13.15 x86_64;
- Homebrew 6.0.21 Intel prefix `/usr/local/bin/brew`;
- approximately 122 GiB free.

Classification:
`PORTABLE_INTEL_MAC_BUILD_HOST=CAPABLE_PREFLIGHT_PASS`.
The permanent safety requirement remains: never compile on ASUS2. Build host need not be the historical iMac if exact source/provenance gates are reconstructed.

## D97HK portable reconstruction authority
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HK_PORTABLE_INTEL_HOST_BOOTSTRAP_AND_D97HI_INNER_BUILD.sh`
- commit `cb878d7a9541f6400c198017931e72eaa7dcf426`;
- Git blob `b3d8022ac3d543fd1fd38fedc14ebab6bd0ccfe8`.

D97HK pins and reuses exact historical authorities:
- D97DU commit `d8faeb3b108e57f35ee9576a8cbf1f7149c7bc9`, blob `ceed3890b5d35efbefc38ebf1a40f358884e58b9`;
- D97GS commit `8f86bfa76282b3b1c5b9aca311e95324406224d5`, blob `b408d8d372ca6956db0caeb2a253df44acd7a5b9`;
- D97HI commit `4ca10b8e9a1b0db046d570bc2e1d2710ab16fa9a`, blob `0bf2e5601f08613d916d1414a5e2561153517ed5`.

Portable chain:
1. clone exact upstream OCLP b9df76 / tree 7c3411...;
2. reconstruct D97DX native-Metal-safe source/asset prep using exact D97DU authority, but deliberately defer target-local MetallibSupportPkg/helper gates;
3. require exact D97DX source diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
4. require Python 3.13 x86_64 venv and exact Universal-Binaries SHA `33b6f11c...`;
5. use exact D97GS authority in source-prep-only mode and require exact D97GS source diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
6. use exact D97HI authority, add only P3, build x86_64 inner OpenCore-Patcher.app;
7. package only `OpenCore-Patcher-Tahoe-D97HI-INNER.zip` for independent audit and later exact wrapper assembly.

No D97GS outer wrapper reconstruction is attempted on the new host. This avoids depending on historical target debug-helper/wrapper assets. Wrapper assembly is deferred until after independent inner audit.

No P2b/AIR00/D34 replay.
No Root Patch/reboot/target mutation is authorized.

## Current action
Run only D97HK on the portable Intel Mac.
After PASS, review exact source diff SHA, inner executable SHA and inner ZIP SHA/bytes before any target transfer or wrapper assembly.
