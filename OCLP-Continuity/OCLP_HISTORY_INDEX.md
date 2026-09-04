# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97BC_GOLDEN_CONTRACT_STRUCTURAL_CLOSED_IDENTICAL_OCLP_TAHOE_ELIGIBILITY_PREFLIGHT_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Final architecture
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP donor -> Golden-equivalent compiler output -> Haswell driver -> image`.
Tahoe comparator must use SAME ORIGINAL OCLP functional content; only a separately audited minimal eligibility/OS-support bypass may differ.

## Golden snapshots
GOLDEN_A = Sequoia `15.7.9 / 24G830`, D97AU/D97AX/D97AY oracle.
GOLDEN_B = Sequoia `15.8 / 24H22`, same OCLP Root Patch reapplied manually, acceleration working, no EFI changes per user.
Donor hashes unchanged: 32023 `ddabe975...`, 3802 `85d4c285...`, service `31a6f745...`.

## Retained Golden producer/runtime facts
Receiver eight-key XPC schema proven. GOLDEN_B Metal request-builder xrefs rebased identically to GOLDEN_A and G3 reaches Metal compositor.
D97AU GOLDEN_A observed both donor generations; exhaustive unchanged selector maps request llvmVersion 3802 -> donor 3802 and request llvmVersion 31001 -> donor 32023.

## D97AZ / D97BB
D97AZ: primary requestType `[R13+0x8]`; timeout `[R13+0x18]`; sandbox condition `[R13+0x70]`; alternate requestType immediate 9; helper paths mapped.
D97BB: `LC_FUNCTION_STARTS` function `0x7FF80D370756..0x7FF80D370C28`; llvmVersion source `movslq 0x20(%rbx),%rdx` -> uint64 setter.

## D97BC — object provenance PASS / Golden structural closure
Exact files:
- JSON 1740 bytes / SHA256 `67458836538b52b7ada6d54400bd396aa8eb6521b6cffbed0c87fdf93767c530`;
- TXT 5768 bytes / SHA256 `b4e9207e439d5740a214ad09f00f4565dbb2c0680b1d93e5b45f6f38327ddef5`.

Function prolog:
- `movq %rsi,%r13` => R13 = ABI arg2 / RSI;
- `movq %rdi,%rbx` => RBX = ABI arg1 / RDI.
No intervening RBX/R13 writes before mapped fields.

Bound layout:
- ABI arg1 +0x20 signed dword = llvmVersion;
- ABI arg2 +0x08 dword = requestType;
- ABI arg2 +0x18 qword = timeout;
- ABI arg2 +0x70 byte gates sandboxTokens.

Classifications: RBX/R13 origins `STATIC_ABI_ORIGIN_PROVEN`; llvmVersion source `STATIC_VALUE_SOURCE_PROVEN`.

Golden is now sufficient to begin identical-OCLP Tahoe eligibility preflight. This is not a claim that every payload/runtime byte is captured; those remain explicit comparator targets if needed.

## CURRENT ACTION — read-only Tahoe eligibility preflight
No Root Patch/reboot and no source mutation yet.
Audit exact local OCLP app/source lineage and locate Tahoe/root-patch eligibility gates. Prove an eligibility-only delta can be isolated from payload selection/content, selector/compiler logic, request layout, AIR/bitcode handling and graphics-driver resources. Record exact identities and produce a fail-closed manifest before any integration.
