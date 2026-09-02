# OCLP7 CHECKPOINT — 2026-09-03 — D97AF app deploy PASS / manual Root Patch next

## Authority and supersession
This checkpoint supersedes only the execution-state and `CURRENT SINGLE NEXT ACTION` sections of `OCLP7_CHECKPOINT_20260903_D97AF_DEPLOY_FASTLANE_AUDITED_READY.md`.

All accepted D97AF source/build/artifact identities, the functional lineage and every permanent safety invariant remain unchanged. This checkpoint proves the exact D97AF application deployment on ASUS2 and authorizes only the next manual Root Patch action. It does not claim that Root Patch, reboot, accelerated boot or runtime provenance testing has occurred.

## Exact live deployment result
The public-commit-pinned outer wrapper and exact deploy wrapper ran on ASUS2 and both returned RC `0`.

```text
PUBLIC_RELEASE_COMMIT=15c1a141cb362a03c1e63d8bfbb8dac72b693d0e
DEPLOY_WRAPPER_SHA256=e82a5748abd09684a88932380d98d4ae8d83e0bfea94c462866080cfe7b535b4
DEPLOY_WRAPPER_GIT_BLOB=02b4a322eaabb1eff0c3a14089a9ce6508882bc6
DEPLOY_WRAPPER_BYTES=26914
DEPLOY_WRAPPER_IDENTITY=PASS
ACTIVE_GITHUB_LOGIN=StefanAlMare
DEPLOY_OUTER_RC=0
```

The wrapper revalidated the exact completed build run, all 16 successful job steps and immutable artifact:

```text
WORKFLOW_ID=348814365
RUN_ID=33686570072
JOB_ID=100435354962
RUN_HEAD_SHA=76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e
ARTIFACT_ID=9868515225
ARTIFACT_BYTES=751567689
ARTIFACT_SHA256=70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b
ARTIFACT_EXPIRED=False
OUTER_MEMBER_COUNT=8
OUTER_MEMBER_SET=PASS
SHA256SUMS_FILE_SHA256=99ad0f4d1e4b58910274c19da4a89b74dd935d222da0d0c7407a1d4121379ff2
INNER_APP_ZIP_BYTES=751492703
INNER_APP_ZIP_SHA256=728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907
COMPLETE_SHA256SUMS_AND_PACKAGED_EXE=PASS
DOWNLOADED_REPORTS=PASS
```

The staged application and installed preimage passed before mutation:

```text
STAGED_D97AF_EXE_BYTES=6595600
STAGED_D97AF_EXE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
STAGED_D97AF_EXE_ARCH=x86_64
STAGED_D97AF_IDENTITY=PASS
LIVE_D97AD_PREIMAGE_BYTES=6587056
LIVE_D97AD_PREIMAGE_SHA256=5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0
LIVE_D97AD_PREIMAGE=PASS
```

Both exact-path process censuses were empty. The transaction moved exact D97AD to the following recoverable backup and then installed exact D97AF:

```text
D97AD_BACKUP_APP=/Applications/OpenCore-Patcher.app.D97AD-before-D97AF-20260903-013623
D97AD_BACKUP_EXE_SHA256=5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0
LIVE_D97AF_APP=/Applications/OpenCore-Patcher.app
LIVE_D97AF_EXE_BYTES=6595600
LIVE_D97AF_EXE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
LIVE_D97AF_EXE_ARCH=x86_64
LIVE_D97AF_IDENTITY=PASS
FRESH_D97AF_PID=3678
FRESH_PROCESS_PROVENANCE=PASS
INSTALLED_APP_MUTATION_STATE=D97AF_DEPLOYED_EXACT
EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY=PASS
```

Report path returned by the wrapper:

```text
/Users/alex/Desktop/OCLP7_D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY_REPORT_20260903-013623.txt
```

The trailing macOS shell-session message `shell_session_save... parameter not set` occurred after the bounded command returned RC `0`; it is unrelated to D97AF deployment and does not alter the verdict.

## Authoritative execution state

```text
D97AF_LOCAL_SOURCE_INTEGRATION=PROVEN_PASS
D97AF_GITHUB_BUILD=PROVEN_PASS
D97AF_EXTERNAL_ARTIFACT_BYTE_AUDIT=PROVEN_PASS
D97AF_APP_DEPLOY=PROVEN_PASS
D97AF_LIVE_APP_IDENTITY=PROVEN_EXACT_X86_64
D97AD_RECOVERABLE_APP_BACKUP=PROVEN_EXACT
D97AF_ROOT_PATCH=NOT_STARTED
D97AF_REBOOT=NOT_AUTHORIZED
D97AF_ACCELERATED_BOOT=NOT_STARTED
D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED
D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
```

The deployment changed only the installed OCLP application path and created the timestamped D97AD application backup. It did not modify the current system target, root-patched snapshot, Golden, source, Root Patch state or boot state.

## CURRENT SINGLE NEXT ACTION — manual D97AF Root Patch, then STOP
Use only the exact D97AF OCLP application already open from the proven live path. Manually choose `Post-Install Root Patch` / `Start Root Patching` and allow that one operation to finish.

When OCLP reports completion and offers/recommends reboot, do not reboot. STOP and return the complete Root Patch output (or clear photographs/screenshots of every final line) for audit. No Terminal Root Patch command and no automatic reboot are authorized.

Only after the complete Root Patch result is audited may a later checkpoint authorize the accelerated boot.

## Safety invariants
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEX/D97AEZ external task-port method remains retired.
- D97AF UUID remains `A4F456DF-7447-49BF-AC4F-102D90023A1E`.
- Root Patch is authorized only as the manual current action;
- reboot remains unauthorized.
