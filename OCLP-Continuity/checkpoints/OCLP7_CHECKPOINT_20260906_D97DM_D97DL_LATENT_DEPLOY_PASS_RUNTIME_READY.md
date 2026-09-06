# OCLP7 CHECKPOINT — 2026-09-06 — D97DM D97DL LATENT deploy PASS; runtime ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DL_BUILD_BINARY_AUDIT_PASS_LATENT_DEPLOY_READY.md` for current execution.

## Entering authority
ASUS2: Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, unpatched VESA, no Root Patch.
Active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
Boot args contain `-igfxvesa -ocmcdiag` and do NOT contain `-ocmcd97bv`.

## Returned D97DM report
`OCLP7_D97DM_D97DL_LATENT_EFI_REPLACE_20260906_233117.txt`
- bytes `3361`;
- SHA256 `dba4b4aba53e4c183fa4fabf013f77db6f13dc86987b289d4a9f6480a6ef3fb5`.

## Pre-deploy gates
- config expected/actual SHA exact PASS;
- `plutil` PASS;
- OCLPMetalCompat entry unique at Kernel/Add index 5;
- boot args retain `-igfxvesa -ocmcdiag`;
- `-ocmcd97bv` absent PASS;
- Lilu index 0, version 1.7.3;
- current D97DI executable exact SHA `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`, version 0.0.6.

## Audited D97DL package gates
- package SHA exact `8e84e98d244ec02570f65b569c7da533c93a6ae01ed32d26a84872d0292c04c2`;
- source SHA exact `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- executable SHA exact `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- bundle ID exact `com.oclpmetalcompat.OCLPMetalCompat`;
- version 0.0.7;
- Lilu dependency 1.7.3;
- audited latent gate PASS.

## Replacement result
- staged executable SHA exact PASS;
- D97DI backup created at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97DI-20260906_233117.bak`;
- backup executable SHA exact `0f5a94f72ae0317786ea893cf036d3f6f9c1e537747ad82d7fe9cfb98ba45cd4`;
- final active D97DL executable SHA `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- final version 0.0.7;
- final bundle ID exact;
- final config SHA unchanged `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- final boot args unchanged and `-ocmcd97bv` absent;
- post-replace latent gate PASS;
- no Root Patch, no reboot, no functional mutation.

Authoritative classifications:
- `D97DM_D97DL_IDENTITY_PINNED_EFI_REPLACE=PASS`;
- `D97DM_D97DL_LATENT_DEPLOY=PASS`;
- `D97DM_CONFIG_PRESERVED_BYTE_IDENTICAL=PASS`;
- `D97DM_FUNCTIONAL_BOOTARG_PRESENT=NO`;
- `D97DM_D97BV_FUNCTIONAL_MUTATION=NO`.

## CURRENT ACTION — D97DN latent runtime proof
One unchanged VESA reboot is authorized to prove D97DL 0.0.7 runtime identity and LATENT behavior before any functional arming.

D97DN success criteria:
- exact D97DL 0.0.7 UUID `45EAD92D-43BF-3F42-B37B-EB5007345000` loaded;
- route PASS;
- exact callback build 25G82 PASS;
- `D97DIFunctionalMode=LATENT`;
- `D97DIFunctionalRequested=0`;
- SITE and CAVE write counts remain 0;
- `D97DLSiteCavePrereq` property is present (expected PENDING in LATENT mode unless functional code path is entered);
- boot args still exclude `-ocmcd97bv`.

Still NOT authorized:
- adding `-ocmcd97bv`;
- functional D97BV activation;
- Root Patch;
- accelerated boot.
