# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AY_V2_PIN_MISMATCH_TOOLING_ONLY_V3_DOUBLE_PIN_READY.md`
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
D97AM natural-P7 build/deploy/Root Patch FULL PASS; accelerated `2026-09-04 02:29` `NEGATIVE_NO_USABLE_GUI`. D97AN exact natural 32023 provenance 79/79, 3802=0, 65 PIDs; PCs `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`. D97AO/AP/AQ/AR/AS retained as historical custom-patch evidence only, not the final identical-OCLP comparator.

## D97AU Golden runtime oracle
Authoritative first-three-minute Golden window `2026-09-04 12:54:24..12:57:24`:
- total 451 MTL records;
- 32023=220; 3802=193; OTHER=38;
- 8 exact-generation PIDs, no mixed-generation PID;
- 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`;
- 3802 PCs `0x1DFA3=96`, `0x238E3=97`.
Golden LLDB attach was denied; raw six-counter values remain `UNKNOWN_ATTACH_DENIED`.

## D97AX V2 — Golden contract census FULL PASS with tooling limitations
Exact batch: terminal `107555` bytes / SHA256 `3ee3abc33d296d5434fb84d8a6568b9b5d9820d6b23e7dd74a9770dde11199b5`; TXT `103237` bytes / SHA256 `ef01061f252f7ce64102b5f5959cc760cf1bd008f4a4a2506c539fccdc61c04e`; JSON `44765` bytes / SHA256 `6a69706a1ea523669413c9bf6ea4349eec93d67b200d6c4eca4ec471775f40b5`.

### G1 receiver schema — SCHEMA_STATIC_PROVEN
Original service consumes:
`requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.
D97AX sender-side Metal scan recovered zero calls only due visibility limitations. This is `INCONCLUSIVE`, not a negative.

### G1 runtime — RUNTIME_OBSERVED
Extended same boot through 16:10:12: 1913 records, 32023=894, 3802=778, OTHER=241, 49 exact-generation PIDs. 32023 PCs `0x9A9FC=362`, `0x9FFEE=257`, `0xA0521=257`, `0xA853C=9`, `0xAA5A4=9`; 3802 `0x1DFA3=389`, `0x238E3=389`.

### G2 donor dialect — SCHEMA_STATIC_PROVEN for mapped accesses
Original `getReadParametersFromRequest` reads `+0xD0`, `+0x30`, `+0x88`, `+0x8C`. Original `invokeLowerModule` reads `+0xC4/+0xC8/+0xCC/+0xDC` and `+0xE0`; `runFrameworkPasses` includes `+0xC4`, `+0x88`, `+0xA8`, `+0xB0`. D97AX direct-callgraph section is retired `INCONCLUSIVE_TOOLING`.

### G3 positive working corridor — RUNTIME_OBSERVED
Azul 18.0.8 and AppleIntelHD5000Graphics 18.0.8 load -> framebuffer events -> WindowServer opens MTLCompilerService at `12:55:22.093` -> shader compilation -> `Metal compositor activated` at `12:55:25.092/25.093`.
Xcode `xctrace` includes `Metal System Trace`; DTrace and ktrace exist. No Metal System Trace recorded yet.

## D97AY V2 — TOOLING-ONLY FAIL CLOSED
V2 wrapper `c4d8795734b93cfeac1e0d7005b9914c0fddd01d / 34530755218e024bc27ea60c36acb6993557f5c2` passed its own outer identity, then downloaded the immutable D97AY core and failed before core execution because the wrapper had a wrong expected core blob.

Actual core identity observed on Golden:
- commit `f76b04832150a0a8fd1eb80867785bf147f94537`;
- Git blob `3b07f1d4d52da948268fbd437781dd73092bef1c`;
- SHA256 `203f7255019ffb99e4d83084a8b22a6d9184f5134bab503891faf5d9863c7674`;
- bytes `14109`.

No D97AY core scan executed, so no semantic/static result exists from V2. No mutation/cache mmap/extraction/debugger/Root Patch/reboot occurred.

## CURRENT FRONTIER / NEXT ACTION — D97AY V3
Remain in Golden. Do NOT start Tahoe eligibility bypass.

Run only hardened wrapper `OCLP7_D97AY_V3_GOLDEN_SHARED_CACHE_EIGHT_KEY_HARDENED_WRAPPER.command`:
- wrapper commit `eaff09fb2b3c2d8b1005b38de380759710625119`;
- wrapper Git blob `4dece1e36f339d57b2e4602d0586540a8b2cb5a3`.

V3 double-pins the unchanged core by both corrected Git blob and SHA256, then verifies core zsh syntax, exactly one embedded Python block, exact eight-key cardinality and safety markers before execution.

D97AY core goal: recover Golden shared-cache sender/owner/xrefs for all eight service-consumed keys and statically map observed 3802 PCs `0x1DFA3`/`0x238E3`. No debugger attach, cache extraction/mmap, system mutation, Root Patch or reboot.
