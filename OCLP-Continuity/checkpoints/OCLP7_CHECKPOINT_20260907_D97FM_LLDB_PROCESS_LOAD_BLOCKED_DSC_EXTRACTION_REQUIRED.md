# OCLP7 D97FM — LLDB process-load blocked; exact dyld shared-cache extraction required

Date: 2026-09-07 EEST
Target: ASUS2 Tahoe 26.6.2 / 25G82 x86_64 Haswell

## Input
D97FJ established the fatal frontier at `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal validateWithDevice`.
D97FK showed CoreDisplay/Metal are not present as standalone filesystem Mach-O images on this installation and static mapping must use the active dyld shared cache.
D97FL located the active cache family at `/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h` plus subcaches and confirmed `/usr/lib/dsc_extractor.bundle` exists.

## D97FM evidence
LLDB 2100.0.17.203 successfully created `/bin/sleep` x86_64 and launched PID 7322.
`process load /System/Library/Frameworks/CoreDisplay.framework/Versions/A/CoreDisplay` failed before image load with LLDB utility-expression failure:
- fallback Objective-C++ expression;
- unresolved `_dlerror`;
- no CoreDisplay image load;
- no symbol lookup/disassembly obtained.

Therefore D97FM is a tooling/method blocker, not a new graphics failure.

## Classification
- `D97FM_LLDB_TARGET_LAUNCH=PASS`
- `D97FM_COREDISPLAY_PROCESS_LOAD=INCONCLUSIVE_TOOLING_BLOCKED`
- `D97FM_COREDISPLAY_STATIC_MAPPING=NOT_OBTAINED`
- `D97FM_FATAL_FRONTIER_CHANGED=NO`
- `D97FM_NEXT_METHOD=EXACT_DSC_EXTRACTION`
- `D97FM_REBOOT_AUTHORIZED=NO`
- `D97FM_ROOT_PATCH_AUTHORIZED=NO`
- `D97FM_ASUS2_COMPILE_AUTHORIZED=NO`

## Exact cache authority
Use the active 25G82 Cryptex cache:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`
with its `.01`..`.06` subcaches.

Use the system-matching extractor bundle:
`/usr/lib/dsc_extractor.bundle`.

## Next method
Build a minimal x86_64 wrapper on the explicitly authorized home Intel iMac. The wrapper must only `dlopen` `/usr/lib/dsc_extractor.bundle`, resolve `dyld_shared_cache_extract_dylibs_progress`, and invoke it on a caller-supplied cache/output directory.

The resulting wrapper may then be transferred to ASUS2 and executed without compilation to extract the exact local cache into a separate user-owned work directory. No EFI, NVRAM, Root Patch, framebuffer or boot-arg mutation is involved.
