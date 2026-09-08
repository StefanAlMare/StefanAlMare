# OCLP7 CHECKPOINT — 2026-09-08 — D97HV independent archive audit PASS / D97HW ready

## Purpose
This checkpoint closes the remaining evidence caveat from the prior permanent reconciliation by independently opening and auditing the exact user re-upload of the D97HV ZIP bytes.

No Root Patch, Restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot occurred. No functional patch state changed.

## Exact uploaded archive identity — independently verified
Uploaded local file:
`OCLP7_D97HV_CURRENT_P1_P3_VESA_FRONTIER_20260908_151239(2).zip`

The `(2)` suffix is upload/local-name decoration only. Archive bytes independently verify as the exact persisted D97HV package identity:
- bytes `5390949`;
- SHA256 `e8427830641821d8394b3c82c9cf266ce046eb0e69ad1af28700f47b16122faf`;
- ZIP CRC test PASS (`testzip=None`);
- 53 ZIP entries total.

Classification:
`D97HV_ARCHIVE_OUTER_IDENTITY=INDEPENDENT_PASS`.

## Internal payload integrity
The D97HV report records 46 copied IPS payloads with source size/SHA256/captureTime.
Independent audit matched all 46 archived IPS files against the report:
- missing `0`;
- size mismatches `0`;
- SHA256 mismatches `0`.

Classification:
`D97HV_REPORTED_IPS_PAYLOAD_IDENTITIES=46_OF_46_INDEPENDENT_PASS`.

## Collector defect independently confirmed
`D97HV_REPORT.txt` contains:
- active P1 service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active P3-only compiler SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- `D97HV_ACTIVE_P1_P3_BINDING=PASS`;
- erroneous `D97HV_BOOT_UTC=1970-01-03T06:44:53+00:00`.

Therefore the previously persisted classification remains correct:
`D97HV_AUTOMATIC_CLASSIFICATION=INVALID_TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`.

The 46 copied IPS include historical reports because of the bad boot-time window. They must not be treated as one current cohort.

## Independent authoritative accelerated-window rescope
Durable P1+P3 accelerated window remains:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Independent extraction from the archived raw `current_boot_unified.log` yields `10911` log lines in the bounded window.

### WindowServer population
Exactly 12 distinct WindowServer PIDs occur:
`177, 387, 426, 471, 518, 565, 608, 637, 663, 691, 717, 743`.

Exactly 12 `Server is starting up` markers occur at:
- 14:24:08.037
- 14:25:00.003
- 14:25:14.374
- 14:25:30.429
- 14:25:43.784
- 14:25:57.325
- 14:26:07.545
- 14:26:20.099
- 14:26:31.725
- 14:26:43.366
- 14:26:54.107
- 14:27:05.792

The later recovery VESA cohort is independently distinguished by WindowServer PID177 activity beginning at `14:28:38.955` and `Server is starting up` at `14:28:41.325`.

Classification:
`D97HV_ACCEL_VS_RECOVERY_BOUNDARY=INDEPENDENT_PASS`.

### MTLCompilerService population and host mapping
Within the authoritative accelerated window:
- 145 distinct MTLCompilerService PIDs;
- all 145 have an explicit XPC peer host mapping;
- exactly 144 map to the 12 WindowServer PIDs, with exactly 12 compiler-service processes per WindowServer;
- exactly one maps to SecurityAgent PID405.

Host distribution:
- each WindowServer PID -> 12 MTLCompilerService children;
- SecurityAgent PID405 -> 1 MTLCompilerService child.

Classification:
`D97HV_MTLCOMPILER_LAUNCH_COUNT=145_INDEPENDENT_PROVEN`
`D97HV_MTLCOMPILER_HOST_MAPPING=145_OF_145_EXHAUSTIVE`.

### Simulator/bitcode diagnostic exhaustiveness
In the same exact window:
- 290 total MTLCompilerService lines matching `simulator|bitcode`;
- every one of the 145 MTLCompilerService PIDs emits exactly two such lines;
- every PID emits exactly one line containing the stable `simulator` fragment;
- every PID emits exactly one line containing the stable `bitcode` fragment.

Stable raw fragments are exactly:
- `upported in the simulator but <decode: mismatch for [%u] got [STRING sz:9]> were used`
- `n bitcode.`

Do not reconstruct missing leading/truncated text before D97HW static recovery.

Classification:
`D97HV_SIMULATOR_BITCODE_ROUTE=145_OF_145_EXHAUSTIVE_REACHED`.

### Old frontier absence in the current window
Independent raw-log counts inside the authoritative accelerated window:
- `validateWithDevice` = `0`;
- `MTLReportFailure` = `0`;
- `Surface mode contains bad bits` = `0`;
- `StringMapImpl / collectUsedGlobalVariables / getOrInsertNamedMetadata / addMsaaPositionInfoToModuleMetadata` = `0`.

The ZIP contains 21 MTLCompilerService IPS files total, but captureTime audit proves:
- current 14:24–14:27 MTLCompilerService IPS = `0`;
- all 21 archived MTLCompilerService IPS are historical (23:xx pre-P1 and 03:35 P1-only cohorts).

Classification:
`D97HV_CURRENT_OLD_NULL_IPS=0`
`D97HV_CURRENT_STRINGMAP_IPS=0`
`D97HV_CURRENT_MTLCOMPILERSERVICE_IPS=0`
`D97HV_OLD_FRONTIERS_ABSENT_CURRENT_WINDOW=INDEPENDENT_PASS`.

Absence of MTLCompilerService IPS is not used to infer normal termination. Unified logs prove service/connection loss; exact service termination mechanism remains UNKNOWN.

## XPC / render-pipeline consequence independently verified
Within the authoritative window:
- exact `MTLCompiler: Compilation failed with XPC_ERROR_CONNECTION_INTERRUPTED on N try` count = `132`;
- try1 = `33`;
- try2 = `33`;
- try3 = `33`;
- try4 = `33`;
- `GetGPUPassRenderPipelineState` log occurrences = `11`;
- `Metal failed to build render pipeline` occurrences = `20`.

A direct slice around 14:24:49 independently shows:
`MTLCompilerService simulator/bitcode diagnostic -> WindowServer compiler interrupted -> launchd service inactive -> WindowServer connection invalid/retry`.

The client log may describe the service as having crashed during communication, but with zero current MTLCompilerService IPS the exact service termination cause remains unproven. Durable wording is `compiler-service connection loss / service inactive`.

Classification:
`D97HV_XPC_RETRY_DISTRIBUTION=INDEPENDENT_EXACT_PASS`
`D97HV_PIPELINE_FAILURE_DOWNSTREAM=REACHED_PROVEN`.

## Current WindowServer IPS independently audited
Six WindowServer IPS in the archive have captureTime inside the authoritative accelerated window:
- pid177 `14:24:59.8518`: EXC_CRASH/SIGABRT, `MetalShader::CopyPipelineState(...)+2930`;
- pid387 `14:25:13.7930`: COREANIMATION code4, `PBGRAXb_Xc`, compiler connection interrupted after retries, `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- pid426 `14:25:28.6413`: same COREANIMATION/XPC family;
- pid471 `14:25:43.0220`: same family;
- pid518 `14:25:56.6587`: same family;
- pid565 `14:26:07.0357`: same family.

All six current WindowServer IPS load:
- GPUCompiler 32023 `libllvm-flatbuffers.dylib` UUID `D5CE0007-AACD-3FDD-9F18-880B96F415C0`;
- GPUCompiler 32023 `libGPUCompilerUtils.dylib` UUID `D5CE0007-998A-3F83-BC35-8F9C186F710A`;
- AppleIntelHD5000GraphicsMTLDriver UUID `D5CF0007-37A7-35CF-BB5E-A6BAAA145AD2`, short version `18.8.4`, bundle version `18.0.8`.

Classification:
`D97HV_CURRENT_WINDOWSERVER_IPS=6_INDEPENDENT_AUDITED`
`D97HV_HASWELL_GPUCOMPILER_PATH=REACHED_PROVEN`.

## Final independent D97HV conclusion
The re-uploaded archive independently confirms the permanent reconciliation without introducing a contradictory frontier.

Durable current chain remains:
`P1 + P3 serialized-bitcode path -> exhaustive recurring simulator/bitcode diagnostic route -> compiler-service connection loss / service inactive -> XPC_ERROR_CONNECTION_INTERRUPTED retries -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no usable GUI`.

Exact semantic validator/function producing the diagnostic is still UNKNOWN.
Do not label it `MTLSimCompiler::validSimulatorMetadata` until D97HW current-binary static evidence proves it.

P2b remains plausible but NOT_YET_AUTHORIZED.
AIR00 and D34 remain unauthorized.

## Current action
Unchanged: D97HW read-only static simulator/bitcode frontier map.

Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HW_READONLY_P3_SIMULATOR_BITCODE_STATIC_MAP.sh`.

D97HW has not yet been executed.
No Root Patch, Restore, EFI/NVRAM/framebuffer mutation, acceleration change or reboot is authorized by this checkpoint.
