# OCLP7 CHECKPOINT — 2026-09-04 — D97AM accelerated boot 02:29 NEGATIVE; WindowServer XPC interruption; D97AN runtime audit next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Routine/small work stays on ASUS2; GitHub only for major compile/build/package. Golden Sequoia remains immutable/read-only. No automatic Root Patch or reboot. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_ROOT_PATCH_FULL_PASS_ACCELERATED_BOOT_NEXT.md`.

D97AM manual Root Patch remains FULL PASS with D97AD absent, exact P7 preimage `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`, natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`, and exact post-SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

## Exact reboot chronology
User returned from the D97AM accelerated test with:

```text
reboot time  Fri 4 Sep 02:32
reboot time  Fri 4 Sep 02:29
shutdown time Fri 4 Sep 02:28
reboot time  Fri 4 Sep 02:17
```

Per the permanent VESA rule and the user's recovery sequence:
- `02:29` = D97AM accelerated/root-patched boot;
- `02:32` = current VESA recovery boot;
- `02:17` = older pre-test boot and excluded.

The authoritative accelerated evidence window is therefore fixed to `2026-09-04 02:29:00` through `2026-09-04 02:31:59` local time. Current VESA records from 02:32 onward are excluded.

## D97AM accelerated outcome — NEGATIVE
The accelerated boot did not yield a usable GUI and required VESA recovery.

Classification:
`D97AM_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`.

This is a functional outcome only. It does not by itself identify the MTLCompilerService failure mechanism.

## WindowServer crash inside accelerated window
A WindowServer crash report belongs unambiguously to the 02:29 accelerated boot:

```text
Process=WindowServer PID=498
Launch Time=2026-09-04 02:31:16.1804 +0300
Crash Time=2026-09-04 02:31:30.5263 +0300
Time Awake Since Boot=120 seconds
OS=macOS 26.6.2 (25G82)
Model=MacBookAir6,2
Exception=EXC_CRASH SIGABRT
Termination Namespace=COREANIMATION Code=4
Details=Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.
```

The crash stack again runs through `CA::OGL::MetalContext::create_pipeline_state`, QuartzCore rendering, SkyLight `MetalCompositeLayer`, `CompositorMetal`, and display update. The report also shows the Haswell `AppleIntelHD5000GraphicsMTLDriver` loaded and GPUCompiler 32023 support libraries present.

This confirms the accelerated boot reached the downstream Metal/WindowServer pipeline and reproduced the same downstream interruption class seen previously. WindowServer remains downstream and is not promoted to root cause.

## Critical interpretation
Removing the complete D97AD terminal classifier did **not** by itself restore a usable GUI.

However, this result does NOT yet prove that natural P7 flow reaches the five late simulator-limit diagnostic blocks, nor does it prove that MTLCompilerService terminates exactly as in D97AH. The new runtime sender UUID/provenance and MTLCompilerService lifecycle must be measured directly in the fixed accelerated window.

Do not infer upstream equivalence from the WindowServer crash alone.

## D97AN read-only runtime provenance audit prepared
Public wrapper:
- `OCLP7_D97AN_READONLY_ACCEL_0229_NATURAL_FLOW_RUNTIME_PROVENANCE_AUDIT.command`;
- commit `8685d4e9d5080b533ed06e9661aee759ec174217`;
- blob `a12775867f57e9edd949fefdbeacba6991d3aa48`.

D97AN is strict read-only and fixed to `02:29:00..02:31:59`. It collects structured JSON from MTLCompilerService, launchd, and WindowServer, then separates:
1. all exact 32023 MTLCompiler sender records;
2. the five late simulator diagnostic families;
3. expected natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7` versus old D5CE/A4F UUIDs;
4. per-PID late-diagnostic coverage;
5. launchd MTLCompilerService lifecycle/termination text;
6. any textual artificial 110..114 evidence;
7. WindowServer XPC/compilation correlation in the same historical window.

No source/app/system/Golden/snapshot mutation, Root Patch, or reboot occurs.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Run D97AN once on current VESA recovery. Return the complete terminal output/report.

The decisive question is whether exact 32023 MTLCompiler records — especially any of the five late simulator diagnostics — carry the new natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7` in the 02:29 accelerated cohort.

STOP after D97AN. No Root Patch. No reboot. No source or app mutation.