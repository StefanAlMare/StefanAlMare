# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CL_LILU_DSC_PREFLIGHT_PASS_D97CM_MAP_PARSER_PARITY_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: one native Tahoe Metal/Metal4 image with a selective 3802 ingress lane plus the otherwise unchanged Tahoe 32023/32024 lane, feeding an audited legacy compiler path and Haswell driver.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compilers may be bounded; legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic proven: preserve exact 3802, otherwise execute original Tahoe floor.
Pre-sign cave was `0x1560..0x1630`. D97CD later proved codesign consumes `0x1560..0x1570`; standalone D97BV requires a new cave audit. D97BV remains unapplied.

## D97BW-v2 / D97BX — sparse closure
Sparse reconstruction preserves native code/Metal4 but is not standalone-loadable. Signing and D97BV were not the blocker.

## D97BY — real DSC export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` extraction succeed and preserve native `__text`/Metal4. First real-load rejection was missing `SG_READ_ONLY`.

## D97BZ — SG_READ_ONLY gate passed
Metadata-only flag repair passes that gate. Next exact rejection was segment VM order.

## D97CA — order-remap surface enumerated
Coherent repair surface: 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.

## D97CB — atomic order remap structural PASS
Exact order/SG_READ_ONLY/n_sect repair passed parser/preflight. v2-v4 contained harness defects. v5 proved a valid cold harness.

## D97CB-v5 — cold harness proven; sub-page mapping frontier
Bundle SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.
Baseline `/usr/bin/true` exit 0 with Metal/libbz2 delayed. Positive control libbz2 exit 0 final loaded.
Signed remapped RAW Metal maps `__TEXT`; next failure `__DATA_CONST mmap(...CD0) errno=22`.

## D97CC — page-prefix/LINKEDIT static closure
4K page-prefix plan preserves original section/content VM addresses while page-aligning segment mapping starts/fileoffs. Exactly 20 section offsets; `__LINKEDIT +0x3000`; 7 total LINKEDIT metadata updates.

## D97CD — page-aligned standalone mapping succeeds; Objective-C frontier
Bundle SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient page-aligned Metal SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.
All five segments map; runtime reaches `makeSegmentsReadWrite`, then `RC=-11`.

## D97CE — --slide does not advance Objective-C frontier
SLIDE SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.
`--slide` changes `88012` bytes / `43909` qword chunks, heavily in ObjC/data metadata, but page-aligned SLIDE Metal reproduces exactly D97CD. `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`.

## D97CF — true single Metal still identical Objective-C SIGSEGV
Bundle SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.
Framework override honored: temp Metal loaded, native shared-cache Metal absent, no native-cache mapping, exactly one Metal path/UUID, `D97CF_TRUE_SINGLE_METAL=PASS`.
Runtime remains RW marker -> zero post-marker dyld lines -> `RC=-11`.
Duplicate Metal is insufficient as current cause.

## D97CG — LLDB hook attempt tooling-negative
Bundle SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.
Ordinary frontier reconfirmed. LLDB `-K/--source-on-crash` not entered; RIP/frame0 unresolved. No Metal causal conclusion.

## D97CH — exact libobjc crash-site proof and reproducibility
Two independent explicit-signal LLDB runs preserve true-single-Metal and stop at:
- RIP `0x00007ff804ad9bba`;
- frame0 `libobjc.A.dylib\`map_images_nolock + 676`;
- instruction `orb $0x1,(%rcx)`.

Apple objc4 source correlates this with `header_info::setLoaded(true)`. `getPreoptimizedHeaderRW()` uses shared-cache bookkeeping when `objc_image_info::OptimizedByDyld (0x8)` is set. This generated D97CI-v2's bounded one-bit test.

## D97CI-v2 — OptimizedByDyld bit causal at D97CH frontier; later ObjC fault reached
Returned bundle `OCLP7_D97CI_V2_OBJC_OPTIMIZEDBYDYLD_FLAG_ADAPTER_20260906_132958.zip`:
- bytes `247079`;
- SHA256 `1dff54d95dbff8725d11e59e62506c4bca8367fcc2d5312474e72a4bd8662eb4`;
- TXT SHA256 `03dea8ee432944ed227ec3b42a42dbba9d20b8bb55f90178e6b81a126fdfbd34`;
- JSON SHA256 `66a42d9253784f9835159fde5dd085c95ac0a57b7e8b60cd01ce59d56db50b70`.

Exact pre-adapter carrier SHA `068ec08cff3d279ce1a700695162d0eda19ab8f5b956edb8a91e60c9009d155de2` had exactly one `__objc_imageinfo` at address `0x7FF8411BBDD0`, fileoff `0x30ADD0`, version `0`, flags `0x49`; `OptimizedByDyld (0x8)` was set.

D97CI-v2 changed exactly one byte:
- offset `0x30ADD4`;
- `0x49 -> 0x41`;
- XOR `0x08`;
- adapted SHA256 `c58780541c8079cbf9c095b01a906ed64ff998787918f13cfd600005acd848b7`.
Native `__text`, Metal4, geometry, signing and true-single-Metal remained valid.

The D97CH `map_images_nolock + 676 / setLoaded` fault disappeared. New exact fault:
- `EXC_BAD_ACCESS address=0x20`;
- RIP `0x00007ff804aeaa05`;
- frame0 `libobjc.A.dylib\`readClass(objc_class*, bool, bool) + 69`;
- instruction `movq 0x18(%rax), %r15`;
- `RAX=0x8`;
- `RBX=RDI=0x00007ff843d60620`;
- frame1 `map_images_nolock + 4170`.

Pinned objc4 source maps this path to `cls->nonlazyMangledName() -> bits.safe_ro()->getName()`, making RAX=0x8 invalid class-ro state.

Metal preferred `__DATA` VM is `0x7FF843D59000`. Fault `RBX=0x7FF843D60620` is exactly `+0x7620` inside the preferred Metal `__DATA`, while LLDB reports standalone Metal slide `0xffff8008f1250000`; therefore the corresponding runtime class should be `0x0000000134FB0620`. At least one internal ObjC class pointer remains in preferred shared-cache VM form rather than standalone-runtime-slid form.

Classifications:
- `D97CI_V2_D97CH_SETLOADED_FAULT_CLEARED=RUNTIME_PROVEN`;
- `D97CI_V2_NEW_READCLASS_FAULT=RUNTIME_PROVEN`;
- `D97CI_V2_CLASSLIST_OR_EQUIVALENT_INTERNAL_CLASS_POINTER_UNREBASED=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CI_V2_STANDALONE_CARRIER_HAS_REMAINING_SHARED_CACHE_RELOCATION_STATE=PROVEN_AT_LEAST_ONE_POINTER`.

Do not repair the individual pointer ad hoc.

## D97CJ — returned ObjC relocation-topology closure
Returned `OCLP7_D97CJ_OBJC_RELOCATION_TOPOLOGY_20260906_135939.zip`.

Raw LLDB ties `RBX=RDI=0x7FF843D60620` exactly to static `__objc_classlist[0]`. The pointer is preferred `__DATA +0x7620`; standalone runtime `__DATA` requires `0x134FB0620`, so the pointer is unrebased at the exact `readClass` fault.

The relocation surface is broad: 422/422 classlist, 2/2 catlist, 144/144 protolist and 385/385 superrefs are in-image preferred, with further cache/preferred surfaces in GOT/CFString/selector/protocol references.

The final helper's `SBFileSpec.GetPath()` failure is tooling-only after decisive evidence.

Classifications:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Production evaluation shifts to native shared-cache Metal plus a bounded OCLP-specific runtime compatibility plugin rather than standalone pointer rehydration.

## D97CL — Lilu / DSC runtime preflight PASS
Returned `OCLP7_D97CL_LILU_DSC_RUNTIME_PREFLIGHT_20260906_150640.zip`:
- ZIP SHA256 `3f97d2b82765d5e1a847b8c0a0ad1982fcced6c5c1978ff282f177ea39dd1f4e`;
- TXT final SHA256 `ee9762f22ad15ed7185c184b5246298e091bdf9a97d44b07a56d402bb6c56774`;
- embedded report SHA256 `5443d54ea576d0739723eb0d501e86fc9f050abb64f2b8bacf12072cd2c28f58`, verified as the report before its final self-hash line.

ASUS2 has AVX2, loaded Lilu `1.7.3` and WhateverGreen `1.7.1`, no `-liluuseroff`, no `-liluslow`, and the exact Ventura+/Tahoe Cryptex `dyld_shared_cache_x86_64h` plus `.map`. The exact native Metal path is present in that expected map. No x86_64 fallback map is present.

Classifications:
- `D97CL_FAST_SHARED_CACHE_MAPPING_PRECONDITION=PASS`;
- `D97CL_EXPECTED_CACHE_BINARY_PRECONDITION=PASS`;
- `D97CL_USERPATCHER_BOOTARG_PRECONDITION=PASS`;
- `D97CL_NO_SYSTEM_MUTATION=PASS`.

D97CL proves path/variant/existence prerequisites only. D97CM must parity-test Lilu `UserPatcher::mapAddresses()` against the exact Tahoe 25G82 Metal map block before any plugin build.

## CURRENT ACTION
Remain unpatched VESA. Run D97CM read-only map-parser parity audit when provided and return its ZIP/output.

No D97BV, Root Patch, installation, local compilation, accelerated boot or reboot is authorized.
