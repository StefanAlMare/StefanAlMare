# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97DG_SITE_CAVE_RUNTIME_PROVEN_FUNCTIONAL_DESIGN_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted baseline: `P1 + P2b + P3 + AIR00 + D34`.
Current target: native Tahoe Metal/Metal4 with selective true-3802 ingress and otherwise unchanged Tahoe 32023/32024 semantics.

Closed branches retained:
- full legacy main Metal on Tahoe: ABI-incompatible NEGATIVE;
- standalone reconstructed Metal carrier: CLOSED after D97CJ broad ObjC relocation proof;
- plain BinaryModInfo canonical Tahoe Metal path: blocked because native Metal is cache-resident.

## D97BV selective adapter
Static-semantic PROVEN: preserve exact 3802; otherwise execute original Tahoe behavior.
Site page `0xF5E1000`, in-page `0x719`, original `3d187d0000b9177d00000f4cc1`.
Cave page `0xF47E000`, in-page `0x560`, functional 18-byte replacement window zero in static audit.
D97BV remains unapplied.

## D97CL-D97CN — native-cache substrate
D97CL proved Haswell AVX2, Lilu 1.7.3, WEG 1.7.1 and expected x86_64h shared-cache substrate.
D97CM proved exact native Metal TEXT mapping through Lilu parser.
D97CN proved static target topology: site preimage PASS; cave full208 zero PASS; future functional18 zero PASS.

## D97CO-D97CS — first plugin observation channel
D97CO 0.0.1 compile/binary observe-only PASS.
D97CR proved runtime load but unified logging was inconclusive.
D97CS proved OCLPMetalCompat IOKit lifecycle; persistent IORegistry became the preferred evidence channel.

## D97CT-D97CX — persistent channel / first gate failure
D97CT 0.0.2 added atomic state + asynchronous IORegistry publisher.
D97CX proved persistent channel but early `sysctlbyname(kern.osversion)` exact-build gate failed before route.

## D97CY / D97DC — second gate placement failure
D97CY 0.0.3 used direct kernel-global `osversion[]` in `onPatcherLoadForce`.
D97DC proved publisher later sees `25G82`, but patcher-load still precedes osversion initialization. Classification: gate-placement timing/tooling NEGATIVE, not real build mismatch.

## D97DD 0.0.4
D97DD installs `_cs_validate_page` without early build read; wrapper calls Apple original first, increments callback count, then enforces exact `25G82` per callback before target-page observation.
Compiled UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`.
Compile/source/control-flow/binary audit PASS; no functional page mutation.
D97DE deployed D97DD while preserving config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.

## D97DF — route/callback/build/cave runtime closure
Runtime proved:
- exact D97DD 0.0.4 loaded;
- RouteStatus=PASS;
- callback execution high coverage;
- callback BuildGate=1 / ObservedBuild=25G82;
- cave naturally seen;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15/0xF;
- CaveTainted=0;
- CaveNX=0.

Classifications:
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_CALLBACK_EXECUTION=RUNTIME_PROVEN`;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`;
- cave target delivery/invariants/full Apple validation runtime PROVEN.

## D97DG — full site+cave runtime closure
First two D97DG attempts stopped before mmap because publisher was already near/at 300 ticks; those attempts were tooling-negative only.

Successful returned ZIP:
`OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`
- bytes `2153`;
- SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`.

Inner TXT:
- bytes `5958`;
- SHA256 `0ebb77f6833554415694ab55ee6b28f3cd9854ec4de2f6877c3ed03040774fcc`.

Successful run began at publisher tick 119.
Read-only/private+execute mappings of exact main Cryptex shared-cache pages produced:
- SITE mmap PASS;
- SITE exact 13-byte window PASS;
- SITE page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- `SiteSeenCount=1`;
- `SitePreimage=PASS`;
- `SiteValidated=15/0xF`;
- `SiteTainted=0`;
- `SiteNX=0`;
- CAVE mmap PASS;
- CAVE full208 zero PASS;
- CAVE window18 zero PASS;
- CAVE page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- CaveSeenCount=1, validated `0xF`, tainted 0, NX 0;
- RouteStatus and BuildGate remained PASS.

Authoritative classifications:
- `D97DG_D97BV_SITE_PAGE_ACTIVE_FAULT=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_PREIMAGE=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_PAGE_ACTIVE_FAULT=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_FULL208_ZERO=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_FUNCTIONAL18_ZERO=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`.

The runtime route/timing/preimage prerequisite for functional D97BV delivery is CLOSED PASS.

## D97DH cancellation
D97DH extended-publisher tooling was prepared after the earlier timeout-only D97DG attempts, but is superseded by the successful D97DG run. Do not deploy it. ASUS2 remains on D97DD 0.0.4.

## CURRENT ACTION
No EFI/config/kext change, Root Patch, accelerated boot or functional page mutation is authorized yet.
The next engineering action may be static design/audit of a functional D97BV successor using the proven D97DD delivery path. Actual functional mutation/deployment requires separate explicit user authorization.
