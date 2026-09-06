# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97DG_PUBLISHER_WINDOW_TOOLING_NEGATIVE_D97DH_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: native Tahoe Metal/Metal4 with selective true-3802 ingress and otherwise unchanged Tahoe 32023/32024 semantics.

## Durable closed branches
- Full legacy main Metal on Tahoe: ABI-incompatible NEGATIVE because Metal4 superclass surface disappears.
- Standalone reconstructed Metal carrier: CLOSED after D97CJ proved broad shared-cache-origin Objective-C relocation state.
- Plain BinaryModInfo targeting canonical standalone Tahoe Metal: blocked because native Metal is cache-resident and canonical file is absent.

## D97BV selective adapter
Static-semantic PROVEN: preserve exact 3802; otherwise execute original Tahoe floor behavior.
Native Metal `__TEXT` base `0x7FF80F47D000`.
Site `0x7FF80F5E1719`, page offset `0xF5E1000`, in-page `0x719`, original `3d187d0000b9177d00000f4cc1`, replacement `3dda0e00007406e93bcee9ff90`.
Cave `0x7FF80F47E560`, page offset `0xF47E000`, in-page `0x560`, replacement `3d187d0000b9177d00000f4cc1e9b4311600`.
D97BV remains unapplied and functionally unauthorized.

## D97CL-D97CN native-cache substrate
D97CL proved Haswell AVX2, Lilu 1.7.3, WEG 1.7.1 and expected x86_64h cache substrate.
D97CM proved exact native Metal TEXT mapping through Lilu map parsing.
D97CN proved static target topology: site preimage PASS; cave 208-byte zero PASS; future functional 18-byte zero PASS.

## D97CO-D97CS first plugin observation channel
D97CO 0.0.1 compile/binary observe-only PASS.
D97CQ deployed it. D97CR proved runtime load but unified log marker channel was inconclusive.
D97CS proved OCLPMetalCompat IOKit lifecycle. Persistent IORegistry became the preferred runtime evidence channel.

## D97CT-D97CX persistent channel / first gate failure
D97CT 0.0.2 added atomic state + asynchronous IORegistry publisher.
D97CW deployed it after EFI re-audit.
D97CX proved persistent runtime channel but early `sysctlbyname(kern.osversion)` exact-build query failed before route installation.

## D97CY / D97DC second gate placement failure
D97CY 0.0.3 replaced sysctl with direct kernel-global `osversion[]` in `onPatcherLoadForce`.
Compile/audit PASS; D97DB deployed it while preserving config.
D97DC proved later publisher sees `25G82`, but patcher-load still executes before `osversion[]` initialization; BuildGate latched NEGATIVE and route remained NOT ATTEMPTED.
Classification: gate-placement timing/tooling NEGATIVE, not a real build mismatch.

## D97DD 0.0.4
D97DD installs `_cs_validate_page` route without reading `osversion[]`; wrapper calls Apple original first, increments callback count, then enforces exact `25G82` per callback before target-page observation.
Source SHA256 `6d1292eb812d4df83d0185c8a19c025131fe0e213048221099618e80790aa7c2`.
Compiled UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`.
Compile/source/control-flow/binary audit PASS; no functional page mutation.
D97DE deployed D97DD into active EFI while preserving config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.

## D97DF — major runtime closure
Returned `OCLP7_D97DF_D97DD_VESA_RUNTIME_20260906_205320.zip`:
- ZIP SHA256 `7cfe5586dd5671da1ae42a3c0575c79ebc24bc9bd96bc73033adfdb30485681a`;
- TXT SHA256 `7797af1775f70649a49a5ef319b3d1a729a993aac11be2f7728e0562579fa229`.

Runtime:
- exact D97DD 0.0.4 loaded;
- RouteStatus=PASS;
- D97DDCallbackSeenCount=256069;
- BuildGate=1;
- D97DDObservedBuild=25G82;
- BootArg/Kernel/Cpu gates all PASS.

Classifications:
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_CALLBACK_EXECUTION=RUNTIME_PROVEN`;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`.

Natural VESA cave page observation:
- CaveSeenCount=1;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15/0xF (`VMP_CS_ALL_TRUE`);
- CaveTainted=0;
- CaveNX=0.

Thus cave target page, zero invariant and full Apple code-sign validation are runtime PROVEN.

Site page:
- SiteSeenCount=0 during 300-second VESA publisher window;
- no site preimage/validated/tainted/nx runtime evidence yet.

This is `NOT_OBSERVED_WITHIN_300S_VESA`, not NEGATIVE.

## D97DG — publisher-window tooling negative
Second active-fault attempt returned `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_212953.txt`:
- bytes `2437`;
- SHA256 `6622a56e51b73343fe1a77b2d7fe0202115fa17033e9b5881e446fee782fc5c8`.

Boot time `21:25:09`; collector started around `21:29:53`, roughly 284 seconds later. Initial IORegistry showed:
- D97DD 0.0.4 exact UUID loaded;
- RouteStatus=PASS;
- BuildGate=1;
- callback count `251445`;
- cave still PASS;
- site count still 0;
- PublisherTicks=`288`.

The collector deliberately stopped before mmap because the remaining 12 seconds were insufficient for an active-fault + asynchronous publication cycle.

This is the second independent demonstration that the 300-second publisher window is operationally too short for post-desktop active site faulting on ASUS2.

Classifications:
- `D97DG_ACTIVE_SITE_MMAP_TRIGGER=NOT_EXECUTED`;
- `D97DG_SITE_RUNTIME_PREIMAGE=UNTESTED`;
- `D97DG_PUBLISHER_300S_WINDOW=TOOLING_NEGATIVE_FOR_POST_DESKTOP_ACTIVE_FAULT`;
- no site-negative conclusion;
- all D97DF route/build/callback/cave proofs remain authoritative.

## D97DH current action
D97DH 0.0.5 is a tooling-only successor to D97DD. It preserves route/callback/build/site/cave logic and changes only the asynchronous publisher lifetime:
- cutoff `300 -> 900` seconds;
- early stop still occurs when site+cave have both been observed;
- exposes `D97DHPublisherPolicy=extended-until-site-cave-or-900-v1` and `D97DHPublisherLimitTicks=900`;
- no page mutation and no D97BV replacement bytes.

Prepared source SHA256 `63541e7135388ee73ca3b8a408a45578e742734a79f6d313f8aef919405251f1`.
Prepared iMac build script SHA256 `d269baf9b841216ced0d202595c228772823b49a248962e6466575d99084e71a`, `bash -n` PASS.
Intended plugin version `0.0.5`.

CURRENT ACTION: build D97DH 0.0.5 on the already-authorized iMac 9900K host and return the build ZIP for independent audit. ASUS2 EFI remains on D97DD 0.0.4 until that audit passes.

Functional D97BV page writes remain separately unauthorized. No Root Patch or accelerated boot is authorized.
