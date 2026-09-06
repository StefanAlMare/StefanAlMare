# OCLP7 CHECKPOINT — 2026-09-06 — D97CG true-single-Metal LLDB crash localizer ready

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CF_TRUE_SINGLE_METAL_IDENTICAL_OBJC_SIGSEGV.md` without changing D97CF conclusions.

## Retained D97CF closure
D97CF proved a true single-Metal process:
- framework override honored;
- temporary native-derived page-aligned SLIDE Metal loaded;
- native shared-cache Metal absent;
- no native-cache Metal mapping;
- exactly one Metal path and UUID;
- `D97CF_TRUE_SINGLE_METAL=PASS`.

Runtime still ended at the identical Objective-C boundary:
- target final loaded;
- last dyld marker `mprotect ... to read-write (Metal)`;
- zero dyld lines after marker;
- RC `-11` SIGSEGV.

Therefore:
`D97CF_DUPLICATE_METAL_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`.

## D97CG purpose
Do not mutate Metal again yet. Localize the actual crash instruction/stack while preserving the exact D97CF geometry and true-single-Metal framework override.

D97CG first reconstructs the exact proven D97CF SLIDE-page Metal and hard-requires transient transform SHA256:
`068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`.

It then re-runs the ordinary D97CF cold test. LLDB is attempted only if the ordinary run again proves:
- framework override honored;
- true single Metal;
- classification `SINGLE_METAL_IDENTICAL_RW_MARKER_THEN_SIGSEGV`;
- RC `-11`;
- RW marker seen;
- zero lines after RW marker.

## LLDB methodology
No debugger/tool installation is performed.
D97CG discovers an already-installed LLDB via `/usr/bin/xcrun --find lldb` or existing PATH.

If unavailable, it packages `LLDB_UNAVAILABLE` and makes no causal inference.

If available, it launches the exact same ad-hoc `cold_true` inferior in official LLDB batch mode with the exact D97CF environment:
- `DYLD_FRAMEWORK_PATH=<temp>/Frameworks`;
- `DYLD_INSERT_LIBRARIES=/System/Library/Frameworks/Metal.framework/Versions/A/Metal`;
- dyld libraries/segments/initializers tracing.

LLDB uses a crash-only command file (`-K/--source-on-crash`) to capture:
- process status;
- thread list;
- all-thread backtrace;
- x86_64 general registers including RIP/RSP/RBP;
- `image lookup -v --address $pc`;
- memory region for `$pc`;
- `disassemble --pc --count 24`;
- complete image list/load slides.

The debugger run is classified fail-closed. Strong success requires:
- debugger inferior still proves true single-Metal;
- target RW marker is present;
- crash hook runs;
- EXC_BAD_ACCESS/SIGSEGV is captured;
- fault PC/frame 0 is resolved.

## Script identity
Run only:
`OCLP7_D97CG_single_metal_lldb_sigsegv_localizer.sh`
- bytes `31544`;
- SHA256 `5bc0cc317be9336bd1af30190eb4e91a20224b2b48c99173cfda11ca2bd0203c`;
- shell syntax PASS;
- embedded Python compile PASS.

The script creates only transient Apple-derived binaries under `/private/tmp`, packages TXT/JSON only, deletes transient binaries before completion, applies no D97BV, performs no Root Patch, install, source/local compilation or reboot.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run the exact D97CG script above and return its ZIP/output.
