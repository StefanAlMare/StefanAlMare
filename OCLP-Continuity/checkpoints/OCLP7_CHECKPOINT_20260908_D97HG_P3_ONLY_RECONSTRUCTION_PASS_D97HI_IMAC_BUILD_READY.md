# OCLP7 CHECKPOINT — 2026-09-08 — D97HG P3-ONLY RECONSTRUCTION PASS / D97HI INTEL-iMAC BUILD READY

## Context
ASUS2 / Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.
Current machine state is VESA recovery with D97EZ inert after the first post-P1 accelerated test.

Immediate causal authority:
- D97HF proved P1 runtime semantic progress: old `RIP=0 / r15=32023 / MTLConnectionCtx+56` startup signature absent 9/9;
- all 9 current MTLCompilerService crashes converge on the historical pre-P3 direct-module/LLVM metadata frontier;
- current evidence does not justify P2b as the next patch;
- measured next adapter is P3 serialized-bitcode.

## D97HG actual result — PASS
Exact helper identity:
- helper commit `8575196995c49a30b369abaa3b4da1395b0275e8`;
- helper Git blob `8c6a0dfa5b328cc0776d7afaef8ab33eb5fc087e`.

D97HG was run on ASUS2 read-only/copy-only.

### Active P1 gate
- boot is VESA;
- D97EZ inert;
- active MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- `D97HG_ACTIVE_P1_GATE=PASS`.

### Current MTLCompiler 32023 identity
Path:
`/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`

Exact identity:
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- bytes `1636896`;
- x86_64;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- exact Golden 32023 PASS.

### P2 state — original / no P2b
At file offset `0x9A8CD`:
- bytes `41 8b 81 d0 00 00 00`;
- global occurrence count 1;
- `D97HG_P2_ORIGINAL_MATCH=PASS`;
- `D97HG_CURRENT_P2_STATE=ORIGINAL_D0_NO_P2B`.

This proves the current new frontier was reached without P2b.

### P3 state and exact reconstruction
At file offset `0xA1573`:
- preimage `81 e1 00 00 20 00`;
- global occurrence count 1;
- exact preimage PASS.

P3-only copy changed exactly one byte:
- file offset `0xA1574`;
- `e1 -> c9`;
- postimage `81 c9 00 00 20 00`;
- changed-byte count 1;
- file size unchanged `1636896`.

Exact P3-only post-SHA256:
`0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.

Final D97HG classifications:
`D97HG_P3_ONLY_RECONSTRUCTION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97HG_P2B_REPLAY=NO`
`D97HG_P3_NEXT_MODULE=YES_MEASURED`
`D97HG_STATUS=PASS_COPY_ONLY`.

No system/root/EFI/NVRAM/framebuffer mutation and no reboot occurred.

## D97HI design authority
D97HI is D97GS exact P1-only base plus exactly one new functional adapter: P3.

Integration point:
- after normal patchset installation;
- after exact D97GS P1 selector bridge;
- before root-volume continuation/rebuild/snapshot.

P3 mounted-root target:
`System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`.

Fail-closed P3 contract:
- exact pre-SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- unique preimage `81e100002000` at `0xA1573`;
- write exactly one byte at `0xA1574`: `e1 -> c9`;
- exact postimage `81c900002000`;
- exact post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- target size unchanged.

Explicit non-replay:
- P2b NO;
- AIR00 NO;
- D34 NO.

P1 method/hook must remain byte-identical to D97GS.

## D97HI Intel-iMac build helper
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HI_IMAC_BUILD_P1_PLUS_P3_ONLY_FROM_D97GS.sh`

Identity:
- commit `4ca10b8e9a1b0db046d570bc2e1d2710ab16fa9a`;
- Git blob `0bf2e5601f08613d916d1414a5e2561153517ed5`.

Build policy:
- compilation ONLY on authorized home Intel iMac;
- requires exact D97GS source diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- requires exact D97GS ZIP SHA `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`, bytes `722879148`;
- reuses exact D97GS/D97DX launcher and DEBUG helper provenance;
- builds x86_64 inner app;
- adds exact P3 method/hook and machine-audits P1 unchanged + P3 source contract;
- outputs `OpenCore-Patcher-Tahoe-D97HI.app` and `.zip` to Desktop.

Developer ID is intentionally not introduced for this internal diagnostic build because changing signing identity of the already-proven wrapper/nested helper workflow would add an unrelated variable. Use Developer ID later when distribution signing is relevant.

## Current authorization
Authorized now:
`D97HI_INTEL_IMAC_BUILD=YES`.

Not authorized yet:
- ASUS2 Root Patch;
- reboot;
- accelerated boot;
- P2b/AIR00/D34;
- EFI/NVRAM/framebuffer changes.

After D97HI build, perform an independent artifact audit before any ASUS2 deployment.
