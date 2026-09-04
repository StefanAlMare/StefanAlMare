# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97BA_GOLDEN_B_15_8_STATIC_REBASE_PASS_G3_SUCCESS_RUNTIME_LANE_INCONCLUSIVE_D97AZ_V4_READY.md`
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
User may manually restore ORIGINAL OCLP Root Patch and boot working Golden Sequoia as many times as useful for comparator work. This supersedes older wording that Golden must never be booted. Assistant does not automate Golden Root Patch/reboot and does not install experimental Golden system-file patches without separate explicit authorization.

## AUTHORITATIVE PROJECT ARCHITECTURE — 2026-09-04
The ORIGINAL working OCLP donor/root-patch path is the immutable semantic target.

Architecture:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor path -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Historical P1/P2b/P3/AIR00/D34/P6/P7 are adapters/hypotheses, not axioms. Any or all may retire when Tahoe producer normalization makes the original donor sufficient. Logs are observation channels only; compare actual schemas, values, payloads, layouts and handoff semantics.

## Identical-OCLP Tahoe comparator rule
Only after Golden is sufficiently characterized, Tahoe must use the SAME ORIGINAL OCLP functional content as Golden. The only Tahoe-specific delta permitted is a minimal eligibility/OS-support bypass that merely allows the otherwise-original Golden Root Patch to run on Tahoe.

Before Tahoe Root Patch, prove that the bypass does not alter payload selection/content, MTLCompilerService selector semantics, MTLCompiler binaries/logic, request layout, AIR/bitcode handling, graphics-driver payloads or any donor behavior beyond eligibility. Then run the SAME collectors/workloads/boundaries on Tahoe and locate the earliest exact Golden-vs-Tahoe difference.

## Golden contract evidence labels
`SCHEMA_STATIC_PROVEN`, `RUNTIME_OBSERVED`, `RUNTIME_VALUE_PROVEN`, `GOLDEN_INVARIANT_PROVISIONAL`, `UNKNOWN`, `INCONCLUSIVE`. Never substitute inferred/static values for unavailable runtime values.

## Golden snapshots
### GOLDEN_A — historical producer snapshot
Sequoia `15.7.9 / 24G830`. Complete D97AU/D97AX/D97AY evidence retained and authoritative for that snapshot.

### GOLDEN_B — current working Golden
Sequoia `15.8 / 24H22`. User reports no EFI changes, manually reapplied Root Patch with same original OCLP, accelerated GUI working.

## Original OCLP donor identity and contract
Across GOLDEN_A -> GOLDEN_B the critical donor artifacts are byte-identical:
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no selector immediate 32023.
G1 receiver schema SCHEMA_STATIC_PROVEN: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.
G2 original 32023 donor dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule. D97AX direct-callgraph remains retired tooling-inconclusive.

## GOLDEN_A retained runtime/static snapshot
D97AU first-three-minute window `2026-09-04 12:54:24..12:57:24`: total451; 32023=220; 3802=193; 8 exact-generation PIDs; 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`; 3802 PCs `0x1DFA3=96`, `0x238E3=97`.

D97AX positive G3 corridor: Azul/HD5000 load -> WindowServer MTLCompilerService -> shader compilation -> `Metal compositor activated` at `12:55:25.092/25.093`.

D97AY primary Metal request-builder xrefs:
- llvmVersion +`0x2D81F`;
- requestType +`0x2D832`;
- sandboxTokens +`0x2D914`;
- targetData +`0x2D939`;
- data +`0x2D95E`;
- pluginPath +`0x2D97F`;
- client_name +`0x2D9FD`;
- APISpecifiedTimeoutInSeconds +`0x2DA13`;
additional requestType +`0x1089E1`; additional data +`0xDB881`.

Golden 3802 PC `0x238E3` maps to `backendCompileExecutableRequest` immediately after `Build request: pipeline`; `0x1DFA3` maps to `serializeBackendCompilationOutput` immediately after `Compilation (pipeline) time %f ms`. Since 3802 SHA is unchanged, this binary-internal static mapping survives on GOLDEN_B.

## D97AZ V3 on GOLDEN_B — correct fail-closed
D97AZ V3 tooling gates passed, observed OS `15.8/24H22` and unchanged donor hashes, then correctly stopped at its old GOLDEN_A OS pin. Classification: `D97AZ_ON_SEQUOIA_15_8=TOOLING/IDENTITY_FAIL_CLOSED_NO_BACKSLICE_RESULT`.

## D97BA GOLDEN_B producer rebase — PASS with runtime-lane visibility limitation
Exact returned batch:
- JSON 10774 bytes / SHA256 `f702cd1bff179ce268d18d1ab42762f0e4fcba066b488de7fc3e1ae599444a48`;
- TXT 16246 bytes / SHA256 `79f2aa9d3e65f14258e75d1459127b4f5801b492418d6a750550a478df1a3ad4`.

D97BA dynamically mapped current cached Metal:
- text `0x7FF80D343000..0x7FF80D5C5C3D`;
- text SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.

All eight primary request-builder xref offsets and both alternate xrefs exactly match GOLDEN_A. Classification: `G1_GOLDEN_B_METAL_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_REBASE=STATIC_PROVEN_SAME_OFFSETS`.

GOLDEN_B positive G3 boot corridor:
- HD4400 `0x0412`, Metal2, display online;
- Azul 18.0.8 and AppleIntelHD5000Graphics 18.0.8 loaded;
- driver load notifications `18:13:31.615`;
- framebuffer events `18:13:34.269..34.284`;
- `Metal compositor activated` `18:13:35.728/35.730`.
Classification: `G3_GOLDEN_B_15_8_METAL_COMPOSITOR_SUCCESS=RUNTIME_OBSERVED`.

### D97BA boot3m generation-lane correction
Raw MTL log query returned zero records. Therefore D97BA's printed `G1_SEQUOIA_15_8_BOOT3M_GENERATION_LANE=RUNTIME_OBSERVED` is RETRACTED.
Authoritative classification: `G1_GOLDEN_B_15_8_BOOT3M_GENERATION_LANE=INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`.
Do not infer absence of 32023/3802 from that zero-record channel.

## CURRENT FRONTIER / NEXT ACTION — D97AZ V4
Remain in GOLDEN_B Sequoia `15.8 / 24H22`. Do NOT start Tahoe eligibility bypass yet.

Run only:
`OCLP7_D97AZ_V4_GOLDEN_15_8_METAL_REQUEST_BUILDER_VALUE_BACKSLICE_PINNED_HARDENED_WRAPPER.command`
- wrapper commit `f0387a32d91abffb8f64e9d068ee3091dd04a0fe`;
- wrapper Git blob `70ef7429a6a4daf2312f20892e12a887f0c9a307`.

Unchanged D97AZ core:
- commit `fb509db4b1e40c8e9c466fed45b53c8462ed408c`;
- blob `fec92ab86cad92cc69307284c6ad3cd26ed74c19`.

V4 changes only OS/build pins plus previously audited aligned range starts and signed rel32 translation, and additionally fail-closes unless cached Metal text SHA exactly equals `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.

Goal: pair all eight request-builder key xrefs with setters and backslice the XPC value source, prioritizing `llvmVersion` and `requestType`, then the other six; alternate data/requestType paths remain separate.
No debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.
