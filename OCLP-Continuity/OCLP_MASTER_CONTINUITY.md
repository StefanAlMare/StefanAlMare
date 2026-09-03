# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AK_ORIGIN_CLOSED_D97AL_P7_NATURAL_FLOW_DESIGN_PASS_SOURCE_INTEGRATION_NEXT.md`
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

Golden Sequoia remains immutable/read-only. Golden root-patched MTLCompiler SHA256: `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.

D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized. D97AEX/D97AEZ retired.

Architecture remains: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.
Evidence labels remain distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/STATIC-PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.

## Accepted functional lineage
Exactly P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset.

Accepted true-five SHA256: `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
P6/P7 remain retained with runtime sufficiency NEGATIVE and are not part of the accepted five-functional-patch baseline. D22 remains semantic proof for AIR2.6/Metal3.1. D34 cave `0xEF8..0xEFE` is protected.

## Durable D97 lineage
D97AD final MTLCompiler SHA256: `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.
Selector-only MTLCompilerService SHA256: `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Historical D97AD accelerated boot `2026-09-02 00:10`, later VESA `00:12` excluded. D97AEQ proved 28/28 natural `exit(1)` and invalidated the whole-stage classifier as runtime outcome instrumentation. D97AES proved all 33 historical diagnostics across 28/28 PIDs came from `Versions/32023/MTLCompiler`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 was NEGATIVE for that cohort. D97AER mapped the five late simulator-limit diagnostics. D226 shared-cache image remains a distinct input lineage; cross-image semantic site correlation is not established. D97AEZ task-port observer is retired.

## D97AF / D97AG / D97AH transaction lineage
D97AF froze UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E` for the D97AD-instrumented image. D97AD -> A4F UUID-only expected postimage SHA256: `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

D97AF first Root Patch was invalid because packaged Python lacked `os.listxattr`; target stamp mutation was not reached and old exception handling allowed misleading continuation.

D97AG corrected xattr access to fail-closed `/usr/bin/xattr` and installed fatal unmount + bare re-raise. Its real Root Patch then failed closed at hard-coded `/bin/chflags`, before staged write/rename/UUID commit. ASUS2 proved `/usr/bin/chflags` is the valid path.

D97AH changes exactly two method-local `/bin/chflags` tokens to `/usr/bin/chflags` and otherwise preserves the D97AG/D97AF transaction.
Exact local D97AH source identities before the current natural-flow transition:
- helpers `6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c`;
- sys_patch `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`;
- metal `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`;
- stamp method `fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a`.

Authoritative D97AH major build/private release:
- private repo `StefanAlMare/Private-Work`;
- branch `oclp7-d97ah-github-build`;
- head `d04ddd28c784a0b30c6629feeface10804d5d591`;
- workflow/run/job `349436422 / 33769927671 / 100697248264`;
- app ZIP `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`;
- packaged executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Exact D97AH app is live at `/Applications/OpenCore-Patcher.app`; D97AG backup remains `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

## D97AH manual Root Patch and accelerated boot
D97AH manual Root Patch is FULL PASS. Real privileged transaction crossed the prior blocker and proved:

```text
PRE_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
OLD_UUID=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
NEW_UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
POST_SHA=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
D97AF_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AF_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AF_LC_UUID_BUILD_STAMP=PASS
```

AuxKC/APFS snapshot/unmount also completed. Accelerated boot around 23:15 remained `NEGATIVE_NO_USABLE_GUI`. Current recovery VESA `kern.boottime` is `2026-09-03 23:17:53 +0300`, sec `1788466673`; all evidence strictly before that timestamp belongs to the accelerated boot.

Structured JSON runtime audit proved 28/28 failing diagnostic PIDs had sender:
`/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`, UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Old D5CE count was zero. Classification: `D97AF_RUNTIME_PROVENANCE=PROVEN_28_OF_28_DIAGNOSTIC_COHORT`. Direct runtime text-byte capture remains not performed; exact D97AH MTLCompilerService exit status remains UNKNOWN/INCONCLUSIVE.

## D97AI / D97AJ interpretation
D97AJ fully resolved the one indirect switch in current A4F and proved zero remaining reachable unresolved indirects and no bypass to the five late xrefs in the instrumented CFG.

Critical methodology correction: D97AD exits `110..114` are project-invented terminal diagnostic markers, not donor/Sequoia behavior. At image offset `0x9D6BD`, natural P7 bytes are `8b8d10feffff83f941`; D97AD replaces them with terminal `6a6e5fe9bb38f6ff90`. Therefore D97AJ proves no hidden bypass around our artificial terminal, not that natural donor/P7 flow cannot continue.

Do not remove only exit110. Natural-flow requires complete D97AD removal.

## D97AK full-image origin closure — PASS
D97AK reverified exact current A4F and mapped the complete image:

```text
EXACT_FIVE_LITERAL_UNIQUENESS=PASS
ADDITIONAL_DIRECT_STRING_XREF_COUNT=0
TOTAL_INDIRECT_STRING_POINTER_XREF_COUNT=0
EXTERNAL_DIRECT_INTERIOR_ENTRY_COUNT=0
EXTERNAL_DIRECT_LATE_REGION_ENTRY_COUNT=0
EXTERNAL_RIP_VALIDATOR_REFERENCE_COUNT=0
EXTERNAL_RIP_LATE_REGION_REFERENCE_COUNT=0
RAW_ABSOLUTE_LATE_POINTER_TOTAL=0
D97AK_DIAGNOSTIC_ORIGIN=ONLY_KNOWN_UNREACHABLE_DIRECT_XREFS_ZERO_STATIC_EXTERNAL_LATE_ENTRY
```

All five strings have only their already-known xrefs inside `validSimulatorMetadata`; no alternate static origin or external late entry exists.

## D97AL P7 natural-flow synthetic design — FULL PASS
Current source preimages were reverified exact and active order is exactly:
`selector -> control -> P6 -> P7 -> D97AD -> D97AF`.

D97AL reverses A4F -> exact D97AD -> exact P7 entirely in memory. All six D97AD terminal windows and the shared stub revert to their exact P7 preimages. Reconstructed P7 SHA256 is exactly:
`6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

New frozen P7 natural-flow provenance UUID:
`0FC4C627-2A5D-491B-8101-00CAAA7116B7`.
A4F remains permanently reserved for the D97AD-instrumented 28/28 cohort.

P7 + new UUID differs from exact P7 by exactly 16 bytes at LC_UUID offset `0xAB0..0xABF` and has deterministic final SHA256:
`e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

Classification: `D97AL_P7_NATURAL_FLOW_SYNTHETIC_DESIGN=STATIC_PROVEN`.

## CURRENT ACTION — local source integration only
No Root Patch and no reboot are authorized.

Perform one fail-closed ASUS2 local source transition:
1. remove exactly one active D97AD call from `sys_patch.py` while retaining its helper definition dormant;
2. preserve selector/control/P6/P7;
3. retarget the privileged stamp transaction preimage from D97AD SHA to exact P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
4. retarget A4F to new UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`;
5. retarget expected post-SHA to `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`;
6. preserve D97AG xattr/fatal-boundary and D97AH `/usr/bin/chflags` semantics;
7. preserve `metal_3802.py` byte-identical;
8. build/AST/compile-audit candidates before mutation, make recoverable backups, CAS/atomic replace with rollback, audit exact post-state, then STOP.

No local major build. After assistant audit of source integration, sync exact source to private GitHub for a GitHub-only major build/package. Installed app/system target/Golden must remain unchanged.