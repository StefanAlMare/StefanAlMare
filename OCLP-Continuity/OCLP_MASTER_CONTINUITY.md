# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_SEQUOIA_15_8_UPDATE_DONOR_IDENTICAL_D97AZ_OLD_OS_FAIL_CLOSED_D97BA_REBASE_NEXT.md`
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

Before Tahoe Root Patch, prove that bypass does not alter payload selection/content, MTLCompilerService selector semantics, MTLCompiler binaries/logic, request layout, AIR/bitcode handling, graphics-driver payloads or any donor behavior beyond eligibility. Then run the SAME collectors/workloads/boundaries on Tahoe and locate the earliest exact Golden-vs-Tahoe difference.

## Golden contract evidence labels
`SCHEMA_STATIC_PROVEN`, `RUNTIME_OBSERVED`, `RUNTIME_VALUE_PROVEN`, `GOLDEN_INVARIANT_PROVISIONAL`, `UNKNOWN`, `INCONCLUSIVE`. Never substitute inferred/static values for unavailable runtime values.

## Golden snapshots after Sequoia update
### GOLDEN_A — historical producer snapshot
Sequoia `15.7.9 / 24G830` with complete D97AX/D97AY evidence retained. This snapshot remains authoritative for the exact producer/runtime facts collected before the update.

### GOLDEN_B — current working Golden
User updated Sequoia to `15.8 / 24H22`, reports no EFI changes, manually reapplied Root Patch with the same original OCLP and reports working accelerated GUI as before.

D97AZ V3 independently observed exact donor hashes on 15.8 before fail-closing on its old OS pin:
- Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Therefore the original OCLP donor is byte-identical across 15.7.9 -> 15.8 for these three critical artifacts. G2 donor schema and selector/binary evidence survives. Producer-side Metal/shared-cache absolute addresses and current runtime G1/G3 must be rebased before further backslice.

## Original OCLP donor contract retained
Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no selector immediate 32023.
G1 receiver schema SCHEMA_STATIC_PROVEN: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.
G2 original 32023 donor request-memory dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule. D97AX direct-callgraph remains retired tooling-inconclusive.

## GOLDEN_A D97AU/D97AX/D97AY retained snapshot
D97AU 15.7.9 first-three-minute window: total451; 32023=220; 3802=193; 8 exact-generation PIDs; 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`; 3802 PCs `0x1DFA3=96`, `0x238E3=97`.

D97AX positive G3 corridor: Azul/HD5000 load -> WindowServer MTLCompilerService -> shader compilation -> `Metal compositor activated` at `12:55:25.092/25.093`.

D97AY 15.7.9 primary Metal eight-key request-builder offsets:
- llvmVersion +`0x2D81F`;
- requestType +`0x2D832`;
- sandboxTokens +`0x2D914`;
- targetData +`0x2D939`;
- data +`0x2D95E`;
- pluginPath +`0x2D97F`;
- client_name +`0x2D9FD`;
- APISpecifiedTimeoutInSeconds +`0x2DA13`;
additional requestType +`0x1089E1`; additional data +`0xDB881`.

15.7.9 Golden 3802 PC `0x238E3` maps to `backendCompileExecutableRequest` immediately after `Build request: pipeline`; `0x1DFA3` maps to `serializeBackendCompilationOutput` immediately after `Compilation (pipeline) time %f ms`. Since 3802 SHA is unchanged on 15.8, this binary-internal static mapping remains valid.

## D97AZ V3 on current 15.8 — correct fail-closed
Wrapper/tooling gates passed and current hashes were observed unchanged, then core printed:
`OS_VERSION=15.8`, `OS_BUILD=24H22`, followed by `D97AZ_AUDIT=FAIL_CLOSED|REASON=GOLDEN_OS_IDENTITY` because D97AZ was pinned to GOLDEN_A `15.7.9/24G830`.

Classification: `D97AZ_ON_SEQUOIA_15_8=TOOLING/IDENTITY_FAIL_CLOSED_NO_BACKSLICE_RESULT`.
No system mutation, cache mmap, persistent extraction/instrumentation, debugger attach, Root Patch or reboot occurred during D97AZ.

## CURRENT FRONTIER / NEXT ACTION — D97BA V2
Remain in GOLDEN_B Sequoia `15.8 / 24H22`. Do NOT start Tahoe eligibility bypass and do NOT rerun D97AZ yet.

Run hardened wrapper:
`OCLP7_D97BA_V2_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_HARDENED_WRAPPER.command`
- wrapper commit `641e3ef6ffb2ebfe5f38e8ff37d60ec2452b7427`;
- wrapper Git blob `13cf5578123134329665322a7a016fabed8e109c`.

Core:
`OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_DYNAMIC_METAL_AND_BOOT3M.command`
- commit `4c3c76b826b50d6b98ff400baac1b65c709508f7`;
- Git blob `b9fd1966c7d88a98284dd5775cacb59036b26e00`.

V2 applies exactly one tooling transform so runtime PID parsing prefers `processID`, then checks zsh syntax, exactly four embedded Python blocks, Python compile, 15.8/24H22 identity pins, Metal-range-only shared-cache reading and no-mutation safety tokens before execution.

D97BA goals:
1. prove current original-OCLP donor identity;
2. dynamically locate and hash the 15.8 cached Metal text image;
3. recover the eight-key Metal key/xref census from Metal only and compare xref offsets to GOLDEN_A;
4. capture first-three-minute 32023/3802 UUID lanes and PCs for the current 15.8 boot;
5. confirm `Metal compositor activated` in the current boot3m channel when available;
6. no cache mmap/extraction, debugger attach, system mutation, Root Patch or reboot.

After D97BA, adapt/rebuild D97AZ against exact GOLDEN_B addresses only if producer xrefs are revalidated.
