# OCLP PERMANENT PROJECT DATABASE — ASUS2 Tahoe Haswell

Updated: 2026-09-05 EEST
Scope: **all continuations OCLP 11, OCLP 12, OCLP 13, OCLP 14, OCLP 15 and later**.
Purpose: this is the consolidated durable project-state database. A future conversation must be able to understand the project from this file plus the current checkpoint, without reconstructing state from scattered chat fragments.

This file summarizes the current authoritative state. Detailed evidence remains preserved in MASTER, HISTORY, RETROSPECTIVE and the immutable checkpoint corpus. When a conflict exists, the newest authoritative checkpoint explicitly linked by MASTER wins for the current frontier; permanent safety/methodology rules remain governed by `OCLP_PERMANENT_WORKING_RULES.md` and `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

---

## 1. End goal
Run macOS Tahoe `26.6.2 / 25G82` on ASUS2 with Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, with a stable hardware-accelerated graphical image and usable GUI.

The project is not satisfied by hiding a crash or forcing WindowServer to continue. The objective is to identify and correct the earliest causal incompatibility while preserving the working downstream OCLP/Sequoia donor contract whenever possible.

---

## 2. Current authoritative architecture

`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`

Strategic comparator rule:
- Golden Sequoia is the working oracle.
- Tahoe must receive the **same ORIGINAL OCLP functional root-patch content** as Golden.
- Historical experimental Tahoe compiler/payload mutations are **not** imported into the identical-OCLP comparator by default.
- Only the smallest separately audited Tahoe host-OS eligibility delta is permitted before the controlled comparison.

---

## 3. Golden systems and immutable rule

### GOLDEN_A
- macOS Sequoia `15.7.9 / 24G830`.
- Historical D97AU/D97AX/D97AY runtime/static oracle.

### GOLDEN_B
- macOS Sequoia `15.8 / 24H22`.
- Same EFI according to user.
- Original OCLP Root Patch manually reapplied.
- Hardware acceleration works.

Golden is **immutable/read-only**. Never boot or modify Golden merely to collect new evidence. Use persisted evidence or read-only mounted/static inspection only when genuinely necessary.

---

## 4. Exact Golden ORIGINAL-OCLP source lineage
Working Golden root-patch manifest:
`/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist`

Manifest identity:
- bytes: `34173`;
- SHA256: `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- OCLP: `v2.5.0`;
- PatcherSupportPkg: `v1.9.6`;
- manifest OS: `24.6 (24H22)`;
- Time Patched: `September 04, 2026 @ 18:04:54`;
- Metal Library Used: `/Library/Application Support/Dortania/MetallibSupportPkg/15.7.9-24G830`;
- Commit URL pins exact upstream source commit:
  `dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

Classification:
`GOLDEN_ROOTPATCH_ORIGINAL_OCLP_SOURCE_COMMIT=PINNED_b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

Important distinction:
- root-patch source commit lineage is pinned;
- byte identity of the Golden `.app` bundle was previously `INCONCLUSIVE_TOOLING` because of path aliasing and remains a separate evidence question.

---

## 5. Golden installed component invariants
Donor/compiler components:
- 32023 SHA256: `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA256: `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA256: `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Haswell components:
- AppleIntelFramebufferAzul binary SHA256: `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics binary SHA256: `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver binary SHA256: `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

Original selector mapping:
- request `3802 -> Versions/3802`;
- request `31001 -> Versions/32023`.

---

## 6. Golden request/producer contract closure
Receiver XPC schema:
- `requestType:uint64`;
- `sandboxTokens:value`;
- `llvmVersion:uint64`;
- `pluginPath:string`;
- `targetData:value`;
- `data:value`;
- `client_name:string`;
- `timeout:uint64`.

Primary Golden request builder:
- function region `0x7FF80D370756..0x7FF80D370C28` identified via LC_FUNCTION_STARTS;
- `RBX = ABI arg1/RDI`;
- signed dword `[RBX+0x20] -> llvmVersion`;
- `R13 = ABI arg2/RSI`;
- dword `[R13+0x08] -> requestType`;
- qword `[R13+0x18] -> timeout`;
- byte `[R13+0x70]` gates `sandboxTokens`;
- alternate requestType path uses immediate `9`.

Classifications:
- RBX/R13 origin: `STATIC_ABI_ORIGIN_PROVEN`;
- llvmVersion source: `STATIC_VALUE_SOURCE_PROVEN`.

Golden dual-generation runtime evidence remains authoritative: observed 3802 donor traffic corresponds to request llvmVersion 3802 and observed 32023 donor traffic corresponds to request llvmVersion 31001 under unchanged selector semantics.

---

## 7. Historical accepted functional baseline
Exactly five historical functional patches remain the accepted diagnostic baseline:
1. P1 selector bridge;
2. P2b request-layout bridge `request+0xD0 -> request+0x110`;
3. P3 serialized-bitcode path;
4. AIR00 fallback producing AIR 2.6 / Metal 3.1;
5. D34 semantic-equivalent reset.

True-five SHA historically recorded:
`6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

D22 remains semantic proof for the relevant AIR 2.6 / Metal 3.1 state.

These five are **evidence/diagnostic history**, not automatically part of the new identical-OCLP comparator.

Reserve/retired status:
- P6/P7: retained evidence but runtime sufficiency NEGATIVE;
- D50/D68/D82: reserve-only unless explicitly promoted by a new authoritative checkpoint;
- D84: retired/withdrawn;
- D36-D44: invalidated because of protected D34 cave overlap.

---

## 8. Retained causal model
Strong downstream model:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

WindowServer is downstream; it is not treated as root cause.

Proven far-frontier evidence may legitimately move investigation downstream without linearly re-proving every earlier address, provided semantic handoff discipline remains intact.

---

## 9. Current rejected Tahoe/T2 experimental worktree
Observed historical/canonical local source path:
`/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`

Observed state in D97BD/OCLP11 continuity:
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- branch `alex-tahoe-25G82-custom`;
- prior/tag `8969550` (`4.0.0.16900` / `4.0.0.16047`);
- `origin/main e371b71468464ea3a13b8b82c3ca5298a71df141`;
- `origin/Development 85ea01b333c9a7e50c44f054a52614425c3058a2`.

Tracked dirty files included:
- `sys_patch/patchsets/shared_patches/metal_3802.py`;
- `sys_patch/sys_patch.py`;
- `sys_patch/sys_patch_helpers.py`;
plus historical D97/.before material.

Classification:
`TAHOE_CURRENT_WORKTREE_IDENTICAL_OCLP_BASELINE=REJECTED_DIRTY_CUSTOM`.

Never clean/reset/mutate this worktree merely to manufacture a comparator. It is historical evidence, not the source of the identical-OCLP build.

---

## 10. D97BE exact Golden eligibility audit — CLOSED
Exact source audited:
`dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

Exact `detect.py` host OS gate:
- `_min_os = os_data.big_sur.value`;
- `_max_os = os_data.sequoia.value`;
- outside range -> `UNSUPPORTED_HOST_OS=True`.

Exact propagation:
`_validation_check_unsupported_host_os()`
-> `requirements[UNSUPPORTED_HOST_OS]`
-> `_can_patch(requirements)`
-> `_cant_patch`
-> `self.can_patch`
-> `PatchSysVolume.start_patch()` enforcement.

Exact `os_data.py` already defines:
- `sequoia = 24`;
- `tahoe = 25`.

Exact Haswell path already remains applicable on Darwin 25:
- Haswell is non-native from Ventura onward;
- MetallibSupportPkg is required from Sequoia onward;
- original `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell model-specific` patch composition remains active.

Exact `metallib_handler.py` uses the dynamic Dortania MetallibSupportPkg manifest and has no fixed Tahoe maximum.

D97BE conclusion:
`D97BE_MINIMAL_TAHOE_DELTA=ONE_LINE_DETECT_MAX_OS_SEQUOIA_TO_TAHOE`.

Authorized functional delta for the comparator:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

No other functional source change is authorized before the controlled Tahoe comparator Root Patch.

Other original OCLP validations remain intact: SIP, FileVault, SecureBootModel, AMFI, repatching state, network/download requirements, etc. They may independently block patching and must not be bypassed as part of this experiment.

---

## 11. CURRENT TECHNICAL FRONTIER
**D97BF — GitHub-first build/package/audit of exact Golden OCLP + one-line Tahoe eligibility.**

Mandatory build contract:
1. checkout exact upstream `b9df76...`;
2. verify clean source identity;
3. verify OCLP `2.5.0`, PatcherSupportPkg `1.9.6`, `tahoe=25`;
4. apply exactly one replacement in `detect.py`;
5. require exactly one changed file and exactly `1 insertion / 1 deletion`;
6. static/compile validation;
7. hash-prove protected functional files unchanged;
8. build/package in GitHub CI;
9. create artifact SHA/tree manifest and CI provenance report;
10. audit workflow/run/job/artifact;
11. deliver only identity-pinned artifact to ASUS2;
12. STOP before Root Patch;
13. manual Root Patch only after explicit assistant authorization;
14. reboot only after Root Patch output is fully audited and separately authorized.

---

## 12. Permanent execution responsibility
**GitHub-first is authoritative.**

Assistant/GitHub executes whenever technically possible:
- source/reference audits;
- validation;
- source/workflow integration;
- compile/diff;
- build/package;
- packaged-app audit;
- SHA/tree manifest;
- artifact publication/preparation;
- CI workflow/run/job audit.

ASUS2/user performs only actions inherently bound to ASUS2/live state:
- local hardware/cache/files/log evidence unavailable remotely;
- target-local download/identity verification/backup/deploy where necessary;
- opening OCLP;
- manual Root Patch after explicit authorization;
- accelerated boot after separate authorization;
- VESA recovery and physical boot actions.

If GitHub is genuinely blocked for a GitHub-eligible action, STOP and document the blocker. Local compilation is not an automatic fallback and requires explicit user authorization.

Never auto Root Patch. Never auto reboot.

---

## 13. Permanent diagnostic methodology
- Evidence classes must remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.
- Module-boundary methodology is default.
- At large boundaries ask simultaneously: where execution went, and whether payload/state remains good.
- Whole-stage/multi-threshold diagnostics are preferred over one-address/one-reboot scans.
- Universal/no-PID coverage is required where requests or compiler-service processes can vary.
- Same-cohort rules apply to mutually exclusive sampled classifiers.
- Tooling failure or absent visibility is never silently promoted to a biological/technical hypothesis.
- Capture raw evidence first; interpretation second.
- Candidate and proven states remain distinct.
- D34 cave `0xEF8..0xEFE` is protected.

---

## 14. Permanent accelerated-boot/VESA rule
After a Root Patch test, accelerated boot may produce no usable image. Normal recovery is hard restart/power cycle followed by VESA boot.

Therefore the current/latest boot after the user returns is often the VESA recovery session; analyze the immediately preceding accelerated diagnostic boot, not blindly the latest boot.

Use `last reboot` chronology and the user’s explicit identification of accelerated vs VESA sessions. Never mix logs from VESA recovery into the accelerated diagnostic evidence window.

---

## 15. Persistence contract / anti-loss policy
Persist immediately after every decisive PROVEN/NEGATIVE result, functional integration, build/package result, Root Patch result, accelerated-boot result, or major methodology decision.

Mandatory persistence targets:
- this permanent database when current durable state changes;
- `OCLP_MASTER_CONTINUITY.md`;
- `OCLP_HISTORY_INDEX.md` when phase/history changes;
- one new incremental checkpoint.

If no decisive result occurs, persist a continuity checkpoint **no later than every 10 substantive technical assistant responses**. This is a hard anti-loss ceiling, not a target to delay saving. Saving more often is allowed and preferred before risky operations or conversation boundaries.

At each persistence event, the periodic-response count is conceptually reset to zero.

---

## 16. Future-conversation startup protocol
For OCLP12/OCLP13/OCLP14/OCLP15+:
1. read this file in full;
2. read `OCLP_PERMANENT_WORKING_RULES.md` in full;
3. read `OCLP_MASTER_CONTINUITY.md` in full;
4. read `OCLP_PERMANENT_VESA_RECOVERY_RULE.md` in full;
5. read the exact `Current authoritative checkpoint` named by MASTER in full;
6. consult `OCLP_PROJECT_RETROSPECTIVE_20260827.md` and `OCLP_HISTORY_INDEX.md` for strategic/history validation when needed.

Do not ask the user to reconstruct persisted history. Do not resume from memory or chat fragments when repository authority is available.

---

## 17. Full-detail archive map
- Permanent procedure: `OCLP_PERMANENT_WORKING_RULES.md`.
- Current frontier/index: `OCLP_MASTER_CONTINUITY.md`.
- Permanent recovery rule: `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
- Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.
- Chronological phase index: `OCLP_HISTORY_INDEX.md`.
- Full experiment/evidence lineage: `OCLP-Continuity/checkpoints/`.
- Current D97BE closure checkpoint: `OCLP7_CHECKPOINT_20260905_D97BE_EXACT_GOLDEN_GATE_CHAIN_PROVEN_ONE_LINE_TAHOE_ELIGIBILITY_D97BF_BUILD_NEXT.md`.

This database is intended to make the project immediately intelligible to a new continuation while preserving the detailed checkpoint corpus as the evidence archive.
