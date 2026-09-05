# OCLP7 CHECKPOINT — D97BN partial PASS; two Tahoe builder layouts closed; v2 generation/caller completion ready

Date: 2026-09-05 EEST

## Entering state
- Target: Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current ASUS2 state: unpatched VESA, `-igfxvesa`, no active Root Patch.
- Native 25G82 Metal `__TEXT` SHA256 remains `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.
- Native MTLCompilerService SHA256 remains `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
- D97BM already proved native Metal4/IOGPU class-name surface present and found two complete Tahoe XPC request builders.

## D97BN execution result
User ran `OCLP7_D97BN_tahoe_all_builders_generation_origin.sh`.

The script made no source/system/cache mutation, Root Patch or reboot.

It mapped both complete builders and multiple scalar helpers, then fail-closed before the generation-immediate/caller census because `dis_func()` refused one very large LC_FUNCTION_STARTS range:
`RuntimeError: FUNCTION_SIZE_UNSAFE:0xDE15A`.

Classification:
`D97BN_V1_RESULT=PARTIAL_PASS_READONLY_TOOLING_SIZE_GUARD`.

This is a collector limitation, not Tahoe functional evidence.

## Builder A — static scalar closure
Exact function:
`0x7FF80F635510..0x7FF80F635A4D`.

Function entry:
- `RDI -> RBX`;
- `RSI -> R12`.

Exact XPC scalar sources:
- llvmVersion: `0x7FF80F6355EC: movslq 0x1c(%rbx), %rdx` -> `[ABI_ARG1_RDI + 0x1C]`;
- requestType: helper call with `R12` in RDI -> helper `0x7FF80F5A59CC`;
- timeout: helper call with `R12` in RDI -> helper `0x7FF80F5A5A0C`.

Helper `0x7FF80F5A59CC` is exactly:
`movl 0xac(%rdi), %eax; ret`.

Helper `0x7FF80F5A5A0C` is exactly:
`movq 0xb8(%rdi), %rax; ret`.

Therefore:
- `D97BN_BUILDER_A_LLVMVERSION_SOURCE_ARG1_PLUS_0x1C=STATIC_VALUE_SOURCE_PROVEN`;
- `D97BN_BUILDER_A_REQUESTTYPE_SOURCE_ARG2_PLUS_0xAC=STATIC_VALUE_SOURCE_PROVEN`;
- `D97BN_BUILDER_A_TIMEOUT_SOURCE_ARG2_PLUS_0xB8=STATIC_VALUE_SOURCE_PROVEN`.

## Builder B — static scalar closure
Exact function:
`0x7FF80F663CA9..0x7FF80F66492C`.

Key entry provenance inside function:
- original RDI saved at `-0x98(%rbp)`;
- `0x28(%rdi)` loaded into R15;
- llvmVersion is later read through original-RDI object.

Exact llvmVersion source:
`0x7FF80F663DF0: movslq 0x38(%rcx), %rdx` with RCX loaded from saved original RDI.
Thus builder B llvmVersion source is `[ABI_ARG1_RDI + 0x38]`.

requestType uses R15 as helper argument and calls the same exact `0x7FF80F5A59CC`, therefore `[RDI+0x28]` subordinate object `+0xAC` supplies requestType.

timeout uses the same subordinate object family and helper `0x7FF80F5A5A0C`, therefore subordinate object `+0xB8` supplies timeout.

Classifications:
- `D97BN_BUILDER_B_LLVMVERSION_SOURCE_ARG1_PLUS_0x38=STATIC_VALUE_SOURCE_PROVEN`;
- `D97BN_BUILDER_B_REQUESTTYPE_SOURCE_ARG1_PLUS_0x28_DEREF_PLUS_0xAC=STATIC_VALUE_SOURCE_PROVEN`;
- `D97BN_BUILDER_B_TIMEOUT_SOURCE_ARG1_PLUS_0x28_DEREF_PLUS_0xB8=STATIC_VALUE_SOURCE_PROVEN`.

## Alternate requestType closure
Two alternate requestType paths were mapped:
- `0x7FF80F62717E`;
- `0x7FF80F63539E`.

Both write exact immediate `9` into EDX before the uint64 setter.

Classification:
`D97BN_TAHOE_ALTERNATE_REQUESTTYPE_VALUE_9=STATIC_VALUE_PROVEN_TWO_PATHS`.

This matches the retained Golden alternate requestType immediate `9` semantic.

## Comparison to Golden producer layout
Golden primary builder:
- llvmVersion `[ABI_ARG1 + 0x20]`;
- requestType `[ABI_ARG2 + 0x08]`;
- timeout `[ABI_ARG2 + 0x18]`.

Tahoe has at least two distinct native request-object layouts:
- Builder A: llvmVersion `arg1+0x1C`, requestType `arg2+0xAC`, timeout `arg2+0xB8`;
- Builder B: llvmVersion `arg1+0x38`, requestType subordinate object `+0xAC`, timeout subordinate object `+0xB8`.

Thus a literal Golden-offset transplant into native Tahoe Metal is forbidden without request-family-specific provenance. Offset difference is structural proof, not by itself proof of wrong value semantics.

## Runtime generation fact retained
Historical D97AA accelerated evidence remains authoritative for the observed failing cohort:
- 12/12 MTLCompilerService spawns received `llvmVersion=32023`;
- 3802=0;
- other=0.

Working Golden naturally uses both 3802 and 32023 donor lanes.

The missing Tahoe 3802 generation lane therefore remains the active upstream semantic difference to localize.

## D97BN v2 design
Prepared `OCLP7_D97BN_v2_generation_and_caller_completion.sh`.

V2 intentionally does not rerun the already-completed builder/helper dump. It only completes the sections not reached in v1:
1. raw + instruction-validated 3802/31001/32023 immediate census in exact 25G82 native Metal `__text`;
2. direct E8 caller census for builder A and builder B;
3. bounded context around matching generation instructions and builder callsites;
4. allow functions up to `0x200000` bytes in temporary disassembly, but print only local context;
5. preserve exact native Metal identity, VESA/no-root-patch gates;
6. no mutation, Root Patch or reboot.

V2 identity:
- bytes `13626`;
- SHA256 `0976a64b8f864a7b6895fcab742e666bda386ce6f9428aefb67de745e6877d80`.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only `OCLP7_D97BN_v2_generation_and_caller_completion.sh` and return its generated ZIP.

No Root Patch and no accelerated reboot are authorized.