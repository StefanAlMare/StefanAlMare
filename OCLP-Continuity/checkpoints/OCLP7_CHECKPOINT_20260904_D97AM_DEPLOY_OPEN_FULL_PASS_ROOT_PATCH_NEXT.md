# OCLP7 CHECKPOINT — 2026-09-04 — D97AM exact deploy/open FULL PASS; manual Root Patch next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell, SMBIOS `MacBookAir6,2`. Routine/small work remains ASUS2-only; GitHub only for major compile/build/package. Golden Sequoia remains immutable/read-only. Root Patch and reboot remain manual-only and separately authorized. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_ASUS2_ARTIFACT_AUDIT_FULL_PASS_DEPLOY_OPEN_NEXT.md`.

## D97AM build/artifact state retained
Authoritative D97AM GitHub v3 build/private release remains FULL PASS:
- private repo `StefanAlMare/Private-Work`;
- branch `oclp7-d97am-github-build`;
- head `6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d`;
- workflow/run/job `349724427 / 33812721798 / 100838020678`;
- release ID/tag `382366988 / oclp7-d97am-run-33812721798-attempt-1`;
- app ZIP `751495650` bytes / SHA256 `d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca`;
- packaged executable `6596496` bytes / SHA256 `fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3` / x86_64.

ASUS2 private-release artifact audit V2 remains FULL PASS, including 7/7 local assets, checksum files, two-part reassembly, ZIP CRC/safe members, exact embedded executable, reports ZIP CRC/safe members and report/content binding.

## D97AM exact ASUS2 deploy/open — FULL PASS
Public deploy/open wrapper:
- commit `e2284bc23dc90aac0b926b0012b4724af28a33a0`;
- blob `577acb4f98dd3c0bbdd20ccdc46962a3284d394c`.

Outer wrapper identity and zsh parse passed exactly before any mutation.

### Private release reacquisition / staging
The deploy flow re-bound the exact release ID/tag/head and exact two split assets, then redownloaded and verified both parts:

```text
PART0_BYTES=390000000
PART0_SHA256=9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67
PART1_BYTES=361495650
PART1_SHA256=80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08
D97AM_DEPLOY_TWO_PART_LOCAL_IDENTITIES=PASS
```

Reassembled app ZIP:

```text
VERIFIED_ZIP_BYTES_ACTUAL=751495650
VERIFIED_ZIP_SHA256_ACTUAL=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca
D97AM_DEPLOY_REASSEMBLED_ZIP_IDENTITY=PASS
```

Staged executable:

```text
STAGED_EXE_BYTES=6596496
STAGED_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
STAGED_EXE_ARCHS=x86_64
D97AM_STAGED_APP_IDENTITY=PASS
```

### Exact live D97AH preimage revalidated
Before switching `/Applications/OpenCore-Patcher.app`, exact live D97AH was revalidated:

```text
LIVE_PRE_BYTES=6596544
LIVE_PRE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
LIVE_PRE_ARCHS=x86_64
D97AH_LIVE_PREIMAGE=PASS
```

No exact-path OCLP process was running before the switch.

### Backup / switch / live identity
Timestamped exact D97AH backup created and retained:
`/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`.

Backup executable remained exact D97AH `6596544 / 207b4e...`.

Exact new live D97AM identity:

```text
LIVE_POST_BYTES=6596496
LIVE_POST_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
LIVE_POST_ARCHS=x86_64
D97AM_LIVE_APP_IDENTITY=PASS
```

Existing older D97AG backup remains untouched.

### Fresh-process proof
Before open, exact live-path process set was empty. Opening `/Applications/OpenCore-Patcher.app` produced fresh exact-path PID `2980`.

Final live executable was reverified exact:

```text
FINAL_LIVE_EXE_BYTES=6596496
FINAL_LIVE_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
FRESH_D97AM_EXACT_PIDS=2980
D97AM_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AM_DEPLOYED_EXACT_OPENED
```

Deployment report:
`/Users/alex/Desktop/OCLP7_D97AM_EXACT_APP_DEPLOY_OPEN_STOP_REPORT_20260904-020713.txt`.

## Classification
`D97AM_ASUS2_EXACT_APP_DEPLOY_OPEN=FULL_PASS`.

This proves installed-app identity and fresh-process provenance only. It is not Root Patch, root-patched target, accelerated boot, GUI-success or runtime-semantic evidence.

Mutation ledger:
- local project source: unchanged;
- installed OCLP app: exact D97AM deployed/opened;
- system root target: unchanged;
- Golden: unchanged;
- Root Patch: AUTO-NO;
- reboot: AUTO-NO.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
FASTLANE through `backup/deploy -> open OCLP -> STOP` is complete and audited.

The next bounded ASUS2 action is **manual Root Patch from the already-open exact D97AM app**. The user may click `Start Root Patching` / perform the normal OCLP Root Patch manually only after assistant authorization based on this checkpoint.

Expected critical D97AM transaction during Root Patch:
1. P1/P2b/P3/AIR00/D34/P6/P7 stages pass as before;
2. D97AD classifier must NOT run at all;
3. D97AM natural-flow stamp must accept exact P7 preimage SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
4. UUID transition must be exact `D5CE0008-587C-3861-971A-4BAEFB7B9C5B -> 0FC4C627-2A5D-491B-8101-00CAAA7116B7`;
5. exact target post-SHA must become `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`;
6. D97AG xattr/fatal-boundary and D97AH `/usr/bin/chflags` semantics must remain operational;
7. downstream AuxKC/APFS snapshot/unmount/patch completion must complete normally.

STOP after Root Patch output. Do not reboot yet. The complete Root Patch terminal/app output must be returned and audited before accelerated boot authorization.