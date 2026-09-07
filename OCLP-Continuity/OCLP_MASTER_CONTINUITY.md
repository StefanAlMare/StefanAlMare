# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority and must be read after the permanent rules.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GU_BASE_RESTORED_D97GS_BUILD_PASS_D97GV_AUDIT_READY.md`
- commit `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`.

Immediate causal/build predecessors:
- D97GT source-drift audit: four D97DX source sections exact; only DEBUG helper build artifact extra — checkpoint `3b44945d87ac96a0bfef4c5cd5e898d1f7d3407b`;
- D97GR exact historical P1 reconstruction PASS / current NULL-call causally closed — commit `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GP original selector 31001 proven / 32023 compiler exports PASS / P1 missing — commit `eec9dfd358f77130bfe87510bd3fee97d163a412`;
- D97GN 12/12 MTLCompilerService NULL indirect-call frontier — commit `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress / MTLCompilerService crash-loop frontier — commit `b28469abf0363ab7f0877b63c22465c1694d41b6`;
- D97GH corrected Root Patch active-snapshot VESA PASS — commit `d05354c74e73917f93b5a9ff7a01b5755470687e`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, x86_64;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- currently in VESA recovery;
- recovery boot args retain active `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` and inert/commented `#-ocmcd97ez`;
- exact audited D97EZ/OCLPMetalCompat 0.0.12 remains in EFI;
- normal framebuffer baseline remains 3/3/3;
- corrected D97DX Root Patch is installed and boot-proven;
- active snapshot contains exact corrected `180/180` real metallibs, zero missing/different/stubs;
- active CoreDisplay metallib exact `20739` bytes, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, magic `MTLB`;
- Haswell AuxKC Data kexts persist and load under VESA (`AppleIntelFramebufferAzul 18.0.8`, `AppleIntelHD5000Graphics 18.0.8`);
- official OCLP helper identity previously closed PASS;
- D97EW persistent hard-recovery collector remains installed.

### Current optional iGPU-property baseline
Keep OFF until usable accelerated image exists:
- `igfxfw=2`;
- `rps-control=1`;
- Enable Max Pixel Clock Override.

History:
- ACCEL1 at 23:39 used all three ON;
- ACCEL2 at 23:50 used all three OFF;
- same MTLCompilerService crash occurred in both, so these properties do not explain the current compiler frontier.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Historical compiler compatibility baseline / current replay rule
Historically accepted baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Meaning:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave protected. D50/D68/D82 reserve-only; D84 retired.

Current rule: do **not** replay all five blindly. Patch only the earliest measured failed module. The present measured frontier justifies **P1 only**. P2b/P3/AIR00/D34 may be reintroduced only if a later measured post-P1 frontier requires them.

Mandatory method:
- module-boundary + semantic evidence + far-frontier;
- binary search only inside a failed module;
- universal/no-PID coverage where requests vary;
- control-flow success is never semantic proof;
- vocabulary: REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter(s) -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- no legacy main Metal shadow;
- no MetalOld;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no wholesale true-five replay without measured necessity;
- no global `set_id_mode` mask;
- no semantic claim for bit `0x200` beyond measured evidence;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiments at the measured frontier;
- Golden Sequoia immutable/read-only.

## Settled runtime facts
### D97BV / D97DT
Selective true-3802 native-Metal ingress CLOSED PASS on exact 25G82. D97FS proved active-cache differences are exactly intentional D97BV SITE/CAVE postimages, not corruption.

### D97EB / D97EE
Framebuffer 1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

### D97EY -> D97FH / corrected-payload ACCEL2
D97EZ maps only exact `0x224 -> 0x24`; all other modes pass untouched; raw Apple return propagates. Corrected-payload ACCEL2 proved 58 successful calls: 20 adapted + 38 passthrough, zero failures. set_id_mode remains CLOSED PASS.

## Metallib defect and repair closure
D97FV/D97FW proved old local/installed 25G82 dynamic metallibs were systemically metadata stubs (`180/180`). Exact package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real package CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

D97FX reconstructed local source exact; D97GA removed old installed stubs by Restore; D97GB executed corrected Root Patch; D97GD proved patched System-volume 180/180 exact; D97GE closed Haswell AuxKC/userspace placement; D97GF/D97GH proved the active booted snapshot contains all 180 exact real metallibs.

Classification:
`CORRECTED_ROOTPATCH=STRUCTURAL_SEMANTIC_PASS_PRE_ACCELERATION`.

## D97GL / D97GM — metallib repair produced semantic progress
Authoritative accelerated boundaries:
- ACCEL1 start `2026-09-07 23:39` local;
- ACCEL2 start `23:50`;
- VESA recovery `23:52`.

Both corrected-payload accelerated windows proved:
- old `validateWithDevice` fatal signature absent;
- `MTLReportFailure` absent;
- bad-bits failure absent;
- GPUPass still requested;
- repeated MTLCompilerService deaths interrupt WindowServer XPC compilation.

Thus metallib correction genuinely moved the fatal frontier.

## D97GN — exact current compiler crash
Twelve `.ips` reports across both corrected-payload accelerated sessions converge 12/12 on:
- MTLCompilerService 263.8;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS / SIGSEGV at address 0;
- RIP=0 / CR2=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, image offset `0x3448`.

Accepted D97M static map correlates this with exact `callq *0x8(%r14)` after resolution of `MTLCodeGenServiceCreate`.

## D97GP — P1 missing proven
Current MTLCompilerService:
- bytes `85520`;
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5` = exact Golden original;
- selector bytes at `0x3494`: `81fe19790000` = compare 31001;
- indirect call bytes at `0x3444`: `41ff5608`.

Current MTLCompiler 32023:
- bytes `1636896`;
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` = exact Golden;
- all four required `MTLCodeGenServiceCreate/Destroy/BuildRequest/SetPluginPath` exports present, 4/4 PASS.

Classification:
- missing-export hypothesis NEGATIVE;
- P1 selector bridge MISSING PROVEN;
- 32023 compiler identity/exports PASS.

## D97GR — exact P1 causal closure
Disposable-copy reconstruction proved:
- original service SHA exact;
- unique preimage `81fe19790000` only at `0x3494`;
- postimage `81fe177d0000` = compare 32023;
- exactly two changed bytes `0x3496 19->17`, `0x3497 79->7d`;
- resulting SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` = exact historical P1/D97M;
- continuation to `/Versions/32023/MTLCompiler`, `cmovne`, `_dlopen` unchanged.

Classification:
`D97GR_CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

This closes the current crash cause but does not prove downstream post-P1 runtime success.

## D97GT / D97GU — Intel-iMac source-base closure
D97GT proved no source drift:
- all four D97DX source sections byte-identical to exact embedded D97DX patch;
- only extra tracked path was the intentional D97DX DEBUG helper build artifact, exact SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`.

D97GU then restored only that one helper path from HEAD with backup and hash guards:
- four-source D97DX diff before/after exact SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- restored HEAD helper SHA `772d2246825f9f1c471007b1b9bf151e20cac8522911e3cb4705524543be55be`;
- tracked changes after exactly the four D97DX source files;
- `sys_patch.py` pristine.

Classification:
`D97GU_D97DX_SOURCE_BASE=EXACT_RESTORED`.

## D97GS — P1-only build PASS
D97GS was rebuilt unchanged on the authorized Intel iMac from the exact D97DX source base.

Source/build closure:
- D97DX pre-diff exact `c8b45d7f...` PASS;
- only new changed source file is `sys_patch.py`;
- P1 source guard contract PASS;
- no P2b/P3/AIR00/D34 replay;
- inner executable x86_64 SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`.

Wrapper provenance retained exact:
- D97DX ZIP `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- DEBUG helper `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- base D97DX source patch `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- launcher `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`.

Final D97GS:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- P1 pre-SHA `31a6f745...`;
- P1 post-SHA `a8716ffd...`;
- no Root Patch/system/EFI/NVRAM/framebuffer mutation and no reboot during build.

Classification:
`D97GS_BUILD=PASS`
`D97GS_P1_ONLY_NEW_FUNCTIONAL_DELTA=PASS`.

## CURRENT ACTION — D97GV independent artifact audit on Intel iMac
No ASUS2 Root Patch and no accelerated boot are authorized yet.

Run only:
`OCLP-Continuity/artifacts/OCLP7_D97GV_IMAC_AUDIT_D97GS_P1_ONLY_ARTIFACT.sh`

D97GV v2 authority:
- commit `ec349c174dcd0c6bbb4e1b7b7bab9ab64ca0fce7`;
- Git blob `253af01b4409e0495cf23febc41ec5a2ce41f7f0`.

D97GV must prove:
1. exact D97GS ZIP SHA/bytes;
2. exact D97DX base ZIP provenance;
3. exact DEBUG helper + launcher identities retained;
4. exact D97GS inner executable identity, x86_64 arch, codesign;
5. exact D97DX base patch retained in D97GS;
6. all four D97DX source-diff sections byte-identical inside D97GS source diff;
7. only new source section is additive `sys_patch.py` P1 hook;
8. exact build/model/pre-SHA/post-SHA/offset/two-byte-write guard contract;
9. no P2b/P3/AIR00/D34 replay and no new legacy main-Metal shadow.

Only after D97GV PASS may ASUS2 P1-only Root Patch be considered/authorized.