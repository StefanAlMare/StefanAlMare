# OCLP7 CHECKPOINT — D97GI two corrected-Root-Patch accelerated boots preliminary classification; D97GJ log capture ready

Date: 2026-09-08 EEST

## Entering authority
- D97GH closed the corrected Root Patch as STRUCTURAL-SEMANTIC PASS pre-acceleration and authorized one measured accelerated boot.
- User then attempted acceleration twice before returning to VESA recovery.
- User explicitly identifies reboot times `2026-09-07 23:41` and `2026-09-07 23:50` local as the two accelerated boots.
- Current recovery boot is the later VESA boot around `23:52`.

## Returned D97EW cohorts
User uploaded:
- `D97GI_ACCEL1_20260907T204303Z-312.zip` corresponding to the first accelerated-boot time window after the 23:41 reboot;
- `D97GI_ACCEL2_20260907T205125Z-322.zip` corresponding to the second accelerated-boot time window after the 23:50 reboot.

### Cohort 1 — collector run `20260907T204303Z-312`
Collector:
- start UTC `20:43:06` = local `23:43:06`;
- PID `312`;
- first summary sample only at local `23:48:57`, indicating severe delay/stall before collector sampling completed;
- only one completed summary tick was captured before the next reboot window.

OCLPMetalCompat identity:
- version `0.0.12`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

IORegistry state captured late in this boot:
- D97BV functional mode ACTIVE;
- observer route PASS;
- D97EZ functional mode LATENT;
- D97EZ requested `0`;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCapturedCount=0`.

The collector's `boot_args.txt` contains a VESA/inert-D97EZ token state; however the user explicitly identifies the 23:41 reboot as an accelerated attempt. Therefore this file alone is not used to override the user-authoritative boot boundary. The measured runtime fact is narrower: when the late IORegistry sample was finally captured, D97EZ was LATENT and no set_id_mode calls had been observed.

Classification:
- first 23:41 boot: `ACCELERATED_ATTEMPT_USER_BOUNDARY_ACCEPTED`;
- D97EZ active behavior in captured runtime: `NEGATIVE / LATENT`;
- set_id_mode progress: `0 calls observed`;
- exact cause of the severe stall and relationship to the intended EFI token state remains UNKNOWN pending unified-log audit.

### Cohort 2 — collector run `20260907T205125Z-322`
Collector:
- start UTC `20:51:56` = local `23:51:56`;
- PID `322`;
- tuple captured on tick 1 at UTC `20:52:04`;
- collector completed tuple-post capture sequence by UTC `20:52:15`.

OCLPMetalCompat:
- exact 0.0.12 UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- D97BV ACTIVE;
- D97EZ ACTIVE;
- observer route PASS.

Measured set_id_mode totals:
- `D97ELSetIdModeCallCount=58`;
- exact `0x224` seen `20`;
- exact `0x224` adapted `20`;
- adaptation success `20`;
- adaptation failure `0`;
- other-mode seen `38`;
- passthrough success `38`;
- passthrough failure `0`.

Thus all 58 routed calls are exhaustively accounted for and all returned success in the measured adapter contract.

First-eight tuples:
1. original mode `0x24`, passed `0x24`, ret `0`;
2. original `0x224`, passed `0x24`, ret `0`;
3. original `0x224`, passed `0x24`, ret `0`;
4. original `0x224`, passed `0x24`, ret `0`;
5. original `0x224`, passed `0x24`, ret `0`;
6. original `0x24`, passed `0x24`, ret `0`;
7. original `0x24`, passed `0x24`, ret `0`;
8. original `0x24`, passed `0x24`, ret `0`.

Counters remain stable through all five post-capture snapshots while publisher/callback counters continue advancing.

Classification:
`D97GI_ACCEL2_D97EZ=STRUCTURAL_SEMANTIC_PASS` for 58 measured calls.

This re-confirms that the old set_id_mode bad-bits blocker is not the current failure in the second corrected-payload accelerated boot.

## What remains unknown
The D97EW zips do not contain the required WindowServer/CoreDisplay/Metal unified log or crash reports. Therefore they cannot by themselves determine whether:
- the previous `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` failure disappeared;
- native Metal `validateWithDevice` still aborts with the same predicate family;
- the corrected metallib layer moved execution to a new downstream frontier;
- or another failure now prevents a usable GUI.

No claim is made yet that the metallib defect was the sole/final runtime root cause.

## Next exact action — D97GJ
Remain in VESA recovery. Do not Root Patch or change EFI.

Run read-only helper:
`OCLP-Continuity/artifacts/OCLP7_D97GJ_TWO_ACCEL_BOOT_LOG_CAPTURE.sh`

Helper authority:
- commit `77dfa6cfafbd13dca7a8b40de1a0492c9c38c92e`;
- blob `9c3ee448d4495697328f567fe4d5e98e3fcb70ed`.

D97GJ captures unified-log windows:
- ACCEL1: `2026-09-07 23:41:00` through `23:50:00`;
- ACCEL2: `2026-09-07 23:50:00` through `23:52:59`;
plus recent WindowServer/panic/GPU diagnostic reports and D97EW cohort inventory.

The decisive audit will compare both accelerated windows against the prior D97FJ signatures:
- `GetGPUPassRenderPipelineState`;
- `validateWithDevice`;
- `MTLReportFailure`;
- WindowServer SIGSEGV/SIGABRT;
- previous framebuffer/mode-info failures.

Still forbidden:
- new EFI/bootarg experiments;
- Root Patch/Restore;
- new adapter semantics;
- Golden mutation;
- global masking or true-five replay.
