# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DI_BUILD_BINARY_AUDIT_PASS_LATENT_DEPLOY_AUTHORIZED.md`
Build audit artifact: `OCLP-Continuity/artifacts/OCLP7_D97DI_BUILD_BINARY_AUDIT_20260906.md`
D97DJ deploy artifact: `OCLP-Continuity/artifacts/OCLP7_D97DJ_D97DI_LATENT_EFI_REPLACE.sh`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`

## Mandatory startup order
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. history/retrospective as needed.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current mode: unpatched VESA;
- no Root Patch;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag`;
- boot args do NOT contain `-ocmcd97bv`;
- Lilu `1.7.3` at Kernel/Add index 0;
- OCLPMetalCompat unique Kernel/Add index 5;
- active EFI currently contains D97DD `OCLPMetalCompat.kext` 0.0.4;
- D97DD executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`;
- D97DD UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no Golden request-layout transplant;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV exact adapter
Static semantics PROVEN:
- exact input `3802` bypasses Tahoe floor;
- every non-3802 input executes original Tahoe floor semantics.

Exact targets:
- SITE page `0xF5E1000`, in-page `0x719`, original `3d187d0000b9177d00000f4cc1`;
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- CAVE page `0xF47E000`, in-page `0x560`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`.

## Runtime delivery closure
D97DD 0.0.4 established the final observe-only `_cs_validate_page` substrate: Apple original first, exact callback build 25G82, exact main x86_64h cache path/page observation and persistent IORegistry state.

D97DF proved route PASS, callback execution PASS, exact-build PASS and natural CAVE delivery with zero invariants, Apple validated `0xF`, tainted 0, NX 0.

D97DG successful active read-only fault closed both targets:
- ZIP `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip` SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`;
- SITE exact original window PASS, page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`, SiteSeenCount=1, validated `0xF`, tainted 0, NX 0;
- CAVE full208 zero PASS and functional18 zero PASS, page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`, CaveSeenCount=1, validated `0xF`, tainted 0, NX 0.

Thus the runtime route/timing/preimage prerequisite for functional D97BV delivery is CLOSED PASS.
D97DH is superseded and must not be deployed.

## D97DI 0.0.6 — build/binary audit PASS
Authoritative source SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`, Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Without `-ocmcd97bv`, D97DI is LATENT / observe-only. Existing `-ocmcdiag` still gates route installation.

Returned build `OCLP7_D97DI_IMAC_BUILD_20260906_223615.zip`:
- SHA256 `671d3a19af6a0168b89272c7833547e49a84dbf44fb03765e9c40bc61a4b0642`;
- manifest mismatches 0;
- Lilu build PASS;
- D97DI build PASS;
- zero compiler errors.

Compiled D97DI:
- version `0.0.6`;
- UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- Lilu dependency `1.7.3`.

Binary audit PASS:
- exact SITE replacement occurs once;
- exact CAVE replacement occurs once;
- trampoline arithmetic PASS;
- required D97DI markers present;
- generic patching surfaces absent.

Audited LATENT package:
- `OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`;
- SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`.

## D97DJ — CURRENT ACTION
User explicitly authorized LATENT deployment.

Authoritative D97DJ script:
- `OCLP-Continuity/artifacts/OCLP7_D97DJ_D97DI_LATENT_EFI_REPLACE.sh`;
- delivered local script SHA256 `1c6ed6802a7974aefd2367d3df943f8daa1ed8ab939f1be2186b73640212eab5`;
- `bash -n` PASS.

D97DJ must:
- run on ASUS2 only;
- verify exact config SHA, D97DD executable identity, OCLPMetalCompat index 5 and Lilu 1.7.3;
- require `-igfxvesa -ocmcdiag`;
- abort if `-ocmcd97bv` is present;
- verify audited D97DI package/source/executable identity;
- replace only `EFI/OC/Kexts/OCLPMetalCompat.kext`;
- backup D97DD;
- preserve config byte-identically;
- perform no Root Patch, no functional page mutation and no reboot.

After D97DJ, return the generated TXT report BEFORE reboot.

NOT authorized yet:
- adding `-ocmcd97bv`;
- functional D97BV page mutation;
- Root Patch;
- accelerated boot;
- reboot before D97DJ report audit.
