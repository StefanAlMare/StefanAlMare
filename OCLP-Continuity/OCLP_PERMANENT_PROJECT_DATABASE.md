# OCLP PERMANENT PROJECT DATABASE — ASUS2 Tahoe Haswell

Updated: 2026-09-05 EEST
Scope: **all continuations OCLP 11, OCLP 12, OCLP 13, OCLP 14, OCLP 15 and later**.
Purpose: consolidated durable project state. Detailed evidence remains in MASTER, HISTORY, RETROSPECTIVE and checkpoint corpus. If current-state wording conflicts, the newest authoritative checkpoint linked by MASTER wins. Permanent safety/methodology rules remain governed by `OCLP_PERMANENT_WORKING_RULES.md` and `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

---

## 1. End goal
Run macOS Tahoe `26.6.2 / 25G82` on ASUS2 with Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, with stable hardware acceleration and usable GUI.

---

## 2. Current architecture authority
The old pure identical-Golden strategy is no longer sufficient at the whole `Metal.framework` boundary.

Current required architecture after D97BK:
`Tahoe-native Metal4/IOGPU outer ABI -> audited legacy-3802 ingress adapter -> Golden-equivalent legacy compiler/selector semantics -> Haswell driver handoff -> image`.

Core rule:
- preserve Tahoe-native Metal4 Objective-C ABI surface;
- do not blindly replace Tahoe `Metal.framework/Versions/A/Metal` with the legacy 13.2.1 donor;
- integrate only the legacy 3802 path required for Haswell through a bounded, semantically audited adapter;
- keep exact 25G82 MetallibSupportPkg handling.

This is consistent with the historical adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

---

## 3. Golden systems / immutable rule
### GOLDEN_A
- Sequoia `15.7.9 / 24G830`.

### GOLDEN_B
- Sequoia `15.8 / 24H22`;
- same EFI according to user;
- original OCLP Root Patch manually reapplied;
- hardware acceleration works.

Golden is **immutable/read-only**. Never boot or modify Golden merely to collect evidence.

---

## 4. Exact Golden ORIGINAL-OCLP source lineage
Working Golden root-patch manifest:
`/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist`

Pinned identity:
- manifest bytes `34173`;
- manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- OCLP `v2.5.0`;
- PatcherSupportPkg `v1.9.6`;
- manifest OS `24.6 (24H22)`;
- exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Official Golden-lineage Desktop app:
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- Developer ID Team `S74BDJXQMD`;
- deep/strict codesign PASS.

Official privileged helper reference:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`.

---

## 5. Golden component invariants
Donor/compiler components:
- 32023 SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Haswell components:
- AppleIntelFramebufferAzul binary SHA256 `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics binary SHA256 `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver binary SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

Original selector mapping:
- request `3802 -> Versions/3802`;
- request `31001 -> Versions/32023`.

---

## 6. Golden request/producer contract closure
Receiver XPC schema:
- `requestType:uint64`;
- `sandboxTokens:value`;
- `llvmVersion:uint64`;
- `pluginPath:string`;
- `targetData:value`;
- `data:value`;
- `client_name:string`;
- `timeout:uint64`.

Primary Golden request builder:
- region `0x7FF80D370756..0x7FF80D370C28`;
- `RBX = ABI arg1/RDI`;
- `[RBX+0x20] -> llvmVersion`;
- `R13 = ABI arg2/RSI`;
- `[R13+0x08] -> requestType`;
- `[R13+0x18] -> timeout`;
- `[R13+0x70]` gates sandboxTokens;
- alternate requestType immediate `9`.

---

## 7. Historical accepted functional baseline
Exactly:
1. P1 selector bridge;
2. P2b request-layout bridge `request+0xD0 -> request+0x110`;
3. P3 serialized-bitcode path;
4. AIR00 fallback producing AIR 2.6 / Metal 3.1;
5. D34 semantic-equivalent reset.

True-five historical SHA:
`6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

D22 remains semantic proof for AIR 2.6 / Metal 3.1.

These are historical/proven design evidence, not automatically active patches. P6/P7 sufficiency is NEGATIVE. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

---

## 8. Retained late-userspace causal model
Once the legacy compiler stage is reached, retained causal chain is:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

D97BK establishes a different, earlier userspace blocker for the D97BJ full-framework donor, so this old chain is not assumed to be reached until Metal4 ABI closure passes.

---

## 9. Rejected historical Tahoe/T2 worktree
Historical path:
`/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`

It is a dirty/custom historical source and is not an identical comparator. Never clean/reset it merely to manufacture a comparator.

---

## 10. Exact b9df76 Tahoe eligibility closure
Exact b9df76 originally has `_max_os = os_data.sequoia.value`; `os_data.py` already defines Tahoe = Darwin 25.

The historical second Haswell/native-OS blocker does not apply to exact b9df76:
- Haswell is included;
- `IntelHaswell.native_os()` is false on Darwin 25;
- Haswell composition remains LegacyMetal3802 + MontereyGVA + MontereyOpenCL + model-specific;
- LegacyMetal3802 has no Tahoe maximum.

Thus host-eligibility delta itself is valid, but it never proved whole Root Patch compatibility.

---

## 11. D97BH — exact 25G82 MetallibSupportPkg
Exact package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact local tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

Runtime proved local package selection works. D97BJ improved this by preferring exact local host-build package before API fallback.

Exact Pyquick 25G82 patch dictionary SHA256:
`c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`.

---

## 12. D97BJ — Root Patch execution PASS, boot strategy NEGATIVE
D97BJ used exact b9df76 plus:
- Tahoe host eligibility;
- `Metal.framework` legacy donor forced to `13.2.1-24`;
- exact 25G82 metallib map (182 entries);
- exact local Metallib preference.

Root Patch execution itself was successful:
- preflight PASS;
- Metal 3802 Common/Extended installed;
- exact 25G82 metallibs installed including `VisionKitCore`;
- Monterey GVA/OpenCL installed;
- Haswell kext/driver set installed;
- Modern Wireless installed;
- GPUCompiler merged;
- AuxKC built and forced;
- final `Patching complete`.

Official helper was restored before accelerated test, so helper state is not a confounder.

---

## 13. D97BK — accelerated evidence correction and root cause
Evidence bundle:
`OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`
- bytes `291750`;
- SHA256 `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`.

Authoritative chronology:
- `05:15` accelerated #1;
- `05:18` accelerated #2;
- `12:09` / `12:36` VESA/recovery excluded.

### Kernel panic retracted
There was no kernel panic. No panic report/backtrace exists and `DumpPanic processed 0 files` after each accelerated failure.

Classifications:
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_RESTART=RETRACTED_USER_VISUAL_MISCLASSIFICATION`;
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC=NEGATIVE`.

### Deterministic userspace failure
Both accelerated boots reach `WindowServer` running, then repeatedly kill `runningboardd` and `launchservicesd` with:
`OS_REASON_OBJC | Superclass of IOGPUMetal4RenderCommandEncoder ... in IOGPU is set to 0xbad4007, indicating it is missing from an installed root`.

After repeated essential-service crashes, `launchd` explicitly commits an orderly system shutdown.

Classifications:
- `D97BJ_ACCELERATED_BOOT_USERSPACE_REACHED=PROVEN`;
- `D97BJ_WINDOWSERVER_SPAWN_AND_RUNNING=PROVEN`;
- `D97BJ_IOGPU_METAL4_SUPERCLASS_MISSING=PROVEN`;
- `D97BJ_LAUNCHD_CONTROLLED_SHUTDOWN_AFTER_CRITICAL_SERVICE_CRASH_LOOP=PROVEN`;
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE`.

### Static ABI closure
Tahoe IOGPU Metal4 classes inherit from `_MTL4*` superclasses supplied by Tahoe Metal.framework. Proven family includes:
- `_MTL4CommandQueue`;
- `_MTL4CommandBuffer`;
- `_MTL4CommandAllocator`;
- `_MTL4RenderCommandEncoder`;
- `_MTL4ComputeCommandEncoder`;
- `_MTL4MachineLearningCommandEncoder`.

D97BJ's full legacy `Metal.framework 13.2.1-24` donor removes Tahoe's Metal4 superclass surface while native Tahoe IOGPU remains modern.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

A one-class shim is insufficient because the dependency is a wider Metal4 family.

---

## 14. Current D97BL design direction
D97BL must preserve native Tahoe Metal.framework/Metal4 ABI and integrate legacy 3802 support as a hybrid boundary adapter.

The historical accepted five-functional lineage becomes strategically relevant again, but each element must be revalidated against current Tahoe 25G82 and exact native Metal4 contracts before reuse.

Keep from D97BJ:
- Tahoe host eligibility;
- exact local 26.6.2-25G82 MetallibSupportPkg handling;
- exact 25G82 metallib map.

Reject from D97BJ as final Tahoe strategy:
- wholesale legacy Metal.framework 13.2.1-24 replacement/merge over native Tahoe Metal4 root.

---

## 15. Mandatory pre-reboot Metal4 closure gate
No future Root Patch/accelerated boot until static audit proves:
1. native Tahoe Metal4 ABI surface remains present after proposed patch;
2. every IOGPU-referenced `_MTL4*` superclass resolves from installed root;
3. Tahoe `Metal.framework/Versions/A/Metal` is not blindly replaced by legacy donor;
4. legacy 3802 selector/compiler ingress is implemented via bounded audited adapter;
5. exact 25G82 metallib map/local package handling remains intact.

This gate exists specifically to minimize unavoidable Root Patch/recovery cycles.

---

## 16. Execution responsibility / quota override
GitHub-first is the permanent default, but GitHub compilation/build/package jobs remain suspended until explicit user confirmation that quota is reset/unblocked.

Allowed now:
- GitHub source reads;
- static audit;
- provenance;
- persistence/checkpoints.

Not allowed without explicit new instruction:
- new GitHub Actions compile/build/package run;
- implicit local compilation fallback.

Never auto Root Patch. Never auto reboot.

---

## 17. Permanent diagnostic / VESA discipline
- keep evidence classes distinct;
- module-boundary methodology by default;
- raw evidence before interpretation;
- whole-stage/multi-threshold diagnostics preferred;
- analyze the immediately preceding accelerated diagnostic boot, not later VESA recovery;
- user's boot identification is authoritative;
- D34 cave `0xEF8..0xEFE` remains protected;
- persist decisive PROVEN/NEGATIVE results immediately.

---

## 18. Current system state and CURRENT ACTION
Current machine state after recovery:
- Tahoe `26.6.2 / 25G82`;
- VESA/recovery;
- saved/sealed snapshot restored;
- no active Root Patch (`OpenCore-Legacy-Patcher.plist` absent in current root).

### CURRENT ACTION
Remain unpatched in VESA/recovery state.

No Root Patch and no accelerated reboot are authorized.

Design/audit D97BL as a Tahoe-native-Metal4-preserving hybrid. First map the exact native Tahoe Metal4/IOGPU contract and the minimum legacy 3802 ingress required from the historical true-five. Before any future boot, pass the mandatory static Metal4 superclass-closure gate.

Startup order for every continuation:
1. read this database;
2. read permanent working rules;
3. read MASTER;
4. read permanent VESA rule;
5. read exact checkpoint linked by MASTER;
6. consult retrospective/history as needed.