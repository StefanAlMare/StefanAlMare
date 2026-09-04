# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_GOLDEN_FULL_CONTRACT_BOOK_THEN_IDENTICAL_OCLP_TAHOE_ELIGIBILITY_BYPASS_D97AX_V2_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / historical baseline
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package plus identity-pinned script persistence/delivery. No automatic Root Patch/reboot. Historical Tahoe baseline P1 -> P2b -> P3 -> AIR00 -> D34, true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 historical runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Golden comparator override: user may manually restore original OCLP Root Patch and boot working Golden Sequoia repeatedly. Assistant does not automate Golden Root Patch/reboot or install experimental Golden system-file patches without separate explicit authorization.

## Tahoe natural-flow retained state
D97AM source/build/artifact/deploy/Root Patch FULL PASS; accelerated 02:29 `NEGATIVE_NO_USABLE_GUI`, 02:32 VESA excluded.

D97AN exact natural 32023 provenance 79/79, 3802 zero; PCs `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`. D97AO natural validator all-five late xrefs STATIC-PROVEN reachable. D97AP specialized start->timing CONTROL-FLOW PROVEN. D97AQ exact termination remains UNKNOWN.

D97AR maps six threshold locals. D97AS proves a terminal six-bit classifier statically feasible but it remains reserve-only because a stronger earlier producer/lane divergence is active.

## Golden D97AT / D97AU
Working Golden Sequoia 15.7.9/24G830 confirmed HD4400 0x0412 / Metal2 / display online. Exact Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`; exact Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`.

Golden validator has exact same six-counter static contract as Tahoe. Working Golden also emits the same truncated simulator fragments, so those messages are not failure-specific.

D97AU authoritative Golden boot window `12:54:24..12:57:24`: 32023=220, 3802=193, 8 exact-generation PIDs, no mixed-generation PID. Golden 32023 PCs: `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`.

Tahoe failing historical custom reference: 32023=79, 3802=0, exact 32023 PIDs=65, `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.

Boot-aligned generation-selection divergence and internal-32023 request-lane divergence are RUNTIME-PROVEN observations; causality not yet proven.

D97AU explicit LLDB attach denial means raw Golden six-counter values remain UNKNOWN_ATTACH_DENIED; same debugger lane closed.

## D97AV V2 — static PASS, boot subsection tooling false
User returned JSON/TXT batch and identities were independently verified:
- JSON 12407 bytes / SHA256 `685acdd2df077908eec6cbeedff60d2bb66bbbe4b323c670fdb603dcf1385626`;
- TXT 36248 bytes / SHA256 `2d6d6d6c06df896d251441eb00172e0b2d5d72a6a8e3bba40e4c8a1ed6dc2542`.

Golden identity and static seven-patch map PASS.

D97AV V2 boot subsection printed `1970-01-03 08:18:27..08:21:27`, caused by greedy `sed` matching `usec =` instead of epoch `sec =` in `kern.boottime`. Its 305-row/18-PID sequence data is RETIRED as tooling-false; D97AU absolute window remains runtime authority.

`0x9A9FC` is `MTLCompilerObject::upgradeAIRModule` immediately after log `MTLCompiler upgrade pass forced to use air version %d.%d`.

Historical site ownership: P2b/AIR00/P7 in `getReadParametersFromRequest`; P3 in `backendCompileModule`; D34 in `runFrameworkPasses`; P6 in `invokeLowerModule` + `runFrameworkPasses`.

Golden original service SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5` contains selector 3802 at `0x3478`, 31001 at `0x3496`, and no 32023 immediate. Golden maps `3802 -> MTLCompiler 3802`, `31001 -> MTLCompiler 32023`. Historical Tahoe P1 changes only `31001 -> 32023`, leaving 3802 untouched. Therefore Tahoe zero-3802 originates upstream of P1.

## 2026-09-04 final comparator methodology — Golden full contract, then identical original OCLP on Tahoe
User explicitly fixed the comparator design:
- first exhaustively scan working Golden Sequoia and its interaction with ORIGINAL OCLP, including repeated manual boots/workloads as needed;
- ORIGINAL OCLP functional behavior/payloads/selector/compiler path is the immutable oracle;
- build a contract book G1 producer/XPC ingress, G2 original donor request/payload/AIR/bitcode/module semantics, G3 compiler-output/Haswell-driver handoff;
- only after Golden is sufficiently mapped, run Tahoe with the SAME ORIGINAL OCLP functional content;
- the only Tahoe-specific OCLP delta permitted for that comparator is a minimal, separately audited eligibility/OS-support bypass that merely lets original OCLP apply the Golden-equivalent Root Patch on Tahoe;
- prove that this bypass does not alter payload content/selection, selector semantics, MTLCompiler binaries/logic, AIR/bitcode handling, request layout, or graphics-driver payloads;
- then run the SAME measurement suite on Tahoe and locate the first exact Golden-vs-Tahoe contract difference;
- final repair belongs below the immutable OCLP donor, normalizing Tahoe producer output until it becomes Golden-equivalent.

Historical P1/P2b/P3/AIR00/D34/P6/P7 must not contaminate the final identical-OCLP comparator unless later explicitly justified as producer-side normalization outside donor semantics.

D97AW `8187316e... / e2d77333...` is RETIRED UNRUN because its narrow questions are subsumed by the broader contract census.

## CURRENT ACTION — D97AX V2 Golden ingress census
Core V1 `OCLP7_D97AX_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS.command`:
- commit `9f02c5c8200d2f37a785b0e87cd3ba8906a6da97`;
- blob `7a2cd15ca7aebdb3fe3d4a530b8aed79ecab9074`;
- unrun because preflight found macOS `system_profiler` path should be `/usr/sbin`, not `/usr/bin`.

Hardened V2 wrapper `OCLP7_D97AX_V2_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS_HARDENED_WRAPPER.command`:
- commit `d227fbc0b48415e3c3fda2b226fd279d786c9bfd`;
- blob `ddd1584a697ee432ceee2813effc3537f44173f4`.

V2 verifies the exact core blob, applies exactly two `system_profiler` path replacements, verifies patched zsh and exactly three embedded Python blocks, then runs a read-only census of XPC sender/receiver schema, runtime lanes, donor request-memory access sets, Haswell driver identity/load state and available non-persistent observation channels.

STOP after D97AX V2; return TXT + JSON. No debugger, cache extraction, Root Patch, system mutation or reboot. After audit, choose the first repeated-Golden-boot/workload capture only from the contract fields that remain UNKNOWN.
