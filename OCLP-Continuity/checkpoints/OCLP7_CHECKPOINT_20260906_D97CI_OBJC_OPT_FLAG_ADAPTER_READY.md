# OCLP7 CHECKPOINT — 2026-09-06 — D97CI ObjC OptimizedByDyld flag adapter ready

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CH_EXACT_OBJC_SETLOADED_FAULT.md`.

## Retained D97CH closure
D97CH exact runtime evidence:
- true single Metal preserved under LLDB;
- `EXC_BAD_ACCESS` at `0x7ff58e927008`;
- RIP `0x00007ff804ad9bba`;
- frame 0 `libobjc.A.dylib\`map_images_nolock + 676`;
- fault instruction `orb $0x1,(%rcx)` with `RCX=0x7ff58e927008`;
- next instructions call `header_info::classlist`, matching Apple source `addHeader()` immediately after `hi->setLoaded(true)`.

Apple objc4 source correlation:
- `header_info::setLoaded()` writes through `getHeaderInfoRW()`;
- `getPreoptimizedHeaderRW(hdr)` returns nullptr unless `hdr->info()->optimizedByDyld()` is true;
- if true, it assumes `hdr` belongs to shared-cache `headerInfoROs`, calculates `headerInfoROs->index(hdr)`, and returns the corresponding `objc_debug_headerInfoRWs` entry;
- `objc_image_info::OptimizedByDyld = 1<<3 = 0x8` and denotes an optimized shared-cache image.

The standalone extracted Metal uses a runtime-allocated `header_info`. Therefore a retained `OptimizedByDyld` flag is the current bounded causal hypothesis for the invalid `setLoaded` write. Exact flag presence must be proven on-host before mutation.

## D97CI script identity
Run only:
`OCLP7_D97CI_objc_optimizedbydyld_flag_adapter.sh`
- bytes `37479`;
- SHA256 `10b0bdfb3deb5f7c3f0e7e73b766f7f14abe5e592d163fd2a80b62be03ee1360`;
- zsh syntax PASS;
- embedded Python compile PASS.

## D97CI exact methodology
D97CI:
1. pins Tahoe `26.6.2 / 25G82`, VESA, native service SHA and pinned `ipsw v3.1.713`;
2. reproduces exact SLIDE SHA `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`;
3. reconstructs exact proven page-aligned carrier and requires pre-adapter transform SHA `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`;
4. locates exactly one `__objc_imageinfo`, prints segment/address/fileoff/size/version/flags;
5. requires version `0` and `OptimizedByDyld (0x8)` present; otherwise FAIL-CLOSED without mutation conclusion;
6. creates a transient copy clearing only bit `0x8` in the 32-bit image-info flags;
7. requires exactly one changed byte and exact XOR `0x08`, while native `__text` and Metal4 counts remain unchanged;
8. signs the temporary framework target and verifies the bit remains cleared after codesign;
9. uses the proven cold host + libbz2 positive control and D97CF framework override; requires true single Metal for causal inference;
10. if process does not exit 0, reuses explicit-signal LLDB to capture the next PC/backtrace/registers and compare frame #0 directly with D97CH.

Automatic causality labels:
- process exit 0: flag-clear strongly supported;
- different resolved frame #0: D97CH `setLoaded` fault cleared and a later fault reached;
- exact `map_images_nolock + 676` persists: hypothesis NEGATIVE;
- debugger/single-Metal failure: INCONCLUSIVE.

## Safety
All Apple-derived binaries are temporary under `/private/tmp` and deleted before TXT/JSON-only packaging. No Apple binary in ZIP. No D97BV, Root Patch, installation, local compilation, accelerated boot or reboot.

## CURRENT ACTION
Remain unpatched in Tahoe VESA. Run exact D97CI and return ZIP/output.