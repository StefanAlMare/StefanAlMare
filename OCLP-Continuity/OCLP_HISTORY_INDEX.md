# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AU_GOLDEN_BOOT_ALIGNED_GENERATION_LANE_DIVERGENCE_PROVEN_OBSERVED_D97AV_PRODUCER_MAP_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / baseline
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package. No automatic Root Patch/reboot. Accepted Tahoe baseline P1 -> P2b -> P3 -> AIR00 -> D34, true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

User Golden comparator override: user may manually restore original OCLP Root Patch and boot Golden Sequoia for runtime comparison. Assistant does not automate Golden Root Patch/reboot and does not install experimental system-file patches on Golden without separate explicit authorization. Read-only/static/log collection is allowed; temporary debugger attempts do not authorize persistent Golden mutation.

## Natural-flow / Tahoe retained state
D97AD artificial terminals removed; natural P7 restored. D97AM source/build/artifact/deploy/Root Patch FULL PASS; accelerated 02:29 `NEGATIVE_NO_USABLE_GUI`, 02:32 VESA excluded.

D97AN exact natural 32023 runtime provenance PROVEN 79/79; zero 3802 sender records in failing accelerated MTL cohort; 65 exact 32023 PIDs. PCs: `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.

D97AO all-five natural validator late xrefs STATIC-PROVEN reachable. D97AP specialized start->timing CONTROL-FLOW PROVEN for observed cohort; `0xA5F81` mapped to backend start. D97AQ RunningBoard termination binding channel NEGATIVE; exact termination UNKNOWN.

## D97AR / D97AS
D97AR maps exact six donor thresholds:
`rbp-1f0 buffers>=65; rbp-1f8 samplers>=17; rbp-1f4 textures>=129; rbp-200 constant buffers>=15; rbp-1fc interpolated inputs>=32; rbp-1ec interpolated components>=125`.

D97AS proves a universal terminal six-bit Tahoe classifier STATIC-PROVEN feasible in exact single-entry 112-byte span `0x9D6BD..0x9D72D`, status `160..223`; full patch SHA `d677f8c5d2dda8a5c9813918807ce92b05f988ce47d656f1f280f0c36739c44d`. Not integrated/runtime-tested; reserve-ready.

## D97AT — working Golden comparator
User manually restored original OCLP Root Patch and booted working Golden 15.7.9/24G830. HD4400 0x0412 / Metal 2 / display online confirmed.

Exact Golden 32023 `1636896 / ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269 / D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; exact 3802 `438560 / 85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40 / D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.

Golden `validSimulatorMetadata` exact same six-counter static contract as Tahoe. Working Golden also emits truncated simulator-related messages, so those message fragments are not failure-specific.

D97AT LLDB `--waitfor` capture zero hits -> INCONCLUSIVE.

## D97AU — boot-aligned comparator changes active frontier
Golden boot first 3 minutes:
```text
TOTAL_MTL=451
32023=220
3802=193
ACTIVE_SET=3802,32023
8 exact-generation PIDs
32023-only: 360,395,528,553
3802-only: 367,398,540,565
no PID uses both generations
```

Tahoe failing reference: 32023=79, 3802=0, exact 32023 PID count=65.

Classification: boot-aligned generation-selection divergence is RUNTIME-PROVEN as an observation; causality not yet proven.

Golden exact 32023 first-3m PCs:
`0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`.
Tahoe exact 32023: `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.

Classification: boot-aligned 32023 request-lane divergence is RUNTIME-PROVEN as an observation. This promotes producer/handoff mapping above late-validator probing.

D97AU existing-PID LLDB attach was explicitly denied by macOS (`Not allowed to attach to process`); raw Golden six-counter values remain UNKNOWN_ATTACH_DENIED. Do not infer zero values and do not repeat same attach lane without new permission evidence.

## CURRENT ACTION — D97AV
Run read-only Golden wrapper `OCLP7_D97AV_GOLDEN_BOOT_LANE_AND_LLVMVERSION_PRODUCER_STATIC_AUDIT.command`, commit `d0e8c3f476ffcfd0deacb4866d94e6098a6bffcd`, blob `9344774aa6cf97f4216486b76e7bf470001ac20e`.

It maps 32023 PC `0x9A9FC` plus known `0x9FFEE/0xA0521/0xA5F81`, audits Golden Metal.framework `llvmVersion` producer and relevant constants/calls, and reconstructs exact per-PID first-three-minute generation/PC sequences. No debugger attach, Root Patch, system mutation or reboot.

STOP after D97AV; return complete report before rebooting Tahoe.