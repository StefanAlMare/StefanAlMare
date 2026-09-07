# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime checkpoint: `OCLP7_CHECKPOINT_20260908_D97GN_MTLCOMPILERSERVICE_NULL_INDIRECT_CALL_REGRESSION_D97GP_STATIC_GATE_READY.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history. Older OCLP1–OCLP6 and early OCLP7 details are retained in their original checkpoints; this index emphasizes the accepted chain and current frontier.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`. D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave protected. D50/D68/D82 reserve-only; D84 retired. Golden Sequoia immutable/read-only. Permanent method: module-boundary + semantic evidence + far-frontier; binary search only inside failed module; control-flow success is not semantic proof.

## Early accepted compiler-bridge history
The project previously encountered and solved a legacy `MTLCompilerService 263.8` startup/compiler-bridge class on Tahoe. Historical archive `Tahoe-25G82-MTLBridge-AccelCrash-20260814-111243.txt` contains a characteristic crash:
- `RIP=0`;
- `r15=32023`;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Subsequent project work established the accepted compiler bridge chain P1/P2b/P3/AIR00/D34 and progressed far inside MTLCompiler before the later OCLP7 native-Metal/Haswell integration work.

## D97BV / D97DT — selective true-3802 closure
Selective true-3802 delivery CLOSED PASS. D97FS later mapped active-cache differences exactly to intentional D97BV runtime SITE/CAVE postimages.

## D97EB / D97EE — framebuffer experiment
1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

## D97EY -> D97FH — set_id_mode blocker closed
Exact measured rejection was `0x224` versus accepted `0x24`; D97EZ maps only exact `0x224 -> 0x24` and passes all other modes untouched.
D97FH ACTIVE run proved 16/16 adapted + 4/4 passthrough successes, zero failures.
Corrected-payload ACCEL2 later expanded this to 58 successful calls: 20 adapted + 38 passthrough, zero failures.

## D97FI / D97FJ — old downstream CoreDisplay fatal frontier
After set_id_mode closure, IntelAccelerator/framebuffer/display initialization progressed but WindowServer still failed.
Two D97FJ `.ips` reports converged on `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` and native Metal render-pipeline validation.

## D97FT — exact GPUPass static map
Static mapping proved GPUPass specialization/render-pipeline construction and the same bootstrap tuple/descriptor recipe in working Golden. The exact underlying Metal validation predicate remained UNKNOWN.

## D97FV / D97FW — systemic metallib materialization failure
Pinned `MetallibSupportPkg-26.6.2-25G82.pkg`:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay `default.metallib`:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

D97FW proved old local and installed dynamic metallibs were metadata stubs: real regular targets `180`, old local exact `0` / stubs `180`, old installed exact `0` / stubs `180`.

## D97FX / D97FY — corrected source reconstruction
D97FX reconstructed the local 25G82 MetallibSupportPkg source tree byte-for-byte from the pinned original package, proving `180/180` real metallibs and exact CoreDisplay.
D97FY final pre-remediation gate revalidated corrected source plus exact D97DX wrapper/helper/source and patchdict closure.

## D97GA — APFS Restore full PASS
After Restore and corrected VESA reboot:
- old metadata-stub layer removed;
- native CoreDisplay restored;
- unique QuartzCore non-direct-MTLB target proved valid fat Mach-O Metal library container;
- official helper exact/codesign PASS.
Corrected D97DX Root Patch authorized.
Checkpoint commit `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`.

## D97GB — corrected Root Patch execution PASS
Exact D97DX transcript proved corrected Root Patch completion:
- exact local 25G82 MetallibSupportPkg selected;
- Metal 3802 Common/Extended/.metallibs installed;
- CoreDisplay overwritten with corrected payload;
- Monterey GVA/OpenCL installed;
- Intel Haswell patchset installed;
- AuxKC support added for Azul/HD5000;
- userspace Haswell GL/MTL/VA bundles installed;
- AuxKC built; patching complete without error.
Checkpoint commit `45480db8db7726a770e3deac1f2bbbfd6fda28b5`.

## D97GC / D97GD — patched System-volume metallib proof
D97GC stopped only on snapshot-device parser false negative. D97GD corrected it and mounted underlying System volume read-only.
D97GD proved:
- corrected dynamic metallibs exact `180`;
- missing `0`;
- different `0`;
- metadata stubs `0`;
- CoreDisplay `20739` bytes / SHA `b848d54e...` / `MTLB`.

D97GD's later Haswell-kext check was a false assumption because Ventura+ AuxKC redirects these `.kext`s to Data `/Library/Extensions`.

## D97GE — Haswell AuxKC closure / corrected Root Patch preboot PASS
Proved:
- AppleIntelFramebufferAzul and AppleIntelHD5000Graphics present in `/Library/Extensions`;
- correct bundle IDs;
- `OSBundleRequired=Auxiliary`;
- both exact paths in AuxKC build instructions;
- Haswell userspace bundles present on patched System volume;
- official helper exact.
Classification: corrected Root Patch preboot STRUCTURAL-SEMANTIC PASS.
Checkpoint commit `c89b84767823b8893578fff62084d10c9a889dcb`.

## D97GF / D97GH — active-snapshot VESA PASS
After VESA reboot, active snapshot proved:
- `180/180` corrected metallibs exact;
- zero missing/different/stubs;
- CoreDisplay exact `20739 / b848d54e... / MTLB`;
- AuxKC paths persistent;
- `AppleIntelFramebufferAzul 18.0.8` and `AppleIntelHD5000Graphics 18.0.8` loaded.
Direct helper/collector gate closed official helper identity and D97EW running state.
Classification: corrected Root Patch STRUCTURAL-SEMANTIC PASS pre-acceleration.
Checkpoint commit `d05354c74e73917f93b5a9ff7a01b5755470687e`.

## D97GL — exact accelerated boot boundaries
User-authoritative boundaries:
- ACCEL1 reboot start `2026-09-07 23:39` local;
- ACCEL2 reboot start `23:50`;
- recovery VESA reboot `23:52`.
A 23:41 reboot occurred inside ACCEL1 sequence and is not the start boundary.
D97GL helper commit `d90195836c860996a4abf5ce5aabe6b3f16ad653`.
Boundary correction checkpoint commit `f23a00683792c5e000bba85c6cfd19ca2ed7d3c8`.

## D97GM — metallib correction produces semantic progress
D97GL unified-log analysis of both accelerated windows proved:
- old `validateWithDevice` fatal signature absent;
- `MTLReportFailure` absent;
- surface bad-bits failure absent;
- GPUPass still requested;
- repeated MTLCompilerService crashes interrupt WindowServer compiler XPC.

Thus the real metallib correction changed the measured fatal frontier and produced semantic progress. Old D97FJ validation-abort frontier is no longer current.
Checkpoint commit `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## D97GO — optional iGPU property baseline correction
User clarified:
- ACCEL1: `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override ON;
- ACCEL2: all three OFF;
- future baseline keeps all three OFF until accelerated image works.

Therefore ACCEL1-vs-ACCEL2 is confounded by these property changes. However the new MTLCompilerService crash occurs in both configurations and cannot be explained solely by them. Comparison of old D97FJ with corrected-payload ACCEL1 remains useful because those optional properties were ON in both while the fatal frontier changed.
Checkpoint commit `2d7df2ee45bad9de63ff2699feb876409727f252`.

## D97GN — exact MTLCompilerService NULL indirect-call frontier
D97GN collection returned 12 `.ips` reports spanning both accelerated boot sessions.
Every report converges on:
- MTLCompilerService version `263.8`;
- slice UUID `3716d20f-b990-3906-b3e5-44e88ae63af8`;
- `EXC_BAD_ACCESS / SIGSEGV`;
- invalid address `0x0`;
- faulting `RIP=0`, `CR2=0`;
- `r15=32023`;
- first symbolized return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, imageOffset `0x3448`;
- next frame `ctx(int)` block +35, imageOffset `0x33F1`.

Both bootSessionUUIDs show the same signature.

Previously accepted D97M static map explains the exact null-call site:
- `MTLConnectionCtx` calls `CompilerPluginInterface`;
- plugin constructor chooses compiler path from selector;
- for selector 32023 it chooses `MTLCompiler.framework/Versions/32023/MTLCompiler`;
- it `dlsym`s `MTLCodeGenServiceCreate` to object offset `+0x8`, Destroy to `+0x10`, BuildRequest to `+0x18`, SetPluginPath to `+0x20`;
- it checks only `dlopen`, not individual dlsym results;
- exact `0x100003444: callq *0x8(%r14)` immediately calls the Create pointer;
- crash return address `0x100003448` matches imageOffset `0x3448` while `RIP=0`.

Historical 2026-08-14 project evidence has the same `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature. Current failure is therefore a regression to a previously encountered compiler-bridge boundary rather than a new framebuffer failure.

Classification:
- D97GN crash signature SEMANTIC PROVEN;
- exact NULL indirect-call site STATIC-MAPPED PROVEN;
- reason the pointer is NULL remains UNKNOWN pending current on-disk identity/export audit.

Checkpoint commit `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

## Current action — D97GP static gate
No accelerated boot authorized.
Remain VESA; do not change EFI/NVRAM/framebuffer/root.

Run read-only helper:
`OCLP7_D97GP_READONLY_MTLCOMPILERSERVICE_CURRENT_IDENTITY_EXPORT_GATE.sh`
- commit `93fdfe90e6999f700b03e57167a16e8e1437cf01`;
- blob `adbcb989c97d5c1c2d33154a5377c9f954a2c581`.

D97GP asks only:
1. does current MTLCompilerService match the accepted D97M selector-patched identity/bytes?
2. what is current MTLCompiler 32023 identity?
3. does it statically export all four required `MTLCodeGenService*` symbols?
4. if not, identify the missing export boundary before any remediation.

No service launch, no dlopen execution, no compilation, no Root Patch, no reboot.
