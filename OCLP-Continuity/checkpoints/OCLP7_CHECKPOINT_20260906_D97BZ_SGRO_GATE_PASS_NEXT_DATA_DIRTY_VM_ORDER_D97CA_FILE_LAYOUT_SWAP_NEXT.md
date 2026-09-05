# OCLP7 CHECKPOINT — 2026-09-06 — D97BZ SG_READ_ONLY gate passed; next dyld rejection is __DATA_DIRTY VM order; D97CA next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; legacy main Metal shadow remains forbidden.
- No Root Patch or accelerated reboot authorized.

## Returned D97BZ evidence
Bundle:
`OCLP7_D97BZ_SG_READ_ONLY_METADATA_GATE_20260906_013542.zip`
- bytes `4013`;
- SHA256 `efe3bc569e6be515a6a1d7d2742589785e4329527b2a10656626169fb70952ee`;
- TXT bytes `6256`, SHA256 `65696bca289f6d9e9a64f556a2b7196ae47e03454a00dedaccf0c110f17df6f0`;
- JSON bytes `4031`, SHA256 `289f8afec996ea29024ff36dbebd13406597b3db70bc05524c5a44b13d019c1c`.

ZIP contains only report TXT/JSON. Collector reported transient extractor and Apple-binary cleanup PASS; no system/cache mutation, installation, local compilation, Root Patch or reboot occurred.

## Exact RAW real-export identity revalidated
- RAW bytes `5722944`;
- RAW SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`;
- exact native Tahoe `__text` relative offset `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- all six native Metal4 string counts exactly retained.

Segment geometry before D97BZ metadata change:
- `__TEXT`: VM `0x7FF80F47D000`, fileoff `0x0`, filesize `0x2EC000`, flags `0`;
- `__DATA_CONST`: VM `0x7FF84119DCD0`, fileoff `0x2EC000`, filesize `0x70000`, flags `0`;
- `__DATA`: VM `0x7FF843D590C0`, fileoff `0x35C000`, filesize `0xD000`, flags `0`;
- `__DATA_DIRTY`: VM `0x7FF84384F510`, fileoff `0x369000`, filesize `0x5000`, flags `0`;
- `__LINKEDIT`: VM `0x7FF880000000`, fileoff `0x36E000`, filesize `0x207340`.

## D97BZ SG_READ_ONLY metadata-only mutation — exact bounded PASS
`__DATA_CONST` segment flags word is at file offset `0x50C`.
D97BZ changed only:
`flags 0x0 -> 0x10 (SG_READ_ONLY)`.

Pre-sign diff:
- differing bytes `1`;
- exact diff offset `0x50C`;
- differences outside the 32-bit flags word `0`.

Classification:
`D97BZ_SG_READ_ONLY_METADATA_ONLY_DIFF_BOUNDARY=STATIC_PROVEN`.

## SG_READ_ONLY gate itself is closed
After setting `SG_READ_ONLY`:
- unsigned `dlopen_preflight` PASS;
- ad-hoc signing PASS;
- strict signature verification PASS;
- signed `dlopen_preflight` PASS.

The previous D97BY first rejection `__DATA_CONST segment missing SG_READ_ONLY flag` disappears completely.

Therefore:
`D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`.

## New exact first dyld rejection
Real child `dlopen` remains negative both unsigned and signed, now with exact error:
`segment '__DATA_DIRTY' vm address out of order`.

Child image census proves this is not a coalesced-success ambiguity:
- target temp path absent before load;
- `DLOPEN_HANDLE=NULL`;
- image count unchanged `346 -> 346`;
- target path absent after load;
- no new images.

Classification:
`D97BZ_REAL_DLOPEN=NEGATIVE_NEXT_GATE_DATA_DIRTY_VM_ADDRESS_OUT_OF_ORDER`.

D97BV remained correctly unapplied because the original metadata-fixed baseline is not yet truly loadable.

## Why the next gate occurs
Current exported load-command/file order is:
`__TEXT -> __DATA_CONST -> __DATA -> __DATA_DIRTY -> __LINKEDIT`.

VM order is instead:
`__TEXT -> __DATA_CONST -> __DATA_DIRTY -> __DATA -> __LINKEDIT`, because:
- `__DATA_DIRTY` VM `0x7FF84384F510`;
- `__DATA` VM `0x7FF843D590C0`.

Apple dyld source `mach_o/UnsafeHeader.cpp` validates that for dyld-managed non-cache images segment load-command order must match both file-content order and VM order. It first rejects decreasing file offsets, then rejects decreasing VM addresses with `segment '%s' vm address out of order` (except narrow legacy exceptions not applicable to this dylib).

Therefore merely reordering load commands is insufficient: it would repair VM order but create fileoff order failure.

## Next bounded repair hypothesis
The smallest coherent next standalone-layout adapter is file-layout-only:
1. keep every segment VM address and every section VM address unchanged;
2. keep `__TEXT`, `__DATA_CONST`, `__LINKEDIT` file layout unchanged;
3. physically place `__DATA_DIRTY` payload before `__DATA` payload;
4. set `__DATA_DIRTY.fileoff = 0x35C000`;
5. set `__DATA.fileoff = 0x361000`;
6. remap nonzero section file offsets inside those two segments by preserving each section's relative offset within its owning segment;
7. reorder the complete `LC_SEGMENT_64` commands so `__DATA_DIRTY` precedes `__DATA` while preserving all command bytes/sections except required fileoff/section-offset fields;
8. `__LINKEDIT` remains at `0x36E000` because `0x5000 + 0xD000 = 0x12000`, exactly the same combined span.

This preserves virtual-address semantics and therefore x86_64 RIP-relative relationships; it changes only standalone file geometry/load-command order needed by dyld.

Do not alter VM addresses or section addresses in this experiment.

## CURRENT ACTION — D97CA
Remain unpatched in Tahoe VESA.

Next transient test must reproduce the pinned RAW real export, apply `SG_READ_ONLY`, then build one file-layout-only variant that swaps `__DATA_DIRTY`/`__DATA` physical order and complete segment-load-command order while keeping all VM/section addresses unchanged. It must audit every changed byte/field, verify section-relative fileoff preservation, run `file`/`otool`, unsigned and signed preflight + true child `dlopen`, and stop at the next exact dyld condition.

Only if that original layout-fixed baseline truly loads may D97BV be re-audited/applied.

No Root Patch, installation or accelerated reboot authorized.