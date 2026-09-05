# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97BZ_SGRO_GATE_PASS_NEXT_DATA_DIRTY_VM_ORDER_D97CA_FILE_LAYOUT_SWAP_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

Current target:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden producer / selector closure
Golden primary builder uses `[arg1+0x20] -> llvmVersion`; Golden original service maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both 3802 and 32023 and reaches compositor success.

## D97AA — failing Tahoe generation cohort
Accelerated Tahoe cohort: 12/12 observed requests `llvmVersion=32023`; 3802=0; other=0.

## D97BJ / BK — whole legacy Metal rejected
Full legacy `13.2.1-24/Metal.framework` removed Tahoe Metal4 superclass ABI. Accelerated boots reached WindowServer, then critical userspace services failed and launchd shut down. Permanent NEGATIVE: legacy main Metal cannot shadow Tahoe cache Metal.

## D97BL — native-Metal selective hybrid rule
Legacy `MTLCompilerService.xpc` can be bounded; legacy main Metal remains forbidden. Historical native-Metal + legacy-XPC/private-compilers + unchanged true-five already failed and must not be repeated unchanged.

## D97BM / BN / BO — native producer mapping
Native Tahoe Metal start `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`.
Native generation census contains 3802 and 32023, no 31001.
3802 and 32023 singleton lanes exist; selector distinguishes 3802/3902/32023/32024.

## D97BP / BQ — shared generation architecture
Shared accessor `0x7FF80F5E16C3..0x7FF80F5E1778` feeds the constructor discriminator and all six validated selector call sites. Selector generation argument is ABI arg2/RSI.

## D97BR / BS / BT — default 3802 suppression proven
Primary accessor floor converts 3802 to 32023. Lazy fallbacks floor to 32023/32024. Sole bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`; current/default value zero.

Classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BU / BV — selective 3802-preserve adapter
Exact patch window `0x7FF80F5E1719..0x7FF80F5E1726`, original bytes `3d187d0000b9177d00000f4cc1`.
Safe executable unsectioned cave `0x7FF80F47E560..0x7FF80F47E630`, 208 zero bytes.

Exact adapter:
- site `3dda0e00007406e93bcee9ff90`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`.

Semantics: preserve exact 3802; every other input executes original Tahoe floor unchanged.
Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## D97BW-v2 / D97BX — sparse analysis container closure
Sparse reconstruction preserved native code/Metal4 and exact D97BV diff. Structural parsers and preflight passed, signing passed, but real `dlopen` failed identically for original/patched due shared-cache segment geometry. D97BV is not the loadability regression; sparse mirroring is not deployable.

## D97BY — real DSC export, first standalone dyld gate
Bundle `OCLP7_D97BY_REAL_DSC_SINGLE_IMAGE_EXPORT_20260906_012127.zip`, SHA256 `c2517f1a3758fcbdabe0ab033a7bc7f07385aadf6f13f9369bb1cecb10fd2b53`.

Pinned extractor: `blacktop/ipsw v3.1.713`; checksum manifest SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`; macOS x86_64 asset SHA256 `7f5719d0a2a53996fca4dba4826aa015a6ddecfbba822a21e92400a80da7f1ab`; transient ipsw SHA256 `d02498ccd0a88e0afc461cbfd5f4a9df34a6194386595226b10a9a46fe078d6a`.

RAW and `--slide` export RC 0, each 5,722,944 bytes. Both preserve exact native Tahoe `__text` (rel `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`) and exact Metal4 counts.

Unsigned/signed preflight and ad-hoc signing pass. Real child `dlopen` first rejects both with:
`__DATA_CONST segment missing SG_READ_ONLY flag`.

## D97BZ — SG_READ_ONLY gate closed, VM-order gate exposed
Bundle:
`OCLP7_D97BZ_SG_READ_ONLY_METADATA_GATE_20260906_013542.zip`
- bytes `4013`;
- SHA256 `efe3bc569e6be515a6a1d7d2742589785e4329527b2a10656626169fb70952ee`;
- TXT SHA256 `65696bca289f6d9e9a64f556a2b7196ae47e03454a00dedaccf0c110f17df6f0`;
- JSON SHA256 `289f8afec996ea29024ff36dbebd13406597b3db70bc05524c5a44b13d019c1c`.

D97BZ reproduced exact RAW export and changed only `__DATA_CONST` flags at file offset `0x50C`: `0x0 -> 0x10 (SG_READ_ONLY)`. Pre-sign binary diff contained exactly one changed byte and zero differences outside that 32-bit flags word.

After the fix:
- unsigned preflight PASS;
- ad-hoc signing/strict verify PASS;
- signed preflight PASS;
- prior missing-SG_READ_ONLY rejection disappears.

Classification:
`D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`.

Real child `dlopen` now fails at the next exact condition:
`segment '__DATA_DIRTY' vm address out of order`.
Handle remains NULL, target temp path is not loaded, image count unchanged.

Export load/file order:
`__TEXT -> __DATA_CONST -> __DATA -> __DATA_DIRTY -> __LINKEDIT`.
VM order:
`__TEXT -> __DATA_CONST -> __DATA_DIRTY -> __DATA -> __LINKEDIT`.

Apple dyld source confirms non-cache dyld-managed images require segment load-command order to agree with file order and VM order. Merely swapping load commands would repair VM order but violate fileoff order.

## D97CA methodology correction — audit dependencies before any segment swap
A full segment reorder changes old segment indices 2/3 and section ordinals for all `__DATA`/`__DATA_DIRTY` sections. Exported linkedit retains dyld rebase/bind streams and symbol/relocation metadata that can encode those indices/ordinals. Therefore blind segment/load-command swapping is rejected as not statically closed.

Prepared read-only collector:
`OCLP7_D97CA_segment_order_dependency_audit.sh`
- bytes `24666`;
- SHA256 `237b1f93cb1255cb0d5d56aeeb3db7442971e69c03a5a6706f6f66ba73a991ce`.

D97CA will census load-command/segment order, section ordinal remaps, dyld rebase/bind segment-index references, symtab `n_sect`, relocation section ordinals, and split-seg/chained-fixup or other explicit order-sensitive blockers. It performs no binary mutation.

## CURRENT ACTION — D97CA
Remain unpatched in Tahoe VESA. Run only D97CA and return its ZIP.

Only if the complete remap surface is bounded may a later test reorder `__DATA_DIRTY`/`__DATA` file/load-command geometry while preserving VM/section addresses and coherently remapping every affected metadata reference.

No Root Patch or accelerated reboot authorized.