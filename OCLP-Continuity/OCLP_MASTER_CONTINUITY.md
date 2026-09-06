# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DI_STATIC_DESIGN_PASS_BUILD_READY.md`
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

## Current machine / EFI
- ASUS2: Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current mode: unpatched VESA;
- no active Root Patch;
- boot args currently retain `-igfxvesa -ocmcdiag` and do **not** contain `-ocmcd97bv`;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- Lilu `1.7.3` index 0;
- OCLPMetalCompat unique index 5;
- active EFI remains D97DD `OCLPMetalCompat.kext` 0.0.4;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.
GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
The user has already authorized the iMac 9900K local build host for this OCLPMetalCompat lineage.

## Durable architecture
Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions remain:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no Golden request-layout transplant;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV exact adapter
D97BV is static-semantic PROVEN:
- exact input 3802 bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics.

Exact targets:
- SITE VM `0x7FF80F5E1719`, page `0xF5E1000`, in-page `0x719`;
- SITE original `3d187d0000b9177d00000f4cc1`;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE VM `0x7FF80F47E560`, page `0xF47E000`, in-page `0x560`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## Runtime delivery closure through D97DG
D97DD 0.0.4 established the final observe-only delivery substrate:
- `_cs_validate_page` route installed before any early build read;
- Apple original called first;
- callback exact-build `25G82` gate;
- exact main x86_64h path and exact target-page observation;
- persistent IORegistry state.

D97DF runtime proved D97DD load, route PASS, callback execution PASS, callback exact-build PASS, and natural CAVE delivery/invariants with Apple validated `0xF`, tainted 0, NX 0.

D97DG then actively faulted exact SITE and CAVE pages through read-only private+execute mappings of the main Cryptex shared cache.
Successful D97DG ZIP:
- `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`;
- SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`.

Runtime closure:
- SITE exact original window PASS;
- SITE page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- SiteSeenCount=1, SitePreimage=PASS, validated `0xF`, tainted 0, NX 0;
- CAVE full208 zero PASS, functional18 zero PASS;
- CAVE page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- CaveSeenCount=1, validated `0xF`, tainted 0, NX 0;
- route/build remained PASS.

Thus the runtime route/timing/preimage prerequisite for functional D97BV delivery is CLOSED PASS.

D97DH extended-publisher tooling is superseded and must not be deployed.

## D97DI 0.0.6 — latent functional successor STATIC PASS
D97DI preserves the D97DD delivery path and compiles the exact D97BV SITE+CAVE payload behind an additional explicit boot argument:
`-ocmcd97bv`.

Without `-ocmcd97bv`, D97DI remains LATENT / observe-only and performs no functional page writes.
The existing `-ocmcdiag` remains required to install the route.

Functional write sequence is fail-closed:
1. Apple original `_cs_validate_page` first;
2. exact callback build `25G82`;
3. exact SITE/CAVE page offset;
4. exact main x86_64h vnode suffix;
5. explicit `-ocmcd97bv` request;
6. Apple result exactly validated `0xF`, tainted 0, NX 0;
7. exact SITE preimage or exact CAVE zero invariants;
8. fixed-size exact-offset write only;
9. exact postimage verification.

Writes are bounded to:
- SITE exactly 13 bytes at `+0x719`;
- CAVE exactly 18 bytes at `+0x560`.

D97DI adds explicit IORegistry state for functional mode, safety, mutation, postimages and write counts. Functional publisher completion also waits for both mutation outcomes when ACTIVE.

Pinned D97DI source:
- GitHub `OCLP-Continuity/artifacts/OCLP7_D97DI_kern_start.cpp`;
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Static audit artifact:
- `OCLP-Continuity/artifacts/OCLP7_D97DI_STATIC_DESIGN_AUDIT.md`;
- SHA256 `ba904670495c8a70daad5bdb807debbbe8ca63cfd1d4383fb58916633737ddd0`;
- Git blob `08eec8fb1ed0767bba66a5c79fbc3590d0987241`.

Prepared local iMac build helper:
- SHA256 `bbd360dd870e6e0395693cf1fd2caf777ab2cb9c5ddcab02fad8428e8955714e`;
- `bash -n` PASS;
- exact source SHA pinned;
- target version 0.0.6;
- binary audit requires both exact functional payloads and D97DI markers;
- deploy authorization NO.

Static classifications:
- `D97DI_D97BV_CONTROL_FLOW=STATIC_SEMANTIC_PROVEN`;
- `D97DI_FUNCTIONAL_BOOTARG_FAIL_CLOSED=STATIC_PROVEN`;
- `D97DI_APPLE_VALIDATION_SAFETY_GATE=STATIC_PROVEN`;
- `D97DI_SITE_WRITE_BOUND=STATIC_PROVEN`;
- `D97DI_CAVE_WRITE_BOUND=STATIC_PROVEN`;
- `D97DI_POSTIMAGE_VERIFICATION=STATIC_PROVEN`;
- `D97DI_LATENT_DEFAULT=STATIC_PROVEN`;
- `D97DI_SOURCE_STATIC_AUDIT=PASS`;
- `D97DI_BUILD=UNTESTED`.

FeatureUnlock commit `201bd45766207e6cc10cd40a8ac1f9c6216f9acb` remains the upstream Apple-original-first shared-cache callback modification precedent; D97DI is narrower because it uses exact path/page/preimage/fixed windows.

## CURRENT ACTION
Build D97DI 0.0.6 on the already-authorized iMac 9900K host and return the resulting ZIP for independent audit.

ASUS2 remains unchanged on D97DD 0.0.4.

Not authorized yet:
- D97DI deployment to ASUS2;
- adding `-ocmcd97bv`;
- functional page mutation;
- Root Patch;
- accelerated boot;
- reboot.
