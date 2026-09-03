# OCLP7 CHECKPOINT — 2026-09-04 — D97AN natural-flow runtime provenance PROVEN 79/79; late-message parser inconclusive; D97AO static PC/CFG audit next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Routine/small work remains ASUS2-only; GitHub only for major compile/build/package. Golden Sequoia remains immutable/read-only. Root Patch and reboot remain manual-only and separately authorized. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_ACCEL_0229_NEGATIVE_WINDOWSERVER_XPC_INTERRUPTED_D97AN_RUNTIME_AUDIT_NEXT.md`.

D97AM Root Patch remains FULL PASS, with D97AD absent, exact P7 preimage `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`, natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`, and exact root-patched post-SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

Accelerated chronology remains fixed:
- `02:29` = D97AM accelerated/root-patched boot;
- `02:32` = VESA recovery;
- authoritative historical runtime window = `2026-09-04 02:29:00..02:31:59` local.

Current VESA `kern.boottime` observed by D97AN:
`{ sec = 1788478349, usec = 433654 } Fri Sep 4 02:32:29 2026`.

## D97AN wrapper identity / mutation ledger
Public read-only collector:
- `OCLP7_D97AN_READONLY_ACCEL_0229_NATURAL_FLOW_RUNTIME_PROVENANCE_AUDIT.command`;
- commit `8685d4e9d5080b533ed06e9661aee759ec174217`;
- blob `a12775867f57e9edd949fefdbeacba6991d3aa48`.

Wrapper blob and zsh parse passed exactly. Mutation ledger remained source NO, installed app NO, system target NO, Golden NO, Root Patch AUTO-NO, snapshot NO, reboot AUTO-NO.

## D97AN exact runtime provenance — PROVEN
Structured accelerated-window collection returned:

```text
MTL_JSON_RECORDS=351
LAUNCHD_JSON_RECORDS=7984
WINDOWSERVER_JSON_RECORDS=3698
MTL_PROCESS_PID_COUNT=66
```

MTL sender distribution included exactly:

```text
ALL_SENDER_COUNT=195|PATH=/usr/lib/system/libxpc.dylib|UUID=19C9DA96-742F-3A7D-A22D-E1DF683CE47B
ALL_SENDER_COUNT=79|PATH=/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler|UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
ALL_SENDER_COUNT=77|PATH=/usr/lib/system/libsystem_info.dylib|UUID=D5713F2F-7E03-3AEE-82DA-89F175842724
```

Exact provenance counts:

```text
EXPECTED_UUID_MTLCOMPILER_SENDER_MATCHES=79
OLD_D5CE_UUID_MTLCOMPILER_SENDER_MATCHES=0
OLD_A4F_UUID_MTLCOMPILER_SENDER_MATCHES=0
D97AN_RUNTIME_32023_SENDER_PROVENANCE=PROVEN_EXPECTED_NATURAL_FLOW_UUID
```

Classification:
`D97AN_RUNTIME_32023_SENDER_PROVENANCE=PROVEN_EXPECTED_NATURAL_FLOW_UUID`.

This closes stale-D5CE/A4F sender ambiguity for the current D97AM failing cohort. The exact 32023 sender seen in the failing accelerated boot is the natural-flow UUID-stamped image.

## Runtime sender-PC concentration
All 79 exact 32023 MTLCompiler sender records are concentrated at only three `senderProgramCounter` image offsets:

```text
0x9FFEE = 7 records
0xA0521 = 7 records
0xA5F81 = 65 records
TOTAL = 79
```

Representative decoded messages are privacy/truncation affected, for example:
- `0x9FFEE`: `upported in the simulator but <decode: mismatch for [%u] got [STRING sz:24]> were used`;
- `0xA0521`: ` were used`;
- `0xA5F81`: `upported in the simulator but <decode: mismatch for [%u] got [STRING sz:9]> were used`.

Historical D97AET had already observed `0x9FFEE` and `0xA5F81` in the prior instrumented lineage and explicitly did not treat those outer sender PCs as proof of traversal through the five validator-local xrefs. Therefore the current truncated text/outer PC observations must likewise not be overinterpreted.

## D97AN five-late parser result — INCONCLUSIVE, not NEGATIVE
The collector's literal message classifier printed:

```text
LATE_DIAGNOSTIC_RECORD_COUNT=0
BUFFERS=0
SAMPLERS=0
TEXTURES=0
CONSTANT_BUFFERS=0
INTERPOLATED_INPUTS=0
D97AN_NATURAL_FLOW_LATE_DIAGNOSTIC_REACHABILITY=NO_MATCH_OBSERVED_NOT_HARD_NEGATIVE
```

This is not a hard runtime negative. Unified-log privacy/format decoding truncated the diagnostic strings before the classifier could match the exact literals, while the same exact 32023/new-UUID records visibly contain simulator/`were used` fragments.

Authoritative classification:
`D97AN_FIVE_LATE_DIAGNOSTIC_RUNTIME_REACHABILITY=INCONCLUSIVE_TRUNCATED_UNIFIED_LOG_MESSAGE_CLASSIFIER`.

Do not promote `LATE_DIAGNOSTIC_RECORD_COUNT=0` to NEGATIVE.

## Launchd lifecycle / terminal evidence
D97AN observed repeated MTLCompilerService spawn -> inactive cycles throughout the accelerated window. The collector printed:

```text
LAUNCHD_MTL_RECORD_COUNT=139
LAUNCHD_EXIT_TEXT_COUNTS=1:0;110:0;111:0;112:0;113:0;114:0
D97AN_ARTIFICIAL_110_114_TEXT_EVIDENCE_TOTAL=0
```

Zero textual 110..114 evidence is consistent with complete D97AD removal, already independently proven in source/package/Root Patch. However the current launchd text parser did not recover an exact natural process exit status. Exact MTLCompilerService termination status therefore remains `UNKNOWN/INCONCLUSIVE`, not exit(1) NEGATIVE/PROVEN.

Some apparent lifecycle pseudo-PIDs such as `48`, `1292`, and `53964` are substring matches inside service-instance UUID text and are parser artifacts; they are not process identities.

## WindowServer correlation retained
D97AN observed:

```text
WINDOWSERVER_XPC_INTERRUPTED_TEXT_COUNT=454
WINDOWSERVER_COMPILATION_FAILED_TEXT_COUNT=35
WINDOWSERVER_RELEVANT_RECORD_COUNT=585
```

WindowServer repeatedly reports compiler service interruption/crash during communication, failed pipeline compilation, and retries. This reinforces the established downstream chain but does not identify the exact upstream terminal site.

`D97AM_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI` remains unchanged.

## What D97AN proves / does not prove
PROVEN:
1. exact failing 32023 MTLCompiler sender provenance is new natural-flow UUID `0FC4...`, 79/79 records;
2. old D5CE and A4F sender records are zero for that exact sender cohort;
3. the accelerated failure still causes repeated MTLCompilerService interruption and downstream WindowServer pipeline failure;
4. artificial 110..114 text evidence is zero.

INCONCLUSIVE / UNKNOWN:
1. exact five late validator-xref runtime reachability, because unified-log messages are truncated;
2. exact MTLCompilerService process exit status;
3. exact semantic meaning of outer runtime sender PCs `0x9FFEE`, `0xA0521`, `0xA5F81` until statically mapped on the exact natural-flow image;
4. direct runtime text-byte read remains NOT PERFORMED.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — D97AO read-only static/runtime-PC reconciliation
Next bounded ASUS2 action is a read-only audit on current VESA recovery. No Root Patch/reboot/source/app/system/Golden mutation.

D97AO should:
1. pin current VESA boot sec `1788478349`;
2. pin exact current 32023 target SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9` and UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`;
3. statically map runtime sender PCs `0x9FFEE`, `0xA0521`, `0xA5F81` to exact instructions, nearest symbols/functions, and local disassembly context;
4. enumerate all simulator/`were used` string literals and their direct xrefs/owners relevant to those outer PCs, so truncated unified-log records are not guessed from text fragments;
5. reconstruct the natural-P7 `validSimulatorMetadata` CFG using the already-proven D97AB seven-entry switch resolution, with natural bytes at `0x9D6BD` and no D97AD terminal, then report whether the five known late xrefs `0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D` are statically reachable from normal entry;
6. report zero/unresolved indirect branches after known-switch resolution and keep runtime reachability separate from static reachability.

STOP after D97AO. No Root Patch. No reboot.