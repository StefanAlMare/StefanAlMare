# OCLP7 CHECKPOINT — 2026-09-05 — Developer marker rejected as overbroad; local Sequoia exact build authorized

Status: **D97BG METHODOLOGY CORRECTION / USER LOCAL-BUILD AUTHORIZATION / NO ROOT PATCH**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BG_B9DF76_BUILTIN_DEVELOPER_BYPASS_ELIMINATES_APP_PATCH_HASWELL_ALREADY_VALID.md`.

## User-local execution result
The user ran the D97BG preparation script from accelerated Sequoia.
Observed:
- proven Desktop source app executable SHA256 PASS: `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- proven Desktop source app Info.plist SHA256 PASS: `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- deep/strict codesign PASS;
- script stopped immediately after `=== 2. DISCOVER TAHOE 25G82 SYSTEM + DATA VOLUME ===` because the discovery Python exited nonzero under `set -e` while its diagnostic stdout had been redirected to a temporary file.

Therefore no target mutation occurred:
- no Tahoe app copy;
- no `.dortania_developer` marker creation;
- no Root Patch;
- no reboot.

Classification:
`D97BG_FIRST_PREP_ATTEMPT=SOURCE_IDENTITY_PASS_DISCOVERY_SCRIPT_TOOLING_ABORT_PRE_MUTATION`.

## Developer marker re-evaluation
Exact `b9df76` `detect.py` does contain a built-in developer bypass via `~/.dortania_developer`, and this bypass can suppress `UNSUPPORTED_HOST_OS`.

However exact b9df76 hardware classes also use `_dortania_internal_check()` for other development-only patch-selection behavior. Example: `intel_iron_lake.py` changes its patch composition based on developer mode and `legacy_accel_support` membership.

Therefore `.dortania_developer` is a **global developer-mode switch**, not a semantically minimal equivalent of only changing:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

For the controlled identical-OCLP comparator, the developer-marker route is rejected.

Classification:
`D97BG_DORTANIA_DEVELOPER_MARKER_AS_MINIMAL_COMPARATOR=REJECTED_OVERBROAD`.

## User authorization for local Sequoia work
The user explicitly instructed that the remaining OCLP work should be performed locally in accelerated Sequoia because it is easier/faster there.

This is explicit authorization for the required local build/compile steps for this D97BF/D97BG comparator lane.

Classification:
`LOCAL_SEQUOIA_BUILD_AUTHORIZATION=GRANTED_BY_USER_2026_09_05`.

This does not authorize Root Patch or reboot.

## Correct engineering route
Build a new comparator app in an isolated local directory on accelerated Sequoia:
1. exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e` / tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
2. apply only the one-line host-eligibility delta in `detect.py`;
3. require exactly one changed file and `1 insertion / 1 deletion`;
4. prove protected source blobs unchanged;
5. reuse/copy exact embedded `payloads.dmg` and `Universal-Binaries.dmg` from the proven signed reference app when compatible with upstream build layout, avoiding unnecessary asset regeneration;
6. build the application locally with the exact upstream PyInstaller spec;
7. verify resulting app is x86_64 or universal2 as required;
8. generate SHA256 and audit manifest;
9. preserve the proven reference app unchanged;
10. only after successful build/audit copy the comparator app to Tahoe;
11. STOP before Root Patch.

GitHub Actions compilation remains suspended until explicit quota-reset confirmation.
No Root Patch is authorized.
No reboot is authorized.
Golden remains immutable/read-only.
