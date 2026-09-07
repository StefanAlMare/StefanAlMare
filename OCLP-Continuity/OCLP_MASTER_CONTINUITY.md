# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority and must be read after the permanent rules.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GS_P1_ONLY_BUILD_HELPER_READY_IMAC_BUILD_NEXT.md`
- commit `b41a9a6be41bd1ec563c4e8d13134e92b95f249c`.

Immediate causal predecessors:
- D97GR exact historical P1 reconstruction PASS / current NULL-call causally closed — commit `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GP original selector 31001 proven / 32023 compiler exports PASS / P1 missing — commit `eec9dfd358f77130bfe87510bd3fee97d163a412`;
- D97GN 12/12 MTLCompilerService NULL indirect-call frontier — commit `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GO optional iGPU-property baseline correction — commit `2d7df2ee45bad9de63ff2699feb876409727f252`;
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
- active CoreDisplay metallib is exact `20739` bytes, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, magic `MTLB`;
- Haswell AuxKC Data kexts persist and load under VESA (`AppleIntelFramebufferAzul 18.0.8`, `AppleIntelHD5000Graphics 18.0.8`);
- official OCLP helper identity previously closed PASS;
- D97EW persistent hard-recovery collector remains installed.

### Current optional iGPU property baseline
Keep OFF until usable accelerated image exists:
- `igfxfw=2`;
- `rps-control=1`;
- Enable Max Pixel Clock Override.

History:
- ACCEL1 at 23:39 used all three ON;
- ACCEL2 at 23:50 used all three OFF;
- same MTLCompilerService crash occurred in both, so these properties do not explain the current compiler frontier.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Permanent functional baseline / method
Historically accepted compiler compatibility baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Meaning:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave remains protected. D50/D68/D82 reserve-only; D84 retired.

Important current rule: do **not** replay all five blindly. Apply only the adapter required by the measured failed module. D97GR currently justifies P1 only. P2b/P3/AIR00/D34 may be reintroduced only if a later measured frontier requires them.

Mandatory method:
- module-boundary + semantic evidence + far-frontier;
- binary search only inside a failed module;
- universal/no-PID coverage where requests vary;
- control-flow success is never semantic proof;
- evidence vocabulary: REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

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
Selective true-3802 native-Metal ingress CLOSED PASS on exact 25G82. D97FS later proved active-cache differences are exactly intentional D97BV SITE/CAVE postimages, not corruption.

### D97EB / D97EE
Framebuffer 1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

### D97EY -> D97FH / corrected-payload ACCEL2
D97EZ maps only exact `0x224 -> 0x24`; all other modes pass untouched; raw Apple return propagates.
Corrected-payload ACCEL2 expanded runtime proof to:
- calls 58;
- exact224 seen/adapted/success `20/20/20`, fail 0;
- other 38, passthrough success 38, fail 0.
Thus set_id_mode remains CLOSED PASS.

## Metallib defect and repair closure
D97FV/D97FW proved the old local/installed 25G82 metallib layer was systemically materialized as metadata stubs (`180/180`). Real package CoreDisplay metallib:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdbca60eca1078226ded4bc92d`;
- direct `MTLB`, contains GPUPass.

Exact pinned package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

D97FX reconstructed the local source exact; D97GA removed old installed stubs by Restore; D97GB executed corrected Root Patch; D97GD proved patched System-volume `180/180` exact; D97GE closed Haswell AuxKC/userspace placement; D97GF/D97GH proved active booted snapshot contains all 180 exact real metallibs.

Classification:
`CORRECTED_ROOTPATCH=STRUCTURAL_SEMANTIC_PASS_PRE_ACCELERATION`.

## D97GL / D97GM — metallib repair produces semantic progress
User-authoritative boot boundaries:
- ACCEL1 start `2026-09-07 23:39` local;
- ACCEL2 start `23:50`;
- VESA recovery `23:52`.

Both corrected-payload accelerated windows proved:
- old `validateWithDevice` fatal signature absent;
- `MTLReportFailure` absent;
- old surface bad-bits blocker absent;
- GPUPass still requested;
- repeated MTLCompilerService deaths interrupt WindowServer XPC compilation.

Thus metallib correction produced genuine semantic progress; old D97FJ validation-abort frontier is no longer current.

## D97GN — exact current compiler crash
Twelve `.ips` reports across both corrected-payload accelerated sessions converge 12/12 on:
- MTLCompilerService 263.8;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- EXC_BAD_ACCESS / SIGSEGV;
- invalid address 0;
- RIP=0 / CR2=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, image offset `0x3448`.

Accepted D97M static map correlates this with the exact indirect call `callq *0x8(%r14)` after the service tries to resolve `MTLCodeGenServiceCreate`.

## D97GP — P1 missing proven
Read-only current on-disk audit proved:

### MTLCompilerService
- bytes `85520`;
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5` = exact Golden original;
- selector bytes at `0x3494`: `81fe19790000` = compare 31001;
- exact indirect call bytes at `0x3444`: `41ff5608`.

The original service maps selector 31001, not runtime selector 32023, to the 32023 compiler lane.

### MTLCompiler 32023
- bytes `1636896`;
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` = exact Golden;
- all four required `MTLCodeGenServiceCreate/Destroy/BuildRequest/SetPluginPath` exports present, 4/4 PASS.

Classification:
- missing-export hypothesis NEGATIVE;
- current service P1 selector bridge MISSING PROVEN;
- current 32023 compiler identity/exports PASS.

## D97GR — exact P1 causal closure
Disposable-copy reconstruction proved:
- exact original service SHA before patch;
- unique preimage `81fe19790000` only at `0x3494`;
- postimage `81fe177d0000` = compare 32023;
- exactly two byte changes: `0x3496 19->17`, `0x3497 79->7d`;
- resulting SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` = exact historical P1/D97M identity;
- disassembly continues to `/Versions/32023/MTLCompiler`, `cmovne`, `_dlopen` unchanged.

Classification:
`D97GR_CURRENT_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

This closes the present crash cause but does not yet prove downstream post-P1 runtime success.

## CURRENT ACTION — D97GS P1-ONLY BUILD ON INTEL IMAC
No accelerated boot and no ASUS2 Root Patch are authorized yet.

Build helper:
`OCLP-Continuity/artifacts/OCLP7_D97GS_IMAC_BUILD_P1_ONLY_FROM_D97DX.sh`
- commit `8f86bfa76282b3b1c5b9aca311e95324406224d5`;
- Git blob `b408d8d372ca6956db0caeb2a253df44acd7a5b9`.

D97GS requirements/design:
- build host authorized home Intel iMac only;
- exact b9df76 D97DX worktree;
- exact pre-D97GS D97DX four-file source diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- adds only `sys_patch.py` as fifth changed source file;
- P1 hook runs after all patchset installs and before root-volume rebuild/snapshot;
- exact build `25G82` and model `MacBookAir6,2` guards;
- exact pre-SHA, unique preimage, exact two-byte write, exact post-SHA guards;
- fail closed on any mismatch;
- no P2b/P3/AIR00/D34 replay;
- no patch dictionary/metallib changes;
- reuses exact audited D97DX launcher/debug-helper wrapper provenance;
- build performs no Root Patch/system/EFI/NVRAM/framebuffer mutation and no reboot.

Next sequence:
1. run D97GS build helper on Intel iMac;
2. return full build report and D97GS ZIP identity;
3. independently audit source diff and built artifact;
4. only then decide/authorize ASUS2 Root Patch execution;
5. after any future Root Patch, first audit patched volume and VESA boot before any acceleration.
