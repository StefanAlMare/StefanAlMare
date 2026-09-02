# OCLP7 CHECKPOINT — 2026-09-03 — old Root Patch unpatch PASS / VESA reboot next

## Authority and supersession
This checkpoint supersedes only the execution-state and `CURRENT SINGLE NEXT ACTION` sections of `OCLP7_CHECKPOINT_20260903_D97AF_APP_DEPLOY_PASS_MANUAL_ROOT_PATCH_NEXT.md`.

All accepted D97AF source/build/artifact/application identities, the recoverable D97AD application backup, the functional lineage and every permanent safety invariant remain unchanged. This checkpoint records that the operation just completed was the unpatch/revert of the previously active root-patched snapshot, not application of the D97AF Root Patch.

## Exact returned unpatch result
The exact D97AF OCLP application reported:

```text
- Starting Unpatch Process
Exact local metallib found (26.6.2-25G82), skipping API fallback
- Starting APFS snapshot revert
- Found SkylightPlugins folder, removing old plugins
- Cleaning Auxiliary Kernel Collection
  - Removing AppleIntelFramebufferAzul.kext
  - Removing AppleIntelHD5000Graphics.kext
- Unpatching complete
Please reboot the machine for patches to take effect
```

Authoritative interpretation:

```text
LOCAL_METALLIB_IDENTITY=26.6.2-25G82_EXACT
LEGACY_ROOT_PATCH_UNPATCH=OCLP_REPORTED_PASS_PENDING_REBOOT
APFS_SNAPSHOT_REVERT=OCLP_REPORTED_COMPLETE_PENDING_REBOOT_ACTIVATION
OLD_SKYLIGHT_PLUGINS_REMOVAL=OCLP_REPORTED
AUXKC_APPLEINTELFRAMEBUFFERAZUL_REMOVAL=OCLP_REPORTED
AUXKC_APPLEINTELHD5000GRAPHICS_REMOVAL=OCLP_REPORTED
D97AF_ROOT_PATCH=NOT_STARTED
REBOOT_AFTER_UNPATCH=REQUIRED
```

This successful output is not a D97AF Root Patch PASS. Until the reboot, no conclusion may be drawn about the effective next-boot snapshot or D97AF runtime behavior. The last proven installed application remains exact D97AF x86_64, SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`; exact D97AD remains recoverable at `/Applications/OpenCore-Patcher.app.D97AD-before-D97AF-20260903-013623`.

## Authoritative execution state

```text
D97AF_APP_DEPLOY=PROVEN_PASS
LEGACY_ROOT_PATCH_UNPATCH=OCLP_REPORTED_PASS_PENDING_REBOOT
SYSTEM_SNAPSHOT_MUTATION=YES_BY_MANUAL_UNPATCH
D97AF_ROOT_PATCH=NOT_STARTED
UNPATCH_ACTIVATION_REBOOT=NOT_YET_RUN
D97AF_ACCELERATED_BOOT=NOT_STARTED
D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED
GOLDEN_MUTATION=NO
```

## CURRENT SINGLE NEXT ACTION — manual reboot into unpatched VESA, then STOP
Manually reboot ASUS2 once using the correct ASUS2 OpenCore/EFI configuration. This reboot activates the completed snapshot revert and is expected to return Tahoe without Haswell root patches, therefore in VESA/non-accelerated mode.

After reaching the VESA desktop, STOP and report that VESA is loaded. The post-reboot clean state and D97AF application identity will then be checked before patching. Do not run D97AF Root Patch during the same unobserved step. The following checkpoint will authorize the exact D97AF manual Root Patch from the already-deployed application.

This is a preparatory unpatched/VESA reboot, not the later accelerated D97AF test boot. No automatic reboot is authorized or performed.

## Safety invariants
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEX/D97AEZ external task-port method remains retired.
- D97AF UUID remains `A4F456DF-7447-49BF-AC4F-102D90023A1E`.
- only the manual unpatch-activation reboot is now authorized;
- D97AF Root Patch remains not started until VESA return.
