# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HQ_AUXKC_VALID_VESA_UNLOADED_DIRECT_D97HO_ROOTPATCH_READY.md`
- commit `1258ce510da9e25dbbfe8035b000df582fc39e89`.

Immediate decisive predecessors:
- D97HP partial PASS / D97HQ AuxKC audit ready — `2a3668e8fd0c20e20b714f4a6e6a35b25576406d`;
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

## D97HP — userspace/compiler base exact; Haswell loaded-only gate retired for VESA
D97HP proved:
- VESA active, D97EZ inert;
- D97HO artifact exact;
- active P1 service exact SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- P1 postimage `81fe177d0000 @ 0x3494`;
- active MTLCompiler 32023 exact pre-P3 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- P2 original `418b81d0000000 @ 0x9A8CD`, no P2b;
- P3 unapplied exact preimage `81e100002000 @ 0xA1573`;
- corrected metallibs exact 180/180, missing0, different0.

D97HP then stopped at `AZUL_NOT_LOADED`. D97HQ resolves this gate.

## D97HQ — AuxKC valid, Haswell present but intentionally unloaded in current VESA boot
User archive:
`OCLP7_D97HQ_AUXKC_HASWELL_AUDIT_20260908_125907.zip`
- bytes `346782`;
- SHA256 `8095be562ce77e8d4b416f5d558b2938d583277119fb5d1e018e3045ad41bc68`.

Exact D97HQ results:
- VESA gate PASS;
- Azul/HD5000 kext bundles present on disk;
- `D97HQ_AZUL_IN_AUX_ALL=1`, loaded0, unloaded1, all-collections1;
- `D97HQ_HD5000_IN_AUX_ALL=1`, loaded0, unloaded1, all-collections1;
- `D97HQ_KMUTIL_CHECK_AUX_LOADINFO_RC=0`;
- AuxKC `/Library/KernelCollections/AuxiliaryKernelExtensions.kc`, bytes `5439488`;
- kmutil inspect contains LC_FILESET_ENTRY for both Haswell kext bundle IDs;
- IOKit counts under VESA: Azul0, HD5000Graphics0, IntelAccelerator0, IntelFramebuffer0, AppleIntelFramebuffer0, display0=2, AppleBacklight=4;
- official helper exact SHA `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team `S74BDJXQMD`, PASS;
- classifier `PRESENT_IN_AUX_BUT_NOT_BOTH_LOADED`;
- final `PASS_READONLY_DIAGNOSTIC_COLLECTION`.

Interpretation:
The current VESA boot has no Intel accelerator/framebuffer service and kmutil explicitly classifies both Haswell kexts as present in the valid AuxKC but unloaded. Therefore the D97HP loaded-only failure is not evidence of a broken AuxKC and does not justify Restore.

## Restore-first vs direct D97HO — DECIDED
`RESTORE_FIRST=NO`
`DIRECT_D97HO_ROOT_PATCH=AUTHORIZED`

Rationale:
- exact P1-only active userspace base;
- exact pre-P3 MTLCompiler 32023;
- P2 original and P3 unique preimage exact;
- metallibs 180/180 exact;
- valid AuxKC contains both Haswell kexts;
- official helper exact;
- D97HO independently audited and exact.

Expected D97HO Root Patch semantics:
- P1 sees already-post SHA and no-ops idempotently;
- P3 changes exactly `0xA1574: e1 -> c9` and must produce SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- P2b/AIR00/D34 remain absent;
- normal D97DX patchsets reapply/rebuild corrected files and AuxKC.

## CURRENT ACTION — manual D97HO Root Patch, then NO reboot
1. User manually launches `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.app` on ASUS2.
2. Run Post-Install Root Patch.
3. Capture full patch output.
4. Do NOT reboot when patching completes.
5. Run a read-only pre-reboot audit proving P1 + P3 exact, metallibs exact, and AuxKC rebuild success.

No EFI/NVRAM/framebuffer mutation is authorized. No accelerated boot is authorized until the pre-reboot audit closes PASS.
