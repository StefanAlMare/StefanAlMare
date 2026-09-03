# OCLP7 CHECKPOINT — 2026-09-04 — D97AM ASUS2 private-release artifact audit FULL PASS; deploy/open next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell, SMBIOS `MacBookAir6,2`. Routine/small work stays on ASUS2; GitHub is only for major compilation/build/package. Golden Sequoia remains immutable/read-only. Root Patch and reboot remain manual-only and separately authorized. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_GITHUB_BUILD_RELEASE_FULL_PASS_ASUS2_ARTIFACT_AUDIT_NEXT.md`.

## D97AM design/build state retained
D97AM removes the active D97AD terminal classifier as a whole while retaining its helper definition dormant. Active path remains selector -> true-five control -> P6 -> P7 -> D97AM P7-natural-flow provenance stamp. New UUID remains `0FC4C627-2A5D-491B-8101-00CAAA7116B7`; expected root-patched 32023 image post-SHA remains `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

Exact local source identities remain:

```text
HELPERS_SHA256=7c1127a62379ea5cef9efd42f5d14e7956def01e6f7635defe4f64e77473a844
SYSPATCH_SHA256=78e096b982c8a2e8c78f8bd18b32fc0961fa84e26d573a8d8fa304393d6a29a3
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AM_METHOD_SHA256=45e3b803a52fc876b0a1c4ebae6fe23878f32febc44368c4aaf32453170dcc6f
D97AD_ACTIVE_CALL_COUNT=0
D97AD_HELPER_DEFINITION_DORMANT_COUNT=1
P7_NATURAL_FLOW_PRE_SHA256=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
P7_NATURAL_FLOW_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
P7_NATURAL_FLOW_EXPECTED_POST_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
```

Authoritative GitHub v3 build/private release remains FULL PASS:

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97am-github-build
HEAD_SHA=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d
WORKFLOW_ID=349724427
RUN_ID=33812721798
JOB_ID=100838020678
RELEASE_ID=382366988
RELEASE_TAG=oclp7-d97am-run-33812721798-attempt-1
RELEASE_ASSET_COUNT=7
```

Packaged executable authoritative identity: `6596496` bytes / SHA256 `fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3` / x86_64. App ZIP authoritative identity: `751495650` bytes / SHA256 `d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca`.

## ASUS2 artifact audit V1 — tooling false failure only
Public auditor V1:
- commit `80f652130f6d0fc32319b727211576388cdb3b10`;
- blob `7fb4215818665850b7e42e61d4e96c1ffe7568e0`.

V1 successfully proved release/tag/head/7-asset metadata, downloaded all seven assets, verified all seven local size/SHA identities, verified `RELEASE-ASSETS.SHA256`, and verified `PARTS.SHA256`. It then stopped because the auditor incorrectly required `GITHUB_REPOSITORY=StefanAlMare/Private-Work` inside `D97AM_SPLIT_MANIFEST.env`.

The authoritative build generator never wrote `GITHUB_REPOSITORY` into that manifest. It wrote `GITHUB_RUN_ID`, `GITHUB_RUN_ATTEMPT`, `GITHUB_HEAD_SHA`, and mutation/rootpatch/reboot markers. Repository binding is independently and strongly enforced through the private release API endpoint `repos/StefanAlMare/Private-Work/...` plus exact release ID/tag/head and exact seven asset IDs.

Classification: `D97AM_ASUS2_ARTIFACT_AUDIT_V1=TOOLING_FALSE_FAILURE_REDUNDANT_NONEXISTENT_MANIFEST_FIELD_AFTER_7_OF_7_ASSET_IDENTITY_PASS`.

## ASUS2 artifact audit V2 — FULL PASS
V2 wrapper:
- commit `4d41ac00685d325910360a05d9b816e130e0fd15`;
- blob `086c1c866519232276c6f4f26c911c4c21a003ea`.

V2 fetched and verified exact V1 blob, removed exactly one redundant manifest requirement (`"GITHUB_REPOSITORY": repo,`) in memory, reported patched inner SHA256 `f23c277b94a6e9429257cc114fd4ff6eee9142341e73e26f11b9d5b5467eea62`, Git blob `cb169604046e0519559b172cb30a5b8069cb845c`, and parsed the patched shell successfully. No other audit logic changed.

Raw ASUS2 V2 evidence:

```text
RELEASE_ID=382366988
RELEASE_TAG=oclp7-d97am-run-33812721798-attempt-1
RELEASE_TARGET_HEAD=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d
RELEASE_ASSET_COUNT=7
D97AM_RELEASE_METADATA_BINDING=PASS
D97AM_ALL_SEVEN_LOCAL_ASSET_IDENTITIES=PASS
D97AM_RELEASE_ASSETS_SHA256_FILE=PASS
D97AM_PARTS_SHA256_FILE=PASS
D97AM_SPLIT_MANIFEST_CONTENT=PASS
D97AM_RELEASE_IDENTITY_CONTENT=PASS
REASSEMBLED_APP_ZIP_BYTES=751495650
REASSEMBLED_APP_ZIP_SHA256=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca
D97AM_TWO_PART_REASSEMBLY_LOCAL=PASS
APP_ZIP_MEMBER_COUNT=171
APP_ZIP_CRC=PASS
APP_ZIP_SAFE_MEMBERS=PASS
APP_ZIP_EXECUTABLE_BYTES=6596496
APP_ZIP_EXECUTABLE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
APP_ZIP_EXECUTABLE_ARCHS=x86_64
D97AM_APP_ZIP_EXECUTABLE_EXACT=PASS
REPORTS_ZIP_MEMBER_COUNT=12
REPORTS_ZIP_CRC=PASS
REPORTS_ZIP_SAFE_MEMBERS=PASS
REPORTS_FILE_COUNT_NON_APPLEDOUBLE=11
REPORTS_PACKAGED_EXECUTABLE_BYTES=6596496
REPORTS_PACKAGED_EXECUTABLE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
REPORTS_SPLIT_MANIFEST_BYTE_IDENTITY=PASS
D97AM_REPORTS_CONTENT_BINDING=PASS
D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=FULL_PASS
D97AM_VERIFIED_APP_ZIP_BYTES=751495650
D97AM_VERIFIED_APP_ZIP_SHA256=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca
D97AM_VERIFIED_PACKAGED_EXE_BYTES=6596496
D97AM_VERIFIED_PACKAGED_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
D97AM_VERIFIED_PACKAGED_ARCH=x86_64
```

The reports archive additionally bound exact source-audit/build-audit/transform markers, exact packaged executable byte identity, and exact split-manifest byte identity.

Mutation ledger for artifact audit V2:
- source mutation: NO;
- installed app mutation: NO;
- system target mutation: NO;
- Golden mutation: NO;
- Root Patch: AUTO-NO;
- reboot: AUTO-NO.

Classification: `D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=FULL_PASS`.

## Current installed preimage
Per previous authoritative state, live app is still exact D97AH at `/Applications/OpenCore-Patcher.app` and must be revalidated before any switch. Expected live D97AH executable:

```text
LIVE_PREIMAGE_BYTES=6596544
LIVE_PREIMAGE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
LIVE_PREIMAGE_ARCH=x86_64
```

Existing retained D97AG backup remains `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708` and must not be overwritten.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
FASTLANE artifact/package verification is complete. The next bounded ASUS2 action is exact **backup/deploy/open/STOP** for D97AM only:
1. reacquire or reconstruct the exact D97AM app ZIP from the exact private release using pinned release/asset identities;
2. verify app ZIP exact `751495650` bytes / SHA256 `d6aca517...` and staged executable exact `6596496` bytes / SHA256 `fbcb69e...` / x86_64;
3. revalidate exact current live D97AH preimage `6596544` / `207b4e...` / x86_64;
4. create a timestamped exact D97AH backup beside `/Applications` without touching the older D97AG backup;
5. deploy exact D97AM atomically/fail-closed with rollback on any post-switch failure;
6. open a fresh process from exact `/Applications/OpenCore-Patcher.app` and prove exact-path fresh PID;
7. STOP with OCLP open. Do not click Root Patch yet.

Do not Root Patch in the deploy command. Do not reboot. Root Patch requires separate explicit authorization only after the complete deploy/open report is audited.