# OCLP7 CHECKPOINT — 2026-09-08 — OCLP 2.5.0 / Nightly review

## Trigger
While paused after successful D97GS Revert Root Patch and before post-reboot clean/native audit, ASUS2 notified the user that a new official OpenCore Legacy Patcher release was available. User also downloaded the latest Nightly and requested a source-level review before continuing.

## Upstream identities at review time
- Official latest release: OpenCore Legacy Patcher 2.5.0.
- Published: 2026-09-08 05:35:54Z.
- 2.5.0 tag commit: `af9b49ac0539c684590ac35c7d695c7e706f6aea`.
- `main` HEAD at review time: exactly the same commit `af9b49ac0539c684590ac35c7d695c7e706f6aea`.

Therefore the current latest Nightly contains no source commit newer than the official 2.5.0 release.

## 2.5.0 functional changelog
- Disable repatching a dirty root volume, requiring unpatch first.
- Slimmed Modern Wireless patchset for Sequoia.
- Move JavaScriptCore pre-AVX patch to RestrictEvents.
- CoreImage reported-version crash fix.
- OpenCorePkg 1.0.4, Lilu 1.7.1, RestrictEvents 1.1.7, PatcherSupportPkg 1.9.7.

## Comparison against our pinned upstream base
Project upstream base remains:
`b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

GitHub comparison `b9df76... -> 2.5.0` shows only two commits and only two changed files:
- `CHANGELOG.md`;
- `opencore_legacy_patcher/constants.py`.

No functional source changes exist between our pinned base and official 2.5.0 in:
- `sys_patch.py`;
- `patchsets/detect.py`;
- `shared_patches/metal_3802.py`;
- Haswell patchsets;
- MTLCompiler/GPUCompiler patch logic;
- kernel-cache/root-patch machinery.

Thus the functional 2.5.0 code, including the dirty-root/repatch guard and CoreImage patch logic, was already present in our pinned `b9df76` base.

## Exact constants difference
Pinned `b9df76` already declares:
- patcher version 2.5.0;
- OpenCorePkg 1.0.4;
- Lilu 1.7.1;
- RestrictEvents 1.1.7;
- PatcherSupportPkg 1.9.6.

Official 2.5.0 changes only:
- PatcherSupportPkg `1.9.6 -> 1.9.7`;
- copyright year `2025 -> 2026`.

## PatcherSupportPkg 1.9.7 delta
Compared with 1.9.6, PatcherSupportPkg 1.9.7 changes only:
- four IO80211 binaries;
- one CoreImage binary: `Universal-Binaries/14.0 Beta 3-24/System/Library/Frameworks/CoreImage.framework/Versions/A/CoreImage`.

Release notes:
- patch `LC_ID_DYLIB` on CoreImage wrapper;
- disable JavaScriptCore patch in IO80211 shim.

No MTLCompiler, GPUCompiler, Haswell kext, Metal framework, or compiler backend binary changes exist in 1.9.7.

## Relevance to current measured frontier
Current project frontier is the serialized-bitcode P3 boundary in MTLCompiler 32023 after P1 runtime semantic progress:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> LLVM metadata/StringMap crash`.

PatcherSupportPkg 1.9.7 does not alter any component on that measured path. The CoreImage wrapper fix may be useful later only if a CoreImage loader/version issue becomes a measured frontier.

## Official Tahoe support status
Official OCLP 2.5.0 source still sets normal supported host OS maximum to Sequoia in `patchsets/detect.py`; Tahoe remains outside normal official patch validation unless Dortania internal/developer override logic is used. Our project therefore still requires the Tahoe-specific custom source policy and exact D97DX/D97GS/D97HI lineage.

## Nightly safety
Upstream SOURCE.md explicitly warns that Nightly builds are untested, not guaranteed safe, and should not be used without a specific reason. Since current `main == 2.5.0`, the Nightly offers no source-level benefit anyway.

## Decision
`INSTALL_OFFICIAL_OCLP_250_ON_ASUS2=NO`
`INSTALL_CURRENT_NIGHTLY_ON_ASUS2=NO`
`KEEP_D97GS_D97HO_PINNED_PROJECT_CHAIN=YES`

Do not allow official OCLP 2.5.0 or Nightly to replace the project app/helper/assets on ASUS2 during this experiment; doing so would introduce an unnecessary provenance/asset variable with no measured compiler-frontier benefit.

The downloaded official/Nightly packages may be retained offline for later comparison or use on unrelated Macs.

Potential later isolated branch:
- compare/import only PatcherSupportPkg 1.9.7 CoreImage wrapper if a measured CoreImage-specific failure appears after P3.
- never fold it into the current P3 experiment preemptively.

## Current action resumes unchanged
After the already-successful D97GS Revert Root Patch:
1. reboot ASUS2 in VESA with D97EZ inert;
2. run D97HR clean/native audit;
3. only after D97HR PASS run exact D97HO Root Patch;
4. pre-reboot audit P1+P3/system/AuxKC;
5. then reboot VESA and audit active snapshot before acceleration.

No EFI/NVRAM/framebuffer changes. P2b/AIR00/D34 remain unauthorized.
