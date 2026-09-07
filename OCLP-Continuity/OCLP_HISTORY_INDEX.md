# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97FH_SET_ID_MODE_ADAPTER_SEMANTIC_PASS_NEW_DOWNSTREAM_FRONTIER.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`. D22 remains the accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave is protected. Golden Sequoia remains immutable/read-only. D50/D68/D82 remain reserve-only; D84 retired. Permanent method remains module-boundary + semantic evidence + far-frontier, with universal/no-PID coverage where requests vary.

## D97BV / D97DT — selective 3802 runtime closure
Selective true-3802 adapter semantics and runtime delivery are CLOSED PASS under exact 25G82. This lane is not to be retested absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch PASS established the bounded target architecture: native Tahoe main Metal authoritative; bounded legacy compiler/compatibility lanes; exact 25G82 metallib handling; Monterey GVA/OpenCL plus Haswell graphics drivers; no legacy main Metal shadow, no MetalOld, no true-five replay.

## D97EB / D97EE — accelerated failure and framebuffer negative
Both normal 3/3/3 and isolated 1/1/1 reached `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV. No kernel panic and no `_MTL4*` regression. Framebuffer-count tuning CLOSED NEGATIVE; 3/3/3 remains authoritative.

## D97EG-D97EP — exact set_id_mode observer
D97EG mapped exact `IOAccelSurface::set_id_mode(uint32_t id,uint32_t mode)` in IOAcceleratorFamily2 487.4.3. D97EH/D97EL established observe-only passthrough. D97EP VESA proved observer request, callback path, exact target route PASS and zero set_id_mode calls as expected.

## D97EQ / D97ER — accelerated repro and transport gap
D97EQ reproduced the same failure after framebuffer open. Exact tuple was not recoverable through unified log/dmesg. D97ER reclassified the unresolved problem as evidence transport.

## D97ES-D97EV — IORegistry tuple telemetry
D97ES 0.0.11 added first-eight post-original tuple capture while preserving exact passthrough semantics. Independent build audit PASS; D97EU exact EFI identity PASS; D97EV VESA route/publisher/schema/empty-slot behavior PASS.

## D97EW / D97EX — persistent accelerated evidence transport
D97EW introduced a root LaunchDaemon collector persisting OCLPMetalCompat evidence under `/Users/Shared/OCLP-D97EW-Capture`. D97EX current-VESA live test proved collector source identity, installation, launchd execution, IORegistry read and disk persistence PASS.

## D97EY — decisive exact tuple semantic proof
Accelerated run `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295` proved:
- accepted `mode=0x24`, badBits `0`, goodBits `0x24`, Apple return `0`;
- rejected `mode=0x224`, badBits `0x200`, goodBits `0x24`, Apple raw return `0xE00002C2 = kIOReturnBadArgument`.
The captured classes differ only by mode bit `0x200`. This is SEMANTIC PROVEN for captured calls. Semantic meaning of `0x200` remains UNKNOWN; global mask remains unauthorized.
D97EY checkpoint commit: `f2762e713565b1e72498241de639bdd5698c82c6`.

## D97EZ — exact-match handoff experiment
D97EZ is LATENT by default; ACTIVE only with `-ocmcd97ez`, translating exact `0x224 -> 0x24`, while every other mode is exact passthrough. `that/id` unchanged, one Apple original call, exact IOReturn passthrough, global/no-PID counters and original/passed first-eight telemetry.
Generator authority: commit `cd76d912018bfa60284af3cb732ae8bca84db091`, blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

## D97FA — GitHub Actions execution blocker
GitHub-first D97EZ Actions push/PR/synchronize probes produced zero workflow runs. D97FA checkpoint commit `4191c7c2f89ce0d95739db6e0723eb7b37b63d0a`.

## D97FB — explicit local compile authorization
User explicitly authorized compilation on the home Intel iMac because GitHub Actions quota/execution is exhausted/blocked. D97FB checkpoint commit `9be9a0659fd63327b343b9eab163116b56d1210f`.

## D97FC — authorized local Intel-iMac helper ready
Build helper `OCLP7_D97EZ_IMAC_BUILD.sh`: commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`, blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`. D97FC checkpoint commit `785b87a8235ed003a4e55e198a7a963dac3bbf2b`.

## D97FD — independent D97EZ 0.0.12 build audit PASS
Returned archive `OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`:
- bytes `154432`;
- SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`;
- CRC PASS;
- 20/20 frozen manifest payload hashes PASS;
- manifest SHA256 `f041bc196767ca8c0c4a0ae33b0091a424f3fc56f70bca0e95e7d62bee58a8ac`.
Independent lineage regeneration produced byte-identical EH/EL/ES/EZ sources. Build log: 2 BUILD SUCCEEDED, 0 failed, 0 error lines, 6 non-functional warnings.
Compiled D97EZ: version `0.0.12`, x86_64 MH_KEXT_BUNDLE, UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`, executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`, Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`, generated source SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`.
Independent disassembly proves exact compare/translation, unchanged `that/id`, one original call, post-call diagnostic masks and exact return passthrough.
D97FD checkpoint commit `4cc0928f94f9d28bcb1b5b91660a221c570742c4`.

## D97FE / D97FF — deployment identity
Fail-closed deploy helper was prepared, but user manually replaced the EFI kext. Direct active-EFI verification proved exact D97EZ 0.0.12 identity before runtime boot.

## D97FG — D97EZ LATENT VESA runtime PASS
Loaded D97EZ 0.0.12 exact UUID. `FunctionalRequested=0`, `FunctionalMode=LATENT`, route PASS, zero set_id_mode calls, zero adaptation counters, publisher ticks 300. This closed the required LATENT VESA safety gate.
D97FG checkpoint commit `6c71ca6ead28321ac338323f96365208f1037f34`.

## D97FH — ACTIVE exact adapter semantic PASS / set_id_mode blocker CLOSED
Persisted ACTIVE accelerated run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290`

Saved boot args prove inert `#-igfxvesa` plus active `-ocmcd97ez`; exact D97EZ 0.0.12 UUID remained loaded.

At first 15 routed calls:
- exact-224 seen 12;
- adapted 12;
- adapt success 12;
- adapt failure 0;
- other modes 3;
- passthrough success 3;
- passthrough failure 0;
- exhaustive classification `12+3=15` PASS.

At stable 20 routed calls:
- exact-224 seen 16;
- adapted 16;
- adapt success 16;
- adapt failure 0;
- other modes 4;
- passthrough success 4;
- passthrough failure 0;
- exhaustive classification `16+4=20` PASS.

First-eight direct telemetry:
- slots 2/3/4/5/7/8 original mode `0x224`, badBits `0x200`, goodBits `0x24`, D97EZ passed `0x24`, Apple return `0`;
- slots 1/6 original mode `0x24`, passed `0x24`, Apple return `0`.

Therefore the exact `0x224 -> 0x24` handoff adapter is STRUCTURAL-SEMANTIC PROVEN for captured traffic and Apple acceptance is SEMANTIC PROVEN for all 16 adapted calls in the observed 20-call window. All observed non-224 passthrough calls also succeed.

The previous `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` rejection is CLOSED PASS as a causal blocker for the measured path.

End-to-end GUI remains unproven because the system still returned to VESA after the ACTIVE experiment. The next frontier is downstream of successful set_id_mode acceptance.

D97FH checkpoint commit: `3b882d7428a010a48d4744f290ab97a9232d4b4e`.
MASTER advance to D97FH: `023a154a47f944a6fa309513948b2f6f7cd2c292`.

## Current causal frontier
Closed:
`Tahoe 0x224 -> legacy IOAccelSurface rejection`.

Current:
`successful IOAccelSurface::set_id_mode acceptance -> next CoreDisplay/SkyLight/WindowServer/IOAccelerator failure preventing usable accelerated image`.

## Current action
Remain in VESA with D97EZ functional bootarg absent/inert. Do not change EFI, Root Patch, framebuffer counts or boot variables.

Collect and analyze unified/system logs from the immediately preceding ACTIVE accelerated boot around 2026-09-07 16:50 EEST. Locate the first new error after successful set_id_mode acceptance. Do not repeat the ACTIVE boot unchanged before this downstream frontier is identified.
