# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BJ_TAHOE_25G82_ROOT_PATCH_RUNTIME_PASS_ACCELERATED_BOOT_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is the chronological high-level index. Full experiment/evidence lineage remains in `OCLP-Continuity/checkpoints/`; current consolidated state is in MASTER and the permanent database.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / methodology
Historical architecture converged toward:
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver -> image`.

Accepted diagnostic five-functional historical baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.
P6/P7 insufficient. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

Durable causal model:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Methodology: module-boundary + semantic evidence + far-frontier, universal/no-PID where request/process variability exists.

## 2026-09-01 to 2026-09-04 — D97 provenance / producer closure
Durable Golden request-builder closure:
- primary builder `0x7FF80D370756..0x7FF80D370C28`;
- RBX = arg1/RDI; `[RBX+0x20] -> llvmVersion`;
- R13 = arg2/RSI; `[R13+0x08] -> requestType`, `[R13+0x18] -> timeout`, `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`.

This phase also established selector/donor generation mapping, Golden comparator capture and universal observer discipline. Detailed evidence remains in checkpoint corpus.

## D97BD — identical-OCLP Tahoe eligibility preflight
The historical Tahoe/T2 local worktree was rejected as comparator baseline because it was dirty/custom in `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py` and contained D97/.before material.

D97BD preserved Golden component invariants and opened the exact clean-ref eligibility audit.

## 2026-09-05 — permanent GitHub-first policy restored
User set GitHub-first as the permanent default execution contract, with ASUS2 reserved for identity-pinned local/live/hardware actions, manual Root Patch, accelerated boot and VESA recovery. GitHub Actions compilation was later explicitly suspended until quota reset; GitHub remained available for source reads, static audit and persistence.

## 2026-09-05 — Golden source lineage pinned
Working Golden root-patch manifest pinned:
- manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

## D97BE — exact b9df76 Tahoe host eligibility chain
Exact b9df76 proved:
- `detect.py` original max host = Sequoia;
- `os_data.py` already defines Tahoe = Darwin 25;
- unsupported host propagates to Root Patch block;
- Haswell remains non-native/patchable on Darwin 25;
- exact Haswell composition remains `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific`;
- historical second native-OS/patchset blocker does not apply to exact b9df76.

The initial static conclusion was a one-line host max delta, explicitly scoped as only the demonstrated pre-patchset host gate, not proof of complete Tahoe Root Patch success.

## D97BF — pre-build identity gates
Before GitHub compilation suspension, exact b9df76 checkout/tree and a one-file static host-gate delta were validated. Protected Golden blobs for constants, os_data, Haswell, metal_3802, sys_patch, sys_patch_helpers and metallib_handler were pinned.

## 2026-09-05 — official Desktop OCLP b9df76 lineage proven
User Desktop app evidence:
- OCLP 2.5.0;
- universal x86_64/arm64;
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- valid Developer ID `S74BDJXQMD`;
- strict/deep codesign PASS.

Official workflow provenance tied it to exact b9df76 source lineage. Byte identity to the expired official artifact remained unavailable.

## D97BG — Tahoe-ready signed wrapper
Built a wrapper preserving the exact signed Golden inner OCLP and official helper while automatically creating/removing the built-in developer marker. Build/audit PASS proved the host-gate bypass architecture.

Live Tahoe testing then proved D97BG was insufficient for full 25G82 Root Patch because deeper Tahoe-specific Metal3802 assumptions remained.

## D97BH — exact local 25G82 MetallibSupportPkg runtime PASS
Exact Pyquick package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Installed tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

Because official Dortania manifest lacked Tahoe 26.x, b9df76 initially attempted remote selection. Temporarily forcing manifest failure proved runtime local fallback:
- checks loose `26.6`;
- finds exact `26.6.2-25G82`;
- Patcher becomes capable of patching.

Classification:
`D97BH_25G82_LOCAL_METALLIB_FALLBACK_RUNTIME=PASS`.

## D97BI — Tahoe Metal.framework donor blocker PROVEN
After Metallib PASS, Root Patch preflight failed looking for:
`Universal-Binaries/13.2.1-25/System/Library/Frameworks/Metal.framework`.

Exact b9df76 generated `13.2.1-{Darwin major}`; historical Tahoe work had already identified existing donor `13.2.1-24`.

Classification:
`B9DF76_TAHOE_25_METAL_FRAMEWORK_SOURCE_13_2_1_25=PROVEN_MISSING`.

## D97BJ — complete Tahoe 25G82 functional source delta
Exact b9df76 was prepared locally in Tahoe VESA with exactly three functional source files changed:
1. `opencore_legacy_patcher/support/metallib_handler.py`
2. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`

Functional effects:
- host max Sequoia -> Tahoe;
- Tahoe Metal.framework donor -> `13.2.1-24`;
- Tahoe-only exact 25G82 metallib map generated from Pyquick `sys_patch_dict.py` SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact local host-build MetallibSupportPkg preferred before API fallback.

Map size: 182 metallib entries.
Python syntax PASS.
DEBUG helper build PASS, SHA256 `a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

## D97BJ packaging lane
Current wxPython 4.3.1 resolved x86_64-only while exact b9df76 spec requested universal2; PyInstaller failed in COLLECT with an incompatible-arch error. This was classified as packaging/tooling only.

For Intel-only ASUS2, packaging target was bounded to x86_64. Resume v1 then stopped only because its expected diff omitted the intentionally compiled DEBUG helper tracked file; resume v2 corrected the audit to exactly five expected tracked changes: three functional source files + packaging spec + intentional debug helper binary.

## D97BJ — Tahoe 25G82 Root Patch runtime PASS
User subsequently executed D97BJ Root Patch in Tahoe VESA.

Runtime PASS evidence:
- exact local `26.6.2-25G82` Metallib found immediately and API skipped;
- Patcher capable of patching;
- Universal-Binaries mounted;
- preflight completed;
- Metal 3802 Common installed;
- Metal 3802 Common Extended installed with previous 13.2.1-25 blocker cleared;
- exact 25G82 metallib map executed, including `VisionKitCore.framework`;
- Monterey GVA installed;
- Monterey OpenCL installed;
- Intel Haswell driver set installed;
- Modern Wireless Common installed;
- GPUCompiler libraries merged;
- patchset metadata and RSR monitor installed;
- new Auxiliary Kernel Collection built and forced;
- root volume unmounted;
- final `Patching complete`.

No traceback or Root Patch failure appeared.

Classifications:
- `D97BJ_TAHOE_25G82_ROOT_PATCH_PREFLIGHT=PASS`;
- `D97BJ_TAHOE_25G82_EXACT_LOCAL_METALLIB_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_EXACT_METALLIB_MAP_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_HASWELL_PATCHSET_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_AUXKC_BUILD=PASS`;
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS`.

Accelerated GUI result remains `NOT_YET_TESTED`.

## CURRENT ACTION
Fully quit D97BJ inner OCLP, verify installed privileged helper has returned to exact official SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, then manually reboot into accelerated/root-patched Tahoe. If no usable image appears, recover through VESA and analyze only the immediately preceding accelerated diagnostic boot under the permanent VESA rule.
