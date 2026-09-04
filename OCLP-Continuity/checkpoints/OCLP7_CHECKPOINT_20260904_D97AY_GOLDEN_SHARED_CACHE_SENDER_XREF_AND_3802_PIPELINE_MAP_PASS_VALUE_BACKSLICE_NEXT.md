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

Exact xref census counts: requestType=2, sandboxTokens=1, llvmVersion=1, pluginPath=1, targetData=1, data=2, client_name=1, APISpecifiedTimeoutInSeconds=1.
The enormous raw string hit counts for generic keys such as `data` are not sender semantics; only Metal-owned exact RIP xrefs are promoted.

## G1 — value semantics still open
D97AY intentionally did NOT claim the values passed to the XPC setters. Exact Golden runtime/static source for `llvmVersion`, source/enum semantics for `requestType`, and the other six value sources remain open. No runtime value is inferred merely from key presence/xref.

Classification: `G1_GOLDEN_XPC_WRITER_VALUE_SOURCES=UNKNOWN_PENDING_BACKSLICE`.

## Golden 3802 lane — exact semantic map
Observed runtime PC `0x238E3` maps to `MTLCompilerObject::backendCompileExecutableRequest(BinaryRequestData&)` immediately after `Build request: pipeline` and at the following `mach_absolute_time` call.
Observed runtime PC `0x1DFA3` maps to `MTLCompilerObject::serializeBackendCompilationOutput(...)` immediately after `Compilation (pipeline) time %f ms`.

Therefore Golden 3802 runtime lane has observed pipeline start plus later completion/timing/serialization-stage evidence. Classification: `GOLDEN_3802_PIPELINE_START_AND_TIMING_PATH=STATIC_MAPPED_TO_RUNTIME_PCS`.

## Current Golden contract status
D97AX + D97AY now give receiver-side eight-key schema, sender-side exact eight-key request-builder xref cluster, original donor memory dialect, dual-generation runtime lane, exact 3802 pipeline start/timing mapping, and positive driver->compiler->Metal compositor success corridor.

Highest-priority remaining G1 task is value/dataflow recovery from the common request-builder cluster.

## CURRENT ACTION — D97AZ V3
Remain in Golden; do NOT start Tahoe eligibility bypass yet.

D97AZ core is persisted but not to be run directly:
- core file `OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.command`;
- commit `fb509db4b1e40c8e9c466fed45b53c8462ed408c`;
- Git blob `fec92ab86cad92cc69307284c6ad3cd26ed74c19`.

The first hardened V2 wrapper is retired UNRUN after assistant preflight noticed that arbitrary pre-xref range starts could begin mid-instruction and misalign x86 disassembly.

Authoritative aligned wrapper:
`OCLP7_D97AZ_V3_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE_ALIGNED_HARDENED_WRAPPER.command`
- commit `6260523f326fdda28c429ad90095babde696e979`;
- Git blob `1f9ab406f35a3ae51c125584473b3ab64b0ed327`.

V3 verifies the exact immutable core blob, then applies exactly four tooling transforms in-memory only:
1. primary range begins exactly at proven instruction boundary `0x7FF80D37081F`;
2. alternate data range begins exactly at proven boundary `0x7FF80D41E881`;
3. alternate requestType range begins exactly at proven boundary `0x7FF80D44B9E1`;
4. synthetic-Mach-O relative call targets are translated as signed 64-bit section-relative values.
It then checks zsh syntax, exactly one Python heredoc, Python compile, aligned-range invariants and all eight keys before execution.

D97AZ goals:
- pair each of the eight primary key xrefs with the next un-clobbered XPC setter call;
- backslice setter value argument `RDX` to immediate/memory/register source where safely resolvable;
- prioritize exact source for `llvmVersion` and `requestType`;
- keep alternate `data` and `requestType` builders separate;
- classify each field `STATIC_VALUE_SOURCE_PROVEN`, `STRUCTURAL_SOURCE_MAPPED`, or `UNKNOWN`;
- no debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

Only after D97AZ should repeated Golden boots / a short Metal System Trace be selected for fields whose exact runtime values remain UNKNOWN.