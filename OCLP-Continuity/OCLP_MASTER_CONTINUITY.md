# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BG_TARGET_SPECIFIC_DEVELOPER_MARKER_EQUIVALENT_NO_BUILD_REQUIRED.md`
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
Preserve this app unchanged.

## Tahoe host gate and historical second blocker
Exact b9df76 has `_max_os = os_data.sequoia.value`, so Tahoe normally sets `Validation: Unsupported Host OS`.
Exact b9df76 also has built-in developer bypass via `~/.dortania_developer`.

Historical Tahoe patchset/native-OS blocker from the earlier custom/Tahoe-aware source does not apply to b9df76 Haswell:
- Haswell is included in `_hardware_variants`;
- `IntelHaswell.native_os()` is `xnu < Ventura`, therefore False on Darwin 25;
- Haswell patch composition remains `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific`;
- `LegacyMetal3802` has no Tahoe maximum.

## Target-specific developer-marker proof
Developer mode is broader in the abstract, but exact reachability on ASUS2 makes it equivalent to the desired host-gate bypass for this target:
- `HardwarePatchsetDetection` skips hardware classes whose `present()` is false before executing their patch logic;
- ASUS2 target graphics are Haswell;
- `IntelHaswell` does not consult `_dortania_internal_check()`;
- other developer-mode branches are in non-present GPU families such as Iron Lake, Sandy Bridge, Nvidia Tesla/WebDriver, AMD TeraScale and AMD Navi;
- comparison `b9df76...af9b49` proves patchset files are unchanged between exact Golden and the code-search reference (only `CHANGELOG.md` and `constants.py` differ).

Classification:
`D97BG_DORTANIA_DEVELOPER_MARKER_ON_ASUS2_HASWELL=TARGET_SPECIFIC_SEMANTIC_EQUIVALENT_TO_HOST_OS_GATE_BYPASS`.

## Why no rebuild
OCLP's privileged helper verifies that the main application is signed by Dortania before executing root commands. A locally rebuilt/ad-hoc app would require a debug helper or a replacement Developer ID, introducing an unnecessary extra change.

Therefore:
- no GitHub build required;
- no local build required;
- no app repack/re-sign required;
- use the original officially signed b9df76 app unchanged.

## User-confirmed dependency
MetallibSupportPkg is already present/usable in Tahoe.

## Latest local execution
D97BG preparation script verified source executable SHA, Info.plist SHA and deep/strict codesign PASS, then aborted during Tahoe-volume discovery before any target mutation.
No app copy, no marker, no Root Patch, no reboot occurred in that attempt.

## Current user/assistant responsibility
User explicitly stated they will:
1. copy the app into Tahoe themselves;
2. perform the Root Patch manually themselves;
3. return after Root Patch so comparison work can begin.

Assistant does not need to perform or script the copy.

## CURRENT ACTION
On Tahoe, user should preserve the app unchanged, create `~/.dortania_developer`, verify the executable SHA/codesign if desired, open OCLP, and perform the Root Patch manually.
After Root Patch completes, user returns the complete Root Patch output before accelerated-boot comparison.

No automatic reboot is authorized. Accelerated-boot/VESA evidence rules remain in force for the comparison phase.
