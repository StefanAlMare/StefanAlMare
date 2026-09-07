# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FH_SET_ID_MODE_ADAPTER_SEMANTIC_PASS_NEW_DOWNSTREAM_FRONTIER.md`

Previous LATENT VESA gate:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FG_D97EZ_LATENT_VESA_RUNTIME_PASS_ACTIVE_ACCEL_AUTHORIZED.md`

Current independent build-audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT_PASS_VESA_DEPLOY_AUTHORIZED.md`

Original exact tuple semantic checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EY_EXACT_SET_ID_MODE_TUPLE_SEMANTIC_PROOF.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

## Current D97EZ authority
Design:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_DESIGN.md`

Generator:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py`
- commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

Audited local Intel-iMac build helper:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_IMAC_BUILD.sh`
- helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`;
- Git blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.

Audited D97EZ build:
- archive `OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`;
- bytes `154432`;
- ZIP SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`;
- package manifest SHA256 `f041bc196767ca8c0c4a0ae33b0091a424f3fc56f70bca0e95e7d62bee58a8ac`;
- generated source SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`;
- version `0.0.12` x86_64;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

D97FD independently proved ZIP/package/lineage/source/build/Mach-O/disassembly integrity PASS.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext remains audited D97EZ `OCLPMetalCompat.kext` 0.0.12;
- loaded/runtime UUID when tested: `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- D97EW persistent collector remains installed and proven LIVE/PASS;
- normal framebuffer baseline remains 3/3/3;
- current session is VESA recovery after the D97FH ACTIVE accelerated experiment;
- current recovery state should have active `-igfxvesa` and absent/inert `-ocmcd97ez`;
- no new T2/Haswell boot variable is authorized;
- no Root Patch change is authorized.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Functional baseline and permanent method
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains the accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave `0xEF8..0xEFE` remains protected. D50/D68/D82 remain reserve-only; D84 is retired. Golden Sequoia remains immutable/read-only.

Module-boundary + semantic evidence + far-frontier methodology remains mandatory. Universal/no-PID coverage is required when requests can vary. Control-flow success is never semantic proof by itself.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no true-five reapplication;
- no global functional masking of `set_id_mode` bits;
- no semantic claim for bit `0x200` beyond measured evidence.

## Settled architecture before D97FH
- D97BV/D97DT selective true-3802 runtime delivery is CLOSED PASS.
- D97DX native-Metal-safe Root Patch is PASS.
- D97EB/D97EE framebuffer-count tuning is CLOSED NEGATIVE; 3/3/3 authoritative.
- D97EG-D97EP exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` observer route and passthrough are CLOSED PASS for proven scope.
- D97ES/D97ET added first-eight tuple telemetry without mutation.
- D97EW/D97EX closed hard-recovery evidence transport.

## D97EY — pre-fix semantic failure proof
Captured accepted class:
- `mode=0x24`;
- badBits `0`;
- goodBits `0x24`;
- Apple return `0`.

Captured rejected class:
- `mode=0x224`;
- badBits `0x200`;
- goodBits `0x24`;
- Apple raw return `0xE00002C2 = kIOReturnBadArgument`.

The captured classes differ only by bit `0x200`. This is SEMANTIC PROVEN for captured calls. Semantic name of `0x200` remains UNKNOWN.

## D97EZ exact-match rule
LATENT unless `-ocmcd97ez` active.

ACTIVE rule only:
- exact `originalMode == 0x224` -> pass `0x24`;
- every non-`0x224` mode exact passthrough;
- `that/id` unchanged;
- one Apple original call;
- exact Apple IOReturn returned unchanged.

Global/no-PID counters classify every routed call. First-eight telemetry preserves original mode and separately records passed mode.

## D97FG — LATENT VESA runtime PASS
Exact runtime identity 0.0.12/UUID PASS. `D97EZFunctionalRequested=0`, `FunctionalMode=LATENT`, observer route PASS, zero set_id_mode calls and zero adaptation counters, publisher bounded to 300 ticks. This closed the required LATENT safety gate.

## D97FH — ACTIVE exact adapter SEMANTIC PASS / bad-bits blocker CLOSED
Accelerated ACTIVE persisted run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290`

Saved boot args prove:
- inert `#-igfxvesa`;
- active `-ocmcd97ez`;
- preserved `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh`, inert `#-ocmcd97bvcave`.

Loaded identity:
- D97EZ 0.0.12;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

At first 15 calls:
- exact-224 seen `12`;
- exact-224 adapted `12`;
- adapt success `12`;
- adapt failure `0`;
- other mode seen `3`;
- passthrough success `3`;
- passthrough failure `0`;
- `12 + 3 == 15` exhaustive classification PASS.

At stable 20 calls:
- exact-224 seen `16`;
- exact-224 adapted `16`;
- adapt success `16`;
- adapt failure `0`;
- other mode seen `4`;
- passthrough success `4`;
- passthrough failure `0`;
- `16 + 4 == 20` exhaustive classification PASS.

First-eight direct telemetry:
- slots 2/3/4/5/7/8 original `0x224` -> passed `0x24` -> Apple return `0`;
- slots 1/6 original `0x24` -> passed `0x24` -> Apple return `0`.

Therefore:
- exact D97EZ translation is STRUCTURAL-SEMANTIC PROVEN for captured traffic;
- every observed exact-224 call in the 20-call window is accepted by Apple after translation;
- every observed non-224 passthrough call succeeds;
- previous `Surface mode contains bad bits` rejection is CLOSED PASS as a causal blocker for this measured path.

This does NOT prove end-to-end accelerated GUI success. The system still required VESA recovery; the next failure is downstream of successful set_id_mode acceptance.

## Current causal frontier
Closed:
`Tahoe 0x224 -> legacy IOAccelSurface rejection`

Current:
`successful IOAccelSurface::set_id_mode acceptance -> next CoreDisplay / SkyLight / WindowServer / IOAccelerator failure preventing usable accelerated image`

## Execution-lane authority
User explicitly authorized local compilation on the home Intel iMac because GitHub Actions quota/execution is blocked. Do not retry GitHub Actions compilation during the current quota-limited period.

## CURRENT ACTION — READ-ONLY DOWNSTREAM FAILURE LOCALIZATION
Remain in VESA with D97EZ functional mode inactive. Do not change EFI, Root Patch, framebuffer counts or boot variables.

Analyze persisted system/unified logs from the immediately preceding ACTIVE accelerated boot around 2026-09-07 16:50 EEST and identify the first new failure after successful set_id_mode acceptance.

Do not repeat the ACTIVE boot unchanged until that downstream frontier is located.
