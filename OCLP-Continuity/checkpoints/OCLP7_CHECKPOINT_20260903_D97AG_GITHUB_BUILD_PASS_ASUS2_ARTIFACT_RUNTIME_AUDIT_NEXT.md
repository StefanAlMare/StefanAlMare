# OCLP7 CHECKPOINT — D97AG GITHUB BUILD PASS; ASUS2 ARTIFACT/RUNTIME AUDIT COMPLETED

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.

## Supersession notice
The ASUS2 artifact/reassembly + packaged-runtime audit that was the `CURRENT NEXT ACTION` of this checkpoint has now completed with outer RC `0` and is PROVEN PASS.

The authoritative successor checkpoint is:
`OCLP7_CHECKPOINT_20260903_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_PASS_DEPLOY_NEXT.md`.

Read that successor checkpoint for the complete evidence and current frontier. The following facts are repeated here so a startup using the older MASTER pointer cannot regress the state.

## Corrected build identity
The actual D97AG GitHub workflow ID is `348876070`, not the previously pinned `348947684`. Exact run/job/head are:

```text
WORKFLOW_ID=348876070
RUN_ID=33696449978
JOB_ID=100466229401
HEAD_SHA=4bde01b09717d076499ebf3640b5e4c0378798dd
BUILD_BRANCH=oclp7-d97ag-github-build
RUN_CONCLUSION=success
JOB_CONCLUSION=success
```

The first ASUS2 wrapper stopped fail-closed solely on the stale workflow-ID pin before artifact download or mutation. Classification: `TOOLING_FALSE_FAILURE_NO_MUTATION`.

## ASUS2 artifact/runtime audit PASS
The corrected ASUS2 audit independently proved exact artifact wrappers and payloads, reports checksum set, exact two-part reassembly and packaged executable identity:

```text
D97AG_APP_ZIP_BYTES=751494420
D97AG_APP_ZIP_SHA256=d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846
D97AG_PACKAGED_EXE_BYTES=6596544
D97AG_PACKAGED_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
D97AG_PACKAGED_ARCH=x86_64
D97AG_ASUS2_ARTIFACT_REASSEMBLY=PASS
D97AG_ASUS2_PACKAGED_EXECUTABLE_IDENTITY=PASS
```

The exact frozen auditor was then executed on ASUS2 against that exact packaged executable and returned:

```text
D97AG_RUNTIME_AUDIT_MODE=PACKAGED_FROZEN
D97AG_RUNTIME_PROCESS_FROZEN=YES
D97AG_RUNTIME_OS_LISTXATTR_AVAILABLE=NO
D97AG_RUNTIME_BACKEND_FINGERPRINT=71959f823a2da72c12e53581c85773ebdfd0100b22a780152bf8c69fe2d56286
D97AG_RUNTIME_BACKEND_SOURCE_SHA256=d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019
D97AG_RUNTIME_EMPTY_MANIFEST=PASS
D97AG_RUNTIME_EMPTY_TEXT_BINARY_VALUES=PASS
D97AG_EXACT_XATTR_CODE_OBJECT_RUNTIME=PASS
D97AG_ASUS2_FROZEN_XATTR_RUNTIME=PASS
D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT=PASS
```

Verified D97AG app ZIP retained at:
`/Users/alex/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip`.

Audit report:
`/Users/alex/Desktop/OCLP7_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_REPORT_20260903-162932.txt`.

No OCLP source, installed application, system target, Golden, Root Patch, snapshot or reboot mutation occurred during this audit. Last proven installed app remains exact D97AF executable SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`, 6595600 bytes.

## CURRENT ACTION — exact D97AG application deploy/open/STOP
ASUS2 remains at STOP. Do not Root Patch and do not reboot.

Next bounded action is application-only: verify retained exact D97AG ZIP, stage and verify exact D97AG x86_64 app, prove exact live D97AF preimage, create a timestamped recoverable D97AF backup, deploy exact D97AG to `/Applications/OpenCore-Patcher.app`, reverify live identity, open exact OCLP and STOP.

Only after exact D97AG live deployment output is returned and audited may a separate manual Root Patch be authorized.

All permanent invariants remain: baseline exactly P1+P2b+P3+AIR00+D34; P6/P7 retained with runtime sufficiency NEGATIVE; Golden immutable/read-only; D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; never auto Root Patch or reboot.