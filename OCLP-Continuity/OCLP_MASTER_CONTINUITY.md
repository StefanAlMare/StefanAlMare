# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CI_OBJC_OPT_FLAG_ADAPTER_READY.md`
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

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- no repeat of historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Exact target Metallib package remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Native producer / D97BV closure
Native Tahoe Metal cache base `0x7FF80F47D000`; native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`; native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`. Native 3802 and 32023 lanes exist; no 31001.
D97BT proved default-environment 3802 suppression to 32023/32024.
D97BV selective adapter remains static-semantic proven, but D97CD proved codesign consumes `0x1560..0x1570` of the former cave. D97BV remains unauthorized pending a fresh signed-cave audit.

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

## D97CH — exact libobjc crash localized
Bundle `OCLP7_D97CH_SINGLE_METAL_LLDB_EXPLICIT_SIGNAL_20260906_052600.zip`:
- bytes `246375`;
- SHA256 `d94d604f5675b72ac6e412e8d0bf593ed18ac6ff4f2e89dedfec59fe80c2433e`.
TXT SHA256 `001679e65ef84fa4106a695d4707b735b2c6d89f15a8eabe4db2e48fa18d45c4`; JSON SHA256 `33c50f5a39b5aaf540102ab9285b26aef24996a914f7d4465bb55868ef9d9a71`.

D97CH explicit signal handling succeeds:
- `D97CH_LLDB_TRUE_SINGLE_METAL=PASS`;
- inferior stopped on `EXC_BAD_ACCESS`;
- fault address `0x7ff58e927008`;
- RIP `0x00007ff804ad9bba`;
- frame0 `libobjc.A.dylib\`map_images_nolock + 676`;
- fault instruction `orb $0x1,(%rcx)`;
- `RCX=RAX=0x7ff58e927008`.

Backtrace is `map_images_nolock -> map_images -> dyld ObjC notifier -> setObjCNotifiers -> _dyld_objc_register_callbacks -> _objc_init`.
This proves the active failure is in libobjc Objective-C image registration.

Apple objc4 source correlates the faulting write with `header_info::setLoaded(true)` in `addHeader()`: that call is immediately followed by `header_info::classlist`, matching D97CH machine code.
`header_info::setLoaded()` writes through `getHeaderInfoRW()`.
`getPreoptimizedHeaderRW(hdr)` is taken only when `hdr->info()->optimizedByDyld()` is true; it then assumes `hdr` belongs to shared-cache `headerInfoROs`, computes `headerInfoROs->index(hdr)`, and returns a shared-cache `header_info_rw` entry.
`objc_image_info::OptimizedByDyld = 1<<3 = 0x8`.

D97CH's standalone Metal has a runtime-allocated `header_info`; retaining the shared-cache `OptimizedByDyld` flag is therefore the current exact bounded causal hypothesis for the invalid setLoaded pointer. Exact flag presence still requires on-host proof before mutation.

Authoritative classifications:
- `D97CH_TRUE_SINGLE_METAL_BAD_ACCESS_PC_BACKTRACE_CAPTURED=RUNTIME_PROVEN`;
- `D97CH_CRASH_SITE_LIBOBJC_MAP_IMAGES_NOLOCK_SETLOADED_WRITE=RUNTIME_SOURCE_CORRELATED`;
- `D97CH_OBJC_OPTIMIZED_BY_DYLD_FLAG_CAUSALITY=HYPOTHESIS_REQUIRES_EXACT_FLAG_AUDIT_AND_BOUNDED_TEST`.

## D97CI — ObjC OptimizedByDyld flag adapter ready
Run only `OCLP7_D97CI_objc_optimizedbydyld_flag_adapter.sh`:
- bytes `37479`;
- SHA256 `10b0bdfb3deb5f7c3f0e7e73b766f7f14abe5e592d163fd2a80b62be03ee1360`;
- zsh syntax PASS;
- embedded Python compile PASS.

D97CI reproduces the exact proven pre-adapter SLIDE-page transform SHA `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`, then:
1. locates exactly one `__objc_imageinfo`;
2. prints version/flags and requires version 0 + `OptimizedByDyld (0x8)` set;
3. creates a transient copy clearing only bit `0x8`;
4. requires exactly one changed byte with XOR `0x08`, unchanged `__text` and Metal4;
5. signs and verifies the bit remains clear;
6. reruns proven cold host + framework override and requires true single Metal for causality;
7. if nonzero, runs explicit-signal LLDB and compares the new frame0 with D97CH.

Automatic causality:
- exit 0 => flag-clear strongly supported;
- different resolved frame0 => D97CH setLoaded fault cleared, later frontier reached;
- exact `map_images_nolock + 676` persists => hypothesis NEGATIVE;
- harness/single-Metal failure => INCONCLUSIVE.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run only exact D97CI and return its ZIP/output.

D97BV remains absent. No Root Patch, installation, local compilation, accelerated boot or reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.