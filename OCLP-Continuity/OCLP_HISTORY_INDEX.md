# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97FA_GITHUB_ACTIONS_EXECUTION_BLOCKER.md`.
Current decisive semantic checkpoint: `OCLP7_CHECKPOINT_20260907_D97EY_EXACT_SET_ID_MODE_TUPLE_SEMANTIC_PROOF.md`.
Permanent database/rules and the incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / baseline
Current architecture: native Tahoe Metal/Metal4 with selective true-3802 ingress and otherwise unchanged Tahoe semantics.

Accepted functional baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

Golden Sequoia remains immutable/read-only. D50/D68/D82 remain reserve-only. D84 is retired. D34 cave remains protected.

Closed branches include legacy-main-Metal shadowing, global forced-3802/global 32023 rewrite, standalone reconstructed carrier and framebuffer-count tuning.

## Early compiler/path history
Earlier OCLP1-OCLP7 work established the accepted five-patch compiler/request bridges, AIR 2.6 / Metal 3.1 semantics, downstream compiler-service progress, and the far-frontier methodology. Historical over-probing and cross-PID sampling errors drove the permanent module-boundary + semantic-evidence + universal/no-PID rules. Full detailed chronology remains in `OCLP_PERMANENT_PROJECT_DATABASE.md` and prior checkpoints.

## D97BV / D97DT — selective 3802 runtime closure
Selective adapter semantics:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor sequence.

D97DL 0.0.7 became source authority. D97DT closed runtime CAVE/SITE delivery, validation safety and cross-process visibility under exact 25G82. This lane is CLOSED PASS and should not be retested absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch execution PASS installed the bounded architecture:
- native Tahoe main Metal authoritative;
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes and compatibility payloads;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL plus Haswell graphics drivers;
- no legacy main Metal shadow, no MetalOld, no true-five replay.

## D97EB / D97EE — accelerated core failure
Normal 3/3/3 and isolated 1/1/1 both reached:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV.

No kernel panic and no `_MTL4*` superclass regression. The 1/1/1 experiment was NEGATIVE; normal 3/3/3 remains authoritative.

## D97EG-D97EP — exact set_id_mode observer
D97EG mapped the exact imported symbol as `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)` in IOAcceleratorFamily2 487.4.3.

D97EH established exact observe-only passthrough: Apple original receives unchanged `that/id/mode`, is called first, and exact original IOReturn is returned unchanged. D97EL preserved those semantics and added route/callback telemetry.

D97EP VESA proved observer request active, global callback active, exact IOAcceleratorFamily2 target callback seen and route PASS, with zero set_id_mode calls in VESA as expected.

## D97EQ / D97ER — accelerated repro and transport gap
D97EQ reproduced the accelerated failure after `GPU: FB: 3 of 3 opened`, with four bad-bits errors, display offline about 3 ms later and WindowServer SIGSEGV about 20.6 ms after the fourth error. No kernel panic, `_MTL4*` regression or preceding MTLCompilerService failure.

The exact observer tuple was not captured. D97ER showed post-recovery unified log and live dmesg custom markers absent, so repeating unchanged D97EL was not justified. The unresolved problem became tuple transport rather than graphics localization.

## D97ES / D97ET — IORegistry tuple telemetry build PASS
D97ES `OCLPMetalCompat.kext` 0.0.11 preserves D97EL passthrough semantics and captures first eight post-original tuples atomically:
- `id`;
- `mode`;
- `badBits = mode & 0xFF8073C0`;
- `goodBits = mode & 0x007F8C3F`;
- raw original IOReturn.

Independent build audit PASS:
- generated source SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- exact D97ES -> D97EL -> D97EH -> D97DL lineage proved;
- no functional mode mutation or return coercion.

Publisher cadence is asynchronous, about once per second, bounded to 300 seconds, and remains live until at least one observer tuple when observer mode is requested.

D97ET checkpoint commit: `af16880e29d0ae51492a5252cda354bc52b52c9d`.

## D97EU — active EFI identity PASS
ASUS2 direct pre-reboot verification matched audited D97ES exactly:
- version 0.0.11;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.

D97EU checkpoint commit: `3861969fe3d6ead6c8684a099e3a5abd80500814`.

## D97EV — D97ES VESA runtime PASS
Authorized VESA boot proved exact D97ES loaded, observer/callback/target route PASS, zero set_id_mode calls, eight empty capture slots, healthy D97CT gates, D97BV functional mode ACTIVE and publisher liveness through tick 300.

D97EV checkpoint commit: `3520d6a1c3d5b49af962d199230b58472b2b25bb`.

## D97EW — persistent transport-preservation gate
Because a hard recovery reboot destroys prior live IORegistry, D97EW required an on-disk collector independent of WindowServer before any new accelerated experiment.

GitHub-first collector:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Static audit PASS: root LaunchDaemon, boot-started, IORegistry polling, writable evidence under `/Users/Shared/OCLP-D97EW-Capture`, positive-tuple full snapshot + boot/kext identity + `sync` + five follow-ups, and no EFI/NVRAM/Root Patch/framebuffer/Golden/reboot mutation.

D97EW checkpoint commit: `930c308de295f412650e9454cefcce3cf305baa7`.

## D97EX — persistent collector current-VESA live PASS
ASUS2 verified exact source blob identity before install. Install/plist PASS, LaunchDaemon running, repeated service-present/captured=0/calls=0/route=PASS samples, and direct IORegistry agreement closed the accelerated-evidence transport lane.

Installed identities:
- capture SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`.

D97EX checkpoint commit: `eab27b10117750e19c0c8d01c3f0de25d1857c2c`.
Master update advancing authority to D97EX: `fc0d9002fe231ea730b6ebdd75a830785997896d`.

## D97EY — exact accelerated `set_id_mode` tuple semantic proof
The authorized D97EX accelerated boot was executed with only `-igfxvesa` made inert. Persisted accelerated run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`.

Same-run identity evidence:
- saved args contain `#-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` with inert `#-ocmcd97bvcave`;
- loaded observer is D97ES 0.0.11 UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- route `PASS`;
- first sample captured 8 tuples at total call count 15;
- five follow-ups show total call count 20;
- tuple evidence was persisted and synced before recovery.

Exact first-eight payload:
- slot1: `id=0x1000 mode=0x24 badBits=0 goodBits=0x24 ret=0`;
- slots2-5: `id=0x1001..0x1004 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`;
- slot6 repeats `id=0x1000 mode=0x24 ... ret=0`;
- slots7-8 repeat `id=0x1001..0x1002 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`.

`0xE00002C2` is standard `kIOReturnBadArgument`.

Decisive semantic classification for captured calls:
- `mode=0x24 -> success` = SEMANTIC PROVEN;
- `mode=0x224`, differing by exactly extra bit `0x200`, produces `badBits=0x200` with identical `goodBits=0x24` and returns BadArgument every captured time = SEMANTIC PROVEN;
- pattern repeats across surface-ID sequences;
- exact semantic name/meaning of `0x200` = UNKNOWN;
- exact equivalent Golden runtime mode = UNKNOWN;
- global clearing/masking of `0x200` = NOT AUTHORIZED.

Same accelerated boot also yielded repeated downstream WindowServer SIGSEGV in CoreDisplay/SkyLight initialization. The direct D97EY kernel tuple is the stronger causal frontier.

Public context confirms `set_id_mode` mode is a bitwise presentation/surface flag field, but no reliable public source names the observed `0x200` bit; no semantic label is invented.

D97EY checkpoint commit: `f2762e713565b1e72498241de639bdd5698c82c6`.
Master advancement commit: `e9aa21dee41d5e0204df7017b762093fb6a96e5f`.

## D97EZ — exact-match adapter design prepared in GitHub
D97EZ is intentionally bounded and LATENT by default:
- source design commit `8384f183303831ddd117652ef90e5c707a2ee589`;
- generator commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- generator Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`;
- exact D97ES input SHA pinned;
- functional gate `-ocmcd97ez`;
- only ACTIVE + exact `originalMode==0x224` selects `passedMode=0x24`;
- all non-0x224 modes remain exact passthrough;
- Apple original called once and exact return preserved;
- global/no-PID exact/other and success/failure counters;
- per-slot original/passed-mode telemetry;
- no broad mask.

GitHub-first workflow `.github/workflows/oclp7-d97ez-exact224-adapter-build.yml` was added to reconstruct exact lineage, generate deterministically, compile x86_64 on `macos-15-intel`, audit source/binary/disassembly, package and publish an artifact.

No D97EZ binary/package identity exists yet.

## D97FA — GitHub Actions execution blocker
The D97EZ GitHub-first compile/build/package/audit lane is currently blocked at Actions execution, not at source design or repository writes.

Observed sequence:
1. Workflow created on `main` at commit `6c9e21e548904f7c3597ab67cc44d00a002f0fd9` with push/main + workflow_dispatch. Head-scoped and repo-wide Actions run queries returned zero runs.
2. `pull_request` trigger was added on `main` at commit `320c8caab6d6f0c7790eef27d2b120acbb883c7e`.
3. Branch `oclp7-d97ez-exact224-ci` created.
4. Draft PR #17 opened with documentation-only change; initial head `dc7e11ebf989cc41ed931ba066fc6da1efab4f14`; workflow runs list remained empty.
5. Second documentation-only synchronize commit head `58c6c0332e67c43de31260a6c8d613ea8c00f40b`; workflow runs list remained empty.
6. Repository-wide Actions API still reports `total_count=0`, `workflow_runs=[]`.
7. Synchronized PR head has no statuses/checks.
8. Authenticated repo metadata reports admin/maintain/push/pull permissions; repository content write is therefore not the observed blocker.
9. Current GitHub connector has no workflow-dispatch/create-run operation; only read/rerun operations for already-existing Actions runs are exposed.

Exact deeper GitHub-side reason for zero execution (for example Actions disabled/restricted or another execution policy) is UNKNOWN via the available interface. Observed classification is `GITHUB_ACTIONS_EXECUTION=BLOCKED`.

Per permanent GitHub-first rule, local compilation is not an implicit fallback and remains unauthorized.

D97FA checkpoint commit: `4191c7c2f89ce0d95739db6e0723eb7b37b63d0a`.
Master advancement commit: `e126f787275dd2435457a801a091bf50acd908b6`.

## Current causal frontier
`Tahoe/CoreDisplay surface-mode semantics -> mode 0x224 (good 0x24 + extra 0x200) -> IOAccelSurface::set_id_mode -> legacy Haswell IOAccelerator returns kIOReturnBadArgument`.

The exact observed failing bit class is measured. Unknowns are the semantic intent of bit `0x200` and whether a selective exact-match translation is sufficient for stable graphical progress.

## Current action
STOP at D97FA until GitHub Actions execution becomes available for `StefanAlMare/StefanAlMare` through a working trigger/dispatch path. Then resume the existing D97EZ GitHub-first workflow, repair any CI failure in GitHub, independently audit the complete x86_64 binary/package/artifact, and only then persist a separate VESA-first deployment checkpoint.

Until then: no local compilation fallback, no D97EZ deployment, no `-ocmcd97ez` on ASUS2, no Root Patch, no EFI mutation, no reboot/accelerated boot. D97ES 0.0.11 and current VESA recovery state remain authoritative.