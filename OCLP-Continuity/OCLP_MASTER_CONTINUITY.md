# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CJ_OBJC_RELOCATION_TOPOLOGY_AUDIT_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
Before any technical modification:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable architecture
Pinned Golden OCLP: `dortania/OpenCore-Legacy-Patcher` commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.
Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; D34 cave remains protected.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

The final target is one native Tahoe Metal image with two logical compiler-generation lanes, not two Metal frameworks. The 3802 lane must be selectively preserved when genuinely requested; Tahoe's 32023/32024 path must remain otherwise unchanged.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802` production repair;
- no repeat of historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Exact target Metallib package remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Native producer / D97BV closure
Native Tahoe Metal cache base `0x7FF80F47D000`; native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`; native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`. Native 3802 and 32023 lanes exist; no 31001.
D97BT proved default-environment 3802 suppression to 32023/32024.
D97BV selective adapter remains static-semantic proven: exact input 3802 bypasses the floor, every non-3802 input executes original Tahoe behavior. D97CD proved codesign consumes `0x1560..0x1570` of the former standalone cave, so D97BV remains unauthorized pending a fresh signed-cave audit or a different production patching substrate.

## Standalone native-Metal reconstruction closure
D97BW-v2/BX: sparse mirror analysis-only.
D97BY: real `ipsw v3.1.713` extraction preserves native `__text`/Metal4; first load rejection missing `SG_READ_ONLY`.
D97BZ: `SG_READ_ONLY` fixed; next rejection segment VM order.
D97CA: order-remap surface fully enumerated: 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.
D97CB: atomic order/SG_READ_ONLY/n_sect remap structural PASS.
D97CB-v5: proven cold harness; remapped RAW Metal maps `__TEXT`, then fails sub-page `__DATA_CONST mmap(...CD0) errno=22`.
D97CC: exact 4K page-prefix/LINKEDIT plan statically closed; 20 section fileoffs, `__LINKEDIT +0x3000`, 7 total LINKEDIT metadata updates, section/content VM addresses preserved.

## D97CD — page-aligned mapping FULL PASS; Objective-C frontier
Bundle SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient unsigned page-aligned Metal: bytes `5735232`, SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.
All five standalone Metal segments map successfully. Runtime reaches `mprotect ... to read-write (Metal.PAGE.adhoc)` then exits `RC=-11` SIGSEGV.

## D97CE — full --slide does NOT advance frontier
SLIDE Metal SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.
`--slide` changes `88012` bytes / `43909` 8-byte chunks, heavily in Objective-C/data metadata, while load commands, native `__text` and Metal4 remain identical.
Page-aligned SLIDE transform SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2` reproduces D97CD exactly: target loaded, RW marker, zero dyld lines after marker, RC `-11`.
Classifications:
- `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`;
- `D97CE_RAW_CACHE_SLIDE_INFO_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`.

## D97CF — true single Metal; duplicate-Metal cause CLOSED NEGATIVE
Bundle SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.
Framework override honored: temp Metal loaded, native shared-cache Metal absent, no native-cache Metal mapping, one Metal path/UUID, `D97CF_TRUE_SINGLE_METAL=PASS`.
Runtime remains RW marker -> zero post-marker dyld lines -> `RC=-11`.
Classification: `D97CF_DUPLICATE_METAL_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`.

## D97CG — LLDB crash-hook tooling negative
Bundle SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.
Ordinary D97CF frontier reconfirmed. LLDB `lldb-2100.0.17.203` preserves true-single-Metal and reaches RW marker, but `-K/--source-on-crash` is never entered. RIP/frame0 unresolved. This is debugger-harness only; do not rerun D97CG.

## D97CH — exact libobjc crash localized and reproduced
Original bundle SHA256 `d94d604f5675b72ac6e412e8d0bf593ed18ac6ff4f2e89dedfec59fe80c2433e`.
Independent rerun bundle SHA256 `ba05d9b299d52ce2f12ab817d9d88e4f1ee7da8e013fb9d9a18d05cbd314263d`.
Both runs preserve true-single-Metal and stop on the same exact instruction:
- RIP `0x00007ff804ad9bba`;
- frame0 `libobjc.A.dylib\`map_images_nolock + 676`;
- instruction `orb $0x1,(%rcx)`;
- fault destination changes only with ASLR.

Apple objc4 source correlates the sequence with `header_info::setLoaded(true)` in `addHeader()`. `setLoaded()` writes through `getHeaderInfoRW()`, and `getPreoptimizedHeaderRW()` uses shared-cache RW bookkeeping only when `objc_image_info::OptimizedByDyld (0x8)` is set.

Authoritative classifications:
- `D97CH_TRUE_SINGLE_METAL_BAD_ACCESS_PC_BACKTRACE_CAPTURED=RUNTIME_PROVEN`;
- `D97CH_CRASH_SITE_LIBOBJC_MAP_IMAGES_NOLOCK_SETLOADED_WRITE=RUNTIME_SOURCE_CORRELATED`;
- `D97CH_REPRODUCIBILITY_SAME_RIP_FRAME_INSTRUCTION=RUNTIME_PROVEN`.

## D97CI-v2 — OptimizedByDyld one-bit hypothesis POSITIVE; new readClass frontier
Returned bundle `OCLP7_D97CI_V2_OBJC_OPTIMIZEDBYDYLD_FLAG_ADAPTER_20260906_132958.zip`:
- bytes `247079`;
- SHA256 `1dff54d95dbff8725d11e59e62506c4bca8367fcc2d5312474e72a4bd8662eb4`;
- TXT SHA256 `03dea8ee432944ed227ec3b42a42dbba9d20b8bb55f90178e6b81a126fdfbd34`;
- JSON SHA256 `66a42d9253784f9835159fde5dd085c95ac0a57b7e8b60cd01ce59d56db50b70`.

D97CI-v2 proved the standalone carrier had one `__objc_imageinfo` at `0x7FF8411BBDD0`, fileoff `0x30ADD0`, version `0`, flags `0x49`, with `OptimizedByDyld (0x8)` set. It changed exactly one byte at `0x30ADD4`, `0x49 -> 0x41`, XOR `0x08`; adapted SHA256 `c58780541c8079cbf9c095b01a906ed64ff998787918f13cfd600005acd848b7`; geometry, native `__text`, Metal4 and true-single-Metal remained intact.

The D97CH `setLoaded` crash disappeared. New exact LLDB frontier:
- `EXC_BAD_ACCESS address=0x20`;
- RIP `0x00007ff804aeaa05`;
- frame0 `libobjc.A.dylib\`readClass(objc_class*, bool, bool) + 69`;
- instruction `movq 0x18(%rax), %r15`;
- `RAX=0x8`;
- `RBX=RDI=0x00007ff843d60620`;
- frame1 `map_images_nolock + 4170`.

Pinned objc4 source correlates `readClass()` with `cls->nonlazyMangledName() -> bits.safe_ro()->getName()`, so the +0x18 load is the class-ro name read and RAX=0x8 is invalid class-ro state.

Crucially, Metal preferred `__DATA` VM is `0x7FF843D59000`; fault class pointer `0x7FF843D60620` is `+0x7620` inside that preferred segment. LLDB reports standalone Metal slide `0xffff8008f1250000`, so the corresponding standalone runtime class address should be `0x0000000134FB0620`. At least one Objective-C internal class pointer therefore reaches libobjc in preferred shared-cache VM form instead of standalone-runtime-slid form.

Authoritative classifications:
- `D97CI_V2_D97CH_SETLOADED_FAULT_CLEARED=RUNTIME_PROVEN`;
- `D97CI_V2_NEW_READCLASS_FAULT=RUNTIME_PROVEN`;
- `D97CI_V2_CLASSLIST_OR_EQUIVALENT_INTERNAL_CLASS_POINTER_UNREBASED=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CI_V2_STANDALONE_CARRIER_HAS_REMAINING_SHARED_CACHE_RELOCATION_STATE=PROVEN_AT_LEAST_ONE_POINTER`.

Do not repair the single failing pointer ad hoc.

## D97CJ — ObjC relocation-topology audit ready
Run only `OCLP7_D97CJ_objc_relocation_topology_audit.sh`:
- bytes `48877`;
- SHA256 `7921c9923afaa7ca499d8c00a146ab215d5c4a0f0e33c5d244f68ac153cc056e`;
- shell syntax PASS;
- embedded main Python compile PASS;
- embedded LLDB-helper Python compile PASS;
- safety/cleanup scan PASS.

D97CJ applies no new functional Metal mutation. It retains only the already-proven D97CI one-bit clear, inventories all relevant ObjC pointer-bearing sections, and if the exact readClass fault persists it ties the runtime RBX to a static classlist entry, computes the expected standalone address using the actual Metal slide, reads the slid class/class_ro/name, and fails closed unless all gates agree.

A broad cache-origin relocation surface would favor abandoning standalone-carrier repair as the production path and instead preserving native shared-cache Metal while evaluating a selective 3802 runtime patch through Lilu/WhateverGreen-style userland/shared-cache patching. That alternative remains under evaluation, not yet final.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run only exact `OCLP7_D97CJ_objc_relocation_topology_audit.sh` and return its ZIP/output.

D97BV remains absent. No Root Patch, installation, local compilation, accelerated boot or reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
