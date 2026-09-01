# OCLP7 CHECKPOINT — 2026-09-02 — D97AD accelerated 00:10 / VESA 00:12 / D97AEQ ready

## Boot chronology pinned
User returned from VESA and supplied:
- reboot `2026-09-02 00:12` = VESA recovery boot, EXCLUDED from runtime evidence;
- reboot `2026-09-02 00:10` = immediately preceding D97AD accelerated diagnostic boot, SELECTED;
- shutdown `2026-09-02 00:09` = transition into the diagnostic boot;
- earlier `2026-09-01 23:37` entries are excluded.

Authoritative runtime-log window for D97AEQ is `2026-09-02 00:10:00` through but not including `2026-09-02 00:12:00` EEST.

## Accelerated WindowServer crash anchor
The crash report supplied from the selected accelerated boot shows:
- WindowServer PID `394`;
- launch `2026-09-02 00:11:32.9517 +0300`;
- crash `2026-09-02 00:11:47.9888 +0300`;
- boot session UUID `B6B4D4C3-D751-4FB0-AE64-2AF8AA1B9CC0`;
- termination namespace COREANIMATION code 4;
- `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.`

The report also shows `GPUCompiler.framework/Versions/32023` libraries loaded in WindowServer. This retains the established causal ordering `MTLCompilerService failure -> XPC interruption -> pipeline creation failure -> WindowServer abort`. The WindowServer crash is downstream evidence and does not by itself determine which D97AD classifier outcome occurred.

## D97AD runtime classifier contract
The installed Root Patch was already FULL PASS with exact D97AD MTLCompiler SHA:
`524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

Expected selector-only service SHA:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Outcome codes:
- 110 = candidate REL+`0x58B`;
- 111 = buffer-index REL+`0x29A`;
- 112 = sampler-index REL+`0x2D9`;
- 113 = nested argument-buffer REL+`0x3E2`;
- 114 = other early return REL+`0xB9` or unwind REL+`0x6CC`.

Mandatory runtime liveness gate remains: every spawned MTLCompilerService PID in the selected accelerated boot must emit exactly one classifier exit 110–114. Missing classifier exit, signal exit, another normal exit code, or ambiguous multiplicity invalidates the runtime run.

## D97AEQ read-only audit artifact
Artifact: `OCLP7_D97AEQ_READONLY_D97AD_ACCELERATED_WHOLE_STAGE_EXIT_AUDIT.command`
- commit `c3da3efe2e53c2e74703df7d0385415df0b4eeb4`;
- blob `463d30a4e3b640994e68bebebc91a01e14fd2be9`.

D97AEQ is read-only. It:
1. verifies Tahoe 26.6.2 / 25G82;
2. verifies visible selector-only MTLCompilerService SHA;
3. verifies visible D97AD MTLCompiler SHA;
4. verifies all six exact D97AD postimages plus the shared exit stub;
5. reprints boot chronology;
6. extracts unified logs only from `00:10:00..00:12:00`;
7. enumerates every MTLCompilerService spawn PID and every launchd `exited due to` record;
8. applies the exact liveness gate per PID;
9. prints histogram and sequence for exits 110–114;
10. correlates classifier activity hosted by fatal WindowServer PID 394 before/after the crash anchor.

No source/system/Golden mutation, service launch, runtime instrumentation, Root Patch or reboot is performed. D82 remains reserve-only. Patch8 remains unauthorized.

## CURRENT SINGLE NEXT ACTION
Run D97AEQ only and return the complete `OCLP7_D97AEQ_READONLY_D97AD_ACCELERATED_WHOLE_STAGE_EXIT_AUDIT_REPORT.txt`. Do not Root Patch or reboot.
