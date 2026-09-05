# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BG_USER_REQUIRES_TAHOE_READY_APP_BUILT_IN_SEQUOIA_WRAPPER_ROUTE.md`
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

## Proven user app
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
The release helper validates the Team ID and signing certificates of the parent OCLP executable against Dortania (`S74BDJXQMD`).
A locally rebuilt/ad-hoc-signed main OCLP app would therefore fail helper authorization unless a debug/custom helper were installed, which would introduce an unnecessary additional behavior/security change.

## User responsibility correction
The user explicitly clarified that compatibility preparation is the assistant's job in Sequoia.
The user must receive a Tahoe-ready app and then only:
1. copy that final app into Tahoe;
2. run Root Patch manually;
3. return after Root Patch for comparison work.

The user is not to be asked to manually apply the Tahoe compatibility patch or create the developer marker.

## Selected Tahoe-ready application architecture
Create `~/Desktop/OpenCore-Patcher-Tahoe.app` in Sequoia as a wrapper bundle containing the exact signed `OpenCore-Patcher.app` unchanged.
The wrapper launcher automatically:
- verifies inner executable and Info.plist identity;
- verifies inner Dortania signature;
- verifies/uses the official privileged helper, with optional embedded official-helper fallback asset;
- creates `~/.dortania_developer` immediately before inner OCLP launch;
- launches and waits for the signed inner OCLP;
- removes only the marker it created when OCLP exits.

From the user's perspective this is one Tahoe-ready application: copy, launch, Root Patch. No manual compatibility action remains.

## User-confirmed dependency
MetallibSupportPkg is already present/usable in Tahoe.

## Current execution contract
GitHub compilation remains suspended until user explicitly says quota reset/unblocked.
No OCLP rebuild is needed for the selected wrapper route.
Never auto Root Patch. Never auto reboot.

## CURRENT ACTION
Build and audit `~/Desktop/OpenCore-Patcher-Tahoe.app` in accelerated Sequoia from the proven source app. Optionally produce `OpenCore-Patcher-Tahoe.zip` for transport. Require inner exact hashes and original Dortania codesign PASS before handoff.

No Root Patch or reboot is authorized during this Sequoia preparation step.
