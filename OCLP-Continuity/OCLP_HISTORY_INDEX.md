# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_P7_NATURAL_FLOW_SOURCE_INTEGRATION_PASS_GITHUB_BUILD_NEXT.md`.
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

Exact D97AH app remains live; D97AG backup retained. D97AH manual Root Patch is FULL PASS; accelerated boot remained `NEGATIVE_NO_USABLE_GUI`. Current VESA recovery begins `2026-09-03 23:17:53 +0300`, sec `1788466673`. D97AF structured runtime provenance is PROVEN 28/28 for exact 32023/A4F diagnostic sender; old D5CE count zero.

## D97AI / D97AJ fully resolved A4F CFG and correction
D97AJ revalidated the known seven-entry switch and proved zero reachable unresolved indirects and no bypass to the five late xrefs in the instrumented A4F CFG. Interpretation correction: exits 110..114 are project-invented terminal diagnostics, not donor/Sequoia behavior. Natural P7 bytes at `0x9D6BD` are `8b8d10feffff83f941`; D97AD replaces them with terminal `6a6e5fe9bb38f6ff90`. Therefore natural-flow testing requires complete D97AD removal, not only exit110 removal.

## D97AK full-image diagnostic-origin audit — PASS
D97AK proved each of the five simulator-limit strings occurs exactly once and has exactly its known direct xref inside `validSimulatorMetadata`. No alternate origin/entry exists: additional direct xrefs 0, indirect pointer xrefs 0, external direct interior/late entries 0, external RIP references 0, raw absolute late pointers 0.

## D97AL P7 natural-flow design — FULL PASS
D97AL reverified local source and active order `selector -> control -> P6 -> P7 -> D97AD -> D97AF`, then in-memory reversed A4F -> exact D97AD -> exact P7. Exact P7 SHA256: `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.
New frozen natural-flow UUID: `0FC4C627-2A5D-491B-8101-00CAAA7116B7`. P7 + new UUID changes exactly 16 bytes at `0xAB0..0xABF` and has deterministic SHA256 `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`.

## D97AM local P7 natural-flow source integration — FULL PASS
D97AM integrator artifact commit/blob: `c7532f00b241d4e197b3408fd6d2e3010203541c` / `e758a5fb2b8c2fed2f7d2efd1678cbb8c477aa53`.
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

Installed app/system target/Golden were unchanged; no local major build, Root Patch or reboot occurred. A cosmetic error-message phrase still says `expected exact D97AD preimage`, but the enforced preimage SHA is P7; transaction semantics are unaffected.

## CURRENT ACTION
Sync exact D97AM source to private `StefanAlMare/Private-Work` and perform a dedicated GitHub Intel/x86_64 major build/package. Audit source identities, packaged call order, D97AD active-call absence, P7/new UUID/new expected SHA constants, dormant D97AD definition where packaged, D97AG/D97AH transaction semantics, and identity-pinned artifact/release delivery.

No local major build. STOP after assistant GitHub build/package audit. Do not deploy, Root Patch or reboot until separately authorized.