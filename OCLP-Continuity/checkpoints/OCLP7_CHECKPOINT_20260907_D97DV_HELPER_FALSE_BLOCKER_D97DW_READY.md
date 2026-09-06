# OCLP7 CHECKPOINT — D97DV official-helper build-host false blocker; D97DW ready

Date: 2026-09-07 EEST

## Entering state
- ASUS2 unchanged: Tahoe 26.6.2 / 25G82, VESA, D97DL 0.0.7 active, `-ocmcd97bv` active, no Root Patch.
- D97DT full D97BV VESA pair remains CLOSED PASS.
- D97DU native-Metal-safe Root Patch design remains unchanged.

## D97DV returned output
D97DV authority and base-helper identities passed.
D97DV transformations passed:
- build-host MetallibSupportPkg requirement removed;
- Python 3.13 x86_64 pin active.

Runtime preflight then proved:
- Python selected exactly `3.13.15` at `/usr/local/bin/python3.13`;
- build-host exact 25G82 MetallibSupportPkg no longer required;
- target-only 25G82 path contract recorded.

The run stopped before clone/build at:
`FATAL: Exact official helper 9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a not found.`

## Classification
This is a BUILD-HOST PREFLIGHT DEFECT ONLY.
Historical D97BJ evidence proves the official helper restore asset was not part of Root Patch functionality. D97BJ Root Patch had already completed successfully while the DEBUG helper remained installed; restoring the official helper was a separate post-run safety cleanup before reboot.

Therefore requiring the official restore asset on the iMac build host is unnecessary.

No clone/build, Root Patch, EFI mutation, system patch mutation or reboot occurred.

## D97DW correction
D97DW keeps D97DU Root Patch semantics byte-policy-equivalent and changes only helper logistics:
- no official helper required on build host;
- no official helper bundled from build host;
- generated target wrapper fail-closes unless ASUS2 currently has the exact official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a` and TeamIdentifier `S74BDJXQMD`;
- before any DEBUG-helper swap, wrapper saves the exact current official helper on ASUS2 and verifies the saved copy;
- DEBUG helper is temporary;
- primary restore path explicitly reinstalls and verifies the saved official helper immediately after the custom OCLP exits;
- EXIT/HUP/INT/TERM trap is retained only as secondary restore fallback.

Authority:
- `OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_V3.sh`
- commit `738390d5a7dedec8b2d67f43baf6a9ef34c3a084`
- Git blob `9d8c8ddc25a1359af0192e657fddd6765015f984`
- local generator syntax check `bash -n=PASS`.

Pinned bootstrap:
- `OCLP-Continuity/artifacts/OCLP7_D97DW_IMAC_BUILD_AUTHORITY_BOOTSTRAP.sh`
- commit `9ac756f949f2843ddfd32d013d7a02550d9ba7c0`.

## CURRENT ACTION
Run only the pinned D97DW bootstrap on the authorized Intel iMac build host.

Still NOT authorized:
- Root Patch;
- EFI changes;
- removal of `-igfxvesa`;
- accelerated reboot.
