# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BE_EXACT_GOLDEN_GATE_CHAIN_PROVEN_ONE_LINE_TAHOE_ELIGIBILITY_D97BF_BUILD_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

## Mandatory startup for every OCLP12/OCLP13/OCLP14/OCLP15+ continuation
Before proposing a technical modification:
1. read `OCLP_PERMANENT_PROJECT_DATABASE.md` in full;
2. read `OCLP_PERMANENT_WORKING_RULES.md` in full;
3. read this MASTER in full;
4. read `OCLP_PERMANENT_VESA_RECOVERY_RULE.md` in full;
5. read the exact current checkpoint named above in full;
6. consult the retrospective and history index to validate strategic/history context when needed.

The consolidated database plus the current checkpoint must be sufficient to resume without asking the user to reconstruct chat history. The checkpoint corpus remains the detailed evidence archive.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Golden is immutable/read-only.

## Exact Golden ORIGINAL-OCLP baseline
Working Golden root-patch manifest pins:
- upstream repository `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`.

The identical-OCLP Tahoe comparator must start from that exact clean commit. The rejected dirty Tahoe/T2 worktree is historical evidence only and is not a comparator source.

## D97BE CLOSED — exact eligibility chain
Exact Golden `detect.py` uses `_max_os = os_data.sequoia.value` while exact Golden `os_data.py` already defines `tahoe = 25`.

Exact gate propagation is:
`_validation_check_unsupported_host_os()`
-> `requirements[UNSUPPORTED_HOST_OS]`
-> `_can_patch(requirements)`
-> `_cant_patch`
-> `self.can_patch`
-> `PatchSysVolume.start_patch()` enforcement.

Exact Haswell/Metal patch construction already remains applicable on Darwin 25. No payload/selector/compiler/donor source edit is required or authorized for this comparator.

Authorized minimal Tahoe functional delta is exactly one line:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

All other original OCLP validation gates remain intact. SIP/FileVault/SecureBootModel/AMFI/repatch/network/download failures are not to be bypassed as part of this experiment.

## Frozen historical state
Accepted five-functional diagnostic baseline remains exactly `P1 + P2b + P3 + AIR00 + D34` as project evidence/history, not as default comparator content.
P6/P7 are not sufficient. D50/D68/D82 remain reserve-only. D84 is retired.
Golden installed donor/component hashes and the closed Golden request/producer contract are recorded in `OCLP_PERMANENT_PROJECT_DATABASE.md` and the checkpoint corpus and remain unchanged.

## Permanent execution contract
GitHub-first is authoritative:
- assistant executes all GitHub-resolvable validation, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/tree manifest, artifact preparation/publication and CI audit;
- ASUS2/user executes only identity-pinned live/local/hardware actions inherently requiring ASUS2, target-local delivery/deploy when needed, opening OCLP, manual Root Patch after authorization, accelerated boot, and VESA recovery;
- GitHub blocker => STOP and document exact blocker;
- local compilation is never implicit fallback and requires explicit user authorization;
- never auto Root Patch;
- never auto reboot.

## Persistence contract
Persist immediately after decisive PROVEN/NEGATIVE results, integrations/builds, Root Patch results, accelerated-boot results, or major methodology changes. Otherwise persist no later than every 10 substantive technical assistant responses. Update the permanent database when durable current state changes, MASTER, HISTORY when phase/history changes, and a new incremental checkpoint.

## CURRENT ACTION — D97BF
**GitHub-first integration/build/package/audit of exact Golden OCLP `b9df76...` with only the one-line Tahoe host-OS eligibility delta.**

Mandatory gates:
1. exact clean checkout of `b9df76...`;
2. verify OCLP `2.5.0`, PatcherSupportPkg `1.9.6`, and `tahoe=25`;
3. apply exactly the one-line `sequoia -> tahoe` replacement in `detect.py`;
4. prove only `detect.py` changed and diff is exactly `1 insertion / 1 deletion`;
5. static/compile validation;
6. prove Haswell/Metal/sys_patch/sys_patch_helpers/selector/donor-sensitive source remains byte-identical to exact Golden commit;
7. build/package in GitHub CI;
8. produce artifact SHA256/tree manifest and provenance/audit report;
9. audit workflow/run/job/artifact completely;
10. only then provide an identity-pinned artifact for ASUS2;
11. STOP before Root Patch.

No Root Patch and no reboot are authorized by this MASTER state.
