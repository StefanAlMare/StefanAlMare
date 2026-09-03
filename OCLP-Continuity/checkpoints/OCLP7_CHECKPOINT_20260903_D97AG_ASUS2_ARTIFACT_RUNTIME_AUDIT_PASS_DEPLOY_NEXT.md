# OCLP7 CHECKPOINT — D97AG ASUS2 ARTIFACT/RUNTIME AUDIT PASS; DEPLOY NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_GITHUB_BUILD_PASS_ASUS2_ARTIFACT_RUNTIME_AUDIT_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 are retained with runtime sufficiency NEGATIVE. Golden Sequoia is immutable/read-only. D50/D68/D82 remain reserve-only; D84 is retired; Patch8 is unauthorized. D97AEX/D97AEZ is retired. Never auto Root Patch or reboot.

Execution-lane authority remains: routine/small tests, ordinary validations, packaged-runtime checks, artifact/reassembly verification and diagnostic iteration run on ASUS2 under user control. GitHub is reserved only for major/substantial compile/build/package workloads.

## Corrected D97AG GitHub provenance
The earlier audit wrapper contained one incorrect workflow-ID pin. The exact run metadata returned by GitHub and ASUS2 proves:

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97ag-github-build
HEAD_SHA=4bde01b09717d076499ebf3640b5e4c0378798dd
WORKFLOW_ID=348876070
RUN_ID=33696449978
RUN_ATTEMPT=1
JOB_ID=100466229401
RUN_STATUS=completed
RUN_CONCLUSION=success
JOB_STATUS=completed
JOB_CONCLUSION=success
```

The previous value `348947684` is retired as a wrapper pinning error only. The first ASUS2 audit attempt stopped fail-closed at `RUN_IDENTITY_MISMATCH:workflow_id:348876070:348947684` before artifact download, application mutation, OCLP launch, Root Patch or reboot. Classification: `D97AG_FIRST_ASUS2_AUDIT=TOOLING_FALSE_FAILURE_NO_MUTATION`.

The original audit wrapper was exact public commit `b506cc1e90c278de483fd95955e078027df5c228`, git blob `36c43b17d3493b7b7cb35b8590653e6e20ebe60c`, SHA256 `0a9d3fd19d202c35ee2148af35fb1a99469b5c3798c64bc219630321a6aadadc`, 21778 bytes. On ASUS2 exactly one `WORKFLOW_ID="348947684"` occurrence was deterministically changed to `WORKFLOW_ID="348876070"`; corrected local SHA256 was `1d112e1dc76e1a0356cd692de8ccc06855c8bce1bd1b07bdbc22791ccf3d9fef`, corrected git-style blob `6982b9dedfeddb4b84abde9209a0e5a3689ebff3`, same 21778 bytes, and local zsh parse PASS.

## ASUS2 exact artifact/reassembly audit PASS
The corrected audit ran on ASUS2 with outer RC `0`. Exact run/job/head/branch/path identities passed; 25 reported job steps were all successful and every required build step was present.

Exact artifact wrappers passed metadata, expiration, size, GitHub digest, downloaded SHA256 and CRC checks:

```text
PART00_ARTIFACT_ID=9872061067
PART00_ARTIFACT_BYTES=390001616
PART00_ARTIFACT_SHA256=a3f0426126126a3e71351c645135757f7a89f7cc1a9f9d269e2cb9fdf17b926a
PART00_PAYLOAD_BYTES=390000000
PART00_PAYLOAD_SHA256=87189ac03eb044b3d674dddeb091ccafbb4705ac246c26d9f648bba5e66dc60e

PART01_ARTIFACT_ID=9872064375
PART01_ARTIFACT_BYTES=361496036
PART01_ARTIFACT_SHA256=7e167cef69dd9fa602a314ca138b2e94b6f76cf777fc3a65edf73b848fdc0e40
PART01_PAYLOAD_BYTES=361494420
PART01_PAYLOAD_SHA256=9952bf53e223fb9688102f18865afdb2ea58fa07362d807da61651e908955d23

REPORTS_ARTIFACT_ID=9872066045
REPORTS_ARTIFACT_BYTES=18021887
REPORTS_ARTIFACT_SHA256=da5b9e2d2a55786c1b6a4f3c64c054779ad73f394578e1a5e07c2bd0fd287217
```

The three copies of `PARTS.SHA256` independently matched SHA256 `925b5ec65f8a87ac7a8719c714f6556ba80601eefbd8436b322e6ac07d327086`; the three split manifests independently matched SHA256 `9db663ff0768d3f22627ba1002f2e000db9f6a939b73b449c792e17bd85b6dfc`. Report checksum set PASS.

Exact reassembly on ASUS2 produced:

```text
D97AG_APP_ZIP_BYTES=751494420
D97AG_APP_ZIP_SHA256=d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846
D97AG_PACKAGED_EXE_BYTES=6596544
D97AG_PACKAGED_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
D97AG_PACKAGED_ARCH=x86_64
```

The packaged executable extracted from the reassembled app ZIP is Mach-O 64-bit x86_64. It is byte-identical to the packaged executable carried in the reports artifact.

## ASUS2 real PyInstaller-frozen xattr runtime PASS
The exact frozen auditor, x86_64, was executed on ASUS2 against the exact packaged D97AG executable. Returned evidence:

```text
D97AG_RUNTIME_AUDIT_MODE=PACKAGED_FROZEN
D97AG_RUNTIME_PROCESS_FROZEN=YES
D97AG_RUNTIME_OS_LISTXATTR_AVAILABLE=NO
D97AG_RUNTIME_BACKEND_FREEVARS=_os,_subprocess
D97AG_RUNTIME_BACKEND_FINGERPRINT=71959f823a2da72c12e53581c85773ebdfd0100b22a780152bf8c69fe2d56286
D97AG_RUNTIME_BACKEND_SOURCE_SHA256=d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019
D97AG_RUNTIME_EMPTY_MANIFEST=PASS
D97AG_RUNTIME_EMPTY_TEXT_BINARY_VALUES=PASS
D97AG_EXACT_XATTR_CODE_OBJECT_RUNTIME=PASS
ASUS2_FROZEN_RUNTIME_REQUIRED_LINES_MISSING=[]
D97AG_ASUS2_FROZEN_XATTR_RUNTIME=PASS
```

This directly closes the packaged-runtime compatibility defect that invalidated D97AF: the actual frozen runtime still lacks `os.listxattr`, but the corrected D97AG backend successfully uses the exact external `/usr/bin/xattr` code object and returns empty/text/binary xattrs correctly.

Final local classifications:

```text
D97AG_ASUS2_ARTIFACT_REASSEMBLY=PASS
D97AG_ASUS2_PACKAGED_EXECUTABLE_IDENTITY=PASS
D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT=PASS
D97AG_LOCAL_PACKAGED_RUNTIME_COMPATIBILITY=PROVEN_PASS
```

The exact verified application ZIP is retained locally at:
`/Users/alex/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip`.

Audit report:
`/Users/alex/Desktop/OCLP7_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_REPORT_20260903-162932.txt`.

## Mutation ledger
```text
ASUS2_ARTIFACT_DOWNLOAD=YES_TEMPORARY_PLUS_VERIFIED_ZIP_RETAINED
ASUS2_SOURCE_MUTATION=NO
ASUS2_INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
SNAPSHOT_MUTATION=NO
REBOOT=AUTO-NO
```

The last proven installed `/Applications/OpenCore-Patcher.app` remains exact D97AF x86_64 executable SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`, 6595600 bytes. It remains unauthorized for Root Patch.

## Exact next-action delivery identity
The bounded ASUS2 application transition wrapper is published but was not executed or tested in GitHub; GitHub is used only to persist the source identity. Syntax parsing and runtime execution belong to ASUS2.

```text
DELIVERY_FILE=OCLP7_D97AG_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command
DELIVERY_COMMIT=fcd817dec08e1ff782316516f7d2432e2b5d51df
DELIVERY_GIT_BLOB=e8dca8761903de7f612629ff85ea9ec81bc5d65c
GITHUB_EXECUTION=NOT_RUN_BY_DESIGN
```

The wrapper is fail-closed before mutation on ZIP/staged/live-preimage identity mismatch. It requests `sudo` only at the bounded `/Applications` transition gate, creates and verifies a timestamped D97AF backup, deploys only exact D97AG, re-verifies the live executable, opens exact OCLP and requires a fresh exact-path process. Ordinary EXIT/HUP/INT/TERM recovery attempts to restore exact D97AF while the transition is incomplete. The short two-rename interval is not claimed crash-atomic against SIGKILL/kernel crash/power loss.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not Root Patch and do not reboot.

Run the exact public-commit-pinned wrapper above on ASUS2. It must:
1. verify the retained D97AG ZIP is exact `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`;
2. extract to a private staging directory and verify exactly one `OpenCore-Patcher.app`, executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64;
3. verify current live application preimage is exact D97AF executable SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470` / 6595600 bytes;
4. stop/drain only processes using the exact live OCLP executable path;
5. move current exact D97AF app to a timestamped recoverable `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-*` backup;
6. install exact D97AG to `/Applications/OpenCore-Patcher.app`;
7. reverify exact live D97AG executable identity and x86_64 architecture;
8. open exact live OCLP and prove a fresh exact-path process;
9. STOP and return full terminal output.

This next action may mutate `/Applications/OpenCore-Patcher.app` only. It must not modify OCLP source, system target, root-patched snapshot or Golden and must not run Root Patch or reboot.

Only after exact D97AG live deployment is returned and audited may a separate manual Root Patch be authorized.