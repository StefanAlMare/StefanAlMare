# OCLP7 CHECKPOINT — D97BO FULL PASS; no direct generation/writer intersection; constructor/selector dataflow next

Date: 2026-09-05 EEST

## Entering state
- Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine remains unpatched VESA after snapshot restore; `-igfxvesa` active; no Root Patch.
- Native Tahoe Metal4 must remain authoritative. Full legacy `13.2.1-24/Metal.framework` remains permanently forbidden because it shadows cache-resident Metal and breaks `_MTL4*` ABI.
- Historical native-Metal + legacy-XPC/private compilers + true-five has already failed to yield usable GUI and must not be repeated unchanged.

## D97BO returned bundle
`OCLP7_D97BO_LLVMVERSION_FIELD_WRITER_AND_GENERATION_ORIGIN_20260905_225120.zip`
- bytes `905767`;
- SHA256 `a83675a6f07bb330537d93d4011ae6688a0024f162cc8acd67756ecdc0ab6380`.

JSON parsed successfully. Final TXT markers:
- `D97BO_FIELD_WRITE_CENSUS=PASS`;
- `D97BO_GENERATION_CALLER_CENSUS=PASS`;
- `D97BO_GENERATION_GLOBAL_XREF_CENSUS=PASS`;
- `D97BO_WRITER_GENERATION_INTERSECTION=PASS`;
- `D97BO_AUDIT=PASS`.

No source/system/cache mutation, Root Patch or reboot occurred.

Classification:
`D97BO_RESULT=FULL_PASS_READONLY`.

## Generation singleton closure
D97BO revalidated native Tahoe generation initializers:
- 3802 initializer `0x7FF80F614D86..0x7FF80F614D9F` calls the common factory with ESI=`0xEDA` and stores returned RAX into global `0x7FF843D65C90`;
- 32023 initializer `0x7FF80F614DB8..0x7FF80F614DD1` calls the same factory with ESI=`0x7D17` and stores returned RAX into global `0x7FF843D65CB0`.

Each generation global has two mapped xrefs. The important shared selector function is:
`0x7FF80F5EFFEB..0x7FF80F5F009C`.

Its static logic explicitly distinguishes generation IDs:
- compare EDX with `0xEDA` (3802);
- compare EDX with `0xF3E`;
- compare EDX with `0x7D17` (32023);
- compare EDX with `0x7D18`;
- select the corresponding generation global/singleton.

Classification:
`TAHOE_NATIVE_GENERATION_SINGLETON_SELECTOR_3802_32023=STATIC_PROVEN`.

This confirms 3802 support is live architecture in native Tahoe Metal rather than dead data.

## llvmVersion-field write census
A broad instruction-level write census found:
- 81 instructions writing displacement `+0x1C` somewhere in Metal `__text`;
- 1804 instructions writing displacement `+0x38` somewhere in Metal `__text`.

These counts are broad structural candidates because displacement alone does not prove object type. They must not be described as 81/1804 llvmVersion writers.

### High-value constructor candidate
One function intersects the broad field-write set with explicit native 32023 logic:
`0x7FF80F4A5DF8..0x7FF80F4A7A88`.

Within this function:
- `0x7FF80F4A6283`: compares stack-local `-0x27C(%rbp)` with exact `0x7D17` (32023);
- `0x7FF80F4A726F`: writes dword from stack-local `-0x3A0(%rbp)` to `0x1C(%r13)`;
- `0x7FF80F4A727A`: writes a separate dword to `0x20(%r13)`;
- `0x7FF80F4A72B1`: copies a 16-byte block to `0x38(%r13)`;
- `0x7FF80F4A79CE`: writes dword from stack-local `-0x2C4(%rbp)` to `0x38(%r8)` in another constructed layout.

The function is therefore a real high-value object-construction/layout candidate that combines generation-aware logic with the exact displacements consumed by the two native XPC builders.

Classification:
`D97BO_GENERATION_AWARE_OBJECT_CONSTRUCTOR_CANDIDATE_0x7FF80F4A5DF8=STATIC_MAPPED_HIGH_PRIORITY`.

This is not yet proof that the exact constructed object reaches Builder A/B. Stack-local provenance and caller/object identity remain open.

## Other broad writer functions containing 32023 logic
Two additional functions in the broad `+0x38` displacement census contain exact 32023 logic:
- `0x7FF80F5F5793..0x7FF80F5F586F`;
- `0x7FF80F6024F1..0x7FF80F60261E`.

For these, the matched writes are stack-local `-0x38(%rbp)` rather than an established request-object field, so they are not promoted as llvmVersion writers.

## No simple direct intersection
D97BO found no writer-function intersection with:
- a direct call to the known 3802-return / 3802-init / 32023-init functions;
- a direct reference to the generation singleton globals;
- a 3802 immediate in a broad field-writer function.

Only three broad writer functions contain 32023 immediates, with the constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88` the only high-value object-layout candidate.

Classifications:
- `D97BO_DIRECT_GENERATION_FUNCTION_TO_LLVMVERSION_WRITER_EDGE=NEGATIVE`;
- `D97BO_GENERATION_GLOBAL_TO_LLVMVERSION_WRITER_DIRECT_XREF=NEGATIVE`;
- `D97BO_SIMPLE_ONE_HOP_NORMALIZATION_SITE=NOT_PROVEN`.

This means a one-instruction/one-global patch is not justified.

## Builder-A caller context retained
D97BN-v2 already proved three direct Builder-A callers. Two wrapper callers source Builder-A arg1 from `[incoming object +0x38]` and pass neighboring fields `+0x40/+0x48/+0x20/+0x50/+0x54` as other arguments. D97BO captured those caller bodies for the next object-provenance comparison.

## Strategic consequence
The next frontier is dataflow between:
1. generation-aware object construction (`0x7FF80F4A5DF8..0x7FF80F4A7A88`), especially stack locals feeding `+0x1C` / `+0x38`;
2. native generation singleton selection (`0x7FF80F5EFFEB..0x7FF80F5F009C`);
3. Builder-A wrapper objects whose `[+0x38]` becomes Builder-A arg1;
4. Builder-B indirect/virtual ingress.

Do not Root Patch and do not patch `32023 -> 31001` or any literal field offset yet.

## CURRENT ACTION — D97BP
Remain unpatched in VESA.

Next read-only audit should be narrowly bounded to:
1. back-slice stack locals `-0x3A0`, `-0x2C4`, and generation discriminator `-0x27C` inside constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88`;
2. map direct callers of that constructor and argument/object provenance;
3. map direct callers of native generation selector `0x7FF80F5EFFEB..0x7FF80F5F009C` and the EDX source at each call;
4. compare those caller/dataflow objects against Builder-A caller wrapper shape and Builder-B request-object shape;
5. determine whether one natural upstream adapter boundary is statically proven.

No source/system/cache mutation, Root Patch or reboot.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until:
- native Metal4 remains authoritative;
- legacy main Metal is absent from the proposed root;
- legacy service/compiler ingress remains bounded;
- exact 25G82 metallib handling remains intact;
- producer normalization is statically complete across relevant request families;
- the experiment provides new causal information beyond the historical true-five state.
