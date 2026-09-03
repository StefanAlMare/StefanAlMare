# OCLP7 CHECKPOINT — 2026-09-04 — D97AM GitHub Intel build/private release FULL PASS; ASUS2 artifact audit next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell, SMBIOS `MacBookAir6,2`. Routine/small work remains ASUS2-only; GitHub is reserved for major compile/build/package. Golden Sequoia remains immutable/read-only. Root Patch and reboot remain manual-only and separately authorized. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_P7_NATURAL_FLOW_SOURCE_INTEGRATION_PASS_GITHUB_BUILD_NEXT.md`.

## D97AM local source state retained
The exact local D97AM source integration remains FULL PASS:

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

A4F `A4F456DF-7447-49BF-AC4F-102D90023A1E` remains permanently bound to the earlier D97AD-instrumented 28/28 diagnostic cohort and is not reused.

## Private D97AM build lane
Private repository: `StefanAlMare/Private-Work`.
Build branch: `oclp7-d97am-github-build`.
Parent audited D97AH build head: `d04ddd28c784a0b30c6629feeface10804d5d591`.

The D97AM private lane uses a deterministic transform rather than manually copying large Python files. Exact transform identity observed in the authoritative run:

```text
D97AM_MANIFEST_GIT_BLOB=21e84bef05891c0f7876d85cf67177fd641deacc
D97AM_TRANSFORM_GIT_BLOB=7aa39868e406b54d3ffa5b5df08cb2cc4c4a2918
D97AM_TRANSFORM_SHA256=d91da748c01f5bd4921de3c8c0bc3e9799a563cee348a33075e2538c4be5d870
D97AM_TRANSFORM_BYTES=11116
```

The transform first reconstructs the exact audited D97AH source lineage, then applies only the D97AM natural-flow source transition and fails closed unless the resulting source identities equal the ASUS2 local D97AM identities.

## Non-authoritative tooling false failures
Two preliminary runs are retained as tooling history only; neither reached a major build and neither produced Haswell/runtime evidence.

### v1 — bad unobserved transform SHA/size pin
- trigger head `114b25b0a9bf3921901a0bfe4cb10b89b88bd92e`;
- workflow ID `349701944`;
- run `33812043670`;
- job `100835838242`;
- runner `macos-15-intel`.

D97AH source replay passed, then the shell stopped before invoking the D97AM transform because an initially guessed transform SHA256/byte-count pin did not match the committed blob. Classification: `D97AM_V1=TOOLING_FALSE_FAILURE_BEFORE_D97AM_TRANSFORM_NO_BUILD`.

### v2 — GNU-only `base64 -w0` in pre-build locator
- trigger head `4a207fdcc2dc98c36352ef3fa9a56de44417f21a`;
- workflow ID `349721036`;
- run `33812588726`;
- job `100837592383`;
- runner `macos-15-intel`.

The run failed in the pre-build locator because macOS `/usr/bin/base64` does not support GNU `-w0`. Build core was skipped. Classification: `D97AM_V2=TOOLING_FALSE_FAILURE_PRE_BUILD_NO_SOURCE_OR_BUILD_RESULT`.

Neither v1 nor v2 is authoritative.

## D97AM authoritative v3 GitHub build — FULL PASS
Authoritative workflow:
`.github/workflows/oclp7-d97am-build-v3-authoritative.yml`

Exact run identity:

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97am-github-build
HEAD_SHA=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d
WORKFLOW_ID=349724427
RUN_ID=33812721798
RUN_ATTEMPT=1
JOB_ID=100838020678
RUNNER_NAME=GitHub Actions 1000000251
RUNNER_LABEL=macos-15-intel
JOB_CONCLUSION=success
```

All external workflow steps completed with conclusion `success`, including the aggregated exact v2 build core and final release locator.

Runner environment recorded by the raw log:
- x86_64 Intel runner;
- macOS 15.7.9 / 24G830 GitHub-hosted image;
- this ephemeral GitHub runner is build infrastructure only and must not be conflated with the immutable project Golden Sequoia machine.

## Exact lineage replay and D97AM source sync — PASS
The authoritative run proved:

```text
D97AH_D97AD_SNAPSHOT_REASSEMBLY=PASS
D97AH_PARENT_D97AF_TRANSITION=PASS
D97AH_PARENT_D97AG_PREIMAGE=PASS
D97AH_EXACT_PATCH_GENERATION=PASS
D97AH_EXACT_SOURCE_TRANSITION=PASS
D97AM_PARENT_D97AH_SOURCE_REPLAY=PASS
D97AM_PRIVATE_SOURCE_SYNC=PASS
```

Exact D97AM source identities on the GitHub builder:

```text
D97AM_POST_HELPERS_SHA256=7c1127a62379ea5cef9efd42f5d14e7956def01e6f7635defe4f64e77473a844
D97AM_POST_SYSPATCH_SHA256=78e096b982c8a2e8c78f8bd18b32fc0961fa84e26d573a8d8fa304393d6a29a3
D97AM_POST_METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AM_EXACT_SOURCE_TRANSITION=PASS
```

The source audit separately reverified:

```text
D97AM_METHOD_SOURCE_SHA256=45e3b803a52fc876b0a1c4ebae6fe23878f32febc44368c4aaf32453170dcc6f
D97AM_DORMANT_D97AD_METHOD_SHA256=bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12
D97AM_D97AD_ACTIVE_CALL_COUNT=0
D97AM_D97AD_DORMANT_HELPER_COUNT=1
D97AM_EXACT_SOURCE_IDENTITY=PASS
D97AM_XATTR_AND_CHFLAGS_SEMANTICS=PASS
D97AM_FATAL_BOUNDARY=PASS
OCLP7_D97AM_GITHUB_SOURCE_AUDIT=PASS
```

Required D97AM constants were each present exactly once; old D97AD/A4F constants and `/bin/chflags` were absent from the active D97AM method. `/usr/bin/chflags` semantics remained exact.

## Major Intel build — PASS
The build reused the audited D97AH build infrastructure after exact D97AM source sync. OpenCore tools were found and application build completed successfully.

Classification:
`D97AM_MAJOR_INTEL_BUILD=PASS`.

Signing/notarization/security validation was explicitly skipped because signing/notarization details were incomplete. Therefore signing/notarization is **NOT VERIFIED and NOT PASS**.

## Packaged PyInstaller semantic audit — PASS
Packaged executable architecture: `x86_64`.

Source and packaged PyInstaller module semantic fingerprints matched exactly:

```text
helpers=c6946358e7e35b8cde4f9693804653b4e20a6f7650f3a37c019845c9be21daa1
syspatch=d95ce53f880488bf8decd5068c53923a3902d4b7dc2474f80e52ac9fd1b53048
metal=0c3994d77d3396fc00967a155a1d70fea9d4337c2a865bbc05abfd05d80a54bf
```

Packaged D97AM method constants:
- exact P7 pre-SHA: count 1;
- exact new UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`: count 1;
- exact expected post-SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`: count 1.

Forbidden old constants:
- D97AD pre-SHA: 0;
- A4F UUID: 0;
- A4F post-SHA: 0.

Packaged chflags proof:

```text
PACKAGED_D97AM_BIN_CHFLAGS_CONSTANT_POOL_COUNT=0
PACKAGED_D97AM_USR_BIN_CHFLAGS_CONSTANT_POOL_COUNT=1
PACKAGED_D97AM_BIN_CHFLAGS_LOAD_CONST_COUNT=0
PACKAGED_D97AM_USR_BIN_CHFLAGS_LOAD_CONST_COUNT=2
```

The constant-pool count of 1 is correct Python deduplication; two LOAD_CONST uses prove the two method-local chflags call sites.

Packaged classifications:

```text
D97AM_PACKAGED_THREE_MODULE_SEMANTIC_IDENTITY=PASS
D97AM_PACKAGED_METHOD_NATURAL_FLOW_IDENTITY=PASS
D97AM_PACKAGED_D97AD_DORMANT_IDENTITY=PASS
D97AM_PACKAGED_XATTR_CHFLAGS_IDENTITY=PASS
OCLP7_D97AM_GITHUB_BUILD_AUDIT=PASS
```

## Exact D97AM application identities
Packaged executable:

```text
PACKAGED_EXE_BYTES=6596496
PACKAGED_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
PACKAGED_ARCH=x86_64
```

Application ZIP:

```text
APP_ZIP_NAME=OCLP7-D97AM-OpenCore-Patcher.app.zip
APP_ZIP_BYTES=751495650
APP_ZIP_SHA256=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca
```

Two-part split/reassembly:

```text
PART00_BYTES=390000000
PART00_SHA256=9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67
PART01_BYTES=361495650
PART01_SHA256=80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08
D97AM_TWO_PART_SPLIT_REASSEMBLY=PASS
```

Reports ZIP:

```text
REPORTS_ZIP_BYTES=6517739
REPORTS_ZIP_SHA256=ab0e5926efed5ddbe3c4032bfd7584097a309b2bd1964e2e6349e3734eb03481
```

## Private release — FULL PASS
Release identity:

```text
RELEASE_ID=382366988
RELEASE_TAG=oclp7-d97am-run-33812721798-attempt-1
RELEASE_TARGET_HEAD=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d
RELEASE_ASSET_COUNT=7
```

Exact release assets audited by the authoritative workflow:

```text
543427741  D97AM_SPLIT_MANIFEST.env                             737 bytes       sha256:a5aa00d48c2b973113971b2f2db4e66c865b3f82449b6199d2d95ff0a8cda09c
543427689  OCLP7-D97AM-OpenCore-Patcher.app.zip.part-00        390000000 bytes sha256:9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67
543427740  OCLP7-D97AM-OpenCore-Patcher.app.zip.part-01        361495650 bytes sha256:80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08
543427739  OCLP7-D97AM-REPORTS.zip                               6517739 bytes    sha256:ab0e5926efed5ddbe3c4032bfd7584097a309b2bd1964e2e6349e3734eb03481
543427758  OCLP7_D97AM_RELEASE_ASSET_IDENTITY.txt                516 bytes        sha256:4969b5f306d1b7afd458655237f692da166d4a13db3629e31495c30b772d53a4
543427716  PARTS.SHA256                                           222 bytes        sha256:974b12a2e882a922262be9b0d0243f63260eec2fd9f937bf1acc6f9eedab6a60
543427759  RELEASE-ASSETS.SHA256                                  587 bytes        sha256:f33a6fe1c35aaa5a64aa91cb6782d80736082ef36b70f92dd77c95ba70a1f0c1
```

Release gates:

```text
D97AM_CURRENT_RUN_IDENTITY_BINDING=PASS
D97AM_RELEASE_PAYLOAD_PREUPLOAD=PASS
D97AM_PRIVATE_RELEASE_ASSET_AUDIT=PASS
OCLP7_D97AM_GITHUB_BUILD_AND_RELEASE_DELIVERY=PASS
OCLP7_D97AM_V2_AUTHORITATIVE_BUILD_AND_RELEASE=PASS
OCLP7_D97AM_V3_AUTHORITATIVE_BUILD_CORE=PASS
```

The final locator independently binds run/job/release to the exact v3 head and confirms 7 release assets.

## Classification
`D97AM_GITHUB_MAJOR_BUILD_PACKAGE_PRIVATE_RELEASE=FULL_PASS`.

This classification is build/package/release provenance only. It is not installed-state, Root Patch, runtime, accelerated-GUI, or functional-success evidence.

Mutation ledger for the authoritative GitHub build:
- ASUS2 source during GitHub build: unchanged;
- installed ASUS2 app: unchanged;
- system target: unchanged;
- Golden: unchanged;
- Root Patch: NO;
- reboot: NO.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
STOP after this GitHub build/package/release audit, as required by the previous checkpoint.

The next technical action in a subsequent step is an **ASUS2 private-release artifact audit only**: retrieve the exact 7 private release assets through an identity-pinned mechanism, verify release/head/asset identities, verify both part digests, reassemble the exact app ZIP, verify exact ZIP size/SHA, ZIP CRC/safe-member properties, packaged executable size/SHA/architecture, and audit the reports/manifest contents against the authoritative GitHub run.

Do not deploy D97AM yet. Do not open/replace the installed OCLP app yet. Do not Root Patch. Do not reboot. Deployment requires a separate assistant audit after ASUS2 artifact verification.