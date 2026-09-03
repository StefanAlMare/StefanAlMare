# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AK_ORIGIN_CLOSED_D97AL_P7_NATURAL_FLOW_DESIGN_PASS_SOURCE_INTEGRATION_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This file is an index/frontier summary. Exact historical detail is preserved in incremental checkpoints and repository history; older checkpoints are not superseded except where a later checkpoint explicitly corrects an interpretation.

## Permanent protocol
Routine/small tests, source edits, probes, packaged-runtime tests, artifact/reassembly checks, live app/hardware/accelerated/VESA evidence stay on ASUS2. GitHub is only for major/substantial compile/build/package. No automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

## Functional baseline
Accepted five-functional-patch baseline:
`P1 -> P2b -> P3 -> AIR00 -> D34`.

True-five SHA256: `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Golden root-patched MTLCompiler SHA256: `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
P6/P7 retained with runtime sufficiency NEGATIVE.

## Durable D97 diagnostic lineage
D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Historical accelerated D97AD boot `2026-09-02 00:10`, later VESA `00:12` excluded. D97AEQ proved 28/28 natural exit(1), invalidating the terminal classifier as a valid runtime outcome map. D97AES proved all 33 historical diagnostics across 28/28 PIDs came from 32023/D5CE and rejected 3802 generation selection for that cohort. D97AER mapped the late simulator-limit family. D97AET sender PCs did not prove traversal past the D97AD terminal. D226 shared-cache image is a separate input lineage; cross-image semantic mapping remains unestablished. D97AEZ task-port observer retired after policy denial.

## D97AF / D97AG / D97AH transaction evolution
D97AF froze A4F UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`; D97AD + A4F SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

D97AF build/deploy passed but Root Patch was invalid because packaged Python lacked `os.listxattr`; target mutation was not reached and old exception handling misleadingly continued.

D97AG replaced xattr access with fail-closed `/usr/bin/xattr` and installed fatal unmount + bare re-raise. D97AG major build workflow/run/job `348876070 / 33696449978 / 100466229401`; app ZIP SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`; packaged exe SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`. Real Root Patch then failed closed at `/bin/chflags`; ASUS2 proved `/usr/bin/chflags` valid.

D97AH changed exactly two method-local `/bin/chflags` tokens to `/usr/bin/chflags`. Exact local pre-natural-flow source identities:

```text
HELPERS_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
SYSPATCH_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AH_METHOD_SHA256=fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a
```

Authoritative D97AH major build/private release:
- repo/branch/head `StefanAlMare/Private-Work` / `oclp7-d97ah-github-build` / `d04ddd28c784a0b30c6629feeface10804d5d591`;
- workflow/run/job `349436422 / 33769927671 / 100697248264`;
- app ZIP `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`;
- packaged executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Exact D97AH deployed app remains live; D97AG backup retained at `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

## D97AH Root Patch and accelerated result
D97AH manual Root Patch is FULL PASS. The corrected privileged transaction committed exact A4F UUID-only postimage, preserved metadata and completed atomic same-volume rename, AuxKC and APFS snapshot.

Accelerated boot around 23:15 remained `NEGATIVE_NO_USABLE_GUI`. Exact current VESA recovery begins `2026-09-03 23:17:53 +0300`, `kern.boottime sec=1788466673`.

D97AF structured runtime provenance is PROVEN 28/28: every failing diagnostic sender is exact path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`, UUID A4F; old D5CE count zero. Direct runtime text-byte capture remains not performed and exact D97AH service exit status remains UNKNOWN/INCONCLUSIVE.

## D97AI / D97AJ fully resolved A4F CFG
D97AI verified exact A4F/D97AD terminal and five late xrefs but left the known REL+0x279 `jmpq *%rax` unresolved. D97AJ revalidated D97AB's seven-entry switch on current A4F and proved:

```text
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=317
CFG_REACHABLE_WITH_EXIT110_BLOCKED_AND_SWITCH=314
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_FULLY_RESOLVED_REACHABLE_CFG
```

Interpretation correction: exits 110..114 are project-invented terminal diagnostics, not donor/Sequoia behavior. The natural P7 bytes at `0x9D6BD` are `8b8d10feffff83f941`; D97AD replaces them with terminal `6a6e5fe9bb38f6ff90`. D97AJ therefore closes only hidden bypass around our artificial terminal.

## D97AK full-image diagnostic-origin audit — PASS
D97AK proved each of the five simulator-limit strings occurs exactly once and has exactly its known direct xref inside `validSimulatorMetadata`. No alternate origin/entry exists:

```text
ADDITIONAL_DIRECT_STRING_XREF_COUNT=0
TOTAL_INDIRECT_STRING_POINTER_XREF_COUNT=0
EXTERNAL_DIRECT_INTERIOR_ENTRY_COUNT=0
EXTERNAL_DIRECT_LATE_REGION_ENTRY_COUNT=0
EXTERNAL_RIP_VALIDATOR_REFERENCE_COUNT=0
EXTERNAL_RIP_LATE_REGION_REFERENCE_COUNT=0
RAW_ABSOLUTE_LATE_POINTER_TOTAL=0
D97AK_DIAGNOSTIC_ORIGIN=ONLY_KNOWN_UNREACHABLE_DIRECT_XREFS_ZERO_STATIC_EXTERNAL_LATE_ENTRY
```

This closes the remaining static alternative-origin/external-entry explanation for A4F.

## D97AL P7 natural-flow design — FULL PASS
D97AL reverified current local source and active order exactly:
`selector -> control -> P6 -> P7 -> D97AD -> D97AF`.

In-memory reversal proved A4F -> exact D97AD -> exact P7. Restoring all six D97AD terminal windows and zeroing the shared exit stub yields exact P7 SHA256:
`6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

New frozen natural-flow provenance UUID:
`0FC4C627-2A5D-491B-8101-00CAAA7116B7`.
A4F remains permanently bound to the D97AD-instrumented 28/28 cohort.

P7 + the new UUID differs by exactly 16 LC_UUID bytes at `0xAB0..0xABF` and has deterministic final SHA256:
`e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

Classification: `D97AL_P7_NATURAL_FLOW_SYNTHETIC_DESIGN=STATIC_PROVEN`.

## CURRENT ACTION
No Root Patch and no reboot.

Perform one bounded fail-closed ASUS2 local source integration only:
- remove exactly one active D97AD call, leave its helper definition dormant;
- retain selector/control/P6/P7;
- retarget the existing privileged UUID-stamp transaction to require exact P7 preimage SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
- stamp frozen UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`;
- require final SHA `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`;
- preserve D97AG xattr/fatal boundary, D97AH `/usr/bin/chflags`, and `metal_3802.py` byte-identical;
- pre-audit candidate AST/compile/diff, create backups, CAS/atomic replace with rollback, audit exact final source, then STOP.

No local major build. After assistant audit, sync exact source to private GitHub and perform the major build/package there. Installed app/system target/Golden remain unchanged until separately authorized.