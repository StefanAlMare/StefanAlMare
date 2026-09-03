# OCLP7 CHECKPOINT — D97AG GITHUB BUILD PASS; ASUS2 ARTIFACT/RUNTIME AUDIT NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_TAHOE_XATTR_AND_LOCAL_SOURCE_INTEGRATION_PASS_GITHUB_BUILD_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 are retained with runtime sufficiency NEGATIVE. Golden Sequoia is immutable/read-only. D50/D68/D82 remain reserve-only; D84 is retired; Patch8 is unauthorized. D97AEX/D97AEZ external task-port observation is retired. Never auto Root Patch or reboot.

Execution-lane authority remains: routine/small tests, ordinary validations, packaged-runtime checks, artifact/reassembly verification and diagnostic iteration run on ASUS2 under user control. GitHub is reserved only for major/substantial compile/build/package workloads. Existing audited artifact-delivery mechanisms are reused.

## D97AG source state carried forward
The exact D97AG correction is the two-file source transition identified by patch SHA256 `2c4e93e57b2d13762ef90020496f87c2a95c7e39553ff60f948bfacd2b6b659b`, 3137 bytes. It replaces unavailable packaged-Python `os.listxattr/getxattr` with fail-closed `/usr/bin/xattr -s` / `-s -p -x` and changes the shared Metal exception boundary to best-effort unmount plus bare re-raise before `_write_patchset`, AuxKC or snapshot continuation.

Local source integration on ASUS2 was already PROVEN PASS with helpers SHA256 `ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2`, sys_patch SHA256 `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`, unchanged metal_3802 SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, unchanged D97AD method SHA256 `bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12`, corrected D97AF method SHA256 `1abd24399b9c39b215d7c06ecaf18fdfe24faeb19a743ac2ea957a20c99dc8d5`, and xattr backend source SHA256 `d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019`.

## Major D97AG Intel GitHub build — audited PASS
The major build already existed when this continuation resumed; it was not rerun.

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97ag-github-build
HEAD_SHA=4bde01b09717d076499ebf3640b5e4c0378798dd
PARENT_SHA=76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e
WORKFLOW_ID=348947684
WORKFLOW_NAME=OCLP7 D97AG exact Intel build
RUN_ID=33696449978
RUN_ATTEMPT=1
JOB_ID=100466229401
RUNNER_CLASS=macos-15-intel / x86_64
RUN_CONCLUSION=success
```

The job has 22 substantive steps from immutable-input verification through build/package and artifact upload; every reported step completed `success`. Exact D97AD snapshot reconstruction, D97AD->D97AF transition, D97AF->D97AG correction and source/package identity gates all completed.

The exact reports artifact was independently downloaded after the run and its SHA256 matched the GitHub artifact digest exactly:

```text
REPORTS_ARTIFACT_ID=9872066045
REPORTS_ARTIFACT_NAME=OCLP7-D97AG-RUN-33696449978-ATTEMPT-1-REPORTS
REPORTS_ARTIFACT_BYTES=18021887
REPORTS_ARTIFACT_SHA256=da5b9e2d2a55786c1b6a4f3c64c054779ad73f394578e1a5e07c2bd0fd287217
REPORTS_ARTIFACT_GITHUB_DIGEST=sha256:da5b9e2d2a55786c1b6a4f3c64c054779ad73f394578e1a5e07c2bd0fd287217
```

The report payload records the exact final application identities:

```text
D97AG_APP_ZIP_BYTES=751494420
D97AG_APP_ZIP_SHA256=d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846
D97AG_PACKAGED_EXE_BYTES=6596544
D97AG_PACKAGED_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
D97AG_PACKAGED_ARCH=x86_64
```

Packaged semantic/source fingerprints agree for helpers, sys_patch and metal_3802; D97AD is unchanged; D97AG is present exactly once; retired helpers are absent; the packaged xattr backend fingerprint is `71959f823a2da72c12e53581c85773ebdfd0100b22a780152bf8c69fe2d56286`; forbidden `listxattr/getxattr` names are absent; `/usr/bin/xattr` is retained; the UUID/post-SHA contract remains D97AF target preimage `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` -> postimage `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

Historical build-time native/frozen xattr probes are retained as informative build evidence only. Under the current execution-lane rule they do NOT replace the required ASUS2 local packaged-runtime test.

## Bounded artifact delivery identities
The final app ZIP was split without rebuild into exactly two binary parts:

```text
PART_00_ARTIFACT_ID=9872061067
PART_00_ARTIFACT_NAME=OCLP7-D97AG-RUN-33696449978-ATTEMPT-1-PART-00
PART_00_ARTIFACT_BYTES=390001616
PART_00_ARTIFACT_DIGEST=sha256:a3f0426126126a3e71351c645135757f7a89f7cc1a9f9d269e2cb9fdf17b926a
PART_00_PAYLOAD_BYTES=390000000
PART_00_PAYLOAD_SHA256=87189ac03eb044b3d674dddeb091ccafbb4705ac246c26d9f648bba5e66dc60e

PART_01_ARTIFACT_ID=9872064375
PART_01_ARTIFACT_NAME=OCLP7-D97AG-RUN-33696449978-ATTEMPT-1-PART-01
PART_01_ARTIFACT_BYTES=361496036
PART_01_ARTIFACT_DIGEST=sha256:7e167cef69dd9fa602a314ca138b2e94b6f76cf777fc3a65edf73b848fdc0e40
PART_01_PAYLOAD_BYTES=361494420
PART_01_PAYLOAD_SHA256=9952bf53e223fb9688102f18865afdb2ea58fa07362d807da61651e908955d23
```

GitHub-side split/reassembly produced exact app ZIP SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`. This is build provenance only; ASUS2 must independently download, verify artifact wrappers, verify part payloads, reassemble, verify ZIP CRC/SHA, extract and verify the x86_64 executable, and run the frozen xattr code-object auditor locally.

## Mutation ledger
```text
GITHUB_BUILD=PASS
GITHUB_SOURCE_MUTATION=YES_EPHEMERAL_CI_EXACT_TWO_FILES
ASUS2_SOURCE_MUTATION=NO_NEW_MUTATION_IN_THIS_CHECKPOINT
ASUS2_INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
SNAPSHOT_MUTATION=NO
REBOOT=AUTO-NO
```

The last proven live installed application on ASUS2 remains D97AF executable SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`. It remains unauthorized for another Root Patch.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not Root Patch and do not reboot.

Run one bounded, non-system-mutating ASUS2 artifact/runtime audit action using the already-authenticated GitHub CLI and exact run/artifact identities above. It must:
1. prove current GitHub login/repository/run/job/head identities;
2. download all three exact artifacts;
3. verify each outer artifact SHA/digest/size and safe member set;
4. verify the two exact binary part payload hashes and shared split manifest;
5. reassemble exact app ZIP and verify `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846` plus ZIP integrity;
6. verify packaged executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64;
7. verify the reports checksum set and frozen auditor identity `042fbd18f3bae5f0878ee7b5c16dcae26c63b3c21e1492d0c0a857095d140017`;
8. execute that frozen auditor locally against the exact packaged executable and require `D97AG_RUNTIME_AUDIT_MODE=PACKAGED_FROZEN`, `D97AG_RUNTIME_PROCESS_FROZEN=YES`, `D97AG_RUNTIME_OS_LISTXATTR_AVAILABLE=NO`, `D97AG_RUNTIME_EMPTY_MANIFEST=PASS`, `D97AG_RUNTIME_EMPTY_TEXT_BINARY_VALUES=PASS`, and `D97AG_EXACT_XATTR_CODE_OBJECT_RUNTIME=PASS`;
9. STOP with no `/Applications` mutation, no OCLP launch, no Root Patch and no reboot.

Only after that complete ASUS2 audit is returned and accepted may a separate bounded backup/deploy/open-OCLP/STOP action be authorized.