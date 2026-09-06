# OCLP7 CHECKPOINT — 2026-09-06 — D97CI-v2 clears D97CH fault; new readClass unrebased class-pointer frontier

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CI_V2_OBJC_OPT_FLAG_ADAPTER_READY.md`.

## Returned evidence
Bundle:
`OCLP7_D97CI_V2_OBJC_OPTIMIZEDBYDYLD_FLAG_ADAPTER_20260906_132958.zip`
- bytes `247079`;
- SHA256 `1dff54d95dbff8725d11e59e62506c4bca8367fcc2d5312474e72a4bd8662eb4`;
- TXT bytes `718445`, SHA256 `03dea8ee432944ed227ec3b42a42dbba9d20b8bb55f90178e6b81a126fdfbd34`;
- JSON bytes `767484`, SHA256 `66a42d9253784f9835159fde5dd085c95ac0a57b7e8b60cd01ce59d56db50b70`.

Machine remained Tahoe `26.6.2 / 25G82`, unpatched VESA, no Root Patch/reboot/D97BV.

## D97CI-v2 bounded adapter result
Exact pre-adapter carrier identity passed:
- SLIDE/page SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`.

Exactly one `__objc_imageinfo` was found:
- segment `__DATA_CONST`;
- address `0x7FF8411BBDD0`;
- fileoff `0x30ADD0`;
- version `0`;
- flags before `0x49`;
- `OptimizedByDyld (0x8)` was set.

The adapter changed exactly one byte:
- offset `0x30ADD4`;
- `0x49 -> 0x41`;
- XOR `0x08`;
- adapted SHA256 `c58780541c8079cbf9c095b01a906ed64ff998787918f13cfd600005acd848b7`;
- native `__text`, Metal4 counts and section geometry remained unchanged;
- post-codesign flag remained clear.

Thus:
`D97CI_V2_OPTIMIZED_BY_DYLD_ONE_BIT_ADAPTER=RUNTIME_PRECONDITION_AND_STATIC_DIFF_PROVEN`.

## Runtime result
True single Metal remained proven after flag clear.
The previous D97CH fault at `libobjc.A.dylib map_images_nolock + 676` / `header_info::setLoaded(true)` disappeared.

New LLDB stop:
- `EXC_BAD_ACCESS (code=1, address=0x20)`;
- RIP `0x00007ff804aeaa05`;
- frame0 `libobjc.A.dylib readClass(objc_class*, bool, bool) + 69`;
- instruction `movq 0x18(%rax), %r15`;
- `RAX=0x8`;
- `RBX=RDI=0x00007ff843d60620`;
- frame1 `map_images_nolock + 4170`.

Automatic classification:
`D97CI_V2_CAUSAL_CLASSIFICATION=FLAG_CLEAR_CLEARED_D97CH_SETLOADED_FAULT_NEW_FRONTIER_REACHED`.

## Exact source/layout correlation
Pinned objc4 source shows `readClass()` begins with `cls->nonlazyMangledName()`, while `nonlazyMangledName()` returns `bits.safe_ro()->getName()`.
`class_ro_t::name` is reached by the faulting `+0x18` load, therefore at the crash `RAX=0x8` is the invalid `class_ro_t*`-equivalent source.

More importantly, Metal's preferred `__DATA` VM is `0x7FF843D59000`; the class pointer `0x7FF843D60620` is exactly preferred-VM offset `0x7620` inside that segment.
LLDB reports the standalone Metal image slide as `0xffff8008f1250000`, so the corresponding runtime address should be `0x0000000134fb0620`, not `0x7FF843D60620`.

Therefore a Metal Objective-C class pointer is directly observed reaching libobjc in preferred shared-cache VM form instead of standalone-runtime-slid form.

Authoritative classifications:
- `D97CI_V2_D97CH_SETLOADED_FAULT_CLEARED=RUNTIME_PROVEN`;
- `D97CI_V2_NEW_READCLASS_FAULT=RUNTIME_PROVEN`;
- `D97CI_V2_CLASSLIST_OR_EQUIVALENT_INTERNAL_CLASS_POINTER_UNREBASED=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CI_V2_STANDALONE_CARRIER_HAS_REMAINING_SHARED_CACHE_RELOCATION_STATE=PROVEN_AT_LEAST_ONE_POINTER`.

Do not patch the individual failing pointer ad hoc. The next step must inventory the complete relevant Objective-C relocation/preoptimization surface and decide whether a finite standalone-fixup reconstruction is justified or whether production should preserve native shared-cache Metal and apply the selective 3802 adapter through Lilu userland/shared-cache process patching.

## CURRENT ACTION
Remain unpatched in VESA. No D97BV, Root Patch or reboot.
Design/run D97CJ as a bounded read-only/static+LLDB ObjC relocation-topology audit before any further Metal mutation.
