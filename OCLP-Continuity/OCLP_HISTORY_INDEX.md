# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime/remediation checkpoint: `OCLP7_CHECKPOINT_20260908_D97GW_ASUS2_PREFLIGHT_PASS_D97GS_P1_ONLY_ROOTPATCH_AUTHORIZED.md`.

Permanent database/rules and all incremental checkpoints remain authoritative for deep history. This index emphasizes accepted causal milestones and the current action.

## End goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable method / architecture
Historical compiler baseline: `P1 + P2b + P3 + AIR00 + D34`.
Current rule: never replay all five blindly; patch only the earliest measured failed module. Current evidence justifies P1 only.

Architecture:
`Tahoe native Metal/Metal4 ABI -> bounded legacy compiler ingress -> measured adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Golden Sequoia immutable/read-only. No legacy main Metal shadow/MetalOld, no global 32023 rewrite, no global forced-3802 path, no global set_id_mode mask, no unrelated boot-variable experiments, no automatic Root Patch/reboot.

## Early compiler-bridge history
Historical Tahoe work encountered the same startup signature later rediscovered:
- MTLCompilerService 263.8;
- `RIP=0`;
- `r15=32023`;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`.

Historical P1/P2b/P3/AIR00/D34 moved execution far inside MTLCompiler, eventually into `MTLSimCompiler::validSimulatorMetadata`. That late path is retained as design evidence, not current authority.

## D97BV / D97DT — selective true-3802 ingress
Selective true-3802 delivery CLOSED PASS.

## D97EB / D97EE — framebuffer experiment
1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

## D97EY -> D97FH — set_id_mode blocker closed
D97EZ maps only exact `0x224 -> 0x24`, all other modes passthrough. D97FH proved 16/16 adapted + 4/4 passthrough successes; corrected ACCEL2 later expanded to 58/58 successes (20 adapted + 38 passthrough), zero failures.

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
D97FX reconstructed local 25G82 MetallibSupportPkg exact. D97GA Restore removed old installed stubs. D97GB executed corrected D97DX Root Patch. D97GD proved patched System volume 180/180 exact. D97GE closed Haswell AuxKC/userspace placement. D97GF/D97GH proved active booted VESA snapshot contains exact 180/180 real metallibs and loaded Haswell Azul/HD5000 kexts.

Key commits:
- D97GA `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`;
- D97GB `45480db8db7726a770e3deac1f2bbbfd6fda28b5`;
- D97GE `c89b84767823b8893578fff62084d10c9a889dcb`;
- D97GH `d05354c74e73917f93b5a9ff7a01b5755470687e`.

## D97GL / D97GM — corrected metallibs produce semantic progress
Authoritative boot boundaries:
- ACCEL1 `2026-09-07 23:39`;
- ACCEL2 `23:50`;
- VESA recovery `23:52`.

Both corrected-payload accelerated windows showed old `validateWithDevice` / `MTLReportFailure` fatal signature absent, bad-bits absent, GPUPass still requested, and repeated MTLCompilerService deaths interrupting WindowServer compiler XPC.

Thus metallib repair genuinely moved the fatal frontier.
Checkpoint `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## D97GO — optional iGPU baseline correction
ACCEL1 used `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override ON. ACCEL2 used all three OFF. Same compiler crash occurred in both. Future baseline keeps all three OFF until image works.

## D97GN — exact MTLCompilerService NULL-call frontier
Twelve `.ips` reports spanning both accelerated sessions converge 12/12 on:
- MTLCompilerService 263.8;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS/SIGSEGV at address 0;
- RIP=0 / CR2=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, offset `0x3448`.

Accepted D97M static map links `0x3448` to return from exact `callq *0x8(%r14)`, the `MTLCodeGenServiceCreate` pointer.
Checkpoint `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

## D97GP — service is pre-P1; 32023 compiler PASS
Current MTLCompilerService:
- bytes `85520`;
- SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- selector `81fe19790000` = compare 31001 at `0x3494`;
- indirect call `41ff5608` at `0x3444`.

Current MTLCompiler 32023:
- SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` exact Golden;
- all four required MTLCodeGenService exports present, 4/4 PASS.

Missing-export hypothesis NEGATIVE; P1 selector bridge MISSING PROVEN.
Checkpoint `eec9dfd358f77130bfe87510bd3fee97d163a412`.

## D97GQ / D97GR — exact P1 reconstruction
D97GQ stopped only on `cp -p` protected chflags; tooling false negative.

D97GR proved on a disposable copy:
- original SHA exact `31a6f745...`;
- preimage `81fe19790000` unique at `0x3494`;
- postimage `81fe177d0000`;
- exactly two changed bytes `0x3496 19->17`, `0x3497 79->7d`;
- patched SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact historical P1/D97M;
- continuation to `/Versions/32023/MTLCompiler`, `cmovne`, `_dlopen` unchanged.

Classification:
`CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.
Checkpoint `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`.

## D97GT / D97GU — Intel-iMac source-base closure
D97GT proved all four D97DX source sections byte-identical; the only extra tracked file was the intentional D97DX DEBUG helper build artifact. D97GU restored only that one path from HEAD with backup/hash guards, leaving exact four-file D97DX source diff and pristine `sys_patch.py`.

Checkpoint `3b44945d87ac96a0bfef4c5cd5e898d1f7d3407b`.

## D97GS — P1-only build PASS
D97GS built on authorized Intel iMac from exact D97DX source base:
- ZIP SHA `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner x86_64 SHA `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- exact D97DX launcher/helper/base-source provenance retained;
- only new functional source section is additive `sys_patch.py` P1 hook;
- no P2b/P3/AIR00/D34 replay.

Checkpoint `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`.

## D97GV — independent artifact audit PASS
D97GV independently proved exact D97GS artifact identity, exact D97DX base sections 4/4, x86_64/codesign, wrapper/helper provenance, one additive `sys_patch.py` P1 section, exact P1 guard contract, and no P2b/P3/AIR00/D34 replay.

Final:
`D97GV_D97GS_ARTIFACT_IDENTITY=PASS`
`D97GV_D97DX_BASE_SECTIONS_EXACT=PASS`
`D97GV_P1_ONLY_SOURCE_DELTA=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

Checkpoint `72812a82b3a94bfe0dd42c55401834e97d237ffb`.

## D97GW — live ASUS2 preflight PASS
Live ASUS2 preflight proved:
- Tahoe 25G82 x86_64 / VESA / D97EZ inert PASS;
- current service exact pre-P1 SHA `31a6f745...`;
- corrected local CoreDisplay exact `20739 / b848... / MTLB`;
- local metallib count 180, bad magic 0;
- transferred D97GS ZIP exact SHA/bytes;
- extracted launcher/inner/debug-helper/source identities exact;
- `D97GW_STATUS=PASS_READONLY_PREFLIGHT`.

Checkpoint `40fd4789f7ca430d54d475dce5d193ad19644430`.

## Current action — D97GS manual P1-only Root Patch authorized
Authorized now on ASUS2:
`D97GS_MANUAL_P1_ONLY_ROOT_PATCH_ON_ASUS2=YES`.

Keep VESA bootargs unchanged. Use only exact outer D97GS app validated by D97GW. Require log showing exact P1 application/post-SHA and normal `Patching complete`. Close inner OCLP so outer wrapper restores official helper.

DO NOT reboot. DO NOT remove `-igfxvesa`. DO NOT activate D97EZ.

After Root Patch, run read-only D97GX:
`OCLP7_D97GX_ASUS2_POST_ROOTPATCH_PRE_REBOOT_AUDIT.sh`
- commit `7004e8463541220f6b96950d879a6f29de49e77b`;
- blob `b57e84b7544afb787de9eaf7af904f71c2e895e7`.

D97GX must prove exact P1 service on newly patched underlying System volume, 180/180 corrected metallibs, exact CoreDisplay, official helper restored, while active current snapshot remains pre-P1 until reboot.

No reboot authorized until D97GX PASS.
