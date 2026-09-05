# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BH_TAHOE_25G82_METALLIB_LOCAL_PRESENT_OFFICIAL_MANIFEST_MISSES_26X_FORCE_LOCAL_FALLBACK.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

## Mandatory startup
Before proposing a technical modification in any future OCLP continuation, read the permanent database, permanent working rules, this MASTER, the VESA rule, and the current checkpoint linked above.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.

Golden/reference app remains immutable.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`.

## Proven user reference app
`/Users/alex/Desktop/OpenCore-Patcher.app` is proven official b9df76-source-lineage OCLP 2.5.0, universal `x86_64 arm64`, valid Dortania Developer ID signature.

Reference executable SHA256:
`0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`.

Reference Info.plist SHA256:
`6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`.

Preserve this app unchanged.

## Tahoe host gate and Haswell scope
Exact b9df76 has `_max_os = os_data.sequoia.value`, so Tahoe normally sets `Validation: Unsupported Host OS`.
Exact b9df76 also has built-in developer bypass via `~/.dortania_developer`.

Historical Tahoe patchset/native-OS blocker from the earlier custom/Tahoe-aware source does not apply to b9df76 Haswell:
- Haswell is included in `_hardware_variants`;
- `IntelHaswell.native_os()` is `xnu < Ventura`, therefore False on Darwin 25;
- Haswell patch composition remains `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific`;
- `LegacyMetal3802` has no Tahoe maximum.

For normal patch detection on ASUS2, non-present other legacy GPU classes are skipped before their developer-mode patch branches execute; Haswell itself does not consult developer mode. Thus the developer marker is target-specific semantically equivalent to bypassing the host-OS gate for ASUS2 Haswell.

## Why the inner signed app must remain unchanged
OCLP 2.5.0 root commands use `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`.
The release helper validates Team ID and signing certificates of the calling OCLP executable against Dortania (`S74BDJXQMD`).
A locally rebuilt/ad-hoc-signed main OCLP app would therefore fail helper authorization unless a debug/custom helper were installed, introducing an unnecessary extra behavior/security change.

## D97BG Tahoe-ready wrapper — PASS
On accelerated Sequoia, the user successfully produced:
`/Users/alex/Desktop/OpenCore-Patcher-Tahoe.app`

Transport ZIP:
`/Users/alex/Desktop/OpenCore-Patcher-Tahoe.zip`

Transport identity:
- bytes `738378441`;
- SHA256 `3c63c2d4c90039c12f025f27aba47ab279b0e075535b37399521d6b3e016308b`.

Embedded inner Golden OCLP remained exact:
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- Dortania codesign PASS.

Official privileged helper:
- TeamIdentifier `S74BDJXQMD`;
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- codesign PASS.

Final audit classifications:
- `INNER_GOLDEN_IDENTITY=PASS`;
- `INNER_DORTANIA_CODESIGN=PASS`;
- `PRIVILEGED_HELPER_IDENTITY=PASS`;
- `TAHOE_COMPATIBILITY_EMBEDDED=PASS`.

The outer wrapper automatically creates the built-in developer marker immediately before launching the exact signed inner OCLP, waits for it to exit, and removes only the marker it created. The user performs no separate compatibility step.

Classification:
`D97BG_TAHOE_READY_WRAPPER_BUILD_AUDIT=PASS`.

No Root Patch ran during construction.
No reboot ran during construction.

## D97BH Tahoe MetallibSupportPkg blocker — cause proven
User is now booted in Tahoe 26.6.2 / 25G82 in VESA, performed Root Patch Restore, and attempted a new Root Patch with D97BG. OCLP reports MetallibSupportPkg missing and attempts network retrieval.

Exact target package exists in Pyquick release tag `26.6.2-25G82`:
- asset `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact b9df76 local root is:
`/Library/Application Support/Dortania/MetallibSupportPkg`.

Current official Dortania manifest has no Tahoe 26.x / 25G82 entry. In b9df76, a successful remote-manifest fetch with no 26.x match prevents the useful local loose-version fallback. If the manifest fetch fails, b9df76 falls back to local `26.6` matching and accepts a folder named `26.6.2-25G82` under the Dortania root.

Classifications:
- `B9DF76_25G82_METALLIB_REMOTE_MANIFEST_PATH=BLOCKED_BY_NO_26X_ENTRY`;
- `B9DF76_25G82_METALLIB_LOCAL_FALLBACK_IF_MANIFEST_UNREACHABLE=PROVEN_BY_SOURCE`.

Historical Tahoe-aware OCLP-T2 work had explicitly patched the handler to prefer the exact local host-build package before API fallback, corroborating this same ordering problem.

## Current responsibility boundary
Assistant-side Tahoe compatibility preparation remains complete.
User performs only inherently target-local actions and manual Root Patch.
Never ask user to edit the signed inner OCLP or rebuild it for this blocker.

## Current execution contract
GitHub compilation remains suspended until user explicitly says quota reset/unblocked.
Never auto Root Patch. Never auto reboot.
Golden remains immutable/read-only.

## CURRENT ACTION
1. Ensure exact local tree exists at `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.
2. Temporarily make only `dortania.github.io` unreachable while leaving other internet access intact, forcing b9df76 into its built-in local fallback.
3. Fully quit and relaunch `OpenCore-Patcher-Tahoe.app`.
4. Confirm MetallibSupportPkg missing state clears / local `26.6.2-25G82` is accepted.
5. User runs manual Root Patch and returns complete output.
6. Remove the temporary `dortania.github.io` host override after Root Patch completes.

No reboot is authorized by this MASTER state.