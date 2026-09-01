# OCLP7 CHECKPOINT — 2026-09-01 — D97ZA/D97Z FASTLANE FULL PASS / manual Root Patch authorized

## Retained runtime question
The fatal-request `llvmVersion` remains runtime UNKNOWN. The exact universal terminal classifier is retained:
- exit `123` when EAX is exactly `3802` (`0xEDA`);
- exit `124` when EAX is exactly `32023` (`0x7D17`);
- exit `125` for every other EAX value.

Transport: Darwin x86_64 exit syscall `0x2000001`, observable through launchd. Universal/no-PID and terminal/no-pass-through.

## D97Y static authorization retained
D97Y proved the complete-instruction in-place interval file `0x25C3..0x25EB`, length 40, with no inbound direct target, RIP-relative xref, symbol, function boundary or internal control transfer. Exact postimage:
`3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b90909090`.
Synthetic final service SHA:
`2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.

## D97ZA wrapper identity and static audit — FULL PASS
Wrapper:
`OCLP7_D97ZA_DIRECT_PINNED_INPLACE_EXIT_CLASSIFIER_FASTLANE_WRAPPER.command`
- commit `32ebc5a679b92f4ea6a9dc7a234e6281d7f61177`;
- blob `c0816d84048364eb793dcab0f55c3a4e8bcc1a70`.

Compressed core payload commit:
`09543f3f5e7ad816d15650580ed17165eb698b0f`.
Payload identities all passed:
- part1 `ad2bac11c3875ae725855031cae5c00de443935d`;
- part2 `02325e749088750bef7ce02cfb9cfa09f8d32f29`;
- part3 `74517f92d02917fd839f3034f73e51875377ac67`;
- part4 `4177b268cad02d4c740fe8b1ac53c08e451ad9a6`.

Reconstructed core SHA256 exact:
`419516697a9d69b888ec8fb03c10d6892c809c2e1a7653f190739f87350c3716`.

Wrapper gates:
- all payload blobs exact;
- core identity PASS;
- zsh parse PASS;
- embedded Python block sequence exactly `PYPRE, PYOFF, PYFIX, PYCOMPILE, PYAUD, PYPKG`;
- all six Python blocks compile PASS;
- required anchors missing `[]`;
- forbidden automatic Root Patch/reboot lines `[]`;
- static FASTLANE contract audit PASS.

## D97Z core precheck — FULL PASS
Exact live state:
- live D97V app executable SHA `9b2b981afb2cc4a56e3b9b8a2e97c454a3bcce9522a37d0cd17629bd5ae76e45`;
- visible D97V service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`;
- visible D97V block exact.

Source cardinality before integration:
- selector helper 1;
- D97V helper 1;
- D97Z helper 0;
- control/P6/P7/D97 helpers each 1.

Retained helper segment identities:
- selector `adb3981f5ac58820d4715436f56936ce2cae1bcf7c162107d215ff6150ee61a4`;
- control `254104fa863b6d0b8e9c27a6db907b423c3153958d3e51fc4cbd912c7ebe6ac9`;
- P6 `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a`;
- P7 `a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b`;
- D97 `7147d3be9c63968859fd89958aa74a15db6adad866c5f95059f6a61b39b6ae9c`.

Pre-integration call order:
selector -> D97V -> control -> P6 -> P7 -> D97.
Only D97 was the active late MTL diagnostic. Source no-write compile, tracked manifest and source contract all PASS.

## Offline exact D97Z proof — FULL PASS
The exact current D97V service was reconstructed to selector-only SHA:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

The mapper re-proved:
- exact code section and block `0x25C3..0x25EB`;
- six complete original instructions;
- no original control transfer;
- no direct target at block start/interior;
- no RIP-relative target or symbol inside;
- owner and next symbol boundaries unchanged;
- all classifier rel8 destinations exact;
- semantic tests exact for 3802, 32023, 0, 3902 and `0xFFFFFFFF`;
- synthetic disassembly exact;
- final SHA exact `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.

`OFFLINE_D97Z_PROOF=PASS`.

## Source integration and audit — FULL PASS
D97V was replaced by D97Z in the same helper/call positions — not stacked:
- `D97V_HELPER_REPLACED_BY_D97Z=PASS`;
- `D97V_CALL_REPLACED_BY_D97Z=PASS`;
- receiver preserved as `sys_patch_helpers.SysPatchHelpers(self.constants)`.

Post-integration active call order:
selector -> D97Z -> control -> P6 -> P7 -> D97.

Audit proved:
- selector/control/P6/P7/D97 helper segment SHA values unchanged;
- D97Z exact assignments: site `0x25C3`, end `0x25EB`, selector offsets `0x3496/0x3478`, exits `123/124/125`;
- D97Z helper immediately after selector;
- active late MTL diagnostic remains D97;
- active service diagnostic is D97Z;
- no-write compile PASS;
- exactly the two allowed tracked files changed and no others;
- helper delta is precisely D97V -> D97Z;
- sys_patch delta is precisely D97V call -> D97Z call;
- helper and sys_patch whitespace gates PASS;
- `SOURCE_AUDIT=PASS`.

## Build, packaged audit and deployment — FULL PASS
Build completed successfully in 78.81 seconds.

Packaged app:
- selector, D97Z, control, P6, P7 and D97 calls each appear exactly once;
- D97V packaged call absent;
- packaged order exact selector -> D97Z -> control -> P6 -> P7 -> D97;
- D97Z privileged write count exactly 3;
- downstream D97 retained;
- `PACKAGED_AUDIT=PASS`.

Application executable:
- dist SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`;
- live SHA identical;
- deploy SHA match PASS.

Backup:
`/Applications/OpenCore-Patcher.app.D97V-before-D97Z-20260901-164617`
with exact prior D97V executable SHA `9b2b981afb2cc4a56e3b9b8a2e97c454a3bcce9522a37d0cd17629bd5ae76e45`.

Fresh-process provenance:
- PID `1380`;
- exact command `/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher`;
- open live app PASS.

## Final FASTLANE classification
- `FASTLANE_D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER=PASS`;
- core RC 0;
- wrapper PASS;
- `D97V_REPLACED_NOT_STACKED=PASS`;
- downstream D97 retained;
- D82 not executed;
- Patch8 not integrated;
- Root Patch AUTO-NO;
- reboot AUTO-NO.

Classification: **D97ZA/D97Z FASTLANE FULL PASS**. Runtime remains UNTESTED.

## CURRENT SINGLE NEXT ACTION
Manual Root Patch in the freshly deployed/opened OCLP application is AUTHORIZED.

Return the complete Root Patch output for assistant audit. Do not reboot or perform the accelerated classifier boot until that output is fully audited and explicit authorization is given.

Expected Root Patch evidence:
- selector 31001 -> 32023 PASS;
- `D97Z_SERVICE_PREIMAGE_SHA=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- `D97Z_LLVMVERSION_EXIT_CLASSIFIER_SERVICE_SHA=2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- `D97Z_COMMITTED_SERVICE_SHA=2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- `D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER=PASS`;
- block/exits `0x25C3..0x25EB`, `123/124/125`;
- retained true-five/P6/P7/D97 lineage;
- AuxKC build and APFS snapshot completion.

D82 remains reserve-only. Patch8 remains unauthorized.
