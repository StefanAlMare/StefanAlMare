# OCLP7 CHECKPOINT — 2026-09-04 — D97AY V2 pin mismatch tooling-only; V3 double-pin ready

## Context
Golden Sequoia remains working `15.7.9 / 24G830`. Current architecture and D97AX Golden contract-book results remain unchanged. The next semantic target remains G1 sender-side shared-cache recovery for the eight MTLCompilerService-consumed keys plus static mapping of Golden 3802 PCs.

## D97AY V2 failed before core execution — TOOLING ONLY
User ran hardened wrapper `OCLP7_D97AY_V2_GOLDEN_SHARED_CACHE_EIGHT_KEY_HARDENED_WRAPPER.command`:
- wrapper commit `c4d8795734b93cfeac1e0d7005b9914c0fddd01d`;
- wrapper Git blob `34530755218e024bc27ea60c36acb6993557f5c2`.

Outer wrapper identity passed exactly. The wrapper then downloaded the immutable D97AY core from commit `f76b04832150a0a8fd1eb80867785bf147f94537` and reported:
- configured expected core blob: `1ae81e5221d105603a9d9f8174a0506371564bee`;
- actual downloaded core blob: `3b07f1d4d52da948268fbd437781dd73092bef1c`;
- actual core bytes: `14109`;
- actual core SHA256: `203f7255019ffb99e4d83084a8b22a6d9184f5134bab503891faf5d9863c7674`.

The wrapper fail-closed at `BASE_BLOB_MISMATCH` before `/bin/zsh -f "$BASE"`. Therefore:
- D97AY core semantic/static scan was NOT executed;
- no shared-cache scan result exists from V2;
- no Golden semantic conclusion may be drawn;
- no system-file mutation, cache mmap/extraction, debugger attach, Root Patch or reboot occurred.

Classification: `D97AY_V2=TOOLING_ONLY_BAD_EXPECTED_CORE_BLOB_FAIL_CLOSED`.

## D97AY core identity corrected
Exact core remains unchanged at:
- file `OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.command`;
- commit `f76b04832150a0a8fd1eb80867785bf147f94537`;
- corrected Git blob `3b07f1d4d52da948268fbd437781dd73092bef1c`;
- SHA256 `203f7255019ffb99e4d83084a8b22a6d9184f5134bab503891faf5d9863c7674`;
- bytes `14109`.

No core logic was modified.

## CURRENT ACTION — D97AY V3 hardened double-pin wrapper
Use:
`OCLP7_D97AY_V3_GOLDEN_SHARED_CACHE_EIGHT_KEY_HARDENED_WRAPPER.command`
- commit `eaff09fb2b3c2d8b1005b38de380759710625119`;
- Git blob `4dece1e36f339d57b2e4602d0586540a8b2cb5a3`.

V3 verifies both corrected core Git blob and SHA256, then checks core zsh syntax, exactly one embedded Python block, exact presence/cardinality of the eight receiver keys, and read-only safety markers before executing the unchanged D97AY core.

Remain in Golden. Run D97AY V3 only. Return complete TXT + JSON. No Root Patch/reboot.
