# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260903_D97AH_CMP_PROBE_PASS_AUDIT_V2_NEXT.md`
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

Detailed incremental checkpoints remain authoritative for completed phases. This MASTER is the current-state/frontier summary.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4600/4400 family, SMBIOS `MacBookAir6,2`. Local source branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.

Golden root-patched MTLCompiler SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269` is immutable/read-only. Accepted true-five SHA256 is `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

Routine/small tests, source inspection, edits, probes, packaged-runtime checks, artifact/reassembly verification, live application checks, hardware evidence, accelerated boots and VESA evidence stay on ASUS2 under user control. GitHub is used only for major/substantial compile/build/package workloads. Local major compilation requires explicit user authorization. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.
Evidence labels remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/STATIC-PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.

## Accepted functional lineage
Exactly P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset. P6/P7 retained with runtime sufficiency NEGATIVE. D22 is semantic proof for AIR2.6/Metal3.1.

## Durable D97 state
D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`. D97AD build/deploy/manual Root Patch passed. Selected accelerated boot `2026-09-02 00:10`; VESA `00:12` excluded.

D97AEQ proved 28/28 normal exit(1) and invalidated the whole-stage classifier experiment. D97AER placed visible late simulator xrefs after the candidate terminal. D97AES proved all 33 diagnostics over 28/28 PIDs came from `Versions/32023/MTLCompiler`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 NEGATIVE for that cohort. D97AET archived PCs did not directly prove traversal beyond the terminal.

D226 cache image is a separate input lineage; physical cache reads are valid but cross-image semantic site correlation from D5CE is not established. Exact current D97AD runtime text remains UNKNOWN. D97AEZ external task-port method is retired after natural exact-path PID reach and `errno=1` read denial.

## D97AF LC_UUID contract
Frozen UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Exact D97AD preimage SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; UUID-only expected postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`. The stamp is provenance evidence for covered diagnostic-sender cohorts, not a direct runtime text read.

## D97AF -> D97AG
D97AF source/build/deploy passed, but Root Patch was invalid because packaged Python lacked `os.listxattr`; the custom target mutation was not reached while old exception handling continued into later system work.

D97AG corrected `_xattrs` to fail-closed `/usr/bin/xattr` use and changed the Metal-chain exception boundary to unmount + bare re-raise before later patchset/AuxKC/snapshot continuation.

D97AG major Intel build: private branch `oclp7-d97ag-github-build`, head `4bde01b09717d076499ebf3640b5e4c0378798dd`, workflow/run/job `348876070 / 33696449978 / 100466229401`, success. App ZIP `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`; executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

ASUS2 D97AG artifact/reassembly and frozen xattr runtime audit passed. Exact D97AG is currently live at `/Applications/OpenCore-Patcher.app`; D97AF backup is `/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317`.

## D97AG real Root Patch / D97AH cause
Manual D97AG Root Patch passed P1/P2b/P3/AIR00/D34/P6/P7/D97AD. The corrected xattr backend is real-Root-Patch PROVEN: flags `524288`, xattrs `[]`, ACL NONE and exact D97AD preimage were read successfully.

The run then failed closed at hard-coded `/bin/chflags`, before staged `dd`, atomic target rename or LC_UUID commit. D97AG fatal boundary worked: root volume unmounted and no later AuxKC/snapshot completion or misleading `Patching complete`. `D97AG_ROOT_PATCH=FAIL_CLOSED_NEW_TOOL_PATH_DEFECT`; reboot unauthorized.

ASUS2 probe proved `/bin/chflags` absent and `/usr/bin/chflags` valid/executable universal x86_64+arm64e; all other absolute transaction tools are valid.

## D97AH local source PASS
D97AH changes only two exact string tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`: `/bin/chflags` -> `/usr/bin/chflags`.

Exact local identities:
- helpers SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`;
- method SHA256 `fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a`;
- patch SHA256 `66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c`, `1005` bytes;
- sys_patch unchanged `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`;
- metal unchanged `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`.

First local correction attempt false-failed because substring counting treated `/bin/chflags` inside `/usr/bin/chflags` as a hit; no mutation. Corrected AST/token-exact action changed exactly two method-local tokens and passed AST/compile/inode/metadata/diff gates.

## D97AH major GitHub build and private-release delivery PASS
Early build/audit evolution is retained in the authoritative checkpoint: first build compiled but post-build auditor false-failed on Python constant-pool dedup; v2 was YAML-invalid before any job; v3 corrected the audit and proved build/package PASS but Actions artifact upload failed from storage quota; v4 is non-authoritative. None altered ASUS2.

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

All 15 job steps passed. Exact D97AH patch/source/method identities match ASUS2. D97AD method, D97AG xattr backend and fatal boundary are unchanged. Source and packaged module fingerprints match. Packaged method proves constant-pool old/new `0/1` and actual LOAD_CONST old/new `0/2`; this correctly accounts for Python constant deduplication.

Exact v5 app ZIP: `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Packaged executable: `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Delivery uses private release ID `382116519`, tag `oclp7-d97ah-run-33769927671-attempt-1`, target head `d04ddd28c784a0b30c6629feeface10804d5d591`, with seven exact uploaded assets/digests. `OCLP7_D97AH_GITHUB_BUILD_AND_RELEASE_DELIVERY=PASS`. Signing/notarization remains unverified and is not classified PASS.

## D97AH ASUS2 audit attempt 1 / cmp probe
Audit attempt 1 passed release binding, all seven asset identities/checksum sets, exact ZIP reassembly/CRC/safe-member audit, exact packaged executable identity and reports ZIP safe-member/file-set/checksum audit. It then false-failed because wrapper v1 invoked absent `/bin/cmp`; this does not prove report/app executable byte difference. No verified ZIP was retained and no mutation occurred.

Bounded ASUS2 probe then proved `/bin/cmp` absent and `/usr/bin/cmp` present, regular, executable, universal x86_64+arm64e; `command -v`, `whence -a`, `type -a` and `/usr/bin/which -a` all resolve only `/usr/bin/cmp`.

Corrected public audit wrapper v2 is `OCLP7_D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT_V2.command`, commit `85b5f8b3487cc940918dc446890b959daa7cc4ed`, blob `c5a91b5d50a82b17cc4ea2a60303934182540fb0`. It pins wrapper v1 and changes only the exact temporary comparison line `/bin/cmp ...` -> `/usr/bin/cmp ...`, with exact line-cardinality and local parse gates, then reruns the complete v1 audit from the beginning. It is not executed/tested on GitHub.

## CURRENT ACTION — ASUS2 D97AH private-release audit v2
ASUS2 remains at STOP. Do not deploy, Root Patch or reboot.

Run one bounded ASUS2-only execution of the public-commit-pinned v2 wrapper. First prove v2 public wrapper blob and local zsh parse. Then v2 must verify pinned v1, perform exactly the temporary cmp-path line correction, parse the patched v1 locally and rerun the full release/reassembly/reports audit from the beginning.

Required final evidence includes explicit `D97AH_REPORT_AND_APP_EXECUTABLE_BYTE_IDENTITY=PASS`, complete report-content PASS gates, exact verified Desktop ZIP retention, `D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=PASS`, and v2/outer PASS. Printed PASS alone is insufficient; return complete terminal output.

Only after that complete ASUS2 audit v2 is returned and accepted may a separate backup/deploy/open-OCLP/STOP action be authorized. Actual privileged D97AH `chflags` execution remains a later real Root Patch runtime test; Root Patch/reboot remain unauthorized now.