# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AY_V2_PIN_MISMATCH_TOOLING_ONLY_V3_DOUBLE_PIN_READY.md`.
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

G1 receiver schema SCHEMA_STATIC_PROVEN: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`. Sender-side Metal zero-recovery is INCONCLUSIVE visibility, not negative.

Extended same boot: 1913 records, 32023=894, 3802=778, OTHER=241, 49 exact-generation PIDs. G2 original donor dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule. D97AX direct-callgraph retired as tooling-inconclusive.

G3 positive corridor: Azul/HD5000 load -> framebuffer events -> WindowServer opens MTLCompilerService -> shader compilation -> `Metal compositor activated` at `12:55:25.092/25.093`. Metal System Trace is available but not yet recorded.

## D97AY V2 — tooling-only fail closed
V2 wrapper `c4d8795734b93cfeac1e0d7005b9914c0fddd01d / 34530755218e024bc27ea60c36acb6993557f5c2` passed outer identity but contained a wrong expected core blob `1ae81e...`.

User's exact downloaded core at immutable commit `f76b04832150a0a8fd1eb80867785bf147f94537` was:
- Git blob `3b07f1d4d52da948268fbd437781dd73092bef1c`;
- SHA256 `203f7255019ffb99e4d83084a8b22a6d9184f5134bab503891faf5d9863c7674`;
- 14109 bytes.

Wrapper stopped at `BASE_BLOB_MISMATCH` before executing the core. Therefore D97AY V2 produced no semantic/cache-scan result and made no mutation, cache mmap/extraction, debugger attach, Root Patch or reboot.

Classification: `D97AY_V2=TOOLING_ONLY_BAD_EXPECTED_CORE_BLOB_FAIL_CLOSED`.

## CURRENT ACTION — D97AY V3
Run `OCLP7_D97AY_V3_GOLDEN_SHARED_CACHE_EIGHT_KEY_HARDENED_WRAPPER.command`:
- commit `eaff09fb2b3c2d8b1005b38de380759710625119`;
- Git blob `4dece1e36f339d57b2e4602d0586540a8b2cb5a3`.

V3 double-pins the unchanged core with corrected Git blob + SHA256 and gates zsh syntax, exactly one embedded Python block, exact eight-key cardinality and read-only markers before running. Goal remains Golden shared-cache sender/owner/xref recovery for all eight input keys plus static 3802 PC mapping. Remain in Golden; no Root Patch/reboot.
