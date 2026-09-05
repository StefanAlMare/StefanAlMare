# OCLP7 D97BZ artifact identity — 2026-09-06

Parent authoritative checkpoint:
`OCLP7_CHECKPOINT_20260906_D97BY_REAL_EXPORT_EXACT_TEXT_DLOPEN_SG_READ_ONLY_NEGATIVE_D97BZ_NEXT.md`

Read-only/transient collector:
`OCLP7_D97BZ_sg_read_only_metadata_gate.sh`

Pinned identity:
- bytes `19303`;
- SHA256 `cd1aaed08f33e6396612cd0c15cf9907e13d3e219d7a24356dfe19c033cb76b7`.

Purpose:
- reproduce only the pinned RAW `blacktop/ipsw` real export of exact Tahoe 25G82 Metal;
- census `LC_SEGMENT_64` flags;
- create one temporary variant that changes only `__DATA_CONST` flags by OR-ing `SG_READ_ONLY (0x10)`;
- prove pre-sign diff is confined to that 32-bit flags word;
- test unsigned and ad-hoc-signed preflight + real child `dlopen` with anti-coalescing image-list verification;
- apply/re-audit D97BV only if the metadata-fixed original becomes genuinely loadable;
- otherwise stop at the next exact dyld rejection;
- no segment/section VM relocation, no installation, no Root Patch, no reboot.
