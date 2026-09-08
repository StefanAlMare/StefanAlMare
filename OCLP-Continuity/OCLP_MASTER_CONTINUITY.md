# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HI_P1_REGEX_AUDIT_FALSE_NEGATIVE_SUSPECT_D97HM_AST_RESUME_READY.md`
- commit `6bdc32e965ba98f2726d91a5896d86ccb7e62824`.

Immediate decisive predecessors:
- portable Intel host ready — `018c46a1d853c93617338d630e7beb7afe323b21`;
- D97HG exact P3-only reconstruction PASS / D97HI build authorized — `3aa5c5ea432b99fd538c44eb9bfe0ab481bf71ec`;
- D97HF P1 runtime semantic progress / measured P3 frontier — `1af98134a40236290484037548dfba621df1c626`;
- first post-P1 accelerated no-GUI / VESA recovery — `52125fed156f25c9f08ef611e7876793eab5e42a`;
- D97HD active P1 VESA snapshot PASS + D97EW live gate PASS — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.
Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only. Never compile on ASUS2.

## Build-host authority
Home Intel iMac remains valid. Current work MacBook Pro is explicitly authorized as a portable non-target Intel build host because it passed x86_64/Xcode/Python/toolchain/free-space preflight and all source reconstruction is exact/hash-gated.

## Current measured compiler state
- P1 runtime semantic progress PROVEN: old `RIP=0 / r15=32023 / MTLConnectionCtx+56` absent 9/9 current crashes.
- Current 9/9 frontier: `MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
- P2b is NOT justified as the next patch.
- P3 serialized-bitcode bridge is measured/historically causal.
- D97HG P3-only reconstruction changed exactly `0xA1574: e1->c9`, giving exact post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
- AIR00/D34 remain unauthorized.

## Portable bootstrap progress
D97HL/D97HK on the work Mac successfully:
- verified exact historical authority blobs;
- cloned exact upstream b9df76/tree;
- recreated D97DX source diff exact `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- created Python 3.13 x86_64 venv and installed requirements;
- regenerated exact Universal-Binaries SHA `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- recreated exact D97GS source diff `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inserted D97HI P3 and produced full current D97HI source diff `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

## Current stop — P1 audit boundary issue
D97HI stopped before compilation because a regex-delimited P1 source capture changed hash after a new method was inserted immediately after P1:
- pre `4302a73061f15f373cc0167c3f921b1aefc93e10f95932ecc1c20cacebb2ddb3`;
- post `e1be3d2b40f084d1fa42a74df0950d58c94be4b9867ae70f0366df07f6c71fad`.

This is `INCONCLUSIVE_TOOLING_BOUNDARY`, not yet proven false-negative and not evidence that P1 changed. No build occurred.

## CURRENT ACTION — D97HM AST-bounded P1 audit + resume inner build
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HM_RESUME_AFTER_P1_AUDIT_FALSE_NEGATIVE_AND_BUILD_INNER.sh`
- commit `ac528a97f01fc31d5bd629371d3a86b2df16c4ab`;
- blob `81a4079447e884ee0c8bb7dbf48b4662a45a0da6`.

D97HM must:
1. require current full source diff exactly `c4590568...`;
2. reconstruct exact D97GS from saved patch `cae9c...` in a temporary detached worktree;
3. extract P1 in both sources using Python AST FunctionDef `lineno/end_lineno` boundaries;
4. compare actual P1 function bytes exactly, excluding only blank separator lines between methods;
5. stop if any actual P1 byte differs;
6. verify P3 constants/hook/order and current full source identity;
7. reuse existing venv/assets and build/package D97HI inner app only.

No wrapper assembly, target transfer, Root Patch, reboot, acceleration, P2b, AIR00 or D34 is authorized until D97HM PASS and an independent inner audit.
