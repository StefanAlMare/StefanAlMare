# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_SEQUOIA_15_8_UPDATE_DONOR_IDENTICAL_D97AZ_OLD_OS_FAIL_CLOSED_D97BA_REBASE_NEXT.md`.
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

D97AZ V3 tooling gates passed, then current system reported:
- `OS_VERSION=15.8`;
- `OS_BUILD=24H22`;
- 32023 SHA unchanged `ddabe975...`;
- 3802 SHA unchanged `85d4c285...`;
- MTLCompilerService SHA unchanged `31a6f745...`.
It then correctly stopped at `D97AZ_AUDIT=FAIL_CLOSED|REASON=GOLDEN_OS_IDENTITY` because D97AZ was pinned to GOLDEN_A 15.7.9.

Classification: `D97AZ_ON_SEQUOIA_15_8=TOOLING/IDENTITY_FAIL_CLOSED_NO_BACKSLICE_RESULT`.
This proves the three critical donor artifacts are byte-identical across 15.7.9 -> 15.8, so donor-side G1 receiver/G2/static 3802 mapping remains valid. Producer-side Metal/shared-cache addresses and current G1/G3 runtime are not automatically transferable and must be rebased.

## CURRENT ACTION — D97BA V2
Remain in Sequoia `15.8 / 24H22`. Do not start Tahoe eligibility bypass and do not rerun D97AZ yet.

Run `OCLP7_D97BA_V2_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_HARDENED_WRAPPER.command`:
- wrapper commit `641e3ef6ffb2ebfe5f38e8ff37d60ec2452b7427`;
- blob `13cf5578123134329665322a7a016fabed8e109c`.

Core `OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_DYNAMIC_METAL_AND_BOOT3M.command`:
- commit `4c3c76b826b50d6b98ff400baac1b65c709508f7`;
- blob `b9fd1966c7d88a98284dd5775cacb59036b26e00`.

D97BA dynamically locates cached Metal on 15.8, hashes only the Metal text image, recovers eight-key xrefs and compares relative offsets to GOLDEN_A, then inspects the first three minutes of the current boot for exact 32023/3802 UUID lanes/PCs and `Metal compositor activated`. No cache mmap/extraction, debugger attach, system mutation, Root Patch or reboot.
