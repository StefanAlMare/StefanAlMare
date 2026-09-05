# OCLP7 CHECKPOINT — 2026-09-05 — Target-specific developer marker equivalence; no rebuild required

Status: **D97BG TARGET-SPECIFIC STATIC PROOF / NO BUILD / NO ROOT PATCH**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BG_DEVELOPER_MARKER_REJECTED_TOO_BROAD_LOCAL_SEQUOIA_EXACT_BUILD_AUTHORIZED.md`.

## User execution scope
User will handle copying the app to Tahoe and will perform Root Patch manually. Assistant scope is only to make the exact Golden-lineage OCLP usable on Tahoe and define the comparator semantics.

## Key reconciliation
Global Dortania developer mode is broader than a one-line source edit in the abstract. However exact reachability for ASUS2 changes that conclusion.

Exact `b9df76` detection first skips hardware classes whose `present()` is false before invoking their native/patch logic. ASUS2 target hardware is Intel Haswell HD4400/4600. `IntelHaswell` does not consult `_dortania_internal_check()` at all.

Current-main code search for `_dortania_internal_check()` is valid for exact b9df76 patchset source because comparison `b9df76...af9b49` shows only `CHANGELOG.md` and `constants.py` changed; patchset files are identical. Developer-mode branches are confined to the unsupported-host check and other GPU families such as Iron Lake, Sandy Bridge, Nvidia Tesla/WebDriver, AMD TeraScale and AMD Navi. Those classes are absent on the ASUS2 target and are skipped by `present()`.

Therefore on this specific ASUS2 Haswell target, creating `~/.dortania_developer` changes the reachable patching logic only by suppressing `Validation: Unsupported Host OS`; it does not alter reachable Haswell patch composition.

Classification:
`D97BG_DORTANIA_DEVELOPER_MARKER_ON_ASUS2_HASWELL=TARGET_SPECIFIC_SEMANTIC_EQUIVALENT_TO_HOST_OS_GATE_BYPASS`

## Why this route is superior to a local rebuild
The original Desktop app remains officially signed by Dortania. OCLP's privileged helper verifies that the main app is signed by Dortania before executing root commands. A locally rebuilt/ad-hoc signed app would fail root-helper verification unless the helper were rebuilt in debug mode or with a replacement Developer ID, introducing an unnecessary extra modification and security change.

Thus the clean comparator route is:
- preserve the official b9df76 OCLP 2.5.0 app unchanged;
- copy it unchanged to Tahoe (user action);
- create `~/.dortania_developer` in the Tahoe user's home;
- verify executable SHA256 remains `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc` and deep/strict codesign remains valid;
- open OCLP in Tahoe;
- expected Tahoe-specific unsupported-host gate is cleared;
- Haswell path remains original `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific`;
- user may then perform Root Patch manually and return afterward for accelerated-boot comparison.

MetallibSupportPkg is user-confirmed present in Tahoe.

No GitHub build is required.
No local build is required.
No app repack or re-sign is required.
Assistant does not perform copy or Root Patch.
