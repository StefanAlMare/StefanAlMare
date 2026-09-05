# OCLP7 CHECKPOINT — D97BM native Tahoe producer layout difference proven; second builder mapped; D97BN generation-origin audit next

Date: 2026-09-05 EEST

## Entering state
- Target: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine: unpatched VESA after sealed/saved snapshot restore; `-igfxvesa` active; no `OpenCore-Legacy-Patcher.plist` in current root.
- D97BL architecture remains: preserve native Tahoe Metal4 ABI and integrate legacy 3802 support selectively; never install full legacy `13.2.1-24/Metal.framework` over native Tahoe.
- No Root Patch and no accelerated reboot are authorized.

## Returned D97BM bundle
`OCLP7_D97BM_TAHOE_NATIVE_METAL_PRODUCER_AND_METAL4_AUDIT_20260905_135803.zip`
- bytes: `10512`
- SHA256: `0a98c10b518356b53397b9c0b950944a8ee8b6f93788ca8bc97782dc32ba739b`

Embedded audit markers include:
- `D97BM_SHARED_CACHE_MAP=PASS`
- `D97BM_PRIMARY_EIGHT_KEY_CLUSTER=PASS`
- `D97BM_FUNCTION_START_BOUNDARY=PASS`
- `D97BM_NATIVE_METAL_TEXT_SHA_PINNED=PASS`
- `D97BM_AUDIT=PASS`

The ZIP packaging occurred successfully. The TXT copy inside the ZIP ends at the packaging section before the outer shell's post-package marker; this does not negate the completed JSON/TXT evidence.

## Exact native 25G82 identities
Native Tahoe `MTLCompilerService`:
- SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.

Native Metal shared-cache image:
- path `/System/Library/Frameworks/Metal.framework/Versions/A/Metal`
- text catalog start `0x7FF80F47D000`
- text catalog end `0x7FF80F76815A`
- exact cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Native IOGPU shared-cache image:
- path `/System/Library/PrivateFrameworks/IOGPU.framework/Versions/A/IOGPU`
- text catalog start `0x7FF906A1F000`
- text catalog end `0x7FF906A6BECC`.

## Native Metal4 surface presence
Exact 25G82 cache census found all six already-required native superclass names in Metal and all six corresponding IOGPU class names.

Metal class-string counts:
- `_MTL4CommandQueue` 82
- `_MTL4CommandBuffer` 103
- `_MTL4CommandAllocator` 49
- `_MTL4RenderCommandEncoder` 79
- `_MTL4ComputeCommandEncoder` 97
- `_MTL4MachineLearningCommandEncoder` 38

IOGPU class-string counts:
- `IOGPUMetal4CommandQueue` 77
- `IOGPUMetal4CommandBuffer` 120
- `IOGPUMetal4CommandAllocator` 32
- `IOGPUMetal4RenderCommandEncoder` 13
- `IOGPUMetal4ComputeCommandEncoder` 13
- `IOGPUMetal4MachineLearningCommandEncoder` 13

Classifications:
- `D97BM_NATIVE_METAL4_CLASS_NAME_SURFACE_PRESENT=STATIC_PROVEN_STRING_PRESENCE`
- `D97BM_NATIVE_IOGPU_METAL4_CLASS_NAME_SURFACE_PRESENT=STATIC_PROVEN_STRING_PRESENCE`

This is not yet a full Objective-C metadata/superclass-resolution proof for a future modified root. The mandatory pre-reboot closure gate remains active.

## Primary Tahoe eight-key request builder — STATIC PROVEN
D97BM recovered a complete eight-key XPC cluster in one exact LC_FUNCTION_STARTS function:
- function `0x7FF80F635510..0x7FF80F635A4D`
- cluster `0x7FF80F6355F0..0x7FF80F635811` span `0x221`.

Primary key xrefs:
- `llvmVersion` `0x7FF80F6355F0`
- `requestType` `0x7FF80F63560C`
- `sandboxTokens` `0x7FF80F635714`
- `targetData` `0x7FF80F635739`
- `data` `0x7FF80F63575F`
- `pluginPath` `0x7FF80F635780`
- `client_name` `0x7FF80F6357F7`
- `APISpecifiedTimeoutInSeconds` `0x7FF80F635811`.

All eight are in the same containing function.

## Tahoe llvmVersion source — decisive layout result
Exact sequence in native 25G82 Metal:
- `0x7FF80F6355EC: movslq 0x1c(%rbx), %rdx`
- `0x7FF80F6355F0: lea llvmVersion -> RSI`
- setter call follows.

Function entry proves:
- `0x7FF80F635537: movq %rdi,%rbx`
so RBX remains ABI arg1/RDI in Tahoe as it is in Golden.

Therefore:
`D97BM_TAHOE_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x1C=STATIC_VALUE_SOURCE_PROVEN`.

Golden counterpart is already proven:
`G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

Thus:
`D97BM_GOLDEN_VS_TAHOE_LLVMVERSION_OBJECT_LAYOUT_OFFSET_DIFFERENCE=PROVEN`.

Important qualification: the offset difference by itself does **not** prove the value is semantically wrong. It proves the producer object layout/field location differs.

## Historical runtime value fact retained
D97AA accelerated evidence already proved all 12 observed failing WindowServer-hosted requests reached MTLCompilerService with exact `llvmVersion=32023`, with histogram:
- 3802 = 0
- 32023 = 12
- other = 0.

Golden working evidence separately shows natural traffic in both 3802 and 32023 donor generations; original Golden service semantics are `3802 -> Versions/3802` and `31001 -> Versions/32023`.

Therefore the current repair question is not only offset/layout. The project must identify the native Tahoe generation-selection origin and why the failing Tahoe cohort lacks the working Golden 3802 lane.

## Tahoe requestType source — structural mapping
Primary Tahoe requestType is not read directly from the Golden-style `[arg2+0x08]` site in the builder.

Exact builder sequence:
- `RSI` entry argument is saved into R12 (`movq %rsi,%r12`).
- builder calls a helper with `RDI=R12` at `0x7FF80F635602`.
- helper return EAX is copied to EDX and sent as `requestType`.

Classification:
`D97BM_TAHOE_PRIMARY_REQUESTTYPE_SOURCE=STRUCTURAL_HELPER_RETURN_FROM_ARG2_OBJECT`.

The helper's internal semantic source is not yet promoted; D97BN must map it exactly.

## Second complete Tahoe request-builder cluster — STATIC MAPPED
D97BM found a second full set of all eight Metal-owned XPC key xrefs:
- `llvmVersion` `0x7FF80F663DF7`
- `requestType` `0x7FF80F663E36`
- `sandboxTokens` `0x7FF80F663F38`
- `targetData` `0x7FF80F663F66`
- `data` `0x7FF80F663F8F`
- `pluginPath` `0x7FF80F663FBD`
- `client_name` `0x7FF80F664074`
- `APISpecifiedTimeoutInSeconds` `0x7FF80F664096`.

Additional requestType-only xrefs exist at:
- `0x7FF80F62717E`
- `0x7FF80F63539E`.

Additional data xrefs exist at:
- `0x7FF80F4E643A`
- `0x7FF80F572FA1`.

Classification:
`D97BM_TAHOE_SECOND_COMPLETE_EIGHT_KEY_REQUEST_BUILDER=STATIC_MAPPED_PENDING_FUNCTION_AND_SOURCE_CLOSURE`.

Engineering consequence: patching only primary address `0x7FF80F6355EC` would be structurally incomplete until the second builder is audited.

## Current architecture consequence
Do not repeat the historical plain true-five hybrid. Do not patch the native Metal producer yet.

The next static task is to identify the generation-selection origin across both complete request builders and all alternate request paths, while preserving native Metal4 unchanged.

## D97BN prepared next action
Read-only collector:
`OCLP7_D97BN_tahoe_all_builders_generation_origin.sh`

Pinned input:
- Tahoe `26.6.2 / 25G82`
- native MTLCompilerService SHA `4262e71f...66256`
- native cached Metal start `0x7FF80F47D000`
- native cached Metal `__TEXT` SHA `bf405828...04605`.

D97BN goals:
1. map exact LC_FUNCTION_STARTS functions for both complete eight-key builders;
2. back-slice `llvmVersion`, `requestType` and timeout sources in both;
3. map the two extra requestType paths and two extra data paths;
4. disassemble helper functions encountered while resolving scalar field sources;
5. census all native Metal `__text` occurrences of generation constants `3802`, `31001`, `32023` and validate their containing instructions/functions;
6. identify direct callers of both complete request-builder functions;
7. decide whether generation normalization can be universal or must be request-family-specific.

No system/cache/source mutation. No Root Patch. No reboot.

## CURRENT ACTION
Remain unpatched in Tahoe VESA. Run D97BN only and return its TXT+JSON ZIP.

No Root Patch and no accelerated reboot are authorized.