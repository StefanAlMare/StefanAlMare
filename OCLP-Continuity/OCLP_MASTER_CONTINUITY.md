# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BF_HISTORICAL_SECOND_TAHOE_GATE_RECONCILED_B9DF76_SCOPE_CORRECTED.md`
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

The identical-OCLP Tahoe comparator must start from that exact clean lineage. The rejected dirty Tahoe/T2 worktree is historical evidence only and is not a comparator source.

## D97BE CLOSED — exact eligibility chain
Exact Golden `detect.py` uses `_max_os = os_data.sequoia.value` while exact Golden `os_data.py` already defines `tahoe = 25`.

Exact gate propagation is:
`_validation_check_unsupported_host_os()`
-> `requirements[UNSUPPORTED_HOST_OS]`
-> `_can_patch(requirements)`
-> `_cant_patch`
-> `self.can_patch`
-> `PatchSysVolume.start_patch()` enforcement.

Exact Haswell/Metal patch construction remains statically applicable on Darwin 25 in exact `b9df76`.

Authorized minimal **static host-eligibility** delta for exact `b9df76` is exactly one line:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

All other original OCLP validation gates remain intact. SIP/FileVault/SecureBootModel/AMFI/repatch/network/download failures are not to be bypassed as part of this experiment.

### Scope correction — historical second Tahoe patchset gate
The user correctly recalled an earlier Tahoe-aware/custom OCLP source in which a second patchset-level blocker existed: legacy GPU classes could be excluded/treated as native on Tahoe, causing them to be skipped or their `patches()` result to be empty.

Exact re-audit of Golden `b9df76...` proves that historical blocker does **not** exist in this lineage:
- `intel_haswell.IntelHaswell` is unconditionally present in `_hardware_variants`;
- `IntelHaswell.native_os()` is exactly `return self._xnu_major < os_data.ventura.value`, so Darwin 25 returns `False`;
- `IntelHaswell.patches()` therefore proceeds to `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific` content;
- `LegacyMetal3802._os_requires_patches()` is `self._xnu_major >= os_data.ventura.value`, with no Tahoe maximum.

Classification:
`HISTORICAL_TAHOE_PATCHSET_NATIVE_OS_BLOCKER_APPLIES_TO_B9DF76=NO`.

Important: the one-line result is **not** a proof that a complete Tahoe Root Patch is sufficient or guaranteed. It proves only the sole currently demonstrated Tahoe-specific static source gate before Haswell patchset generation in exact `b9df76`. Full Root Patch success remains `NOT_YET_PROVEN` and may still depend on MetallibSupportPkg matching, network/package retrieval, SIP/FileVault/SecureBootModel/AMFI/repatch state, root-volume/cache/snapshot behavior, or other Tahoe runtime incompatibility.

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

## User Desktop OpenCore-Patcher.app — exact official Golden lineage proven
Read-only local audit of `/Users/alex/Desktop/OpenCore-Patcher.app` established:
- OCLP `2.5.0`;
- bundle ID `com.dortania.opencore-legacy-patcher`;
- embedded Build Date `2026-03-19 09:33:30`;
- BuildMachineOSBuild `21G531`;
- universal executable `x86_64 arm64`;
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- Developer ID signature `Mykola Grymalyuk (S74BDJXQMD)`;
- strict/deep codesign verification PASS, `codesign_exit=0`;
- signing timestamp displayed locally `19 Mar 2026 at 18:33:46`;
- bundle created `2026-03-19 18:36:42 +0200`;
- payloads present (`payloads.dmg` ~46M, `Universal-Binaries.dmg` ~612M), timestamped `19 Mar 18:32`.

Upstream provenance correlation proves exact source lineage:
- `b9df76...` committed at `2026-03-19T16:31:54Z`;
- official Dortania push workflow run `23305527165` started at `2026-03-19T16:32:02Z` with exact head SHA `b9df76...`;
- job `67778441258`, label `x86_64_monterey`, completed successfully at `16:41:53Z`;
- official `OpenCore-Patcher.pkg` artifact `6010508330` was created at `16:41:49Z`;
- there was no later upstream commit between `16:31:55Z` and `20:00:00Z` that day.

Classification:
`USER_DESKTOP_APP_OFFICIAL_B9DF76_SOURCE_LINEAGE=PROVEN_BY_OFFICIAL_WORKFLOW_PROVENANCE`.

Byte-for-byte identity to the now-expired official artifact remains unavailable and is a separate question:
`USER_DESKTOP_APP_BYTE_IDENTITY_TO_EXPIRED_OFFICIAL_ARTIFACT=UNAVAILABLE_EXPIRED_ARTIFACT`.

Engineering consequence: the user already possesses a valid official universal2 OCLP 2.5.0 app from the exact Golden source lineage. A full fresh build is no longer the only possible route; a deterministic modification of a copy of the frozen PyInstaller module may be viable.

## User local OpenCore-Patcher.pkg
TrueNAS Reader manifest for batch `20260904T225753Z-dv103208c1-178bdb6a` identifies:
- `OpenCore-Patcher.pkg`;
- bytes `738123183`;
- SHA256 `b4e32cbfb1f978f670ccafff7b513d352e0665366caa73faeed0dbcd428dc364`.

The original PKG remains preserved as evidence. Its byte identity to a public reshared 2.5.0 nightly is NEGATIVE by size only; this does not contradict the now-proven source lineage of the Desktop `.app`.

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
- local compilation remains subject to explicit user authorization before local build commands are issued;
- never auto Root Patch;
- never auto reboot.

## Persistence contract
Persist immediately after decisive PROVEN/NEGATIVE results, integrations/builds, Root Patch results, accelerated-boot results, or major methodology changes. Otherwise persist no later than every 10 substantive technical assistant responses. Update MASTER, HISTORY when phase/history changes, and a new incremental checkpoint; the current checkpoint overlays transient execution state onto the consolidated database.

## CURRENT ACTION — expanded read-only frozen-app eligibility audit
Before deciding between direct app patching and a full build, audit the proven Desktop app read-only:
1. identify the PyInstaller archive structure and available archive-viewer tooling;
2. prove frozen module location/content for `opencore_legacy_patcher.sys_patch.patchsets.detect`;
3. also prove frozen `opencore_legacy_patcher.sys_patch.patchsets.hardware.graphics.intel_haswell` matches exact `b9df76` selection/native/patch composition;
4. verify packaged MetallibSupportPkg resolution and determine whether target `26.6.2 / 25G82` has a usable local or remote MetallibSupportPkg match;
5. only then determine whether one frozen-module edit is sufficient for the comparator app;
6. preserve the current Desktop app unchanged as the proven reference.

If direct frozen-module patching proves unsafe/non-deterministic, fall back to the previously defined non-GitHub exact-source build lane; local compilation still requires explicit user authorization.

No Root Patch and no reboot are authorized by this MASTER state.
