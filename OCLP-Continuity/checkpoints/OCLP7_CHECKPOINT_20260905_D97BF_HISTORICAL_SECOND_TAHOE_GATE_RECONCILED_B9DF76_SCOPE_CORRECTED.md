# OCLP7 CHECKPOINT — 2026-09-05 — Historical second Tahoe gate reconciled; exact b9df76 scope corrected

Status: **D97BF STATIC-SCOPE CORRECTION / NO BUILD / NO ROOT PATCH**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BF_DESKTOP_APP_OFFICIAL_B9DF76_LINEAGE_PROVEN_PYINSTALLER_LAYOUT_AUDIT_NEXT.md`.

## User correction
The user correctly recalled an earlier OCLP/Tahoe discussion in which a second patchset-level blocker existed in addition to the global unsupported-host gate.

Historical blocker previously identified in the Tahoe-aware/custom source used during the earlier project phase:
1. legacy GPU patchset classes could be excluded/disabled for Tahoe at the hardware-variant selection layer;
2. even when present, legacy GPU classes could classify Tahoe as `native_os()` through a Tahoe-specific clause, causing `HardwarePatchsetDetection` to skip them or `patches()` to return `{}`.

That historical result remains valid for the source tree in which it was observed. It must not be silently projected onto another OCLP lineage.

## Re-audit of exact Golden source b9df76
Exact source audited:
`dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`
Tree:
`7c3411fde7d40604164c8877a5ab5594448083ac`

### Global host-OS gate
Exact `detect.py` still contains:
```python
_min_os = os_data.big_sur.value
_max_os = os_data.sequoia.value
...
if self._xnu_major < _min_os or self._xnu_major > _max_os:
    return True
```
This remains the known Tahoe-specific eligibility blocker in b9df76.

### Hardware-variant inclusion
Exact b9df76 `HardwarePatchsetDetection.__init__()` includes `intel_haswell.IntelHaswell` unconditionally in `_hardware_variants`.
There is no Tahoe exclusion around Haswell in this exact source.

### Haswell native_os gate
Exact b9df76 `IntelHaswell.native_os()` is:
```python
return self._xnu_major < os_data.ventura.value
```
Therefore on Darwin 25 / Tahoe it returns `False`, so Haswell is not skipped as a native GPU.

Exact `IntelHaswell.patches()` only returns `{}` when `native_os()` is true. On Darwin 25 that condition is false, so it proceeds to compose:
- `LegacyMetal3802`;
- `MontereyGVA`;
- `MontereyOpenCL`;
- Haswell model-specific patches.

### Metal3802 gate
Exact b9df76 `LegacyMetal3802._os_requires_patches()` is:
```python
return self._xnu_major >= os_data.ventura.value
```
There is no Tahoe maximum here. Darwin 25 remains inside the patch-required side of this condition.

### MetallibSupportPkg
Exact Haswell requires MetallibSupportPkg for Sequoia or newer.
The exact b9df76 metallib handler has no static Tahoe maximum; it queries the dynamic Dortania MetallibSupportPkg manifest and attempts exact/closest matching.
This is a runtime/package dependency, not an additional Tahoe source-gate edit.

## Corrected classification
The historical second Tahoe patchset blocker is **real but source-lineage-specific**.

For exact Golden b9df76:
`HISTORICAL_TAHOE_PATCHSET_NATIVE_OS_BLOCKER_APPLIES_TO_B9DF76=NO`

For exact Golden b9df76, the only currently PROVEN Tahoe-specific source eligibility edit required to make Haswell survive patchset detection is:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

Classification:
`B9DF76_TAHOE_STATIC_SOURCE_GATE_REQUIRED_FOR_HASWELL_PATCHSET_SELECTION=ONE_LINE_DETECT_MAX_OS`

Important scope correction:
This does **not** prove that one line is sufficient for a fully successful Tahoe Root Patch. It proves only that the known static host-eligibility gate is the sole Tahoe-specific source gate currently demonstrated in exact b9df76 before Haswell patchset generation.

A complete Root Patch can still be blocked or fail because of unchanged runtime validations/dependencies or Tahoe behavior, including:
- MetallibSupportPkg availability/matching;
- network if required package retrieval is needed;
- SIP;
- FileVault;
- SecureBootModel;
- AMFI;
- dirty/repatch state;
- root-volume mount/cache/snapshot behavior;
- any Tahoe runtime incompatibility not represented by an explicit source guard.

Current official OCLP documentation still scopes supported patcher operation through Sequoia, while Tahoe support remains ongoing. Therefore full Tahoe Root Patch success must remain `NOT_YET_PROVEN` until the exact b9df76-derived comparator is exercised and audited.

## CURRENT ACTION
Do not patch the Desktop app yet.
Continue the read-only frozen-app audit, but expand the target from only `detect.py` to the complete static eligibility/selection contract:
1. locate frozen `opencore_legacy_patcher.sys_patch.patchsets.detect`;
2. locate frozen `opencore_legacy_patcher.sys_patch.patchsets.hardware.graphics.intel_haswell`;
3. prove packaged logic matches exact b9df76 for `_hardware_variants`, `native_os()`, and Haswell `patches()` composition;
4. inspect packaged MetallibSupportPkg resolution path and determine whether the target Tahoe build `25G82 / 26.6.2` has a usable local or remote MetallibSupportPkg match;
5. only after these read-only checks decide whether a one-module direct patch is actually sufficient for the comparator app or whether another package/runtime accommodation is required.

GitHub Actions compilation remains suspended until explicit user quota-reset confirmation.
Local compilation remains prohibited until explicit user authorization.
No Root Patch is authorized.
No reboot is authorized.
Golden remains immutable/read-only.
