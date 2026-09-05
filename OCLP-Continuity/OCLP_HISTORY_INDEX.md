# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CBV3_DYLD_DELAYED_FALSE_POSITIVE_D97CBV4_NEXT.md`.
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
- `__DATA_DIRTY` payload fileoff `0x35C000`;
- `__DATA` payload fileoff `0x361000`;
- `__LINKEDIT` remains `0x36E000`;
- command order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all VM addresses preserved;
- 5 section fileoff rewrites;
- 3652 symtab `n_sect` remaps;
- pre-sign diff `40655`, zero outside audited domains;
- `file`, `otool -l`, `otool -L` PASS.
Unsigned/signed preflight PASS; Python child actual `dlopen` `RC=-11` SIGSEGV, with standalone loadability still unresolved because Python already has native Metal loaded.

## D97CB-v2 — macOS copy2/chflags tooling defect
D97CB-v2 reconfirmed remap/preflight/SIGSEGV, then `shutil.copy2('/usr/bin/true', HOST)` failed in macOS Python 3.13 `copystat()->chflags` with PermissionError. Tooling-only.

## D97CB-v3 — cold host valid; delayed-state substring false positive
Returned Terminal paste:
- bytes `118929`;
- SHA256 `c8f3d4317fa1e4ad605fffd249f6abb18301df358d36be39f3f5502ae6529e2a`.

D97CB-v3 fixed host copying with `copyfile()` and successfully removed/replaced the signature; ad-hoc sign and strict verify PASS; baseline `/usr/bin/true` exited 0.

The baseline dyld trace initially prints both `/usr/lib/libbz2.1.0.dylib` and native Metal, but later logs:
- `move loaded to delayed: libbz2.1.0.dylib`;
- `move loaded to delayed: Metal`;
with no later reverse promotion.

Apple dyld `DyldRuntimeState.cpp` shows `move loaded to delayed` actually removes the loader from active `loaded` and pushes it into `delayLoaded`; `move delayed to loaded` is the reverse transition. Therefore v3's raw-substring check misclassified delayed closure members as active preload.

Classifications:
- `D97CBV3_COLD_HOST_COPY_AND_ADHOC_SIGN=PASS`;
- `D97CBV3_BASELINE_EXIT=PASS`;
- `D97CBV3_BASELINE_METAL_FINAL_STATE=DELAYED`;
- `D97CBV3_BASELINE_BZ2_FINAL_STATE=DELAYED`;
- `D97CBV3_FAIL_COLD_HOST_PRELOADS_METAL=TOOLING_FALSE_POSITIVE`;
- standalone loadability remains not yet proven.

No positive-control injection, remapped-Metal cold injection, or D97BV application occurred after the false-positive stop.

## CURRENT ACTION — D97CB-v4
Run only `OCLP7_D97CB_v4_dyld_final_state_cold_host.sh`, bytes `34857`, SHA256 `fa0e6fc5825a260be3c638bdb177c63378abd3adf44b08d0683a99d1e383a0be`.

V4 reproduces the identical remap and changes only trace classification. It computes final loader state after applying all `loaded -> delayed` / `delayed -> loaded` transitions. Baseline requires Metal/libbz2 not final-loaded. Control injection must end with libbz2 final-loaded and exit 0. Only then may signed remapped Metal be cold-injected. Explicit target path, target final state, system Metal final state and exit code are separate outputs. Only target final-loaded + exit 0 may authorize D97BV re-audit.

Remain unpatched in VESA. No Root Patch or accelerated reboot authorized.
