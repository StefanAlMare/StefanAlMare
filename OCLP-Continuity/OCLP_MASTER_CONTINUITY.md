# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BG_DEVELOPER_MARKER_REJECTED_TOO_BROAD_LOCAL_SEQUOIA_EXACT_BUILD_AUTHORIZED.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

## Mandatory startup for every OCLP12/OCLP13/OCLP14/OCLP15+ continuation
Before proposing a technical modification:
1. read `OCLP_PERMANENT_PROJECT_DATABASE.md` in full;
2. read `OCLP_PERMANENT_WORKING_RULES.md` in full;
3. read this MASTER in full;
4. read `OCLP_PERMANENT_VESA_RECOVERY_RULE.md` in full;
5. read the exact current checkpoint named above in full;
6. consult retrospective/history when needed.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.

Golden/reference app remains immutable.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`.

## Tahoe static host-eligibility result
Exact b9df76 `detect.py` uses `_max_os = os_data.sequoia.value` while `os_data.py` already defines `tahoe = 25`.

Exact static comparator delta:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

This is the sole currently demonstrated Tahoe-specific static source gate before Haswell patchset generation in exact b9df76.

## Historical second Tahoe blocker reconciliation
The user correctly recalled a second patchset/native-OS blocker from an earlier Tahoe-aware/custom source.
Exact Golden b9df76 does not contain that blocker for Haswell:
- Haswell is included in `_hardware_variants`;
- `IntelHaswell.native_os()` is `xnu < Ventura`, therefore False on Darwin 25;
- Haswell proceeds to `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific`;
- `LegacyMetal3802._os_requires_patches()` is `xnu >= Ventura`, with no Tahoe maximum.

Classification:
`HISTORICAL_TAHOE_PATCHSET_NATIVE_OS_BLOCKER_APPLIES_TO_B9DF76=NO`.

## Developer marker correction
Exact b9df76 has a built-in developer bypass via `~/.dortania_developer`, but the same developer-mode predicate is used by other patch classes to alter patch composition.
Therefore the marker is broader than the desired one-line host-eligibility change and is rejected for the controlled comparator.

Classification:
`D97BG_DORTANIA_DEVELOPER_MARKER_AS_MINIMAL_COMPARATOR=REJECTED_OVERBROAD`.

## Proven user app
`/Users/alex/Desktop/OpenCore-Patcher.app` is proven official b9df76-source-lineage OCLP 2.5.0, universal x86_64+arm64, valid Developer ID signature.
Preserve it unchanged as reference.

## Latest local execution result
The D97BG preparation script verified source executable SHA, Info.plist SHA and deep/strict codesign PASS, then aborted during Tahoe-volume discovery before any mutation because the discovery Python exited nonzero under `set -e` while diagnostics were redirected.

No app was copied to Tahoe.
No developer marker was created.
No Root Patch ran.
No reboot ran.

Classification:
`D97BG_FIRST_PREP_ATTEMPT=SOURCE_IDENTITY_PASS_DISCOVERY_SCRIPT_TOOLING_ABORT_PRE_MUTATION`.

## User-confirmed Tahoe dependency
MetallibSupportPkg is already present/usable in Tahoe and is not currently treated as a blocker.

## Current execution contract
GitHub compilation remains suspended until user explicitly says quota reset/unblocked.
The user explicitly authorized the remaining comparator work to be performed locally in accelerated Sequoia.

Classification:
`LOCAL_SEQUOIA_BUILD_AUTHORIZATION=GRANTED_BY_USER_2026_09_05`.

This authorization covers the local build/compile steps needed for the comparator. It does not authorize Root Patch or reboot.

## CURRENT ACTION — exact local Sequoia comparator build
On accelerated Sequoia:
1. create isolated clean build directory;
2. checkout exact upstream `b9df76...` and verify tree `7c3411...`;
3. apply exactly the one-line `detect.py` Sequoia->Tahoe delta;
4. require one changed file and `1 insertion / 1 deletion`;
5. prove protected source blobs unchanged;
6. reuse exact reference-app `payloads.dmg` and `Universal-Binaries.dmg` where compatible;
7. build with exact upstream PyInstaller spec;
8. verify resulting app architecture, version, hashes and bundle integrity;
9. preserve the proven reference app unchanged;
10. after build audit, copy only the identity-pinned comparator app to Tahoe;
11. STOP before Root Patch.

No Root Patch is authorized by this MASTER state.
No reboot is authorized by this MASTER state.
