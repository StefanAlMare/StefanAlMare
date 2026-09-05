# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BM_NATIVE_TAHOE_PRODUCER_LAYOUT_DIFF_SECOND_BUILDER_D97BN_GENERATION_ORIGIN_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` and `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup
Before any technical modification read, in order:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact current checkpoint above;
6. retrospective/history when strategic context is needed.

## Target / current machine state
- macOS Tahoe `26.6.2 / 25G82`;
- Intel Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- end goal: stable hardware acceleration and usable GUI.

Current ASUS2 state:
- unpatched Tahoe VESA after sealed/saved snapshot restore;
- `-igfxvesa` active;
- no active Root Patch.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Exact Golden ORIGINAL-OCLP authority
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- Golden root-patch manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- official app executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

Golden compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Golden selector:
- `3802 -> Versions/3802`;
- `31001 -> Versions/32023`.

Golden primary Metal request-builder contract:
- function `0x7FF80D370756..0x7FF80D370C28`;
- RBX = ABI arg1/RDI;
- `[RBX+0x20] -> llvmVersion`;
- R13 = ABI arg2/RSI;
- `[R13+0x08] -> requestType`;
- `[R13+0x18] -> timeout`;
- `[R13+0x70]` gates sandboxTokens;
- alternate requestType immediate `9`.

Golden runtime has natural 3802 and 32023 donor lanes and a positive Haswell -> compiler -> Metal compositor success corridor.

## Durable historical functional evidence
Accepted true-five diagnostic baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

- P1 selector bridge;
- P2b request-layout bridge `+0xD0 -> +0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback to AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

True-five SHA: `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
P6/P7 sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated. D34 cave `0xEF8..0xEFE` protected.

Historical late-userspace chain once legacy compilation is reached:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Core architecture principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## Exact 25G82 Metallib authority
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- exact Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact map size 182 entries.

Keep D97BJ's exact-local Metallib preference and exact 25G82 map in future hybrid work.

## D97BJ / D97BK closure
D97BJ Root Patch execution itself was PASS, including Haswell kexts, exact metallibs and AuxKC.

However full legacy `13.2.1-24/Metal.framework` on Tahoe is NEGATIVE. D97BK proved two accelerated attempts were not kernel panics: WindowServer reached `running`, then critical services repeatedly died because Tahoe IOGPU could not resolve Metal4 superclass `IOGPUMetal4RenderCommandEncoder -> _MTL4RenderCommandEncoder`; launchd then committed orderly shutdown.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## D97BL selective hybrid closure
Required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Donor collision audit proved:
- `12.5-3802-23/Metal.framework` contains only the legacy `MTLCompilerService.xpc` files and can be bounded without touching main Metal;
- `13.2.1-24/Metal.framework` adds `Versions/A/Metal` and `MetalOld.dylib`; adding `Versions/A/Metal` shadows cache-resident Tahoe Metal and is forbidden.

Historical Tahoe source had already tested native Metal + legacy XPC/private compilers + P1/P2b/P3/AIR00/D34 and did not produce a usable GUI. Do not repeat that Root Patch unchanged.

## D97AA runtime generation fact
For the accelerated failing cohort, 12/12 observed MTLCompilerService spawns carried exact `llvmVersion=32023`; 3802=0 and other=0.

Thus the native Tahoe generation-selection origin remains a live upstream difference relative to working Golden, which naturally uses both legacy compiler generations.

## D97BM — exact native 25G82 producer result
Returned bundle:
`OCLP7_D97BM_TAHOE_NATIVE_METAL_PRODUCER_AND_METAL4_AUDIT_20260905_135803.zip`
- bytes `10512`;
- SHA256 `0a98c10b518356b53397b9c0b950944a8ee8b6f93788ca8bc97782dc32ba739b`.

Audit PASS markers:
- shared-cache map PASS;
- primary eight-key cluster PASS;
- function-start boundary PASS;
- native Metal text pin PASS;
- D97BM audit PASS.

Native 25G82 identities:
- native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- Metal image `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` at `0x7FF80F47D000`, cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`;
- IOGPU image `/System/Library/PrivateFrameworks/IOGPU.framework/Versions/A/IOGPU` at `0x7FF906A1F000`.

All required `_MTL4*` names and corresponding `IOGPUMetal4*` names are present in their native exact-25G82 cache images. This is static class-name surface presence, not yet full future-root Objective-C superclass-resolution proof.

### Tahoe primary request builder
Exact LC_FUNCTION_STARTS function:
`0x7FF80F635510..0x7FF80F635A4D`.

All eight XPC input keys occur in one cluster `0x7FF80F6355F0..0x7FF80F635811`.

Function entry:
- `RDI -> RBX`;
- `RSI -> R12`.

Exact Tahoe llvmVersion source:
`0x7FF80F6355EC: movslq 0x1c(%rbx), %rdx`.

Classification:
`D97BM_TAHOE_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x1C=STATIC_VALUE_SOURCE_PROVEN`.

Golden uses `[RBX+0x20]` for the same XPC field, so the producer object layout offset difference is proven. The offset difference alone does not establish wrong semantics.

Tahoe primary requestType is obtained by calling a helper on the RSI/R12 object and moving returned EAX to EDX. Exact helper internals remain pending.

### Second complete Tahoe request builder
A second complete eight-key family is mapped at:
- llvmVersion `0x7FF80F663DF7`;
- requestType `0x7FF80F663E36`;
- sandboxTokens `0x7FF80F663F38`;
- targetData `0x7FF80F663F66`;
- data `0x7FF80F663F8F`;
- pluginPath `0x7FF80F663FBD`;
- client_name `0x7FF80F664074`;
- timeout `0x7FF80F664096`.

Extra requestType paths: `0x7FF80F62717E`, `0x7FF80F63539E`.
Extra data paths: `0x7FF80F4E643A`, `0x7FF80F572FA1`.

Therefore a one-address producer patch is not authorized; both complete builders and alternate paths must first be closed.

## Current frontier — D97BN
Read-only D97BN maps both complete Tahoe request builders, scalar source helpers, alternate request paths, generation immediates 3802/31001/32023 in native Metal `__text`, and direct callers of both builders.

Purpose: identify the real native Tahoe generation-selection origin and determine whether a future normalization can be universal or must be request-family-specific.

No source/system/cache mutation. No Root Patch. No reboot.

## Mandatory pre-reboot gate
No future Root Patch/accelerated boot until the candidate experiment proves:
1. native Tahoe Metal4 ABI remains authoritative;
2. no legacy `Versions/A/Metal` shadows native cache Metal;
3. legacy service/compiler ingress is bounded;
4. exact 25G82 Metallib handling remains intact;
5. producer normalization is statically complete across all relevant builders/request families;
6. the experiment provides new causal information beyond the already-tested true-five state.

## Execution contract
GitHub Actions compile/build/package remains suspended until user explicitly says quota reset/unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only `OCLP7_D97BN_tahoe_all_builders_generation_origin.sh` and return its generated TXT+JSON ZIP.

No Root Patch and no accelerated reboot are authorized.