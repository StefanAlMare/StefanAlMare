# OCLP7 D97FP — DSC extractor local-build helper path hardening

Date: 2026-09-07 EEST

## Context
The authorized Intel-iMac D97FN wrapper build was retried after adding an explicit macOS SDK sysroot. The build host correctly resolved:
- macOS 26.6.2 / 25G83;
- x86_64 Darwin;
- full Xcode clang++;
- MacOSX26.5.sdk;
- `$SDKROOT/usr/include/dlfcn.h` present.

The helper then stopped before compilation because it invoked `/usr/bin/ls`, which does not exist on this Tahoe build. `/bin/ls` is the valid location.

## Interpretation
This is a helper-path defect only. It does not invalidate:
- D97FN wrapper source;
- the dsc_extractor method;
- the D97FJ CoreDisplay/Metal runtime frontier.

No binary was produced by the failed attempt.

## Hardening
Authoritative helper path:
`OCLP-Continuity/artifacts/OCLP7_D97FN_IMAC_BUILD_DSC_EXTRACTOR.sh`

New helper authority:
- commit `cadb067954a311206f91f7f3cb2a8398ee4dc375`;
- Git blob `be951b48d44d5c1542bb723cc7b36f31e497f5c3`.

The helper now:
- uses `/bin/ls` explicitly;
- resolves `clang++`, `lipo`, `dwarfdump`, and `otool` through `/usr/bin/xcrun --find`;
- validates every required CLI tool before compilation;
- preserves explicit `SDKROOT` and `-isysroot "$SDKROOT"`;
- preserves exact wrapper source commit/blob;
- continues to build only on the explicitly authorized home Intel iMac;
- performs no ASUS2 compilation, system mutation, Root Patch, EFI/NVRAM change, or reboot.

Wrapper source remains unchanged:
- commit `524467d3f41166f58e75a39d003ae79eedf71d7e`;
- blob `08aca87f551cf9dbd2d12974d58f81e7de2495c9`.

## Classification
- `D97FP_PREVIOUS_BUILD=STOP_BEFORE_COMPILE`
- `D97FP_SDKROOT=PASS`
- `D97FP_DLFCN_HEADER=PASS`
- `D97FP_HELPER_PATH_DEFECT=FIXED`
- `D97FP_WRAPPER_SOURCE_CHANGED=NO`
- `D97FP_ASUS2_COMPILE=NO`
- `D97FP_RUNTIME_GATE_CHANGED=NO`
- `D97FP_REBOOT_AUTHORIZED=NO`

## CURRENT ACTION
Retry the Intel-iMac local wrapper build using helper commit `cadb067954a311206f91f7f3cb2a8398ee4dc375` / blob `be951b48d44d5c1542bb723cc7b36f31e497f5c3`.
Return the produced `OCLP7_D97FN_DSC_EXTRACTOR_IMAC_<timestamp>.zip` for independent audit before any ASUS2 use.
