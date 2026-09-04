# OCLP7 CHECKPOINT — 2026-09-05 — D97BE exact Golden gate chain PROVEN / one-line Tahoe eligibility delta / D97BF build next

Status: **AUTHORITATIVE TECHNICAL CHECKPOINT**.
Conversation/session label: **OCLP 11**.
Previous checkpoint: `OCLP7_CHECKPOINT_20260905_OCLP11_RESUME_GOLDEN_ROOTPATCH_MANIFEST_LINEAGE_PINNED_D97BE_NEXT.md`.

## D97BE result
D97BE is complete for the exact Golden ORIGINAL-OCLP baseline.

Exact baseline:
- repository: `dortania/OpenCore-Legacy-Patcher`;
- commit: `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- OCLP version: `2.5.0`;
- PatcherSupportPkg: `1.9.6`;
- this is the source commit pinned by the working Golden Sequoia root-patch manifest.

## Exact host-OS eligibility chain
At exact `b9df76...`, `opencore_legacy_patcher/sys_patch/patchsets/detect.py` contains:
- `_min_os = os_data.big_sur.value`;
- `_max_os = os_data.sequoia.value`;
- `self._xnu_major > _max_os` => `HardwarePatchsetValidation.UNSUPPORTED_HOST_OS = True`.

That value enters `requirements`, and `_can_patch(requirements)` rejects any `Validation:*` key whose value is `True`.
The result is assigned through:
`_cant_patch = not self._can_patch(requirements)`
-> `requirements[PATCHING_NOT_POSSIBLE] = _cant_patch`
-> `self.can_patch = not _cant_patch`.

`PatchSysVolume.start_patch()` then enforces:
`if patchset_obj.can_patch is False: ... return`.

Classification:
`D97BE_GOLDEN_HOST_OS_GATE_CHAIN=STATIC_PROVEN`.

## Tahoe enum already exists in the exact Golden source
Exact `b9df76.../datasets/os_data.py` already defines:
- `sequoia = 24`;
- `tahoe = 25`.

Therefore no dataset edit is needed to express Tahoe support.

## Haswell/Tahoe payload construction remains valid without functional edits
Exact `b9df76.../hardware/graphics/intel_haswell.py`:
- Haswell is non-native for Darwin >= 22, so Darwin 25 remains patch-eligible;
- `requires_metallib_support_pkg()` is true for Darwin >= 24, therefore also on Tahoe;
- `patches()` continues to compose the original `LegacyMetal3802`, `MontereyGVA`, `MontereyOpenCL`, and original Haswell model-specific payloads.

Exact `metal_3802.py` already uses forward-compatible conditions (`>= sequoia`, `>= sonoma`, etc.) and is not to be changed for this comparator.

`metallib_handler.py` obtains the MetallibSupportPkg catalog dynamically from Dortania and has no static Tahoe maximum gate.

Classification:
`D97BE_HASWELL_PAYLOAD_PATH_WITH_TAHOE=STATIC_COMPATIBLE_WITHOUT_SOURCE_EDIT`.

## Minimal functional delta
The only Tahoe-specific functional source delta authorized for the identical-OCLP comparator is exactly one replacement in exact Golden `detect.py`:

```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

No other functional source edit is authorized.

This changes only host-OS eligibility. It does **not** change:
- `intel_haswell.py`;
- `metal_3802.py`;
- `sys_patch.py`;
- `sys_patch_helpers.py`;
- selector/compiler/donor logic;
- XPC request layout;
- Golden component invariants;
- historical P1/P2b/P3/AIR00/D34 evidence baseline.

Other validations (SIP, FileVault, SecureBootModel, AMFI, repatching state, required downloads/network) remain original OCLP validations and may independently block Root Patch if ASUS2 is not in the required state. They are not Tahoe-version bypass targets and must not be disabled.

Classification:
`D97BE_MINIMAL_TAHOE_DELTA=ONE_LINE_DETECT_MAX_OS_SEQUOIA_TO_TAHOE`.

## Comparator discipline
The rejected dirty Tahoe/T2 worktree remains non-authoritative and must not be used as source for the comparator build. No historical custom `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py`, P1/P2b/P3/AIR00/D34/P6/P7 code is imported into this build.

The build source must be a clean checkout of exact upstream `b9df76...`, followed only by the one-line eligibility delta above.

## D97BF — CURRENT ACTION
GitHub-first integration/build/package/audit of exact Golden OCLP with the one-line Tahoe eligibility delta.

Mandatory D97BF gates:
1. clean exact checkout at `b9df76...`;
2. verify OCLP `2.5.0`, PatcherSupportPkg `1.9.6`, and Tahoe enum `25`;
3. apply exactly one replacement in `detect.py`;
4. prove `git diff --name-only` contains only `detect.py` and numstat is exactly one deletion + one insertion;
5. compile/static validation;
6. prove protected functional files remain byte-identical to the exact Golden commit;
7. build `OpenCore-Patcher.app` in GitHub CI from that exact source;
8. package an identity-pinned artifact and generate SHA256/tree manifest/audit report;
9. audit the GitHub workflow/run/job/artifact before any ASUS2 deployment;
10. STOP before Root Patch. Root Patch remains manual and requires explicit authorization after artifact deployment/identity verification.

Golden remains immutable/read-only. No reboot is authorized by this checkpoint.
