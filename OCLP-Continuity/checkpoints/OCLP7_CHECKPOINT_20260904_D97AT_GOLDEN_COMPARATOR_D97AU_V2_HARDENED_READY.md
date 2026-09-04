# OCLP7 CHECKPOINT — 2026-09-04 — D97AT Golden comparator retained; D97AU V2 hardened ready

Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260904_D97AT_GOLDEN_WORKING_COMPARATOR_STATIC_EXACT_LIVE_WAITFOR_INCONCLUSIVE_D97AU_EXISTING_PID_CAPTURE_NEXT.md`.

All D97AS/D97AT evidence and the explicit Golden comparator authorization from the previous checkpoint remain unchanged.

## D97AU V1 identity retired before user execution
Initial D97AU wrapper commit/blob `19e61d3a85bacfed2bcab03020a2a2ad4e895a70 / c10d4cd98700fe465b1d2cc659bf4cc619a42245` was not run by the user. Pre-delivery audit found a zsh portability issue: unquoted scalar `$LIVE_PIDS` does not reliably word-split into multiple PID tokens under native zsh semantics. The design itself was unchanged, but multi-PID iteration needed hardening.

## D97AU V2 exact authoritative wrapper
Authoritative public wrapper:
- `OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_COMPARATOR.command`;
- commit `68046cbe634f11b0654a1a659b7dbaa627e01c31`;
- Git blob `7cc3efc69a3b7fd00e6f0506d15017cb7391239c`.

V2 changes only execution robustness before any runtime test:
- polls for an already-live `MTLCompilerService` for up to 10 seconds;
- uses native zsh forced word splitting `${=LIVE_PIDS}` to iterate multiple PID values correctly;
- otherwise preserves the Golden-only exact OS/build/SHA gate, boot-aligned first-three-minute 3802/32023 comparator, exact 32023 UUID/path selection, existing-PID temporary LLDB attachment, raw six-counter capture point `0x7FFB162C76C3`, threshold mask/backtrace output, and no persistent system-file mutation.

## CURRENT ACTION
Remain in working Golden Sequoia 15.7.9/24G830. Run D97AU V2 once and return both generated files:
- `OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_REPORT.txt`;
- `OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_DATA.json`.

Do not reboot to Tahoe before D97AU V2 output is audited. No Root Patch or system-file mutation is requested.