# OCLP7 CHECKPOINT — 2026-09-05 — D97BU partial PASS; exact patch site valid; no safe `__text` cave; D97BV next

## Entering state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine remains unpatched Tahoe VESA with `-igfxvesa` active and no Root Patch.
- Native Tahoe Metal remains cache-resident/authoritative; no legacy main Metal may shadow it.
- No Root Patch or accelerated reboot is authorized.

## D97BU console result
User ran `OCLP7_D97BU_minimal_3802_preserve_adapter_preflight.sh`.
No ZIP was produced because the collector fail-closed at the cave gate.
No system/cache/source mutation, cache extraction, Root Patch or reboot occurred.

Identity gates passed:
- OS `26.6.2 / 25G82`;
- native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- native cached Metal `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

## Exact adapter site remains valid
Accessor function:
`0x7FF80F5E16C3..0x7FF80F5E1778`.

Exact proposed replacement window:
- start `0x7FF80F5E1719`;
- continue `0x7FF80F5E1726`;
- length `13` bytes;
- exact preimage hex `3d187d0000b9177d00000f4cc1`.

Exact original instructions:
- `cmpl $0x7d18,%eax`;
- `movl $0x7d17,%ecx`;
- `cmovll %ecx,%eax`.

D97BU proved:
- preimage identity PASS;
- no direct branch enters the middle of this 13-byte window (`PATCH_SITE_INCOMING_BRANCH_COUNT=0`).

Classification:
`D97BU_ACCESSOR_CLAMP_PATCH_SITE_COMPLETE_INSTRUCTION_BOUNDARY=STATIC_PROVEN`.

## No safe padding cave inside `__text`
D97BU searched native Metal `__text` for homogeneous zero/NOP runs satisfying its strict safety constraints. Result:
`CAVE_CANDIDATE_COUNT=0`.

Collector stopped fail-closed with:
`FAIL=NO_STATIC_SAFE_PADDING_CAVE`.

This is a preflight/tooling architecture result, not a Tahoe runtime failure.

Classification:
`D97BU_NATIVE_METAL___TEXT_SAFE_PADDING_CAVE_GE_32=NEGATIVE`.

Do not reuse a live function, exception landing pad, string/data region or merely unreferenced decoded code as a cave on this evidence.

## Extraction-tool inventory
On ASUS2:
- `xcrun -f dyld_shared_cache_util` -> absent (`RC=72`);
- `xcrun -f dsc_extractor` -> absent (`RC=72`).

This means an Apple command-line cache extractor is not currently available through xcrun. It does not imply native Metal cannot later be reconstructed by another audited method.

## Adapter semantics retained
Desired adapter semantics remain:
- if incoming generation is exact `3802`, preserve `3802`;
- otherwise execute Tahoe's original 32023 floor byte-for-byte.

Do not fall back to global `32023 -> 31001`, Golden offset transplantation, global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`, or global threshold lowering merely because `__text` lacks padding.

## D97BV prepared
Read-only collector:
`OCLP7_D97BV_text_intersection_padding_cave_preflight.sh`
- bytes `16179`;
- SHA256 `ad279fd6e554a57c77287a86c1f3521288852095a2a60d12bdb37ebdf8723ffd`.

D97BV searches only unsectioned padding inside the executable native Metal `__TEXT` segment. A candidate is accepted only if:
- it lies outside all Mach-O sections and outside Mach header/load commands;
- segment permissions include execute;
- bytes are homogeneous `00` or `90` and capacity is at least 18 bytes;
- no function start, direct branch target or decoded RIP-relative target lands inside it.

If such padding exists, D97BV statically assembles the exact selective 3802 trampoline and proves a truth table with no non-3802 semantic drift. If none exists, it returns a clean PASS-with-negative-cave result instead of failing the machine.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97BV_text_intersection_padding_cave_preflight.sh` and return its ZIP.

No Root Patch and no accelerated reboot are authorized.
