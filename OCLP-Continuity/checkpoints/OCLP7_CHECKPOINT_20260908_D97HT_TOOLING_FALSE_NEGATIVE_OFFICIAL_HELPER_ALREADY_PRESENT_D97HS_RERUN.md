# OCLP7 CHECKPOINT — 2026-09-08 — D97HT tooling false-negative / official helper already present / rerun D97HS

## Scope
ASUS2 Tahoe 26.6.2 / 25G82, after exact D97HO Root Patch completed and before reboot.

## Root Patch result already observed
D97HO completed successfully and explicitly reported:
- exact P1 selector bridge PASS: `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- exact P3 serialized-bitcode bridge PASS: `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- new AuxKC built;
- `Patching complete`.
No reboot has occurred.

## First D97HS run
D97HS confirmed:
- VESA active;
- active booted snapshot still native Tahoe;
- active native MTLCompilerService SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- active native CoreDisplay SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128;
- active legacy 32023 absent.
It then stopped because the active privileged helper was observed as DEBUG SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`, Team not set.

## D97HT result / tooling classification
D97HT fetched exact D97HA and exact D97HS successfully.
D97HA then observed the active helper already equal to the official SHA:
`9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`.
Because D97HA is intentionally fail-closed and expects the pre-state to be the exact DEBUG helper, it stopped with:
`ACTIVE_NOT_EXACT_DEBUG_HELPER`.

This is a tooling/precondition false-negative, not a Root Patch/P3 failure. The helper is already in the desired official state, so no helper restoration is needed.

The trailing password prompt is explained by D97HA's EXIT cleanup trap invoking `sudo rm -f` on its temporary staging path even after the precheck fails; it does not indicate a new Root Patch/system mutation.

## Current action
Do NOT reboot.
Do NOT rerun Root Patch.
Do NOT run D97HA again.
Rerun the exact D97HS directly so it can verify the already-official helper and continue to the underlying-System P1/P3, metallib 180/180, and AuxKC checks.

Exact D97HS:
- commit `dcfc861b9bd23a8ac00d7d07c43f4166ea402f18`;
- blob `dd71dbd1149a6c96b3e754ff500f029f536bdef5`.

Classification:
`D97HT_FAILURE=TOOLING_FALSE_NEGATIVE_PRECONDITION_DRIFT`
`OFFICIAL_HELPER_ALREADY_PRESENT=PROVEN_BY_SHA`
`D97HO_ROOTPATCH_P1_P3=NOT_INVALIDATED`
`NEXT=RERUN_EXACT_D97HS_BEFORE_ANY_REBOOT`.
