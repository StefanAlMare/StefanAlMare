# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BF_GITHUB_BUILD_QUOTA_SUSPENDED_EXTERNAL_OR_LOCAL_MAC_BUILD_NEXT.md`.
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

This closed root-patch source lineage. Golden `.app` byte identity remains a separate historical `INCONCLUSIVE_TOOLING` question and is not required for the source-controlled comparator.

## 2026-09-05 — D97BE exact Golden eligibility chain CLOSED
Exact `b9df76...` audit proved:
- `detect.py` has `_max_os = os_data.sequoia.value`;
- exact `os_data.py` already has `tahoe = 25`;
- unsupported host OS propagates through `requirements[UNSUPPORTED_HOST_OS] -> _can_patch -> _cant_patch -> self.can_patch`;
- `PatchSysVolume.start_patch()` blocks when `can_patch` is false;
- exact Haswell path remains non-native/patchable on Darwin 25;
- exact Haswell patch composition remains original `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell model-specific`;
- MetallibSupportPkg lookup is dynamic and has no static Tahoe maximum.

Therefore the minimal identical-OCLP Tahoe functional delta is exactly:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

No payload, selector, compiler, donor, request-layout, Haswell, Metal3802, sys_patch or sys_patch_helpers functional edit is authorized.

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
- D97BF must move to a non-GitHub macOS executor;
- local compilation still requires explicit user authorization before issuing local build commands.

Alternative ranking recorded in the current checkpoint:
1. controlled Intel Mac build — technically preferred;
2. Codemagic individual/free macOS M2 build — best current free cloud candidate, subject to strict x86_64/universal2 post-build audit;
3. other macOS CI providers if needed.

## CURRENT ACTION — D97BF alternative executor
Build/package/audit exact Golden OCLP `b9df76...` + only the one-line Tahoe eligibility delta on a non-GitHub macOS executor.

Mandatory acceptance remains:
- exact commit/tree;
- one-file/one-line diff proof;
- protected source identity;
- successful OCLP 2.5.0 app build;
- x86_64 or universal2 architecture proof;
- SHA256 + bundle/tree manifest;
- identity-pinned delivery;
- STOP before manual Root Patch.

No Root Patch and no reboot are authorized at this point.
