# OCLP7 CHECKPOINT — 2026-09-04 — D97AZ V4 GOLDEN_B request-builder value backslice PASS; llvmVersion source lies before aligned left edge; D97BB prelude next

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Remain in working GOLDEN_B Sequoia `15.8 / 24H22` until the Golden contract book is sufficiently complete. Do not start Tahoe eligibility bypass yet.

## D97AZ V4 returned batch — exact local identities
User returned:
- TXT `OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.txt`: 17967 bytes / SHA256 `04b89d8b9e8b2d6dcd8a8210a90e7406ea1bc3632d64646d8385c248fe51f1e2`;
- JSON `OCLP7_D97AZ_GOLDEN_METAL_REQUEST_BUILDER_VALUE_BACKSLICE.json`: 8841 bytes / SHA256 `445cfb3160513756a9be40a374d2137694c658ab08048ca3b2181fa67d3d0ce6`.

JSON parses successfully and agrees with TXT field classifications and raw instruction/dataflow records.

D97AZ revalidated GOLDEN_B identity:
- OS `15.8 / 24H22`;
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Final core markers:
- `G1_GOLDEN_PRIMARY_REQUEST_BUILDER_VALUE_BACKSLICE=COMPLETE_FOR_STATIC_CHANNEL`;
- `RUNTIME_VALUE_CLAIM=NO`;
- `D97AZ_AUDIT=COMPLETE`;
- no system mutation, cache mmap, persistent extraction/instrumentation, debugger attach, Root Patch or reboot.

Classification: `D97AZ_V4_GOLDEN_B_PRIMARY_REQUEST_BUILDER_STATIC_BACKSLICE=PASS`.

## Setter-family pairing — static mapped
Three consecutive call targets partition the primary fields by expected XPC setter type:
- target `0x7FF80D50FDC8` (Metal +`0x1CCDC8`): `pluginPath`, `client_name` — string-setter family;
- target `0x7FF80D50FDCE` (+`0x1CCDCE`): `llvmVersion`, `requestType`, `APISpecifiedTimeoutInSeconds`, and alternate `requestType` — uint64-setter family;
- target `0x7FF80D50FDD4` (+`0x1CCDD4`): `sandboxTokens`, `targetData`, `data` — value-setter family.

The exact imported symbol names were not independently recovered by D97AZ; the family pairing is supported by field schema plus common target grouping. Do not overstate imported-symbol identity beyond this.

## Primary request-builder field source map
### requestType — STATIC_VALUE_SOURCE_PROVEN
Exact chain:
- `movl 0x8(%r13), %r14d` at `0x7FF80D37082E`;
- key `requestType` xref at `0x7FF80D370832`;
- `movq %r14, %rdx` at `0x7FF80D37083C`;
- uint64-setter-family call at `0x7FF80D37083F`.

Therefore the primary Golden request-builder setter source is the 32-bit field `[r13+0x8]`, zero-extended through R14 into RDX.
Classification: `G1_GOLDEN_PRIMARY_REQUESTTYPE_SOURCE_R13_PLUS_0x8=STATIC_VALUE_SOURCE_PROVEN`.

The following code derives `requestType & ~1` and compares it with `0x10`, proving this source participates in explicit request-class branching.

### APISpecifiedTimeoutInSeconds — STATIC_VALUE_SOURCE_PROVEN
Exact chain:
- `movq 0x18(%r13), %rdx` at `0x7FF80D370A0F`;
- key xref at `0x7FF80D370A13`;
- uint64-setter-family call at `0x7FF80D370A1D`.

Classification: `G1_GOLDEN_TIMEOUT_SOURCE_R13_PLUS_0x18=STATIC_VALUE_SOURCE_PROVEN`.

### pluginPath — STATIC_IMMEDIATE_SETTER_SOURCE_PROVEN / ROOT ORIGIN STILL OPEN
Setter receives `movq -0x48(%rbp), %rdx` at `0x7FF80D370989` followed by string-setter-family call at `0x7FF80D37098D`.
Classification for immediate setter source: `STATIC_VALUE_SOURCE_PROVEN`; semantic/root origin of stack local remains upstream.

### sandboxTokens — STRUCTURAL_SOURCE_MAPPED
When `byte [r13+0x70]` is nonzero, code calls local/helper target from `0x7FF80D37090F`; returned RAX is moved into RDX and passed to value-setter-family call for `sandboxTokens`.
Exact helper semantics/value remain open.

### targetData — STRUCTURAL_SOURCE_MAPPED
A helper/stub call at `0x7FF80D370931` returns RAX; RAX is passed as RDX to the `targetData` value-setter-family call at `0x7FF80D370946`. The source object immediately before the helper is stack local `-0x50(%rbp)` in RDI. Exact helper/import semantics remain open.

### data — STRUCTURAL_SOURCE_MAPPED
A helper/stub call at `0x7FF80D370956` with R12 in RDI returns RAX; RAX is passed as RDX to the `data` value-setter-family call at `0x7FF80D37096B`. Exact helper/import semantics remain open.

### client_name — STRUCTURAL_SOURCE_MAPPED
Local/helper call at `0x7FF80D3709F3` returns RAX; after non-null test, RAX is passed in RDX to the string-setter-family call at `0x7FF80D370A0A`. Exact helper/root semantic source remains open.

## llvmVersion — precise correction: UNKNOWN_RANGE_LEFT_EDGE, not semantic absence
D97AZ V4 aligned the primary extraction range to begin exactly at the proven `llvmVersion` key xref `0x7FF80D37081F` to avoid x86 mid-instruction ambiguity.
Observed sequence begins:
- `0x7FF80D37081F`: LEA `llvmVersion` key -> RSI;
- `0x7FF80D370826`: `movq %rax, %rdi`;
- `0x7FF80D370829`: uint64-setter-family call.

There is no write to RDX between the extraction left edge and that call. Therefore D97AZ's `NO_WRITER` result means the llvmVersion value was placed in RDX *before* `0x7FF80D37081F`, outside the captured range.

Authoritative classification:
`G1_GOLDEN_LLVMVERSION_STATIC_SOURCE=UNKNOWN_RANGE_LEFT_EDGE`.
Do NOT describe this as evidence that no source exists or that the value is unknown at runtime globally.

## Alternate requestType path — exact immediate 9
Alternate xref `0x7FF80D44B9E1` is followed by:
- `movl $0x9, %edx` at `0x7FF80D44B9E8`;
- uint64-setter-family call at `0x7FF80D44B9F4`.

Classification:
`G1_GOLDEN_ALTERNATE_REQUESTTYPE_VALUE_9=STATIC_VALUE_PROVEN`.

Alternate `data` xref is mapped but D97AZ could not pair it to a nearby setter before RSI clobber; keep it `UNKNOWN/SEPARATE_PATH`, not negative.

## Tooling caveat — NM_OWNER not authoritative
D97AZ printed `NM_OWNER=(30794, ... _traceLog)` around these shared-cache code addresses. This owner result is inconsistent with the actual cached Metal VM context and is not used as a containing-function proof. It is retired as a symbol-owner hint only.

## Runtime values vs static source
D97AZ explicitly made no runtime value claim. Static source locations are not automatically runtime values. GOLDEN_A's exact generation selection remains separately constrained by the original exhaustive selector (`3802 -> 3802`, `31001 -> 32023`) plus D97AU runtime lane provenance; GOLDEN_B runtime generation visibility remains inconclusive from D97BA's zero-record channel.

## CURRENT FRONTIER / NEXT ACTION — D97BB
Remain in GOLDEN_B `15.8 / 24H22`.

Next bounded read-only collector must recover the *prelude immediately before* `0x7FF80D37081F` from a provable instruction/function boundary, then backslice RDX for the llvmVersion setter. Preferred method: parse the cached Metal Mach-O `LC_FUNCTION_STARTS` (or another explicit static boundary) and disassemble from the containing function start through the existing llvmVersion/requestType sequence. Do not use an arbitrary mid-instruction start.

Goals:
1. prove containing function/start boundary for the primary request builder;
2. recover exact writer chain feeding RDX at the llvmVersion setter;
3. identify the root structure field/immediate/helper source if statically resolvable;
4. preserve existing D97AZ source map without rerunning broad shared-cache census;
5. no debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After llvmVersion static source is resolved, choose only the minimum additional Golden runtime channel needed to establish exact per-request values still not logically proven from existing exhaustive selector/runtime evidence.