# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_ACCEL_0229_NEGATIVE_WINDOWSERVER_XPC_INTERRUPTED_D97AN_RUNTIME_AUDIT_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is an index/frontier summary. Exact historical detail is preserved in incremental checkpoints and repository history; older checkpoints are not superseded except where a later checkpoint explicitly corrects an interpretation.

## Permanent protocol
Routine/small tests, source edits, probes, packaged-runtime tests, artifact/reassembly checks, live app/hardware/accelerated/VESA evidence stay on ASUS2. GitHub is only for major/substantial compile/build/package. No automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

## Functional baseline
Accepted five-functional-patch baseline: `P1 -> P2b -> P3 -> AIR00 -> D34`.
True-five SHA256 `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. Golden root-patched MTLCompiler SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`. P6/P7 retained with runtime sufficiency NEGATIVE.

## Durable D97 diagnostic lineage
D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.
Historical accelerated D97AD boot `2026-09-02 00:10`, later VESA `00:12` excluded. D97AEQ proved 28/28 natural exit(1), invalidating the terminal classifier as a valid runtime outcome map. D97AES proved all 33 historical diagnostics across 28/28 PIDs came from 32023/D5CE and rejected 3802 generation selection for that cohort. D97AER mapped the late simulator-limit family. D97AET sender PCs did not prove traversal past the D97AD terminal. D226 shared-cache image is a separate input lineage; D97AEZ task-port observer retired.

## D97AF / D97AG / D97AH transaction evolution
D97AF froze A4F UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`; D97AD + A4F SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.
D97AF Root Patch was invalid because packaged Python lacked `os.listxattr`. D97AG corrected xattr access to fail-closed `/usr/bin/xattr` and installed fatal unmount + bare re-raise; its real Root Patch failed closed at `/bin/chflags`. ASUS2 proved `/usr/bin/chflags` valid. D97AH changed exactly two method-local `/bin/chflags` tokens to `/usr/bin/chflags`.

Authoritative D97AH major build/private release:
- repo/branch/head `StefanAlMare/Private-Work` / `oclp7-d97ah-github-build` / `d04ddd28c784a0b30c6629feeface10804d5d591`;
- workflow/run/job `349436422 / 33769927671 / 100697248264`;
- app ZIP `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`;
- packaged executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Exact D97AH app remained live until D97AM deploy; D97AG backup retained. D97AH manual Root Patch is FULL PASS; accelerated boot remained `NEGATIVE_NO_USABLE_GUI`. Current pre-D97AM VESA recovery began `2026-09-03 23:17:53 +0300`, sec `1788466673`. D97AF structured runtime provenance is PROVEN 28/28 for exact 32023/A4F diagnostic sender; old D5CE count zero.

## D97AI / D97AJ fully resolved A4F CFG and correction
D97AJ revalidated the known seven-entry switch and proved zero reachable unresolved indirects and no bypass to the five late xrefs in the instrumented A4F CFG. Interpretation correction: exits 110..114 are project-invented terminal diagnostics, not donor/Sequoia behavior. Natural P7 bytes at `0x9D6BD` are `8b8d10feffff83f941`; D97AD replaces them with terminal `6a6e5fe9bb38f6ff90`. Therefore natural-flow testing requires complete D97AD removal, not only exit110 removal.

## D97AK full-image diagnostic-origin audit — PASS
D97AK proved each of the five simulator-limit strings occurs exactly once and has exactly its known direct xref inside `validSimulatorMetadata`. No alternate origin/entry exists: additional direct xrefs 0, indirect pointer xrefs 0, external direct interior/late entries 0, external RIP references 0, raw absolute late pointers 0.

## D97AL P7 natural-flow design — FULL PASS
D97AL reverified local source and active order `selector -> control -> P6 -> P7 -> D97AD -> D97AF`, then in-memory reversed A4F -> exact D97AD -> exact P7. Exact P7 SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.
New frozen natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`. P7 + new UUID changes exactly 16 bytes at `0xAB0..0xABF` and has deterministic SHA256 `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

## D97AM local P7 natural-flow source integration — FULL PASS
D97AM integrator artifact commit/blob `c7532f00b241d4e197b3408fd6d2e3010203541c` / `e758a5fb2b8c2fed2f7d2efd1678cbb8c477aa53`.
Preimage gates and candidate AST/compile audit passed; recoverable backup created at `/Users/alex/Desktop/OCLP7_D97AM_SOURCE_BACKUP_20260904-010010_2161`.

Exact post-state:

```text
HELPERS_SHA256=7c1127a62379ea5cef9efd42f5d14e7956def01e6f7635defe4f64e77473a844
SYSPATCH_SHA256=78e096b982c8a2e8c78f8bd18b32fc0961fa84e26d573a8d8fa304393d6a29a3
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AM_METHOD_SHA256=45e3b803a52fc876b0a1c4ebae6fe23878f32febc44368c4aaf32453170dcc6f
FINAL_ACTIVE_ORDER=selector,control,p6,p7,d97am-natural-flow-stamp
D97AD_ACTIVE_CALL_COUNT=0
D97AD_HELPER_DEFINITION_DORMANT_COUNT=1
OLD_D97AF_HELPER_DEFINITION_COUNT=0
D97AM_HELPER_DEFINITION_COUNT=1
P7_NATURAL_FLOW_PRE_SHA256=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
P7_NATURAL_FLOW_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
P7_NATURAL_FLOW_EXPECTED_POST_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
METAL_BYTE_IDENTITY_PRESERVED=PASS
D97AM_SOURCE_TRANSACTION=PASS
```

Installed app/system target/Golden were unchanged by source integration. One cosmetic error-message phrase still says `expected exact D97AD preimage`, while the enforced preimage SHA is P7; transaction semantics are unaffected.

## D97AM private build tooling evolution
Private build repo/branch: `StefanAlMare/Private-Work` / `oclp7-d97am-github-build`, based on audited D97AH head `d04ddd28c784a0b30c6629feeface10804d5d591`.

Two non-authoritative tooling false failures occurred before any major build:
- v1 head `114b25b0a9bf3921901a0bfe4cb10b89b88bd92e`, workflow/run/job `349701944 / 33812043670 / 100835838242`: wrong initially guessed transform SHA/size pin; D97AH replay passed, D97AM transform/build not reached;
- v2 head `4a207fdcc2dc98c36352ef3fa9a56de44417f21a`, workflow/run/job `349721036 / 33812588726 / 100837592383`: GNU-only `base64 -w0` in macOS pre-build locator; build core skipped.

These are tooling history only, not Haswell evidence.

## D97AM authoritative v3 GitHub build/private release — FULL PASS
Exact identity:

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97am-github-build
HEAD_SHA=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d
WORKFLOW_ID=349724427
RUN_ID=33812721798
RUN_ATTEMPT=1
JOB_ID=100838020678
RUNNER_LABEL=macos-15-intel
JOB_CONCLUSION=success
```

The authoritative run reconstructed exact D97AH source, applied the deterministic D97AM transform and reproduced exact ASUS2 source hashes. Observed transform identity: manifest Git blob `21e84bef05891c0f7876d85cf67177fd641deacc`, transform Git blob `7aa39868e406b54d3ffa5b5df08cb2cc4c4a2918`, transform SHA256 `d91da748c01f5bd4921de3c8c0bc3e9799a563cee348a33075e2538c4be5d870`, `11116` bytes.

GitHub source audit proved exact D97AM method SHA, dormant D97AD helper unchanged, D97AD active call zero, exact selector/control/P6/P7/D97AM call order, required P7/new-UUID/new-post-SHA constants, forbidden D97AD/A4F constants absent, D97AG xattr/fatal boundary retained and D97AH `/usr/bin/chflags` retained.

Major Intel build PASS. Signing/notarization remained explicitly skipped/not verified.

Packaged PyInstaller audit PASS. Exact executable:
`6596496` bytes / SHA256 `fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3` / x86_64.

Exact app ZIP:
`751495650` bytes / SHA256 `d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca`.

Split:
- part00 `390000000` bytes / SHA256 `9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67`;
- part01 `361495650` bytes / SHA256 `80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08`;
- reassembly PASS.

Reports ZIP `6517739` bytes / SHA256 `ab0e5926efed5ddbe3c4032bfd7584097a309b2bd1964e2e6349e3734eb03481`.

Private release:
- release ID `382366988`;
- tag `oclp7-d97am-run-33812721798-attempt-1`;
- target exact head `6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d`;
- 7 exact assets, all uploaded and digest-audited by the workflow.

Classification: `D97AM_GITHUB_MAJOR_BUILD_PACKAGE_PRIVATE_RELEASE=FULL_PASS`.
This is build/package/release provenance only, not installed-state, Root Patch, runtime or functional-success evidence.

## D97AM ASUS2 artifact audit — FULL PASS
Artifact audit V1 commit/blob `80f652130f6d0fc32319b727211576388cdb3b10` / `7fb4215818665850b7e42e61d4e96c1ffe7568e0` proved release metadata, all 7 local asset size/SHA identities, `RELEASE-ASSETS.SHA256` and `PARTS.SHA256`, then failed on a redundant/non-existent `GITHUB_REPOSITORY` manifest-field expectation. The authoritative generator never wrote that field; repository binding remained independently enforced through the exact private release API endpoint and exact release/tag/head/assets. V1 is tooling false failure only.

V2 commit/blob `4d41ac00685d325910360a05d9b816e130e0fd15` / `086c1c866519232276c6f4f26c911c4c21a003ea` removed exactly that one redundant requirement in memory and preserved the rest of V1 unchanged.

V2 on ASUS2 proved all seven local assets exact, release checksum and part checksum files exact, split manifest content exact, release identity exact, local two-part reassembly exact, app ZIP CRC/safe-members PASS, exact embedded executable `6596496 / fbcb69e... / x86_64`, reports ZIP CRC/safe-members PASS, packaged executable byte identity repeated inside reports, split manifest byte identity and required source/build/transform report markers.

Final classification: `D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=FULL_PASS`.
Mutation ledger: source NO; installed app NO; system target NO; Golden NO; Root Patch AUTO-NO; reboot AUTO-NO.

## D97AM exact ASUS2 deploy/open — FULL PASS
Deploy/open wrapper commit/blob: `e2284bc23dc90aac0b926b0012b4724af28a33a0` / `577acb4f98dd3c0bbdd20ccdc46962a3284d394c`.

The flow rebound exact private release/parts, reassembled exact app ZIP `751495650 / d6aca517...`, staged exact D97AM executable `6596496 / fbcb69e... / x86_64`, revalidated exact live D97AH preimage `6596544 / 207b4e... / x86_64`, created timestamped backup `/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`, switched live app fail-closed, and reverified live D97AM exact.

Fresh exact-path process proof:
`FRESH_D97AM_EXACT_PIDS=2980`.

Final markers:

```text
D97AH_LIVE_PREIMAGE=PASS
D97AM_NEW_APP_READY_EXACT=PASS
D97AM_LIVE_APP_IDENTITY=PASS
D97AM_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AM_DEPLOYED_EXACT_OPENED
FINAL_LIVE_EXE_BYTES=6596496
FINAL_LIVE_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

Classification: `D97AM_ASUS2_EXACT_APP_DEPLOY_OPEN=FULL_PASS`.

## D97AM manual Root Patch — FULL PASS
The complete Root Patch output was audited raw. Exact local metallib `26.6.2-25G82` was used and normal OCLP preflight/patchsets completed.

Functional chain:

```text
D81P_TRUE_FIVE_FINAL_MTL_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6_REQUEST_DIALECT_CALLSITE_PORTS=PASS
P7_COMMITTED_MTL_SHA=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
P7_RAW88_A8_READ_PORTS=PASS
```

The complete Root Patch log contains zero occurrences of `D97AD`; the terminal classifier did not run.

Exact D97AM natural-flow transaction:

```text
D97AM_LC_UUID_BUILD_STAMP_PRE_SHA=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
D97AM_LC_UUID_BUILD_STAMP_OLD=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
D97AM_LC_UUID_BUILD_STAMP_NEW=0FC4C627-2A5D-491B-8101-00CAAA7116B7
D97AM_LC_UUID_BUILD_STAMP_OFFSET=0xAB0
D97AM_LC_UUID_BUILD_STAMP_POST_SHA=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
D97AM_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AM_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AM_LC_UUID_BUILD_STAMP=PASS
D97AM_RUNTIME_PROVENANCE=NOT_YET_TESTED
D97AM_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
```

AuxKC build/forcing, APFS snapshot creation, root-volume unmount and `Patching complete` all completed. No FAIL/traceback/exception/error marker exists in the raw log.

Classification: `D97AM_ROOT_PATCH=FULL_PASS`.

## D97AM accelerated boot 02:29 — NEGATIVE_NO_USABLE_GUI
Reboot chronology returned by the user fixes `02:29` as D97AM accelerated and `02:32` as VESA recovery. The authoritative historical window is `2026-09-04 02:29:00..02:31:59` local time.

WindowServer PID 498 launched at `02:31:16.1804` and crashed at `02:31:30.5263` with `COREANIMATION Code 4`, `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED` after retries. Stack again reaches QuartzCore Metal pipeline-state creation and SkyLight/CompositorMetal. Haswell MTL driver and GPUCompiler 32023 support libraries are present.

Classification: `D97AM_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`.

This proves complete D97AD removal did not by itself recover GUI. WindowServer remains downstream; exact natural-flow MTLCompilerService behavior is not inferred from this alone.

## CURRENT ACTION
Run D97AN read-only wrapper `OCLP7_D97AN_READONLY_ACCEL_0229_NATURAL_FLOW_RUNTIME_PROVENANCE_AUDIT.command`, commit `8685d4e9d5080b533ed06e9661aee759ec174217`, blob `a12775867f57e9edd949fefdbeacba6991d3aa48`.

It audits the fixed 02:29 accelerated cohort for exact 32023 MTLCompiler sender UUID/path, the five late simulator diagnostic families, per-PID coverage, launchd lifecycle/exit text, artificial 110..114 text evidence and WindowServer correlation.

STOP after D97AN. No Root Patch, reboot, source/app/system/Golden/snapshot mutation.