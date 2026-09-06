# OCLP7 CHECKPOINT — 2026-09-06 — D97CY compile/audit PASS; deploy ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CX_BUILD_GATE_NEGATIVE_D97CY_READY.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; `-igfxvesa` and `-ocmcdiag` retained.
- No active Root Patch.
- Active EFI config SHA256 `cc2ac81ad11e82f8c7928d70aa6ff659efcf7d2d19ab3243869552e6da24f88f`.
- Lilu `1.7.3` at Kernel/Add index 0.
- OCLPMetalCompat unique Kernel/Add index 2.
- Active EFI currently contains D97CT 0.0.2 executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.
- D97CX proved the persistent IORegistry channel and proved the early `sysctlbyname("kern.osversion")` exact-build gate implementation NEGATIVE before route evaluation.

## D97CY build-gate repair
D97CY removes the early sysctl build query and uses the kernel-global `osversion[]` symbol directly. The exact build comparison is performed inside the existing Lilu patcher-load callback immediately before `_cs_validate_page` route installation.

D97CY publishes:
- `D97CYBuildGateMethod = kernel-global-osversion-v1`;
- `D97CYObservedBuild = osversion`.

The plugin remains observe-only:
- Apple original `_cs_validate_page` is called first;
- validation-page bytes are not modified;
- site/cave state is recorded atomically;
- asynchronous publisher exposes state through IORegistry;
- no Root Patch or shared-cache/system mutation is performed.

## D97CY v2 source / compile
Authorized source:
- `OCLP7_D97CY_kern_start_v2.cpp`;
- SHA256 `1fb91340c3fbfe4fab6dfffcad8df96c3576c39f4b3b23f46894c24e45b4884f`.

The first D97CY source revision included `libkern/version.h` and failed compile because that header redeclared `version_major/version_minor` with C linkage while Lilu `kern_util.hpp` already declares them with C++ linkage. This was a tooling/source integration failure only.

D97CY v2 removes the full header and declares only:
`extern "C" char osversion[];`

Returned build ZIP:
- `OCLP7_D97CY_IMAC_BUILD_20260906_195136.zip`;
- bytes `53587`;
- SHA256 `ce9f364ce05f41d189d812aae869bf1037e08b61036b50dd58f94aec20227084`.

Build host:
- macOS `26.6.2 / 25G83`;
- Intel i9-9900K;
- Xcode `26.5 / 17F42`;
- Apple clang `21.0.0`.

Pinned Lilu `1.7.3` build: PASS.
D97CY plugin build: PASS.
Build errors: 0.
Warnings: 6, non-functional build-system/toolchain warnings.

## Compiled D97CY 0.0.3 identity
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.3`;
- thin x86_64 KEXTBUNDLE;
- UUID `92D3F51C-CBE0-3250-99F8-F2150C95C193`;
- executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- built Info.plist SHA256 `0c175c6c83c0d086e14da8be22e6233efdf2e95b1eb6e862294841d53c53954d`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature.

Returned ZIP manifest mismatches: 0.
Both xcodebuild stages report `BUILD SUCCEEDED`; `BUILD FAILED` count 0; build errors 0.

## Independent binary audit
Required persistent observation strings are present, including:
- `D97CTRouteStatus`;
- `D97CTSiteSeenCount` / `D97CTSitePreimage`;
- `D97CTCaveSeenCount` / `D97CTCaveWindow18` / `D97CTCaveFull208`;
- `D97CYBuildGateMethod`;
- `D97CYObservedBuild`;
- `kernel-global-osversion-v1`;
- target `25G82`;
- main `/dyld_shared_cache_x86_64h` suffix;
- `-ocmcdiag`.

Forbidden/write-path audit:
- `sysctlbyname` absent;
- `vm_map_write_user` absent;
- `orgVmMapWriteUser` absent;
- `findAndReplace` absent;
- `vmProtect` absent;
- `injectPayload` absent;
- `injectSegment` absent;
- `const_cast` absent.

D97BV byte audit:
- original 13-byte preimage occurs once as comparison data;
- site replacement occurs 0 times;
- cave replacement occurs 0 times.

Classifications:
- `D97CY_LOCAL_COMPILE=PASS`;
- `D97CY_MANIFEST_AUDIT=PASS`;
- `D97CY_SOURCE_IDENTITY=PASS`;
- `D97CY_COMPILED_OBSERVE_ONLY_NO_FUNCTIONAL_PAGE_MUTATION=PASS`;
- `D97CY_EXACT_BUILD_GATE_RUNTIME=UNTESTED`;
- `D97CY_CS_VALIDATE_PAGE_ROUTE_RUNTIME=UNTESTED`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## Audited deploy artifact
Prepared audited package:
- `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip`;
- SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`;
- manifest SHA256 `5a6c0f1c8546ecf32efff8b6b814a184aefe63e1838df0a747cc01d57c575768`;
- executable remains exact SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.

Prepared ASUS2 controlled replacement script:
- `OCLP7_D97CZ_D97CY_EFI_REPLACE.sh`;
- SHA256 `fc58e52ff5a7859d42a0b1cccbf581ef2d545d398298ac075e0d29aae7e95214`;
- `bash -n` PASS.

D97CZ is pinned to the current config SHA, current D97CT executable SHA, new D97CY executable SHA, package SHA, Lilu 1.7.3 and OCLPMetalCompat unique index 2. It modifies only `EFI/OC/Kexts/OCLPMetalCompat.kext`, backs up D97CT, and leaves `config.plist` unchanged.

## CURRENT ACTION
On ASUS2 only:
1. mount the active EFI;
2. place `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip` and `OCLP7_D97CZ_D97CY_EFI_REPLACE.sh` in `~/Downloads`;
3. run D97CZ once;
4. return the Desktop D97CZ report to ChatGPT;
5. do **not** reboot until that report is audited.

No Root Patch, accelerated boot, or functional D97BV shared-cache mutation is authorized.