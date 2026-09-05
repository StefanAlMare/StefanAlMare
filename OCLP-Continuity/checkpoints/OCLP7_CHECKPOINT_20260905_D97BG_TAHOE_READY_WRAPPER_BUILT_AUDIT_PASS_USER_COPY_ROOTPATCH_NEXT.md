# OCLP7 CHECKPOINT — 2026-09-05 — D97BG Tahoe-ready wrapper built/audited PASS; user copy + Root Patch next

Status: **D97BG BUILD/AUDIT PASS / TAHOE-READY APP PRODUCED / NO ROOT PATCH / NO REBOOT**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BG_USER_REQUIRES_TAHOE_READY_APP_BUILT_IN_SEQUOIA_WRAPPER_ROUTE.md`.

## User-confirmed execution result
On accelerated Sequoia, the user executed the D97BG wrapper-construction block against the proven reference:
`/Users/alex/Desktop/OpenCore-Patcher.app`.

The source reference revalidated as exact Golden identity:
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- source TeamIdentifier `S74BDJXQMD`;
- deep/strict codesign PASS.

The installed official privileged helper revalidated:
- path `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`;
- TeamIdentifier `S74BDJXQMD`;
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- codesign PASS.

## Tahoe-ready artifact produced
Application:
`/Users/alex/Desktop/OpenCore-Patcher-Tahoe.app`

Transport ZIP:
`/Users/alex/Desktop/OpenCore-Patcher-Tahoe.zip`

Transport identity:
- bytes `738378441`;
- SHA256 `3c63c2d4c90039c12f025f27aba47ab279b0e075535b37399521d6b3e016308b`.

Embedded inner Golden OCLP identity remained exact:
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- inner Dortania codesign PASS;
- embedded privileged helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- embedded helper codesign PASS.

Final classifications printed by the construction audit:
- `INNER_GOLDEN_IDENTITY=PASS`;
- `INNER_DORTANIA_CODESIGN=PASS`;
- `PRIVILEGED_HELPER_IDENTITY=PASS`;
- `TAHOE_COMPATIBILITY_EMBEDDED=PASS`.

No Root Patch was run.
No reboot was run.

## Architecture of the Tahoe-ready app
The outer `OpenCore-Patcher-Tahoe.app` is a launcher/wrapper.
It preserves the exact signed Dortania OCLP app byte-for-byte as an embedded inner application.
At launch it:
1. revalidates the embedded Golden executable/Info.plist identity and Dortania signature;
2. validates/installs the exact official privileged helper if needed;
3. creates the OCLP built-in developer marker automatically for the duration of the OCLP session;
4. launches the exact signed inner OCLP and waits for it;
5. removes only the marker it created when the inner OCLP exits.

For the exact ASUS2 Haswell target, prior static audit proved that the developer-mode predicate is semantically equivalent to bypassing the Tahoe host-OS gate on the reachable Haswell patch path: non-present alternative GPU classes are skipped before their developer-mode patch logic, while Haswell itself does not consult the developer-mode predicate.

This wrapper route is intentionally preferred over modifying/re-signing the inner OCLP because the OCLP 2.5.0 privileged helper requires the calling OCLP executable to match Dortania Team ID/certificates.

Classification:
`D97BG_TAHOE_READY_WRAPPER_BUILD_AUDIT=PASS`

`D97BG_TAHOE_READY_ZIP_SHA256=3c63c2d4c90039c12f025f27aba47ab279b0e075535b37399521d6b3e016308b`

`D97BG_INNER_GOLDEN_BYTE_IDENTITY=PRESERVED`

`D97BG_INNER_DORTANIA_SIGNATURE=PRESERVED`

`D97BG_OFFICIAL_PRIVILEGED_HELPER_IDENTITY=PRESERVED`

## Responsibility boundary after D97BG PASS
The assistant's Tahoe compatibility preparation is complete for this comparator artifact.

The user will now:
1. copy `OpenCore-Patcher-Tahoe.app` (or unzip the identity-pinned ZIP and copy the app) into Tahoe;
2. launch that Tahoe-ready wrapper app;
3. perform the Root Patch manually;
4. return the complete Root Patch output/result before comparison work continues.

The user does **not** need to manually create `.dortania_developer`, patch OCLP source, modify detect.py, or perform any separate Tahoe-compatibility operation.

## CURRENT ACTION
**User copy + manual Root Patch on Tahoe using the D97BG Tahoe-ready app.**

After Root Patch finishes, persist the Root Patch result immediately and then proceed according to the permanent accelerated-boot/VESA rule.

No automatic reboot is authorized.
Golden remains immutable/read-only.
GitHub compilation remains suspended until explicit user quota-reset confirmation.
