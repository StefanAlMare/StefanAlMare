# OCLP7 CHECKPOINT — D97AJ A4F fully resolved CFG; no late-block bypass; diagnostic origin next

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ACCEL_NEGATIVE_D97AF_RUNTIME_PROVENANCE_28OF28_H4_NEGATIVE.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Root Patch/reboot remain manual-only and separately authorized.

D97AH application remains live. D97AH manual Root Patch remains FULL PASS. Current root-patched MTLCompiler 32023 is the exact D97AF A4F postimage:
- path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- bytes `1636896`;
- SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`;
- LC_UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`.

D97AH accelerated boot remains `NEGATIVE_NO_USABLE_GUI`. D97AF runtime diagnostic provenance remains PROVEN for 28/28 failing PIDs: every diagnostic sender path is `Versions/32023/MTLCompiler` and every sender UUID is A4F; old D5CE is zero for the complete cohort. Exact MTLCompilerService exit status remains UNKNOWN/INCONCLUSIVE from the JSON collector.

## D97AI result retained
D97AI verified current VESA boot `kern.boottime sec=1788466673`, exact A4F SHA/UUID and exact D97AD exit110 bytes `6a6e5fe9bb38f6ff90` at image offset `0x9D6BD`. It disassembled `MTLSimCompiler::validSimulatorMetadata(llvm::Module*)` at `0x7FFB162C7132..0x7FFB162C7830` and confirmed the five late diagnostic xrefs at image offsets:
- `0x9D6C8` buffers;
- `0x9D6EE` samplers;
- `0x9D712` textures;
- `0x9D73A` constant-buffer bindings;
- `0x9D75D` interpolated inputs.

Its generic CFG parser left exactly one reachable unresolved indirect branch: `jmpq *%rax` at image offset `0x9D3AB` / REL+`0x279`. Therefore D97AI correctly classified bypass reachability as INCONCLUSIVE rather than NEGATIVE.

## Historical resolution of the one indirect branch
D97AB/D97AC had already identified that exact REL+`0x279` instruction as a seven-entry compiler-generated switch. D97AB resolved its target RELs as:

`0x27B,0x281,0x36F,0x2B2,0x2CE,0x36F,0x2FF`

D97AC then proved the historical CFG had zero reachable unresolved/outside edges after this switch resolution.

Because A4F differs from D97AD only by LC_UUID and D97AD differs from the earlier CFG substrate only at known classifier terminal windows, D97AJ was designed to revalidate—not merely assume—the same switch identity and targets on the exact current A4F image.

## D97AJ exact A4F switch/CFG audit — PASS
D97AJ wrapper identity/parse passed, current VESA boot identity remained exact, and A4F file SHA/UUID/exit110 bytes passed again.

Current A4F switch identity:

```text
SWITCH_IMAGE_OFFSET=0x9D3AB
SWITCH_REL=0x279
SWITCH_TEXT=jmpq *%rax
D97AB_KNOWN_SWITCH_INSTRUCTION_ON_A4F=PASS
D97AB_PROVEN_SWITCH_TARGET_COUNT_RAW=7
D97AB_PROVEN_SWITCH_TARGET_COUNT_UNIQUE=6
```

All seven historical switch entries resolve to exact instruction boundaries on current A4F:

```text
REL 0x27B -> image offset 0x9D3AD
REL 0x281 -> image offset 0x9D3B3
REL 0x36F -> image offset 0x9D4A1
REL 0x2B2 -> image offset 0x9D3E4
REL 0x2CE -> image offset 0x9D400
REL 0x36F -> image offset 0x9D4A1
REL 0x2FF -> image offset 0x9D431
D97AB_SEVEN_ENTRY_SWITCH_RESOLUTION_APPLIES_TO_CURRENT_A4F=PASS
```

The local switch construction itself is visible and structurally consistent on A4F:
- mask/normalize index;
- `cmpl $0x6, %eax`;
- out-of-range branch to `0x9D4A1`;
- RIP-relative table base;
- signed 32-bit table load;
- add table base;
- `jmpq *%rax`.

## Fully resolved A4F CFG — decisive
After replacing only this known switch edge set, D97AJ produced:

```text
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=317
CFG_REACHABLE_WITH_EXIT110_BLOCKED_AND_SWITCH=314
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
```

Every one of the five late diagnostic xrefs is unreachable from the normal function entry, and remains unreachable with the exit110 region blocked:

```text
0x9D6C8: REACHABLE_NORMAL=NO; REACHABLE_WITH_EXIT110_BLOCKED=NO
0x9D6EE: REACHABLE_NORMAL=NO; REACHABLE_WITH_EXIT110_BLOCKED=NO
0x9D712: REACHABLE_NORMAL=NO; REACHABLE_WITH_EXIT110_BLOCKED=NO
0x9D73A: REACHABLE_NORMAL=NO; REACHABLE_WITH_EXIT110_BLOCKED=NO
0x9D75D: REACHABLE_NORMAL=NO; REACHABLE_WITH_EXIT110_BLOCKED=NO
```

Authoritative classification:

`D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_FULLY_RESOLVED_REACHABLE_CFG`

`D97AJ_A4F_KNOWN_SWITCH_RESOLVED_CFG_AUDIT=PASS`

This supersedes only the D97AI bypass INCONCLUSIVE state. It does not alter D97AF runtime provenance or claim direct runtime text-byte capture.

## Strategic consequence
The current contradiction is now narrower and stronger:
1. runtime structured logging proves 28/28 failing diagnostics are emitted by MTLCompiler 32023 carrying the project A4F UUID stamp;
2. current filesystem A4F is exact SHA `a0e78b...` and contains the exact D97AD exit110 terminal;
3. a fully resolved CFG from the normal `validSimulatorMetadata` entry has zero unresolved reachable indirects and cannot reach any of the five mapped late diagnostic xrefs at all.

Therefore an internal bypass around exit110 is NEGATIVE. Do not patch the late validator or weaken exit110 to force traversal.

The remaining explanations to discriminate before any new runtime instrumentation are now static-origin/execution-semantic questions:
- the same diagnostic strings may have additional xrefs elsewhere in A4F, so the runtime message may not originate from the five `validSimulatorMetadata` xrefs previously mapped;
- there may be a direct or address-taken external entry into an internal late block rather than normal function-entry traversal;
- if exhaustive A4F xref/inbound-entry mapping rejects both, the contradiction becomes an executed-text/runtime-mapping semantic problem rather than a CFG bypass problem.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
No Root Patch and no reboot are authorized.

Run one bounded read-only ASUS2 full-image A4F diagnostic-origin audit. It must:
1. verify exact current A4F SHA/UUID and unchanged VESA boot identity;
2. locate the five exact simulator-limit string literals and enumerate every code xref to each across the entire A4F executable, not only `validSimulatorMetadata`;
3. classify the symbol/function owner of every xref;
4. enumerate every direct branch/call from outside `validSimulatorMetadata` into its interior, especially the late region `0x9D6C5..0x9D77F`;
5. report any address-taken/jump-table evidence that targets these internal late addresses where statically recoverable;
6. make no source/system/Golden/runtime mutation, launch no MTLCompilerService, and STOP with complete raw output.

If the five strings have only the already-known unreachable xrefs and there are zero external entries into the late blocks, persist that contradiction before considering any runtime observation method. If another xref or external entry exists, map its earliest upstream payload/state handoff for H1/H2/H3 analysis.
