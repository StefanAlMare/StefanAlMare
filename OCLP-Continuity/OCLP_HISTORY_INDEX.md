# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime/remediation checkpoint: `OCLP7_CHECKPOINT_20260908_D97GV_D97GS_ARTIFACT_AUDIT_PASS_ASUS2_PREFLIGHT_NEXT.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history. Older OCLP1–OCLP6 and early OCLP7 details remain in their original checkpoints; this index emphasizes the accepted causal chain and current frontier.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable method / architecture
Historical accepted compiler baseline: `P1 + P2b + P3 + AIR00 + D34`. D22 AIR 2.6 / Metal 3.1 semantic proof retained. D34 cave protected. D50/D68/D82 reserve-only; D84 retired.

Current rule: do not blindly replay historical true-five. Patch only the earliest measured failed module. Present measured failure justifies P1 only.

Architecture:
`Tahoe native Metal/Metal4 ABI -> bounded legacy compiler ingress -> measured adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Permanent prohibitions include no legacy main Metal shadow, no MetalOld, no global 32023 rewrite, no global forced-3802 path, no global set_id_mode mask, no unrelated boot-variable experiments, no automatic Root Patch/reboot. Golden Sequoia immutable/read-only.

## Early compiler-bridge history
Historical Tahoe work encountered the same startup compiler-bridge signature later rediscovered:
- MTLCompilerService 263.8;
- `RIP=0`;
- `r15=32023`;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Historical P1/P2b/P3/AIR00/D34 moved execution far into MTLCompiler, eventually into `MTLSimCompiler::validSimulatorMetadata`. That later path remains design evidence, not the current frontier.

## D97BV / D97DT — selective true-3802 closure
Selective true-3802 delivery CLOSED PASS. D97FS later proved active-cache differences exactly intentional D97BV SITE/CAVE runtime postimages.

## D97EB / D97EE — framebuffer experiment
1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

## D97EY -> D97FH — set_id_mode blocker closed
Exact rejection was `0x224` vs accepted `0x24`. D97EZ maps only exact `0x224 -> 0x24`, all others passthrough. D97FH proved 16/16 adapted + 4/4 passthrough successes; corrected-payload ACCEL2 later expanded to 58/58 total successes (20 adapted + 38 passthrough), zero failures.

## D97FI / D97FJ / D97FT — old CoreDisplay frontier
After set_id_mode closure, IntelAccelerator/framebuffer/display initialization progressed but WindowServer failed in `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` / native Metal validation. D97FT statically mapped GPUPass and found the mapped bootstrap tuple/descriptor recipe equivalent to Golden.

## D97FV / D97FW — systemic metallib materialization defect
Exact 25G82 MetallibSupportPkg:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

D97FW proved old local and installed dynamic metallibs were metadata stubs: 180/180 invalid materializations.

## D97FX / D97FY / D97GA -> D97GH — corrected metallib / Root Patch closure
D97FX reconstructed local 25G82 MetallibSupportPkg byte-for-byte. D97FY revalidated corrected source and D97DX provenance. D97GA Restore removed old installed stubs. D97GB executed corrected D97DX Root Patch. D97GD proved patched System volume 180/180 exact, zero missing/different/stubs, CoreDisplay exact. D97GE closed Haswell AuxKC/userspace placement. D97GF/D97GH proved the active booted VESA snapshot contains exact 180/180 real metallibs and loaded Haswell Azul/HD5000 kexts.

Classification: corrected Root Patch STRUCTURAL-SEMANTIC PASS pre-acceleration.

Key commits:
- D97GA `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`;
- D97GB `45480db8db7726a770e3deac1f2bbbfd6fda28b5`;
- D97GE `c89b84767823b8893578fff62084d10c9a889dcb`;
- D97GH `d05354c74e73917f93b5a9ff7a01b5755470687e`.

## D97GL / D97GM — corrected metallibs produce semantic progress
Authoritative accelerated boundaries:
- ACCEL1 `2026-09-07 23:39`;
- ACCEL2 `23:50`;
- VESA recovery `23:52`.

Both corrected-payload accelerated windows showed old `validateWithDevice`/`MTLReportFailure` fatal signature absent, old bad-bits failure absent, GPUPass still requested, and repeated MTLCompilerService deaths interrupting WindowServer compiler XPC.

Thus metallib repair genuinely moved the fatal frontier.
D97GM checkpoint `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## D97GO — optional iGPU baseline correction
User clarified:
- ACCEL1: `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override ON;
- ACCEL2: all three OFF;
- future baseline keeps all three OFF until image works.

Same compiler crash occurred under both configurations, so these properties are not sufficient to explain it.
Checkpoint `2d7df2ee45bad9de63ff2699feb876409727f252`.

## D97GN — exact MTLCompilerService NULL-call frontier
Twelve `.ips` reports spanning both accelerated sessions converge 12/12 on:
- MTLCompilerService 263.8;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS/SIGSEGV at address 0;
- RIP=0 / CR2=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, offset `0x3448`.

Accepted D97M static map links `0x3448` to return from exact `callq *0x8(%r14)`, the `MTLCodeGenServiceCreate` pointer. Historical 2026-08-14 evidence has the same signature.
Checkpoint `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

## D97GP — service is pre-P1; 32023 compiler itself PASS
Read-only audit proved current MTLCompilerService is exact Golden original:
- bytes `85520`;
- SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- selector at `0x3494`: `81fe19790000` = compare 31001;
- indirect call at `0x3444`: `41ff5608`.

Current MTLCompiler 32023:
- bytes `1636896`;
- SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` exact Golden;
- all four required `MTLCodeGenServiceCreate/Destroy/BuildRequest/SetPluginPath` exports present, 4/4 PASS.

Missing-export hypothesis NEGATIVE; current P1 selector bridge MISSING PROVEN.
Checkpoint `eec9dfd358f77130bfe87510bd3fee97d163a412`.

## D97GQ / D97GR — exact P1 reconstruction
D97GQ first stopped before semantic patching because `cp -p` attempted protected `chflags`; tooling false negative only.

D97GR disposable-copy reconstruction then proved:
- original SHA exact `31a6f745...`;
- preimage `81fe19790000` unique exactly at `0x3494`;
- postimage `81fe177d0000`;
- exactly two changed bytes: `0x3496 19->17`, `0x3497 79->7d`;
- patched SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact historical P1/D97M;
- disassembly selects `/Versions/32023/MTLCompiler` with following `cmovne` / `_dlopen` unchanged.

Classification:
`CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

D97GR checkpoint `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`.

## D97GT — Intel-iMac apparent source drift resolved
First D97GS build guard saw whole-worktree diff SHA mismatch. D97GT read-only audit proved:
- all four D97DX source sections exact byte-for-byte against embedded D97DX source patch;
- no source drift;
- only extra tracked file was D97DX DEBUG helper binary left by earlier build;
- that helper SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9` exactly matched known D97DX build artifact.

Classification: first D97GS stop was guard/tooling false negative, not source drift.
Checkpoint `3b44945d87ac96a0bfef4c5cd5e898d1f7d3407b`.

## D97GU — exact D97DX source base restored
D97GU backed up and restored only the tracked DEBUG helper binary to HEAD, with no global reset/checkout of source.

Before/after:
- exact four-source D97DX diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- DEBUG helper build artifact backed up exact SHA `993bf7e8...`;
- restored HEAD helper SHA `772d2246825f9f1c471007b1b9bf151e20cac8522911e3cb4705524543be55be`;
- tracked changes after exactly four D97DX source files;
- `sys_patch.py` pristine.

Classification: `D97GU_D97DX_SOURCE_BASE=EXACT_RESTORED`.

## D97GS — P1-only build PASS
Unchanged D97GS helper built from exact D97DX source base on authorized Intel iMac.

Source gate:
- pre-diff exact `c8b45d7f...` PASS;
- only new changed source file `sys_patch.py`;
- exact P1 build/model/pre-SHA/post-SHA/preimage/postimage/offset/hook contract PASS;
- no P2b/P3/AIR00/D34 replay.

Build identities:
- inner x86_64 executable SHA `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- exact D97DX template ZIP `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- exact D97DX DEBUG helper `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- exact D97DX base source patch `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- exact launcher `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`.

Final D97GS:
- ZIP SHA `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- P1 pre-SHA `31a6f745...`;
- P1 post-SHA `a8716ffd...`;
- no Root Patch/system/EFI/NVRAM/framebuffer mutation, no reboot.

Classification:
`D97GS_BUILD=PASS`
`D97GS_P1_ONLY_NEW_FUNCTIONAL_DELTA=PASS`.

Checkpoint `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`.

## D97GV — independent D97GS artifact audit PASS
D97GV on Intel iMac proved:
- D97GS ZIP SHA `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`, bytes `722879148` exact;
- D97DX comparator ZIP exact;
- D97GS/D97DX DEBUG helper exact same SHA `993bf7e8...`;
- D97GS retains exact D97DX base source patch `c8b45d7f...`;
- D97GS new source patch exact `cae9c340...`;
- inner executable exact SHA `5f4abff8...`, x86_64, codesign PASS;
- D97GS/D97DX launcher exact same SHA `344ea23b...`;
- source section count base 4 / D97GS 5;
- all four D97DX base sections byte-identical;
- only new source section is `sys_patch.py`;
- zero removed lines, 83 added lines in new `sys_patch.py` section;
- exact P1 hook/build/model/pre-SHA/post-SHA/preimage/postimage/offset/two-byte-write guards each exactly once;
- P1 contract file PASS;
- no P2b/P3/AIR00/D34 replay.

Final classifications:
`D97GV_D97GS_ARTIFACT_IDENTITY=PASS`
`D97GV_D97DX_BASE_SECTIONS_EXACT=PASS`
`D97GV_P1_ONLY_SOURCE_DELTA=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97GV_STATUS=PASS_READONLY_AUDIT`.

D97GV audit ZIP SHA `5f4b96edcf719ed29779ef8b79e89b1d4066a7b51dfd964990dd428b37b3ae66`.
Checkpoint `72812a82b3a94bfe0dd42c55401834e97d237ffb`.

## Current action — D97GW ASUS2 read-only preflight
No Root Patch and no accelerated boot authorized yet.

Run only on ASUS2:
`OCLP7_D97GW_ASUS2_PREFLIGHT_D97GS_P1_ONLY_ROOTPATCH.sh`
- commit `efd54accbfd4360b5e650f576a9cc43211b03315`;
- blob `7f7b4c9ca7ea8cb9e81d874fb4a76db42c7fd42f`.

D97GW must verify exact Tahoe 25G82/VESA/D97EZ-inert state, current pre-P1 service identity, corrected local 25G82 MetallibSupportPkg state, exact transferred D97GS ZIP SHA/bytes, extracted wrapper/helper/inner/source identities and codesign.

Only after `D97GW_STATUS=PASS_READONLY_PREFLIGHT` may manual D97GS Root Patch be separately authorized. After that Root Patch completes, DO NOT reboot until transcript and patched-volume audit are complete.
