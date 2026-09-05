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
- previous dyld rejection `__DATA_CONST segment missing SG_READ_ONLY flag` disappeared;
- real child `dlopen` advanced to `segment '__DATA_DIRTY' vm address out of order`;
- no D97BV patch was applied because the original standalone baseline remained not real-loadable.

Classifications:
- `D97BZ_DYLD_SG_READ_ONLY_GATE=PASSED_BY_EXACT_METADATA_FIX`;
- `D97BZ_REAL_DLOPEN=NEGATIVE_NEXT_GATE_DATA_DIRTY_VM_ADDRESS_OUT_OF_ORDER`.

## D97CA returned evidence
Bundle `OCLP7_D97CA_SEGMENT_ORDER_DEPENDENCY_AUDIT_20260906_014835.zip`:
- bytes `84192`;
- SHA256 `90a9edb0abc2832a86db5c3d54c0429894844e56d6f258a91a7de93dfb40e1f0`.

Current RAW order/file order:
`__TEXT -> __DATA_CONST -> __DATA -> __DATA_DIRTY -> __LINKEDIT`.
VM order:
`__TEXT -> __DATA_CONST -> __DATA_DIRTY -> __DATA -> __LINKEDIT`.

Exact geometry:
- `__DATA`: index 2, VM `0x7FF843D590C0`, fileoff `0x35C000`, filesize `0xD000`, command `0x9C0..0xB98`, sections 30..34;
- `__DATA_DIRTY`: index 3, VM `0x7FF84384F510`, fileoff `0x369000`, filesize `0x5000`, command `0xB98..0xD20`, sections 35..38;
- `__LINKEDIT`: fileoff `0x36E000`.

The two data payloads are contiguous and combined size is unchanged, so a physical file-order swap can keep `__LINKEDIT` fixed.

## D97CA dependency closure
Required ordinal map:
- old `30..34` (`__DATA`) -> new `34..38`;
- old `35..38` (`__DATA_DIRTY`) -> new `30..33`.

Census:
- dyld rebase/bind segment-index rewrites: **0**;
- relocation section-ordinal rewrites: **0**;
- `LC_DYLD_CHAINED_FIXUPS`: absent;
- `LC_SEGMENT_SPLIT_INFO`: absent;
- unknown order-sensitive loads: **0**;
- file-backed section offsets to rewrite: **5**;
- symtab `n_sect` rewrites: **3652**.

Affected symbol counts:
`30->34` 2236; `31->35` 404; `32->36` 305; `33->37` 127; `34->38` 9; `35->30` 440; `36->31` 25; `37->32` 101; `38->33` 5.

Classification:
`D97CA_MANUAL_SEGMENT_ORDER_REPAIR_CLASSIFICATION=STATIC_REMAP_SURFACE_ENUMERATED`.

## D97CB exact collector identity
Artifact:
`OCLP7_D97CB_atomic_segment_order_remap.sh`
- bytes `30519`;
- SHA256 `bc82e73935714003a0daaa4d8c5fe9259831f1afbe422fc25f73f83d70d65b2d`;
- shell syntax PASS;
- embedded Python compile PASS.

D97CB adds a stronger cold-load proof: a verified pinned `ipsw` binary copy is ad-hoc re-signed under `/private/tmp` and used as a host with `DYLD_INSERT_LIBRARIES=<temporary Metal>`. Success requires both normal process exit and explicit appearance of the temporary Metal path in dyld print output. This avoids false success through a Python process that may already have native Metal loaded.

## CURRENT ACTION — D97CB
Remain unpatched in Tahoe VESA.
Run only the exact pinned D97CB collector above.

It must reproduce exact RAW export, atomically:
1. set SG_READ_ONLY;
2. place `__DATA_DIRTY` payload at `0x35C000`, `__DATA` at `0x361000`, keep `__LINKEDIT=0x36E000`;
3. swap the complete two segment-command blocks;
4. update exactly five file-backed section offsets;
5. remap exactly 3652 symtab `n_sect` bytes;
6. preserve every segment/section VM address and exact native `__text`/Metal4 surface;
7. prove all pre-sign diffs are inside audited domains;
8. test parser/order invariants, ctypes preflight/dlopen, signed target and true cold-load host;
9. only on a true cold-loadable original may D97BV be re-audited/applied;
10. stop at the next exact dyld/runtime error and do not auto-alter VM addresses or reconstruct fixup streams.

No Root Patch, installation, or accelerated reboot authorized.
