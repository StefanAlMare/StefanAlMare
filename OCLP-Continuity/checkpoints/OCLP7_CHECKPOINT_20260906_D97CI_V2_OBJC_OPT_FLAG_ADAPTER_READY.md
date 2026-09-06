# OCLP7 CHECKPOINT — 2026-09-06 — D97CI-v2 ObjC OptimizedByDyld one-bit adapter ready

Authority: supersedes prospectively `OCLP7_CHECKPOINT_20260906_D97CI_OBJC_OPT_FLAG_ADAPTER_READY.md` as the runnable checkpoint. The older D97CI identity remains historical but its exact script artifact is not recoverable bit-identically from the active sandbox/repository, so it must not be substituted under the old SHA.

## State / safety
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- No D97BV, Root Patch, installation, local compilation, accelerated boot or reboot is authorized.
- All Apple-derived binaries in D97CI-v2 are transient under `/private/tmp` and deleted before TXT/JSON-only packaging.

## D97CH reproducibility closure
The newest user-returned bundle is:
`OCLP7_D97CH_SINGLE_METAL_LLDB_EXPLICIT_SIGNAL_20260906_113939.zip`
- bytes `246350`;
- SHA256 `ba05d9b299d52ce2f12ab817d9d88e4f1ee7da8e013fb9d9a18d05cbd314263d`;
- JSON bytes `766468`, SHA256 `20119a85eee200a790d57c494de9eaeb6ff1990e7c81f09e07b9fa9df0096544`;
- TXT bytes `717024`, SHA256 `a364ee7a980da9aa24e70087d5e0aa363445718d4cc1acbd8b2e6cc8ad47ac6e`.

It independently reproduces the prior D97CH result:
- `D97CH_LLDB_TRUE_SINGLE_METAL=PASS`;
- inferior stopped on `EXC_BAD_ACCESS`;
- RIP `0x00007ff804ad9bba`;
- frame #0 `libobjc.A.dylib\`map_images_nolock + 676`;
- fault instruction `orb $0x1,(%rcx)`;
- `RAX=RCX=0x7ff58f8cf008` in the new run;
- `R13=0x600003484000`;
- same control stack into libobjc/dyld Objective-C registration;
- only the fault address changed versus the earlier run, consistently with ASLR.

Thus the crash site is reproducible, not incidental.

## Exact source correlation
Pinned public sources:
- `apple-oss-distributions/objc4` commit `fb265098298302243cd7eeaa1f63f0ba7786dd9a`;
- `apple-oss-distributions/dyld` commit `fd8d0c4d52320ebf64db34f3cb280310d905c5ae`.

The D97CH machine-code sequence matches `addHeader()` in `runtime/objc-os.mm`: `hi->setLoaded(true)` immediately precedes `hi->classlist(&count)`.

`header_info::setLoaded()` calls `getHeaderInfoRW()->setLoaded(v)`.
`getHeaderInfoRW()` first calls `getPreoptimizedHeaderRW(this)` and otherwise uses local `rw_data[0]`.
`getPreoptimizedHeaderRW(hdr)` returns nullptr unless `hdr->info()->optimizedByDyld()` is true; if true it indexes shared-cache `headerInfoROs` and returns an entry in `objc_debug_headerInfoRWs`.
`header_info_rw::setLoaded()` sets bit 0 through the faulting byte write.

`objc_image_info::OptimizedByDyld = 1<<3 = 0x8` and denotes an image from an optimized shared cache.

The standalone exported Metal has a runtime-allocated `header_info`; retaining the cache-only `OptimizedByDyld` bit is therefore the active bounded causal hypothesis for the invalid `setLoaded` destination. This remains a hypothesis until the exact bit is proven present and the one-bit clear test is executed.

## Old D97CI artifact status
The prior checkpoint recorded:
`OCLP7_D97CI_objc_optimizedbydyld_flag_adapter.sh`
- bytes `37479`;
- SHA256 `10b0bdfb3deb5f7c3f0e7e73b766f7f14abe5e592d163fd2a80b62be03ee1360`.

That exact script is not present in the active sandbox or repository and could not be recovered bit-identically. Its identity remains historical only. Do not present another file under that SHA.

## D97CI-v2 runnable identity
Run only:
`OCLP7_D97CI_v2_objc_optimizedbydyld_flag_adapter.sh`
- bytes `37177`;
- SHA256 `a8618edcf9143d0e8c99beafa695bdb7dbef98a1773f0d77ed3f2987f4c37dc5`;
- shell syntax PASS;
- embedded Python compile PASS;
- transient cleanup audit PASS.

## D97CI-v2 exact methodology
D97CI-v2:
1. pins Tahoe `26.6.2 / 25G82`, VESA, native service SHA and pinned `ipsw v3.1.713`;
2. reproduces exact SLIDE SHA `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`;
3. reconstructs the exact proven page-aligned pre-adapter carrier and hard-requires SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`;
4. locates exactly one `__objc_imageinfo`, prints segment/address/fileoff/size/version/flags, and requires version `0` plus `OptimizedByDyld (0x8)` set;
5. if that precondition is absent, fails closed and makes no mutation conclusion;
6. creates a transient copy and clears only bit `0x8` in the 32-bit ObjC image-info flags;
7. requires unchanged byte length, exactly one changed byte at imageinfo flags byte 0, exact XOR `0x08`, unchanged section geometry, unchanged native `__text` SHA and unchanged Metal4 counts;
8. signs the adapted temporary framework target and re-verifies version `0` and bit `0x8` still clear after codesign;
9. runs the proven cold host and libbz2 positive control;
10. runs canonical Metal insertion plus `DYLD_FRAMEWORK_PATH` and requires true single Metal for causal inference;
11. if the process exits 0, records the strongest positive result;
12. otherwise, if true single Metal is preserved, runs explicit-signal LLDB for SIGSEGV/SIGBUS/SIGABRT/SIGILL and records RIP/frame0/fault address/backtrace;
13. compares resolved frame #0 directly with the exact D97CH `libobjc.A.dylib\`map_images_nolock + 676` fault.

Automatic causal classifications:
- `FLAG_CLEAR_PROCESS_EXIT_0_STRONGLY_SUPPORTED`;
- `FLAG_CLEAR_HYPOTHESIS_NEGATIVE_SAME_D97CH_SETLOADED_FAULT`;
- `FLAG_CLEAR_CLEARED_D97CH_SETLOADED_FAULT_NEW_FRONTIER_REACHED`;
- explicit INCONCLUSIVE labels on harness/debugger failure.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run only exact `OCLP7_D97CI_v2_objc_optimizedbydyld_flag_adapter.sh` above and return its ZIP/output.
