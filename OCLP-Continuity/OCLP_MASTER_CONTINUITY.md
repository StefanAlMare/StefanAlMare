# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GV_D97GS_ARTIFACT_AUDIT_PASS_ASUS2_PREFLIGHT_NEXT.md`
- commit `72812a82b3a94bfe0dd42c55401834e97d237ffb`.

Immediate causal/build predecessors:
- D97GU exact D97DX source base restored + D97GS build PASS — checkpoint `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`;
- D97GT source-drift audit: four D97DX source sections exact; only DEBUG helper build artifact extra — checkpoint `3b44945d87ac96a0bfef4c5cd5e898d1f7d3407b`;
- D97GR exact historical P1 reconstruction PASS / current NULL-call causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GP original selector 31001 proven / 32023 compiler exports PASS / P1 missing — `eec9dfd358f77130bfe87510bd3fee97d163a412`;
- D97GN 12/12 MTLCompilerService NULL indirect-call frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress / MTLCompilerService crash-loop frontier — `b28469abf0363ab7f0877b63c22465c1694d41b6`;
- D97GH corrected Root Patch active-snapshot VESA PASS — `d05354c74e73917f93b5a9ff7a01b5755470687e`.

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

### Optional iGPU-property baseline
Keep OFF until usable accelerated image exists:
- `igfxfw=2`;
- `rps-control=1`;
- Enable Max Pixel Clock Override.

ACCEL1 at 23:39 used all three ON; ACCEL2 at 23:50 used all three OFF; the same MTLCompilerService crash occurred in both.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Historical compiler compatibility baseline / current replay rule
Historical accepted baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do **not** replay all five blindly. Patch only the earliest measured failed module. Current evidence justifies **P1 only**. P2b/P3/AIR00/D34 may return only if a later measured post-P1 frontier requires them.

D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave protected. D50/D68/D82 reserve-only; D84 retired.

Mandatory method:
- module-boundary + semantic evidence + far-frontier;
- binary search only inside failed module;
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
D97EZ maps only exact `0x224 -> 0x24`; all other modes passthrough; raw Apple return propagates. Corrected-payload ACCEL2 proved 58 successful calls: 20 adapted + 38 passthrough, zero failures. set_id_mode remains CLOSED PASS.

## Metallib defect and repair closure
D97FV/D97FW proved old local/installed 25G82 dynamic metallibs were systemically metadata stubs (`180/180`). Exact package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real package CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

D97FX reconstructed local source exact; D97GA removed old installed stubs by Restore; D97GB executed corrected Root Patch; D97GD proved patched System-volume 180/180 exact; D97GE closed Haswell AuxKC/userspace placement; D97GF/D97GH proved active booted snapshot contains all 180 exact real metallibs.

Classification: `CORRECTED_ROOTPATCH=STRUCTURAL_SEMANTIC_PASS_PRE_ACCELERATION`.

## D97GL / D97GM — metallib repair produced semantic progress
Authoritative accelerated boundaries:
- ACCEL1 start `2026-09-07 23:39` local;
- ACCEL2 start `23:50`;
- VESA recovery `23:52`.

Both corrected-payload accelerated windows proved old `validateWithDevice`/`MTLReportFailure` fatal signature absent, bad-bits absent, GPUPass still requested, and repeated MTLCompilerService deaths interrupt WindowServer XPC compilation. Metallib repair genuinely moved the fatal frontier.

## D97GN — exact current compiler crash
Twelve `.ips` reports across both accelerated sessions converge 12/12 on:
- MTLCompilerService 263.8;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS / SIGSEGV at address 0;
- RIP=0 / CR2=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, image offset `0x3448`.

Accepted D97M static map correlates this with exact `callq *0x8(%r14)` after resolution of `MTLCodeGenServiceCreate`.

## D97GP / D97GR — P1 missing proven and causally closed
Current service before P1:
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5` exact Golden original;
- selector at `0x3494`: `81fe19790000` = compare 31001;
- runtime selector/request = 32023.

Current MTLCompiler 32023:
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` exact Golden;
- all four required MTLCodeGenService exports present, 4/4 PASS.

D97GR disposable-copy reconstruction proved:
- unique preimage at `0x3494`;
- exact postimage `81fe177d0000` = compare 32023;
- exactly two byte changes at `0x3496/0x3497`;
- resulting SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` = exact historical P1/D97M;
- continuation to `/Versions/32023/MTLCompiler`, `cmovne`, `_dlopen` unchanged.

Classification: `CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

## D97GT / D97GU — Intel-iMac source-base closure
D97GT proved all four D97DX source sections byte-identical to exact embedded D97DX patch. Only extra tracked path was the intentional D97DX DEBUG helper build artifact SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`.

D97GU restored only that tracked helper path from HEAD with backup/hash guards and ended with exact four-file D97DX source diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`, `sys_patch.py` pristine.

Classification: `D97GU_D97DX_SOURCE_BASE=EXACT_RESTORED`.

## D97GS — P1-only build PASS
D97GS build on authorized Intel iMac:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner x86_64 executable SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- no Root Patch/system/EFI/NVRAM/framebuffer mutation/reboot during build.

## D97GV — independent D97GS artifact audit PASS
D97GV independently proved:
- exact D97GS ZIP identity;
- exact D97DX comparator/base provenance;
- DEBUG helper and launcher byte-identical to D97DX;
- inner executable exact + x86_64 + codesign PASS;
- exact D97DX base source patch retained;
- source sections: 4 base + 1 new;
- all four D97DX sections byte-identical;
- only new source section `sys_patch.py`;
- `sys_patch.py` zero removed lines, 83 added lines;
- exact P1 hook/build/model/pre-SHA/post-SHA/preimage/postimage/offset/two-byte-write guards each exactly once;
- P1 contract file PASS;
- no P2b/P3/AIR00/D34 replay.

Final classifications:
`D97GV_D97GS_ARTIFACT_IDENTITY=PASS`
`D97GV_D97DX_BASE_SECTIONS_EXACT=PASS`
`D97GV_P1_ONLY_SOURCE_DELTA=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97GV_STATUS=PASS_READONLY_AUDIT`.

D97GV audit ZIP SHA256 `5f4b96edcf719ed29779ef8b79e89b1d4066a7b51dfd964990dd428b37b3ae66`.

## CURRENT ACTION — D97GW ASUS2 read-only preflight
No Root Patch is authorized until D97GW passes. No accelerated boot is authorized.

Run only:
`OCLP-Continuity/artifacts/OCLP7_D97GW_ASUS2_PREFLIGHT_D97GS_P1_ONLY_ROOTPATCH.sh`

D97GW authority:
- commit `efd54accbfd4360b5e650f576a9cc43211b03315`;
- Git blob `7f7b4c9ca7ea8cb9e81d874fb4a76db42c7fd42f`.

D97GW must prove on ASUS2:
1. exact Tahoe 25G82 x86_64 + active VESA + D97EZ inert;
2. current active MTLCompilerService remains exact pre-P1 SHA `31a6f745...`;
3. corrected local MetallibSupportPkg remains valid, CoreDisplay exact `20739/b848.../MTLB`, 180 local metallibs, zero bad magic;
4. transferred D97GS ZIP exact SHA/bytes;
5. extracted wrapper/helper/inner/source identities exact and codesign PASS.

If and only if D97GW returns `D97GW_STATUS=PASS_READONLY_PREFLIGHT`, manual D97GS Root Patch may then be separately authorized. Even after Root Patch completes: DO NOT reboot until transcript + patched-volume audit are complete.
