# OCLP7 CHECKPOINT — 2026-09-06 — D97CJ ObjC relocation topology audit ready

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CI_V2_FLAG_CLEAR_NEW_READCLASS_UNREBASED_CLASS_POINTER.md`.

## Retained D97CI-v2 closure
Returned bundle:
`OCLP7_D97CI_V2_OBJC_OPTIMIZEDBYDYLD_FLAG_ADAPTER_20260906_132958.zip`
- bytes `247079`;
- SHA256 `1dff54d95dbff8725d11e59e62506c4bca8367fcc2d5312474e72a4bd8662eb4`;
- TXT SHA256 `03dea8ee432944ed227ec3b42a42dbba9d20b8bb55f90178e6b81a126fdfbd34`;
- JSON SHA256 `66a42d9253784f9835159fde5dd085c95ac0a57b7e8b60cd01ce59d56db50b70`.

Exact pre-adapter carrier SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2` contained one `__objc_imageinfo` with version `0`, flags `0x49` and `OptimizedByDyld (0x8)` set. D97CI-v2 changed exactly one byte at `0x30ADD4`, `0x49 -> 0x41`, XOR `0x08`, preserving geometry, native `__text`, Metal4 and true-single-Metal.

This cleared the exact D97CH `map_images_nolock + 676 / header_info::setLoaded(true)` crash.
The new exact frontier is:
- `EXC_BAD_ACCESS address=0x20`;
- RIP `0x00007ff804aeaa05`;
- frame0 `libobjc.A.dylib\`readClass(objc_class*, bool, bool) + 69`;
- instruction `movq 0x18(%rax), %r15`;
- `RAX=0x8`;
- `RBX=RDI=0x00007ff843d60620`;
- frame1 `map_images_nolock + 4170`.

Pinned objc4 source correlates `readClass()` with `cls->nonlazyMangledName() -> bits.safe_ro()->getName()`. The `+0x18` load is the class-ro name read, so `RAX=0x8` is an invalid class-ro pointer/state.

Metal preferred `__DATA` VM is `0x7FF843D59000`, making fault class pointer `0x7FF843D60620` exactly `+0x7620` inside Metal's preferred `__DATA`. D97CI LLDB reports standalone Metal slide `0xffff8008f1250000`, so the corresponding runtime address should be `0x0000000134FB0620` rather than `0x7FF843D60620`.

Therefore at least one Objective-C internal class pointer reaches libobjc in preferred shared-cache VM form instead of standalone-runtime-slid form. Do not patch this individual pointer ad hoc.

Authoritative retained classifications:
- `D97CI_V2_D97CH_SETLOADED_FAULT_CLEARED=RUNTIME_PROVEN`;
- `D97CI_V2_NEW_READCLASS_FAULT=RUNTIME_PROVEN`;
- `D97CI_V2_CLASSLIST_OR_EQUIVALENT_INTERNAL_CLASS_POINTER_UNREBASED=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CI_V2_STANDALONE_CARRIER_HAS_REMAINING_SHARED_CACHE_RELOCATION_STATE=PROVEN_AT_LEAST_ONE_POINTER`.

## D97CJ purpose
Before any new Metal functional mutation, inventory the complete relevant Objective-C relocation topology of the standalone carrier and prove/falsify at runtime that the exact `readClass` class pointer is an unrebased `__objc_classlist` entry.

D97CJ deliberately retains only the already-proven D97CI one-bit `OptimizedByDyld` clear as a prerequisite. It applies no D97BV and no additional Metal code/data repair.

## Static topology audit
D97CJ inventories pointer qwords in:
- `__objc_classlist`, `__objc_nlclslist`;
- `__objc_catlist`, `__objc_nlcatlist`;
- `__objc_protolist`, `__objc_protorefs`;
- `__objc_classrefs`, `__objc_superrefs`;
- `__objc_selrefs`, `__objc_msgrefs`;
- `__cfstring`, `__got`, `__la_symbol_ptr`.

Each pointer is classified as NULL, SMALL, in-image preferred VM, cache-like external/preferred, or other. Classlist entries are additionally decoded through the class object's `bits` qword using the x86_64 class-data mask observed at the current runtime frontier.

## Runtime LLDB proof
If the one-bit-adapted true-single-Metal carrier still faults, D97CJ uses explicit-signal LLDB and an audited Python helper to capture:
- fault `RBX/RDI/RAX`;
- actual temporary Metal load address and slide;
- expected runtime class address from `fault_RBX + Metal_slide`;
- memory at the un-slid RBX and expected slid class address;
- expected class `bits` raw/masked/runtime address;
- expected `class_ro_t` bytes;
- expected class name pointer/string.

Strong classification requires the fault RBX to match a static classlist entry, expected runtime class arithmetic to match, the slid class and its `class_ro_t` to be readable, and a readable class name. Then:
`UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE_STRUCTURAL_RUNTIME_PROVEN`.

If any gate fails, D97CJ reports an explicit INCONCLUSIVE/PARTIAL classification rather than inferring.

## Strategic decision after D97CJ
- If the remaining ObjC relocation surface is small, finite and reconstructible with standard standalone Mach-O fixup metadata, a bounded carrier fixup reconstruction may remain justified.
- If the surface is broad/cache-optimized, prefer preserving native Tahoe Metal inside dyld shared cache and evaluate a production selective-3802 patch via Lilu/WhateverGreen-style userland/shared-cache process patching. This alternative is not yet promoted to final design.

## Script identity
Run only:
`OCLP7_D97CJ_objc_relocation_topology_audit.sh`
- bytes `48877`;
- SHA256 `7921c9923afaa7ca499d8c00a146ab215d5c4a0f0e33c5d244f68ac153cc056e`;
- shell syntax PASS;
- embedded main Python compile PASS;
- embedded LLDB-helper Python compile PASS;
- transient cleanup/safety scan PASS.

No system/cache mutation, tool installation, local compilation, Apple binary in ZIP, D97BV, Root Patch or reboot.

## CURRENT ACTION
Remain unpatched in Tahoe VESA. Run only exact D97CJ script above and return ZIP/output.
