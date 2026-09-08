# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HN_INDEPENDENT_INNER_AUDIT_PASS_D97HO_WRAPPER_ASSEMBLY_READY.md`
- commit `d169d7c63c7d69b3b9f49ce8dd12d8512bf8e546`.

Immediate decisive predecessors:
- D97HM portable D97HI inner build PASS / D97HN next — `7fa87cc64fb44b4b1d527261c8e233197090ef09`;
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
Portable non-target Intel build hosts are allowed only with exact source/provenance/hash gates.

## Current measured compiler state
- P1 runtime semantic progress PROVEN: old `RIP=0 / r15=32023 / MTLConnectionCtx+56` absent 9/9 current crashes.
- Current measured frontier: `MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
- P2b is NOT justified as current next patch.
- P3 serialized-bitcode bridge is measured/historically causal.
- D97HG exact P3-only post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
- AIR00/D34 remain unauthorized.

## D97HM — exact P1 preservation + D97HI inner build PASS
D97HM proved prior regex P1 mismatch was a tooling-boundary false negative. Exact AST-bounded P1 FunctionDef bytes:
- ref/current bytes `3466 / 3466`;
- ref/current SHA256 `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`;
- byte-identical PASS.

Current exact source identities:
- D97GS diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- D97HI diff SHA `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

Built inner:
- x86_64;
- executable SHA256 `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- ZIP bytes `722927108`.

Functional classification:
`D97HI_STATUS=BUILD_PASS_PORTABLE_INNER`
`D97HI_NEW_FUNCTIONAL_DELTA=P3_ONLY`
`D97HI_P1_BASE=PRESERVED_EXACT`
`D97HI_P2B_REPLAY=NO`
`D97HI_AIR00_REPLAY=NO`
`D97HI_D34_REPLAY=NO`.

## D97HN — independent inner artifact audit PASS
D97HN independently proved:
- current D97HI source diff exact `c4590568...`;
- exact D97GS reference reconstruction `cae9c...`;
- P1 AST-bounded ref/current SHA both `387311b0...`, byte-identical PASS;
- exactly one P1 function and one P3 function;
- all P1/P3 constants/preimages/postimages/offsets/hooks unique;
- hook order P1 -> P3 -> continuation PASS;
- source contract `STATIC_STRUCTURAL_SEMANTIC_PROVEN`;
- inner app codesign PASS;
- inner arch x86_64;
- inner executable SHA exact `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- ZIP SHA exact `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- ZIP bytes `722927108`;
- extracted executable identity exact;
- app manifest rows 156, ZIP-extracted manifest rows 156, exact equality PASS.

Audit package:
- `OCLP7_D97HN_INDEPENDENT_AUDIT_20260908_122001.zip`;
- SHA256 `f561d9531ad7485963e1fd56544bac6b8bca2d4f6b3b3341095f2df2484db5ae`;
- bytes `28035`.

Final classifications:
`D97HN_STATUS=PASS_INDEPENDENT_INNER_AUDIT`
`D97HN_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97HI_INNER_ARTIFACT=TRANSFER_AUTHORIZED_FOR_WRAPPER_ASSEMBLY_ONLY`.

## D97GS exact wrapper authority
Exact D97GS ZIP:
- SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- bytes `722879148`.

Exact retained components:
- launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- D97DX source patch SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- D97GS source patch SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`.

## CURRENT ACTION — D97HO wrapper assembly only on ASUS2
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HO_ASUS2_ASSEMBLE_D97GS_WRAPPER_WITH_AUDITED_D97HI_INNER.sh`
- commit `3b99673b0873afdc4e14d7f84fb941913a6e94e1`.

D97HO must:
1. verify exact D97GS ZIP identity and bytes;
2. verify exact transferred D97HI inner ZIP identity and bytes;
3. verify exact D97GS launcher/debug-helper/base-patch/D97GS-patch identities;
4. verify D97HI inner executable SHA, x86_64 arch and codesign;
5. copy D97GS wrapper and replace only nested `Contents/Resources/OpenCore-Patcher.app`;
6. add provenance text recording exact D97HI source/inner/P1/P3 identities;
7. re-sign only outer wrapper ad-hoc and deep-verify;
8. package D97HO ZIP and report exact identity.

No Root Patch, reboot, accelerated boot, EFI/NVRAM/framebuffer mutation, P2b, AIR00 or D34 is authorized until D97HO PASS and a read-only ASUS2 preflight.
