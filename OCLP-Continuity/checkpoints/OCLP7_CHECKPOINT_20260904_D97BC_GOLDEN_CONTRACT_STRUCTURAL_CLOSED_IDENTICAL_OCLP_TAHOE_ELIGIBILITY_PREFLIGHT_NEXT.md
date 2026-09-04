# OCLP7 CHECKPOINT — 2026-09-04 — D97BC Golden structural contract closed; identical-OCLP Tahoe eligibility preflight next

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

The user-authoritative next phase is now opened: Tahoe must be patched with the SAME ORIGINAL OCLP functional content as working Golden. The only Tahoe-specific delta permitted is a separately audited minimal eligibility/OS-support bypass. No payload/compiler/selector/request-layout/AIR/bitcode/driver semantic patch is allowed in that comparator.

## D97BC returned batch
Exact user files:
- JSON `OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.json`: 1740 bytes / SHA256 `67458836538b52b7ada6d54400bd396aa8eb6521b6cffbed0c87fdf93767c530`;
- TXT `OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.txt`: 5768 bytes / SHA256 `b4e9207e439d5740a214ad09f00f4565dbb2c0680b1d93e5b45f6f38327ddef5`.

JSON parses and agrees with TXT. D97BC final marker `D97BC_AUDIT=COMPLETE`; no system mutation, cache mmap, persistent extraction/instrumentation, debugger attach, Root Patch or reboot.

## Function boundary and Metal identity revalidated
GOLDEN_B Sequoia `15.8 / 24H22`; donor hashes unchanged:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Cached Metal text SHA remains `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.
`LC_FUNCTION_STARTS` revalidates primary request-builder function exactly `0x7FF80D370756..0x7FF80D370C28`, 318 disassembled instructions.

## Producer object provenance — STATIC ABI ORIGIN PROVEN
Function prolog:
- `0x7FF80D37077A: movq %rsi,%r13` => R13 is entry ABI argument 2 (RSI);
- `0x7FF80D37077D: movq %rdi,%rbx` => RBX is entry ABI argument 1 (RDI).
No other RBX/R13 writes occur before their mapped field uses.

Classification:
- `G1_GOLDEN_RBX_ORIGIN_CLASS=STATIC_ABI_ORIGIN_PROVEN`, origin `ABI_ARG1_RDI`;
- `G1_GOLDEN_R13_ORIGIN_CLASS=STATIC_ABI_ORIGIN_PROVEN`, origin `ABI_ARG2_RSI`.

## Golden primary producer layout bound to ABI objects
ABI argument 1 / RDI -> RBX:
- `[RBX+0x20]` signed dword -> sign-extended qword -> XPC `llvmVersion` uint64 setter.

ABI argument 2 / RSI -> R13:
- `[R13+0x08]` dword -> XPC primary `requestType` uint64 setter;
- `[R13+0x18]` qword -> XPC `APISpecifiedTimeoutInSeconds` uint64 setter;
- `[R13+0x70]` byte gates the `sandboxTokens` value path.

Other D97AZ facts retained:
- alternate requestType path writes exact immediate `9`;
- pluginPath setter source `[RBP-0x48]` with root origin still upstream;
- targetData/data/client_name/sandboxTokens helper-return paths structurally mapped.

## llvmVersion Golden value semantics retained
D97BB proved static source `[ABI_ARG1_RDI + 0x20]`.
For GOLDEN_A, original MTLCompilerService selector is exhaustive and byte-identical to GOLDEN_B: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no original selector branch for 32023.
D97AU runtime observed both donor generations with distinct generation PIDs. Thus GOLDEN_A observed 3802 donor traffic corresponds to request llvmVersion 3802 and observed 32023 donor traffic corresponds to request llvmVersion 31001. This is composed static+runtime proof, not a direct register capture.

GOLDEN_B's zero-record MTL log channel remains `INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`; it does not negate the retained Golden runtime oracle.

## Golden closure decision
Golden is sufficiently characterized to begin the identical-OCLP Tahoe comparator phase without another Golden reboot solely for structure/provenance.

Rationale:
1. original donor identity and selector are exact;
2. receiver eight-key schema is static-proven;
3. sender Metal eight-key builder/xrefs are mapped and rebased on 15.8;
4. llvmVersion/requestType/timeout/sandbox producer source layout is mapped to explicit ABI objects;
5. Golden dual-generation runtime oracle exists on GOLDEN_A and donor semantics remain byte-identical on GOLDEN_B;
6. GOLDEN_B reconfirms working Haswell driver -> Metal compositor success corridor.

This does NOT claim every payload byte or every request runtime value is directly captured. Remaining unknowns stay documented and can be measured with the same comparator later if Tahoe diverges there.

## CURRENT FRONTIER / NEXT ACTION — IDENTICAL-OCLP TAHOE ELIGIBILITY PREFLIGHT
Do NOT Root Patch or reboot yet.

Next bounded action is read-only and must:
1. identify the exact original OCLP app/version/build/source lineage used for working Golden as far as locally observable;
2. identify the exact Tahoe OS/root-patch eligibility/support gate(s) in the canonical local source;
3. construct a file/function influence map proving which code can alter eligibility only and which code selects/mutates payloads;
4. hash/record the original Golden donor payload identities and the candidate Tahoe source/resource inputs needed to prove equivalence;
5. design the smallest source delta that changes only eligibility/OS-support acceptance;
6. produce a fail-closed manifest for later integration/diff/build.

No source mutation in the preflight, no Root Patch, no reboot. After preflight, only if eligibility-only isolation is proven may a minimal source integration be made, audited, and then sent to a major GitHub build/package lane.
