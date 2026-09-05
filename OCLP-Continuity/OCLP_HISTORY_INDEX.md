# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BL_TAHOE_NATIVE_METAL4_SELECTIVE_3802_HYBRID_STATIC_AUDIT_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is the chronological high-level index. Full experiment/evidence lineage remains in `OCLP-Continuity/checkpoints/`; current state is in MASTER and the permanent database.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / methodology
Accepted historical five-functional baseline:
`P1 + P2b + P3 + AIR00 + D34`.

P6/P7 insufficient. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

Durable late-userspace causal model when that stage is reached:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Methodology: module-boundary + semantic evidence + far-frontier; universal/no-PID where request/process variability exists.

Core architectural principle from retrospective:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## 2026-09-01 to 2026-09-04 — D97 provenance / producer closure
Durable Golden request-builder closure:
- primary builder `0x7FF80D370756..0x7FF80D370C28`;
- RBX = arg1/RDI; `[RBX+0x20] -> llvmVersion`;
- R13 = arg2/RSI; `[R13+0x08] -> requestType`, `[R13+0x18] -> timeout`, `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`.

This phase established selector/donor generation mapping, Golden comparator capture and universal observer discipline. Detailed evidence remains in checkpoint corpus.

## D97BD — identical-OCLP Tahoe eligibility preflight
Historical Tahoe/T2 worktree was rejected as comparator baseline because it was dirty/custom. D97BD moved to exact clean Golden source identity.

## 2026-09-05 — execution/persistence policy
GitHub-first remains the permanent default for technically executable remote work. GitHub Actions compilation/build/package is temporarily suspended until explicit quota-reset confirmation. GitHub source reads/static audit/persistence remain allowed. ASUS2 is reserved for target-local state, manual Root Patch, accelerated boot and VESA recovery.

## 2026-09-05 — Golden source lineage pinned
Working Golden root-patch manifest pinned:
- manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Official Desktop app lineage was proven against that source/workflow. Official executable SHA256:
`0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`.

## D97BE/BF — exact b9df76 Tahoe host gate
Exact b9df76 originally limits supported host to Sequoia; Tahoe=Darwin 25 already exists in `os_data.py`. Haswell itself remains patchable on Darwin 25 and the historical second native-OS gate does not apply to this exact source.

The one-line host gate correction was valid only for eligibility, never proof of full Tahoe Root Patch compatibility.

## D97BG — signed Golden wrapper
A wrapper preserved the exact signed Golden inner OCLP/helper and used the built-in developer marker to bypass the host gate. Runtime proved host-gate bypass alone insufficient.

## D97BH — exact local 25G82 MetallibSupportPkg runtime PASS
Exact target package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Installed exact tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

Because official manifest lacks Tahoe 26.x, forcing manifest failure proved b9df76 local loose-version fallback finds the exact local package and makes the patcher capable.

## D97BI — missing 13.2.1-25 Metal.framework donor PROVEN
After Metallib PASS, b9df76 preflight requested nonexistent:
`Universal-Binaries/13.2.1-25/System/Library/Frameworks/Metal.framework`.

Historical Tahoe work identified existing donor `13.2.1-24`.

## D97BJ — exact 25G82 Tahoe source delta
Exact b9df76 was adapted with three functional source files:
1. `support/metallib_handler.py`;
2. `sys_patch/patchsets/detect.py`;
3. `sys_patch/patchsets/shared_patches/metal_3802.py`.

Effects:
- Tahoe host eligibility;
- Metal.framework donor `13.2.1-24` on Darwin 25;
- exact 25G82 metallib map from Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e` (182 entries);
- prefer exact local host-build Metallib before remote API.

Packaging was bounded to x86_64 because current wxPython was not universal2. Debug helper SHA256:
`a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

## D97BJ — Root Patch execution runtime PASS
User executed D97BJ Root Patch in Tahoe VESA.

PASS evidence:
- exact local Metallib found and API skipped;
- preflight completed;
- Metal 3802 Common/Extended installed;
- exact 25G82 metallib map executed including `VisionKitCore.framework`;
- Monterey GVA/OpenCL installed;
- Haswell driver set installed;
- Modern Wireless installed;
- GPUCompiler libraries merged;
- AuxKC built and forced;
- final `Patching complete`.

Official privileged helper was restored/verified before accelerated testing, so helper state was closed.

## D97BJ — user initially reports kernel-panic restart
User observed two accelerated attempts that appeared to kernel panic/restart, then recovered through VESA and ultimately restored the saved/sealed snapshot. A read-only evidence bundle was collected before any further patching.

This observational classification was intentionally provisional pending logs.

## D97BK — evidence reclassifies failure: NOT kernel panic; deterministic Metal4 ABI userspace shutdown
Evidence bundle:
`OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`
- bytes `291750`;
- SHA256 `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`.

Authoritative boot chronology:
- 05:15 accelerated #1;
- 05:18 accelerated #2;
- 12:09 and 12:36 VESA/recovery excluded.

### No kernel panic
No panic report/backtrace exists for either accelerated attempt. `DumpPanic processed 0 files` after both.

The prior visual classification is retracted:
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_RESTART=RETRACTED_USER_VISUAL_MISCLASSIFICATION`;
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC=NEGATIVE`.

### Accelerated #1
- WindowServer reaches running at `05:15:58.163`.
- `runningboardd` then exits with `OS_REASON_OBJC` because `IOGPUMetal4RenderCommandEncoder` in Tahoe `IOGPU.framework` has superclass sentinel `0xbad4007`, explicitly described as missing from an installed root.
- `launchservicesd` dies with the same reason.
- repeated runningboardd crashes follow.
- launchd commits orderly system shutdown at `05:16:03.758`; shutdown reaches COMMITTED at `05:16:04.750`.

### Accelerated #2
Exact reproduction:
- WindowServer running at `05:18:30.514`;
- same runningboardd/launchservicesd Objective-C IOGPU Metal4 superclass failure;
- repeated crash loop;
- launchd commits shutdown at `05:18:35.262`; COMMITTED at `05:18:35.986`.

Therefore userspace and WindowServer are reached; kernel/AuxKC/Haswell load is not the immediate failure boundary.

Classifications:
- `D97BJ_ACCELERATED_BOOT_USERSPACE_REACHED=PROVEN`;
- `D97BJ_WINDOWSERVER_SPAWN_AND_RUNNING=PROVEN`;
- `D97BJ_IOGPU_METAL4_SUPERCLASS_MISSING=PROVEN`;
- `D97BJ_LAUNCHD_CONTROLLED_SHUTDOWN_AFTER_CRITICAL_SERVICE_CRASH_LOOP=PROVEN`;
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE`.

## D97BK — static ABI closure
Tahoe IOGPU Metal4 classes inherit from `_MTL4*` classes supplied by Tahoe Metal.framework. Proven family includes command queue, command buffer, command allocator, render encoder, compute encoder and machine-learning encoder.

D97BJ wholesale legacy donor `Metal.framework 13.2.1-24` removes that Tahoe Metal4 superclass surface while keeping native Tahoe `IOGPU.framework`.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

Adding only the first missing `_MTL4RenderCommandEncoder` would be structurally incomplete because the ABI dependency is a wider class family.

## D97BL — selective Tahoe-native Metal4 hybrid phase opened
The identical-Golden full Metal.framework downgrade is closed as a final Tahoe strategy.

D97BL target architecture is:
`native Tahoe Metal.framework / Metal4 ABI -> selective legacy 3802 compiler ingress -> audited boundary adapters -> Haswell driver -> image`.

Native Tahoe `Metal.framework/Versions/A/Metal` must remain intact.

Historical true-five becomes the relevant design lineage again, subject to fresh audit:
`P1 + P2b + P3 + AIR00 + D34`.

Known static placement reinforces that this can live below the Metal4 surface:
- P1 is in `MTLCompilerService` selector and leaves the 3802 selector branch intact;
- P2b/AIR00 are in compiler `getReadParametersFromRequest`;
- P3 is in `backendCompileModule`;
- D34 is in `runFrameworkPasses` with protected cave `0xEF8..0xEFE`.

P6/P7 remain insufficient and are not promoted.

D97BJ pieces retained prospectively:
- Tahoe host eligibility;
- exact local 25G82 MetallibSupportPkg preference;
- exact 25G82 metallib map.

Current public OCLP-T2 implementations still merge full legacy Metal.framework payloads, so they are not evidence that Tahoe Metal4 closure is solved.

Exact b9df76 MERGE behavior uses recursive rsync; same-relative-path donor files overwrite native files. Therefore D97BL begins with exact per-file collision and dependency mapping rather than another framework merge.

Prepared read-only collector:
`OCLP7_D97BL_static_hybrid_audit.sh`.
It compares native Tahoe Metal.framework against `12.5-3802-23` and `13.2.1-24`, maps donor-only/colliding files, maps Mach-O dependencies/selectors, enumerates native `_MTL4*` surface, inspects MTLCompiler/GPUCompiler donors, and recovers historical P1-D34 source/diffs. It performs no mutation, Root Patch or reboot.

## Mandatory pre-reboot gate
No new Root Patch/accelerated boot until static audit proves:
- native Tahoe Metal4 ABI survives the patch;
- every IOGPU-referenced `_MTL4*` superclass resolves;
- native Tahoe `Metal.framework/Versions/A/Metal` is preserved;
- 3802 ingress is implemented as an audited hybrid adapter;
- exact 25G82 metallib handling remains intact.

## CURRENT ACTION
Remain unpatched in Tahoe VESA after snapshot restore.

Run only `OCLP7_D97BL_static_hybrid_audit.sh` and return the generated `OCLP7_D97BL_STATIC_HYBRID_AUDIT_<timestamp>.zip`.

No Root Patch and no accelerated reboot are authorized.