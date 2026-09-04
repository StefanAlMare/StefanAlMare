# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AU_LANE_DIVERGENCE_SEVEN_PATCH_UTILITY_REEVALUATION_D97AV_V2_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / baseline
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package. No automatic Root Patch/reboot. Historical Tahoe baseline P1 -> P2b -> P3 -> AIR00 -> D34, true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 active historically with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Golden comparator override: user may manually restore original OCLP Root Patch and boot working Golden Sequoia. Assistant does not automate Golden Root Patch/reboot or install experimental Golden system-file patches without separate explicit authorization.

## Tahoe natural-flow retained state
D97AM source/build/artifact/deploy/Root Patch FULL PASS; accelerated 02:29 `NEGATIVE_NO_USABLE_GUI`, 02:32 VESA excluded.

D97AN exact natural 32023 provenance 79/79, 3802 zero; PCs `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`. D97AO natural validator all-five late xrefs STATIC-PROVEN reachable. D97AP specialized start->timing CONTROL-FLOW PROVEN. D97AQ exact termination remains UNKNOWN.

D97AR maps six threshold locals. D97AS proves a terminal six-bit classifier statically feasible but it remains reserve-only because a stronger earlier producer/lane divergence has now been observed.

## Golden D97AT / D97AU
Working Golden Sequoia 15.7.9/24G830 confirmed HD4400 0x0412 / Metal2 / display online. Exact Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`; exact Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`.

Golden validator has exact same six-counter static contract as Tahoe. Working Golden also emits the same truncated simulator fragments, so those messages are not failure-specific.

D97AU Golden first-three-minute boot window: total451; 32023=220; 3802=193; 8 exact-generation PIDs; no PID uses both generations. Golden 32023 PCs: `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`.

Tahoe failing reference: 32023=79; 3802=0; exact 32023 PIDs=65; `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.

Boot-aligned generation-selection divergence and internal-32023 request-lane divergence are RUNTIME-PROVEN as observations; causality not yet proven.

D97AU explicit LLDB attach denial means raw Golden six-counter values remain UNKNOWN_ATTACH_DENIED; same debugger lane closed.

## Seven-patch utility reevaluation
User explicitly requested reevaluation of whether our patches actually help versus merely push Tahoe through a different path than Sequoia. Historical acceptance is no longer automatic KEEP status.

Exactly seven conceptual functional interventions are active:
1. P1 selector bridge `31001 -> 32023` in MTLCompilerService;
2. P2b request-layout bridge;
3. P3 serialized-bitcode path;
4. AIR00;
5. D34 semantic-equivalent reset;
6. P6 12 request-dialect ports;
7. P7 2 raw optional-payload ports.
D97AM UUID stamp is provenance-only.

P1 is the only intervention with direct pre-dlopen generation-selection influence. D97M native service selector maps 32023->32023, 3802->3802, others NULL; D97O proves XPC `llvmVersion` is selector source. P1 remaps only 31001 to 32023 and does not rewrite 3802.

P2b/P3/AIR00/D34/P6/P7 execute inside already-selected 32023. They cannot directly choose 3802 vs 32023 but may affect the specialized/backend internal lane.

Clean true-five combined runtime did not produce usable GUI. P6 and P7 each corrected real static dialect mismatches but each had runtime sufficiency NEGATIVE. No intervention is removed blindly or retained by inertia.

## CURRENT ACTION — D97AV V2 in Golden
Old unrun D97AV V1 is retired before execution.

Run read-only `OCLP7_D97AV_V2_GOLDEN_BOOT_LANE_LLVMVERSION_AND_PATCH_UTILITY_CAUSAL_AUDIT.command`, commit `56bf44d75d145a6b738468a9c3869c5291aa31be`, blob `d7b01788f8edc85c5190e481577b479e895892ea`.

It maps the four Golden 32023 lane PCs, exact per-PID first-three-minute sequences, Golden service selector constants/context, visible Metal `llvmVersion` context, and every exact P2b/P3/AIR00/D34/P6/P7 site as Golden preimage versus Tahoe postimage with containing function. It emits a conservative seven-patch utility/influence matrix.

STOP after D97AV V2; return report + JSON. No debugger, Root Patch, system mutation or reboot. After audit, design only a small targeted ablation matrix for plausible causal patch(es), not seven separate reboots.