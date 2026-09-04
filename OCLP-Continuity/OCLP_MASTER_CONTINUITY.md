# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AN_NATURAL_UUID_PROVEN_79_OF_79_LATE_PARSER_INCONCLUSIVE_D97AO_STATIC_PC_CFG_NEXT.md`
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

D97AF first Root Patch was invalid because packaged Python lacked `os.listxattr`; target stamp mutation was not reached and old exception handling allowed misleading continuation. D97AG corrected xattr access to fail-closed `/usr/bin/xattr` and installed fatal unmount + bare re-raise. Its real Root Patch failed closed at hard-coded `/bin/chflags`, before staged write/rename/UUID commit. ASUS2 proved `/usr/bin/chflags` valid. D97AH changes exactly two method-local `/bin/chflags` tokens to `/usr/bin/chflags` and otherwise preserves the D97AG/D97AF transaction.

Authoritative D97AH build/private release: repo/branch/head `StefanAlMare/Private-Work` / `oclp7-d97ah-github-build` / `d04ddd28c784a0b30c6629feeface10804d5d591`; workflow/run/job `349436422 / 33769927671 / 100697248264`; app ZIP `751494634` / `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`; executable `6596544` / `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf` / x86_64.

D97AH is retained as backup at `/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`; older D97AG backup remains `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

D97AH manual Root Patch is FULL PASS. Its accelerated boot remained `NEGATIVE_NO_USABLE_GUI`. Structured JSON runtime audit proved 28/28 failing diagnostic PIDs had exact 32023/A4F sender provenance; old D5CE count was zero. Direct runtime text-byte capture remains not performed.

## D97AI / D97AJ interpretation correction
D97AJ fully resolved the known seven-entry switch in current A4F and proved zero remaining reachable unresolved indirects and no bypass to the five late xrefs in the instrumented CFG.

Critical correction: D97AD exits `110..114` are project-invented terminal diagnostics, not donor/Sequoia behavior. At image offset `0x9D6BD`, natural P7 bytes are `8b8d10feffff83f941`; D97AD replaced them with terminal `6a6e5fe9bb38f6ff90`. Therefore D97AJ only proved no hidden bypass around our artificial terminal; it did not prove natural donor/P7 flow cannot continue. Natural-flow testing required complete D97AD removal, not only exit110 removal.

## D97AK full-image origin closure — PASS
D97AK proved each of the five simulator-limit strings occurs exactly once and has exactly its known direct xref inside `validSimulatorMetadata`, with zero alternate direct/indirect string origins and zero external direct/RIP/raw-pointer late entries.

## D97AL P7 natural-flow design — FULL PASS
D97AL reversed A4F -> exact D97AD -> exact P7 in memory. Exact P7 SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

Frozen natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`. P7 + new UUID differs by exactly 16 LC_UUID bytes at `0xAB0..0xABF` and has deterministic SHA256 `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`. A4F remains permanently bound to the instrumented D97AD cohort.

## D97AM local source integration — FULL PASS
D97AM removed exactly the active D97AD call while retaining its helper dormant, retargeted the privileged stamp method to P7 natural-flow, retained selector/control/P6/P7, preserved D97AG xattr/fatal semantics, preserved D97AH `/usr/bin/chflags`, and kept `metal_3802.py` byte-identical.

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

Local backup: `/Users/alex/Desktop/OCLP7_D97AM_SOURCE_BACKUP_20260904-010010_2161`.

## D97AM authoritative v3 major build/private release — FULL PASS
Private repo/branch/head `StefanAlMare/Private-Work` / `oclp7-d97am-github-build` / `6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d`; workflow/run/job `349724427 / 33812721798 / 100838020678`; release ID/tag `382366988 / oclp7-d97am-run-33812721798-attempt-1`.

Packaged executable exact `6596496` / `fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3` / x86_64. App ZIP exact `751495650` / `d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca`. ASUS2 private-release artifact audit V2 is FULL PASS. Signing/notarization remains NOT VERIFIED.

## D97AM exact ASUS2 deploy/open — FULL PASS
Exact live D97AH was revalidated; timestamped D97AH backup retained; exact D97AM deployed at `/Applications/OpenCore-Patcher.app`; fresh exact-path PID `2980` proven.

```text
D97AM_LIVE_APP_IDENTITY=PASS
D97AM_EXACT_APP_DEPLOY_OPEN_STOP=PASS
FINAL_LIVE_EXE_BYTES=6596496
FINAL_LIVE_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
```

## D97AM manual Root Patch — FULL PASS
The complete Root Patch output was audited raw. P1/P2b/P3/AIR00/D34/P6/P7 all completed. The Root Patch log contains zero `D97AD` occurrences.

```text
D81P_TRUE_FIVE_FINAL_MTL_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P7_COMMITTED_MTL_SHA=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
D97AM_LC_UUID_BUILD_STAMP_OLD=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
D97AM_LC_UUID_BUILD_STAMP_NEW=0FC4C627-2A5D-491B-8101-00CAAA7116B7
D97AM_LC_UUID_BUILD_STAMP_POST_SHA=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
D97AM_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AM_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AM_LC_UUID_BUILD_STAMP=PASS
```

AuxKC, APFS snapshot, unmount and `Patching complete` all succeeded. Classification `D97AM_ROOT_PATCH=FULL_PASS`.

## D97AM accelerated boot 02:29 — NEGATIVE_NO_USABLE_GUI
Chronology is fixed: `02:29` accelerated D97AM, `02:32` VESA recovery. Authoritative accelerated window `2026-09-04 02:29:00..02:31:59` local.

WindowServer PID 498 launched at `02:31:16.1804` and crashed at `02:31:30.5263` with COREANIMATION Code 4 and `XPC_ERROR_CONNECTION_INTERRUPTED` after retries. Stack reaches Metal pipeline-state creation and SkyLight/CompositorMetal; Haswell MTL driver and GPUCompiler 32023 support libraries are present.

Classification `D97AM_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`. Removing D97AD did not by itself recover GUI. WindowServer remains downstream.

## D97AN runtime provenance — PROVEN 79/79; late literal classifier INCONCLUSIVE
D97AN read-only wrapper commit/blob `8685d4e9d5080b533ed06e9661aee759ec174217` / `a12775867f57e9edd949fefdbeacba6991d3aa48`. Current VESA boot sec `1788478349`.

Structured accelerated-window evidence:

```text
MTL_JSON_RECORDS=351
MTL_PROCESS_PID_COUNT=66
ALL_SENDER_COUNT=79|PATH=/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler|UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
EXPECTED_UUID_MTLCOMPILER_SENDER_MATCHES=79
OLD_D5CE_UUID_MTLCOMPILER_SENDER_MATCHES=0
OLD_A4F_UUID_MTLCOMPILER_SENDER_MATCHES=0
D97AN_RUNTIME_32023_SENDER_PROVENANCE=PROVEN_EXPECTED_NATURAL_FLOW_UUID
```

Thus the current failing 32023 sender is exactly the natural-flow UUID image; stale D5CE/A4F ambiguity is closed for the current cohort.

All 79 exact 32023 sender records concentrate at three outer senderProgramCounter offsets:

```text
0x9FFEE = 7
0xA0521 = 7
0xA5F81 = 65
```

Their unified-log messages are privacy/format truncated (`upported in the simulator...`, `were used`), so D97AN's literal five-late classifier returning zero matches is NOT a hard negative. Authoritative classification:
`D97AN_FIVE_LATE_DIAGNOSTIC_RUNTIME_REACHABILITY=INCONCLUSIVE_TRUNCATED_UNIFIED_LOG_MESSAGE_CLASSIFIER`.

Launchd showed repeated spawn/inactive cycles. Text parser found zero 110..114 evidence, consistent with D97AD removal, but did not recover an exact natural exit status. Exact MTLCompilerService exit status remains UNKNOWN/INCONCLUSIVE. Direct runtime text-byte read remains NOT PERFORMED.

WindowServer correlation remains strongly downstream: 454 XPC-interrupted text records and 35 compilation-failed records in the fixed accelerated window.

## CURRENT ACTION — D97AO read-only static/runtime-PC reconciliation
Run public wrapper `OCLP7_D97AO_READONLY_NATURAL_P7_RUNTIME_PC_AND_RESOLVED_CFG_AUDIT.command`, commit `2401be6af44180ae35040ad752ea3b361238d0b7`, Git blob `969701ab1fb00bea91d44196b463e3a400efd258`.

D97AO pins current VESA boot sec `1788478349`, exact natural target SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`, UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`, and natural bytes `8b8d10feffff83f941` at former exit110 site `0x9D6BD`.

It maps runtime PCs `0x9FFEE/0xA0521/0xA5F81`, inventories simulator/`were used` string/xref evidence, and reconstructs the natural-P7 `validSimulatorMetadata` CFG with the already-proven D97AB seven-entry switch resolution to determine static reachability of the five known late xrefs. Static reachability must remain distinct from runtime reachability.

STOP after D97AO. No Root Patch, reboot, service launch, source/app/system/Golden/snapshot mutation.