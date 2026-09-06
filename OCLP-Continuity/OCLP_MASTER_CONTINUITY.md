# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97DJ_D97DI_LATENT_DEPLOY_PASS_RUNTIME_READY.md`

## Mandatory startup order
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. history/retrospective as needed.

## Current ASUS2 authority
- macOS Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- unpatched VESA;
- no active Root Patch;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag`;
- boot args do NOT contain `-ocmcd97bv`;
- Lilu `1.7.3` at Kernel/Add index 0;
- OCLPMetalCompat unique Kernel/Add index 5;
- active EFI now contains D97DI `OCLPMetalCompat.kext` 0.0.6;
- D97DI executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- D97DI expected UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- D97DD backup exists at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DD-20260906_225651.bak`, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`.

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

## Runtime delivery closure through D97DG
D97DD 0.0.4 established the final observe-only `_cs_validate_page` substrate: Apple original first, exact callback build `25G82`, exact main x86_64h cache path/page observation and persistent IORegistry state.

D97DF proved route PASS, callback execution PASS, exact-build PASS and natural CAVE delivery with full zero invariants, Apple validated `0xF`, tainted 0, NX 0.

D97DG then actively faulted exact SITE and CAVE pages through read-only/private+execute mappings. Successful D97DG ZIP `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`, SHA256 `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`.

Runtime closure:
- SITE exact original preimage PASS; page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`; validated `0xF`, tainted 0, NX 0;
- CAVE full208 zero PASS and functional18 zero PASS; page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`; validated `0xF`, tainted 0, NX 0.

Thus runtime route/timing/preimage prerequisite for functional D97BV delivery is CLOSED PASS.
D97DH is superseded and must not be deployed.

## D97DI 0.0.6 — source/build/binary audit PASS
Authoritative source:
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

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

Binary audit:
- exact SITE replacement once;
- exact CAVE replacement once;
- trampoline arithmetic PASS;
- required D97DI markers present;
- generic patching surfaces absent.

Audited LATENT package `OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`, SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`.

D97DI functional design is double gated:
- `-ocmcdiag` installs route;
- `-ocmcd97bv` separately arms functional page writes.
Without `-ocmcd97bv`, D97DI is LATENT / observe-only.

## D97DJ — LATENT deployment PASS
Returned report `OCLP7_D97DJ_D97DI_LATENT_EFI_REPLACE_20260906_225651.txt`.

PASS evidence:
- config expected/actual SHA identical `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- unique OCLPMetalCompat index 5;
- Lilu 1.7.3 index 0;
- old D97DD executable identity exact;
- audited D97DI package/source/executable identity exact;
- staged D97DI SHA exact;
- D97DD backup exact;
- final D97DI executable SHA `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- final version 0.0.6;
- config remains byte-identical;
- boot args remain `-igfxvesa -ocmcdiag` without `-ocmcd97bv`;
- `POST_REPLACE_LATENT_GATE=PASS`;
- no Root Patch;
- no reboot;
- no functional D97BV mutation.

Authoritative classifications:
- `D97DJ_D97DI_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DJ_D97DI_LATENT_DEPLOY=PASS`;
- `D97DJ_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DJ_FUNCTIONAL_BOOTARG_PRESENT=NO`;
- `D97DJ_D97BV_FUNCTIONAL_MUTATION=NO`.

## CURRENT ACTION — D97DK LATENT runtime proof
One manual VESA diagnostic reboot is authorized through the same unchanged active OpenCore EFI.

Rules:
1. keep `-igfxvesa -ocmcdiag`;
2. keep `-ocmcd97bv` absent;
3. do not change EFI/config;
4. do not Root Patch;
5. reboot normally through the same active EFI;
6. after desktop returns, collect D97DI runtime evidence.

D97DK must prove:
- exact D97DI 0.0.6 loaded, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- route PASS;
- callback exact-build PASS / observed build 25G82;
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- `D97DISiteWriteCount=0`;
- `D97DICaveWriteCount=0`;
- boot args exclude `-ocmcd97bv`.

Still NOT authorized:
- adding `-ocmcd97bv`;
- functional D97BV activation;
- Root Patch;
- accelerated boot.