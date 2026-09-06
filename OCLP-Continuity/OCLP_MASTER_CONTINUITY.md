# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DI_BUILD_BINARY_AUDIT_PASS_LATENT_DEPLOY_READY.md`
Build audit artifact: `OCLP-Continuity/artifacts/OCLP7_D97DI_BUILD_BINARY_AUDIT_20260906.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current ASUS2 state
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current mode: unpatched VESA;
- no active Root Patch;
- boot args retain `-igfxvesa -ocmcdiag`;
- boot args do **not** contain `-ocmcd97bv`;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- Lilu `1.7.3` at Kernel/Add index 0;
- OCLPMetalCompat unique index 5;
- active EFI remains D97DD `OCLPMetalCompat.kext` 0.0.4;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
Local iMac 9900K compilation is authorized for this OCLPMetalCompat lineage.

## Durable architecture
Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global `32023 -> 31001` or `32023 -> 3802` rewrite;
- no Golden request-layout transplant;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV exact adapter
Static semantics are PROVEN:
- exact input `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics.

Exact targets:
- SITE VM `0x7FF80F5E1719`, page `0xF5E1000`, in-page `0x719`;
- SITE original `3d187d0000b9177d00000f4cc1`;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE VM `0x7FF80F47E560`, page `0xF47E000`, in-page `0x560`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## Runtime delivery closure through D97DG
D97DD 0.0.4 established the final observe-only `_cs_validate_page` delivery substrate: Apple original first, callback exact-build `25G82`, exact main x86_64h cache path/page observation, persistent IORegistry state.

D97DF runtime proved D97DD load, route PASS, callback execution PASS, exact-build PASS and natural CAVE delivery/invariants with Apple validated `0xF`, tainted 0, NX 0.

D97DG successful active read-only page-fault run:
- ZIP `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`;
- SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`;
- SITE exact original window PASS;
- SITE page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- SiteSeenCount=1, SitePreimage=PASS, validated `0xF`, tainted 0, NX 0;
- CAVE full208 zero PASS, functional18 zero PASS;
- CAVE page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- CaveSeenCount=1, validated `0xF`, tainted 0, NX 0;
- route/build remained PASS.

Therefore the runtime route/timing/preimage prerequisite for functional D97BV delivery is CLOSED PASS.
D97DH extended-publisher tooling is superseded; do not deploy it.

## D97DI 0.0.6 — latent functional successor
Pinned source:
- `OCLP-Continuity/artifacts/OCLP7_D97DI_kern_start.cpp`;
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Without `-ocmcd97bv`, D97DI remains LATENT / observe-only. Existing `-ocmcdiag` remains required to install the route.

Functional write sequence is fail-closed:
1. Apple original `_cs_validate_page` first;
2. exact callback build `25G82`;
3. exact SITE/CAVE page offset;
4. exact main x86_64h vnode suffix;
5. explicit `-ocmcd97bv` request;
6. Apple result validated `0xF`, tainted 0, NX 0;
7. exact SITE preimage or exact CAVE zero invariants;
8. exact bounded write only;
9. exact postimage verification.

Writes are bounded to SITE 13 bytes at `+0x719` and CAVE 18 bytes at `+0x560`.

Historical iMac helper authority correction:
- commit `9d867d14c9be80e74ec9cefb50a30597de017959`;
- helper Git blob `8cc7f350f6fee51d17a6fbe1bbdfced4554a9ccf`;
- actual helper SHA256 `faea187c1e1f4b43dabcc231b62f4110c903cf3543f2711324bcbedf7854f49c`;
- prior documented `bbd360...` is stale/incorrect.

## D97DI returned build / independent audit PASS
Returned ZIP:
`OCLP7_D97DI_IMAC_BUILD_20260906_223615.zip`

- bytes `56369`;
- SHA256 `671d3a19af6a0168b89272c7833547e49a84dbf44fb03765e9c40bc61a4b0642`;
- manifest mismatches `0`;
- Lilu build PASS;
- D97DI build PASS;
- two `BUILD SUCCEEDED`;
- zero compiler errors;
- six non-functional build/toolchain warnings.

Compiled D97DI:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.6`;
- thin x86_64 Mach-O KEXTBUNDLE;
- UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- built Info.plist SHA256 `b228aa9e1e33f8d27b8e139afbde3c376076de12114b1a3d579eaf2465774484`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature per build report.

Binary audit:
- exact SITE replacement occurs once;
- exact CAVE replacement occurs once;
- SITE non-3802 JMP -> exact CAVE PASS;
- SITE exact-3802 `JE +6` -> SITE+13 PASS;
- CAVE original-floor prefix PASS;
- CAVE return JMP -> SITE+13 PASS;
- all D97DD substrate and D97DI functional state markers present;
- forbidden generic patch/write strings absent: `vm_map_write_user`, `orgVmMapWriteUser`, `findAndReplace`, `findAndReplaceWithMask`, `injectPayload`, `injectSegment`, `vmProtect`.

Authoritative classifications:
- `D97DI_LOCAL_COMPILE=PASS`;
- `D97DI_MANIFEST_AUDIT=PASS`;
- `D97DI_SOURCE_IDENTITY=PASS`;
- `D97DI_MACHO_IDENTITY=PASS`;
- `D97DI_D97BV_BINARY_PAYLOAD=PASS`;
- `D97DI_D97BV_CONTROL_FLOW_REAUDIT=PASS`;
- `D97DI_REQUIRED_RUNTIME_MARKERS=PASS`;
- `D97DI_FORBIDDEN_GENERIC_PATCH_SURFACE=ABSENT`;
- `D97DI_LATENT_DEFAULT=PASS`;
- `D97DI_BUILD_BINARY_AUDIT=PASS`.

## Audited latent package
Prepared local package:
`OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`
- SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`;
- bytes `23614`;
- AUDIT.txt SHA256 `e8b8b6e941fb976cfb2f7d01b9517d9e22895458ea3127317a48a4e31cae208c`;
- manifest SHA256 `fccce61cd6d4502eae9b31f4bb3e98d1ff5cd7accb0796b9dde1610a4d1462d3`.

## CURRENT ACTION / authorization boundary
D97DI is ready for an identity-pinned **LATENT deployment design** from D97DD 0.0.4 while preserving config and leaving `-ocmcd97bv` absent.

Not authorized yet:
- D97DI deployment to ASUS2;
- adding `-ocmcd97bv`;
- functional page mutation;
- Root Patch;
- accelerated boot;
- reboot.