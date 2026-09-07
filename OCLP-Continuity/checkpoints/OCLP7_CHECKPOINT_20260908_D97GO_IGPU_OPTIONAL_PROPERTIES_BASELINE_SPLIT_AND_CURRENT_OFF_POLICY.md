# OCLP7 CHECKPOINT — D97GO iGPU optional-properties baseline split; current OFF policy

Date: 2026-09-08 EEST

## User-authoritative configuration history
The user clarified the exact iGPU DeviceProperties state used across the corrected-Root-Patch accelerated experiments.

Until and including Accelerated #1 (reboot boundary 2026-09-07 23:39 local), the following optional WhateverGreen iGPU properties were enabled:
- `igfxfw=2` — force Apple GuC firmware loading;
- `rps-control=1` — enable RPS control patch;
- `enable-max-pixel-clock-override` — enable max pixel clock override (with its associated max-pixel-clock configuration as previously used).

At Accelerated #2 (reboot boundary 2026-09-07 23:50 local), the user deliberately disabled all three because they are optional/tuning properties and should not be part of the minimum baseline until a usable image exists.

Current policy from the user:
- keep `igfxfw` disabled;
- keep `rps-control` disabled;
- keep Max Pixel Clock Override disabled;
- do not re-enable any of them until a usable accelerated image is obtained and a separate need is demonstrated.

## Upstream semantic confirmation
WhateverGreen documentation defines:
- `igfxfw=2` / `igfxfw` property: force loading of Apple GuC firmware;
- `igfxrpsc=1` / `rps-control` property: enable RPS control patch;
- `-igfxmpc` / `enable-max-pixel-clock-override` plus `max-pixel-clock-frequency`: increase maximum pixel clock.

Therefore these are optional/tuning behaviors, not mandatory prerequisites for proving the baseline accelerated graphics pipeline.

## Experimental interpretation
This creates a configuration split between the two corrected-Root-Patch accelerated boots:

### Accelerated #1 — 23:39
- corrected real 25G82 metallib layer active;
- `igfxfw=2` ON;
- `rps-control=1` ON;
- Max Pixel Clock Override ON;
- no usable image;
- D97GL shows the old D97FJ `validateWithDevice`/`MTLReportFailure` fatal frontier no longer dominates; MTLCompilerService crash-loop becomes the downstream measured frontier.

### Accelerated #2 — 23:50
- corrected real 25G82 metallib layer active;
- `igfxfw` OFF;
- `rps-control` OFF;
- Max Pixel Clock Override OFF;
- no usable image;
- D97EZ ACTIVE remains semantically clean: 58 total routed calls, 20/20 exact `0x224 -> 0x24` adaptations successful, 38/38 passthrough successful, zero failures;
- D97GL again shows MTLCompilerService crash-loop as the downstream frontier, with old D97FJ `validateWithDevice`/`MTLReportFailure` absent.

## Causal consequence
The direct comparison between Accelerated #1 and Accelerated #2 is confounded by these three optional iGPU property changes and must not be used to attribute every traffic difference solely to metallib repair.

However, the stronger causal comparison remains valid:
- pre-repair D97FJ accelerated state used the prior optional-property configuration;
- post-repair Accelerated #1 also used that same prior optional-property configuration;
- the fatal frontier nevertheless changed from `CoreDisplay -> validateWithDevice/MTLReportFailure` to an MTLCompilerService crash-loop.

Thus the metallib repair still has a controlled same-iGPU-property comparison supporting real downstream progress.

Further, the new MTLCompilerService frontier appears in both Accelerated #1 (optional properties ON) and Accelerated #2 (optional properties OFF), so within measured scope those three optional iGPU properties are not sufficient to explain the new MTLCompilerService crash-loop.

## Current baseline authority
For all next experiments until a usable image exists:
- `igfxfw` OFF;
- `rps-control` OFF;
- Max Pixel Clock Override OFF;
- normal framebuffer baseline remains 3/3/3;
- no new iGPU tuning/optimization property should be introduced unless independently justified by a measured blocker.

Classification:
- configuration history: USER-AUTHORITATIVE;
- optional-property semantics: STATIC-DOCUMENTED;
- cross-run comparison #1 vs #2: CONFOUNDED for differences attributable to these properties;
- metallib-repair progress versus pre-repair D97FJ using same prior optional-property configuration: SEMANTIC PROGRESS SUPPORTED;
- MTLCompilerService frontier persistence with properties ON and OFF: REACHED in both measured accelerated configurations;
- current minimal iGPU baseline with these three properties OFF: AUTHORIZED.

## Current next action
Remain in VESA recovery with the three optional iGPU properties OFF.
Do not run another accelerated boot yet.
Collect and audit MTLCompilerService `.ips` reports from the 23:39 and 23:50 accelerated experiments (D97GN lane) to localize the exact compiler-service crash cause.
