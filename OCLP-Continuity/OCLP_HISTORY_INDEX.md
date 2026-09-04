# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97BB_GOLDEN_LLVMVERSION_SOURCE_PROVEN_D97BC_OBJECT_PROVENANCE_V2_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / final architecture
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package plus identity-pinned script persistence/delivery. No automatic Root Patch/reboot.
Final comparator: `Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP donor -> Golden-equivalent compiler output -> Haswell driver -> image`.
Use SAME ORIGINAL OCLP functional content on Tahoe with only separately audited eligibility/OS-support bypass.

## Golden snapshots
GOLDEN_A = Sequoia `15.7.9 / 24G830`, complete D97AU/D97AX/D97AY snapshot.
GOLDEN_B = Sequoia `15.8 / 24H22`, no EFI changes per user, same original OCLP Root Patch manually reapplied, acceleration working.
Critical donor hashes unchanged: 32023 `ddabe975...`, 3802 `85d4c285...`, MTLCompilerService `31a6f745...`.
Original selector `3802 -> 3802`, `31001 -> 32023`.

## Retained Golden producer/runtime facts
D97AU GOLDEN_A boot3m observed both 3802 and 32023 donor lanes. Combined with exhaustive selector semantics, corresponding request llvmVersion values are logically constrained to 3802 and 31001 respectively; this is composed static+runtime proof.
D97BA GOLDEN_B cached Metal text `0x7FF80D343000..0x7FF80D5C5C3D`, SHA `f3e49d47...`; request-builder xrefs unchanged; G3 reaches Metal compositor. GOLDEN_B MTL zero-record log channel remains visibility-INCONCLUSIVE.

## D97AZ V4 — primary value/dataflow backslice PASS
Primary requestType = dword `[R13+0x8]`; timeout = qword `[R13+0x18]`; sandboxTokens condition = byte `[R13+0x70]`; alternate requestType = immediate `9`. pluginPath/targetData/data/client_name source paths mapped as recorded in checkpoint. Setter-family targets string `0x7FF80D50FDC8`, uint64 `0x7FF80D50FDCE`, value `0x7FF80D50FDD4`.

## D97BB — llvmVersion source + function boundary PASS
Exact returned files:
- TXT 4779 bytes / SHA256 `694647bdfa56ca79b9446df8d9fb1a383e48834c13bbdd7462d68e1f6810c4e1`;
- JSON 4113 bytes / SHA256 `3ede6711d2494b3a9f3ae3900c0c9f8572b0c955b46b325789a7e6026fca63e2`.

`LC_FUNCTION_STARTS` proves primary request-builder function `0x7FF80D370756..0x7FF80D370C28`.
Exact llvmVersion source: `movslq 0x20(%rbx),%rdx` at `0x7FF80D37081B`, then key xref and uint64 setter. Classification `G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

## CURRENT ACTION — D97BC V2
Run hardened wrapper `OCLP7_D97BC_V2_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE_HARDENED_WRAPPER.command`:
- commit `02bfb4c212dc62a7659469e5439b6003e02721df`;
- blob `43e1a9a96c211f0db530dfa3395dde30d97a42d2`.
Core `OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.command`:
- commit `6457b6f5c613de18f60ae6517fc3f05ee8323240`;
- blob `7513123504d526bb5439410c453080d909fef218`.

D97BC revalidates current Metal/function boundary, disassembles only the one proven primary function, inventories RBX/R13 writes and traces explicit origins to ABI/object/memory sources where supported. Goal: bind `[RBX+0x20]=llvmVersion` and R13-based request fields to root producer objects. No mutation, debugger attach, Root Patch or reboot.
After D97BC, decide if any minimal Golden runtime capture remains before identical-OCLP Tahoe eligibility-bypass phase.