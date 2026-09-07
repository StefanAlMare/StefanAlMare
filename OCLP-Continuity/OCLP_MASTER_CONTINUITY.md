# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

Current authoritative runtime/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FF_D97EZ_EFI_IDENTITY_PASS_LATENT_VESA_REBOOT_AUTHORIZED.md`

Current independent build-audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT_PASS_VESA_DEPLOY_AUTHORIZED.md`

Previous deploy-helper checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FE_D97EZ_VESA_DEPLOY_HELPER_READY.md`

Current local-compile authorization checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FB_LOCAL_IMAC_COMPILE_EXPLICITLY_AUTHORIZED.md`

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

D97FD independently proved ZIP/package/lineage/source/build/Mach-O/disassembly integrity PASS. This proves build/static/binary correctness, not runtime success.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext has now been manually replaced with audited D97EZ `OCLPMetalCompat.kext` 0.0.12;
- direct active-EFI verification reports exact D97EZ executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- direct active-EFI verification reports exact D97EZ UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64;
- D97EW persistent collector remains installed and previously LIVE/PASS;
- current session is VESA recovery after the D97EX accelerated measurement;
- current boot args remain `-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh`;
- `-igfxvesa` is active;
- `-ocmcd97ez` is absent;
- therefore the next D97EZ boot is expected to be LATENT and VESA;
- no functional `0x224 -> 0x24` translation is currently activated;
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

## D97EY — decisive exact tuple semantic proof
Captured accepted class: `mode=0x24`, badBits `0`, goodBits `0x24`, Apple return `0`.
Captured rejected class: `mode=0x224`, badBits `0x200`, goodBits `0x24`, Apple raw return `0xE00002C2 = kIOReturnBadArgument`.

The only observed mode-bit difference between captured accepted/rejected classes is `0x200`. This is SEMANTIC PROVEN for captured calls; semantic meaning of bit `0x200` remains UNKNOWN. No global mask is authorized.

## D97EZ exact-match experiment
D97EZ is LATENT unless `-ocmcd97ez` is active.

ACTIVE rule only:
- exact `originalMode == 0x224` -> pass `0x24`;
- every non-`0x224` mode exact passthrough;
- `that/id` unchanged;
- one Apple original call;
- exact Apple IOReturn returned unchanged.

Global/no-PID counters classify every routed call. First-eight telemetry preserves original mode and separately records passed mode.

## Execution-lane authority
The user explicitly authorized local compilation on the home Intel iMac because GitHub Actions quota/execution is exhausted/blocked. Do not retry GitHub Actions compilation during the current quota-limited period.

## D97FF pre-reboot closure
Manual active-EFI replacement is identity-pinned PASS:
- version `0.0.12`;
- executable SHA256 exact audited value;
- UUID exact audited value;
- active VESA bootarg preserved;
- D97EZ functional bootarg absent.

This closes the pre-reboot deployment identity gate. It does not prove runtime load or LATENT behavior yet.

## CURRENT ACTION — ONE LATENT VESA REBOOT AUTHORIZED
Perform exactly one reboot with current boot args unchanged.

Expected:
- VESA active via `-igfxvesa`;
- D97EZ 0.0.12 loads from EFI;
- `D97EZFunctionalMode=LATENT` because `-ocmcd97ez` is absent;
- zero functional exact-match adaptations;
- existing D97BV and set_id_mode observer routes remain requested.

After returning to VESA, do not alter EFI, boot args, NVRAM, Root Patch or framebuffer. Collect live loaded-kext identity and D97EZ IORegistry state. Accelerated boot and active `-ocmcd97ez` remain forbidden until LATENT VESA behavior is separately proven and persisted.
