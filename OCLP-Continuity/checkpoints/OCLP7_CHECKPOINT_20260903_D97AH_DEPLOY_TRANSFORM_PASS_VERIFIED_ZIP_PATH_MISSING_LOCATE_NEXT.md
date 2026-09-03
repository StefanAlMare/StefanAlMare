# OCLP7 CHECKPOINT — D97AH deploy transform PASS; verified ZIP path missing; locate next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ASUS2_AUDIT_V2_PASS_DEPLOY_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/wrappers remain ASUS2-only; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH source/build/private-release/ASUS2 artifact audit v2 remain PASS. Exact D97AH ZIP identity remains `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Exact D97AH executable remains `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Exact D97AG live preimage remains expected at `/Applications/OpenCore-Patcher.app`, `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

## Deploy transform tooling evolution
The initial D97AH deploy transform wrapper false-failed because the placeholder contained `D97AG`. A local v3/v4 correction then fixed exactly the validator/tooling defects already proven from the passed D97AG deploy substrate:
- neutral placeholder `__OCLP7_PREIMAGE_ROLE_OLD__`;
- correct `OpenCore-Patcher.app.D97AH-deploying-` cardinality `3` (definition plus two cleanup guards);
- correct final-state marker including shell quotes: `INSTALLED_APP_MUTATION_STATE="D97AH_DEPLOYED_EXACT_OPENED"`.

The final v4 transform passed all old-substrate, identity, required-cardinality, forbidden-stale-identity and semantic-marker gates, then produced and locally parsed exact transformed inner deploy wrapper:

```text
D97AH_DEPLOY_EXACT_ROLE_AND_IDENTITY_TRANSFORM=PASS
D97AH_DEPLOY_PATCHED_WRAPPER_SHA256=590b11ec37b0c9d7162e365460a788132c33881c9bee6599f40af6a9a4381285
D97AH_DEPLOY_PATCHED_WRAPPER_BYTES=14858
D97AH_DEPLOY_PATCHED_WRAPPER_LOCAL_PARSE=PASS
D97AH_DEPLOY_TRANSFORM_WRAPPER=PASS_READY_TO_EXECUTE_INNER
```

## Inner deploy attempt — fail closed before any application mutation
The transformed inner deployment began only far enough to validate local tooling/temp identity/free space and then stopped at the first retained-ZIP gate:

```text
VERIFIED_ZIP=/Users/alex/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip
PRIVATE_TEMP_IDENTITY=501:700:2
APPLICATION_VOLUME_FREE_KB=85391956
D97AH_EXACT_APP_DEPLOY_OPEN_STOP=FAIL_CLOSED|REASON=VERIFIED_ZIP_MISSING_OR_SYMLINK
INSTALLED_APP_MUTATION_STATE=NO
```

Exit recovery explicitly reported:

```text
D97AH_DEPLOY_EXIT_RECOVERY_BEGIN=STATE:NO|RC:2
D97AH_DEPLOY_EXIT_RECOVERY=NOT_REQUIRED_NO_APPLICATION_MUTATION
D97AH_DEPLOY_EXIT_RECOVERY_FINAL_STATE=NO
```

Therefore no sudo stage copy, process drain, backup move, `/Applications` switch, OCLP open, system target mutation, Golden mutation, Root Patch or reboot occurred. Live app remains exact D97AG.

Classification: `D97AH_DEPLOY_ATTEMPT=FAIL_CLOSED_VERIFIED_ZIP_PATH_MISSING_NO_APPLICATION_MUTATION`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not deploy, Root Patch or reboot.

Run one bounded read-only filesystem-location probe for the exact D97AH ZIP only. Search the expected Desktop path first, then same-user Trash and a shallow set of user-visible locations, reporting every regular-file or symlink candidate whose basename matches `OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip` and also any `OCLP7_D97AH*OpenCore-Patcher.app.zip` candidates. For every candidate print path, type/symlink state, bytes and SHA256 when regular. Do not move, copy, rename, delete or re-download anything yet.

If the exact ZIP is found elsewhere with `751494634` bytes and SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`, the next action will restore/copy it to the expected Desktop path using an identity-pinned local step, then STOP before rerunning deploy. If it is not found, use the already audited private-release delivery path to re-create the exact verified Desktop ZIP in a separate bounded step.
