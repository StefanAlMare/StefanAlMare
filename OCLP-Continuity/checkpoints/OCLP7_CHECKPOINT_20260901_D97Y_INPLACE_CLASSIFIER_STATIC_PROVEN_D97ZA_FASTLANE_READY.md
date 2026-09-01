# OCLP7 CHECKPOINT — 2026-09-01 — D97Y in-place classifier STATIC PROVEN / D97ZA FASTLANE ready

## Retained runtime question
The exact fatal-request `llvmVersion` remains UNKNOWN.

Retained selector semantics:
- low32 `3802` selects MTLCompiler 3802;
- low32 `32023` selects MTLCompiler 32023;
- any other low32 value selects no valid compiler path.

The accepted universal terminal classifier is:
- exit `123` for EAX `3802` (`0xEDA`);
- exit `124` for EAX `32023` (`0x7D17`);
- exit `125` for every other EAX value.

The transport is the Darwin x86_64 exit syscall `0x2000001`, observed through launchd. It does not depend on `.ips` register reports.

## D97X retained STATIC NEGATIVE
D97X found no executable zero-run of at least 48 bytes and no statically safe cave in `MTLCompilerService` `__TEXT,__text`. Cave placement remains unauthorized. Cave requirements are not weakened.

## D97Y artifact
`OCLP7_D97Y_READONLY_INPLACE_TERMINAL_CLASSIFIER_BLOCK_SAFETY_MAP.command`
- commit `4e3d2333d1d28350295ce2710e82431edba1ed3f`;
- blob `549c894920b9fb1d688272f6b50034b3763bcf55`.

D97Y was strict read-only and returned PASS.

## D97Y identity and reconstruction
- visible D97V service SHA exact: `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`;
- visible site12 exact: `0f0b9090909090b9000000c0`;
- selector-only reconstruction SHA exact: `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- selector-only site12 exact: `4c89b558ffffffb9000000c0`.

## Complete in-place block proof
The minimum complete-instruction interval beginning at the first instruction after `xpc_dictionary_get_uint64` is:
- file `0x25C3..0x25EB`;
- VM `0x1000025C3..0x1000025EB`;
- length `40` bytes;
- six complete original instructions.

Original six-instruction sequence:
1. `movq %r14,-0xA8(%rbp)`;
2. `movl $0xC0000000,%ecx`;
3. `movq %rcx,-0xA0(%rbp)`;
4. `leaq ____ZL3ctxi_block_invoke(%rip),%rcx`;
5. `movq %rcx,-0x98(%rbp)`;
6. `leaq ___block_descriptor_36_e5_v8?0l(%rip),%rcx`.

First untouched instruction:
- VM `0x1000025EB`: `movq %rcx,-0x90(%rbp)`.

Exact block preimage:
`4c89b558ffffffb9000000c048898d60ffffff488d0df10d000048898d68ffffff488d0d951b0000`

Preimage SHA256:
`0808135bb09b797b61ab8da494604db69a4e25a635ccd779025c7483a97af93f`

Safety gates:
- original control-transfer instructions inside block: none;
- direct target at block start: 0;
- direct target inside block: 0;
- RIP-relative target into block: 0;
- symbol inside block: 0;
- owner symbol remains `____ZL29MTLCompilerServiceHandleEvent..._block_invoke`;
- next symbol is at `0x100002868`, well after the block;
- inbound-reference safety PASS.

## Exact classifier proof
Classifier code length is 36 bytes:
`3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b`

The 40-byte postimage appends four NOPs:
`3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b90909090`

All four rel8 destinations were exact. Semantic tests passed for `3802`, `32023`, `0`, `3902`, and `0xFFFFFFFF`. The exit syscall encoding and terminal fallback `UD2` were exact.

Synthetic final service:
- SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- 32023 selector retained;
- 3802 selector retained;
- next original instruction bytes retained;
- synthetic disassembly exactly matched classifier + four NOPs + untouched instruction at `0x25EB`.

Authoritative classifications:
- `D97Y_INPLACE_COMPLETE_INSTRUCTION_BLOCK=STATIC_PROVEN`;
- `D97Y_INBOUND_REFERENCE_SAFETY=STATIC_PROVEN`;
- `D97Y_THREE_WAY_EXIT_CLASSIFIER=STATIC_PROVEN`;
- D97Y authorizes FASTLANE design only; runtime remains untested.

## D97Z core / D97ZA wrapper
The D97Z core is stored as four identity-pinned compressed payload parts at commit `09543f3f5e7ad816d15650580ed17165eb698b0f`:
- part1 blob `ad2bac11c3875ae725855031cae5c00de443935d`;
- part2 blob `02325e749088750bef7ce02cfb9cfa09f8d32f29`;
- part3 blob `74517f92d02917fd839f3034f73e51875377ac67`;
- part4 blob `4177b268cad02d4c740fe8b1ac53c08e451ad9a6`.

Decompressed core SHA256:
`419516697a9d69b888ec8fb03c10d6892c809c2e1a7653f190739f87350c3716`.

Wrapper artifact:
`OCLP7_D97ZA_DIRECT_PINNED_INPLACE_EXIT_CLASSIFIER_FASTLANE_WRAPPER.command`
- commit `32ebc5a679b92f4ea6a9dc7a234e6281d7f61177`;
- blob `c0816d84048364eb793dcab0f55c3a4e8bcc1a70`.

D97ZA verifies every payload blob, reconstructs the core, requires the exact core SHA256, zsh-parses it, compiles all six embedded Python blocks, audits required identities/contracts and forbids automatic Root Patch/reboot, then executes the full D97Z FASTLANE.

D97Z performs:
1. exact branch/HEAD/live-D97V-app/current-D97V-service/source prechecks;
2. D97V -> selector-only -> D97Z offline proof, including complete-block/inbound-reference/classifier/synthetic-disassembly gates;
3. source backup;
4. replacement of the D97V helper and call by D97Z in the same positions — not stacking;
5. retained selector/control/P6/P7/D97 helper identity, active call-order, compile, exact delta and unrelated-file audits;
6. full app build;
7. packaged-app call/order/constants/three-privileged-write audit, with downstream D97 retained;
8. SHA backup/deploy and fresh-process provenance;
9. open OCLP;
10. STOP.

D97Z never auto Root Patches or reboots.

## CURRENT SINGLE NEXT ACTION
Run D97ZA only and return both complete reports:
- `OCLP7_D97ZA_DIRECT_PINNED_INPLACE_EXIT_CLASSIFIER_FASTLANE_WRAPPER_REPORT.txt`;
- `OCLP7_FASTLANE_D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER_REPORT.txt`.

A printed PASS is insufficient until assistant audit. Do not Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
