# OCLP PERMANENT PROJECT DATABASE — ASUS2 Tahoe Haswell

Updated: 2026-09-05 EEST
Scope: all OCLP11/OCLP12/OCLP13/OCLP14/OCLP15+ continuations.
Purpose: consolidated durable project state. Detailed evidence remains in MASTER, HISTORY, RETROSPECTIVE and checkpoint corpus. If current-state wording conflicts, the newest authoritative checkpoint linked by MASTER wins. Permanent safety/methodology rules remain governed by `OCLP_PERMANENT_WORKING_RULES.md` and `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

---

## 1. End goal
Run macOS Tahoe `26.6.2 / 25G82` on ASUS2 with Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and usable GUI.

---

## 2. Current architecture authority
The old whole-framework identical-Golden strategy is closed as a final Tahoe solution.

Current required architecture:
`Tahoe-native Metal4/IOGPU outer ABI -> audited legacy-3802 ingress adapter -> Golden-equivalent legacy compiler/selector semantics -> Haswell driver handoff -> image`.

Core rules:
- preserve native Tahoe Metal4 Objective-C ABI surface;
- do not install legacy `13.2.1-24/Versions/A/Metal` over the cache-resident Tahoe Metal image;
- integrate only the legacy 3802 path needed for Haswell through a bounded adapter;
- keep exact 25G82 MetallibSupportPkg handling;
- do not spend a Root Patch/recovery cycle recreating a historical state that already failed without adding new causal information.

This follows the historical principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

---

## 3. Golden systems / immutable rule
Golden Sequoia working systems remain immutable/read-only. Never boot or modify Golden merely to collect new evidence. Use persisted evidence or read-only static inspection only when genuinely required.

---

## 4. Exact Golden ORIGINAL-OCLP source lineage
Pinned identity:
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- root-patch manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- official app executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

---

## 5. Golden component invariants
- 32023 SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- AppleIntelFramebufferAzul SHA256 `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics SHA256 `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

Original service selector:
- request `3802 -> Versions/3802`;
- request `31001 -> Versions/32023`.

---

## 6. Golden request/producer contract closure
Receiver XPC schema:
- requestType:uint64;
- sandboxTokens:value;
- llvmVersion:uint64;
- pluginPath:string;
- targetData:value;
- data:value;
- client_name:string;
- APISpecifiedTimeoutInSeconds:uint64.

Primary Golden Metal request builder:
- function `0x7FF80D370756..0x7FF80D370C28`;
- RBX = ABI arg1/RDI;
- signed dword `[RBX+0x20] -> llvmVersion`;
- R13 = ABI arg2/RSI;
- `[R13+0x08] -> requestType`;
- `[R13+0x18] -> timeout`;
- `[R13+0x70]` gates sandboxTokens;
- alternate requestType immediate `9`.

Golden runtime established both 3802 and 32023 donor lanes and a positive Haswell driver -> compiler -> Metal compositor corridor.

---

## 7. Historical accepted functional baseline
Exactly:
1. P1 selector bridge;
2. P2b request-layout bridge `+0xD0 -> +0x110`;
3. P3 serialized-bitcode path;
4. AIR00 fallback producing AIR 2.6 / Metal 3.1;
5. D34 semantic-equivalent reset.

True-five historical SHA:
`6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

D22 remains semantic proof for AIR 2.6 / Metal 3.1. D34 cave `0xEF8..0xEFE` is protected.

P6/P7 runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

These five patches are design evidence, not automatically the next active patchset.

---

## 8. Retained late-userspace causal model
Once legacy compilation is reached:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

WindowServer is downstream, not root cause.

---

## 9. Rejected historical Tahoe custom worktree
Historical path:
`/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`.

It remains dirty/custom evidence, not an identical comparator. Never clean/reset it merely to manufacture a comparator.

The recovered historical source is now useful as design evidence because it shows a native-Metal-safe hybrid was already tested.

---

## 10. Exact b9df76 Tahoe eligibility closure
Exact b9df76 originally has `_max_os = os_data.sequoia.value`; Tahoe is Darwin 25. Haswell remains non-native/patchable on Darwin 25. The historical second native-OS blocker does not apply to exact b9df76.

Thus host eligibility itself is valid but never proved whole Root Patch compatibility.

---

## 11. Exact 25G82 MetallibSupportPkg
Exact package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact local tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

Exact Pyquick 25G82 dictionary SHA256:
`c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`.

Runtime local selection is proven. D97BJ exact-local-first handling and exact 182-entry Tahoe metallib map remain retained for future designs.

---

## 12. D97BJ — Root Patch execution PASS, full legacy Metal boot strategy NEGATIVE
D97BJ used exact b9df76 plus Tahoe eligibility, exact local Metallib preference, exact 25G82 metallib map and forced legacy `13.2.1-24/Metal.framework`.

Root Patch runtime itself fully passed: preflight, Metal3802 Common/Extended, exact metallibs, Monterey GVA/OpenCL, Haswell driver set, Modern Wireless, GPUCompiler and AuxKC; final `Patching complete`.

Official helper was restored before accelerated boot.

---

## 13. D97BK — accelerated evidence and Metal4 ABI root cause
Evidence bundle:
`OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`, SHA256 `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`.

The two accelerated attempts did not kernel panic. Both reached userspace and WindowServer running. Essential services then repeatedly died because Tahoe IOGPU Metal4 classes could not resolve their native Metal `_MTL4*` superclasses; launchd committed orderly shutdown.

Proven class family includes command queue, command buffer, command allocator, render, compute and machine-learning encoders.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

Adding one `_MTL4*` shim is structurally insufficient.

---

## 14. D97BL v2 — donor collision closure
Returned bundle:
`OCLP7_D97BL_STATIC_HYBRID_AUDIT_20260905_134001.zip`
- bytes `143866`;
- SHA256 `426b5bccbaf525626007e90d695466cf7afbedf90b6c075e5076b3e083bf1a23`.

Collector classification:
`D97BL_V2_COLLECTOR_RESULT=PARTIAL_PASS_WITH_READONLY_TOOLING_DEFECTS`.

Two reporting bugs occurred but no mutation:
- collision-analysis Python UnboundLocalError;
- native Metal was incorrectly probed as a root file even though Tahoe supplies it from dyld shared cache.

Durable collision conclusions:

### Native Tahoe MTLCompilerService
- SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- universal x86_64 + arm64e;
- UUID `022C1750-8735-389A-A8BA-A8A67F54235D`.

### `12.5-3802-23/Metal.framework`
Contains exactly four regular files, all inside `MTLCompilerService.xpc`. It can be bounded to service-bundle replacement without touching main Metal.

Legacy service remains exact Golden identity SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

### `13.2.1-24/Metal.framework`
Contains exactly:
- `Versions/A/Metal`, SHA256 `b9b6fd7ee445b0060c8dbbdd878b5a3f6f5d172865432fa4302f72f6bdb41c2f`;
- `Versions/A/MetalOld.dylib`, SHA256 `5ba827f9c3c5d0018222d615e7118e1e8db511ba0ea66e8b4df7f4b50a9107db`.

Because Tahoe native Metal is cache-resident, installing legacy `Versions/A/Metal` at the canonical path shadows the native image.

Permanent classification:
`D97BL_13_2_1_24_METAL_AND_METALOLD_INSTALL=FORBIDDEN_TAHOE_NATIVE_CACHE_SHADOW`.

The private 3802/32023 compiler payloads remain candidates for a bounded hybrid subject to later static root closure.

---

## 15. Historical true-five non-repetition rule
Recovered historical Tahoe source already used the native-Metal-safe structure:
- preserved native Tahoe Metal;
- replaced only legacy MTLCompilerService.xpc;
- merged private 3802/32023 compiler lanes;
- used Tahoe metallibs;
- applied P1/P2b/P3/AIR00/D34.

That architecture reached MTLCompilerService but did not yield a usable GUI.

Permanent classification:
`D97BL_PLAIN_TRUE_FIVE_HYBRID_REBOOT_REPETITION=REJECTED_NO_NEW_CAUSAL_INFORMATION`.

Do not authorize a reboot whose only purpose is to recreate that historical state.

---

## 16. Producer-normalization frontier
D97AV established that P1 is a downstream compatibility shim: it adapts a Tahoe request carrying 32023 to the legacy selector, but does not explain the missing Golden 3802 lane. Preferred repair is upstream producer normalization if exact current Tahoe producer comparison confirms it.

Next analysis therefore targets the native Tahoe Metal request producer in exact 25G82 dyld shared cache.

---

## 17. Mandatory pre-reboot Metal4 / novelty gate
No future Root Patch/accelerated boot until static audit proves:
1. native Tahoe Metal4 ABI remains present;
2. all relevant IOGPU `_MTL4*` superclasses resolve;
3. native cache-resident Metal is not shadowed by legacy `Versions/A/Metal`;
4. legacy 3802 ingress is bounded/audited;
5. exact 25G82 metallib/local-package handling remains intact;
6. the proposed experiment supplies causal information not already obtained from historical true-five testing.

---

## 18. Execution responsibility / quota override
GitHub-first remains permanent default. GitHub compilation/build/package jobs remain suspended until explicit user confirmation that quota reset/unblocked.

Allowed now:
- GitHub source reads;
- static audit;
- provenance;
- persistence/checkpoints.

Local compilation is not an implicit fallback and requires explicit authorization.
Never auto Root Patch. Never auto reboot.

---

## 19. Permanent diagnostic / VESA discipline
- keep evidence classes distinct;
- module-boundary methodology by default;
- raw evidence before interpretation;
- whole-stage/multi-threshold diagnostics preferred;
- analyze the immediately preceding accelerated diagnostic boot, not later VESA recovery;
- user's boot identification is authoritative;
- persist decisive PROVEN/NEGATIVE results immediately.

---

## 20. Current system state / CURRENT ACTION
Current machine:
- Tahoe `26.6.2 / 25G82`;
- VESA/recovery with `-igfxvesa`;
- sealed/saved snapshot restored;
- no active Root Patch.

### CURRENT ACTION — D97BM read-only native shared-cache producer audit
Run only `OCLP7_D97BM_tahoe_native_metal_producer_and_metal4_audit.sh`.

D97BM must:
1. pin native Tahoe MTLCompilerService SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
2. parse exact local 25G82 dyld shared caches read-only;
3. locate native Metal and IOGPU images;
4. hash native Metal `__TEXT`;
5. recover all eight Metal-owned XPC request-key xrefs;
6. derive the primary eight-key request-builder cluster and LC_FUNCTION_STARTS boundaries;
7. back-slice Tahoe llvmVersion/requestType/timeout value sources;
8. census native `_MTL4*` and `IOGPUMetal4*` class-name surface;
9. inventory cache tooling for later bounded native-image reconstruction;
10. make no source/system/cache mutation, no Root Patch and no reboot.

After D97BM, compare exact Tahoe producer layout/value semantics against the already-proven Golden producer contract. Only then design a bounded producer-side adapter and a synthetic patched-root closure audit.

Startup order for every continuation:
1. read this database;
2. read permanent working rules;
3. read MASTER;
4. read permanent VESA rule;
5. read exact checkpoint linked by MASTER;
6. consult retrospective/history as needed.