# OCLP7 CHECKPOINT — 2026-09-06 — D97DI helper SHA documentation corrected; build ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DI_STATIC_DESIGN_PASS_BUILD_READY.md` for current execution only with respect to helper identity. All D97DI static design and runtime-precondition classifications from that checkpoint remain valid.

## Entering state
- ASUS2 remains unchanged on D97DD `OCLPMetalCompat.kext` 0.0.4.
- Active config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- Boot args retain `-igfxvesa -ocmcdiag`; `-ocmcd97bv` is absent.
- No Root Patch, no D97DI deployment, no functional D97BV page mutation and no reboot are authorized.
- D97DG already closed the runtime delivery prerequisite for SITE+CAVE on exact Tahoe 25G82.

## D97DI source authority unchanged
Authoritative source:
- path `OCLP-Continuity/artifacts/OCLP7_D97DI_kern_start.cpp`;
- SHA256 `932f979ae8a04112b6ee68309d3b14885a20acf7676eb7cc6e49d06976d9b86b`;
- Git blob `df5f3a67b6117460c0c01b921db1affcb0c6489e`.

D97DI remains STATIC PASS / BUILD READY. Functional writes remain latent behind explicit `-ocmcd97bv`.

## Helper identity correction
Historical helper commit:
`9d867d14c9be80e74ec9cefb50a30597de017959`

Historical helper path:
`OCLP-Continuity/artifacts/OCLP7_D97DI_IMAC_BUILD.sh`

Git blob:
`8cc7f350f6fee51d17a6fbe1bbdfced4554a9ccf`

The previous documentation SHA256 `bbd360dd870e6e0395693cf1fd2caf777ab2cb9c5ddcab02fad8428e8955714e` was incorrect. Commit `cbe38873f6eb7a2654cafb0e4497021397aa7ccd` changed only the SHA text in the static-audit document; it did not change the helper blob.

On the authorized iMac, materializing exact blob `8cc7f350f6fee51d17a6fbe1bbdfced4554a9ccf` produced SHA256:
`faea187c1e1f4b43dabcc231b62f4110c903cf3543f2711324bcbedf7854f49c`.

Because the Git blob matched exactly, the bootstrap correctly stopped on the stale documentation SHA. This is a persistence/tooling correction only, not a D97DI source/build/semantic failure.

Classifications:
- `D97DI_HELPER_GIT_BLOB=AUTHORITATIVE_8cc7f350f6fee51d17a6fbe1bbdfced4554a9ccf`;
- `D97DI_HELPER_SHA256=faea187c1e1f4b43dabcc231b62f4110c903cf3543f2711324bcbedf7854f49c`;
- `D97DI_PREVIOUS_HELPER_SHA_DOCUMENTATION=NEGATIVE_STALE`;
- `D97DI_BUILD=UNTESTED`.

## CURRENT ACTION
On the already-authorized iMac 9900K host, use the corrected authority bootstrap v2 to materialize the exact source and exact historical helper, verify Git blob + corrected SHA256, then execute the helper and return `OCLP7_D97DI_IMAC_BUILD_<timestamp>.zip` for independent audit.

ASUS2 remains unchanged. D97DI deployment, `-ocmcd97bv`, functional page mutation, Root Patch, accelerated boot and reboot remain unauthorized.
