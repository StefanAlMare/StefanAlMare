# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97BV_FULL_PASS_EXECUTABLE_INTERSECTION_CAVE_SELECTIVE_3802_ADAPTER_D97BW_RECONSTRUCTION_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Target / current machine state
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA after saved/sealed snapshot restore;
- `-igfxvesa` active;
- no active Root Patch.

End goal: stable hardware acceleration + usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Golden authority
Working Golden OCLP lineage: upstream `dortania/OpenCore-Legacy-Patcher`, exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`, PatcherSupportPkg `1.9.6`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.
Golden primary Metal request-builder: `0x7FF80D370756..0x7FF80D370C28`, `[arg1+0x20] -> llvmVersion`, `[arg2+0x08] -> requestType`, `[arg2+0x18] -> timeout`, alternate requestType 9.
Golden runtime naturally uses both 3802 and 32023 donor lanes and reaches Metal compositor success.

## Durable architecture
Historical accepted true-five: `P1 + P2b + P3 + AIR00 + D34`. P6/P7 sufficiency NEGATIVE; D50/D68/D82 reserve-only; D84 retired; D34 cave protected.

Required current architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> Haswell driver -> image`.

Legacy `12.5-3802-23` can be bounded to `MTLCompilerService.xpc` only. Legacy `13.2.1-24/Versions/A/Metal` shadows native cache-resident Metal and is forbidden. Historical native-Metal + legacy-XPC/private-compilers + true-five already failed; do not repeat unchanged.

Exact target Metallib authority: local `MetallibSupportPkg-26.6.2-25G82`, package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`, exact Tahoe map 182 entries.

## D97BJ / D97BK closure
D97BJ Root Patch execution itself passed. Accelerated boots were not kernel panics: userspace/WindowServer reached, then full legacy Metal.framework removed Tahoe `_MTL4*` superclass surface and launchd performed orderly shutdown.

Permanent NEGATIVE: `D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## D97AA runtime generation fact
Failing Tahoe accelerated cohort: 12/12 observed service requests `llvmVersion=32023`; 3802=0; other=0. Golden naturally uses both 3802 and 32023 lanes.

## Native Tahoe producer closure
Native Tahoe Metal cache image starts at `0x7FF80F47D000`; cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`. Native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`. Native `_MTL4*` / `IOGPUMetal4*` surface is present.

Tahoe Builder A `0x7FF80F635510..0x7FF80F635A4D`: llvmVersion `[arg1+0x1C]`, requestType helper `+0xAC`, timeout `+0xB8`, three direct E8 callers.
Tahoe Builder B `0x7FF80F663CA9..0x7FF80F66492C`: llvmVersion `[arg1+0x38]`, same requestType/timeout helper family via subordinate object, no direct E8 callers.
Both alternate requestType paths use immediate 9.

Native generation census: 3802 raw 11 / validated 9; 31001 zero; 32023 raw 10 / validated 10. Do not globally replace `32023 -> 31001`; do not transplant Golden `+0x20` offsets.

## Shared generation architecture / accessor suppression
3802 initializer -> singleton global `0x7FF843D65C90`; 32023 initializer -> singleton global `0x7FF843D65CB0`. Selector `0x7FF80F5EFFEB..0x7FF80F5F009C` distinguishes 3802/3902/32023/32024.

Generation-aware constructor `0x7FF80F4A5DF8..0x7FF80F4A7A88` uses shared accessor `0x7FF80F5E16C3`, stores EAX into discriminator `-0x27C`, optionally overrides from `[arg1+0x138]`, and builds layouts containing `+0x1C/+0x20/+0x38` writes.

D97BQ proved selector generation input is ABI arg2/RSI. All six validated selector callers do `call accessor -> movl %eax,%esi -> call selector`.

D97BT proved default-environment accessor-wide suppression of 3802:
- primary path floors to 32023;
- lazy fallbacks floor to 32023 or 32024;
- only bypass is explicit `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`, default/current value zero.

Classification:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

## D97BU partial PASS — exact patch window; no cave inside `__text`
Exact accessor clamp patch window:
- `0x7FF80F5E1719..0x7FF80F5E1726`;
- 13-byte preimage `3d187d0000b9177d00000f4cc1`;
- complete Tahoe compare/mov/cmov instructions;
- no incoming branch targets window interior.

D97BU found zero safe homogeneous padding cave candidates inside `__text` and stopped fail-closed. This remains a valid NEGATIVE only for `__text` padding.

## D97BV FULL PASS — executable unsectioned cave + selective adapter
Returned bundle:
`OCLP7_D97BV_TEXT_INTERSECTION_PADDING_CAVE_PREFLIGHT_20260906_001956.zip`
- bytes `2574`;
- SHA256 `c39198d603664b921f57abd0d09d24ad7fc1d08c2da8f44677c86de93301cbfd`.

D97BV found exactly one safe padding candidate outside all Mach-O sections but inside executable native `__TEXT`:
- `0x7FF80F47E560..0x7FF80F47E630`;
- length 208 bytes;
- all zero;
- immediately before `__text`;
- zero function-start, direct branch-target and decoded RIP-relative-target hits.

Classification:
`D97BV_NATIVE_METAL_EXECUTABLE_INTERSECTION_PADDING_CAVE=STATIC_PROVEN_SAFE_BY_CURRENT_GATES`.

Selective adapter static bytes:
- site `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`;
- cave `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`.

Semantics:
- input exactly 3802 -> preserve 3802 and continue;
- every other value -> execute exact original Tahoe floor in cave and return to original continuation.

Truth-table audit showed no non-3802 semantic drift.

Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

## Current blocker: local native-Metal delivery
Adapter logic and executable placement are now statically closed. A standalone exact native 25G82 Metal image is not yet proven reconstructible/load-command-valid from the dyld shared cache.

Apple `dyld_shared_cache_util` / `dsc_extractor` are absent via xcrun. Do not use a donor legacy Metal and do not redistribute an extracted Apple binary through GitHub.

## CURRENT ACTION — D97BW
Remain unpatched in Tahoe VESA.

Run only read-only/temporary-file collector:
`OCLP7_D97BW_native_metal_temp_reconstruction.sh`
- bytes `18302`;
- SHA256 `20e2d042447eba578b857faeb221fd615751da37514afafd56921ecd581f09c1`.

D97BW must:
1. reconstruct a temporary standalone native Metal candidate from exact cache segments using declared Mach-O file offsets;
2. validate segment overlap, load-command referenced data ranges, `file`, `otool -l`, `otool -L`, native `__TEXT` identity and `_MTL4*` string surface;
3. apply the exact D97BV site+cave adapter only to a second temporary copy;
4. prove all byte differences are confined to the two authorized windows and native Metal4 surface remains present;
5. inspect codesign state read-only;
6. delete both temporary Apple binaries before packaging;
7. package only TXT+JSON, never Apple binary bytes;
8. make no cache/system mutation, Root Patch or reboot.

No source integration/build/package is authorized yet. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.