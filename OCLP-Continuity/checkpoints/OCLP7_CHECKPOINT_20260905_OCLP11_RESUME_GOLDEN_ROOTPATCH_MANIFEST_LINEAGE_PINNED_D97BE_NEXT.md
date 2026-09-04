# OCLP7 CHECKPOINT — 2026-09-05 — OCLP11 resume / Golden root-patch manifest lineage pinned / D97BE next

Status: AUTHORITATIVE CONTINUITY CHECKPOINT.
Conversation/session label: **OCLP 11**.
Previous technical endpoint: **D97BD — GOLDEN -> TAHOE IDENTICAL-OCLP ELIGIBILITY PREFLIGHT**.
Technical frontier remains **D97BE CLEAN-REF + EXACT GATE-CHAIN AUDIT**.

## User-confirmed strategy
The current strategy is to use Tahoe as a comparator against the working Sequoia Golden system by applying the **same ORIGINAL OCLP functional root-patch content** that produced the working Golden image, with no historical Tahoe experimental payload/compiler changes imported by default. The only Tahoe-specific functional delta that may be considered is the smallest separately audited eligibility/OS-support bypass required to let that same ORIGINAL OCLP root-patch path run on Tahoe.

The purpose is causal comparison: because the Golden producer/ingress/compiler/Haswell handoff contract has already been characterized, an identical-OCLP Tahoe root patch gives a controlled way to compare Tahoe against Sequoia and isolate the remaining OS-side difference responsible for lack of accelerated image.

## Newly supplied decisive Golden root-patch manifest evidence
Read-only local report supplied by the user for:
`/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist`

Manifest identity:
- bytes: `34173`;
- SHA256: `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- `Commit URL`: `https://github.com/dortania/OpenCore-Legacy-Patcher/commit/b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- `OpenCore Legacy Patcher`: `v2.5.0`;
- `PatcherSupportPkg`: `v1.9.6`;
- manifest `OS Version`: `24.6 (24H22)`;
- `Time Patched`: `September 04, 2026 @ 18:04:54`;
- `Metal Library Used`: `/Library/Application Support/Dortania/MetallibSupportPkg/15.7.9-24G830`.

The manifest records the actual working Golden root-patch inventory, including `Intel Haswell`, `Metal 3802 Common`, `Metal 3802 Common Extended`, `Metal 3802 .metallibs`, Monterey GVA/OpenCL and other exact payload entries.

## GitHub verification of the manifest commit
The assistant verified in GitHub that commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e` exists in `dortania/OpenCore-Legacy-Patcher`.
Commit message: `detect.py: Fix missing import`.
Commit date: `2026-03-19T16:31:54Z`.

Classification:
`GOLDEN_ROOTPATCH_ORIGINAL_OCLP_SOURCE_COMMIT=PINNED_b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

This closes the **root-patch source commit lineage** that MASTER previously left open. It does **not** retroactively prove byte identity of the Golden `.app` bundle; the D97BD app-bundle identity subsection remains `INCONCLUSIVE_TOOLING` because of path aliasing/unresolved bundle metadata. These are separate evidence questions.

## Important correction to D97BD eligibility interpretation
D97BD observed the custom Tahoe/T2 worktree `patchsets/detect.py` with `_max_os = os_data.tahoe.value`, therefore correctly concluded that widening `_max_os` in that **custom Tahoe tree** was not the relevant gate.

The newly pinned ORIGINAL-OCLP Golden commit was checked read-only in GitHub. At exact commit `b9df76...`, `_validation_check_unsupported_host_os()` contains:
- `_min_os = os_data.big_sur.value`;
- `_max_os = os_data.sequoia.value`;
- host OS outside that interval returns unsupported.

Therefore the old blanket sentence `Do NOT patch _max_os` must not be generalized to the exact Golden ORIGINAL-OCLP baseline. For D97BE the correct rule is:

`NO_ELIGIBILITY_EDIT_IS_AUTHORIZED_UNTIL_THE_EXACT_b9df76_GATE_CHAIN_IS_AUDITED.`

D97BE must determine whether the minimal Tahoe-only delta is only the ORIGINAL-OCLP host-OS maximum, or whether another eligibility requirement in the exact clean ref also blocks root patching. Payload/selector/compiler/donor logic remains out of scope for an eligibility-only delta.

## D97BD retained facts
D97BD remains PASS and read-only. Current Tahoe source worktree remains rejected as comparator baseline:
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- branch `alex-tahoe-25G82-custom`;
- tracked dirty files: `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py`;
- extensive historical `.before-*` and D97 material;
- classification: `TAHOE_CURRENT_WORKTREE_IDENTICAL_OCLP_BASELINE=REJECTED_DIRTY_CUSTOM`.

The accepted historical evidence baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`; D50/D68/D82 remain reserve-only. Golden remains immutable/read-only.

## Execution contract
Permanent GitHub-first policy remains active:
- GitHub-resolvable clean-ref, source, gate-chain, diff, compile/build/package/audit work is performed by the assistant in GitHub;
- ASUS2/user is used only for identity-pinned local/live/hardware evidence and target-local deploy/root-patch/boot actions that inherently require ASUS2;
- no implicit local compilation fallback;
- never auto Root Patch;
- never auto reboot.

## CURRENT ACTION — D97BE
Read-only **CLEAN-REF + EXACT GATE-CHAIN AUDIT**, now with the primary Golden ORIGINAL-OCLP candidate pinned to exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

D97BE must, before any integration:
1. audit exact `b9df76...` eligibility chain from `_validation_check_unsupported_host_os()` through requirements, `_can_patch`, `self.can_patch` and `sys_patch.py` enforcement;
2. compare the exact clean ORIGINAL-OCLP relevant files against Tahoe/T2 refs and the rejected dirty worktree without mutating either;
3. identify whether a single eligibility-only Tahoe delta is sufficient;
4. prove that such delta leaves Haswell/Metal payload construction, selector/compiler/donor logic, request layout and Golden component invariants unchanged;
5. stop before source integration, Root Patch or reboot unless a later authoritative checkpoint explicitly advances the phase.
