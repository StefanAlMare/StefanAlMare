# OCLP7 CHECKPOINT — 2026-09-02 — D97AER static late-message map / visible-D97AD runtime contradiction

## Input retained from D97AEQ
Selected accelerated boot remains `2026-09-02 00:10`; VESA recovery `00:12` excluded. D97AEQ proved 28/28 observed MTLCompilerService PIDs terminated by normal `exit(1)`, zero signals, zero missing exit records, and zero classifier exits 110–114. Visible selector-only service SHA and visible D97AD MTLCompiler SHA/postimages were exact.

## D97AER visible identities — PASS
D97AER reverified:
- MTLCompilerService selector-only SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- visible MTLCompiler 32023 D97AD SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- visible MTLCompiler 3802 exists, SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`.

## Static 32023 simulator diagnostic map — decisive
Visible D97AD 32023 contains six simulator-limit strings. The mapper resolved five late xrefs, all owned by `MTLSimCompiler::validSimulatorMetadata(llvm::Module*)`, function `0x7FFB162C7132..0x7FFB162C7830`:
- buffers message at REL `0x596`;
- samplers message at REL `0x5BC`;
- textures message at REL `0x5E0`;
- constant-buffer message at REL `0x608`;
- interpolated-input message at REL `0x62B`.

All five are strictly after D97AD candidate terminal REL `0x58B`. The disassembly immediately before the first late message visibly contains the exact D97AD terminal sequence at REL `0x58B`: push exit110 / pop RDI / unconditional JMP to the shared Darwin exit stub, followed by the late predicate block.

Therefore, if the runtime diagnostic came from execution of this exact patched 32023 image along the mapped CFG, the process should have terminated with exit 110 before emitting any of the five late messages. D97AEQ instead observed zero 110 and natural exit(1) for every PID.

The sixth string is the nested-argument-buffer diagnostic known from the retained static map as an earlier outcome family; D97AD separately instruments the nested outcome with exit 113. The D97AER xref finder did not resolve this 32023 xref, which is a mapper limitation, not evidence that the string is absent.

## Static 3802 comparison
Visible 3802 contains the same six simulator strings. Its `validSimulatorMetadata` owns all six resolved xrefs, including nested-argument-buffer REL `0x4CB` and the late resource-limit family at REL `0x619`, `0x645`, `0x66D`, `0x69C`, `0x6C3`.

Thus the compact runtime message text alone cannot discriminate 32023 from 3802 because both generations contain the same diagnostic family.

## Historical compact-log path provenance
D97AER found no explicit `/Versions/32023/MTLCompiler` or `/Versions/3802/MTLCompiler` path in the selected compact unified-log window. Historical runtime generation/path provenance therefore remains UNKNOWN from that channel.

## Runtime diagnostic correlation
D97AER proved the simulator diagnostic appears for all 28 spawned PIDs. All 28 show the common `STRING sz:9` decode mismatch; PIDs 347, 380, 433 additionally show size-24 variants.

D97AER printed `RUNTIME_EXIT1_PID_COUNT=0` and `UNIVERSAL_PRE_EXIT_DIAGNOSTIC_CORRELATION=INCOMPLETE` because its local regex expected `MTLCompilerService[PID]` immediately before the launchd exit text and did not match the actual `com.apple.MTLCompilerService.UUID [PID]:] exited due to exit(1)` shape. This is a tooling false negative. D97AEQ remains authoritative for the 28/28 natural exit(1) fact.

## Authoritative classification
- `D97AER_STATIC_32023_LATE_DIAGNOSTIC_XREFS=STATIC_PROVEN_AFTER_REL_0x58B`;
- `D97AER_RUNTIME_SIMULATOR_DIAGNOSTIC=REACHED_FOR_ALL_28_OBSERVED_PIDS`;
- `D97AER_COMPACT_LOG_GENERATION_PROVENANCE=UNKNOWN`;
- `D97AER_EXIT1_LOCAL_CORRELATOR=TOOLING_FALSE_NEGATIVE`; retained D97AEQ 28/28 exit(1) unchanged;
- `EXACT_VISIBLE_D97AD_32023_EXECUTION_PROVENANCE=UNRESOLVED`;
- `VISIBLE_D97AD_BYTES_VS_RUNTIME_LATE_MESSAGE=CONTRADICTION_REQUIRING_EXECUTED_IMAGE_PROVENANCE`.

Do not infer 3802 or stale/shared-cache execution yet. Those remain hypotheses until direct provenance evidence.

## CURRENT SINGLE NEXT ACTION
Run a new read-only JSON unified-log provenance mapper on the same historical accelerated window. It must inspect raw JSON records for the simulator diagnostic and extract every available `senderImagePath`, `senderImageUUID`, `processImagePath`, `processImageUUID`, source/format metadata and PID. Compare sender UUID/path against the visible 32023 and 3802 Mach-O UUIDs. Also repair the launchd exit(1) parser only as corroboration; D97AEQ remains authoritative for exit counts.

No source/system/Golden mutation, service launch, Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
