# OCLP7 CHECKPOINT — 2026-09-08 — D97HE v2 FRONTIER COLLECTOR READY

## Runtime state
ASUS2 is back in VESA after the first post-P1 accelerated boot produced no usable image.
The accelerated boot remains authoritative; the current VESA boot is recovery only.

WindowServer accelerated crash is proven downstream on `XPC_ERROR_CONNECTION_INTERRUPTED` after multiple retries. P1 runtime effect remains UNKNOWN until MTLCompilerService crash reports are classified.

## D97HE v1 tooling correction
The first published D97HE collector at commit `6ea8974bb24f01c681b8e2523025eeb1dc1d655f` was NOT run by the user.
Static review caught two tooling defects before execution:
1. accelerated D97EW run selector could emit multiple historical matches instead of only newest;
2. generated shell time-window variables with spaces were unquoted before `source`.

No ASUS2 state was changed by this discovery.

## Corrected D97HE v2 authority
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HE_POST_P1_ACCEL_RECOVERY_FRONTIER_COLLECTOR.sh`

Exact authority:
- commit `4af65c99950c95e1f709e4d930213bb934ad3ed9`;
- Git blob `d7aad0b44f53dfaff7ce9d0a770bd38255c0ad37`.

Corrections:
- selects only newest D97EW run matching active `-ocmcd97ez` + inert `#-igfxvesa`;
- writes quoted `START_LOCAL` / `END_LOCAL` shell values;
- otherwise preserves read-only scope and frontier logic.

## Current action
Run D97HE v2 only.
It must collect:
- authoritative D97EW accelerated run and tuple evidence;
- MTLCompilerService + WindowServer IPS reports in accelerated window;
- RIP/r15/faulting frames;
- exact count of old `RIP=0 + r15=32023 + MTLConnectionCtx+56` signature;
- bounded unified logs;
- current recovery VESA P1 service identity.

No Root Patch, accelerated boot, EFI/NVRAM/framebuffer change, or P2b/P3/AIR00/D34 replay is authorized before review.
