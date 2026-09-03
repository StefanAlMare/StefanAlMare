# OCLP7 CHECKPOINT — D97AH ZIP restored exact; v5 private-temp deploy next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_VERIFIED_ZIP_FOUND_EXACT_IN_TRASH_RESTORE_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/wrappers remain ASUS2-only; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH source/build/private-release/ASUS2 artifact audit v2 remain PASS. Exact D97AH ZIP identity is `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Exact D97AH executable remains `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Exact D97AG remains live until a deployment explicitly succeeds.

## Exact ZIP restore — PASS
ASUS2 copied the exact Trash source to a private Desktop staging file, verified the staging identity, atomically moved staging to the expected Desktop destination, then reverified both destination and retained Trash source.

Decisive evidence:

```text
SOURCE_BYTES=751494634
SOURCE_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_SOURCE_IDENTITY=PASS
STAGED_BYTES=751494634
STAGED_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_STAGED_IDENTITY=PASS
DESTINATION_BYTES=751494634
DESTINATION_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
SOURCE_POST_BYTES=751494634
SOURCE_POST_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_ZIP_RESTORE_DESTINATION_IDENTITY=PASS
D97AH_ZIP_RESTORE_SOURCE_RETAINED_EXACT=PASS
D97AH_VERIFIED_ZIP_RESTORED_TO_EXPECTED_DESKTOP_PATH=PASS
```

No `/Applications`, system target, Golden, Root Patch, snapshot or reboot mutation occurred during restore.

## Second Desktop-path disappearance during deploy v4
A later public v4 deploy wrapper passed its own public blob/parse, exact three validator corrections, v1 transform identity and local parse, then entered the transformed inner deploy. Inner deploy again stopped at its first ZIP-path gate with `VERIFIED_ZIP_MISSING_OR_SYMLINK`, `INSTALLED_APP_MUTATION_STATE=NO`, and explicit `NOT_REQUIRED_NO_APPLICATION_MUTATION` recovery. Therefore no sudo stage, process drain, backup, `/Applications` switch or app open occurred. Live remains D97AG.

Because an exact Desktop copy had just been proven, the repeated disappearance is treated as an external filesystem-location race/dependency rather than an artifact identity failure.

## v5 private-temp-source deploy wrapper
A new public wrapper was created without GitHub execution/testing:

```text
PATH=OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP_V5_TEMP_SOURCE.command
COMMIT=cba4f9aa11574a1ece9f98e084180efcbc63a2a7
GIT_BLOB=58ef14fe7f1fb4944abffcd03b52f3f8c429c133
```

V5 eliminates Desktop persistence from the deploy transaction. It:
1. checks Trash then Desktop for an exact regular non-symlink D97AH ZIP with pinned bytes/SHA256;
2. immediately copies the first exact candidate to a private `/private/tmp/OCLP7_D97AH_DEPLOY_V5.*` source and reverifies the private copy and original source;
3. pins the already ASUS2-passed D97AG deployment substrate commit/blob/SHA256/bytes;
4. directly derives the D97AH inner deployment from that substrate using the already-proven neutral role placeholder, exact D97AH/D97AG identities and correct semantic/cardinality gates;
5. binds inner `VERIFIED_ZIP` to the private temporary exact copy rather than Desktop/Trash;
6. locally parses the inner script before execution;
7. executes the inherited exact D97AG backup/switch/recovery/open flow;
8. deletes only private temp after completion.

If the inner deploy fails after any application mutation, the inherited deploy substrate is responsible for exact D97AG recovery. Root Patch and reboot remain AUTO-NO.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP before v5 execution. Run exactly one public-commit-pinned v5 wrapper execution. Return complete output. Required successful endpoint is exact D97AG preimage proof, exact D97AH staged/private-source proof, timestamped exact D97AG backup, exact D97AH live identity, fresh exact-path D97AH process, `D97AH_EXACT_APP_DEPLOY_OPEN_STOP=PASS`, `D97AH_DEPLOY_V5=PASS`, and STOP.

Do not click Root Patch and do not reboot. Actual privileged D97AH `/usr/bin/chflags` execution remains a later separate manual Root Patch gate only after deploy/open output is audited and accepted.
