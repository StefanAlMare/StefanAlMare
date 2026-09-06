# OCLP7 CHECKPOINT — 2026-09-06 — D97DJ D97DI LATENT deploy PASS; runtime ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DI_BUILD_BINARY_AUDIT_PASS_LATENT_DEPLOY_AUTHORIZED.md` for current execution.

## ASUS2 entering state
- macOS Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- unpatched VESA;
- no Root Patch;
- active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag`;
- boot args do NOT contain `-ocmcd97bv`;
- Lilu 1.7.3 at Kernel/Add index 0;
- OCLPMetalCompat unique index 5.

## D97DJ returned report
Returned report: `OCLP7_D97DJ_D97DI_LATENT_EFI_REPLACE_20260906_225651.txt`.

Host:
- ProductVersion `26.6.2`;
- BuildVersion `25G82`;
- Darwin `25.6.0 x86_64`.

Pre-deploy config identity:
- expected SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- actual SHA256 identical;
- `plutil` PASS;
- unique OCLPMetalCompat index 5.

Boot args before replacement:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag`

Semantic gates:
- `-igfxvesa` present;
- `-ocmcdiag` present;
- `-ocmcd97bv` absent = PASS;
- OCLPMetalCompat enabled, Darwin 25 only;
- Lilu 1.7.3 at index 0.

## Old D97DD exact identity
- version `0.0.4`;
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- executable expected/actual SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25` PASS.

## Audited D97DI package identity
Package: `OCLP7_D97DI_AUDITED_LATENT_DEPLOY_20260906.zip`.
- expected/actual package SHA256 `6f4b43f8fedf9a5167b5d3921d69fb43e7c580f951627352ea78a23316d37e3f` PASS;
- authoritative source expected/actual SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b` PASS;
- executable expected/actual SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4` PASS;
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.6`;
- Lilu dependency `1.7.3`;
- audited latent gate PASS.

## Replacement
- staged executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4` PASS;
- backup created: `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DD-20260906_225651.bak`;
- backup executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`.

Post-replace:
- final executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- final version `0.0.6`;
- final bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- final config SHA256 remains `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- final boot args remain unchanged and contain no `-ocmcd97bv`;
- `POST_REPLACE_LATENT_GATE=PASS`;
- `D97DJ_STATUS=PASS`;
- Root Patch NO;
- reboot NO;
- functional D97BV mutation NO.

## Authoritative classifications
- `D97DJ_D97DI_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DJ_D97DI_LATENT_DEPLOY=PASS`;
- `D97DJ_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DJ_D97DD_BACKUP=PASS`;
- `D97DJ_FUNCTIONAL_BOOTARG_PRESENT=NO`;
- `D97DJ_D97BV_FUNCTIONAL_MUTATION=NO`.

## Current EFI authority
ASUS2 EFI now contains D97DI `OCLPMetalCompat.kext` 0.0.6:
- executable SHA256 `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- expected Mach-O UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- functional mode must remain LATENT because `-ocmcd97bv` is absent.

## CURRENT ACTION — D97DK latent runtime proof
One manual VESA diagnostic reboot may be authorized only after this checkpoint is persisted.

The boot must use the same unchanged active OpenCore EFI:
- retain `-igfxvesa -ocmcdiag`;
- keep `-ocmcd97bv` absent;
- no Root Patch;
- no config/EFI changes.

After desktop returns, collect D97DI runtime evidence proving:
- exact D97DI 0.0.6 loaded, UUID `7E86D62E-6F0D-3C49-9BE6-A97D45D88F06`;
- route PASS and callback exact-build PASS;
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- `D97DISiteWriteCount=0`;
- `D97DICaveWriteCount=0`;
- no mutation/postimage PASS claim caused by functional execution;
- boot args still exclude `-ocmcd97bv`.

Functional `-ocmcd97bv` activation, Root Patch and accelerated boot remain unauthorized pending D97DK audit.