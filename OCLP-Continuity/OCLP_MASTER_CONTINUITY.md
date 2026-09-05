# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BI_METALLIB_25G82_PASS_NEXT_BLOCKER_METAL_FRAMEWORK_13_2_1_25_TO_24_SHADOW_ALIAS.md`
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

## D97BH MetallibSupportPkg — runtime PASS
Exact Pyquick package for target:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact b9df76 local root:
`/Library/Application Support/Dortania/MetallibSupportPkg`.

Because official Dortania manifest has no Tahoe 26.x entry, `dortania.github.io` was temporarily made unreachable. Runtime Root Patcher output then proved:
- manifest fetch failed as intended;
- local fallback checked `26.6`;
- exact local `26.6.2-25G82` was found;
- `Patcher is capable of patching`.

Classification:
`D97BH_25G82_LOCAL_METALLIB_FALLBACK_RUNTIME=PASS`.

## D97BI next blocker — Metal.framework donor path PROVEN
After Metallib PASS, Root Patcher mounted `Universal-Binaries.dmg`, entered preflight, and failed because exact b9df76 requests:
`Universal-Binaries/13.2.1-25/System/Library/Frameworks/Metal.framework`.

Exact b9df76 `metal_3802.py` constructs:
`"Metal.framework": f"13.2.1-{self._xnu_major}"`, so Darwin 25 requests `13.2.1-25`.

Historical Tahoe project work already identified that `13.2.1-25` does not exist and redirected Tahoe to existing `13.2.1-24`.

Exact b9df76 mounts `Universal-Binaries.dmg` using `hdiutil ... -shadow`, so the temporary mounted workspace is writable without modifying the signed app or embedded DMG.

Classifications:
- `B9DF76_TAHOE_25_METAL_FRAMEWORK_SOURCE_13_2_1_25=PROVEN_MISSING`;
- `TAHOE_25_METAL_FRAMEWORK_DONOR_13_2_1_24=HISTORICALLY_IDENTIFIED_REQUIRED_REDIRECT`.

## Current responsibility boundary
Assistant-side application compatibility preparation remains complete. User performs only inherently target-local actions and manual Root Patch. Never modify the signed inner OCLP for this blocker.

## Current execution contract
GitHub compilation remains suspended until user explicitly says quota reset/unblocked.
Never auto Root Patch. Never auto reboot.
Golden remains immutable/read-only.

## CURRENT ACTION
While the same Tahoe OCLP session still has the writable shadow-mounted Universal-Binaries workspace:
1. locate the temporary `payloads/Universal-Binaries` root;
2. prove `13.2.1-24/System/Library/Frameworks/Metal.framework` exists;
3. create workspace-only symlink `13.2.1-25 -> 13.2.1-24`;
4. verify the exact previously missing `13.2.1-25/.../Metal.framework` resolves;
5. rerun manual Root Patch in the same OCLP session;
6. return complete Root Patch output.

Do not reboot yet. Keep the temporary `dortania.github.io` override until Root Patch finishes.