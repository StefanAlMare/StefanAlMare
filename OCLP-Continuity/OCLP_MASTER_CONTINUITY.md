# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DG_SITE_CAVE_RUNTIME_PROVEN_FUNCTIONAL_DESIGN_READY.md`
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
- boot args retain `-igfxvesa -ocmcdiag`;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- Lilu `1.7.3` index 0;
- OCLPMetalCompat unique index 5;
- active EFI contains D97DD `OCLPMetalCompat.kext` 0.0.4;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable architecture
Target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions remain:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no Golden layout transplant;
- no global forced 3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV retained facts
D97BV selective adapter is static-semantic PROVEN: exact input 3802 bypasses Tahoe floor; every non-3802 input executes original Tahoe behavior.

Exact targets:
- site VM `0x7FF80F5E1719`, page offset `0xF5E1000`, in-page `0x719`;
- site original `3d187d0000b9177d00000f4cc1`;
- site replacement `3dda0e00007406e93bcee9ff90`;
- cave VM `0x7FF80F47E560`, page offset `0xF47E000`, in-page `0x560`;
- cave replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

D97BV remains unapplied.

## Runtime delivery closure
D97DD 0.0.4 installs `_cs_validate_page` without early build read, calls Apple original first, then enforces exact `25G82` inside the callback before target-page observation.

D97DF proved exact D97DD load, route PASS, callback execution PASS, callback exact-build PASS for 25G82, and natural cave observation with zero invariants PASS and Apple validated `0xF`, tainted 0, NX 0.

D97DG then actively faulted both exact target pages through read-only `MAP_PRIVATE|PROT_READ|PROT_EXEC` mappings of the main Cryptex shared cache.

Returned D97DG ZIP:
- `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`;
- bytes `2153`;
- SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`.

Inner TXT:
- bytes `5958`;
- SHA256 `0ebb77f6833554415694ab55ee6b28f3cd9854ec4de2f6877c3ed03040774fcc`.

D97DG runtime closure:
- initial publisher ticks `119`;
- site mmap PASS;
- exact site 13-byte window `3d187d0000b9177d00000f4cc1` PASS;
- site page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`;
- `SiteSeenCount=1`;
- `SitePreimage=PASS`;
- `SiteValidated=15/0xF`;
- `SiteTainted=0`;
- `SiteNX=0`;
- cave mmap PASS;
- cave full208 zero PASS;
- cave window18 zero PASS;
- cave page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`;
- CaveSeenCount=1, validated `0xF`, tainted 0, NX 0;
- final callback count `174416`;
- route/build remain PASS.

Authoritative classifications:
- `D97DG_D97BV_SITE_PAGE_ACTIVE_FAULT=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_PREIMAGE=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_PAGE_ACTIVE_FAULT=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_FULL208_ZERO=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_FUNCTIONAL18_ZERO=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`.

The runtime route/timing/preimage prerequisite for a functional D97BV successor is now CLOSED PASS.

## D97DH cancellation
D97DH extended-publisher tooling is no longer needed because D97DG succeeded within D97DD's existing window. Do not build/deploy D97DH for the current path. ASUS2 remains on D97DD 0.0.4.

## CURRENT ACTION
No EFI/config/kext change, Root Patch, accelerated boot or functional page mutation is currently authorized.

The next allowed engineering action is static design/audit of a functional D97BV successor using the proven D97DD `_cs_validate_page` delivery path. Actual functional page mutation/deployment requires separate explicit user authorization.
