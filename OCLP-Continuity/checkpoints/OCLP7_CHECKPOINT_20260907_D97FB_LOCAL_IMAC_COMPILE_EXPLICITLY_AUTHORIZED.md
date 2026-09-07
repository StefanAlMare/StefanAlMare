# OCLP7 D97FB — local Intel iMac compile explicitly authorized

Date: 2026-09-07 EEST

## User authorization
The user explicitly overrode the temporary GitHub-first compile lane for the current quota-limited period and authorized local compilation on the user's home Intel iMac.

Exact operational meaning:
- do not spend further effort trying to execute D97EZ builds in GitHub Actions while the current Actions quota/execution lane is unavailable;
- local compilation on the user's home Intel iMac is explicitly authorized;
- this is an authorized exception to the permanent rule that local compilation is not an implicit fallback;
- GitHub remains the source-of-truth/integration/persistence lane for source, design, helper scripts, hashes, checkpoints and later audit results;
- ASUS2 remains reserved for target-local deploy/live-state/manual boot/VESA evidence only;
- no compile on ASUS2 is authorized;
- no Root Patch or reboot is authorized by this checkpoint.

## Current semantic authority
D97EY remains the decisive semantic checkpoint:
- observed accepted mode: `0x24`, badBits `0`, goodBits `0x24`, Apple return success;
- observed rejected mode: `0x224`, badBits `0x200`, goodBits `0x24`, Apple return `0xE00002C2 = kIOReturnBadArgument`;
- semantic meaning of bit `0x200` remains UNKNOWN;
- global masking remains prohibited.

## Current D97EZ design
D97EZ remains an exact-match experimental handoff adapter only:
- LATENT unless `-ocmcd97ez` is present;
- if and only if ACTIVE and `originalMode == 0x224`, pass `0x24` to Apple original;
- all other modes pass unchanged;
- `that` and `id` unchanged;
- Apple original called exactly once;
- exact Apple IOReturn returned unchanged;
- first-eight telemetry preserves originalMode and records passedMode;
- global/no-PID counters classify all routed calls.

Generator authority:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py`
- commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

## CURRENT ACTION
Prepare and audit a fail-closed Intel-iMac local build helper for D97EZ 0.0.12. The helper must reconstruct exact D97ES lineage from pinned Git sources, verify all identities, generate D97EZ deterministically, compile x86_64, package the kext/source/generators/logs/disassembly/hash manifest, and stop without deploy/Root Patch/reboot.

After the user runs the helper on the authorized home Intel iMac and returns the ZIP/build output, independently audit the returned artifact before any ASUS2 deployment is considered.
