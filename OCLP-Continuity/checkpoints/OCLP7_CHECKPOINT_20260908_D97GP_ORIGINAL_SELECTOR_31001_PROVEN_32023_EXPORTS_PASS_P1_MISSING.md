# OCLP7 CHECKPOINT — D97GP original selector 31001 proven; 32023 compiler exports PASS; P1 missing

Date: 2026-09-08 EEST

## Entering authority
D97GN proved 12/12 MTLCompilerService crashes converge on EXC_BAD_ACCESS/SIGSEGV at address 0, RIP=0, `r15=32023`, return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56` / service file offset `0x3448`.

## D97GP current service identity
Read-only audit of the active corrected-root-patch VESA system proved:
- service path `/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService`;
- bytes `85520`;
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- this is exact Golden original service identity, not the historical D97M selector-patched identity `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Static bytes:
- selector compare at file offset `0x3494`: `81fe19790000` = `cmp esi, 0x7919` = decimal 31001;
- expected P1/D97M selector bytes: `81fe177d0000` = decimal 32023;
- indirect call at `0x3444`: `41ff5608` = `callq *0x8(%r14)` exact.

The service constructor maps only exact selector 31001 to `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`. A runtime request carrying 32023 does not take that mapping.

## D97GP current MTLCompiler 32023 identity
- path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- bytes `1636896`;
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` = exact Golden compiler identity;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

All four required exports are present in Mach-O symbol metadata:
- `MTLCodeGenServiceCreate` PRESENT;
- `MTLCodeGenServiceDestroy` PRESENT;
- `MTLCodeGenServiceBuildRequest` PRESENT;
- `MTLCodeGenServiceSetPluginPath` PRESENT;
- required export count `4/4` PASS.

Classification:
- `D97GP_STATIC_MISSING_EXPORT_HYPOTHESIS=NEGATIVE`;
- `D97GP_CURRENT_SERVICE_P1_SELECTOR_BRIDGE=MISSING_PROVEN`;
- `D97GP_CURRENT_32023_COMPILER_IDENTITY_AND_EXPORTS=PASS`.

## Causal composition
D97GN runtime gives selector/request value 32023 at every crash. D97GP static map proves the installed service still recognizes 31001, not 32023, for the 32023 compiler lane. The current null indirect call therefore matches the historical pre-P1 frontier.

This is a regression/integration omission, not evidence of a new Haswell/Metal4 hardware wall.

## Next
Before any system mutation or reboot, reconstruct P1 on a disposable copy of the current exact service:
- verify current preimage and SHA;
- replace only `81fe19790000` at `0x3494` with `81fe177d0000`;
- compute patched-copy SHA;
- compare with historical D97M expected SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- prove the diff is exactly the selector immediate and nothing else.

No accelerated boot is authorized until this exact P1 reconstruction and subsequent integration design are closed.