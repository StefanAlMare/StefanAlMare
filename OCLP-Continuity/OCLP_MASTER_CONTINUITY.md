# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GW_ASUS2_PREFLIGHT_PASS_D97GS_P1_ONLY_ROOTPATCH_AUTHORIZED.md`
- commit `40fd4789f7ca430d54d475dce5d193ad19644430`.

Immediate predecessors:
- D97GV independent D97GS artifact audit PASS — `72812a82b3a94bfe0dd42c55401834e97d237ffb`;
- D97GU exact D97DX source base restored + D97GS build PASS — `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`;
- D97GT no source drift / DEBUG-helper build artifact only — `3b44945d87ac96a0bfef4c5cd5e898d1f7d3407b`;
- D97GR exact historical P1 reconstruction PASS / current NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GP service pre-P1 / 32023 compiler exports PASS — `eec9dfd358f77130bfe87510bd3fee97d163a412`;
- D97GN 12/12 MTLCompilerService NULL indirect-call frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress — `b28469abf0363ab7f0877b63c22465c1694d41b6`;
- D97GH corrected Root Patch active-snapshot VESA PASS — `d05354c74e73917f93b5a9ff7a01b5755470687e`.

## Current ASUS2 authority
- macOS Tahoe `26.6.2 / 25G82`, x86_64;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- currently in VESA recovery;
- bootargs retain active `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` and inert/commented `#-ocmcd97ez`;
- exact audited D97EZ/OCLPMetalCompat 0.0.12 remains in EFI;
- normal framebuffer baseline remains 3/3/3;
- corrected D97DX Root Patch is installed and boot-proven;
- active snapshot contains exact corrected `180/180` real metallibs, zero missing/different/stubs;
- active CoreDisplay metallib exact `20739` bytes, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, magic `MTLB`;
- Haswell AuxKC kexts load under VESA (`AppleIntelFramebufferAzul 18.0.8`, `AppleIntelHD5000Graphics 18.0.8`);
- D97EW persistent hard-recovery collector remains installed;
- optional iGPU properties remain OFF until usable accelerated image exists: `igfxfw=2`, `rps-control=1`, Enable Max Pixel Clock Override.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Current method / replay rule
Historical compiler baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do **not** replay all five blindly. Patch only the earliest measured failed module. Current evidence justifies **P1 only**. P2b/P3/AIR00/D34 may return only if a later measured post-P1 frontier requires them.

Evidence vocabulary: REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

Durable architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions:
- no legacy main Metal shadow / MetalOld;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no wholesale true-five replay without measured necessity;
- no global `set_id_mode` mask;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiments;
- Golden Sequoia immutable/read-only.

## Settled causal chain
### D97BV / D97DT
Selective true-3802 native-Metal ingress CLOSED PASS.

### D97EY -> D97FH / corrected ACCEL2
D97EZ exact `0x224 -> 0x24` adapter remains CLOSED PASS. Corrected ACCEL2 proved 58/58 set_id_mode calls successful: 20 adapted + 38 passthrough.

### Metallib defect and repair
D97FV/D97FW proved all 180 old local/installed dynamic metallibs were metadata stubs. Exact package SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay metallib: bytes `20739`, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, `MTLB`.

D97FX reconstructed the local source exact; D97GA removed old installed stubs; D97GB executed corrected D97DX Root Patch; D97GD/D97GE/D97GF/D97GH proved patched and active snapshot 180/180 exact plus Haswell AuxKC/userspace closure.

### D97GL / D97GM
Authoritative accelerated boundaries: ACCEL1 `23:39`, ACCEL2 `23:50`, VESA recovery `23:52` on 2026-09-07. After metallib repair, old `validateWithDevice` / `MTLReportFailure` fatal signature disappeared and the measured frontier moved to repeated MTLCompilerService crashes. Metallib repair = SEMANTIC PROVEN progress.

### D97GN
12/12 MTLCompilerService `.ips` converge on:
- version 263.8, UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS/SIGSEGV at address 0;
- RIP=0 / CR2=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, image offset `0x3448`.

Accepted D97M static map links `0x3448` to return from exact `callq *0x8(%r14)` after resolution of `MTLCodeGenServiceCreate`.

### D97GP / D97GR — P1 causal closure
Current service before P1:
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- selector `81fe19790000` = compare 31001 at `0x3494`;
- runtime selector = 32023.

Current MTLCompiler 32023 is exact Golden SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`; all four required MTLCodeGenService exports present.

D97GR proved exact historical P1 reconstruction:
- postimage `81fe177d0000` = compare 32023;
- only bytes `0x3496 19->17`, `0x3497 79->7d` change;
- resulting SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` exact historical P1/D97M.

Classification:
`CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

### D97GS / D97GV
D97GS P1-only build on Intel iMac:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`, bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner x86_64 executable SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- exact D97DX launcher/helper provenance retained;
- only new functional source section is additive `sys_patch.py` P1 hook;
- no P2b/P3/AIR00/D34 replay.

D97GV independent audit proved artifact identity PASS, all four D97DX base sections byte-identical, P1-only source delta STATIC-STRUCTURAL-SEMANTIC PROVEN.

### D97GW — live ASUS2 preflight PASS
Proven live on ASUS2:
- Tahoe 25G82 x86_64 / VESA / D97EZ inert PASS;
- current service exact pre-P1 SHA `31a6f745...`;
- corrected local CoreDisplay metallib exact `20739 / b848... / MTLB`;
- local metallib count `180`, bad-magic `0`;
- transferred D97GS ZIP exact SHA/bytes;
- launcher/inner/debug-helper/source identities exact;
- `D97GW_STATUS=PASS_READONLY_PREFLIGHT`.

## CURRENT ACTION — D97GS MANUAL P1-ONLY ROOT PATCH AUTHORIZED
Authorized now:
`D97GS_MANUAL_P1_ONLY_ROOT_PATCH_ON_ASUS2=YES`.

Use only the exact outer D97GS app validated by D97GW. Keep VESA bootargs unchanged. Run Root Patch manually. Require D97GS log showing exact P1 application and post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, followed by normal `Patching complete`. Close inner OCLP so outer wrapper restores official helper.

DO NOT reboot. DO NOT remove `-igfxvesa`. DO NOT activate D97EZ.

After Root Patch, run only:
`OCLP-Continuity/artifacts/OCLP7_D97GX_ASUS2_POST_ROOTPATCH_PRE_REBOOT_AUDIT.sh`
- commit `7004e8463541220f6b96950d879a6f29de49e77b`;
- blob `b57e84b7544afb787de9eaf7af904f71c2e895e7`.

D97GX must prove on the newly patched underlying System volume, read-only:
- exact P1 service SHA/postimage;
- patched metallibs 180/180 exact against corrected local source;
- exact CoreDisplay metallib;
- official privileged helper restored exact;
- current active snapshot still pre-P1 until reboot.

No reboot is authorized until D97GX PASS.
