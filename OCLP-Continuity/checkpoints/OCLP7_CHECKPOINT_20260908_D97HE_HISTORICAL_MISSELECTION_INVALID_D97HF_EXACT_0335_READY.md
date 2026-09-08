# OCLP7 CHECKPOINT — 2026-09-08 — D97HE HISTORICAL MISSELECTION INVALID / D97HF EXACT 03:35 COLLECTOR READY

## Current runtime event
First post-P1 accelerated boot produced no usable image. User recovered correctly to VESA under the permanent recovery rule.

Current WindowServer crash is authoritative for the accelerated boot:
- process `WindowServer` PID 373;
- Launch Time `2026-09-08 03:35:27.3200 +0300`;
- crash `2026-09-08 03:35:43.5056 +0300`;
- uptime 90 seconds;
- termination COREANIMATION code 4;
- `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.`
- current process loaded `GPUCompiler.framework/Versions/32023/Libraries/libllvm-flatbuffers.dylib` and `libGPUCompilerUtils.dylib`;
- current process loaded `AppleIntelHD5000GraphicsMTLDriver` 18.8.4 / bundle version 18.0.8.

This proves downstream Metal compositor/compiler activity but does NOT by itself prove whether P1 succeeded semantically in MTLCompilerService.

## D97HE ZIP audit — INVALID FOR CURRENT BOOT
Uploaded `OCLP7_D97HE_POST_P1_ACCEL_FRONTIER_20260908_034912.zip` was inspected directly.

D97HE incorrectly selected historical D97EW run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T205125Z-322`
= 2026-09-07 23:51:25 local EEST, i.e. old corrected ACCEL2 evidence.

Its tuple evidence is also historical:
- D97ELSetIdModeCallCount 58;
- D97EZExact224SeenCount 20;
- D97EZExact224AdaptedCount 20;
- D97EZPassthroughSuccessCount 38;
- D97ESCapturedCount 8.

The only MTLCompilerService IPS copied were historical:
- `MTLCompilerService-2026-09-07-234108.ips` captureTime 23:41:03 +0300;
- `MTLCompilerService-2026-09-07-235125.0004.ips` captureTime 23:51:06 +0300;
- `MTLCompilerService-2026-09-07-2351254.ips` captureTime 23:51:06 +0300.

All three naturally contain the old pre-P1 signature `RIP=0 / r15=32023 / MTLConnectionCtx+56`, but they predate the current post-P1 boot and therefore cannot classify P1 runtime behavior.

Classification:
`D97HE_CURRENT_BOOT_CLASSIFICATION=INVALID_HISTORICAL_MISSELECTION`
`D97HE_OLD_SIGNATURE_RESULT=DISCARDED_FOR_CURRENT_BOOT`
`P1_RUNTIME_EFFECT=UNKNOWN_PENDING_EXACT_CURRENT_WINDOW`

No inference toward P2b/P3/AIR00/D34 is allowed from D97HE.

## D97HF exact collector
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HF_POST_P1_EXACT_0335_FRONTIER_COLLECTOR.sh`
- commit `2c7251f8a1d74e33cd2a26940f9ac325d1072186`;
- blob `848974fb7b3fd8f285e744085149e32362c56d7f`.

D97HF is bounded to exact current test window:
`2026-09-08 03:34:00 +0300` through `03:39:30 +0300`.

It:
1. requires current VESA recovery and D97EZ inert;
2. requires current live service still exact P1 SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
3. inventories all D97EW run directories in UTC equivalent 00:33–00:41 without using them as the authority;
4. searches DiagnosticReports and Retired plus user reports;
5. selects MTLCompilerService/WindowServer IPS strictly by embedded `captureTime` within the exact current window;
6. parses RIP/r15/top fault frames and old `MTLConnectionCtx+56` signature;
7. captures exact-window unified log;
8. writes evidence only to Desktop; no Root Patch/Restore/EFI/NVRAM/framebuffer/reboot mutation.

## Current action
Run D97HF only. Do not run another accelerated boot. Do not add P2b/P3/AIR00/D34. Runtime module decision waits for exact 03:35 MTLCompilerService evidence.
