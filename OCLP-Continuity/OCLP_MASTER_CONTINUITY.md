# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AX_GOLDEN_CONTRACT_CENSUS_PASS_G1_RECEIVER_G2_DONOR_DIALECT_G3_COMPOSITOR_SUCCESS_SENDER_VALUES_NEXT.md`
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
User may manually restore ORIGINAL OCLP Root Patch and boot working Golden Sequoia `15.7.9 / 24G830` as many times as useful for comparator work. This explicitly supersedes the older permanent wording that Golden must never be booted. Assistant does not automate Golden Root Patch/reboot and does not install experimental Golden system-file patches without separate explicit authorization.

## AUTHORITATIVE PROJECT ARCHITECTURE — 2026-09-04
The ORIGINAL working OCLP donor/root-patch path is the immutable semantic target. Do not modify or relax donor/compiler logic merely to accept Tahoe-specific data.

Architecture:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor path -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Historical P1/P2b/P3/AIR00/D34/P6/P7 are adapters/hypotheses, not axioms. Any or all may retire when Tahoe producer normalization makes the original donor sufficient.
Logs are observation channels only. Compare actual request/message schemas, values, payloads, object layouts and handoff semantics.

## Identical-OCLP Tahoe comparator rule
Only after Golden is sufficiently characterized, Tahoe must use the SAME ORIGINAL OCLP functional content as Golden. The only Tahoe-specific OCLP delta permitted for that comparator is a minimal eligibility/OS-support bypass that merely allows the otherwise-original Golden Root Patch to run on Tahoe.

Before Tahoe Root Patch, prove that the bypass does not alter payload selection/content, MTLCompilerService selector semantics, MTLCompiler binaries/logic, request layout, AIR/bitcode handling, graphics-driver payloads or any functional donor behavior beyond eligibility. Prove unchanged byte/SHA identities wherever feasible.

Then run the SAME collectors/workloads/boundaries on Tahoe and locate the earliest exact Golden-vs-Tahoe difference. Final repair belongs below the immutable OCLP donor.

## Golden contract evidence labels
- `SCHEMA_STATIC_PROVEN`
- `RUNTIME_OBSERVED`
- `RUNTIME_VALUE_PROVEN`
- `GOLDEN_INVARIANT_PROVISIONAL`
- `UNKNOWN`
- `INCONCLUSIVE`
Never substitute inferred/static values for unavailable runtime values.

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

Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no selector immediate 32023. Historical P1 changed only 31001->32023 and left 3802 untouched, so the historical Tahoe zero-3802 condition originated upstream of P1.

## Historical Tahoe comparator retained only as reference
D97AM natural-P7 build/deploy/Root Patch FULL PASS; accelerated `2026-09-04 02:29` `NEGATIVE_NO_USABLE_GUI`; later VESA excluded.
D97AN exact natural 32023 provenance 79/79, 3802=0, 65 PIDs; PCs `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.
D97AO natural validator CFG all late xrefs STATIC-PROVEN reachable. D97AP specialized start->timing CONTROL-FLOW PROVEN. D97AQ termination remains UNKNOWN/INCONCLUSIVE. D97AR six donor threshold locals retained. D97AS six-bit classifier reserve-only.
This is historical custom-patch evidence, not the final identical-OCLP comparator.

## D97AU Golden runtime oracle
Authoritative first-three-minute Golden window `2026-09-04 12:54:24..12:57:24`:
- total 451 MTL records;
- 32023=220; 3802=193; OTHER=38;
- 8 exact-generation PIDs, no PID uses both generations;
- 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`;
- 3802 PCs `0x1DFA3=96`, `0x238E3=97`.
Golden LLDB attach was explicitly denied; raw six counter values remain `UNKNOWN_ATTACH_DENIED`.

## D97AV V2 retained facts
Its 1970 boot subsection is retired as tooling-false. Static map retained:
- `0x9A9FC` = `MTLCompilerObject::upgradeAIRModule`;
- historical P2b/AIR00/P7 sites are in `getReadParametersFromRequest`;
- P3 in `backendCompileModule`; D34 in `runFrameworkPasses`; P6 in `invokeLowerModule` + `runFrameworkPasses`.

## D97AX V2 — Golden contract census FULL PASS with two tooling limitations
Returned exact batch:
- terminal transcript `107555` bytes / SHA256 `3ee3abc33d296d5434fb84d8a6568b9b5d9820d6b23e7dd74a9770dde11199b5`;
- report TXT `103237` bytes / SHA256 `ef01061f252f7ce64102b5f5959cc760cf1bd008f4a4a2506c539fccdc61c04e`;
- JSON `44765` bytes / SHA256 `6a69706a1ea523669413c9bf6ea4349eec93d67b200d6c4eca4ec471775f40b5`.
Outer/base blob identities exact, exactly two tooling path replacements, patched core SHA256 `6d21332893de2408c70b8b7568a472a84bf4abd8806a820a9158d8cd6f8802a7`, exactly 3 embedded Python blocks compile PASS, final RC0, no mutations/attach/Root Patch/reboot.

### G1 receiver schema — SCHEMA_STATIC_PROVEN
Original MTLCompilerService consumes exactly recovered input keys/types:
- `requestType` uint64;
- `sandboxTokens` value;
- `llvmVersion` uint64;
- `pluginPath` string;
- `targetData` value;
- `data` value;
- `client_name` string;
- `APISpecifiedTimeoutInSeconds` uint64.
Service-side reply/output keys include `ProbGuardMalloc`, `error`, `errorMessage`, `reply`.

D97AX recovered zero sender-side Metal XPC callsites because the visible/shared-cache-aware disassembly channel did not expose cached Metal writer code. This is `INCONCLUSIVE_VISIBILITY_CHANNEL`, NOT a negative and NOT proof of zero sender keys.

### G1 runtime — RUNTIME_OBSERVED
Fixed D97AU window reproduced exactly. Extended same boot through 16:10:12 yielded 1913 records: 32023=894, 3802=778, OTHER=241, 49 exact-generation PIDs. 32023 PCs `0x9A9FC=362`, `0x9FFEE=257`, `0xA0521=257`, plus `0xA853C=9`, `0xAA5A4=9`; 3802 `0x1DFA3=389`, `0x238E3=389`.
This strongly supports persistence within one boot, but repeated-boot invariant is not yet claimed.

### G2 donor request dialect — SCHEMA_STATIC_PROVEN for mapped accesses
Original `getReadParametersFromRequest` reads `+0xD0`, `+0x30`, `+0x88`, `+0x8C` plus the recorded structured fields.
Original `invokeLowerModule` reads donor dialect `+0xC4/+0xC8/+0xCC/+0xDC` and `+0xE0` through its request/header arguments.
`runFrameworkPasses` includes reads `+0xC4`, `+0x88`, `+0xA8`, `+0xB0` among others.
Other donor functions mapped: `upgradeAIRModule`, `buildSpecializedFunctionRequest`, `backendCompileExecutableRequest`, `backendCompileModule`, `validSimulatorMetadata`, `buildRequestWithOptions`, `getSerializedModule`.
Exact runtime field values remain UNKNOWN unless directly observed.

D97AX targeted direct-callgraph section is retired as `INCONCLUSIVE_TOOLING`: its symbol-owner/stub/cold resolution mapped every target to the same `generateBinaryArchiveID...cold.2`; do not use those edges causally.

### G3 positive working corridor — RUNTIME_OBSERVED
Loaded `AppleIntelFramebufferAzul 18.0.8` and `AppleIntelHD5000Graphics 18.0.8`.
Positive chronology:
- 12:55:18.961/18.962 driver load notifications;
- 12:55:20.993..21.008 framebuffer/IGPU events;
- 12:55:22.093 WindowServer opens `com.apple.MTLCompilerService`;
- 12:55:22.094+ shader compilation;
- 12:55:25.092/25.093 `Metal compositor activated.`
This is the positive target corridor for the later identical-OCLP Tahoe comparator.

Working Golden also emits RunningBoard `setGPURole ... nil IOGPU device ref` and early restricted-lookup warnings, so those messages are not failure-specific by themselves.

### Observation capability
Xcode `xctrace` is present and includes `Metal System Trace`; DTrace and ktrace exist. No Metal System Trace has been recorded yet.

## CURRENT FRONTIER / NEXT ACTION
Remain in Golden. Do NOT start Tahoe eligibility bypass yet.

Highest-priority UNKNOWN is G1 sender-side contract. Next read-only collector must reuse the proven chunked dyld-shared-cache mapping method to recover Golden Metal.framework writers for all 8 service-consumed input keys, map setter types/value sources, and statically map observed 3802 PCs `0x238E3`/`0x1DFA3`. It should also repair the narrow direct-call/dataflow map without trusting the D97AX cold-symbol result.

After that collector is audited, select a controlled repeated-Golden-boot and/or short Metal System Trace only for the exact remaining UNKNOWN fields. No debugger attach, system mutation, Root Patch or reboot in the next static collector.
