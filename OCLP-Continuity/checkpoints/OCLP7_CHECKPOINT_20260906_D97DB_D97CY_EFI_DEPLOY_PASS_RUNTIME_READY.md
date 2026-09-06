# OCLP7 CHECKPOINT — 2026-09-06 — D97DB D97CY EFI deploy PASS; VESA runtime ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DA_EFI_REAUDIT_PASS_D97DB_REPINNED.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; `-igfxvesa` and `-ocmcdiag` retained.
- No active Root Patch.
- D97DA current EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- Lilu `1.7.3` at Kernel/Add index 0.
- AMFIPass `1.4.1` at index 4.
- OCLPMetalCompat unique entry at index 5, Darwin 25 only.
- Pre-deploy OCLPMetalCompat was exact D97CT 0.0.2 executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.

## D97CY audited artifact
- Package: `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip`.
- Package SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`.
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`.
- Version `0.0.3`.
- UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`.
- Executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.
- Lilu dependency `1.7.3`.
- Observe-only; no functional D97BV replacement bytes and no validation-page write/injection path.

## D97DB returned report
Returned report: `OCLP7_D97DB_D97CY_EFI_REPLACE_20260906_201309.txt`.
- bytes `2942`.
- SHA256 `2cd9ead11a26cde82459b124284c42e4ada312de8011ff01d0bf22ac1828111d`.

Identity gates all passed:
- config expected/actual SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- OCLPMetalCompat unique index `5`;
- Lilu index `0`, version `1.7.3`;
- boot args include `-igfxvesa` and `-ocmcdiag`;
- current D97CT executable expected/actual SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- audited package expected/actual SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`;
- new executable expected/actual SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- staged executable SHA matched exactly.

Replacement result:
- backup created at `/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CT-20260906_201309.bak`;
- backup executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- final OCLPMetalCompat version `0.0.3`;
- final executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- final bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- final config SHA256 unchanged `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- plist validation PASS.

Final report classification: `D97DB_STATUS=PASS`.

## Safety classification
- `D97DB_D97CY_IDENTITY_PINNED_EFI_DEPLOY=PASS`.
- `D97DB_CONFIG_MUTATION=NO`.
- `D97DB_ROOT_PATCH=NO`.
- `D97DB_REBOOT_PERFORMED=NO`.
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## CURRENT ACTION
One manual **VESA diagnostic reboot** is authorized with D97CY 0.0.3 already deployed.

For that boot:
1. make no further EFI changes;
2. do not Root Patch;
3. preserve `-igfxvesa` and `-ocmcdiag`;
4. reboot normally through the same active OpenCore EFI;
5. after desktop returns, collect D97CY runtime identity and persistent IORegistry state, including:
   - D97CY observed build / build-gate method;
   - D97CTBootArgGate, KernelGate, BuildGate, CpuGate;
   - D97CTRouteStatus;
   - site/cave counts and preimage/zero-window checks;
   - Apple validated/tainted/nx values when pages are observed.

This remains an observe-only VESA boot. No Root Patch, accelerated boot, or functional D97BV shared-cache mutation is authorized.
