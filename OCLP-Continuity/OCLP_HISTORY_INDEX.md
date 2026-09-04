# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AY_GOLDEN_SHARED_CACHE_SENDER_XREF_AND_3802_PIPELINE_MAP_PASS_VALUE_BACKSLICE_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / historical baseline
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package plus identity-pinned script persistence/delivery. No automatic Root Patch/reboot. Historical Tahoe custom lineage P1/P2b/P3/AIR00/D34/P6/P7 is evidence only and must not contaminate the final identical-OCLP comparator unless later justified as producer normalization below immutable donor semantics.

Golden comparator override: user may manually restore original OCLP Root Patch and boot working Golden Sequoia repeatedly. Assistant does not automate Golden Root Patch/reboot or install experimental Golden system-file patches without separate authorization.

## Final comparator architecture — 2026-09-04
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP donor -> Golden-equivalent compiler output -> Haswell driver -> image`.

First exhaustively characterize Golden. Then use SAME ORIGINAL OCLP functional content on Tahoe with only a separately audited eligibility/OS-support bypass. Run the SAME collectors and normalize Tahoe at the earliest exact difference.

## Golden oracle identities
Golden Sequoia `15.7.9 / 24G830`, HD4400 `0x0412`, Metal2, display online.
Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.
Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`, UUID `D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.
Golden original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
Original selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`.

## D97AU / D97AV retained
D97AU fixed Golden boot window `12:54:24..12:57:24`: total451, 32023=220, 3802=193, 8 exact-generation PIDs; 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`; 3802 PCs `0x1DFA3=96`, `0x238E3=97`.
D97AV static map: `0x9A9FC=upgradeAIRModule`; its 1970 boot subsection retired tooling-false.

## D97AX V2 — Golden contract census FULL PASS
Returned exact files:
- terminal `107555` bytes / SHA256 `3ee3abc33d296d5434fb84d8a6568b9b5d9820d6b23e7dd74a9770dde11199b5`;
- TXT `103237` bytes / SHA256 `ef01061f252f7ce64102b5f5959cc760cf1bd008f4a4a2506c539fccdc61c04e`;
- JSON `44765` bytes / SHA256 `6a69706a1ea523669413c9bf6ea4349eec93d67b200d6c4eca4ec471775f40b5`.

G1 receiver schema SCHEMA_STATIC_PROVEN: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.
G2 original donor dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule. D97AX direct-callgraph retired as tooling-inconclusive.
G3 positive corridor: Azul/HD5000 load -> WindowServer MTLCompilerService -> shader compilation -> `Metal compositor activated` at `12:55:25.092/25.093`.

## D97AY V2 — tooling-only fail closed
V2 wrapper contained a wrong expected core blob and stopped before core execution. Actual immutable core at commit `f76b04832150a0a8fd1eb80867785bf147f94537`: Git blob `3b07f1d4d52da948268fbd437781dd73092bef1c`, SHA256 `203f7255019ffb99e4d83084a8b22a6d9184f5134bab503891faf5d9863c7674`, 14109 bytes. No semantic result from V2.

## D97AY V3/core — Golden shared-cache sender xref + 3802 map PASS
Returned:
- JSON 112785392 bytes / SHA256 `2b873f21f71016b3911b2d028e01dc993a118b8f13c68260a6ec760c18c52184`;
- TXT 69660570 bytes / SHA256 `abfe1a04d512697df6c2bb57f31935108aed2a4d1cd8d5325fadc7f903db40e5`.

Final classifications:
`G1_GOLDEN_SHARED_CACHE_EIGHT_KEY_OWNER_MAP=STATIC_CENSUS_COMPLETE`;
`G1_GOLDEN_METAL_KEY_RIP_XREF_MAP=STATIC_CENSUS_COMPLETE`;
`G1_GOLDEN_XPC_WRITER_VALUE_SOURCES=NOT_YET_CLAIMED`;
`GOLDEN_3802_OBSERVED_PC_STATIC_MAP=COMPLETE`;
`D97AY_AUDIT=COMPLETE`.

Golden Metal image: `0x7FF80D343000..0x7FF80D5C5C3D`.
Primary eight-key request-builder cluster:
- llvmVersion +`0x2D81F`;
- requestType +`0x2D832`;
- sandboxTokens +`0x2D914`;
- targetData +`0x2D939`;
- data +`0x2D95E`;
- pluginPath +`0x2D97F`;
- client_name +`0x2D9FD`;
- APISpecifiedTimeoutInSeconds +`0x2DA13`.
Additional requestType xref +`0x1089E1`; additional data xref +`0xDB881`.

Exact xref counts: requestType2, sandboxTokens1, llvmVersion1, pluginPath1, targetData1, data2, client_name1, timeout1.
Classification: `G1_GOLDEN_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_CLUSTER=STATIC_MAPPED`.

Golden 3802 PC `0x238E3` maps to `backendCompileExecutableRequest` immediately after `Build request: pipeline`; `0x1DFA3` maps to `serializeBackendCompilationOutput` immediately after `Compilation (pipeline) time %f ms`. Working Golden therefore has observed pipeline start plus timing/serialization-stage evidence in 3802.

## CURRENT ACTION — D97AZ
Remain in Golden. Do not start Tahoe eligibility bypass.
Next: read-only value/dataflow backslice of the primary Metal request-builder cluster. Recover containing function, XPC setter pairing and exact source/value for `llvmVersion` and `requestType` first, then the other six where possible; keep alternate requestType/data paths separate. No debugger attach, Root Patch or reboot.
