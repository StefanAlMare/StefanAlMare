# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BZ_SGRO_GATE_PASS_D97CA_REMAP_SURFACE_ENUMERATED_D97CB_NEXT.md`.
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
Bundle SHA256 `c2517f1a3758fcbdabe0ab033a7bc7f07385aadf6f13f9369bb1cecb10fd2b53`.
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` exports both RC 0, each 5,722,944 bytes, preserving exact native Tahoe `__text` SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a` and exact Metal4 counts.
Preflight/signing pass; real dlopen first rejects `__DATA_CONST segment missing SG_READ_ONLY flag`.

## D97BZ — metadata SG_READ_ONLY gate passed
Bundle `OCLP7_D97BZ_SG_READ_ONLY_METADATA_GATE_20260906_013542.zip`, SHA256 `efe3bc569e6be515a6a1d7d2742589785e4329527b2a10656626169fb70952ee`.
Only one effective pre-sign byte changed at `__DATA_CONST` flags (`0x00 -> 0x10`); zero diff outside flags field. Previous dyld gate disappeared.
New exact real dlopen rejection: `segment '__DATA_DIRTY' vm address out of order`.
Classification: `D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`.

## D97CA — segment-order dependency audit FULL PASS
Bundle `OCLP7_D97CA_SEGMENT_ORDER_DEPENDENCY_AUDIT_20260906_014835.zip`:
- bytes `84192`;
- SHA256 `90a9edb0abc2832a86db5c3d54c0429894844e56d6f258a91a7de93dfb40e1f0`.

D97CA proved current compact RAW file/load order is `__TEXT, __DATA_CONST, __DATA, __DATA_DIRTY, __LINKEDIT`, while VM order is `__TEXT, __DATA_CONST, __DATA_DIRTY, __DATA, __LINKEDIT`. Apple dyld requires non-cache managed segment command order to agree with both file and VM order.

Exact affected geometry:
- `__DATA`: old index 2, fileoff `0x35C000`, size `0xD000`, sections 30..34;
- `__DATA_DIRTY`: old index 3, fileoff `0x369000`, size `0x5000`, sections 35..38;
- combined end remains `0x36E000`, so `__LINKEDIT` need not move.

Proposed ordinal map: old `30..34 -> 34..38`; old `35..38 -> 30..33`.
D97CA dependency census:
- dyld segment-index rewrites needed: 0;
- relocation section-ordinal rewrites: 0;
- chained fixups absent;
- split-seg info absent;
- unknown order-sensitive loads: 0;
- file-backed section offsets to rewrite: 5;
- symtab `n_sect` rewrites: 3652.

Affected symtab counts: `30->34` 2236; `31->35` 404; `32->36` 305; `33->37` 127; `34->38` 9; `35->30` 440; `36->31` 25; `37->32` 101; `38->33` 5.

Classification: `D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## CURRENT ACTION — D97CB
Remain unpatched in Tahoe VESA.
D97CB may perform one atomic temporary standalone-layout remap only: set SG_READ_ONLY, physically place `__DATA_DIRTY` before `__DATA`, swap their complete segment command blocks, update two segment fileoffs plus five file-backed section offsets, remap exactly 3652 symtab `n_sect` bytes, preserve every VM/section VM address, keep `__LINKEDIT` at `0x36E000`, prove diff boundaries, then test parser/order invariants and unsigned/signed real child dlopen.

Only if the explicit temp path truly loads may D97BV be re-audited/applied. Stop at the next exact dyld/runtime error. Do not automatically reconstruct fixup streams or move VM addresses.

No Root Patch or accelerated reboot authorized.
