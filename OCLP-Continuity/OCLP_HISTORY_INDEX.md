# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> current phase

Updated: 2026-09-08 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime/remediation checkpoint: `OCLP7_CHECKPOINT_20260908_D97HC_PRE_REBOOT_AUDIT_PASS_VESA_REBOOT_AUTHORIZED.md`.

Permanent database/rules and all incremental checkpoints remain authoritative for deep history. This index emphasizes accepted causal milestones and the current action.

## End goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable method / architecture
Historical compiler baseline: `P1 + P2b + P3 + AIR00 + D34`.
Current rule: never replay all five blindly; patch only the earliest measured failed module. P1 is now installed and must be measured at runtime before considering the later historical modules.

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
Current legacy MTLCompilerService:
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
Live ASUS2 preflight proved the exact D97GS ZIP transferred correctly and the corrected local metallib source was intact. The user then deliberately chose a cleaner sequence: Restore/Revert old D97DX first, reboot VESA, validate native base, then apply D97GS.

Checkpoint `40fd4789f7ca430d54d475dce5d193ad19644430`.

## D97GY first pass — clean System Restore, residual DEBUG helper
After Restore + VESA reboot, D97GY proved:
- native Tahoe service restored exact SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`, UUID/arches PASS;
- native CoreDisplay exact SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes `24128`, `MTLB`;
- Haswell AuxKC Data kexts removed;
- corrected local metallib source still 180/180 valid.

Manual helper audit found exact D97DX DEBUG helper still active:
- SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- ad-hoc, TeamIdentifier not set.

Classification: System/APFS restore PASS; overall gate partial only because helper state was residual.
Checkpoint `f0335052f6b8de8a1bd2c6b776b747f149d1b156`.

## D97GZ — exact official helper source locator PASS
D97GZ inspected the exact reused D97DX launcher and proved its original behavior:
- verify exact official helper;
- save temporary backup `/tmp/d97dx-official-helper.XXXXXX`;
- install DEBUG helper temporarily;
- restore exact official helper on exit/cleanup.

The temporary backup no longer existed, but D97GZ found two exact persistent official copies, both SHA+Team PASS:
1. `/Users/alex/Desktop/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`;
2. `/Library/Application Support/Dortania/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`.

Both:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`.

D97GZ read-only locator PASS. Checkpoint `741ddb3f82136f2df0b92b807786f6740a8d4124`.

## D97HA — official privileged helper restored PASS
D97HA used the persistent `/Library/Application Support/Dortania/OpenCore-Patcher.app/...` official helper source and modified only the active privileged helper.

Evidence:
- active DEBUG pre-SHA exact `993bf7e8...` PASS;
- official source SHA exact `9b74b7c9...`, Team `S74BDJXQMD`, codesign PASS;
- DEBUG helper backed up to Desktop;
- staged official helper SHA/Team/codesign PASS;
- atomic replacement PASS;
- active post SHA `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team `S74BDJXQMD`;
- stat `root:wheel -rwsr-xr-x 136816`;
- `D97HA_STATUS=PASS`;
- no reboot.

Checkpoint `132bba39a18c8658c8948b73b7776cc9510c46a5`.

## D97GY final rerun — post-Restore baseline fully PASS
Final D97GY rerun proved all gates simultaneously:
- VESA active / D97EZ inert PASS;
- native Tahoe service exact PASS;
- native CoreDisplay exact PASS;
- Haswell AuxKC removed PASS;
- corrected local metallib source 180/180 valid PASS;
- official helper exact SHA `9b74b7c9...`, Team `S74BDJXQMD` PASS.

Final classifications:
`D97GY_NATIVE_BASELINE=PASS`
`D97GY_RESTORE_REBOOT=STRUCTURAL_SEMANTIC_PASS`
`D97GY_D97GS_ROOTPATCH_BASE=READY`
`D97GY_STATUS=PASS_READONLY_POST_RESTORE_GATE`.

Checkpoint `dd4fcfd0b37f858b60c6c30ddcc1ba5b3645b63a`.

## D97GS manual Root Patch on clean base — PASS
The exact audited D97GS outer app was used. Root Patch transcript proves:
- exact local 25G82 MetallibSupportPkg selected;
- Metal 3802 Common / Common Extended installed;
- corrected `.metallibs` patchset installed;
- Monterey GVA/OpenCL installed;
- Intel Haswell installed;
- Modern Wireless Common installed;
- D97GS exact P1 selector bridge reached;
- exact historical P1 identity PASS SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- AuxKC rebuilt;
- `Patching complete` reached.

Classification:
`D97GS_P1_ROOTPATCH=PASS`.

## D97HB — tooling false negative after successful read-only mount
D97HB correctly proved before the stop:
- VESA active, D97EZ inert;
- active snapshot still native Tahoe service `4262e71f...`;
- active CoreDisplay native `daee638d... / 24128`;
- official helper exact `9b74b7c9... / S74BDJXQMD`;
- local metallib source still 180 exact;
- underlying System device `disk1s8` mounted read-only successfully.

It then failed only because the script invoked `/usr/bin/mount`, which does not exist on macOS. No Root Patch semantic failure was demonstrated.

Classification:
`D97HB_POST_MOUNT_RESULT=INCONCLUSIVE_TOOLING_FALSE_NEGATIVE`.
Checkpoint `c702ca47f20a036f2201799d05c1723441eb8a88`.

## D97HC — corrected pre-reboot audit PASS
D97HC replaced `/usr/bin/mount` with `/sbin/mount` and completed the full audit.

Active snapshot remained native as expected:
- service SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- CoreDisplay SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- CoreDisplay bytes 24128.

Underlying newly patched System volume read-only evidence:
- mount line explicitly `apfs, sealed, local, read-only, journaled, nobrowse`;
- exact P1 service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- bytes 85520;
- P1 postimage `81fe177d0000` at offset `0x3494` PASS;
- patched metallib exact 180;
- missing 0;
- different 0;
- patched CoreDisplay exact SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes 20739;
- MTLB magic;
- official helper exact and restored.

Final classifications:
`D97HC_STATUS=PASS_PRE_REBOOT_AUDIT`
`D97HC_ACTIVE_SNAPSHOT=NATIVE_TAHOE_UNCHANGED`
`D97HC_PATCHED_P1=STRUCTURAL_SEMANTIC_PASS_PRE_REBOOT`
`D97HC_PATCHED_METALLIBS=180_OF_180_EXACT`
`D97HC_OFFICIAL_HELPER=RESTORED_PASS`.

Checkpoint `c809157e3773a17a149a8cba322bde0fc724c5cb`.

## Current action — VESA reboot authorized, then D97HD active-snapshot audit
A single VESA reboot is authorized now.

Keep:
- `-igfxvesa` active;
- D97EZ inert/commented;
- framebuffer 3/3/3;
- optional `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override OFF;
- no EFI/NVRAM/framebuffer changes.

After reboot do not accelerate. Run D97HD read-only active-snapshot audit:
`OCLP7_D97HD_ASUS2_POST_VESA_REBOOT_ACTIVE_SNAPSHOT_AUDIT.sh`
- commit `43dc468dc82293eeb3b4daf1182eaee641715e68`.

D97HD must prove:
- active exact P1 service SHA `a8716ffd...` + P1 postimage;
- active corrected metallibs 180/180 exact;
- active CoreDisplay exact `b848d54e... / 20739 / MTLB`;
- Haswell Azul + HD5000 kexts installed and loaded;
- official helper exact;
- VESA still active and D97EZ still inert.

No accelerated boot is authorized until D97HD PASS.
