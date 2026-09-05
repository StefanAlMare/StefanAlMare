# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BG_TAHOE_READY_WRAPPER_BUILT_AUDIT_PASS_USER_COPY_ROOTPATCH_NEXT.md`
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

## User-confirmed dependency
MetallibSupportPkg is already present/usable in Tahoe.

## Current responsibility boundary
Assistant-side Tahoe compatibility preparation is complete.

User will now only:
1. copy `OpenCore-Patcher-Tahoe.app` (or the identity-pinned ZIP) into Tahoe;
2. launch the Tahoe-ready wrapper;
3. perform Root Patch manually;
4. return the complete Root Patch result/output.

The user is not to be asked to manually edit detect.py, create `.dortania_developer`, patch source, rebuild OCLP, or perform a separate compatibility step.

## Current execution contract
GitHub compilation remains suspended until user explicitly says quota reset/unblocked.
Never auto Root Patch. Never auto reboot.
Golden remains immutable/read-only.

## CURRENT ACTION
**User copy + manual Root Patch in Tahoe with the D97BG Tahoe-ready wrapper.**

Persist the Root Patch result immediately when returned. Then proceed under the permanent accelerated-boot/VESA evidence rule before any comparison conclusions.
