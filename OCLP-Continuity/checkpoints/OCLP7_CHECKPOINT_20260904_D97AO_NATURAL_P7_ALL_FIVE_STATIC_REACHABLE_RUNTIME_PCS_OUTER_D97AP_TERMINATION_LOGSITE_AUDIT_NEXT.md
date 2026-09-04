# OCLP7 CHECKPOINT — 2026-09-04 — D97AO natural P7 all five late xrefs STATIC-PROVEN reachable; runtime PCs mapped outer; D97AP next

## Authority / carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/static/log work stays ASUS2; GitHub only for major build/package. Root Patch/reboot manual-only.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AN_NATURAL_UUID_PROVEN_79_OF_79_LATE_PARSER_INCONCLUSIVE_D97AO_STATIC_PC_CFG_NEXT.md`.

D97AM accelerated chronology remains historically fixed: `02:29` accelerated, `02:32` VESA recovery, authoritative runtime window `2026-09-04 02:29:00..02:31:59` local. Later reboot at `10:08:19` does not alter that historical evidence window.

## D97AO V1 tooling false failure only
D97AO V1 wrapper commit/blob `2401be6af44180ae35040ad752ea3b361238d0b7 / 969701ab1fb00bea91d44196b463e3a400efd258` failed closed before target inspection because it unnecessarily required current `kern.boottime` to remain the historical 02:32 VESA boot. Current boot had advanced to sec `1788505699` at 10:08:19. No target/CFG conclusion came from V1.

D97AO V2 wrapper commit/blob `d5e83b1bbc2cb40bdd0f33b9e36cb8158705543a / e10803b6c394baf6cd5736dece2839dd3d319f77` patched only the current-boot equality gate in memory and otherwise executed the exact V1 auditor. Patched inner identity observed: blob `11c01414b5749f722a5d3bf70efbeed9d224c0e5`, SHA256 `2317359ebfbf7d329015bea231ee7dd31f1a7e7fd080bf262f83480ccefe8261`, 17379 bytes.

## Exact natural target identity retained after later reboot
D97AO V2 proved current root-patched target still exact:

```text
TARGET_BYTES=1636896
TARGET_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
MACHO_LC_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
D97AO_TARGET_SHA_IDENTITY=PASS
D97AO_TARGET_LC_UUID_IDENTITY=PASS
```

Former D97AD exit110 site is restored exactly to natural P7 bytes:

```text
IMAGE_OFFSET=0x9D6BD
BYTES=8b8d10feffff83f941
D97AO_EXACT_NATURAL_SITE_BYTES=PASS
```

## D97AN runtime sender-PC mapping — STATIC-MAPPED
The three exact runtime PCs from the D97AN 79-record natural-UUID cohort map to outer request/backend functions, not validator-local late xrefs:

1. `0x9FFEE` — 7 records — `MTLCompilerObject::buildSpecializedFunctionRequest(...)`, exact instruction `callq _mach_absolute_time`, immediately after an `__os_log_impl` site whose static literal is `Build request: %s`.
2. `0xA0521` — 7 records — same `buildSpecializedFunctionRequest(...)`, exact instruction `testb $0x2, 0x5(%r14)`, immediately after an `__os_log_impl` site whose static literal is `Compilation (%s) time %f ms`.
3. `0xA5F81` — 65 records — `MTLCompilerObject::backendCompileExecutableRequest(BinaryRequestData&)`, exact instruction `callq _mach_absolute_time`, immediately after an `__os_log_impl` site whose static literal is `Build request: %s`.

`D97AO_RUNTIME_PC_STATIC_MAPPING=PASS`.

Consequently D97AN's privacy/truncation-decoded event text (`...supported in the simulator...were used`) must not be treated as a direct mapping of those outer sender PCs to the five validator-local xrefs. Runtime five-late reachability remains INCONCLUSIVE until a reliable channel demonstrates it.

## Simulator string/xref inventory revalidated
D97AO independently enumerated the five known late literals/xrefs inside `MTLSimCompiler::validSimulatorMetadata` at:
- buffers `0x9D6C8`;
- samplers `0x9D6EE`;
- textures `0x9D712`;
- constant buffers `0x9D73A`;
- interpolated inputs `0x9D75D`.

This is consistent with D97AK's full-image uniqueness/origin closure.

## Natural P7 resolved CFG — decisive STATIC-PROVEN result
Exact natural `validSimulatorMetadata` range remains `0x9D132..0x9D830`. D97AB known switch at `0x9D3AB` was revalidated as `jmpq *%rax`; all seven proven switch targets are exact instructions.

Natural-P7 CFG result:

```text
FUNCTION_DISASSEMBLED_INSTRUCTION_COUNT=408
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=397
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
```

Every late xref is reachable from normal function entry in the fully resolved natural P7 CFG:

```text
0x9D6C8 STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D6EE STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D712 STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D73A STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
0x9D75D STATIC_REACHABLE_FROM_NORMAL_ENTRY=YES
D97AO_NATURAL_P7_LATE_CFG=STATIC_PROVEN_ALL_FIVE_REACHABLE_FROM_NORMAL_ENTRY
D97AO_RUNTIME_PC_AND_NATURAL_RESOLVED_CFG_AUDIT=PASS
```

The static paths explicitly traverse the restored natural site at `0x9D6BD`. This resolves the earlier A4F/D97AJ contradiction: the project-invented D97AD terminal at that site cut off natural continuation; once removed, all five late blocks are statically reachable.

Important evidence boundary: `STATIC_PROVEN_ALL_FIVE_REACHABLE` is not runtime `REACHED`. Runtime branch selection / exact late predicate / semantic counter values remain unresolved.

Mutation ledger: source NO; installed app NO; system target NO; Golden NO; service launch AUTO-NO; Root Patch AUTO-NO; snapshot NO; reboot AUTO-NO.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — D97AP read-only termination + outer-logsite lifecycle audit
Before any new diagnostic build/reboot, exhaust existing historical evidence from the fixed 02:29 accelerated cohort.

D97AP should remain read-only and:
1. pin exact current target `e7739c... / 0FC4...` but not require a particular current boot;
2. re-query the fixed historical 02:29..02:31:59 logs for MTLCompilerService plus launchd/runningboard/ReportCrash/kernel/diagnostic processes mentioning the service/PIDs, looking for exact crash/signal/exit/corpse/termination evidence;
3. inspect available DiagnosticReports for MTLCompilerService events in that historical window without mutating anything;
4. statically enumerate `__os_log_impl` sites and format literals in `buildSpecializedFunctionRequest` and `backendCompileExecutableRequest`, then reconcile D97AN sender PCs with those exact log-site return PCs;
5. correlate per-PID historical sequences, especially the 7 specialized start / 7 specialized completion-like timing-site records and 65 backend-start records, without treating absence of a log as a hard negative unless the static logging contract justifies it;
6. keep exact process termination status UNKNOWN unless directly recovered.

Only after D97AP should a new runtime instrumentation design be considered. Any future reboot must capture semantic payload/branch state, not merely another coarse control-flow marker.

STOP after D97AP. No Root Patch/reboot/source/app/system/Golden/snapshot mutation.