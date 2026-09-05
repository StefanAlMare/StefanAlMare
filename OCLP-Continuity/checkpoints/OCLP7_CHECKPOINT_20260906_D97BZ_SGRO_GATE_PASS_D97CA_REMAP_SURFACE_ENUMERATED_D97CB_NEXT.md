# OCLP7 CHECKPOINT — 2026-09-06 — D97BZ SG_READ_ONLY gate passes; D97CA remap surface fully enumerated; D97CB next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; full legacy main Metal remains forbidden.
- No Root Patch or accelerated reboot authorized.

## D97BZ decisive result
Returned D97BZ metadata-only experiment set only `SG_READ_ONLY (0x10)` on the real exported RAW `__DATA_CONST` segment flags word.
- pre-sign binary diff was exactly one effective byte (`0x00 -> 0x10`) within that 32-bit field;
- unsigned and ad-hoc-signed `dlopen_preflight` passed;
- the previous dyld rejection `__DATA_CONST segment missing SG_READ_ONLY flag` disappeared;
- real child `dlopen` advanced to the next exact rejection:
  `segment '__DATA_DIRTY' vm address out of order`;
- no D97BV patch was applied because the original standalone baseline was still not real-loadable.

Authoritative classifications:
- `D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`;
- `D97BZ_REAL_DLOPEN=NEGATIVE_NEXT_GATE_DATA_DIRTY_VM_ADDRESS_OUT_OF_ORDER`.

## Why simple load-command permutation is insufficient
Current compact RAW segment order/file order:
`__TEXT -> __DATA_CONST -> __DATA -> __DATA_DIRTY -> __LINKEDIT`.

VM order is:
`__TEXT -> __DATA_CONST -> __DATA_DIRTY -> __DATA -> __LINKEDIT`.

Apple dyld source confirms non-cache dyld-managed binaries require load-command order to match both file order and VM order. Merely swapping the two segment commands would fix VM order but make file order wrong.

## D97CA returned evidence
Bundle: `OCLP7_D97CA_SEGMENT_ORDER_DEPENDENCY_AUDIT_20260906_014835.zip`
- bytes `84192`;
- SHA256 `90a9edb0abc2832a86db5c3d54c0429894844e56d6f258a91a7de93dfb40e1f0`.

D97CA reproduced exact RAW export and audited every order-sensitive surface before any mutation.

Exact segment identities:
- `__TEXT`: index 0, VM `0x7FF80F47D000`, fileoff `0x0`, filesize `0x2EC000`, sections 1..14;
- `__DATA_CONST`: index 1, VM `0x7FF84119DCD0`, fileoff `0x2EC000`, filesize `0x70000`, sections 15..29;
- `__DATA`: index 2, VM `0x7FF843D590C0`, fileoff `0x35C000`, filesize `0xD000`, sections 30..34;
- `__DATA_DIRTY`: index 3, VM `0x7FF84384F510`, fileoff `0x369000`, filesize `0x5000`, sections 35..38;
- `__LINKEDIT`: index 4, VM `0x7FF880000000`, fileoff `0x36E000`.

The two data payloads are contiguous and their combined size is unchanged, so a coherent physical file-order swap can keep `__LINKEDIT` at `0x36E000`.

## D97CA order-sensitive dependency closure
Proposed segment-index map for swapping `__DATA_DIRTY` before `__DATA`:
- old 2 -> new 3;
- old 3 -> new 2.

Proposed section ordinal map:
- old `30..34` (`__DATA`) -> new `34..38`;
- old `35..38` (`__DATA_DIRTY`) -> new `30..33`.

D97CA census:
- dyld rebase/bind segment-index references requiring rewrite: **0**;
- relocations requiring section-ordinal rewrite: **0**;
- `LC_DYLD_CHAINED_FIXUPS`: absent;
- `LC_SEGMENT_SPLIT_INFO`: absent;
- unknown order-sensitive loads: **0**;
- file-backed section offsets requiring rewrite after physical swap: **5**;
- symtab entries whose `n_sect` ordinal must be remapped: **3652**.

Exact affected symbol-ordinal counts:
- `30 -> 34`: 2236;
- `31 -> 35`: 404;
- `32 -> 36`: 305;
- `33 -> 37`: 127;
- `34 -> 38`: 9;
- `35 -> 30`: 440;
- `36 -> 31`: 25;
- `37 -> 32`: 101;
- `38 -> 33`: 5.

Authoritative classification:
`D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## Interpretation
The remap surface is finite and statically closed enough for one atomic temporary transformation:
1. retain all VM addresses and section VM addresses unchanged;
2. keep `SG_READ_ONLY` on `__DATA_CONST`;
3. physically place `__DATA_DIRTY` payload before `__DATA` payload;
4. swap the complete two `LC_SEGMENT_64` command blocks so load-command order becomes VM/file order;
5. update only their segment fileoffs and five file-backed section offsets;
6. remap exactly the 3652 affected symtab `n_sect` bytes according to the proven ordinal map;
7. do not alter `__LINKEDIT` fileoff, VM addresses, relocation payloads or dyld index streams.

No claim is made yet that this will be loadable. The next dyld gate may be shared-cache sub-page VM geometry or missing standalone fixups. Test only in a sacrificial child.

## CURRENT ACTION — D97CB
Remain unpatched in Tahoe VESA.

Next transient collector must reproduce the exact RAW export, apply the atomic order/file/symtab remap above only to a temp copy, prove every pre-sign diff belongs to the audited domains, run parser/segment-order/section-ordinal audits, then test unsigned and ad-hoc-signed real child `dlopen`.

Only if the remapped original is truly loaded as the explicit temp path may D97BV be re-audited/applied to a second temp copy.

Stop at the next exact dyld error. Do not alter VM addresses or section VM addresses automatically.

No Root Patch, installation, or accelerated reboot authorized.
