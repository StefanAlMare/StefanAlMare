# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GS_REVERT_PASS_D97HR_POST_REBOOT_NATIVE_AUDIT_READY.md`
- commit `22fa01b19306788c75911baf0eb7fdb5c55a1de4`.

Immediate decisive predecessors:
- D97HO UI Revert-only / Restore-first required — `afb6fee84e8b7eae53a30693999049667d5be17a`;
- D97HQ AuxKC valid / VESA unloaded diagnostic — `1258ce510da9e25dbbfe8035b000df582fc39e89`;
- D97HP partial PASS / D97HQ ready — `2a3668e8fd0c20e20b714f4a6e6a35b25576406d`;
- D97HN inner audit PASS / D97HO wrapper PASS — `e75fec4b3c5921ec0a2a28760bf7c699fc96a333`;
- D97HN independent D97HI inner audit PASS — `d169d7c63c7d69b3b9f49ce8dd12d8512bf8e546`;
- D97HM portable D97HI inner build PASS — `7fa87cc64fb44b4b1d527261c8e233197090ef09`;
- D97HG exact P3-only reconstruction PASS — `3aa5c5ea432b99fd538c44eb9bfe0ab481bf71ec`;
- D97HF P1 runtime semantic progress / measured P3 frontier — `1af98134a40236290484037548dfba621df1c626`.

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

## D97HP + D97HQ — pre-revert live base exact
D97HP proved before its loaded-only stop:
- VESA active, D97EZ inert;
- D97HO artifact exact;
- active P1 service exact SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- P1 postimage `81fe177d0000 @ 0x3494`;
- active MTLCompiler 32023 exact pre-P3 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- P2 original `418b81d0000000 @ 0x9A8CD`, no P2b;
- P3 unapplied exact preimage `81e100002000 @ 0xA1573`;
- corrected metallibs exact 180/180, missing0, different0.

D97HQ then proved:
- Azul and HD5000 present on disk and in AuxKC;
- both explicitly unloaded under current VESA boot;
- `kmutil check --collection aux --load-info` RC=0;
- AuxKC contains LC_FILESET_ENTRY for both Haswell kexts;
- no IntelAccelerator/IntelFramebuffer IOKit services under VESA;
- official helper exact SHA/team/codesign.

Thus D97HP `AZUL_NOT_LOADED` was not AuxKC corruption.

## OCLP UI patcher-state — Restore-first workflow required
Exact D97HO, when launched on the still-patched P1 snapshot, exposed only `Revert Root Patch` and no `Start Root Patch`.
This superseded the earlier direct-patch decision.
Classification:
`RESTORE_FIRST=REQUIRED_BY_OCLP_WORKFLOW`.
This was not D97HO/P3 failure.

## D97GS Revert Root Patch — PASS
User ran controlled Revert using exact D97GS lineage.
Observed:
- exact local MetallibSupportPkg 26.6.2-25G82 found;
- installed patchsets correctly detected: Metal 3802 Common, Metal 3802 .metallibs, Intel Haswell, Metal 3802 Common Extended, Monterey GVA, Monterey OpenCL;
- SkylightPlugins removed;
- Auxiliary Kernel Collection cleaned;
- AppleIntelFramebufferAzul.kext removed;
- AppleIntelHD5000Graphics.kext removed;
- `Unpatching complete`;
- OCLP requests reboot for changes to take effect.

Classification:
`D97GS_REVERT_ROOT_PATCH=PASS`
`D97HO_P3_NOT_APPLIED_YET`.

## CURRENT ACTION — reboot in VESA, then D97HR clean/native audit
Reboot is now authorized with no other change:
- keep `-igfxvesa` active;
- keep D97EZ inert;
- no EFI/NVRAM/framebuffer changes.

After reboot run:
`OCLP-Continuity/artifacts/OCLP7_D97HR_ASUS2_POST_REVERT_REBOOT_CLEAN_NATIVE_AUDIT.sh`
- commit `27ce582a14ecf4486fb9397208da2905bddfd4a4`.

D97HR must prove:
1. 25G82 + VESA gate PASS;
2. native MTLCompilerService exact SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
3. native CoreDisplay metallib exact SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes `24128`, MTLB;
4. Haswell patch bundles removed from /Library/Extensions;
5. AuxKC consistency RC=0;
6. official helper exact SHA/team/codesign;
7. D97HO ZIP still exact `a1aa24d5... / 722975756`.

Only after D97HR PASS is D97HO Root Patch authorized on the clean/native snapshot. After D97HO patch completes, do not reboot until a pre-reboot P1+P3/system/AuxKC audit passes.

No P2b/AIR00/D34. No acceleration until post-patch audits close PASS.
