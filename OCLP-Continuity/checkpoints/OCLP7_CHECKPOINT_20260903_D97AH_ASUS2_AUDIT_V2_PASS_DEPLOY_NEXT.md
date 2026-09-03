# OCLP7 CHECKPOINT — D97AH ASUS2 AUDIT V2 PASS; EXACT DEPLOY/OPEN NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_CMP_PROBE_PASS_AUDIT_V2_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/audits stay on ASUS2; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

Authoritative D97AH v5 build remains workflow/run/job `349436422 / 33769927671 / 100697248264`, head `d04ddd28c784a0b30c6629feeface10804d5d591`. Exact app ZIP is `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`; packaged executable is `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Exact D97AG remains live before the deployment step, executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, `6596544` bytes, x86_64.

## ASUS2 private-release audit v2 — PASS
Public v2 wrapper identity:

```text
PATH=OCLP7_D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT_V2.command
COMMIT=85b5f8b3487cc940918dc446890b959daa7cc4ed
GIT_BLOB=c5a91b5d50a82b17cc4ea2a60303934182540fb0
WRAPPER_SHA256=fb2f29da864f0ea8c4a4e8aa79391ff640d695d085eaf42c8b3fe481dd9836c4
WRAPPER_BYTES=4234
```

The wrapper pinned exact v1 commit/blob, proved exact old/new cmp-line cardinality `1/0 -> 0/1`, produced temporary patched v1 SHA256 `8387e539f5817e03c10177c03a1b249054db7f55ccf619cccf8f1f16ebba366a` / `19941` bytes and locally parsed it successfully. Only `/bin/cmp` -> `/usr/bin/cmp` in the temporary wrapper was changed.

The complete original private-release audit then reran from the beginning and passed all required gates:

```text
D97AH_RELEASE_API_BINDING_AND_ASSET_SET=PASS
D97AH_DOWNLOADED_RELEASE_ASSET_SET=PASS
D97AH_DOWNLOADED_RELEASE_ASSET_IDENTITIES=PASS
D97AH_RELEASE_ASSETS_CHECKSUM_SET=PASS
D97AH_PARTS_CHECKSUM_SET=PASS
D97AH_SPLIT_MANIFEST_IDENTITY=PASS
D97AH_RELEASE_IDENTITY_BINDING=PASS
D97AH_APP_ZIP_REASSEMBLY_AND_CRC=PASS
D97AH_APP_ZIP_SAFE_MEMBER_AUDIT=PASS
D97AH_PACKAGED_EXECUTABLE_IDENTITY=PASS
D97AH_REPORTS_ZIP_SAFE_MEMBER_AUDIT=PASS
D97AH_REPORT_FILE_SET=PASS
D97AH_REPORTS_CHECKSUM_SET=PASS
D97AH_REPORT_AND_APP_EXECUTABLE_BYTE_IDENTITY=PASS
D97AH_REPORT_CONTENT_AUDIT=PASS
D97AH_REPORT_APP_IDENTITY=PASS
D97AH_ASUS2_PRIVATE_RELEASE_DOWNLOAD=PASS
D97AH_ASUS2_ARTIFACT_REASSEMBLY=PASS
D97AH_ASUS2_PACKAGED_EXECUTABLE_IDENTITY=PASS
D97AH_ASUS2_REPORTS_AUDIT=PASS
D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=PASS
D97AH_AUDIT_V2=PASS
D97AH_AUDIT_V2_OUTER_RC=0
```

Exact reassembled ZIP evidence:

```text
REASSEMBLED_APP_ZIP_BYTES=751494634
REASSEMBLED_APP_ZIP_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
```

Exact packaged executable evidence:

```text
PACKAGED_EXE_BYTES=6596544
PACKAGED_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
PACKAGED_EXE_ARCHS=x86_64
```

The reports-carried executable is byte-identical to the app ZIP executable, and all exact D97AH source/package/LOAD_CONST/xattr/fatal-boundary evidence in the reports passed.

## Verified local D97AH ZIP retained
The complete PASS retained the exact verified app ZIP at:

`/Users/alex/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip`

Retention state: `VERIFIED_APP_ZIP_RETAINED=NEW_EXACT`.

Audit report:

`/Users/alex/Desktop/OCLP7_D97AH_ASUS2_PRIVATE_RELEASE_AUDIT_REPORT_20260903-185409-11761.txt`

## Exact deploy/open wrapper prepared
Public wrapper prepared without GitHub execution/testing:

```text
PATH=OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command
COMMIT=fe47aa9c06bd416d387e3f64a137b18d471479c1
GIT_BLOB=55304b6e3db1d1d9ab4e86b7e3b9aa154a744567
```

It pins the previously ASUS2-passed D97AG deploy substrate at commit `fcd817dec08e1ff782316516f7d2432e2b5d51df`, blob `e8dca8761903de7f612629ff85ea9ec81bc5d65c`, SHA256 `64d7ceb501c8b909b7633a836c371257f1e2c48fd13d4f1f290095b6a4123c96`, `14858` bytes. In a private temporary copy it performs a collision-safe role shift (`D97AF -> D97AG`, `D97AG -> D97AH`) and exact identity replacements for verified run `33769927671`, D97AH ZIP/executable and D97AG live preimage. It validates critical pre/post cardinalities, required deployment/recovery semantic markers and forbidden stale D97AF/old-run identities, locally parses the transformed deploy script, then executes it on ASUS2. It preserves the previously proven switch/recovery mechanism rather than inventing a new deployment implementation.

## Mutation ledger

```text
SOURCE_MUTATION=NO
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

Therefore D97AH build/package/delivery/ASUS2 artifact and report audit are complete. The actual privileged D97AH `/usr/bin/chflags` path remains untested until the later manual real Root Patch.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Run exactly one separate ASUS2 state-changing action through the public-commit-pinned deploy/open wrapper above: verify the retained D97AH ZIP again, stage exact D97AH, prove current live app is exact D97AG, create a timestamped exact D97AG backup, drain only the exact live OCLP executable path, switch `/Applications/OpenCore-Patcher.app` to exact D97AH, verify the live executable identity, open exact D97AH, prove a fresh exact-path process and STOP.

Required preimage/live identities:
- current D97AG live executable: `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64;
- new D97AH executable: `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf` / x86_64.

The deployment action must retain the exact D97AG backup and fail closed with automatic D97AG restoration if the switch/audit/open sequence fails before final exact-open state.

STOP immediately after exact D97AH open/proof. Do not Root Patch and do not reboot. Root Patch remains a separate later manual gate only after the deploy/open output is returned and accepted.