# OCLP7 CHECKPOINT — D97GR exact historical P1 reconstruction PASS; current NULL-call causally closed; P1-only integration next

Date: 2026-09-08 EEST

## Entering authority
D97GN proved 12/12 current corrected-payload accelerated crashes converge on the historical pre-P1 signature:
- MTLCompilerService 263.8;
- EXC_BAD_ACCESS / SIGSEGV;
- RIP=0 / CR2=0;
- r15=32023;
- first symbolized return `MTLConnectionCtx::MTLConnectionCtx(int)+56`, file offset `0x3448`.

D97GP then proved:
- installed service is exact Golden original SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- selector at file offset `0x3494` is original `81fe19790000` = compare 31001;
- exact runtime request is 32023;
- current MTLCompiler 32023 is exact Golden SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- all four required `MTLCodeGenService*` exports are present;
- therefore the current crash is caused by missing P1 selector mapping, not missing compiler exports.

D97GQ first stopped only on `cp -p` filesystem-flag preservation and was classified TOOLING FALSE NEGATIVE. D97GR superseded it with byte-identity-only copy semantics.

## D97GR execution
User ran exact helper `OCLP7_D97GR_READONLY_RECONSTRUCT_P1_SELECTOR_COPY_V2.sh` in VESA recovery.

Safety state:
- system mutation NO;
- Root Patch NO;
- Restore NO;
- EFI/NVRAM/framebuffer mutation NO;
- reboot NO;
- patch target disposable Desktop copy only.

Exact original service:
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- copy-before-patch SHA identical PASS.

Exact P1 preimage:
- offset `0x3494`;
- bytes `81fe19790000`;
- unique occurrence count `1`;
- unique occurrence exactly at `0x3494`.

Exact P1 postimage:
- bytes `81fe177d0000`;
- disassembly: `cmpl $0x7d17, %esi` = 32023;
- following literal remains `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- `cmovne` and `_dlopen` continuation remain unchanged.

Patched-copy identity:
- SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- exact historical P1/D97M SHA MATCH PASS.

Binary delta:
- exactly two bytes differ;
- offsets `0x3496` and `0x3497` only;
- `0x3496: 19 -> 17`;
- `0x3497: 79 -> 7d`;
- no other file byte changed.

Helper final:
- `D97GR_P1_RECONSTRUCTION=EXACT_HISTORICAL_MATCH`;
- `D97GR_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`;
- `D97GR_STATUS=PASS_READONLY_COPY_RECONSTRUCTION`.

## Causal closure
By composition:
1. D97GN runtime proves the current service receives selector/request 32023 and dies at the NULL create-function call.
2. D97GP proves the installed service still maps only 31001 to the 32023 compiler lane while the compiler itself and all required exports are valid.
3. D97GR proves the historical P1 two-byte selector bridge reconstructs byte-for-byte the accepted historical patched service identity.

Therefore:
`D97GR_CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`

This does not yet prove the post-P1 downstream runtime path or usable GUI.

## Methodological consequence
Do NOT replay the whole historical true-five patchset blindly.
The currently measured failed module is the selector boundary only.
Next remediation must be P1-only, guarded by exact source/preimage/SHA checks, while preserving:
- native Tahoe main Metal/Metal4 ABI;
- corrected real 25G82 metallibs;
- current bounded legacy compiler lanes;
- D97EZ exact set_id_mode adapter;
- Haswell AuxKC/userspace driver state;
- optional iGPU properties OFF baseline.

P2b/P3/AIR00/D34 remain accepted historical design evidence and may be reintroduced only if the next measured downstream frontier proves they are needed.

## Next
Design and audit a bounded D97DX integration that applies exact P1 only after the legacy `MTLCompilerService.xpc` donor is installed on the mounted root and before OCLP creates the new APFS snapshot.

Requirements:
- exact build 25G82 guard;
- exact target path guard;
- exact original service SHA guard;
- unique preimage at `0x3494` guard;
- write only two selector-immediate bytes;
- exact post-patch SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` required;
- abort patching on any mismatch;
- no change to metallib materialization or other patchsets;
- no accelerated boot until source/build/integration identity is independently audited.
