# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97EW_D97ES_VESA_PASS_PERSISTENT_CAPTURE_GATE.md`.
Permanent database/rules remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Current target: native Tahoe Metal/Metal4 with selective true-3802 ingress and otherwise unchanged Tahoe 32023/32024 semantics.
Historical accepted baseline: `P1 + P2b + P3 + AIR00 + D34`.

Closed branches:
- full legacy main Metal: ABI-incompatible NEGATIVE;
- standalone reconstructed Metal carrier: CLOSED after D97CJ broad ObjC relocation proof;
- plain BinaryModInfo canonical Tahoe Metal path: blocked because native Metal is shared-cache resident.

Golden Sequoia remains immutable/read-only. D50/D68/D82 remain reserve-only unless a later authoritative checkpoint explicitly promotes one.

## D97BV selective adapter
Static semantic closure:
- exact 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor sequence.

Exact target bytes:
- SITE page `0xF5E1000`, in-page `0x719`, original `3d187d0000b9177d00000f4cc1`;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE page `0xF47E000`, in-page `0x560`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97CL-D97CN — native shared-cache substrate
D97CL proved Haswell AVX2, Lilu 1.7.3, WEG 1.7.1 and x86_64h cache substrate.
D97CM proved exact native Metal TEXT mapping.
D97CN proved exact static target topology: SITE preimage PASS; CAVE full208 zero PASS and first18 zero PASS.

## D97CO-D97CS — plugin observation channel
D97CO 0.0.1 compile/binary observe-only PASS.
D97CR proved runtime load; unified logging inconclusive.
D97CS proved OCLPMetalCompat IOKit lifecycle; persistent IORegistry became preferred evidence channel.

## D97CT-D97CX — persistent channel / early build-gate failure
D97CT 0.0.2 added atomic state and asynchronous IORegistry publication.
D97CX proved persistent channel but early `sysctlbyname(kern.osversion)` failed before route.

## D97CY / D97DC — second early-gate failure
D97CY 0.0.3 replaced sysctl with kernel-global `osversion[]` in patcher-load.
D97DC proved publisher later sees `25G82` but patcher-load still precedes osversion initialization. Tooling/timing NEGATIVE only; not a real build mismatch.

## D97DD 0.0.4
D97DD installs `_cs_validate_page` without early build read; wrapper calls Apple original first, then exact-build gate per callback.
Compiled UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`.
D97DE deployed D97DD preserving config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.

## D97DF — route/callback/build/cave runtime closure
Runtime proved:
- exact D97DD loaded;
- RouteStatus=PASS;
- callback execution high coverage;
- BuildGate=1 / ObservedBuild=25G82;
- CaveSeenCount=1;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15/0xF;
- CaveTainted=0;
- CaveNX=0.

## D97DG — full SITE+CAVE runtime closure
Successful ZIP:
`OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`
- SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`.

Read-only active mappings proved:
- SITE mmap PASS;
- SITE exact 13-byte preimage PASS;
- SITE page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- SiteSeenCount=1;
- SitePreimage=PASS;
- SiteValidated=15/0xF;
- SiteTainted=0;
- SiteNX=0;
- CAVE mmap PASS;
- CAVE full208 zero PASS;
- CAVE first18 zero PASS;
- CAVE page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- CaveSeenCount=1, validated 0xF, tainted 0, NX 0.

Runtime route/timing/preimage prerequisite for D97BV delivery: CLOSED PASS.
D97DH extended-publisher tooling became superseded and must not be deployed.

## D97DI static design
D97DI 0.0.6 preserves D97DD route/callback/build/path/page substrate and adds exact D97BV writes behind separate explicit boot arg `-ocmcd97bv`.
Without `-ocmcd97bv`, D97DI is LATENT / observe-only.

Fail-closed sequence:
- Apple original first;
- exact build 25G82;
- exact target page;
- exact main x86_64h shared-cache path;
- explicit functional bootarg;
- Apple validated=0xF, tainted=0, NX=0;
- exact SITE preimage or CAVE zero invariants;
- fixed exact write;
- immediate postimage verification.

Write bounds:
- SITE 13 bytes at `+0x719`;
- CAVE 18 bytes at `+0x560`.

Pinned source SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`, Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Helper identity correction:
- helper Git blob `8cc7f350f6fee51d17a6fbe1bbdfced4554a9ccf`;
- actual helper SHA256 `faea187c1e1f4b43dabcc231b62f4110c903cf3543f2711324bcbedf7854f49c`;
- prior `bbd360...` documentation value was incorrect.

## D97DI 0.0.6 build / binary audit PASS
Returned build:
`OCLP7_D97DI_IMAC_BUILD_20260906_223615.zip`
- bytes `56369`;
- SHA256 `671d3a19af6a0168b89272c7833547e49a84dbf44fb03765e9c40bc61a4b0642`;
- manifest mismatches 0;
- Lilu build PASS;
- D97DI build PASS;
- two BUILD SUCCEEDED;
- zero build errors;
- six non-functional warnings.

Compiled identity:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.6`;
- thin x86_64 Mach-O KEXTBUNDLE;
- UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- Info.plist SHA256 `b228aa9e1e33f8d27b8e139afbde3c376076de12114b1a3d579eaf2465774484`;
- Lilu dependency 1.7.3.

Binary audit:
- exact SITE replacement appears once;
- exact CAVE replacement appears once;
- SITE→CAVE rel32 PASS;
- 3802 bypass→SITE+13 PASS;
- CAVE original-floor prefix PASS;
- CAVE return→SITE+13 PASS;
- all required D97DD/D97DI marker strings present;
- generic patch/write strings absent.

Classifications:
`D97DI_LOCAL_COMPILE=PASS`
`D97DI_MANIFEST_AUDIT=PASS`
`D97DI_SOURCE_IDENTITY=PASS`
`D97DI_MACHO_IDENTITY=PASS`
`D97DI_D97BV_BINARY_PAYLOAD=PASS`
`D97DI_D97BV_CONTROL_FLOW_REAUDIT=PASS`
`D97DI_LATENT_DEFAULT=PASS`
`D97DI_BUILD_BINARY_AUDIT=PASS`

Audited latent package:
`OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`
- SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`.

## D97DL-D97DT — selective 3802 runtime path closure
D97DL 0.0.7 became source authority for the selective D97BV adapter. Under exact 25G82 VESA, later D97DT evidence closed CAVE/SITE runtime delivery, validation safety and cross-process visibility. Selective-3802 runtime delivery is CLOSED PASS and is not to be retested absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch execution PASS installed the bounded architecture:
- native Tahoe main Metal remains authoritative;
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes plus CoreImage/RenderBox compatibility;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL and Haswell graphics drivers;
- no MetalOld, no legacy main Metal shadow and no true-five replay.

## D97EB / D97EE — accelerated failure and framebuffer experiment
Normal 3/3/3 accelerated boot and isolated 1/1/1 framebuffer experiment both reached the same core failure:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV.
No kernel panic and no `_MTL4*` superclass regression occurred. The 1/1/1 experiment did not solve the failure, so framebuffer-count tuning is CLOSED NEGATIVE and the normal 3/3/3 baseline remains authoritative.

## D97EG-D97EP — exact set_id_mode observer route
D97EG mapped the exact imported symbol as `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)` in IOAcceleratorFamily2 487.4.3.
D97EH 0.0.9 established an exact observe-only wrapper: original `that/id/mode` passed unchanged, Apple original called first, original IOReturn returned unchanged, candidate masks computed only after original return.
D97EL 0.0.10 preserved those semantics and added route/callback telemetry.
D97EP VESA IORegistry evidence proved observer request active, callback path active, exact route PASS and `D97ELSetIdModeCallCount=0` under VESA. Registration/matching/symbol routing is therefore CLOSED PASS in VESA.

## D97EQ — accelerated failure reproduced; tuple not captured
D97EL accelerated boot reproduced the causal sequence with WindowServer PID 177:
- `GPU: FB: 3 of 3 opened`;
- four `Surface mode contains bad bits` errors;
- display offline about 3 ms later;
- WindowServer SIGSEGV about 20.6 ms after the fourth error.
No kernel panic, no `_MTL4*` regression and no preceding MTLCompilerService failure were found. Exact observer tuple remained UNCAPTURED.

## D97ER — transport classification
Post-recovery unified log and live VESA `dmesg` contained no D97EH/D97EL custom markers. Repeating the same accelerated D97EL boot was therefore NOT JUSTIFIED. D97EP route PASS remained valid; the unresolved problem became tuple transport/capture rather than a newly demonstrated graphics regression.

## D97ES / D97ET — IORegistry tuple telemetry build and independent audit
D97ES 0.0.11 preserves exact D97EL route/observer passthrough semantics and adds bounded asynchronous IORegistry publication for the first eight post-original tuples: `id`, `mode`, `badBits`, `goodBits`, raw original return.

Independent build audit PASS:
- version `0.0.11`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- exact D97ES -> D97EL -> D97EH -> D97DL lineage proved;
- binary passthrough semantics proved;
- no functional mode mutation or return coercion.

The publisher updates IORegistry once per second and remains bounded to 300 seconds.

D97ET authorized VESA deployment only.

## D97EU — active EFI deployment identity PASS
ASUS2 direct pre-reboot verification of `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext` matched audited D97ES exactly:
- version `0.0.11`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.

Exactly one VESA validation reboot was authorized with unchanged args `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`, `#-ocmcd97bvcave` inert, and no Root Patch/framebuffer/T2-variable/set_id_mode mutation.

D97EU checkpoint commit: `3861969fe3d6ead6c8684a099e3a5abd80500814`.

## D97EV — D97ES VESA runtime validation PASS
The authorized VESA reboot was completed and live evidence proved:
- loaded `OCLPMetalCompat` 0.0.11 UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- `D97ELObserverRequested=1`;
- `D97ELCallbackSeenCount=17`;
- `D97ELTargetCallbackSeenCount=1`;
- `D97ELLastCallbackIndex=20`;
- `D97ELKextLoadIndex=9`;
- `D97ELRouteStatus=PASS`;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCaptureSlots=8`;
- `D97ESCapturedCount=0`;
- all eight `D97ESxxValid=0`;
- `D97CTRouteStatus=PASS`;
- boot/kernel/cpu/build gates all 1;
- `D97DDObservedBuild=25G82`;
- `D97DIFunctionalRequested=1`;
- `D97DIFunctionalMode=ACTIVE`;
- `D97CTPublisherTicks=300`.

Thus D97ES route, publisher schema, bounded liveness and empty-slot behavior are PASS in VESA. Zero SITE/CAVE touches in this one VESA boot do not invalidate the already CLOSED-PASS D97BV/D97DT runtime proof.

Preliminary D97EV wording allowed the next accelerated measurement, but no accelerated boot occurred before the stronger D97EW transport-preservation gate below superseded that prospective authorization.

D97EV checkpoint commit: `3520d6a1c3d5b49af962d199230b58472b2b25bb`.

## D97EW — persistent transport-preservation gate
D97ES tuples live only in IORegistry; VESA recovery by hard reboot destroys the prior boot's IORegistry. Therefore an accelerated test cannot be authorized until tuple data can be persisted during the accelerated boot independently of WindowServer.

GitHub-first persistent collector created and statically audited:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Static audit:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_CAPTURE_STATIC_AUDIT.md`
- commit `c0fb94b0a92d52ede5527bf8478b94c0593d948b`.

Design:
- root LaunchDaemon, independent of WindowServer;
- runs every boot;
- polls full OCLPMetalCompat IORegistry once per second for up to 300 seconds;
- stores full snapshots and summary under `/Users/Shared/OCLP-D97EW-Capture`;
- on first positive `D97ESCapturedCount`, immediately persists and syncs the tuple snapshot, boot args and loaded-kext state, then five additional snapshots;
- no EFI/NVRAM write, Root Patch, framebuffer change, Golden access or reboot;
- uninstall removes only collector/plist and preserves evidence.

Classification:
- D97ES VESA runtime PASS;
- persistent collector static audit PASS;
- accelerated boot NOT AUTHORIZED until collector itself passes a no-reboot live test in the current VESA session.

D97EW checkpoint commit: `930c308de295f412650e9454cefcce3cf305baa7`.
Master update commit advancing authority to D97EW: `7761652d1bb3cbfd3d29351b9c1c41ea31165886`.

## Current action
Remain in the current D97ES VESA session. Install the exact commit-pinned D97EW persistent collector and return the full installer/live-test output. Required live VESA result: installer PASS, service present, `captured_count=0`, `set_id_mode_calls=0`, `route=PASS`.

Do not Root Patch, reboot, alter EFI/boot args/framebuffer, or attempt acceleration until that collector live test is audited and a new checkpoint separately authorizes the accelerated measurement boot.
