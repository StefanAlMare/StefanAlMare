# OCLP7 checkpoint — D97AEZ GitHub full PASS / ASUS2 activation ready

Date: 2026-09-02 EEST

## Authoritative verdict
D97AEZ is the smallest passive boot-bound observation transport for the already-installed exact D97AD diagnostic. Its complete GitHub-capable implementation lane is closed `PASS`. GitHub proved the implementation, identities, state machine, failure behavior and release package; it did not and cannot prove the live accelerated runtime result.

ASUS2 is Intel Haswell `x86_64`, not ARM. In this project `activation`/`activate`/`deploy` means enabling the passive observer. The sole literal `arm64` occurrence belongs to a negative non-x86_64 CI fixture.

No new functional OCLP patch and no new Root Patch are presently justified. D97AD remains installed with exact selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and exact final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, 1636896 bytes.

## Causal question retained
During a new failed accelerated boot, do naturally spawned exact-path `MTLCompilerService` processes map the current D97AD 31-window postimage or different runtime text?

- complete captured cohort with all 31 windows `MATCH`: only the known P7-vs-D97AD bounded-provenance mismatch hypothesis becomes `NEGATIVE` within those windows; no whole-image or runtime-semantic identity claim;
- one or more bounded-window `MISMATCH`: deployment/cache/image provenance becomes the active frontier;
- no natural process, task-read denial, UUID negative, race, wrong boot, interruption or incomplete coverage: `INCOMPLETE/UNKNOWN`, with no functional-patch inference.

## Frozen public release identities
The wrapper release content is immutable at public commit `eba63b606f4a48f747b1605e682d4ac2a624bb40`, tree `3622a4bf5ab0c34e444634b40ccf0f0fe18fa71d`. Both wrappers pin the earlier immutable payload commit/tree `b30a02fed23cdd75de880c90947f5c985571b53a` / `51b4df3c6935dbf818b5269c99a7752d71da2eba`, avoiding self-reference.

- runner `OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT_RUNNER.command`: mode `100755`, blob `74ab4b67f2d2bfe2e7635b1d4025e488d59c2ad2`, SHA256 `9c2dc2060ea557dfea9ca1901b055f1242ba4e34f5ec29297e6b847997a320a4`, 36701 bytes / 794 lines;
- plist `OCLP7_D97AEZ_BOOT_BOUND_ONE_SHOT.plist`: mode `100644`, blob `8ef97872d0a29c28a91c9d1818bf0c5c7492c080`, SHA256 `90c0801805319126520cc946d9f2bb4a69e95fd7a0be4a85914a1c3305ec03c5`, 1027 bytes;
- unchanged corrected D97AEX helper: mode `100755`, blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`, SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`, 94928 bytes;
- activation wrapper `OCLP7_D97AEZ_ACTIVATE_OBSERVER_PINNED_WRAPPER.command`: mode `100755`, blob `484182b44283c338213faeae46b9c8b2592df744`, SHA256 `1fe59799df1e46822dca2ffb4a0d203bd8f06cc41923fa7cfc78c29acd81c115`, 39883 bytes / 802 lines;
- retrieval wrapper `OCLP7_D97AEZ_RETRIEVE_PINNED_WRAPPER.command`: mode `100755`, blob `4492668f573c4ed6f4b9a3256bf9e449f273c983`, SHA256 `4e738b39fbd6dbaee95107f5caa65cbe78da8f6343698b55f20be36d963f1948`, 50220 bytes / 1044 lines;
- audit workflow: mode `100644`, blob `ba9e7ec4a605b87166947ed9d4b97882e5f77ad8`, SHA256 `8a37bd2e7e6b303d61ee36a9881128cd2f18b535e3adb783fe7a31d4dd33077e`, 67937 bytes / 1289 lines.

## GitHub exhaustive PASS
Private branch head/tree `09c937d32a13fd03242b0f6b9fdc7b5c8c6c3a66` / `cac21270170b010f8265b77aa39fd9c2658a4d2d`; pull-request merge-test SHA `2f577b1e5ea344d9dfec47c18723fd1e7700ef50`. Workflow ID `348570767`, run `33655550721`, job `100333075176`, runner `macos-15-intel`, conclusion `success`; all 11 functional steps passed.

The GitHub lane passed exact checkout/static identities, runner/plist syntax and safety, unchanged-helper provenance and six-marker self-test, fresh x86_64 helper compile/link/self-test, public payload pins, wrapper parsing/supply chain, and the complete isolated state matrix:

- same-activation-boot skip;
- first-different-x86_64-boot RC0 `MATCH` and atomic first claim;
- duplicate invocation/no rerun;
- RC2 task denial, RC3 incomplete and RC4 mismatch;
- non-x86_64 negative fixture;
- pre/post identity drift;
- contradictory terminals and truncated summary;
- grep execution error distinct from zero matches;
- watchdog, watchdog secondary failure and watchdog/signal overlap;
- truncated deployment consumed without rerun;
- interrupted partial state with atomic `DONE`.

Two genuine shell defects were exposed and repaired before freeze:

1. a compound zsh `local` declaration evaluated a later expansion before the earlier local was established under `set -u`; declarations are now sequential;
2. zsh sticky status after the simulated grep error made descriptor close inherit RC2 and `set -e` exit before sealing; all three closes are now exact `exec [34]>&- || true`, which closes the descriptor, preserves stderr and allows strict sealing to continue.

The final runner delta was independently audited as exactly those three close-line changes and frozen with no blocker.

## Downloaded artifact audit
Artifact `OCLP7-D97AEZ-GitHub-audit`, ID `9856618441`, is 66407 bytes and has ZIP digest/SHA256 `f7d377c7080eb709781d3e41b40803193be02fd74e02517e6d387b595d43f5e2`. ZIP CRC, five-entry outer inventory, outer hashes, safe path/type inventory and exact content checks passed after download.

The inner audit tar is 335872 bytes / SHA256 `d0ffcaf3164524013fbb6b6321288efddc83e53d9c2dc8650d34fc43faaa1969`, with 42 safe entries. The nested release-wrapper tar is 97280 bytes / SHA256 `dd05a77a309b6093c7045f259f6b9293ee7d3b27f3b8bacfddfcb480fcca2c11`; its activation wrapper, retrieval wrapper and manifest match the audited source copies byte-for-byte.

Authoritative markers: `D97AEZ_GITHUB_STATIC_BUILD_SELFTEST_SIMULATION_AUDIT=PASS`, `D97AEZ_GITHUB_EXHAUSTIVE_AUDIT=PASS`, `D97AEZ_RELEASE_WRAPPER_AUDIT_PACKAGE=PASS`. `D97AEZ_PRODUCTION_RUNNER_EXECUTION=NOT_RUN_IN_GITHUB` and `D97AEZ_ASUS2_ACCELERATED_RUNTIME=NOT_RUN_IN_GITHUB` remain explicit.

## Safety boundary
The activation wrapper installs and activates only the passive one-shot observer, validates the immediate same-boot skip, writes one Desktop report and ends with `USER_ACTION_NOW=STOP`. It never opens OCLP, performs Root Patch, reboots, or launches/stops/controls `MTLCompilerService`. The observer-owned installation/state is explicit, bounded, identity-pinned and removable.

No ASUS2 accelerated boot is authorized before the assistant audits the complete activation report. No new Root Patch is expected because D97AD is already installed and exact, but every later boot authorization remains a separate gate.

## CURRENT ACTION
User: run exactly one outer identity-pinned command that downloads the activation wrapper from immutable public release commit `eba63b606f4a48f747b1605e682d4ac2a624bb40`, verifies blob `484182b44283c338213faeae46b9c8b2592df744`, SHA256 `1fe59799df1e46822dca2ffb4a0d203bd8f06cc41923fa7cfc78c29acd81c115` and 39883 bytes, then executes it once. Return the complete Terminal transcript and the generated Desktop report. Then STOP.

Do not open OCLP, do not Root Patch and do not reboot yet. The assistant must audit the activation report before authorizing the separate accelerated-boot gate.

Baseline remains exactly P1+P2b+P3+AIR00+D34. Golden is immutable/read-only. D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.
