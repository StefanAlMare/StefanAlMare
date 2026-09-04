# OCLP7 CHECKPOINT — 2026-09-04 — D97AZ V4 GOLDEN_B request-builder value backslice PASS; llvmVersion source lies before aligned left edge; D97BB V2 ready

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
Setter receives `movq -0x48(%rbp), %rdx` at `0x7FF80D370989` followed by string-setter-family call at `0x7FF80D37098D`. Immediate setter source is proven; semantic/root origin of the stack local remains upstream.

### sandboxTokens — STRUCTURAL_SOURCE_MAPPED
When `byte [r13+0x70]` is nonzero, code calls a helper; returned RAX is moved into RDX and passed to the value-setter-family call. Exact helper semantics/value remain open.

### targetData — STRUCTURAL_SOURCE_MAPPED
A helper/stub call at `0x7FF80D370931` returns RAX, then RAX goes to RDX for targetData. Source object immediately before the helper is stack local `-0x50(%rbp)` in RDI.

### data — STRUCTURAL_SOURCE_MAPPED
A helper/stub call at `0x7FF80D370956` with R12 in RDI returns RAX; RAX goes to RDX for data.

### client_name — STRUCTURAL_SOURCE_MAPPED
Helper call at `0x7FF80D3709F3` returns RAX; after non-null test, RAX goes to RDX for client_name.

## llvmVersion — precise correction: UNKNOWN_RANGE_LEFT_EDGE
D97AZ V4 aligned the primary extraction range to begin exactly at `0x7FF80D37081F` to avoid x86 mid-instruction ambiguity. Sequence begins:
- `0x7FF80D37081F`: llvmVersion key LEA -> RSI;
- `0x7FF80D370826`: `movq %rax, %rdi`;
- `0x7FF80D370829`: uint64-setter-family call.

No RDX write exists inside the captured range before that call. Therefore `NO_WRITER` means the llvmVersion value was placed in RDX before the captured left edge.
Authoritative classification: `G1_GOLDEN_LLVMVERSION_STATIC_SOURCE=UNKNOWN_RANGE_LEFT_EDGE`.
Do not describe this as semantic absence.

## Alternate requestType path — exact immediate 9
Alternate xref `0x7FF80D44B9E1` is followed by `movl $0x9,%edx` then the same uint64-setter-family target. Classification `G1_GOLDEN_ALTERNATE_REQUESTTYPE_VALUE_9=STATIC_VALUE_PROVEN`.
Alternate data remains a separate mapped path with no paired setter claim.

## Tooling caveat
D97AZ `NM_OWNER=(..._traceLog)` is not authoritative for cached-code function ownership and is retired from semantic use.
D97AZ explicitly made no runtime value claim. Static source locations are not automatically runtime values.

## CURRENT FRONTIER / NEXT ACTION — D97BB V2
Remain in GOLDEN_B `15.8 / 24H22`.

Run only hardened wrapper:
`OCLP7_D97BB_V2_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_HARDENED_WRAPPER.command`
- wrapper commit `4e99313000e59b57b28b761571e2d56fbd96429b`;
- wrapper Git blob `e51f547b3765688b772b43937dc0f3d762a9c801`.

Core:
`OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.command`
- commit `c05563fdeae951c5731051c73ac7e43fd7f2ffdd`;
- core Git blob `c02a2e7c196f3260858be55f6175ba275120ac35`.

Wrapper fail-closes unless core blob, zsh parse, single Python heredoc compile, current Metal SHA pin, LC_FUNCTION_STARTS markers and safety markers all pass.

D97BB core:
1. pins GOLDEN_B OS/build, donor hashes and cached Metal text SHA `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`;
2. parses cached Metal Mach-O `LC_FUNCTION_STARTS`;
3. derives a real containing-function boundary for llvmVersion xref `0x7FF80D37081F`;
4. disassembles only from that function boundary through the existing setter;
5. revalidates llvmVersion key target and uint64-setter-family target `0x7FF80D50FDCE`;
6. back-slices RDX to first safely resolvable source.

Goal: resolve exact static source of Golden llvmVersion without arbitrary pre-xref alignment. No debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After D97BB, choose only the minimum additional Golden runtime channel needed for exact values not already logically established by exhaustive selector/runtime evidence.