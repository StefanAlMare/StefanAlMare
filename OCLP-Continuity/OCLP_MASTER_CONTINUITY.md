# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HP_PARTIAL_PASS_AZUL_LOAD_STATE_INCONCLUSIVE_D97HQ_AUXKC_AUDIT_READY.md`
- commit `2a3668e8fd0c20e20b714f4a6e6a35b25576406d`.

Immediate decisive predecessors:
- D97HN inner audit PASS / D97HO wrapper PASS / D97HP ready — `e75fec4b3c5921ec0a2a28760bf7c699fc96a333`;
- D97HN independent D97HI inner audit PASS — `d169d7c63c7d69b3b9f49ce8dd12d8512bf8e546`;
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
- Measured frontier: `MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor -> SIGSEGV`.
- P2b is NOT justified as current next patch.
- P3 serialized-bitcode bridge is measured/historically causal.
- D97HG exact P3-only post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
- AIR00/D34 remain unauthorized.

## D97HI inner — build + independent audit CLOSED PASS
Exact D97HI source diff:
`c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

P1 preserved byte-identically by AST-bounded function audit:
- bytes `3466 / 3466`;
- SHA256 both `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`.

D97HN independently proved:
- P1 exact, P3-only, hook order P1 -> P3 -> continuation;
- P2b/AIR00/D34 = NO;
- x86_64 inner executable SHA `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- inner ZIP SHA `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`, bytes `722927108`;
- built app vs extracted ZIP manifest exact 156/156.

## D97HO wrapper assembly — CLOSED PASS
Exact D97GS wrapper + exact audited D97HI inner.
D97HO output:
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.app`;
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip`;
- ZIP SHA `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

Preserved exact D97GS components:
- launcher SHA `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- DEBUG helper SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- D97DX patch SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- D97GS patch SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`.

No Root Patch or reboot occurred.

## D97HP — PARTIAL PASS, userspace/compiler base exact
Current boot remains VESA with D97EZ inert.

D97HP proved before stopping:
- `D97HP_VESA_GATE=PASS`;
- D97HO artifact exact `a1aa24d5... / 722975756`;
- active P1 service exact SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- P1 postimage `81fe177d0000 @ 0x3494` PASS;
- active MTLCompiler 32023 exact pre-P3 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 remains original `418b81d0000000 @ 0x9A8CD`, no P2b;
- P3 remains unapplied exact preimage `81e100002000 @ 0xA1573`;
- corrected metallibs exact 180/180, missing0, different0.

D97HP then stopped:
`D97HP_STATUS=FAIL`
`D97HP_REASON=AZUL_NOT_LOADED`.

Classification:
`D97HP_USERSPACE_P1_PRE_P3_BASE=STRUCTURAL_SEMANTIC_PASS`
`D97HP_METALLIB_LAYER=180_OF_180_EXACT`
`D97HP_HASWELL_LOAD_STATE=INCONCLUSIVE`.

VESA alone is not a sufficient explanation: prior D97HD VESA boot reported both AppleIntelFramebufferAzul and AppleIntelHD5000Graphics loaded. Therefore do not infer either a driver regression or a need for Restore from the single generic `kmutil showloaded` miss.

## CURRENT ACTION — D97HQ read-only AuxKC/load-state audit
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HQ_ASUS2_READONLY_AUXKC_HASWELL_STATE_AUDIT.sh`
- commit `eb6cdadc1ce00ee65d87417ce99eb946a4271617`;
- Git blob `b77a65026f0eece6d88f09e58f98430041c61619`.

D97HQ must distinguish:
1. Haswell kext bundles present on disk;
2. presence in `kmutil showloaded --collection aux --show all`;
3. explicit AUX loaded state;
4. explicit AUX unloaded state;
5. all-collection load information;
6. `kmutil check --collection aux --load-info` consistency;
7. standard on-disk AuxKC presence/inspection;
8. IOKit evidence for Intel framebuffer/accelerator/display services;
9. official privileged helper exact SHA/team/codesign.

D97HQ is read-only. It does NOT load/unload kexts and does not modify Root Patch/Restore/EFI/NVRAM/framebuffer state.

## Restore-first vs direct D97HO
Decision remains deferred until D97HQ returns. Do not Root Patch or Restore yet.

No Root Patch, Restore, reboot, acceleration, EFI/NVRAM/framebuffer change, P2b, AIR00 or D34 is authorized before D97HQ review.
