# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BF_GITHUB_BUILD_QUOTA_SUSPENDED_EXTERNAL_OR_LOCAL_MAC_BUILD_NEXT.md`
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
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
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

## D97BF pre-build evidence already proven
Before the GitHub compilation stop instruction, CI attempts repeatedly established:
- exact checkout of `b9df76...` = PASS;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- one changed file only: `opencore_legacy_patcher/sys_patch/patchsets/detect.py`;
- diff exactly `1 insertion / 1 deletion` = PASS;
- protected Golden blobs remained byte-identical:
  - constants.py `bdba8738efe1be132427200e0c9a842998e21b86`;
  - os_data.py `094ec597de4ed6b09c42d49d8aceda7888d7fde2`;
  - intel_haswell.py `5ef1ae0f541c413974906a125ad76704680e127c`;
  - metal_3802.py `4276b1aede0134b4d2bbd6980fb3f0e1214302ad`;
  - sys_patch.py `d92544778cba207baa462b1650a6a9a5742d284d`;
  - sys_patch_helpers.py `e4c153e11bd7e5f41c991af83c4c77bc8495a844`;
  - metallib_handler.py `6530e14311fd0ff798395a363ecfc7f4eba78caa`.

The failed attempts observed before the stop instruction were CI/audit-lane failures and do not constitute a proven OCLP functional build failure.

## Frozen historical state
Accepted five-functional diagnostic baseline remains exactly `P1 + P2b + P3 + AIR00 + D34` as project evidence/history, not as default comparator content.
P6/P7 are not sufficient. D50/D68/D82 remain reserve-only. D84 is retired.
Golden installed donor/component hashes and the closed Golden request/producer contract remain unchanged.

## Current execution contract — GitHub compile override
GitHub-first remains the general repository/audit methodology, **but the user has explicitly suspended GitHub compilation until the GitHub Actions quota resets/unblocks**.

Until the user explicitly lifts this restriction:
- no new GitHub Actions compile/build/package run may be started for this project;
- GitHub may be used for source reading, static audit, persistence, checkpointing and metadata operations that do not invoke compilation;
- build/package execution must use a non-GitHub macOS executor;
- local compilation remains subject to explicit user authorization before local commands are issued;
- never auto Root Patch;
- never auto reboot.

## Persistence contract
Persist immediately after decisive PROVEN/NEGATIVE results, integrations/builds, Root Patch results, accelerated-boot results, or major methodology changes. Otherwise persist no later than every 10 substantive technical assistant responses. Update MASTER, HISTORY when phase/history changes, and a new incremental checkpoint; the current checkpoint overlays transient execution state onto the consolidated database.

## CURRENT ACTION — D97BF alternative build lane
**Build/package/audit exact Golden OCLP `b9df76...` with only the one-line Tahoe eligibility edit on a non-GitHub macOS executor.**

Preferred executor order:
1. controlled Intel Mac build, if the user explicitly authorizes local compilation;
2. external macOS CI independent of GitHub Actions quota, with Codemagic currently the strongest free cloud candidate;
3. other macOS CI/trial providers only if needed.

The mandatory D97BF source/audit gates do not change:
- exact commit/tree;
- OCLP 2.5.0 / PatcherSupportPkg 1.9.6 / Tahoe 25;
- exactly one 1/1 detect.py delta;
- protected Golden source identity;
- successful app build;
- verify x86_64 or universal2 architecture;
- artifact SHA256 and bundle/tree manifest;
- STOP before Root Patch.

No Root Patch and no reboot are authorized by this MASTER state.
