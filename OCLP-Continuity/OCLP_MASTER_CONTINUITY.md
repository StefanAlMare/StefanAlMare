# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HM_PORTABLE_D97HI_INNER_BUILD_PASS_D97HN_AUDIT_NEXT.md`
- commit `7fa87cc64fb44b4b1d527261c8e233197090ef09`.

Immediate decisive predecessors:
- D97HI regex P1 audit tooling-boundary / D97HM AST resume ready — `6bdc32e965ba98f2726d91a5896d86ccb7e62824`;
- portable Intel host ready — `018c46a1d853c93617338d630e7beb7afe323b21`;
- D97HG exact P3-only reconstruction PASS — `3aa5c5ea432b99fd538c44eb9bfe0ab481bf71ec`;
- D97HF P1 runtime semantic progress / measured P3 frontier — `1af98134a40236290484037548dfba621df1c626`;
- D97HD active P1 VESA snapshot PASS + D97EW live gate PASS — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.
Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only. Never compile on ASUS2.

Portable non-target Intel build hosts are allowed only with exact source/provenance/hash gates. Current work MacBook Pro passed this requirement.

## Current measured compiler state
- P1 runtime semantic progress PROVEN: old `RIP=0 / r15=32023 / MTLConnectionCtx+56` absent 9/9 current crashes.
- Current measured frontier: `MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
- P2b is NOT justified as current next patch.
- P3 serialized-bitcode bridge is measured/historically causal.
- D97HG exact P3-only post-SHA: `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
- AIR00/D34 remain unauthorized.

## D97HM — P1 audit corrected and D97HI inner build PASS
The prior regex-based P1 hash mismatch was a tooling-boundary false negative. D97HM reconstructed exact D97GS in a temporary worktree and compared the AST-bounded P1 FunctionDef bytes.

Exact P1 audit:
- pre/post bytes `3466 / 3466`;
- pre/post SHA256 `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`;
- `D97HM_P1_AST_BYTE_IDENTICAL=PASS`;
- `D97HM_P1_FUNCTION_PRESERVED_EXACT=PASS`.

P3 source contract:
- method/hook/pre-SHA/post-SHA/offset/preimage/postimage each exactly once;
- hook order P1 -> P3 -> continuation PASS;
- `D97HM_P3_SOURCE_CONTRACT=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

Current exact source identities:
- D97GS diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- D97HI diff SHA `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

Built D97HI portable inner artifact:
- x86_64;
- executable SHA256 `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- ZIP `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.zip`;
- ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- ZIP bytes `722927108`.

Functional classification:
`D97HI_STATUS=BUILD_PASS_PORTABLE_INNER`
`D97HI_NEW_FUNCTIONAL_DELTA=P3_ONLY`
`D97HI_P1_BASE=PRESERVED_EXACT`
`D97HI_P2B_REPLAY=NO`
`D97HI_AIR00_REPLAY=NO`
`D97HI_D34_REPLAY=NO`.

No Root Patch, wrapper assembly, target transfer or reboot occurred.

## CURRENT ACTION — D97HN independent inner artifact audit
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HN_INDEPENDENT_D97HI_INNER_ARTIFACT_AUDIT.sh`
- commit `a73152b6ed715fa76428320f08bce843c4b11b5d`.

D97HN must independently prove:
1. current D97HI source diff exact `c4590568...` and changed-file set exact;
2. reconstructed D97GS reference exact `cae9c...`;
3. P1 AST-bounded bytes identical to D97GS;
4. P3-only source contract and hook ordering exact;
5. inner app codesign + x86_64 + executable SHA exact `1c3760fc...`;
6. ZIP SHA/bytes exact `b0fe14f2... / 722927108`;
7. extracted ZIP inner executable identity exact;
8. file/symlink manifest of extracted ZIP identical to the built inner app.

No transfer to ASUS2, wrapper assembly, Root Patch, reboot, acceleration, P2b, AIR00 or D34 is authorized until D97HN PASS is reviewed.
