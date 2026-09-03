# OCLP7 CHECKPOINT — D97AH exact deploy/open PASS; manual Root Patch next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ASUS2_AUDIT_V2_PASS_DEPLOY_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH authoritative build remains workflow/run/job `349436422 / 33769927671 / 100697248264`, head `d04ddd28c784a0b30c6629feeface10804d5d591`. Exact D97AH app ZIP is `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`; packaged executable is `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

## Artifact location note
The user explicitly clarified that the repeated disappearance of the verified Desktop ZIP was caused by manually deleting visible Desktop files between assistant steps, not by OCLP or system behavior. The exact audited Trash copy remained available and the one-shot action recreated the exact Desktop ZIP before deploy.

Immediately before deploy, the one-shot gate proved both Trash source and recreated Desktop target exact:

```text
TRASH_BYTES=751494634
TRASH_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_TRASH_SOURCE_EXACT=PASS
STAGE_BYTES=751494634
STAGE_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_DESKTOP_STAGE_EXACT=PASS
D97AH_DESKTOP_RECREATED_FROM_TRASH=PASS
DESKTOP_BYTES=751494634
DESKTOP_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
TRASH_POST_BYTES=751494634
TRASH_POST_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_DESKTOP_AND_TRASH_EXACT_BEFORE_DEPLOY=PASS
```

## D97AH deploy transform / wrapper audit PASS
Public deploy v4 wrapper commit/blob:

```text
COMMIT=ed4da377f96b4f2edad0b84565e6a98180f4e4d4
GIT_BLOB=f553e36b20e5c2c8fe87d370df039e2a8f0f9e58
WRAPPER_SHA256=18cb2a0ca21d9a854488d235e7acf781f1542397b97597552ff0e244634d949c
WRAPPER_BYTES=5356
```

It applied the three already-audited tooling-only corrections to the pinned D97AH deploy-transform substrate: neutral role placeholder, correct `D97AH-deploying` cardinality `3`, and quoted final-state semantic marker. The transformed wrapper passed exact identity and local parse gates:

```text
D97AH_DEPLOY_V4_EXACT_THREE_VALIDATOR_LINES=PASS
D97AH_DEPLOY_V4_PATCHED_SHA256=8ba432e8dd1ac42de85213db1752eecdb7bb5fd823bb93fbfb054ae7857d90ad
D97AH_DEPLOY_V4_PATCHED_BYTES=7779
D97AH_DEPLOY_V4_PATCHED_LOCAL_PARSE=PASS
D97AH_DEPLOY_V4_READY_TO_EXECUTE_FULL_PINNED_FLOW=PASS
D97AH_DEPLOY_EXACT_ROLE_AND_IDENTITY_TRANSFORM=PASS
D97AH_DEPLOY_PATCHED_WRAPPER_SHA256=590b11ec37b0c9d7162e365460a788132c33881c9bee6599f40af6a9a4381285
D97AH_DEPLOY_PATCHED_WRAPPER_BYTES=14858
D97AH_DEPLOY_PATCHED_WRAPPER_LOCAL_PARSE=PASS
D97AH_DEPLOY_TRANSFORM_WRAPPER=PASS_READY_TO_EXECUTE_INNER
```

## Exact ASUS2 D97AG -> D97AH deployment PASS
The inner deployment re-verified the D97AH ZIP exact:

```text
VERIFIED_ZIP_BYTES_ACTUAL=751494634
VERIFIED_ZIP_SHA256_ACTUAL=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
```

Staged D97AH identity:

```text
STAGED_EXE_BYTES=6596544
STAGED_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
STAGED_EXE_ARCHS=x86_64
D97AH_STAGED_APP_IDENTITY=PASS
```

Exact live D97AG preimage before mutation:

```text
LIVE_PRE_BYTES=6596544
LIVE_PRE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
LIVE_PRE_ARCHS=x86_64
D97AG_LIVE_PREIMAGE=PASS
```

After sudo staging, exact new app beside live:

```text
NEW_EXE_BYTES=6596544
NEW_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
NEW_EXE_ARCHS=x86_64
D97AH_NEW_APP_READY_EXACT=PASS
```

Exact-path process drain was clean:

```text
PRE_DRAIN_EXACT_PIDS=NONE
POST_DRAIN_EXACT_PIDS=NONE
D97AG_EXACT_PATH_PROCESS_DRAIN=PASS
```

Timestamped exact D97AG backup retained:

`/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`

Backup executable evidence:

```text
BACKUP_EXE_BYTES=6596544
BACKUP_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
```

D97AH live after switch:

```text
LIVE_POST_BYTES=6596544
LIVE_POST_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
LIVE_POST_ARCHS=x86_64
LIVE_POST_FILE=/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher: Mach-O 64-bit executable x86_64
D97AH_LIVE_APP_IDENTITY=PASS
```

Fresh exact-path process after open:

```text
PRE_OPEN_EXACT_PIDS=NONE
FRESH_D97AH_EXACT_PIDS=13110
FINAL_LIVE_EXE_BYTES=6596544
FINAL_LIVE_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
D97AH_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AH_DEPLOYED_EXACT_OPENED
```

All wrapper layers returned success:

```text
D97AH_DEPLOY_OUTER_RC=0
D97AH_DEPLOY_V4_WRAPPER_RC=0
D97AH_ONE_SHOT_DEPLOY_OUTER_RC=0
```

Deploy report:

`/Users/alex/Desktop/OCLP7_D97AH_EXACT_APP_DEPLOY_OPEN_STOP_REPORT_20260903-200708.txt`

## Mutation ledger after deploy/open

```text
INSTALLED_APP_MUTATION=YES_EXACT_D97AG_TO_D97AH_WITH_EXACT_D97AG_BACKUP_RETAINED
SOURCE_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

Therefore FASTLANE through exact packaged-app audit, identity, backup/deploy, open and fresh-process proof is complete PASS for D97AH.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
D97AH exact application is live and open. Manual Root Patch is now the next separately authorized ASUS2 action. Root Patch must be initiated manually by the user from the currently open exact D97AH OCLP application. Return the complete Root Patch output before any reboot.

The real Root Patch is specifically required to prove the previously untested privileged D97AH transaction beyond the old D97AG `/bin/chflags` failure: `/usr/bin/chflags` must execute in the real path; staged postimage `dd`, staged metadata verification, exact postimage SHA/UUID, target CAS, atomic target rename/commit, later patchset/AuxKC and snapshot behavior must be classified from raw output only.

Do not reboot after Root Patch until its complete output has been audited. Accelerated boot remains separately unauthorized until that audit.
