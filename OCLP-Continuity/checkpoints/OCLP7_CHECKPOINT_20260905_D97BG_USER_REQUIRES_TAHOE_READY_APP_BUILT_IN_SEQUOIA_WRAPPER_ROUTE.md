# OCLP7 CHECKPOINT — 2026-09-05 — User requires Tahoe-ready app produced in Sequoia before handoff

Status: **EXECUTION RESPONSIBILITY CORRECTION / COMPATIBILITY MUST BE BAKED BEFORE USER HANDOFF**.

## User clarification
The user explicitly clarified that the assistant must complete the Tahoe-compatibility work in Sequoia first. The user's responsibility starts only after a Tahoe-ready application exists:
1. assistant produces the Tahoe-ready application in Sequoia;
2. user copies that final app to Tahoe;
3. user runs Root Patch manually;
4. user returns after Root Patch for Golden-vs-Tahoe comparison work.

The user must not be asked to apply the Tahoe-eligibility patch or create a developer marker manually.

## Why direct binary/source rebuild is not the preferred handoff artifact
Exact OCLP 2.5.0 uses `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper` for root commands. The release helper validates the Team ID and certificates of its parent OCLP executable against Dortania (`S74BDJXQMD`). A locally rebuilt/ad-hoc-signed OCLP executable would therefore fail helper authorization unless the helper were also replaced with a debug/custom helper, introducing an unnecessary additional security/behavior change.

## Selected Tahoe-ready handoff route
Build a single outer application bundle in Sequoia, `OpenCore-Patcher-Tahoe.app`, that contains the proven official signed b9df76 OCLP app unchanged as an inner application.

The outer launcher automatically:
- verifies the inner exact executable and Info.plist hashes;
- verifies the inner Dortania code signature remains valid;
- ensures a compatible Dortania privileged helper is present (optionally embedding the already-installed official helper from Sequoia as a fallback installer asset);
- creates `~/.dortania_developer` automatically immediately before launching the inner OCLP;
- launches the unchanged signed inner OCLP and waits for it to exit;
- removes only the marker it created after OCLP exits.

For ASUS2 Haswell this marker is target-specific semantically equivalent to bypassing the static unsupported-host gate: Haswell itself does not consult developer mode, and non-present legacy GPU classes are skipped before their developer-mode patch branches execute under normal patch detection.

## Resulting user experience
The user receives one application bundle already prepared for Tahoe. They copy it to Tahoe and launch it. They do not manually create a marker, patch source, modify PyInstaller, rebuild OCLP, or install a custom debug helper.

## Preserved invariants
Inner OCLP remains exact official Golden-lineage app:
- OCLP 2.5.0;
- exact source lineage `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- Dortania Developer ID signature remains untouched;
- original payloads remain untouched.

No Root Patch or reboot is performed while creating the wrapper in Sequoia.

## CURRENT ACTION
Create and audit `~/Desktop/OpenCore-Patcher-Tahoe.app` in Sequoia from the proven `~/Desktop/OpenCore-Patcher.app`, then optionally ZIP it for transport. Require inner identity and signature PASS before handoff.
