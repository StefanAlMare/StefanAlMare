# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_GOLDEN_FULL_CONTRACT_BOOK_THEN_IDENTICAL_OCLP_TAHOE_ELIGIBILITY_BYPASS_D97AX_V2_NEXT.md`
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

Incremental checkpoints remain authoritative for historical detail. This MASTER is current-state/frontier only.

## Target
Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family, `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

Routine/static/log/small work stays on the target Mac under user control. GitHub is only for major compile/build/package and identity-pinned script persistence/delivery. Never auto Root Patch or reboot.

## Golden comparator authority
User may manually restore ORIGINAL OCLP Root Patch and boot working Golden Sequoia `15.7.9 / 24G830` as many times as useful for comparator work. Assistant does not automate Golden Root Patch/reboot and does not install experimental Golden system-file patches without separate explicit authorization.

## AUTHORITATIVE PROJECT ARCHITECTURE — 2026-09-04
The ORIGINAL working OCLP donor/root-patch path is the immutable semantic target. Do not modify or relax donor/compiler logic merely to accept Tahoe-specific data.

Architecture:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor path -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Historical custom interventions P1/P2b/P3/AIR00/D34/P6/P7 are hypotheses/adapters, not axioms. Any or all may retire once Tahoe producer normalization makes the original donor sufficient.

Logs are observation channels only. Compare actual request/message schemas, values, payloads, object layouts and handoff semantics.

## Identical-OCLP Tahoe comparator rule
After the Golden contract book is sufficiently complete, the Tahoe comparator must use the SAME ORIGINAL OCLP functional content as Golden.

The only Tahoe-specific OCLP delta permitted at that stage is a minimal eligibility/OS-support bypass that allows the otherwise-original Golden Root Patch to run on Tahoe. That bypass must be separately audited and proven not to alter:
- payload selection/content;
- MTLCompilerService selector semantics;
- MTLCompiler binaries/logic;
- request layout or serialized payload handling;
- AIR/bitcode semantics;
- driver payloads;
- any other functional donor behavior beyond the eligibility gate itself.

Where feasible, byte/SHA identity of Golden-vs-Tahoe donor artifacts must be proven before the Tahoe Root Patch is authorized. Then run the SAME collectors/workloads/boundaries on Tahoe and locate the earliest exact Golden-vs-Tahoe difference.

## Golden contract-book evidence labels
- `SCHEMA_STATIC_PROVEN`: key/type/layout/source demonstrated statically.
- `RUNTIME_OBSERVED`: exact cohort/lane/event observed.
- `RUNTIME_VALUE_PROVEN`: exact runtime value directly recovered.
- `GOLDEN_INVARIANT_PROVISIONAL`: repeated Golden boots/workloads agree, architecture not yet independently proven.
- `UNKNOWN`: exact value unavailable.
- `INCONCLUSIVE`: observation channel insufficient.

Never replace unavailable runtime values with inferred/static values.

## Golden contract-book layers
### G1 producer/XPC ingress
Metal.framework -> XPC request -> MTLCompilerService:
- complete recoverable XPC key/type schema;
- `llvmVersion` and request-class producers;
- generation split 3802 vs 31001->32023;
- runtime UUID/path/PC/PID/lane sequences;
- repeated-boot stability.

### G2 original MTLCompiler donor ingress/internal handoff
- request header fields/offsets;
- serialized payload, bitcode type/length/pointer and optional payload;
- AIR/Metal semantic version;
- getReadParameters/upgradeAIR/specialized/backend/module reconstruction/metadata contracts;
- exact runtime values where observable, otherwise explicit UNKNOWN.

### G3 compiler output -> Haswell driver
- GPUCompiler/Metal/IOGPU/AppleIntelHD5000GraphicsMTLDriver identities/load state;
- pipeline/library/function result paths and observable status contracts;
- Metal System Trace/xctrace capability;
- earliest Tahoe-vs-Golden output divergence before driver consumption.

Do not return to Tahoe functional mutation until Golden target contracts are sufficiently defined.

## Retained Tahoe evidence
Historical D97AM natural-P7 build/deploy/Root Patch FULL PASS; accelerated boot `2026-09-04 02:29` remained `NEGATIVE_NO_USABLE_GUI`; later VESA boot excluded.

D97AN exact natural 32023 provenance 79/79, 3802 zero. PCs: `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.
D97AO natural validator CFG fully resolved; all five late xrefs STATIC-PROVEN reachable.
D97AP specialized start->timing CONTROL-FLOW PROVEN for observed cohort.
D97AQ exact MTLCompilerService termination remains UNKNOWN/INCONCLUSIVE.

D97AR six donor thresholds:
- `[rbp-0x1f0] >=65` buffers;
- `[rbp-0x1f8] >=17` samplers;
- `[rbp-0x1f4] >=129` textures;
- `[rbp-0x200] >=15` constant buffers;
- `[rbp-0x1fc] >=32` interpolated inputs;
- `[rbp-0x1ec] >=125` interpolated component inputs.
D97AS late six-bit classifier remains reserve-only, not current frontier.

## Working Golden identities/runtime oracle
Golden Sequoia `15.7.9 / 24G830`, HD4400 `0x0412`, Metal 2, display online.

Golden 32023:
`1636896 / ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269 / D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

Golden 3802:
`438560 / 85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40 / D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.

Golden original MTLCompilerService:
SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`.

D97AU authoritative first-three-minute Golden window `2026-09-04 12:54:24..12:57:24`:
- total MTL records 451;
- 32023=220;
- 3802=193;
- 8 exact-generation PIDs;
- no PID uses both generations;
- Golden 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`.

Historical Tahoe custom-patch reference:
- 32023=79;
- 3802=0;
- 65 exact 32023 PIDs;
- `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.
This remains useful historical evidence but is not the final identical-OCLP comparator.

Golden LLDB attach was explicitly denied; raw six counter values remain `UNKNOWN_ATTACH_DENIED`. Do not retry the same debugger lane without new permission evidence.

## D97AV V2 retained static facts
Its erroneous 1970 boot subsection is retired; D97AU fixed window remains runtime authority.

Golden `0x9A9FC` = `MTLCompilerObject::upgradeAIRModule`, after `MTLCompiler upgrade pass forced to use air version %d.%d`.
Historical custom site ownership: P2b/AIR00/P7 -> `getReadParametersFromRequest`; P3 -> `backendCompileModule`; D34 -> `runFrameworkPasses`; P6 -> `invokeLowerModule` + `runFrameworkPasses`.

Golden original selector:
- 3802 at `0x3478` -> Versions/3802;
- 31001 at `0x3496` -> Versions/32023;
- no selector immediate 32023.
Historical P1 changes only 31001->32023 and leaves 3802 untouched; therefore Tahoe zero-3802 originates upstream of P1.

## Retired unrun D97AW
D97AW `8187316e... / e2d77333...` is retired before execution because the user broadened the goal to an exhaustive Golden contract census.

## CURRENT ACTION — D97AX V2 Golden ingress census
Core V1 is identity-pinned but unrun because preflight found `/usr/bin/system_profiler` path error:
- core commit `9f02c5c8200d2f37a785b0e87cd3ba8906a6da97`;
- core Git blob `7a2cd15ca7aebdb3fe3d4a530b8aed79ecab9074`.

Use hardened tooling-only wrapper:
`OCLP7_D97AX_V2_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS_HARDENED_WRAPPER.command`
- commit `d227fbc0b48415e3c3fda2b226fd279d786c9bfd`;
- Git blob `ddd1584a697ee432ceee2813effc3537f44173f4`.

V2 verifies the exact core blob, applies exactly two `/usr/bin/system_profiler -> /usr/sbin/system_profiler` replacements, checks patched zsh syntax and exactly three embedded Python blocks before execution.

D97AX census goals:
1. robust current boot chronology plus fixed D97AU window;
2. MTLCompilerService XPC getter/setter call census with recoverable keys/types/value sources;
3. Metal.framework XPC setter/getter census through visible/shared-cache-aware disassembly;
4. sender/receiver vocabulary intersection;
5. fixed-window + current-boot generation/PC/PID/message prototypes;
6. original 32023 donor function and request-memory displacement census + direct call graph;
7. Haswell graphics driver identity/load state and driver/WindowServer log prototypes;
8. xctrace/DTrace/ktrace observation capability inventory;
9. no debugger attach, cache extraction, system mutation, Root Patch or reboot.

Remain in Golden. Run only D97AX V2 and return complete TXT + JSON. STOP after D97AX V2. Then select repeated-Golden-boot/workload captures only from the exact UNKNOWN fields.
