# OCLP7 CHECKPOINT — D97AI A4F CFG INCONCLUSIVE ONLY AT KNOWN SWITCH; D97AJ RESOLUTION NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ACCEL_NEGATIVE_D97AF_RUNTIME_PROVENANCE_28OF28_H4_NEGATIVE.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Root Patch/reboot remain manual-only and separately authorized.

D97AH application and Root Patch state remain unchanged. The accelerated D97AH boot remains `NEGATIVE_NO_USABLE_GUI`. D97AF runtime diagnostic sender provenance remains PROVEN 28/28 for exact 32023 path and stamped UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`; old D5CE is NEGATIVE for that complete diagnostic cohort. Exact service termination status for that boot remains UNKNOWN/INCONCLUSIVE.

## D97AI read-only A4F control-flow reconciliation
The returned D97AI wrapper identity and parse passed. The current VESA boot remained exactly `kern.boottime sec=1788466673`, so chronology was unchanged.

The installed target was verified exact:

```text
TARGET=/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler
TARGET_BYTES=1636896
TARGET_SHA256=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
MACHO_LC_UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
A4F_TARGET_SHA_IDENTITY=PASS
A4F_TARGET_LC_UUID_IDENTITY=PASS
```

The exact D97AD terminal bytes on the A4F postimage are present:

```text
EXIT110_IMAGE_OFFSET=0x9D6BD
EXIT110_BYTES_EXPECTED=6a6e5fe9bb38f6ff90
EXIT110_BYTES_ACTUAL=6a6e5fe9bb38f6ff90
D97AD_EXIT110_BYTES_ON_A4F=PASS
```

`MTLSimCompiler::validSimulatorMetadata` remained exact range `0x7FFB162C7132..0x7FFB162C7830`; D97AI decoded 428 instructions.

The five late simulator-limit literal-xref instructions were individually present at image offsets:
- `0x9D6C8` buffers;
- `0x9D6EE` samplers;
- `0x9D712` textures;
- `0x9D73A` constant-buffer binding;
- `0x9D75D` interpolated inputs.

The D97AD terminal is visibly an unconditional transfer out of the validator:

```text
0x9D6BD pushq $0x6e
0x9D6BF popq %rdi
0x9D6C0 jmp 0x7ffb1622af80
0x9D6C5 nop
0x9D6C6 jb 0x7ffb162c76e3
```

Thus ordinary fallthrough from the terminal into the late family does not exist.

## D97AI graph result
Generic direct-branch CFG result:

```text
CFG_REACHABLE_INSTRUCTION_COUNT=227
CFG_REACHABLE_WITH_EXIT110_REGION_BLOCKED=224
CFG_REACHABLE_UNRESOLVED_BRANCH_COUNT_WITH_EXIT110_BLOCKED=1
UNRESOLVED_REACHABLE_BRANCH|IMAGE_OFFSET=0x9D3AB|VM=0x7FFB162C73AB|jmpq *%rax
```

With only directly decoded edges, every late diagnostic site was unreachable both normally and with the exit110 region blocked. There were no resolved direct predecessors from an earlier region into those five late instructions; each printed predecessor was only its immediately preceding local conditional branch.

D97AI correctly classified:

`D97AI_STATIC_LATE_BLOCK_BYPASS_EXIT110=INCONCLUSIVE_UNRESOLVED_REACHABLE_BRANCH`

This is not evidence of a bypass. It means exactly one reachable indirect edge was not interpreted by the generic D97AI CFG parser.

## The unresolved edge is not historically unknown
The sole unresolved instruction is image offset `0x9D3AB`, which is validator REL+`0x279` from function start `0x9D132`.

D97AB/D97AC had already identified this exact instruction as the known indirect switch and resolved it to seven entries. Historical D97AB resolver contract:

```text
INDIRECT_JUMP_REL=0x279
expected switch entry RELs = 0x27B,0x281,0x36F,0x2B2,0x2CE,0x36F,0x2FF
```

D97AC then proved, with the indirect switch resolved:

```text
REACHABLE_OUTSIDE_OR_UNRESOLVED_EDGE_COUNT=0
BLOCKS_WITHOUT_PATH_TO_CLASSIFIED_FINITE_OUTCOME_COUNT=0
FINITE_PATH_OUTCOME_PARTITION_EXHAUSTIVE_STATIC=PASS
```

However, historical resolution must not simply be transferred to A4F without a current-image check. D97AF is UUID-only over exact D97AD and none of the six D97AD terminal patch windows are at REL+`0x279`, but the next action will still revalidate the switch on the exact current A4F image before promoting the D97AI result.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
No Root Patch, reboot, service launch or source/system mutation is authorized.

Run one bounded read-only D97AJ audit on ASUS2. It must:
1. verify unchanged VESA chronology and exact A4F SHA/UUID;
2. verify the sole indirect instruction at image offset `0x9D3AB` / REL+`0x279`;
3. apply and audit the already-proven D97AB seven-entry switch resolution against the current A4F disassembly;
4. recompute reachability with this indirect edge resolved;
5. report whether any of the five late diagnostic blocks is reachable without traversing the D97AD exit110 terminal;
6. require zero remaining reachable unresolved indirect edges before a hard NEGATIVE classification.

If the seven-entry resolution matches and all late blocks remain unreachable with exit110 terminalized, classify static bypass NEGATIVE and preserve the stamped-runtime/static-CFG contradiction for the next causal investigation. If any current switch identity/target differs, STOP INCONCLUSIVE rather than transferring historical assumptions.

No Root Patch or reboot. Return complete raw output and STOP.