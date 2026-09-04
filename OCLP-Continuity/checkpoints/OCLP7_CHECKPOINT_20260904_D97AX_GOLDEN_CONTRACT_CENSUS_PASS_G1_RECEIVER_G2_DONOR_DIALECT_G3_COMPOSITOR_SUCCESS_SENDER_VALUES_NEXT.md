# OCLP7 CHECKPOINT — 2026-09-04 — D97AX Golden contract census PASS; G1 receiver schema, G2 donor dialect, G3 compositor-success corridor; sender/runtime values next

## User-authoritative architecture
The project remains:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

The ORIGINAL working OCLP donor is the immutable semantic oracle. Before the final Tahoe comparator, Golden may be manually rebooted repeatedly to establish exact contracts. The later Tahoe comparator must use the SAME ORIGINAL OCLP functional content, with only a separately audited eligibility/OS-support bypass permitted.

## D97AX V2 returned batch — exact identity
User returned:
- terminal transcript: `107555` bytes, SHA256 `3ee3abc33d296d5434fb84d8a6568b9b5d9820d6b23e7dd74a9770dde11199b5`;
- TXT report: `103237` bytes, SHA256 `ef01061f252f7ce64102b5f5959cc760cf1bd008f4a4a2506c539fccdc61c04e`;
- JSON report: `44765` bytes, SHA256 `6a69706a1ea523669413c9bf6ea4349eec93d67b200d6c4eca4ec471775f40b5`.

Outer wrapper blob exact `ddd1584a697ee432ceee2813effc3537f44173f4`; base core blob exact `7a2cd15ca7aebdb3fe3d4a530b8aed79ecab9074`; exactly two `system_profiler` tooling path replacements; patched core SHA256 `6d21332893de2408c70b8b7568a472a84bf4abd8806a820a9158d8cd6f8802a7`; exactly 3 embedded Python blocks compiled. Final outer/core RC0. No system mutation, debugger attach, cache extraction, Root Patch or reboot.

Classification: `D97AX_V2_EXECUTION_IDENTITY=FULL_PASS`.

## Golden identity — retained exact
- Sequoia `15.7.9 / 24G830`.
- Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.
- Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`, UUID `D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.
- Golden original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`.

## G1 — receiver-side XPC ingress schema STATIC PROVEN
D97AX statically recovered 15 XPC dictionary callsites in original MTLCompilerService. Exact input keys/types consumed by service:
- `requestType` -> `xpc_dictionary_get_uint64`;
- `sandboxTokens` -> `xpc_dictionary_get_value`;
- `llvmVersion` -> `xpc_dictionary_get_uint64`;
- `pluginPath` -> `xpc_dictionary_get_string`;
- `targetData` -> `xpc_dictionary_get_value`;
- `data` -> `xpc_dictionary_get_value`;
- `client_name` -> `xpc_dictionary_get_string`;
- `APISpecifiedTimeoutInSeconds` -> `xpc_dictionary_get_uint64`.

Service-side outputs also include `ProbGuardMalloc=true`, reply `error`, `errorMessage`, `reply`.

Classification: `G1_ORIGINAL_SERVICE_RECEIVER_XPC_SCHEMA=SCHEMA_STATIC_PROVEN`.

### G1 sender visibility limitation
D97AX visible/shared-cache-aware Metal disassembly recovered zero XPC set/get callsites and zero sender keys. This is NOT evidence that Metal sends no keys. Historical Tahoe D97QB/R/S/T already showed that Metal writer logic lives in the dyld shared cache and can be recovered with cache-aware raw mapping.

Classification: `G1_GOLDEN_METAL_SENDER_SCHEMA=D97AX_INCONCLUSIVE_VISIBILITY_CHANNEL`.
Do not treat `known_intersection=0` as NEGATIVE.

## G1 runtime lanes — RUNTIME OBSERVED
Authoritative fixed boot window `2026-09-04 12:54:24..12:57:24` reproduced exactly:
- records 451;
- 32023=220;
- 3802=193;
- OTHER=38;
- exact-generation PID count 8;
- 32023 PCs: `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`;
- 3802 PCs: `0x1DFA3=96`, `0x238E3=97`.

Extended same-boot observation through 16:10:12:
- records 1913;
- 32023=894;
- 3802=778;
- OTHER=241;
- 49 exact-generation PIDs;
- 32023: `0x9A9FC=362`, `0x9FFEE=257`, `0xA0521=257`, plus `0xA853C=9`, `0xAA5A4=9`;
- 3802: `0x1DFA3=389`, `0x238E3=389`.

3802 runtime messages map observationally to pipeline start/timing prototypes: `Build request: pipeline` and `Compilation (pipeline) time ...`.

Classification: `G1_GOLDEN_3802_AND_32023_DUAL_LANE_THIS_BOOT=RUNTIME_OBSERVED`.
Because this is still one boot, do not promote to repeated-boot invariant yet.

## G2 — original donor request dialect / memory schema
D97AX statically mapped donor functions and memory-access sets.

### getReadParametersFromRequest
Exact original-donor reads include:
- request/header access `+0xD0`;
- raw/request accesses `+0x30`, `+0x88`, `+0x8C`;
- additional structured accesses through arguments at `+0x08/+0x10/+0x18/+0x20/+0x30/+0x40/+0x41/+0x50`, etc.

This makes Golden `+0xD0`, `+0x88`, `+0x8C` part of the original donor contract, not custom-patch assumptions.

### invokeLowerModule / runFrameworkPasses
Original donor `invokeLowerModule` reads the legacy header/dialect offsets:
- `+0xC4`, `+0xC8`, `+0xCC`, `+0xDC`;
- `+0xE0` through another request/header base.
`runFrameworkPasses` also reads `+0xC4`, `+0x88`, `+0xA8`, `+0xB0` among other fields.

Therefore historical Tahoe P6/P7 patch sites correspond to real Tahoe-vs-donor dialect mismatches, but final repair must make Tahoe-produced structures Golden-equivalent before unchanged donor consumption rather than modifying donor reads.

### Other donor functions mapped
`upgradeAIRModule`, `buildSpecializedFunctionRequest`, `backendCompileExecutableRequest`, `backendCompileModule`, `validSimulatorMetadata`, `buildRequestWithOptions`, and `getSerializedModule` have exact static function/memory-access censuses retained in the D97AX JSON/TXT.

Classification: `G2_ORIGINAL_32023_DONOR_REQUEST_MEMORY_SCHEMA=SCHEMA_STATIC_PROVEN_FOR_MAPPED_ACCESSES`.
Exact runtime values remain UNKNOWN unless directly observed.

### D97AX direct-callgraph section — RETIRED TOOLING
The emitted targeted callgraph maps every target function to the same `generateBinaryArchiveID...cold.2`, which is not credible as a semantic direct-call map and reflects symbol-owner/stub/cold-range resolution failure.

Classification: `D97AX_TARGETED_DONOR_DIRECT_CALLGRAPH=INCONCLUSIVE_TOOLING_RETIRED`.
Do not use those edges as causal evidence.

## G3 — positive working Haswell corridor
Golden reports:
- Intel HD Graphics 4400, device `0x0412`, revision `0x000b`, VRAM 1536 MB, Metal 2, display online;
- loaded `AppleIntelFramebufferAzul 18.0.8`;
- loaded `AppleIntelHD5000Graphics 18.0.8`.

Positive boot chronology:
- `12:55:18.961/18.962`: Azul and HD5000 graphics load notifications;
- `12:55:20.993..21.008`: IGPU/Framebuffer vendor events;
- `12:55:22.093`: WindowServer opens `com.apple.MTLCompilerService`;
- `12:55:22.094+`: repeated Metal shader compilation;
- `12:55:25.092/25.093`: `Metal compositor activated.`

Classification: `G3_GOLDEN_HASWELL_TO_METAL_COMPOSITOR_SUCCESS_CORRIDOR=RUNTIME_OBSERVED`.
This is a high-value positive boundary for the later identical-OCLP Tahoe comparator.

Messages such as RunningBoard `setGPURole ... nil IOGPU device ref` and early kernelmanager restricted-lookup warnings occur in this working Golden boot and therefore are not failure-specific by themselves.

## Observation capabilities
Golden has Xcode `xctrace`; `Metal System Trace` template is available. `/usr/sbin/dtrace` and `/usr/bin/ktrace` exist. D97AX inventoried these only; no trace was recorded.

## Golden UNKNOWN list after D97AX
Highest-priority unresolved contracts:
1. complete Golden Metal.framework sender-side XPC schema and exact writer value sources for the 8 service-consumed input keys;
2. exact runtime values/cohort relation for at least `llvmVersion` and `requestType`, ideally every scalar sender field;
3. static mapping of Golden 3802 PCs `0x238E3` and `0x1DFA3` to containing functions and exact start/timing semantics;
4. repaired direct-call/dataflow map among getReadParameters -> upgradeAIR / specialized / backend / module stages;
5. G3 compiler-output/GPU handoff detail beyond compositor activation, potentially via a controlled short Metal System Trace;
6. repeated-boot confirmation of the Golden dual-generation and success corridor.

## NEXT DIRECTION
Remain in Golden. Do NOT move to Tahoe eligibility bypass yet.
Next collector should be a read-only Golden shared-cache sender/XPC writer census that reuses the proven chunked dyld-cache mapping strategy, enumerates all service-consumed keys (not only `llvmVersion`), maps writer types/value sources, and also statically maps the two observed 3802 PCs. It must not mutate Golden, attach a debugger, Root Patch or reboot.

Only after that sender census is audited should a controlled repeated-Golden-boot and/or Metal System Trace capture be selected from the remaining UNKNOWN fields.
