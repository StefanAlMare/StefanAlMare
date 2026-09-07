# OCLP7 CHECKPOINT — D97GS source-base guard stop; D97GT drift audit ready

Date: 2026-09-08 EEST

## Entering authority
D97GR proved the current MTLCompilerService null-call cause is the missing P1 selector bridge and reconstructed historical P1 byte-for-byte on a disposable copy.
D97GS was designed to build a D97DX-derived P1-only Root Patcher on the authorized Intel iMac, with no ASUS2/system mutation.

## D97GS execution result
User ran exact D97GS helper on Intel iMac.
Helper identity PASS:
- Git blob `b408d8d372ca6956db0caeb2a253df44acd7a5b9`.

Safety banner confirmed:
- Root Patch NO;
- system-root mutation NO;
- EFI/NVRAM/framebuffer mutation NO;
- reboot NO;
- P1 only intended functional delta;
- no P2b/P3/AIR00/D34 replay.

D97GS stopped before any source insertion/build because current worktree diff identity was:
`12a397b06951070ec41df8a67af1d008106f351b081ebdc09ce8333adb4647b8`
while exact audited D97DX source-base diff must be:
`c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`.

Classification:
`D97GS_SOURCE_BASE_GUARD=STOP_CORRECTLY`
`D97GS_P1_SOURCE_INSERT_REACHED=NO`
`D97GS_BUILD_REACHED=NO`
`D97GS_SYSTEM_MUTATION=NO`.

This is not evidence against P1. Exact reason for source-base drift is UNKNOWN until read-only audit.

## D97GT
Read-only helper added:
`OCLP-Continuity/artifacts/OCLP7_D97GT_IMAC_READONLY_D97DX_SOURCE_DRIFT_AUDIT.sh`
- commit `ae53f489db21c354291c7b9eac18555adfb502aa`;
- Git blob `9ec149b1b69c41b04e97581252195cde5534d9d0`.

D97GT performs no reset/checkout/apply/build/root patch/reboot. It:
1. verifies exact b9df76 HEAD;
2. inventories current tracked/untracked status;
3. records current diff and changed-file set;
4. locates exact embedded D97DX source patch from audited D97DX app/ZIP if present;
5. compares expected-vs-current patch globally and by file section;
6. packages evidence for classification.

## Current action
Run D97GT on Intel iMac only.
Do not reset/checkout/apply source before D97GT.
ASUS2 remains untouched in VESA.
