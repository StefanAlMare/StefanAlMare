# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97DI_BUILD_BINARY_AUDIT_PASS_LATENT_DEPLOY_READY.md`.
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

## Current action
ASUS2 remains unchanged on D97DD 0.0.4.
D97DI is ready for an identity-pinned **LATENT** deployment design that preserves current config and leaves `-ocmcd97bv` absent.

Not yet authorized: D97DI deployment, functional bootarg, functional mutation, Root Patch, accelerated boot or reboot.