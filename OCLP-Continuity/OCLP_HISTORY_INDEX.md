# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260907_D97FI_CORE_DISPLAY_OFFLINE_CRASH_LOOP_FRAMEBUFFER_METADATA_FRONTIER.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`. D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave protected. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired. Permanent method remains module-boundary + semantic evidence + far-frontier, with universal/no-PID coverage where requests vary.

## D97BV / D97DT — selective 3802 runtime closure
Selective true-3802 adapter semantics and runtime delivery CLOSED PASS under exact 25G82. Do not retest absent contradiction.

## D97DX — native-Metal-safe Root Patch
D97DX Root Patch PASS: native Tahoe main Metal authoritative; bounded legacy compiler/compatibility lanes; exact 25G82 metallib; Monterey GVA/OpenCL + Haswell drivers; no legacy main Metal shadow, MetalOld or true-five replay.

## D97EB / D97EE — framebuffer count negative
Normal 3/3/3 and isolated 1/1/1 both reached `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV. No panic, no `_MTL4*`; 1/1/1 CLOSED NEGATIVE, 3/3/3 authoritative.

## D97EG-D97EP — exact set_id_mode observer
Mapped exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` and established observe-only exact passthrough. D97EP VESA route PASS with zero calls as expected.

## D97EQ / D97ER — evidence transport gap
Accelerated failure reproduced; exact tuple unavailable from unified log/dmesg, reclassifying the problem as evidence transport.

## D97ES-D97EV — IORegistry tuple telemetry
D97ES 0.0.11 added first-eight post-original tuple capture while preserving exact passthrough. Independent build/EFI/VESA audits PASS.

## D97EW / D97EX — persistent accelerated evidence
Root LaunchDaemon collector persists OCLPMetalCompat evidence under `/Users/Shared/OCLP-D97EW-Capture`; live VESA persistence PASS.

## D97EY — exact tuple semantic proof
Accelerated run `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295` proved accepted `mode=0x24` / Apple `0` versus rejected `mode=0x224`, additional `0x200`, Apple `0xE00002C2 = kIOReturnBadArgument`. Meaning of `0x200` UNKNOWN; no global mask authorized.
Checkpoint commit `f2762e713565b1e72498241de639bdd5698c82c6`.

## D97EZ — exact-match handoff experiment
LATENT by default; ACTIVE only with `-ocmcd97ez`; exact `0x224 -> 0x24`; every other mode exact passthrough; unchanged `that/id`; one Apple call; exact return passthrough; global counters + original/passed first-eight telemetry.
Generator commit `cd76d912018bfa60284af3cb732ae8bca84db091`, blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

## D97FA / D97FB — build execution lane
GitHub Actions produced no runs and quota/execution remained blocked. User explicitly authorized compilation on home Intel iMac. Do not retry GitHub Actions compilation during this quota-limited period.

## D97FC / D97FD — local build + independent audit
Helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`, blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.
Returned build `OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`, bytes `154432`, SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`.
Independent audit: CRC/manifest/lineage/source/build/Mach-O/disassembly PASS. Compiled D97EZ 0.0.12 x86_64 UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`, executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`, Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`.
D97FD commit `4cc0928f94f9d28bcb1b5b91660a221c570742c4`.

## D97FE / D97FF — deployment identity
User manually replaced EFI kext. Exact D97EZ 0.0.12 active-EFI identity verified before runtime boot.

## D97FG — LATENT VESA runtime PASS
Exact loaded identity PASS; `FunctionalMode=LATENT`; observer route PASS; zero set_id_mode calls/adaptations; publisher 300 ticks. D97FG commit `6c71ca6ead28321ac338323f96365208f1037f34`.

## D97FH — ACTIVE adapter semantic PASS / set_id_mode CLOSED
Persisted ACTIVE accelerated run `/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290`.
At stable 20 routed calls:
- exact-224 seen/adapted/succeeded 16/16/16, failures 0;
- other modes/passthrough succeeded 4/4, failures 0;
- exhaustive 16+4=20 PASS.
First-eight direct telemetry proves captured original `0x224` passed as `0x24` with Apple ret 0; original `0x24` passed unchanged with ret 0.
Thus exact adapter STRUCTURAL-SEMANTIC PASS and prior bad-bits rejection CLOSED PASS as measured causal blocker. End-to-end GUI still failed.
D97FH checkpoint commit `3b882d7428a010a48d4744f290ab97a9232d4b4e`; MASTER advance `023a154a47f944a6fa309513948b2f6f7cd2c292`.

## D97FI — downstream CoreDisplay/framebuffer metadata frontier
Read-only analysis of the immediately preceding ACTIVE accelerated boot localizes the next module downstream of successful set_id_mode acceptance.

Newly REACHED:
- GPUWrangler identifies Haswell IGPU `8086:0412`;
- `/IntelAccelerator` exists;
- AppleIntelFramebuffer@0/@1/@2 exist;
- fb0 online; internal-panel DPCD readable;
- `display0` and `AppleBacklightDisplay` publish;
- CoreDisplay reaches `GPU: FB: 3 of 3 opened`.

First direct accelerated framebuffer-resource negative:
`IOAccelDisplayPipe::init_framebuffer_resource(...): getPixelInformation for framebuffer 0 failed`.
This is REACHED_NEGATIVE, but causal sufficiency remains UNKNOWN.

Related downstream failures:
- `IOFBSetDisplayModeAndDepth: Failed to obtain mode info from IOFBGetDisplayModeInformation()`;
- `Attempting to get capabilities from capabilities with no devices`.

Repeatable fatal path:
`Setting offline display 0x00000000 main in AddCGXDisplayDeviceToDeviceList`
-> `CGXDisplayDriverInitialize`
-> `WS::Displays::CoreDisplayManager::initialize()`
-> `WSInitialize`
-> WindowServer SIGSEGV.
This repeats across multiple WindowServer PIDs. A later restart also logs `(Metal) validateWithDevice, line 5044: error '<private>'` immediately before crash; relationship UNKNOWN.

`com.apple.driver.IOVersatile` dependency/allocation failures also occur, but they recur in the usable VESA recovery boot; therefore IOVersatile is currently NON-DISCRIMINATING and causal status UNPROVEN.

Current localized module:
`successful set_id_mode -> fb0 pixel/mode metadata/resource construction -> CoreDisplay device/capability construction -> main display offline -> WindowServer SIGSEGV`.
Exact crash instruction/stack remains UNKNOWN pending reading existing `.ips` reports.

D97FI checkpoint commit `6099a8b3a12fc69a115408c3e1ee11fc85e5fd95`.
MASTER advance to D97FI: `bc4856b31fc3ecdbf6e157a3ad5c5ec6791aee18`.

## Current action
Remain in VESA. No reboot and no EFI/Root Patch/framebuffer/bootarg changes.
Collect the newest WindowServer `.ips` reports corresponding to the 16:50 accelerated crash loop and inspect exact exception, faulting thread/stack and loaded images. Do not repeat ACTIVE boot before this evidence gate is resolved.
