# OCLP7 D97FH — D97EZ ACTIVE `set_id_mode` exact adapter SEMANTIC PASS / previous bad-bits blocker CLOSED

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2

## Input authority
- D97EY established the pre-fix semantic failure: `mode=0x24` accepted, `mode=0x224` rejected with raw Apple `0xE00002C2 = kIOReturnBadArgument`.
- D97FD independently audited D97EZ 0.0.12 source/binary exact-match semantics.
- D97FG proved LATENT VESA runtime PASS and authorized one ACTIVE accelerated experiment.
- D97EW persistent collector preserved the immediately preceding accelerated ACTIVE run.

## Accelerated ACTIVE run identity
Persisted run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290`

Saved boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 #-igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh -ocmcd97ez`

Therefore:
- acceleration requested (`#-igfxvesa`, no active `-igfxvesa`);
- D97EZ functional experiment ACTIVE (`-ocmcd97ez`);
- existing D97BV/observer args preserved;
- no unrelated new T2/Haswell variable introduced.

Loaded kext identity in the accelerated run:
- `com.oclpmetalcompat.OCLPMetalCompat (0.0.12)`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

D97EW captured 8 tuples at tick 1 with route PASS. First sample total call count = 15. Follow-up samples reached total call count = 20.

## Global/no-PID semantic proof
First ACTIVE sample (15 calls):
- `D97EZFunctionalRequested=1`;
- `D97EZFunctionalMode="ACTIVE"`;
- `D97ELSetIdModeCallCount=15`;
- `D97EZExact224SeenCount=12`;
- `D97EZExact224AdaptedCount=12`;
- `D97EZAdaptSuccessCount=12`;
- `D97EZAdaptFailureCount=0`;
- `D97EZOtherModeSeenCount=3`;
- `D97EZPassthroughSuccessCount=3`;
- `D97EZPassthroughFailureCount=0`.

Thus:
- `12 + 3 == 15` exhaustive classification PASS;
- `Exact224AdaptedCount == Exact224SeenCount == 12` PASS;
- every adapted exact-224 call observed so far succeeded at Apple original;
- every non-224 passthrough call observed so far succeeded;
- zero functional failures.

Stable follow-up state at 20 calls:
- `D97ELSetIdModeCallCount=20`;
- `D97EZExact224SeenCount=16`;
- `D97EZExact224AdaptedCount=16`;
- `D97EZAdaptSuccessCount=16`;
- `D97EZAdaptFailureCount=0`;
- `D97EZOtherModeSeenCount=4`;
- `D97EZPassthroughSuccessCount=4`;
- `D97EZPassthroughFailureCount=0`.

Thus:
- `16 + 4 == 20` exhaustive classification PASS;
- `16 adapted == 16 exact-224 seen` PASS;
- all 20 routed calls returned Apple success;
- no residual set_id_mode rejection in the observed ACTIVE window.

## First-eight direct original/passed/return proof
Captured first-eight slots:
1. original `0x24` -> passed `0x24` -> Apple return `0`;
2. original `0x224` -> passed `0x24` -> Apple return `0`;
3. original `0x224` -> passed `0x24` -> Apple return `0`;
4. original `0x224` -> passed `0x24` -> Apple return `0`;
5. original `0x224` -> passed `0x24` -> Apple return `0`;
6. original `0x24` -> passed `0x24` -> Apple return `0`;
7. original `0x224` -> passed `0x24` -> Apple return `0`;
8. original `0x224` -> passed `0x24` -> Apple return `0`.

For exact-224 captured slots:
- original D97ES `Mode=548` (`0x224`);
- original D97ES `BadBits=512` (`0x200`);
- original D97ES `GoodBits=36` (`0x24`);
- D97EZ `PassedMode=36` (`0x24`);
- D97ES raw Apple `Ret=0`.

For original-0x24 captured slots:
- `PassedMode == originalMode == 0x24`;
- Apple `Ret=0`.

This is direct STRUCTURAL-SEMANTIC / SEMANTIC proof that D97EZ performs only the measured handoff translation for captured traffic and that the legacy Apple target accepts the translated calls.

## Closed causal blocker
The previous accelerated blocker:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits`
was caused, for the captured failing class, by Tahoe producer mode `0x224` carrying exact additional bit `0x200` into the legacy Haswell-side IOAccelerator contract.

D97EZ exact boundary translation changes only that exact measured input class `0x224 -> 0x24` and the Apple original then returns success for all 16 exact-224 calls observed in the 20-call ACTIVE window.

Therefore the previous set_id_mode bad-bits rejection is now CLOSED PASS as a causal blocker in this measured path.

This does NOT prove end-to-end accelerated GUI success. The user returned to VESA after the ACTIVE experiment, so a later downstream failure/frontier remains to be identified from the accelerated boot's persisted system logs.

## Classification
- `D97FH_ACTIVE_RUN_IDENTITY=PASS`
- `D97FH_D97EZ_FUNCTIONAL_GATE=ACTIVE_PROVEN`
- `D97FH_GLOBAL_CLASSIFICATION_EXHAUSTIVE=PASS`
- `D97FH_EXACT224_ADAPTATION_COVERAGE=PASS`
- `D97FH_EXACT224_APPLE_ACCEPTANCE=SEMANTIC_PROVEN`
- `D97FH_NON224_PASSTHROUGH_ACCEPTANCE=SEMANTIC_PROVEN_FOR_OBSERVED_CLASS`
- `D97FH_FIRST8_ORIGINAL_PASSED_RETURN=STRUCTURAL_SEMANTIC_PROVEN`
- `D97FH_SET_ID_MODE_BAD_BITS_BLOCKER=CLOSED_PASS`
- `D97FH_GLOBAL_MASK_SEMANTICS=NOT_CLAIMED`
- `D97FH_BIT_0x200_SEMANTIC_NAME=UNKNOWN`
- `D97FH_END_TO_END_GUI=NOT_PROVEN`
- `D97FH_NEW_DOWNSTREAM_FRONTIER=UNKNOWN_PENDING_PREVIOUS_BOOT_LOG_ANALYSIS`
- `D97FH_ROOT_PATCH_AUTHORIZED=NO`
- `D97FH_NEW_BOOTARGS_AUTHORIZED=NO`

## Current causal frontier
Previous frontier is closed:
`Tahoe mode 0x224 -> legacy IOAccelSurface rejection`

New frontier:
`successful IOAccelSurface::set_id_mode acceptance -> next CoreDisplay/SkyLight/WindowServer/IOAccelerator failure preventing usable accelerated image`

The next step is read-only analysis of the immediately preceding accelerated ACTIVE boot's persisted unified/system logs around the failure window. Do not alter D97EZ design, EFI, Root Patch, framebuffer or boot variables before locating that next failure.

## CURRENT ACTION
Remain in VESA with `-ocmcd97ez` absent/inert. Collect the immediately preceding accelerated ACTIVE boot's logs around 2026-09-07 16:50 EEST and determine the first new failure after successful set_id_mode acceptance. Do not repeat the ACTIVE boot unchanged until that downstream frontier is identified.
