# OCLP7 CHECKPOINT — D97HO UI REVERT-ONLY => RESTORE-FIRST REQUIRED

Date: 2026-09-08 EEST

## Context
D97HO wrapper assembly passed and D97HQ proved the active P1/pre-P3 userspace/compiler/metallib base is structurally exact and the Haswell kexts are present in a healthy AuxKC but unloaded in the current VESA boot.

## New decisive observation
When launching `OpenCore-Patcher-Tahoe-D97HO.app` on ASUS2, Gatekeeper required an explicit Open Anyway approval and `osascript` requested permission to make changes. After launch, OCLP did **not** expose `Start Root Patch`; it exposed only `Revert Root Patch`.

This is decisive workflow evidence that OCLP considers the current root snapshot already patched/dirty and will not allow a new Root Patch pass directly over it.

## Classification
- D97HQ healthy AuxKC / VESA-unloaded Haswell state remains valid.
- The earlier decision `DIRECT_D97HO_ROOT_PATCH=AUTHORIZED` is superseded by UI/runtime patcher state.
- `RESTORE_FIRST=REQUIRED_BY_OCLP_WORKFLOW`.
- This is not evidence of D97HO/P3 failure.
- Gatekeeper/osascript prompts are security/authorization surface, not compiler evidence.

## Required sequence
1. Do **not** attempt to bypass OCLP's Revert-only state.
2. Revert the current Root Patch using the exact D97GS lineage/current patched state workflow.
3. Reboot into VESA on the reverted/native snapshot.
4. Perform a read-only clean-state audit.
5. Run exact D97HO Root Patch on the clean state.
6. Do not reboot immediately after patching; first perform a pre-reboot P1+P3/system snapshot audit.
7. Only after that PASS authorize reboot and later acceleration testing.

## Invariants
No EFI/NVRAM/framebuffer changes. P2b/AIR00/D34 remain unauthorized. Golden Sequoia remains read-only.
