# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HG_P3_ONLY_RECONSTRUCTION_PASS_D97HI_IMAC_BUILD_READY.md`
- commit `3aa5c5ea432b99fd538c44eb9bfe0ab481bf71ec`.

Immediate decisive predecessors:
- D97HF P1 runtime semantic progress / measured P3 frontier — `1af98134a40236290484037548dfba621df1c626`;
- D97HE historical misselection invalid / D97HF exact collector ready — `d7691224526b3b35c4607f15d43bccfa8372d5f9`;
- first post-P1 accelerated no-GUI / VESA recovery — `52125fed156f25c9f08ef611e7876793eab5e42a`;
- D97HD active P1 VESA snapshot PASS + D97EW live gate PASS — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`;
- D97GR exact P1 reconstruction / old NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only.
Compilation/build is authorized only on the home Intel iMac, never on ASUS2.

Durable architecture:
`Tahoe native Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Historical accepted compiler baseline:
`P1 + P2b + P3 + AIR00 + D34`.
Do NOT replay it wholesale. Only the currently measured failed module may return.

## Settled active ASUS2 snapshot
Current ASUS2 is in VESA recovery with D97EZ inert.

Active P1 MTLCompilerService exact SHA256:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`
with exact postimage `81fe177d0000` at `0x3494`.

Corrected metallibs are active 180/180 exact. CoreDisplay:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- MTLB.

Haswell Azul/HD5000 kexts loaded. Official helper exact.

## First post-P1 accelerated test — outcome
Only VESA/D97EZ states changed; framebuffer and optional iGPU properties stayed at baseline.
No usable GUI appeared. User correctly hard-cycled and restored VESA.

WindowServer reached Metal compositor and died downstream after repeated `XPC_ERROR_CONNECTION_INTERRUPTED` during pipeline compilation.

## D97HF — P1 runtime semantic progress PROVEN
Exact current window: `2026-09-08 03:34:00–03:39:30 +0300`.

D97HF exact-window evidence:
- 9 current MTLCompilerService crash reports parsed;
- old `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature count = 0/9;
- all 9 requests entered 32023 codegen/build path.

Classification:
`P1_SELECTOR_BRIDGE_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

All 9 new crashes converge on:
`MTLCodeGenServiceBuildRequest -> buildRequest -> backendCompileExecutableRequest -> backendCompileModule -> compilerBuildRequest -> MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> llvm::Module::getOrInsertNamedMetadata -> llvm::collectUsedGlobalVariables -> llvm::StringMapImpl::LookupBucketFor+153 -> SIGSEGV`.

Loaded identities:
- MTLCompiler 32023 UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- Haswell compiler plugin UUID `F28B138A-8357-348E-A2FD-A3131B515A06`;
- crashing LLVM 3802 UUID `D5CE0007-CBC1-3B4E-97B0-9E75C1A2EC13`.

## Measured next module — P3, not P2b
Historical evidence contains the same pre-P3 StringMap/addMsaa crash family. Historical P2/P2b request-layout changes did not alter that crash family.

Therefore:
`P2B_AS_NEXT_PATCH=NOT_JUSTIFIED`.
This does not prove P2b permanently unnecessary; it proves current runtime does not require it to reach or explain the measured frontier.

Historical P3 directly targets the measured boundary by forcing `MTLCompilerOptionCompilerPluginRequiresSerializedBitcode`, avoiding the direct cross-generation `llvm::Module*` handoff.

Classification:
`CURRENT_FRONTIER=P3_SERIALIZED_BITCODE_BOUNDARY_MATCH_PROVEN`
`P3_AS_NEXT_PATCH=MEASURED_AND_HISTORICALLY_CAUSAL`.

## D97HG — P3-only exact reconstruction PASS
Current MTLCompiler 32023 exact base:
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- bytes `1636896`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

P2 remains original/no-P2b at `0x9A8CD`:
`41 8b 81 d0 00 00 00`, unique PASS.

P3 exact site:
- offset `0xA1573`;
- preimage `81e100002000`, unique PASS;
- postimage `81c900002000`;
- exactly one changed byte `0xA1574: e1 -> c9`;
- exact P3-only post-SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- size unchanged.

Classification:
`D97HG_P3_ONLY_RECONSTRUCTION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97HG_P2B_REPLAY=NO`
`D97HG_P3_NEXT_MODULE=YES_MEASURED`.

## CURRENT ACTION — D97HI Intel-iMac build only
Authorized:
`D97HI_INTEL_IMAC_BUILD=YES`.

Build helper:
`OCLP-Continuity/artifacts/OCLP7_D97HI_IMAC_BUILD_P1_PLUS_P3_ONLY_FROM_D97GS.sh`
- commit `4ca10b8e9a1b0db046d570bc2e1d2710ab16fa9a`;
- Git blob `0bf2e5601f08613d916d1414a5e2561153517ed5`.

D97HI contract:
- exact D97GS source base SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- preserve D97GS P1 method byte-identical;
- add only P3 mounted-root adapter after P1;
- P3 pre-SHA `ddabe975...`;
- P3 exact unique preimage `81e100002000 @ 0xA1573`;
- write one byte `0xA1574 e1->c9`;
- exact P3 post-SHA `0066a944...`;
- P2b/AIR00/D34 replay NO;
- exact D97GS/D97DX wrapper/debug-helper provenance retained;
- output `OpenCore-Patcher-Tahoe-D97HI.app/.zip` on Intel iMac Desktop.

Developer ID is intentionally not introduced for this internal diagnostic artifact because changing signing identity of the proven wrapper/nested-helper workflow would introduce an unrelated test variable. It remains available for distribution signing when relevant.

Not authorized yet:
- ASUS2 D97HI Root Patch;
- reboot or acceleration;
- P2b/AIR00/D34;
- EFI/NVRAM/framebuffer changes.

After build PASS, perform independent D97HJ artifact audit before ASUS2 deployment.
