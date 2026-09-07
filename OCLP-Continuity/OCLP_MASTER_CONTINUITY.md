# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority and must be read after the permanent rules.

## Current authoritative checkpoints
Current runtime/remediation frontier:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GN_MTLCOMPILERSERVICE_NULL_INDIRECT_CALL_REGRESSION_D97GP_STATIC_GATE_READY.md`
- commit `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

Immediate predecessor checkpoints:
- D97GO optional iGPU-property baseline correction — commit `2d7df2ee45bad9de63ff2699feb876409727f252`;
- D97GM corrected-metallib semantic progress / MTLCompilerService crash-loop frontier — commit `b28469abf0363ab7f0877b63c22465c1694d41b6`;
- D97GL boot-boundary correction — commit `f23a00683792c5e000bba85c6cfd19ca2ed7d3c8`;
- D97GH corrected Root Patch active-snapshot VESA PASS — commit `d05354c74e73917f93b5a9ff7a01b5755470687e`;
- D97GE corrected Root Patch preboot STRUCTURAL-SEMANTIC PASS — commit `c89b84767823b8893578fff62084d10c9a889dcb`;
- D97GA Restore full PASS — commit `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, x86_64;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- currently back in VESA recovery;
- recovery boot args must retain active `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` and inert/commented `#-ocmcd97ez`;
- exact audited D97EZ/OCLPMetalCompat 0.0.12 remains in EFI;
- normal framebuffer baseline remains 3/3/3;
- corrected Root Patch is installed and boot-proven;
- active snapshot has exact corrected `180/180` metallibs, zero missing/different/stubs;
- active CoreDisplay metallib is exact `20739` bytes, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, magic `MTLB`;
- Haswell AuxKC Data kexts persist and loaded under VESA (`AppleIntelFramebufferAzul 18.0.8`, `AppleIntelHD5000Graphics 18.0.8`);
- official OCLP helper identity previously closed PASS;
- D97EW persistent hard-recovery collector remains installed.

### Current optional iGPU property baseline
Until Accelerated #1 the user had enabled:
- `igfxfw=2`;
- `rps-control=1`;
- Enable Max Pixel Clock Override.

For Accelerated #2 the user disabled all three. Future baseline keeps all three **OFF** until usable accelerated image exists. Do not reintroduce them without a measured reason.

This makes direct ACCEL1-vs-ACCEL2 attribution confounded, but does not invalidate metallib causal progress because old D97FJ and corrected-payload ACCEL1 both used the three optional properties ON while the fatal frontier changed.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Permanent functional baseline / method
Accepted functional baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

Meaning:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave remains protected. D50/D68/D82 reserve-only; D84 retired.

Mandatory method:
- module-boundary + semantic evidence + far-frontier;
- binary search only inside failed module;
- universal/no-PID coverage where requests vary;
- control-flow success is never semantic proof;
- evidence vocabulary: REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- no legacy main Metal shadow;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no true-five reapplication;
- no global `set_id_mode` mask;
- no semantic claim for bit `0x200` beyond measured evidence;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiments at the measured frontier;
- Golden Sequoia immutable/read-only.

## Settled runtime facts
### D97BV / D97DT
Selective true-3802 native-Metal ingress is CLOSED PASS on exact 25G82. D97FS later proved active-cache differences are exactly intentional D97BV SITE/CAVE runtime postimages, not corruption.

### D97EB / D97EE
Framebuffer 1/1/1 experiment CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

### D97EY -> D97FH / current ACCEL2
D97EZ maps only exact `0x224 -> 0x24`; every other mode passes untouched; Apple return propagates raw.
D97FH had already closed the old bad-bits blocker.
Corrected-payload Accelerated #2 re-proved a broader sample:
- set_id_mode calls `58`;
- exact224 seen/adapted/success `20/20/20`, fail `0`;
- other modes `38`, passthrough success `38`, fail `0`.
Thus set_id_mode remains CLOSED PASS.

## Old D97FJ / D97FT frontier
Before metallib repair, two WindowServer crashes converged on:
`CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline validation`.
D97FT statically mapped the GPUPass construction path and same bootstrap tuple/descriptor recipe as Golden.

## D97FV / D97FW systemic metallib defect
Pinned original MetallibSupportPkg:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- `MTLB`, contains GPUPass.

D97FW proved old local and installed dynamic metallibs were systemic metadata stubs: `180/180` invalid materializations.

## D97FX -> D97GH corrected materialization closure
- D97FX reconstructed local 25G82 metallib source exact from pinned package.
- D97FY final corrected-source preflight PASS.
- D97GA APFS Restore removed old installed stub layer.
- D97GB corrected D97DX Root Patch execution PASS.
- D97GD read-only patched System-volume audit: `180/180` exact, zero missing/different/stubs, CoreDisplay exact.
- D97GE corrected Haswell AuxKC placement/enrollment + userspace bundles + helper closed preboot STRUCTURAL-SEMANTIC PASS.
- D97GF/D97GH after VESA reboot proved the **active booted snapshot** contains all 180 exact real metallibs and Haswell kexts are loaded.

Classification:
`CORRECTED_ROOTPATCH=STRUCTURAL_SEMANTIC_PASS_PRE_ACCELERATION`.

## D97GL / D97GM — corrected metallibs produce semantic progress
User-authoritative accelerated boundaries:
- ACCEL1 start `2026-09-07 23:39` local;
- ACCEL2 start `23:50`;
- VESA recovery start `23:52`.

D97GL unified logs proved in both corrected-payload accelerated windows:
- old `validateWithDevice` fatal signature absent;
- `MTLReportFailure` absent;
- old surface bad-bits blocker absent;
- GPUPass path still requested;
- repeated `MTLCompilerService` death/restart interrupts WindowServer XPC compilation.

Therefore metallib correction produced real downstream semantic progress. The old D97FJ native-Metal validation abort is no longer the measured fatal frontier.

## D97GN — exact current MTLCompilerService fatal frontier
D97GN archive contains 12 MTLCompilerService `.ips` reports spanning both corrected-payload accelerated sessions.

All 12 are identical in the decisive fields:
- `MTLCompilerService` 263.8;
- slice UUID `3716d20f-b990-3906-b3e5-44e88ae63af8`;
- `EXC_BAD_ACCESS / SIGSEGV`;
- invalid address `0x0`;
- faulting `RIP=0`, `CR2=0`;
- `r15=32023`;
- first symbolized return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, imageOffset `13384 = 0x3448`;
- next frame `ctx(int)` block +35, imageOffset `0x33F1`.

Same crash occurs in both bootSessionUUIDs, so optional iGPU-property difference is not sufficient to explain it.

Previously accepted D97M static map correlates the exact frame with:
- `MTLConnectionCtx` calls `CompilerPluginInterface`;
- constructor `dlsym("MTLCodeGenServiceCreate")` and stores it at object offset `+0x8`;
- exact `0x100003444: callq *0x8(%r14)`;
- crash return address `0x100003448` = imageOffset `0x3448`.

Thus `RIP=0` is a NULL indirect-call at the codegen-create function pointer boundary.

The project archive from 2026-08-14 has the same `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature, proving this is a historical compiler-bridge regression class, not a novel framebuffer failure.

Current exact frontier:
`MTLCompilerService 263.8 -> selector 32023 -> MTLCompiler/Versions/32023 -> dlopen -> dlsym MTLCodeGenService* -> NULL +0x8 indirect call`.

UNKNOWN until D97GP:
- current service SHA/selector bytes vs accepted D97M selector-patched service;
- current MTLCompiler 32023 identity;
- whether the current compiler exports all four required MTLCodeGenService entrypoints;
- if exports exist, why dlsym is NULL.

## CURRENT ACTION — D97GP READ-ONLY STATIC GATE
No further accelerated boot is authorized now.
Remain in VESA recovery. No EFI/NVRAM/framebuffer/root changes.

Run only:
`OCLP-Continuity/artifacts/OCLP7_D97GP_READONLY_MTLCOMPILERSERVICE_CURRENT_IDENTITY_EXPORT_GATE.sh`

D97GP authority:
- commit `93fdfe90e6999f700b03e57167a16e8e1437cf01`;
- Git blob `adbcb989c97d5c1c2d33154a5377c9f954a2c581`.

D97GP is read-only and must not:
- launch MTLCompilerService;
- dlopen/execute MTLCompiler;
- compile anything;
- Root Patch/Restore;
- reboot;
- mutate EFI/NVRAM/framebuffer/system.

Classify D97GP before designing any remediation.
