# OCLP7 CHECKPOINT — D97FT GPUPass bootstrap equivalence and native Metal validation-context frontier

Date: 2026-09-07 EEST

## Entering authority
- ASUS2: Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current visible boot remains VESA recovery after D97FH ACTIVE accelerated experiment.
- D97BV selective-3802 runtime adapter remains CLOSED PASS.
- D97DX native-Metal-safe Root Patch remains PASS.
- D97EZ exact `0x224 -> 0x24` set_id_mode adapter remains STRUCTURAL-SEMANTIC PASS for measured traffic and the prior bad-bits blocker remains CLOSED PASS.
- D97FJ established the fatal userspace frontier inside `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` and native Metal render-pipeline validation.
- D97FS established that the active cache signature mismatch is exactly the intentional D97BV runtime Metal text mutation, while `Cryptexes/Incoming/OS` is a pristine signature-valid 25G82 extraction reference.

## D97FT returned archive
`OCLP7_D97FT_INCOMING_SELECTED_20260907_200933.zip`
- bytes `6829957`;
- SHA256 `937e77b54edd1741b9cb19b89142a98380e77ac74a2811a9f6f1e060b375018b`;
- ZIP CRC PASS.

The archive contains exact images extracted by Apple `dsc_extractor.bundle` from the signature-valid Incoming 25G82 x86_64h cache plus static dumps.

### Extracted CoreDisplay
- x86_64;
- UUID `8BFEFF75-C8C8-3B5B-AFA0-61385199A1BB` — exact D97FJ IPS identity;
- SHA256 `e8ca1d0b851143235aa2acb500bab5e8ca2d5dbb708647d135f9f8458d3d933f`;
- bytes `1626112`.

### Extracted native Metal
- x86_64;
- UUID `5D64FA80-29CE-32AA-BAB6-4E5034132C0B` — exact D97FJ validation-abort identity;
- SHA256 `f9287f12f4ed6247d53cf322c468db96ed877abe54912c990f5697e916b45ec8`;
- bytes `5672960`.

Classification:
- `D97FT_EXTRACTED_IPS_IDENTITY=PASS`.

## Exact CoreDisplay GPUPass function map
Exact function:
`CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState(unsigned int,unsigned int,unsigned long) const`

Start:
`0x7FF80543D1B4`.

D97FJ crash offsets map exactly to:
- `+599 = 0x7FF80543D40B`;
- `+636 = 0x7FF80543D430`;
- `+1720 = 0x7FF80543D86C`.

Static control flow:
1. allocate/init `MTLFunctionConstantValues`;
2. call `setConstantValue:type:atIndex:` twice, type `0x21`, indices `0` and `1`;
3. call `newFunctionWithName:constantValues:error:` on the CoreDisplay Metal library;
4. exact compact-CFString decoding resolves the function name to `GPUPass`;
5. retain/cache the returned specialized function object;
6. if the returned NSError pointer is non-null, enter the error-report path using `description` and `getCString:maxLength:encoding:`;
7. continue to build an `MTLRenderPipelineDescriptor`;
8. set vertexFunction from the pre-existing MetalDevice vertex function;
9. set fragmentFunction from the GPUPass specialization result;
10. obtain `colorAttachments[0]` and set its pixelFormat;
11. call `newRenderPipelineStateWithDescriptor:error:`.

### Crash A reclassification
The D97FJ `objc_msgSend` / Foundation conversion crashes at GetGPUPass `+599/+636` are inside the branch entered only after `newFunctionWithName:@"GPUPass" constantValues:... error:&error` has produced a non-null NSError.

Therefore:
- `D97FT_GPUPASS_SPECIALIZATION_ERROR_BRANCH=REACHED`;
- `D97FT_GPUPASS_SPECIALIZATION_NSError_NON_NULL=CONTROL_FLOW_PROVEN` for that captured crash mode;
- exact specialization error text/reason remains UNKNOWN;
- do NOT infer solely from this branch that the returned MTLFunction is nil.

This is an earlier captured negative than render-pipeline descriptor validation for that crash mode.

## Exact CreateMetalDevice bootstrap tuple
D97FJ caller is `CoreDisplay::CreateMetalDevice +589`.

Exact Tahoe callsite passes constants:
- arg1 `0xFFFFFFFF`;
- arg2 `0xFFFFFFFF`;
- pixelFormat `0x5E`.

Thus the failing/bootstrap call is:
`GetGPUPassRenderPipelineState(0xFFFFFFFF, 0xFFFFFFFF, 0x5E)`.

`0x5E = 94 = MTLPixelFormatBGR10A2Unorm`.

The persisted Golden Sequoia CoreDisplay static map shows the same bootstrap tuple and the same GPUPass descriptor recipe on the working Haswell comparator.

Classification:
- `D97FT_GPUPASS_BOOTSTRAP_TUPLE=STATIC_PROVEN`;
- `D97FT_CORE_DISPLAY_GPUPASS_BOOTSTRAP_GOLDEN_TAHOE=STATIC_SEMANTIC_EQUIVALENT` for the mapped tuple/descriptor construction scope.

Therefore no Tahoe-only CoreDisplay field or bootstrap pixel-format change has been demonstrated, and CoreDisplay/pixel-format mutation is not justified.

## Native Metal validateWithDevice +716 exact meaning
Exact helper:
`validateWithDevice(id<MTLDevice>, MTLRenderPipelineDescriptorPrivate const&)`
start `0x7FF80F645727`.

D97FJ offset `+716 = +0x2CC = 0x7FF80F6459F3`.

Exact instructions immediately before that address:
- load the local `_MTLMessageContext`;
- call `__MTLMessageContextEnd`;
- `+716` is the return address immediately after that call.

Therefore D97FJ `validateWithDevice +716` does NOT identify one descriptor predicate. It proves that validation accumulated one or more messages/errors and context finalization reached `_MTLMessageContextEndNewNSErrorOrAbort -> MTLReportFailure -> abort`.

Classification:
- `D97FT_NATIVE_METAL_VALIDATION_CONTEXT_END=STATIC_MAPPED`;
- `D97FT_NATIVE_METAL_VALIDATION_ERROR_CONTEXT=REACHED_NEGATIVE`;
- exact individual validation predicate remains UNKNOWN.

## Relevant validation classes mapped
Static analysis of Tahoe Metal maps `_validateFunction` and render-raster validation families.

`_validateFunction` can report, among others:
- required function is nil;
- function belongs to a different device;
- function is not specialized and requires `newFunctionWithName:constantValues:...`.

Important precision:
- the fragment-function validation call allows nil in the mapped path; therefore a nil GPUPass fragment alone is NOT statically proven to be the descriptor-validation error.

Render-raster/device validation includes, among others:
- unsupported sample counts;
- invalid color/depth/stencil pixel formats;
- pixel format not color-renderable for the device;
- blendability/write-mask constraints;
- render-target storage limits;
- depth/stencil consistency;
- vertex-amplification/device-capability constraints.

For color attachments, Tahoe Metal queries `_MTLPixelFormatGetInfoForDevice(device,pixelFormat)` before device-specific capability checks. `BGR10A2Unorm` device renderability is therefore a candidate boundary, but is NOT yet proven causal.

## Exact 25G82 CoreDisplay metallib context
Existing project evidence establishes:
- exact 25G82 `CoreDisplay.framework/Versions/A/Resources/default.metallib` is part of MetallibSupportPkg;
- exact package copy SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- D97DX Root Patch runtime installed the exact CoreDisplay default.metallib.

No existing project artifact found so far provides a shader-level `GPUPass` AIR/metadata comparison for this CoreDisplay metallib against Golden Sequoia.

## Causal frontier after D97FT
Closed/excluded for current scope:
- set_id_mode `0x224` rejection — CLOSED PASS;
- D97BV delivery — CLOSED PASS;
- Tahoe-only CoreDisplay GPUPass bootstrap tuple/descriptor recipe — no divergence found, STATIC SEMANTIC EQUIVALENCE to Golden for mapped scope;
- `validateWithDevice +716` as a unique predicate — false interpretation; it is context-finalization return.

Current earliest captured negative:
`CoreDisplay newFunctionWithName:@"GPUPass" constantValues(-1,-1) -> NSError path REACHED`

Parallel downstream negative:
`GPUPass render descriptor -> Tahoe native Metal validation accumulates error -> __MTLMessageContextEnd -> abort`.

Exact common semantic cause across these two fatal modes remains UNKNOWN.

## CURRENT ACTION — STATIC GPUPASS METALLIB INSPECTION
Remain in VESA. No reboot and no EFI/Root Patch/framebuffer/NVRAM/bootarg changes.

Before designing any runtime observer, inspect the exact installed 25G82 CoreDisplay `default.metallib` statically, especially `GPUPass`:
- prove GPUPass presence and function metadata;
- recover target triple, AIR version, Metal language version, SDK metadata and function-constant metadata where statically available;
- compare against Golden CoreDisplay GPUPass if an existing read-only/persisted Golden artifact can provide it;
- distinguish metallib/shader specialization incompatibility from Tahoe Metal device-capability validation.

Do not repeat ACTIVE acceleration until this static metallib boundary is exhausted or a bounded observer is justified.