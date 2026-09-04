# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97BA_GOLDEN_B_15_8_STATIC_REBASE_PASS_G3_SUCCESS_RUNTIME_LANE_INCONCLUSIVE_D97AZ_V4_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / final architecture
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package plus identity-pinned script persistence/delivery. No automatic Root Patch/reboot.

Final comparator architecture:
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP donor -> Golden-equivalent compiler output -> Haswell driver -> image`.

First characterize Golden completely, then use SAME ORIGINAL OCLP functional content on Tahoe with only a separately audited eligibility/OS-support bypass. Historical Tahoe custom patches remain evidence only unless later reintroduced as producer-side normalization.

## Golden snapshots
### GOLDEN_A — Sequoia 15.7.9 / 24G830
Complete D97AU/D97AX/D97AY snapshot retained.
Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.
Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`, UUID `D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.
Original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
Original selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`.

D97AU boot3m: total451, 32023=220, 3802=193, 8 exact-generation PIDs; 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`; 3802 PCs `0x1DFA3=96`, `0x238E3=97`.

D97AX G1 receiver schema SCHEMA_STATIC_PROVEN for eight inputs: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.
D97AX G2 donor dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule. G3 positive corridor reaches `Metal compositor activated`.

D97AY V3/core PASS. Primary Metal request-builder xref offsets on 15.7.9:
- llvmVersion +`0x2D81F`;
- requestType +`0x2D832`;
- sandboxTokens +`0x2D914`;
- targetData +`0x2D939`;
- data +`0x2D95E`;
- pluginPath +`0x2D97F`;
- client_name +`0x2D9FD`;
- timeout +`0x2DA13`;
additional requestType +`0x1089E1`; data +`0xDB881`.
Golden 3802 `0x238E3` maps to pipeline build start in `backendCompileExecutableRequest`; `0x1DFA3` maps to pipeline timing/serialization in `serializeBackendCompilationOutput`.

## GOLDEN_B — Sequoia 15.8 / 24H22 current
User updated Sequoia, reports no EFI changes, manually reapplied Root Patch with same OCLP and working acceleration as before.

D97AZ V3 observed unchanged 32023/3802/MTLCompilerService hashes, then correctly fail-closed on its old 15.7.9 OS pin. No backslice result from that run.

### D97BA — current producer rebase PASS
Returned exact files:
- JSON 10774 bytes / SHA256 `f702cd1bff179ce268d18d1ab42762f0e4fcba066b488de7fc3e1ae599444a48`;
- TXT 16246 bytes / SHA256 `79f2aa9d3e65f14258e75d1459127b4f5801b492418d6a750550a478df1a3ad4`.

Original donor artifacts remain byte-identical to GOLDEN_A.

Current cached Metal:
- text `0x7FF80D343000..0x7FF80D5C5C3D`;
- SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.

All eight primary request-builder xref offsets exactly match GOLDEN_A:
llvmVersion `+0x2D81F`, requestType `+0x2D832`, sandboxTokens `+0x2D914`, targetData `+0x2D939`, data `+0x2D95E`, pluginPath `+0x2D97F`, client_name `+0x2D9FD`, timeout `+0x2DA13`.
Alternate requestType `+0x1089E1` and data `+0xDB881` also remain.
Classification: `G1_GOLDEN_B_METAL_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_REBASE=STATIC_PROVEN_SAME_OFFSETS`.

G3 current working corridor: HD4400/Metal2/display online, Azul 18.0.8 + HD5000Graphics 18.0.8 loaded, driver notifications `18:13:31.615`, framebuffer events `18:13:34.269..34.284`, `Metal compositor activated` `18:13:35.728/35.730`.
Classification: `G3_GOLDEN_B_15_8_METAL_COMPOSITOR_SUCCESS=RUNTIME_OBSERVED`.

D97BA boot3m MTL query returned zero records. Its printed lane label is corrected/retracted. Authoritative classification: `G1_GOLDEN_B_15_8_BOOT3M_GENERATION_LANE=INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`. Do not infer generation absence.

## CURRENT ACTION — D97AZ V4
Remain in GOLDEN_B Sequoia `15.8 / 24H22`.
Run `OCLP7_D97AZ_V4_GOLDEN_15_8_METAL_REQUEST_BUILDER_VALUE_BACKSLICE_PINNED_HARDENED_WRAPPER.command`:
- commit `f0387a32d91abffb8f64e9d068ee3091dd04a0fe`;
- blob `70ef7429a6a4daf2312f20892e12a887f0c9a307`.

It reuses unchanged D97AZ core `fb509db4... / fec92ab8...`, updates only OS/build pins plus audited aligned-range/rel32 tooling transforms, and additionally pins current cached Metal text SHA `f3e49d47...` before execution.

Goal: static value/dataflow backslice for all eight request-builder fields, prioritizing exact source/value of `llvmVersion` and `requestType`; preserve alternate data/requestType paths. No system mutation, debugger attach, persistent instrumentation, Root Patch or reboot.
