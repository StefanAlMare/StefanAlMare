# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260903_D97AH_DEPLOY_OPEN_PASS_ROOTPATCH_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-03 EEST

## Mandatory startup
Before any technical change read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

Detailed incremental checkpoints remain authoritative for completed phases. This MASTER is the current-state/frontier summary and must not be used to reinterpret older evidence.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4600/4400 family, SMBIOS `MacBookAir6,2`. Local source branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.

Golden root-patched MTLCompiler SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` is immutable/read-only. Accepted true-five SHA256 is `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

Routine/small tests, source inspection, small edits, probes, packaged-runtime checks, artifact/reassembly verification, live installed-state checks, hardware evidence, accelerated boots and VESA evidence stay on ASUS2 under user control. GitHub is used only for major/substantial compile/build/package workloads; continuity writes and delivery-source persistence do not move routine execution to GitHub. Local major compilation requires explicit user authorization. Never auto Root Patch or reboot.

D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized. D97AEX/D97AEZ retired. Golden immutable/read-only.

Architecture remains: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.
Evidence labels remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/STATIC-PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.

## Accepted functional lineage
Exactly P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset. P6/P7 retained with runtime sufficiency NEGATIVE. D22 is semantic proof for AIR2.6/Metal3.1.

## Durable D97 state
D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`. D97AD build/deploy/manual Root Patch passed. Selected accelerated boot `2026-09-02 00:10`; later VESA `00:12` is excluded for that accelerated evidence.

D97AEQ proved 28/28 normal exit(1) and invalidated the whole-stage classifier experiment. D97AES proved all 33 diagnostics over 28/28 PIDs came from `Versions/32023/MTLCompiler`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 NEGATIVE for that cohort. D226 cache is a separate input lineage; physical cache reads are valid but semantic cross-image site correlation from D5CE is not established. Exact current D97AD runtime text remains UNKNOWN. D97AEZ external task-port observation is retired after exact-path process reach but `errno=1` read denial.

## D97AF LC_UUID contract
Frozen UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Exact D97AD preimage SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; UUID-only expected postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`. The stamp is provenance evidence for covered diagnostic-sender cohorts, not a direct runtime text read.

## D97AF -> D97AG
D97AF build/deploy passed, but its manual Root Patch was invalid because packaged Python lacked `os.listxattr`. The custom target mutation was not reached, while old exception handling incorrectly allowed later patchset/AuxKC/snapshot continuation. `D97AF_ROOT_PATCH=INVALID_PARTIAL`.

D97AG corrected `_xattrs` to fail-closed `/usr/bin/xattr` use and changed the shared Metal-chain exception boundary to best-effort unmount + bare re-raise before later patchset/AuxKC/snapshot continuation.

D97AG major Intel build: private branch `oclp7-d97ag-github-build`, head `4bde01b09717d076499ebf3640b5e4c0378798dd`, workflow/run/job `348876070 / 33696449978 / 100466229401`, success. App ZIP `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`; executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

ASUS2 D97AG artifact/reassembly and frozen xattr runtime audit passed. Exact D97AG was live until the D97AH deployment below; D97AF backup remains `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## D97AG real Root Patch / D97AH cause
Manual D97AG Root Patch passed P1/P2b/P3/AIR00/D34/P6/P7/D97AD. The corrected xattr backend is real-Root-Patch PROVEN: flags `524288`, xattrs `[]`, ACL NONE and exact D97AD preimage were read successfully.

The run then failed closed at hard-coded `/bin/chflags`, before staged `dd`, atomic target rename or LC_UUID commit. D97AG fatal boundary worked: root volume unmounted and no later AuxKC/snapshot completion or misleading `Patching complete`. `D97AG_ROOT_PATCH=FAIL_CLOSED_NEW_TOOL_PATH_DEFECT`; reboot unauthorized.

ASUS2 probe proved `/bin/chflags` absent and `/usr/bin/chflags` valid/executable universal x86_64+arm64e; other transaction tool paths remained valid.

## D97AH exact source correction
D97AH changes exactly two method-local string tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`: `/bin/chflags` -> `/usr/bin/chflags`.

Exact local identities:
- helpers SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`;
- method SHA256 `fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a`;
- patch SHA256 `66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c`, `1005` bytes;
- sys_patch unchanged `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`;
- metal unchanged `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`.

The first local correction wrapper false-failed from substring overlap and mutated nothing; the corrected AST/token action changed exactly the two intended tokens and passed AST/compile/inode/metadata/diff gates.

## D97AH authoritative major build/private release PASS
Early build/audit/tooling false failures remain detailed in checkpoint history: constant-pool dedup auditor, YAML-invalid v2, Actions artifact quota, and non-authoritative v4. None are semantic failures of D97AH.

Authoritative v5:

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97ah-github-build
HEAD_SHA=d04ddd28c784a0b30c6629feeface10804d5d591
WORKFLOW_ID=349436422
RUN_ID=33769927671
JOB_ID=100697248264
RUNNER=macos-15-intel / x86_64
RUN_CONCLUSION=success
```

All 15 job steps passed. Exact D97AH patch/source/method identities match ASUS2. D97AD method, D97AG xattr backend and fatal boundary are unchanged. Source and packaged module fingerprints match. Packaged method proves constant-pool old/new `0/1` and actual LOAD_CONST old/new `0/2`, correctly accounting for Python constant deduplication.

Exact v5 app ZIP: `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Packaged executable: `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Delivery uses private release ID `382116519`, tag `oclp7-d97ah-run-33769927671-attempt-1`, target head `d04ddd28c784a0b30c6629feeface10804d5d591`, with seven exact uploaded assets/digests. `OCLP7_D97AH_GITHUB_BUILD_AND_RELEASE_DELIVERY=PASS`. Signing/notarization remains unverified and is not classified PASS.

## D97AH ASUS2 private-release audit v2 PASS
The complete ASUS2 v2 audit passed release binding, all seven asset identities/checksum sets, exact split reassembly and ZIP integrity, exact packaged executable identity, report ZIP/file/checksum audit, explicit report/app executable byte identity and all report-content gates.

Exact audited ZIP identity: `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Exact packaged executable: `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Decisive markers include `D97AH_REPORT_AND_APP_EXECUTABLE_BYTE_IDENTITY=PASS`, `D97AH_REPORT_CONTENT_AUDIT=PASS`, `D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=PASS`, `D97AH_AUDIT_V2=PASS`, `D97AH_AUDIT_V2_OUTER_RC=0`.

The user's later deletion of Desktop-visible files explained the repeated missing-ZIP deploy preflight failures; the exact Trash copy remained identical and was used to recreate the Desktop ZIP immediately before final deploy. This was user file housekeeping, not an OCLP/system defect.

## D97AH exact deploy/open PASS — currently live
Final one-shot deploy re-verified the exact ZIP and staged executable, proved the live D97AG preimage exact, created an exact timestamped D97AG backup, switched exact D97AH live, opened it and proved a fresh exact-path process.

Exact retained D97AG backup:
`/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`

D97AG backup executable: `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`.

Current live D97AH executable at `/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher`:
`6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Fresh exact-path PID after open: `13110`.

Decisive deploy markers:

```text
D97AH_STAGED_APP_IDENTITY=PASS
D97AG_LIVE_PREIMAGE=PASS
D97AH_NEW_APP_READY_EXACT=PASS
D97AG_EXACT_PATH_PROCESS_DRAIN=PASS
D97AH_LIVE_APP_IDENTITY=PASS
D97AH_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AH_DEPLOYED_EXACT_OPENED
D97AH_DEPLOY_OUTER_RC=0
D97AH_DEPLOY_V4_WRAPPER_RC=0
D97AH_ONE_SHOT_DEPLOY_OUTER_RC=0
```

Deploy report: `/Users/alex/Desktop/OCLP7_D97AH_EXACT_APP_DEPLOY_OPEN_STOP_REPORT_20260903-200708.txt`.

No OCLP source, system target, Golden, Root Patch or reboot mutation occurred during deploy/open.

## CURRENT ACTION — manual D97AH Root Patch
D97AH exact application is live and open. The FASTLANE through packaged audit, exact identity, backup/deploy, open and fresh-process proof is complete PASS.

The next action is one manual ASUS2 Root Patch initiated by the user from the currently open exact D97AH application. Return the complete Root Patch output and STOP. Do not reboot after Root Patch until that output is audited.

This Root Patch is specifically required to prove the real privileged D97AH transaction beyond the former D97AG `/bin/chflags` failure. The raw output must establish whether `/usr/bin/chflags` is reached successfully, whether staged postimage `dd`, staged metadata verification, exact postimage SHA/UUID, target CAS, atomic target rename/commit and later patchset/AuxKC/snapshot stages complete. Printed `Patching complete` alone is not sufficient.

Accelerated boot/reboot remains separately unauthorized until the Root Patch output is returned and accepted.
