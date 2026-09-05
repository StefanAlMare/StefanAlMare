# OCLP7 CHECKPOINT — 2026-09-05 — D97BR full PASS; 3802->32023 clamp proven; escape hatches remain; D97BS next

## Entering state
- Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine state remains unpatched Tahoe VESA after saved/sealed snapshot restore.
- `-igfxvesa` active; no active Root Patch.
- Native Tahoe Metal remains cache-resident and authoritative; full legacy `13.2.1-24/Metal.framework` remains forbidden.
- No Root Patch or accelerated reboot is authorized.

## D97BR returned bundle
`OCLP7_D97BR_GENERATION_ACCESSOR_CFG_AND_CLAMP_20260905_232748.zip`
- bytes `4515`;
- SHA256 `1b3d252e8824f9e531980afdd1f9ca93b06d2c83e6e2bf7bb18ded44f90d22f7`.

All collector final markers passed:
- `D97BR_ACCESSOR_CFG=PASS`;
- `D97BR_CLAMP_SEMANTICS=PASS`;
- `D97BR_GLOBAL_OVERRIDE_CENSUS=PASS`;
- `D97BR_INDIRECT_SOURCE_CALL_CENSUS=PASS`;
- `D97BR_EXTERNAL_TAIL_AUDIT=PASS`;
- `D97BR_AUDIT=PASS`.

No source/system/cache mutation, Root Patch or reboot occurred.

## Exact native identity revalidated
- OS `26.6.2 / 25G82`;
- native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- native cached Metal `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`;
- accessor function `0x7FF80F5E16C3..0x7FF80F5E1778`.

## Complete accessor CFG
D97BR reconstructed the accessor CFG with:
- 57 edges;
- all 50 instructions reachable;
- zero unreachable instructions;
- one normal `ret` at `0x7FF80F5E1759`;
- one external tail at `0x7FF80F5E1762 -> 0x7FF80F5E15C6`.

Classification:
`D97BR_SHARED_GENERATION_ACCESSOR_CFG=STATIC_PROVEN_COMPLETE_FOR_DIRECT_BRANCH_MODEL`.

## Decisive clamp semantics — SEMANTIC PROVEN
Exact path:
- `0x7FF80F5E1719`: `cmpl $0x7d18,%eax` = compare with 32024;
- `0x7FF80F5E171E`: `movl $0x7d17,%ecx` = 32023;
- `0x7FF80F5E1723`: `cmovll %ecx,%eax`.

Therefore, on this path, every positive generation value below 32024 is replaced with exact 32023 before normal return.

In particular:
`3802 < 32024 -> EAX := 32023`.

Authoritative classification:
`D97BR_ACCESSOR_INPUT_3802_ON_CLAMP_PATH_BECOMES_32023=SEMANTIC_PROVEN`.

Accessor contains no immediate 3802 and contains explicit 32023/32024 immediates.

This is directly consistent with retained runtime D97AA evidence that the failing Tahoe accelerated cohort delivered 12/12 requests as exact llvmVersion 32023 and zero as 3802. It is not yet proof that every possible accessor path suppresses 3802.

## Three accessor output classes
### 1. Clamp path
An indirect generation-source call returns EAX, then the 32024/32023 floor logic executes.
3802 is deterministically converted to 32023 on this path.

### 2. Global override path
Accessor can load a dword directly from global:
`0x7FF843853E18`.

Observed current static value in the cache image is `0`.
D97BR found exactly one code writer:
- function `0x7FF80F612AF4..0x7FF80F612B0E`;
- store at `0x7FF80F612B06`.

Because a nonzero global value bypasses the clamp and returns directly, this path must be closed before accessor-wide suppression can be claimed.

### 3. Alternate/fallback path
Another indirect source path defaults EAX to exact 32023.
For one value class it uses external tail:
`0x7FF80F5E1762 -> 0x7FF80F5E15C6..0x7FF80F5E1624`.

The tail function reads a lazy-initialized global and returns it. Its possible values and writer semantics remain to be audited.

## Indirect source calls
Accessor contains two indirect calls at:
- `0x7FF80F5E1713`;
- `0x7FF80F5E1732`.

D97BR mapped their call slots and nearby selector-reference loads but did not resolve reliable semantic names/targets. Their exact generation-source semantics remain open.

## What is NOT yet proven
Do not promote any of the following yet:
- accessor universally forbids 3802;
- every Tahoe generation-bearing object is necessarily clamped;
- the global override cannot carry 3802;
- the lazy tail cannot return 3802;
- a patch at the clamp alone is complete across all request families.

These remain open until escape-hatch closure.

## Strategic consequence
The leading upstream-cause model is now much stronger:
`generation-bearing object -> shared accessor -> path-local minimum-generation clamp -> 32023 -> native selector/XPC producer`.

This supplies a plausible static mechanism for the observed 12/12 Tahoe 32023 cohort while preserving the fact that Tahoe still contains real 3802 machinery elsewhere.

The correct next action is not Root Patch and not a clamp patch yet. First close the two accessor escape paths.

## D97BS prepared
Read-only collector:
`OCLP7_D97BS_accessor_escape_hatches.sh`
- bytes `20670`;
- SHA256 `4aa35c3afd3774f3385e70e4147cf80e942c96e3a3c0608fac5d2ad328300d9d`.

D97BS must:
1. audit exact writer semantics and callers for global override `0x7FF843853E18` / writer function `0x7FF80F612AF4`;
2. resolve actual indirect call-slot targets used by the accessor where statically possible;
3. identify lazy global(s) used by tail function `0x7FF80F5E15C6`;
4. enumerate all xrefs/writers to those lazy globals and source provenance;
5. classify whether any escape path has a directly visible 3802 source;
6. make no system/cache/source mutation, Root Patch or reboot.

Absence of an immediate 3802 alone must not be used as proof of semantic impossibility; D97BS should preserve that limitation explicitly.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only `OCLP7_D97BS_accessor_escape_hatches.sh` and return its ZIP.

No Root Patch and no accelerated reboot are authorized.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until:
1. native Tahoe Metal4 remains authoritative;
2. no legacy main Metal shadows cache Metal;
3. legacy service/compiler ingress remains bounded;
4. exact 25G82 Metallib handling remains intact;
5. producer normalization is statically complete across all relevant accessor/request paths;
6. the proposed test adds new causal information beyond historical true-five.

GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed; local compilation is not an implicit fallback.