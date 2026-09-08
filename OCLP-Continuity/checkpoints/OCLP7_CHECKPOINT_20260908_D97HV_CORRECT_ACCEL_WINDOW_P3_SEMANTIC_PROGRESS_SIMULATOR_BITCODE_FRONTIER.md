# OCLP7 CHECKPOINT — 2026-09-08 — D97HV corrected accelerated-window analysis / P3 semantic progress

## Why this checkpoint exists
D97HV was run after recovery into VESA, but the immediately preceding boot was the actual accelerated P1+P3 experiment. The user explicitly identified this boot ordering, which is authoritative under the permanent VESA rule.

The original D97HV script also contained a boot-time parser defect: its `kern.boottime` regex captured the wrong numeric field and printed a 1970 boot time. It therefore mixed historical IPS/log evidence into its automatic `P3_MIXED_CURRENT_BOOT_FRONTIER` classification. That automatic classification is invalid and superseded by the corrected time-window analysis below.

## Authoritative boot boundaries
Immediately preceding accelerated P1+P3 boot:
- first accelerated WindowServer launch evidence: `2026-09-08 14:24:02.6523 +0300`;
- accelerated WindowServer startup activity begins at approximately `14:24:08`;
- accelerated compiler/WindowServer loop continues through approximately `14:27:16.953`;
- hard recovery/reboot follows;
- recovery VESA WindowServer starts only at approximately `14:28:38.955`;
- console login into VESA is later at `14:29:43`.

Therefore the authoritative accelerated analysis window is:
`2026-09-08 14:24:02 -> approximately 14:27:17 +0300`.

Do not mix this window with:
- the historical 2026-09-07 23:xx compiler crashes;
- the P1-only 2026-09-08 03:35 accelerated window;
- the 14:28+ VESA recovery boot.

## Bound runtime identities
The active experiment was already independently proven before this analysis:
- exact P1 service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- exact P3-only MTLCompiler32023 SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- P2 remained original `418b81d0000000 @ 0x9A8CD`;
- no P2b, AIR00 or D34;
- corrected metallibs 180/180 exact;
- Haswell AuxKC valid.

## Corrected accelerated evidence
Within the authoritative 14:24:02–14:27:17 accelerated window:

### WindowServer
Twelve distinct WindowServer processes are present:
`177, 387, 426, 471, 518, 565, 608, 637, 663, 691, 717, 743`.

Observed startup times include:
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

WindowServer IPS captured in this accelerated boot include:
- 14:24:59.8518, pid177, EXC_CRASH/SIGABRT in `MetalShader::CopyPipelineState(MetalContext*, bool, bool)+2930`;
- 14:25:13.7930, pid387, COREANIMATION code4, `spec=PBGRAXb_Xc`, compiler connection interrupted after retries, `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- 14:25:28.6413, pid426, same COREANIMATION/XPC pipeline failure family;
- 14:25:43.0220, pid471, same family;
- 14:25:56.6587, pid518, same family;
- 14:26:07.0357, pid565, same family.

Later accelerated WindowServer instances continue the same compiler/XPC restart loop until recovery reboot.

### MTLCompilerService
There are 145 distinct MTLCompilerService launches in the accelerated window:
- 144 associated with the 12 WindowServer processes, effectively 12 compiler-service launches per WindowServer;
- one additional launch associated with SecurityAgent.

All 145 compiler-service invocations reach the same new recurring MTLCompiler diagnostic route. The unified log text is partially decode-truncated, but two stable fragments appear once per invocation:
- `...upported in the simulator but <decode: mismatch for [%u] got [STRING sz:9]> were used`
- `n bitcode.`

Do not reconstruct or invent the missing portions of these strings; exact full wording remains UNKNOWN until static string/xref recovery.

Crucially, within the accelerated P1+P3 window:
- current `MTLCompilerService` IPS count = 0;
- current old NULL-call (`RIP=0 / r15=32023 / MTLConnectionCtx+56`) count = 0;
- current post-P1 StringMap SIGSEGV family count = 0.

The 12 NULL-call IPS and 9 StringMap IPS copied by D97HV are historical contamination caused by the broken boot-time window, not P1+P3 current evidence.

### XPC / pipeline consequence
WindowServer logs show deterministic compiler connection loss:
- 132 `MTLCompiler: Compilation failed with XPC_ERROR_CONNECTION_INTERRUPTED on N try` lines;
- try 1 = 33, try 2 = 33, try 3 = 33, try 4 = 33;
- repeated connection INVALID/retry behavior follows;
- `GetGPUPassRenderPipelineState: ... <error>` appears repeatedly;
- `Metal failed to build render pipeline` appears repeatedly;
- WindowServer is then aborted/restarted.

Example causal slice around 14:26:00:
`MTLCompilerService -> simulator/bitcode diagnostic -> service inactive -> WindowServer XPC interrupted on retries -> GPUPass render pipeline error -> WindowServer restart`.

The same pattern persists through the final accelerated compiler launches immediately before the recovery reboot at approximately 14:27:17.

## Comparison with P1-only accelerated evidence
P1-only accelerated boot at 03:35 had 9/9 current MTLCompilerService IPS in the exact StringMap SIGSEGV family:
`StringMapImpl::LookupBucketFor <- collectUsedGlobalVariables <- getOrInsertNamedMetadata <- addMsaaPositionInfoToModuleMetadata <- MTLCompilerBuildRequestWithOptions ...`.

P1+P3 accelerated boot has:
- 0 current StringMap IPS;
- 0 current MTLCompilerService crash IPS;
- 145/145 compiler-service invocations reaching a new deterministic simulator/bitcode diagnostic path instead.

Because exact P3 is the only new compiler functional delta and specifically forces serialized-bitcode handoff, this is causal runtime movement of the compiler frontier.

## Classification
`D97HV_AUTOMATIC_P3_MIXED_CLASSIFICATION=TOOLING_FALSE_NEGATIVE_TIME_WINDOW_CONTAMINATION`

`P3_RUNTIME_SEMANTIC_PROGRESS=PROVEN`

`POST_P1_STRINGMAP_FRONTIER=MOVED_CLOSED_FOR_THIS_ACCELERATED_EXPERIMENT`

`P1_PLUS_P3_ACCELERATED_GUI=NEGATIVE_NO_USABLE_GUI`

Current measured late-userspace chain:
`P1 + P3 serialized-bitcode path -> recurring MTLCompiler simulator/bitcode diagnostic -> MTLCompilerService connection loss -> XPC_ERROR_CONNECTION_INTERRUPTED -> GPUPass/render-pipeline failure -> WindowServer abort/restart -> no GUI`.

The exact semantic validator/function producing the simulator/bitcode diagnostics is still UNKNOWN. Do NOT yet label it `MTLSimCompiler::validSimulatorMetadata`; historical work eventually reached that symbol, but current identity has not been proven.

## P2b decision
P2b becomes a plausible next candidate because:
- it is the historical request-layout adapter `+0xD0 -> +0x110`;
- historical P2b+P3 was part of the chain that progressed much farther;
- P3 has now moved execution into a serialized-bitcode/simulator-related path where request layout may matter.

However:
`P2B_NEXT_PATCH=NOT_YET_AUTHORIZED`.

Permanent method still requires mapping the new measured failure before patching.

## Immediate next action
Perform a read-only static map of the exact active P3-only MTLCompiler32023:
1. pin active P1/P3 identities;
2. recover full strings containing `simulator` and `bitcode` from MTLCompiler32023;
3. locate string file offsets/virtual addresses and xrefs;
4. disassemble the call path around those xrefs;
5. map relationship to P2 offset `0x9A8CD` and P3 offset `0xA1573`;
6. search for and map `MTLSimCompiler::validSimulatorMetadata` only if current binary evidence supports it;
7. determine whether P2b is upstream/causal to the new diagnostic path;
8. no Root Patch, EFI/NVRAM/framebuffer mutation, acceleration or reboot during this mapping.

D97EW can be inventoried separately for the 14:24–14:27 accelerated run if useful, but the uploaded D97HV archive already provides decisive compiler-frontier movement evidence.
