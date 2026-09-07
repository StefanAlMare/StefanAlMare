# OCLP7 D97FN — exact dsc_extractor wrapper source + authorized Intel-iMac build helper ready

Date: 2026-09-07 EEST

## Purpose
D97FM closed the LLDB process-load lane as tooling-blocked and requires exact extraction of the active 25G82 x86_64h dyld shared cache.

## Source authority
Wrapper source:
`OCLP-Continuity/artifacts/OCLP7_D97FN_DSC_EXTRACTOR_WRAPPER.cc`
- source commit `524467d3f41166f58e75a39d003ae79eedf71d7e`;
- Git blob `08aca87f551cf9dbd2d12974d58f81e7de2495c9`.

Semantics:
- fixed system bundle `/usr/lib/dsc_extractor.bundle`;
- `dlopen(..., RTLD_LAZY | RTLD_LOCAL)`;
- resolves only `dyld_shared_cache_extract_dylibs_progress`;
- invokes it with caller-supplied cache path and output root;
- bounded textual progress only;
- returns extractor result unchanged as process success/failure;
- no system mutation, EFI, NVRAM, Root Patch or reboot logic.

The API/signature matches Apple dyld open-source `dsc_extractor.cpp` and Chromium's macOS cache-extractor wrapper.

## Build helper authority
Build helper:
`OCLP-Continuity/artifacts/OCLP7_D97FN_IMAC_BUILD_DSC_EXTRACTOR.sh`
- helper commit `cbf02d0f63e726c893bd182586013d709858877d`;
- Git blob `06a98dd692c24143ade7d69fbdfe875706b757af`.

Helper behavior:
- fail-closed Darwin x86_64 gate;
- locates clang++ via xcrun;
- downloads source from exact pinned commit;
- verifies exact Git blob before compile;
- compiles x86_64 only with blocks enabled;
- ad-hoc signs the helper binary;
- records file/arch/UUID/SHA256/bytes/dependencies;
- packages source, binary and build report to Desktop ZIP;
- performs no extraction, deployment, EFI/NVRAM/Root Patch or reboot.

## Execution authority
The user previously explicitly authorized compilation on the home Intel iMac because GitHub Actions quota is blocked.
Therefore D97FN wrapper compilation on that home Intel iMac is authorized.
Compilation on ASUS2 remains NOT authorized.

## Classification
- `D97FN_SOURCE_READY=PASS`
- `D97FN_SOURCE_PINNED=PASS`
- `D97FN_IMAC_BUILD_HELPER_READY=PASS`
- `D97FN_IMAC_COMPILE_AUTHORIZED=YES`
- `D97FN_ASUS2_COMPILE_AUTHORIZED=NO`
- `D97FN_ASUS2_EXTRACTION_AUTHORIZED=NO_PENDING_RETURNED_BINARY_AUDIT`
- `D97FN_REBOOT_AUTHORIZED=NO`
- `D97FN_ROOT_PATCH_AUTHORIZED=NO`

## Current action
Build the pinned D97FN wrapper on the authorized home Intel iMac and return the produced ZIP for independent identity audit. Only after that audit may the wrapper be run on ASUS2 against the exact local 25G82 `dyld_shared_cache_x86_64h`.
