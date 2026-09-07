# OCLP7 CHECKPOINT — D97GM metallib repair moves fatal frontier to MTLCompilerService crash loop

Date: 2026-09-08 EEST

## Entering authority
- Corrected Root Patch is active and structurally/semantically closed pre-acceleration by D97GH.
- Active snapshot contains exact `180/180` corrected metallibs, zero missing/different/stubs.
- Active CoreDisplay metallib exact identity: `20739` bytes, SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, `MTLB`.
- User-authoritative accelerated boot boundaries:
  - accelerated #1: reboot `2026-09-07 23:39` local, ends before reboot 23:50;
  - accelerated #2: reboot `2026-09-07 23:50` local, ends before VESA recovery reboot 23:52.

## D97GL archive authority
Uploaded archive:
`OCLP7_D97GL_TWO_ACCEL_BOOT_LOG_CAPTURE_20260908_001739.zip`
- bytes `609651`;
- SHA256 `cf4beb07403e87601313b226a34913d8f996165edc9ad401e7f5401d3ea9cde0`.

Archive contains separate unified-log windows:
- `ACCEL1_2339`: `2026-09-07 23:39:00 -> 23:49:59`;
- `ACCEL2_2350`: `2026-09-07 23:50:00 -> 23:51:59`;
plus D97EW cohorts.

## Accelerated #1 unified-log result
Focused log counts:
- `GetGPUPassRenderPipelineState`: `4` occurrences;
- `validateWithDevice`: `0`;
- `MTLReportFailure`: `0`;
- `Surface mode contains bad bits`: `0`;
- `getPixelInformation for framebuffer 0 failed`: `1`;
- `IOFBGetDisplayModeInformation`: `12`;
- `XPC_ERROR_CONNECTION_INTERRUPTED`: `424`;
- `XPC_ERROR_CONNECTION_INVALID`: `127`;
- explicit kernel `Process[...] crashed: MTLCompilerServi`: `41`;
- ReportCrash `Formulating fatal 309 report ... MTLCompilerService`: `10`;
- successful `.ips` creation lines: `8`.

CoreDisplay `GetGPUPassRenderPipelineState` failures are immediately preceded by MTLCompilerService crash / XPC interruption, e.g. at 23:40:46.867-23:40:46.868 and 23:41:00.429-23:41:00.430.

Explicit MTLCompilerService crash reports created include:
- `/Library/Logs/DiagnosticReports/MTLCompilerService-2026-09-07-234059.ips`;
- `...-234100.ips`;
- `...-234101.ips`;
- `...-234108.ips`;
- `...-234109.ips`;
- `...-234111.000.ips`;
- `...-234111.ips`;
- `...-234115.ips`.

## Accelerated #2 unified-log result
Focused log counts:
- `GetGPUPassRenderPipelineState`: `3` occurrences;
- `validateWithDevice`: `0`;
- `MTLReportFailure`: `0`;
- `Surface mode contains bad bits`: `0`;
- `getPixelInformation for framebuffer 0 failed`: `1`;
- `IOFBGetDisplayModeInformation`: `8`;
- `XPC_ERROR_CONNECTION_INTERRUPTED`: `452`;
- `XPC_ERROR_CONNECTION_INVALID`: `138`;
- explicit kernel `Process[...] crashed: MTLCompilerServi`: `28`;
- ReportCrash fatal MTLCompilerService lines: `21`;
- successful `.ips` creation lines captured: `2`.

CoreDisplay GPUPass failures again follow compiler-service death, e.g.:
- 23:51:06.613 compiler XPC interrupted -> 23:51:06.614 `GetGPUPassRenderPipelineState ... <error>`;
- 23:51:15.082 compiler crash -> same timestamp GPUPass error;
- 23:51:26.549 compiler crash -> same timestamp GPUPass error.

Explicit created reports include:
- `/Library/Logs/DiagnosticReports/MTLCompilerService-2026-09-07-2351254.ips`;
- `/Library/Logs/DiagnosticReports/MTLCompilerService-2026-09-07-235125.0004.ips`.

## D97EW accelerated #2 semantic adapter result
Authoritative D97EW run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T205125Z-322`

At first capture:
- `D97ELSetIdModeCallCount=58`;
- `D97EZExact224SeenCount=20`;
- `D97EZExact224AdaptedCount=20`;
- `D97EZAdaptSuccessCount=20`;
- `D97EZAdaptFailureCount=0`;
- `D97EZOtherModeSeenCount=38`;
- `D97EZPassthroughSuccessCount=38`;
- `D97EZPassthroughFailureCount=0`;
- functional mode `ACTIVE`;
- route `PASS`.

Thus the prior exact `set_id_mode 0x224` blocker remains CLOSED PASS after corrected Root Patch.

## Decisive semantic change versus D97FJ
Before metallib repair, D97FJ had two WindowServer crash modes converging on:
- `GetGPUPassRenderPipelineState` error path;
- native Metal `validateWithDevice` / `MTLReportFailure` abort.

After corrected real metallib materialization, across both accelerated windows:
- `GetGPUPassRenderPipelineState` is still reached and reports error;
- `validateWithDevice` is absent;
- `MTLReportFailure` is absent;
- instead, the dominant immediate upstream failure is repeated `MTLCompilerService` process death causing `XPC_ERROR_CONNECTION_INTERRUPTED/INVALID`.

Classification:
- corrected metallib repair produced REAL SEMANTIC PROGRESS;
- old native Metal validation-abort frontier is CLOSED as the current observed failure mode;
- GPUPass itself is not closed, because its compiler dependency fails;
- new measured fatal frontier is `MTLCompilerService` crash loop / XPC transport loss.

`D97GM_OLD_VALIDATEWITHDEVICE_FRONTIER=NO_LONGER_REPRODUCED`
`D97GM_MTLCOMPILERSERVICE_CRASH_LOOP=REACHED_AND_REPRODUCED_BOTH_ACCELERATED_WINDOWS`
`D97GM_METALLIB_FIX_RUNTIME_PROGRESS=SEMANTIC_PROVEN`

## Important non-causal ReportCrash message
Unified log repeatedly shows ReportCrash failing LaunchServices lookup for the XPC bundle with `kLSNotAnApplicationErr`. This occurs while ReportCrash is formulating crash reports and is not itself proven to be the cause of the compiler crash. Do not misclassify it as root cause.

## Current next action
Do NOT run another accelerated boot.
Do NOT change EFI/root/NVRAM/framebuffer.
Collect the actual MTLCompilerService `.ips` reports created during the two accelerated windows, then map their exception/termination reason and crashing stack against the exact installed legacy `MTLCompilerService.xpc` and D97DX compiler/private-framework chain.

The D97GL diagnostic-copy filter missed these reports because its filename keyword set omitted `MTLCompilerService`.
