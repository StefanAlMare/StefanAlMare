# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FG_D97EZ_LATENT_VESA_RUNTIME_PASS_ACTIVE_ACCEL_AUTHORIZED.md`

Current pre-runtime deployment checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FF_D97EZ_EFI_IDENTITY_PASS_LATENT_VESA_REBOOT_AUTHORIZED.md`

Current independent build-audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT_PASS_VESA_DEPLOY_AUTHORIZED.md`

Current decisive semantic checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EY_EXACT_SET_ID_MODE_TUPLE_SEMANTIC_PROOF.md`

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

D97FD independently proved ZIP/package/lineage/source/build/Mach-O/disassembly integrity PASS. This proves build/static/binary correctness, not accelerated runtime success.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active and loaded kext is audited D97EZ `OCLPMetalCompat.kext` 0.0.12;
- loaded UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- D97EW persistent collector remains installed and previously LIVE/PASS;
- current session is the completed D97EZ LATENT VESA validation boot;
- current boot args are `-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh`;
- `-igfxvesa` active;
- `-ocmcd97ez` absent;
- no new T2/Haswell variable active;
- normal 3/3/3 framebuffer baseline remains authoritative;
- no Root Patch change is authorized.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Functional baseline and permanent method
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains the accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave `0xEF8..0xEFE` remains protected. D50/D68/D82 remain reserve-only; D84 is retired.

Module-boundary + semantic evidence + far-frontier methodology remains mandatory. Universal/no-PID coverage is required when requests can vary. Control-flow success is never semantic proof by itself.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no true-five reapplication;
- no global functional masking of `set_id_mode` bits;
- no semantic claim for bit `0x200` without direct proof.

## Settled downstream architecture
D97BV/D97DT selective true-3802 runtime delivery is CLOSED PASS and not to be retested absent contradiction.
D97DX native-Metal-safe Root Patch is PASS.
D97EB/D97EE framebuffer-count tuning is CLOSED NEGATIVE; normal 3/3/3 remains authoritative.
D97EG-D97EP exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` observer route and passthrough are CLOSED PASS for their proven scope.
D97ES/D97ET added first-eight tuple telemetry without mutation; D97EW/D97EX closed the hard-recovery evidence transport gap.

## D97EY — decisive exact tuple semantic proof
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

The captured accepted/rejected classes differ only by bit `0x200`. This is SEMANTIC PROVEN for captured calls. Semantic meaning of `0x200` remains UNKNOWN. No global mask is authorized.

## D97EZ exact-match experiment
LATENT unless `-ocmcd97ez` is active.

ACTIVE rule only:
- exact `originalMode == 0x224` -> pass `0x24`;
- every non-`0x224` mode exact passthrough;
- `that/id` unchanged;
- one Apple original call;
- exact Apple IOReturn returned unchanged.

Global/no-PID counters classify every routed call. First-eight telemetry preserves original mode and separately records passed mode.

## D97FG — LATENT VESA runtime PASS
Exact runtime evidence on 25G82:
- loaded D97EZ 0.0.12 UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- `D97EZFunctionalRequested=0`;
- `D97EZFunctionalMode=LATENT`;
- all D97EZ seen/adapt/success/failure counters `0`;
- observer requested `1`;
- callback seen `17`;
- exact target callback seen `1`;
- `D97ELRouteStatus=PASS`;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCapturedCount=0`;
- all eight D97ES Valid fields `0`;
- `D97CTRouteStatus=PASS`;
- publisher ticks `300`.

This proves D97EZ runtime identity, LATENT gate, route/publisher and expected VESA zero-call/zero-adaptation behavior. It does not prove accelerated passthrough semantics because VESA produces no set_id_mode calls.

## Execution-lane authority
User explicitly authorized local compilation on the home Intel iMac because GitHub Actions quota/execution is currently exhausted/blocked. Do not retry GitHub Actions compilation during this quota-limited period.

## CURRENT ACTION — ONE D97EZ ACTIVE ACCELERATED EXPERIMENT AUTHORIZED
Perform exactly one diagnostic boot with only these intentional changes from current proven VESA state:
- make `-igfxvesa` inert as `#-igfxvesa`;
- add active `-ocmcd97ez`.

Keep unchanged:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- inert `#-ocmcd97bvcave`;
- `ipc_control_port_options=0`;
- `-amfipassbeta`;
- D97DX Root Patch;
- D97EZ 0.0.12;
- D97EW collector;
- normal 3/3/3 framebuffer baseline.

No other T2/Haswell variable, Root Patch or framebuffer change is authorized.

If image is lost, keep the system powered for at least 30 seconds before hard power to allow D97EZ publication and D97EW sync. Recover by restoring active `-igfxvesa` and removing/making inert `-ocmcd97ez`. After recovery, accelerated evidence comes only from the preceding accelerated D97EW run, not the current VESA IORegistry.
