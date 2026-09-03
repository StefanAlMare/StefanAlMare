# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AM_DEPLOY_OPEN_FULL_PASS_ROOT_PATCH_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-04 EEST

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

Routine/small tests, source inspection, small source edits, probes, packaged-runtime checks, artifact/reassembly verification, live installed-state checks, hardware evidence, accelerated boots and VESA evidence stay on ASUS2 under user control. GitHub is used only for major/substantial compile/build/package workloads. Local major compilation requires explicit user authorization. Never auto Root Patch or reboot.

Golden Sequoia remains immutable/read-only. Golden root-patched MTLCompiler SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.

D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized. D97AEX/D97AEZ retired.

Architecture remains: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.
Evidence labels remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/STATIC-PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.

## Accepted functional lineage
Exactly P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset.
Accepted true-five SHA256 `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
P6/P7 remain retained with runtime sufficiency NEGATIVE and are not part of the accepted five-functional-patch baseline. D22 remains semantic proof for AIR2.6/Metal3.1. D34 cave `0xEF8..0xEFE` is protected.

## Durable D97 diagnostic lineage
D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Selector-only MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Historical D97AD accelerated boot `2026-09-02 00:10`, later VESA `00:12` excluded. D97AEQ proved 28/28 natural `exit(1)` and invalidated the whole-stage terminal classifier as a valid runtime outcome map. D97AES proved all 33 historical diagnostics across 28/28 PIDs came from `Versions/32023/MTLCompiler`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 was NEGATIVE for that cohort. D97AER mapped the five late simulator-limit diagnostics. D97AET sender PCs did not directly prove traversal past the D97AD terminal. D226 shared-cache image is a distinct input lineage; cross-image semantic site correlation is not established. D97AEZ task-port observer is retired.

## D97AF / D97AG / D97AH transaction lineage
D97AF froze UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E` for the D97AD-instrumented image. D97AD -> A4F UUID-only postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

D97AF first Root Patch was invalid because packaged Python lacked `os.listxattr`; target stamp mutation was not reached and old exception handling allowed misleading continuation. D97AG corrected xattr access to fail-closed `/usr/bin/xattr` and installed fatal unmount + bare re-raise. Its real Root Patch failed closed at hard-coded `/bin/chflags`, before staged write/rename/UUID commit. ASUS2 proved `/usr/bin/chflags` is the valid path. D97AH changes exactly two method-local `/bin/chflags` tokens to `/usr/bin/chflags` and otherwise preserves the D97AG/D97AF transaction.

Authoritative D97AH major build/private release:
- private repo `StefanAlMare/Private-Work`;
- branch `oclp7-d97ah-github-build`;
- head `d04ddd28c784a0b30c6629feeface10804d5d591`;
- workflow/run/job `349436422 / 33769927671 / 100697248264`;
- app ZIP `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`;
- packaged executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

D97AH is now retained as backup at `/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`; older D97AG backup remains `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

## D97AH Root Patch / accelerated / A4F provenance
D97AH manual Root Patch is FULL PASS. The real privileged transaction committed exact A4F UUID-only postimage, preserved metadata and completed atomic same-volume rename, AuxKC and APFS snapshot.

Accelerated boot around 23:15 remained `NEGATIVE_NO_USABLE_GUI`. Current recovery VESA `kern.boottime` is `2026-09-03 23:17:53 +0300`, sec `1788466673`.

Structured JSON runtime audit proved 28/28 failing diagnostic PIDs had sender exact 32023 path with UUID A4F; old D5CE count was zero. Classification: `D97AF_RUNTIME_PROVENANCE=PROVEN_28_OF_28_DIAGNOSTIC_COHORT`. Direct runtime text-byte capture remains not performed; exact D97AH MTLCompilerService exit status remains UNKNOWN/INCONCLUSIVE.

## D97AI / D97AJ interpretation correction
D97AJ fully resolved the one indirect switch in current A4F and proved zero remaining reachable unresolved indirects and no bypass to the five late xrefs in the instrumented CFG.

Critical methodology correction: D97AD exits `110..114` are project-invented terminal diagnostic markers, not donor/Sequoia behavior. At image offset `0x9D6BD`, natural P7 bytes are `8b8d10feffff83f941`; D97AD replaces them with terminal `6a6e5fe9bb38f6ff90`. Therefore D97AJ proves no hidden bypass around our artificial terminal, not that natural donor/P7 flow cannot continue. Do not remove only exit110; natural-flow requires complete D97AD removal.

## D97AK full-image origin closure — PASS
D97AK reverified exact current A4F and proved each of the five simulator-limit strings has only its known direct xref within `validSimulatorMetadata`, with zero alternate direct/indirect string origins and zero external direct/RIP/raw-pointer late entries. Classification: static alternative-origin/external-entry hypothesis NEGATIVE for exact A4F.

## D97AL P7 natural-flow design — FULL PASS
D97AL reversed A4F -> exact D97AD -> exact P7 entirely in memory. Restoring all six D97AD terminal windows and shared stub yields exact P7 SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

New frozen P7 natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`. A4F remains permanently bound to the D97AD-instrumented 28/28 cohort. P7 + new UUID differs by exactly 16 LC_UUID bytes at `0xAB0..0xABF` and has deterministic final SHA256 `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

## D97AM local source integration — FULL PASS
D97AM removed exactly the one active D97AD call while retaining its helper definition dormant, renamed/retargeted the active privileged stamp method to P7 natural-flow, retained selector/control/P6/P7, preserved D97AG xattr/fatal-boundary semantics, preserved D97AH `/usr/bin/chflags`, and kept `metal_3802.py` byte-identical.

Exact local post-state:

```text
HELPERS_SHA256=7c1127a62379ea5cef9efd42f5d14e7956def01e6f7635defe4f64e77473a844
SYSPATCH_SHA256=78e096b982c8a2e8c78f8bd18b32fc0961fa84e26d573a8d8fa304393d6a29a3
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AM_METHOD_SHA256=45e3b803a52fc876b0a1c4ebae6fe23878f32febc44368c4aaf32453170dcc6f
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

Local backup: `/Users/alex/Desktop/OCLP7_D97AM_SOURCE_BACKUP_20260904-010010_2161`.
One cosmetic residue remains inside an error string (`expected exact D97AD preimage`) while the actual enforced preimage constant is exact P7; it does not affect transaction semantics.

## D97AM GitHub build evolution
Private repo `StefanAlMare/Private-Work`, branch `oclp7-d97am-github-build`, based on audited D97AH head `d04ddd28c784a0b30c6629feeface10804d5d591`.

Two preliminary runs are tooling false failures only:
- v1 head `114b25b0a9bf3921901a0bfe4cb10b89b88bd92e`, workflow/run/job `349701944 / 33812043670 / 100835838242`: wrong initially guessed transform SHA/size pin; stopped before D97AM transform/build;
- v2 head `4a207fdcc2dc98c36352ef3fa9a56de44417f21a`, workflow/run/job `349721036 / 33812588726 / 100837592383`: GNU-only `base64 -w0` in macOS locator; build core skipped.

Neither carries functional/runtime evidence.

## D97AM authoritative v3 major build/private release — FULL PASS
Exact build identity:

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

The run reassembled/replayed exact D97AH lineage, applied the deterministic D97AM transition, and matched exact ASUS2 source identities. Observed transform identity:

```text
D97AM_MANIFEST_GIT_BLOB=21e84bef05891c0f7876d85cf67177fd641deacc
D97AM_TRANSFORM_GIT_BLOB=7aa39868e406b54d3ffa5b5df08cb2cc4c4a2918
D97AM_TRANSFORM_SHA256=d91da748c01f5bd4921de3c8c0bc3e9799a563cee348a33075e2538c4be5d870
D97AM_TRANSFORM_BYTES=11116
```

Source audit passed exact source hashes, D97AM method SHA, dormant D97AD method identity, D97AD active-call count zero, exact active order selector/control/P6/P7/D97AM, P7/new UUID/new post-SHA constants, D97AG xattr/fatal boundary and D97AH chflags semantics.

`D97AM_MAJOR_INTEL_BUILD=PASS`.
Signing/notarization/security validation was explicitly skipped because credentials/details were incomplete; signing/notarization remains NOT VERIFIED, not PASS.

Packaged PyInstaller audit passed exact source/package module semantic identity, D97AM natural-flow method identity, dormant D97AD identity and xattr/chflags identity. Packaged executable:

```text
PACKAGED_EXE_BYTES=6596496
PACKAGED_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
PACKAGED_ARCH=x86_64
```

Application ZIP:

```text
APP_ZIP_BYTES=751495650
APP_ZIP_SHA256=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca
```

Split/reassembly:

```text
PART00_BYTES=390000000
PART00_SHA256=9181f6e5d100d971755d430fbf7e12a45dea921029900c90d3ec960f08e73e67
PART01_BYTES=361495650
PART01_SHA256=80f626024d92d9add35099ee903809e770c9e0ee85312d4fe46ce08d44159f08
D97AM_TWO_PART_SPLIT_REASSEMBLY=PASS
```

Reports ZIP `6517739` bytes / SHA256 `ab0e5926efed5ddbe3c4032bfd7584097a309b2bd1964e2e6349e3734eb03481`.

Private release:

```text
RELEASE_ID=382366988
RELEASE_TAG=oclp7-d97am-run-33812721798-attempt-1
RELEASE_TARGET_HEAD=6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d
RELEASE_ASSET_COUNT=7
```

All seven assets were uploaded and digest-audited by the authoritative workflow. Classification: `D97AM_GITHUB_MAJOR_BUILD_PACKAGE_PRIVATE_RELEASE=FULL_PASS`.

## D97AM ASUS2 private-release artifact audit — FULL PASS
Artifact auditor V1 commit/blob `80f652130f6d0fc32319b727211576388cdb3b10` / `7fb4215818665850b7e42e61d4e96c1ffe7568e0` had one tooling false failure: after already proving 7/7 local asset identities and checksum files, it incorrectly required a non-existent redundant `GITHUB_REPOSITORY` field inside the split manifest. The build generator never writes that field; repository binding is independently enforced through the exact private release API endpoint and release identity.

Auditor V2 commit/blob `4d41ac00685d325910360a05d9b816e130e0fd15` / `086c1c866519232276c6f4f26c911c4c21a003ea` removed exactly that one redundant manifest requirement in memory and changed no other audit logic.

ASUS2 V2 proved:

```text
D97AM_RELEASE_METADATA_BINDING=PASS
D97AM_ALL_SEVEN_LOCAL_ASSET_IDENTITIES=PASS
D97AM_RELEASE_ASSETS_SHA256_FILE=PASS
D97AM_PARTS_SHA256_FILE=PASS
D97AM_SPLIT_MANIFEST_CONTENT=PASS
D97AM_RELEASE_IDENTITY_CONTENT=PASS
REASSEMBLED_APP_ZIP_BYTES=751495650
REASSEMBLED_APP_ZIP_SHA256=d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca
D97AM_TWO_PART_REASSEMBLY_LOCAL=PASS
APP_ZIP_CRC=PASS
APP_ZIP_SAFE_MEMBERS=PASS
APP_ZIP_EXECUTABLE_BYTES=6596496
APP_ZIP_EXECUTABLE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
APP_ZIP_EXECUTABLE_ARCHS=x86_64
D97AM_APP_ZIP_EXECUTABLE_EXACT=PASS
REPORTS_ZIP_CRC=PASS
REPORTS_ZIP_SAFE_MEMBERS=PASS
REPORTS_PACKAGED_EXECUTABLE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
REPORTS_SPLIT_MANIFEST_BYTE_IDENTITY=PASS
D97AM_REPORTS_CONTENT_BINDING=PASS
D97AM_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=FULL_PASS
```

Artifact audit mutation ledger: source NO; installed app NO; system target NO; Golden NO; Root Patch AUTO-NO; reboot AUTO-NO.

## D97AM exact ASUS2 deploy/open — FULL PASS
Deploy/open wrapper commit/blob `e2284bc23dc90aac0b926b0012b4724af28a33a0` / `577acb4f98dd3c0bbdd20ccdc46962a3284d394c`.

Exact live D97AH preimage was revalidated before switching:

```text
LIVE_PRE_BYTES=6596544
LIVE_PRE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
LIVE_PRE_ARCHS=x86_64
D97AH_LIVE_PREIMAGE=PASS
```

The exact D97AM private release was reacquired, both parts and reassembled ZIP were reverified, and staged executable was exact `6596496 / fbcb69e... / x86_64`.

Timestamped D97AH backup retained:
`/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`.

Exact live D97AM after switch:

```text
LIVE_POST_BYTES=6596496
LIVE_POST_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
LIVE_POST_ARCHS=x86_64
D97AM_LIVE_APP_IDENTITY=PASS
```

A fresh process was proven from exact live path:
`FRESH_D97AM_EXACT_PIDS=2980`.

Final deployment markers:

```text
D97AM_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AM_DEPLOYED_EXACT_OPENED
FINAL_LIVE_EXE_BYTES=6596496
FINAL_LIVE_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
SOURCE_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

Classification: `D97AM_ASUS2_EXACT_APP_DEPLOY_OPEN=FULL_PASS`.

## CURRENT ACTION — manual D97AM Root Patch
FASTLANE through deploy/open is complete and audited. The next bounded ASUS2 action is manual Root Patch from the already-open exact D97AM app.

Expected critical transaction:
1. P1/P2b/P3/AIR00/D34/P6/P7 pass;
2. D97AD classifier is not invoked;
3. D97AM accepts exact P7 preimage SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
4. UUID changes exactly `D5CE0008-587C-3861-971A-4BAEFB7B9C5B -> 0FC4C627-2A5D-491B-8101-00CAAA7116B7`;
5. target post-SHA becomes exactly `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`;
6. D97AG xattr/fatal-boundary and D97AH `/usr/bin/chflags` semantics remain operational;
7. AuxKC/APFS snapshot/unmount/patch completion succeeds.

STOP after complete Root Patch output. Do not reboot until assistant audits the Root Patch.