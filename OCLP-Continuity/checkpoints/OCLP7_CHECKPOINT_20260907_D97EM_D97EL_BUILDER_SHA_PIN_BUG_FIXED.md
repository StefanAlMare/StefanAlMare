# OCLP7 CHECKPOINT — D97EM — D97EL builder SHA pin bug fixed

Date: 2026-09-07 EEST

## User-observed build result
Authorized Intel iMac build attempt of `OCLP7_D97EL_IMAC_BUILD.sh` stopped before generation/compilation with:

- `D97EL_BUILD_STATUS=FAIL`
- `FAIL_REASON=D97EL_generator_sha_mismatch`

No D97EL binary was produced. No ASUS2/EFI/Root Patch/NVRAM/reboot action occurred.

## Root cause
The D97EL telemetry generator itself is still pinned exactly to:

- commit `1fb87c18169a9bd1b74c2b3ff67badc77449c1d4`
- path `OCLP-Continuity/artifacts/OCLP7_D97EL_TELEMETRY_GENERATOR.py`
- Git blob `16fdcd6de0de7681a2abdf4c30716fb81a0d0f3e`

The original build helper contained a manually entered SHA256 expectation that did not match the fetched generator content. The fail-closed check therefore stopped correctly, but the expected SHA value was the defective component.

## Corrected authority
`OCLP-Continuity/artifacts/OCLP7_D97EL_IMAC_BUILD.sh` was corrected at commit:

`b5a063783af782c9f42d51adc75a5aea23191d85`

Corrected builder policy:

1. pin D97EL generator by exact Git commit + path + Git blob;
2. report the fetched generator SHA256 instead of trusting a manually entered SHA256 constant;
3. retain exact D97DL and D97EH authority gates;
4. generate D97EL twice independently from the same pinned D97EH input;
5. require byte-identical output and identical SHA256 before compilation;
6. retain static telemetry-only checks and all no-mutation/no-return-coercion checks;
7. deployment remains unauthorized after build; returned ZIP still requires independent audit.

Corrected downloadable builder identity in the current assistant runtime:

- bytes `10301`
- SHA256 `5ddc863852e55042866b571ff598c989aaf6899770acf8009b4c9285ce5343dd`
- `bash -n` PASS.

## Current action
Rerun only the corrected D97EL builder on the authorized Intel iMac.

Still forbidden:
- any ASUS2 EFI change;
- Root Patch;
- accelerated boot;
- mode-bit masking or return coercion.
