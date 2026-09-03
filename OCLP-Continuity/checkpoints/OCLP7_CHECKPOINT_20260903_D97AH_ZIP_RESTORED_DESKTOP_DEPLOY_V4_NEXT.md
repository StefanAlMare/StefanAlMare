# OCLP7 CHECKPOINT — D97AH verified ZIP restored to Desktop; deploy v4 next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_VERIFIED_ZIP_FOUND_EXACT_IN_TRASH_RESTORE_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/wrappers remain ASUS2-only; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH source/build/private-release/ASUS2 artifact audit v2 remain fully PASS. Exact D97AH ZIP identity remains `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Exact D97AH executable remains `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Exact D97AG remains live before successful deployment: executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

## Exact ZIP restore — PASS
ASUS2 restored the exact audited D97AH ZIP from same-user Trash to the expected Desktop path using an exact source -> staging -> destination identity-gated copy. No application/system/Golden/Root Patch/reboot mutation occurred.

Source before copy:

```text
SOURCE=/Users/alex/.Trash/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip
SOURCE_BYTES=751494634
SOURCE_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_SOURCE_IDENTITY=PASS
```

Staging copy:

```text
STAGED_BYTES=751494634
STAGED_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_STAGED_IDENTITY=PASS
```

Final expected Desktop destination:

```text
DESTINATION=/Users/alex/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip
DESTINATION_BYTES=751494634
DESTINATION_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_DESTINATION_IDENTITY=PASS
D97AH_VERIFIED_ZIP_RESTORED_TO_EXPECTED_DESKTOP_PATH=PASS
```

Trash source remained exact after copy:

```text
SOURCE_POST_BYTES=751494634
SOURCE_POST_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_SOURCE_RETAINED_EXACT=PASS
```

## Deploy transform status carried forward
The final local v4 transform already passed all old-substrate, identity, required-cardinality, forbidden-stale-identity and semantic-marker gates and produced a locally parsed exact transformed inner deploy wrapper:

```text
D97AH_DEPLOY_EXACT_ROLE_AND_IDENTITY_TRANSFORM=PASS
D97AH_DEPLOY_PATCHED_WRAPPER_SHA256=590b11ec37b0c9d7162e365460a788132c33881c9bee6599f40af6a9a4381285
D97AH_DEPLOY_PATCHED_WRAPPER_BYTES=14858
D97AH_DEPLOY_PATCHED_WRAPPER_LOCAL_PARSE=PASS
D97AH_DEPLOY_TRANSFORM_WRAPPER=PASS_READY_TO_EXECUTE_INNER
```

The previous inner deploy attempt stopped before any application mutation only because the Desktop ZIP path was absent then. That cause is now removed by the exact restore above.

## Public pinned deploy v4 wrapper
A short public wrapper was created without GitHub execution/testing:

```text
PATH=OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP_V4.command
COMMIT=ed4da377f96b4f2edad0b84565e6a98180f4e4d4
GIT_BLOB=f553e36b20e5c2c8fe87d370df039e2a8f0f9e58
```

It pins the previous D97AH deploy-transform wrapper `fe47aa9c06bd416d387e3f64a137b18d471479c1 / 55304b6e3db1d1d9ab4e86b7e3b9aa154a744567`, applies exactly the three validator corrections already ASUS2-proven (neutral placeholder, `deploying` cardinality 3, quoted final-state marker), requires the patched v4 wrapper SHA256 `8ba432e8dd1ac42de85213db1752eecdb7bb5fd823bb93fbfb054ae7857d90ad` and bytes `7779`, locally parses it and then executes the complete pinned deployment flow on ASUS2.

## Mutation ledger before deploy

```text
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP before deploy. Run exactly one execution of the public-commit-pinned deploy v4 wrapper. It must re-verify the restored exact D97AH Desktop ZIP, extract/prove exact staged D97AH, prove current live D97AG, prepare exact D97AH beside live after sudo gate, drain only exact OCLP live path, retain timestamped exact D97AG backup, switch D97AH live, verify live D97AH bytes/SHA/arch, open exact D97AH, prove a fresh exact-path process and STOP.

If anything fails after application mutation begins, inherited recovery must restore exact D97AG unless final exact D97AH-open state was already reached.

Do not Root Patch and do not reboot after deploy/open. Return complete terminal output for audit. Root Patch remains a separate later manual gate only after deploy/open is accepted.
