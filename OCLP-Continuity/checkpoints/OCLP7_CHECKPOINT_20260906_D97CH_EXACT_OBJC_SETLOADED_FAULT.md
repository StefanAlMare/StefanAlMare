# OCLP7 CHECKPOINT — 2026-09-06 — D97CH exact Objective-C setLoaded fault

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CG_LLDB_HOOK_NEGATIVE_D97CH_EXPLICIT_SIGNAL_READY.md`.

## State
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- D97BV is absent and unauthorized.
- No Root Patch, reboot, accelerated boot, installation or local compilation authorized.

## Returned D97CH evidence
Bundle `OCLP7_D97CH_SINGLE_METAL_LLDB_EXPLICIT_SIGNAL_20260906_052600.zip`:
- bytes `246375`;
- SHA256 `d94d604f5675b72ac6e412e8d0bf593ed18ac6ff4f2e89dedfec59fe80c2433e`.
Packaged TXT:
- bytes `717024`;
- SHA256 `001679e65ef84fa4106a695d4707b735b2c6d89f15a8eabe4db2e48fa18d45c4`.
Packaged JSON:
- bytes `766468`;
- SHA256 `33c50f5a39b5aaf540102ab9285b26aef24996a914f7d4465bb55868ef9d9a71`.
Cleanup PASS; temp remaining file count `0`.

## Runtime closure
D97CH preserved the D97CF true-single-Metal environment under LLDB:
- `D97CH_LLDB_TRUE_SINGLE_METAL=PASS`;
- target RW marker seen;
- inferior stopped;
- bad access captured;
- `D97CH_LLDB_CLASSIFICATION=TRUE_SINGLE_METAL_BAD_ACCESS_PC_BACKTRACE_CAPTURED`.

Exact crash:
- stop reason `EXC_BAD_ACCESS (code=1, address=0x7ff58e927008)`;
- RIP `0x00007ff804ad9bba`;
- frame 0 `libobjc.A.dylib\`map_images_nolock + 676`;
- fault instruction `orb $0x1, (%rcx)`;
- `RCX = RAX = 0x00007ff58e927008`.

Backtrace begins:
1. `libobjc.A.dylib\`map_images_nolock + 676`;
2. `libobjc.A.dylib\`map_images + 74`;
3. dyld ObjC mapped-image notifier;
4. `dyld4::RuntimeState::setObjCNotifiers`;
5. `_dyld_objc_register_callbacks`;
6. `libobjc.A.dylib\`_objc_init + 1583`.

This proves the former `makeSegmentsReadWrite -> SIGSEGV` boundary is inside libobjc image registration, not a mapping failure or Metal initializer.

## Source-semantic correlation
Apple objc4 source at commit `fb265098298302243cd7eeaa1f63f0ba7786dd9a` shows in `addHeader()` that `hi->setLoaded(true)` is immediately followed by `hi->classlist(...)`. The D97CH faulting instruction is immediately followed by the same `header_info::classlist` call, identifying the machine-code fault as the `setLoaded(true)` write path.

`header_info::setLoaded()` calls `getHeaderInfoRW()->setLoaded(v)`.
`getPreoptimizedHeaderRW(hdr)` returns a shared-cache RW entry only when `hdr->info()->optimizedByDyld()` is true; it then executes `headerInfoROs->index(hdr)` and returns `&objc_debug_headerInfoRWs->headers[index]`.

`objc_image_info::OptimizedByDyld = 1<<3` (`0x8`) and means the image is from an optimized shared cache.

D97CH registers a runtime-allocated standalone `header_info` for the extracted Metal. The observed invalid RCX is consistent with taking the preoptimized shared-cache RW route for that standalone header. This is a strong source+runtime causal hypothesis, but the actual `__objc_imageinfo` flag in the exact exported Metal must be measured before mutation.

## Authoritative classifications
- `D97CH_TRUE_SINGLE_METAL_BAD_ACCESS_PC_BACKTRACE_CAPTURED=RUNTIME_PROVEN`;
- `D97CH_CRASH_SITE_LIBOBJC_MAP_IMAGES_NOLOCK_SETLOADED_WRITE=RUNTIME_SOURCE_CORRELATED`;
- `D97CH_CURRENT_FAULT_ADDRESS=0x7ff58e927008`;
- `D97CH_DUPLICATE_METAL_CAUSE=ALREADY_NEGATIVE`;
- `D97CH_OBJC_OPTIMIZED_BY_DYLD_FLAG_CAUSALITY=HYPOTHESIS_REQUIRES_EXACT_FLAG_AUDIT_AND_BOUNDED_TEST`.

## CURRENT ACTION
Remain unpatched VESA. Next bounded transient test must:
1. reconstruct the exact proven SLIDE export/page-aligned single-Metal carrier;
2. locate exact `__objc_imageinfo` and print version/flags;
3. require `OptimizedByDyld (0x8)` to be present before any mutation;
4. create a temporary copy clearing only bit `0x8` in `objc_image_info.flags`;
5. prove the binary diff is exactly that metadata bit plus ordinary codesign effects;
6. sign and rerun true-single-Metal cold test;
7. if it still faults, use the already-proven explicit-signal LLDB capture to localize the next PC.

No D97BV, Root Patch or reboot.