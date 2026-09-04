# OCLP7 CHECKPOINT — 2026-09-04 — D97AR six late counters/predicates STATIC-MAPPED; six-bit terminal classifier feasibility next

## Authority / carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/static/log work stays ASUS2; GitHub only for major compile/build/package. Root Patch/reboot manual-only.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AQ_RUNNINGBOARD_ZERO_DIRECT_BINDINGS_TERMINATION_UNKNOWN_D97AR_SEMANTIC_DESIGN_NEXT.md`.

Historical D97AM accelerated runtime window remains `2026-09-04 02:29:00..02:31:59` local, with later VESA/current boots excluded from accelerated evidence.

## D97AR wrapper / target identity
Read-only wrapper:
- `OCLP7_D97AR_READONLY_NATURAL_P7_LATE_SEMANTIC_CAPTURE_DESIGN_AUDIT.command`;
- commit `5036034fb6c27859b8dd0746d4343f85925a1869`;
- Git blob `5d283c8aa53cb791a42a7bc3ff10ab82a4ba0868`.

Exact current natural target revalidated:
```text
TARGET_BYTES=1636896
TARGET_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
MACHO_LC_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
D97AR_TARGET_IDENTITY=PASS
FORMER_D97AD_SITE_BYTES_ACTUAL=8b8d10feffff83f941
D97AR_FORMER_D97AD_SITE_NATURAL_BYTES=PASS
```

No source/app/system/Golden/service-launch/Root-Patch/reboot mutation occurred.

## Exact six-counter semantic map from natural donor code
D97AR disassembly resolves the late validator counters and exact unsigned threshold predicates directly from natural P7 code.

1. Buffers:
```text
0x9D6BD movl -0x1f0(%rbp), %ecx
0x9D6C3 cmpl $0x41, %ecx
0x9D6C6 jb 0x9D6E3
0x9D6C8 error xref "only %u buffers ..."
```
Meaning: error/fallthrough iff unsigned `[rbp-0x1f0] >= 65`; supported maximum encoded by message path is 64.

2. Samplers:
```text
0x9D6E3 movl -0x1f8(%rbp), %ecx
0x9D6E9 cmpl $0x11, %ecx
0x9D6EC jb 0x9D706
0x9D6EE error xref "only %u samplers ..."
```
Meaning: error/fallthrough iff `[rbp-0x1f8] >= 17`; supported maximum 16.

3. Textures:
```text
0x9D706 cmpl $0x81, -0x1f4(%rbp)
0x9D710 jb 0x9D72F
0x9D712 error xref "only %u textures ..."
```
Meaning: error/fallthrough iff `[rbp-0x1f4] >= 129`; supported maximum 128.

4. Constant-buffer bindings:
```text
0x9D72F movl -0x200(%rbp), %ecx
0x9D735 cmpl $0xf, %ecx
0x9D738 jb 0x9D752
0x9D73A error xref "only %u constant buffers binding ..."
```
Meaning: error/fallthrough iff `[rbp-0x200] >= 15`; supported maximum 14.

5. Interpolated inputs:
```text
0x9D752 movl -0x1fc(%rbp), %edx
0x9D758 cmpl $0x20, %edx
0x9D75B jb 0x9D77F
0x9D75D error xref "fragment shader has %u interpolated inputs ..."
```
Meaning: error/fallthrough iff `[rbp-0x1fc] >= 32`; supported maximum 31.

6. Interpolated component inputs:
```text
0x9D77F movl -0x1ec(%rbp), %ebx
0x9D785 cmpl $0x7d, %ebx
0x9D788 jb 0x9D7A6
0x9D78A error xref "fragment shader has %u interpolated component inputs ..."
```
Meaning: error path iff `[rbp-0x1ec] >= 125`; supported maximum 124.

This directly identifies the six-counter boundary referenced historically by D96C/D97JB. The recovered retrospective states that boundary was stable/universal but does not preserve old raw runtime values; do not invent them.

## Evidence consequence
D97AR maps exact semantic storage/thresholds, but it does not provide runtime values or runtime branch outcomes. Exact raw-value channels remain unproven:
```text
CAPTURE_CHANNEL_UNIFIED_LOG_RAW_NUMERIC_RELIABLE=NO_PROOF_CURRENTLY
CAPTURE_CHANNEL_LAUNCHD_EXIT_CODE_CAPACITY=INSUFFICIENT_FOR_SIX_RAW_VALUES
CAPTURE_CHANNEL_CRASH_REGISTER_REPORTING=HISTORICALLY_UNRELIABLE_FOR_CURRENT_COHORT
D97AR_SAFE_RAW_NUMERIC_OUTPUT_CHANNEL=UNPROVEN_REQUIRES_SEPARATE_DESIGN
D97AR_SEMANTIC_CAPTURE_STATIC_DESIGN_AUDIT=PASS
```

## New design insight — six branch predicates fit one deterministic 6-bit status
Although six arbitrary raw integers cannot fit in one process exit code, the six exact donor predicates are booleans. Their complete threshold state is exactly 6 bits and therefore can be encoded in a single deterministic 8-bit exit status for each request/PID.

Proposed bit assignment:
- bit0 (`1`) = buffers `>=65`;
- bit1 (`2`) = samplers `>=17`;
- bit2 (`4`) = textures `>=129`;
- bit3 (`8`) = constant buffers `>=15`;
- bit4 (`16`) = interpolated inputs `>=32`;
- bit5 (`32`) = interpolated component inputs `>=125`.

Proposed terminal diagnostic exit status = `160 + bitmask`, yielding exhaustive unambiguous range `160..223`. `160` means all six below donor error thresholds; `223` means all six threshold predicates true.

This would not claim raw integer equivalence. If executed universally at the correct natural boundary, it would directly prove the six donor branch-condition outcomes for each classified request/PID and whether execution reached the capture point. It is intentionally terminal and makes no pass-through claim.

## D97AS exact prepared wrapper identity
Public read-only feasibility auditor:
- `OCLP7_D97AS_READONLY_SIX_PREDICATE_BITMASK_TERMINAL_CLASSIFIER_FEASIBILITY_AUDIT.command`;
- commit `fc992c3f52b56f5e51357a7897b1afed025a2fbf`;
- Git blob `76b6320ba0aac57b7d3357a22e0c2ee55d51de1f`.

The proposed overwrite span is `0x9D6BD..0x9D72D` exclusive, exactly 112 bytes. The generated terminal classifier is 107 bytes plus 5 NOP padding bytes. D97AS must prove instruction alignment, exact preimage, zero outside-to-interior CFG entries, zero reachable unresolved indirects, D34 non-overlap, exact six-predicate machine-code encoding, and synthetic temporary-copy disassembly before classifying the design feasible.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — D97AS
Run D97AS once on ASUS2. It is read-only relative to source/live system and writes only a temporary synthetic copy in `/private/tmp`, removed on exit.

STOP after D97AS. No source/app/system/Golden/service/Root-Patch/reboot mutation.