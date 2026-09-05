# OCLP7 CHECKPOINT — D97BN v2 full PASS; Tahoe has zero 31001, two native llvmVersion layouts; field-writer origin next

Date: 2026-09-05 EEST

## Entering state
- Target: Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine state remains unpatched Tahoe VESA after sealed/saved snapshot restore.
- D97BM already proved exact native Tahoe Metal/IOGPU cache identity, both native request-builders, native Metal4 class presence, and first builder `llvmVersion=[arg1+0x1C]`.
- D97BN v1 mapped both builder layouts and helper offsets but stopped fail-closed on an oversized function during generation census; no mutation occurred.

## D97BN v2 returned bundle
`OCLP7_D97BN_V2_GENERATION_AND_CALLER_COMPLETION_20260905_224128.zip`
- bytes: `11417`
- SHA256: `06f6c90e89bd384189d8e2179ebbcc0351f3783738bc24f3268e47d24562957d`.

Final markers:
- `D97BN_V2_GENERATION_CENSUS=PASS`
- `D97BN_V2_BUILDER_CALLER_CENSUS=PASS`
- `D97BN_V2_AUDIT=PASS`
- user collector was read-only; no Root Patch/reboot/system mutation.

## Two native Tahoe request-builder layouts — retained / strengthened
### Builder A
Function:
`0x7FF80F635510..0x7FF80F635A4D`

Static sources:
- `llvmVersion = signed dword [ABI_ARG1_RDI + 0x1C]`;
- `requestType = helper(ABI_ARG2_RSI)` where helper `0x7FF80F5A59CC` is exactly `movl 0xAC(%rdi), %eax; ret`;
- timeout = helper on same object family where `0x7FF80F5A5A0C` is exactly `movq 0xB8(%rdi), %rax; ret`.

Three direct E8 callers were validated:
1. call `0x7FF80F6352BA`, caller `0x7FF80F63524A..0x7FF80F635339`; passes `R13` as builder arg1 and an 8-argument request construction tuple;
2. call `0x7FF80F6361EB`, caller `0x7FF80F6361AD..0x7FF80F636214`; builder arg1 comes from `[incoming RDI + 0x38]`;
3. call `0x7FF80F636240`, caller `0x7FF80F636214..0x7FF80F63624C`; builder arg1 likewise comes from `[incoming RDI + 0x38]`.

### Builder B
Function:
`0x7FF80F663CA9..0x7FF80F66492C`

Static sources:
- `llvmVersion = signed dword [ABI_ARG1_RDI + 0x38]`;
- requestType is read through the same `+0xAC` helper family from the request object reached via `[arg1+0x28]`;
- timeout uses the same `+0xB8` helper family;
- no direct E8 callers were found for Builder B, so its ingress is likely indirect/virtual/non-E8 and remains to be mapped separately if required.

Both alternate requestType paths observed by D97BN use exact immediate `9`.

Classification:
`D97BN_TAHOE_TWO_DISTINCT_NATIVE_LLVMVERSION_LAYOUTS=STATIC_PROVEN`.

## Generation-value census — decisive
Inside exact native Tahoe 25G82 Metal `__text`:
- raw imm32 `3802` occurrences: 11; instruction-validated occurrences: 9;
- raw/validated `31001` occurrences: **0**;
- raw/validated `32023` occurrences: 10.

Classification:
- `TAHOE_NATIVE_METAL_31001_IMMEDIATE_CENSUS=ZERO_STATIC_PROVEN`;
- `TAHOE_NATIVE_METAL_3802_LOGIC_PRESENT=STATIC_PROVEN`;
- `TAHOE_NATIVE_METAL_32023_LOGIC_PRESENT=STATIC_PROVEN`.

This is the key dialect difference from working Golden: Golden service semantics use `31001 -> Versions/32023`, while Tahoe native producer code contains no 31001 immediate at all.

## Important generation functions / contexts
Validated 3802-specific code includes:
- `0x7FF80F596A81..0x7FF80F596A8C`: tiny function returning exact `3802` (`movl $0xEDA,%eax; ret`);
- `0x7FF80F614D86..0x7FF80F614D9F`: initializes a global/factory lane with immediate `3802`;
- several dispatch/comparison functions that classify `3802`, `0xF3E`, and the `32023/32024` range.

Validated 32023-specific code includes:
- `0x7FF80F614DB8..0x7FF80F614DD1`: analogous global/factory initialization with immediate `32023`;
- `0x7FF80F5E1624..0x7FF80F5E1778`: minimum/current-generation logic that explicitly clamps/uses `32023`/`32024`;
- multiple dispatch/comparison functions treating `32023` and `32024` as a generation family.

These prove Tahoe still has real 3802 logic; the runtime D97AA observation of 12/12 requests as 32023 therefore cannot be explained by total absence of 3802 support in Metal.

## Runtime composition with D97AA
D97AA authoritative accelerated cohort:
- 12 unique MTLCompilerService requests;
- `llvmVersion=32023`: 12;
- `3802`: 0;
- other: 0.

Therefore:
`TAHOE_FAILING_RUNTIME_REQUEST_COHORT_ALL_32023` remains PROVEN, while static native Metal still contains 3802 generation machinery.

This rules out a naive global constant replacement. A safe adapter must identify why the relevant request object fields become 32023 and only normalize the appropriate request class at or before those object-field writes.

## Strategic consequence
Do **not** patch builder A `+0x1C` to Golden `+0x20`; Builder B uses a different valid layout `+0x38`, and offset difference alone is not proof of bad semantics.

Do **not** globally replace `32023 -> 31001`; Tahoe uses 32023 throughout legitimate native-generation logic and also contains separate 3802 paths.

Preferred next boundary:
identify the exact writers/producers of the fields consumed as `llvmVersion` by both builders:
- Builder A arg1 field `+0x1C`;
- Builder B arg1 field `+0x38`;
then connect those writers to the native 3802/32023 generation-selection functions.

Only after that origin is static-proven can a bounded upstream normalizer be designed.

## D97BO CURRENT ACTION
Remain unpatched in VESA.

Run a read-only field-writer/provenance audit that:
1. pins exact 25G82 native Metal text SHA;
2. maps all instruction-level writes to object offsets `+0x1C` and `+0x38` in Metal `__text`;
3. maps validated Builder A caller argument provenance, especially caller objects whose `[+0x38]` becomes builder arg1;
4. maps direct/indirect generation functions around the exact 3802-return and 32023-generation initializers;
5. identifies call/dataflow paths from generation selection into the two llvmVersion fields where statically resolvable;
6. does not patch cache/root/system, does not Root Patch and does not reboot.

No Root Patch authorized. No accelerated reboot authorized. Golden remains immutable/read-only.