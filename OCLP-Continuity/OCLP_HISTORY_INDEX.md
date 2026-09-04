# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_OCLP11_RESUME_GOLDEN_ROOTPATCH_MANIFEST_LINEAGE_PINNED_D97BE_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Final architecture
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP donor -> Golden-equivalent compiler output -> Haswell driver -> image`.
Tahoe comparator must use SAME ORIGINAL OCLP functional content; only a separately audited minimal eligibility/OS-support bypass may differ.

## Golden snapshots / contract closure
GOLDEN_A = Sequoia `15.7.9 / 24G830`, D97AU/D97AX/D97AY oracle.
GOLDEN_B = Sequoia `15.8 / 24H22`, same OCLP Root Patch reapplied manually, acceleration working, no EFI changes per user.
Donor hashes unchanged: 32023 `ddabe975...`, 3802 `85d4c285...`, service `31a6f745...`.

D97AZ: requestType `[R13+0x8]`; timeout `[R13+0x18]`; sandbox condition `[R13+0x70]`; alternate requestType immediate 9; helper paths mapped.
D97BB: LC_FUNCTION_STARTS request-builder `0x7FF80D370756..0x7FF80D370C28`; llvmVersion source `movslq 0x20(%rbx),%rdx`.
D97BC: RBX = ABI arg1/RDI, R13 = ABI arg2/RSI; no intervening writes before mapped fields. Producer layout bound to ABI objects. Golden structural contract declared sufficient to begin identical-OCLP Tahoe eligibility phase.

## D97BD — identical-OCLP Tahoe eligibility preflight PASS
Complete returned terminal transcript:
- bytes `401990`;
- SHA256 `00b6182ddda1e3b10c1427ff1e53b51d364aba8141d1e9f4d5c9c0596cb87c71`.
Core/wrapper pins and Python/safety gates PASS; final `D97BD_AUDIT=COMPLETE`, outer/launcher RC 0; no mutation/fetch/checkout/reset/debugger/Root Patch/reboot.

App identity subsection retired as `INCONCLUSIVE_TOOLING`: `/Volumes/AsusLaptop -> /` created path aliasing and app metadata/executable hashes were unresolved.

Canonical Tahoe source observed:
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`, branch `alex-tahoe-25G82-custom`;
- prior/tag `8969550` (`4.0.0.16900` / `4.0.0.16047`);
- `origin/main e371b71468464ea3a13b8b82c3ca5298a71df141`;
- `origin/Development 85ea01b333c9a7e50c44f054a52614425c3058a2`.

Current worktree is rejected as identical-OCLP baseline because tracked `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py` are dirty and historical D97/.before material is present.
Classification: `TAHOE_CURRENT_WORKTREE_IDENTICAL_OCLP_BASELINE=REJECTED_DIRTY_CUSTOM`.

D97BD added Golden component invariants:
- AppleIntelFramebufferAzul SHA `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics SHA `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver SHA `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

D97BD eligibility result for the **custom Tahoe/T2 worktree**: its `patchsets/detect.py` already sets `_max_os = os_data.tahoe.value`, so simple max-OS widening is not the gate in that custom tree. Exact chain requiring clean-ref audit is `_validation_check_unsupported_host_os -> requirements[UNSUPPORTED_HOST_OS] -> _can_patch -> _cant_patch -> self.can_patch -> sys_patch enforcement`.

Haswell payload construction is separate in `intel_haswell.py`; shared Metal payload is `metal_3802.py` and current worktree copy is dirty/custom. An eligibility-only comparator must not modify these payload paths.

## 2026-09-05 — permanent GitHub-first execution policy restored
After a complete reread of the authoritative startup sequence and the repository text/checkpoint/script/workflow corpus, the user explicitly restored GitHub-first as the permanent execution policy.

Major methodology result:
- all work technically executable in GitHub is performed/audited by the assistant in GitHub, including validations, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest, artifact publication/preparation and CI audit;
- ASUS2/user execution is limited to identity-pinned evidence/actions inherently requiring ASUS2 or its installed/live/local-only state;
- GitHub blocker => STOP and exact blocker documentation;
- local compilation is never implicit fallback and requires explicit user authorization;
- Root Patch and reboot remain manual-only and separately authorized.

This supersedes prospectively the 2026-09-03 ASUS2-local-default execution-lane policy. Historical results remain technically unchanged.

No technical frontier changed. Accepted historical baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`; Golden remains immutable/read-only; D50/D68/D82 remain reserve-only. Final identical-OCLP comparator rules from MASTER remain unchanged.

## 2026-09-05 — OCLP 11 resume / Golden root-patch source lineage pinned
The current conversation is **OCLP 11** and resumes directly from D97BD.

User supplied the complete read-only Golden root-patch manifest report for `/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist`.
Exact manifest identity:
- bytes `34173`;
- SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- `Commit URL` = exact upstream `dortania/OpenCore-Legacy-Patcher` commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- OCLP `v2.5.0`;
- PatcherSupportPkg `v1.9.6`;
- manifest OS `24.6 (24H22)`;
- root patch time `September 04, 2026 @ 18:04:54`;
- Metal Library Used `/Library/Application Support/Dortania/MetallibSupportPkg/15.7.9-24G830`.

The manifest records the actual Golden payload inventory including Intel Haswell + Metal 3802 Common/Common Extended + Metal 3802 .metallibs. GitHub verification confirms commit `b9df76...` exists in `dortania/OpenCore-Legacy-Patcher` with message `detect.py: Fix missing import`.

Classification: `GOLDEN_ROOTPATCH_ORIGINAL_OCLP_SOURCE_COMMIT=PINNED_b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

This closes root-patch **source commit lineage** but does not change D97BD app-bundle identity classification: `.app` byte identity remains `INCONCLUSIVE_TOOLING` and is a separate question.

Important correction: exact `dortania/OpenCore-Legacy-Patcher@b9df76...` has `_validation_check_unsupported_host_os()` with `_max_os = os_data.sequoia.value`. Therefore D97BD's `max_os=tahoe` result belongs only to the custom Tahoe/T2 worktree and must not be generalized to ORIGINAL-OCLP.

No eligibility edit is yet authorized. D97BE must audit the full exact `b9df76...` gate chain and determine whether the minimal Tahoe-only delta is merely host-OS max support or whether another clean-ref requirement also blocks patching. Historical payload/compiler adapters remain excluded from the identical-OCLP comparator unless later separately justified.

## CURRENT ACTION — D97BE clean-ref + exact gate-chain audit
Read-only, no source mutation, Root Patch or reboot.
Execution is GitHub-first.
Primary Golden ORIGINAL-OCLP candidate is exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`.
Assistant must audit its exact eligibility chain, compare relevant clean files/refs against Tahoe/T2 refs and the rejected dirty worktree, and prove whether one eligibility-only Tahoe delta is sufficient while leaving Haswell/Metal payloads, selector/compiler/donor logic, request layout and Golden component invariants untouched.
Only after clean baseline + exact gate are proven may an eligibility-only source integration be designed.