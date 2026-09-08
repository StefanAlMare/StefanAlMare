# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and the checkpoint below are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HF_P1_RUNTIME_SEMANTIC_PROGRESS_P3_FRONTIER_D97HG_READY.md`
- commit `1af98134a40236290484037548dfba621df1c626`.

Immediate predecessors:
- D97HE historical misselection invalid / D97HF exact 03:35 collector ready — `d7691224526b3b35c4607f15d43bccfa8372d5f9`;
- first post-P1 accelerated no-GUI / VESA recovery frontier pending — `52125fed156f25c9f08ef611e7876793eab5e42a`;
- D97HD active P1 VESA snapshot PASS + D97EW live capture gate PASS — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`;
- D97GR exact P1 reconstruction / old NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GN old 12/12 `RIP=0 / r15=32023 / MTLConnectionCtx+56` frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only.

Durable architecture:
`Tahoe native Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Historical accepted compiler baseline:
`P1 + P2b + P3 + AIR00 + D34`.
Do NOT replay it wholesale. Only the currently measured failed module may return.

## Settled active snapshot
D97GS/D97HC/D97HD prove active P1 MTLCompilerService SHA256:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`
with exact postimage `81fe177d0000` at `0x3494`.

Corrected metallibs are active 180/180 exact. CoreDisplay:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- MTLB.

Haswell Azul/HD5000 kexts loaded. Official helper exact. D97EW live gate was PASS before acceleration.

## First post-P1 accelerated test
Only two boot-arg states changed:
- VESA made inert;
- D97EZ activated.

Framebuffer remained 3/3/3. `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override remained OFF. No unrelated Root Patch/EFI/NVRAM change.

Outcome:
- no usable image/GUI;
- user correctly hard-cycled and restored VESA with D97EZ inert;
- recovery boot is not authoritative evidence for failed accelerated boot.

WindowServer current crash:
- launch `2026-09-08 03:35:27.3200 +0300`;
- crash `03:35:43.5056 +0300`;
- Metal compositor reached;
- fatal pipeline error from repeated `XPC_ERROR_CONNECTION_INTERRUPTED`;
- GPUCompiler 32023 libraries and Haswell MTL driver loaded.

## D97HE misselection — retired for current boot
D97HE mistakenly selected old D97EW run `20260907T205125Z-322` (7 September ACCEL2) and therefore old MTLCompilerService crashes. Its current-P1 classification is invalid and discarded.

## D97HF exact current evidence — P1 runtime progress proven
Uploaded:
`OCLP7_D97HF_POST_P1_0335_FRONTIER_20260908_035520.zip`
- bytes `491018`;
- SHA256 `e285ee79278154f941277f9a8a9787118a8035375b36f6a785ed62bb1544d2ce`.

Exact window selected by embedded report `captureTime`:
`2026-09-08 03:34:00–03:39:30 +0300`.

D97HF:
- 10 exact-window IPS copied;
- 9 are MTLCompilerService;
- 9/9 parsed;
- old `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature count = 0;
- classifier `SEMANTIC_PROGRESS_NEW_FRONTIER`.

Classification:
`P1_SELECTOR_BRIDGE_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.
This proves P1 removed the measured startup NULL-call and all current failing requests entered the 32023 codegen/build path.

## New exact frontier — 9/9
Every current MTLCompilerService crash is EXC_BAD_ACCESS/SIGSEGV with fault address/CR2 0 and the same chain:

`MTLCodeGenServiceBuildRequest`
`-> MTLCompilerObject::buildRequest`
`-> backendCompileExecutableRequest`
`-> backendCompileModule`
`-> MTLCompilerPluginInterface::compilerBuildRequest`
`-> MTLCompilerBuildRequestWithOptions`
`-> addMsaaPositionInfoToModuleMetadata`
`-> llvm::Module::getOrInsertNamedMetadata`
`-> llvm::collectUsedGlobalVariables`
`-> llvm::StringMapImpl::LookupBucketFor +153`
`-> SIGSEGV`.

Loaded identities in current crashes:
- MTLCompiler 32023 UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- Haswell libMTLIntelCompilerPlugin UUID `F28B138A-8357-348E-A2FD-A3131B515A06`;
- crashing LLVM is GPUCompiler 3802 libLLVM UUID `D5CE0007-CBC1-3B4E-97B0-9E75C1A2EC13`.

## Measured next module — P3, not P2b
Historical accepted evidence contains the same pre-P3 crash family: libLLVM 3802 StringMap/metadata -> Haswell MTLCompilerBuildRequestWithOptions -> MTLCompiler 32023.

Historical P2/P2b request-layout A/B changes did not alter this crash family. P2b `+0x110` remains historical semantic evidence but is NOT justified as the next current patch by this frontier.

Historical P3 directly targets this boundary:
- MTLCompiler 32023 file offset `0xA1573`;
- preimage `81 e1 00 00 20 00`;
- postimage `81 c9 00 00 20 00`;
- semantic: force `MTLCompilerOptionCompilerPluginRequiresSerializedBitcode` before backend/plugin dispatch, avoiding incompatible direct `llvm::Module*` handoff between LLVM generations.

Historical P3 on the P2a source changed SHA `933476d5...` to `c94b30f2...`; those are NOT valid P3-only hashes for the current exact Golden 32023 base.

Classification:
`CURRENT_FRONTIER=P3_SERIALIZED_BITCODE_BOUNDARY_MATCH_PROVEN`
`P2B_AS_NEXT_PATCH=NOT_JUSTIFIED`
`P3_AS_NEXT_PATCH=MEASURED_AND_HISTORICALLY_CAUSAL`.

## CURRENT ACTION — D97HG copy-only P3 reconstruction
Run only:
`OCLP-Continuity/artifacts/OCLP7_D97HG_READONLY_RECONSTRUCT_P3_ONLY_FROM_CURRENT_32023.sh`
- commit `8575196995c49a30b369abaa3b4da1395b0275e8`;
- Git blob `8c6a0dfa5b328cc0776d7afaef8ab33eb5fc087e`.

D97HG must:
1. require current VESA recovery and D97EZ inert;
2. require active P1 service exact;
3. require current MTLCompiler 32023 exact base SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
4. prove current P2 state remains original `+0xD0` and P3 preimage is exact at `0xA1573`;
5. patch only a Desktop copy from `81e100002000` to `81c900002000`;
6. prove exactly one byte changed and calculate the exact P3-only post-SHA.

No build, Root Patch, reboot, acceleration, P2b, AIR00 or D34 is authorized until D97HG PASS is reviewed.
