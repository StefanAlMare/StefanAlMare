# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AO_NATURAL_P7_ALL_FIVE_STATIC_REACHABLE_RUNTIME_PCS_OUTER_D97AP_TERMINATION_LOGSITE_AUDIT_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-04 EEST

## Mandatory startup
Before any technical change read in full, in order:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

Incremental checkpoints remain authoritative for exact historical detail. This MASTER is only the current-state/frontier summary.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Local source branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.

Routine/small tests, static/source/log inspection, small edits and diagnostics stay on ASUS2. GitHub only for major/substantial compile/build/package. Golden Sequoia immutable/read-only. Never auto Root Patch or reboot. Evidence classes remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/STATIC-PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.

Accepted functional baseline remains exactly P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset. True-five SHA256 `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. D34 cave `0xEF8..0xEFE` protected.

Architecture remains `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.

## Durable D97 correction
D97AD terminal outcomes 110..114 are project-invented diagnostics, not donor semantics. Natural P7 bytes at `0x9D6BD` are `8b8d10feffff83f941`; D97AD replaced them with artificial terminal code. D97AJ's zero-late reachability therefore applies only to instrumented A4F, not natural donor flow.

D97AK proved the five late simulator-limit strings have only their known direct xrefs inside `MTLSimCompiler::validSimulatorMetadata`, with no alternate direct/indirect string origins or external late entries.

D97AL restored exact P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda` and froze natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`; P7+UUID differs only at LC_UUID and has SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

## D97AM current installed/root-patched state
D97AM source/build/artifact/deploy are FULL PASS. Live app executable remains `6596496` bytes / SHA256 `fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3` / x86_64. D97AH backup retained at `/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`.

Manual D97AM Root Patch FULL PASS: true-five -> P6 -> P7, zero D97AD, UUID D5CE -> `0FC4...`, post-SHA exact `e7739c...`, atomic rename/metadata/AuxKC/APFS snapshot/unmount all PASS.

## D97AM accelerated boot outcome
Historical chronology is fixed:
- `02:29` = D97AM accelerated/root-patched boot;
- `02:32` = VESA recovery;
- authoritative historical runtime window = `2026-09-04 02:29:00..02:31:59` local.

Later boot(s), including `10:08:19`, do not redefine this historical accelerated window.

Accelerated outcome remains `D97AM_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`. WindowServer crashed in Metal pipeline creation after repeated `XPC_ERROR_CONNECTION_INTERRUPTED`; WindowServer remains downstream.

## D97AN — exact natural-flow runtime provenance PROVEN 79/79
Structured logs prove exactly 79 sender records from `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`, all UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`; old D5CE=0 and A4F=0. Stale-image/generation ambiguity is closed for the current failing cohort.

The 79 records concentrate at image offsets:
- `0x9FFEE` = 7;
- `0xA0521` = 7;
- `0xA5F81` = 65.

D97AN literal matching of the five late diagnostics is INCONCLUSIVE because unified-log event text is privacy/format truncated. Exact MTLCompilerService exit status also remains UNKNOWN/INCONCLUSIVE. Zero text evidence for artificial 110..114 is consistent with D97AD removal.

## D97AO — natural P7 resolved CFG STATIC-PROVEN
D97AO V1 failed only at an overstrict current-boot gate before target inspection. D97AO V2 removed only that redundant gate and then audited the exact current target.

Exact target retained after later reboot:
```text
TARGET_BYTES=1636896
TARGET_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
MACHO_LC_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
NATURAL_SITE_0x9D6BD=8b8d10feffff83f941
```

D97AN runtime PCs are STATIC-MAPPED to outer request/backend code:
- `0x9FFEE`, 7 records: `MTLCompilerObject::buildSpecializedFunctionRequest`, immediately after static `Build request: %s` os_log site;
- `0xA0521`, 7 records: same function, immediately after static `Compilation (%s) time %f ms` os_log site;
- `0xA5F81`, 65 records: `MTLCompilerObject::backendCompileExecutableRequest`, immediately after static `Build request: %s` os_log site.

Therefore those outer sender PCs must not be equated with validator-local late xrefs.

Natural `validSimulatorMetadata` CFG:
```text
FUNCTION_DISASSEMBLED_INSTRUCTION_COUNT=408
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=397
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
0x9D6C8 STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D6EE STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D712 STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D73A STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D75D STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
D97AO_NATURAL_P7_LATE_CFG=STATIC_PROVEN_ALL_FIVE_REACHABLE_FROM_NORMAL_ENTRY
```

This resolves the D97AJ/A4F contradiction: D97AD's artificial terminal cut off the natural continuation. It does NOT yet promote any of the five sites to runtime REACHED.

## CURRENT ACTION — D97AP read-only termination + outer-logsite lifecycle audit
Public wrapper: `OCLP7_D97AP_READONLY_ACCEL_0229_TERMINATION_AND_OUTER_LOGSITE_LIFECYCLE_AUDIT.command`, commit `1def667693ad51fdfb436eb5f5b60459ce2da430`, Git blob `2f7f0ad4e48232f32f78d7de7e6308164c412bcd`.

D97AP is fixed to the historical 02:29 accelerated window but does not require a particular current boot. It pins exact current target `e7739c... / 0FC4...`, re-queries MTLCompilerService plus selected system-daemon logs, scans available DiagnosticReports, statically enumerates `__os_log_impl` sites in `buildSpecializedFunctionRequest` and `backendCompileExecutableRequest`, reconciles D97AN sender PCs with those exact log-site return PCs, and correlates per-PID start/timing sequences.

Goal: recover direct crash/signal/exit/corpse evidence if it exists and determine what the three outer runtime PCs actually prove about request lifecycle. Do not hard-negative a missing log unless the static logging contract justifies it. Exact termination remains UNKNOWN unless directly recovered.

STOP after D97AP. No Root Patch, reboot, service launch, source/app/system/Golden/snapshot mutation. Any later reboot must add semantic payload/branch information, not merely another coarse control-flow marker.