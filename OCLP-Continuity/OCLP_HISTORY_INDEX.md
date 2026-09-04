# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BF_HISTORICAL_SECOND_TAHOE_GATE_RECONCILED_B9DF76_SCOPE_CORRECTED.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is the chronological high-level index. The full experiment/evidence lineage is preserved in `OCLP-Continuity/checkpoints/`; the consolidated current state is in `OCLP_PERMANENT_PROJECT_DATABASE.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture evolution
Historical architecture converged from local compiler/payload adaptation toward the current controlled comparator:
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver -> image`.

The current experiment deliberately removes historical custom Tahoe OCLP payload/compiler edits and uses the same ORIGINAL OCLP functional root-patch content as the working Golden Sequoia system, with only the smallest separately audited Tahoe host-OS eligibility delta.

## Historical accepted functional baseline
The accepted diagnostic five-functional baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

It remains project evidence/history and is not silently imported into the identical-OCLP comparator.
P6/P7 were not sufficient. D50/D68/D82 remain reserve-only. D84 is retired. D36-D44 were invalidated for D34 cave overlap.

## Durable causal model
Compiler-service failure precedes XPC interruption, pipeline creation failure, SkyLight/CopyPipelineState abort, and WindowServer death. WindowServer is downstream rather than the root cause.

Methodology evolved to module-boundary + semantic evidence + far-frontier, with universal/no-PID observation where request/process variability can occur.

## 2026-09-01 to 2026-09-04 — D97 provenance/producer closure
The D97 sequence established, among other durable results:
- runtime llvmVersion/provenance work;
- selector and donor generation mapping;
- correction of false-negative/inconclusive tooling classifiers;
- universal observer methodology;
- Golden comparator capture;
- Golden request-builder XPC schema and producer ABI closure.

Key Golden producer closure:
- request builder `0x7FF80D370756..0x7FF80D370C28`;
- RBX = ABI arg1/RDI and `[RBX+0x20] -> llvmVersion`;
- R13 = ABI arg2/RSI and `[R13+0x08] -> requestType`, `[R13+0x18] -> timeout`, `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`.

Detailed evidence remains in the checkpoint corpus.

## D97BD — identical-OCLP Tahoe eligibility preflight
D97BD PASS established the controlled transition from Golden characterization to identical-OCLP Tahoe comparison.

The historical/current Tahoe/T2 local worktree was rejected as comparator baseline because it was dirty/custom in `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py` and contained extensive D97/.before material.

D97BD also preserved additional Golden component invariants and identified the complete host eligibility chain requiring exact clean-ref audit.

## 2026-09-05 — permanent GitHub-first execution policy restored
User explicitly made GitHub-first the default repository/execution contract:
- assistant executes work technically resolvable in GitHub;
- ASUS2 is used only for identity-pinned local/live/hardware evidence and unavoidable target-local actions, manual Root Patch after authorization, accelerated boot and VESA recovery;
- local compilation is never implicit fallback;
- never auto Root Patch or reboot.

This general policy remains historical authority, subject to explicit later user overrides such as the current temporary GitHub compilation suspension.

## 2026-09-05 — OCLP11 Golden source lineage pinned
User supplied the working Golden root-patch manifest from `/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist`.

It pinned:
- manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- OCLP `v2.5.0`;
- PatcherSupportPkg `v1.9.6`;
- exact upstream source commit `dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

This closed root-patch source lineage.

## 2026-09-05 — D97BE exact Golden eligibility chain CLOSED
Exact `b9df76...` audit proved:
- `detect.py` has `_max_os = os_data.sequoia.value`;
- exact `os_data.py` already has `tahoe = 25`;
- unsupported host OS propagates through `requirements[UNSUPPORTED_HOST_OS] -> _can_patch -> _cant_patch -> self.can_patch`;
- `PatchSysVolume.start_patch()` blocks when `can_patch` is false;
- exact Haswell path remains non-native/patchable on Darwin 25;
- exact Haswell patch composition remains original `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell model-specific`;
- MetallibSupportPkg lookup is dynamic and has no static Tahoe maximum.

Therefore the minimal identical-OCLP Tahoe static host-eligibility delta is exactly:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

No payload, selector, compiler, donor, request-layout, Haswell, Metal3802, sys_patch or sys_patch_helpers functional edit is authorized by this static result alone.

## 2026-09-05 — continuity database systematized
Created `OCLP_PERMANENT_PROJECT_DATABASE.md` as the consolidated durable state for OCLP12/OCLP13/OCLP14/OCLP15+.

Anti-loss policy: persist decisive results immediately; otherwise create a continuity checkpoint no later than every 10 substantive technical assistant responses.

## 2026-09-05 — D97BF pre-build identity gates proven
Before the GitHub compilation stop instruction, CI attempts established reusable pre-build evidence:
- exact Golden commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e` checkout PASS;
- exact Golden tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- exactly one changed source file: `detect.py`;
- exactly `1 insertion / 1 deletion`;
- protected Golden files remained byte-identical with recorded Git blob identities:
  - constants.py `bdba8738efe1be132427200e0c9a842998e21b86`;
  - os_data.py `094ec597de4ed6b09c42d49d8aceda7888d7fde2`;
  - intel_haswell.py `5ef1ae0f541c413974906a125ad76704680e127c`;
  - metal_3802.py `4276b1aede0134b4d2bbd6980fb3f0e1214302ad`;
  - sys_patch.py `d92544778cba207baa462b1650a6a9a5742d284d`;
  - sys_patch_helpers.py `e4c153e11bd7e5f41c991af83c4c77bc8495a844`;
  - metallib_handler.py `6530e14311fd0ff798395a363ecfc7f4eba78caa`.

The failed attempts observed at that stage were audit/workflow-lane failures, not a proven OCLP functional build failure.

## 2026-09-05 — GitHub compilation suspended by explicit user instruction
The user explicitly instructed that no more GitHub compilation/build jobs be used until the GitHub Actions quota resets/unblocks.

Current override:
- no new GitHub Actions compile/build/package run;
- GitHub remains usable only for non-compiling source reads, static audit, persistence/checkpoints and metadata work;
- D97BF must move to a non-GitHub macOS executor if a full build is needed;
- local compilation still requires explicit user authorization before issuing local build commands.

## 2026-09-05 — user local OpenCore-Patcher.pkg identified as strong Golden-lineage candidate
TrueNAS Reader manifest identified:
- batch `20260904T225753Z-dv103208c1-178bdb6a`;
- `OpenCore-Patcher.pkg`;
- bytes `738123183`;
- SHA256 `b4e32cbfb1f978f670ccafff7b513d352e0665366caa73faeed0dbcd428dc364`.

A public reshared 2.5.0 nightly package had a different byte size, which did not disprove common source lineage because build/package metadata vary.

## 2026-09-05 — Desktop OpenCore-Patcher.app exact official b9df76 lineage PROVEN
The user performed a read-only audit of `/Users/alex/Desktop/OpenCore-Patcher.app`.

Observed app evidence:
- OCLP `2.5.0`;
- Build Date `2026-03-19 09:33:30`;
- BuildMachineOSBuild `21G531`;
- universal `x86_64 arm64` executable;
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- valid Developer ID signature from `Mykola Grymalyuk (S74BDJXQMD)`;
- strict/deep codesign verification PASS (`codesign_exit=0`);
- signing timestamp displayed locally `19 Mar 2026 at 18:33:46`;
- bundle created `2026-03-19 18:36:42 +0200`;
- payloads present and timestamped `19 Mar 18:32`.

Upstream GitHub provenance then established:
- exact Golden commit `b9df76...` was created at `2026-03-19T16:31:54Z`;
- official Dortania push run `23305527165`, exact head SHA `b9df76...`, started at `16:32:02Z`;
- successful job `67778441258` used label `x86_64_monterey` and completed `16:41:53Z`;
- official `OpenCore-Patcher.pkg` artifact `6010508330` was created at `16:41:49Z`;
- no later upstream commit existed from `16:31:55Z` through `20:00:00Z` that day.

Classification:
`USER_DESKTOP_APP_OFFICIAL_B9DF76_SOURCE_LINEAGE=PROVEN_BY_OFFICIAL_WORKFLOW_PROVENANCE`.

Exact byte identity to the expired official artifact cannot now be re-proved and remains separately `UNAVAILABLE_EXPIRED_ARTIFACT`.

Engineering consequence: a fresh full application build is no longer the only possible path. First audit the frozen PyInstaller archive read-only before any direct modification.

## 2026-09-05 — historical second Tahoe patchset blocker reconciled with exact b9df76
User correctly recalled an earlier Tahoe-aware/custom OCLP source in which legacy graphics could be blocked after the global host-OS gate by patchset selection/native-OS logic.

Re-audit of exact Golden `b9df76...` proved that specific historical blocker is absent here:
- Haswell is unconditionally listed in `_hardware_variants`;
- `IntelHaswell.native_os()` is only `xnu < Ventura`, therefore false on Darwin 25;
- `IntelHaswell.patches()` continues to `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific` patches;
- `LegacyMetal3802._os_requires_patches()` is `xnu >= Ventura`, with no Tahoe maximum.

Classification:
`HISTORICAL_TAHOE_PATCHSET_NATIVE_OS_BLOCKER_APPLIES_TO_B9DF76=NO`.

Scope correction: the one-line `detect.py` edit is proven only as the required Tahoe-specific **static host-eligibility gate** before Haswell patchset generation. It is not proof that the entire Root Patch procedure will succeed on Tahoe. Full Root Patch remains `NOT_YET_PROVEN` and still depends on MetallibSupportPkg matching, ordinary validation gates, root-volume/cache/snapshot behavior, and any other Tahoe runtime incompatibility.

## CURRENT ACTION — expanded read-only frozen-app eligibility audit
On the preserved Desktop app:
- identify the PyInstaller archive layout/viewer path;
- locate and verify frozen `opencore_legacy_patcher.sys_patch.patchsets.detect`;
- locate and verify frozen `opencore_legacy_patcher.sys_patch.patchsets.hardware.graphics.intel_haswell` against exact b9df76;
- verify packaged MetallibSupportPkg resolution and whether `26.6.2 / 25G82` has a usable local or remote match;
- only then decide whether a one-module direct patch is sufficient for the comparator app.

If direct frozen-module patching is unsafe/non-deterministic, return to exact-source build on a non-GitHub macOS executor. Local compilation still requires explicit user authorization. GitHub compilation remains suspended until explicit quota-reset confirmation.
No Root Patch and no reboot are authorized at this point.
