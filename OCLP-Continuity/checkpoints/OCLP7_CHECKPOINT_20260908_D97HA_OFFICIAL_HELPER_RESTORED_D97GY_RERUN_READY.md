# OCLP7 CHECKPOINT — D97HA official helper restored; D97GY rerun ready

Date: 2026-09-08 EEST

## Entering state
Post-Restore D97GY had already proven:
- Tahoe 26.6.2 / 25G82 x86_64;
- VESA active, D97EZ inert;
- native Tahoe MTLCompilerService restored exact SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- native CoreDisplay metallib restored exact `24128` bytes / SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1` / MTLB;
- Haswell AuxKC Data kexts removed and not loaded;
- corrected local MetallibSupportPkg source survived exact: 180 metallibs, CoreDisplay `20739` / `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, zero bad magic.

D97GY then stopped at official-helper verification. Manual inspection proved the active system helper was the exact D97DX DEBUG helper:
- SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- ad-hoc signature;
- TeamIdentifier not set.

Thus APFS Restore was structurally clean, but wrapper helper restoration was incomplete. D97GS remained blocked pending helper closure.

## D97GZ locator
D97GZ read-only locator proved the exact D97DX/D97GS launcher uses a temporary `/tmp/d97dx-official-helper.XXXXXX` backup and removes it at cleanup. The temporary backup was no longer present.

Two persistent exact official helper sources were found. Chosen source:
`/Library/Application Support/Dortania/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`

Exact official identity:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`.

## D97HA execution — PASS
D97HA restored only the privileged helper.

Precheck:
- active DEBUG helper SHA exact `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- DEBUG helper codesign verify PASS.

Official source:
- SHA exact `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`;
- codesign verify PASS.

Backup:
- DEBUG helper saved to `/Users/alex/Desktop/OCLP7_D97HA_DEBUG_HELPER_BACKUP_20260908_025708`;
- backup SHA exact `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`.

Staged official helper:
- SHA exact official;
- Team exact official;
- codesign PASS.

Final active helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`;
- stat `root:wheel -rwsr-xr-x 136816`;
- codesign verify PASS.

Classification:
`D97HA_OFFICIAL_HELPER_RESTORED=PASS`
`D97HA_ONLY_MUTATION=PRIVILEGED_HELPER_RESTORE`
`D97HA_REBOOT=NO`.

## Current action
Rerun the already-audited read-only D97GY gate without reboot or any other mutation.

Required final D97GY closure:
- `D97GY_OFFICIAL_HELPER=PASS`;
- `D97GY_NATIVE_BASELINE=PASS`;
- `D97GY_RESTORE_REBOOT=STRUCTURAL_SEMANTIC_PASS`;
- `D97GY_D97GS_ROOTPATCH_BASE=READY`;
- `D97GY_STATUS=PASS_READONLY_POST_RESTORE_GATE`.

Only after this full D97GY PASS may D97GS P1-only Root Patch be re-authorized on the clean restored baseline.