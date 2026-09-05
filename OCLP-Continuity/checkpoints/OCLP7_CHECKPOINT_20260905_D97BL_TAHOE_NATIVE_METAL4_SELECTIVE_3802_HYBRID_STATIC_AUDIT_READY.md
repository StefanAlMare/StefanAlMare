# OCLP7 CHECKPOINT — D97BL Tahoe-native Metal4 + selective legacy 3802 hybrid static audit ready

Date: 2026-09-05 EEST

## Entering state
- Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine state is unpatched Tahoe VESA after sealed/saved snapshot restore.
- D97BJ Root Patch execution itself remains PASS.
- D97BK proved the two accelerated D97BJ attempts were NOT kernel panics; userspace and WindowServer were reached, then essential services died with Objective-C loader error because Tahoe IOGPU Metal4 superclasses were missing after the full legacy Metal.framework merge.

## D97BK boundary that D97BL must preserve
Tahoe IOGPU contains a Metal4 class family whose superclasses are provided by native Tahoe Metal.framework, including at minimum:
- `IOGPUMetal4CommandQueue : _MTL4CommandQueue`;
- `IOGPUMetal4CommandBuffer : _MTL4CommandBuffer`;
- `IOGPUMetal4CommandAllocator : _MTL4CommandAllocator`;
- `IOGPUMetal4RenderCommandEncoder : _MTL4RenderCommandEncoder`;
- `IOGPUMetal4ComputeCommandEncoder : _MTL4ComputeCommandEncoder`;
- `IOGPUMetal4MachineLearningCommandEncoder : _MTL4MachineLearningCommandEncoder`.

Therefore the full `13.2.1-24/Metal.framework` merge is permanently NEGATIVE for Tahoe as a final architecture.

## D97BL architecture decision
D97BL is a selective hybrid, not another full-framework downgrade:

`native Tahoe Metal.framework / Metal4 ABI -> selective legacy 3802 compiler ingress -> audited boundary adapters -> Haswell driver -> image`

The native Tahoe `Metal.framework/Versions/A/Metal` must remain intact.

Potential legacy pieces to retain only after exact collision/identity audit:
- 3802/32023 compiler-version payloads;
- `MTLCompilerService` selector support;
- legacy `MTLCompiler.framework` / `GPUCompiler.framework` components where required;
- exact Haswell kext/driver set;
- exact 25G82 metallib map.

## Historical true-five relevance
The accepted historical functional baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

It is now architecturally relevant again because these are boundary/compiler-path adaptations rather than a wholesale Tahoe Metal ABI replacement.

Static locations already proven:
- P1: `MTLCompilerService` selector; Golden supports `3802 -> Versions/3802` and `31001 -> Versions/32023`; Tahoe P1 changes the second compare to accept `32023`, leaving the 3802 branch intact.
- P2b: compiler `getReadParametersFromRequest`, fileoff `0x9A8CD`, request-layout bridge.
- AIR00: `getReadParametersFromRequest`, fileoff `0x9A933`.
- P3: `backendCompileModule`, fileoff `0xA1573`.
- D34: `runFrameworkPasses`, callsite `0x9F6FA`; protected cave `0xEF8..0xEFE`.

P6/P7 remain insufficient and are not promoted into D97BL functional baseline. D50/D68/D82 remain reserve-only; D84 retired; D36-D44 invalidated.

## External/current OCLP-T2 audit
Current public `albert-mueller/OpenCore-Legacy-Patcher-T2` still merges whole legacy `Metal.framework` payloads (`12.5-3802-23` and `13.2.1-24` for newer hosts). That pattern is structurally capable of reproducing the D97BK Metal4 ABI break and is therefore not imported blindly.

Exact b9df76 merge semantics use:
`rsync -r -i -a SOURCE/file_name DESTINATION/`
for `PatchType.MERGE_*`.
Thus any donor file with the same relative path replaces the native Tahoe file; a full Metal.framework merge is not safe merely because the patch method is called MERGE.

## D97BL read-only static collector
Prepared local script:
`OCLP7_D97BL_static_hybrid_audit.sh`.

Purpose:
1. verify current unpatched/VESA baseline;
2. locate and hash exact `Universal-Binaries.dmg`;
3. mount the DMG read-only;
4. locate payload roots `12.5-3802-23`, `13.2.1-24`, `12.7.6-3802`, and `14.2 Beta 1` when present;
5. build exact per-file SHA256 manifests for native Tahoe Metal.framework and both legacy Metal donors;
6. classify every native/donor collision and every donor-only file;
7. map Mach-O identities, dylib dependencies, selector literals and imm32 3802/31001/32023 counts;
8. enumerate native Tahoe `_MTL4*` surface;
9. enumerate legacy MTLCompiler/GPUCompiler framework donors;
10. recover the historical P1-D34 source tree and exact diffs/hashes if locally present;
11. capture D97BJ source delta as comparator;
12. make no source/system mutation, no Root Patch and no reboot.

Expected output:
`~/Desktop/OCLP7_D97BL_STATIC_HYBRID_AUDIT_<timestamp>.zip`
with final marker `D97BL_STATIC_HYBRID_AUDIT=PASS`.

## Mandatory pre-Root-Patch gate remains active
No D97BL Root Patch or accelerated boot may be authorized until static evidence proves:
1. native Tahoe Metal4 ABI remains intact;
2. all IOGPU-referenced `_MTL4*` superclasses resolve;
3. native Tahoe `Metal.framework/Versions/A/Metal` is preserved;
4. legacy 3802 selector/compiler path is present through a bounded hybrid mechanism;
5. exact local `26.6.2-25G82` MetallibSupportPkg and exact 25G82 metallib map remain intact.

## CURRENT ACTION
User runs only the read-only `OCLP7_D97BL_static_hybrid_audit.sh` in the current unpatched Tahoe VESA state and returns the generated ZIP.

Then assistant audits the exact collisions and historical source, defines the minimal selective hybrid patch root, and only after a separate static Metal4 closure PASS decides whether a new app/build is warranted.

No Root Patch authorized. No accelerated reboot authorized. Golden remains immutable/read-only.