# OCLP7 CHECKPOINT — 2026-09-06 — D97DI build/binary audit PASS; LATENT deploy authorized

## Runtime authority entering D97DJ
ASUS2 remains unchanged on:
- Tahoe 26.6.2 / 25G82;
- Haswell HD4400/4600 8086:0412;
- SMBIOS MacBookAir6,2;
- unpatched VESA;
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag` and do NOT contain `-ocmcd97bv`;
- Lilu 1.7.3 at Kernel/Add index 0;
- OCLPMetalCompat unique index 5;
- active D97DD 0.0.4 executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`, UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.

## D97DI 0.0.6 build result
Returned build: `OCLP7_D97DI_IMAC_BUILD_20260906_223615.zip`.
- ZIP bytes: 56369;
- ZIP SHA256: `671d3a19af6a0168b89272c7833547e49a84dbf44fb03765e9c40bc61a4b0642`;
- manifest mismatches: 0;
- Lilu xcodebuild PASS;
- D97DI xcodebuild PASS;
- errors: 0;
- warnings: 6 non-functional build/toolchain warnings.

Source inside ZIP matches authoritative D97DI source:
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

Compiled D97DI:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.6`;
- thin x86_64 KEXTBUNDLE;
- UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- built Info.plist SHA256 `b228aa9e1e33f8d27b8e139afbde3c376076de12114b1a3d579eaf2465774484`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency 1.7.3;
- ad-hoc signature.

## Binary payload audit
Exact SITE replacement occurs exactly once:
`3dda0e00007406e93bcee9ff90`.

Exact CAVE replacement occurs exactly once:
`3d187d0000b9177d00000f4cc1e9b4311600`.

Control-flow arithmetic PASS:
- SITE non-3802 jump -> exact CAVE;
- exact 3802 JE +6 -> SITE+13;
- CAVE starts with exact original Tahoe 13-byte floor sequence;
- CAVE return jump -> SITE+13.

Required D97DD substrate and D97DI functional-mode/safety/mutation/postimage/write-count markers are compiled in.
Forbidden generic patching strings are absent: `vm_map_write_user`, `orgVmMapWriteUser`, `findAndReplace`, `findAndReplaceWithMask`, `injectPayload`, `injectSegment`, `vmProtect`.

## Audited latent package
`OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`
- SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f`;
- bytes 23614.

## Authorization boundary
User explicitly authorized the next step.

AUTHORIZED now:
- D97DJ identity-pinned replacement of only `EFI/OC/Kexts/OCLPMetalCompat.kext` from D97DD 0.0.4 to D97DI 0.0.6;
- LATENT mode only;
- `config.plist` must remain byte-identical;
- `-ocmcd97bv` must remain absent;
- no Root Patch;
- no reboot until D97DJ report is returned and audited.

NOT authorized yet:
- adding `-ocmcd97bv`;
- functional D97BV page mutation;
- accelerated boot;
- Root Patch;
- reboot before post-deploy report audit.

## CURRENT ACTION
Run D97DJ controlled LATENT EFI replacement on ASUS2, return the generated report, and do not reboot.
