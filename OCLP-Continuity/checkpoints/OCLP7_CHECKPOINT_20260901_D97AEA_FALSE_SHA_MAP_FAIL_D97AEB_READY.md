# OCLP7 CHECKPOINT — 2026-09-01 — D97AEA false SHA-map fail / D97AEB ready

## Retained static authority
D97AC finite-path outcome partition remains STATIC PROVEN with the mandatory runtime liveness gate. D97AD exact transition remains FULL PASS:
- selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- D97Z is to be removed, D97 replaced rather than stacked, selector/control/P6/P7 retained.

## D97AEA observed result
The pinned wrapper/core identities, zsh/Python compilation, precheck, exact service transition, exact D97-to-P7 reconstruction, all six outcome postimages, non-overlap and synthetic disassembly all passed.

D97AEA then stopped in `SOURCE PREIMAGE AUDIT` before source integration, build or deploy. It printed the actual P6 helper segment SHA:

`ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a`

and immediately raised `helper segment SHA mismatch` for P6. This actual SHA is the retained authoritative P6 helper SHA. The D97AE expected-helper table had the P6/P7 SHA literals reversed. Therefore:

`D97AEA_SOURCE_PREIMAGE_AUDIT=FALSE_FAIL_P6_P7_EXPECTED_SHA_MAP`

No runtime patch design, patch bytes, source transition, service, MTLCompiler, live app, Root Patch or boot state was changed. Failure rollback was invoked; the next run rechecks all exact preimages regardless.

## D97AEB correction wrapper
Artifact `OCLP7_D97AEB_P6_P7_SHA_MAP_FIX_WRAPPER.command`:
- commit `d95e9451cfe0f4b3aa447150d1e481d9ab635a83`;
- blob `d9f3bed3882e268c22ec3b37cc285c4a7228dd37`.

D97AEB reconstructs the exact original D97AE core from its four pinned payload blobs and requires decompressed SHA256 `d8166ed5697cf281a60b19dba4c902470c4900de740006431d7cff5580fa5bb6`. It modifies only the two expected P6/P7 SHA literals inside the unique embedded Python block owning the failing `helper segment SHA mismatch` gate. It proves that all other text and all runtime-design anchors remain unchanged, compiles every embedded Python block, parses the corrected zsh core and then executes the complete D97AE FASTLANE.

Authoritative values:
- P6 helper segment `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a`;
- P7 helper segment `a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b`.

## CURRENT ACTION
Run D97AEB only and return:
- `OCLP7_D97AEB_P6_P7_SHA_MAP_FIX_WRAPPER_REPORT.txt`;
- `OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_REPORT.txt`.

Do not Root Patch or reboot even if D97AEB and D97AE return PASS. Manual Root Patch requires a separate full assistant audit.
