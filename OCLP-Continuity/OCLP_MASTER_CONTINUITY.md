# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT_PASS_VESA_DEPLOY_AUTHORIZED.md`

Previous local-build helper checkpoint:
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

Audited returned D97EZ build:
- archive `OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`;
- bytes `154432`;
- ZIP SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`;
- package manifest SHA256 `f041bc196767ca8c0c4a0ae33b0091a424f3fc56f70bca0e95e7d62bee58a8ac`;
- generated source SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`;
- version `0.0.12` x86_64;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext still remains audited D97ES `OCLPMetalCompat.kext` 0.0.11 until D97FD deployment is performed;
- active D97ES executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- active D97ES UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64;
- D97EW persistent collector remains installed and previously LIVE/PASS;
- the D97EX accelerated measurement boot completed and its persisted run is `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`;
- current session is VESA recovery after that accelerated measurement;
- D97EZ 0.0.12 build is now independently audited PASS but has not yet been deployed;
- no functional `set_id_mode` correction is installed on ASUS2;
- no new T2/Haswell boot variable is authorized;
- no Root Patch or reboot is authorized before active-EFI D97EZ identity is verified.

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

D97EZ remains an experimental compatibility hypothesis. D97FD proves its build/static/binary integrity, not yet its runtime effect.

## Execution-lane authority — local-build exception
The user explicitly authorized local compilation on the more powerful home Intel iMac because GitHub Actions quota/execution is currently exhausted/blocked. This satisfies the permanent local-build approval requirement.

Do not retry GitHub Actions compilation during the current quota-limited period. GitHub remains source/design/helper/persistence authority. ASUS2 remains target-only for identity-pinned deployment/runtime/VESA evidence.

## D97FD — independent build audit PASS
The returned local archive was read directly and independently audited.

PASS results:
- exact ZIP identity and CRC;
- all 20 frozen package manifest hashes;
- exact D97DL/EH/EL/ES/EZ generator/source identities;
- full byte-identical lineage regeneration through D97EZ;
- source exact-match/no-mask semantics;
- two successful Xcode builds, zero failed builds, zero error lines;
- x86_64 MH_KEXT_BUNDLE identity;
- exact version/UUID/executable/Info.plist hashes;
- binary disassembly confirms exact `0x224` compare, conditional `0x24` selection, unchanged `that/id`, one Apple original call, post-call diagnostic masks, and exact IOReturn return.

Therefore D97EZ 0.0.12 is authorized for VESA-first deployment only, with functional bootarg `-ocmcd97ez` absent.

## CURRENT ACTION — D97EZ VESA-FIRST DEPLOYMENT
On ASUS2, while remaining in current VESA recovery:
1. back up current active D97ES 0.0.11 kext;
2. replace only active EFI `EFI/OC/Kexts/OCLPMetalCompat.kext` with audited D97EZ 0.0.12;
3. keep `Kernel -> Add -> BundlePath` unchanged;
4. DO NOT add `-ocmcd97ez` yet;
5. keep VESA args exactly `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` with `#-ocmcd97bvcave` inert;
6. no Root Patch, framebuffer change, T2/Haswell variable, or reboot yet;
7. verify active EFI identity before reboot.

Required active-EFI identity:
- version `0.0.12`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64.

Only after exact identity PASS may one VESA validation reboot be separately authorized. Accelerated boot and functional `-ocmcd97ez` remain forbidden until LATENT VESA behavior is proven.
