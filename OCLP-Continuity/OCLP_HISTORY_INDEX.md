# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BL_V2_PARTIAL_PASS_DONOR_COLLISION_CLOSURE_D97BM_NATIVE_CACHE_PRODUCER_AUDIT_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is the high-level chronological index. Detailed evidence remains in `OCLP-Continuity/checkpoints/`; current consolidated state is in MASTER and the permanent database.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / methodology
Historical accepted functional baseline:
`P1 + P2b + P3 + AIR00 + D34`.

P6/P7 insufficient. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

Durable late-userspace causal model:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Methodology: module-boundary + semantic evidence + far-frontier; universal/no-PID when process/request variability exists.

Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## 2026-09-01 to 2026-09-04 — D97 provenance / producer closure
Golden request-builder and selector contract was closed:
- primary cached Metal builder `0x7FF80D370756..0x7FF80D370C28`;
- RBX = ABI arg1/RDI; `[RBX+0x20] -> llvmVersion`;
- R13 = ABI arg2/RSI; `[R13+0x08] -> requestType`, `[R13+0x18] -> timeout`, `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`;
- original MTLCompilerService selector `3802 -> Versions/3802`, `31001 -> Versions/32023`.

Golden dual-generation runtime and positive Haswell -> compiler -> Metal compositor corridor were established. P1 was later reclassified as a downstream compatibility shim that masks an upstream llvmVersion producer difference; preferred architecture is producer normalization if Tahoe comparison confirms it.

## 2026-09-05 — exact Golden OCLP lineage
Working Golden root patch pinned to:
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`.

Official Desktop app lineage was proven against the official workflow. Golden remains immutable/read-only.

## D97BE/BF — exact b9df76 Tahoe eligibility
Exact b9df76 originally caps host support at Sequoia. Tahoe already exists as Darwin 25 in `os_data.py`; Haswell itself remains non-native/patchable on Darwin 25. Historical second native-OS blocker does not apply to this exact source. The host-gate correction was valid only for eligibility, never proof of complete Tahoe compatibility.

## D97BG — signed Golden wrapper
A wrapper preserved the exact signed Golden OCLP/helper and used the built-in developer marker to bypass the host gate. Runtime proved host-gate bypass alone insufficient.

## D97BH — exact local 25G82 MetallibSupportPkg PASS
Exact package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Installed exact local tree works. D97BJ later improved selection by preferring exact host-build local package before API.

## D97BI — missing Tahoe legacy Metal donor
After Metallib PASS, exact b9df76 requested nonexistent `13.2.1-25/Metal.framework`. Existing legacy donor is `13.2.1-24`.

## D97BJ — complete Tahoe 25G82 source delta and Root Patch runtime PASS
D97BJ adapted exact b9df76 with:
- Tahoe host eligibility;
- forced `13.2.1-24/Metal.framework` on Darwin 25;
- exact 25G82 metallib map (182 entries) from Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact local Metallib preference.

Root Patch runtime itself passed fully: preflight, Metal3802, exact metallibs including VisionKitCore, Monterey GVA/OpenCL, Haswell set, Modern Wireless, GPUCompiler and AuxKC. Final `Patching complete`.

Official privileged helper was restored/verified before accelerated testing.

## D97BK — accelerated failure reclassified: not kernel panic
User initially perceived two accelerated attempts as kernel panic/restart. Read-only evidence proved otherwise.

Evidence bundle:
- `OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`;
- SHA256 `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`.

Authoritative chronology: 05:15 and 05:18 accelerated; later VESA recovery excluded.

Both boots reached WindowServer running. No panic report/backtrace existed; DumpPanic processed zero files. Essential services repeatedly died with Objective-C loader error because Tahoe `IOGPUMetal4RenderCommandEncoder` could not resolve its `_MTL4RenderCommandEncoder` superclass. Launchd then committed orderly shutdown.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

This closed whole legacy `Metal.framework` replacement as a final Tahoe strategy.

## D97BL — Tahoe-native Metal4 selective-hybrid phase
New target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Native Tahoe Metal must remain cache-resident/authoritative. Full legacy `13.2.1-24/Metal.framework` must not shadow it.

### D97BL v1
Read-only collector located exact Universal-Binaries.dmg but failed only because it omitted the public OCLP DMG passphrase. Exact b9df76 passphrase is literally `password`. Tooling failure only.

### D97BL v2 returned bundle
User returned:
`OCLP7_D97BL_STATIC_HYBRID_AUDIT_20260905_134001.zip`
- bytes `143866`;
- SHA256 `426b5bccbaf525626007e90d695466cf7afbedf90b6c075e5076b3e083bf1a23`.

DMG read-only mount and core evidence collection succeeded, but two reporting defects prevented a full collector PASS: collision-analysis Python `UnboundLocalError` and direct-file probing of native Metal although Tahoe Metal is dyld-cache resident.

Classification:
`D97BL_V2_COLLECTOR_RESULT=PARTIAL_PASS_WITH_READONLY_TOOLING_DEFECTS`.

### Decisive donor collision closure
Native Tahoe on-disk Metal.framework contains no ordinary `Versions/A/Metal`; native Metal is supplied from dyld shared cache.

Donor `12.5-3802-23/Metal.framework` contains only four `MTLCompilerService.xpc` files. It can therefore be bounded to replacing the service bundle without touching the main Metal image.

Donor `13.2.1-24/Metal.framework` contains only:
- `Versions/A/Metal` SHA256 `b9b6fd7ee445b0060c8dbbdd878b5a3f6f5d172865432fa4302f72f6bdb41c2f`;
- `Versions/A/MetalOld.dylib` SHA256 `5ba827f9c3c5d0018222d615e7118e1e8db511ba0ea66e8b4df7f4b50a9107db`.

Installing donor `Versions/A/Metal` at the canonical path shadows the native cache-resident Tahoe image and explains D97BK.

Classification:
`D97BL_13_2_1_24_METAL_AND_METALOLD_INSTALL=FORBIDDEN_TAHOE_NATIVE_CACHE_SHADOW`.

Native Tahoe MTLCompilerService SHA256 is `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Legacy service remains exact Golden SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

### Historical-source non-repetition closure
Recovered historical Tahoe custom source already did the safe base architecture:
- kept native Tahoe Metal;
- replaced only legacy MTLCompilerService.xpc;
- merged private 3802/32023 compiler lanes;
- used Tahoe metallibs;
- contained P1/P2b/P3/AIR00/D34.

That state reached MTLCompilerService but did not yield a usable GUI. Therefore another Root Patch that merely recreates true-five hybrid would not add causal information.

Classification:
`D97BL_PLAIN_TRUE_FIVE_HYBRID_REBOOT_REPETITION=REJECTED_NO_NEW_CAUSAL_INFORMATION`.

## D97BM — native Tahoe shared-cache producer audit opened
The next frontier is the native Tahoe Metal request producer, not another Root Patch.

D97BM must read exact local 25G82 dyld caches and:
- locate native Metal and IOGPU images;
- pin native Metal text identity;
- recover all eight request-key xrefs;
- identify primary builder function boundaries;
- back-slice Tahoe llvmVersion/requestType/timeout sources;
- census exact native `_MTL4*` / `IOGPUMetal4*` class surface;
- inventory bounded dyld-cache tooling.

After D97BM, compare Tahoe producer layout/value semantics against the already-proven Golden contract and design only a producer-side normalization that supplies new causal information.

## CURRENT ACTION
Remain unpatched in Tahoe VESA. Run only `OCLP7_D97BM_tahoe_native_metal_producer_and_metal4_audit.sh` and return its TXT+JSON ZIP.

No Root Patch and no accelerated reboot are authorized.