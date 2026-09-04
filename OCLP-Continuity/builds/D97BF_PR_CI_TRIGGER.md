# D97BF PR CI trigger

This file exists only to trigger the pull-request CI lane for the D97BF Golden OCLP + one-line Tahoe eligibility build.

It has no functional relationship to OpenCore Legacy Patcher source, payloads, selector/compiler/donor logic, Root Patch, or ASUS2 state.

Expected workflow: `.github/workflows/oclp-d97bf-golden-tahoe-eligibility-build.yml`.
Expected Golden source: `dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`.
Expected functional delta: only `_max_os = os_data.sequoia.value` -> `_max_os = os_data.tahoe.value` in exact Golden `detect.py`.
