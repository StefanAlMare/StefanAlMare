# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HN_INNER_AUDIT_PASS_D97HO_WRAPPER_PASS_D97HP_PREFLIGHT_READY.md`
- commit `e75fec4b3c5921ec0a2a28760bf7c699fc96a333`.

Immediate decisive predecessors:
- D97HN independent D97HI inner audit PASS / wrapper assembly ready — `d169d7c63c7d69b3b9f49ce8dd12d8512bf8e546`;
- D97HM portable D97HI inner build PASS — `7fa87cc64fb44b4b1d527261c8e233197090ef09`;
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

## D97HI inner — build + independent audit CLOSED PASS
Exact D97HI source diff:
`c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

D97HM proved exact P1 preservation using AST-bounded function bytes:
- D97GS/D97HI P1 bytes 3466/3466;
- SHA256 both `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`;
- byte-identical PASS.

D97HN independently proved:
- source contract `STATIC_STRUCTURAL_SEMANTIC_PROVEN`;
- P1 exact, P3-only, hook order P1 -> P3 -> continuation;
- P2b/AIR00/D34 replay = NO;
- inner arch x86_64;
- inner executable SHA256 `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- inner ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- inner ZIP bytes `722927108`;
- built app vs extracted ZIP manifest exact 156/156.

Classification:
`D97HN_STATUS=PASS_INDEPENDENT_INNER_AUDIT`
`D97HI_INNER=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

## D97HO wrapper assembly on ASUS2 — PASS
Inputs:
- exact D97GS ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- exact audited D97HI inner ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`.

D97HO preserved exact D97GS wrapper components:
- launcher PASS, SHA `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- DEBUG helper PASS, SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- D97DX source patch PASS, SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- D97GS source patch PASS, SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`.

Nested D97HI inner:
- executable SHA exact `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- x86_64;
- preserved exact after assembly;
- nested and outer codesign PASS.

D97HO output:
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.app`;
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip`;
- ZIP SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- ZIP bytes `722975756`.

Classification:
`D97HO_STATUS=PASS_WRAPPER_ASSEMBLY`
`D97HO_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

No Root Patch or reboot occurred.

## Current ASUS2 expected live base before P3
ASUS2 remains in VESA recovery with D97EZ inert after the post-P1 accelerated no-image boot.
Expected exact active state, to be re-proven by D97HP:
- active MTLCompilerService exact P1 SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active MTLCompiler 32023 exact pre-P3 base SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- P2 still original `+0xD0`, no P2b;
- P3 not yet applied, preimage `81e100002000` at `0xA1573`;
- corrected metallibs 180/180 exact;
- Haswell kexts loaded;
- official helper exact.

## CURRENT ACTION — D97HP read-only ASUS2 preflight
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HP_ASUS2_READONLY_PREFLIGHT_D97HO_AND_ACTIVE_P1_PRE_P3.sh`
- commit `51de1da3e8da4808ae0a816cd8eb0884310232ba`.

D97HP must prove simultaneously:
1. VESA active and D97EZ inert;
2. exact D97HO artifact `a1aa24d5... / 722975756` and exact nested provenance/components;
3. active exact P1 service/postimage;
4. active exact pre-P3 MTLCompiler 32023, P2 original and P3 preimage exact;
5. active corrected metallibs exact 180/180 and CoreDisplay exact `b848d54e... / 20739 / MTLB`;
6. Haswell kexts loaded;
7. official helper exact SHA/team/codesign.

D97HP is read-only and does not authorize Root Patch.

## Restore-first vs direct D97HO patch
Decision is intentionally deferred until D97HP returns. Do not assume direct patching is safe merely because D97HO is self-contained; do not spend a Restore/reboot cycle merely from habit either. Choose from exact live evidence.

No Root Patch, Restore, reboot, acceleration, EFI/NVRAM/framebuffer change, P2b, AIR00 or D34 is authorized before D97HP review.
