# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BL_V2_PARTIAL_PASS_DONOR_COLLISION_CLOSURE_D97BM_NATIVE_CACHE_PRODUCER_AUDIT_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` and `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup
Before any technical modification, read in this order:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact current checkpoint above;
6. retrospective/history when strategic context is needed.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and usable GUI.

Current target state: Tahoe VESA/recovery, sealed/saved snapshot restored, no active Root Patch.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- Golden root-patch manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- official Golden-lineage app executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

Golden remains immutable/read-only.

Golden installed/compiler identities:
- 32023 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- AppleIntelFramebufferAzul `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

Golden selector mapping:
- request `3802 -> Versions/3802`;
- request `31001 -> Versions/32023`.

Golden primary Metal request-builder contract:
- function `0x7FF80D370756..0x7FF80D370C28`;
- RBX = ABI arg1/RDI; signed dword `[RBX+0x20] -> llvmVersion`;
- R13 = ABI arg2/RSI; `[R13+0x08] -> requestType`;
- `[R13+0x18] -> timeout`;
- `[R13+0x70]` gates sandboxTokens;
- alternate requestType immediate `9`.

## Durable historical functional evidence
Accepted five-functional diagnostic baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

- P1 selector bridge;
- P2b request-layout bridge `+0xD0 -> +0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

True-five historical SHA: `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
D22 remains semantic proof for AIR 2.6 / Metal 3.1.
P6/P7 sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap. D34 cave `0xEF8..0xEFE` remains protected.

Retained late-userspace causal chain once legacy compilation is reached:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Durable architecture principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## D97BH / Metallib closure
Exact target package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Local exact tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

Exact Pyquick 25G82 patch dictionary SHA256:
`c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`.

D97BJ improved exact-local selection before API and generated the exact 25G82 metallib map (182 entries). These improvements remain retained for the future hybrid design.

## D97BJ Root Patch — execution PASS, whole-Metal strategy NEGATIVE
D97BJ started from exact b9df76 and added Tahoe host eligibility, exact local Metallib selection, exact 25G82 map and forced legacy `13.2.1-24/Metal.framework` on Tahoe. Packaging was x86_64-only because current wxPython was not universal2.

Root Patch runtime execution itself passed:
- preflight PASS;
- local Metallib exact match PASS;
- Metal 3802 Common/Extended installed;
- exact 25G82 metallibs installed including VisionKitCore;
- Monterey GVA/OpenCL installed;
- Haswell driver set installed;
- Modern Wireless installed;
- GPUCompiler merged;
- AuxKC built and forced;
- final `Patching complete`.

Official helper was restored/verified before accelerated boot, so helper state is not a confounder.

## D97BK accelerated evidence — NOT kernel panic
Evidence bundle `OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`:
- bytes `291750`;
- SHA256 `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`.

Authoritative chronology:
- 05:15 accelerated #1;
- 05:18 accelerated #2;
- later VESA/recovery boots excluded.

Both accelerated boots reached userspace and WindowServer `running`. There was no kernel panic report/backtrace; `DumpPanic processed 0 files` after each failure.

Fatal repeated userspace error:
`Superclass of IOGPUMetal4RenderCommandEncoder ... in IOGPU is set to 0xbad4007, indicating it is missing from an installed root`.

`runningboardd` and `launchservicesd` crash repeatedly; launchd then explicitly commits orderly system shutdown.

Classifications:
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC=NEGATIVE`;
- `D97BJ_ACCELERATED_BOOT_USERSPACE_REACHED=PROVEN`;
- `D97BJ_WINDOWSERVER_SPAWN_AND_RUNNING=PROVEN`;
- `D97BJ_IOGPU_METAL4_SUPERCLASS_MISSING=PROVEN`;
- `D97BJ_LAUNCHD_CONTROLLED_SHUTDOWN_AFTER_CRITICAL_SERVICE_CRASH_LOOP=PROVEN`;
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE`.

Tahoe IOGPU Metal4 family depends on native Metal `_MTL4*` superclasses including command queue, command buffer, command allocator, render encoder, compute encoder and machine-learning encoder.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## D97BL architecture
The final architecture must preserve the native Tahoe Metal4 ABI:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Never blindly install the full legacy `13.2.1-24/Metal.framework` over Tahoe.

## D97BL v2 returned evidence — PARTIAL PASS with decisive collision closure
Returned bundle:
`OCLP7_D97BL_STATIC_HYBRID_AUDIT_20260905_134001.zip`
- bytes `143866`;
- SHA256 `426b5bccbaf525626007e90d695466cf7afbedf90b6c075e5076b3e083bf1a23`.

Environment/DMG gates passed:
- Tahoe `26.6.2 / 25G82`;
- active `-igfxvesa`;
- current Root Patch absent;
- exact Universal-Binaries.dmg bytes `641964544`, SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- read-only DMG mount with public b9df76 passphrase `password` succeeded.

Collector result is not a full PASS because of two read-only tooling defects:
1. embedded collision-analysis Python `UnboundLocalError`;
2. attempted direct-file read of native `Versions/A/Metal`, although Tahoe's native Metal image is dyld shared-cache resident.

Classification:
`D97BL_V2_COLLECTOR_RESULT=PARTIAL_PASS_WITH_READONLY_TOOLING_DEFECTS`.

### Exact donor collision closure
Native Tahoe on-disk Metal.framework has no ordinary `Versions/A/Metal` binary; native Metal is cache-resident.

Native Tahoe MTLCompilerService:
- SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- universal x86_64 + arm64e;
- UUID `022C1750-8735-389A-A8BA-A8A67F54235D`.

Donor `12.5-3802-23/Metal.framework` contains exactly four regular files, all inside `MTLCompilerService.xpc`. Therefore it can be bounded structurally to replacement of the service bundle without touching the main Metal binary.

Legacy service identity:
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- original selector surface supports both 3802 and 32023 donor paths.

Donor `13.2.1-24/Metal.framework` contains exactly:
- `Versions/A/Metal`, SHA256 `b9b6fd7ee445b0060c8dbbdd878b5a3f6f5d172865432fa4302f72f6bdb41c2f`;
- `Versions/A/MetalOld.dylib`, SHA256 `5ba827f9c3c5d0018222d615e7118e1e8db511ba0ea66e8b4df7f4b50a9107db`.

Installing donor `Versions/A/Metal` at the canonical path shadows the native cache-resident Metal image and reproduces the D97BK ABI break.

Classification:
`D97BL_13_2_1_24_METAL_AND_METALOLD_INSTALL=FORBIDDEN_TAHOE_NATIVE_CACHE_SHADOW`.

Legacy private compiler identities remain compatible candidates for a hybrid subject to later root closure:
- 3802 MTLCompiler SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- 32023 MTLCompiler SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.

## Historical-source non-repetition closure
Recovered historical Tahoe source already implemented a native-Metal-safe base:
- on Tahoe, replaced only `MTLCompilerService.xpc` from `12.5-3802-23`;
- skipped full 12.5 Metal merge;
- skipped full 13.2.1 Metal merge;
- retained private MTLCompiler/GPUCompiler donor lanes and exact Tahoe metallibs;
- contained P1/P2b/P3/AIR00/D34.

That historical architecture reached MTLCompilerService but did not yield usable GUI. Therefore repeating a plain native-Metal + legacy-XPC/private-compiler + true-five Root Patch would not add new causal information.

Classification:
`D97BL_PLAIN_TRUE_FIVE_HYBRID_REBOOT_REPETITION=REJECTED_NO_NEW_CAUSAL_INFORMATION`.

## Current frontier — producer normalization
D97AV established that P1 is a downstream compatibility shim and masks an upstream llvmVersion producer difference. The preferred repair, if current Tahoe producer audit confirms, is upstream normalization in the native Tahoe Metal request producer with original legacy selector semantics preserved.

Golden producer contract is already closed as above.

D97BM is the next read-only action. It must inspect exact 25G82 dyld shared cache, not a root-file approximation.

## Mandatory pre-reboot Metal4 closure gate
No future Root Patch/accelerated boot until a proposed patch-root audit proves:
1. native Tahoe Metal4 ABI remains present;
2. all IOGPU-referenced `_MTL4*` superclasses resolve;
3. native cache-resident Tahoe Metal is not shadowed by legacy `Versions/A/Metal`;
4. legacy 3802 selector/compiler ingress is bounded and audited;
5. exact 25G82 metallib/local-package handling remains intact;
6. the new experiment provides new causal information beyond the already-tested true-five state.

## Execution contract
GitHub Actions compilation/build/package remains suspended until user explicitly says quota reset/unblocked. GitHub reads/static audit/persistence remain allowed. Local compilation is not an implicit fallback. Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only the read-only `OCLP7_D97BM_tahoe_native_metal_producer_and_metal4_audit.sh` collector. It must:
- pin current 25G82 native MTLCompilerService identity;
- parse exact local dyld shared caches without system/cache mutation;
- locate exact native Metal and IOGPU images;
- hash native Metal `__TEXT`;
- recover all eight XPC request keys and native Metal-owned RIP xrefs;
- identify the primary eight-key request-builder cluster and exact function boundaries;
- back-slice native Tahoe `llvmVersion`, `requestType` and timeout sources;
- census exact native `_MTL4*` / `IOGPUMetal4*` class-name surface;
- inventory cache tooling for a later bounded native-image reconstruction method.

Return the generated D97BM TXT+JSON ZIP for assistant audit.

No Root Patch and no accelerated reboot are authorized.