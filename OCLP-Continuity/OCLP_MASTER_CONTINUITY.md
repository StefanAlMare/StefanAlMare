# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FC_D97EZ_LOCAL_IMAC_BUILD_HELPER_READY.md`

Current local-compile authorization checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FB_LOCAL_IMAC_COMPILE_EXPLICITLY_AUTHORIZED.md`

Current decisive semantic checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EY_EXACT_SET_ID_MODE_TUPLE_SEMANTIC_PROOF.md`

Current GitHub Actions blocker checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FA_GITHUB_ACTIONS_EXECUTION_BLOCKER.md`

Previous accelerated-evidence transport checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EX_PERSISTENT_COLLECTOR_LIVE_PASS_ACCEL_BOOT_AUTHORIZED.md`

Previous D97ES VESA runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EV_D97ES_VESA_RUNTIME_PASS_ACCEL_MEASUREMENT_AUTHORIZED.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

## Current D97EZ authorities
Design:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_DESIGN.md`

Generator:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py`
- commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

Authorized local Intel-iMac build helper:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_IMAC_BUILD.sh`
- hardened helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`;
- Git blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext remains audited D97ES `OCLPMetalCompat.kext` 0.0.11;
- active D97ES executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- active D97ES UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64;
- D97EW persistent collector remains installed and previously LIVE/PASS;
- the D97EX accelerated measurement boot completed and its persisted run is `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`;
- current session is VESA recovery after that accelerated measurement;
- no D97EZ binary has been built or deployed yet;
- no functional `set_id_mode` correction is installed on ASUS2;
- no new T2/Haswell boot variable is authorized;
- no Root Patch or reboot is authorized at D97FC.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Functional baseline and permanent method
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains the accepted upstream semantic proof for AIR 2.6 / Metal 3.1. D34 cave `0xEF8..0xEFE` remains protected. D50/D68/D82 remain reserve-only; D84 is retired. Golden Sequoia remains immutable/read-only.

Module-boundary + semantic evidence + far-frontier methodology remains mandatory. Universal/no-PID coverage is required when requests can vary. Control-flow success is never semantic proof by itself.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions remain:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication;
- no global functional masking of `set_id_mode` bits;
- no semantic claim for bit `0x200` without direct proof.

## Settled downstream architecture
D97BV/D97DT selective true-3802 delivery is CLOSED PASS and must not be retested absent contradiction.

D97DX native-Metal-safe Root Patch is PASS and preserves native Tahoe main Metal while providing the bounded legacy compiler/Haswell compatibility path.

D97EB/D97EE proved framebuffer-count tuning NEGATIVE. Normal 3/3/3 remains authoritative.

D97EG-D97EP proved the exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` route and observer passthrough semantics. D97ES/D97ET added first-eight IORegistry tuple telemetry without argument mutation or return coercion. D97EW/D97EX closed the accelerated evidence transport gap using the persistent LaunchDaemon collector.

## D97EY — decisive exact tuple semantic proof
The immediately preceding accelerated boot was identified by saved boot args with `#-igfxvesa`, and exact D97ES 0.0.11 identity was preserved.

First D97EW sample captured 8 tuples with total call count 15; follow-up snapshots reached total call count 20.

Captured classes:
- accepted: `mode=0x24`, `badBits=0`, `goodBits=0x24`, Apple return `0`;
- rejected: `mode=0x224`, `badBits=0x200`, `goodBits=0x24`, Apple raw return `0xE00002C2 = kIOReturnBadArgument`.

The only observed mode-bit difference between the accepted and rejected captured classes is `0x200`. This is SEMANTIC PROVEN for the captured calls. The semantic name/meaning of bit `0x200` remains UNKNOWN.

Therefore:
- no global mask is authorized;
- no production claim that `0x200` is universally unnecessary is authorized;
- the next experiment must be an exact-match boundary adapter, not a broad validator bypass.

## D97EZ exact-match experiment
D97EZ is LATENT unless new explicit bootarg `-ocmcd97ez` is active.

ACTIVE rule only:
- if and only if `originalMode == 0x00000224`, pass `0x00000024` to Apple original;
- every non-`0x224` mode is exact passthrough;
- `that` and `id` unchanged;
- Apple original called exactly once;
- Apple's exact IOReturn returned unchanged.

Telemetry:
- global/no-PID counters classify every routed call;
- first-eight D97ES fields preserve original input;
- D97EZ adds per-slot `PassedMode` so original and translated inputs are directly observable.

D97EZ is an experimental compatibility hypothesis, not yet deployed and not yet proven at runtime.

## Execution-lane authority — 2026-09-07 local-build exception
The user explicitly states that GitHub Actions quota/execution is currently exhausted/blocked and instructs that compilation should be performed locally on the user's more powerful home Intel iMac.

This satisfies the permanent rule that local compilation requires explicit user authorization.

Current execution policy:
- do NOT keep trying to compile D97EZ with GitHub Actions during the current quota-limited period;
- source/design/helper integration and persistence remain in GitHub;
- D97EZ compilation is explicitly authorized on the user's home Intel iMac;
- compilation on ASUS2 is NOT authorized;
- ASUS2 remains target-only for later identity-pinned deploy/live-state/manual boot/VESA evidence;
- returned local build artifact must be independently audited before any deployment.

D97FA remains historical evidence of the Actions execution failure, but D97FB/D97FC supersede its stop condition for compilation by explicit user authorization.

## D97FC helper contract
The local helper is fail-closed and must:
- verify exact D97DL/D97EH/D97EL/D97ES/D97EZ lineage identities;
- deterministically generate D97EZ twice and byte-compare;
- enforce exact-match-only source semantics and broad-mask absence;
- require non-empty D97ES->D97EZ diff;
- compile pinned Lilu + FeatureUnlock/MacKernelSDK x86_64;
- build OCLPMetalCompat 0.0.12 x86_64;
- record UUID/executable SHA/Info.plist SHA/source SHA;
- preserve strings/nm/disassembly artifacts;
- package kext, sources, generators, diff and logs;
- finalize report before SHA256 manifest generation;
- self-verify the frozen package manifest;
- create Desktop ZIP + ZIP SHA256 sidecar;
- never deploy, Root Patch, mutate EFI/NVRAM or reboot.

## CURRENT ACTION — AUTHORIZED HOME INTEL IMAC BUILD
Run exact helper `OCLP7_D97EZ_IMAC_BUILD.sh` from commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1` / Git blob `19a22fe133fe04d0758f8a14a5306d4f81d25007` on the authorized home Intel iMac.

Return:
1. complete terminal output;
2. produced `OCLP7_D97EZ_IMAC_BUILD_<stamp>.zip`;
3. optionally the adjacent `.zip.sha256` sidecar if convenient.

Then independently audit the complete returned build before any ASUS2 deployment. No deployment, Root Patch or reboot is authorized before that audit.
