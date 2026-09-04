# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97BD_ELIGIBILITY_PREFLIGHT_PASS_DIRTY_CUSTOM_TREE_CLEAN_REF_AND_GATE_CHAIN_NEXT.md`.
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

Critical eligibility result: current `patchsets/detect.py` already sets `_max_os = os_data.tahoe.value`, so simple max-OS widening is NOT the gate. Exact chain requiring clean-ref audit is `_validation_check_unsupported_host_os -> requirements[UNSUPPORTED_HOST_OS] -> _can_patch -> _cant_patch -> self.can_patch -> sys_patch enforcement`.

Haswell payload construction is separate in `intel_haswell.py`; shared Metal payload is `metal_3802.py` and current worktree copy is dirty/custom. An eligibility-only comparator must not modify these payload paths.

## CURRENT ACTION — D97BE clean-ref + exact gate-chain audit
Read-only, no source mutation, Root Patch or reboot.
Compare candidate clean ref/tag `8969550`, committed HEAD `4143b707...`, existing `origin/main` and `origin/Development`, plus current worktree, with exact hashes and targeted function bodies for detect.py/sys_patch.py/intel_haswell.py/metal_3802.py/sys_patch_helpers.py/datasets/os_data.py.
Prove ancestry; recover exact eligibility chain; inspect Golden root-patch manifest/version markers and corrected app identity if available. Only after clean baseline + exact gate are proven may an eligibility-only source integration be designed.