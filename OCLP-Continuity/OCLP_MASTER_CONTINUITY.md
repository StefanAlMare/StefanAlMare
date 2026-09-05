# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BO_FULL_PASS_NO_DIRECT_INTERSECTION_CONSTRUCTOR_SELECTOR_DATAFLOW_D97BP_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact current checkpoint above;
6. retrospective/history when strategic context is needed.

## Target / current machine state
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA after saved/sealed snapshot restore;
- `-igfxvesa` active;
- no active Root Patch.

End goal: stable hardware acceleration + usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Exact Golden authority
Original working OCLP lineage:
- upstream `dortania/OpenCore-Legacy-Patcher`;
- commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`, PatcherSupportPkg `1.9.6`;
- root-patch manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- official app executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team `S74BDJXQMD`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector:
- `3802 -> Versions/3802`;
- `31001 -> Versions/32023`.

Golden primary Metal request-builder:
- `0x7FF80D370756..0x7FF80D370C28`;
- `[ABI arg1 +0x20] -> llvmVersion`;
- `[ABI arg2 +0x08] -> requestType`;
- `[ABI arg2 +0x18] -> timeout`;
- `[ABI arg2 +0x70]` sandbox gate;
- alternate requestType immediate `9`.

Golden runtime naturally uses both 3802 and 32023 donor lanes and reaches Metal compositor success.

## Durable functional/methodology authority
Accepted historical functional lineage:
`P1 + P2b + P3 + AIR00 + D34`.

True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
P6/P7 sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated. D34 cave `0xEF8..0xEFE` protected.

Architecture principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## Exact 25G82 Metallib authority
- package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- local tree `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
- Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact Tahoe map 182 entries.

Retain exact-local handling + exact map in future hybrid designs.

## D97BJ / D97BK closure
D97BJ Root Patch execution itself passed, including Haswell kexts, exact metallibs and AuxKC.

Accelerated boots were not kernel panics. D97BK proved userspace/WindowServer reached, then critical services died because full legacy `13.2.1-24/Metal.framework` removed Tahoe `_MTL4*` superclass surface; launchd committed orderly shutdown.

Permanent NEGATIVE:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE`.

## D97BL selective-hybrid authority
Required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Donor collision closure:
- `12.5-3802-23/Metal.framework` can be bounded to legacy `MTLCompilerService.xpc` only;
- `13.2.1-24/Versions/A/Metal` shadows cache-resident native Metal and is forbidden.

Historical native-Metal + legacy-XPC/private-compilers + true-five already failed to yield usable GUI; do not repeat unchanged.

## D97AA runtime generation fact
Failing Tahoe accelerated cohort:
- 12/12 observed service requests `llvmVersion=32023`;
- 3802=0;
- other=0.

Golden naturally uses both 3802 and 32023 lanes.

## D97BM / D97BN producer closure
Native Tahoe Metal:
- cache path `/System/Library/Frameworks/Metal.framework/Versions/A/Metal`;
- start `0x7FF80F47D000`;
- cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Native MTLCompilerService SHA256:
`4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.

Native `_MTL4*` / `IOGPUMetal4*` class-name surface is present.

### Tahoe Builder A
`0x7FF80F635510..0x7FF80F635A4D`
- llvmVersion `[arg1+0x1C]`;
- requestType helper reads `+0xAC` from arg2 object;
- timeout helper reads `+0xB8` from same object family;
- three direct E8 callers;
- two wrapper callers source Builder-A arg1 from `[incoming object+0x38]`.

### Tahoe Builder B
`0x7FF80F663CA9..0x7FF80F66492C`
- llvmVersion `[arg1+0x38]`;
- requestType uses same `+0xAC` helper family from subordinate object `[arg1+0x28]`;
- timeout uses same `+0xB8` family;
- no direct E8 callers found.

Both alternate requestType paths use immediate `9`.

Generation census in native Metal:
- 3802 raw 11 / validated 9;
- 31001 raw 0 / validated 0;
- 32023 raw 10 / validated 10.

Therefore native Tahoe still contains real 3802 architecture but no Golden 31001 selector dialect. Do not globally replace `32023 -> 31001` and do not transplant Golden `+0x20` offsets.

## D97BO FULL PASS — current frontier
Returned bundle:
`OCLP7_D97BO_LLVMVERSION_FIELD_WRITER_AND_GENERATION_ORIGIN_20260905_225120.zip`
- bytes `905767`;
- SHA256 `a83675a6f07bb330537d93d4011ae6688a0024f162cc8acd67756ecdc0ab6380`.

All D97BO final markers PASS; no mutation.

### Native generation singleton selector
- 3802 init `0x7FF80F614D86..0x7FF80F614D9F` creates/stores singleton global `0x7FF843D65C90`;
- 32023 init `0x7FF80F614DB8..0x7FF80F614DD1` creates/stores singleton global `0x7FF843D65CB0`;
- shared selector `0x7FF80F5EFFEB..0x7FF80F5F009C` explicitly distinguishes 3802 (`0xEDA`), 3902 (`0xF3E`), 32023 (`0x7D17`) and 32024 (`0x7D18`) and returns corresponding singleton.

Classification:
`TAHOE_NATIVE_GENERATION_SINGLETON_SELECTOR_3802_32023=STATIC_PROVEN`.

### High-priority generation-aware constructor candidate
Function:
`0x7FF80F4A5DF8..0x7FF80F4A7A88`.

It combines explicit 32023 logic and request-layout-like writes:
- `0x7FF80F4A6283`: compare local `-0x27C` with 32023;
- `0x7FF80F4A726F`: write local `-0x3A0` -> `+0x1C(%r13)`;
- `0x7FF80F4A727A`: separate write -> `+0x20(%r13)`;
- `0x7FF80F4A72B1`: 16-byte write -> `+0x38(%r13)`;
- `0x7FF80F4A79CE`: local `-0x2C4` -> `+0x38(%r8)` in another constructed layout.

This is high-value STATIC-MAPPED evidence, not yet proof that the exact object reaches Builder A/B.

### No simple one-hop bridge
D97BO found no direct generation-function call or generation-global xref in the broad displacement-writer functions. Only three broad writer functions contain 32023 immediates; the constructor above is the only high-priority object-layout candidate.

Classifications:
- direct generation-function -> llvmVersion-writer edge = NEGATIVE;
- generation-global -> writer direct xref = NEGATIVE;
- simple one-hop normalization site = NOT PROVEN.

## CURRENT ACTION — D97BP
Remain unpatched in Tahoe VESA.

Next read-only audit:
1. back-slice constructor locals `-0x3A0`, `-0x2C4`, and discriminator `-0x27C` in `0x7FF80F4A5DF8..0x7FF80F4A7A88`;
2. map direct callers/argument provenance of that constructor;
3. map direct callers of selector `0x7FF80F5EFFEB..0x7FF80F5F009C` and EDX source at each call;
4. compare those objects with Builder-A wrapper shape and Builder-B request-object shape;
5. prove or reject one natural upstream adapter boundary.

No Root Patch and no accelerated reboot are authorized.

## Mandatory pre-reboot gate
No Root Patch/accelerated boot until:
1. native Tahoe Metal4 remains authoritative;
2. legacy main Metal is absent from proposed root;
3. legacy service/compiler ingress remains bounded;
4. exact 25G82 Metallib handling remains intact;
5. producer normalization is statically complete across relevant request families;
6. test adds new causal information beyond historical true-five.

## Execution contract
GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback.
