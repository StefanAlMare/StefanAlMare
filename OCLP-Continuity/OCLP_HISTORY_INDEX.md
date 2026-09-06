# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CI_V2_OBJC_OPT_FLAG_ADAPTER_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: `native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compilers may be bounded; legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic proven: preserve exact 3802, otherwise execute original Tahoe floor.
Pre-sign cave was `0x1560..0x1630`. D97CD later proved codesign consumes `0x1560..0x1570`; standalone D97BV requires a new cave audit.

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
4K page-prefix plan preserves original section/content VM addresses while page-aligning segment mapping starts/fileoffs. Exactly 20 section offsets; `__LINKEDIT +0x3000`; 7 total LINKEDIT metadata updates; no unknown blocker.

## D97CD — page-aligned standalone mapping succeeds; Objective-C frontier
Bundle SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient page-aligned Metal SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.
All five segments map; runtime reaches `makeSegmentsReadWrite`, then `RC=-11`.

## D97CE — --slide does not advance Objective-C frontier
SLIDE SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.
`--slide` changes `88012` bytes / `43909` qword chunks, heavily in ObjC/data metadata, but page-aligned SLIDE Metal reproduces exactly the D97CD boundary. `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`.

## D97CF — true single Metal still identical Objective-C SIGSEGV
Bundle SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.
Framework override is honored: temporary page-aligned SLIDE Metal loaded, native shared-cache Metal absent, no native-cache mapping, exactly one Metal path/UUID, `D97CF_TRUE_SINGLE_METAL=PASS`.
Runtime remains RW marker -> zero post-marker dyld lines -> `RC=-11`.
Classification: duplicate Metal is insufficient as current cause.

## D97CG — LLDB hook attempt tooling-negative
Bundle SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.
Ordinary frontier reconfirmed. LLDB `-K/--source-on-crash` not entered; RIP/frame0 unresolved. No Metal causal conclusion.

## D97CH — exact libobjc crash-site runtime proof and reproducibility
Original persisted bundle `OCLP7_D97CH_SINGLE_METAL_LLDB_EXPLICIT_SIGNAL_20260906_052600.zip`:
- bytes `246375`;
- SHA256 `d94d604f5675b72ac6e412e8d0bf593ed18ac6ff4f2e89dedfec59fe80c2433e`.

Newest rerun `OCLP7_D97CH_SINGLE_METAL_LLDB_EXPLICIT_SIGNAL_20260906_113939.zip`:
- bytes `246350`;
- SHA256 `ba05d9b299d52ce2f12ab817d9d88e4f1ee7da8e013fb9d9a18d05cbd314263d`;
- JSON SHA256 `20119a85eee200a790d57c494de9eaeb6ff1990e7c81f09e07b9fa9df0096544`;
- TXT SHA256 `a364ee7a980da9aa24e70087d5e0aa363445718d4cc1acbd8b2e6cc8ad47ac6e`.

Both explicit-signal LLDB runs preserve true-single-Metal and stop at:
- RIP `0x00007ff804ad9bba`;
- frame0 `libobjc.A.dylib\`map_images_nolock + 676`;
- instruction `orb $0x1,(%rcx)`;
- fault destination in RCX/RAX;
- same backtrace through Objective-C dyld notifier registration.
Fault destination differs only by ASLR (`0x7ff58e927008` vs `0x7ff58f8cf008`).

Apple objc4 source correlates the sequence with `header_info::setLoaded(true)` in `addHeader()`, immediately followed by `header_info::classlist`.
`setLoaded` writes through `getHeaderInfoRW()`. `getPreoptimizedHeaderRW(hdr)` uses shared-cache RW bookkeeping only when `hdr->info()->optimizedByDyld()` is true, then indexes `headerInfoROs` by `hdr`.
`objc_image_info::OptimizedByDyld = 1<<3 = 0x8`.

The standalone Metal uses a runtime-allocated header_info, making a retained cache-origin OptimizedByDyld bit the active bounded causal hypothesis.
Classifications:
- exact ObjC crash site runtime proven;
- same RIP/frame/instruction reproducible across independent runs;
- setLoaded source correlation established;
- OptimizedByDyld causality still requires exact flag audit + one-bit test.

## D97CI-v2 — one-bit ObjC cache-origin adapter runnable authority
The prior D97CI checkpoint recorded `OCLP7_D97CI_objc_optimizedbydyld_flag_adapter.sh`, bytes `37479`, SHA256 `10b0bdfb3deb5f7c3f0e7e73b766f7f14abe5e592d163fd2a80b62be03ee1360`. That exact script is not recoverable bit-identically from the active sandbox/repository and remains historical only.

Current runnable script:
`OCLP7_D97CI_v2_objc_optimizedbydyld_flag_adapter.sh`
- bytes `37177`;
- SHA256 `a8618edcf9143d0e8c99beafa695bdb7dbef98a1773f0d77ed3f2987f4c37dc5`;
- shell syntax PASS;
- embedded Python compile PASS;
- transient cleanup audit PASS.

D97CI-v2 reproduces exact SLIDE/page carrier, then locates one `__objc_imageinfo` and requires version 0 + flag `0x8` set. Only then it clears bit `0x8` in a transient copy, requires exactly one changed byte/XOR `0x08`, preserves section geometry/`__text`/Metal4, signs and verifies the bit remains clear, then reruns true-single-Metal. If nonzero, explicit-signal LLDB localizes the next fault and automatically compares frame0 to D97CH.

Automatic result semantics:
- exit 0 => flag clear strongly supported;
- exact D97CH frame persists => hypothesis NEGATIVE;
- different resolved frame0 => D97CH setLoaded fault cleared, later frontier reached;
- harness/debugger failure => INCONCLUSIVE.

## CURRENT ACTION
Remain unpatched VESA. Run exact `OCLP7_D97CI_v2_objc_optimizedbydyld_flag_adapter.sh` and return ZIP/output.

No D97BV, Root Patch, installation, local compilation, accelerated boot or reboot is authorized.
