# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime/remediation checkpoint: `OCLP7_CHECKPOINT_20260908_D97GS_P1_ONLY_BUILD_HELPER_READY_IMAC_BUILD_NEXT.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history. Older OCLP1–OCLP6 and early OCLP7 details are retained in their original checkpoints; this index emphasizes the accepted chain and current frontier.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`. D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave protected. D50/D68/D82 reserve-only; D84 retired. Golden Sequoia immutable/read-only.

Current methodology does not blindly replay the historical five. Patch only the earliest measured failed module; preserve downstream working donor semantics. Current measured failure justifies P1 only.

Durable architecture:
`Tahoe native Metal/Metal4 ABI -> bounded legacy compiler ingress -> measured adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

No legacy main Metal shadow, MetalOld, global 32023 rewrite, global forced-3802 path, unrelated boot-variable experiments, or automatic Root Patch/reboot.

## Early compiler-bridge history
The project previously encountered the same startup bridge class now seen again:
- MTLCompilerService 263.8;
- `RIP=0`;
- `r15=32023`;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Historical work established P1/P2b/P3/AIR00/D34 and moved execution far inside MTLCompiler, eventually into the `MTLSimCompiler::validSimulatorMetadata` region. That historical late path is design evidence, not the current frontier.

## D97BV / D97DT — selective true-3802 closure
Selective true-3802 delivery CLOSED PASS. D97FS later proved active-cache differences are exactly intentional D97BV SITE/CAVE runtime postimages.

## D97EB / D97EE — framebuffer experiment
1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

## D97EY -> D97FH — set_id_mode blocker closed
Exact rejection was `0x224` versus accepted `0x24`; D97EZ maps only exact `0x224 -> 0x24`, all other modes passthrough.
D97FH: 16/16 adapted + 4/4 passthrough successes.
Corrected-payload ACCEL2 later expanded this to 58 successes: 20 adapted + 38 passthrough, zero failures.

## D97FI / D97FJ / D97FT — old CoreDisplay fatal frontier
After set_id_mode closure, IntelAccelerator/framebuffer/display initialization progressed but WindowServer failed in `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` / native Metal validation.
D97FT statically mapped GPUPass and showed the bootstrap tuple/descriptor recipe matched Golden in the mapped scope.

## D97FV / D97FW — systemic metallib materialization defect
Pinned exact 25G82 MetallibSupportPkg:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

D97FW proved old local and installed dynamic metallibs were metadata stubs: 180/180 invalid materializations.

## D97FX / D97FY — corrected local source
D97FX reconstructed the local 25G82 MetallibSupportPkg tree byte-for-byte from the exact package. D97FY revalidated corrected source, exact D97DX app/helper/source and 182-entry patchdict closure.

## D97GA — APFS Restore full PASS
Restore removed old installed stub layer and restored native CoreDisplay. Official helper exact/codesign PASS. Corrected D97DX Root Patch authorized.
Checkpoint `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`.

## D97GB — corrected Root Patch execution PASS
Exact D97DX transcript proved corrected local 25G82 metallibs, bounded Metal3802 XPC/private compiler lanes, Monterey GVA/OpenCL, Intel Haswell patchset, AuxKC and userspace Haswell bundles installed successfully.
Checkpoint `45480db8db7726a770e3deac1f2bbbfd6fda28b5`.

## D97GC / D97GD — patched System-volume metallib proof
D97GC parser stop was tooling only. D97GD mounted the underlying System volume read-only and proved:
- exact metallibs 180;
- missing 0;
- different 0;
- metadata stubs 0;
- CoreDisplay exact `20739 / b848d54e... / MTLB`.

## D97GE — Haswell AuxKC closure
Proved Azul/HD5000 kexts in Data `/Library/Extensions`, `OSBundleRequired=Auxiliary`, exact AuxKC enrollment, Haswell userspace bundles on patched System volume, helper exact. Corrected Root Patch preboot STRUCTURAL-SEMANTIC PASS.
Checkpoint `c89b84767823b8893578fff62084d10c9a889dcb`.

## D97GF / D97GH — active-snapshot VESA PASS
After VESA reboot:
- active corrected metallibs 180/180 exact;
- zero missing/different/stubs;
- CoreDisplay exact;
- AuxKC paths persist;
- `AppleIntelFramebufferAzul 18.0.8` and `AppleIntelHD5000Graphics 18.0.8` loaded;
- official helper exact;
- D97EW collector running.
Corrected Root Patch STRUCTURAL-SEMANTIC PASS pre-acceleration.
Checkpoint `d05354c74e73917f93b5a9ff7a01b5755470687e`.

## D97GL — authoritative accelerated boundaries
User-authoritative:
- ACCEL1 start `2026-09-07 23:39`;
- ACCEL2 start `23:50`;
- recovery VESA `23:52`.
A 23:41 reboot occurred within ACCEL1 sequence and is not its start.
Boundary checkpoint `f23a00683792c5e000bba85c6cfd19ca2ed7d3c8`.

## D97GM — metallib correction produces semantic progress
Both corrected-payload accelerated windows showed:
- old `validateWithDevice` fatal signature absent;
- `MTLReportFailure` absent;
- bad-bits failure absent;
- GPUPass still requested;
- repeated MTLCompilerService crash/restart interrupts WindowServer compilation XPC.

Thus metallib repair genuinely moved the fatal frontier.
Checkpoint `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## D97GO — optional iGPU baseline correction
User clarified:
- ACCEL1: `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override ON;
- ACCEL2: all three OFF;
- future baseline keeps all three OFF until image works.

Same compiler crash occurred with both configurations, so those optional properties are not sufficient to explain the compiler crash.
Checkpoint `2d7df2ee45bad9de63ff2699feb876409727f252`.

## D97GN — exact MTLCompilerService NULL-call frontier
Twelve `.ips` reports, both accelerated sessions, converge 12/12 on:
- MTLCompilerService 263.8;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS/SIGSEGV at address 0;
- RIP=0 / CR2=0;
- r15=32023;
- first return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, offset `0x3448`.

Accepted D97M static map links `0x3448` to the return from exact `callq *0x8(%r14)`, the `MTLCodeGenServiceCreate` function pointer. Historical 2026-08-14 evidence has the same signature.
Checkpoint `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

## D97GP — current service is pre-P1; 32023 compiler itself PASS
Read-only audit proved:

MTLCompilerService:
- bytes `85520`;
- SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, exact Golden original;
- selector at `0x3494` is `81fe19790000` = compare 31001;
- exact indirect call at `0x3444` remains `41ff5608`.

MTLCompiler 32023:
- bytes `1636896`;
- SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, exact Golden;
- all four `MTLCodeGenServiceCreate/Destroy/BuildRequest/SetPluginPath` exports present, 4/4 PASS.

Therefore missing-export hypothesis is NEGATIVE and current P1 selector bridge is MISSING PROVEN.
Checkpoint `eec9dfd358f77130bfe87510bd3fee97d163a412`.

## D97GQ — copy-flags tooling false negative
First copy-only reconstruction used `cp -p`; protected SSV flags caused `chflags ... Operation not permitted` before semantic patching. No system mutation. Superseded by D97GR.
Checkpoint `c8a80478b56038785999584c570850e19460b689`.

## D97GR — P1 exact historical reconstruction PASS
On a disposable byte-identical copy:
- original SHA exact `31a6f745...`;
- preimage `81fe19790000` unique exactly at `0x3494`;
- postimage `81fe177d0000`;
- exactly two changed bytes: `0x3496 19->17`, `0x3497 79->7d`;
- patched SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact historical P1/D97M identity;
- disassembly selects `/Versions/32023/MTLCompiler` and preserves following `cmovne` / `_dlopen` continuation.

Classification:
`CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

Checkpoint `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`.

## D97GS — P1-only integration/build stage
Do not replay P2b/P3/AIR00/D34 yet. Current measured module requires P1 only.

D97GS design:
- exact D97DX source/base reused;
- only new source file delta is `sys_patch.py`;
- P1 hook executes after all patchset installs and before root rebuild/snapshot;
- exact build 25G82 + model MacBookAir6,2 guards;
- exact pre-SHA + unique preimage guard;
- writes only the two proven bytes;
- exact postimage and historical P1 SHA required;
- aborts before snapshot on mismatch;
- patchdict/metallib logic unchanged;
- no new P2b/P3/AIR00/D34;
- exact D97DX launcher/debug-helper wrapper provenance reused.

Build helper:
`OCLP7_D97GS_IMAC_BUILD_P1_ONLY_FROM_D97DX.sh`
- commit `8f86bfa76282b3b1c5b9aca311e95324406224d5`;
- blob `b408d8d372ca6956db0caeb2a253df44acd7a5b9`.

Build-ready checkpoint:
`b41a9a6be41bd1ec563c4e8d13134e92b95f249c`.

## Current action
1. Run D97GS build helper on explicitly authorized home Intel iMac only.
2. Return complete build report and D97GS ZIP identity.
3. Audit source diff and artifact independently.
4. Do not yet Root Patch ASUS2.
5. No accelerated boot authorized.
