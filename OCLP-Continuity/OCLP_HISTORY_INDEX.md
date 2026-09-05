# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CBV2_MACOS_COPY2_CHFLAGS_TOOLING_FAIL_D97CBV3_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: `native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden / generation closure
Golden original selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches compositor success.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer: Builder A `[arg1+0x1C]`, Builder B `[arg1+0x38]`, native 3802 and 32023 lanes present, no 31001.
D97BP/BQ proved shared generation accessor and selector ABI arg2/RSI.
D97BT proved default-environment accessor-wide 3802 suppression; sole bypass explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`.

## Whole legacy Metal rejected
D97BJ/BK: full legacy `13.2.1-24/Metal.framework` shadows/removes Tahoe Metal4 superclass ABI. Accelerated boots reached WindowServer then failed in userspace. Permanent NEGATIVE.
D97BL: legacy `MTLCompilerService.xpc` may be bounded; legacy main Metal remains forbidden. Do not repeat unchanged native-Metal + legacy-XPC/private-compilers + true-five reboot.

## D97BV — selective 3802-preserve adapter
Patch window `0x7FF80F5E1719..0x7FF80F5E1726`; safe unsectioned cave `0x7FF80F47E560..0x7FF80F47E630`.
Site `3dda0e00007406e93bcee9ff90`; cave `3d187d0000b9177d00000f4cc1e9b4311600`.
Semantics: preserve exact 3802, otherwise execute original Tahoe floor. `STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 / D97BX — sparse analysis container closure
Sparse reconstruction preserved native code/Metal4 and D97BV diff, but real dlopen failed identically original/patched due shared-cache standalone mapping geometry. Signing and D97BV were not the blocker. Sparse mirror is analysis-only.

## D97BY — real DSC single-image export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` exports both succeed, preserve exact native Tahoe `__text` and Metal4 counts. Preflight/signing pass; real dlopen first rejects missing `SG_READ_ONLY` on `__DATA_CONST`.

## D97BZ — metadata SG_READ_ONLY gate passed
Only one effective pre-sign byte changed at `__DATA_CONST` flags (`0x00 -> 0x10`); previous dyld gate disappeared. New exact real dlopen rejection: `segment '__DATA_DIRTY' vm address out of order`.
Classification: `D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`.

## D97CA — segment-order dependency audit FULL PASS
Bundle SHA256 `90a9edb0abc2832a86db5c3d54c0429894844e56d6f258a91a7de93dfb40e1f0`.
D97CA proved current compact RAW file/load order `__TEXT,__DATA_CONST,__DATA,__DATA_DIRTY,__LINKEDIT` conflicts with VM order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`.
Dependency surface for coherent reorder:
- dyld segment-index rewrites: 0;
- relocation section-ordinal rewrites: 0;
- chained fixups absent;
- split-seg info absent;
- unknown order-sensitive loads: 0;
- file-backed section offsets: 5;
- symtab `n_sect` rewrites: 3652.
Classification: `D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## D97CB — atomic remap structural PASS
Target remap passed:
- `__DATA_CONST` has `SG_READ_ONLY`;
- `__DATA_DIRTY` payload moved to fileoff `0x35C000`;
- `__DATA` payload moved to fileoff `0x361000`;
- `__LINKEDIT` remains `0x36E000`;
- command order becomes `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all segment/section VM addresses preserved;
- exactly 5 file-backed section offsets rewritten;
- exactly 3652 symtab `n_sect` values remapped;
- pre-sign diff count `40655`, zero outside audited domains;
- `file`, `otool -l`, `otool -L` PASS.

Unsigned/signed `dlopen_preflight` PASS. Actual Python-child `dlopen` terminates `RC=-11` (SIGSEGV) rather than producing another explicit dyld validation rejection. Python already has native Metal loaded, so standalone loadability remains unresolved.

## D97CB-v2 — macOS Python copy2/chflags tooling defect
Returned Terminal log:
- bytes `13995`;
- SHA256 `fb053fe50bf85a803bcad582f7d1e6995ca0f14c4ca468c5de75e76b22a46d7b`.

D97CB-v2 reconfirmed every D97CB structural remap marker and again observed unsigned/signed preflight PASS plus actual child `dlopen RC=-11`.

The new cold-host harness failed before cold injection because `shutil.copy2('/usr/bin/true', HOST)` invokes `copystat()`, and macOS Python 3.13 attempted to propagate BSD file flags with `chflags`, producing `PermissionError: [Errno 1] Operation not permitted` on the `/private/tmp/.../cold_true` destination.

This is a tooling-only failure and does not invalidate the remap.

Classifications:
- `D97CBV2_ATOMIC_REMAP_STRUCTURAL=PASS_RECONFIRMED`;
- `D97CBV2_REMAP_UNSIGNED_SIGNED_PREFLIGHT=PASS_RECONFIRMED`;
- `D97CBV2_REMAP_CHILD_DLOPEN=SIGSEGV_NEGATIVE_RECONFIRMED`;
- `D97CBV2_COLD_HOST_COPY2_CHFLAGS=TOOLING_NEGATIVE`;
- `D97CBV2_REMAP_STANDALONE_LOADABILITY=NOT_YET_PROVEN`.

## CURRENT ACTION — D97CB-v3
Run only `OCLP7_D97CB_v3_macos_safe_cold_host.sh`, bytes `32508`, SHA256 `24f0b52509530700daa64eb2c9a2fcd882671acb4a4ff8b5f6570443c66918c1`.

D97CB-v3 changes only the cold-host copy from `shutil.copy2()` to `shutil.copyfile()` plus explicit `chmod(0755)`, avoiding metadata/BSD-file-flag copying. It then removes the copied signature, re-signs ad-hoc, requires a Metal-free baseline, validates `DYLD_INSERT_LIBRARIES` with a visible/exit-0 libbz2 control, and only then injects signed remapped Metal.

If target path appears but process fails, stop at that later init/runtime frontier and do not apply D97BV. Only target-path observed + host exit 0 authorizes D97BV re-audit.

Remain unpatched in VESA. No Root Patch or accelerated reboot authorized.
