# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BG_B9DF76_BUILTIN_DEVELOPER_BYPASS_ELIMINATES_APP_PATCH_HASWELL_ALREADY_VALID.md`
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
6. consult the retrospective and history index to validate strategic/history context when needed.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.

Golden/reference app remains immutable.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`.

## Tahoe host-eligibility result
Exact b9df76 `detect.py` has `_max_os = os_data.sequoia.value`, but the same function first checks built-in Dortania developer mode. Exact developer check is:
```python
return Path("~/.dortania_developer").expanduser().exists()
```
If present, unsupported-host validation returns False before the Sequoia maximum test.

Classification:
`B9DF76_TAHOE_UNSUPPORTED_HOST_GATE_CAN_BE_BYPASSED_WITH_BUILTIN_DORTANIA_DEVELOPER_MARKER=PROVEN`.

Engineering consequence: do not patch/repack/re-sign the proven signed app. Use the built-in marker in the Tahoe user's home instead.

## Haswell second-gate result
The historical Tahoe patchset/native_os blocker from a different custom/Tahoe-aware source does not apply to exact b9df76.
- Haswell is included in `_hardware_variants`;
- `native_os()` is `xnu < Ventura`, therefore False on Darwin 25;
- Haswell patch composition proceeds to LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific patches;
- LegacyMetal3802 has no Tahoe maximum.

Classification:
`B9DF76_HASWELL_PATCHSET_SECOND_GATE_CHANGE_REQUIRED=NO`.

## User-confirmed Tahoe dependency
User confirms MetallibSupportPkg is already present/usable in Tahoe. Treat it as not currently blocking preparation.

## Proven user app
`/Users/alex/Desktop/OpenCore-Patcher.app` is proven official b9df76-source-lineage OCLP 2.5.0, universal x86_64+arm64, valid Developer ID signature.
Preserve it unchanged.

## Current execution contract
GitHub compilation remains suspended until user explicitly says quota reset/unblocked.
Local compilation is unnecessary for the current route.
Never auto Root Patch. Never auto reboot.

## CURRENT ACTION — prepare Tahoe from accelerated Sequoia without modifying app
1. identify mounted Tahoe Data volume for build `25G82`;
2. copy the proven signed OCLP app unchanged into Tahoe Applications, preserving any existing app;
3. create `.dortania_developer` only in the Tahoe user home;
4. verify copied app SHA/codesign and marker;
5. boot Tahoe manually only after explicit authorization;
6. open OCLP and inspect detected root-patch list/validation state;
7. STOP before Root Patch and audit the complete output.

No Root Patch is authorized by this MASTER state.
No reboot is authorized by this MASTER state.
