# OCLP7 CHECKPOINT — 2026-09-05 — b9df76 built-in developer bypass eliminates app patch; Haswell already valid

Status: **D97BG STATIC CONTROL-SOLUTION / NO BUILD / NO ROOT PATCH**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BF_HISTORICAL_SECOND_TAHOE_GATE_RECONCILED_B9DF76_SCOPE_CORRECTED.md`.

## User execution preference
User explicitly prefers to prepare the Tahoe-side changes while booted in accelerated Sequoia. MetallibSupportPkg is confirmed by the user as already present and usable in Tahoe, so it is removed from the current unknown list.

## New exact-source result
Exact Golden source `b9df76ebdf3e768b37c1cc980e8444aa837c623e` contains a built-in Dortania developer-mode bypass in `HardwarePatchsetDetection._validation_check_unsupported_host_os()`:

```python
_min_os = os_data.big_sur.value
_max_os = os_data.sequoia.value
if self._dortania_internal_check() is True:
    return False
if self._xnu_major < _min_os or self._xnu_major > _max_os:
    return True
```

and exact `_dortania_internal_check()` is:
```python
return Path("~/.dortania_developer").expanduser().exists()
```

Therefore the global Tahoe unsupported-host gate can be cleared **without modifying the signed application bundle at all** by creating `~/.dortania_developer` in the user home of the Tahoe installation.

Classification:
`B9DF76_TAHOE_UNSUPPORTED_HOST_GATE_CAN_BE_BYPASSED_WITH_BUILTIN_DORTANIA_DEVELOPER_MARKER=PROVEN`.

## Haswell second-gate status
Exact b9df76 Haswell logic remains already correct for Darwin 25:
- `IntelHaswell` is present in `_hardware_variants`;
- `IntelHaswell.native_os()` is `self._xnu_major < os_data.ventura.value` -> False on Darwin 25;
- `IntelHaswell.patches()` proceeds to LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific patches;
- `LegacyMetal3802._os_requires_patches()` is `self._xnu_major >= os_data.ventura.value` with no Tahoe maximum.

Classification:
`B9DF76_HASWELL_PATCHSET_SECOND_GATE_CHANGE_REQUIRED=NO`.

## Engineering consequence
Do **not** modify, repack, or re-sign `/Users/alex/Desktop/OpenCore-Patcher.app`.
Preserve the proven official b9df76 OCLP 2.5.0 application byte-for-byte.

Preferred route:
1. while booted in accelerated Sequoia, identify the mounted Tahoe Data volume for build `25G82`;
2. copy the proven signed OCLP 2.5.0 app unchanged into Tahoe `/Applications` (Data-volume Applications directory), preserving any pre-existing app as backup;
3. create `.dortania_developer` only in the Tahoe user's home, not in Sequoia;
4. verify target app SHA/codesign unchanged and marker path correct;
5. boot Tahoe and open OCLP;
6. inspect the detected root-patch list and validation state only;
7. STOP before Root Patch and return the complete OCLP output/list for audit.

This route avoids breaking Developer ID signature and avoids any local compilation or PyInstaller repackaging.

## Safety
- Golden/reference app remains unchanged.
- No Root Patch is authorized.
- No reboot is authorized by this checkpoint.
- GitHub compilation remains suspended until explicit quota-reset confirmation.
