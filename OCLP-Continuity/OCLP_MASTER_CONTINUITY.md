# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AY_GOLDEN_SHARED_CACHE_SENDER_XREF_AND_3802_PIPELINE_MAP_PASS_VALUE_BACKSLICE_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-04 EEST

## Mandatory startup
Before any technical change read in full, in order:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

Incremental checkpoints are authoritative for historical detail. This MASTER is current state/frontier only.

## Target and execution contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.
Routine/static/log/small work stays on the target Mac under user control. GitHub is only for major compile/build/package and identity-pinned script persistence/delivery. Never auto Root Patch or reboot.

## Golden comparator authority — explicit user override
User may manually restore ORIGINAL OCLP Root Patch and boot working Golden Sequoia `15.7.9 / 24G830` as many times as useful for comparator work. This supersedes older wording that Golden must never be booted. Assistant does not automate Golden Root Patch/reboot and does not install experimental Golden system-file patches without separate explicit authorization.

## AUTHORITATIVE PROJECT ARCHITECTURE — 2026-09-04
The ORIGINAL working OCLP donor/root-patch path is the immutable semantic target.

Architecture:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor path -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Historical P1/P2b/P3/AIR00/D34/P6/P7 are adapters/hypotheses, not axioms. Any or all may retire when Tahoe producer normalization makes the original donor sufficient. Logs are observation channels only; compare actual schemas, values, payloads, layouts and handoff semantics.

## Identical-OCLP Tahoe comparator rule
Only after Golden is sufficiently characterized, Tahoe must use the SAME ORIGINAL OCLP functional content as Golden. The only Tahoe-specific delta permitted is a minimal eligibility/OS-support bypass that merely allows the otherwise-original Golden Root Patch to run on Tahoe.

Before Tahoe Root Patch, prove that bypass does not alter payload selection/content, MTLCompilerService selector semantics, MTLCompiler binaries/logic, request layout, AIR/bitcode handling, graphics-driver payloads or any donor behavior beyond eligibility. Then run the SAME collectors/workloads/boundaries on Tahoe and locate the earliest exact Golden-vs-Tahoe difference.

## Golden contract evidence labels
`SCHEMA_STATIC_PROVEN`, `RUNTIME_OBSERVED`, `RUNTIME_VALUE_PROVEN`, `GOLDEN_INVARIANT_PROVISIONAL`, `UNKNOWN`, `INCONCLUSIVE`. Never substitute inferred/static values for unavailable runtime values.

## Golden contract layers
### G1 producer/XPC ingress
Metal.framework/request producer -> XPC dictionary -> MTLCompilerService selector: complete key/type schema, `llvmVersion`, `requestType`, generation split 3802 vs 31001->32023, runtime lanes and repeated-boot stability.

### G2 original donor ingress/internal semantics
Request header/layout, serialized payload, bitcode type/length/pointer, optional payload, AIR/Metal versions, getReadParameters/upgradeAIR/specialized/backend/module reconstruction/metadata contracts and exact values where observable.

### G3 compiler output -> Haswell graphics stack
GPUCompiler/Metal/IOGPU/AppleIntelHD5000GraphicsMTLDriver identities/load state, pipeline/library/function result paths, status contracts and earliest driver-facing handoff.

## Working Golden exact identities
Golden Sequoia `15.7.9 / 24G830`, Intel HD4400 device `0x0412`, revision `0x000b`, Metal 2, display online.
Golden 32023: `1636896 / ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269 / D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.
Golden 3802: `438560 / 85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40 / D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.
Golden original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`.
Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no selector immediate 32023.

## Historical Tahoe comparator retained only as reference
D97AM natural-P7 build/deploy/Root Patch FULL PASS; accelerated `2026-09-04 02:29` `NEGATIVE_NO_USABLE_GUI`. D97AN exact natural 32023 provenance 79/79, 3802=0, 65 PIDs; PCs `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`. D97AO/AP/AQ/AR/AS remain historical custom-patch evidence only, not the final identical-OCLP comparator.

## D97AU Golden runtime oracle
Authoritative first-three-minute Golden window `2026-09-04 12:54:24..12:57:24`:
- total 451 MTL records;
- 32023=220; 3802=193; OTHER=38;
- 8 exact-generation PIDs, no mixed-generation PID;
- 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`;
- 3802 PCs `0x1DFA3=96`, `0x238E3=97`.
Golden LLDB attach was denied; raw six-counter values remain `UNKNOWN_ATTACH_DENIED`.

## D97AX V2 — Golden contract census FULL PASS
G1 receiver schema SCHEMA_STATIC_PROVEN: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.

G2 original donor dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule. D97AX direct-callgraph is retired tooling-inconclusive.

G3 positive corridor: Azul/HD5000 load -> framebuffer events -> WindowServer opens MTLCompilerService -> shader compilation -> `Metal compositor activated` at `12:55:25.092/25.093`. Metal System Trace is available but not yet recorded.

## D97AY V2 tooling-only fail, V3/core PASS
D97AY V2 stopped safely at a wrong expected core blob before core execution. The unchanged core identity was corrected and V3 was used.

Returned D97AY V3/core outputs:
- JSON 112785392 bytes / SHA256 `2b873f21f71016b3911b2d028e01dc993a118b8f13c68260a6ec760c18c52184`;
- TXT 69660570 bytes / SHA256 `abfe1a04d512697df6c2bb57f31935108aed2a4d1cd8d5325fadc7f903db40e5`.

D97AY final classifications:
- `G1_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_MAP=STATIC_CENSUS_COMPLETE`;
- `G1_GOLDEN_METAL_KEY_RIP_XREF_MAP=STATIC_CENSUS_COMPLETE`;
- `G1_GOLDEN_XPC_WRITER_VALUE_SOURCES=NOT_YET_CLAIMED`;
- `GOLDEN_3802_OBSERVED_PC_STATIC_MAP=COMPLETE`;
- `D97AY_AUDIT=COMPLETE`.

### G1 primary Golden Metal request-builder cluster
Metal image `0x7FF80D343000..0x7FF80D5C5C3D`.
All eight service-consumed keys have exact Metal-owned RIP xrefs in one primary cluster:
- llvmVersion `0x7FF80D37081F` (Metal +`0x2D81F`);
- requestType `0x7FF80D370832` (+`0x2D832`);
- sandboxTokens `0x7FF80D370914` (+`0x2D914`);
- targetData `0x7FF80D370939` (+`0x2D939`);
- data `0x7FF80D37095E` (+`0x2D95E`);
- pluginPath `0x7FF80D37097F` (+`0x2D97F`);
- client_name `0x7FF80D3709FD` (+`0x2D9FD`);
- APISpecifiedTimeoutInSeconds `0x7FF80D370A13` (+`0x2DA13`).
Additional xrefs: requestType +`0x1089E1`; data +`0xDB881`.

Classification: `G1_GOLDEN_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_CLUSTER=STATIC_MAPPED`.
Exact writer value sources remain UNKNOWN pending backslice.

### Golden 3802 runtime lane mapped
`0x238E3` = `MTLCompilerObject::backendCompileExecutableRequest(BinaryRequestData&)` immediately after `Build request: pipeline` and at the following `mach_absolute_time` call.
`0x1DFA3` = `MTLCompilerObject::serializeBackendCompilationOutput(...)` immediately after `Compilation (pipeline) time %f ms`.

Thus working Golden 3802 has observed pipeline start plus later timing/serialization-stage evidence.

## CURRENT FRONTIER / NEXT ACTION — D97AZ
Remain in Golden. Do NOT start Tahoe eligibility bypass yet.

Next bounded collector is a read-only Golden Metal primary request-builder value/dataflow backslice around +`0x2D81F..0x2DA13`.
Goals:
- map containing function/range;
- pair each key xref with its XPC setter;
- recover exact value source for `llvmVersion` and `requestType` first, then the other six where statically resolvable;
- keep alternate requestType/data xrefs separate;
- classify each field as `STATIC_VALUE_SOURCE_PROVEN`, `STRUCTURAL_SOURCE_MAPPED`, or `UNKNOWN`.

No debugger attach, persistent instrumentation, system mutation, Root Patch or reboot. Only after D97AZ should repeated Golden boots or a short Metal System Trace be selected for values still UNKNOWN.
