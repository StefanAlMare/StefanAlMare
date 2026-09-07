# OCLP7 CHECKPOINT — D97FQ

Date: 2026-09-07 EEST

## Scope
Independent audit of user-returned Intel-iMac build archive:
`OCLP7_D97FN_DSC_EXTRACTOR_IMAC_20260907_182728.zip`

This checkpoint does not modify ASUS2, EFI, NVRAM, Root Patch, framebuffer configuration or boot arguments.

## Archive audit
- outer ZIP bytes: `4737`
- outer ZIP SHA256: `74fb7f80dd09fb388fde09091f6b925425a1c7fa0d160bde386d842747ecffce`
- ZIP CRC/test: PASS
- package contents:
  - `OCLP7_D97FN_DSC_EXTRACTOR_WRAPPER.cc`
  - `d97fn-dsc-extractor`
  - `D97FN_BUILD_REPORT.txt`

## Build-host evidence
Build report states:
- macOS 26.6.2 / build 25G83
- Darwin x86_64
- Apple clang 21.0.0
- SDKROOT `MacOSX26.5.sdk`
- exact `dlfcn.h` present
- source commit `524467d3f41166f58e75a39d003ae79eedf71d7e`
- expected/actual source Git blob both `08aca87f551cf9dbd2d12974d58f81e7de2495c9`
- build status PASS
- ASUS2 compile NO
- system mutation NO
- reboot NO

## Source identity
Returned source:
- Git blob `08aca87f551cf9dbd2d12974d58f81e7de2495c9` — exact authoritative source
- SHA256 `4f9fb87ebed9b25d652119b7232c501f44e2ba5524d67920249bb0572205edc1`

## Binary identity
Returned `d97fn-dsc-extractor`:
- Mach-O 64-bit x86_64 executable
- flags: NOUNDEFS, DYLDLINK, TWOLEVEL, PIE
- bytes `27664`
- SHA256 `04f0e1aa835f7dcafc3ccf989fe90bf3324b9d173824a7540d0232e9e7464bff`
- UUID `213B833D-A864-3A3D-97E5-BB4AB8824033`
- LC_BUILD_VERSION: macOS, SDK 26.5, minimum OS 26.0
- dependencies only:
  - `/usr/lib/libc++.1.dylib`
  - `/usr/lib/libSystem.B.dylib`
- LC_CODE_SIGNATURE present (ad-hoc signing produced by build helper)

## Binary semantic audit
Direct strings and disassembly independently confirm the intended minimal behavior:
1. validates `argc == 3`;
2. calls `dlopen("/usr/lib/dsc_extractor.bundle", RTLD_LAZY|RTLD_LOCAL)`;
3. calls `dlsym(..., "dyld_shared_cache_extract_dylibs_progress")`;
4. reports fail-closed if dlopen/dlsym fails;
5. invokes the resolved Apple extraction function exactly once with:
   - user-supplied shared-cache path;
   - user-supplied extraction-root path;
   - progress callback;
6. reports the Apple return code;
7. calls `dlclose`;
8. returns success only when Apple extractor returns `0`.

No EFI/NVRAM/Root Patch/kext/framebuffer/system mutation logic exists in the wrapper.

## Apple Developer certificate / notarization
User now has Apple Developer signing/notarization capability. It is NOT required for the current local diagnostic extraction. The audited binary is already ad-hoc signed and sufficient for this controlled local use. Developer ID signing/notarization should be reserved for later distribution or polished reusable tooling after runtime semantics are proven; changing signing now would alter the audited binary identity and add no diagnostic value.

## Classification
- ZIP/package integrity: PASS
- source authority: PASS
- local iMac compile: PASS
- Mach-O identity: PASS
- binary implementation: STRUCTURAL-SEMANTIC PROVEN for intended wrapper scope
- target ASUS2 runtime compatibility with `/usr/lib/dsc_extractor.bundle`: UNKNOWN until first read-only execution

## Authorized next action
One read-only/user-data extraction attempt on ASUS2 is authorized using this exact audited binary SHA256:
`04f0e1aa835f7dcafc3ccf989fe90bf3324b9d173824a7540d0232e9e7464bff`

Target cache authority from D97FL:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`

The extraction output must go to a newly created non-system directory. No root privileges are required unless the Apple extractor itself unexpectedly demands them; do not escalate automatically. No reboot, Root Patch, EFI, NVRAM, kext or boot-arg changes are authorized.

After extraction, preserve only the evidence needed for static mapping of exact 25G82 CoreDisplay/Metal around `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState`, especially offsets corresponding to prior crash `+599` and `+1720` and strings around `F_NymriCY`.
