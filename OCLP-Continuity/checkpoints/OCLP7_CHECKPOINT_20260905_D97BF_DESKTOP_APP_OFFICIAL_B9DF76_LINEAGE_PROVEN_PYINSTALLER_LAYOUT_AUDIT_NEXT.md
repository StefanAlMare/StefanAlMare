# OCLP7 CHECKPOINT — 2026-09-05 — Desktop OpenCore-Patcher.app official b9df76 lineage proven; PyInstaller layout audit next

Status: **D97BF DECISIVE PROVENANCE RESULT / NO BUILD EXECUTED**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BF_USER_OCLP_PKG_GOLDEN_LINEAGE_CANDIDATE_READONLY_AUDIT_NEXT.md`.

## User-local read-only app audit
The user audited the copy at:
`/Users/alex/Desktop/OpenCore-Patcher.app`

Observed bundle metadata:
- bundle created: `2026-03-19 18:36:42 +0200`;
- bundle modified: `2026-03-21 21:34:22 +0200`;
- `du -sh`: `777M`;
- CFBundleIdentifier: `com.dortania.opencore-legacy-patcher`;
- CFBundleName: `OpenCore Legacy Patcher`;
- CFBundleShortVersionString: `2.5.0`;
- CFBundleVersion: `2.5.0`;
- Build Date: `2026-03-19 09:33:30`;
- BuildMachineOSBuild: `21G531`;
- LSMinimumSystemVersion: `10.10.0`.

Executable:
`/Users/alex/Desktop/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher`

Executable audit:
- Mach-O universal binary;
- architectures: `x86_64 arm64`;
- executable SHA256: `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256: `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`.

Codesign:
- Identifier: `com.dortania.opencore-legacy-patcher`;
- format: universal `x86_64 arm64`;
- Developer ID Application: `Mykola Grymalyuk (S74BDJXQMD)`;
- TeamIdentifier: `S74BDJXQMD`;
- signing timestamp displayed locally: `19 Mar 2026 at 18:33:46`;
- deep/strict verification: `valid on disk` and `satisfies its Designated Requirement`;
- `codesign_exit=0`.

Embedded payloads observed:
- `payloads.dmg`: approximately `46M`, timestamp `19 Mar 18:32`;
- `Universal-Binaries.dmg`: approximately `612M`, timestamp `19 Mar 18:32`.

## Exact upstream provenance correlation
Golden source commit is already pinned to:
`b9df76ebdf3e768b37c1cc980e8444aa837c623e`
with exact tree:
`7c3411fde7d40604164c8877a5ab5594448083ac`.

Upstream GitHub metadata proves:
- commit `b9df76...` created at `2026-03-19T16:31:54Z`;
- message: `detect.py: Fix missing import`;
- no subsequent upstream commits exist between `2026-03-19T16:31:55Z` and `2026-03-19T20:00:00Z`.

Official Dortania Actions metadata for this exact head SHA proves run:
- run ID `23305527165`;
- workflow `CI - Build wxPython`;
- event `push`;
- head SHA `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- run started `2026-03-19T16:32:02Z`;
- job ID `67778441258`;
- job label `x86_64_monterey`;
- job completed `2026-03-19T16:41:53Z`;
- conclusion `success`.

The official run published an `OpenCore-Patcher.pkg` artifact:
- artifact ID `6010508330`;
- created `2026-03-19T16:41:49Z`;
- artifact size metadata `738056006` bytes;
- artifact archive digest `sha256:9f840adfcd6b68166b24394cd62df3f5ddb2acbe0e4af59f996239ee8c1c66b3`;
- artifact is now expired.

The app's official Developer ID signature, OCLP 2.5.0 metadata, Monterey build-machine marker, universal2 architecture, payload timestamps, build/sign/create times and the official upstream workflow window all align with the exact `b9df76...` push build. There is no later upstream commit in the relevant build window.

Classification:
`USER_DESKTOP_APP_OFFICIAL_B9DF76_SOURCE_LINEAGE=PROVEN_BY_OFFICIAL_WORKFLOW_PROVENANCE`

Separate byte-identity classification:
`USER_DESKTOP_APP_BYTE_IDENTITY_TO_EXPIRED_OFFICIAL_ARTIFACT=UNAVAILABLE_EXPIRED_ARTIFACT`

This distinction is intentional: source/build lineage is proven; byte-for-byte identity to the expired downloadable artifact cannot be re-proved from current GitHub storage.

## Engineering consequence
The user already possesses a valid official OCLP 2.5.0 universal2 application from the exact Golden source lineage. Therefore a fresh build is no longer the only possible route to D97BF.

A new candidate route is to make a **copy-only modification of the existing Desktop app**, changing only the packaged Python implementation of the already-authorized eligibility delta:

```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

Before any modification, the PyInstaller archive layout must be audited read-only to determine whether the frozen `opencore_legacy_patcher.sys_patch.patchsets.detect` module can be replaced/repacked deterministically without rebuilding the entire application.

No direct app modification is yet authorized by this checkpoint; first map the frozen archive and recover the exact packaged module representation.

## CURRENT ACTION
Perform a **read-only PyInstaller layout audit** on `/Users/alex/Desktop/OpenCore-Patcher.app`:
1. identify PyInstaller archive structure and viewer availability;
2. prove presence/location of frozen module `opencore_legacy_patcher.sys_patch.patchsets.detect`;
3. determine whether the one-line eligibility change can be made by deterministic archive/module replacement rather than full application compilation;
4. preserve original Desktop app copy unchanged until a modification procedure is fully audited;
5. if a copy-only patch route is feasible, create a second working copy, patch only that copy, ad-hoc/re-sign only as required, and audit final architecture/hash/bundle integrity before any deployment.

GitHub Actions compilation remains suspended until explicit user quota-reset confirmation.
Local compilation remains prohibited until explicit user authorization.
No Root Patch is authorized.
No reboot is authorized.
Golden remains immutable/read-only.
