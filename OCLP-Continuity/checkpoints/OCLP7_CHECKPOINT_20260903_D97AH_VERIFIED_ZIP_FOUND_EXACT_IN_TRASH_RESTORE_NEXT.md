# OCLP7 CHECKPOINT — D97AH verified ZIP found exact in Trash; restore next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_DEPLOY_TRANSFORM_PASS_VERIFIED_ZIP_PATH_MISSING_LOCATE_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/wrappers remain ASUS2-only; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH build/private-release/ASUS2 artifact audit v2 remain PASS. Exact D97AH ZIP identity is `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Exact D97AH executable remains `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Exact D97AG remains live before successful deployment.

## Read-only location probe — PASS
ASUS2 proved the previously audited exact verified ZIP exists at:

`/Users/alex/.Trash/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip`

Direct evidence:

```text
SYMLINK=NO
REGULAR_FILE=YES
BYTES=751494634
SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
MTIME=2026-09-03 18:55:53
MODE=-rw-r--r--
UID=501
GID=20
FLAGS=-
CANDIDATE_EXACT_IDENTITY=PASS
FOUND_ANY_CANDIDATE=1
FOUND_EXACT_D97AH_ZIP=1
```

Probe mutation ledger:

```text
SOURCE_MUTATION=NO
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
SNAPSHOT_MUTATION=NO
REBOOT=AUTO-NO
```

Therefore no re-download/reassembly/build is required. The artifact itself is unchanged and exact; only its filesystem location differs from the deploy wrapper's required Desktop path.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not deploy, Root Patch or reboot.

Run one bounded local restore step only: require the Trash source to be an exact regular non-symlink file with the pinned bytes/SHA256; require the Desktop destination to be absent; copy it with metadata preservation to `/Users/alex/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip`; verify destination exact bytes/SHA256 and regular non-symlink status; leave the Trash source untouched; STOP.

Do not run the deploy in the same action. Only after the restored Desktop ZIP output is returned and accepted may the already-derived exact D97AG->D97AH deploy/open action be rerun. Root Patch and reboot remain unauthorized.
