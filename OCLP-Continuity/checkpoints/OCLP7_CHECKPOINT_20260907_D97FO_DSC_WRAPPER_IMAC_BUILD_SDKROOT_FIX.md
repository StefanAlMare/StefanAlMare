# OCLP7 D97FO — DSC wrapper Intel-iMac build stopped at missing SDK sysroot / helper fixed

Date: 2026-09-07 EEST

## Input
User ran the authorized Intel-iMac D97FN build helper on host macOS 26.6.2 / 25G83, x86_64, full Xcode clang path:
`/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++`.

Pinned wrapper source authority remained exact:
- source commit `524467d3f41166f58e75a39d003ae79eedf71d7e`;
- expected/actual Git blob `08aca87f551cf9dbd2d12974d58f81e7de2495c9` PASS.

## Failure
Compilation stopped before producing any binary:
`fatal error: 'dlfcn.h' file not found`.

This is a build-helper environment/toolchain invocation failure, not a wrapper source-semantic failure and not a runtime/ASUS2 failure.

The helper located full Xcode clang but did not pass the active macOS SDK sysroot explicitly.

Classification:
- wrapper source identity PASS;
- compile REACHED_NEGATIVE at header resolution;
- produced binary NONE;
- deployment NONE;
- ASUS2 mutation NONE;
- runtime frontier unchanged.

## Fix
Authoritative helper path remains:
`OCLP-Continuity/artifacts/OCLP7_D97FN_IMAC_BUILD_DSC_EXTRACTOR.sh`

Fixed helper authority:
- commit `cf6d7ca1c2c748882d012786155df2de667e875a`;
- Git blob `4b9b598d6168032f92d99dd6de04154f4f7dcad1`.

Fix is intentionally build-only:
1. resolve `SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"`;
2. require SDK directory exists;
3. require `$SDKROOT/usr/include/dlfcn.h` exists;
4. compile with `-isysroot "$SDKROOT"`;
5. preserve exact pinned wrapper source unchanged;
6. preserve x86_64-only build, ad-hoc code signing, identity report and ZIP packaging;
7. no compile on ASUS2;
8. no Root Patch, EFI/NVRAM mutation or reboot.

## Current action
Rerun the fixed helper on the already-authorized home Intel iMac. Return the resulting D97FN build ZIP for independent audit. Do not run anything new on ASUS2 before that audit.
