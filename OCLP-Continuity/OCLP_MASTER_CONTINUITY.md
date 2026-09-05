# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BL_V1_DMG_PASSPHRASE_TOOLING_FAIL_V2_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` and `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup
Before any technical modification, read the permanent database, permanent working rules, this MASTER, permanent VESA rule, the exact current checkpoint above, and retrospective/history when strategic context is needed.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and usable GUI.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- official Golden-lineage executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

Golden remains immutable/read-only.

## Durable historical architecture/evidence
Accepted five-functional diagnostic baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

P6/P7 insufficient. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

Durable compiler/userspace causal chain once that stage is reached:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Durable architecture principle from retrospective:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## D97BG/BH/BI closure
D97BG proved the exact signed Golden OCLP can be launched on Tahoe by bypassing only the host-OS gate, but host-gate bypass alone is insufficient.

D97BH proved exact local MetallibSupportPkg works:
- package `MetallibSupportPkg-26.6.2-25G82.pkg`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`;
- local tree `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

D97BI proved exact b9df76 requests nonexistent `13.2.1-25/Metal.framework` on Darwin 25; available legacy donor is `13.2.1-24`.

## D97BJ functional delta and Root Patch
D97BJ starts from exact b9df76 and changed three functional source files:
1. `opencore_legacy_patcher/support/metallib_handler.py`;
2. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`;
3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`.

Effects:
- host max Sequoia -> Tahoe;
- Tahoe Metal.framework donor forced to `13.2.1-24`;
- exact 25G82 metallib map generated from Pyquick dictionary SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e` (182 entries);
- exact local host-build Metallib preferred before API.

Packaging-only change for Intel ASUS2: PyInstaller target `universal2 -> x86_64`.

D97BJ Root Patch runtime execution = PASS:
- preflight PASS;
- exact local Metallib found;
- Metal 3802 Common/Extended installed;
- exact Tahoe 25G82 metallibs installed including `VisionKitCore.framework`;
- Monterey GVA/OpenCL installed;
- Haswell kext/driver set installed;
- Modern Wireless installed;
- GPUCompiler merged;
- AuxKC built and forced;
- final `Patching complete`.

The official privileged helper was manually restored and verified before accelerated testing, so helper state is not a confounder.

## D97BK accelerated evidence — major correction
Evidence bundle:
`OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`
- bytes `291750`;
- SHA256 `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`.

Authoritative chronology:
- 05:15 — accelerated #1;
- 05:18 — accelerated #2;
- 12:09 — VESA/recovery excluded;
- 12:36 — current VESA/recovery excluded.

The two accelerated attempts did **not** kernel panic. There is no panic report/backtrace and `DumpPanic` processed `0 files` after each failure.

Correct classifications:
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_RESTART=RETRACTED_USER_VISUAL_MISCLASSIFICATION`;
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC=NEGATIVE`.

Both boots deterministically reach WindowServer `running`, then `runningboardd` and `launchservicesd` repeatedly die with `OS_REASON_OBJC`:
`Superclass of IOGPUMetal4RenderCommandEncoder ... in IOGPU is set to 0xbad4007, indicating it is missing from an installed root`.
Launchd then explicitly commits a controlled system shutdown.

Classifications:
- `D97BJ_ACCELERATED_BOOT_USERSPACE_REACHED=PROVEN`;
- `D97BJ_WINDOWSERVER_SPAWN_AND_RUNNING=PROVEN`;
- `D97BJ_IOGPU_METAL4_SUPERCLASS_MISSING=PROVEN`;
- `D97BJ_LAUNCHD_CONTROLLED_SHUTDOWN_AFTER_CRITICAL_SERVICE_CRASH_LOOP=PROVEN`;
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE`.

## D97BK static ABI root cause
Tahoe IOGPU uses Metal4 Objective-C classes whose superclasses come from Tahoe Metal.framework. Proven examples include:
- `IOGPUMetal4CommandQueue : _MTL4CommandQueue`;
- `IOGPUMetal4CommandBuffer : _MTL4CommandBuffer`;
- `IOGPUMetal4CommandAllocator : _MTL4CommandAllocator`;
- `IOGPUMetal4RenderCommandEncoder : _MTL4RenderCommandEncoder`;
- `IOGPUMetal4ComputeCommandEncoder : _MTL4ComputeCommandEncoder`;
- `IOGPUMetal4MachineLearningCommandEncoder : _MTL4MachineLearningCommandEncoder`.

D97BJ's full legacy `Metal.framework` donor `13.2.1-24` removes that Tahoe Metal4 superclass surface while native Tahoe `IOGPU.framework` remains modern.

Therefore:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

The exact Golden/Sequoia full-framework downgrade is not a valid final Tahoe strategy. Adding only one missing `_MTL4*` class is structurally incomplete.

## D97BL architecture decision
D97BL preserves the native Tahoe `Metal.framework` / Metal4 ABI and integrates legacy 3802 support selectively below that surface.

Target architecture:
`native Tahoe Metal.framework / Metal4 ABI -> selective legacy 3802 compiler ingress -> audited boundary adapters -> Haswell driver -> image`.

Historical true-five remains the relevant design lineage, subject to fresh current audit:
`P1 + P2b + P3 + AIR00 + D34`.

Known static locations:
- P1 is in `MTLCompilerService` selector; it preserves the 3802 branch and adapts the 32023 selector compare;
- P2b and AIR00 are in `getReadParametersFromRequest`;
- P3 is in `backendCompileModule`;
- D34 is in `runFrameworkPasses`, with protected cave `0xEF8..0xEFE`.

P6/P7 remain insufficient and are not promoted into D97BL.

D97BJ elements retained prospectively:
- Tahoe host eligibility;
- exact local `26.6.2-25G82` MetallibSupportPkg handling;
- exact 25G82 metallib destination/source map.

Current public OCLP-T2 still merges whole legacy Metal.framework payloads, so it is not treated as a solved Tahoe Metal4 reference.

Exact b9df76 `MERGE` uses `rsync -r -i -a`; same-relative-path donor files replace native files. D97BL therefore requires exact per-file collision analysis rather than another full framework merge.

## D97BL v1 collector tooling correction
The first `OCLP7_D97BL_static_hybrid_audit.sh` run verified the current unpatched VESA state and located exact `Universal-Binaries.dmg`:
- path `/Users/alex/Developer/OpenCore-Legacy-Patcher-D97BJ-b9df76-Tahoe25G82/Universal-Binaries.dmg`;
- bytes `641964544`;
- SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`.

It then failed only because the audit script mounted the encrypted DMG without the public PatcherSupportPkg passphrase.

Exact b9df76 `dmg_mount.py` uses `-passphrase "password"` when mounting `Universal-Binaries.dmg`.

Classifications:
- `D97BL_V1_DMG_MOUNT_FAILURE=TOOLING_ONLY_MISSING_PUBLIC_PASSPHRASE`;
- `B9DF76_UNIVERSAL_BINARIES_DMG_PASSPHRASE=password`.

D97BL v2 changes only that audit mount command and remains read-only.

## Mandatory pre-reboot Metal4 closure gate
No future Root Patch/accelerated boot until the proposed patch root proves:
1. native Tahoe Metal4 ABI surface remains present;
2. all IOGPU-referenced `_MTL4*` superclasses resolve from the installed root;
3. native Tahoe `Metal.framework/Versions/A/Metal` is preserved;
4. 3802 compiler/selector support is integrated through an audited bounded hybrid adapter;
5. exact 25G82 metallib map/local handling remains intact.

## Current system state
User restored the sealed/saved snapshot after the failed D97BJ attempts.
Current state is unpatched Tahoe VESA; current OCLP root-patch plist is absent.

## Execution contract
GitHub Actions compilation remains suspended until user explicitly says quota reset/unblocked.
GitHub reads/static audit/persistence remain allowed.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## CURRENT ACTION
Remain unpatched in VESA/recovery state.

Run only the read-only `OCLP7_D97BL_static_hybrid_audit_v2.sh` collector. It uses exact public b9df76 Universal-Binaries.dmg passphrase `password`, then performs the original D97BL collision/Metal4/compiler/historical-source audit unchanged.

Return the generated `OCLP7_D97BL_STATIC_HYBRID_AUDIT_<timestamp>.zip` for assistant audit.

No Root Patch and no accelerated reboot are authorized.