# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT_PASS_VESA_DEPLOY_AUTHORIZED.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

D22 remains the accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave is protected. Golden Sequoia remains immutable/read-only. D50/D68/D82 remain reserve-only; D84 retired.

Permanent method remains module-boundary + semantic evidence + far-frontier, with universal/no-PID coverage where requests vary.

## Early compiler/path history
OCLP1-OCLP7 established the five accepted compiler/request bridges, upstream AIR/Metal semantics, compiler-service progress and the far-frontier methodology. Earlier over-probing, cross-PID sampling and invalid cave overlap drove the permanent working rules. Full chronology remains in `OCLP_PERMANENT_PROJECT_DATABASE.md`, retrospective and earlier checkpoints.

## D97BV / D97DT — selective 3802 runtime closure
Selective true-3802 adapter semantics and runtime delivery are CLOSED PASS under exact 25G82. This lane is not to be retested absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch PASS established the bounded target architecture:
- native Tahoe main Metal authoritative;
- bounded legacy `MTLCompilerService.xpc` under native Metal;
- private compiler/compatibility lanes;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL plus Haswell graphics drivers;
- no legacy main Metal shadow, no MetalOld, no true-five replay.

## D97EB / D97EE — accelerated failure and framebuffer negative
Both normal 3/3/3 and isolated 1/1/1 reached:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV.

No kernel panic and no `_MTL4*` regression. Framebuffer-count tuning CLOSED NEGATIVE; 3/3/3 remains authoritative.

## D97EG-D97EP — exact set_id_mode observer
D97EG mapped exact `IOAccelSurface::set_id_mode(uint32_t id,uint32_t mode)` in IOAcceleratorFamily2 487.4.3.

D97EH/D97EL established observe-only passthrough: Apple original receives unchanged input and its exact IOReturn is returned unchanged. D97EP VESA proved observer request, callback path, exact target route PASS and zero set_id_mode calls as expected.

## D97EQ / D97ER — accelerated repro and transport gap
D97EQ reproduced the same failure after framebuffer open. Exact tuple was not recoverable through unified log/dmesg. D97ER reclassified the unresolved problem as evidence transport, not a new graphics failure.

## D97ES-D97EV — IORegistry tuple telemetry
D97ES 0.0.11 added first-eight post-original tuple capture while preserving exact passthrough semantics:
- id;
- original mode;
- badBits;
- goodBits;
- raw Apple IOReturn.

Independent build audit PASS; D97EU exact EFI identity PASS; D97EV VESA route/publisher/schema/empty-slot behavior PASS.

## D97EW / D97EX — persistent accelerated evidence transport
Because hard VESA recovery destroys prior live IORegistry, D97EW introduced a root LaunchDaemon collector that starts each boot, polls OCLPMetalCompat IORegistry and persists evidence under `/Users/Shared/OCLP-D97EW-Capture`.

D97EX current-VESA live test proved collector source identity, installation, launchd execution, IORegistry read and disk persistence PASS. One accelerated measurement was then authorized.

## D97EY — decisive exact tuple semantic proof
Accelerated run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`

Saved boot args identify the run as accelerated with `#-igfxvesa`. Exact D97ES 0.0.11 UUID remained loaded.

First collector sample:
- captured slots = 8;
- total call count = 15;
- route = PASS.

Follow-up snapshots reached total call count 20.

Captured accepted class:
- `mode=0x24`;
- badBits `0`;
- goodBits `0x24`;
- Apple IOReturn `0`.

Captured rejected class:
- `mode=0x224`;
- badBits `0x200`;
- goodBits `0x24`;
- Apple raw IOReturn `0xE00002C2 = kIOReturnBadArgument`.

The captured accepted/rejected classes differ only by mode bit `0x200`. This is SEMANTIC PROVEN for captured calls. The semantic meaning of bit `0x200` remains UNKNOWN, so global clearing/masking is not authorized.

D97EY checkpoint commit: `f2762e713565b1e72498241de639bdd5698c82c6`.

## D97EZ — exact-match handoff experiment
D97EZ design is intentionally narrower than a mask:
- LATENT by default;
- new functional bootarg `-ocmcd97ez`;
- ACTIVE exact translation only `originalMode == 0x224 -> passedMode 0x24`;
- every other mode exact passthrough;
- `that`/`id` unchanged;
- Apple original called once;
- exact Apple IOReturn returned unchanged;
- global/no-PID counters classify every routed call;
- first-eight telemetry preserves originalMode and records passedMode.

Generator authority:
- commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

## D97FA — GitHub Actions execution blocker
A GitHub-first D97EZ workflow was integrated and tested via push, PR-open and PR-synchronize paths. Repository Actions queries returned zero runs; the connector exposes no workflow-dispatch action. PR #17 used only a documentation-only trigger branch and was closed without merge.

D97FA checkpoint commit: `4191c7c2f89ce0d95739db6e0723eb7b37b63d0a`.

## D97FB — explicit local compile authorization
On 2026-09-07 the user explicitly stated that GitHub Actions quota/execution is exhausted/blocked and instructed that compilation be performed on the user's more powerful home Intel iMac.

This is the explicit authorization required by the permanent working rule for local compilation. It supersedes the D97FA stop condition only for the build lane while preserving all runtime safety gates.

D97FB checkpoint commit: `9be9a0659fd63327b343b9eab163116b56d1210f`.

## D97FC — authorized local Intel-iMac helper ready
Authoritative helper:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_IMAC_BUILD.sh`
- hardened helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`;
- Git blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.

Helper properties:
- x86_64 Darwin + full-Xcode fail-closed gate;
- exact D97DL -> D97EH -> D97EL -> D97ES lineage reconstruction and identity checks;
- exact D97EZ generator pin;
- deterministic D97EZ generation twice + byte compare;
- exact-match semantic source audit and broad-mask absence;
- non-empty D97ES->D97EZ diff requirement;
- pinned Lilu / FeatureUnlock / MacKernelSDK x86_64 build;
- OCLPMetalCompat 0.0.12 identity output;
- strings/nm/disassembly capture;
- kext/source/generator/diff/log package;
- build report finalized before SHA manifest;
- manifest self-check before ZIP;
- Desktop ZIP plus SHA256 sidecar;
- no deploy, Root Patch, EFI/NVRAM mutation or reboot.

D97FC checkpoint commit: `785b87a8235ed003a4e55e198a7a963dac3bbf2b`.
Master advance to D97FC: `bfa094747b0bdd47468081f7b173a8b67ad433d8`.

## D97FD — independent D97EZ 0.0.12 build audit PASS
Returned archive:
`OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`
- bytes `154432`;
- SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`;
- CRC PASS;
- no symlink/AppleDouble metadata anomalies.

Frozen package manifest:
- 20 payload hashes;
- all 20 PASS;
- manifest SHA256 `f041bc196767ca8c0c4a0ae33b0091a424f3fc56f70bca0e95e7d62bee58a8ac`.

Independent lineage regeneration using packaged pinned inputs produced byte-identical EH/EL/ES/EZ sources.

D97EZ generated source:
- SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`;
- exact-match source semantics PASS;
- broad mask absent;
- one Apple call and exact return passthrough PASS.

Build log:
- 2 `BUILD SUCCEEDED`;
- 0 `BUILD FAILED`;
- 0 error lines;
- 6 non-functional toolchain/build-system warnings.

Compiled kext:
- version `0.0.12`;
- Mach-O x86_64 `MH_KEXT_BUNDLE`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- executable bytes `83616`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`.

Independent disassembly proves exact `0x224` compare, conditional `0x24` selection, unchanged `that/id`, one original Apple call, diagnostic masks only after the original return, and exact return passthrough.

Classification:
- build integrity PASS;
- lineage PASS;
- source semantic PASS;
- binary exact-match semantics PASS;
- VESA deployment AUTHORIZED;
- VESA reboot NOT yet authorized pending active-EFI identity;
- accelerated boot / functional `-ocmcd97ez` NOT authorized;
- Root Patch NOT authorized.

D97FD checkpoint commit: `4cc0928f94f9d28bcb1b5b91660a221c570742c4`.
Master advance to D97FD: `942388047fb2b3475e2c4a6319800db13f8963fa`.

## Current action
On ASUS2 in current VESA recovery, deploy only audited D97EZ 0.0.12 to the existing active EFI `EFI/OC/Kexts/OCLPMetalCompat.kext`, preserving a backup of D97ES 0.0.11 and preserving all boot args/configuration. Do NOT add `-ocmcd97ez` yet. Verify active-EFI identity before reboot:
- version `0.0.12`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64.

No Root Patch, reboot, framebuffer change, T2/Haswell variable, accelerated boot or functional D97EZ activation is authorized until the exact deployed identity is returned and audited.
