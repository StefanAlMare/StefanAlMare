# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BN_PARTIAL_PASS_TWO_LAYOUTS_REQUESTTYPE_AC_TIMEOUT_B8_TOOLING_SIZE_STOP_V2_READY.md`
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
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA after sealed/saved snapshot restore;
- `-igfxvesa` active;
- no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Exact Golden authority
Original working OCLP lineage:
- upstream `dortania/OpenCore-Legacy-Patcher`;
- commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`, PatcherSupportPkg `1.9.6`;
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

Golden primary Metal request-builder:
- function `0x7FF80D370756..0x7FF80D370C28`;
- RBX = ABI arg1/RDI;
- `[RBX+0x20] -> llvmVersion`;
- R13 = ABI arg2/RSI;
- `[R13+0x08] -> requestType`;
- `[R13+0x18] -> timeout`;
- `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`.

Golden runtime naturally exhibits both 3802 and 32023 donor lanes and a positive Haswell -> compiler -> Metal compositor corridor.

## Durable historical functional evidence
Accepted true-five diagnostic lineage remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
P6/P7 sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated. D34 cave `0xEF8..0xEFE` protected.

Architecture principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## Exact 25G82 Metallib authority
- package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- exact local tree `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
- Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact Tahoe map 182 entries.

Keep D97BJ exact-local handling + exact map in future hybrid designs.

## D97BJ / D97BK closure
D97BJ Root Patch execution itself passed completely, including Haswell kexts, metallibs and AuxKC.

The accelerated failures were not kernel panics. D97BK proved userspace and WindowServer were reached, then critical services died because full legacy `13.2.1-24/Metal.framework` removed Tahoe Metal4 superclass surface; launchd committed orderly shutdown.

Permanent classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## D97BL hybrid closure
Required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Donor collision audit:
- `12.5-3802-23/Metal.framework` can be bounded to legacy `MTLCompilerService.xpc` only;
- `13.2.1-24/Versions/A/Metal` shadows native cache-resident Tahoe Metal and is forbidden.

Historical native-Metal + legacy-XPC/private-compilers + true-five was already tested and failed to produce usable GUI. Do not repeat it unchanged.

## D97AA retained runtime generation fact
In the failing accelerated cohort:
- 12/12 observed service requests carried exact `llvmVersion=32023`;
- 3802=0;
- other=0.

Golden naturally uses both 3802 and 32023 lanes. Missing Tahoe 3802 generation remains a live upstream semantic difference.

## D97BM exact 25G82 producer result
Native Metal cache image:
- path `/System/Library/Frameworks/Metal.framework/Versions/A/Metal`;
- start `0x7FF80F47D000`;
- cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Native MTLCompilerService SHA256:
`4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.

Native IOGPU image starts at `0x7FF906A1F000`.
Exact native `_MTL4*` and corresponding `IOGPUMetal4*` class-name surface is present.

D97BM identified two complete native XPC request builders.

## D97BN partial PASS — two native Tahoe request layouts
D97BN v1 mapped both complete builders and scalar helpers, then fail-closed before generation/caller census on a collector-only size guard:
`FUNCTION_SIZE_UNSAFE:0xDE15A`.

Classification:
`D97BN_V1_RESULT=PARTIAL_PASS_READONLY_TOOLING_SIZE_GUARD`.

### Builder A
Function `0x7FF80F635510..0x7FF80F635A4D`.
- entry RDI -> RBX, RSI -> R12;
- llvmVersion `[ABI_ARG1 + 0x1C]`;
- requestType helper `0x7FF80F5A59CC` = `movl 0xAC(%rdi),%eax; ret`, called on ABI arg2/R12;
- timeout helper `0x7FF80F5A5A0C` = `movq 0xB8(%rdi),%rax; ret`, called on ABI arg2/R12.

Thus builder A:
- llvmVersion arg1+0x1C;
- requestType arg2+0xAC;
- timeout arg2+0xB8.

### Builder B
Function `0x7FF80F663CA9..0x7FF80F66492C`.
- original RDI saved and used as request object;
- llvmVersion `[ABI_ARG1 + 0x38]`;
- R15 receives `[ABI_ARG1 + 0x28]` subordinate object;
- same helper `+0xAC` supplies requestType from that subordinate object;
- same helper `+0xB8` supplies timeout from that object family.

Thus builder B has a distinct native request-object layout.

### Alternate requestType
Two mapped alternate paths both write exact immediate `9`, matching Golden alternate semantics.

Important consequence:
- literal Golden offsets cannot be transplanted into Tahoe globally;
- a one-address producer patch is forbidden;
- any future normalization must be complete across relevant request families.

## CURRENT ACTION — D97BN v2
Run only read-only:
`OCLP7_D97BN_v2_generation_and_caller_completion.sh`.

Pinned identity:
- bytes `13626`;
- SHA256 `0976a64b8f864a7b6895fcab742e666bda386ce6f9428aefb67de745e6877d80`.

V2 completes only the sections not reached in D97BN v1:
1. raw + instruction-validated 3802/31001/32023 immediate census in exact native 25G82 Metal `__text`;
2. direct caller census for builder A and builder B;
3. bounded local contexts around matching instructions/calls;
4. no source/system/cache mutation, Root Patch or reboot.

## Mandatory pre-reboot gate
No future Root Patch/accelerated boot until:
1. native Tahoe Metal4 remains authoritative;
2. no legacy main Metal shadows cache Metal;
3. legacy service/compiler ingress is bounded;
4. exact 25G82 Metallib handling remains intact;
5. producer normalization is statically complete across relevant request families;
6. the experiment adds new causal information beyond historical true-five.

## Execution contract
GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback.