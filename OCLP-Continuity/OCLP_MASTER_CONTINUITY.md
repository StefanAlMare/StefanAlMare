# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260903_D97AJ_A4F_FULLY_RESOLVED_CFG_NO_LATE_BYPASS_DIAGNOSTIC_ORIGIN_NEXT.md`
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
D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`. D97AD build/deploy/manual Root Patch passed. Selected historical accelerated boot `2026-09-02 00:10`; later VESA `00:12` is excluded for that historical accelerated evidence.

D97AEQ proved 28/28 normal exit(1) and invalidated the whole-stage classifier experiment. D97AES proved all 33 historical diagnostics over 28/28 PIDs came from `Versions/32023/MTLCompiler`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 NEGATIVE for that cohort. D97AER statically mapped five late simulator-limit diagnostics after D97AD candidate exit110 at REL `0x58B`. D97AET historical sender PCs/backtraces did not prove traversal past that terminal. D226 cache is a separate input lineage; physical cache reads are valid but semantic cross-image site correlation is not established. D97AEZ external task-port observation is retired after exact-path process reach but `errno=1` read denial.

## D97AF LC_UUID contract
Frozen UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Exact D97AD preimage SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; UUID-only expected postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`. The stamp is provenance evidence for covered diagnostic-sender cohorts, not a direct runtime text-byte read.

## D97AF -> D97AG
D97AF build/deploy passed, but its manual Root Patch was invalid because packaged Python lacked `os.listxattr`. The custom target mutation was not reached, while old exception handling incorrectly allowed later patchset/AuxKC/snapshot continuation. `D97AF_ROOT_PATCH=INVALID_PARTIAL`.

D97AG corrected `_xattrs` to fail-closed `/usr/bin/xattr` use and changed the shared Metal-chain exception boundary to best-effort unmount + bare re-raise before later patchset/AuxKC/snapshot continuation.

D97AG major Intel build: private branch `oclp7-d97ag-github-build`, head `4bde01b09717d076499ebf3640b5e4c0378798dd`, workflow/run/job `348876070 / 33696449978 / 100466229401`, success. App ZIP `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`; executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

ASUS2 D97AG artifact/reassembly and frozen xattr runtime audit passed. Manual D97AG Root Patch proved the corrected xattr backend in the real patch path, then failed closed at hard-coded `/bin/chflags`, before staged `dd`, atomic target rename or LC_UUID commit. The fatal boundary worked; no later AuxKC/snapshot completion occurred. `D97AG_ROOT_PATCH=FAIL_CLOSED_NEW_TOOL_PATH_DEFECT`.

ASUS2 probe proved `/bin/chflags` absent and `/usr/bin/chflags` valid/executable universal x86_64+arm64e; other transaction tool paths remained valid.

## D97AH exact source correction
D97AH changes exactly two method-local string tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`: `/bin/chflags` -> `/usr/bin/chflags`.

Exact local identities:
- helpers SHA256 `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`;
- method SHA256 `fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a`;
- patch SHA256 `66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c`, `1005` bytes;
- sys_patch unchanged `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`;
- metal unchanged `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`.

First local correction false-failed from substring overlap with no mutation; the corrected AST/token action changed exactly the intended two tokens and passed AST/compile/inode/metadata/diff gates.

## D97AH authoritative major build/private release PASS
Authoritative v5 private build:

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

All 15 steps passed. Exact source/package identities match ASUS2. D97AD method, D97AG xattr backend and fatal boundary are unchanged. Packaged method proves constant-pool old/new `0/1` and LOAD_CONST old/new `0/2`, correctly accounting for Python constant deduplication.

Exact app ZIP: `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Packaged executable: `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Private release ID `382116519`, tag `oclp7-d97ah-run-33769927671-attempt-1`, target head `d04ddd28c784a0b30c6629feeface10804d5d591`, seven exact uploaded assets. `OCLP7_D97AH_GITHUB_BUILD_AND_RELEASE_DELIVERY=PASS`. Signing/notarization remains unverified and is not classified PASS.

## D97AH ASUS2 artifact audit and deployment PASS
Private-release audit v2 passed exact release/asset identities, split reassembly, ZIP CRC/safe-member audit, packaged executable identity, reports checksums, explicit report/app executable byte identity and all report-content gates. Exact verified ZIP identity: `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`.

D97AH exact deployment/open passed on ASUS2. Exact D97AG live preimage was `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64. Backup retained:
`/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

Exact D97AH is live at `/Applications/OpenCore-Patcher.app`, executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Fresh exact-path process was proven after open.

## D97AH manual Root Patch — FULL PASS
The complete Root Patch raw output was audited. Exact local metallib `26.6.2-25G82` was used, elevated root mount and preflight passed, all patchsets ran, and the accepted functional chain P1/P2b/P3/AIR00/D34 plus retained P6/P7 and D97AD passed again.

D97AD exact committed MTL SHA remained `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

The real privileged D97AH LC_UUID transaction completed:

```text
D97AF_TARGET_FLAGS_PRE=524288
D97AF_TARGET_XATTRS_PRE=[]
D97AF_TARGET_ACL_PRE=NONE
D97AF_LC_UUID_BUILD_STAMP_PRE_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
D97AF_LC_UUID_BUILD_STAMP_OLD=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
D97AF_LC_UUID_BUILD_STAMP_NEW=A4F456DF-7447-49BF-AC4F-102D90023A1E
D97AF_LC_UUID_BUILD_STAMP_OFFSET=0xAB0
D97AF_LC_UUID_BUILD_STAMP_POST_SHA=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
D97AF_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AF_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AF_LC_UUID_BUILD_STAMP=PASS
```

Because D97AH differs from D97AG only by the two exact method-local `chflags` path tokens, the previous `/bin/chflags` blocker is eliminated in the real Root Patch path and the entire corrected staged-write/metadata/atomic-commit transaction is PROVEN complete.

Downstream work also passed: patchset information written, RSR handling completed, AuxKC built/forced, APFS snapshot creation reached, root volume unmounted, then `Patching complete` and reboot request. Classification: `D97AH_ROOT_PATCH=FULL_PASS`.

## D97AH accelerated boot and D97AF stamped runtime provenance
The D97AH accelerated/root-patched boot began around 23:15. Exact current VESA recovery `kern.boottime` is `2026-09-03 23:17:53 +0300` (`sec=1788466673`), so all evidence strictly before that timestamp belongs to the accelerated boot; the VESA session itself is excluded.

The accelerated boot did not produce a usable GUI. Intel Haswell acceleration components were initialized, but MTLCompilerService repeatedly disappeared during Metal shader compilation and WindowServer entered the known XPC-interruption/pipeline-failure/SIGABRT chain. Classification: `D97AH_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`.

A read-only `log show --style json` audit of the accelerated cohort found 28 MTLCompilerService PIDs and exactly 28 simulator-diagnostic records. Every diagnostic record has:

```text
senderImagePath=/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler
senderImageUUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
processImagePath=/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService
processImageUUID=3716D20F-B990-3906-B3E5-44E88AE63AF8
```

Aggregate evidence:

```text
DIAGNOSTIC_RECORD_COUNT=28
DIAG_SENDER_COUNT=28|PATH=/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler|UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
EXPECTED_STAMP_UUID_ALL_RECORD_MATCHES=28
OLD_UUID_ALL_RECORD_MATCHES=0
EXPECTED_STAMP_UUID_DIAG_MATCHES=28
OLD_UUID_DIAG_MATCHES=0
```

Therefore `D97AF_RUNTIME_PROVENANCE=PROVEN_28_OF_28_DIAGNOSTIC_COHORT`. The failing diagnostic sender is the exact 32023 generation carrying the project-unique A4F D97AF stamp; the old D5CE sender identity is NEGATIVE for this complete cohort. H4 had already been rejected for generation selection by historical D97AES; D97AF now removes the remaining stale/alternate-D5CE sender ambiguity for this cohort.

Do not overclaim direct text-byte capture: `D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED`. The exact MTLCompilerService termination status in this D97AH boot was not recovered by the JSON collector and remains `UNKNOWN/INCONCLUSIVE`; zero textual matches for 110–114 or exit1 are not NEGATIVE evidence.

## D97AI / D97AJ A4F control-flow reconciliation
D97AI verified exact A4F SHA/UUID, exact D97AD exit110 bytes at image offset `0x9D6BD`, and the five late simulator-limit xrefs at `0x9D6C8`, `0x9D6EE`, `0x9D712`, `0x9D73A`, `0x9D75D`. Its generic CFG left exactly one reachable unresolved indirect `jmpq *%rax` at REL+`0x279`, so D97AI correctly remained INCONCLUSIVE.

D97AJ revalidated the historical D97AB seven-entry switch resolution on the exact A4F image. All seven entries are exact instruction boundaries on current A4F, and the switch construction is unchanged. After replacing that one known indirect with its seven proven targets:

```text
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=317
CFG_REACHABLE_WITH_EXIT110_BLOCKED_AND_SWITCH=314
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
```

All five late diagnostic xrefs are unreachable from the normal function entry and remain unreachable with the exit110 region blocked. Authoritative classification:

`D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_FULLY_RESOLVED_REACHABLE_CFG`

This closes the internal-bypass hypothesis. Do not weaken or suppress the late validator.

## CURRENT ACTION — full-image diagnostic origin / external-entry audit
No Root Patch and no reboot are authorized.

The contradiction is now: runtime proves A4F/32023 as the 28/28 diagnostic sender, while a fully resolved CFG from the normal `validSimulatorMetadata` entry cannot reach the five mapped late diagnostic xrefs at all.

Next single bounded action is read-only ASUS2 full-image mapping of diagnostic origin:
1. enumerate every code xref across exact A4F to the five exact simulator-limit string literals, not only xrefs within `validSimulatorMetadata`;
2. identify the symbol/function owner of every xref;
3. enumerate direct branches/calls from outside `validSimulatorMetadata` into its interior, especially `0x9D6C5..0x9D77F`;
4. enumerate statically recoverable address-taken/RIP-relative references into those internal late addresses;
5. if another diagnostic xref or external entry exists, map the earliest upstream payload/state handoff for H1/H2/H3; if neither exists, persist the contradiction before any new runtime observer.

No source/system/Golden mutation, service launch, Root Patch or reboot. One bounded action, complete raw output, then STOP.
