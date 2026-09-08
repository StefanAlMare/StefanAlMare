# OCLP7 CHECKPOINT — 2026-09-08 — D97HF P1 RUNTIME SEMANTIC PROGRESS / P3 FRONTIER / D97HG READY

## Context
ASUS2 / Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.
Current boot is VESA recovery after the first post-P1 accelerated boot at approximately 03:35 local.

Uploaded evidence:
`OCLP7_D97HF_POST_P1_0335_FRONTIER_20260908_035520.zip`
- bytes `491018`;
- SHA256 `e285ee79278154f941277f9a8a9787118a8035375b36f6a785ed62bb1544d2ce`.

## D97HF exact-window result
D97HF selected reports by embedded `captureTime` in exact window 2026-09-08 03:34:00–03:39:30 +0300.

Evidence:
- current VESA recovery gate PASS;
- active MTLCompilerService still exact P1 SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- IPS copied: 10 total = 9 MTLCompilerService + 1 WindowServer;
- all 9 MTLCompilerService reports parsed;
- old `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature count = 0;
- D97HF classifier: `SEMANTIC_PROGRESS_NEW_FRONTIER`.

Classification:
`D97HF_P1_OLD_NULL_SIGNATURE=ABSENT_9_OF_9`
`D97HF_P1_SELECTOR_BRIDGE_RUNTIME_SEMANTIC_PROGRESS=PROVEN`.

This does not mean the whole compiler path is correct; it proves P1 removed the measured startup NULL-call frontier and allowed all current requests to enter the 32023 codegen path.

## New exact frontier — 9/9 identical family
Every current MTLCompilerService report is EXC_BAD_ACCESS / SIGSEGV with CR2/fault address 0 and the same symbolic chain:

`MTLCodeGenServiceBuildRequest`
`-> split_stack_call`
`-> MTLCompilerObject::buildRequest`
`-> MTLCompilerObject::backendCompileExecutableRequest`
`-> MTLCompilerObject::backendCompileModule`
`-> MTLCompilerPluginInterface::compilerBuildRequest`
`-> MTLCompilerBuildRequestWithOptions`
`-> addMsaaPositionInfoToModuleMetadata`
`-> llvm::Module::getOrInsertNamedMetadata`
`-> llvm::collectUsedGlobalVariables`
`-> llvm::StringMapImpl::LookupBucketFor +153`
`-> SIGSEGV`.

Current process loads:
- MTLCompiler 32023 UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- Haswell `libMTLIntelCompilerPlugin.dylib` UUID `F28B138A-8357-348E-A2FD-A3131B515A06`;
- crashing LLVM is GPUCompiler 3802 `libLLVM.dylib` UUID `D5CE0007-CBC1-3B4E-97B0-9E75C1A2EC13`.

## Historical match and measured-next-module classification
Recovered accepted August evidence shows the same pre-P3 crash family:
- EXC_BAD_ACCESS at 0;
- libLLVM 3802 `StringMapImpl::LookupBucketFor -> collectUsedGlobalVariables -> Module::getOrInsertNamedMetadata`;
- Haswell `addMsaaPositionInfoToModuleMetadata -> MTLCompilerBuildRequestWithOptions`;
- MTLCompiler 32023 backend path.

Historical P2/P2b request-layout changes did not alter that crash family. A/B request-layout candidates still reached the same later D12 frontier; `+0x110` became accepted P2b because it matched Tahoe-native semantic field placement, not because it closed this StringMap crash.

Historical P3 is the direct adapter for this exact failure mode:
- MTLCompiler 32023 file offset `0xA1573`;
- preimage `81 e1 00 00 20 00`;
- postimage `81 c9 00 00 20 00`;
- semantic change forces `MTLCompilerOptionCompilerPluginRequiresSerializedBitcode` before backend/plugin dispatch;
- purpose: avoid incompatible direct `llvm::Module*` handoff across LLVM-generation ABI and use SerializedBitcode semantics instead.

Historical P3 on the P2a source changed SHA256 `933476d5e19de582a4d5ffbfa49d32978bec7573b4ba07e55c2825e4146e1bda` to `c94b30f2312494f2ff64ec7d46f3733e13b709acc8d455ba53cda48e3c28b009`.
Those hashes are NOT the current desired P3-only hash because current active 32023 MTLCompiler is the unmodified exact Golden base `ddabe975...` and P2b is intentionally not being replayed without measured need.

Classification:
`D97HF_CURRENT_FRONTIER=P3_SERIALIZED_BITCODE_BOUNDARY_MATCH_PROVEN`
`D97HF_P2B_AS_NEXT_PATCH=NOT_JUSTIFIED_BY_CURRENT_CRASH`
`D97HF_P3_AS_NEXT_PATCH=MEASURED_AND_HISTORICALLY_CAUSAL`.

## Current action
Before any build or Root Patch, reconstruct P3 on a disposable copy of the current exact MTLCompiler 32023 and derive the exact P3-only post-SHA.

Use D97HG read-only/copy-only gate.
No system binary modification, Root Patch, reboot, EFI/NVRAM/framebuffer change, P2b, AIR00 or D34 is authorized yet.
