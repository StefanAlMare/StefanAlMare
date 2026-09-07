# OCLP7 CHECKPOINT — D97GN MTLCompilerService null indirect-call regression; D97GP static gate ready

Date: 2026-09-08 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Corrected Root Patch metallib layer is active and exact (`180/180`, zero missing/different/stubs; CoreDisplay exact `20739` bytes / SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d` / `MTLB`).
- D97GL proved semantic progress versus old D97FJ: old `validateWithDevice` / `MTLReportFailure` fatal frontier disappeared after real metallib repair; new measured frontier is repeated `MTLCompilerService` crash/restart with WindowServer XPC interruption.
- User-authoritative accelerated boot boundaries: ACCEL1 starts `2026-09-07 23:39` local; ACCEL2 starts `23:50`; VESA recovery starts `23:52`.
- ACCEL1 had `igfxfw=2`, `rps-control=1`, and Max Pixel Clock Override enabled. ACCEL2 had all three disabled. Future baseline keeps all three OFF until usable accelerated image exists.
- D97EZ remains CLOSED PASS; ACCEL2 measured 58/58 calls successful: 20 exact `0x224 -> 0x24` adaptations, 38 passthrough, zero failures.

## D97GN evidence archive
User returned `OCLP7_D97GN_MTLCOMPILERSERVICE_IPS_20260908_002901(1).zip` containing 12 `MTLCompilerService` `.ips` reports from the two accelerated sessions.

All 12 reports converge on the same crash signature:
- process: `MTLCompilerService`;
- CFBundleVersion / ShortVersion: `263.8`;
- service slice UUID: `3716d20f-b990-3906-b3e5-44e88ae63af8`;
- path: `/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService`;
- exception: `EXC_BAD_ACCESS` / `SIGSEGV`;
- subtype: `KERN_INVALID_ADDRESS at 0x0000000000000000`;
- faulting `RIP=0` and `CR2=0`;
- `r15=32023` on every report;
- first symbolized return frame: `MTLConnectionCtx::MTLConnectionCtx(int) + 56`, imageOffset `13384 = 0x3448`;
- next frame: `invocation function for block in ctx(int) + 35`, imageOffset `13297 = 0x33F1`.

The signature occurs in both boot sessions:
- ACCEL1 bootSessionUUID `06F343F8-7DFD-4375-83C7-25BE3609B05E`;
- ACCEL2 bootSessionUUID `D5D4E326-E54A-498B-BBD3-D6478E4D3D46`.

Classification:
`D97GN_MTLCOMPILERSERVICE_CRASH_SIGNATURE=SEMANTIC_PROVEN`.

## Static correlation to exact service control flow
Previously accepted D97M static map of the same 263.8 service maps `MTLConnectionCtx::MTLConnectionCtx(int)`:
- constructor starts `0x100003410`;
- calls `CompilerPluginInterface::CompilerPluginInterface(int)` at `0x10000343C`;
- then stores object pointer;
- exact `0x100003444: callq *0x8(%r14)`;
- return address `0x100003448` corresponds to crash frame imageOffset `0x3448`.

The same static map shows `CompilerPluginInterface::CompilerPluginInterface(int)`:
- for selector `0x7D17 = 32023`, chooses `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- calls `dlopen`;
- `dlsym("MTLCodeGenServiceCreate")` -> stores result at object offset `0x8`;
- `dlsym("MTLCodeGenServiceDestroy")` -> `0x10`;
- `dlsym("MTLCodeGenServiceBuildRequest")` -> `0x18`;
- `dlsym("MTLCodeGenServiceSetPluginPath")` -> `0x20`;
- only the `dlopen` handle is checked for NULL; the individual `dlsym` results are not null-checked before the immediate indirect call at `0x100003444`.

Therefore the observed `RIP=0` at the immediate `callq *0x8(%r14)` is structurally consistent with `MTLCodeGenServiceCreate` resolving to NULL (or otherwise leaving the `+0x8` function pointer NULL).

Classification:
`D97GN_NULL_INDIRECT_CALL_SITE=STATIC_MAPPED_PROVEN`.

The exact reason that `+0x8` is NULL remains UNKNOWN until current on-disk service/compiler identities and symbol exports are audited. Do not yet claim missing export versus dlsym namespace/loader failure.

## Historical regression identity
The project archive `Tahoe-25G82-MTLBridge-AccelCrash-20260814-111243.txt` contains the same historical failure signature before the compiler bridge was developed:
- `RIP=0`;
- `r15=32023`;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56` / imageOffset `13384`;
- same legacy MTLCompilerService 263.8 path/signature class.

Thus current D97GN is a regression to a previously encountered pre-bridge service/compiler boundary, not a novel framebuffer failure.

Classification:
`D97GN_HISTORICAL_SIGNATURE_MATCH=SEMANTIC_PROVEN`.

## D97DX relevance / hypothesis guard
D97DX's native-Metal-safe patch dictionary intentionally installs:
- bounded `MTLCompilerService.xpc` donor `12.5-3802-23`;
- private `MTLCompiler.framework` / `GPUCompiler.framework` donor lanes;
- no whole legacy Metal.framework shadow.

The D97DX build delta did not itself reintroduce the project's historical `sys_patch_helpers.py` compiler bridge chain as new source modifications. However, the `12.5-3802-23` service donor may already contain the Tahoe 32023 selector modification. Therefore DO NOT conclude that the selector bridge is absent until current service SHA/bytes are read.

## Current causal frontier
Closed/proven:
- corrected real metallib layer active;
- old CoreDisplay native-Metal validation abort frontier removed in measured corrected-payload runs;
- D97EZ exact set_id_mode adapter remains CLOSED PASS;
- current no-image accelerated failure is upstream of actual shader compilation and localizes to MTLCompilerService context construction.

Current exact frontier:
`MTLCompilerService 263.8 -> CompilerPluginInterface(selector=32023) -> dlopen MTLCompiler/Versions/32023 -> dlsym codegen entrypoints -> immediate function-pointer call -> NULL target at +0x8`.

UNKNOWN:
- whether current service binary exactly equals the accepted selector-patched D97M service;
- whether current `MTLCompiler/Versions/32023` exports all four required `MTLCodeGenService*` symbols;
- if exports exist, why `dlsym` returns NULL (loader namespace/visibility/other runtime condition).

## Next action — D97GP static identity/export gate only
Remain in current VESA recovery. No EFI/NVRAM/framebuffer/root changes and no reboot.

D97GP must read only:
1. current MTLCompilerService SHA/UUID/version and selector/path bytes;
2. current `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` SHA/UUID/file type;
3. exported/global symbol tables for:
   - `MTLCodeGenServiceCreate`
   - `MTLCodeGenServiceDestroy`
   - `MTLCodeGenServiceBuildRequest`
   - `MTLCodeGenServiceSetPluginPath`;
4. current compiler dependencies / dylib load commands;
5. no `dlopen` execution, no service launch, no compilation, no Root Patch.

No accelerated boot is authorized before D97GP classification.
