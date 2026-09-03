# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AM_ROOT_PATCH_FULL_PASS_ACCELERATED_BOOT_NEXT.md`
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

## D97AM authoritative v3 major build/private release — FULL PASS
Private repo/branch/head `StefanAlMare/Private-Work` / `oclp7-d97am-github-build` / `6cf6d143bed3e2c5601a7f19c9f16c5e5dd9d01d`; workflow/run/job `349724427 / 33812721798 / 100838020678`; release ID/tag `382366988 / oclp7-d97am-run-33812721798-attempt-1`.

Packaged executable exact `6596496` bytes / SHA256 `fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3` / x86_64. App ZIP exact `751495650` bytes / SHA256 `d6aca517ae89c7676d3cd416178e4a3a9ba4b23d7658b9e7d3bf879faeabc9ca`. ASUS2 private-release artifact audit is FULL PASS.

## D97AM exact ASUS2 deploy/open — FULL PASS
Deploy/open wrapper commit/blob `e2284bc23dc90aac0b926b0012b4724af28a33a0` / `577acb4f98dd3c0bbdd20ccdc46962a3284d394c`.

Exact live D97AH preimage was revalidated, timestamped backup `/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713` retained, exact D97AM deployed at `/Applications/OpenCore-Patcher.app`, and fresh exact-path PID `2980` proven.

```text
D97AM_LIVE_APP_IDENTITY=PASS
D97AM_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AM_DEPLOYED_EXACT_OPENED
FINAL_LIVE_EXE_BYTES=6596496
FINAL_LIVE_EXE_SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
```

Classification: `D97AM_ASUS2_EXACT_APP_DEPLOY_OPEN=FULL_PASS`.

## D97AM manual Root Patch — FULL PASS
The complete manual Root Patch output was audited raw. Exact local metallib `26.6.2-25G82` was used; normal OCLP root-patch preflight and patchsets completed.

Functional chain:

```text
D81P_TRUE_FIVE_FINAL_MTL_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6_REQUEST_DIALECT_CALLSITE_PORTS=PASS
P7_COMMITTED_MTL_SHA=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
P7_RAW88_A8_READ_PORTS=PASS
```

The complete Root Patch log contains zero occurrences of `D97AD`; the terminal classifier did not run.

Exact D97AM natural-flow stamp:

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

## CURRENT ACTION — first D97AM accelerated boot
User is authorized to reboot manually into the normal accelerated/root-patched configuration. No additional patching or mutation is authorized before this boot.

If accelerated GUI is usable, keep that boot and return with the observed state. If no usable image appears, hard restart/power-cycle and boot VESA recovery according to `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`, then return. The immediately preceding accelerated D97AM boot is the authoritative runtime evidence window; the later VESA recovery boot must be excluded.

On return, establish exact reboot chronology before collecting/interpreting logs. No further Root Patch is authorized in this sequence.