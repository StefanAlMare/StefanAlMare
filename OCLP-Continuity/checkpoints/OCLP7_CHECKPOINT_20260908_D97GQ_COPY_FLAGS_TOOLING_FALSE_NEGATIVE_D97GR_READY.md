# OCLP7 CHECKPOINT — D97GQ copy-flags tooling false negative; D97GR ready

Date: 2026-09-08 EEST

## Entering authority
D97GP proved the current MTLCompilerService crash is a regression to the historical missing-P1 selector boundary:
- installed service is exact Golden original SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- selector preimage at `0x3494` is still `81fe19790000` (`cmp esi, 31001`);
- real accelerated request is `32023`;
- MTLCompiler 32023 is exact Golden and statically exports all four required `MTLCodeGenService*` entrypoints.

D97GQ was designed to reconstruct historical P1 only on a disposable copy and compare the resulting SHA against the accepted historical P1/D97M identity `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

## D97GQ execution
User ran exact D97GQ helper and proved:
- helper identity PASS;
- VESA recovery boot arguments remained safe;
- source service SHA matched exact Golden original.

The helper then stopped at:
`cp: chflags: .../MTLCompilerService.P1.copy: Operation not permitted`

Cause:
- D97GQ used `cp -p`;
- `-p` attempted to preserve protected filesystem flags from the sealed System-volume file onto the Desktop copy;
- macOS rejected the `chflags` operation.

No semantic patching step was reached.
No system/root/EFI/NVRAM/framebuffer mutation occurred.
No Root Patch/Restore/reboot occurred.

Classification:
`D97GQ_RESULT=TOOLING_FALSE_NEGATIVE_COPY_METADATA_FLAGS`

This is not evidence against P1 reconstruction semantics.

## D97GR correction
D97GR supersedes D97GQ for this copy-only reconstruction.

Changes:
- uses plain `/bin/cp` without `-p`;
- explicitly verifies the copy SHA equals the source SHA before patching;
- modifies only the disposable Desktop copy;
- keeps the same unique selector preimage and exact P1 postimage;
- compares patched-copy SHA to accepted historical P1/D97M SHA.

Helper:
`OCLP-Continuity/artifacts/OCLP7_D97GR_READONLY_RECONSTRUCT_P1_SELECTOR_COPY_V2.sh`
- commit `f0b5cf130a02b8c75b0823bb80ed0dd48dfe290a`;
- Git blob `e93cabd94b6e5395671a8111aad4e49e0ef8155c`.

## Current action
Remain VESA.
Do not Root Patch or reboot.
Run only D97GR and classify its byte-for-byte result.

Desired decisive closure:
- original SHA exact;
- preimage unique at `0x3494`;
- patched SHA exact historical P1/D97M;
- delta confined to selector instruction bytes;
- `D97GR_P1_RECONSTRUCTION=EXACT_HISTORICAL_MATCH`.
