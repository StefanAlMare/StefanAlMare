# OCLP7 CHECKPOINT — 2026-09-04 — D97AY Golden shared-cache sender xref map + 3802 pipeline map PASS; writer value backslice next

## User-authoritative architecture
The project remains:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Remain in working Golden Sequoia until the Golden contract book is sufficiently complete. The final Tahoe comparator must use the SAME ORIGINAL OCLP functional content, with only a separately audited Tahoe eligibility/OS-support bypass.

## D97AY V3 returned files
User returned both core outputs:
- JSON `/mnt/data/OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.json`: 112785392 bytes, SHA256 `2b873f21f71016b3911b2d028e01dc993a118b8f13c68260a6ec760c18c52184`;
- TXT `/mnt/data/OCLP7_D97AY_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_XREF_AND_3802_PC_MAP.txt`: 69660570 bytes, SHA256 `abfe1a04d512697df6c2bb57f31935108aed2a4d1cd8d5325fadc7f903db40e5`.

TXT final classification:
- `G1_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_MAP=STATIC_CENSUS_COMPLETE`;
- `G1_GOLDEN_METAL_KEY_RIP_XREF_MAP=STATIC_CENSUS_COMPLETE`;
- `G1_GOLDEN_XPC_WRITER_VALUE_SOURCES=NOT_YET_CLAIMED`;
- `GOLDEN_3802_OBSERVED_PC_STATIC_MAP=COMPLETE`;
- `D97AY_AUDIT=COMPLETE`;
- no system mutation, cache mmap/extraction, debugger attach, Root Patch or reboot.

Classification: `D97AY_GOLDEN_SHARED_CACHE_SENDER_XREF_AND_3802_PC_MAP=PASS`.

## Golden identity
D97AY revalidated:
- Sequoia `15.7.9 / 24G830`;
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

## G1 — Metal shared-cache sender vocabulary/xrefs
Metal image exactly mapped in shared cache:
`0x7FF80D343000..0x7FF80D5C5C3D`.

All eight service-consumed keys have Metal-owned key instances and exact RIP-relative code xrefs.

Primary common request-construction cluster:
- `llvmVersion` xref `0x7FF80D37081F` (Metal +`0x2D81F`) -> key `0x7FF80D53DBDB`;
- `requestType` `0x7FF80D370832` (+`0x2D832`) -> `0x7FF80D53DBBF`;
- `sandboxTokens` `0x7FF80D370914` (+`0x2D914`) -> `0x7FF80D53DBE7`;
- `targetData` `0x7FF80D370939` (+`0x2D939`) -> `0x7FF80D53DBF5`;
- `data` `0x7FF80D37095E` (+`0x2D95E`) -> key `0x7FF80D53ABA9`;
- `pluginPath` `0x7FF80D37097F` (+`0x2D97F`) -> `0x7FF80D53DC00`;
- `client_name` `0x7FF80D3709FD` (+`0x2D9FD`) -> `0x7FF80D53DC22`;
- `APISpecifiedTimeoutInSeconds` `0x7FF80D370A13` (+`0x2DA13`) -> `0x7FF80D53DC2E`.

This is a highly localized Golden request-builder boundary containing all eight ingress keys. Classification: `G1_GOLDEN_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_CLUSTER=STATIC_MAPPED`.

Additional xrefs:
- `requestType` also at `0x7FF80D44B9E1` (Metal +`0x1089E1`);
- `data` also at `0x7FF80D41E881` (Metal +`0xDB881`).

Exact xref census counts:
- requestType=2;
- sandboxTokens=1;
- llvmVersion=1;
- pluginPath=1;
- targetData=1;
- data=2;
- client_name=1;
- APISpecifiedTimeoutInSeconds=1.

The enormous raw string hit counts for generic keys such as `data` are not themselves sender semantics. Only Metal-owned exact RIP xrefs are promoted.

## G1 — value semantics still open
D97AY intentionally did NOT claim the values passed to the XPC setters. Therefore:
- exact Golden runtime/static source for `llvmVersion` remains to be back-sliced from the request-builder;
- exact source/enum semantics for `requestType` remain open;
- the six remaining fields need source/value classification where feasible;
- no runtime value is inferred merely from key presence/xref.

Classification: `G1_GOLDEN_XPC_WRITER_VALUE_SOURCES=UNKNOWN_PENDING_BACKSLICE`.

## Golden 3802 lane — exact semantic map
Observed runtime PC `0x238E3` maps to:
`MTLCompilerObject::backendCompileExecutableRequest(BinaryRequestData&)` immediately after the `Build request: pipeline` os_log and at the following `mach_absolute_time` call.

Observed runtime PC `0x1DFA3` maps to:
`MTLCompilerObject::serializeBackendCompilationOutput(...)` immediately after `Compilation (pipeline) time %f ms` os_log.

Therefore Golden 3802 runtime lane has observed pipeline start plus later completion/timing/serialization-stage evidence, not merely arbitrary compiler traffic.

Classification:
`GOLDEN_3802_PIPELINE_START_AND_TIMING_PATH=STATIC_MAPPED_TO_RUNTIME_PCS`.
This is control/lane evidence, not yet full semantic payload equivalence.

## Current Golden contract status
D97AX + D97AY now give:
1. receiver-side eight-key XPC schema;
2. sender-side Metal exact eight-key request-builder xref cluster;
3. Golden original donor memory dialect;
4. Golden dual-generation runtime lane;
5. exact 3802 pipeline start/timing mapping;
6. positive driver->compiler->Metal compositor success corridor.

Highest-priority remaining G1 task is no longer discovery. It is value/dataflow recovery from the common request-builder cluster.

## CURRENT ACTION
Remain in Golden; do NOT start Tahoe eligibility bypass yet.

Next bounded collector: read-only `D97AZ` Golden Metal primary request-builder value/dataflow backslice.
Goals:
- identify the containing function/range for Metal +`0x2D81F..0x2DA13`;
- identify the XPC setter call paired with each of the eight key xrefs;
- recover argument/value source for `llvmVersion` and `requestType` first, then the other six where statically resolvable;
- preserve alternate requestType/data xrefs separately;
- classify each field as `STATIC_VALUE_SOURCE_PROVEN`, `STRUCTURAL_SOURCE_MAPPED`, or `UNKNOWN`;
- no debugger attach, persistent instrumentation, Root Patch, reboot or Golden system mutation.

Only after D97AZ should repeated Golden boots / a short Metal System Trace be selected for fields whose exact runtime values remain UNKNOWN.
